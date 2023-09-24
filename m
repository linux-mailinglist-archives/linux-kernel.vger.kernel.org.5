Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C28F7AC7E8
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Sep 2023 14:12:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229598AbjIXMMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Sep 2023 08:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjIXMMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Sep 2023 08:12:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD32101;
        Sun, 24 Sep 2023 05:12:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8D24C433C8;
        Sun, 24 Sep 2023 12:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695557558;
        bh=suCin03FD/qH8e+5A1XgOSfSU4aMf8HCIR6C794YICQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cqkxus+clIFBtl5Np7mB30a7oHV3VVQrgab0QHzt+XDDU/WHz7tU6QWtIpZakrhva
         S7Me7ONlxrggTq3dVsuOO2ZO483hqlq/FUpzi0FxgI/a/udy6jL9wln2AOJYd8DeHt
         EHIDe6eKogYMJu6oKJ0fQuZVfsCsJQ+G8vYXPqTWxk2Nrk+z38GKfEmfuBfDECGKQV
         3N4skVFZiDW/LXv9ArPGpIqLO0qdKtrJhAHGavy8JV0tW0nwtBGArlW4DhdawxnG1b
         x3pMNI/SZXuGKTJP3TS6mcfQQL3SKVB9MQKlzdj62wLGGQ3zCSlegiccOHZfRqlsU0
         KkH++rX1RcyDA==
Date:   Sun, 24 Sep 2023 13:12:30 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Benjamin Bara <bbara93@gmail.com>
Cc:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] iio: pressure: Support ROHM BU1390
Message-ID: <20230924131230.6a999c0f@jic23-huawei>
In-Reply-To: <7181e56e-9488-25c9-3d03-64e49b2c952a@gmail.com>
References: <cover.1694760170.git.mazziesaccount@gmail.com>
        <f378a401cec4fb0b9287b52ab159f00dd77569a6.1694760170.git.mazziesaccount@gmail.com>
        <20230917113518.7c4bb1a0@jic23-huawei>
        <a5c19874-32ba-60bf-6e72-9139a2873c7e@gmail.com>
        <c987f401-81c4-00e5-51a7-88a6a38a2ca2@gmail.com>
        <20230919155340.0000076f@Huawei.com>
        <7181e56e-9488-25c9-3d03-64e49b2c952a@gmail.com>
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

On Thu, 21 Sep 2023 11:17:41 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> On 9/19/23 17:53, Jonathan Cameron wrote:
> > On Tue, 19 Sep 2023 14:28:29 +0300
> > Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >  =20
> >> On 9/18/23 15:56, Matti Vaittinen wrote: =20
> >>> On 9/17/23 13:35, Jonathan Cameron wrote: =20
> >>>> On Fri, 15 Sep 2023 09:56:19 +0300
> >>>> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> >>>>    =20
> >>>>> Support for the ROHM BM1390 pressure sensor. The BM1390GLV-Z can me=
asure
> >>>>> pressures ranging from 300 hPa to 1300 hPa with configurable measur=
ement
> >>>>> averaging and internal FIFO. The sensor does also provide temperatu=
re
> >>>>> measurements.
> >>>>>
> >>>>> Sensor does also contain IIR filter implemented in HW. The data-she=
et
> >>>>> says the IIR filter can be configured to be "weak", "middle" or
> >>>>> "strong". Some RMS noise figures are provided in data sheet but no
> >>>>> accurate maths for the filter configurations is provided. Hence, th=
e IIR
> >>>>> filter configuration is not supported by this driver and the filter=
 is
> >>>>> configured to the "middle" setting (at least not for now).
> >>>>>
> >>>>> The FIFO measurement mode is only measuring the pressure and not the
> >>>>> temperature. The driver measures temperature when FIFO is flushed a=
nd
> >>>>> simply uses the same measured temperature value to all reported
> >>>>> temperatures. This should not be a problem when temperature is not
> >>>>> changing very rapidly (several degrees C / second) but allows users=
 to
