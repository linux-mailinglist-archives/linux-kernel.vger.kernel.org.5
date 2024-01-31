Return-Path: <linux-kernel+bounces-45579-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1828C8432A1
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 02:15:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8F2128763C
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:15:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8111D2916;
	Wed, 31 Jan 2024 01:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ed5glmhA"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6327C1C20;
	Wed, 31 Jan 2024 01:15:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706663742; cv=none; b=dF3uU8IBHHqqqyKf11+UEIrAlikNk+RlTQZDxOfvbLk+DdkhAql9cAfFDfand1auh+tcsbYYNYPQl9we6kaUG61r99E4m0yOtguP7WEO6gA8iD8d5ZOYNZBq9g5Nbtf9+XdtfHtHmv77v4jHRHFBhuyx4usfdD6ScRqg/rzLjQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706663742; c=relaxed/simple;
	bh=/pTzJOK51v+5SYhIFOmecoVuKff4pmOxFD7hGsAarAo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U2WZQygybQBAOrJYz00MtvGf415LE5G/4YcvgpbNyvqhyK96jFtct0kQHsbm7ohB88sRQGceqt3+BY69g21NEedbhlb8TjBqsaDiDmIDgyNdkLjXXj0crDNmumzTtPT+L/r3EDTb/OCe0cZsvMUfbxDNTNO6MSOwxpqpxSSNeM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ed5glmhA; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d7858a469aso26581045ad.2;
        Tue, 30 Jan 2024 17:15:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706663740; x=1707268540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TMI3cnWrauJ0sVrAPWjosebBGINiaEuvqhQTmdIHpwU=;
        b=ed5glmhAauN1DdTP9WSelwo27ZmJ3DFMPnWR+X86+VV8YkHOSNjVNSR11ovk2TMCGy
         GirQdV64Ytk5hE5+8lv09bxszn1qWPS4HJc8krbYVXOYlbPjE0krswZB39bbQ9PiiXMi
         27hObmpnQVaLYtOEwFuKWDaW3u+rR5WwBNHsS0Qus879Pbc+9yDOyrPOgj0cnAo3keZJ
         34XR4usdxYewBYMqGyX3QPj3bJWcAktwErWy2E2qXGIldcc4rBKfErAERP0xa4JGmT2k
         64ZUVlrgmCCJJabMPd5QXWlES8kz95hvsoNF42crApIARaaiIijdGcfd0QOMPeHQGZrH
         6PQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706663740; x=1707268540;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TMI3cnWrauJ0sVrAPWjosebBGINiaEuvqhQTmdIHpwU=;
        b=asmnSjoaV1fJm1zmIk9/vGFH+dkp6YhV3XC3Zje8v8V0nanLaVW5MIGdRviZ+YHE2O
         mr1MpIRVy4qz+1LSyyLgafhZUYgAsPuXLsD9oYCGDFlMVAPz7S8zbpxusfpJK8Etdvih
         UpFcbAS1mwioXkrzArJwkaDeRPEiDanda01sLpUewszloHcVVl6xp5DHIWK92cP5ylAd
         iHdq1J73XnwtEiCPwuc9SnKgPyA53dIJq/kqIuECxo11VDMJWXWRspkfbbLjS8IXE1No
         MtWLw8o1GlUkQkN76sVuSvG/p8Cqm2NewJ36d2yzYOTbRzhCIixbqbDlwTwF9mH5OgSc
         apSg==
X-Gm-Message-State: AOJu0YwlWu5iRn9TAao73sogSNyiwv0OBinY91MBv8YPcKVxvVGmCKiz
	tbnxyNM83MMz8RyVolvdSACkqun8aeE4Uc3nnYHyLdbZbCI3t/44
X-Google-Smtp-Source: AGHT+IG8UGKG/Zt1rkUy45qpAPEJlPjYqNZszRCvj1fmkMfo62fVTpD1GY8zqyGU1X8ERHaQ08XHGA==
X-Received: by 2002:a17:902:e805:b0:1d8:d01b:571e with SMTP id u5-20020a170902e80500b001d8d01b571emr246288plg.33.1706663740422;
        Tue, 30 Jan 2024 17:15:40 -0800 (PST)
Received: from localhost ([2601:1c0:5000:d5c:ae1c:de46:682a:206])
        by smtp.gmail.com with ESMTPSA id t18-20020a170902d29200b001d8d6ec2d7fsm4866303plc.61.2024.01.30.17.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jan 2024 17:15:39 -0800 (PST)
From: Rob Clark <robdclark@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: linux-arm-msm@vger.kernel.org,
	freedreno@lists.freedesktop.org,
	Rob Clark <robdclark@chromium.org>,
	Rob Clark <robdclark@gmail.com>,
	Abhinav Kumar <quic_abhinavk@quicinc.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>,
	Daniel Vetter <daniel@ffwll.ch>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sumit Semwal <sumit.semwal@linaro.org>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH v2] drm/msm/gem: Fix double resv lock aquire
Date: Tue, 30 Jan 2024 17:15:37 -0800
Message-ID: <20240131011537.31049-1-robdclark@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rob Clark <robdclark@chromium.org>

Since commit 56e5abba8c3e ("dma-buf: Add unlocked variant of vmapping
functions"), the resv lock is already held in the prime vmap path, so
don't try to grab it again.

v2: This applies to vunmap path as well

Fixes: 56e5abba8c3e ("dma-buf: Add unlocked variant of vmapping functions")
Signed-off-by: Rob Clark <robdclark@chromium.org>
---
 drivers/gpu/drm/msm/msm_gem_prime.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/msm/msm_gem_prime.c b/drivers/gpu/drm/msm/msm_gem_prime.c
index 5f68e31a3e4e..0915f3b68752 100644
--- a/drivers/gpu/drm/msm/msm_gem_prime.c
+++ b/drivers/gpu/drm/msm/msm_gem_prime.c
@@ -26,7 +26,7 @@ int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
 	void *vaddr;
 
-	vaddr = msm_gem_get_vaddr(obj);
+	vaddr = msm_gem_get_vaddr_locked(obj);
 	if (IS_ERR(vaddr))
 		return PTR_ERR(vaddr);
 	iosys_map_set_vaddr(map, vaddr);
@@ -36,7 +36,7 @@ int msm_gem_prime_vmap(struct drm_gem_object *obj, struct iosys_map *map)
 
 void msm_gem_prime_vunmap(struct drm_gem_object *obj, struct iosys_map *map)
 {
-	msm_gem_put_vaddr(obj);
+	msm_gem_put_vaddr_locked(obj);
 }
 
 struct drm_gem_object *msm_gem_prime_import_sg_table(struct drm_device *dev,
-- 
2.43.0


