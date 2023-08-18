Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58FBF7808EE
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:49:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359351AbjHRJtU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:49:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359359AbjHRJtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:49:17 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C37A2D7D;
        Fri, 18 Aug 2023 02:49:15 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 98e67ed59e1d1-26d1e5f2c35so538941a91.2;
        Fri, 18 Aug 2023 02:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692352154; x=1692956954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vEagzt0M0Xz7/XTdQsFK+MZqc0qK0frdAcvn3zJ8R/I=;
        b=HYB7hcCQ6anKyxTi4/htddF3d3VTD3py2Zf1pV5MHNHVzmgg3DUuCUYa7avfBYR1EE
         BHhx3cTB2dNRMOryKCV1rig02yfulGawcR2i0g2OYFApJPBB3a5wTcAh4pPv8jW1jnpY
         GHH5pZmED8D3/cE8I4CjMOSHOagrJAFzKX9Gx3tn6Ck/tAD5gwoBIGRmgP+c4eKLOHlm
         jDVO6MnTecA45f7i7NokSYZN4GBQlNLxoSe+sADuaRbjcM9zxzJNGdZBdDUJ9xjXeG8o
         j2+r12sa9cvj3WVKAtUJ8eHozufTObYooVHBgqHfcjuIguqEN2uAyVIEQSB0RPFpuxQe
         WkWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692352154; x=1692956954;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vEagzt0M0Xz7/XTdQsFK+MZqc0qK0frdAcvn3zJ8R/I=;
        b=O4wD9RkrtbgnGBGO+u7PnOECjJPwC7rR849QAkq9n9qQt4aK6VVSiJJzfVzaQuawCn
         lNKWB0C4AiIeOeua4nl+Qk3MWCdItUUUJZynA/mSQjiy8ALAfvVw06F2Y8xeasthqKt2
         o00DRkCABx4u81fClWi426lQM578BFXzsBwvuoRW6Y8gjYSXfFdfTGthWGti7YMc80iS
         qcNi/rOSmm/rFqq2jIjFvjqlzsWqUFLVAZNJkOKS/hBTjyoOe6Hds0CG90oD6GoxBPtk
         VjsmBQVVzS/UvzrWCUYhPCsZy6vuIqxf8pN5Ia15aymsSzH3RBpufln2aBODVgRfEBMA
         1khg==
X-Gm-Message-State: AOJu0YwPqB123Ig4Hf8w0zIfz0DbPW1M6UJ4hCAN9CMNShRhRp0BPOAe
        Epwn8wZeF8Sv6CuPAR2IQo4=
X-Google-Smtp-Source: AGHT+IED1CiCOHgv5RWQZ1avSi5qTunWTAsGiCdzxQtWWCax1h9VTR1r+KGEilWYWy54UYCjvQYxkQ==
X-Received: by 2002:a17:90b:3ecb:b0:268:71e4:ec2a with SMTP id rm11-20020a17090b3ecb00b0026871e4ec2amr1736031pjb.48.1692352154378;
        Fri, 18 Aug 2023 02:49:14 -0700 (PDT)
Received: from localhost.localdomain ([198.211.45.220])
        by smtp.googlemail.com with ESMTPSA id z9-20020a17090ab10900b00262fc3d911esm2908052pjq.28.2023.08.18.02.49.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 02:49:13 -0700 (PDT)
From:   Furong Xu <0x1207@gmail.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Joao Pinto <jpinto@synopsys.com>,
        Simon Horman <horms@kernel.org>
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        xfr@outlook.com, rock.xu@nio.com, Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next 1/1] net: stmmac: Check more MAC HW features for XGMAC Core 3.20
Date:   Fri, 18 Aug 2023 17:48:32 +0800
Message-Id: <20230818094832.179420-1-0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

1. XGMAC core does not have hash_filter definition, it uses
vlhash(VLAN Hash Filtering) instead, skip hash_filter when XGMAC.
2. Show exact size of Hash Table instead of raw register value.
3. Show full description of safety features defined by Synopsys Databook.
4. When safety feature is configured with no parity, or ECC only,
keep FSM Parity Checking disabled.

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 drivers/net/ethernet/stmicro/stmmac/common.h  | 36 ++++++++++
 .../net/ethernet/stmicro/stmmac/dwxgmac2.h    | 21 ++++++
 .../ethernet/stmicro/stmmac/dwxgmac2_core.c   |  6 +-
 .../ethernet/stmicro/stmmac/dwxgmac2_dma.c    | 23 ++++++
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 71 +++++++++++++++++--
 5 files changed, 149 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/common.h b/drivers/net/ethernet/stmicro/stmmac/common.h
