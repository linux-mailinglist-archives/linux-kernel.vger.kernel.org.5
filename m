Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 334B87CD3A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:53:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344445AbjJRFxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjJRFxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:53:46 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53D6BA;
        Tue, 17 Oct 2023 22:53:42 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39I5rVVF11104695, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39I5rVVF11104695
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 18 Oct 2023 13:53:31 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 18 Oct 2023 13:53:31 +0800
Received: from RTEXH36505.realtek.com.tw (172.21.6.25) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Wed, 18 Oct 2023 13:53:30 +0800
Received: from localhost.localdomain (172.21.252.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server id
 15.1.2375.32 via Frontend Transport; Wed, 18 Oct 2023 13:53:30 +0800
From:   Jyan Chou <jyanchou@realtek.com>
To:     <adrian.hunter@intel.com>, <ulf.hansson@linaro.org>,
        <jh80.chung@samsung.com>
CC:     <linux-mmc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benchuanggli@gmail.com>, <jyanchou@realtek.com>
Subject: [PATCH V2][1/4] mmc: solve DMA boundary limitation of CQHCI driver
Date:   Wed, 18 Oct 2023 13:53:21 +0800
Message-ID: <20231018055326.18256-2-jyanchou@realtek.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231018055326.18256-1-jyanchou@realtek.com>
References: <20231018055326.18256-1-jyanchou@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-KSE-ServerInfo: RTEXDAG02.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Due to synopsys data book's description, it had a limitation
while using DMA that buffer size and start address must not
exceed 128 MB.

We add an option setup_tran_desc to make tran_desc setting flexible.

Signed-off-by: Jyan Chou <jyanchou@realtek.com>

---
v0 -> v1:
- Separate different patch supports into single patch.

v1 -> v2:
- Export cqhci_set_tran_desc for setting the descriptor's callback function.
---
---
 drivers/mmc/host/cqhci-core.c | 8 +++++++-
 drivers/mmc/host/cqhci.h      | 2 ++
 2 files changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/mmc/host/cqhci-core.c b/drivers/mmc/host/cqhci-core.c
index b3d7d6d8d654..5560329d2a7d 100644
--- a/drivers/mmc/host/cqhci-core.c
+++ b/drivers/mmc/host/cqhci-core.c
@@ -474,7 +474,7 @@ static int cqhci_dma_map(struct mmc_host *host, struct mmc_request *mrq)
 	return sg_count;
 }
 
-static void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
+void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
 				bool dma64)
 {
 	__le32 *attr = (__le32 __force *)desc;
@@ -495,6 +495,7 @@ static void cqhci_set_tran_desc(u8 *desc, dma_addr_t addr, int len, bool end,
 		dataddr[0] = cpu_to_le32(addr);
 	}
 }
+EXPORT_SYMBOL(cqhci_set_tran_desc);
 
 static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 			       struct cqhci_host *cq_host, int tag)
@@ -516,6 +517,11 @@ static int cqhci_prep_tran_desc(struct mmc_request *mrq,
 
 	desc = get_trans_desc(cq_host, tag);
 
+	if (cq_host->ops->setup_tran_desc) {
+		cq_host->ops->setup_tran_desc(data, cq_host, desc, sg_count);
+		return 0;
+	}
+
 	for_each_sg(data->sg, sg, sg_count, i) {
 		addr = sg_dma_address(sg);
 		len = sg_dma_len(sg);
diff --git a/drivers/mmc/host/cqhci.h b/drivers/mmc/host/cqhci.h
index 1a12e40a02e6..cb3dfb161c54 100644
--- a/drivers/mmc/host/cqhci.h
+++ b/drivers/mmc/host/cqhci.h
@@ -289,6 +289,8 @@ struct cqhci_host_ops {
 				 u64 *data);
 	void (*pre_enable)(struct mmc_host *mmc);
 	void (*post_disable)(struct mmc_host *mmc);
+	void (*setup_tran_desc)(struct mmc_data *data,
+		struct cqhci_host *cq_host, u8 *desc, int sg_count);
 #ifdef CONFIG_MMC_CRYPTO
 	int (*program_key)(struct cqhci_host *cq_host,
 			   const union cqhci_crypto_cfg_entry *cfg, int slot);
-- 
2.42.0

