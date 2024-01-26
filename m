Return-Path: <linux-kernel+bounces-40218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A1C83DCA6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB4D51C21CC3
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:44:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497331C6BE;
	Fri, 26 Jan 2024 14:44:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sjDAQtvm"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905911C2AE
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706280283; cv=none; b=ON0j+IboTtebKw66GBQBkzfDJtzGn7iMbIf233JANr1DLZtfWNQoGDxvJfCAfkxf/y7DJYa/o7RNNilgi7wv3bDV3ivitNKXwAiefVuXhmbJXf1Nz7kMnYFuQ/s+nMF3iL+pgSS9X06IHKJYDJUPbeZK8ddq8St8rslP1R+LScw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706280283; c=relaxed/simple;
	bh=S/etbdxpdJbEcvSqL3E9/1O3DiFS9pqHuIWHhwxiDJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eHMjiABpFGS+g21/MwyH5VvigUBdTT510QphQOhh7lxTsqKu4BY8n6keMTNYCVJUpOWPya22QTCTyPe3aBZ0ZFcEuh7KCb4lAuUD16TGz1IsR1X7J1Aeh4h2vXA5d+5VZPv6KrCQDFlXmFJxnfxi2F7Lz304WGKt5/7l5MTUfp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sjDAQtvm; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33926ccbc80so346676f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706280280; x=1706885080; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i5B+fHMvjnJUN3quASTzUIwtKvGYeHenqNIe0ucdsRE=;
        b=sjDAQtvmxvznRV37dI/wMPUPtubbdaFZphZHfQlsgQ1lClAyR4VgxstdnVdoli1Ejv
         rOpWTt3vYQcE6bfxBFP+0hCq3qvWlEq4zMls1GEz9/yqghL/Pg/xEKYU9Yxy8P+wrGLj
         67/Jgx3hebNy803u4AbK2t0BjByOozdrxSbd13nLCW8dMvnOVtQCK1Nu/nWQ7KZDzC89
         /KxCniXX6kIEnzlEyJeqsZtOVR9SIFZGtOh6GJx0MVkK3DF0aWJoenK/Z1eLEV1/d5VJ
         J6wHUHu46JPgLidY8GwfpklC37H2vvW0giRebfTc98qT8CvbndOoq8ttoNMVJBrk57zP
         k16g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706280280; x=1706885080;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i5B+fHMvjnJUN3quASTzUIwtKvGYeHenqNIe0ucdsRE=;
        b=HUlutKpCo1YZcm89omzlh+pGL3q/ZOBroIg8yRWMp5qFq8bnI3CgENBUG5qbOmyDzb
         qdYCEZ/COYhnRK5wf5ij+JXcQjHWlljxhgeCIOXu086W15i3/O6YA9PPOk4+u3y/BztH
         mcpFx3Gqp3XizZLlb6Of1moxbIy23wWisYhoUTT35pp4rfg7hJnyxPVUSyrcbx6ydvzp
         IulxWDeLoPRD4yW/a4jh0FDVoxkstt9zzoeoxaZp8iG2El+dCex6wS8f+GGj2tpUeEmV
         69CeZIKrlQY7OyfQQzFrfZ4nAejhaQHvOXcnvKtHNvNl1DuTzV8bFxrM3FNjEagyy/HI
         zoHw==
X-Gm-Message-State: AOJu0YzC6gh1YoDhH7fIQB8YojSOTVMmml4de8tXdwVL4SB4WkXOXcCH
	UOEt8LgCojowacMGwtAozU+PJ+YX9wPnGAWHDX/TTbm0lMLMEvjDvhc2E9+AXQ==
X-Google-Smtp-Source: AGHT+IERvL8VWBU0pIT6Hmg6/b0+n3elHgZZdlfzUMyAnnic5sMEMijkPnCj31BtoZQBu1KA6TJrWA==
X-Received: by 2002:adf:f10e:0:b0:337:9d3b:c180 with SMTP id r14-20020adff10e000000b003379d3bc180mr1855231wro.4.1706280279513;
        Fri, 26 Jan 2024 06:44:39 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:3837:e733:e624:7fe2])
        by smtp.gmail.com with ESMTPSA id f15-20020a056000036f00b00337d84efaf7sm1415718wrf.74.2024.01.26.06.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:44:38 -0800 (PST)
Date: Fri, 26 Jan 2024 15:44:33 +0100
From: Marco Elver <elver@google.com>
To: Andrey Konovalov <andreyknvl@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Potapenko <glider@google.com>,
	Dmitry Vyukov <dvyukov@google.com>,
	Vlastimil Babka <vbabka@suse.cz>,
	Andrey Ryabinin <ryabinin.a.a@gmail.com>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
	linux-mm@kvack.org
Subject: Re: [PATCH 2/2] kasan: revert eviction of stack traces in generic
 mode
