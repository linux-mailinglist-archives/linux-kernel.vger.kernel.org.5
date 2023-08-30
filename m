Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA47B78E12D
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 23:09:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240259AbjH3VJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 17:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231879AbjH3VJU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 17:09:20 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A7E0CE7;
        Wed, 30 Aug 2023 14:08:48 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37UHsI8m024465;
        Wed, 30 Aug 2023 14:56:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=8
        fD74OlzXGZqtv4t5a4iQJ3l7Jbn7phXIoroy2WVeQM=; b=jaEznPhAaIOi00W2l
        2q8g3AmqqX/rzhcpNp+E8C9vgwphSGRnu+KDeL04pJnubnzmjFUA9KIAxajr+bBo
        gxJQX+kFdRF//3Lk2SXs27lx5llSfzLN6pP6+sK+ifIHW/36m5EBZGrQdCzxXtg0
        6CmdYzRYaPUJ/1RG31IQraw0+lZD2qNRxPe3HK7xpTDsdbArZeKRNhD1x3RyZw3e
        5M5Nsz3IzEZ58EPHUZtXVd8h7KYFsHo2iLkCjPGx+J1qmNT+PKGBDXygz50wYkGr
        34EQ7vqxYN1J38PSYsDItn/sVbSe/wmk7llmD2hUxjev9GX2YfyVlovm1KewEzov
        A3uRQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesydet6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 30 Aug 2023 14:56:03 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 30 Aug
 2023 20:56:00 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Wed, 30 Aug 2023 20:56:00 +0100
Received: from vkarpovich-ThinkStation-P620.crystal.cirrus.com (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AB4D93563;
        Wed, 30 Aug 2023 19:55:58 +0000 (UTC)
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
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH v2 1/4] ASoC: cs35l45: Checks index of cs35l45_irqs[]
Date:   Wed, 30 Aug 2023 14:55:33 -0500
Message-ID: <20230830195536.448884-1-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: -D_7bmSqULdL-eadz0hEzmvvZ8ewAy6M
X-Proofpoint-GUID: -D_7bmSqULdL-eadz0hEzmvvZ8ewAy6M
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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

