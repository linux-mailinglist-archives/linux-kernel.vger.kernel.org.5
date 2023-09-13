Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D959579EBDC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:00:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238847AbjIMPAi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:00:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233101AbjIMPAg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:00:36 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9FBB3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:00:32 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CMxBYu012824;
        Wed, 13 Sep 2023 10:00:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=PVaReH5xb95hJSWXKB1ZU+tI/szUdn6DXOR932aBpIg=; b=
        ZVX2QHyELoWnF6ZoDjt2cH8BufZ2Dq6Issq3cu3yfcHwBgxgmSPXaPMNAU26Iqjg
        oWq7YHopmwhz01H6B3+OKSbC2yyXrbC4CK4a32u/g+chTsdfbgdJBdv9aCi80sLu
        7zajfAr+fdu/YeJyIwhUYL7/i0kHIetATNUujdUA2PGZv5MpxNTkg8aqQfZm0Wvm
        cm/yRu5zv0bviXs0bgYoIY4wNrAFGOM/wM9hGKMrACERIB8tFUBZH0Q0apudQjs8
        Idst/X2UQm9PH3LLH/aXRp6NHa7cQFOH8t5KXGFInwL6pspOnXxl7nvSV8rA5AxB
        OcG23m7O4rS9NEuSfrjHVQ==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7u125n-3
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 13 Sep 2023 10:00:23 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 13 Sep
 2023 16:00:20 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 13 Sep 2023 16:00:20 +0100
Received: from sbinding-cirrus-dsktp2.ad.cirrus.com (unknown [198.90.238.120])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 6982F15B9;
        Wed, 13 Sep 2023 15:00:20 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 2/3] ASoC: cs42l42: Don't rely on GPIOD_OUT_LOW to set RESET initially low
Date:   Wed, 13 Sep 2023 16:00:11 +0100
Message-ID: <20230913150012.604775-3-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913150012.604775-1-sbinding@opensource.cirrus.com>
References: <20230913150012.604775-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: lca0U4S-IG95BKgtvo7CRGe-1JouNJCD
X-Proofpoint-ORIG-GUID: lca0U4S-IG95BKgtvo7CRGe-1JouNJCD
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

The ACPI setting for a GPIO default state has higher priority than the
flag passed to devm_gpiod_get_optional() so ACPI can override the
GPIOD_OUT_LOW. Explicitly set the GPIO low when hard resetting.

Although GPIOD_OUT_LOW can't be relied on this doesn't seem like a
reason to stop passing it to devm_gpiod_get_optional(). So we still pass
it to state our intent, but can deal with it having no effect.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 56d2857a4f01..dc93861ddfb0 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2321,6 +2321,12 @@ int cs42l42_common_probe(struct cs42l42_private *cs42l42,
 	if (cs42l42->reset_gpio) {
 		dev_dbg(cs42l42->dev, "Found reset GPIO\n");
 
+		/*
+		 * ACPI can override the default GPIO state we requested
+		 * so ensure that we start with RESET low.
+		 */
+		gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
+
 		/* Ensure minimum reset pulse width */
 		usleep_range(10, 500);
 
-- 
2.34.1

