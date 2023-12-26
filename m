Return-Path: <linux-kernel+bounces-11544-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 633CF81E7F8
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 16:24:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D7E51C21EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 15:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90C674F1FB;
	Tue, 26 Dec 2023 15:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M3ospDoL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31DC4E1A4;
	Tue, 26 Dec 2023 15:24:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C6FC433C8;
	Tue, 26 Dec 2023 15:24:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703604252;
	bh=VlJdIEVrGsFA0m3/i7L3Gwjmbmanh3dw9UE6fqjlmUU=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=M3ospDoLP+ury/pm0s+JReRP/vHz0o8+Vy5yQjWF8DUwsn90aC/NrG1PwcXAWqBx3
	 5iI4tlUZ+Qu79SMjuklcYr7c720Q+b/BHKns8XdDjqpTVwwCfcT96euZyY5Y4mmfGo
	 dcWp/7t4xGC2CrfJ8NcuOIJc7yu5Y8DMhjdKEi8T1tAyJuA3jkgvLWZ72Mp2TXXUD3
	 8paNLpCMv2T+XYknBGgBDXsE+CzabU1Mm1jfGtSpaK9gUsmkxr7NNAbwlX/JQxBOWd
	 oFhXhfC7SQK/usV97W12/8gj8BVfOIAPdLVoLCRQWkJ193FVIjUx8xCjOOdbR6Gk/t
	 O3Ijst5qVh4wQ==
Date: Tue, 26 Dec 2023 15:24:07 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
Cc: Hiten Chauhan <hiten.chauhan@siliconsignals.io>, "lars@metafoo.de"
 <lars@metafoo.de>, "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600
Message-ID: <20231226152407.4ed3b8e4@jic23-huawei>
In-Reply-To: <FR3P281MB1757322B2BC19434D324AB8ECE94A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
References: <20231117151446.49738-1-hiten.chauhan@siliconsignals.io>
	<FR3P281MB17576C325FD416F14DCE4B7FCEB4A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<MAXPR01MB4118176054665C88E3C6FAE7EABFA@MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM>
	<FR3P281MB1757E3C062BA1D363B6D7E80CEBDA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<MAXPR01MB41180BBF8B6743966FB0B135EA8AA@MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM>
	<FR3P281MB1757AC113CAD4072B85BB695CE8AA@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20231210112038.6c4613d3@jic23-huawei>
	<MAXPR01MB4118D846300DD45ED8866235EA90A@MAXPR01MB4118.INDPRD01.PROD.OUTLOOK.COM>
	<20231220122708.740c9ff9@jic23-huawei>
	<FR3P281MB17572C7F829D96564AE61B0DCE96A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
	<20231221104403.3680cb24@jic23-huawei>
	<FR3P281MB1757322B2BC19434D324AB8ECE94A@FR3P281MB1757.DEUP281.PROD.OUTLOOK.COM>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.38; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 22 Dec 2023 11:06:26 +0000
Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:

> Hello,
>=20
> this feature is using only accelerometer values, it is not based on a qua=
ternion (it is a low power feature, aimed at waking the device only when de=
tecting a tilt).=20

Understood.  My aim was to explain that it was a computed channel type (lik=
e a quaternion is)
rather than draw a specific connection between this case and quaternions.

> Thus in_accel_tilt would make more sense.
>=20
> But perhaps we could add a new channel of type inclination that is report=
ing only a threshold event. That would make more sense, I think.

Just because this device only has events, doesn't mean a sensible future de=
vice
wouldn't report the current value of the tilt so it has to work as a normal=
 channel
to which a threshold is applied.

It's not measuring an acceleration (though derived from one) so we can't ma=
ke
it a modified acceleration channel (as that would have units of m/s^2 which
makes no sense). So if we are using a modifier it needs to be a modified
rotation channel.

Hence suggestion of
in_rot_tilt

Units are in radians and a fixed threshold of 35/10 * M_PI should be expose=
d to
userspace, but the modifier is a bit like the ones we have for true north vs
magnetic north (and tilt compensated versions of those).  The similarity be=
ing
that in both those cases and this one we are dealing with a different
'basis' from which to compute the channel (there it's a corrective rotation
from magnetic north for the true north variants, here it's rotation change
from an initial rotation).

Hopefully that makes my thinking a little clearer. Deriving new ABI is abou=
t trying
to build something consistent across many channel types.  Not always easy t=
o do.

