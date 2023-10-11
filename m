Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5293F7C5A72
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 19:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232870AbjJKRol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 13:44:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232896AbjJKRoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 13:44:38 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF32DA4;
        Wed, 11 Oct 2023 10:44:35 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-d9a50ac5eabso82345276.1;
        Wed, 11 Oct 2023 10:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697046275; x=1697651075; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iyy+ysmQl4Bp1AUl2QIMnm0hQgXYP2CG0aAsMLq8u9A=;
        b=HPOU8PbEM/jdbLNVMg6GILqV3cuWHkwSoAy8oHcKmTeAhiB8zTTISkgdLlJ53mPMJJ
         qXIN9nvxI9YBuwvLREBTV1+W5XJgEUcfY2UvazkCf+9zM6UNZm6zBxQdVFJ9R+/4Jdej
         z+BddXkV+90HP3hjtPHZvefwGLpyYfjRI6WukjvvApL6u6N/Ua8lGGV6aHjftjbQbf5u
         RS8S/5SW3dFr/S9Y0RZipUlmTctngsy+RgerVnZn5ZxCC7j7Rsr7J8SvqTlkseTofQsa
         f1L9jAG9z75KzcB/PfRauHe/wD+Q0T+C9xiZAzHtZ99QdnE0PcaaI1cSlcVLBqTjJxeb
         wEQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697046275; x=1697651075;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iyy+ysmQl4Bp1AUl2QIMnm0hQgXYP2CG0aAsMLq8u9A=;
        b=lFSC1g9I3asg6HuSJ/u9V3uLEvV+usisnomHd46K1h8jI2RyvRZhnCBvoUAyokNGtf
         RR7Wm/Mj8Gn/O0/pDwHCQ/CVS128p2vtlr2xaA46ClB1uZ3tDmsPHPRTiCbH+QLRhyeU
         dpZ4llAi7mIto782hLUfIOcepZNKURy5PiQT9S2aqdeS0bwS49JZxV4sP2Dr5OSp8DgQ
         wH2d433t259b/OCFuc87oQ9UTXEbHOC/D6/du6FSr9S7yzsjGX5LL0rt0NW6ZTWWQ5Ym
         vg8oV4lKdPmOUTf3AuOeg8DvjxCUmq5TAXaD6chUT1U8mtEKxt2Joy0hp30GnPtRaelK
         TRoA==
X-Gm-Message-State: AOJu0Yxq/CfQHw3Ts+GxWsGmfRjA8jGvWyTGyGVndqY/vcapDC3sScxL
        jKpT04NFQfyV6i29KevLNkQipi5ipzKNMyPymuc=
X-Google-Smtp-Source: AGHT+IEqzvlLevFjLbBV7j7WTIsB6wSm7NN0VAlnFhMEHL1DP2s//b6gojMeg98oG+nm4gSiDDerRbAbnT46xkodUnU=
X-Received: by 2002:a05:6902:152:b0:d9a:38b0:a0c8 with SMTP id
 p18-20020a056902015200b00d9a38b0a0c8mr7068973ybh.61.1697046275143; Wed, 11
 Oct 2023 10:44:35 -0700 (PDT)
MIME-Version: 1.0
References: <20231009224347.2076221-1-mmaurer@google.com>
In-Reply-To: <20231009224347.2076221-1-mmaurer@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 11 Oct 2023 19:44:23 +0200
Message-ID: <CANiq72=wAOryvUW3whsGRvribm2eYT+Z-KsJKCkZ0g8b3P+jQg@mail.gmail.com>
Subject: Re: [PATCH] x86: Enable IBT in Rust if enabled in C
To:     Matthew Maurer <mmaurer@google.com>
Cc:     peterz@infradead.org, Thomas Gleixner <tglx@linutronix.de>,
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
        linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 10, 2023 at 12:43=E2=80=AFAM Matthew Maurer <mmaurer@google.com=
> wrote:
>
> These flags are not made conditional on compiler support because at the
> moment exactly one version of rustc supported, and that one supports
> these flags.
>
> Building without these additional flags will manifest as objtool
> printing a large number of errors about missing ENDBR and if CFI is
> enabled (not currently possible) will result in incorrectly structured
> function prefixes.
>
> Signed-off-by: Matthew Maurer <mmaurer@google.com>
> ---
>
> Split out the IBT additions as per
> https://lkml.kernel.org/linux-fsdevel/CANiq72kK6ppBE7j=3Dz7uua1cJMKaLoR5U=
3NUAZXT5MrNEs9ZhfQ@mail.gmail.com/

Thanks a lot Matthew for this! It is great to see those warnings
finally go away.

I have added the `objtool` pass to the intermediate Rust object files
and, with that + this patch applied + IBT enabled (but not
rethunk/retpoline), the only thing I see is:

    samples/rust/rust_print.o: warning: objtool: init_module(): not an
indirect call target
    samples/rust/rust_print.o: warning: objtool: cleanup_module(): not
an indirect call target

But we can fix those independently of this (ideally we want to reuse
the C macros, rather than putting more complexity in `module!`), so:

Acked-by: Miguel Ojeda <ojeda@kernel.org>

I will send the patch for adding `objtool`.

Cheers,
Miguel
