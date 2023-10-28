Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 822967DA6CA
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 13:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbjJ1L5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 07:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJ1L5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 07:57:01 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A935FEB;
        Sat, 28 Oct 2023 04:56:59 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 442D5C433C9;
        Sat, 28 Oct 2023 11:56:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698494219;
        bh=F3UZH5ynEYTHdu9MGAXiLPZY7Z8iM1kzFnZyCVEVYN8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=U3Zctb796iHDs9Q4qUhJ94hrVlKygnDfQWMq2ylTkkH1pg26kOdfWgt8JyJMTb/nB
         XlyrxtBSTjF8emrxktbb5E+MkA80AzhCQtpSQ0HX26FVS/pP5OwuQv66IDJfFFMfuY
         0VZdOp/iMDI+2BbL75tf8I0nXoQumxlDN3XrhdrbMKpOwQJDkNagtE4ZV8CJXd3sle
         sWyrdzQQ1mIyDb8N5kVKItKGC8q8kWYlfUPmZu+HrmJGYph8iwEzBWlt3VrPcz2qmb
         62Ut3ug6LEB/BcVhdXU8a03gyY22m4P8x9c6QPOiSVyFW1iAt2oK2qGRZPJayL5Tiv
         g4N36J+TqABJw==
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-6c4a25f6390so1957904a34.2;
        Sat, 28 Oct 2023 04:56:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YyBLIVtkO1yYXQtGeC/jjFCSCKc3KZJsIEWZyz6CrWTLXr+QiwO
        DhxuWBBR688em7RtS1hy16WcbziSjtesRBn4s3g=
X-Google-Smtp-Source: AGHT+IEyvyq1GRt6qcOSR9deQPtEthF2apO+P6WkoLcPXNdo+CKPDxPqH5R2N1OzYnbkbBuouyS6v2REs9ii6/WPZQE=
X-Received: by 2002:a05:6870:5cc6:b0:1e9:a248:b1b6 with SMTP id
 et6-20020a0568705cc600b001e9a248b1b6mr5976887oab.35.1698494218615; Sat, 28
 Oct 2023 04:56:58 -0700 (PDT)
MIME-Version: 1.0
References: <20231022170613.2072838-1-masahiroy@kernel.org>
 <20231022170613.2072838-4-masahiroy@kernel.org> <20231023232814.GA3514685@dev-arch.thelio-3990X>
In-Reply-To: <20231023232814.GA3514685@dev-arch.thelio-3990X>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Sat, 28 Oct 2023 20:56:22 +0900
X-Gmail-Original-Message-ID: <CAK7LNAREsQ4EUsz33zx8DCixO36QoWgFfZ4SOAeU7LtLbfdj_Q@mail.gmail.com>
Message-ID: <CAK7LNAREsQ4EUsz33zx8DCixO36QoWgFfZ4SOAeU7LtLbfdj_Q@mail.gmail.com>
Subject: Re: [PATCH 04/10] modpost: remove more symbol patterns from the
 section check whitelist
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>
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

On Tue, Oct 24, 2023 at 8:28=E2=80=AFAM Nathan Chancellor <nathan@kernel.or=
g> wrote:
>
> On Mon, Oct 23, 2023 at 02:06:07AM +0900, Masahiro Yamada wrote:
> > These symbol patterns were whitelisted to allow them to reference to
> > functions with the old __devinit and __devexit annotations.
> >
> > We stopped doing this a long time ago, for example, commit 6f039790510f
> > ("Drivers: scsi: remove __dev* attributes.") remove those annotations
> > from the scsi drivers.
> >
> > Keep *_ops and *_console, otherwise they will really cause section
> > mismatch warnings.
> >
> > Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> > ---
> >
> >  scripts/mod/modpost.c | 8 +-------
> >  1 file changed, 1 insertion(+), 7 deletions(-)
> >
> > diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
> > index 792ba9da0f27..19b138664f75 100644
> > --- a/scripts/mod/modpost.c
> > +++ b/scripts/mod/modpost.c
> > @@ -997,13 +997,7 @@ static int secref_whitelist(const char *fromsec, c=
onst char *fromsym,
> >       /* symbols in data sections that may refer to any init/exit secti=
ons */
> >       if (match(fromsec, PATTERNS(DATA_SECTIONS)) &&
> >           match(tosec, PATTERNS(ALL_INIT_SECTIONS, ALL_EXIT_SECTIONS)) =
&&
> > -         match(fromsym, PATTERNS("*_template", // scsi uses *_template=
 a lot
> > -                                 "*_timer", // arm uses ops structures=
 named _timer a lot
> > -                                 "*_sht", // scsi also used *_sht to s=
ome extent
> > -                                 "*_ops",
> > -                                 "*_probe",
>
> It seems like this one might still be needed. I see this when building
> certain arm64 configurations with clang.
>
>   WARNING: modpost: vmlinux: section mismatch in reference: qcom_irq_comb=
iner_probe+0x0 (section: .data) -> combiner_probe (section: .init.text)



Thanks for comprehensive compile-testing.


I will keep "*_probe", but I believe __ref is better
if this is only the instance that happens to
have _ops suffix.









> > -                                 "*_probe_one",
> > -                                 "*_console")))
> > +         match(fromsym, PATTERNS("*_ops", "*_console")))
> >               return 0;
> >
> >       /*
> > --
> > 2.40.1
> >



--=20
Best Regards
Masahiro Yamada
