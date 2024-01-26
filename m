Return-Path: <linux-kernel+bounces-40163-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B219783DB71
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 15:08:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 374811F22A55
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 14:08:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2A261C28F;
	Fri, 26 Jan 2024 14:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h4rlFJ+M"
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B25E1BF5A
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 14:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706278098; cv=none; b=ufu+gTBB1urYDa7Y3/kIO+WfcMfrvDRB7Zs7gFDdo1tG/VyJ4vzEYhK0G+8DN7O4d9bWte4Fqxrfq3hJhSmdQNMmGMUCYenNSRnr6xSIrJWhwFgpLVYHUtmIQNd+lfHdC4HEg7ifijige8dHoxtDCAefKpnZHFHwpJrd0UtyW+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706278098; c=relaxed/simple;
	bh=XkaowBTfnLsJ+t9OmNiKhbdYwQRJbNS8IsIzn6HCgkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P9a97m2Yv2Ljw74sNkdWaHWv9wa7EfD+sWb2+woYoEvu9aig4ixkZ3EOQCOGCrhENxV3XXWJuXbQlCNAqOlkr42muqMu+Rrt5CTH2/ZOK441Bp/QfJzDxAwMeZnNa49ARTarvAAejblrBZZoNm6LApsfjS6AocJpWmwm28fG4Ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h4rlFJ+M; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40ee705e9e3so3821355e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 06:08:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706278094; x=1706882894; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/VI/OXzcFzlYXsdPLN9N03OpjAt6MEKivygrHh6SqEg=;
        b=h4rlFJ+MmxvgaymuWXt5eUQtOok3NnffbQyOWLKe54gqgKj+wn2Jit6Hxg3dkmCnWC
         qwRSGk+jYhUlWzWEgJ30fAVvd14LHasPdzHmfoqxTo2IYu6mZBLzWW31bSH/AvNJIeZH
         qgNb+Xt3/Tdm8TWsxkmh87H+h+oNfrJXf+PY/IeZxgdSwNKDsUxglrtWL1kig+s3QX8Z
         VF2wbfKR9e/SjZ9TG/AA0COv51qnUXgUphqXUfz0v6ld8cX2HnNwb278kzJMpCdtZe5w
         GSLvLf7qnmcPZpCtQClAlIvcnRu+xRwDZU9WVyQBnrAcmYHUmTCKr0LOCHW2pWLY3F1a
         BfzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706278094; x=1706882894;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/VI/OXzcFzlYXsdPLN9N03OpjAt6MEKivygrHh6SqEg=;
        b=bxm2cg7dAicVR5SQPYkYneDaoP1VoHfRpNXhS1ZJDv28JNY55Ei2kxikQ127syO5yV
         s7DwPFcJFhSY+sxQM2Tel6gU1M5+EajEk83Tk/RAesHvSil4uDbq0rawKf8SrGEdj5aC
         EYy0WZSlzr03eCmuSZIAuBZajuwkekYWszK1hS/K5lOA/8222Sa544ID+6FFjz9kPN42
         anKkXAIEaIY6Fy6b0IfU7KwP5xvUdi83rIX5fa33fS6oWhGhN8iUp0/zsg7GePMMYYXJ
         g9YSMEeIAXGOKAhi9s138PPKVWWHmw6LNq5FI9EfOEwY93fLLGjBGwI2jx+kjbXyhqK+
         nM7g==
X-Gm-Message-State: AOJu0YxaEt5NDOXiZAq0SJGG404WDqhaYP1b8Cxx352Bw1f9YWOrWySq
	UT3SMq3dsVkZTQM1fSY6QywYiDRZPdC7U4ZgWZp0Rc2X63Ad665GdPi42YHsUw==
X-Google-Smtp-Source: AGHT+IEuIgVMUDoiT2x4vpiW9DICFBzG/KvTN8gQG9YPJHasf4Ybq4Sh2N8x29vJZwfDAMNF0phVGg==
X-Received: by 2002:a05:600c:3421:b0:40e:c363:bc15 with SMTP id y33-20020a05600c342100b0040ec363bc15mr979356wmp.65.1706278094299;
        Fri, 26 Jan 2024 06:08:14 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:3837:e733:e624:7fe2])
        by smtp.gmail.com with ESMTPSA id k35-20020a05600c1ca300b0040e4ca7fcb4sm2013199wms.37.2024.01.26.06.08.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 06:08:13 -0800 (PST)
Date: Fri, 26 Jan 2024 15:08:08 +0100
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
Subject: Re: [PATCH 1/2] stackdepot: use variable size records for
 non-evictable entries
Message-ID: <ZbO8yD_ofPQ1Z2NT@elver.google.com>
References: <20240125094815.2041933-1-elver@google.com>
 <CA+fCnZfzpPvg3UXKfxhe8n-tT2Pqhfysy_HdrMb6MxaEtnJ2BQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CA+fCnZfzpPvg3UXKfxhe8n-tT2Pqhfysy_HdrMb6MxaEtnJ2BQ@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)

On Thu, Jan 25, 2024 at 11:35PM +0100, Andrey Konovalov wrote:
[...]
> I wonder if we should separate the stat counters for
> evictable/non-evictable cases. For non-evictable, we could count the
> amount of consumed memory.
[...]
> 
> We can also now drop the special case for DEPOT_POOLS_CAP for KMSAN.
> 
> Otherwise, looks good to me.
> 
> Reviewed-by: Andrey Konovalov <andreyknvl@gmail.com>
> 
> Thank you for cleaning this up!

