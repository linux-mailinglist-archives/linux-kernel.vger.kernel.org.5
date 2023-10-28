Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1D327DA80F
	for <lists+linux-kernel@lfdr.de>; Sat, 28 Oct 2023 18:29:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229475AbjJ1Q3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 28 Oct 2023 12:29:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjJ1Q3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 28 Oct 2023 12:29:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3754E5;
        Sat, 28 Oct 2023 09:29:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82171C433C8;
        Sat, 28 Oct 2023 16:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698510585;
        bh=Rj3BkShgUCjKqzMxkOR2/2ofVk0mecsIOI+51xRc2BQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=R3lhfCi0bNJN+4SAO97/uT6nhxXo8bukWGzXkflwHCRIZcAu5EuF03PEW+gcN4IN8
         7y+bNo4JV14tkA/xs3cr9d8hkAj4Iufoz6rbAQwqmb3hBsEOrtvaia869PEDcYdvZQ
         MtMZn7o44Sl+za2i8Ek984y5EWsbJldM7e9y7NHpZxspigyvA8y7D9gOHA4hw+/hPR
         cBQNr+chLMDTsnvE+TeoXViiE3SggLd6qGTDghfvGFwr//wBu8yT4Co1HGf6AvjC95
         3eY4GLX2wimIwSW2T6UvEq8SOGK/E8Rz3l5fwsZts4ZsfmlphOUof7C8mMt2N0cWmb
         U2Rdh9MDV9G+A==
Date:   Sat, 28 Oct 2023 17:29:19 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Nuno =?UTF-8?B?U8Oh?= <noname.nuno@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Eliza Balas <Eliza.Balas@analog.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        "derek.kiernan@amd.com" <derek.kiernan@amd.com>,
        "dragan.cvetic@amd.com" <dragan.cvetic@amd.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Olivier Moysan <olivier.moysan@foss.st.com>
Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD engine
Message-ID: <20231028172919.24335aa4@jic23-huawei>
In-Reply-To: <a1ddec9a04c8a978d50d04c69d675510b05eedb1.camel@gmail.com>
References: <20231019125646.14236-1-eliza.balas@analog.com>
        <20231019125646.14236-3-eliza.balas@analog.com>
        <2023101917-cork-numeric-dab8@gregkh>
        <BN7PR03MB4545E7EAB2D72B9098C30C6797DBA@BN7PR03MB4545.namprd03.prod.outlook.com>
        <2023102030-resort-glance-57ef@gregkh>
        <BN7PR03MB4545FF54B96514EC9F41887E97D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
        <2023102339-outcast-scone-5a63@gregkh>
        <BN7PR03MB4545DA4A9404F349170CBA1097D8A@BN7PR03MB4545.namprd03.prod.outlook.com>
        <15f25d73-32d5-4809-8096-32c856559d66@app.fastmail.com>
        <a1ddec9a04c8a978d50d04c69d675510b05eedb1.camel@gmail.com>
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

On Mon, 23 Oct 2023 16:36:57 +0200
Nuno S=C3=A1 <noname.nuno@gmail.com> wrote:

> On Mon, 2023-10-23 at 16:19 +0200, Arnd Bergmann wrote:
> > On Mon, Oct 23, 2023, at 15:30, Balas, Eliza wrote: =20
> > > > -----Original Message-----
> > > > Cvetic <dragan.cvetic@amd.com>; Arnd Bergmann <arnd@arndb.de>
> > > > Subject: Re: [PATCH v3 2/2] drivers: misc: adi-axi-tdd: Add TDD eng=
ine =20
> >  =20
> > > > > > > Since the device is not an iio device, using an iio function =
would
> > > > > > > be confusing. =20
> > > > > >=20
> > > > > > Why isn't this an iio device? =20
> > > > >=20
> > > > > The device is not registered into the IIO device tree,
> > > > > and does not rely on IIO kernel APIs.
> > > > > Even though there are a few attributes that resemble the
> > > > > ones from iio, and the sysfs structure is similar,
> > > > > this is not an IIO device.
> > > > > In the previous patch versions 1 and 2 we concluded
> > > > > that this device fits better in the misc subsystem. =20
> > > >=20
> > > > Ok, can you point to that in the changelog where the IIO maintainer
> > > > agreed that this doesn't fit into that subsystem?
> > > >  =20
> > > This was one of the discussions from previous v2 :=20
> > > https://lore.kernel.org/all/5b6318f16799e6e2575fe541e83e42e0afebe6cf.=
camel@gmail.com/
> > >=20
> > > I will add it to the changelog the next time I submit the patches. =20
> >=20
> > It sounds like Jonathan wasn't quite sure either here, and I would
> > still argue (as I did in that thread), that drivers/iio is probably
> > a better option than drivers/misc.
> >  =20
>=20
> Well, if Jonathan agrees to have this in IIO, it would actually be better=
 for
