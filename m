Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA357EA9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:42:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232070AbjKNEm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:42:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjKNEmz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:42:55 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFA11125
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:42:51 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1cc921a4632so47360905ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936971; x=1700541771; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sCrSsxjAq1jCq+B2JpsAc9Scn9B6dHAemDj3eFlW1CE=;
        b=PicbEKxJg/UQGOrmAEEc1CFbYiPVXA4zgetGi1XaHRZx3T3vft9I8d4NKcB97Fj1NA
         GlwPWecS2g0DWpjuJ6UVfX3PqT36r/HU5aXZ7pOchbgI3v5UvJBB66mqNBsHogDhZEST
         yn4E/W7e3HCNnPfPWL4OA7JISg7xENXuYJTCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936971; x=1700541771;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sCrSsxjAq1jCq+B2JpsAc9Scn9B6dHAemDj3eFlW1CE=;
        b=mJ4n02cNOCTCsKYB//1W49O5lRyaB9LmAV+SI8gz8rpVDJiuibMs6/3rU86HT3petG
         mpprIhNmsZ2V//nvIErCmhFAYdksfJrjxKcLk2kY9b7DSL53gorcdGZEgA4alNw5BOyb
         62DUYJ5WcYjgXzn08YEly8GUMtmSNjcgGebSULZUMzxtrGY67tX5J8eJMZEUZ92wzRiQ
         4qQ7h5GHhlj8/1czFidAcnjiaYW6vWypS0lZMdVrXsa2/gUvPwbyjRUDVdq/PpcFGsPP
         VujMpD4tJSAdOf/xymbrtHv8Rh4yKhtdFWDAjkldjUuEGif0e076J+vJVg4HRKgnzqRT
         oliA==
X-Gm-Message-State: AOJu0YxPPPA4vgkno6UzO8Mf0Tcsy7h7XCVtR6tUMc0Nm+Rog9tEqhps
        PlCEMg4bKZ1ry1qEnwPMaAusgg==
X-Google-Smtp-Source: AGHT+IGdwyQZzmA4/9nwfKzzB4u85s8j9BkjlV/hZKmIfu7UdDuaDJSnLL1zsdTxEYzRzIo24svtGQ==
X-Received: by 2002:a17:902:db0d:b0:1cc:4467:a563 with SMTP id m13-20020a170902db0d00b001cc4467a563mr1181743plx.3.1699936971495;
        Mon, 13 Nov 2023 20:42:51 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id z5-20020a1709027e8500b001b8622c1ad2sm4947830pla.130.2023.11.13.20.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:42:51 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:42:50 -0800
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
Subject: Re: [PATCH 12/20] mm/slab: move pre/post-alloc hooks from slab.h to
 slub.c
Message-ID: <202311132042.CA0081D@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-34-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-34-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:53PM +0100, Vlastimil Babka wrote:
> We don't share the hooks between two slab implementations anymore so
> they can be moved away from the header. As part of the move, also move
> should_failslab() from slab_common.c as the pre_alloc hook uses it.
> This means slab.h can stop including fault-inject.h and kmemleak.h.
> Fix up some files that were depending on the includes transitively.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
