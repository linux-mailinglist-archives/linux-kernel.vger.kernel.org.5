Return-Path: <linux-kernel+bounces-43082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5DCF840B5E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:28:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A233128D186
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE79015702B;
	Mon, 29 Jan 2024 16:28:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b="qBooUn/4"
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67F2064CFF;
	Mon, 29 Jan 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.152.168
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706545681; cv=none; b=m8YoAM48HTCmJqpF5H87PtqcEk54MHtNaN02al8DkfVhUVtjqWlz7lT7vmxmcwXfxSaDwW7XySPzEgRnJzwq1+SABna1tANBkObLDCsXZzCZAGH6tjPUBaiTyykyrDFgE/ZYkF9A+9UmoEqBUz14TsS+1yqsNp5VjkfoA2GMpp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706545681; c=relaxed/simple;
	bh=1HSK11Wfi7i7NJG5CuDvObzPSWsGrGhllG5djarUfjU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Gern3qkwIl3e5jqqcvKueDsSabOJZzET2zI24a54PW0dA9ReAlmPXQP8S81Lqkc7MlQhKooHPat3ldvSKL7NnEClOLqbIQXprsvlDHpWKhV98ERO3/oFcKBeQMxSpAKDnQiJtnvDMv9NP2EEzilwgAFAm8Vb8i0+h0z7SkSgXIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com; spf=pass smtp.mailfrom=opensource.cirrus.com; dkim=pass (2048-bit key) header.d=cirrus.com header.i=@cirrus.com header.b=qBooUn/4; arc=none smtp.client-ip=67.231.152.168
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=opensource.cirrus.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=opensource.cirrus.com
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
	by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40T5fM0A006968;
	Mon, 29 Jan 2024 10:27:52 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	PODMain02222019; bh=9UZPrvwSETOvFqtQyagoZ3GxnlQC7ET9ALMxEkO6v10=; b=
	qBooUn/4uwNaOyczsOZntmdKFh4BK6kXo786TxxXqfXkki4Whh/0xrBr+5A4XfoB
	tzPBpup29qT+03Ziom7HJ2G4sAbt0h0gzs+x5d5VJijfXaiQSPrBgb4PEjmUNVdW
	f1g4ZVmyu51YhFzfUCv1ZzwNtoi7mPivf9aR7wBgSHOd3gC0IgSxF7vNiS+dW3C7
	/0p9bRP0Df69nV5nOgS0jqF0Tmf/gZ8TGu43WVSMsBe+9k8hA8NC6+aGv9vLxrAs
	8/vYiFpqEvxuAtmfv/+35tylQj/bm8jd9Kp4hXH2+8H8VT5wNO6uXwtzCHtHSDwC
	5VfC6LtoRgLM9a8NpDsLow==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
	by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3vvy4nta8p-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jan 2024 10:27:52 -0600 (CST)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Mon, 29 Jan
 2024 16:27:42 +0000
Received: from ediswmail9.ad.cirrus.com (198.61.86.93) by
 ediex01.ad.cirrus.com (198.61.84.80) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40 via Frontend Transport; Mon, 29 Jan 2024 16:27:42 +0000
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.64.204])
	by ediswmail9.ad.cirrus.com (Postfix) with ESMTP id 6BDAE820247;
	Mon, 29 Jan 2024 16:27:42 +0000 (UTC)
From: Richard Fitzgerald <rf@opensource.cirrus.com>
To: <broonie@kernel.org>, <tiwai@suse.com>
CC: <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        "Richard
 Fitzgerald" <rf@opensource.cirrus.com>
Subject: [PATCH 03/18] ASoC: cs35l56: cs35l56_component_remove() must clear cs35l56->component
Date: Mon, 29 Jan 2024 16:27:22 +0000
Message-ID: <20240129162737.497-4-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240129162737.497-1-rf@opensource.cirrus.com>
References: <20240129162737.497-1-rf@opensource.cirrus.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: _tgwHGyX_zM0B8maXPn7AKPgJFDm8Npk
X-Proofpoint-GUID: _tgwHGyX_zM0B8maXPn7AKPgJFDm8Npk
X-Proofpoint-Spam-Reason: safe

The cs35l56->component pointer is used by the suspend-resume handling to
know whether the driver is fully instantiated. This is to prevent it
queuing dsp_work which would result in calling wm_adsp when the driver
is not an instantiated ASoC component. So this pointer must be cleared
by cs35l56_component_remove().

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: e49611252900 ("ASoC: cs35l56: Add driver for Cirrus Logic CS35L56")
---
 sound/soc/codecs/cs35l56.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/sound/soc/codecs/cs35l56.c b/sound/soc/codecs/cs35l56.c
index 45b4de3eff94..09944db4db30 100644
--- a/sound/soc/codecs/cs35l56.c
+++ b/sound/soc/codecs/cs35l56.c
@@ -809,6 +809,8 @@ static void cs35l56_component_remove(struct snd_soc_component *component)
 	struct cs35l56_private *cs35l56 = snd_soc_component_get_drvdata(component);
 
 	cancel_work_sync(&cs35l56->dsp_work);
+
+	cs35l56->component = NULL;
 }
 
 static int cs35l56_set_bias_level(struct snd_soc_component *component,
-- 
2.39.2


