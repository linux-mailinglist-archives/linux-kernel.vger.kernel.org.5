Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFD2762CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:14:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjGZHOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:14:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232132AbjGZHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:14:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9CED2D42;
        Wed, 26 Jul 2023 00:10:32 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9lMG6mlqzCrW0;
        Wed, 26 Jul 2023 15:07:06 +0800 (CST)
Received: from china (10.175.101.107) by dggpeml100024.china.huawei.com
 (7.185.36.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 15:10:29 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <broonie@kernel.org>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <frowand.list@gmail.com>
CC:     <zhangxiaoxu5@huawei.com>, <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v2 -next 2/3] spi: mockup: Add writeable tracepoint for spi transfer
Date:   Wed, 26 Jul 2023 15:08:48 +0000
Message-ID: <20230726150849.28407-3-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230726150849.28407-1-zhangxiaoxu5@huawei.com>
References: <20230726150849.28407-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.107]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml100024.china.huawei.com (7.185.36.115)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Yongjun <weiyongjun1@huawei.com>

Add writeable tracepoint for transfer_one_message(), then bpf program
can be used to control read and write data from spi host, as mockup
chip's expectation.

For example:

  #include "vmlinux.h"
  #include <bpf/bpf_helpers.h>
  #include <bpf/bpf_tracing.h>

  SEC("raw_tp.w/spi_transfer_writeable")
  int BPF_PROG(spi_transfer_writeable_test, struct spi_msg_ctx *msg,
               u8 chip, unsigned int len)
  {
      if (msg->tx_nbits)
          msg->data[0] = 0x20;

      return 0;
  }

  char LICENSE[] SEC("license") = "GPL";

This will be useful for writing spi device mockup backend.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 drivers/spi/Kconfig               |  1 +
 drivers/spi/spi-mockup.c          | 52 +++++++++++++++++++++++++++++--
 include/linux/spi/spi-mockup.h    | 17 ++++++++++
 include/trace/events/spi_mockup.h | 31 ++++++++++++++++++
 4 files changed, 99 insertions(+), 2 deletions(-)
 create mode 100644 include/linux/spi/spi-mockup.h
 create mode 100644 include/trace/events/spi_mockup.h

diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index 1768e57f0088..608e224e52ef 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -1188,6 +1188,7 @@ config SPI_TLE62X0
 config SPI_MOCKUP
 	tristate "SPI controller Testing Driver"
 	depends on OF
+	select BPF_EVENTS
 	help
 	  This enables SPI controller testing driver, which provides a way to
 	  test SPI subsystem.
diff --git a/drivers/spi/spi-mockup.c b/drivers/spi/spi-mockup.c
index 4debfd1fb9fd..3835012e2ee8 100644
--- a/drivers/spi/spi-mockup.c
+++ b/drivers/spi/spi-mockup.c
@@ -14,6 +14,9 @@
 #include <linux/platform_device.h>
 #include <linux/spi/spi.h>
 
+#define CREATE_TRACE_POINTS
+#include <trace/events/spi_mockup.h>
+
 #define MOCKUP_CHIPSELECT_MAX		8
 
 struct mockup_spi {
@@ -150,13 +153,58 @@ static struct attribute *spi_mockup_attrs[] = {
 };
 ATTRIBUTE_GROUPS(spi_mockup);
 
+static int spi_mockup_transfer_writeable(struct spi_message *msg)
+{
+	struct spi_msg_ctx *ctx;
+	struct spi_transfer *t;
+	int ret = 0;
+
+	ctx = kmalloc(sizeof(*ctx), GFP_ATOMIC);
+	if (!ctx)
+		return -ENOMEM;
+
+	list_for_each_entry(t, &msg->transfers, transfer_list) {
+		if (t->len > SPI_BUFSIZ_MAX)
+			return -E2BIG;
+
+		memset(ctx, 0, sizeof(*ctx));
+		ctx->cs_off = t->cs_off;
+		ctx->cs_change = t->cs_change;
+		ctx->tx_nbits = t->tx_nbits;
+		ctx->rx_nbits = t->rx_nbits;
+
+		if (t->tx_nbits)
+			memcpy(ctx->data, t->tx_buf, t->len);
+
+		trace_spi_transfer_writeable(ctx, msg->spi->chip_select, t->len);
+
+		if (ctx->ret) {
+			ret = ctx->ret;
+			break;
+		}
+
+		if (t->rx_nbits)
+			memcpy(t->rx_buf, ctx->data, t->len);
+		msg->actual_length += t->len;
+	}
+
+	kfree(ctx);
+
+	return ret;
+}
+
 static int spi_mockup_transfer(struct spi_controller *ctrl,
 			       struct spi_message *msg)
 {
-	msg->status = 0;
+	int ret = 0;
+
+	if (trace_spi_transfer_writeable_enabled())
+		ret = spi_mockup_transfer_writeable(msg);
+
+	msg->status = ret;
 	spi_finalize_current_message(ctrl);
 
-	return 0;
+	return ret;
 }
 
 static int spi_mockup_probe(struct platform_device *pdev)
diff --git a/include/linux/spi/spi-mockup.h b/include/linux/spi/spi-mockup.h
new file mode 100644
index 000000000000..224894b416fb
--- /dev/null
+++ b/include/linux/spi/spi-mockup.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __LINUX_SPI_MOCKUP_H
+#define __LINUX_SPI_MOCKUP_H
+
+#define SPI_BUFSIZ_MAX		0x1000
+
+struct spi_msg_ctx {
+	int ret;
+	unsigned cs_off:1;
+	unsigned cs_change:1;
+	unsigned tx_nbits:3;
+	unsigned rx_nbits:3;
+	__u8 data[SPI_BUFSIZ_MAX];
+};
+
+#endif
diff --git a/include/trace/events/spi_mockup.h b/include/trace/events/spi_mockup.h
new file mode 100644
index 000000000000..46debf26a5e3
--- /dev/null
+++ b/include/trace/events/spi_mockup.h
@@ -0,0 +1,31 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * SPI mockup controller transfer writeable tracepoint
+ *
+ * Copyright(c) 2022 Huawei Technologies Co., Ltd.
+ */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM spi_mockup
+
+#if !defined(_TRACE_SPI_MOCKUP_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_SPI_MOCKUP_H
+
+#include <linux/tracepoint.h>
+#include <linux/spi/spi-mockup.h>
+
+#ifndef DECLARE_TRACE_WRITABLE
+#define DECLARE_TRACE_WRITABLE(call, proto, args, size) \
+	DECLARE_TRACE(call, PARAMS(proto), PARAMS(args))
+#endif
+
+DECLARE_TRACE_WRITABLE(spi_transfer_writeable,
+	TP_PROTO(struct spi_msg_ctx *msg, u8 chip_select, unsigned int len),
+	TP_ARGS(msg, chip_select, len),
+	sizeof(struct spi_msg_ctx)
+);
+
+#endif /* _TRACE_SPI_MOCKUP_H */
+
+/* This part must be outside protection */
+#include <trace/define_trace.h>
-- 
2.34.1

