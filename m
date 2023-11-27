Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B61F7FA04A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 14:06:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233563AbjK0NF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 08:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233553AbjK0NFz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 08:05:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E1F41AD
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:06:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8672C433CA
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 13:06:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701090361;
        bh=O5+TPRgRQKTwUWXmDRX+fO0seuontejPhxWQGhiUTN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=oaqt6tOUNZniBd3gRUAJsZZLGVmeah8c5L2GcnmrHModBvkApDTHGT+OeNntuMrTp
         hMubDZe9C6KE/xC3Ak00tNagxEEuz/QBH08ryjfGXr2ZRkYZuHSyP6G79oMxTRM0w4
         Nl6GWc+oJJeKoNMPiLUCizSViWuedo4AhV+I4xAvCIzf4dt0Xxkc4NJW4J6gMdL2EW
         7GQ1iHTUdbaKfJsDFTfQf7rrMH4z3Pk+NNov4ZRqGBOQ8E+hJ4EAM819OBDGyt03dc
         I8vf/Np4YQHW7M8e2nYGlkdnBdfaYagQUu/1bIFPAn3aQ0VXqUezHFCghQKBFmFP5u
         +NlT0L9JlYNjg==
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-54b18dbf148so2702746a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 05:06:01 -0800 (PST)
X-Gm-Message-State: AOJu0Yx2Aeja1gindIXF1IQEAwD4GOHtzerbt3ts72Wxp8uvfXaf8z8+
        PQwXTerkU9sMBiThLw7izMxv/SyUypaeFCmprBs=
X-Google-Smtp-Source: AGHT+IFjd9c/KBqZSzh3W3oTL1yQwUzu8hoIXk5DEmY4uHqnaxulHz500Aew7d7jGL/3Ct6elxCGx58FyiK+g8K81Zo=
X-Received: by 2002:a17:906:1091:b0:a0d:38b0:7286 with SMTP id
 u17-20020a170906109100b00a0d38b07286mr3370864eju.69.1701090360093; Mon, 27
 Nov 2023 05:06:00 -0800 (PST)
MIME-Version: 1.0
References: <20231126013921.103133-1-guoren@kernel.org> <ZWSD6v1d9wwOxOYd@FVFF77S0Q05N>
In-Reply-To: <ZWSD6v1d9wwOxOYd@FVFF77S0Q05N>
From:   Guo Ren <guoren@kernel.org>
Date:   Mon, 27 Nov 2023 21:05:48 +0800
X-Gmail-Original-Message-ID: <CAJF2gTQQWA3zuz39qbWZR3=Ej7hHwXVi1T-JM2X6-tbqJVD+ag@mail.gmail.com>
Message-ID: <CAJF2gTQQWA3zuz39qbWZR3=Ej7hHwXVi1T-JM2X6-tbqJVD+ag@mail.gmail.com>
Subject: Re: [PATCH V3] locking/atomic: scripts: Exclude arch_atomic(64)_read(set)
 mappings
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     peterz@infradead.org, keescook@chromium.org, paulmck@kernel.org,
        ubizjak@gmail.com, tglx@linutronix.de,
        linux-kernel@vger.kernel.org, Guo Ren <guoren@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 7:56=E2=80=AFPM Mark Rutland <mark.rutland@arm.com>=
 wrote:
>
> On Sat, Nov 25, 2023 at 08:39:21PM -0500, guoren@kernel.org wrote:
> > From: Guo Ren <guoren@linux.alibaba.com>
> >
> > The definitions of atomic(64)_read(set) are relax version, and using
> > them for acquire and release is incorrect, so exclude these mappings.
>
> This was fixed by commit:
>
>   6d2779ecaeb56f92 ("locking/atomic: scripts: fix fallback ifdeffery")
>
> That commit was in v6.6-rc3, and has been backported to stable kernels.
>
> I think you're using an old kernel as a base.
okay, thx for mentioning it.

