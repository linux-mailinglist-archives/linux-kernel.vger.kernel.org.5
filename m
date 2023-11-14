Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCBC87EA992
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 05:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231994AbjKNEei (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 23:34:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231417AbjKNEef (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 23:34:35 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7841CD48
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:34:32 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-6bee11456baso4443450b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 20:34:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699936472; x=1700541272; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=o11HARQxoCvg8Gx5zjjgZkRsPvVu73rMm7hpUxapQ0A=;
        b=nCjAYxdqkxTcu4IH1X2BoihM3eISHye9R89txlKCrNR1Z21wy+2EWieTDV8Lt7FRcc
         8oDzGftIS6Xl+kf3lbraPK9h5hHKtFVG5zLOqK9qvFklCKwOR9twagX5h7dtuDQ4e+TH
         RHbCs7s5CBh9e8cJAp2tnrrOlRwc8lEfqZwBY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699936472; x=1700541272;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o11HARQxoCvg8Gx5zjjgZkRsPvVu73rMm7hpUxapQ0A=;
        b=TaGPZnCIFOaQaNIJXFmcwmrk+kwt/7ZMeDf59nWbPyaJkIDDf6mA7yEeB9flImTyVr
         kR3SyU60d33YlWsfIpXX6O++akVUgYTQXTnZS8fFEIkPuuHRbtwQBtFBAVbaIWiaG8RY
         kgeho/kAXj8hscSAlqfpj81t87mlVm6fjaducBflg50Hajf1yD341E+pfmQJyALVfuJ1
         Ia/mqPOxaEQZr1tXU7oE40qq/wf6lyNms4BIEc3teXOmc0UoO9Lq4XVra05yeDJieDSn
         VIN09uaVcT9B5YLYYUjFYARPjgLIdvEp2pI+9WpqT6RhVwDHU4mtry1wUVxrbVQxHu2U
         IJuQ==
X-Gm-Message-State: AOJu0YwyZe4964iWsg92MGmivNtVJb5VXSibhNoMLmpHwEnzwHQI6My0
        /CpV5/pd7Wy1n6e/Mgvqpo8l7A==
X-Google-Smtp-Source: AGHT+IGseueIFF+JmLoGhwnqLpZw2W4u0dwVJZMG/dnzFetGq2hz6yOEFr5CcVgcKPJNd+w2yidtYw==
X-Received: by 2002:a05:6a20:729e:b0:186:7ac3:41c8 with SMTP id o30-20020a056a20729e00b001867ac341c8mr4469072pzk.56.1699936472009;
        Mon, 13 Nov 2023 20:34:32 -0800 (PST)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id a13-20020a170902b58d00b001c465bedaccsm4835731pls.83.2023.11.13.20.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Nov 2023 20:34:31 -0800 (PST)
Date:   Mon, 13 Nov 2023 20:34:31 -0800
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
        kasan-dev@googlegroups.com, cgroups@vger.kernel.org,
        Mark Hemment <markhe@nextd.demon.co.uk>
Subject: Re: [PATCH 08/20] mm/slab: remove mm/slab.c and slab_def.h
Message-ID: <202311132032.1BB9A17@keescook>
References: <20231113191340.17482-22-vbabka@suse.cz>
 <20231113191340.17482-30-vbabka@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231113191340.17482-30-vbabka@suse.cz>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 13, 2023 at 08:13:49PM +0100, Vlastimil Babka wrote:
> Remove the SLAB implementation. Update CREDITS (also sort the SLOB entry
> properly).
> 
> RIP SLAB allocator (1996 - 2024)

/me does math on -rc schedule... Yeah, okay, next merge window likely
opens Jan 1st. So, this will land in 2024. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
