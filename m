Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F174A77069C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 19:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231653AbjHDRDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 13:03:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231681AbjHDRDc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 13:03:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE5349D8
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 10:03:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B6490620B7
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 17:02:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27219C433C8;
        Fri,  4 Aug 2023 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691168578;
        bh=9zCz6fL5uLMjhsXTrlMBXoPcdM5rWmBh0zdD9+OFthM=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JuPQC6NMfJmKhwXjC9hw0IyI6awcWX10lGP77HyRKArnWc24fxcRhe3ZVmZw2jWsM
         QBCtJBYR3FKUBMQTxSHwkVijfh/P21aje/h9Y1eCfDZTbDeqHmmj7HXf7vMu9sCd/f
         2+T2IZiFRSQ3rc79xqI9FBd9vC5PNwX612+VcLIDIO97qJZoM3f3DbcFoYhxGlaDRF
         L+5hs73HlgbzuQEV4cB75YYB7HrGydRVdmhlyiWdfAaHIxRQ1PIkqG5UPrSXjSAhjH
         ZAIyS7XNktAPtCsXHDPC0LEVx7TPTFeISwVNILDXmxXhirP7cwzy9Fb1+eUNcx7zfB
         k1+RicqNSWtGg==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so37688851fa.3;
        Fri, 04 Aug 2023 10:02:58 -0700 (PDT)
X-Gm-Message-State: AOJu0YyUB1uLN7Cs3tYqgvHK5iWg6fITzCXQftAoz4LrObUGkCDMRhF7
        HAldhZ9lkk4fvEGLTKXgR6D8LDcxJ3zvMDWdsg==
X-Google-Smtp-Source: AGHT+IFpT3Jz9eUUjz8gBnEl/G9Wl5TYudwVd5Pkn2WF4/7vexUzQc9k4OYkWaDaebvVLGxtZGKoszr3GFCQ9fUyBfw=
X-Received: by 2002:a2e:781a:0:b0:2b9:ac48:d7fb with SMTP id
 t26-20020a2e781a000000b002b9ac48d7fbmr2055634ljc.41.1691168576159; Fri, 04
 Aug 2023 10:02:56 -0700 (PDT)
MIME-Version: 1.0
References: <CADyTPEzqf8oQAPSFRWJLxAhd-WE4fX2zdoe9Vu6V9hZMn1Yc8g@mail.gmail.com>
 <CAL_JsqLrErF__GGHfanRFCpfbOh6fvz4-aJv32h8OfDjUeZPSg@mail.gmail.com>
 <CADyTPEwgG0=R_b5DNBP0J0auDXu2BNTOwkSUFg-s7pLJUPC+Tg@mail.gmail.com> <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
In-Reply-To: <CADyTPExgjcaUeKiR108geQhr0KwFC0A8qa_n_ST2RxhbSczomQ@mail.gmail.com>
From:   Rob Herring <robh@kernel.org>
Date:   Fri, 4 Aug 2023 11:02:43 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
Message-ID: <CAL_Jsq+N2W0hVN7fUC1rxGL-Hw9B8eQvLgSwyQ3n41kqwDbxyg@mail.gmail.com>
Subject: Re: PROBLEM: Broken or delayed ethernet on Xilinx ZCU104 since 5.18 (regression)
To:     Nick Bowler <nbowler@draconx.ca>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        netdev@vger.kernel.org, regressions@lists.linux.dev
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

On Fri, Aug 4, 2023 at 10:54=E2=80=AFAM Nick Bowler <nbowler@draconx.ca> wr=
ote:
>
> On 2023-08-04, Nick Bowler <nbowler@draconx.ca> wrote:
> > On 04/08/2023, Rob Herring <robh@kernel.org> wrote:
> >> On Fri, Aug 4, 2023 at 9:27=E2=80=AFAM Nick Bowler <nbowler@draconx.ca=
> wrote:
> >>>   commit e461bd6f43f4e568f7436a8b6bc21c4ce6914c36
> >>>   Author: Robert Hancock <robert.hancock@calian.com>
> >>>   Date:   Thu Jan 27 10:37:36 2022 -0600
> >>>
> >>>       arm64: dts: zynqmp: Added GEM reset definitions
> >>>
> >>> Reverting this fixes the problem on 5.18.  Reverting this fixes the
> >>> problem on 6.1.  Reverting this fixes the problem on 6.4.  In all of
> >>> these versions, with this change reverted, the network device appears
> >>> without delay.
> >>
> >> With the above change, the kernel is going to be waiting for the reset
> >> driver which either didn't exist or wasn't enabled in your config
> >> (maybe kconfig needs to be tweaked to enable it automatically).
> >
> > The dts defines a reset-controller node with
> >
> >   compatible =3D "xlnx,zynqmp-reset"
> >
> > As far as I can see, this is supposed to be handled by the code in
> > drivers/reset/zynqmp-reset.c driver, it is enabled by CONFIG_ARCH_ZYNQM=
P,
> > and I have that set to "y", and it appears to be getting compiled in (t=
hat
> > is, there is a drivers/reset/zynqmp-reset.o file in the build directory=
).
>
> Oh, I get it, to include this driver I need to also enable:
>
>   CONFIG_RESET_CONTROLLER=3Dy
>
> Setting this fixes 6.4.  Perhaps CONFIG_ARCH_ZYNQMP should select it?

Maybe. Do other platforms do that?

> I guess the reset-zynqmp.o file that was in my build directory must
> have been leftover garbage from a long time ago.
>
> However, even with this option enabled, 6.5-rc4 remains broken (no
> change in behaviour wrt. the network device).  I will bisect this
> now.

It would be good to know why the deferred probe timeout doesn't work.
If you disable modules, the kernel shouldn't wait past late_initcall.
Though this functionality keeps getting tweaked, so I may be off on
the current behavior.

Rob
