Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5317E78B5F6
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 19:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232830AbjH1RGp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 13:06:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232760AbjH1RGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 13:06:12 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E8CAC;
        Mon, 28 Aug 2023 10:06:10 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37SF3RKM001527;
        Mon, 28 Aug 2023 12:05:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=1K7XdmDHh0xz7TpE3lzKGlocX1TExBJDy839St96yLs=; b=
        o7lFohVXlz0GE1Ki4Gv+yoxFTtnm884TBuIvGrOxnUmfWtMbD4+Fv3nd2MrJNCUP
        RsWzejBaK8VyGT77JlcIBwUkBxLDV+3VWkhYZOU1Dsz28/7xyVSvS9TpeawfJube
        nJTcEc28DqfSH5HC2Jt45Sy5Mz8/JOtsxTveeyb1NrjGtCeW5ou15vD6xzQJq6aV
        68Z89Ems/hJ0wfuzdUGjOq1+VhcN71wSQP3tzpMuiFaqiNpfkfOyaVoHlD9mkKeY
        kq6FF4mbJTPOBhjWnXAy3aw3dGuaHKDJ3TmZpB0NZ+1pXapfnvZWoM8OBKyic1QQ
        muK4QD3k4Db+9iODWbcRgw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3sqesyae6v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 28 Aug 2023 12:05:47 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Mon, 28 Aug
 2023 18:05:45 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.37 via Frontend Transport; Mon, 28 Aug 2023 18:05:45 +0100
Received: from vkarpovich-ThinkStation-P620.crystal.cirrus.com (vkarpovich-ThinkStation-P620.ad.cirrus.com [141.131.145.49])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9803711D4;
        Mon, 28 Aug 2023 17:05:43 +0000 (UTC)
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
        <RicardoRivera-Matosricardo.rivera-matos@cirrus.com>,
        Vlad Karpovich <vkarpovi@opensource.cirrus.com>,
        Ricardo Rivera-Matos <rriveram@opensource.cirrus.com>
Subject: [PATCH 3/7] ASoC: cs35l45: Checks index of cs35l45_irqs[]
Date:   Mon, 28 Aug 2023 12:05:21 -0500
Message-ID: <20230828170525.335671-3-vkarpovi@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
References: <20230828170525.335671-1-vkarpovi@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: wsLEp0sPU1UosyUbVW3CauHt1Ldlwl7o
X-Proofpoint-GUID: wsLEp0sPU1UosyUbVW3CauHt1Ldlwl7o
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
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
index 40fb64904260..2c9b41171a05 100644
--- a/sound/soc/codecs/cs35l45.c
+++ b/sound/soc/codecs/cs35l45.c
@@ -1023,7 +1023,10 @@ static irqreturn_t cs35l45_spk_safe_err(int irq, void *data)
 
 	i = irq - regmap_irq_get_virq(cs35l45->irq_data, 0);
 
-	dev_err(cs35l45->dev, "%s condition detected!\n", cs35l45_irqs[i].name);
+	if (i < 0 || i > 6)
+		dev_err(cs35l45->dev, "Unspecified global error condition (%d) detected!\n", irq);
+	else
+		dev_err(cs35l45->dev, "%s condition detected!\n", cs35l45_irqs[i].name);
 
 	return IRQ_HANDLED;
 }
-- 
2.25.1

