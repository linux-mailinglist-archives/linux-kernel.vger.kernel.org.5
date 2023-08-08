Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DACA77482A
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236138AbjHHT15 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:27:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236116AbjHHT1l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:27:41 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E01474AFA
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:19:45 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 378GfYwF012826;
        Tue, 8 Aug 2023 11:47:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=AuMoPk2SddtMqxj2LNmox9QFPh23Jlu82ndLix93u4E=; b=
        NgvX80+c/S3jRDKQoq6/Tl6nnBWUNJTjjr1K9/iNKeMNkkkmjtGDpevVnEXj9d9Z
        OaxEI8uh7N79xrF0Qj32phy0DgEr1O/bbtPnWBnqwX/GL2pCblCLYiaNWTEZK4ui
        xwnIViwTgSsxbGEkDDaqgz8H2xJMTrGsPu6WEUGdvXACPOBg9cmeqqel8Z4EdmGq
        p2ZvTZ1KLF6qSql5NYIOIV53wt7ltBqu7w2ZDU2YzH58uaUfJmXfnZ8jfTFYZHON
        0WRiwcnmHMU4De2Pi+0MncwwTsOcXBlrTDcIyu0WACX1H6OGbPMO10VT2lIjzVNO
        C9/ODoE5Z15I55dNaDB//g==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3s9juhtucr-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 11:47:07 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Tue, 8 Aug
 2023 17:47:05 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Tue, 8 Aug 2023 17:47:05 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.220])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id F32E43563;
        Tue,  8 Aug 2023 16:47:04 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 2/5] ASoC: cs35l56: Don't rely on GPIOD_OUT_LOW to set RESET initially low
Date:   Tue, 8 Aug 2023 17:46:59 +0100
Message-ID: <20230808164702.21272-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230808164702.21272-1-rf@opensource.cirrus.com>
References: <20230808164702.21272-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: VpSh-Y7tixG6CeifcVqE4kD-QZaxSsK7
X-Proofpoint-ORIG-GUID: VpSh-Y7tixG6CeifcVqE4kD-QZaxSsK7
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The ACPI setting for a GPIO default state has higher priority than the
flag passed to devm_gpiod_get_optional() so ACPI can override the
GPIOD_OUT_LOW. Explicitly set the GPIO low when hard resetting.

Although GPIOD_OUT_LOW can't be relied on this doesn't seem like a
reason to stop passing it to devm_gpiod_get_optional(). So we still pass
it to state our intent, but can deal with it having no effect.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index be400208205a..9560059c867b 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -1069,6 +1069,8 @@ int cs35l56_common_probe(struct cs35l56_private *cs35l56)
 		return dev_err_probe(cs35l56->base.dev, ret, "Failed to enable supplies\n");
 
 	if (cs35l56->base.reset_gpio) {
+		/* ACPI can override GPIOD_OUT_LOW flag so force it to start low */
+		gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 0);
 		cs35l56_wait_min_reset_pulse();
 		gpiod_set_value_cansleep(cs35l56->base.reset_gpio, 1);
 	}
-- 
2.30.2

