Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 930307A08A8
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 17:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240774AbjINPJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 11:09:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232858AbjINPJd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 11:09:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E632E1AE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 08:09:29 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38ECunMK020490;
        Thu, 14 Sep 2023 10:09:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=9/Xe635LD6iDoA7xW4TH+xL5WC3QyAf+GAeZOp4sAUk=; b=
        emzWWtAOakqSAJyaWRSZd69Koh67MWyLOxzsSBqGBb0y0XSJM7GyHA0Zjw8ljqDQ
        A5mTx3tbnEZkn7YoCLT7o3cPdQD9S3YA19wIvdxV6lJKglVBi9xGkCWcIMvcgV0Y
        7A5nEEE2Ei2q7Axso7h+PYyLlfUQEk1zO1WqQlvmATL4j0qfzkiHhgCmDfQl9HeO
        SBg2553sWt6N/n7MbpwbsKhKqUZiT3MWCL/eY1vudsA8btOVpnv/vHbBib5RLiUm
        GgPMM2hJ9TmckOkOBYzCZ9+EsRR7j11ljLDJaosQkeUtrmWK71i1iiHsOEyGwBmv
        uoA1SZiW3AYRsYOn9OmiTw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7sj90x-4
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Sep 2023 10:09:23 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 14 Sep
 2023 16:09:21 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 14 Sep 2023 16:09:21 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.215])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id D72A7357D;
        Thu, 14 Sep 2023 15:09:20 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 3/3] ASoC: cs35l56: Omit cs35l56_pm_ops_i2c_spi if I2C/SPI not enabled
Date:   Thu, 14 Sep 2023 16:09:18 +0100
Message-ID: <20230914150918.14505-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230914150918.14505-1-rf@opensource.cirrus.com>
References: <20230914150918.14505-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 1pbGrrcizE69K0dpA49EEzUOomu1jFEx
X-Proofpoint-ORIG-GUID: 1pbGrrcizE69K0dpA49EEzUOomu1jFEx
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The cs35l56_pm_ops_i2c_spi struct is only needed if either the
I2C or SPI modules are selected for building. Otherwise it would
be unused bytes, so in that case omit it.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index b7d3f768635b..232af4e8faa4 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1229,12 +1229,14 @@ void cs35l56_remove(struct cs35l56_private *cs35l56)
 }
 EXPORT_SYMBOL_NS_GPL(cs35l56_remove, SND_SOC_CS35L56_CORE);
 
+#if IS_ENABLED(CONFIG_SND_SOC_CS35L56_I2C) || IS_ENABLED(CONFIG_SND_SOC_CS35L56_SPI)
 EXPORT_NS_GPL_DEV_PM_OPS(cs35l56_pm_ops_i2c_spi, SND_SOC_CS35L56_CORE) = {
 	SET_RUNTIME_PM_OPS(cs35l56_runtime_suspend_i2c_spi, cs35l56_runtime_resume_i2c_spi, NULL)
 	SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend, cs35l56_system_resume)
 	LATE_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_late, cs35l56_system_resume_early)
 	NOIRQ_SYSTEM_SLEEP_PM_OPS(cs35l56_system_suspend_no_irq, cs35l56_system_resume_no_irq)
 };
+#endif
 
 MODULE_DESCRIPTION("ASoC CS35L56 driver");
 MODULE_IMPORT_NS(SND_SOC_CS35L56_SHARED);
-- 
2.30.2