Jonathan

>=20
> Thanks,
> JB
>=20
>=20
> From: Jonathan Cameron <jic23@kernel.org>
> Sent: Thursday, December 21, 2023 11:44
> To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> Cc: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; lars@metafoo.de <lar=
s@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; linux=
-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600=20
> =C2=A0
> On Wed, 20 Dec 2023 13:=E2=80=8A29:=E2=80=8A49 +0000 Jean-Baptiste Maneyr=
ol <Jean-Baptiste.=E2=80=8AManeyrol@=E2=80=8Atdk.=E2=80=8Acom> wrote: > Hi =
Jonhathan, Hiten, > > I can be of some help to explain the feature. > > Thi=
s Tilt feature is the implementation of the=20
> ZjQcmQRYFpfptBannerStart
> This Message Is From an External Sender=20
> This message came from outside your organization.=20
> =C2=A0
> ZjQcmQRYFpfptBannerEnd
> On Wed, 20 Dec 2023 13:29:49 +0000
> Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
>=20
> > Hi Jonhathan, Hiten,
> >=20
> > I can be of some help to explain the feature.
> >=20
> > This Tilt feature is the implementation of the TILT_DETECTOR sensor fro=
m Android system. The angle computed is between gravity vectors. The 1st on=
e is computed as a reference when turning the feature on, and the 2nd is co=
ntinuously evaluated on a time frame. When the angle between these 2 gravit=
y vectors is large enough, a tilt event is generated.
> >=20
> > Here are the TILT_DETECTOR specs from Android system:
> >     /**
> >      * WAKE_UP_TILT_DETECTOR
> >      * reporting-mode: special (setDelay has no impact)
> >      *
> >      * A sensor of this type generates an event each time a tilt event =
is
> >      * detected. A tilt event must be generated if the direction of the
> >      * 2-seconds window average gravity changed by at least 35 degrees =
since the
> >      * activation or the last trigger of the sensor.
> >      *
> >      *  reference_estimated_gravity =3D average of accelerometer measur=
ements over
> >      *  the first 1 second after activation or the estimated gravity at=
 the last
> >      *  trigger.
> >      *
> >      *  current_estimated_gravity =3D average of accelerometer measurem=
ents over
> >      *  the last 2 seconds.
> >      *
> >      *  trigger when
> >      *     angle(reference_estimated_gravity, current_estimated_gravity)
> >      *       > 35 degrees
> >      *
> >      * Large accelerations without a change in phone orientation must n=
ot
> >      * trigger a tilt event.
> >      * For example, a sharp turn or strong acceleration while driving a=
 car
> >      * must not trigger a tilt event, even though the angle of the aver=
age
> >      * acceleration might vary by more than 35 degrees.
> >      *
> >      * Typically, this sensor is implemented with the help of only an
> >      * accelerometer. Other sensors can be used as well if they do not =
increase
> >      * the power consumption significantly. This is a low power sensor =
that
> >      * must allow the AP to go into suspend mode. Do not emulate this s=
ensor
> >      * in the HAL.
> >      * Like other wake up sensors, the driver is expected to a hold a w=
ake_lock
> >      * with a timeout of 200 ms while reporting this event. The only al=
lowed
> >      * return value is 1.0.
> >      *
> >      * Implement only the wake-up version of this sensor.
> >      */
> >=20
> >=20
> > Hope it helps to better understand. =20
>=20
> Thanks - that is indeed very useful.  A reference to this in the driver
> would be a good idea. =20
>=20
> I'm open to suggestions on how to describe this. Maybe we just need to
> use the gesture route? (I'm not keen on that unless it's the last resort
> as it provides no real grouping of channel types or expectations on scali=
ng
> etc).  Or we could use a new rotation channel modifier for 'tilt' and
> just document that as relative to a 'reference' value. Effectively treat
> it like we treat quaternions or Euler angles for rotation.  If the channel
> was exposed, we'd then support explicitly resetting it but here it is eve=
nt
> only so I suppose just using the event enable is enough.
>=20
> in_rot_tilt_*
>=20
> The averaging makes this even messier. I guess that's there to effectively
> remove the non gravity component and we should probably just not bother
> describing it.  If it is useful to do so we could add it as a form of eve=
nt
> signal filter.
>=20
> Jonathan
>=20
> >=20
> > Thanks,
> > JB
> >=20
> >=20
> > From: Jonathan Cameron <jic23@kernel.org>
> > Sent: Wednesday, December 20, 2023 13:27
> > To: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
> > Cc: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; lars@metaf=
oo.de <lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.o=
rg>; linux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> > Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600=20
> > =C2=A0
> > On Mon, 18 Dec 2023 06:=E2=80=8A36:=E2=80=8A28 +0000 Hiten Chauhan <hit=
en.=E2=80=8Achauhan@=E2=80=8Asiliconsignals.=E2=80=8Aio> wrote: > Hi Jonath=
an, > > 1. As per the datasheet for tilt interrupt, there is no direction, =
angle, or axis. Tilt only gets reported beyond 35*=20
> > ZjQcmQRYFpfptBannerStart
> > This Message Is From an External Sender=20
> > This message came from outside your organization.=20
> > =C2=A0
> > ZjQcmQRYFpfptBannerEnd
> > On Mon, 18 Dec 2023 06:36:28 +0000
> > Hiten Chauhan <hiten.chauhan@siliconsignals.io> wrote:
> >  =20
> > > Hi Jonathan,
> > >=20
> > >   1.   As per the datasheet for tilt interrupt, there is no direction=
, angle, or axis. Tilt only gets reported beyond 35* angle.   =20
> >=20
> > This can still be exposed by providing the threshold parameter but maki=
ng it
> > read only. This seems to be axis free tilt which is unusual and a bit t=
ricky
> > to define as we normally define rotations around a particular axis.
> > So whatever we do is going to be something that userspace won't really =
know
> > how to deal with. One option is to do what we allow for single axis
> > rotation sensors and have in_rot channel (no modifier) then defines eve=
nts
> > for that.
> >=20
> > Given how poorly defined this is on the datasheet I think that's the be=
st we can do.
> >=20
> > Tilt has to be relative to something, but there is no information as to=
 what. Is it
