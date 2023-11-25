Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5F9D7F8790
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 02:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231447AbjKYBfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 20:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjKYBfa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 20:35:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04AEB170B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:35:37 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FCDFC433CA
        for <linux-kernel@vger.kernel.org>; Sat, 25 Nov 2023 01:35:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700876136;
        bh=/Kmxrpm10HUQQe+SizMiik5D37A0rYSx5zyUEJetOOw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=FXDrha5rCETk8VZxnAaIj8njcSOxrpT/eF+qwhfATU5qJTKZ7UmIJ/EAjxzYW0RaR
         RPf/dwjkIL7310UvGnI2iAM7S7+TSpmFxRuGSQoRP1THksAUhQgTt+hPnqCVzEMpwA
         iEIVe5OQouzgjLZFsxHxatwqU9EgZkX/O1Ek6AjuyFNGbt4ucxn8EeocecHPfY42Yi
         CuhYtJkJVF2s2wByVLMGXGYAvCD186pboFbe+KzERvkdqS9IEx9kAGACplzRmz3ftk
         i+2KOMJK26xT00ZjtBfTcz7CDW3S5s5slTYB8kp+KWhlV2fVQ48xxdvZPSacjTZCRd
         dUVwm6FwX3NdA==
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-9fd0059a967so677149666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 17:35:36 -0800 (PST)
X-Gm-Message-State: AOJu0YxyMznloQPVONP21NjaZwCJAS7HvXPb4LJF8GKEBseCbpcVNSNv
        m2YVrq5nk1xNdJllGN45Ih5OU7/3GhZoKW3hk+Q=
X-Google-Smtp-Source: AGHT+IFx0FH5QL99qgVQ8vc6pTpjPjNn2vHOEQHWN2CSMnpL78GELlKEFNStsHXAKktxrQIapFp7sHSR+A9arn2QmsM=
X-Received: by 2002:a17:906:b758:b0:a00:1263:8c4c with SMTP id
 fx24-20020a170906b75800b00a0012638c4cmr7007909ejb.18.1700876134764; Fri, 24
 Nov 2023 17:35:34 -0800 (PST)
MIME-Version: 1.0
References: <20231124162508.3331357-1-guoren@kernel.org> <20231124163220.GU3818@noisy.programming.kicks-ass.net>
In-Reply-To: <20231124163220.GU3818@noisy.programming.kicks-ass.net>
From:   Guo Ren <guoren@kernel.org>
Date:   Sat, 25 Nov 2023 09:35:21 +0800
X-Gmail-Original-Message-ID: <CAJF2gTSTB7tXooj-7aVQK70rW0a6hKhK3Ljtcnfxjg5eobo8Pw@mail.gmail.com>
Message-ID: <CAJF2gTSTB7tXooj-7aVQK70rW0a6hKhK3Ljtcnfxjg5eobo8Pw@mail.gmail.com>
Subject: Re: [PATCH] locking/atomic: Add acquire and release fence for atomic(64)_read(set)
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mark.rutland@arm.com, keescook@chromium.org, paulmck@kernel.org,
        ubizjak@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 12:32=E2=80=AFAM Peter Zijlstra <peterz@infradead.o=
rg> wrote:
>
> On Fri, Nov 24, 2023 at 11:25:08AM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The definitions of atomic(64)_read(set) are relax version, so
> > add acquire and release fence for them.
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
>
> You lost the script change?
Sorry, it's my fault. I shouldn't have modify header file directly.
Here is the v2:
https://lore.kernel.org/all/20231125013025.3620560-1-guoren@kernel.org/

>
> >  include/linux/atomic/atomic-arch-fallback.h | 14 +++++++++++---
> >  1 file changed, 11 insertions(+), 3 deletions(-)
> >
> > diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linu=
x/atomic/atomic-arch-fallback.h
> > index 18f5744dfb5d..9775900eeefd 100644
> > --- a/include/linux/atomic/atomic-arch-fallback.h
> > +++ b/include/linux/atomic/atomic-arch-fallback.h
> > @@ -460,7 +460,10 @@ raw_atomic_read_acquire(const atomic_t *v)
> >  #if defined(arch_atomic_read_acquire)
> >       return arch_atomic_read_acquire(v);
> >  #elif defined(arch_atomic_read)
> > -     return arch_atomic_read(v);
> > +     int ret;
> > +     ret =3D arch_atomic_read(v);
> > +     __atomic_acquire_fence();
> > +     return ret;
> >  #else
> >       int ret;
> >
> > @@ -509,6 +512,7 @@ raw_atomic_set_release(atomic_t *v, int i)
> >  #if defined(arch_atomic_set_release)
> >       arch_atomic_set_release(v, i);
> >  #elif defined(arch_atomic_set)
> > +     __atomic_release_fence();
> >       arch_atomic_set(v, i);
> >  #else
> >       if (__native_word(atomic_t)) {
> > @@ -2576,7 +2580,10 @@ raw_atomic64_read_acquire(const atomic64_t *v)
> >  #if defined(arch_atomic64_read_acquire)
> >       return arch_atomic64_read_acquire(v);
> >  #elif defined(arch_atomic64_read)
> > -     return arch_atomic64_read(v);
> > +     s64 ret;
> > +     ret =3D arch_atomic64_read(v);
> > +     __atomic_acquire_fence();
> > +     return ret;
> >  #else
> >       s64 ret;
> >
> > @@ -2625,6 +2632,7 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
> >  #if defined(arch_atomic64_set_release)
> >       arch_atomic64_set_release(v, i);
> >  #elif defined(arch_atomic64_set)
> > +     __atomic_release_fence();
> >       arch_atomic64_set(v, i);
> >  #else
> >       if (__native_word(atomic64_t)) {
> > @@ -4657,4 +4665,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
> >  }
> >
> >  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> > -// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
> > +// 3135f55051cf62b76664e528bf04337c44a14e72
> > --
> > 2.36.1
> >



--=20
Best Regards
 Guo Ren
