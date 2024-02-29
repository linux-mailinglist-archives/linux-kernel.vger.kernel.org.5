Return-Path: <linux-kernel+bounces-87393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD2786D3CD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:56:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDBE1B2526C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59DE313C9D6;
	Thu, 29 Feb 2024 19:56:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ACdicXmw"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31B9313C9F7;
	Thu, 29 Feb 2024 19:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709236563; cv=none; b=L5hNYnjmdk6lmqFyUUsWylErvX4BrtqrjER3/5SD5HkDySN78kmiDaOTNgbXWZhnhiT09u65zRcImxcSrVY5iYXv8uiybcTcveYfy9Xe5lAS+eBTwTpaASjQsfFvCbuJCSibSUBu+za86Fhe2FxOJup0Dfgox6ITzBQmov0R9Hg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709236563; c=relaxed/simple;
	bh=NVI5WFKeuJH0tx6oWGjB5QE4SI3b+PhYHwaN02LOX7I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KUuMYxQxgQa3vYl0ZOn46NB5dvH1e37z8i5yQ3PENqMti4xlcmNJUemxHjOvMqr6MkcD7+61PvNyjdckjIS+BTTBEDmTIAFaGvSV5o90j3R0yFH5w/7B9wQ9qEuPlKm+gJOzWKAA8j8xzEj+tuLiFbavSmjvnurJCa6PWjZlaW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ACdicXmw; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a44665605f3so83288066b.2;
        Thu, 29 Feb 2024 11:55:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709236556; x=1709841356; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=y3dRCI30Cqlop6Z/piqJrZ5N5wWPVcx8trh55DUTij0=;
        b=ACdicXmwY7VJDaymlfb8CmBOswjUhBDoKCTT/gGmdmEGNnyZZrDjFZ3GxzYq1eTPHP
         MsTpIoCbYktadsqeSetsb5F+UKIaUUN5q/FZ3XTMJI3vQPdyczfyRS86zLOcCbuJW00s
         cW/ogbCBWjM8UVtVAnBAvx4pnnuDOZzIUGLOjocovJOS+ANC5PS5q8kpNStIstlUG0+7
         ikyFUSWPrbnFmi8mpzf31W6dTSrrAiqC/DuA467wit+i1u22URCqd/bW2m/DbDXvZgyE
         rJXUaX9CJZR9js5hMx8y5sOtT7XaK9N/dUnM0PeDVEDYweisbvdBGGlCoZv+pPlxcLIq
         j4UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709236556; x=1709841356;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y3dRCI30Cqlop6Z/piqJrZ5N5wWPVcx8trh55DUTij0=;
        b=g0AxiyNYG9pRaNa5IyRHtmFcNHuRWPnxBJ9hAgnF9pOA/r1B2WzwOOmdsWGYl/rSnW
         ycATGh6upDsZ7NXaxZtm1j1XEskw8Goy8p0Bic9aY6NDL8sdqdyA+E7z8IbL+MEWT0Eo
         r5D++B+XWGZPDRu5sTnZQTYb//EfXk3ERnIOf/O6/FI1bwohcLeVD2QQRIsEc9JC663P
         0A8+5An0FJPVOt3UjLuG00QGTJ2DcrVjnnPJWdl8+4nxRHtC9+SEvPf6YabDbsrQeMkb
         mzaK8XAi0ip0gs56FnFGX88bveISglGObhSOTccHuBgwKE0ZUdJAcDhS1F4zRFZ0j5Wz
         Wgqw==
X-Forwarded-Encrypted: i=1; AJvYcCXKo7TIXbXKWZeTQlyOComTHSoV4mz3KqLqiWkYsS5O8aqTbEjlBe0tQgSXpbCVB9VOVkASm2emw6/mbicnmfva+T0//3hgKA1Jn+JsEoetlTAvpZsyKjFMJPVczx5SuRQEsCuH
X-Gm-Message-State: AOJu0YxUfJu5hShmhI+vqhY4PbtKrp/1uOKAYFsx2BJItYnKiFo82Iwc
	PDFtLHGYqvVvAAuCWhLUUH9ZrQJr0HxXV03KXO4I4FGMRYQyTddU