index b37f2f6b2229..4b7908fad498 100644
--- a/drivers/net/ethernet/stmicro/stmmac/common.h
+++ b/drivers/net/ethernet/stmicro/stmmac/common.h
@@ -406,6 +406,18 @@ struct dma_features {
 	unsigned int number_tx_queues;
 	/* PPS output */
 	unsigned int pps_out_num;
+	/* Number of Traffic Classes */
+	unsigned int numtc;
+	/* DCB Feature Enable */
+	unsigned int dcben;
+	/* IEEE 1588 High Word Register Enable */
+	unsigned int advthword;
+	/* PTP Offload Enable */
+	unsigned int ptoen;
+	/* One-Step Timestamping Enable */
+	unsigned int osten;
+	/* Priority-Based Flow Control Enable */
+	unsigned int pfcen;
 	/* Alternate (enhanced) DESC mode */
 	unsigned int enh_desc;
 	/* TX and RX FIFO sizes */
@@ -426,16 +438,40 @@ struct dma_features {
 	unsigned int dvlan;
 	unsigned int l3l4fnum;
 	unsigned int arpoffsel;
+	/* One Step for PTP over UDP/IP Feature Enable */
+	unsigned int pou_ost_en;
+	/* Tx Timestamp FIFO Depth */
+	unsigned int ttsfd;
+	/* Queue/Channel-Based VLAN tag insertion on Tx */
+	unsigned int cbtisel;
+	/* Supported Parallel Instruction Processor Engines */
+	unsigned int frppipe_num;
+	/* Number of Extended VLAN Tag Filters */
+	unsigned int nrvf_num;
 	/* TSN Features */
 	unsigned int estwid;
 	unsigned int estdep;
 	unsigned int estsel;
 	unsigned int fpesel;
 	unsigned int tbssel;
+	/* Number of DMA channels enabled for TBS */
+	unsigned int tbs_ch_num;
+	/* Per-Stream Filtering Enable */
+	unsigned int sgfsel;
 	/* Numbers of Auxiliary Snapshot Inputs */
 	unsigned int aux_snapshot_n;
 	/* Timestamp System Time Source */
 	unsigned int tssrc;
+	/* Enhanced DMA Enable */
+	unsigned int edma;
+	/* Different Descriptor Cache Enable */
+	unsigned int ediffc;
+	/* VxLAN/NVGRE Enable */
+	unsigned int vxn;
+	/* Debug Memory Interface Enable */
+	unsigned int dbgmem;
+	/* Number of Policing Counters */
+	unsigned int pcsel;
 };
 
 /* RX Buffer size must be multiple of 4/8/16 bytes */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
index 464108236f3c..f61b3af5685b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2.h
@@ -122,6 +122,9 @@
 #define XGMAC_TLPIEN			BIT(0)
 #define XGMAC_LPI_TIMER_CTRL		0x000000d4
 #define XGMAC_HW_FEATURE0		0x0000011c
+#define XGMAC_HWFEAT_EDMA		BIT(31)
+#define XGMAC_HWFEAT_EDIFFC		BIT(30)
+#define XGMAC_HWFEAT_VXN		BIT(29)
 #define XGMAC_HWFEAT_SAVLANINS		BIT(27)
 #define XGMAC_HWFEAT_TSSTSSEL		GENMASK(26, 25)
 #define XGMAC_HWFEAT_ADDMACADRSEL	GENMASK(22, 18)
@@ -142,29 +145,47 @@
 #define XGMAC_HW_FEATURE1		0x00000120
 #define XGMAC_HWFEAT_L3L4FNUM		GENMASK(30, 27)
 #define XGMAC_HWFEAT_HASHTBLSZ		GENMASK(25, 24)
+#define XGMAC_HWFEAT_NUMTC		GENMASK(23, 21)
 #define XGMAC_HWFEAT_RSSEN		BIT(20)
+#define XGMAC_HWFEAT_DBGMEMA		BIT(19)
 #define XGMAC_HWFEAT_TSOEN		BIT(18)
 #define XGMAC_HWFEAT_SPHEN		BIT(17)
+#define XGMAC_HWFEAT_DCBEN		BIT(16)
 #define XGMAC_HWFEAT_ADDR64		GENMASK(15, 14)
+#define XGMAC_HWFEAT_ADVTHWORD		BIT(13)
+#define XGMAC_HWFEAT_PTOEN		BIT(12)
+#define XGMAC_HWFEAT_OSTEN		BIT(11)
 #define XGMAC_HWFEAT_TXFIFOSIZE		GENMASK(10, 6)
+#define XGMAC_HWFEAT_PFCEN		BIT(5)
 #define XGMAC_HWFEAT_RXFIFOSIZE		GENMASK(4, 0)
 #define XGMAC_HW_FEATURE2		0x00000124
+#define XGMAC_HWFEAT_AUXSNAPNUM		GENMASK(30, 28)
 #define XGMAC_HWFEAT_PPSOUTNUM		GENMASK(26, 24)
 #define XGMAC_HWFEAT_TXCHCNT		GENMASK(21, 18)
 #define XGMAC_HWFEAT_RXCHCNT		GENMASK(15, 12)
 #define XGMAC_HWFEAT_TXQCNT		GENMASK(9, 6)
 #define XGMAC_HWFEAT_RXQCNT		GENMASK(3, 0)
 #define XGMAC_HW_FEATURE3		0x00000128
+#define XGMAC_HWFEAT_TBSCH		GENMASK(31, 28)
 #define XGMAC_HWFEAT_TBSSEL		BIT(27)
 #define XGMAC_HWFEAT_FPESEL		BIT(26)
+#define XGMAC_HWFEAT_SGFSEL		BIT(25)
 #define XGMAC_HWFEAT_ESTWID		GENMASK(24, 23)
 #define XGMAC_HWFEAT_ESTDEP		GENMASK(22, 20)
 #define XGMAC_HWFEAT_ESTSEL		BIT(19)
+#define XGMAC_HWFEAT_TTSFD		GENMASK(18, 16)
 #define XGMAC_HWFEAT_ASP		GENMASK(15, 14)
 #define XGMAC_HWFEAT_DVLAN		BIT(13)
 #define XGMAC_HWFEAT_FRPES		GENMASK(12, 11)
 #define XGMAC_HWFEAT_FRPPB		GENMASK(10, 9)
+#define XGMAC_HWFEAT_POUOST		BIT(8)
+#define XGMAC_HWFEAT_FRPPIPE		GENMASK(7, 5)
+#define XGMAC_HWFEAT_CBTISEL		BIT(4)
 #define XGMAC_HWFEAT_FRPSEL		BIT(3)
+#define XGMAC_HWFEAT_NRVF		GENMASK(2, 0)
+#define XGMAC_HW_FEATURE4		0x0000012c
+#define XGMAC_HWFEAT_EASP		BIT(4)
+#define XGMAC_HWFEAT_PCSEL		GENMASK(1, 0)
 #define XGMAC_MAC_DPP_FSM_INT_STATUS	0x00000150
 #define XGMAC_MAC_FSM_CONTROL		0x00000158
 #define XGMAC_PRTYEN			BIT(1)
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
index 38782662ff98..34e1b0c3f346 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_core.c
@@ -861,8 +861,10 @@ dwxgmac3_safety_feat_config(void __iomem *ioaddr, unsigned int asp,
 	value |= XGMAC_TCEIE; /* TSO Memory Correctable Error */
 	writel(value, ioaddr + XGMAC_DMA_ECC_INT_ENABLE);
 
-	/* Only ECC Protection for External Memory feature is selected */
-	if (asp <= 0x1)
+	/* 0x2: Without ECC or Parity Ports on External Application Interface
+	 * 0x4: Only ECC Protection for External Memory feature is selected
+	 */
+	if (asp == 0x2 || asp == 0x4)
 		return 0;
 
 	/* 4. Enable Parity and Timeout for FSM */
diff --git a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
index 6d6abc3ddb53..a4d58a18129a 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwxgmac2_dma.c
@@ -391,6 +391,9 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 
 	/* MAC HW feature 0 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE0);
+	dma_cap->edma = (hw_cap & XGMAC_HWFEAT_EDMA) >> 31;
+	dma_cap->ediffc = (hw_cap & XGMAC_HWFEAT_EDIFFC) >> 30;
+	dma_cap->vxn = (hw_cap & XGMAC_HWFEAT_VXN) >> 29;
 	dma_cap->vlins = (hw_cap & XGMAC_HWFEAT_SAVLANINS) >> 27;
 	dma_cap->tssrc = (hw_cap & XGMAC_HWFEAT_TSSTSSEL) >> 25;
 	dma_cap->multi_addr = (hw_cap & XGMAC_HWFEAT_ADDMACADRSEL) >> 18;
@@ -413,9 +416,12 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE1);
 	dma_cap->l3l4fnum = (hw_cap & XGMAC_HWFEAT_L3L4FNUM) >> 27;
 	dma_cap->hash_tb_sz = (hw_cap & XGMAC_HWFEAT_HASHTBLSZ) >> 24;
+	dma_cap->numtc = ((hw_cap & XGMAC_HWFEAT_NUMTC) >> 21) + 1;
 	dma_cap->rssen = (hw_cap & XGMAC_HWFEAT_RSSEN) >> 20;
+	dma_cap->dbgmem = (hw_cap & XGMAC_HWFEAT_DBGMEMA) >> 19;
 	dma_cap->tsoen = (hw_cap & XGMAC_HWFEAT_TSOEN) >> 18;
 	dma_cap->sphen = (hw_cap & XGMAC_HWFEAT_SPHEN) >> 17;
+	dma_cap->dcben = (hw_cap & XGMAC_HWFEAT_DCBEN) >> 16;
 
 	dma_cap->addr64 = (hw_cap & XGMAC_HWFEAT_ADDR64) >> 14;
 	switch (dma_cap->addr64) {
@@ -433,13 +439,18 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 		break;
 	}
 
+	dma_cap->advthword = (hw_cap & XGMAC_HWFEAT_ADVTHWORD) >> 13;
+	dma_cap->ptoen = (hw_cap & XGMAC_HWFEAT_PTOEN) >> 12;
+	dma_cap->osten = (hw_cap & XGMAC_HWFEAT_OSTEN) >> 11;
 	dma_cap->tx_fifo_size =
 		128 << ((hw_cap & XGMAC_HWFEAT_TXFIFOSIZE) >> 6);
+	dma_cap->pfcen = (hw_cap & XGMAC_HWFEAT_PFCEN) >> 5;
 	dma_cap->rx_fifo_size =
 		128 << ((hw_cap & XGMAC_HWFEAT_RXFIFOSIZE) >> 0);
 
 	/* MAC HW feature 2 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE2);
+	dma_cap->aux_snapshot_n = (hw_cap & XGMAC_HWFEAT_AUXSNAPNUM) >> 28;
 	dma_cap->pps_out_num = (hw_cap & XGMAC_HWFEAT_PPSOUTNUM) >> 24;
 	dma_cap->number_tx_channel =
 		((hw_cap & XGMAC_HWFEAT_TXCHCNT) >> 18) + 1;
@@ -452,16 +463,28 @@ static int dwxgmac2_get_hw_feature(void __iomem *ioaddr,
 
 	/* MAC HW feature 3 */
 	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE3);
+	dma_cap->tbs_ch_num = ((hw_cap & XGMAC_HWFEAT_TBSCH) >> 28) + 1;
 	dma_cap->tbssel = (hw_cap & XGMAC_HWFEAT_TBSSEL) >> 27;
 	dma_cap->fpesel = (hw_cap & XGMAC_HWFEAT_FPESEL) >> 26;
+	dma_cap->sgfsel = (hw_cap & XGMAC_HWFEAT_SGFSEL) >> 25;
 	dma_cap->estwid = (hw_cap & XGMAC_HWFEAT_ESTWID) >> 23;
 	dma_cap->estdep = (hw_cap & XGMAC_HWFEAT_ESTDEP) >> 20;
 	dma_cap->estsel = (hw_cap & XGMAC_HWFEAT_ESTSEL) >> 19;
+	dma_cap->ttsfd = (hw_cap & XGMAC_HWFEAT_TTSFD) >> 16;
 	dma_cap->asp = (hw_cap & XGMAC_HWFEAT_ASP) >> 14;
 	dma_cap->dvlan = (hw_cap & XGMAC_HWFEAT_DVLAN) >> 13;
 	dma_cap->frpes = (hw_cap & XGMAC_HWFEAT_FRPES) >> 11;
 	dma_cap->frpbs = (hw_cap & XGMAC_HWFEAT_FRPPB) >> 9;
+	dma_cap->pou_ost_en = (hw_cap & XGMAC_HWFEAT_POUOST) >> 8;
+	dma_cap->frppipe_num = ((hw_cap & XGMAC_HWFEAT_FRPPIPE) >> 5) + 1;
+	dma_cap->cbtisel = (hw_cap & XGMAC_HWFEAT_CBTISEL) >> 4;
 	dma_cap->frpsel = (hw_cap & XGMAC_HWFEAT_FRPSEL) >> 3;
+	dma_cap->nrvf_num = (hw_cap & XGMAC_HWFEAT_NRVF) >> 0;
+
+	/* MAC HW feature 4 */
+	hw_cap = readl(ioaddr + XGMAC_HW_FEATURE4);
+	dma_cap->asp |= (hw_cap & XGMAC_HWFEAT_EASP) >> 2;
+	dma_cap->pcsel = (hw_cap & XGMAC_HWFEAT_PCSEL) >> 0;
 
 	return 0;
 }
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 2d627640cc60..a63b39a573d8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6180,6 +6180,16 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 		"External",
 		"Both",
 	};