> >>>>> get the temperature measurements from sensor without any additional
> >>>>> logic.
> >>>>>
> >>>>> This driver allows the sensor to be used in two muitually exclusive
> >>>>> ways,
> >>>>>
> >>>>> 1. With trigger (data-ready IRQ).
> >>>>> In this case the FIFO is not used as we get data ready for each
> >>>>> collected
> >>>>> sample. Instead, for each data-ready IRQ we read the sample from se=
nsor
> >>>>> and push it to the IIO buffer.
> >>>>>
> >>>>> 2. With hardware FIFO and watermark IRQ.
> >>>>> In this case the data-ready is not used but we enable watermark IRQ=
. At
> >>>>> each watermark IRQ we go and read all samples in FIFO and push them
> >>>>> to the
> >>>>> IIO buffer.
> >>>>>
> >>>>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com> =20
> >>
> >> ...
> >> =20
> >>>>> +
> >>>>> +static const unsigned long bm1390_scan_masks[] =3D {
> >>>>> +=C2=A0=C2=A0=C2=A0 BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEM=
P), 0 =20
> >>>> Why?=C2=A0 Doesn't look hard to support just one or the other?
> >>>> Normally we only do this sort of limitation when there is a heavily
> >>>> optimized read routine for a set of channels and it is better
> >>>> to grab them all and throw away the ones we don't care about.
> >>>> That doesn't seem to be true here. So if the fifo grabbed both
> >>>> temp and pressure it would makes sense here, but doesn't seem
> >>>> like it does. =20
> >>>
> >>> I have a feeling I have misunderstood how this mask works. I have
> >>> assumed all the channels with corresponding mask bit _can_ be enabled
> >>> simultaneously, but I have not understood they _must_ all be enabled.=
 I
> >>> think I must go back studying this, but if all channels really _must_=
 be
> >>> enabled, then you are correct. It actually makes a lot of sense to
> >>> support the pressure values alone, as, according to the data-sheet, t=
he
> >>> HW is doing a "MEMS temperature compensation" to the pressure values.
> >>> So, my assuimption is the temperature data may not be required to be
> >>> captured.
> >>>
> >>> This also means I should revise the scan masks for the BU27008, BU270=
10
> >>> and BU27034 light sensors as I don't think all the users want all the
> >>> channels enabled. I wonder how I have not noticed any problems when I
> >>> tested those things - did I really always enable all the channels...?=
 @_@
> >>>
> >>> Anyways, Thanks. =20
> >>
> >> Hi Jonathan,
> >>
> >> There's something in IIO scan_masks / buffer demuxing that I don't qui=
te
> >> understand =20
>=20
> Thank You for the patience and the explanation Jonathan. I have a -=20
> hopefully not totally wrong - feeling I understand this better. I didn't=
=20
> understand that IIO framework has this extra logic and that=20
> available_scan_masks was not really meant for telling what IIO allows=20
> _users_ to enable - but it was for driver to tell IIO core what the=20
> driver can give. (Naturally this impacts to what IIO allows users to=20
> enable, but not directly). Eg, if I now get it right, the=20
> 'available_scan_masks' is information what data flows between driver and=
=20
> IIO. Similarly, 'active_scan_mask' tells what the IIO core 'expects' to=20
> get from the driver, right? So, in bm1390 case, if I set both:
>=20
> BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP),
> and
> BIT(BM1390_CHAN_PRESSURE),
>=20
> to 'available_scan_masks', then it means driver is telling IIO it can=20
> give both pressure and temperature, or temperature alone. As a result,=20
> IIO can set either both temp and pressure to 'active_scan_mask' - in=20
> which case driver should push both in the buffers - or just the=20
> pressure, in which case the driver should not push the temperature.

