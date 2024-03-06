Return-Path: <linux-kernel+bounces-94242-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A9B96873BDD
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:15:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 668DB284C85
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7871B137930;
	Wed,  6 Mar 2024 16:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="WRxLoTK3"
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F18E1361CF;
	Wed,  6 Mar 2024 16:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741716; cv=none; b=kSJdWCN1vh20OJM/YczvyXTymBnnGOR9OkKK0lyNMAsksE4okC3P+RquvCdoP1JfTXPlnOErJQt7/PQob9Qkh+vi0Al+Xz2KGXpRquGE9HRxEIuNR0h/EeKVx8F3F72EcygTir0S+fCefoMbhVj8TzL7BsLIutxYmuMVAldDQyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741716; c=relaxed/simple;
	bh=NL/0kJLMNB3af/nPrZVGA4zsieNtor+zdkiPluqcrOw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kyo8kvWkze1F0XgkgBar4mAQ4AevLmrBl7IBsMYvv/v4QHHVz/CXwPOvR4SNUYTgcQjXBeonzfDkNvW0a0/RS8s6nlNMYf79M7ONrIwP8efu3quqZoboc71QkE/kBQS3bIIFQ5ICXxeRSY47s6W3xzDixpK158lwmkOoj9N+OTg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=WRxLoTK3; arc=none smtp.client-ip=67.231.149.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
	by mx0a-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4265UZQk010435;
	Wed, 6 Mar 2024 10:15:08 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=VZNrVFRkfXL9w5uIYi/FRwxU+dWrhc/p57PfZFvalls=; b=
	WRxLoTK3l9ZH4Y7a6CbeC65EN2kWfgDWIcKEW6+y020QvLT7GRYPUFUSme9nDEKH
	nBBs9inOwKpGCm5Sc6CFVq6xX01GJYesK56CGjb4kvQ+t8HHsqpuA7+eRlN2TMeF
	NdjqrSZQK3Sx50M0gBK1/902hf+AhiUXH9xPmHryZe46N6/EQoLu0ATKhu8+HZrt
	rIfzqDESazRjC18IOLhN2B97Pc9bzZ3Zw2UPchcXCzKZ1ww7sn9zAAn6m6wu+rQr
	53OOan5DC7EMuXLy8+zNBtOK67ohdPAd6w56owdnq4nLlWEra15HEni6gSQIXHa3
	tmzMm28SY+VqGCQbOyyffQ==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3wm2d2mwg1-3
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:15:08 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Mar 2024
 16:15:08 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Wed, 6 Mar 2024 16:15:08 +0000
Received: from ediswws08.ad.cirrus.com (ediswws08.ad.cirrus.com [198.90.208.13])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id EB68082024D;
	Wed,  6 Mar 2024 16:15:07 +0000 (UTC)
From: Stuart Henderson <stuarth@opensource.cirrus.com>
To: <broonie@kernel.org>, <shengjiu.wang@gmail.com>, <Xiubo.Lee@gmail.com>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        "Stuart
 Henderson" <stuarth@opensource.cirrus.com>
Subject: [PATCH 4/5] ASoC: wm8962: Fix wm8962_set_fll to use source instead of fll_id
Date: Wed, 6 Mar 2024 16:14:38 +0000
Message-ID: <20240306161439.1385643-4-stuarth@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
References: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: fpMeca3XnbrZ1u6BZ8CozMD4xQPnsanN
X-Proofpoint-GUID: fpMeca3XnbrZ1u6BZ8CozMD4xQPnsanN
X-Proofpoint-Spam-Reason: safe

Previously wm8962_set_fll was using fll_id to configure the source.
This change is problematic, but it looks like there's limited
users of this driver, and luckily they all seem to be intending to
use WM8962_FLL_MCLK as the source which happens to have the same
value as WM8962_FLL.

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
---
 sound/soc/codecs/wm8962.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index 2256cc0a37eb..24bd818c3345 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2890,6 +2890,14 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	int ret;
 	int fll1 = 0;
 
+	switch (fll_id) {
+	case WM8962_FLL:
+		break;
+	default:
+		dev_err(component->dev, "Unknown FLL ID %d\n", fll_id);
+		return -EINVAL;
+	}
+
 	/* Any change? */
 	if (source == wm8962->fll_src && Fref == wm8962->fll_fref &&
 	    Fout == wm8962->fll_fout)
@@ -2916,13 +2924,13 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	/* Parameters good, disable so we can reprogram */
 	snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1, WM8962_FLL_ENA, 0);
 
-	switch (fll_id) {
+	switch (source) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
-		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		fll1 |= (source - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
 		break;
 	case WM8962_FLL_OSC:
-		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		fll1 |= (source - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
 		snd_soc_component_update_bits(component, WM8962_PLL2,
 					      WM8962_OSC_ENA, WM8962_OSC_ENA);
 		break;
-- 
2.39.2


