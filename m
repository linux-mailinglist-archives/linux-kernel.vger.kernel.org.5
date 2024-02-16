Return-Path: <linux-kernel+bounces-68426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3017C857A10
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:13:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6F2D285264
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E0621CAAD;
	Fri, 16 Feb 2024 10:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="cCCU8feS"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B599F1CAAC
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708078387; cv=none; b=RzoB0+JUfs+8v9sWGsUjfqFStUXolqJ13eIQTrEgq8Il+Yj17TNOWBn6dR4hMo1unR7RIWG58WQzW2rr++huP1d0Yqj64kPqHflNJsc+nPXcrTlMaA/5ybt7/ylsCJVhdXv6gtLzeOrz8a1JT+THbUxcUEHFze4C1iLysyLPZqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708078387; c=relaxed/simple;
	bh=ddSHJRLWu0hndL+TKATWxu/fkQ5Cgt2wZVl4XXmBDmc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=jIeGs3dObUk7YcxjBzz6eT4FbE2YTVGELde+nCofyDkOqv4gn+vJDV+2oMF/WUR3qZODlbSdDb0whWpMqqq+9UsSX4hI7cdajuiDgyu8pWo0/rEsm+o/TKDWb5MjauV6Ob4pGwf1Rrkod8jSFFidXialFTGvQwpdOX8LoOUQdIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=cCCU8feS; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G7jo54008245;
	Fri, 16 Feb 2024 04:12:35 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=y
	Bl3sKU+2L8E6Xmqeuy6j40kaWR7Rwcru9wjT8+Wxww=; b=cCCU8feS682LwGXVU
	IhIxI/WXeHUTfJbWYlekatdSIv9LSdHNPSjZaPs5IouL3/mrjG71XQXkplkPcC+t
	IkgXebFAcKHC3cVmRZh3fUvEcHMV4rAajVR95R7HBJhUAoX1g3kjDba1blEy1Njk
	At5AJffR2hPIdDB7cW6NMPVQAqmNcDDY9xOYP7mfdJ14TJ6a8dVHqwkKtCX+7ood
	4oLP9d78pfl0fBFKgo2bBA80DrvHRYiN9aDNwhruDg0dCzZ0dr7c6Bd7XwDoNuqy
	GAuaNuQFN4NmuUsiIGCXA2Y9NcyFFsL/WWc+0lQQF7V830IHhpiUpXvFTrWhOup2
	3KwVw==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3w67e26w8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 04:12:34 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Fri, 16 Feb
 2024 10:12:32 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Fri, 16 Feb 2024 10:12:32 +0000
Received: from lon-bigdaddy.ad.cirrus.com (unknown [198.61.65.28])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 4C923820242;
	Fri, 16 Feb 2024 10:12:32 +0000 (UTC)
From: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
To: Mark Brown <broonie@kernel.org>
CC: Jaroslav Kysela <perex@perex.cz>, <alsa-devel@alsa-project.org>,
        <patches@opensource.cirrus.com>, <linux-kernel@vger.kernel.org>,
        "Vitaly
 Rodionov" <vitalyr@opensource.cirrus.com>
Subject: [PATCH] ASoC: cs42l42: Remove redundant delays in suspend().
Date: Fri, 16 Feb 2024 10:11:57 +0000
Message-ID: <20240216101157.23176-1-vitalyr@opensource.cirrus.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: SPHtKxswNvwdYnim-ycZigmdJQrTo97J
X-Proofpoint-GUID: SPHtKxswNvwdYnim-ycZigmdJQrTo97J
X-Proofpoint-Spam-Reason: safe

This patch will remove redundant delay and minimise
total suspend() function call time.

Signed-off-by: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
---
 include/sound/cs42l42.h    | 5 ++---
 sound/soc/codecs/cs42l42.c | 1 -
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/include/sound/cs42l42.h b/include/sound/cs42l42.h
index 3994e933db19..1bd8eee54f66 100644
--- a/include/sound/cs42l42.h
+++ b/include/sound/cs42l42.h
@@ -809,8 +809,7 @@
 #define CS42L42_PLL_LOCK_TIMEOUT_US	1250
 #define CS42L42_HP_ADC_EN_TIME_US	20000
 #define CS42L42_PDN_DONE_POLL_US	1000
-#define CS42L42_PDN_DONE_TIMEOUT_US	200000
-#define CS42L42_PDN_DONE_TIME_MS	100
-#define CS42L42_FILT_DISCHARGE_TIME_MS	46
+#define CS42L42_PDN_DONE_TIMEOUT_US	235000
+#define CS42L42_PDN_DONE_TIME_MS	65
 
 #endif /* __CS42L42_H */
diff --git a/sound/soc/codecs/cs42l42.c b/sound/soc/codecs/cs42l42.c
index 2d11c5125f73..60d366e53526 100644
--- a/sound/soc/codecs/cs42l42.c
+++ b/sound/soc/codecs/cs42l42.c
@@ -2195,7 +2195,6 @@ int cs42l42_suspend(struct device *dev)
 	/* Discharge FILT+ */
 	regmap_update_bits(cs42l42->regmap, CS42L42_PWR_CTL2,
 			   CS42L42_DISCHARGE_FILT_MASK, CS42L42_DISCHARGE_FILT_MASK);
-	msleep(CS42L42_FILT_DISCHARGE_TIME_MS);
 
 	regcache_cache_only(cs42l42->regmap, true);
 	gpiod_set_value_cansleep(cs42l42->reset_gpio, 0);
-- 
2.40.1


