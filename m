Return-Path: <linux-kernel+bounces-159171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF41C8B2A36
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:55:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3CD61C2263D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC3E154436;
	Thu, 25 Apr 2024 20:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CaJ1lSq+"
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD526AD2D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714078527; cv=none; b=ehH4xNYw15tciZb9R/mOU/4V1U2o+dvbDCdvuIjOCylIwgSWGL6ZlLLA4ioI+5qf1LJx3TAg+1TrdYSXHeZe21sEpKND4c9gCUMq0rUads8XVhIUlcfVrwmxfExpJ5ueZNMXsTKFh4xkwdh9ZZe7/aji5fSpACGhz+jZO1CCvKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714078527; c=relaxed/simple;
	bh=wgzxsbZYA35UmV3+kDlEwfXFaeOy97jxAsm3UECTe0s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rfCSqK17xTQ1i7xIJfAGYiNNqqHJ5IjIRqwg52icpegO6wHwHssC448V52exwyOLfQnCraFlGdzA2FKMHtUaeIQpzmndFUj2rUQCXnknk9faAQYdiRaJvJB/GfaMPlOGr8LyoQOuBK8qvlADmeSrs6ppyDHHWsAu/aScf01VCWw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=CaJ1lSq+; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2ab791bce6fso1069140a91.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:55:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714078525; x=1714683325; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ISz6479faSwg2T6S4jx3WNpGT6tzmgyY9eqAE3NqtuI=;
        b=CaJ1lSq+Gqzw4/LuxmkVsFvpwIdsIGo9M6Yf+Bd92mSxeEjrBMyh3e6Q69/BHMCeY4
         hgMpb4ZlKGaWJuhxt5Zr+6hPR4SBa++Wz5AZlui54vm5NCMdtfDA1NGvCvTLTWiyPHI6
         gDMq5majUry4ndbAJwiZ5t+ulVVeOmjJBVCnU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714078525; x=1714683325;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ISz6479faSwg2T6S4jx3WNpGT6tzmgyY9eqAE3NqtuI=;
        b=fjWF3SnidlxYSZmv7MYa1qWot5I+ClCxq/4xKnZmFCy1Csyx48XSMkoRt8dpgyAYy7
         RmA0JdbZGomW7fCgc5VDqLgGzUT5/BR1NPwkrxClMwQQ3iIuZTJvFudKVHNEMXkDgPyd
         aO6ZXGzjYcPZwqNqfrCiuTVw14jhS6VMXQdPh+PU4gNHH9AFezh98hMs+LCGY3jVOWl/
         +ScMXi3va99Lvl/iWXQ4gMotwvRUGL1356eLi3S6U4oLX2KFFCBVKEY+xSS1vbmm2Tdb
         2L8lLyjXbsu+UcVDFe04y6arl425E7rFfFhWOjyMRK3J1RTBMj8B1/GI+SsGotY5PT2H
         wJbg==
X-Forwarded-Encrypted: i=1; AJvYcCXvzuMLCSos7q8Cj4cxW8FvQ1qRFxhjYK9bbDlmI2K8D0wmJbtFF66V5czyn7BA9FQSNDoqvN4zgGUBZVeII/K3/ymjJzJULTbJCsRQ
X-Gm-Message-State: AOJu0YxsXQ7KdCpHjC0ymiS/bM+BIOtwhCalaJpK/j5fPUjswYcJeuJb
	JQteaClgpZHqFbT+YLyYtzi1G7TgHLAN1QoAu37VCKwLJbnRoEVfM1PU0nyOZQ==
X-Google-Smtp-Source: AGHT+IGuak1A5s4buRECAohF0iWefXrhA28ayIjCoI5pRSndED0RKVF3MGtMAQ81PA5K/hyZWPPbQg==
X-Received: by 2002:a17:90a:654c:b0:2ac:dbec:2d6f with SMTP id f12-20020a17090a654c00b002acdbec2d6fmr783550pjs.39.1714078525060;
        Thu, 25 Apr 2024 13:55:25 -0700 (PDT)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id cn19-20020a17090af09300b002a2b06ce909sm14996316pjb.17.2024.04.25.13.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:55:24 -0700 (PDT)
From: Kees Cook <keescook@chromium.org>
To: Suren Baghdasaryan <surenb@google.com>
Cc: Kees Cook <keescook@chromium.org>,
	Kent Overstreet <kent.overstreet@linux.dev>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <cl@linux.com>,
	Pekka Enberg <penberg@kernel.org>,
	David Rientjes <rientjes@google.com>,
	Joonsoo Kim <iamjoonsoo.kim@lge.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Roman Gushchin <roman.gushchin@linux.dev>,
	Hyeonggon Yoo <42.hyeyoo@gmail.com>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH] mm/slub: Avoid recursive loop with kmemleak
