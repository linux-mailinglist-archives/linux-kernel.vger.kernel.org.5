Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A726B79EBE2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240978AbjIMPAm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 11:00:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234329AbjIMPAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 11:00:37 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F6AB3
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 08:00:33 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 38CMxBYs012824;
        Wed, 13 Sep 2023 10:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=Dh+rm8/z+C93/OT9V7lVmPaM5s4LmDAFqoJT9hkB4GU=; b=
        qvciHAJn7z2vKVWeICmAqeZ/0vJ4Tu44gm11e1i5y2Iy3QN9L3Aa0/dSTinHheUw
        ns7jln0/ET8PAgrT6rGUj9ROC4NPQ6HTWVn24N6YqnNuplaKFw+TdToWlUbG9J6z
        4PdDiNBtZXWixvbIBQ0jTQPjoE9SRlF6kCF9XpaUQn9XB6E6NqTCWioojDJurgGL
        vuCqbkX9g9MDH7TpsOZsHrBJmcyxN6X2Xppz5CBun23CFjsDitOlu7nWuWDT4eQB
        hAF/XxYm5szXcdfHhgRRt1W4tU66DBAShSlQdiMaKOK3VxZW+j1NFYqwKMQXfKdu
        ND45i4zVjCZ9bSh/mvnL8A==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3t2y7u125n-2
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
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 21DCB11AA;
        Wed, 13 Sep 2023 15:00:20 +0000 (UTC)
From:   Stefan Binding <sbinding@opensource.cirrus.com>
To:     Mark Brown <broonie@kernel.org>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>
Subject: [PATCH v1 1/3] ASoC: cs42l42: Ensure a reset pulse meets minimum pulse width.
Date:   Wed, 13 Sep 2023 16:00:10 +0100
Message-ID: <20230913150012.604775-2-sbinding@opensource.cirrus.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230913150012.604775-1-sbinding@opensource.cirrus.com>
References: <20230913150012.604775-1-sbinding@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: oQb8ia575QRFzeNOv0q-cj2ulpxtpl8e
X-Proofpoint-ORIG-GUID: oQb8ia575QRFzeNOv0q-cj2ulpxtpl8e
X-Proofpoint-Spam-Reason: safe
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Richard Fitzgerald <rf@opensource.cirrus.com>

The CS42L42 can accept very short reset pulses of a few microseconds
but there's no reason to force a very short pulse.
Allow a wide range for the usleep_range() so it can be relaxed about
the choice of timing source.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Signed-off-by: Stefan Binding <sbinding@opensource.cirrus.com>
---
 sound/soc/codecs/cs42l42.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index a0de0329406a..56d2857a4f01 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2320,6 +2320,10 @@ int cs42l42_common_probe(struct cs42l42_private *cs42l42,
 
 	if (cs42l42->reset_gpio) {
 		dev_dbg(cs42l42->dev, "Found reset GPIO\n");
+
+		/* Ensure minimum reset pulse width */
+		usleep_range(10, 500);
+
 		gpiod_set_value_cansleep(cs42l42->reset_gpio, 1);
 	}
 	usleep_range(CS42L42_BOOT_TIME_US, CS42L42_BOOT_TIME_US * 2);
-- 
2.34.1

