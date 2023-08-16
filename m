Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8607777D8ED
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 05:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241479AbjHPDTI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 23:19:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241419AbjHPDSv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 23:18:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0867F2129;
        Tue, 15 Aug 2023 20:18:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 99FCE61E3F;
        Wed, 16 Aug 2023 03:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF871C433C8;
        Wed, 16 Aug 2023 03:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692155929;
        bh=nHa10dP3nxkBDfFeoYCyrAWMJy2FWPWe6fhPPlrfvjw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=H/s8ksQgxX8mS8C/flFxZKwIVaFF/RF+o8D82O5pqyg0e9DAgysdSrSlySvj8TAuA
         1KGM8HsZ8bW/jTjY5jDNyDdhU8VYKHlnBSod9zi0GycgQpdD43VLoMm+u2Hj7EoUZm
         7Lfo+TTTAHR3inLxOIoJ4RyLB6/ES406qn8GFV9e5M82gvwoyXCc3bjcIHLS83AKiv
         IapcUI+SAaVc8WiKTrlrgxRLBMqdgSAofKX2tYdRURosLIW+RXrAOst0jj1J44PWE2
         97V1mvMvT/owWfcdHRPbc7sjyZQwvmcpQJF7PKLJBoSDKPvfA5On5CUh7OEPpIsxdN
         gIidje49cNFMA==
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-1c4c7a83bcdso2532173fac.0;
        Tue, 15 Aug 2023 20:18:48 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy8Mf55gYq1tkqyEGmoCZ5dqYRtoUGi9Pe6gCq/CwLqk2Q4k1dR
        2i/xPbSf3k4sr7CuNiVv4X2Ixcd2V6iiMxG6wq0=
X-Google-Smtp-Source: AGHT+IH7IEocFvUzeHl8Q5HSvIPf8HZyNDAO827/V/uM8h8IgRa304+0DWpfnB1m9Ac65kQwNaOzIiIt/si0wgRnPmU=
X-Received: by 2002:a05:6871:6aa:b0:1bb:3f64:bb89 with SMTP id
 l42-20020a05687106aa00b001bb3f64bb89mr764048oao.24.1692155928214; Tue, 15 Aug
 2023 20:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20230729214138.79902-1-sergeantsagara@protonmail.com>
 <CAK7LNAR_Egr+G9_HmGfrmFAEQ0Tznmbff0w9cJ=1biV5P4PmNQ@mail.gmail.com>
 <875y5rsd6c.fsf@protonmail.com> <CAK7LNAS2XKRisvMkB+dw3ZnExYuy9U8xB9BXnXy2FvqZWrRk-g@mail.gmail.com>
 <871qg8cirv.fsf@protonmail.com>
In-Reply-To: <871qg8cirv.fsf@protonmail.com>
From:   Masahiro Yamada <masahiroy@kernel.org>
Date:   Wed, 16 Aug 2023 12:18:12 +0900
X-Gmail-Original-Message-ID: <CAK7LNAQvDYNEPbK0NJUYAYwfnSG_kUFokkBrD4+h3bSeecS1LA@mail.gmail.com>
Message-ID: <CAK7LNAQvDYNEPbK0NJUYAYwfnSG_kUFokkBrD4+h3bSeecS1LA@mail.gmail.com>
Subject: Re: [PATCH] scripts: merge_config: Add flag to prevent unsetting
 config option
To:     Rahul Rameshbabu <sergeantsagara@protonmail.com>
Cc:     linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 12:00=E2=80=AFAM Rahul Rameshbabu
<sergeantsagara@protonmail.com> wrote:
>
>
> On Tue, 08 Aug, 2023 04:04:37 +0900 "Masahiro Yamada" <masahiroy@kernel.o=
rg> wrote:
> > On Mon, Aug 7, 2023 at 1:13=E2=80=AFPM Rahul Rameshbabu
> > <sergeantsagara@protonmail.com> wrote:
> >>
> >>
> >> On Sun, 06 Aug, 2023 23:19:55 +0900 "Masahiro Yamada" <masahiroy@kerne=
l.org> wrote:
> >> > On Sun, Jul 30, 2023 at 6:42=E2=80=AFAM Rahul Rameshbabu
> >> > <sergeantsagara@protonmail.com> wrote:
> >> >>
> >> >> Overriding a previously defined entry for a config option with 'is =
not set'
> >> >> may be undesirable in some fragment configuration setups.
> >> >
> >> > Then, you should remove the 'is not set' entry from the fragment.
> >>
> >> I had a feeling that was the expectation. Just for reference, my flow
> >> for generating fragments looks like the following.
> >>
> >>   1. make allnoconfig
> >>   2. make menuconfig   # select the options that I desire for the frag=
ment
> >
> >
> > Sorry, I could not understand
> > how these steps generate a fragment file.
> >
> > You will get a full .config file
> > after 'make menuconfig'.
>
> Yep, this is right. I am not really generating a fragment this way but
> rather full configs with minimal options that I end up wanting to merge
> together. What's your process for generating fragments you need? Just
> dumping the options you want in fragment files and letting make properly
> select the dependencies?


I would manually write a fragment file.


I see comment lines in

kernel/configs/debug.config
kernel/configs/xen.config

I believe they were written by hand.





--=20
Best Regards
Masahiro Yamada