Message-ID: <ZbPFUXNeENyuwync@elver.google.com>
References: <20240125094815.2041933-1-elver@google.com>
 <20240125094815.2041933-2-elver@google.com>
 <CA+fCnZc6L3t3AdQS1rjFCT0s6RpT+q4Z4GmctOveeaDJW0tBow@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZc6L3t3AdQS1rjFCT0s6RpT+q4Z4GmctOveeaDJW0tBow@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, Jan 25, 2024 at 11:36PM +0100, Andrey Konovalov wrote:
[...]
> 
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> 
> But I'm wondering if we should also stop resetting metadata when the
> object is fully freed (from quarantine or bypassing quarantine).
> 
> With stack_depot_put, I had to put the stack handles on free, as
> otherwise we would leak the stack depot references. And I also chose
> to memset meta at that point, as its gets invalid anyway. But without
> stack_depot_put, this is not required.
> 
> Before the stack depot-related changes, the code was inconsistent in
> this regard AFAICS: for quarantine, free meta was marked as invalid
> via KASAN_SLAB_FREE but alloc meta was kept; for no quarantine, both
> alloc and free meta were kept.
> 
> So perhaps we can just keep both metas on full free. I.e. drop both
> kasan_release_object_meta calls. This will go back to the old behavior
> + keeping free meta for the quarantine case (I think there's no harm
> in that). This will give better reporting for uaf-before-realloc bugs.
> 
> WDYT?

Yes, that makes sense.

You mean this on top?

diff --git a/mm/kasan/common.c b/mm/kasan/common.c
index ad32803e34e9..0577db1d2c62 100644
--- a/mm/kasan/common.c
+++ b/mm/kasan/common.c
@@ -264,12 +264,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object,
 	if (kasan_quarantine_put(cache, object))
 		return true;
 
-	/*
-	 * If the object is not put into quarantine, it will likely be quickly
-	 * reallocated. Thus, release its metadata now.
-	 */
-	kasan_release_object_meta(cache, object);
-
 	/* Let slab put the object onto the freelist. */
 	return false;
 }
diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
index 8bfb52b28c22..fc9cf1860efb 100644
--- a/mm/kasan/generic.c
+++ b/mm/kasan/generic.c
@@ -510,20 +510,6 @@ static void release_free_meta(const void *object, struct kasan_free_meta *meta)
 	*(u8 *)kasan_mem_to_shadow(object) = KASAN_SLAB_FREE;
 }
 
-void kasan_release_object_meta(struct kmem_cache *cache, const void *object)
-{
-	struct kasan_alloc_meta *alloc_meta;
-	struct kasan_free_meta *free_meta;
-
-	alloc_meta = kasan_get_alloc_meta(cache, object);
-	if (alloc_meta)
-		release_alloc_meta(alloc_meta);
-
-	free_meta = kasan_get_free_meta(cache, object);
-	if (free_meta)
-		release_free_meta(object, free_meta);
-}
-
 size_t kasan_metadata_size(struct kmem_cache *cache, bool in_object)
 {
 	struct kasan_cache *info = &cache->kasan_info;
diff --git a/mm/kasan/kasan.h b/mm/kasan/kasan.h
index 216ae0ef1e4b..fb2b9ac0659a 100644
--- a/mm/kasan/kasan.h
+++ b/mm/kasan/kasan.h
@@ -390,10 +390,8 @@ struct kasan_alloc_meta *kasan_get_alloc_meta(struct kmem_cache *cache,
 struct kasan_free_meta *kasan_get_free_meta(struct kmem_cache *cache,
 						const void *object);
 void kasan_init_object_meta(struct kmem_cache *cache, const void *object);
-void kasan_release_object_meta(struct kmem_cache *cache, const void *object);
 #else
 static inline void kasan_init_object_meta(struct kmem_cache *cache, const void *object) { }
-static inline void kasan_release_object_meta(struct kmem_cache *cache, const void *object) { }
 #endif
 
 depot_stack_handle_t kasan_save_stack(gfp_t flags, depot_flags_t depot_flags);
diff --git a/mm/kasan/quarantine.c b/mm/kasan/quarantine.c
index 3ba02efb952a..a758c2e10703 100644
--- a/mm/kasan/quarantine.c
+++ b/mm/kasan/quarantine.c
@@ -145,8 +145,6 @@ static void qlink_free(struct qlist_node *qlink, struct kmem_cache *cache)
 	void *object = qlink_to_object(qlink, cache);
 	struct kasan_free_meta *free_meta = kasan_get_free_meta(cache, object);
 
-	kasan_release_object_meta(cache, object);
-
 	/*
 	 * If init_on_free is enabled and KASAN's free metadata is stored in
 	 * the object, zero the metadata. Otherwise, the object's memory will