+	static const char * const dwxgmac_safety_feature_desc[] = {
+		"No",
+		"All Safety Features with ECC and Parity",
+		"All Safety Features without ECC or Parity",
+		"All Safety Features with Parity Only",
+		"ECC only",
+		"UNDEFINED",
+		"UNDEFINED",
+		"UNDEFINED",
+	};
 	struct net_device *dev = seq->private;
 	struct stmmac_priv *priv = netdev_priv(dev);
 
@@ -6198,15 +6208,16 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 		   (priv->dma_cap.mbps_1000) ? "Y" : "N");
 	seq_printf(seq, "\tHalf duplex: %s\n",
 		   (priv->dma_cap.half_duplex) ? "Y" : "N");
-	seq_printf(seq, "\tHash Filter: %s\n",
-		   (priv->dma_cap.hash_filter) ? "Y" : "N");
-	if (priv->plat->has_xgmac)
+	if (priv->plat->has_xgmac) {
 		seq_printf(seq,
 			   "\tNumber of Additional MAC address registers: %d\n",
 			   priv->dma_cap.multi_addr);
-	else
+	} else {
+		seq_printf(seq, "\tHash Filter: %s\n",
+			   (priv->dma_cap.hash_filter) ? "Y" : "N");
 		seq_printf(seq, "\tMultiple MAC address registers: %s\n",
 			   (priv->dma_cap.multi_addr) ? "Y" : "N");
+	}
 	seq_printf(seq, "\tPCS (TBI/SGMII/RTBI PHY interfaces): %s\n",
 		   (priv->dma_cap.pcs) ? "Y" : "N");
 	seq_printf(seq, "\tSMA (MDIO) Interface: %s\n",
@@ -6253,12 +6264,13 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 		   (priv->dma_cap.enh_desc) ? "Y" : "N");
 	seq_printf(seq, "\tTX Fifo Size: %d\n", priv->dma_cap.tx_fifo_size);
 	seq_printf(seq, "\tRX Fifo Size: %d\n", priv->dma_cap.rx_fifo_size);
