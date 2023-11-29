Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B92137FD624
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 13:00:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230343AbjK2MAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 07:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbjK2MAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 07:00:10 -0500
Received: from mail-ua1-x92c.google.com (mail-ua1-x92c.google.com [IPv6:2607:f8b0:4864:20::92c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 286C2D48
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:00:16 -0800 (PST)
Received: by mail-ua1-x92c.google.com with SMTP id a1e0cc1a2514c-7c46c7bc538so1811968241.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 04:00:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1701259215; x=1701864015; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nPXPu1JYkKeWx1IZ2D0WOSznovDcK9NZrhDXsB39l8g=;
        b=PywMPGeUJG5uFQKfheyvmk0xN2fNIacl8nwQMRoF+P2cgOyX6/Y1A3OjQobHD3v78k
         AQlmOaDWM4wshk6Q9i6/mYxFqcbj+in/uzg4tiBMMXIm9vIKdP1X8uwxoSmh81xqKzdw
         wGFF6FQqafHlwA14gzEmyqUY1+ZHZk7SbWmKN6weINehwNr0njjiiyYvlpdvDSmMAiUs
         WpjssuqcWFzf1n8ZEBp2wjzUQH27XE36khfJULjJCtFlre5e3Cp8lhpF3E9NRNX17/So
         6LRUS4BF9RbD6EQ1tYAMfUeRwaYJimuxK3OBdE8ep6H9vgIbIVSAqlv7b/HPveqlWTm4
         gGfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701259215; x=1701864015;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nPXPu1JYkKeWx1IZ2D0WOSznovDcK9NZrhDXsB39l8g=;
        b=go/5+cNTCbjMNUoMvjM1sK2Jt/ofP7mmKCzh7f6M6I9l0+9FQsUL0wmS3OTJfadgg9
         8pRMjV5NG5g7C/jHL2Dr6RYU8VfKeMTG0e7Xd2f2obu9YtmF2PUCvzjnR+XYp6t41HbX
         528d/0yFwa5j0b5w4XjBSC9fJ9+zBIPTOZZAkqvRnV5dvP8vg6joEslubsLpj7O43ttP
         KjbgsD1yFoG+ul7l0zfxj7iattHkZ5RPBoEnONuLFrDwwhuKUp7r/Ia03+ewplZGnK3K
         beQOiRLyzD/a9J+8avHon/LQd6ILi6i7ptA+C3Ersqtl6xuOcrLz598+6GbEIf9huMjH
         ulXA==
X-Gm-Message-State: AOJu0YxHm2TQA36pC7EfdajQOgQtnej9oTJOv7Z7a4WBdXkMIZS5rjwA
        sPsz3ffJgxquZRI0E9yoV3rle86ZYLTCh2qB2B+MbQ==
X-Google-Smtp-Source: AGHT+IHz+oE856HvMRcbIiiG9E1pi1IF2Nd8EHuvXGH7ld+DwtyNpIQdgPF2bLuhhYBWoK5fJanh8MVk+4DgexwHbHw=
X-Received: by 2002:a05:6102:5108:b0:460:621c:d14b with SMTP id
 bm8-20020a056102510800b00460621cd14bmr20684204vsb.20.1701259215088; Wed, 29
 Nov 2023 04:00:15 -0800 (PST)
MIME-Version: 1.0
References: <20231129-slub-percpu-caches-v3-0-6bcf536772bc@suse.cz> <20231129-slub-percpu-caches-v3-4-6bcf536772bc@suse.cz>
In-Reply-To: <20231129-slub-percpu-caches-v3-4-6bcf536772bc@suse.cz>
From:   Marco Elver <elver@google.com>
Date:   Wed, 29 Nov 2023 13:00:00 +0100
Message-ID: <CANpmjNN-RCZEzU8tLsUVGLtuDgXMRjddOW3fj6bEzCw2+FSiNg@mail.gmail.com>
Subject: Re: [PATCH RFC v3 4/9] mm/slub: free KFENCE objects in slab_free_hook()
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Matthew Wilcox <willy@infradead.org>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, maple-tree@lists.infradead.org,
        kasan-dev@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
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

On Wed, 29 Nov 2023 at 10:53, Vlastimil Babka <vbabka@suse.cz> wrote:
>
> When freeing an object that was allocated from KFENCE, we do that in the
> slowpath __slab_free(), relying on the fact that KFENCE "slab" cannot be
> the cpu slab, so the fastpath has to fallback to the slowpath.
>
> This optimization doesn't help much though, because is_kfence_address()
> is checked earlier anyway during the free hook processing or detached
> freelist building. Thus we can simplify the code by making the
> slab_free_hook() free the KFENCE object immediately, similarly to KASAN
> quarantine.
>
> In slab_free_hook() we can place kfence_free() above init processing, as
> callers have been making sure to set init to false for KFENCE objects.
> This simplifies slab_free(). This places it also above kasan_slab_free()
> which is ok as that skips KFENCE objects anyway.
>
> While at it also determine the init value in slab_free_freelist_hook()
> outside of the loop.
>
> This change will also make introducing per cpu array caches easier.
>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Tested-by: Marco Elver <elver@google.com>

> ---
>  mm/slub.c | 21 ++++++++++-----------
>  1 file changed, 10 insertions(+), 11 deletions(-)
>
> diff --git a/mm/slub.c b/mm/slub.c
> index 7d23f10d42e6..59912a376c6d 100644
> --- a/mm/slub.c
> +++ b/mm/slub.c
> @@ -1772,7 +1772,7 @@ static bool freelist_corrupted(struct kmem_cache *s, struct slab *slab,
>   * production configuration these hooks all should produce no code at all.
>   *
>   * Returns true if freeing of the object can proceed, false if its reuse
> - * was delayed by KASAN quarantine.
> + * was delayed by KASAN quarantine, or it was returned to KFENCE.
>   */
>  static __always_inline
>  bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
> @@ -1790,6 +1790,9 @@ bool slab_free_hook(struct kmem_cache *s, void *x, bool init)
>                 __kcsan_check_access(x, s->object_size,
>                                      KCSAN_ACCESS_WRITE | KCSAN_ACCESS_ASSERT);
>
> +       if (kfence_free(kasan_reset_tag(x)))
> +               return false;
> +
>         /*
>          * As memory initialization might be integrated into KASAN,
>          * kasan_slab_free and initialization memset's must be
> @@ -1819,22 +1822,25 @@ static inline bool slab_free_freelist_hook(struct kmem_cache *s,
>         void *object;
>         void *next = *head;
>         void *old_tail = *tail;
> +       bool init;
>
>         if (is_kfence_address(next)) {
>                 slab_free_hook(s, next, false);
> -               return true;
> +               return false;
>         }
>
>         /* Head and tail of the reconstructed freelist */
>         *head = NULL;
>         *tail = NULL;
>
> +       init = slab_want_init_on_free(s);
> +
>         do {
>                 object = next;
>                 next = get_freepointer(s, object);
>
>                 /* If object's reuse doesn't have to be delayed */
> -               if (slab_free_hook(s, object, slab_want_init_on_free(s))) {
> +               if (slab_free_hook(s, object, init)) {
>                         /* Move object to the new freelist */
>                         set_freepointer(s, object, *head);
>                         *head = object;
> @@ -3619,9 +3625,6 @@ static void __slab_free(struct kmem_cache *s, struct slab *slab,
>
>         stat(s, FREE_SLOWPATH);
>
> -       if (kfence_free(head))
> -               return;
> -
>         if (IS_ENABLED(CONFIG_SLUB_TINY) || kmem_cache_debug(s)) {
>                 free_to_partial_list(s, slab, head, tail, cnt, addr);
>                 return;
> @@ -3806,13 +3809,9 @@ static __fastpath_inline
>  void slab_free(struct kmem_cache *s, struct slab *slab, void *object,
>                unsigned long addr)
>  {
> -       bool init;
> -
>         memcg_slab_free_hook(s, slab, &object, 1);
>
> -       init = !is_kfence_address(object) && slab_want_init_on_free(s);
> -
> -       if (likely(slab_free_hook(s, object, init)))
> +       if (likely(slab_free_hook(s, object, slab_want_init_on_free(s))))
>                 do_slab_free(s, slab, object, object, 1, addr);
>  }
>
>
> --
> 2.43.0
>
