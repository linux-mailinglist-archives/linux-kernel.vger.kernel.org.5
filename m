Return-Path: <linux-kernel+bounces-151618-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 841BF8AB131
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 17:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 259511F2478B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B072D12F5A5;
	Fri, 19 Apr 2024 15:01:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="li5KU7TM"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7412F385
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 15:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713538912; cv=none; b=cIHKxwT5kAUFXsYZi1SPA1CeMxLpjMzdcoS1xgPHMVzX/broCBu+mV5PwkszE/jqqhdIffrN3idFwD319kJ1NLUHU5Odl/E8HWF2h9yACzbx94AtTLsKe0Oen4alnqRKMNLcMVm6iyvNBWFJxShnFwtOc8u6kGT0wOE41xeZqdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713538912; c=relaxed/simple;
	bh=z/01KbpJUrnhSXb2YDfo1h/eKOvCBmVA/IVm+kzFUng=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nsuQM8RnTa2pdGRvIq075x2gqvveEytC60aMVE22G++PT1Tz6vhtOmVE225sIEoa4PsJQeIlHzYXhGpIA1uQrto/akuOlKvRh4e4QDnVOLc0b7GeatM5L7pn29Gfft8a/t3NSzCCNGDTZL6K9ZcT8CVBaxbpN+/wA5vRfYeTo2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=li5KU7TM; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2da84f93c99so27646441fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713538908; x=1714143708; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0zadu6QxqqDPKAQWxO1aQV8SmpVW6EVj/pCdtlgNCkU=;
        b=li5KU7TM2oRCCKaF8gxeEW0GMEDMAs6UcjS/iMuO0a1hHkx+XyMXDSZqpkcKRtMx+d
         s25/uLPYLOSg1EKadPz+aTb0sQDa4fGfKdoI0NtTrmJZTpwldpBlG2uB4ChRdkN5KRmJ
         cXXDoZLzY3N+/EmEY5OGd5vScdKZC0/4JRQeJDUTfX0GblZ+KJixCWwESUNyw7iPNzN5
         OOy2GuAqPbayICEgED+IDRE/iDbRV67jhUPJ/JDR0VJ+fqGgyQuRm9p0AESPLpUlQpeY
         FQlXghZkNWbTiHuILykNIVpTkQN4eOdmvp8sklJsE6Rh8l85SKatGURZNDnTd4rmL4om
         4LhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713538908; x=1714143708;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0zadu6QxqqDPKAQWxO1aQV8SmpVW6EVj/pCdtlgNCkU=;
        b=rjbm0/BbJUqObYLZ1D5607peg8sBMpHnxiaFhRVyxoD29kD6S5ZrKKUQSnnzwL3xjD
         kkAhxZkVRBa7sKuhL4VuzQbk0swF941EMgmuXC9Dn4MGU7wbxxHjj5fQWsr2c2dhGaTb
         /JhsTadL/D+aKAVCCVHULSARJw2bRF/Q3AUKpJpZsPfeAUQUI6mOSVn0sBPs7G2cTN+U
         aZCSydfj3TU6XjSOlcB8G4FtaGaM2XuPtBIvA4t05Nh3zSn+mt0RzMtVLhaYo9d4TizL
         z9A5WZh37I/wIqzbNQzM1MX2sTsKeFcge9J5WRMyz1DW8Dq8J6//qhvkKc4cJWd+0Vqo
         IHhQ==
X-Forwarded-Encrypted: i=1; AJvYcCWPcnFNSNaS2MHW7/IxGnpTTyQjXjnDq8T/65HWYLWzSt/43WOLneDskAcS3Yt+1XoWI+PqfO/OOpTpOCRmNTZya6pNgyFWfpTK/Al7
X-Gm-Message-State: AOJu0Yx0RXjlyYtrZDwEg/yEhXJZcaNZXAetzecdpU1GXDbCZXh167sf
	Vwq+x1ZrvZqYzw5aM7eymRBWQEzROCsyUgUJDFOAUn0kDewsTKMIoCnRZsI8gAACzH8GyxfOrA4
	V
X-Google-Smtp-Source: AGHT+IGL1W85WvvhW6kovpHuj891c1aSzJ4lVgOhlczmIfJv+733Fam7cnZaouVfnf6+MpkTnF3jyA==
X-Received: by 2002:a2e:9f14:0:b0:2d7:1323:6792 with SMTP id u20-20020a2e9f14000000b002d713236792mr1881512ljk.43.1713538907620;
        Fri, 19 Apr 2024 08:01:47 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b00417ee886977sm10660462wmq.4.2024.04.19.08.01.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Apr 2024 08:01:46 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	steev@kali.org,
	jenneron@postmarketos.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] ASoC: qcom: q6dsp: parse Display port tokens
Date: Fri, 19 Apr 2024 16:01:37 +0100
Message-Id: <20240419150140.92527-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240419150140.92527-1-srinivas.kandagatla@linaro.org>
References: <20240419150140.92527-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

DP Module needs to know the data format type which is specified in the
tplg file, parse that info before setting up the module.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 sound/soc/qcom/qdsp6/topology.c | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/sound/soc/qcom/qdsp6/topology.c b/sound/soc/qcom/qdsp6/topology.c
index 70572c83e101..27a5adb201c3 100644
--- a/sound/soc/qcom/qdsp6/topology.c
+++ b/sound/soc/qcom/qdsp6/topology.c
@@ -730,6 +730,29 @@ static int audioreach_widget_i2s_module_load(struct audioreach_module *mod,
 	return 0;
 }
 
+static int audioreach_widget_dp_module_load(struct audioreach_module *mod,
+					struct snd_soc_tplg_vendor_array *mod_array)
+{
+	struct snd_soc_tplg_vendor_value_elem *mod_elem;
+	int tkn_count = 0;
+
+	mod_elem = mod_array->value;
+
+	while (tkn_count <= (le32_to_cpu(mod_array->num_elems) - 1)) {
+		switch (le32_to_cpu(mod_elem->token)) {
+		case AR_TKN_U32_MODULE_FMT_DATA:
+			mod->data_format = le32_to_cpu(mod_elem->value);
+			break;
+		default:
+			break;
+		}
+		tkn_count++;
+		mod_elem++;
+	}
+
+	return 0;
+}
+
 static int audioreach_widget_load_buffer(struct snd_soc_component *component,
 					 int index, struct snd_soc_dapm_widget *w,
 					 struct snd_soc_tplg_dapm_widget *tplg_w)
@@ -760,6 +783,9 @@ static int audioreach_widget_load_buffer(struct snd_soc_component *component,
 	case MODULE_ID_I2S_SOURCE:
 		audioreach_widget_i2s_module_load(mod, mod_array);
 		break;
+	case MODULE_ID_DISPLAY_PORT_SINK:
+		audioreach_widget_dp_module_load(mod, mod_array);
+		break;
 	default:
 		return -EINVAL;
 	}
-- 
2.43.0


