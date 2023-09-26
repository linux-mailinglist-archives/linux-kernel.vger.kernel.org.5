Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD647AEF5F
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjIZPJ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:09:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbjIZPJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:09:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C311B10E;
        Tue, 26 Sep 2023 08:09:50 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62A43C433C7;
        Tue, 26 Sep 2023 15:09:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695740990;
        bh=hHCGzDD3Zxc5FD7vhGw1qLP3AHNwyYdkUXyjL0lcbmY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Kp7qlTr7JOp9Hny+DIlGiVOJreuGhYt5mSi0bO39fLsQ+grO5SQJ0PTnUICV7LN8G
         ka00On3NCyZM3wRvgNwat13Nu4RI1sakIj7JsIhKoPzzj8nyVd5+iykw+cUwKA0g6N
         R+Xh/PbsMsxeFlkw91xwbVlSookYGwDqXxSg3M4OvBm6LfHALt6Et5Yh0BAdRXudc+
         uWuF2Cp7HWaus+TTXIsZ8HtFvy9CRD6KqSf85l+juIRY+B5EkW45iWhTGoyFk1H8Oj
         HRFrctlpWcUL6QRpv8gdR6dEtRYCFe+lxiPK5uTEkLy3zFiLLxlKmze30F/tk8YbvG
         E6AqVAz/Xeh1A==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-503f39d3236so14645941e87.0;
        Tue, 26 Sep 2023 08:09:50 -0700 (PDT)
X-Gm-Message-State: AOJu0YyoKd+uTigjazdRzz82D0IA/FfVn72ahv9oQ9hyM2kPbn6Bh9KQ
        RqhFQPcgN1O8okPTfEYrYmqMxzU5tiQcXuEzNuY=
X-Google-Smtp-Source: AGHT+IFyp6pt6+QOOIU4VfxbHnVoDos3AySveluVyRvsnCUeeCxBSKU/yuxCUcvcq2gQ+GhBz9ED0hdbPlC4ppjnqAA=
X-Received: by 2002:a05:6512:2815:b0:503:343a:829f with SMTP id
 cf21-20020a056512281500b00503343a829fmr11191314lfb.23.1695740988547; Tue, 26
 Sep 2023 08:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230925110023.1796789-1-masahiroy@kernel.org>
 <CAMj1kXHM_dRNVeMuwiPyniz4qUh8JT6mmX2R2VdhBMLCjFA8WQ@mail.gmail.com> <CAK7LNAR5bjfRShbbPsoAriGR5=fG85yzBWfvBFaaK_=kd5U_LA@mail.gmail.com>
In-Reply-To: <CAK7LNAR5bjfRShbbPsoAriGR5=fG85yzBWfvBFaaK_=kd5U_LA@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 26 Sep 2023 15:09:37 +0000
X-Gmail-Original-Message-ID: <CAMj1kXHD+yrM-qsRGBdC++NUfX7d39=TX=DUkgP3mM8ucNJaRQ@mail.gmail.com>
Message-ID: <CAMj1kXHD+yrM-qsRGBdC++NUfX7d39=TX=DUkgP3mM8ucNJaRQ@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix get_user() broken with veneer
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Russell King <linux@armlinux.org.uk>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>
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

On Tue, 26 Sept 2023 at 14:27, Masahiro Yamada <masahiroy@kernel.org> wrote=
:
>
> On Tue, Sep 26, 2023 at 8:37=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> =
wrote:
> >
> > Hello Masahiro,
> >
> > Thanks for getting to the bottom of this.
> >
> > The patch looks correct to me, but could we please drop this huge
> > commit log text? The AAPCS simply states that a BL instruction might
> > clobber IP, so any inline asm that contains a BL should have IP in its
> > clobber list. In our case, the use of PIC veneers is what might cause
> > this, so we should mention that as well. But your entire journey to
> > get to that conclusion is not something that deserves to be included
> > in the git commit log forever, imho.
> >
> > So with the commit log trimmed:
> >
> > Reviewed-by: Ard Biesheuvel <ardb@kernel.org>
>
>
>
> Is this commit log OK?
>

Yes, thanks for rewriting it.

I don't think a resend is necessary - please drop this in Russell's
patch tracker.

Thanks,


>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>8=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> The 32-bit ARM kernel stops working if the kernel grows to the point
> where veneers for __get_user_* are created.
>
> AAPCS32 [1] states, "Register r12 (IP) may be used by a linker as a
> scratch register between a routine and any subroutine it calls. It
> can also be used within a routine to hold intermediate values between
> subroutine calls."
>
> However, the bl instruction buried within the inline asm is unpredictable
> for compilers; hence, "ip" must be added to the clobber list.
>
> This becomes critical when veneers for __get_user_* are created because
> veneers use the ip register since commit 02e541db0540 ("ARM: 8323/1:
> force linker to use PIC veneers").
>
> [1]: https://github.com/ARM-software/abi-aa/blob/2023Q1/aapcs32/aapcs32.r=
st
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>8=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
>
>
>
>
> --
> Best Regards
> Masahiro Yamada
