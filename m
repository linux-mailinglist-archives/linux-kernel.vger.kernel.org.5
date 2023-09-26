Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841D37AEEF7
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 16:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjIZO1f (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 10:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjIZO1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 10:27:32 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5613101;
        Tue, 26 Sep 2023 07:27:25 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4EE5BC433C7;
        Tue, 26 Sep 2023 14:27:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695738445;
        bh=20uIU8RxlSWPD/xEPFFfvDrNIPmVI0rBNaThFpifypA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=q34PFOdLKHXMML68+1D7SSnXjJ77WVTdMrxfRBDE389Q7MJwMN4L9x7VXL4hMgAXN
         cQnAjVOQJiDtMFyvqNXuc7HTey+mI4XougBv/8AmHlqngWihlCW7hgy1F57wgabghb
         B4CU8voNkkUm09CHYiFeBp3Dr2iSj16vWLd9BeaMdEPVmLvb2EI3ympZbd2pCKZesc
         YfxbOPiyduXKuISsSK/R8tZU454Cf96Hc2nABOkhWvotqZb3gvUvS1Edmt7UAieaFD
         Ig9voDaA3ti0cBc1ih30BNqt6Ide5C5X2T4qstpGnjhSAQ4xohgk6Tkc+gGXLhWKy7
         eXKyQdALGy9Cw==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1dceb2b8823so2712270fac.1;
        Tue, 26 Sep 2023 07:27:25 -0700 (PDT)
X-Gm-Message-State: AOJu0Yz7GVTekff9lRNNznfMdFDDjR3uzN+jnthU6J7koJmFnXfT5PLV
        pg7ajbZq9M2Wp2DyfHYxyFt/8hbKvBEczqUpOnU=
X-Google-Smtp-Source: AGHT+IFutpeLkBuGBlBnkzo0nGwLVFbQ2W/vz6rlqYUimJnxnDBb0b6ks3FP1RJ8ZgpF/JyjyNUkY4wud0ANKe13k+I=
X-Received: by 2002:a05:6870:6984:b0:1d5:8d6a:18f0 with SMTP id
 my4-20020a056870698400b001d58d6a18f0mr1592336oab.27.1695738444682; Tue, 26
 Sep 2023 07:27:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230925110023.1796789-1-masahiroy@kernel.org> <CAMj1kXHM_dRNVeMuwiPyniz4qUh8JT6mmX2R2VdhBMLCjFA8WQ@mail.gmail.com>
In-Reply-To: <CAMj1kXHM_dRNVeMuwiPyniz4qUh8JT6mmX2R2VdhBMLCjFA8WQ@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Tue, 26 Sep 2023 23:26:48 +0900
X-Gmail-Original-Message-ID: <CAK7LNAR5bjfRShbbPsoAriGR5=fG85yzBWfvBFaaK_=kd5U_LA@mail.gmail.com>
Message-ID: <CAK7LNAR5bjfRShbbPsoAriGR5=fG85yzBWfvBFaaK_=kd5U_LA@mail.gmail.com>
Subject: Re: [PATCH] ARM: fix get_user() broken with veneer
To:     Ard Biesheuvel <ardb@kernel.org>
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

On Tue, Sep 26, 2023 at 8:37=E2=80=AFPM Ard Biesheuvel <ardb@kernel.org> wr=
ote:
>
> Hello Masahiro,
>
> Thanks for getting to the bottom of this.
>
> The patch looks correct to me, but could we please drop this huge
> commit log text? The AAPCS simply states that a BL instruction might
> clobber IP, so any inline asm that contains a BL should have IP in its
> clobber list. In our case, the use of PIC veneers is what might cause
> this, so we should mention that as well. But your entire journey to
> get to that conclusion is not something that deserves to be included
> in the git commit log forever, imho.
>
> So with the commit log trimmed:
>
> Reviewed-by: Ard Biesheuvel <ardb@kernel.org>



Is this commit log OK?


=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>8=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
The 32-bit ARM kernel stops working if the kernel grows to the point
where veneers for __get_user_* are created.

AAPCS32 [1] states, "Register r12 (IP) may be used by a linker as a
scratch register between a routine and any subroutine it calls. It
can also be used within a routine to hold intermediate values between
subroutine calls."

However, the bl instruction buried within the inline asm is unpredictable
for compilers; hence, "ip" must be added to the clobber list.

This becomes critical when veneers for __get_user_* are created because
veneers use the ip register since commit 02e541db0540 ("ARM: 8323/1:
force linker to use PIC veneers").

[1]: https://github.com/ARM-software/abi-aa/blob/2023Q1/aapcs32/aapcs32.rst
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D>8=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D






--=20
Best Regards
Masahiro Yamada
