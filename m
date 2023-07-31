Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7D32769AD6
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 17:32:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231709AbjGaPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjGaPcK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 11:32:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E206CBF;
        Mon, 31 Jul 2023 08:32:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7635C611A9;
        Mon, 31 Jul 2023 15:32:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7CADC433CA;
        Mon, 31 Jul 2023 15:32:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690817527;
        bh=5E06FUiid6T4vgfkLSlTscvM6X1NVs/YkUOgbv1WjZc=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=AZxwYpXcjYbyuWTzscU1pa0c7ZxYX+jUX/gVXYqzo3K9Yox+xyMzJ28WqQkICXG5A
         M47daMdHhor49bZP/Yxk7qFAeZrPM7C40B7nyUbuQax3iHE42JuidkswWCQ6XnEZr0
         VQ0httpuVvzcDzoD/pbfsUkAqrpLfVgGrr0ojXvfly/CponzZBi73QjLX8nVNgVLy8
         WS4LcE7PJG3xO0GjUA/zbH79lf6bX+WGchWSDUVBqA+cwN+ZqDWC8sNIghCs2s2cYY
         nzoKmpXCiF6S+tFisvfzKQIQInXYiZgf4/qTiaQ5DjPpj8q7yFPO7361/GgAXugawF
         orO0tNZlGDiSg==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b9ba3d6157so68619551fa.3;
        Mon, 31 Jul 2023 08:32:07 -0700 (PDT)
X-Gm-Message-State: ABy/qLbIt6mdSfZdOnynHk+ljsSEikG/RjRtXniu4o3D/spP2A9v7xcx
        RH2R0QEWvGnUJWH0/EAQA3ygvtMRY2SAODYqpw==
X-Google-Smtp-Source: APBJJlF19uImMksgUiSVsL8p6nT4gd4CeDo7zq0USsNsugz1qVA1GktuTbo0TYPWnk7rVJKuWRXVCTCNUHaM7QQCpkM=
X-Received: by 2002:a2e:8804:0:b0:2b9:ee3e:2407 with SMTP id
 x4-20020a2e8804000000b002b9ee3e2407mr204494ljh.38.1690817525832; Mon, 31 Jul
 2023 08:32:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230721161840.1393996-1-hugo@hugovil.com> <20230721161840.1393996-7-hugo@hugovil.com>
 <CAL_JsqJpdhtnZ8FcM7kGWnM+iuDs1fWiCVgf413evbw-o8TZGQ@mail.gmail.com>
 <20230722104724.ef0c5896c239e721794b9fe9@hugovil.com> <2023072240-supremacy-shallot-a77f@gregkh>
 <20230724115428.d191186852c0bd0ee0d78398@hugovil.com>
In-Reply-To: <20230724115428.d191186852c0bd0ee0d78398@hugovil.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 31 Jul 2023 09:31:53 -0600
X-Gmail-Original-Message-ID: <CAL_JsqL8rjwONd6UAitKik0U44BKSD6m8zbachgfq0R9oHBW8w@mail.gmail.com>
Message-ID: <CAL_JsqL8rjwONd6UAitKik0U44BKSD6m8zbachgfq0R9oHBW8w@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 9:54=E2=80=AFAM Hugo Villeneuve <hugo@hugovil.com> =
wrote:
>
> On Sat, 22 Jul 2023 17:15:26 +0200
> Greg KH <gregkh@linuxfoundation.org> wrote:
>
> > On Sat, Jul 22, 2023 at 10:47:24AM -0400, Hugo Villeneuve wrote:
> > > On Fri, 21 Jul 2023 13:24:19 -0600
> > > Rob Herring <robh+dt@kernel.org> wrote:
> > >
> > > > On Fri, Jul 21, 2023 at 10:19=E2=80=AFAM Hugo Villeneuve <hugo@hugo=
vil.com> wrote:
> > > > >
> > > > > From: Hugo Villeneuve <hvilleneuve@dimonoff.com>
> > > > >
> > > > > Commit 679875d1d880 ("sc16is7xx: Separate GPIOs from modem contro=
l lines")
> > > > > and commit 21144bab4f11 ("sc16is7xx: Handle modem status lines")
> > > > > changed the function of the GPIOs pins to act as modem control
> > > > > lines without any possibility of selecting GPIO function.
> > > >
> > > > Requiring a new DT property is not fixing a kernel regression. You
> > > > should be returning the kernel to original behavior and then have a
> > > > new DT property for new behavior.
> > >
> > > Hi Rob,
> > > please read the entire patch history starting from V1
> > >  and you will understand why this course of action was
> > >  not selected.
> >
> > That's not going to happen, sorry, you need to explain it here, in this
> > patch series, why a specific action is being taken over another one, as
> > no one has time to go dig through past history, sorry.
>
> Hi Rob,
> I initially submitted a patch to revert the kernel to original
> behavior, but it created more problems because the patch was
> unfortunately split in two separate patches, and mixed with other non
> closely-related changes. It was also noted to me that reverting to the
> old behavior would break things for some users.
>
> It was suggested to me by a more experienced kernel developer to
> "suggest a fix, instead of hurrying a revert":
>
>     https://lkml.org/lkml/2023/5/17/758

Do I have to go read this to decipher the justification and reasoning?
When Greg says "in this patch series", he means in the commit messages
of the patches. You send v9 already and it doesn't have that. The
patchset needs to stand on its own summarizing any relevant prior
discussions.

I never suggested doing a revert. Obviously, someone still wants the
new feature. The issue is a new feature was added to the kernel, but
you are requiring a DT change to platforms NOT using the feature. Make
the platforms wanting the new feature to need a DT change. That's
still not great, but it's much better to affect new platforms rather
than old, stable platforms. The period of time that regresses is much
smaller (a few kernel releases vs. years potentially). Of course, if
it's just those 3 platforms and their maintainers are fine with
needing this DT change, then that works too. But there's no evidence
here that they are okay with it. You didn't even do the update of the
dts files and just left them broken.

Rob