-	seq_printf(seq, "\tHash Table Size: %d\n", priv->dma_cap.hash_tb_sz);
+	seq_printf(seq, "\tHash Table Size: %lu\n", priv->dma_cap.hash_tb_sz ?
+		   (BIT(priv->dma_cap.hash_tb_sz) << 5) : 0);
 	seq_printf(seq, "\tTSO: %s\n", priv->dma_cap.tsoen ? "Y" : "N");
 	seq_printf(seq, "\tNumber of PPS Outputs: %d\n",
 		   priv->dma_cap.pps_out_num);
 	seq_printf(seq, "\tSafety Features: %s\n",
-		   priv->dma_cap.asp ? "Y" : "N");
+		   dwxgmac_safety_feature_desc[priv->dma_cap.asp]);
 	seq_printf(seq, "\tFlexible RX Parser: %s\n",
 		   priv->dma_cap.frpsel ? "Y" : "N");
 	seq_printf(seq, "\tEnhanced Addressing: %d\n",
@@ -6283,6 +6295,53 @@ static int stmmac_dma_cap_show(struct seq_file *seq, void *v)
 		   priv->dma_cap.fpesel ? "Y" : "N");
 	seq_printf(seq, "\tTime-Based Scheduling (TBS): %s\n",
 		   priv->dma_cap.tbssel ? "Y" : "N");