> us... The below hack would not be needed at all and IIO is very familiar.

I'm flexible on including this in IIO - we have a few weird and wonderful
devices already that need heavily custom userspace. This looks like it might
be another one of those - though I'm not sure it's all that unusual if you
consider the DDS devices we have drivers for (still in staging after a lot
of years).

A few things in the ABI would need to fit a little better such as matching
units were appropriate and not providing bother msec and raw control of thi=
ngs.

Mapping it as closely as possible onto IIO concepts might be tricky.
Sync is a bit trigger like, but we aren't doing output buffers so it doesn't
fit that well - also the IIO repeat infrastructure is simple and not much u=
sed
in IIO so I doubt it's effective enough for this.  Maybe we can expand
the buffer control concepts to include 'hardware generated sequences'.

Magic might map over to label.

Scratch register says useful for debug on the webpage. Don't expose it then,
or if you do only in debugfs.  Overall enable would be controlled by starti=
ng
the buffer.

I'm not against having more sophisticate output channel definitions to allow
for delays from trigger etc.  We've talked about doing that for input chann=
els
in the past to be able to identify the timing more accurately in devices wi=
th
a sequencer unit. So anything we define should be useful for that case as w=
ell.

So brief brainstorming for how it might be sort of aligned with an IIO ABI.
Abusing slightly the voltage channels - make it a buffer (messing heavily w=
ith
the definition and adding a 'type' field.

buffer0/type   - userspace, pattern - for all existing devices it's userspa=
ce.

For each channel
buffer0/repeats //can't use the scan element spec as it's not writeable.
                //I'd love to fix that but it's horribly invasive to do.
buffer0/repeat_delay //frame length?  Or could map to sampling_frequency :)
buffer0/out_voltageX_en
buffer0/out_voltageX_polarity
buffer0/out_voltageX_index
buffer0/out_voltageX_delay //in seconds I think to match with timeout ABI
                           //not ondelay because I want to reuse this for
                           //the sequencer case mentioned above.
buffer0/out/voltageX_offdelay // also mapped from start of frame.
For the delays, interesting to think about how they map to more general DDS
devices.

startup delay could be considered a trigger characteristic or hammered in h=
ere
as a parameter applying to all channels.
Sync timing is a trigger parameter.  Expose separate triggers for internal,
external and maybe soft - that one is up to you.

It's not that horrible, so if you want to give this a go - perhaps
start with a full formal ABI proposal and let's see if the fit is reasonabl=
e?
Feel free to take the above suggestions as the brief one person brainstorm =
that
they are and propose something much more sensible / coherent!

One thing that concerns me a little is mapping it to more similar
devices.  For instances, treating the signals as voltages is misleading.
Maybe we should treat them as code words, thus supporting more general time
division multiplexers.  We walked through some of the symbol type interfaces
a long time ago for PSK / DDS devices though I think they are still in stag=
ing
(feel free to deal with that whilst you are here :)

It's always hard to define ABI with one device of a new class...

The st micro folk have some complex ADC setups that aren't entirely dissimi=
lar.
(we have chained triggers to deal with a similar 'repeat' on trigger situat=
ion
that looks to me similar to your burst + frame).
Maybe they have considered doing this for DACs or other usecase that overlap
with yours?  +CC Olivier and Fabrice for input.

If there is some common ground here it would be useful to get inputs on the
ABI even if there is no plan to add equivalent support in the near future.

Jonathan




>=20
> > In particular, you mention that you actually make this device
> > appear as an IIO device to user space using the "iio-fake" hack.
> >  =20
>=20
> I want to emphasize that is just our hack to make use of libiio RPC so th=
at we
> can remotely access this device.
> =20
> - Nuno S=C3=A1
>=20

