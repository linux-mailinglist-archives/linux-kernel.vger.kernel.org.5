Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343A57C0082
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 17:39:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233479AbjJJPjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 11:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233484AbjJJPjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 11:39:13 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70158AC
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:39:11 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-405497850dbso53889555e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 08:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1696952350; x=1697557150; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q85Z+29P0POqGNSysfbjieXJTAmPSCNOKhS6TwE+BLQ=;
        b=J7EzO7R/zAL/s8+fDz9SkEjHwONd2UIf285diDBSlzfEg+xbx1AdNYRNheiPRp5+a6
         7kc27KO8aRTmtQlnVcuNzlLOihXjXrmRQR5YDytE9BTrDVTUUPlvMOu+vU5p7pVTCbTt
         pKOcjGSBjIRaLicrZVYJa1muT0pUCSRtsJvlD9nI6WNd91e607Mn5xiBmRFL1neXFOxQ
         vvgOmKIF25dFn/4UzAtyuy/7VHNKyWpqzDTpBmB7dZ18gGmZyhUXYWth+Mn7JvFE+cuF
         bjX0TLC8o6e9NZjV1aW+bsQc34BFn+1uj8zAie8OQ2gFl/xotW32Df6/IvmtWYDnMZRa
         +Spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696952350; x=1697557150;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q85Z+29P0POqGNSysfbjieXJTAmPSCNOKhS6TwE+BLQ=;
        b=IEY1P3l5toZ3oRnolAK+1xAcugheV+i5qqhUjJ2ZlNRQzuUK6R4IFIfmEdjeYdFyIU
         I+QmCrj11KEJbjclnk15oRCxUtRZhR5XZ3r06Rtokb7gKzPivBllh39XLcQ9FdSQrXGJ
         wJJAXSHKz8iNQueqUhQJiRZPSbi3l1se70ZqjEeM6bGEhWAFu06TK+YRs1VxW0Py3aZ0
         8Q84yXsSjpZbVrYl5BCWsqqT6VyoGFWCmW+VJ8xDlqyjZjioV33qEfvT/GdfsRIMKsfb
         peq7tNbYYT3NZRvgFryBv6cdS1DaAUGwVRIHr1NdKBY49xrjQREoLY3H2K/xGhI2pqvm
         suDQ==
X-Gm-Message-State: AOJu0YyVY7r1otB0BGYj1WpWxNU7sZqhC+23QIPJqoKhuzmPJDdOwoDx
        sogKWVaXB7PkBn/ltxGB7tIrDBxK85yGRPCA3KLOMw==
X-Google-Smtp-Source: AGHT+IGag0UvyVnSwYEnOyoH2ugnO1sNkoJ7csMjCJZTs0oRO+juByboNpvXU9ptXwj/6VOXxlAPomx+fqu8Lc2ACQ0=
X-Received: by 2002:a7b:ce89:0:b0:402:f07c:4b48 with SMTP id
 q9-20020a7bce89000000b00402f07c4b48mr15737826wmj.28.1696952349723; Tue, 10
 Oct 2023 08:39:09 -0700 (PDT)
MIME-Version: 1.0
References: <20231009224347.2076221-1-mmaurer@google.com> <20231010081220.GD377@noisy.programming.kicks-ass.net>
In-Reply-To: <20231010081220.GD377@noisy.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 10 Oct 2023 08:38:58 -0700
Message-ID: <CAKwvOdk1c3N05R9fya6HsZwPZzrkDhC3LrK=nRVOoUwyXsiXQg@mail.gmail.com>
Subject: Re: [PATCH] x86: Enable IBT in Rust if enabled in C
To:     Peter Zijlstra <peterz@infradead.org>,
        Matthew Maurer <mmaurer@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        Alice Ryhl <aliceryhl@google.com>,
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 1:13=E2=80=AFAM Peter Zijlstra <peterz@infradead.or=
g> wrote:
>
> On Mon, Oct 09, 2023 at 10:42:54PM +0000, Matthew Maurer wrote:
> > These flags are not made conditional on compiler support because at the
> > moment exactly one version of rustc supported, and that one supports
> > these flags.
> >
> > Building without these additional flags will manifest as objtool
> > printing a large number of errors about missing ENDBR and if CFI is
> > enabled (not currently possible) will result in incorrectly structured
> > function prefixes.
>
> Well, I would also imagine running it on actual IBT enabled hardware
> will get you a non-booting kernel.

Do you know what machine type in QEMU first supports IBT?

>
> > Signed-off-by: Matthew Maurer <mmaurer@google.com>

Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>

> > https://godbolt.org/z/bc4n6sq5q

Intel asm syntax...my eyes!!!

> > ---
> >
> > Split out the IBT additions as per
> > https://lkml.kernel.org/linux-fsdevel/CANiq72kK6ppBE7j=3Dz7uua1cJMKaLoR=
5U3NUAZXT5MrNEs9ZhfQ@mail.gmail.com/
> >
> > arch/x86/Makefile | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/arch/x86/Makefile b/arch/x86/Makefile
> > index 5bfe5caaa444..941f7abf6dbf 100644
> > --- a/arch/x86/Makefile
> > +++ b/arch/x86/Makefile
> > @@ -81,6 +81,7 @@ ifeq ($(CONFIG_X86_KERNEL_IBT),y)
> >  #   https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D104816
> >  #
> >  KBUILD_CFLAGS +=3D $(call cc-option,-fcf-protection=3Dbranch -fno-jump=
-tables)
> > +KBUILD_RUSTFLAGS +=3D -Zcf-protection=3Dbranch -Zno-jump-tables
>
> One question, -Zcf-protection=3Dbranch, will that ever emit NOTRACK
> prefix? The kernel very explicitly does not support (enable) NOTRACK.
>
> >  else
> >  KBUILD_CFLAGS +=3D $(call cc-option,-fcf-protection=3Dnone)
> >  endif
> > --
> > 2.42.0.609.gbb76f46606-goog
> >
>


--=20
Thanks,
~Nick Desaulniers