X-Google-Smtp-Source: AGHT+IEL9jkj54S+9kUY1V3QOVu73bHEonB9uQVtq3A5M1oTgOFv1MjQ8H5XvVG8CsK/6VnEfZlLhg==
X-Received: by 2002:a17:906:71d8:b0:a41:2f5e:f9b4 with SMTP id i24-20020a17090671d800b00a412f5ef9b4mr2226517ejk.59.1709236556351;
        Thu, 29 Feb 2024 11:55:56 -0800 (PST)
Received: from localhost.localdomain (80-108-76-242.cable.dynamic.surfer.at. [80.108.76.242])
        by smtp.gmail.com with ESMTPSA id ti9-20020a170907c20900b00a43a4e405bbsm983214ejc.115.2024.02.29.11.55.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 11:55:55 -0800 (PST)
From: Christian Gmeiner <christian.gmeiner@gmail.com>
To: Lucas Stach <l.stach@pengutronix.de>,
	Russell King <linux+etnaviv@armlinux.org.uk>,
	Christian Gmeiner <christian.gmeiner@gmail.com>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>
Cc: Christian Gmeiner <cgmeiner@igalia.com>,
	stable@vger.kernel.org,
	etnaviv@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] etnaviv: Restore some id values
Date: Thu, 29 Feb 2024 20:55:31 +0100
Message-ID: <20240229195532.7815-1-christian.gmeiner@gmail.com>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Gmeiner <cgmeiner@igalia.com>

The hwdb selection logic as a feature that allows it to mark some fields
as 'don't care'. If we match with such a field we memcpy(..)
the current etnaviv_chip_identity into ident.

This step can overwrite some id values read from the GPU with the
'don't care' value.

Fix this issue by restoring the affected values after the memcpy(..).

As this is crucial for user space to know when this feature works as
expected increment the minor version too.

Fixes: 4078a1186dd3 ("drm/etnaviv: update hwdb selection logic")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Gmeiner <cgmeiner@igalia.com>
---
 drivers/gpu/drm/etnaviv/etnaviv_drv.c  |  2 +-
 drivers/gpu/drm/etnaviv/etnaviv_hwdb.c | 14 ++++++++++++++
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/etnaviv/etnaviv_drv.c b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
index 6228ce603248..9a2965741dab 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_drv.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_drv.c
@@ -494,7 +494,7 @@ static const struct drm_driver etnaviv_drm_driver = {
 	.desc               = "etnaviv DRM",
 	.date               = "20151214",
 	.major              = 1,
-	.minor              = 3,
+	.minor              = 4,
 };
 
 /*
diff --git a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
index 67201242438b..1e38d66702f1 100644
--- a/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
+++ b/drivers/gpu/drm/etnaviv/etnaviv_hwdb.c
@@ -265,6 +265,9 @@ static const struct etnaviv_chip_identity etnaviv_chip_identities[] = {
 bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 {
 	struct etnaviv_chip_identity *ident = &gpu->identity;
+	const u32 product_id = ident->product_id;
+	const u32 customer_id = ident->customer_id;
+	const u32 eco_id = ident->eco_id;
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(etnaviv_chip_identities); i++) {
@@ -278,6 +281,17 @@ bool etnaviv_fill_identity_from_hwdb(struct etnaviv_gpu *gpu)
 			 etnaviv_chip_identities[i].eco_id == ~0U)) {
 			memcpy(ident, &etnaviv_chip_identities[i],
 			       sizeof(*ident));
+
+			/* Restore some id values if ~0U aka 'don't care' is used. */
+			if (etnaviv_chip_identities[i].product_id == ~0U)
+				ident->product_id = product_id;
+
+			if (etnaviv_chip_identities[i].customer_id == ~0U)
+				ident->customer_id = customer_id;
+
+			if (etnaviv_chip_identities[i].eco_id == ~0U)
+				ident->eco_id = eco_id;
+
 			return true;
 		}
 	}
-- 
2.44.0


