Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3331806A61
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 10:10:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346725AbjLFJKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 04:10:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346664AbjLFJKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 04:10:14 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F72FD73;
        Wed,  6 Dec 2023 01:10:20 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-5c210e34088so4238403a12.2;
        Wed, 06 Dec 2023 01:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701853820; x=1702458620; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D8vZXQBRikGU6sWc2QsfIXjdmr6JSGCqbWWomJu158I=;
        b=WWBJp2470RCWT95rFLv/VrCiLHZxQxLctM9uLJs9nhanWv3rh6WX2QrRQRJ+FA5faL
         OZGOJwyKItB3DNEwggUS+zOB0rrVHTkIxSY1YH7OTQRR4gD6AJy7Cq0M1UPoH5cHFDSP
         rDM+VEHMzddvl9iZ3OwbFP6oDij1pM5PXEzQiNXyi/Wi+S9FKxgASMf/UZHYLkgbwFHU
         VIZS1kiMA/jx6AwHN4l35mCKE3r2AEdThTTwSIA0pUQdFDf86cX2sbu0vjeqiv31R+af
         xjgAZEc6Lm4DmIgLoPXLcZkTxjC9KKTfUauj4E2kn+egyEI5Pup7IsWavdGI0wqqAlBp
         jdNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701853820; x=1702458620;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D8vZXQBRikGU6sWc2QsfIXjdmr6JSGCqbWWomJu158I=;
        b=XbrpNwk0s3RsNb7TrfuOfUquiiysBEi9t3l5FwO+ZQmSbxrDLrjNyNnmPM0jmNHrkD
         8iuP5QK9duJIqt66egwhBy5Vixz8EXMgZq4/Gr+CVmleiVQUX2H+LU2yEEOYVEvG+EPp
         bw5MNaTeDeWKIhRx+HuJFdzCVmJR5yjf56GAIUmfd4dB4ePqe7EeerXK5HOTj474r4Vo
         16oi4eSugGXlp/xQqsZKlD358zNEExLRH8+ekXSBVN/qAjaqLUu7RzeP30m+fq5s56Uy
         FaUu4jqlg5Htx7j11mw4QX1Rhf2Go8Wjz0VyYvkjr0CFHzRQR0/0VKs1/IFc5cnVaOHd
         6+ZQ==
X-Gm-Message-State: AOJu0YwImHxn13bzj0+Z236z7TeJtALr5h3ydMleTNOkEtqEL3jmdD4+
        YCuZJroM5J7FlRD6voFR4Fg=
X-Google-Smtp-Source: AGHT+IFset8/x2y0oFwNGQQRLfyeYkns1iFYfHHalNFN3DxWN75KXchutnoXwKUQTPjMGA8dsmHvzQ==
X-Received: by 2002:a05:6a21:3102:b0:188:f3d:ea35 with SMTP id yz2-20020a056a21310200b001880f3dea35mr877394pzb.50.1701853819776;
        Wed, 06 Dec 2023 01:10:19 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id u6-20020a170903124600b001d01c970119sm11497348plh.275.2023.12.06.01.10.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 01:10:18 -0800 (PST)
Date:   Wed, 6 Dec 2023 18:10:11 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
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
        Kees Cook <keescook@chromium.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com,
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH v2 08/21] mm/mempool/dmapool: remove CONFIG_DEBUG_SLAB
 ifdefs
Message-ID: <ZXA6cwJbnayb6KA/@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-8-9c9c70177183@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-8-9c9c70177183@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 07:34:19PM +0100, Vlastimil Babka wrote:
> CONFIG_DEBUG_SLAB is going away with CONFIG_SLAB, so remove dead ifdefs
> in mempool and dmapool code.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/dmapool.c | 2 +-
>  mm/mempool.c | 6 +++---
>  2 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/dmapool.c b/mm/dmapool.c
> index a151a21e571b..f0bfc6c490f4 100644
> --- a/mm/dmapool.c
> +++ b/mm/dmapool.c
> @@ -36,7 +36,7 @@
>  #include <linux/types.h>
>  #include <linux/wait.h>
>  
> -#if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
> +#ifdef CONFIG_SLUB_DEBUG_ON
>  #define DMAPOOL_DEBUG 1
>  #endif
>  
> diff --git a/mm/mempool.c b/mm/mempool.c
> index 734bcf5afbb7..4759be0ff9de 100644
> --- a/mm/mempool.c
> +++ b/mm/mempool.c
> @@ -20,7 +20,7 @@
>  #include <linux/writeback.h>
>  #include "slab.h"
>  
> -#if defined(CONFIG_DEBUG_SLAB) || defined(CONFIG_SLUB_DEBUG_ON)
> +#ifdef CONFIG_SLUB_DEBUG_ON
>  static void poison_error(mempool_t *pool, void *element, size_t size,
>  			 size_t byte)
>  {
> @@ -95,14 +95,14 @@ static void poison_element(mempool_t *pool, void *element)
>  		kunmap_atomic(addr);
>  	}
>  }
> -#else /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
> +#else /* CONFIG_SLUB_DEBUG_ON */
>  static inline void check_element(mempool_t *pool, void *element)
>  {
>  }
>  static inline void poison_element(mempool_t *pool, void *element)
>  {
>  }
> -#endif /* CONFIG_DEBUG_SLAB || CONFIG_SLUB_DEBUG_ON */
> +#endif /* CONFIG_SLUB_DEBUG_ON */

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

>  
>  static __always_inline void kasan_poison_element(mempool_t *pool, void *element)
>  {
> 
> -- 
> 2.42.1
> 
> 
