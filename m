Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 736CC76880D
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jul 2023 22:43:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjG3Uny (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jul 2023 16:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjG3Unx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jul 2023 16:43:53 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB8510C0;
        Sun, 30 Jul 2023 13:43:50 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-58439daf39fso40324057b3.1;
        Sun, 30 Jul 2023 13:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690749830; x=1691354630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9mDvfJJWxk9twVy3Oy4rXAcXGiHrz6rR6pv/vxBssrs=;
        b=SvzWDh2azm6F4Uu3toK4qISg1tNtJekhxtPPKEVr5LWDKNma14QIb3IdRm4QSooiCw
         HpVLjaxLYZmna3NV4nDwi+XyeR3yx6Y4cXn07KpuQo56stgXeLvBsg13FxiluvectFU8
         gwVw4NzGWSrUraj4TY98/49Q3/MdyUiTzACf+W+L+4eLmhWVqBMgZZlzVv0dqtn1pDDe
         tE3YEdI9tx8ewueIRRZoyE2TlVPlvPyLIVCy5GifHuAaTqGBFEWu6Y3khIEWGaF4thv9
         7/uWaGJSLDdOLwFYx2rTXvxyqFiyulhM8R3dWwXeH9rWzPUJsiOfl2rmmD8+mrbxOW70
         zLPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690749830; x=1691354630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9mDvfJJWxk9twVy3Oy4rXAcXGiHrz6rR6pv/vxBssrs=;
        b=e/MoAA0fn9wL5yrl9y/HmVa+6uyrgbXCzaj3v8zXwerM4nDMXQeX7FLMPBMLbykBFi
         xiW6c7yicBWL1PTzdjaGpLlqbETAWZVKIEd2nBqNLUFBd8fB2CXdCipDwa+WzFxMwjEB
         mMJPb6wpv1W/AaUqiqy+W/IYU+7St1p3IbcVJEbA1/BHlHPlLTcsWlIuwhPFd4oZBInD
         pfodobRhbv7pcHRYWvqJiuMANWxtoiboziM5wC6YCZK0ejlCoVb231ajHUCozw5wdGmM
         Y3y01k3qTqXdBZXpXnDv5A6ucoO1sdy4O5/pvqfkTpRj+30yNONkg/S/z3fKvNsf02oe
         IyQw==
X-Gm-Message-State: ABy/qLZCJpqOChovDGYvTwOKmsrkesW8J0bNniKu6xbxGrNkd3QPXu43
        bKe8FO2rmadTFWKG5sH4o5HGqgc0brInmVeCe3Q=
X-Google-Smtp-Source: APBJJlHuvAmNpM0DJMHi2ovKVgNsxjBAxDuY4RdcUYR80/VN27ZIuNM+G3dMgtbBcXvXXTBbbknBHxoYOcDFXLo1uKs=
X-Received: by 2002:a0d:e84d:0:b0:583:f936:cc5a with SMTP id
 r74-20020a0de84d000000b00583f936cc5amr7457243ywe.52.1690749829759; Sun, 30
 Jul 2023 13:43:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230730012905.643822-1-boqun.feng@gmail.com>
In-Reply-To: <20230730012905.643822-1-boqun.feng@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 30 Jul 2023 22:43:38 +0200
Message-ID: <CANiq72k7Kwiq+HDLAv+TrrJC1f9a9ZHxsoKxe9dwr-4uxC7o3Q@mail.gmail.com>
Subject: Re: [PATCH 0/3] Fix alignment issue and prepare for rust 1.71
To:     Boqun Feng <boqun.feng@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Dariusz Sosnowski <dsosnowski@dsosnowski.pl>,
        Geoffrey Thomas <geofft@ldpreload.com>,
        Fox Chen <foxhlchen@gmail.com>,
        John Baublitz <john.m.baublitz@gmail.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Kees Cook <keescook@chromium.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 30, 2023 at 3:29=E2=80=AFAM Boqun Feng <boqun.feng@gmail.com> w=
rote:
>
> Patch #1: introduces the core helper function that help calculate the
> correct size for krealloc(), and also use the helper function to fix
> `__rust_*` ones, this should be backported to stable kernels hence the
> Cc.
>
> Patch #2: use the helper function in KernelAllocator
>
> Patch #3: Bjorn's patch with correct use of the helper function.

Looks good to me, thanks a lot!

> I have to add a few more SAFETY comments in these `__rust_*` functions,
> which may cause conflict with your 1.71 series.

No worries.

> Since all previous patches get refactored a bit, I dropped all the
> Reviewed-bys, appreciate anyone to take a look, thanks!

Thanks Boqun!

Cheers,
Miguel
