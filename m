Return-Path: <linux-kernel+bounces-127519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C152894CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 09:54:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2DDA283237
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 07:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337A53D0D5;
	Tue,  2 Apr 2024 07:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GhtP8OVX"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF9012E648
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 07:54:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712044448; cv=none; b=JBEn+RlZvilLnCVHE8b1itUFWHCsjPrHaPyEBOpYe8m/VENcOoc17dU7BPYYBVDc0vz7hIcny2iAs5599j6LdRcNxjABbEtNr+FXrY1cPEdKKr5QWwtkNqpcOmxTXKQAXNE8hFQxwQdY6WdFcdhQoMhPXEsIywfqMey4V0XAd5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712044448; c=relaxed/simple;
	bh=VnvZ8USXywiPdli2AFm8g6I1VudpIc6SUGU2k0GmCJg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tPGB+es291ROSxl8j5D82M8QaGT2+QKp1KUy+F9NT3kYkN5AuIMETTKY4ptx09AIBNz91IxbuTzAQr4Zl60xUoA7kx9v0icDsEWP4SusphonNSMUmyPMa+nyv8Dj1NCgjEfvSvcos0J241dd3ddxhRP24pU7lpn02LDn8vpNPcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GhtP8OVX; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4e692ca8c4so225472666b.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712044445; x=1712649245; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=S0aDPStcWplmgXtw121bO/EPEa2tJmV5qvIMipnIN9E=;
        b=GhtP8OVXQjfFuBvX53F1s++cBfrhe8mGw9WEMReocpPLQyfTgVP9u7ZCN49ZFYzmXO
         BfXnG2xlpSRZH5nOSewjntJXhjX9W4lu9iTV2zr4O2qoJxYW8kr0cQqTDgm8UE35+eyG
         vWUJ+7N6PM3X3sYe/x36rlp0alr0Oj0/YhNYY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712044445; x=1712649245;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=S0aDPStcWplmgXtw121bO/EPEa2tJmV5qvIMipnIN9E=;
        b=TfAu59CzQt+5tNDnRD79jhs69FL4SHfyNmLUi5fhW2L5vEEhFiSa/godtCC7mTDLbY
         wGj9jqcFqwpgx0Wfbgszf8qZAvzrtTG8FiGQ43AdVEcX4pBGyGqJ2CAclqJkOLwIbriW
         fDcf48i444ouSOSs9ZWGnFoIZyaAlYA71Z8gAaGP0BFbbTB7iQ1EJTH7CnBQARL6tZI/
         wiwoW7cZfsFrAhFQLcpVtRvwpa8mWMapiQrw6drdIW+3VnFm4/+Xq4CdTVvWLPmWZXR/
         X576Bs/ppsNQ09aTnjEOlR1d+JrxSsUizLHX5xANqBkleaugNJxN8NbYzuT9ftdSJyhN
         hmIQ==
X-Forwarded-Encrypted: i=1; AJvYcCVh4gdeOgRlVWQP/pAyL3Ey71sStgeqLS0TbesDWllvrouShQipkg6slYdw+06vRHJy1kr4b712tLdKDKB87cbtsN37xL/6ZmtReYi0
X-Gm-Message-State: AOJu0YwT2zS0q+bhMd91xq7V69rKj3CrfQoGh/QbNNGTYyhZs7J8Zs8u
	T6oQL+WM1Q7tNzyoer2zzr81XIVivGMMZFDxnUtXlqzuxu79IDhZCXA8XKEVFg==
X-Google-Smtp-Source: AGHT+IEO3o3WE2Q6ehT7FdVQbjibduradq+vM90LrmVRkZTLj+wI/38lnWD5V3+vj2JRKKZyNZQGQQ==
X-Received: by 2002:a17:906:795:b0:a4e:8e54:7962 with SMTP id l21-20020a170906079500b00a4e8e547962mr403527ejc.41.1712044445152;
        Tue, 02 Apr 2024 00:54:05 -0700 (PDT)
Received: from orzel7.c.googlers.com.com (229.112.91.34.bc.googleusercontent.com. [34.91.112.229])
        by smtp.gmail.com with ESMTPSA id k5-20020a170906a38500b00a4761c94a5esm6227359ejz.107.2024.04.02.00.54.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 00:54:04 -0700 (PDT)
From: Wojciech Macek <wmacek@chromium.org>
To: Chun-Kuang Hu <chunkuang.hu@kernel.org>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	dri-devel@lists.freedesktop.org,
	linux-mediatek@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	chrome-platform@lists.linux.dev
Cc: Wojciech Macek <wmacek@chromium.org>
Subject: [PATCH] drm/mediatek: Add RENDER capability to DRM device
Date: Tue,  2 Apr 2024 07:53:52 +0000
Message-ID: <20240402075352.3147747-1-wmacek@chromium.org>
X-Mailer: git-send-email 2.44.0.478.gd926399ef9-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

DRM device shall create /dev/dri/renderXXX entry
to allow ChromeOS VMs to access the OpenGL rendering
offload.

Signed-off-by: Wojciech Macek <wmacek@chromium.org>
---
 drivers/gpu/drm/mediatek/mtk_drm_drv.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mediatek/mtk_drm_drv.c b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
index 74832c213092..afa4d6391b08 100644
--- a/drivers/gpu/drm/mediatek/mtk_drm_drv.c
+++ b/drivers/gpu/drm/mediatek/mtk_drm_drv.c
@@ -585,7 +585,8 @@ static struct drm_gem_object *mtk_drm_gem_prime_import(struct drm_device *dev,
 }
 
 static const struct drm_driver mtk_drm_driver = {
-	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC,
+	.driver_features = DRIVER_MODESET | DRIVER_GEM | DRIVER_ATOMIC |
+			   DRIVER_RENDER,
 
 	.dumb_create = mtk_drm_gem_dumb_create,
 
-- 
2.44.0.478.gd926399ef9-goog


