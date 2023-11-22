Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D0077F4DF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 18:13:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343951AbjKVRNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 12:13:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231357AbjKVRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 12:13:35 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D25C41A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:13:30 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id ffacd0b85a97d-332ce50450dso1365809f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 09:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700673209; x=1701278009; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iREYFokOV8dvymG/8i5EmbN9PgByJeos08X2K2e+878=;
        b=Km+f+K3KRq46AjEFJhRB1ZiEm9tNQhaDuW7vnHKuAuubVUVLVLlyuWaJPzfwvNS3w/
         yjZCqfvDq0MrlLw4HYOldrPZUIN40+eG2jZQRWJBIhTuSOxG8d4Ee+anuFNiFUvNPCR8
         Tr4GQjWe5ibggkRs9/+V1WLdPVwA7IsWIBsyrPT9BUaBNn5ngw4sVZLeJ4Kq5tR3t1wH
         1pC/Xz4FBL0Ws0WZ0kW37hlbdvre8LMZHKb0Qo/im5MDw1bE9SKzSvtNeCmyXXZyT0d5
         e+w9c255ENUFIvi9mr0IRKSI7F3zm0sCB4WTXhg0ylMUBW3hqXPXGoNLRfZAFv5GloyW
         7U5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700673209; x=1701278009;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iREYFokOV8dvymG/8i5EmbN9PgByJeos08X2K2e+878=;
        b=VydCO3Cut+n5Cy/4/lIKcBhlGsp5YzKmsAXYA2/p+5jsCrV4Mgx7u2ezmRPI5qfvTt
         l20Acd2mkL7i5kDPai1V1ndTwX8DhcOd7+YH+PRHutGqT182+l8xjGkT+MomR1lclamg
         7itN2vLb/I4fJAqyr+eho3wQ0Um2rs4knyuUSP3jW5Jw2fXf+td5n0sVDY03eo02MM4w
         WssiIomZp6k45H7HSYjrJkgn5T2I5+ckkv1pmMyXhCYDkhklw/I9ZDlm9XRFo0ZHSNjK
         89Kri8foN4OrQegYxJFKRh3mkmyV3U1Ir+TKntHu8dnym+xTt42LuioOR/RxyMEnom92
         gAoA==
X-Gm-Message-State: AOJu0YwdiFVjs9UmZTY57IA7mn2AlJ38wSrIUuBfOkMGs7InPbs47d6H
        8ifd7J+L5V/T28HXa172vMeOxQ==
X-Google-Smtp-Source: AGHT+IHG50GHV18iXf9NgLcNgDR5o5sNBk599jpI37YLzVcyzNoVxOG6dCer6jFfQZDfi6s6ijq21w==
X-Received: by 2002:a5d:64e4:0:b0:332:ce3f:a370 with SMTP id g4-20020a5d64e4000000b00332ce3fa370mr2275817wri.51.1700673208904;
        Wed, 22 Nov 2023 09:13:28 -0800 (PST)
Received: from elver.google.com ([2a00:79e0:9c:201:1dcf:36df:c2d9:af51])
        by smtp.gmail.com with ESMTPSA id b15-20020a056000054f00b0031980294e9fsm17633839wrf.116.2023.11.22.09.13.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 09:13:28 -0800 (PST)
Date:   Wed, 22 Nov 2023 18:13:23 +0100
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com, Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH RFC 00/20] kasan: save mempool stack traces
Message-ID: <ZV42s_c3BzCAEwgu@elver.google.com>
References: <cover.1699297309.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1699297309.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 06, 2023 at 09:10PM +0100, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> This series updates KASAN to save alloc and free stack traces for
> secondary-level allocators that cache and reuse allocations internally
> instead of giving them back to the underlying allocator (e.g. mempool).

Nice.

> As a part of this change, introduce and document a set of KASAN hooks:
> 
> bool kasan_mempool_poison_pages(struct page *page, unsigned int order);
> void kasan_mempool_unpoison_pages(struct page *page, unsigned int order);
> bool kasan_mempool_poison_object(void *ptr);
> void kasan_mempool_unpoison_object(void *ptr, size_t size);
> 
> and use them in the mempool code.
> 
> Besides mempool, skbuff and io_uring also cache allocations and already
> use KASAN hooks to poison those. Their code is updated to use the new
> mempool hooks.
>
> The new hooks save alloc and free stack traces (for normal kmalloc and
> slab objects; stack traces for large kmalloc objects and page_alloc are
> not supported by KASAN yet), improve the readability of the users' code,
> and also allow the users to prevent double-free and invalid-free bugs;
> see the patches for the details.
> 
> I'm posting this series as an RFC, as it has a few non-trivial-to-resolve
> conflicts with the stack depot eviction patches. I'll rebase the series and
> resolve the conflicts once the stack depot patches are in the mm tree.
> 
> Andrey Konovalov (20):
>   kasan: rename kasan_slab_free_mempool to kasan_mempool_poison_object
>   kasan: move kasan_mempool_poison_object
>   kasan: document kasan_mempool_poison_object
>   kasan: add return value for kasan_mempool_poison_object
>   kasan: introduce kasan_mempool_unpoison_object
>   kasan: introduce kasan_mempool_poison_pages
>   kasan: introduce kasan_mempool_unpoison_pages
>   kasan: clean up __kasan_mempool_poison_object
>   kasan: save free stack traces for slab mempools
>   kasan: clean up and rename ____kasan_kmalloc
>   kasan: introduce poison_kmalloc_large_redzone
>   kasan: save alloc stack traces for mempool
>   mempool: use new mempool KASAN hooks
>   mempool: introduce mempool_use_prealloc_only
>   kasan: add mempool tests
>   kasan: rename pagealloc tests
>   kasan: reorder tests
>   kasan: rename and document kasan_(un)poison_object_data
>   skbuff: use mempool KASAN hooks
>   io_uring: use mempool KASAN hook
> 
>  include/linux/kasan.h   | 161 +++++++-
>  include/linux/mempool.h |   2 +
>  io_uring/alloc_cache.h  |   5 +-
>  mm/kasan/common.c       | 221 ++++++----
>  mm/kasan/kasan_test.c   | 876 +++++++++++++++++++++++++++-------------
>  mm/mempool.c            |  49 ++-
>  mm/slab.c               |  10 +-
>  mm/slub.c               |   4 +-
>  net/core/skbuff.c       |  10 +-
>  9 files changed, 940 insertions(+), 398 deletions(-)

Overall LGTM and the majority of it is cleanups, so I think once the
stack depot patches are in the mm tree, just send v1 of this series.