I think you have understood this from the comment further down.  But
key is active_scan_masks is telling the driver what to put in the
buffer via iio_push_to_buffer*().  The driver has to have told
the core what it can provide (available scan masks) and the core is
picking one of those.  So active_scan_mask is always an entry
of available_scan_masks with the special case of no available_scan_masks
meaning any combination of channels is fine.
The chosen value is made up of a superset of the channels enable by
the various consumers: userspace and in kernel consumers. A typical
complex example being a SoC integrated ADCs where a couple of channels
are used for the touch screen and the rest for more general purposes.
In those cases, the in kernel touch screen driver enables the channels
it wants, and the userspace IIO interface might enable some more.
Each consumer just sees what it asks for as the IIO core repacks the
requested channels for each consumer dropping the others (maybe
leaving some valid data in the padding. I can't remember if we let
that happen or not and that code is complex so I'm not going to go
figure it out again today :)  There are some subtle cases around
consumers requesting mutually exclusive sets. We also never really
dealt with how to negotiates sample rates etc, so this isn't
quite as intuitive as it would ideally be.  E.g. the core could
subsample to meet a lower sampling rate request, but IIRC we just
let the multiple consumers fight it out for control :(


>=20
> >>
> >> The bm1390 driver as sent in v2 does not do demuxing but always pushes
> >> whole chunk of data and trusts IIO to do demuxing. =20
> >=20
> > Yup. That should work.  But in this case you can trivially decide not t=
o read
> > or fill in the temperature and hence save some bus cycles.
> >  =20
> >>
> >> 2) I noticed the 'available_scan_masks' was marked as an optional fiel=
d.
> >> So, I think that if there is no restrictions to which of the channels
> >> can be enabled, then we can omit setting it. This is what I tried.
> >>
> >> It appears that when we do not populate the 'available_scan_masks' wit=
h the: =20
> >>   >>> +static const unsigned long bm1390_scan_masks[] =3D {
> >>   >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0 =20
> >>
> >> things change. When I tested enabling only temperature and ran the
> >> iio_generic_buffer -c 20 -N 0 -t bm1390data-rdy-dev0 - the reported
> >> values seemed completely random. =20
> >=20
> > You need to pack the data correctly yourself in the driver.
> > So it adds small amount of code complexity but potentially saves bus
> > traffic. =20
>=20
> ...
>=20
> >>
> >> Based on this experimenting (and headache obtained from reading the
> >> demuxing code) - the IIO framework does not do channel demuxing if the
> >> 'available_scan_masks' is not given? To me this was somewhat unexpecte=
d. =20
> >=20
> > Yes.  If you don't tell it what channel setups are available (note ther=
e can
> > be lots) you are saying that we support any random combination and have
> > to do the data packing by hand.
> >  =20
>=20
> Okay... I think it kind of makes sense to leave an option where the=20
> driver can create buffer as it wants. I am not sure I can wrap my head=20
> around this to the extent that I knew when the IIO does not know what=20
> channels the driver has enabled - and thus, what types of data there=20
> will be - but I can accept the answer that such situations can exist :)=20
> Besides, allowing the driver to do the buffer formatting may allow some=20
> 'use-case specific, custom optimizations' when user-space knows what to=20
> expect (for example, regarding the data alignments and ordering to for=20
> example save space).
>=20
> ...This leads to another thing I noticed - and to another question :)
>=20
> I was experimenting with the bm1390 scan masks and iio_generic_buffer=20
> tool. It seems to me that the iio_generic_buffer does not expect the=20
> padding when the data in buffer is u32 + u16. When I enable the pressure=
=20
> (32bits) and temperature (16 bits) in bm1390 and keep the time-stamp=20
> disabled, the user-space will get buffer where 2 bytes of padding is=20
> added to each temperature sample so the next pressure sample stays=20
> correctly aligned. I believe kernel side does sane job here.
>=20
> This, however, did result (at least my version of) the=20
> iio_generic_buffer tool to read garbage values after the first sample.=20
> My assumption is that the iio_generic_buffer does not add the padding=20
> bytes to the end of last data in the scan in order to ensure also the=20
> next scan will be correctly aligned.
>=20
Ah. That's definitely possible. We've found similar problems with the logic
those example tools before and I can see that this case might not have turn=
ed
up much.

> I did following change to the iio_generic_buffer:
>=20
> Author: Matti Vaittinen <mazziesaccount@gmail.com>
> Date:   Thu Sep 21 10:15:19 2023 +0300
>=20
>      tools: iio: iio_generic_buffer ensure alignment
>=20
>      The iio_generic_buffer can return garbage values when the total size=
 of
>      scan data is not a multiple of largest element in the scan. This can=
 be
