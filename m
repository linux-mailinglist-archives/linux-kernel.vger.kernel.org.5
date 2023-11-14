Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02FAD7EA961
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:13:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjKNENK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:13:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjKNENJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:13:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48911D0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:13:06 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6c4884521f6so4370531b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699935186; x=1700539986; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+59LbEu2KNUEAvaciP4no1NYqRz3c5xA76P/RF2+jHM=;
        b=HMroAsQeUbhDkG3TvWHxJdmh3JQsX3xPQv/9ohE6D2fBIK/q7zR2HoL6ZqPZDmPQCI
         RACizT8YbH9y2TJEzLlbIIK7KVWjq8Q+UHeQPfs+imyp09RUA2/ylYYCF7HIjgHJmv01
         ARGG9WBdC7RslTqwXx3kFSYxY6iMoKHbLWJ4w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699935186; x=1700539986;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+59LbEu2KNUEAvaciP4no1NYqRz3c5xA76P/RF2+jHM=;
        b=LEsSg5w8cZoxVIw72L/v2bbFJyFkmFgPc0j+qwN5Dn+Efj4XEh2OD0gZZXu47p0yJx
         g/g2bG7z0Ad9MBfas45Lb/pEu6hLBd5k0ei7wcWi9t+RlBwcgmUk5duQ5N6RkahXYRPW
         ROFd1PoUZWRtcaXD55hRfjMksDY5opuY5/bl+LrHPIi4Hd+rSYXNHfJ5+uaBsnZjicmd
         sE23oGqTvPntv4fIUw6ZQleo0XLnYz7g/doC9Iy+nqpyWqD+X5j9bhFfXutm386rHUWV
         CvCsbvuvz2+3qbDb16paEzcKNeF0/bDQuLU9MV4VXtdjiEbTuf5NgtqRw8xFR/J0xx3j
         i/nA==
X-Gm-Message-State: AOJu0YzJPbpomi7Sq+cBmtgXoQ7Zby77KlPvSK7F50vgzkgakoef9o0D
        ySSxNRa5ivPy0QpBsu1AXNlT8g==
X-Google-Smtp-Source: AGHT+IFnyRA9Bn0/Hw8sxY38vdUYS60UHoNlHsJm70MG0sel5PqsKgmyNC3i7GG3PlPRUovMdSf9XQ==
X-Received: by 2002:a05:6a00:2d82:b0:6c3:45bc:41f8 with SMTP id fb2-20020a056a002d8200b006c345bc41f8mr7440255pfb.33.1699935185790;
        Mon, 13 Nov 2023 20:13:05 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id p28-20020a056a000a1c00b006933e71956dsm353045pfh.9.2023.11.13.20.13.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:13:05 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:13:04 -0800
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
Subject: Re: [PATCH 02/20] KASAN: remove code paths guarded by CONFIG_SLAB
Message-ID: <202311132012.142AC3618@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-24-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-24-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:43PM +0100, Vlastimil Babka wrote:
> With SLAB removed and SLUB the only remaining allocator, we can clean up
> some code that was depending on the choice.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
