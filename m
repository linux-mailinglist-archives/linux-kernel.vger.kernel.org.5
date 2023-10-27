Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 223937D99DF
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 15:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345871AbjJ0Ndl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 09:33:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjJ0Ndj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 09:33:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC82DCA;
        Fri, 27 Oct 2023 06:33:37 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9CCF7C433C8;
        Fri, 27 Oct 2023 13:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698413617;
        bh=WWRr7vPyHlc/VMGJypSn1m+NSFr6RCiyf59wCByVhWs=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=XazjmrpKo4oiA5ps8HBjVd49X8vONrubs+ZFGb0RlTNTNCYLBNjkeLO3xFb4FVhRP
         ovNRF1Wp9caINQzMe/Pmr5m1hQkld20ynJNWa7DN3dAS5zylBICimP83sx2xYGyLIb
         6RWepaBGaPFQ4AWBsUTwClQFy9Dydhw+tuRg8QJkCd1vYPz0R1vTLxfCwAwGuT6Neg
         xzI8qiytku5rDGimt+CZnh3N0lr9UndHcb7yLl9JcbcGLD5DaidFQU6rhW4S6/am4Z
         qyZ+9qc3IddggzVxUc7yu8hiI2I4/PdBfxOVqMurFUaClat9mlcdHnIbgp2trieL3/
         KfpUpDuQFLOkw==
Date:   Fri, 27 Oct 2023 14:33:35 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Mehdi Djait <mehdi.djait.k@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: kx022a: Fix acceleration value scaling
Message-ID: <20231027143335.7faa87aa@jic23-huawei>
In-Reply-To: <77b5f4a6-4012-4409-9034-419b852a783f@gmail.com>
References: <ZTEt7NqfDHPOkm8j@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
        <CAM+2Eu+ndzS9NLvsZaX_=YTHb_+t4cE5GjQevJ1Lgc2EBO20rA@mail.gmail.com>
        <c623b6ff-6d6c-4351-b828-4ed4663f9de9@gmail.com>
        <CAM+2EuJ8J+sJNBqbPuFLXVK-Y9V=q+Lt=js9giWdSZ6H=aJ2Jg@mail.gmail.com>
        <77b5f4a6-4012-4409-9034-419b852a783f@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Mon, 23 Oct 2023 09:24:39 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 10/20/23 19:48, Jagath Jog J wrote:
> > On Fri, Oct 20, 2023 at 5:39=E2=80=AFPM Matti Vaittinen
> > <mazziesaccount@gmail.com> wrote: =20
> >>
> >> On 10/19/23 21:21, Jagath Jog J wrote: =20
> >>> Hi Matti,
> >>>
> >>> On Thu, Oct 19, 2023 at 6:54=E2=80=AFPM Matti Vaittinen
> >>> <mazziesaccount@gmail.com> wrote: =20
> >>>> =20
> >  =20
> >>>> I did only very quick testing on KX022A and iio_generic_buffer. After
> >>>> the patch the values seemed to be correct order of magnitude. Further
> >>>> testing is appreciated :) =20
> >>>
> >>> Values are correct with this change, Thank you for fixing.
> >>> Tested-by: Jagath Jog J <jagathjog1996@gmail.com> =20
> >>
> >> Thanks a ton for testing! May I ask which component did you use (or did
> >> you just use some 'simulated' regster values?) =20
> >=20
> > Hi Matti,
> >=20
> > I just simulated with the register values, Should the 'tested-by' tag o=
nly be
> > provided after hardware testing? =20
>=20
> I am not sure TBH. I didn't have a problem with your tag though, I was=20
> merely curious to hear about the IC usage :)
>=20
> Now that you mentioned the tested-by tag usage, I started to wonder it=20
> as well. From pure SW/driver point of view the register value simulation=
=20
> is sufficient - but in practice we are not interested in whether the=20
> code works "in theory" - but whether the products do really work. This=20
> is something which includes handling of potential HW quircks and=20
> oddities - which are not always documented or known.
>=20
> If we assume a case where someone is developing new gizmo and hits a bug=
=20
> which is in reality caused by some undocumented HW hiccup - then fixes=20
> with "tested-by" tags which are not actually tested on HW having this=20
> hiccup but using SW simulation - may be misleading.
>=20
> The above is just some overall pondering - I am not too concerned on=20
> your tested-by tag :) Besides, it's cool you did the testing! I=20
> appreciate that! However, I wonder if there is some wider consensus=20
> whether the tests should be ran using real HW when tested-by tag is=20
> given. Jonathan, do you have any educated opinion on this?

It's fine to add a note.  People typically do this if they've tested on
a particular device from a set.  So if you want to (entirely optional)

Tested-by .... #Tested by simulate register values

I wouldn't describe that as a particularly educated opinion though :)
Not something I care that much about.

J
>=20
> > I referred to this driver because it's
> > the most recent accelerometer driver that was merged. =20
>=20
> Makes sense :) Thanks for replying!
>=20
> Yours,
> 	-- Matti
>=20

