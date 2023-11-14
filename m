Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E56F47EA9C9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:46:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229645AbjKNEqn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:46:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232089AbjKNEqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:46:40 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F0F51BF
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:46:37 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-6bd73395bceso4082426b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699937196; x=1700541996; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=z0a8u4z+DUq7pMxicKnRyBLDUEkYlUYGe8Ef1Qv3STI=;
        b=cel19IJ6thEKGn5xpXKFx0GFgYtOeYvhUw0MGwECop0oYc7BchqusuSFZTcMdqb55q
         SST55fvZdi02plEDuyK1DPl84RpjLx/cjq1RvM+OpVnkMPDwHilgYcQYtP+6wyfkq06p
         YeuFnQPSpWGXbHo4j4XL8CnB1jvPEw3erEwgM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699937196; x=1700541996;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z0a8u4z+DUq7pMxicKnRyBLDUEkYlUYGe8Ef1Qv3STI=;
        b=ndkmhG60EqTmw31CRU5Bzc4A6BF7wYWkWgnxfzv2u0W5YPRE4Q7pSisJ/yoFUiqr+s
         jxlvqJAyl0vBTiMYSlU7LDnIWCOFzt3NcwjNixIVyFjKcMDxFFIwDDgZX1cYqxuUcH2n
         dsaMQddX14gwB74D31QvV4ZTRJXcKJtA1hJw2Npew2JJIlguGKPuOyqjLujmYKrloPxW
         q/lXVa7yXq3V+icfbyLg2bx7Sf6HVTkCbM7b3BZY47CZs181hMIYT55zm38XTJTp6a2I
         KJUT25AA74Og8DxFqzNt8V3vCpwOtF5Znrc2vgc9pbw9+k//A5PKWwLsHUhuSELNvMQS
         Chjg==
X-Gm-Message-State: AOJu0YxvfxDFv9aEL4t3/DIPmfgZliSPxQdQqKV9dTTvUvQav+dYDKYG
        BCd63SSCqbB9hBrqxJzZIeGGhg==
X-Google-Smtp-Source: AGHT+IGNQdjS2HSond40o2DEZuHcrsmwjNSXJJ6Otl8qWeHwrNfDjHKKQYMlq6qPVUmTUbyDR3kjJg==
X-Received: by 2002:a05:6a20:6a1c:b0:181:7d6d:c10b with SMTP id p28-20020a056a206a1c00b001817d6dc10bmr2434042pzk.7.1699937196532;
        Mon, 13 Nov 2023 20:46:36 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id hy13-20020a056a006a0d00b006c7ca969858sm398052pfb.82.2023.11.13.20.46.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:46:36 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:46:35 -0800
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
Subject: Re: [PATCH 17/20] mm/slab: move kmalloc() functions from
 slab_common.c to slub.c
Message-ID: <202311132046.04096EE39B@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-39-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-39-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:58PM +0100, Vlastimil Babka wrote:
> This will eliminate a call between compilation units through
> __kmem_cache_alloc_node() and allow better inlining of the allocation
> fast path.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
