Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF59F7EA9A6
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:38:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjKNEib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjKNEi3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:38:29 -0500
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACEFA1A7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:38:26 -0800 (PST)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5842a7fdc61so2670922eaf.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:38:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936706; x=1700541506; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cKLnTTpcsA4GTSpHutPlS9fMo+BLZ8ixEQsC9MUWwLk=;
        b=TuH8e6qV6/EInFoxz1miaeAAFEsLBTtYoGEKOPWYhyQiXnCiTAuD13eGSaSddQ8S9o
         2fBovA96XFn/wl5qu4/72ZzmLXdorvOvPOSScrNlRfASL8q7kBZBaq16aZMjCb1yV6PN
         ENBos8u15PIVTUeCRkLyVcIYsPQvgCT/i+3dM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936706; x=1700541506;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cKLnTTpcsA4GTSpHutPlS9fMo+BLZ8ixEQsC9MUWwLk=;
        b=fGbZuLeHpr48wOhY5G+F7zqjwBAcYIpeUfGzaWN3pHK6iQMwkrdTSz76SzRA7XLb3k
         /g9+HowTdkqBKKVw/CPlVY6dA9/nY38mhfsC+DxNtRYHGG3qB1XLE2vhNhO4MEjoU7GE
         ycCAZmZvsHpLb2kyYn7ZbGBDs5rlWjJ/K0VsizOAoUCwyyC3A8r5hAq24Qd/AJSXoN9O
         JBY8uNathUcw6Nl9tBkTO5jIozxJsh4kAi1HQieqvYwdxpYnKS4lCdCZqt7fDsMu+UpA
         YS7ME2EQYcVmT7Y1FGg0dS9T7jQTRooyqnbiPwh5IOfgmHTnaYrFN6qMwe5GBZuPjx2O
         z1Hg==
X-Gm-Message-State: AOJu0YxxTpqoERZek9iUDHzNH24B5kZkRJj43L1Wgpwn8LLK/0O+VmLX
        vtZm2JZ3rCwime6517dEarOf3g==
X-Google-Smtp-Source: AGHT+IFDSeKpFIR7EqfcNMWsaO6kBeTgiI6AAPV/dcvwqXilQHmw3/CSiZnWYA9Y/YDdW/YrAaS6hg==
X-Received: by 2002:a05:6358:914:b0:168:eded:d6c9 with SMTP id r20-20020a056358091400b00168ededd6c9mr1639355rwi.29.1699936705986;
        Mon, 13 Nov 2023 20:38:25 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id q14-20020a63e20e000000b0056946623d7esm4832935pgh.55.2023.11.13.20.38.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:38:25 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:38:24 -0800
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
Subject: Re: [PATCH 10/20] mm/slab: move the rest of slub_def.h to mm/slab.h
Message-ID: <202311132037.F4FA0B2@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-32-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-32-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:51PM +0100, Vlastimil Babka wrote:
> mm/slab.h is the only place to include include/linux/slub_def.h which
> has allowed switching between SLAB and SLUB. Now we can simply move the
> contents over and remove slub_def.h.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Now is the chance to do any whitespace updates! I saw a few #defines
that looked like they could be re-tab-aligned, but it's not a big deal. :P

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
