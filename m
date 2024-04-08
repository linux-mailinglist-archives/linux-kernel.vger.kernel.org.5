Return-Path: <linux-kernel+bounces-135737-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1B089CA94
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 19:16:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26686288DA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 196C5143C49;
	Mon,  8 Apr 2024 17:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eT5DjDd5"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD9C142E9F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 17:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712596572; cv=none; b=d4Ga6HudmKvqcFRyEZXkbMz8JsBQi0UxQ4eEfXib6XtDTIFECBOoQRE3IBcp5G+F63Hs5EYuGS/s66B5Ecpl6CpMmSyeedVebiJfWCbeTo/CG1pCVJpgDLZfwoiuyuMJU6wWmOkEf6sQbi/UvgW8eFyExtLPC3U3hL/DtIsEekk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712596572; c=relaxed/simple;
	bh=SaCsVCzVf4qxv3ByikrvVOhuEnEE/taKiCJQLeHbC/Y=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=kNHmkk5qkJETIda6axBXIOsIqhbMBktDP+d63hcMPWyb1OJTfDLgl2EMWs48SZ6qJdz0sxqRmrI03TIarB3fWgZJJ06yEnLRlM5P6amTayRZtT6XSlcbktydDjr8PA/SDLQXJL6LCzz0RdAkydehsFXn2YOmOWsm22slKHGJzu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eT5DjDd5; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-343e7c20686so2575764f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 10:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712596569; x=1713201369; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Z/MHDC/Igjk4t4nZzuD7aGsRzLn8MSL7qY/uwxsEKAQ=;
        b=eT5DjDd59ImyOaDxSV8uqDq8C10qrDlL04oKaczOcSlyVYtuZ4a6SeTutAtA9h1Czw
         lsRIGgI2/brdzid+qxPSu32FaHlxx2r8viQ2Qw9HBCTMYE8ZhXVKT5lMvWLZgTz6CuIG
         v+F3QINYPHhLdEZu8pKBHfiEnLm4QYVZLBR6aNLzm7ennAbgPTO+craFg0c8FaS92e2n
         WY3b5244QTcRueUvL7lGJjFyGevs6mZ3jwS8BlKAdBYmhG5TK9d8Gc/W0RX5L7dKGx8a
         nq08vVQnF4uRUEOT9RHIjniK+0Kh5VB2aowW2FQm2YF/kj2rNNVT/fXYwh16mcrY9mjs
         IttA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712596569; x=1713201369;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z/MHDC/Igjk4t4nZzuD7aGsRzLn8MSL7qY/uwxsEKAQ=;
        b=bfObOBl9FBBShUVkYjDOQP+yu5TI5eBaf7kdycpb4uH+kSHQzfSCfCWDcv4hcAY7T7
         JiFD8Apev3JrT9LjIRcZhKofokkt/nmVrxE4nXDXBdNOTLshgr+sJk9lFNVfz0Q6qBP+
         3hShs7RayDJbfONpl78tU7jDrWQrQKbdY0ALvOpwbim+NXULKXFo6MHYuZdvqMvDHd/o
         i8UMYjv93xyasMUhOYQa4V6KmNWdKKO5XkiAiXZJUPzQHXVTZ6+q3PSQCHoHE4MLrG7X
         VImQR9Gzax8vMnHY5IrmjXpbAK1V1fObxtshrJn/a2cuU4tSoh4ASUwEegQkiVERcLLj
         LxuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVxoNmx41yOktVV7ima4hEvqHdWjUifQn0jOg2epOV0sxP/Ku8LRy9M25EenqlDd4oFkRMibkZ9hCKpWEwZWT8pZpw6DJCvA7gJevih
X-Gm-Message-State: AOJu0YzUrJtNVErrc4NENocy6JQq8Pr4wA9mCukvbrDXrRcJDl5zQD0y
	s3hzOOqRenith5FinNKSIEh6Esty/s3rMh1C8A45z8NSYMcH0vaBqjSjM7lMwP0fnGhl0i1Hy6Y
	L6o6fAm4MX8he5yBkYRCEybbRFFA=
X-Google-Smtp-Source: AGHT+IHEKZWh5orZ4XPPFfsWqaRfB/CBsxW2Nv4wV+6virLOPv0C2g5dW/Tx1fVt3NVryKgyJV1uQMwwyeCfjtnsS9A=
X-Received: by 2002:adf:cf0f:0:b0:343:7fa6:4393 with SMTP id
 o15-20020adfcf0f000000b003437fa64393mr6935742wrj.38.1712596568173; Mon, 08
 Apr 2024 10:16:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: broler Liew <brolerliew@gmail.com>
Date: Tue, 9 Apr 2024 01:15:57 +0800
Message-ID: <CAODyvywHfmeFJP_obZB=dWcaibH_1RRGX=+CSVwcdfjSLMbJ4A@mail.gmail.com>
Subject: [PATCH] drm/amdgpu: remove "num_pages" local variable in amdgpu_gtt_mgr_new
To: alexander.deucher@amd.com
Cc: =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
	Xinhui.Pan@amd.com, David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, Luben Tuikov <luben.tuikov@amd.com>, 
	brolerliew <brolerliew@gmail.com>
Content-Type: text/plain; charset="UTF-8"

amdgpu_gtt_mgr_new and ttm_range_man_alloc share similar logic, but
"num_pages" in amdgpu_gtt_mgr_new is defined as local variable which
is calculate directly in ttm_range_man_alloc.

Signed-off-by: brolerliew <brolerliew@gmail.com>
---
drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c | 3 +--
1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
index 44367f03316f..0c56e4057d85 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gtt_mgr.c
@@ -116,7 +116,6 @@ static int amdgpu_gtt_mgr_new(struct
ttm_resource_manager *man,
                             struct ttm_resource **res)
{
       struct amdgpu_gtt_mgr *mgr = to_gtt_mgr(man);
-       uint32_t num_pages = PFN_UP(tbo->base.size);
       struct ttm_range_mgr_node *node;
       int r;

@@ -134,7 +133,7 @@ static int amdgpu_gtt_mgr_new(struct
ttm_resource_manager *man,
       if (place->lpfn) {
               spin_lock(&mgr->lock);
               r = drm_mm_insert_node_in_range(&mgr->mm, &node->mm_nodes[0],
-                                               num_pages, tbo->page_alignment,
+
PFN_UP(node->base.size), tbo->page_alignment,
                                               0, place->fpfn, place->lpfn,
                                               DRM_MM_INSERT_BEST);
               spin_unlock(&mgr->lock);
--
2.40.1

