Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09CB5807476
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 17:04:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442632AbjLFQEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 11:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442545AbjLFQD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 11:03:57 -0500
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1358FD46
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 08:03:56 -0800 (PST)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B6AvD2j025625;
        Wed, 6 Dec 2023 10:03:27 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=0fxSxG4+teDLsjntgKgN17KmimgUY2wX58MvQrY/vYo=; b=
        Ik98qTrsUihTasSXfYMET94Gk9cJqUSlwX2h1QIqWQg8kOTixbCOaymTUAh+h6vQ
        zPMc2tKfD4ZbFoVsMuikq00fMI8rXZ0RAie4z6hmj0bwCOzc4ZBNTq+DKLtjiSaq
        l9GdfpsnAj4uEkqSJYg3h7oiwDKk2OCs5c3cVlbvbR4riSx/7E0fzgnzuo/hxgNS
        iFJUP7Of5q8TB6YpJ4A7uuoMuGcgL84qUVkyaon8g1PZykYGsBTzMIgnUIS/1zyt
        ouokjDteX6/dYpGqEfdKLVz1/4DHzkN85KwlfwEcyC7rPraFWMjOi2Ld1/U6XIEz
        x+ITm72gJ1Iaxb7M6kluwA==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3utd47rww7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 Dec 2023 10:03:26 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 16:03:24 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.40 via Frontend
 Transport; Wed, 6 Dec 2023 16:03:24 +0000
Received: from ricardo-lws.crystal.cirrus.com (ricardo-lws.ad.cirrus.com [141.131.145.40])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 009B611AB;
        Wed,  6 Dec 2023 16:03:22 +0000 (UTC)
From:   Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
CC:     Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/3] ASoC: cs35l45: Prevent IRQ handling when suspending/resuming
Date:   Wed, 6 Dec 2023 10:03:17 -0600
Message-ID: <20231206160318.1255034-3-rriveram@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231206160318.1255034-1-rriveram@opensource.cirrus.com>
References: <20231206160318.1255034-1-rriveram@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: NbkZp4JFc9ISGo9U6WJCQgj5DOK-Ke2B
X-Proofpoint-ORIG-GUID: NbkZp4JFc9ISGo9U6WJCQgj5DOK-Ke2B
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the SYSTEM_SLEEP_PM_OPS handlers to prevent handling an IRQ
when the system is in the middle of suspending or resuming.

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45.c | 43 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 43 insertions(+)

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index 4f4df166f5f0..28f76fccf277 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -1026,6 +1026,46 @@ static int cs35l45_runtime_resume(struct device *dev)
 	return ret;
 }
 
+static int cs35l45_sys_suspend(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "System suspend, disabling IRQ\n");
+	disable_irq(cs35l45->irq);
+
+	return 0;
+}
+
+static int cs35l45_sys_suspend_noirq(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "Late system suspend, reenabling IRQ\n");
+	enable_irq(cs35l45->irq);
+
+	return 0;
+}
+
+static int cs35l45_sys_resume_noirq(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "Early system resume, disabling IRQ\n");
+	disable_irq(cs35l45->irq);
+
+	return 0;
+}
+
+static int cs35l45_sys_resume(struct device *dev)
+{
+	struct cs35l45_private *cs35l45 = dev_get_drvdata(dev);
+
+	dev_dbg(cs35l45->dev, "System resume, reenabling IRQ\n");
+	enable_irq(cs35l45->irq);
+
+	return 0;
+}
+
 static int cs35l45_apply_property_config(struct cs35l45_private *cs35l45)
 {
 	struct device_node *node = cs35l45->dev->of_node;
@@ -1468,6 +1508,9 @@ EXPORT_SYMBOL_NS_GPL(cs35l45_remove, SND_SOC_CS35L45);
 
 EXPORT_GPL_DEV_PM_OPS(cs35l45_pm_ops) = {
 	RUNTIME_PM_OPS(cs35l45_runtime_suspend, cs35l45_runtime_resume, NULL)
+
+	SYSTEM_SLEEP_PM_OPS(cs35l45_sys_suspend, cs35l45_sys_resume)
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs35l45_sys_suspend_noirq, cs35l45_sys_resume_noirq)
 };
 
 MODULE_DESCRIPTION("ASoC CS35L45 driver");
-- 
2.34.1

