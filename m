Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD6987A08A9
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240749AbjINPJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240408AbjINPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:09:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4BAA8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:09:29 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38ECunMJ020490;
        Thu, 14 Sep 2023 10:09:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=qpNWS38UajD69TK6qtKglrFD9kQLiHSe+aaHNyCngyY=; b=
        L2RkqCAOJmW0NWKZsdwiBtMYAc8va7+WcNOJUnG+uzvt70HIzX+cw60yLx+DAM4d
        5UlVQYwW/vfOjp7p18pBBfj+Ni+kNFoNrGf60LT8Oh6Y7Y2vTQTFPq5wMYskNUfl
        syvRwXyn5AVg1UFemhFMG6uRukX4lnrlJ14MAj/4XJ0OyYGIMKILiekDVkeNBxD1
        pFucMF1QGY7tGSqHaX8lTQcHX6wW+xP0Xpm5XSxZ51jrMTqq2yAwAu5hJkG9Tk9o
        E7LoiR8qFZddlkgW3Gr4me18CzUP1CqehnPddRy9u/bwRGmcJykATIZpemHOWssV
        aKwOawRS/pQzrN1eL8pdkA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7sj90x-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:09:23 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 14 Sep
 2023 16:09:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Thu, 14 Sep 2023 16:09:20 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.215])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 8B6F63575;
        Thu, 14 Sep 2023 15:09:20 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/3] ASoC: cs35l56: Use new export macro for dev_pm_ops
Date:   Thu, 14 Sep 2023 16:09:17 +0100
Message-ID: <20230914150918.14505-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914150918.14505-1-rf@opensource.cirrus.com>
References: <20230914150918.14505-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: ROicgJ398I1eI0b7bPfdXemKNiuoBRtq
X-Proofpoint-ORIG-GUID: ROicgJ398I1eI0b7bPfdXemKNiuoBRtq
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

pm.h now has macros to create and export the dev_pm_ops struct
only if CONFIG_PM is enabled.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index e6e366333a47..b7d3f768635b 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1229,13 +1229,12 @@ void cs35l56_remove(struct cs35l56_private *cs35l56)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_remove, SND_SOC_CS35L56_CORE);
 
-const struct dev_pm_ops cs35l56_pm_ops_i2c_spi = {
+EXPORT_NS_GPL_DEV_PM_OPS(cs35l56_pm_ops_i2c_spi, SND_SOC_CS35L56_CORE) = {
 	SET_RUNTIME_PM_OPS(cs35l56_runtime_suspend_i2c_spi, cs35l56_runtime_resume_i2c_spi, NULL)
 	SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend, cs35l56_system_resume)
 	LATE_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_late, cs35l56_system_resume_early)
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_no_irq, cs35l56_system_resume_no_irq)
 };
-EXPORT_SYMBOL_NS_GPL(cs35l56_pm_ops_i2c_spi, SND_SOC_CS35L56_CORE);
 
 MODULE_DESCRIPTION("ASoC CS35L56 driver");
 MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
-- 
2.30.2

