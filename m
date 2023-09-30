Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DFD37B3FD8
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 12:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234064AbjI3KNI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 06:13:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233030AbjI3KNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 06:13:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 018D01AB;
        Sat, 30 Sep 2023 03:13:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71788C433CB;
        Sat, 30 Sep 2023 10:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696068784;
        bh=IsZF4TWVX1SRhu6LHbwwMx3eoaC8wL2iO+qcbuu8h14=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Cd+L2zUWW7V/mdCcs2VMBNZHa7RK3DjvAvwtm41+4KOnMf4x5CJChMb7eM6m6+Hom
         3b9ByZRjj2XdYz2dV2dVBLB8LL67X8Ska+OA8HRX/JaEu8qKrc0myRwLcRkx7KwW0B
         wAvs4xLqQA3eiSgYtsWQFwQ25jkgHonlM5yjkiDaX3nco/i99J35ZHTx5zOmVh6YLi
         XtuEsDbV+OUOEjJEIRHQLtjI5fSFMVdk4jWQFY/ekk5ghibf5FAJjmtGTgukKiHql4
         /IUxTeO2tA7kBpK2u9vCgn1/K8U4X4djq5FobAqVlYF1EPOSqfle/fN91LJq2f9eUf
         TUm5xTlZdlA+w==
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6beff322a97so8654959a34.3;
        Sat, 30 Sep 2023 03:13:04 -0700 (PDT)
X-Gm-Message-State: AOJu0YwjDF//JpN4BSLba0Yx+lWleaqcWsFQzHI+tB8TqKK8HHjJCw63
        NayV9vTvwSuRTj15sbvUk7yONKGJVbTs48axMpk=
X-Google-Smtp-Source: AGHT+IGNnRiz5tgKzD/S5dLvgJu/YGl0PbaMvzwkiazycsrf5XTjJQzKSLhAChdEHi9J6gj+m5WXPo8+Y7pOMC1QqNg=
X-Received: by 2002:a05:6870:96ab:b0:1db:3679:198a with SMTP id
 o43-20020a05687096ab00b001db3679198amr7517135oaq.24.1696068783796; Sat, 30
 Sep 2023 03:13:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230928041600.15982-1-quic_jiangenj@quicinc.com> <CAG_fn=V9FXGpqceojn0UGiPi7gFbDbRnObc-N5a55Qk=XQy=kg@mail.gmail.com>
In-Reply-To: <CAG_fn=V9FXGpqceojn0UGiPi7gFbDbRnObc-N5a55Qk=XQy=kg@mail.gmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 30 Sep 2023 19:12:26 +0900
X-Gmail-Original-Message-ID: <CAK7LNASfdQYy7ON011jQxqd4Bz98CJuvDNCUp2NRrHcK29x3zA@mail.gmail.com>
Message-ID: <CAK7LNASfdQYy7ON011jQxqd4Bz98CJuvDNCUp2NRrHcK29x3zA@mail.gmail.com>
Subject: Re: [PATCH] kasan: Add CONFIG_KASAN_WHITELIST_ONLY mode
To:     Alexander Potapenko <glider@google.com>
Cc:     Joey Jiao <quic_jiangenj@quicinc.com>, kasan-dev@googlegroups.com,
        quic_likaid@quicinc.com, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        linux-kernel@vger.kernel.org, linux-kbuild@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 29, 2023 at 11:06=E2=80=AFPM Alexander Potapenko <glider@google=
.com> wrote:
>
> (CC Masahiro Yamada)
>
> On Thu, Sep 28, 2023 at 6:16=E2=80=AFAM Joey Jiao <quic_jiangenj@quicinc.=
com> wrote:
> >
> > Fow low memory device, full enabled kasan just not work.
> > Set KASAN_SANITIZE to n when CONFIG_KASAN_WHITELIST_ONLY=3Dy.
> > So we can enable kasan for single file or module.
>
> I don't have technical objections here, but it bothers me a bit that
> we are adding support for KASAN_SANITIZE:=3Dy, although nobody will be
> adding KASAN_SANITIZE:=3Dy to upstream Makefiles - only development
> kernels when debugging on low-end devices.
>
> Masahiro, is this something worth having in upstream Kconfig code?


Even if we apply this patch to the upstream,
you will end up with adding 'KASAN_SANITIZE :=3Dy'
to the single file/Makefile.

I am not convinced with this patch
since this nod is not so useful standalone.



> > Signed-off-by: Joey Jiao <quic_jiangenj@quicinc.com>
> Reviewed-by: Alexander Potapenko <glider@google.com>



--
Best Regards
Masahiro Yamada