+	seq_printf(seq, "\tNumber of DMA Channels Enabled for TBS: %d\n",
+		   priv->dma_cap.tbs_ch_num);
+	seq_printf(seq, "\tPer-Stream Filtering: %s\n",
+		   priv->dma_cap.sgfsel ? "Y" : "N");
+	seq_printf(seq, "\tTX Timestamp FIFO Depth: %lu\n",
+		   BIT(priv->dma_cap.ttsfd) >> 1);
+	seq_printf(seq, "\tNumber of Traffic Classes: %d\n",
+		   priv->dma_cap.numtc);
+	seq_printf(seq, "\tDCB Feature: %s\n",
+		   priv->dma_cap.dcben ? "Y" : "N");
+	seq_printf(seq, "\tIEEE 1588 High Word Register: %s\n",
+		   priv->dma_cap.advthword ? "Y" : "N");
+	seq_printf(seq, "\tPTP Offload: %s\n",
+		   priv->dma_cap.ptoen ? "Y" : "N");
+	seq_printf(seq, "\tOne-Step Timestamping: %s\n",
+		   priv->dma_cap.osten ? "Y" : "N");
+	seq_printf(seq, "\tPriority-Based Flow Control: %s\n",
+		   priv->dma_cap.pfcen ? "Y" : "N");
+	seq_printf(seq, "\tNumber of Flexible RX Parser Instructions: %lu\n",
+		   BIT(priv->dma_cap.frpes) << 6);
+	seq_printf(seq, "\tNumber of Flexible RX Parser Parsable Bytes: %lu\n",
+		   BIT(priv->dma_cap.frpbs) << 6);
+	seq_printf(seq, "\tParallel Instruction Processor Engines: %d\n",
+		   priv->dma_cap.frppipe_num);
+	seq_printf(seq, "\tNumber of Extended VLAN Tag Filters: %lu\n",
+		   priv->dma_cap.nrvf_num ?
+		   (BIT(priv->dma_cap.nrvf_num) << 1) : 0);
+	seq_printf(seq, "\tWidth of the Time Interval Field in GCL: %d\n",
+		   priv->dma_cap.estwid ? 4 * priv->dma_cap.estwid + 12 : 0);
+	seq_printf(seq, "\tDepth of GCL: %lu\n",
+		   priv->dma_cap.estdep ? (BIT(priv->dma_cap.estdep) << 5) : 0);
+	seq_printf(seq, "\tQueue/Channel-Based VLAN Tag Insertion on TX: %s\n",
+		   priv->dma_cap.cbtisel ? "Y" : "N");
+	seq_printf(seq, "\tNumber of Auxiliary Snapshot Inputs: %d\n",
+		   priv->dma_cap.aux_snapshot_n);
+	seq_printf(seq, "\tOne-Step Timestamping for PTP over UDP/IP: %s\n",
+		   priv->dma_cap.pou_ost_en ? "Y" : "N");
+	seq_printf(seq, "\tEnhanced DMA: %s\n",
+		   priv->dma_cap.edma ? "Y" : "N");
+	seq_printf(seq, "\tDifferent Descriptor Cache: %s\n",
+		   priv->dma_cap.ediffc ? "Y" : "N");
+	seq_printf(seq, "\tVxLAN/NVGRE: %s\n",
+		   priv->dma_cap.vxn ? "Y" : "N");
+	seq_printf(seq, "\tDebug Memory Interface: %s\n",
+		   priv->dma_cap.dbgmem ? "Y" : "N");
+	seq_printf(seq, "\tNumber of Policing Counters: %lu\n",
+		   priv->dma_cap.pcsel ? BIT(priv->dma_cap.pcsel + 3) : 0);
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(stmmac_dma_cap);
-- 
2.34.1

