Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED29477CCEA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237289AbjHOMtG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:49:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237310AbjHOMsu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:48:50 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7FD1BE5
        for <linux-kernel@vger.kernel.org>; Tue, 15 Aug 2023 05:48:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37FC59WG010995;
        Tue, 15 Aug 2023 07:48:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=7cFx1ctLJ56NlPPqEsUOtWiqLtYmd8Fn1JuskYJ9KW8=; b=
        VJsqiNUXm8I+Q34IiPjo7JVgRke65CZnvS3oSoldbb/YZiLu6I0EPvIommTiMhEU
        QOusKe186ApqjdNMXXmGj8OgwjjmJRJn/wZ6wonPyUH/L0m0Mwf/vEEWulqd58d5
        WevD8LrtZgexWKDgYYw9nNeYaRCsD9mEUuVRvEMj6lbQVYQmlBdQcZm3tf2xbRuB
        bUlBgHo4ZWAyI+x/dTrwbmsJtgItWPwNFqRHmxMi8LlF9VuM2BSWdqbj8jIiC2vu
        KHivnV1Ysa/FsDhMMaUrE7himOv7kwCaZmx+vLjwi4N59PrPj42so2sO5vwmZCy+
        wn+dpptUN3O8rij1WJigng==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhjxk4-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 15 Aug 2023 07:48:31 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 15 Aug
 2023 13:48:29 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 15 Aug 2023 13:48:29 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id A9BD215B4;
        Tue, 15 Aug 2023 12:48:29 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/2] ASoC: cs35l56: Don't overwrite a patched firmware
Date:   Tue, 15 Aug 2023 13:48:26 +0100
Message-ID: <20230815124826.5447-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230815124826.5447-1-rf@opensource.cirrus.com>
References: <20230815124826.5447-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: zcxfjfH8LkAVNrQA1ohl-2m3-2gfwBEB
X-Proofpoint-ORIG-GUID: zcxfjfH8LkAVNrQA1ohl-2m3-2gfwBEB
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only attempt to download wmfw/bin files to a non-secured part if
it reports FIRMWARE_MISSING. If FIRMWARE_MISSING is false the
firmware has already been patched and overwriting the patch could
corrupt the running firmware.

For a secured part the wmfw/bin can be downloaded even if
FIRMWARE_MISSING is false, because they will only patch tunings.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 98cfcae554af..3a9ec8724cc1 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -665,8 +665,17 @@ static void cs35l56_secure_patch(struct cs35l56_private *cs35l56)
 
 static void cs35l56_patch(struct cs35l56_private *cs35l56)
 {
+	unsigned int firmware_missing;
 	int ret;
 
+	ret = regmap_read(cs35l56->base.regmap, CS35L56_PROTECTION_STATUS, &firmware_missing);
+	if (ret) {
+		dev_err(cs35l56->base.dev, "Failed to read PROTECTION_STATUS: %d\n", ret);
+		return;
+	}
+
+	firmware_missing &= CS35L56_FIRMWARE_MISSING;
+
 	/*
 	 * Disable SoundWire interrupts to prevent race with IRQ work.
 	 * Setting sdw_irq_no_unmask prevents the handler re-enabling
@@ -685,8 +694,12 @@ static void cs35l56_patch(struct cs35l56_private *cs35l56)
 	if (ret)
 		goto err;
 
-	/* Use wm_adsp to load and apply the firmware patch and coefficient files */
-	ret = wm_adsp_power_up(&cs35l56->dsp, true);
+	/*
+	 * Use wm_adsp to load and apply the firmware patch and coefficient files,
+	 * but only if firmware is missing. If firmware is already patched just
+	 * power-up wm_adsp without downloading firmware.
+	 */
+	ret = wm_adsp_power_up(&cs35l56->dsp, !!firmware_missing);
 	if (ret) {
 		dev_dbg(cs35l56->base.dev, "%s: wm_adsp_power_up ret %d\n", __func__, ret);
 		goto err;
-- 
2.30.2