Date: Thu, 25 Apr 2024 13:55:23 -0700
Message-Id: <20240425205516.work.220-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2235; i=keescook@chromium.org;
 h=from:subject:message-id; bh=wgzxsbZYA35UmV3+kDlEwfXFaeOy97jxAsm3UECTe0s=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBmKsM6HVptwlfHLpIq5pI6IWcjLcoSkU3RtMyDq
 ARbu9SC/s2JAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZirDOgAKCRCJcvTf3G3A
 JuDSEAC0l2PUgYlxj4pnnLraH/55sLfoMFhtLob3K/MWGueyTyye50pQtaI15ClOF/OhkH+MqSK
 rzq16NGHmNk78CCUeoVXnLRz9PDmsolxQD9MigPFQP6eKHIK5hFcWhPCR5ijm7oZf9bPp1jTOYa
 dlVKyNyeuZek6H1+X90JoyTdyg7UT9ls3CRTTRV8aGcBUtxlG+QsWB6atAvQRpPggUqSovoR/CJ
 8Y6GBikQb/3K85EQNcSwFF1cL63srGhveek31TGCFAF24rPFhbzyH4qS58OOW0R7tBjnESSQJTr
 XXmlqcmRWv/eWjNtTjcJD7R4Fw6iBhUelgzjDMsXw6wtGiV89VGe5wXxC8KheuUfihbSGwQAVdZ
 EH2koc3B9KhvYljNjnUQroDA3BASbFktma2rYYcScRfDi80Vnpt8/1OYjtqFj9wOLx4RF23WfXQ
 dOBKxl+1oxl4icrWM9Fw7jfXr4w00CMTwXYDYqrKRm4AQ3pl8gYFEwDUiPDxKpoHs0j5OKrGGNA
 aK3HASaKRX7fb6aMPPqsfg3fdiCk/rhiLzVCk7KbjibPt1r4nhpPwTe3Giu31YIdYbYKFCji2ZP
 plrAm71N0FQ2N/FetOqaIoPsvbc2H4NzOu8ysPNslnEFA7Z+Fp+MnCYzu/VJi0jjB7mSIN9ZynJ
 +ysUJzG Op1iR2+w==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

The system will immediate fill up stack and crash when both
CONFIG_DEBUG_KMEMLEAK and CONFIG_MEM_ALLOC_PROFILING are enabled.
Avoid allocation tagging of kmemleak caches, otherwise recursive
allocation tracking occurs.

Fixes: 279bb991b4d9 ("mm/slab: add allocation accounting into slab allocation and free paths")
Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Suren Baghdasaryan <surenb@google.com>
Cc: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Christoph Lameter <cl@linux.com>
Cc: Pekka Enberg <penberg@kernel.org>
Cc: David Rientjes <rientjes@google.com>
Cc: Joonsoo Kim <iamjoonsoo.kim@lge.com>
Cc: Vlastimil Babka <vbabka@suse.cz>
Cc: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Hyeonggon Yoo <42.hyeyoo@gmail.com>
Cc: linux-mm@kvack.org
---
 mm/kmemleak.c | 4 ++--
 mm/slub.c     | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/kmemleak.c b/mm/kmemleak.c
index c55c2cbb6837..fdcf01f62202 100644
--- a/mm/kmemleak.c
+++ b/mm/kmemleak.c
@@ -463,7 +463,7 @@ static struct kmemleak_object *mem_pool_alloc(gfp_t gfp)
 
 	/* try the slab allocator first */
 	if (object_cache) {
-		object = kmem_cache_alloc(object_cache, gfp_kmemleak_mask(gfp));
+		object = kmem_cache_alloc_noprof(object_cache, gfp_kmemleak_mask(gfp));
 		if (object)
 			return object;
 	}
@@ -947,7 +947,7 @@ static void add_scan_area(unsigned long ptr, size_t size, gfp_t gfp)
 	untagged_objp = (unsigned long)kasan_reset_tag((void *)object->pointer);
 
 	if (scan_area_cache)
-		area = kmem_cache_alloc(scan_area_cache, gfp_kmemleak_mask(gfp));
+		area = kmem_cache_alloc_noprof(scan_area_cache, gfp_kmemleak_mask(gfp));
 
 	raw_spin_lock_irqsave(&object->lock, flags);
 	if (!area) {
diff --git a/mm/slub.c b/mm/slub.c
index a94a0507e19c..9ae032ed17ed 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -2016,7 +2016,7 @@ prepare_slab_obj_exts_hook(struct kmem_cache *s, gfp_t flags, void *p)
 	if (!p)
 		return NULL;
 
-	if (s->flags & SLAB_NO_OBJ_EXT)
+	if (s->flags & (SLAB_NO_OBJ_EXT | SLAB_NOLEAKTRACE))
 		return NULL;
 
 	if (flags & __GFP_NO_OBJ_EXT)
-- 
2.34.1