> > relative to orientation when the feature is enabled?  Is it relative to=
 some
> > reference plane?  I can't find any indication of which.
> >=20
> > Jonathan
> >=20
> >=20
> >=20
> >  =20
> > >   2.  For the userspace application what I can suggest is, that when =
tilt gets detected we can share accelerometer x,y,z as per theory(Please co=
rrect me here if I am wrong)   =20
> >=20
> >  =20
> > >   3.  In such a case, what is the recommended design?
> > >=20
> > > Thanks &Regards,
> > > Hiten Chauhan
> > > ________________________________
> > > From: Jonathan Cameron <jic23@kernel.org>
> > > Sent: Sunday, December 10, 2023 4:50 PM
> > > To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > > Cc: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; lars@metafoo.de =
<lars@metafoo.de>; linux-iio@vger.kernel.org <linux-iio@vger.kernel.org>; l=
inux-kernel@vger.kernel.org <linux-kernel@vger.kernel.org>
> > > Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600
> > >=20
> > > On Fri, 8 Dec 2023 15:37:32 +0000
> > > Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com> wrote:
> > >    =20
> > > > Hi Hiten,
> > > >
> > > > you can define property that are shared between channels by definin=
g them inside info_mask_shared_by_type or info_mask_shared_by_all filed. As=
 done for scale or for sampling_frequency.
> > > >
> > > > Thanks,
> > > > JB
> > > >
> > > >
> > > > From: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
> > > > Sent: Friday, December 8, 2023 15:14
> > > > To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@=
kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio=
@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org =
<linux-kernel@vger.kernel.org>
> > > > Cc: kernel test robot <lkp@intel.com>
> > > > Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600
> > > >
> > > > Hi Jean,
> > > >
> > > > As per your suggestions (thanks for this), I have looked into creat=
ing channels instead of custom sysfs entries.
> > > >
> > > > I have looked into an example of "mma9551.c".
> > > >
> > > > Now, by comparing the datasheet of mma9551 and inv_icm42600, in mma=
9551 they provide X, Y, and Z tilt interrupt registers.
> > > > But in the case of inv_icm42600, there is only one register to rece=
ive interrupt for tilt.     =20
> > >=20
> > > Just to check.  Can you tell which axis the tilt event was on, or is =
it simply 'tilted somehow?' From a look
> > > at the datasheet its 'tilted by 35 degrees in some direction'
> > > There are a couple of ways we can report this case if that's what you=
 have.  There is a modifier for
