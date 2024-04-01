Return-Path: <linux-kernel+bounces-127144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B94AE89476B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EA9671C21F83
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4F9056B6C;
	Mon,  1 Apr 2024 22:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I6s/V2gT"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800D529CFA
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011421; cv=none; b=MvwetWmuX61tVUQQ8VFFJeo/68Y6v3Izc1CprcT9WQ0gK4i8O5e28PtrY1P8/Ea3gBBl/ehMBG+Kj1zO2NsaOf8vVttp8OPdd8/LIT+Orvojsk22SxA0ufSe6hQavhl5zzGt3406R9G4NCkCoClhHVVnH3PBTFgsdA01PzAtUXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011421; c=relaxed/simple;
	bh=8Vf9Ny+dWGd97zbUbBdSuKZ4GxKDtWvZM5jazU0S0rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kd4uB4o8VAregFOL2s7feHwoc4JSE9B2+p2lzwKkTrPXNHA/tOOcGCalAdw4Gdra7v8oU39nEyqZ4yKizwm3jDocSPS8dNMrTHKkTExmThIolsamMinMDKRvvVgT6EcQYK/m3ZNAYLViWxe7lK0cMz3n7Vb/VVESsl7ZpQ8p3Gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I6s/V2gT; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4734ae95b3so575973366b.0
        for <linux-kernel@vger.kernel.org>; Mon, 01 Apr 2024 15:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712011418; x=1712616218; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6wOlanwnyuahzpz0MfNPGNkl1E4bit5o3/S2j1nuGQ=;
        b=I6s/V2gTNaHr/H61CGCr4Y56mVVsCQ2D650G0a8qM/fQR3suGN8d7bE2+GPi9Ah7kx
         vnyy8TyxqFJUyXmfgWP9fwJQWmEt1oTMWAzfp5a2P7pKI/4haFHSoUMAnVLRDIAlY3M0
         kLhNQorchn5UFpy4z/dCCYIsvitsJPtJ9Ar5F+vZd0qm5UeQrAHVIN6Rs1Cg+F6OAb1w
         TDfZZUZjexEvMd7u+oQVnsWvU7FBtDjeyR2zHiEX8bLBl5W727P9Xrn378fPSlZZNTMW
         iwGA0ga391EA1lG6uEW9fHyIRex76NoWH9WAccye1OeLb3LH7VV1KJfigmdcTHtepgBo
         9xKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712011418; x=1712616218;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6wOlanwnyuahzpz0MfNPGNkl1E4bit5o3/S2j1nuGQ=;
        b=w3HQclzs7dmPCeKUjd2CXRotEHU5fHJTsEXBWmgZh0iHXpYBB5H3ntP60LkIKRYDTi
         TXmmILKkdArEsZaeXgtlvdYuwnwfFzwc+p0DpReqG+7rawwN1fi3yxvb0iumM/3IoeY1
         6Z6dCVNF5r72sJOpz2B7zRTuSNyNXHB2/RnWWqapLF01/zA4ovbogebTslAcDhw7v70v
         vSb07n+JHnCd3svUFXNlw1+Gad1n7EZ6T9x9nVjnPDAkxhNGDuLlHvCfyEHaf+tHcJlj
         XovCa6ifw2ZWcdVYj8cYrHjuVP9MX7U9IFn1T0vepfYMCfpCGT5Yx0R+z2HeJVcHyIaC
         ckGQ==
X-Forwarded-Encrypted: i=1; AJvYcCUCtkNCSv8rWJjrVdMugBjB7w5wUAojgNjwk8jxjm7dnO9jF9qzhwdB217gnVkMACvXqKFMN6b5T+MRwrBELt7oVIss+q9D50k6PTGo
X-Gm-Message-State: AOJu0YwjbZwK7FsSMJK9y2bYg+ZfnSvWH0PiyktrJgwwtEUVquynZ6Tv
	PHPco1FRxn2SoHPKaahjlNGUpxfQ821Yl1uxMINpdh+p3zych9qq
X-Google-Smtp-Source: AGHT+IHHemzLxeLUMG8/nYzOVnRQOJhwt+KswDgE2bL/9MkeZyGspToRNzYF/9xt03CRuCgLz0TmVw==
X-Received: by 2002:a17:906:494e:b0:a4e:69b5:9835 with SMTP id f14-20020a170906494e00b00a4e69b59835mr2677589ejt.6.1712011417805;
        Mon, 01 Apr 2024 15:43:37 -0700 (PDT)