>
> Thanks,
> Mark.
>
> >
> > Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
> > Signed-off-by: Guo Ren <guoren@kernel.org>
> > ---
> > Changelog:
> > v3:
> >  - Minimize modification on atomic(64)_read(set)
> >
> > v2:
> >  - Use gen-atomic-fallback.sh instead of header modification
> > ---
> >  include/linux/atomic/atomic-arch-fallback.h | 10 +---------
> >  scripts/atomic/gen-atomic-fallback.sh       |  3 ++-
> >  2 files changed, 3 insertions(+), 10 deletions(-)
> >
> > diff --git a/include/linux/atomic/atomic-arch-fallback.h b/include/linu=
x/atomic/atomic-arch-fallback.h
> > index 18f5744dfb5d..b83ef19da13d 100644
> > --- a/include/linux/atomic/atomic-arch-fallback.h
> > +++ b/include/linux/atomic/atomic-arch-fallback.h
> > @@ -459,8 +459,6 @@ raw_atomic_read_acquire(const atomic_t *v)
> >  {
> >  #if defined(arch_atomic_read_acquire)
> >       return arch_atomic_read_acquire(v);
> > -#elif defined(arch_atomic_read)
> > -     return arch_atomic_read(v);
> >  #else
> >       int ret;
> >
> > @@ -508,8 +506,6 @@ raw_atomic_set_release(atomic_t *v, int i)
> >  {
> >  #if defined(arch_atomic_set_release)
> >       arch_atomic_set_release(v, i);
> > -#elif defined(arch_atomic_set)
> > -     arch_atomic_set(v, i);
> >  #else
> >       if (__native_word(atomic_t)) {
> >               smp_store_release(&(v)->counter, i);
> > @@ -2575,8 +2571,6 @@ raw_atomic64_read_acquire(const atomic64_t *v)
> >  {
> >  #if defined(arch_atomic64_read_acquire)
> >       return arch_atomic64_read_acquire(v);
> > -#elif defined(arch_atomic64_read)
> > -     return arch_atomic64_read(v);
> >  #else
> >       s64 ret;
> >
> > @@ -2624,8 +2618,6 @@ raw_atomic64_set_release(atomic64_t *v, s64 i)
> >  {
> >  #if defined(arch_atomic64_set_release)
> >       arch_atomic64_set_release(v, i);
> > -#elif defined(arch_atomic64_set)
> > -     arch_atomic64_set(v, i);
> >  #else
> >       if (__native_word(atomic64_t)) {
> >               smp_store_release(&(v)->counter, i);
> > @@ -4657,4 +4649,4 @@ raw_atomic64_dec_if_positive(atomic64_t *v)
> >  }
> >
> >  #endif /* _LINUX_ATOMIC_FALLBACK_H */
> > -// 202b45c7db600ce36198eb1f1fc2c2d5268ace2d
> > +// 2fdd6702823fa842f9cea57a002e6e4476ae780c
> > diff --git a/scripts/atomic/gen-atomic-fallback.sh b/scripts/atomic/gen=
-atomic-fallback.sh
> > index c0c8a85d7c81..282a1d3c41d4 100755
> > --- a/scripts/atomic/gen-atomic-fallback.sh
> > +++ b/scripts/atomic/gen-atomic-fallback.sh
> > @@ -102,7 +102,8 @@ gen_proto_order_variant()
> >       fi
> >
> >       # Allow ACQUIRE/RELEASE/RELAXED ops to be defined in terms of FUL=
L ops
> > -     if [ ! -z "${order}" ]; then
> > +     # Exclude arch_atomic(64)_read(set) mappings because these are no=
t FULL ops.
> > +     if [ ! -z "${order}" ] && [ "${name}" !=3D "read" ] && [ "${name}=
" !=3D "set" ]; then
> >               printf "#elif defined(arch_${basename})\n"
> >               printf "\t${retstmt}arch_${basename}(${args});\n"
> >       fi
> > --
> > 2.36.1
> >



--=20
Best Regards
 Guo Ren
