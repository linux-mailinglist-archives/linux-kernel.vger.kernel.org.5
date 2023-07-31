Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8492769FFE
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 20:05:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbjGaSFF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 14:05:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbjGaSFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 14:05:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD5F2E52;
        Mon, 31 Jul 2023 11:05:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 42C386125E;
        Mon, 31 Jul 2023 18:05:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6E7CC433CB;
        Mon, 31 Jul 2023 18:05:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690826700;
        bh=NlIuvQdLsbZRs9xKKZPU9QNmPufa9SXsdYZpx7GsOCY=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=YxN4v45sggOP8u25Ga6OHNMRp/yaTP+cCGVRCQ+m5LbGA7uXBoDQYJF35LL78/TDd
         QnXPEGL3qXBiv5hoIAsM0YQCRCHdY9CLj/Y19FUnLCmHD61AgY4XCc6BET91FsO0Lv
         bWwGCab4hgJgYb/OYgNUoCQkJYfymAwVIv8y2qBg4zYmAFz738GL2cM9a8Wq7pd6hf
         kbhkqq1lLm1O7i3jWGbeJFg+PGTUvVe/1IANrBOs6Q6BF49aTyBxECju9lHzU2cLPM
         FeBnb5Zi0dItNzZRsvQNcOY0catZvJF7Q7HWHzfq17viEutKrsqfMqQpXydYTX9Xk/
         I+NrfAa1fI5zw==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2b9d3dacb33so44931071fa.1;
        Mon, 31 Jul 2023 11:05:00 -0700 (PDT)
X-Gm-Message-State: ABy/qLYjpn8Nj+qfIrR+QXhhZ82NuAhCeUNUMTgPOSds+pkkwi1T9VVz
        KfVDFzVACYikZIg++Zs69Vg2B2vxF0jApHsqyA==
X-Google-Smtp-Source: APBJJlHmYoa7wNWCoPioGv/c7TslSfI7mb6yLjssF2FXna8gHSJ2JLwRBMq2SeYMDBgzkoTpB9YDIiByhdszSZOiHD4=
X-Received: by 2002:a2e:9c94:0:b0:2b9:dd3b:cf43 with SMTP id
 x20-20020a2e9c94000000b002b9dd3bcf43mr520218lji.13.1690826698551; Mon, 31 Jul
 2023 11:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230721161840.1393996-1-hugo@hugovil.com> <20230721161840.1393996-7-hugo@hugovil.com>
 <CAL_JsqJpdhtnZ8FcM7kGWnM+iuDs1fWiCVgf413evbw-o8TZGQ@mail.gmail.com>
 <20230722104724.ef0c5896c239e721794b9fe9@hugovil.com> <2023072240-supremacy-shallot-a77f@gregkh>
 <20230724115428.d191186852c0bd0ee0d78398@hugovil.com> <CAL_JsqL8rjwONd6UAitKik0U44BKSD6m8zbachgfq0R9oHBW8w@mail.gmail.com>
 <20230731124600.39eb8d5c132f9338c2897543@hugovil.com>
In-Reply-To: <20230731124600.39eb8d5c132f9338c2897543@hugovil.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 31 Jul 2023 12:04:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLaF70hNQndXpJfmH1TMGNbA7myQG0GK9fjyKOs63z-3w@mail.gmail.com>
Message-ID: <CAL_JsqLaF70hNQndXpJfmH1TMGNbA7myQG0GK9fjyKOs63z-3w@mail.gmail.com>
Subject: Re: [RESEND PATCH v8 06/10] serial: sc16is7xx: fix regression with
 GPIO configuration
To:     Hugo Villeneuve <hugo@hugovil.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        jirislaby@kernel.org, jringle@gridpoint.com,
        isaac.true@canonical.com, jesse.sung@canonical.com,
        tomasz.mon@camlingroup.com, l.perczak@camlintechnologies.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        stable@vger.kernel.org,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Lech Perczak <lech.perczak@camlingroup.com>
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

