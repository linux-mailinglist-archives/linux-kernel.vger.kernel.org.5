Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAA047EA997
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:35:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231976AbjKNEf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbjKNEfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:35:24 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88695D45
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:35:21 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1cc0d0a0355so39058075ad.3
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:35:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936520; x=1700541320; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2qJn7DbKeJdLYDJu5dncSAZYv48TYbHL51nKAxUFFOc=;
        b=VxE/DCWNcSFtXJqtMpC5QYzIGEDDTrbGj1yGBts3uz3R8d79LNFTfdbcA/dEm3oWmU
         TuQBe0HqbhQk6KF/7tJi49BEdYtBpNkJdvNV7ks7ATnuALZJZDtdrKXZVIOwdfPKiENH
         LfPv9Vqm5v/fj6z1faQR4T9fugFDwkGg8Iyi8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936520; x=1700541320;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2qJn7DbKeJdLYDJu5dncSAZYv48TYbHL51nKAxUFFOc=;
        b=WE2GtElCDph1bJlGsC51I3a+QgNpB56fS7da382ASWMI6ObYPuEh5FBVZtLS4XFgyt
         +sAwXEZqkBlc9uy2C8SRsLFZC1kRv+obHuPpEXDA+NuvQyxuG8V/UY/frFd9VUMvVZXO
         SLjxPFQ3gDq1l0+iB3HV+TQUEPGSsNry1lGcRe+Y8n1wzLIC7yXqtALDBEup0/GGWAkO
         X6xU4vE8LDxhCxc4KiKKOc02C1BIWVtv6boNr05hS3ediBaflyQJhO72y5cK/2MqyHo+
         kmlUg+ZjIImRAxkR98BWe/+67vpB3dKY2/4yyw//8gzCsl0dVJ96Eye31jjI4bJy/IOk
         1IUw==
X-Gm-Message-State: AOJu0Ywtp+ARECki+5m6kIeahPjGcWUpK1wynAkE6DQ8VMQ35+xPfo5V
        /AGDMOfG8rMaxs3usuMjb5DCcg==
X-Google-Smtp-Source: AGHT+IE2Kxwisuvac82p84jaALXF4xxfKmYC9mDZ5biXrUMK+/x45Z1bswMrDeJnNGtZLpoEhO/6PA==
X-Received: by 2002:a17:903:11d1:b0:1cc:6cc7:e29f with SMTP id q17-20020a17090311d100b001cc6cc7e29fmr1410299plh.43.1699936520572;
        Mon, 13 Nov 2023 20:35:20 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id l18-20020a170903121200b001bf52834696sm4762331plh.207.2023.11.13.20.35.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:35:20 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:35:19 -0800
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
Subject: Re: [PATCH 09/20] mm/slab: move struct kmem_cache_cpu declaration to
 slub.c
Message-ID: <202311132035.A0F72C0F5@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-31-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-31-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:50PM +0100, Vlastimil Babka wrote:
> Nothing outside SLUB itself accesses the struct kmem_cache_cpu fields so
> it does not need to be declared in slub_def.h. This allows also to move
> enum stat_item.
> 
> Signed-off-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
