Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF99D77F37B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:34:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349676AbjHQJeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349709AbjHQJdj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:33:39 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DE410E9
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:33:38 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 37H9X7lX034365;
        Thu, 17 Aug 2023 04:33:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1692264787;
        bh=d2bi7xNYpv55A4isbPGmzxy/NzcyeROLai+rcJ2ZKQU=;
        h=From:To:CC:Subject:Date;
        b=gsir96fWlC7tKz09rwUFsctiJKcq+OXRF6eckgPOlyIn4sxwHt1ptHGwWEczLvmGR
         8ajcu98YP/s5LI637inxJ0RAvWZCOA56u1vnS5C3DvUCpLLI+NqILDgI9TsnvhAN96
         KHgc2pYmT3kVvyj/xi6YkrSXj6oXUhstiOrJ7at4=
Received: from DFLE101.ent.ti.com (dfle101.ent.ti.com [10.64.6.22])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 37H9X71I047196
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 17 Aug 2023 04:33:07 -0500
Received: from DFLE100.ent.ti.com (10.64.6.21) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 17
 Aug 2023 04:33:07 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE100.ent.ti.com
 (10.64.6.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 17 Aug 2023 04:33:07 -0500
Received: from LT5CG31242FY.dhcp.ti.com (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 37H9X0gY101760;
        Thu, 17 Aug 2023 04:33:01 -0500
From:   Shenghao Ding <shenghao-ding@ti.com>
To:     <broonie@kernel.org>, <robh+dt@kernel.org>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>
CC:     <kevin-lu@ti.com>, <13916275206@139.com>,
        <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <liam.r.girdwood@intel.com>, <mengdong.lin@intel.com>,
        <baojun.xu@ti.com>, <thomas.gfeller@q-drop.com>, <peeyush@ti.com>,
        <navada@ti.com>, <tiwai@suse.de>, <gentuser@gmail.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoC: tas2781: fixed register access error when switching to other chips
Date:   Thu, 17 Aug 2023 17:32:56 +0800
Message-ID: <20230817093257.951-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fixed register access error when switching to other tas2781 -- refresh the page
inside regmap on the switched tas2781

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>

---
Changes in v1:
 - fixed register access error when switching to other tas2781
---
 sound/soc/codecs/tas2781-comlib.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/sound/soc/codecs/tas2781-comlib.c b/sound/soc/codecs/tas2781-comlib.c
index a88c6c28a394..ffb26e4a7e2f 100644
--- a/sound/soc/codecs/tas2781-comlib.c
+++ b/sound/soc/codecs/tas2781-comlib.c
@@ -57,16 +57,17 @@ static int tasdevice_change_chn_book(struct tasdevice_priv *tas_priv,
 
 		if (client->addr != tasdev->dev_addr) {
 			client->addr = tasdev->dev_addr;
-			if (tasdev->cur_book == book) {
-				ret = regmap_write(map,
-					TASDEVICE_PAGE_SELECT, 0);
-				if (ret < 0) {
-					dev_err(tas_priv->dev, "%s, E=%d\n",
-						__func__, ret);
-					goto out;
-				}
+			/* All tas2781s share the same regmap, clear the page
+			 * inside regmap once switching to another tas2781.
+			 * Register 0 at any pages and any books inside tas2781
+			 * is the same one for page-switching.
+			 */
+			ret = regmap_write(map, TASDEVICE_PAGE_SELECT, 0);
+			if (ret < 0) {
+				dev_err(tas_priv->dev, "%s, E=%d\n",
+					__func__, ret);
+				goto out;
 			}
-			goto out;
 		}
 
 		if (tasdev->cur_book != book) {
-- 
2.34.1

