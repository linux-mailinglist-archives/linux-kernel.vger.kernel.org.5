Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDE367EA95C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231990AbjKNELv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:11:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231949AbjKNELs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:11:48 -0500
Received: from mail-oa1-x34.google.com (mail-oa1-x34.google.com [IPv6:2001:4860:4864:20::34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB1BD59
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:11:44 -0800 (PST)
Received: by mail-oa1-x34.google.com with SMTP id 586e51a60fabf-1f00b95dc43so3131768fac.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:11:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699935103; x=1700539903; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n+4yq4rGlFBGUUVelo6loa8LJ3whEhAhDSYlb9+Og4U=;
        b=k7ax4ATw7ENKQBKTpFzkjNtDZUnumXdMkial8xKCs96XtVKludT0CtZYqUdBtBNMfL
         YomvUhi3dRzEHyhlXoDdtwOaqMvL8rqJDCRVaqwhqKFO6WKSMOS5j89kqW1ut2UvvzL1
         B1F++JKGqsaTwrerq5gIgSCG2k+syxVp8AeEI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935103; x=1700539903;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n+4yq4rGlFBGUUVelo6loa8LJ3whEhAhDSYlb9+Og4U=;
        b=O+HRC42CcEgdZgQDcQ0q4T567zs+T0q4eercNLSokcd22VQnSSbhAokSQXzv50Hgu9
         ygNj+mlJKgNpl5K8HwYM1qOii47VF3QFYhq3/KJkjTgehGfvjAQmhK4iJ3JJ3RO0nQjw
         UlTB/7vfQJdin9B0Ve5ilr57xI2DjBfULWhzrfbQwj4ZYy46oKR4RsAxwnEW5gTUArKG
         3OOuq/j/WfUBKXiZogpT1MUs8k5CB61chf+xkEiucHxKD8yIrG1B7KOmjFcyELlUispS
         qzqUGoV6x1ACCwnTd6TW1vNYpElgfyL02AFul4zZZaDWxYf2NYYiGSjM6s9HLcaYg/gv
         p9QQ==
X-Gm-Message-State: AOJu0YxF7r1+NH4xVGZOe+UhT2fo3ImiPrvHTdUsSz4Z/MorDN5Zk6mU
        MqCRD7XKIDd5mcAZKxiGr4Tgng==
X-Google-Smtp-Source: AGHT+IEfNarlWdnfTnb+4lj9a61ndeE58KtCzt4cIWOf0C0hGaQoDCR9asaBxInqDvXXBZ8V8HT8ig==
X-Received: by 2002:a05:6870:b155:b0:1ef:62fc:d51c with SMTP id a21-20020a056870b15500b001ef62fcd51cmr10394447oal.51.1699935102819;
        Mon, 13 Nov 2023 20:11:42 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id fz10-20020a17090b024a00b00268b439a0cbsm4292411pjb.23.2023.11.13.20.11.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:11:42 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:11:41 -0800
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
Subject: Re: [PATCH 01/20] mm/slab: remove CONFIG_SLAB from all Kconfig and
 Makefile
Message-ID: <202311132009.8329C2F5D@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-23-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-23-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:42PM +0100, Vlastimil Babka wrote:
> Remove CONFIG_SLAB, CONFIG_DEBUG_SLAB, CONFIG_SLAB_DEPRECATED and
> everything in Kconfig files and mm/Makefile that depends on those. Since
> SLUB is the only remaining allocator, remove the allocator choice, make
> CONFIG_SLUB a "def_bool y" for now and remove all explicit dependencies
> on SLUB as it's now always enabled.
> 
> Everything under #ifdef CONFIG_SLAB, and mm/slab.c is now dead code, all
> code under #ifdef CONFIG_SLUB is now always compiled.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> [...]
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 89971a894b60..766aa8f8e553 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -228,47 +228,12 @@ config ZSMALLOC_CHAIN_SIZE
>  
>  menu "SLAB allocator options"

Should this be "Slab allocator options" ? (I've always understood
"slab" to mean the general idea, and "SLAB" to mean the particular
implementation.

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