>      demonstrated by reading a scan consisting for example of one 4 byte =
and
>      one 2 byte element, where the 4 byte elemnt is first in the buffer.
>=20
>      The IIO generic buffert code does not take into accunt the last two
>      padding bytes that are needed to ensure that the 4byte data for next
>      scan is correctly aligned.
>=20
>      Add padding bytes required to align the next sample into the scan si=
ze.
>=20
>      Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>=20
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffe=
r.c
> index 44bbf80f0cfd..fc562799a109 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -54,9 +54,12 @@ enum autochan {
>   static unsigned int size_from_channelarray(struct iio_channel_info=20
> *channels, int num_channels)
>   {
>          unsigned int bytes =3D 0;
> -       int i =3D 0;
> +       int i =3D 0, max =3D 0;
> +       unsigned int misalignment;
>=20
>          while (i < num_channels) {
> +               if (channels[i].bytes > max)
> +                       max =3D channels[i].bytes;
>                  if (bytes % channels[i].bytes =3D=3D 0)
>                          channels[i].location =3D bytes;
>                  else
> @@ -66,6 +69,16 @@ static unsigned int size_from_channelarray(struct=20
> iio_channel_info *channels, in
>                  bytes =3D channels[i].location + channels[i].bytes;
>                  i++;
>          }
> +       /*
> +        * We wan't the data in next sample to also be properly aligned so
> +        * we'll add padding at the end if needed. TODO: should we use fi=
xed
> +        * 8 byte alignment instead of the size of the biggest samnple?

Nope, biggest sample is correct.

> +        */
> +       misalignment =3D bytes % max;
> +       if (misalignment) {
> +               printf("Misalignment %u. Adding Padding %u\n",=20
> misalignment,  max - misalignment);
> +               bytes +=3D max - misalignment;
> +       }
>=20
>          return bytes;
>   }
>=20
> I can send this as a proper patch if you guys think it is correct.
Please do.


>=20
>=20
> >>
> >> Finally, when the watermark IRQ is used, we can't omit reading the
> >> pressure data because clearing the WMI is done based on the pressure
> >> data in FIFO. =20
> >=20
> > Hmm. That is a good reason to keep the available scan masks set.
> > Add a comment on that next to the mask.
> >  =20
> >>
> >> So, I would propose we do:
> >>
> >> static const unsigned long bm1390_scan_masks[] =3D {
> >> 	BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP),
> >> 	BIT(BM1390_CHAN_PRESSURE), 0 =20
> >=20
> > Makes sense given need to read the pressure channel. =20
> >>
> >> which better reflects what the hardware is capable of - and, unless I =
am
> >> missing something, also allows us to offload the buffer demuxing to th=
e IIO.
> >>
> >> Still, as mentioned in 1), the
> >> =20
> >>   >>> +static const unsigned long bm1390_scan_masks[] =3D {
> >>   >>> +    BIT(BM1390_CHAN_PRESSURE) | BIT(BM1390_CHAN_TEMP), 0 =20
> >>
> >> does not seem to prevent enabling only the temperature channel - so in
> >> the driver buffer handler we still must unconditionally read the
> >> pressure data regardles the active_scan_mask. =20
> >=20
> > active_scan_mask should match the above - it's separate from what is en=
abled.
> > active_scan_mask is on the data capture side of the demux - the buffers
> > are then fed repacked data reflecting what is enabled. =20
>=20
> Cool! So, the driver can rely on IIO asking for the pressure (in=20
> active_scan_mask) after it has correctly set the available scan mask. It=
=20
> may not be a big thing but I like it. It is enough to take care of=20
> ensuring all required stuff is read from HW in one place (in available=20
> scan masks) and not to worry about it in actual data reading path but=20
> just read stuff IIO is asking to be read. I like it.
>=20
> Another thing to note is that, when we build the available_scan_mask=20
> array - we should either pay attention to the order of masks - or change=
=20
> the iio_scan_mask_match() to not accept first matching subset but to go=20
> through all of the masks unless it finds and exactly matching one (and=20
> in general prefer the smallest subset). Not sure this is worth the extra=
=20
> cycles though.

Yes, they do need to be ordered.  I'm not sure if that's clearly documented
or not :(  If not, a patch to add docs on that would be welcome.
I don't think it's worth likely complexity of finding the 'smallest match'
and that's not always obvious.  Imagine a driver that as options

[A, B, C, D] and [A, B, C, E] - how to chose?  May well be more efficient
to do one option than the other (require fewer address writes for the in
order one.  Hence order in will matter anyway so we make it matter complete=
ly
with a policy of first match.


>=20
> Thanks again - feel like I've learned something today :)
No problem.  Was quite a while ago that we figured out how to make all this
stuff work and I remember it being very fiddle.

Hohum. I should take another spin at our documentation at some point as
I'm sure some of this is less clear than it should be (or not mentioned) :)

Have a few big docs jobs to do (non IIO) at the moment so this will probably
be a 'while'.

Jonathan

>=20
> Yours,
> 	-- Matti Vaittinen
>=20

