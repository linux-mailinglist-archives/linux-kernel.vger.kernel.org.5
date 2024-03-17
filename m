Return-Path: <linux-kernel+bounces-105476-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D51D287DED0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 17:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7355E1F2102E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 16:36:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5171163B3;
	Sun, 17 Mar 2024 16:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJspmLiE"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCC321CD2B
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 16:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710693381; cv=none; b=NloheXSbOlJu+50pRlX/p3KV9aq64OWH2q1F/q2ubXdGaJ5FWOfjM+EavyeKyKE74s6Gmpz1SrlIfikmw7qTO+y4D8IX/0B/BQAMVmDB7QcNqsslzARkMX9sHJs2uNQCAIWQzWhSnU1V9xIB0qSOlFdU20gG1VD36O472hmpdUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710693381; c=relaxed/simple;
	bh=cTjsb0/BpLMT/X3BBcyyHdtQwgY4lAHAeXwhRuC8FwI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=BHmC0ggiJUm0AWsDSS7A/qfsABNqV1+GLjorfM0bUayVbVwffVnNk3ZZvfhzGrmzPHoctSPLmj33eELJL8301nCt+ae49ZPHLmhEKoFCkI2+VdguArXZdvuaryRAI+s04DG3+mD1eFI5AQdxtRyy/eSBcu82UWnoWpgP6CGhotc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJspmLiE; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6e6b6e000a4so2548474b3a.0
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 09:36:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710693378; x=1711298178; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=OF79KXhVjtXexZ/GpI6MkY7a20tX+4xRmIvmqST+AnU=;
        b=WJspmLiEns4Ew4BhQ02pRuQxr7/PLduRMufjjKmfSIvHrZ8a2cWEkjplHcm71r2Juy
         9XryTa1v2GtnCTSfiyl8CPJdd6lG5YRZ6C8EFiRXIeImTmvKwdEhBkpUhfKNNcSVmLwU
         +1Azh2SVAcqjfx2hYEOlttCD2BbparbUSjT7tSbvPY43wnpvV45qep1aNWQst5XO08gK
         tmNu3YNGjmlQRKMqvJ15eDvy2xPqDXF+LvGG8a7A7aCnGPSJGoU+HpHOZtw2rFIqM5Zr
         uqF8dg9IP+CuGKOttZo1jcMkHfm/nQ7ocjQp3cTpl+MHZFLlgkeyhfFiW5Sof6FlJX19
         RQvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710693378; x=1711298178;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OF79KXhVjtXexZ/GpI6MkY7a20tX+4xRmIvmqST+AnU=;
        b=ElvKI8fONbnx3xK+pnKkxPiLTfw3U5Ej5GMnUsw0RUaj7m0PUAhWZgG0xn2uLICkau
         WLPmoAURrEF1OWDP6FqtcmDCw32zA2OKZ/+cirlGqmUximyxOPQXk/DkjwqSjFvf9c37
         RKIqWVWfo/cw8Fw0Oz50XTH5VRpOWmrCv0HRiSUCfBF3xuRtxOb6hrLnY4Bph/TVHh+6
         o960hqITE+nvEpjxPtlG/9UYhuzCDrzq3jNaGSZ3YFvfKOmisj1EF6x5Tu7oxYFCrhKR
         C3MsWANitUOU10YIMDQxnE4RuFjB1o5MGJkRCSrJ0LOHeKyx598+9+/r/6CNfg5ATiIM
         AU0Q==
X-Forwarded-Encrypted: i=1; AJvYcCW+hgB7CvwkQareHk5DxjAoitpczfSuVD7oVwZMAj1vkZDiuqZ5Oa+BUk4WQQ+whLKDnElNWOO1ziBAuD7ElmApQIn+yUpB2JRJzc5Z
X-Gm-Message-State: AOJu0YxV6NcBf/s6EQdC+hfqOdPctU3CrtIZffO9qUbvqhS+IIRscAUf
	6nVCXRMgaTPpkoUSV2wRvZ5uy2q81bojYCLwbVVFv+YD8pe3vQws6ec/WQO8
X-Google-Smtp-Source: AGHT+IGa2J0FGsz6KPc52ig70pMekzfNXoYYgf9jnNcxMqsM/th4nXVjaLrcgxRudeFE0v35xphm8A==
X-Received: by 2002:a05:6a20:e123:b0:1a3:4ff4:219b with SMTP id kr35-20020a056a20e12300b001a34ff4219bmr9172546pzb.12.1710693378049;
        Sun, 17 Mar 2024 09:36:18 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p24-20020aa78618000000b006e4f311f61bsm6373725pfn.103.2024.03.17.09.36.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 09:36:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From: Guenter Roeck <linux@roeck-us.net>
To: Maxime Ripard <mripard@kernel.org>
Cc: Chen-Yu Tsai <wens@csie.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH] drm/sun4i: Drop COMPILE_TEST
Date: Sun, 17 Mar 2024 09:36:15 -0700
Message-Id: <20240317163615.563428-1-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Attempts to build the sun4i drm code on various architectures using gcc 11.x
or older fails with

ERROR: modpost: "__udivdi3" [drivers/gpu/drm/sun4i/sun4i-drm-hdmi.ko] undefined!

This is due to commit 358e76fd613a ("drm/sun4i: hdmi: Consolidate
atomic_check and mode_valid") which introduces a constant 64-bit divide
operation. Some compilers / compiler versions fail to translate this
operation into fixed code.

Manual exclusion lists such as "Only build test this code on this subset of
architectures" or "Do not test this code on this set of architectures"
do not scale. Remove COMPILE_TEST support for the suni4 drm driver instead
to ensure that test builds are only performed on supported architectures.

Fixes: 358e76fd613a ("drm/sun4i: hdmi: Consolidate atomic_check and mode_valid")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/gpu/drm/sun4i/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sun4i/Kconfig b/drivers/gpu/drm/sun4i/Kconfig
index 4741d9f6544c..015539bfda2a 100644
--- a/drivers/gpu/drm/sun4i/Kconfig
+++ b/drivers/gpu/drm/sun4i/Kconfig
@@ -2,7 +2,7 @@
 config DRM_SUN4I
 	tristate "DRM Support for Allwinner A10 Display Engine"
 	depends on DRM && COMMON_CLK
-	depends on ARCH_SUNXI || COMPILE_TEST
+	depends on ARCH_SUNXI
 	select DRM_GEM_DMA_HELPER
 	select DRM_KMS_HELPER
 	select DRM_PANEL
-- 
2.39.2