> > > X_OR_Y_OR_Z and we have several users already.  With hindsight that's=
 a bad design option and we should have
> > > just reported it on each axis but there is precedence for doing it wi=
th this modifier so we are stuck with that.
> > > Maybe we should consider adding an explicit X_OR_Y_OR_Z Channel that =
just has events. The risk is that
> > > existing userspace software won't expect that so might not know what =
to do.
> > >=20
> > > For event controls, it's fine if one control affects multiple events.=
  So enabling tilt_x may well enable tilt_y
> > > and tilt_z as well.  User space is meant to cope with getting events =
it didn't explicitly request.
> > >=20
> > > Jonathan
> > >    =20
> > > >
> > > > It appears hardware limitation in our case, so can you please sugge=
st here how we can overcome this?
> > > >
> > > > Appreciate your feedback.
> > > >
> > > > --
> > > > Thanks and Regards,
> > > > Hiten Chauhan
> > > >
> > > >
> > > >
> > > > From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > > > Sent: Monday, November 27, 2023 4:08 PM
> > > > To: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; jic23@kernel.o=
rg <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.ke=
rnel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>
> > > > Cc: kernel test robot <lkp@intel.com>
> > > > Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600
> > > >
> > > > Hello Hiten,
> > > >
> > > > this is more complex than that.
> > > >
> > > > First, you need to use pm_runtime functions to handle chip on/off s=
tate (you can have a look inside inv_icm42600_accel.c for direct reg access=
 how it is done).
> > > >
> > > > You cannot directly write inside PWR_MGMT0 register, otherwise you =
are overwriting sensor states. For example with your code, if the chip buff=
er is running with accel and gyro on, when turning the tilt on it will powe=
r off gyro and move accel in low-power mode. We really don't want that.
> > > >
> > > > We need to track the existing power states, and only do the require=
d changes. For that, you can use inv_icm42600_set_accel_conf() for turning =
accel on. But you will have to add support and handle correctly the INV_ICM=
42600_SENSOR_MODE_LOW_POWER sensor mode and the associated filtering (INV_I=
CM42600_FILTER_AVG_1X can be sufficient for tilt).
> > > >
> > > > This is the multiplexing I was speaking off. That's more complex th=
an it first seems. If power is not very important for you, you can simplify=
 things by just setting the accel to low-noise mode when turning it on with=
 inv_icm42600_set_accel_conf().
> > > >
> > > > For testing your tilt implementation, you need to turn it on/off wh=
ile data buffer is off and while data buffer is on, and check that it doesn=
't impact the data flow (accel and gyro have to stay turned on in low-noise=
 mode).
> > > >
> > > > Thanks.
> > > >
> > > > Best regards,
> > > > JB
> > > >
> > > > From: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
> > > > Sent: Saturday, November 25, 2023 08:05
> > > > To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@=
kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio=
@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org =
<linux-kernel@vger.kernel.org>
> > > > Cc: kernel test robot <lkp@intel.com>
> > > > Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600
> > > >
> > > > Hello Jean, Thanks for your support, For the first issue can I use =
"struct iio_event_spec" for tilt interrupt instead of a custom sysfs file? =
In the second issue I have just disabled tilt related register so when I tu=
rn tilt off other
> > > > ZjQcmQRYFpfptBannerStart
> > > > This Message Is From an External Sender
> > > > This message came from outside your organization.
> > > >
> > > > ZjQcmQRYFpfptBannerEnd
> > > > Hello Jean,
> > > >
> > > > Thanks for your support,
> > > >
> > > > For the first issue can I use "struct iio_event_spec" for tilt inte=
rrupt instead of a custom sysfs file?
> > > >
> > > > In the second issue I have just disabled tilt related register so w=
hen I turn tilt off other functionality on the accelerometer will work fine=
. can you please cross-check?
> > > >
> > > > Thanks & Regards,
> > > > Hiten Chauhan
> > > >
> > > > From: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>
> > > > Sent: Monday, November 20, 2023 7:48 PM
> > > > To: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; jic23@kernel.o=
rg <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio@vger.ke=
rnel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org <linux-k=
ernel@vger.kernel.org>
> > > > Cc: kernel test robot <lkp@intel.com>
> > > > Subject: Re: [PATCH v3] Added tilt interrupt support in inv_icm42600
> > > >
> > > > Hello Hiten,
> > > >
> > > > thanks for your patch.
> > > >
> > > > I see first a big issue at the root. Tilt event is something that s=
hould be reported as an IIO event, not in a custom sysfs file. Jonathan can=
 confirm this, but this is my understanding.
