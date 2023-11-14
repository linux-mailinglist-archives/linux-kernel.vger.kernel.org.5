Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF18E7EA9D3
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232048AbjKNEux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKNEuv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:50:51 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15839123
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:50:48 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-5b8f68ba4e5so3626557a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:50:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937447; x=1700542247; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gSHaE/1GVg9mC1SVDtWharYt7nYPJBYXesltql5ggN0=;
        b=WTsTTJRWM6qWKzHmZhVNQCZsB9NUac7sFHmcctyh1H9ElRJmr42LNA+aPK9gxcPe7N
         PGG5PFJ0ZVR2N3ZcVKg/bgjlNCOqZeWjeooLq7kzVQxb+xQmEge5ank4tqAGl8Y7dt98
         0LFdwOA3GV/EcQ2s7Tg+bEe9jMGWJq3aYEUCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937447; x=1700542247;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gSHaE/1GVg9mC1SVDtWharYt7nYPJBYXesltql5ggN0=;
        b=mZUxiQTLgEy6TOJtau1hNKh+zjIjg1baKtpOAgn7ofbSSLf1XJ9gTxFgKL+I8ebbWO
         oHeATVgk5TM2trqdpWqJoZvJYw7lWS0xSpjOYD1ZTE/1+bLLoShaDu56hD+R350hAIc1
         hobE6fXRuczD80dSxOA/1gQF3yHZAgXADbtpMTZGEQ1wcuRyt0R2lzv8FYa7y6uA60MG
         5f3IwRfE48RHe8B7hXn3h1m3vtzLF6WPtVDSdF97UkGgq3/Jlzo8yDSH/HFAv7RzA1WC
         Ax6uhN3uES8FRaW5ftI9g1cBFnBKuXKITgy6QF2sf2OTXl3BpCyvyM4WleXSyvF+wAhI
         lcVw==
X-Gm-Message-State: AOJu0YwLHNiNJVEzTzpIKhTld6tEfWD6++xb8lnW9YLcaenOcJ/dCQhN
        satr1qo0x3aSnz6iKbC7deJptg==
X-Google-Smtp-Source: AGHT+IF7Byd1ljDiTcsJ0NghEeEEgnKHX0+3r+3s8w6VMPI04pb7VCutEUrPIzMWjcVxqsPNaM8wIg==
X-Received: by 2002:a17:902:8b85:b0:1cc:474d:bdf9 with SMTP id ay5-20020a1709028b8500b001cc474dbdf9mr1243778plb.36.1699937447538;
        Mon, 13 Nov 2023 20:50:47 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001c9db5e2929sm4875757pls.93.2023.11.13.20.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:50:47 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:50:46 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Marco Elver <elver@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org
Subject: Re: [PATCH 18/20] mm/slub: remove slab_alloc() and
 __kmem_cache_alloc_lru() wrappers
Message-ID: <202311132048.B3AADC400@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-40-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-40-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:59PM +0100, Vlastimil Babka wrote:
> slab_alloc() is a thin wrapper around slab_alloc_node() with only one
> caller.  Replace with direct call of slab_alloc_node().
> __kmem_cache_alloc_lru() itself is a thin wrapper with two callers,
> so replace it with direct calls of slab_alloc_node() and
> trace_kmem_cache_alloc().

I'd have a sense that with 2 callers a wrapper is still useful?

> 
> This also makes sure _RET_IP_ has always the expected value and not
> depending on inlining decisions.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> [...]
>  void *kmem_cache_alloc_node(struct kmem_cache *s, gfp_t gfpflags, int node)
>  {
> -	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_, s->object_size);
> +	void *ret = slab_alloc_node(s, NULL, gfpflags, node, _RET_IP_,
> +				    s->object_size);
>  

Whitespace change here isn't mentioned in the commit log.

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