Received: from mosaic.enunes.eu (ip-78-45-66-209.bb.vodafone.cz. [78.45.66.209])
        by smtp.gmail.com with ESMTPSA id c3-20020a170906340300b00a4739efd7cesm5796808ejb.60.2024.04.01.15.43.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Apr 2024 15:43:37 -0700 (PDT)
From: Erico Nunes <nunes.erico@gmail.com>
To: Qiang Yu <yuq825@gmail.com>,
	anarsoul@gmail.com,
	dri-devel@lists.freedesktop.org,
	lima@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	linux-kernel@vger.kernel.org,
	Erico Nunes <nunes.erico@gmail.com>
Subject: [PATCH 1/2] drm/lima: fix shared irq handling on driver remove
Date: Tue,  2 Apr 2024 00:43:28 +0200
Message-ID: <20240401224329.1228468-2-nunes.erico@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401224329.1228468-1-nunes.erico@gmail.com>
References: <20240401224329.1228468-1-nunes.erico@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

lima uses a shared interrupt, so the interrupt handlers must be prepared
to be called at any time. At driver removal time, the clocks are
disabled early and the interrupts stay registered until the very end of
the remove process due to the devm usage.
This is potentially a bug as the interrupts access device registers
which assumes clocks are enabled. A crash can be triggered by removing
the driver in a kernel with CONFIG_DEBUG_SHIRQ enabled.
This patch frees the interrupts at each lima device finishing callback
so that the handlers are already unregistered by the time we fully
disable clocks.

Signed-off-by: Erico Nunes <nunes.erico@gmail.com>
---
 drivers/gpu/drm/lima/lima_gp.c  | 2 ++
 drivers/gpu/drm/lima/lima_mmu.c | 5 +++++
 drivers/gpu/drm/lima/lima_pp.c  | 4 ++++
 3 files changed, 11 insertions(+)

diff --git a/drivers/gpu/drm/lima/lima_gp.c b/drivers/gpu/drm/lima/lima_gp.c
index 6b354e2fb61d..14c39be8da90 100644
--- a/drivers/gpu/drm/lima/lima_gp.c
+++ b/drivers/gpu/drm/lima/lima_gp.c
@@ -338,7 +338,9 @@ int lima_gp_init(struct lima_ip *ip)
 
 void lima_gp_fini(struct lima_ip *ip)
 {
+	struct lima_device *dev = ip->dev;
 
+	devm_free_irq(dev->dev, ip->irq, ip);
 }
 
 int lima_gp_pipe_init(struct lima_device *dev)
diff --git a/drivers/gpu/drm/lima/lima_mmu.c b/drivers/gpu/drm/lima/lima_mmu.c
index e18317c5ca8c..6611e2836bf0 100644
--- a/drivers/gpu/drm/lima/lima_mmu.c
+++ b/drivers/gpu/drm/lima/lima_mmu.c
@@ -118,7 +118,12 @@ int lima_mmu_init(struct lima_ip *ip)
 
 void lima_mmu_fini(struct lima_ip *ip)
 {
+	struct lima_device *dev = ip->dev;
+
+	if (ip->id == lima_ip_ppmmu_bcast)
+		return;
 
+	devm_free_irq(dev->dev, ip->irq, ip);
 }
 
 void lima_mmu_flush_tlb(struct lima_ip *ip)
diff --git a/drivers/gpu/drm/lima/lima_pp.c b/drivers/gpu/drm/lima/lima_pp.c
index d0d2db0ef1ce..84bec163c9ed 100644
--- a/drivers/gpu/drm/lima/lima_pp.c
+++ b/drivers/gpu/drm/lima/lima_pp.c
@@ -286,7 +286,9 @@ int lima_pp_init(struct lima_ip *ip)
 
 void lima_pp_fini(struct lima_ip *ip)
 {
+	struct lima_device *dev = ip->dev;
 
+	devm_free_irq(dev->dev, ip->irq, ip);
 }
 
 int lima_pp_bcast_resume(struct lima_ip *ip)
@@ -319,7 +321,9 @@ int lima_pp_bcast_init(struct lima_ip *ip)
 
 void lima_pp_bcast_fini(struct lima_ip *ip)
 {
+	struct lima_device *dev = ip->dev;
 
+	devm_free_irq(dev->dev, ip->irq, ip);
 }
 
 static int lima_pp_task_validate(struct lima_sched_pipe *pipe,
-- 
2.44.0


