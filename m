Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E863778D9AF
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 20:34:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbjH3Sdu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 14:33:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242726AbjH3JYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 05:24:38 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 481C0B0
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:24:36 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bcb50e194dso81553111fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 02:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1693387474; x=1693992274; darn=vger.kernel.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UI7fXVlKfpB5b5W3nvIcPqt6ERVpjXtyoJBz3Uqak/4=;
        b=5SLu/DKt4o/4NDuqRF1I/3yhM2POmSvnQ3PvoPZfY+T34UtscqE3ZzJGRvvbErPbXr
         7vqGInz8yXYuMGsVg36Ifh+T7uEDCGu0yQiYNCXzvFJsuWrzF7mmnvuHBpvTkaf+yt+z
         0GbvDL6okXBJRu1mlGYFUtwS0DhD2m3bJXgTWr3gym/hBPsHstnnS/s4QMaqpog6KWmt
         X3aatGuRP7OoQhiNxFnXT+TyNv2zARjH4PZE23y9GgCNQlTqyZOfvKS+TL3hfExPAEOl
         zt2utt7PC4eN+AfQfq0FX1FTM2KroR9UTD3PpaK8yZiDDvPZj5E2j53hgXWZrS0gn5oi
         xLYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693387474; x=1693992274;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UI7fXVlKfpB5b5W3nvIcPqt6ERVpjXtyoJBz3Uqak/4=;
        b=Q6SfQmaOSaUBvv3iLBhmMYEZMOP1qho1AVNOqp7M08jXEmdOJOwUEZ9f/iujmB63Wt
         BE/Wpya4k4/IzBpX4/r+1GU25urLXvDMMOFmGGDEJrk9X7p7eGcqllxwz5dsZ1bpF7HU
         cbHm73CU6PnQtVY8df/v9eUZ34YWEm670v6UfVB9E81MCN67BUK9EMKgNFE1DILvrVf4
         al8b2ncQTJQHFK7bRPTVIWPBAFc3uMTVbYtVTSj6ein75DVmOp2dBHBDxRXxQYMz+lgh
         FsQUOxo9CYs6ymCnYt/Mr7/PLjltP+6gRMdGDx/RoZuJNOjMRzCZTio8OD0GdE/MropT
         pDRg==
X-Gm-Message-State: AOJu0Yx9EBUw+GNugxYDQM/h5cTtpwVutHvOIuS2Eu3S9GNwuRQnGslZ
        l2vYS0oHP+l7APIu6vTvVuZ0lA==
X-Google-Smtp-Source: AGHT+IHP8e0ig5H8HhbPig62CSIBHh9eunykH8szviNxNp+jDo0jaFW7BQzj1bXxxJ0VICLY2FnW2w==
X-Received: by 2002:a05:651c:10cf:b0:2bb:b56b:f67e with SMTP id l15-20020a05651c10cf00b002bbb56bf67emr1392650ljn.19.1693387474397;
        Wed, 30 Aug 2023 02:24:34 -0700 (PDT)
Received: from elver.google.com ([2a00:79e0:9c:201:3380:af04:1905:46a])
        by smtp.gmail.com with ESMTPSA id x1-20020a05600c21c100b003fe3674bb39sm1652429wmj.2.2023.08.30.02.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 02:24:33 -0700 (PDT)
Date:   Wed, 30 Aug 2023 11:24:28 +0200
From:   Marco Elver <elver@google.com>
To:     andrey.konovalov@linux.dev
Cc:     Alexander Potapenko <glider@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, kasan-dev@googlegroups.com,
        Evgenii Stepanov <eugenis@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: Re: [PATCH 13/15] stackdepot: add backwards links to hash table
 buckets
Message-ID: <ZO8KzKWszioRKrks@elver.google.com>
References: <cover.1693328501.git.andreyknvl@google.com>
 <e9ed24afd386d12e01c1169c17531f9ce54c0044.1693328501.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ed24afd386d12e01c1169c17531f9ce54c0044.1693328501.git.andreyknvl@google.com>
User-Agent: Mutt/2.2.9 (2022-11-12)
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 07:11PM +0200, andrey.konovalov@linux.dev wrote:
> From: Andrey Konovalov <andreyknvl@google.com>
> 
> Maintain links in the stack records to previous entries within the
> hash table buckets.
> 
> This is preparatory patch for implementing the eviction of stack records
> from the stack depot.
> 
> Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
> ---
>  lib/stackdepot.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/lib/stackdepot.c b/lib/stackdepot.c
> index a84c0debbb9e..641db97d8c7c 100644
> --- a/lib/stackdepot.c
> +++ b/lib/stackdepot.c
> @@ -58,6 +58,7 @@ union handle_parts {
>  
>  struct stack_record {
>  	struct stack_record *next;	/* Link in hash table or freelist */
> +	struct stack_record *prev;	/* Link in hash table */

At this point this could be a normal list_head? Then you don't have to
roll your own doubly-linked list manipulation (and benefit from things
like CONFIG_LIST_DEBUG).

>  	u32 hash;			/* Hash in hash table */
>  	u32 size;			/* Number of stored frames */
>  	union handle_parts handle;
> @@ -493,6 +494,9 @@ depot_stack_handle_t __stack_depot_save(unsigned long *entries,
>  
>  		if (new) {
>  			new->next = *bucket;
> +			new->prev = NULL;
> +			if (*bucket)
> +				(*bucket)->prev = new;
>  			*bucket = new;
>  			found = new;
>  		}
> -- 
> 2.25.1
> 