On Mon, Jul 31, 2023 at 10:46=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com>=
 wrote:
>
> On Mon, 31 Jul 2023 09:31:53 -0600
> Rob Herring <robh+dt@kernel.org> wrote:
>
> > On Mon, Jul 24, 2023 at 9:54=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.c=
om> wrote:
> > >
> > > On Sat, 22 Jul 2023 17:15:26 +0200
> > > Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > > On Sat, Jul 22, 2023 at 10:47:24AM -0400, Hugo Villeneuve wrote:
> > > > > On Fri, 21 Jul 2023 13:24:19 -0600
> > > > > Rob Herring <robh+dt@kernel.org> wrote:
> > > > >
> > > > > > On Fri, Jul 21, 2023 at 10:19=E2=80=AFAM Hugo Villeneuve <hugo@=
hugovil.com> wrote:
> > > > > > >
> > > > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > > > >
> > > > > > > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem co=
ntrol lines")
> > > > > > > and commit 21144bab4f11 ("sc16is7xx: Handle modem status line=
s")
> > > > > > > changed the function of the GPIOs pins to act as modem contro=
l
> > > > > > > lines without any possibility of selecting GPIO function.
> > > > > >
> > > > > > Requiring a new DT property is not fixing a kernel regression. =
You
> > > > > > should be returning the kernel to original behavior and then ha=
ve a
> > > > > > new DT property for new behavior.
> > > > >
> > > > > Hi Rob,
> > > > > please read the entire patch history starting from V1
> > > > >  and you will understand why this course of action was
> > > > >  not selected.
> > > >
> > > > That's not going to happen, sorry, you need to explain it here, in =
this
> > > > patch series, why a specific action is being taken over another one=
, as
> > > > no one has time to go dig through past history, sorry.
> > >
> > > Hi Rob,
> > > I initially submitted a patch to revert the kernel to original
> > > behavior, but it created more problems because the patch was
> > > unfortunately split in two separate patches, and mixed with other non
> > > closely-related changes. It was also noted to me that reverting to th=
e
> > > old behavior would break things for some users.
> > >
> > > It was suggested to me by a more experienced kernel developer to
> > > "suggest a fix, instead of hurrying a revert":
> > >
> > >     https://lkml.org/lkml/2023/5/17/758
> >
> > Do I have to go read this to decipher the justification and reasoning?
> > When Greg says "in this patch series", he means in the commit messages
> > of the patches. You send v9 already and it doesn't have that. The
> > patchset needs to stand on its own summarizing any relevant prior
> > discussions.
> >
> > I never suggested doing a revert.
>
> Hi Rob,
> I am sorry, but this is exactly what I "deciphered" from your
> original email.
>
> I am trying very hard to understand exactly what you mean, but it is
> not that obvious for me. If something is not clear in my commit message,
> I will try to improve it. But before, let's try to focus on making sure
> I understand more clearly what you want exactly.
>
> > Obviously, someone still wants the
> > new feature.
>
> I assume that you refer to the "new feature" as what was added in
> the commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem control
> lines")?

Shrug. It's one of the 2 commits mentioned, I don't know which one
exactly. Whichever one changed default behavior from use GPIOs to use
modem ctrl lines.

Reading it again, I *think* this patch is correct. Default behavior is
restored to use GPIOs. The DT property is needed to enable modem ctrl
lines.

What's not okay is just saying, these platforms may or may not need an upda=
te:

    arm64/boot/dts/freescale/fsl-ls1012a-frdm.dts
    mips/boot/dts/ingenic/cu1830-neo.dts
    mips/boot/dts/ingenic/cu1000-neo.dts

You need to figure that out. Have you checked with maintainers of
these boards? When were they added and by who? At the same time or by
the same person would be a good indication the platform uses modem
ctrl lines. Or were these platforms in use before adding modem ctrl
support? Then they probably use GPIOs or nothing.

If there are platforms which would regress if the modem ctrl feature
was just reverted, which ones are those?

Rob
