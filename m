Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 755857A6AE2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 20:50:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232486AbjISSuT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 14:50:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232084AbjISSuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 14:50:17 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EBA39D
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:50:08 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b962c226ceso98578441fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:50:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1695149406; x=1695754206; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=rf2MsE0QRbUtAnaD3OhEqfmgpq4OLQ94+2y/+SBxQck=;
        b=KLDmxlVAg5/b7kAqJumojDYupoyU4pQtuvW6K2HHxEqB+p278MdmvpzZJYDYnO91CW
         RWIzxhVL2O4q6F54xcEImtvRYDOJAFqnOqgAIrwJn2dg2B8MnOSgtL9YC/YBwOj2gVpW
         meSFs7ZE0DPak1Km60L6TGysXdIAdEzRYtuOk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695149406; x=1695754206;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rf2MsE0QRbUtAnaD3OhEqfmgpq4OLQ94+2y/+SBxQck=;
        b=DgCqRGRYBdslwHKvZT3XsdUuXCWUuYp5+ZUMS2CEaKzjaWZWWWlCwX2niIDEqmD4kN
         E4nk2gFWwD0mSUA7w4hZAAIvdITjbVLiocmxRJKicc85/+IFGbzN9YaA6BCWZ5UwGfkI
         UbbAxKZiydNLCanF7W8Uq5z2sAFzIdCTfGWrbebXjNOLysee7jaMsbh/eQ7kx2URchhX
         NuN15pAkIRwlB2u0UEhGQOAq3/FD4Gx7jn7LrogusAXafxoN4tBnEOyqfWeoFsa5Xyi+
         e9op2gyp04XPAIBjzzT9Wn5RfgtTlNeApSl4P9zoF3cwQauzSjph9hkdprX1Zt4/78Dk
         30Aw==
X-Gm-Message-State: AOJu0YydaWK/2GGUJj/umMbRq0KEcm22n2ZYj70hPptjs3/hniedaiwi
        O08dnMCTqkR3agUS54LTzf7Rr915WpJJtAE26FANKEXM
X-Google-Smtp-Source: AGHT+IHFWMFk38IHpdx02XTKqBWm/TROlpiupCU8I7ney2ddOY4jPAByTiRmAYrYqX56RerW7qITuA==
X-Received: by 2002:a2e:9617:0:b0:2bc:b6ce:eab with SMTP id v23-20020a2e9617000000b002bcb6ce0eabmr214907ljh.51.1695149406511;
        Tue, 19 Sep 2023 11:50:06 -0700 (PDT)
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com. [209.85.208.50])
        by smtp.gmail.com with ESMTPSA id gy18-20020a170906f25200b009a9fbeb15f5sm8103853ejb.46.2023.09.19.11.50.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Sep 2023 11:50:06 -0700 (PDT)
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-532784c8770so2024775a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 11:50:06 -0700 (PDT)
X-Received: by 2002:a50:ee14:0:b0:530:d8df:afaa with SMTP id
 g20-20020a50ee14000000b00530d8dfafaamr219079eds.41.1695149405833; Tue, 19 Sep
 2023 11:50:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230915105933.495735-1-matteorizzo@google.com>
 <7a4f5128-28fd-3c5f-34c2-1c34f4448174@intel.com> <1d7573c0-ebbc-6ed2-f152-1045eb0542f9@os.amperecomputing.com>
 <CAHKB1w+rVyww0UrHhzeGfPA7FM482Z-7ApzXvekVqLHvTDAV3Q@mail.gmail.com>
 <ZQiLX0W2Tcr+wdJT@gmail.com> <CAHk-=wgGzB4u-WZsDpdgjwX1w5=9CLE0gorhaNFD09P1FUGeuQ@mail.gmail.com>
 <CAHKB1w+9GgY_e6J+rZ4zDaXrPZab5xteTuDEH0Z2hWe6x-pT5g@mail.gmail.com>
In-Reply-To: <CAHKB1w+9GgY_e6J+rZ4zDaXrPZab5xteTuDEH0Z2hWe6x-pT5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 19 Sep 2023 11:49:48 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiWReaH-khCA_uiKC5xJSQkDudEfybdepSZXKvdXZkZsg@mail.gmail.com>
Message-ID: <CAHk-=wiWReaH-khCA_uiKC5xJSQkDudEfybdepSZXKvdXZkZsg@mail.gmail.com>
Subject: Re: [RFC PATCH 00/14] Prevent cross-cache attacks in the SLUB allocator
To:     Matteo Rizzo <matteorizzo@google.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Lameter, Christopher" <cl@os.amperecomputing.com>,
        Dave Hansen <dave.hansen@intel.com>, penberg@kernel.org,
        rientjes@google.com, iamjoonsoo.kim@lge.com,
        akpm@linux-foundation.org, vbabka@suse.cz,
        roman.gushchin@linux.dev, 42.hyeyoo@gmail.com,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-mm@kvack.org,
        linux-hardening@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, corbet@lwn.net, luto@kernel.org,
        peterz@infradead.org, jannh@google.com, evn@google.com,
        poprdi@google.com, jordyzomer@google.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 19 Sept 2023 at 08:48, Matteo Rizzo <matteorizzo@google.com> wrote:
>
> On Mon, 18 Sept 2023 at 20:05, Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > ... and equally importantly, what about DMA?
>
> I'm not exactly sure what you mean by this, I don't think this should
> affect the performance of DMA.

I was more worried about just basic correctness.

We've traditionally had a lot of issues with using virtual addresses
for dma, simply because we've got random drivers, and I'm not entirely
convinced that your "virt_to_phys()" update will catch it all.

IOW, even on x86-64 - which is hopefully better than most
architectures because it already has that double mapping issue - we
have things like

        unsigned long paddr = (unsigned long)vaddr - __PAGE_OFFSET;

in other places than just the __phys_addr() code.

The one place I grepped for looks to be just boot-time AMD memory
encryption, so wouldn't be any slab allocation, but ...

               Linus
