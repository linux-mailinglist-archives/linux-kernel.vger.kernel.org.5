Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A1687EA9AE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:41:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbjKNElj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231512AbjKNElh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:41:37 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DEA0118
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:41:34 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-6c4cf0aea06so4141017b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:41:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936894; x=1700541694; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=eA82Hdspg/bY+CR7CFpsTdFZp4h7gtZ2SoVDA2UEAEM=;
        b=CsRdvzi44SUYrtU26qMcQxQza+GO2SigK5NTrdX+MXbGGaf92j7BCd+TLVoREYes9M
         IwRVZ2NL/IFeINp6O3MVx42WCFssAqOAQdBjwwl1e6BFu9IuD5MoW8Fw13GwEWNjftxc
         c+YX7/q7OG7ktXDxby7Wor0y7BAsKafQAGrLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936894; x=1700541694;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eA82Hdspg/bY+CR7CFpsTdFZp4h7gtZ2SoVDA2UEAEM=;
        b=mCSHMEGS2exrPU4Mf9hmFV3p9/BgDRL6rzg3KZS8mI/7lBvdsg+F7gZzqLJ2gP71nN
         WhD/O3xf26IVigStWSX27vkwzE+E6iTqPDO4Bm9RUDYZDVlkSfcI8gmlAJj06gp84sZq
         zZAtcznwrqk1Jl5ugXg1rxhzDYVxMBMb4h88U2oRDmp+BlqcFVJWx6LS9pomR3Vbrs4O
         FfDwBHuVNpbhYyrlYkhteAPhwl4FYng/PfBnsjLOKqPYjdM5fD7pDKtlFmoJIrd7C9b2
         JdQeZJYxkSVHNEp4iJjSaYwadKaM6f0FDUYDQfl4yAq6FAvehMPFpnXAJTW015kSib6I
         xoBQ==
X-Gm-Message-State: AOJu0Yz0OHFxfzNkEtzoSTgClMA2TW7OShX/2nkjz4P2SfxKREOUYUK3
        cnNDa1d7sumU+IbLqXDMMFuZDg==
X-Google-Smtp-Source: AGHT+IFUbqnfiVhlSCwWCV5DGdqS5OAFW8uF1N6KtxMGpaKCHywxvsAYJi+LSQYhPHziOoJn8xTdZQ==
X-Received: by 2002:a05:6a00:10c8:b0:6b8:a6d6:f51a with SMTP id d8-20020a056a0010c800b006b8a6d6f51amr9811289pfu.31.1699936893812;
        Mon, 13 Nov 2023 20:41:33 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b13-20020a056a00114d00b006baa1cf561dsm395221pfm.0.2023.11.13.20.41.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:41:33 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:41:32 -0800
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
Subject: Re: [PATCH 11/20] mm/slab: consolidate includes in the internal
 mm/slab.h
Message-ID: <202311132039.7CC758A@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-33-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-33-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:52PM +0100, Vlastimil Babka wrote:
> The #include's are scattered at several places of the file, but it does
> not seem this is needed to prevent any include loops (anymore?) so
> consolidate them at the top. Also move the misplaced kmem_cache_init()
> declaration away from the top.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/slab.h | 28 ++++++++++++++--------------
>  1 file changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/mm/slab.h b/mm/slab.h
> index 6e76216ac74e..c278f8b15251 100644
> --- a/mm/slab.h
> +++ b/mm/slab.h
> @@ -1,10 +1,22 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  #ifndef MM_SLAB_H
>  #define MM_SLAB_H
> +
> +#include <linux/reciprocal_div.h>
> +#include <linux/list_lru.h>
> +#include <linux/local_lock.h>
> +#include <linux/random.h>
> +#include <linux/kobject.h>
> +#include <linux/sched/mm.h>
> +#include <linux/memcontrol.h>
> +#include <linux/fault-inject.h>
> +#include <linux/kmemleak.h>
> +#include <linux/kfence.h>
> +#include <linux/kasan.h>

I've seen kernel code style in other places ask that includes be
organized alphabetically. Is the order here in this order for some
particular reason?

-- 
Kees Cook
