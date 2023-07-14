Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F5D75365B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 11:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235292AbjGNJ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 05:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230372AbjGNJ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 05:26:30 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD120358C
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:26:18 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-783549ef058so60940939f.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 02:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1689326778; x=1691918778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=NPfPZdNY/TPryzKJfC75beotjl4rmYcQPNm6r14jih0=;
        b=T0yDg5OPXmg67RaUx73uK7fBFeLsLUrAHSycus5i3I1N1BcNhT3GG60LncrjKGQY76
         zp+45hCfctdJFhgZIA0g592LNZxkbp3W7QffFU2ywr/U3E65f6Og9Y8TSlxB0yweYCBd
         yWhz9luIUjUlpi6G4Wy6NmH/O7spTnWJktJLQjKs/HoQfo8axVuGYX4s9J2SNGIIOe2O
         GKIvGehY7NG7Qj2Ih6JslQc/Xa8Hgdyx+rPjT62c/H+IbUf9lsxxpptUA2rgmWBzwgE6
         2SSB/WeP1YtZciADWuaQqQlIH3gj+dIuHoKcSdbuvAkbYryG2FMFbMNUAQGRNTgyYiR5
         wGcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689326778; x=1691918778;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NPfPZdNY/TPryzKJfC75beotjl4rmYcQPNm6r14jih0=;
        b=PBqvsRAi8mUaXHnSueFWasBDUTP4rJ+AYU3UjGqfII1XI4od4c2XrLwbGBjWRk3/XN
         itIgwEekQssFxemIftr9Ed4kr7tnysdHWGT0xRui3vfinG8AiB2scIUAFfTEWgVEoXpt
         uLSqxjXZJ8D+OUWzr0nfxObz9mxj4OkxUaxZAtespE3EbV29cDjwSKxXvKGEiOTmcV+V
         nYrnY9xPh7iZL9i7xhc4+LxcsCTRO1h7zyh4zXUYX2gYIZmkLKGLsJVJScrFlcL7h/Dw
         bWurmdsDGF3VMD/jGxLhUM5yfzKxR0plq60xTAkjBcW/S8ZcO1+GSm4CZlEkr/05aCkS
         08hQ==
X-Gm-Message-State: ABy/qLYPG9wu+nwh7Rzp48dts8JN6uawi55EH8KG/ct1N0LjzFLDDvS7
        bihiJAYe8ZKA36iQ7V/jmrAfYPVDGepwwxkgVlj+AA==
X-Google-Smtp-Source: APBJJlEWD0z1UymRyBM9my/WyEUGmK/fzLNfLPPQRgHyz50Jxz4OIwETJM94ufzZ48gRst4cFYEvj6bKjGmV1ZicHIw=
X-Received: by 2002:a05:6602:18c:b0:787:1990:d2e2 with SMTP id
 m12-20020a056602018c00b007871990d2e2mr4112168ioo.10.1689326777863; Fri, 14
 Jul 2023 02:26:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230713125706.2884502-1-glider@google.com> <20230713125706.2884502-4-glider@google.com>
 <ZLAzG+Ue3JqDM/F3@smile.fi.intel.com>
In-Reply-To: <ZLAzG+Ue3JqDM/F3@smile.fi.intel.com>
From:   Alexander Potapenko <glider@google.com>
Date:   Fri, 14 Jul 2023 11:25:41 +0200
Message-ID: <CAG_fn=W4Uv2YaO=Udwo80_f74y8o0+WWVVqTNK3iW5VDs5B8+w@mail.gmail.com>
Subject: Re: [v2 3/5] arm64: mte: implement CONFIG_ARM64_MTE_COMP
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, linux@rasmusvillemoes.dk,
        yury.norov@gmail.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > + *
> > + *
> > + *
>
> Isn't a bit too many blank lines?

Will fix in v3, thanks!

> > + *
> > + *
> > + *
>
> Ditto.
Ack

