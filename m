Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 319FA7EA984
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:30:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231837AbjKNEaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjKNEaR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:30:17 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D80BD1A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:30:14 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-28003daaaa6so4713898a91.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:30:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936214; x=1700541014; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BVR/Ivq5aw+9huCWfoclhyK6Cz1m1uGsfFPrSjVP+os=;
        b=bjZQ8lop7hyDfPrFFjrGsbb/lxu+tN8uQzWKwFNUL1DZNN61se9kYli2KfjrzCaRkx
         lkooQ4QJrb8g2cNYZibL2BZvLbELxY1oV8YROHIimtEFXSs7zAQkXbwzkkqCNiQP33pf
         EpgRAEE046QEgMq7b0/7Q3jTGBKKcXkRyxblA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936214; x=1700541014;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BVR/Ivq5aw+9huCWfoclhyK6Cz1m1uGsfFPrSjVP+os=;
        b=s64cDq/P7XdWDRtyef4FBQ9RVxKxdxzS4o1GCfxPPDwSzt70XrGmxXm7ukwwKrdTHD
         20bUOPmD+LHWUh4a8BAAfsTMH61S9YFvARhF1+etzF3IMXM3nJqIPQg9a/sLx/UunLuO
         U9ZhpsM84nQ+ipJMXMNanx4rfuv67ZLtPV9kDIhcNA1VBDVXO6j/jLyR/eZl0nDukWwS
         vhUbjOsHrqH6w+uDc6ElwpiwMDaQiMsDBZ9ycaOA7Q5YoM2vAwPpU0o8BS0qbNgTqo13
         qyjPN3uMr4Ogvb6weKYf0g3w4r0lMWYKsw0xHGAs/BXGXoweVq+vO7QMhaNldZfw2Ucv
         J2qQ==
X-Gm-Message-State: AOJu0YxtecY52mq2SNOkwrtYCC29if4ikekmwWvwJ+gfF5RE3jd6yH02
        b1lhTvxutzCaQPac/4yb0s4XyQ==
X-Google-Smtp-Source: AGHT+IGHpiRYqf1wnawSvDbbqcUpNVvAlWIHQjTAdYW+tyahOMwSwXjVkxNjFnslO/Q+Xg7jd3gPkg==
X-Received: by 2002:a17:90b:1d06:b0:280:2823:6615 with SMTP id on6-20020a17090b1d0600b0028028236615mr8237152pjb.36.1699936214292;
        Mon, 13 Nov 2023 20:30:14 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l24-20020a17090aec1800b00280fcbbe774sm4405770pjy.10.2023.11.13.20.30.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:30:13 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:30:13 -0800
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
Subject: Re: [PATCH 06/20] mm/slab: remove CONFIG_SLAB code from slab common
 code
Message-ID: <202311132024.80A0D5D58@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-28-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-28-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:47PM +0100, Vlastimil Babka wrote:
> In slab_common.c and slab.h headers, we can now remove all code behind
> CONFIG_SLAB and CONFIG_DEBUG_SLAB ifdefs, and remove all CONFIG_SLUB
> ifdefs.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/slab.h | 13 +--------
>  mm/slab.h            | 69 ++++----------------------------------------
>  mm/slab_common.c     | 22 ++------------
>  3 files changed, 8 insertions(+), 96 deletions(-)
> 
> diff --git a/include/linux/slab.h b/include/linux/slab.h
> index 34e43cddc520..90fb1f0d843a 100644
> --- a/include/linux/slab.h
> +++ b/include/linux/slab.h
> @@ -24,7 +24,6 @@
>  
>  /*
>   * Flags to pass to kmem_cache_create().
> - * The ones marked DEBUG are only valid if CONFIG_DEBUG_SLAB is set.

I think this comment was wrong, yes? i.e. the "DEBUG" flags are also
used in SLUB?

Regardless:

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
