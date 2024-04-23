Return-Path: <linux-kernel+bounces-155894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9218AF8A4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 22:56:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C8AB1F25DFD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 20:56:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D20B226288;
	Tue, 23 Apr 2024 20:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WvlDeNCh"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA4433A0
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 20:55:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713905722; cv=none; b=Ugu+xsIdk/yfJM2fAjqYf9fSZSeOZty+VTIqPAO4WTK7bSDXEmcpYNMv++DR9XKycgezW7jDEvP+Dq64ZCZjPUary2b1fHi+tA/IJYfVP3AgbvmJ58zm4qsgug00u730E/rV1pafz4/zCnS7F4o4bHEOOTIqLARscFyFdnUE7WU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713905722; c=relaxed/simple;
	bh=mVvpig0aivu5S+vnjfpsPBNuUpemb5I45RMuMnz2xCQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Q+BpRCktPqkLgi48y350kTmPz73uVvIoyH1T5ziwtCTAc5uL867E/MeT/b2uQeftaat0hftH8TcBtuFSBVObFzQomgFeIjLxc4+kP588+aDiuFYtYsROg6EqyDtMYTUNKC+DVM5BpBrV87nxzUS0+A4JRmPm+kp8q/u1aKqzXHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WvlDeNCh; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-41ae95468efso3184065e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 13:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713905719; x=1714510519; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TbfLpkC6sUOo8U9culftXF70TNu8J3c2HXxMlG6vGno=;
        b=WvlDeNChPG/MnCKUyEBuasPw+WpLgzmdKGhHPXfOADW7KUr3eCnCGtRzzqlSOd+SMp
         +SZSzyxKO/v0ynS1vR0O7u9zXc6AeS7BJIgsiREgWS1Jaao+/TL9IDr5EZXnbvkA6Yte
         GFr4qAxYL8RNrchjF5hpvyVXVLe732JAYwutjzZVwEkl3m8j6d89t1GrIe3D/oTRFHQa
         tPOz3pav7JeWnFgd+lw9UYzdGuP91FBIKQmT07Y3fxuqPKDA618dnoaZjumfmoVKs8H0
         5+euP9WvhMQcJDVHJyOzEiEz6IifCw0lixlYzlpV64dwlQoDcuOxf7/ho5gbU2s2fglE
         HV0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713905719; x=1714510519;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TbfLpkC6sUOo8U9culftXF70TNu8J3c2HXxMlG6vGno=;
        b=YDhc3Vt1I32wC1DRiiG+4Drmg2Fllh1Pkautj1mYm9j/Tyy5O5P4bR5VgQ/mEJDEup
         6YRlmLa4PTSMAjW9A/rEarE/YQxovbEdWEJw5RmSNGZIcwA2jWEYp55Q5Y5AGEaZ1Zt4
         HPhPGjYZfe86lSyyT4kVqwV1o9mUINuzUpNyV5YyL1KEhcwluoQuOVJziuh9MLWVGiEr
         wFJ74W0ROk0Vl28sjEEEcRCF67naXsoZ11mAoVZ/B9/1lG6aY0riyz7P/TGwgg7Ql93l
         yHJ8Laast3cVYML3LSRGZ1jxTG/w+DKpf2HYEYuH5/K/SDqzclohc6E4+L9L3gn1EFeI
         rJHA==
X-Forwarded-Encrypted: i=1; AJvYcCVMMSrNdUjYQqQaJ1JeJLdbY/i+DKK2EIFqKzJ5A/KAJDcvH23nbGi84i4o+zJPWe9vuxdbn1KAumM3/SJaM7nus0sEcc/dnZ1sEfAm
X-Gm-Message-State: AOJu0Yw+szSnbhzUegQhol/vpjpU/03CvmEgkXbjX2EaEShNbHvpU6i0
	mdYDHOwHZl+MQKEaJe8Sg907PGq1NOamgrG+mO1O5ttN5y6d0qBvira4PetF
X-Google-Smtp-Source: AGHT+IEbJO5sd+0HnvGDWDkavS9ctSks7YgX/fPrRil0nJ1UKoMxDRyYkerrE1jAXCQAZZdWz6LmdQ==
X-Received: by 2002:a05:600c:4ec9:b0:41a:bf5d:c30a with SMTP id g9-20020a05600c4ec900b0041abf5dc30amr441241wmq.18.1713905718653;
        Tue, 23 Apr 2024 13:55:18 -0700 (PDT)
Received: from [192.168.1.130] (BC249051.unconfigured.pool.telekom.hu. [188.36.144.81])
        by smtp.gmail.com with ESMTPSA id fc9-20020a05600c524900b0041ac5f19213sm2960332wmb.8.2024.04.23.13.55.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Apr 2024 13:55:18 -0700 (PDT)
From: =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
Date: Tue, 23 Apr 2024 22:54:33 +0200
Subject: [PATCH] drm/panel: jdi-fhd-r63452: make use of prepare_prev_first
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240423-jdi-fix-v1-1-808970662b40@gmail.com>
X-B4-Tracking: v=1; b=H4sIAAggKGYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDEyNj3ayUTN20zApdSwuzRHNLs0RjQwNDJaDqgqJUoDDYpOjY2loAgWt
 gkFkAAAA=
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 y.oudjana@protonmail.com, 
 =?utf-8?q?Barnab=C3=A1s_Cz=C3=A9m=C3=A1n?= <trabarni@gmail.com>
X-Mailer: b4 0.13.0

The DSI host must be enabled for the panel to be initialized in
prepare(). Set the prepare_prev_first flag to guarantee this.

Signed-off-by: Barnabás Czémán <trabarni@gmail.com>
---
 drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
index 3e0a8e0d58a0..483dc88d16d8 100644
--- a/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
+++ b/drivers/gpu/drm/panel/panel-jdi-fhd-r63452.c
@@ -247,6 +247,7 @@ static int jdi_fhd_r63452_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_init(&ctx->panel, dev, &jdi_fhd_r63452_panel_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
+	ctx->panel.prepare_prev_first = true;
 
 	ret = drm_panel_of_backlight(&ctx->panel);
 	if (ret)

---
base-commit: a59668a9397e7245b26e9be85d23f242ff757ae8
change-id: 20240423-jdi-fix-986a796a3101

Best regards,
-- 
Barnabás Czémán <trabarni@gmail.com>


