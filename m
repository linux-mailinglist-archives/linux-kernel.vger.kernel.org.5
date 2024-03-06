Return-Path: <linux-kernel+bounces-94238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F58D873BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 17:15:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 509D8284D0F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 16:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF61F13790B;
	Wed,  6 Mar 2024 16:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="MvRn+r6F"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A2760912;
	Wed,  6 Mar 2024 16:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709741707; cv=none; b=q1mgbtwNksvRGsymlqZGY/aMmawfahpVhEYLt4MLPTn8N4UxgZpmNi8eBrjrYH9WBuG/hKEFyIjxipxxnA7bkmlEAQWHkhFZGoHOrObl6vHqTDflCotsxy+AY0dNQMqADM48Rwc9uUCFwkD8QYLnvWABN1+Z5cte8Bb6oqEfSG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709741707; c=relaxed/simple;
	bh=N1y4nbPYklUfzjtuyH7rOVJRAsLNFjOy8FvLbQ54CR8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Eb9f4IavwZXhQ2CV7ZxPby3/+8hqQFUgf4JxWwVmgR9KoF6/t/DoxbWT0EA8iEnfnIzj7kmqepowDbFej4W6sZbkUcoP8wian83OPT10VzTUnoBXuZt44Ksld7nnmuf8KzHWyKWvpLH9aZphmyzI3QEkXnYCXDkKuDZmBoBNn4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=MvRn+r6F; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4268kYKD013643;
	Wed, 6 Mar 2024 10:14:58 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=PODMain02222019; bh=v
	EFvDlU/FVBigkdVQeaMuHEzdd7fO0uiPL0OTGnPJUI=; b=MvRn+r6FpAX4yJkdK
	qabSUFdmuX0BCK+QCx3ifQk15WVXIRdIUiM/hmUC4gdVt1wloLNiuSnRW4rQRbr6
	AiDBUf8F1677Xxq3qmDaQHb/JEhoCnPDheNip2dLi9JgomUeUMUoFJpk+85SzTLb
	5gT3hZaI6zf3w8v6mCQPiMmep4XzCiRWrtg69qWl/Q/nqKgWKZMvdnBg3meA4DLI
	F1lsPtrRfRqEx0SVUeXEIRDrJajYo3ivIchfgKYw7P0yqRDDKei7Kdfs8RrfzsvX
	JhrL81Em74UBcSFiuChOB9I3QK7utOFPpj4QAoZU3eVF2Fy9VPxOeNVSg7N8PzsZ
	e0Lig==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3wpn930g9e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 10:14:58 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Wed, 6 Mar 2024
 16:14:56 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4
 via Frontend Transport; Wed, 6 Mar 2024 16:14:56 +0000
Received: from ediswws08.ad.cirrus.com (ediswws08.ad.cirrus.com [198.90.208.13])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id AF89F820243;
	Wed,  6 Mar 2024 16:14:56 +0000 (UTC)
From: Stuart Henderson <stuarth@opensource.cirrus.com>
To: <broonie@kernel.org>, <shengjiu.wang@gmail.com>, <Xiubo.Lee@gmail.com>
CC: <patches@opensource.cirrus.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        "Stuart
 Henderson" <stuarth@opensource.cirrus.com>
Subject: [PATCH 1/5] ASoC: wm8962: Enable oscillator if selecting WM8962_FLL_OSC
Date: Wed, 6 Mar 2024 16:14:35 +0000
Message-ID: <20240306161439.1385643-1-stuarth@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: l_UbqcPDYUusJtVyLRYriK-0E3ybHfBm
X-Proofpoint-ORIG-GUID: l_UbqcPDYUusJtVyLRYriK-0E3ybHfBm
X-Proofpoint-Spam-Reason: safe

Signed-off-by: Stuart Henderson <stuarth@opensource.cirrus.com>
---
 sound/soc/codecs/wm8962.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/sound/soc/codecs/wm8962.c b/sound/soc/codecs/wm8962.c
index fb90ae6a8a34..6d7bb696b135 100644
--- a/sound/soc/codecs/wm8962.c
+++ b/sound/soc/codecs/wm8962.c
@@ -2914,8 +2914,12 @@ static int wm8962_set_fll(struct snd_soc_component *component, int fll_id, int s
 	switch (fll_id) {
 	case WM8962_FLL_MCLK:
 	case WM8962_FLL_BCLK:
+		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		break;
 	case WM8962_FLL_OSC:
 		fll1 |= (fll_id - 1) << WM8962_FLL_REFCLK_SRC_SHIFT;
+		snd_soc_component_update_bits(component, WM8962_PLL2,
+					      WM8962_OSC_ENA, WM8962_OSC_ENA);
 		break;
 	case WM8962_FLL_INT:
 		snd_soc_component_update_bits(component, WM8962_FLL_CONTROL_1,
-- 
2.39.2


