Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3ADC7B3D11
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 01:51:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233526AbjI2Xka (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 19:40:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Xk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 19:40:29 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D99E3EB;
        Fri, 29 Sep 2023 16:40:27 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69086C433CA;
        Fri, 29 Sep 2023 23:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696030827;
        bh=j795K5/MAlYT7miSth5njB9uoLB+NjYOmU2pz6sh7/8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=LnESN84csn3Ak6ZRIYlcj8hNERPAid/65iQ720iQ5ASNMzRc7vL9gjrg/0jbnmU1W
         TUrEaca6mXN/sLX0EBP/ffXYpmyHynGyGsWQsLCM3ffM/HP12xIbYxtFJnIdvDTMlV
         0uNBJK1k70vPURiWyjPPHUpA/gMu9D/E8zFBi8CChm24mDu88gPZjDn1T9T1O/s3gG
         z5Bk9GKhpjQH1049I3YZNwxk0WaHvw5n++7FKL6+zWqQfxNNCu8aOOiVkD/LC2e6Se
         XfW61O7iKz2k/W9h93s7XkXYnIO8367dE+0uvxUYvrNgThYCUJcPzcguty63YE3hyL
         +dqHKPXyn1fGQ==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-503056c8195so23616841e87.1;
        Fri, 29 Sep 2023 16:40:27 -0700 (PDT)
X-Gm-Message-State: AOJu0YxzKdn9nruGW3lOLvgghPfH5ybeIYxKWum1DP4NnejWgT/9vqbK
        YHFWIwNo3xU3z65SmWYRLl40G9eyPnWymYXfYcY=
X-Google-Smtp-Source: AGHT+IFp7rMJNApRkcjAscXMkeiqDCqNsoHNvxFXia7ij003zaInwJkMVLmEYpzg05PtEQhv43/orpA/sFcxIJIt5G8=
X-Received: by 2002:a19:504b:0:b0:500:9a15:9054 with SMTP id
 z11-20020a19504b000000b005009a159054mr4131558lfj.20.1696030825585; Fri, 29
 Sep 2023 16:40:25 -0700 (PDT)
MIME-Version: 1.0
References: <20230915200328.never.064-kees@kernel.org> <169601526973.3013632.16756928162777602693.b4-ty@chromium.org>
In-Reply-To: <169601526973.3013632.16756928162777602693.b4-ty@chromium.org>
From:   Song Liu <song@kernel.org>
Date:   Fri, 29 Sep 2023 16:40:13 -0700
X-Gmail-Original-Message-ID: <CAPhsuW6RfCryssufHjWHRdUGCh2DywnNNtidZ-UxEWvwo4gcbQ@mail.gmail.com>
Message-ID: <CAPhsuW6RfCryssufHjWHRdUGCh2DywnNNtidZ-UxEWvwo4gcbQ@mail.gmail.com>
Subject: Re: [PATCH] md/md-linear: Annotate struct linear_conf with __counted_by
To:     Kees Cook <keescook@chromium.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-raid@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 12:21=E2=80=AFPM Kees Cook <keescook@chromium.org> =
wrote:
>
> On Fri, 15 Sep 2023 13:03:28 -0700, Kees Cook wrote:
> > Prepare for the coming implementation by GCC and Clang of the __counted=
_by
> > attribute. Flexible array members annotated with __counted_by can have
> > their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOU=
NDS
> > (for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-famil=
y
> > functions).
> >
> > As found with Coccinelle[1], add __counted_by for struct linear_conf.
> > Additionally, since the element count member must be set before accessi=
ng
> > the annotated flexible array member, move its initialization earlier.
> >
> > [...]
>
> Applied to for-next/hardening, thanks!
>
> [1/1] md/md-linear: Annotate struct linear_conf with __counted_by
>       https://git.kernel.org/kees/c/9add7681e09b

Hmm..

Jens pulled this into his for-next branch and for-6.7/block branch
earlier today:

https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/commi=
t/?h=3Dfor-next&id=3De887544d7620f1d3cef017e45df7bc625182caff

Do we need to do anything about this (drop one of them)?

Thanks,
Song
