Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBB837F9487
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Nov 2023 18:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230313AbjKZRTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 12:19:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjKZRTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 12:19:10 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34772FA
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 09:19:17 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36305C433C8;
        Sun, 26 Nov 2023 17:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701019156;
        bh=Hc0XtjIV2+pEzTvuPqxkkSiwVO4rqkQkLmDydqT5wbk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=uCqUu2dFFj0kqIw2+vUkyftTbMLI1Yns0j6jXIdjSKpPBNSNZRE2eoZeMDFRZEDU1
         I0WlY2swyXPMPAN9/2QK8Qq5ZYasOOrTdohcu+3qlltyAZEYtCjOOIRJoJbuowE/kw
         WTa6olXc9v8WUQG4R6ZX6v12aA7wSHvHSOJBIKuLbd0TZakLMbtLQNr+RSjsDUsnDj
         j4yyNnodNHxgwXMw2wluWqs6y8+uzCQQYZ+HOh7EwSRulcr2cIdnVmEzJfM6Id703u
         G6jNQ0dtwOI0pYoKwXI+s4UpCxrBHnOjexIJIjgbvENpRWCdMiv/qHAVqzcwc73p2D
         N0G2xTr8t61rg==
Date:   Sun, 26 Nov 2023 17:19:10 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     David Lechner <dlechner@baylibre.com>
Cc:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: triggered-buffer: prevent possible freeing of
 wrong buffer
Message-ID: <20231126171910.72124e81@jic23-huawei>
In-Reply-To: <CAMknhBEDp1baTDPrAfAv_gZ5o6LxNSt8bgS8wcGUmXdaCHq_Jw@mail.gmail.com>
References: <20231031210521.1661552-1-dlechner@baylibre.com>
        <3ea3d92db5c4c077a76b29dc5a89c4d491695752.camel@gmail.com>
        <CAMknhBEDp1baTDPrAfAv_gZ5o6LxNSt8bgS8wcGUmXdaCHq_Jw@mail.gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

On Thu, 2 Nov 2023 09:53:13 -0500
David Lechner <dlechner@baylibre.com> wrote:

> On Thu, Nov 2, 2023 at 3:59=E2=80=AFAM Nuno S=C3=A1 <noname.nuno@gmail.co=
m> wrote:
> >
> > On Tue, 2023-10-31 at 16:05 -0500, David Lechner wrote: =20
> > > Commit ee708e6baacd ("iio: buffer: introduce support for attaching mo=
re
> > > IIO buffers") introduced support for multiple buffers per indio_dev b=
ut
> > > left indio_dev->buffer for a few legacy use cases.
> > >
> > > In the case of the triggered buffer, iio_triggered_buffer_cleanup()
> > > still assumes that indio_dev->buffer points to the buffer allocated by
> > > iio_triggered_buffer_setup_ext(). However, since
> > > iio_triggered_buffer_setup_ext() now calls iio_device_attach_buffer()
> > > to attach the buffer, indio_dev->buffer will only point to the buffer
> > > allocated by iio_device_attach_buffer() if it the first buffer attach=
ed.
> > >
> > > This adds a check to make sure that no other buffer has been attached
> > > yet to ensure that indio_dev->buffer will be assigned when
> > > iio_device_attach_buffer() is called.
> > >
> > > Fixes: ee708e6baacd ("iio: buffer: introduce support for attaching mo=
re IIO
> > > buffers")
> > > Signed-off-by: David Lechner <dlechner@baylibre.com>
> > > ---
> > >  drivers/iio/buffer/industrialio-triggered-buffer.c | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > index c7671b1f5ead..c06515987e7a 100644
> > > --- a/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > +++ b/drivers/iio/buffer/industrialio-triggered-buffer.c
> > > @@ -46,6 +46,16 @@ int iio_triggered_buffer_setup_ext(struct iio_dev
> > > *indio_dev,
> > >       struct iio_buffer *buffer;
> > >       int ret;
> > >
> > > +     /*
> > > +      * iio_triggered_buffer_cleanup() assumes that the buffer alloc=
ated
> > > here
> > > +      * is assigned to indio_dev->buffer but this is only the case i=
f this
> > > +      * function is the first caller to iio_device_attach_buffer(). =
If
> > > +      * indio_dev->buffer is already set then we can't proceed other=
wise
> > > the
> > > +      * cleanup function will try to free a buffer that was not allo=
cated
> > > here.
> > > +      */
> > > +     if (indio_dev->buffer)
> > > +             return -EADDRINUSE;
> > > + =20
> >
> > Hmmm, good catch! But I think this is just workarounding the real probl=
em =20
>=20
> Yes, I could have done a better job explaining my reason for this fix.
> It seemed like the simplest fix that could be easily backported to
> stable kernels. And then we can look at removing the legacy field
> completely in the future.
>=20
> > because like this, you can only have a triggered buffer by device. This=
 should
> > be fine as we don't really have any multi buffer user so far but ideall=
y it
> > should be possible.

So far multibufferred devices have always been for cases where triggers don=
't make
sense (devices with multiple hardware fifos that run out of step or where a=
 single
fifo is filled unevenly from different sensors, or big complex dma based de=
vices
where the trigger concept doesn't map at all.)

I agree that it sort of make sense to make the trigger per buffer, but in p=
ractice
I'm not sure on what sort of device will need it. Mind you, I guess you hit=
 this
in practice which rather implies something does!

> >
> > Long term we might want to think about moving 'pollfunc' to be a per bu=
ffer
> > thing. Not sure how much trouble that would be given that a trigger is =
also per
> > device and I don't know if it would make sense to have a trigger per bu=
ffer?!
> > Ideally, given the multi buffer concept, I would say it makes sense but=
 it might
> > be difficult to accomplish. So better to think about it only if there's=
 a real
> > usecase for it.
> >
> > On thing that I guess it could be done is to change the triggered API s=
o it
> > returns a buffer and so iio_triggered_buffer_cleanup() would also get a=
 pointer
> > to the buffer it allocated (similar to what DMA buffer's are doing). Bu=
t that's
> > indeed also bigger change... Bahh, I'm likely over complicating things =
for now. =20
>=20
> This sounds very much like the work I am doing on SPI Engine offload
> support - having a trigger associated with a buffer. So maybe
> something will come out of that. =C2=AF\_(=E3=83=84)_/=C2=AF

Ah. I guess if the trigger is being used to route things out of sight of so=
ftware that
might be a case where we do need multiple triggers per device...

Doesn't sound 'too' hard to make work and we'll end up with similar case to=
 buffers
where
iio_deviceX/current_trigger maps to the one for buffer0 so no ABI breakage,=
 just new
toys to play with.
>=20
> > Fell free to:
> >
> > Acked-by: Nuno Sa <nuno.sa@analog.com>
> >
> > =20
Applied with a note that we may revisit adding multiple triggers support in=
 future
but that is unlikely to be suitable for a backport as it's a new feature.

Applied to the fixes-togreg branch of iio.git and marked for stable.

Thanks,

Jonathan


