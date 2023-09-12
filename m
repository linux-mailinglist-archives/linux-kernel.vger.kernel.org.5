Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0CE79D212
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 15:27:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbjILN14 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 09:27:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjILN1y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 09:27:54 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C30610CE
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 06:27:50 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CARhwA022397;
        Tue, 12 Sep 2023 08:27:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=p
        /qu/HO+QWXMZClGw2V6UqRARF88uGiEQkPRhZezuIw=; b=E4VZDDHNOq9yFT0BQ
        IKSGrO6SseUkOvvIZZJkGdrPcNvw79Y7DcMlOueJ0dWq85a2Xp41scQjLW+RqelQ
        zDmwZOGQGdwRXfW3SCh4zpBT3OAaQmbmUwPl3mXhy5hW3vxLX2wlEhpr6JF5ST1r
        WkGgyh+Cncjfr731MbVOCcNkqd9uOCneZ2234m34fJe+j5FwrnYnBNySFx68nUto
        7ma/vzYbEw5JnQk5+0cOiZbFuM8R/+HqC5NWESp1BceVmrt/vD6A8iXq8P+dHtnB
        Wj8zFcn/UJRZc74l5ArGqZv32YcIEJFULknhRV9qWD6ogn30uqx/jlWGSMNxV7Da
        wpSrQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t0p3xkm7r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 12 Sep 2023 08:27:41 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Tue, 12 Sep
 2023 14:27:39 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Tue, 12 Sep 2023 14:27:39 +0100
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.125])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 1EE6C2A1;
        Tue, 12 Sep 2023 13:27:39 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <tiwai@suse.com>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ALSA: hda: cs35l56: Disable low-power hibernation mode
Date:   Tue, 12 Sep 2023 14:27:39 +0100
Message-ID: <20230912132739.3478441-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ibH2zfBop7k4z-d0i_r4D_ZFe2-7TJA2
X-Proofpoint-GUID: ibH2zfBop7k4z-d0i_r4D_ZFe2-7TJA2
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Do not allow the CS35L56 to be put into its lowest power
"hibernation" mode. This only affects I2C because "hibernation"
is already disabled on SPI.

Recent firmwares need a different wake-up sequence. Until
that sequence has been specified, the chip "hibernation" mode
must be disabled otherwise it can intermittently fail to wake.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/pci/hda/cs35l56_hda_i2c.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/sound/pci/hda/cs35l56_hda_i2c.c b/sound/pci/hda/cs35l56_hda_i2c.c
index 83e4acdd89ac..757a4d193e0f 100644
--- a/sound/pci/hda/cs35l56_hda_i2c.c
+++ b/sound/pci/hda/cs35l56_hda_i2c.c
@@ -21,7 +21,6 @@ static int cs35l56_hda_i2c_probe(struct i2c_client *clt)
 		return -ENOMEM;
 
 	cs35l56->base.dev = &clt->dev;
-	cs35l56->base.can_hibernate = true;
 	cs35l56->base.regmap = devm_regmap_init_i2c(clt, &cs35l56_regmap_i2c);
 	if (IS_ERR(cs35l56->base.regmap)) {
 		ret = PTR_ERR(cs35l56->base.regmap);
-- 
2.30.2

