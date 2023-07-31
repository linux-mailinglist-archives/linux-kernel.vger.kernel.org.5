Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A629769D6E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 18:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233782AbjGaQ6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 12:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbjGaQ6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 12:58:19 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915581986
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 09:57:45 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 36V5lNJK017071;
        Mon, 31 Jul 2023 11:57:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=COsUQaN/ErqOVMioTgwxTBAOGWPa/9gsBLSsEI2cT2A=; b=
        A9dafwKHWVwmWHxQyv/TdC6e8R+dzdJDt49STc7fSw2q/XQXVO0ECaFOx4SKySmm
        M1yozutFbDSUsLi9XxSsTGBvnctBmNoS9i3aBGhjjRsGQ3BSxDqtE6ixaZ37cBAN
        lk5Rdy+kXQVor6332GqARJiJ0fVEoWs8oxoDmYcG+t9GnvP9Yw3R3n9DICqS5cIZ
        H2NY3jgc5JRe89waXHeUuEWjbvpkqBelva0rC2bw2AtQqnKURdsyZnDg0PCz4Z4l
        fyPgn3AbVSYFgzIH11p7ew+bnrCKEsGFyNGLUvptymCEFjAqebh+pTcqD9G6d+cr
        OQ95okiKLwocbSmCvdLisQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3s5gk1sg45-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jul 2023 11:57:33 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Mon, 31 Jul
 2023 17:57:30 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Mon, 31 Jul 2023 17:57:30 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.107])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 55A3D45D;
        Mon, 31 Jul 2023 16:57:30 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/9] ALSA: hda/cs35l56: Do not mark cache dirty after REINIT
Date:   Mon, 31 Jul 2023 17:57:19 +0100
Message-ID: <20230731165726.7940-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230731165726.7940-1-rf@opensource.cirrus.com>
References: <20230731165726.7940-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: kFB1f_oNiNMpBEAsCAcGXST23BTvhCOS
X-Proofpoint-ORIG-GUID: kFB1f_oNiNMpBEAsCAcGXST23BTvhCOS
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Only call regcache_mark_dirty() in cs35l56_hda_fw_load() if
the CS35L56 was SYSTEM_RESET.

recache_mark_dirty() changes the behaviour of regcache_sync()
to write out cache values that are not the default value, and
skip cache values that are the default.

AUDIO_REINIT does not reset the registers. regcache_mark_dirty()
after AUDIO_REINIT could cause the regcache_sync() to sync
registers incorrectly because it will assume that all registers
have reset to default.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/cs35l56_hda.c b/sound/pci/hda/cs35l56_hda.c
index c3acda2daeeb..fda716e0db09 100644
--- a/sound/pci/hda/cs35l56_hda.c
+++ b/sound/pci/hda/cs35l56_hda.c
@@ -569,6 +569,7 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	} else {
 		/* Reset the device and wait for it to boot */
 		cs35l56_system_reset(&cs35l56->base, false);
+		regcache_mark_dirty(cs35l56->base.regmap);
 		ret = cs35l56_wait_for_firmware_boot(&cs35l56->base);
 		if (ret)
 			goto err;
@@ -579,7 +580,6 @@ static int cs35l56_hda_fw_load(struct cs35l56_hda *cs35l56)
 	if (ret)
 		goto err;
 
-	regcache_mark_dirty(cs35l56->base.regmap);
 	regcache_sync(cs35l56->base.regmap);
 
 	regmap_clear_bits(cs35l56->base.regmap, CS35L56_PROTECTION_STATUS,
-- 
2.30.2

