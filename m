Return-Path: <linux-kernel+bounces-153478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B80248ACE90
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:44:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C05E01C20CB3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 13:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F013B15099A;
	Mon, 22 Apr 2024 13:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PQpsTJA3"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB7C5028B
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 13:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713793444; cv=none; b=QDquoM9mf4y4q49GkeOQIavNLeg3SAF4tSlBAmDxYirYDqx2NR+nQACLkb88cldinuh3+INNnl/EDcPGrepUbylVG5aOnV3z3ZjNvcUj7XD+1iojwIwwCbzl5ol8al8/BzL/j5fVfrMwtc3f4YWple+RVIdc5O+OKtvKbHzdOvk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713793444; c=relaxed/simple;
	bh=rPldZ9H/ghc6AHkcMuyq2S8TeCvPuuLZe494dCfPxzU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kSMlVFcc8ieNoaDAUoEVPQSDhswKIMdBycyJCvY+8r2gTFwWOLv+qayam9SxgRokhjbessaCcx2F/VWtVxWzDcItyFSPDBDbFEQvGdO3kjXiUr3GCIAJyCw3o2Muyl+yi6yN6cY27oAKG5GeePyqDxv9yOM47bcuRzA4J2A9rtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PQpsTJA3; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a5b68ed5cso9409785e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 06:44:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713793441; x=1714398241; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C68a3MzfkPxx0ofANoAgzKhNox/WCcxWh7hhMFfdoBw=;
        b=PQpsTJA3yBZYkh64TrBA3t4lqyw3BwuJ0G6Rewxwp27G1VSXsOd8gc69ZKm0WratS8
         Z/TMMi6k7EtTL8PC6QvkuwzwromLINSAVHIwhydhHZiuQVafnnzPYCnhvrJ06gnqEN4w
         NyJSPkU/IbKh/Ck/zk2NtytZJWNoqJfpoleYxcL1WxeCy6a88aSiQC1c8THOcqXBUcRv
         rLfpNPYaM1j2Lq1C0YdSadwtHWzkfw+SSydoZtmX80rQ/e+UriE5C1SawIu8Z2t3wJmu
         FTK/wmlL8IBcPzvNDs1YC3QsBqOi2YqSqlRQ6+Jed/c+T8maGlmMF8iIceXqvKBULHvF
         ubNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713793441; x=1714398241;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C68a3MzfkPxx0ofANoAgzKhNox/WCcxWh7hhMFfdoBw=;
        b=G2DD4rw9Z0qE+IXUOareUSrsHcYpK6TeQ8xQfT1t17xQXAXMs3XdvXKV0BSm4iDJdb
         qMysrvohPyJhtmxCkzHUtik9ebyJ4eHaLLSdE57YCOGSGa2jZH5ZcRGDouddizoBhZ/R
         2XQzwqBceSEqioJxlplwxgd2v4LsEdCF6M/aZe0zK69z5DPgylt+bauPgJPWJW+mzGTL
         /BoUcmMu1Jkudw0580E0BHsjQVaAzxY8y48y1EoOQOzfaochyu2274HPTW9R6LjvLcJu
         1/PmBU44tN5niSlAuWH87JnVqBIu5oXF4GzdVV3uMp/faZPIO6hTieSZOL1fBlsoBHtI
         OwBw==
X-Forwarded-Encrypted: i=1; AJvYcCX2bgDGbx4orcI3bCtuM+b6uKtqJxEQF7iZjN9vznpv7H2Ivea1VWTYuaZU2wC2PhZyJw9MWWiKARMzwATQpLKUSEchYzHk0QIC4yzV
X-Gm-Message-State: AOJu0YycAOFoK5afl4BRkKjj0C56cHqar/aNj/WYw/6GiyjIpNhyF5ii
	Rt2mZdTFEymx8tk73jPAr7UUKtrq/O06A5ZVnGfXJngl+EvGcw3P9FHq6F0NRW8=
X-Google-Smtp-Source: AGHT+IF69zomYFFe3gyx0JQZWSWnA/EuT1tmDcqnUqTrWCK1PAfUVruv7UpMnVLeTSrBE1kQSTUlSg==
X-Received: by 2002:a05:600c:3b1a:b0:418:a706:3209 with SMTP id m26-20020a05600c3b1a00b00418a7063209mr8005525wms.31.1713793441064;
        Mon, 22 Apr 2024 06:44:01 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b00417d624cffbsm20731069wmq.6.2024.04.22.06.43.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 06:44:00 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: broonie@kernel.org
Cc: perex@perex.cz,
	tiwai@suse.com,
	lgirdwood@gmail.com,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH v2 1/4] ASoC: qcom: q6dsp: parse Display port tokens
Date: Mon, 22 Apr 2024 14:43:51 +0100
Message-Id: <20240422134354.89291-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
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
2.25.1


