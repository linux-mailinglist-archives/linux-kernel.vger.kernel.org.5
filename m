Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74E1F775502
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjHIIUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 04:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229783AbjHIIUl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:20:41 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EC3610FE;
        Wed,  9 Aug 2023 01:20:41 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4RLNHS2JX9zVl7M;
        Wed,  9 Aug 2023 16:18:44 +0800 (CST)
Received: from localhost.localdomain (10.50.163.32) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 16:20:38 +0800
From:   Yicong Yang <yangyicong@huawei.com>
To:     <jonathan.cameron@huawei.com>, <suzuki.poulose@arm.com>,
        <mathieu.poirier@linaro.org>, <linux-kernel@vger.kernel.org>
CC:     <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: [PATCH 1/5] hwtracing: hisi_ptt: Disable interrupt after trace end
Date:   Wed, 9 Aug 2023 16:18:21 +0800
Message-ID: <20230809081825.11518-2-yangyicong@huawei.com>
X-Mailer: git-send-email 2.31.0
In-Reply-To: <20230809081825.11518-1-yangyicong@huawei.com>
References: <20230809081825.11518-1-yangyicong@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.50.163.32]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yicong Yang <yangyicong@hisilicon.com>

On trace end we disable the hardware but leave the interrupt
unmasked. Mask the interrupt to make the process reverse to
the start. No actual issue since hardware should send no
interrupt after disabled.

Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
---
 drivers/hwtracing/ptt/hisi_ptt.c | 4 ++++
 drivers/hwtracing/ptt/hisi_ptt.h | 1 +
 2 files changed, 5 insertions(+)

diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
index ba081b6d2435..5f0a8e653ae8 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.c
+++ b/drivers/hwtracing/ptt/hisi_ptt.c
@@ -183,6 +183,10 @@ static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
 static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
 {
 	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
+
+	/* Mask the interrupt on the end */
+	writel(HISI_PTT_TRACE_INT_MASK_ALL, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
+
 	hisi_ptt->trace_ctrl.started = false;
 }
 
diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
index e17f045d7e72..46030aa88081 100644
--- a/drivers/hwtracing/ptt/hisi_ptt.h
+++ b/drivers/hwtracing/ptt/hisi_ptt.h
@@ -47,6 +47,7 @@
 #define HISI_PTT_TRACE_INT_STAT		0x0890
 #define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
 #define HISI_PTT_TRACE_INT_MASK		0x0894
+#define   HISI_PTT_TRACE_INT_MASK_ALL	GENMASK(3, 0)
 #define HISI_PTT_TUNING_INT_STAT	0x0898
 #define   HISI_PTT_TUNING_INT_STAT_MASK	BIT(0)
 #define HISI_PTT_TRACE_WR_STS		0x08a0
-- 
2.24.0

