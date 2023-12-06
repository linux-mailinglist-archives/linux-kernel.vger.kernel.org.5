Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3D92806935
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 09:13:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjLFINa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 03:13:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232500AbjLFINY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 03:13:24 -0500
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE67D67;
        Wed,  6 Dec 2023 00:13:15 -0800 (PST)
Received: by mail-oi1-x22c.google.com with SMTP id 5614622812f47-3b842c1511fso3845373b6e.1;
        Wed, 06 Dec 2023 00:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701850394; x=1702455194; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ZKizt4iTnV9cayPmYedMVcEI9nEBmDM8KpDsNPl1XzI=;
        b=FWvQECv9J+jmrIK0lpq4xVT79Gri2fy7DWg1EYCXZ/HPxR8e2jsOK5IyTCjUvYphTk
         4sOViRUYdSA/tN/X3m8bWWUR+vwb3y/wkDH1cX9r/uAByikzBkasj4wuq1bjQsR9WLP5
         TLQLDvGL+158yqxdAN4ZEkPtSiKqwQ30Amgfine7/Sxj/OexXU4N6XNjYQ1kg9tD+Rwi
         jph5HIeqhOcIughzzHJnNvJyZg5BhRIOjfeXiCNPykLDLyuFx8ffWZy8SFuy9alv8OUL
         O4qGK3TGOAuSefN7IvwVZTysG/+fNOAGZYQdjlpFmsyWp6Nt6oaEGuHC+MeM5KyVEOsg
         A3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701850394; x=1702455194;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZKizt4iTnV9cayPmYedMVcEI9nEBmDM8KpDsNPl1XzI=;
        b=WQvlhlBi/zEOaw9z+22V4xoWUlegOBvOlAl2j+jOxEF5hj0Pw3nNpnKSkj4T3+TuAX
         Att2XrJ8VOfLzIxfOjc3CeKSoal11eMb2EhLPKsxJ41PTR7nPO7lEpD79itJSbH80kO1
         ysQZiLUV5VqpDMd2fOt5e9umv8pu6MwoEAReg4lB0FdiLerBWYlTt4zlUrTW1pj0Grdh
         FoqSwNI9MhHoI3b7DHbDAQ54z2E9/RLv53GvUD3U0/PYS6nRYmIvv6us9sUbBon6vTtY
         Ud8vKKoCoqs4RUOp6LomxOsG/BRC9IuZ7WnEgdmNwBrb6cjxpcvPWmHP1sbUhoUPAGXw
         PHYQ==
X-Gm-Message-State: AOJu0YxUf9U/XIqjwDGFVrny2PHZpW7CGdgoWUa1Rj1wdwO0lElgzLm9
        kyjdmcFSmzKVx/AR/qbuVTo=
X-Google-Smtp-Source: AGHT+IElRqPaTCMRS95WPb5zLIvYTqxmbJ/Yepyjh+gda++IHaQn/3mO1oXx/4ZEu1UGLiI+FuRVCA==
X-Received: by 2002:a05:6808:2e4a:b0:3b8:b063:9b7b with SMTP id gp10-20020a0568082e4a00b003b8b0639b7bmr906780oib.109.1701850394310;
        Wed, 06 Dec 2023 00:13:14 -0800 (PST)
Received: from localhost.localdomain ([1.245.180.67])
        by smtp.gmail.com with ESMTPSA id p12-20020a62ab0c000000b006ce7c28be72sm1455066pff.118.2023.12.06.00.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Dec 2023 00:13:13 -0800 (PST)
Date:   Wed, 6 Dec 2023 17:12:58 +0900
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
        cgroups@vger.kernel.org, linux-hardening@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>
Subject: Re: [PATCH v2 05/21] mm/memcontrol: remove CONFIG_SLAB #ifdef guards
Message-ID: <ZXAtCuk7cFQqpJE6@localhost.localdomain>
References: <20231120-slab-remove-slab-v2-0-9c9c70177183@suse.cz>
 <20231120-slab-remove-slab-v2-5-9c9c70177183@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120-slab-remove-slab-v2-5-9c9c70177183@suse.cz>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 07:34:16PM +0100, Vlastimil Babka wrote:
> With SLAB removed, these are never true anymore so we can clean up.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> Acked-by: Michal Hocko <mhocko@suse.com>
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  mm/memcontrol.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/mm/memcontrol.c b/mm/memcontrol.c
> index 774bd6e21e27..947fb50eba31 100644
> --- a/mm/memcontrol.c
> +++ b/mm/memcontrol.c
> @@ -5149,7 +5149,7 @@ static ssize_t memcg_write_event_control(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> -#if defined(CONFIG_MEMCG_KMEM) && (defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
> +#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
>  static int mem_cgroup_slab_show(struct seq_file *m, void *p)
>  {
>  	/*
> @@ -5258,8 +5258,7 @@ static struct cftype mem_cgroup_legacy_files[] = {
>  		.write = mem_cgroup_reset,
>  		.read_u64 = mem_cgroup_read_u64,
>  	},
> -#if defined(CONFIG_MEMCG_KMEM) && \
> -	(defined(CONFIG_SLAB) || defined(CONFIG_SLUB_DEBUG))
> +#if defined(CONFIG_MEMCG_KMEM) && defined(CONFIG_SLUB_DEBUG)
>  	{
>  		.name = "kmem.slabinfo",
>  		.seq_show = mem_cgroup_slab_show,

Looks good to me,
Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>

> 
> -- 
> 2.42.1
> 
> 
