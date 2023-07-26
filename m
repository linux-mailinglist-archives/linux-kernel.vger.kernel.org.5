Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C593762CE5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 09:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjGZHO5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 03:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjGZHON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 03:14:13 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 521542705;
        Wed, 26 Jul 2023 00:10:32 -0700 (PDT)
Received: from dggpeml100024.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4R9lPN2n6pzVk3X;
        Wed, 26 Jul 2023 15:08:56 +0800 (CST)
Received: from china (10.175.101.107) by dggpeml100024.china.huawei.com
 (7.185.36.115) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 26 Jul
 2023 15:10:29 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <broonie@kernel.org>, <rostedt@goodmis.org>, <mingo@redhat.com>,
        <frowand.list@gmail.com>
CC:     <zhangxiaoxu5@huawei.com>, <weiyongjun1@huawei.com>,
        <linux-kernel@vger.kernel.org>, <linux-spi@vger.kernel.org>
Subject: [PATCH v2 -next 3/3] spi: mockup: Add documentation
Date:   Wed, 26 Jul 2023 15:08:49 +0000
Message-ID: <20230726150849.28407-4-zhangxiaoxu5@huawei.com>
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

Add documentation for the SPI mockup controller driver.
This include the tutorial for how to mockup a api device.

Signed-off-by: Wei Yongjun <weiyongjun1@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 Documentation/spi/index.rst      |   1 +
 Documentation/spi/spi-mockup.rst | 174 +++++++++++++++++++++++++++++++
 2 files changed, 175 insertions(+)
 create mode 100644 Documentation/spi/spi-mockup.rst

diff --git a/Documentation/spi/index.rst b/Documentation/spi/index.rst
index 06c34ea11bcf..a8f4f5cd0f09 100644
--- a/Documentation/spi/index.rst
+++ b/Documentation/spi/index.rst
@@ -13,6 +13,7 @@ Serial Peripheral Interface (SPI)
    pxa2xx
    spi-lm70llp
    spi-sc18is602
+   spi-mockup
 
 .. only::  subproject and html
 
diff --git a/Documentation/spi/spi-mockup.rst b/Documentation/spi/spi-mockup.rst
new file mode 100644
index 000000000000..5e720de19991
--- /dev/null
+++ b/Documentation/spi/spi-mockup.rst
@@ -0,0 +1,174 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==========
+spi-mockup
+==========
+
+Description
+===========
+
+This module is a very simple fake SPI controller driver. It implements
+a BPF based interface to mockup SPI device.
+
+No hardware is needed nor associated with this module. It will respond
+spi message by BPF program attached to spi_transfer_writeable tracepoint
+by reading from or writing BPF maps.
+
+The typical use-case is like this:
+        1. load EBPF program as device's backend
+        2. create target chip device
+
+Example
+=======
+
+This example show how to mock a MTD device by using spi-mockup driver.
+
+Compile your copy of the kernel source. Make sure to configure the spi-mockup
+and the target chip driver as a module.
+
+Write a BPF program as device's backup.
+
+::
+
+  #define MCHP23K256_CMD_WRITE_STATUS   0x01
+  #define MCHP23K256_CMD_WRITE          0x02
+  #define MCHP23K256_CMD_READ           0x03
+
+  #define CHIP_REGS_SIZE		0x20000
+
+  #define MAX_CMD_SIZE		        4
+
+  struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, CHIP_REGS_SIZE);
+	__type(key, __u32);
+	__type(value, __u8);
+  } regs_mchp23k256 SEC(".maps");
+
+  static unsigned int chip_reg = 0;
+
+  static int spi_transfer_read(struct spi_msg_ctx *msg, unsigned int len)
+  {
+	int i, key;
+	u8 *reg;
+
+	for (i = 0; i < len && i < sizeof(msg->data); i++) {
+		key = i + chip_reg;
+
+		reg = bpf_map_lookup_elem(&regs_mchp23k256, &key);
+		if (!reg) {
+			bpf_printk("key %d not exists", key);
+			return -EINVAL;
+		}
+
+		msg->data[i] = *reg;
+	}
+
+	return 0;
+  }
+
+  static int spi_transfer_write(struct spi_msg_ctx *msg, unsigned int len)
+  {
+	u8 opcode = msg->data[0], value;
+	int i, key;
+
+	switch (opcode) {
+	case MCHP23K256_CMD_READ:
+	case MCHP23K256_CMD_WRITE:
+		if (len < 2)
+			return -EINVAL;
+
+		chip_reg = 0;
+		for (i = 0; i < MAX_CMD_SIZE && i < len - 1; i++)
+			chip_reg = (chip_reg << 8) + msg->data[1 + i];
+
+		return 0;
+	case MCHP23K256_CMD_WRITE_STATUS:
+		// ignore write status
+		return 0;
+	default:
+		break;
+	}
+
+	for (i = 0; i < len && i < sizeof(msg->data); i++) {
+		value = msg->data[i];
+		key = chip_reg + i;
+
+		if (bpf_map_update_elem(&regs_mchp23k256, &key, &value,
+					BPF_EXIST)) {
+			bpf_printk("key %d not exists", key);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+  }
+
+  SEC("raw_tp.w/spi_transfer_writeable")
+  int BPF_PROG(mtd_mchp23k256, struct spi_msg_ctx *msg, u8 chip, unsigned int len)
+  {
+	int ret = 0;
+
+	if (msg->tx_nbits)
+		ret = spi_transfer_write(msg, len);
+	else if (msg->rx_nbits)
+		ret = spi_transfer_read(msg, len);
+
+	return ret;
+  }
+
+  char LICENSE[] SEC("license") = "GPL";
+
+Use bpftool to load the BPF program.
+
+::
+
+  bpftool prog load mtd-mchp23k256.o /sys/fs/bpf/mtd_mchp23k256 autoattach
+
+
+This is accomplished by executing the following command:
+
+::
+
+  $ echo mchp23k256 0 > /sys/class/spi_master/spi0/new_device
+
+
+The name of the target driver and its chip select were used to instantiate
+the device.
+
+Now, the mchp23k256 MTD device named /dev/mtd0 has been created successfully.
+
+::
+
+  $ ls /sys/bus/spi/devices/spi0.0/mtd/
+  mtd0  mtd0ro
+
+  $ cat /sys/class/mtd/mtd0/name
+  spi0.0
+
+  $ hexdump /dev/mtd0
+  0000000 0000 0000 0000 0000 0000 0000 0000 0000
+  *
+  0008000
+
+  $echo aaaa > /dev/mtd0
+
+  $ hexdump /dev/mtd0
+  0000000 6161 6161 000a 0000 0000 0000 0000 0000
+  0000010 0000 0000 0000 0000 0000 0000 0000 0000
+  *
+  0008000
+
+  $ bpftool map update name regs_mchp23k256 key 0 0 0 0 value 0
+
+  $ hexdump /dev/mtd0
+  0000000 6100 6161 000a 0000 0000 0000 0000 0000
+  0000010 0000 0000 0000 0000 0000 0000 0000 0000
+  *
+  0008000
+
+Remove the mockup device by executing the following command:
+
+::
+
+  $echo 0 > /sys/class/spi_master/spi0/delete_device
-- 
2.34.1

