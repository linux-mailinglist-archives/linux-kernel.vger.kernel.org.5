Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E8357745C6
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:46:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjHHSqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232905AbjHHSpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:45:49 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B7BD114C81
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:47:42 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378GfYwG012826;
        Tue, 8 Aug 2023 11:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=7RZLhRQ+381XYUDrqoqfoe0OVQjJKugGtd0GWZHvb+4=; b=
        O/pVAMLEaRntg+Ct3WXnVTbK6hmMBeSwKpZPzyWrb+VqZjQd2GLEul+R7gUkuUFx
        2NiOZEbPJNiwuEqWvbeM1mtSX0ZiQrckGtX7LANoOEZT0hP75Ts6tKOtz+sBHhfq
        3uafn4i2w/ij1Cjcco0BRkkQStBS/+7G2kEGkjPCLcYZkjtvMf9CaWgLnY43R3ZM
        qZ08SVK8+6I9YHXmNleskA1zVS8AZI+W1SqY72D7zGReY17KT84/Su9AMOLW5vLn
        QQoWaV//qC0vgb8KNdKOFxrsNCmGDRyRa6HyRSCpjiqyU+BJvsyCwKe5qsOL2Ys7
        0SgMTt6a5ddVEahHGwFMnQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtucr-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:47:07 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 17:47:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Tue, 8 Aug 2023 17:47:05 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 4E8963575;
        Tue,  8 Aug 2023 16:47:05 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/5] ASoC: cs35l56: Wait for control port ready during system-resume
Date:   Tue, 8 Aug 2023 17:47:00 +0100
Message-ID: <20230808164702.21272-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808164702.21272-1-rf@opensource.cirrus.com>
References: <20230808164702.21272-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: XHuMFLKBPZboRX8wriv0npaa4Urk6y63
X-Proofpoint-ORIG-GUID: XHuMFLKBPZboRX8wriv0npaa4Urk6y63
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The CS35L56 could be hard-reset during a system suspend-resume cycle,
either by the codec driver, in cs35l56_system_resume_early(), or by ACPI.
After a hard reset the driver must wait for the control port to be ready
(datasheet tIRS time) before attempting to access the CS35L56.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 9560059c867b..094bcbd0a174 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -952,6 +952,12 @@ int cs35l56_system_resume(struct device *dev)
 
 	dev_dbg(dev, "system_resume\n");
 
+	/*
+	 * We might have done a hard reset or the CS35L56 was power-cycled
+	 * so wait for control port to be ready.
+	 */
+	cs35l56_wait_control_port_ready();
+
 	/* Undo pm_runtime_force_suspend() before re-enabling the irq */
 	ret = pm_runtime_force_resume(dev);
 	if (cs35l56->base.irq)
-- 
2.30.2

