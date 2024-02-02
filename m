Return-Path: <linux-kernel+bounces-50039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC2A847388
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:42:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378A9287BCA
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD40B1468E6;
	Fri,  2 Feb 2024 15:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KMuyRO6G"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 859ED1474C3
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 15:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888506; cv=none; b=fwhUi5vZ66VHIdrt6xngKzfPVT51KA0nnBRS2aJgqBkVQIKzh9+MvkwDZarFCreR2upzZprGdKvYve0BaKjmtE/r0fyhI1/ldEqtEHBLSxNJQj6GHAjPfRpXpm63LexD9K2K01xPkuNvkZSAyzecuGv/zlhjGHpNBKPyA5NZRjE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888506; c=relaxed/simple;
	bh=4X1TPMFs6uYp8v8YB3aNn81TS+wxeI5hvW9G+HbDZuM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=LCC6Rz482jex91lQt/olc71l36JjgduZGiliZXX+gEDO0+XM05vl+2wC4n1Psok0fRSO5iiT2La/pPNSg0tmgvYMShgWTkLH5BxjFxk2asaxEaBUa8vm9y0o480hfYPII7LoDUgVwtSy5ORA2WP82K4x9iADicpdB7VG+w0585c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KMuyRO6G; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f79e79f0cso312167766b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 07:41:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706888502; x=1707493302; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LF4BB/ebiJDn9LW6b9s3SFnH7jRadY8xXWrehEGe0f4=;
        b=KMuyRO6G9sk3VlTa3TOnIRMnk1WcA+K6sW52A9jVOGYletXqkfZD62lF3EtF0NtdBk
         rOjJpn+FR0qXu7ovMxS4OgKV649xwsr2/wdNxadoqCv7DNP92erogV32Rq91qFL1iUwy
         Wv2aey2mGZ4pmG/6cqjvOaIRwsbRrLTxVznXX9liONtNspvAb1rZE+4xSMRVeJy6fKlb
         e2A7OJ5G3Kkb9yU1e1fuUWV/EcLI9TnsMn2khuE3LDUKSqw1IoOkchPFri//Cud1I/qI
         bwiyjlcWwVy+5xuWp4NdzbJecOcYvx9OjELbZELRKGUFuSUWyS3sX/ZO+z+s3+FGWvPo
         yKLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706888502; x=1707493302;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LF4BB/ebiJDn9LW6b9s3SFnH7jRadY8xXWrehEGe0f4=;
        b=dytyYDc3Qq3m+8J+WvITg3q4lkr3ctvih7L8Bp7LW/6+Kj3MaUjCGzWFoMzhmFuWsR
         /1kEVhkg2+6Gtr+nww7LCF16s6SBRtkx+f4O2HS/qGiZh/tLyAbbBjYqe7DEc/T1xMbe
         xvAqKCRy74kNBisp1DjD+BmW24BE4HE92i7wSgK9K/eis11Inkc8MxIQ/i/tooIMEZ8O
         J7wGHIylbx2VvlC0S4tL6XGMHB8iua7G7L1eTx3QsTwYt60P97nKyxc9KRPf53H33+69
         4nnDxD0VByLjzXmfMcT5VuIZWqq26aJKPyQN102NoJQxDPJAF8wgzn9WGozPgB1Ndcz+
         DDsA==
X-Gm-Message-State: AOJu0YyY+N34inCVMTq39D898G9EAPyVeIw7daW9zFasTu5M6CIT+CVc
	+TIczP4+ym2kh5nEE8XfSPxo7slUccAqlnPlGdgdQx4BGnab8tv1VLp9Efy7Rxs=
X-Google-Smtp-Source: AGHT+IFKIHngJwG+a8+K2tvxYalO1Inf+CHn/nPl1OzTiD97fi59n0bVlsRCJVniN7XOzim1bIBKfQ==
X-Received: by 2002:a17:906:7185:b0:a36:7bee:5d9b with SMTP id h5-20020a170906718500b00a367bee5d9bmr6375843ejk.76.1706888502620;
        Fri, 02 Feb 2024 07:41:42 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU22WkjqI/e18Wrj93BXTP/RqCvlOF91i6IDCtxrNbtFQ/ntRsDiAvZ/K18jVxcFpHI1pk0CVuDZ54O36EsmAAGwbTefUaNkK5O5fahsHH9A0Rt65bXEZEhqDana+8PI4mHJHVp/Pc2Oc5jMX/LYGhy0F+cpQhlaNSONnnRl4WSxSpVs03IkzZSEsiLVfGzu9ewDpcnCxcwrrRdpm9dnzHkgBzMGS0lQSZfKnsbU0Hve6UYEfhezQ03++TFMGKRJWzds+4e7EGMcMxvcOkaQT5d+GpVsZPpGmOCCywOk0ImT7iWCB9s
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cu9-20020a170906ba8900b00a37116e2885sm624819ejd.84.2024.02.02.07.41.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 07:41:42 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 3/3] ASoC: codecs: tx-macro: Simplify setting AMIC control
Date: Fri,  2 Feb 2024 16:41:34 +0100
Message-Id: <20240202154134.66967-4-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202154134.66967-1-krzysztof.kozlowski@linaro.org>
References: <20240202154134.66967-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When updating all bits in AMIC control registers (mask 0xff), use more
obvious snd_soc_component_write().  Replace also hard-coded value 0x00
with a define.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 sound/soc/codecs/lpass-tx-macro.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/lpass-tx-macro.c b/sound/soc/codecs/lpass-tx-macro.c
index 2d4f6c04332b..7e51212d4503 100644
--- a/sound/soc/codecs/lpass-tx-macro.c
+++ b/sound/soc/codecs/lpass-tx-macro.c
@@ -1850,8 +1850,10 @@ static int tx_macro_component_probe(struct snd_soc_component *comp)
 	snd_soc_component_update_bits(comp, CDC_TX0_TX_PATH_SEC7, 0x3F,
 				      0x0A);
 	/* Enable swr mic0 and mic1 clock */
-	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_AMIC0_CTL, 0xFF, 0x00);
-	snd_soc_component_update_bits(comp, CDC_TX_TOP_CSR_SWR_AMIC1_CTL, 0xFF, 0x00);
+	snd_soc_component_write(comp, CDC_TX_TOP_CSR_SWR_AMIC0_CTL,
+				CDC_TX_SWR_MIC_CLK_DEFAULT);
+	snd_soc_component_write(comp, CDC_TX_TOP_CSR_SWR_AMIC1_CTL,
+				CDC_TX_SWR_MIC_CLK_DEFAULT);
 
 	return 0;
 }
-- 
2.34.1