Thanks - probably will add this change for v2:

diff --git a/lib/stackdepot.c b/lib/stackdepot.c
index 1b0d948a053c..8f3b2c84ec2d 100644
--- a/lib/stackdepot.c
+++ b/lib/stackdepot.c
@@ -44,17 +44,7 @@
 #define DEPOT_OFFSET_BITS (DEPOT_POOL_ORDER + PAGE_SHIFT - DEPOT_STACK_ALIGN)
 #define DEPOT_POOL_INDEX_BITS (DEPOT_HANDLE_BITS - DEPOT_OFFSET_BITS - \
 			       STACK_DEPOT_EXTRA_BITS)
-#if IS_ENABLED(CONFIG_KMSAN) && CONFIG_STACKDEPOT_MAX_FRAMES >= 32
-/*
- * KMSAN is frequently used in fuzzing scenarios and thus saves a lot of stack
- * traces. As KMSAN does not support evicting stack traces from the stack
- * depot, the stack depot capacity might be reached quickly with large stack
- * records. Adjust the maximum number of stack depot pools for this case.
- */
-#define DEPOT_POOLS_CAP (8192 * (CONFIG_STACKDEPOT_MAX_FRAMES / 16))
-#else
 #define DEPOT_POOLS_CAP 8192
-#endif
 #define DEPOT_MAX_POOLS \
 	(((1LL << (DEPOT_POOL_INDEX_BITS)) < DEPOT_POOLS_CAP) ? \
 	 (1LL << (DEPOT_POOL_INDEX_BITS)) : DEPOT_POOLS_CAP)
@@ -128,18 +118,22 @@ static DEFINE_RAW_SPINLOCK(pool_lock);
 
 /* Statistics counters for debugfs. */
 enum depot_counter_id {
-	DEPOT_COUNTER_ALLOCS,
-	DEPOT_COUNTER_FREES,
-	DEPOT_COUNTER_INUSE,
+	DEPOT_COUNTER_REFD_ALLOCS,
+	DEPOT_COUNTER_REFD_FREES,
+	DEPOT_COUNTER_REFD_INUSE,
 	DEPOT_COUNTER_FREELIST_SIZE,
+	DEPOT_COUNTER_PERSIST_COUNT,
+	DEPOT_COUNTER_PERSIST_BYTES,
 	DEPOT_COUNTER_COUNT,
 };
 static long counters[DEPOT_COUNTER_COUNT];
 static const char *const counter_names[] = {
-	[DEPOT_COUNTER_ALLOCS]		= "allocations",
-	[DEPOT_COUNTER_FREES]		= "frees",
-	[DEPOT_COUNTER_INUSE]		= "in_use",
+	[DEPOT_COUNTER_REFD_ALLOCS]	= "refcounted_allocations",
+	[DEPOT_COUNTER_REFD_FREES]	= "refcounted_frees",
+	[DEPOT_COUNTER_REFD_INUSE]	= "refcounted_in_use",
 	[DEPOT_COUNTER_FREELIST_SIZE]	= "freelist_size",
+	[DEPOT_COUNTER_PERSIST_COUNT]	= "persistent_count",
+	[DEPOT_COUNTER_PERSIST_BYTES]	= "persistent_bytes",
 };
 static_assert(ARRAY_SIZE(counter_names) == DEPOT_COUNTER_COUNT);
 
@@ -388,7 +382,7 @@ static struct stack_record *depot_pop_free_pool(void **prealloc, size_t size)
 	return stack;
 }
 
-/* Try to find next free usable entry. */
+/* Try to find next free usable entry from the freelist. */
 static struct stack_record *depot_pop_free(void)
 {
 	struct stack_record *stack;
@@ -466,9 +460,13 @@ depot_alloc_stack(unsigned long *entries, int nr_entries, u32 hash, depot_flags_
 
 	if (flags & STACK_DEPOT_FLAG_GET) {
 		refcount_set(&stack->count, 1);
+		counters[DEPOT_COUNTER_REFD_ALLOCS]++;
+		counters[DEPOT_COUNTER_REFD_INUSE]++;
 	} else {
 		/* Warn on attempts to switch to refcounting this entry. */
 		refcount_set(&stack->count, REFCOUNT_SATURATED);
+		counters[DEPOT_COUNTER_PERSIST_COUNT]++;
+		counters[DEPOT_COUNTER_PERSIST_BYTES] += record_size;
 	}
 
 	/*
@@ -477,8 +475,6 @@ depot_alloc_stack(unsigned long *entries, int nr_entries, u32 hash, depot_flags_
 	 */
 	kmsan_unpoison_memory(stack, record_size);
 
-	counters[DEPOT_COUNTER_ALLOCS]++;
-	counters[DEPOT_COUNTER_INUSE]++;
 	return stack;
 }
 
@@ -546,8 +542,8 @@ static void depot_free_stack(struct stack_record *stack)
 	list_add_tail(&stack->free_list, &free_stacks);
 
 	counters[DEPOT_COUNTER_FREELIST_SIZE]++;
-	counters[DEPOT_COUNTER_FREES]++;
-	counters[DEPOT_COUNTER_INUSE]--;
+	counters[DEPOT_COUNTER_REFD_FREES]++;
+	counters[DEPOT_COUNTER_REFD_INUSE]--;
 
 	printk_deferred_exit();
 	raw_spin_unlock_irqrestore(&pool_lock, flags);