> > > >
> > > > Second issue, there is no multiplexing between the tilt and normal =
data sampling. Meaning turning tilt off will stop the data output of the ch=
ip if it was on. And turning data output off will stop tilt functionnality.=
 All these things have to be multiplexed together and chip power off/on mus=
t be centralized.
> > > >
> > > > Thanks for your work.
> > > >
> > > > Best regards,
> > > > JB
> > > >
> > > > From: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
> > > > Sent: Friday, November 17, 2023 16:14
> > > > To: Jean-Baptiste Maneyrol <Jean-Baptiste.Maneyrol@tdk.com>; jic23@=
kernel.org <jic23@kernel.org>; lars@metafoo.de <lars@metafoo.de>; linux-iio=
@vger.kernel.org <linux-iio@vger.kernel.org>; linux-kernel@vger.kernel.org =
<linux-kernel@vger.kernel.org>
> > > > Cc: Hiten Chauhan <hiten.chauhan@siliconsignals.io>; kernel test ro=
bot <lkp@intel.com>
> > > > Subject: [PATCH v3] Added tilt interrupt support in inv_icm42600
> > > >
> > > > Description: Add new device attribute to enable and disable Tilt in=
terrupt from kernel user space Signed-off-by: Hiten Chauhan <hiten.=E2=80=
=8Achauhan@=E2=80=8Asiliconsignals.=E2=80=8Aio> Reported-by: kernel test ro=
bot <lkp@=E2=80=8Aintel.=E2=80=8Acom> Closes: [[https:=E2=80=8A//urldefense=
.=E2=80=8Acom/v3/__https:=E2=80=8A//lore.=E2=80=8Akernel.=E2=80=8Aorg/oe-kb=
uild-all/202311170235.=E2=80=8AHaVJnmWa-lkp@=E2=80=8Aintel.=E2=80=8Acom/__;=
!!FtrhtPsWDhZ6tw!Abqqh_UwyEydZ0xeIy7YQwPWb_knCM2hsJJWavoAq3igeGccV4RZI87CTV=
__lZgfBjZytNesx5cUc_RXsP6mu9lmvUGZg_rGWg$[lore[.=E2=80=8A]kernel[.=E2=80=8A=
]org]]https:=E2=80=8A//urldefense.=E2=80=8Acom/v3/__https:=E2=80=8A//lore.=
=E2=80=8Akernel.=E2=80=8Aorg/oe-kbuild-all/202311170235.=E2=80=8AHaVJnmWa-l=
kp@=E2=80=8Aintel.=E2=80=8Acom/__;!!FtrhtPsWDhZ6tw!Abqqh_UwyEydZ0xeIy7YQwPW=
b_knCM2hsJJWavoAq3igeGccV4RZI87CTV__lZgfBjZytNesx5cUc_RXsP6mu9lmvUGZg_rGWg$=
[lore[.=E2=80=8A]kernel[.=E2=80=8A]org]https:=E2=80=8A//urldefense.=E2=80=
=8Acom/v3/__https:=E2=80=8A//lore.=E2=80=8Akernel.=E2=80=8Aorg/oe-kbuild-al=
l/202311170235.=E2=80=8AHaVJnmWa-lkp@=E2=80=8Aintel.=E2=80=8Acom/__;!!Ftrht=
PsWDhZ6tw!Abqqh_UwyEydZ0xeIy7YQwPWb_knCM2hsJJWavoAq3igeGccV4RZI87CTV__lZgfB=
jZytNesx5cUc_RXsP6mu9lmvUGZg_rGWg$[lore[.=E2=80=8A]kernel[.=E2=80=8A]org]]h=
ttps:=E2=80=8A//urldefense.=E2=80=8Acom/v3/__https:=E2=80=8A//lore.=E2=80=
=8Akernel.=E2=80=8Aorg/oe-kbuild-all/202311170235.=E2=80=8AHaVJnmWa-lkp@=E2=
=80=8Aintel.=E2=80=8Acom/__;!!FtrhtPsWDhZ6tw!Abqqh_UwyEydZ0xeIy7YQwPWb_knCM=
2hsJJWavoAq3igeGccV4RZI87CTV__lZgfBjZytNesx5cUc_RXsP6mu9lmvUGZg_rGWg$[lore[=
.=E2=80=8A]kernel[.=E2=80=8A]org]
> > > > ZjQcmQRYFpfptBannerStart
> > > > This Message Is From an Untrusted Sender
> > > > You have not previously corresponded with this sender.
> > > >
> > > > ZjQcmQRYFpfptBannerEnd
> > > > Description:
> > > > Add new device attribute to enable and disable
> > > > Tilt interrupt from kernel user space
> > > >
> > > > Signed-off-by: Hiten Chauhan <hiten.chauhan@siliconsignals.io>
> > > >
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > > Closes: https://urldefense.com/v3/__https://lore.kernel.org/oe-kbui=
ld-all/202311170235.HaVJnmWa-lkp@intel.com/__;!!FtrhtPsWDhZ6tw!Abqqh_UwyEyd=
Z0xeIy7YQwPWb_knCM2hsJJWavoAq3igeGccV4RZI87CTV__lZgfBjZytNesx5cUc_RXsP6mu9l=
mvUGZg_rGWg$[lore[.]kernel[.]org]
> >>> ---
> > > >  drivers/iio/imu/inv_icm42600/inv_icm42600.h   |  24 ++++
> > > >  .../iio/imu/inv_icm42600/inv_icm42600_accel.c | 129 ++++++++++++++=
++++
> > > >  2 files changed, 153 insertions(+)
> > > >
> > > > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600.h b/drivers/=
iio/imu/inv_icm42600/inv_icm42600.h
> > > > index 0e290c807b0f..39ed39e77deb 100644
> > > > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > > > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600.h
> > > > @@ -187,6 +187,8 @@ struct inv_icm42600_state {
> > > >  #define INV_ICM42600_FIFO_CONFIG_STOP_ON_FULL           \
> > > >                  FIELD_PREP(INV_ICM42600_FIFO_CONFIG_MASK, 2)
> > > >
> > > > +#define INV_ICM42600_REG_MASK        GENMASK(7, 0)
> > > > +
> > > >  /* all sensor data are 16 bits (2 registers wide) in big-endian */
> > > >  #define INV_ICM42600_REG_TEMP_DATA                      0x001D
> > > >  #define INV_ICM42600_REG_ACCEL_DATA_X                   0x001F
> > > > @@ -239,6 +241,7 @@ struct inv_icm42600_state {
> > > >  #define INV_ICM42600_REG_PWR_MGMT0                      0x004E
> > > >  #define INV_ICM42600_PWR_MGMT0_TEMP_DIS                 BIT(5)
> > > >  #define INV_ICM42600_PWR_MGMT0_IDLE                     BIT(4)
> > > > +#define INV_ICM42600_PWR_ACCEL_MODE                    BIT(1)
> > > >  #define INV_ICM42600_PWR_MGMT0_GYRO(_mode)              \
> > > >                  FIELD_PREP(GENMASK(3, 2), (_mode))
> > > >  #define INV_ICM42600_PWR_MGMT0_ACCEL(_mode)             \
> > > > @@ -306,6 +309,21 @@ struct inv_icm42600_state {
> > > >  #define INV_ICM42600_WHOAMI_ICM42622                    0x46
> > > >  #define INV_ICM42600_WHOAMI_ICM42631                    0x5C
> > > >
> > > > +/* Register configs for tilt interrupt */
> > > > +#define INV_ICM42605_REG_APEX_CONFIG4                  0x4043
> > > > +#define INV_ICM42605_APEX_CONFIG4_MASK                 GENMASK(7, =
0)
> > > > +
> > > > +#define INV_ICM42605_REG_APEX_CONFIG0                  0x0056
> > > > +#define INV_ICM42605_APEX_CONFIG0_TILT_ENABLE          BIT(4)
> > > > +#define INV_ICM42605_APEX_CONFIG0                      BIT(1)
> > > > +
> > > > +#define INV_ICM42605_REG_INTF_CONFIG1                   0x404D
> > > > +#define INV_ICM42605_INTF_CONFIG1_MASK                  GENMASK(5,=
 0)
> > > > +#define INV_ICM42605_INTF_CONFIG1_TILT_DET_INT1_EN      BIT(3)
> > > > +
> > > > +#define INV_ICM42605_REG_INT_STATUS3                   0x0038
> > > > +
> > > > +
> > > >  /* User bank 1 (MSB 0x10) */
> > > >  #define INV_ICM42600_REG_SENSOR_CONFIG0                 0x1003
> > > >  #define INV_ICM42600_SENSOR_CONFIG0_ZG_DISABLE          BIT(5)
> > > > @@ -364,6 +382,8 @@ typedef int (*inv_icm42600_bus_setup)(struct in=
v_icm42600_state *);
> > > >  extern const struct regmap_config inv_icm42600_regmap_config;
> > > >  extern const struct dev_pm_ops inv_icm42600_pm_ops;
> > > >
> > > > +extern uint8_t inv_icm42605_int_reg;
> > > > +
> > > >  const struct iio_mount_matrix *
> > > >  inv_icm42600_get_mount_matrix(const struct iio_dev *indio_dev,
> > > >                                const struct iio_chan_spec *chan);
> > > > @@ -395,4 +415,8 @@ struct iio_dev *inv_icm42600_accel_init(struct =
inv_icm42600_state *st);
> > > >
> > > >  int inv_icm42600_accel_parse_fifo(struct iio_dev *indio_dev);
> > > >
> > > > +int inv_icm42605_generate_tilt_interrupt(struct inv_icm42600_state=
 *st);
> > > > +
> > > > +int inv_icm42605_disable_tilt_interrupt(struct inv_icm42600_state =
*st);
> > > > +
> > > >  #endif
> > > > diff --git a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c b/dr=
ivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > > > index b1e4fde27d25..311f6ea09e64 100644
> > > > --- a/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > > > +++ b/drivers/iio/imu/inv_icm42600/inv_icm42600_accel.c
> > > > @@ -47,6 +47,8 @@
> > > >                  .ext_info =3D _ext_info,                          =
        \
> > > >          }
> > > >
> > > > +uint8_t inv_icm42605_int_reg;
> > > > +
> > > >  enum inv_icm42600_accel_scan {
> > > >          INV_ICM42600_ACCEL_SCAN_X,
> > > >          INV_ICM42600_ACCEL_SCAN_Y,
> > > > @@ -60,6 +62,68 @@ static const struct iio_chan_spec_ext_info inv_i=
cm42600_accel_ext_infos[] =3D {
> > > >          {},
> > > >  };
> > > >
> > > > +static ssize_t tilt_interrupt_show(struct device *dev,
> > > > +                              struct device_attribute *attr, char =
*buf)
> > > > +{
> > > > +       struct inv_icm42600_state *st =3D dev_get_drvdata(dev);
> > > > +       unsigned int val;
> > > > +       int ret;
> > > > +
> > > > +       ret =3D regmap_read(st->map, inv_icm42605_int_reg, &val);
> > > > +
> > > > +       if (ret !=3D 0)
> > > > +               return ret;
> > > > +
> > > > +       snprintf(buf, PAGE_SIZE, "Read reg %x value %x\n", inv_icm4=
2605_int_reg, val);
> > > > +
> > > > +       return strlen(buf);
> > > > +}
> > > > +
> > > > +static ssize_t tilt_interrupt_store(struct device *dev,
> > > > +               struct device_attribute *attr, const char *buf,
> > > > +               size_t count)
> > > > +{
> > > > +       struct inv_icm42600_state *st =3D dev_get_drvdata(dev);
> > > > +       int ret;
> > > > +       int value;
> > > > +
> > > > +       if (!st)
> > > > +               return -EINVAL;
> > > > +
> > > > +       if (kstrtoint(buf, 10, &value))
> > > > +               return -EINVAL;
> > > > +
> > > > +       inv_icm42605_int_reg =3D INV_ICM42605_REG_INT_STATUS3;
> > > > +
> > > > +       switch (value) {
> > > > +       case 1:
> > > > +               ret =3D inv_icm42605_generate_tilt_interrupt(st);
> > > > +               if (ret !=3D 0)
> > > > +                       return -EIO;
> > > > +               break;
> > > > +       case 0:
> > > > +               ret =3D inv_icm42605_disable_tilt_interrupt(st);
> > > > +               if (ret !=3D 0)
> > > > +                       return -EIO;
> > > > +               break;
> > > > +       default:
> > > > +               return -EINVAL;
> > > > +       }
> > > > +
> > > > +       return count;
> > > > +}
> > > > +
> > > > +static DEVICE_ATTR_RW(tilt_interrupt);
> > > > +
> > > > +static struct attribute *icm42605_attrs[] =3D {
> > > > +       &dev_attr_tilt_interrupt.attr,
> > > > +       NULL,
> > > > +};
> > > > +
> > > > +static const struct attribute_group icm42605_attrs_group =3D {
> > > > +       .attrs =3D icm42605_attrs,
> > > > +};
> > > > +
> > > >  static const struct iio_chan_spec inv_icm42600_accel_channels[] =
=3D {
> > > >          INV_ICM42600_ACCEL_CHAN(IIO_MOD_X, INV_ICM42600_ACCEL_SCAN=
_X,
> > > >                                  inv_icm42600_accel_ext_infos),
> > > > @@ -702,6 +766,7 @@ static const struct iio_info inv_icm42600_accel=
_info =3D {
> > > >          .update_scan_mode =3D inv_icm42600_accel_update_scan_mode,
> > > >          .hwfifo_set_watermark =3D inv_icm42600_accel_hwfifo_set_wa=
termark,
> > > >          .hwfifo_flush_to_buffer =3D inv_icm42600_accel_hwfifo_flus=
h,
> > > > +       .attrs =3D &icm42605_attrs_group,
> > > >  };
> > > >
> > > >  struct iio_dev *inv_icm42600_accel_init(struct inv_icm42600_state =
*st)
> > > > @@ -791,3 +856,67 @@ int inv_icm42600_accel_parse_fifo(struct iio_d=
ev *indio_dev)
> > > >
> > > >          return 0;
> > > >  }
> > > > +
> > > > +int inv_icm42605_generate_tilt_interrupt(struct inv_icm42600_state=
 *st)
> > > > +{
> > > > +       int ret;
> > > > +       int val;
> > > > +       char sleep =3D 10;
> > > > +
> > > > +       ret =3D regmap_update_bits(st->map, INV_ICM42605_REG_APEX_C=
ONFIG4,
> > > > +                                INV_ICM42605_APEX_CONFIG4_MASK, 0);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       val =3D INV_ICM42600_PWR_ACCEL_MODE;
> > > > +       ret =3D regmap_write(st->map, INV_ICM42600_REG_PWR_MGMT0, v=
al);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       val =3D INV_ICM42605_APEX_CONFIG0;
> > > > +       ret =3D regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0=
, val);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       val =3D INV_ICM42600_SIGNAL_PATH_RESET_DMP_MEM_RESET;
> > > > +       ret =3D regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_=
RESET, val);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       msleep(sleep);
> > > > +
> > > > +       val =3D INV_ICM42600_SIGNAL_PATH_RESET_DMP_INIT_EN;
> > > > +       ret =3D regmap_write(st->map, INV_ICM42600_REG_SIGNAL_PATH_=
RESET, val);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       val =3D INV_ICM42605_APEX_CONFIG0_TILT_ENABLE |
> > > > +             INV_ICM42605_APEX_CONFIG0;
> > > > +       ret =3D regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0=
, val);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       ret =3D regmap_update_bits(st->map, INV_ICM42605_REG_INTF_C=
ONFIG1,
> > > > +                                INV_ICM42605_INTF_CONFIG1_MASK,
> > > > +                                INV_ICM42605_INTF_CONFIG1_TILT_DET=
_INT1_EN);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       return 0;
> > > > +}
> > > > +
> > > > +int inv_icm42605_disable_tilt_interrupt(struct inv_icm42600_state =
*st)
> > > > +{
> > > > +       int ret;
> > > > +
> > > > +       ret =3D regmap_write(st->map, INV_ICM42605_REG_APEX_CONFIG0=
, 0);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       ret =3D regmap_update_bits(st->map, INV_ICM42605_REG_INTF_C=
ONFIG1,
> > > > +                       INV_ICM42605_INTF_CONFIG1_MASK, 0);
> > > > +       if (ret)
> > > > +               return ret;
> > > > +
> > > > +       return 0;
> > > > +}
> > > >
> > > > base-commit: b85ea95d086471afb4ad062012a4d73cd328fa86     =20
> > >    =20
> >  =20
>=20


