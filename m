Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0BB78F11C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:21:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244285AbjHaQVT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241201AbjHaQVS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:21:18 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514E61BF;
        Thu, 31 Aug 2023 09:21:16 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37VF9jT2009857;
        Thu, 31 Aug 2023 11:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=v
        9izTZHSJz/cxSDw2DvHeuhuoYs2eAtVfEb4uqYV/I4=; b=fiSalqjVfebRZJ+Tm
        4Y0Z9uCpTwuxZWSdLUF3uEPyUklSXV5nm/nYlLNDvWwo1ixEW+ZIren/5YSCdgr4
        oHpTqWB6o2YYTyYeVVQZl7erD8TVxuu8gaPJygdRSU/E8IZDtvYwM0UKorRtD02J
        bOMHG8gLMTBZUjrXUJEyU58PvkegJ/Dg7sSC/kKYMTOI6crPsav1J+dv+V77IfiX
        OOmJjr9NC/dPUtUlwcgVsLRyEM5/AFq61wiCQtMjFZJuQNgWNZHJ/C8abg91fN45
        edVbIATSvDcOQ1406feXEsXjyw+1KuaEYcV4ojE0nfG6JembbwwW9ZaFxISjcP6m
        0P20w==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyep1p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 31 Aug 2023 11:20:56 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Thu, 31 Aug
 2023 17:20:54 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Thu, 31 Aug 2023 17:20:54 +0100
Received: from vkarpovich-ThinkStation-P620.crystal.cirrus.com (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9937111D6;
        Thu, 31 Aug 2023 16:20:52 +0000 (UTC)
From:   Vlad Karpovich <vkarpovi@opensource.cirrus.com>
To:     James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Rob Herring <robh+dt@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        "Ricardo Rivera-Matos" <rriveram@opensource.cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>
Subject: [PATCH v3 1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
Date:   Thu, 31 Aug 2023 11:20:39 -0500
Message-ID: <20230831162042.471801-1-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: sM0T7B4ftU-mp34Q5K-zrbgE_n38BaiR
X-Proofpoint-GUID: sM0T7B4ftU-mp34Q5K-zrbgE_n38BaiR
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>

Checks the index computed by the virq offset before printing the
error condition in cs35l45_spk_safe_err() handler.

Signed-off-by: Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Signed-off-by: Vlad Karpovich <vkarpovi@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l45.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/sound/soc/codecs/cs35l45.c b/sound/soc/codecs/cs35l45.c
index 2ac4612402eb..02b1172d2647 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -1023,7 +1023,10 @@ static irqreturn_t cs35l45_spk_safe_err(int irq, void *data)
 
 	i = irq - regmap_irq_get_virq(cs35l45->irq_data, 0);
 
-	dev_err(cs35l45->dev, "%s condition detected!\n", cs35l45_irqs[i].name);
+	if (i < 0 || i >= ARRAY_SIZE(cs35l45_irqs))
+		dev_err(cs35l45->dev, "Unspecified global error condition (%d) detected!\n", irq);
+	else
+		dev_err(cs35l45->dev, "%s condition detected!\n", cs35l45_irqs[i].name);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