> ...
>
> > +#include <linux/bitmap.h>
> > +#include <linux/gfp.h>
> > +#include <linux/module.h>
> > +#include <asm/mtecomp.h>
> > +#include <linux/slab.h>
> > +#include <linux/swab.h>
> > +#include <linux/string.h>
> > +#include <linux/types.h>
>
> Please, keep linux/* and asm/* separated like
>
> linux/*
> ...blank line...
> asm/*

Done (here and in other files).

> ...
>
> > +#define HANDLE_MASK ~(BIT_ULL(63))
>
> GENMASK_ULL(62, 0)
Done (here and below)

> Not sure why fls() / BIT() can't be used directly instead of these functions,
> but okay, they are not too ugly.

They can't be used directly because 128 maps to 0, but I can sure
simplify them a bit.


> > +void ea0_tags_to_ranges(u8 *tags, u8 *out_tags, short *out_sizes, int *out_len)
> > +{
> > +     u8 prev_tag = 0xff;
>
> GENMASK()? U8_MAX? ((u8)-1)? What is this?
This is an invalid tag value, let it be U8_MAX.


> > +     memset(out_tags, 0, *out_len * sizeof(*out_tags));
> > +     memset(out_sizes, 0, *out_len * sizeof(*out_sizes));
>
> array_size() ?
Done

>
> > +     for (i = 0; i < MTE_GRANULES_PER_PAGE; i++) {
> > +             cur_tag = tags[i / 2];
> > +             if (i % 2)
> > +                     cur_tag = cur_tag % 16;
> > +             else
> > +                     cur_tag = cur_tag / 16;
> > +             if (cur_tag == prev_tag) {
> > +                     out_sizes[cur_idx]++;
> > +             } else {
> > +                     cur_idx++;
> > +                     prev_tag = cur_tag;
> > +                     out_tags[cur_idx] = prev_tag;
> > +                     out_sizes[cur_idx] = 1;
> > +             }
>
> Perhaps instead of doing those % 2, / 2 we simply can go twice less outer loops
> and introduce an inner loop of 2 iterations?

Done


> > +                     if (pos % 2 == 0)
>
> Would be better to keep this aligned with above?
>
>                         if (pos % 2)
>                                 ...
>                         else
>                                 ...

It would, but i % 2 above didn't survive the rewrite, so I assume it
is fine to keep pos % 2 == 0 as is.

>
> ...
>
> > +EXPORT_SYMBOL(ea0_storage_size);
>
> Btw, can we go to the namespaced export from day 1?

Am I getting it right that I just need to change EXPORT_SYMBOL to
EXPORT_SYMBOL_NS and import the namespace in
arch/arm64/mm/test_mtecomp.c?
I.e. MODULE_IMPORT_NS is not needed in mteswap_comp.c, because it is
linked into the kernel?

>
> ...
>
> > +     for (i = 0; i < len; i++) {
> > +             if (i == len)
> > +                     break;
>
> Interesting dead code. What was the idea behind this?

Haha, no idea :)
Removed it.

>
> > +             if (sizes[i] > largest) {
> > +                     largest = sizes[i];
> > +                     largest_idx = i;
> > +             }
>
> (alas max_array() can't be used here)
There's no max_array() in the kernel, am I missing something?


>
> > +             r_sizes[i] = bitmap_get_value_unaligned((unsigned long *)buf,
> > +                                                     bit_pos, 7);
>
> These castings is a red flag. bitmap API shouldn't be used like this. Something
> is not okay here.

In fact it makes sense to make buf an unsigned long*, we don't treat
it as a byte array anywhere else.

> ...
>
> > +void ea0_release_handle(u64 handle)
> > +{
> > +     void *storage = ea0_storage(handle);
> > +     int size = ea0_storage_size(handle);
> > +     struct kmem_cache *c;
>
> > +     if (!handle || !storage)
> > +             return;
>
> You use handle before this check. Haven't you run static analysers?

Sparse doesn't report anything in these files, are there any
alternatives adopted in the kernel?

Note that handle is not dereferenced above, so there's no error per se.
Yet (as pointed out below) these checks are redundant, so I'll remove
some of them.

>
> ...
>
> > +static int mtecomp_init(void)
> > +{
> > +     char name[16];
> > +     int size;
> > +     int i;
> > +
> > +     for (i = 0; i < NUM_CACHES; i++) {
> > +             size = ea0_cache_id_to_size(i);
> > +             snprintf(name, ARRAY_SIZE(name), "mte-tags-%d", size);
> > +             mtecomp_caches[i] =
> > +                     kmem_cache_create(name, size, size, 0, NULL);
> > +     }
> > +     return 0;
> > +}
>
> > +
>
> Unneeded blank line.

I think there's no agreement on this in the kernel code, but my
version is more popular:

$ git grep -B2 '^module_init(' | grep '\-}' -A2 | grep module_init | wc
   2688    2707  164023
$ git grep -B2 '^module_init(' | grep '\-}' -A1 | grep module_init | wc
    505     523   30989
