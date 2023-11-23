Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AA447F57FD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 07:01:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344752AbjKWGBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 01:01:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344731AbjKWGAq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 01:00:46 -0500
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8151B6;
        Wed, 22 Nov 2023 22:00:52 -0800 (PST)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3AN5YmaQ022778;
        Wed, 22 Nov 2023 22:00:46 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type; s=pfpt0220; bh=kM3BU7BmXAvWkQp+dGqrdOyFofGDsnc5M3Efwgf8NdE=;
 b=I0wtuJku19iLqhPBQLvFaC1GtlLsgXYjzLQoNCLHjYAe0DxQ0XfzlNN1z2Llu9poU9VW
 wVbX94K5jJymUF9MDzKP87Bn/z1/BRMTA7fiHSp0pboshcqxdJx7kf3ie6BRVho3ZpDx
 ALquT8Ae15ck7Up/enFA0FvpjzWc3HreX/nVu4zz0hs87B3PdY7p45dbQo3p8aw5WDBA
 XSl+dLdPz9d3mCtcLZ0CtRhhT9SxwZuwdALl/USZARMD/e6LdSv25XPWxfSLIWE/IrZ8
 uoqlT1zkWDillfqAVrXyg307daHjn9d0Kr8lgbEGAGy7zxf1k0Me4VmeMDyExSHye7Xr NA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3uhpxn1xm0-8
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Wed, 22 Nov 2023 22:00:46 -0800
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Wed, 22 Nov
 2023 21:59:57 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Wed, 22 Nov 2023 21:59:57 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
        by maili.marvell.com (Postfix) with ESMTP id 135A73F7088;
        Wed, 22 Nov 2023 21:59:53 -0800 (PST)
From:   Geetha sowjanya <gakula@marvell.com>
To:     <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC:     <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH 3/5] octeontx2-af: Fix mcs stats register address
Date:   Thu, 23 Nov 2023 11:29:39 +0530
Message-ID: <20231123055941.19430-4-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20231123055941.19430-1-gakula@marvell.com>
References: <20231123055941.19430-1-gakula@marvell.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wT6ECuTrFEa1d7aZZSif7bjQrNFo2Rbi
X-Proofpoint-GUID: wT6ECuTrFEa1d7aZZSif7bjQrNFo2Rbi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-23_03,2023-11-22_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds the miss mcs stats register
for mcs supported platforms.

Fixes: 9312150af8da ("octeontx2-af: cn10k: mcs: Support for stats collection")
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../net/ethernet/marvell/octeontx2/af/mcs.c   |  4 +--
 .../ethernet/marvell/octeontx2/af/mcs_reg.h   | 31 ++++++++++++++++---
 2 files changed, 29 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
index d6effbe46208..d4a4e4c837ec 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs.c
@@ -117,7 +117,7 @@ void mcs_get_rx_secy_stats(struct mcs *mcs, struct mcs_secy_stats *stats, int id
 	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYTAGGEDCTLX(id);
 	stats->pkt_tagged_ctl_cnt = mcs_reg_read(mcs, reg);
 
-	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(id);
+	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(id);
 	stats->pkt_untaged_cnt = mcs_reg_read(mcs, reg);
 
 	reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(id);
@@ -215,7 +215,7 @@ void mcs_get_sc_stats(struct mcs *mcs, struct mcs_sc_stats *stats,
 		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCNOTVALIDX(id);
 		stats->pkt_notvalid_cnt = mcs_reg_read(mcs, reg);
 
-		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(id);
+		reg = MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(id);
 		stats->pkt_unchecked_cnt = mcs_reg_read(mcs, reg);
 
 		if (mcs->hw->mcs_blks > 1) {
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
index f3ab01fc363c..f4c6de89002c 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
+++ b/drivers/net/ethernet/marvell/octeontx2/af/mcs_reg.h
@@ -810,14 +810,37 @@
 		offset = 0x9d8ull;			\
 	offset; })
 
+#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDX(a) ({	\
+	u64 offset;					\
+							\
+	offset = 0xee80ull;				\
+	if (mcs->hw->mcs_blks > 1)			\
+		offset = 0xe818ull;			\
+	offset += (a) * 0x8ull;				\
+	offset; })
+
+#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a) ({	\
+	u64 offset;					\
+							\
+	offset = 0xa680ull;				\
+	if (mcs->hw->mcs_blks > 1)			\
+		offset = 0xd018ull;			\
+	offset += (a) * 0x8ull;				\
+	offset; })
+
+#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a)	({	\
+	u64 offset;						\
+								\
+	offset = 0xf680ull;					\
+	if (mcs->hw->mcs_blks > 1)				\
+		offset = 0xe018ull;				\
+	offset += (a) * 0x8ull;					\
+	offset; })
+
 #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCDECRYPTEDX(a)	(0xe680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INOCTETSSCVALIDATEX(a)	(0xde80ull + (a) * 0x8ull)
-#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDORNOTAGX(a)	(0xa680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYNOTAGX(a)	(0xd218 + (a) * 0x8ull)
-#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYUNTAGGEDX(a)	(0xd018ull + (a) * 0x8ull)
-#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCUNCHECKEDOROKX(a)	(0xee80ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSECYCTLX(a)		(0xb680ull + (a) * 0x8ull)
-#define MCSX_CSE_RX_MEM_SLAVE_INPKTSSCLATEORDELAYEDX(a) (0xf680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSAINVALIDX(a)	(0x12680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTUSINGSAERRORX(a) (0x15680ull + (a) * 0x8ull)
 #define MCSX_CSE_RX_MEM_SLAVE_INPKTSSANOTVALIDX(a)	(0x13680ull + (a) * 0x8ull)
-- 
2.25.1

