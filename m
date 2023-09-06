Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F2057942EF
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 20:16:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243336AbjIFSQh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 14:16:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbjIFSQg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 14:16:36 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC8E10C8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 11:16:32 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-26f3e26e55aso80565a91.3
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 11:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694024192; x=1694628992; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=lsgYsuYMD9JP8mkY+KHbnfMRzc75nfCa+ZIUoHqmh8o=;
        b=eKyRyrbrzCmltcfDEIQHmkeKHU3sIqNIrePmTyAHZtIlw3V9eSkz5KNYEjkwRTtf9y
         BhGP7HKkgq8Akq4SjGojAc22d+B5Y3VGZkLe1qx++GG9ZwRovjTtBOa9Aw1w/8zPmYjU
         yEwQavKI+3DWQEhi1Gls0CKZzjVPky0cJARZg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694024192; x=1694628992;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsgYsuYMD9JP8mkY+KHbnfMRzc75nfCa+ZIUoHqmh8o=;
        b=Hts9tpqVc0qDRD15Nmu+LU6F4nW80Wzb5gaXpBJbAeLbWOzT51MSs+K4vmNYkMwFEg
         5MnpNfVjB8w8lMeNF/uvF+EahCx8mxSqDZCzw3q67Rl6mEyTrVC70V0yoKyNMoIjM3oN
         KcHd111knFrzU4RLW/Y5bBQ6pQmDa8lAOudJR8oDHxMBkAJGcwqemR2BzTjfHPvdz/4R
         lFS1W9ryRDjuufjGf9C4cem/NDS3VcyMa05q6FmC1KJeoftog9yWLYBKA6XiBoWAAe8k
         Rq813QLhLCyQMIvn9p1B2+XK/HaJfygT0T51Ln34kZ5FDWqU8nAfuJwqO3mNS+FQzckf
         Ltlg==
X-Gm-Message-State: AOJu0Yx/keHM7qyDDiNpnEEiufxWaZM6gjhMypvq+sghjYaZ12wOgjgi
        1DfirWBLKXiit/vm9Mvb3k8PVw==
X-Google-Smtp-Source: AGHT+IGG4aTceHugUlvAN9jn2NNSgfQYELoIrGL+Bol5zOldnujC5xO5Tq8qDa0dRqi1FTLXYfteLQ==
X-Received: by 2002:a17:90a:d3c5:b0:262:ded7:63d with SMTP id d5-20020a17090ad3c500b00262ded7063dmr14197409pjw.17.1694024192356;
        Wed, 06 Sep 2023 11:16:32 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id d12-20020a170902c18c00b001b694140d96sm11363171pld.170.2023.09.06.11.16.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Sep 2023 11:16:31 -0700 (PDT)
Date:   Wed, 6 Sep 2023 11:16:30 -0700
From:   Kees Cook <keescook@chromium.org>
To:     David Laight <David.Laight@aculab.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'linux-mm@kvack.org'" <linux-mm@kvack.org>,
        'Vlastimil Babka' <vbabka@suse.cz>,
        'Christoph Lameter' <cl@linux.com>,
        'Pekka Enberg' <penberg@kernel.org>,
        'David Rientjes' <rientjes@google.com>,
        'Joonsoo Kim' <iamjoonsoo.kim@lge.com>,
        'Andrew Morton' <akpm@linux-foundation.org>,
        'Eric Dumazet' <edumazet@google.com>
Subject: Re: [PATCH] slab: kmalloc_size_roundup() must not return 0 for
 non-zero size
Message-ID: <202309061106.C0690BDBB@keescook>
References: <fcfee37ead054de19871139167aca787@AcuMS.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fcfee37ead054de19871139167aca787@AcuMS.aculab.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 08:18:21AM +0000, David Laight wrote:
> The typical use of kmalloc_size_roundup() is:
> 	ptr = kmalloc(sz = kmalloc_size_roundup(size), ...);
> 	if (!ptr) return -ENOMEM.
> This means it is vitally important that the returned value isn't
> less than the argument even if the argument is insane.
> In particular if kmalloc_slab() fails or the value is above
> (MAX_ULONG - PAGE_SIZE) zero is returned and kmalloc() will return
> it's single zero-length buffer.
> 
> Fix by returning the input size on error or if the size exceeds
> a 'sanity' limit.
> kmalloc() will then return NULL is the size really is too big.
> 
> Signed-off-by: David Laight <david.laight@aculab.com>
> Fixes: 05a940656e1eb ("slab: Introduce kmalloc_size_roundup()")
> ---
> The 'sanity limit' value doesn't really matter (even if too small)
> It could be 'MAX_ORDER + PAGE_SHIFT' but one ppc64 has MAX_ORDER 16
> and I don't know if that also has large pages.
> Maybe it could be 1ul << 30 on 64bit, but it really doesn't matter
> if it is too big.

I agree that returning 0 for an (impossible to reach) non-zero
is wrong, but the problem seen in netdev was that a truncation happened
for a value returned by kmalloc_size_roundup().

So, for the first, it shouldn't be possible for "c" to ever be NULL here:

	c = kmalloc_slab(size, GFP_KERNEL, 0);
	return c ? c->object_size : 0;

But sure, we can return KMALLOC_MAX_SIZE for that.

The pathological case was this:

	unsigned int truncated;
	size_t fullsize = UINT_MAX + 1;

 	ptr = kmalloc(truncated = kmalloc_size_roundup(fullsize), ...);

Should the logic be changed to return KMALLOC_MAX_SIZE for anything
larger than KMALLOC_MAX_SIZE? This seems like a different kind of
foot-gun.

Everything else in the allocator sanity checking (e.g. struct_size(),
etc) uses SIZE_MAX as the saturation value, which is why
kmalloc_size_roundup() did too.

-- 
Kees Cook
