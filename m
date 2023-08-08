Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EA9774152
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234376AbjHHRSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234302AbjHHRSX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:18:23 -0400
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 669621E312;
        Tue,  8 Aug 2023 09:07:30 -0700 (PDT)
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378A8kv3028961;
        Tue, 8 Aug 2023 04:27:35 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=pfpt0220;
 bh=XAlOl3DDRS02zzgLra0tknIopDmIwtdliZJfkBFdVgQ=;
 b=CFfgTKuAdLKYJChLhCNGECFWt/E6QG/EbMxzXBE5V0U78OZhl7f7ty0eZdyzW+2lvtXf
 i4FqQObnGxqSIHe5T2UOKor5eP6haPlPVFaW5kSFB9GFW809glf7QrQBHZjb4i/PMtxD
 TequXOsoofBTQomX1ON+rYBlBzphp/4LI8RkF5nwhi7kMhCeJqjlT8pUY9pUSUbAZqf6
 xvsne4eLUWGz75kGcKBjKMKozCoxKqC58hTyyHhcDAalGyeW7l/ayJ+YVW7Z2Zm1FL+g
 8QrHenOkaXhmjxESa6+lHYJZxQ/mjfo+MVkm67uTLyIiG8q3eiImLzi9G1CU+IzGcYX5 iA== 
Received: from dc5-exch02.marvell.com ([199.233.59.182])
        by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3sbkntg7mr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 04:27:34 -0700
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 8 Aug
 2023 04:27:33 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 8 Aug 2023 04:27:33 -0700
Received: from localhost.localdomain (unknown [10.28.36.166])
        by maili.marvell.com (Postfix) with ESMTP id A7D113F7045;
        Tue,  8 Aug 2023 04:27:28 -0700 (PDT)
From:   Suman Ghosh <sumang@marvell.com>
To:     <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <lcherian@marvell.com>, <jerinj@marvell.com>
Subject: [net PATCH 3/3] octeontx2-af: CN10KB: fix PFC configuration
Date:   Tue, 8 Aug 2023 16:57:08 +0530
Message-ID: <20230808112708.3179218-4-sumang@marvell.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230808112708.3179218-1-sumang@marvell.com>
References: <20230808112708.3179218-1-sumang@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: cNhGZ-HWFY0j-uZTSBniOwBV2CxkuOyf
X-Proofpoint-ORIG-GUID: cNhGZ-HWFY0j-uZTSBniOwBV2CxkuOyf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_09,2023-08-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hariprasad Kelam <hkelam@marvell.com>

The previous patch which added new CN10KB RPM block support,
has a bug due to which PFC is not getting configured properly.
This patch fixes the same.

Fixes: b9d0fedc6234 ("octeontx2-af: cn10kb: Add RPM_USX MAC support")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 17 +++++++++--------
 .../net/ethernet/marvell/octeontx2/af/rvu_reg.c |  4 ++--
 2 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index b4fcb20c3f4f..af21e2030cff 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -355,8 +355,8 @@ int rpm_lmac_enadis_pause_frm(void *rpmd, int lmac_id, u8 tx_pause,
 
 void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
 {
+	u64 cfg, pfc_class_mask_cfg;
 	rpm_t *rpm = rpmd;
-	u64 cfg;
 
 	/* ALL pause frames received are completely ignored */
 	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
@@ -380,9 +380,11 @@ void rpm_lmac_pause_frm_config(void *rpmd, int lmac_id, bool enable)
 		rpm_write(rpm, 0, RPMX_CMR_CHAN_MSK_OR, ~0ULL);
 
 	/* Disable all PFC classes */
-	cfg = rpm_read(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL);
+	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
+						RPMX_CMRX_PRT_CBFC_CTL;
+	cfg = rpm_read(rpm, lmac_id, pfc_class_mask_cfg);
 	cfg = FIELD_SET(RPM_PFC_CLASS_MASK, 0, cfg);
-	rpm_write(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL, cfg);
+	rpm_write(rpm, lmac_id, pfc_class_mask_cfg, cfg);
 }
 
 int rpm_get_rx_stats(void *rpmd, int lmac_id, int idx, u64 *rx_stat)
@@ -605,8 +607,11 @@ int rpm_lmac_pfc_config(void *rpmd, int lmac_id, u8 tx_pause, u8 rx_pause, u16 p
 	if (!is_lmac_valid(rpm, lmac_id))
 		return -ENODEV;
 
+	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
+						RPMX_CMRX_PRT_CBFC_CTL;
+
 	cfg = rpm_read(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG);
-	class_en = rpm_read(rpm, lmac_id, RPMX_CMRX_PRT_CBFC_CTL);
+	class_en = rpm_read(rpm, lmac_id, pfc_class_mask_cfg);
 	pfc_en |= FIELD_GET(RPM_PFC_CLASS_MASK, class_en);
 
 	if (rx_pause) {
@@ -635,10 +640,6 @@ int rpm_lmac_pfc_config(void *rpmd, int lmac_id, u8 tx_pause, u8 rx_pause, u16 p
 		cfg |= RPMX_MTI_MAC100X_COMMAND_CONFIG_PFC_MODE;
 
 	rpm_write(rpm, lmac_id, RPMX_MTI_MAC100X_COMMAND_CONFIG, cfg);
-
-	pfc_class_mask_cfg = is_dev_rpm2(rpm) ? RPM2_CMRX_PRT_CBFC_CTL :
-						RPMX_CMRX_PRT_CBFC_CTL;
-
 	rpm_write(rpm, lmac_id, pfc_class_mask_cfg, class_en);
 
 	return 0;
diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
index b3150f053291..d46ac29adb96 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rvu_reg.c
@@ -31,8 +31,8 @@ static struct hw_reg_map txsch_reg_map[NIX_TXSCH_LVL_CNT] = {
 	{NIX_TXSCH_LVL_TL4, 3, 0xFFFF, {{0x0B00, 0x0B08}, {0x0B10, 0x0B18},
 			      {0x1200, 0x12E0} } },
 	{NIX_TXSCH_LVL_TL3, 4, 0xFFFF, {{0x1000, 0x10E0}, {0x1600, 0x1608},
-			      {0x1610, 0x1618}, {0x1700, 0x17B0} } },
-	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17B0} } },
+			      {0x1610, 0x1618}, {0x1700, 0x17C8} } },
+	{NIX_TXSCH_LVL_TL2, 2, 0xFFFF, {{0x0E00, 0x0EE0}, {0x1700, 0x17C8} } },
 	{NIX_TXSCH_LVL_TL1, 1, 0xFFFF, {{0x0C00, 0x0D98} } },
 };
 
-- 
2.25.1

