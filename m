Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B4A0786055
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 21:08:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236953AbjHWTHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 15:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbjHWTHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 15:07:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524FE79;
        Wed, 23 Aug 2023 12:07:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34A0061011;
        Wed, 23 Aug 2023 19:07:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70C6EC433C8;
        Wed, 23 Aug 2023 19:07:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692817639;
        bh=RVSvLWhqUQB6+MmdE+gYscr3M5RJ7QG7NfKZTgCn9p8=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=BbT2WBMI3oVMLqutgb1CBas2Qx3soqd66Luskm7ByeGP5/vt2lTWQ0JkGmYW9W+MC
         wVniEh+FnzAJX47IdhxhZjIXmoNDE6pV6/GJvmTxqWAXcnwPXOxC5Ok9UV0kquKSad
         VtBxNeh5LqM/gZfW3lglL0+e93kk4ZbnGPl3uiqWlrGPS5DHycdwy3JKjcBpeFSU9O
         2Gb1wEcl/wt/KETKap9GSp9me9jc0XH0MjwD1l1hHdyxT+YjBKV270+0slpUH3lxHR
         8VyElkMop6Y7Brefg3H4HTPGo2ZSevcIEgeqF2g+Z65AS8pdxMHPnBd3p9OZQRoIYG
         px82G4yElgy7A==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b9c907bc68so99222251fa.2;
        Wed, 23 Aug 2023 12:07:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YyCz9gx5oRzbFrg0TofHaKDd1RBYh/dCVNtNc/KU5VQl/iJOpby
        cMLTNN6G2aIidKCLdMCYuPM2T0ri3xrXPl7NgA==
X-Google-Smtp-Source: AGHT+IFxdup1Kiqi+uIYfNj073uf1yswleXwMzYc0X8IUuQU//tQNBsizGTxXShOkFhTmyDUw3oBBN8mQpGvjtOHeYU=
X-Received: by 2002:a2e:81d0:0:b0:2bc:d33e:ccc5 with SMTP id
 s16-20020a2e81d0000000b002bcd33eccc5mr4501945ljg.41.1692817637284; Wed, 23
 Aug 2023 12:07:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230609183111.1765507-1-robh@kernel.org> <20230703030148.qqszljkgnyzt52da@vireshk-i7>
In-Reply-To: <20230703030148.qqszljkgnyzt52da@vireshk-i7>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 23 Aug 2023 14:07:04 -0500
X-Gmail-Original-Message-ID: <CAL_JsqLQCSHfQtYicBVYfjtcE2nJLZ=g_7ASj5LfBhOb2Y2ouw@mail.gmail.com>
Message-ID: <CAL_JsqLQCSHfQtYicBVYfjtcE2nJLZ=g_7ASj5LfBhOb2Y2ouw@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: pmac32: Use of_property_read_reg() to parse "reg"
To:     Viresh Kumar <viresh.kumar@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org
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

On Sun, Jul 2, 2023 at 10:01=E2=80=AFPM Viresh Kumar <viresh.kumar@linaro.o=
rg> wrote:
>
> On 09-06-23, 12:31, Rob Herring wrote:
> > Use the recently added of_property_read_reg() helper to get the
> > untranslated "reg" address value.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  drivers/cpufreq/pmac32-cpufreq.c | 5 ++---
> >  1 file changed, 2 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/cpufreq/pmac32-cpufreq.c b/drivers/cpufreq/pmac32-=
cpufreq.c
> > index ec75e79659ac..f53635ba16c1 100644
> > --- a/drivers/cpufreq/pmac32-cpufreq.c
> > +++ b/drivers/cpufreq/pmac32-cpufreq.c
> > @@ -378,10 +378,9 @@ static int pmac_cpufreq_cpu_init(struct cpufreq_po=
licy *policy)
> >
> >  static u32 read_gpio(struct device_node *np)
> >  {
> > -     const u32 *reg =3D of_get_property(np, "reg", NULL);
> > -     u32 offset;
> > +     u64 offset;
> >
> > -     if (reg =3D=3D NULL)
> > +     if (of_property_read_reg(np, 0, &offset, NULL) < 0)
> >               return 0;
> >       /* That works for all keylargos but shall be fixed properly
> >        * some day... The problem is that it seems we can't rely
>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

Is someone going to apply this?

Rob
