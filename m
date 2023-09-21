Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E377AA4E8
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 00:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232900AbjIUWZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 18:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231221AbjIUWZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 18:25:28 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96EFBAD19;
        Thu, 21 Sep 2023 10:06:01 -0700 (PDT)
X-UUID: 7195e40a583f11eea33bb35ae8d461a2-20230921
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gq8s2Npu2Vz0jwf1wrspqegc3TXAG46Dv16VsHzTy3g=;
        b=KzzZkDuwt0Ry8r+qO1pKqh4ILb4hUyRyvZNIt7g0SGVuRAZLd4qlbQ2pl/s+4pkpue6gylOs36/8xqSR+6n0vPe2g0zrwsRZdMEtDzqnmCDF+5SqO+S6QZtLjfPM/gUx4n1rTuOuvUqMmCwRWwOGCJYBQX7DkYlqIQKga8HVtS8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.32,REQID:d0280e8a-49b8-4675-b692-fcc3e7382504,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:5f78ec9,CLOUDID:621d48c3-1e57-4345-9d31-31ad9818b39f,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: 7195e40a583f11eea33bb35ae8d461a2-20230921
Received: from mtkmbs14n1.mediatek.inc [(172.21.101.75)] by mailgw01.mediatek.com
        (envelope-from <chun-jen.tseng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 803014075; Thu, 21 Sep 2023 13:26:40 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 21 Sep 2023 13:26:39 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 21 Sep 2023 13:26:39 +0800
From:   Mark Tseng <chun-jen.tseng@mediatek.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Roger Lu <roger.lu@mediatek.com>,
        Kevin Hilman <khilman@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        <chun-jen.tseng@mediatek.com>
Subject: [PATCH v4 3/3] soc: mediatek: svs: Add support for voltage bins
Date:   Thu, 21 Sep 2023 13:26:37 +0800
Message-ID: <20230921052637.30444-4-chun-jen.tseng@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230921052637.30444-1-chun-jen.tseng@mediatek.com>
References: <20230921052637.30444-1-chun-jen.tseng@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support voltage bins turn point

Signed-off-by: Mark Tseng <chun-jen.tseng@mediatek.com>
---
 drivers/soc/mediatek/mtk-svs.c | 57 +++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
index d2ae0b0cf95a..f31e3bedff50 100644
--- a/drivers/soc/mediatek/mtk-svs.c
+++ b/drivers/soc/mediatek/mtk-svs.c
@@ -407,6 +407,7 @@ struct svs_platform_data {
  * @dcbdet: svs efuse data
  * @dcmdet: svs efuse data
  * @turn_pt: 2-line turn point tells which opp_volt calculated by high/low bank
+ * @vbin_turn_pt: voltage bin turn point helps know which svsb_volt should be overridden
  * @type: bank type to represent it is 2-line (high/low) bank or 1-line bank
  *
  * Svs bank will generate suitalbe voltages by below general math equation
@@ -469,6 +470,7 @@ struct svs_bank {
 	u32 dcbdet;
 	u32 dcmdet;
 	u32 turn_pt;
+	u32 vbin_turn_pt;
 	u32 type;
 };
 
@@ -751,11 +753,12 @@ static int svs_status_debug_show(struct seq_file *m, void *v)
 
 	ret = thermal_zone_get_temp(svsb->tzd, &tzone_temp);
 	if (ret)
-		seq_printf(m, "%s: temperature ignore, turn_pt = %u\n",
-			   svsb->name, svsb->turn_pt);
+		seq_printf(m, "%s: temperature ignore, vbin_turn_pt = %u, turn_pt = %u\n",
+			   svsb->name, svsb->vbin_turn_pt, svsb->turn_pt);
 	else
-		seq_printf(m, "%s: temperature = %d, turn_pt = %u\n",
-			   svsb->name, tzone_temp, svsb->turn_pt);
+		seq_printf(m, "%s: temperature = %d, vbin_turn_pt = %u, turn_pt = %u\n",
+			   svsb->name, tzone_temp, svsb->vbin_turn_pt,
+			   svsb->turn_pt);
 
 	for (i = 0; i < svsb->opp_count; i++) {
 		opp = dev_pm_opp_find_freq_exact(svsb->opp_dev,
@@ -952,6 +955,29 @@ static void svs_get_bank_volts_v3(struct svs_platform *svsp)
 	for (i = opp_start; i < opp_stop; i++)
 		if (svsb->volt_flags & SVSB_REMOVE_DVTFIXED_VOLT)
 			svsb->volt[i] -= svsb->dvt_fixed;
+
+	/* For voltage bin support */
+	if (svsb->opp_dfreq[0] > svsb->freq_base) {
+		svsb->volt[0] = svs_opp_volt_to_bank_volt(svsb->opp_dvolt[0],
+							  svsb->volt_step,
+							  svsb->volt_base);
+
+		/* Find voltage bin turn point */
+		for (i = 0; i < svsb->opp_count; i++) {
+			if (svsb->opp_dfreq[i] <= svsb->freq_base) {
+				svsb->vbin_turn_pt = i;
+				break;
+			}
+		}
+
+		/* Override svs bank voltages */
+		for (i = 1; i < svsb->vbin_turn_pt; i++)
+			svsb->volt[i] = interpolate(svsb->freq_pct[0],
+						    svsb->freq_pct[svsb->vbin_turn_pt],
+						    svsb->volt[0],
+						    svsb->volt[svsb->vbin_turn_pt],
+						    svsb->freq_pct[i]);
+	}
 }
 
 static void svs_set_bank_freq_pct_v3(struct svs_platform *svsp)
@@ -1069,6 +1095,29 @@ static void svs_get_bank_volts_v2(struct svs_platform *svsp)
 
 	for (i = 0; i < svsb->opp_count; i++)
 		svsb->volt[i] += svsb->volt_od;
+
+	/* For voltage bin support */
+	if (svsb->opp_dfreq[0] > svsb->freq_base) {
+		svsb->volt[0] = svs_opp_volt_to_bank_volt(svsb->opp_dvolt[0],
+							  svsb->volt_step,
+							  svsb->volt_base);
+
+		/* Find voltage bin turn point */
+		for (i = 0; i < svsb->opp_count; i++) {
+			if (svsb->opp_dfreq[i] <= svsb->freq_base) {
+				svsb->vbin_turn_pt = i;
+				break;
+			}
+		}
+
+		/* Override svs bank voltages */
+		for (i = 1; i < svsb->vbin_turn_pt; i++)
+			svsb->volt[i] = interpolate(svsb->freq_pct[0],
+						    svsb->freq_pct[svsb->vbin_turn_pt],
+						    svsb->volt[0],
+						    svsb->volt[svsb->vbin_turn_pt],
+						    svsb->freq_pct[i]);
+	}
 }
 
 static void svs_set_bank_freq_pct_v2(struct svs_platform *svsp)
-- 
2.18.0

