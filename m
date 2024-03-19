Return-Path: <linux-kernel+bounces-107604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 812D487FF00
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:43:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36D80283116
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 13:43:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 632958004F;
	Tue, 19 Mar 2024 13:43:12 +0000 (UTC)
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE19F2B9A3;
	Tue, 19 Mar 2024 13:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.176.79.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710855791; cv=none; b=QElO1ro5KKjDiWOByXCa1sY5H1b5ggKK0mM/LCvR267eIPWhgwiNhF1MexdwqVCg0rL0JRKG4fNbuSmOKiqtLZgq8lRxnFhUaXhS+Cf+cD6tuitTkdqhPVrvQwKUJIcEJg72/1z/hsRW8+whK98b+pXxos9KALRGJjo1kR5WBTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710855791; c=relaxed/simple;
	bh=WiMdARSt5/lB+0Mj4JwQzBZi0dW5Rc1+tnx2BDCH/jw=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ocZ8UW2R3vj2f0ieDhnq7y76d4uguP4yNmEoLq91n4ZlpsktfKqVQPCxf+Nze1jLjIanO3fi5WkAD8m2YZFNHBUXEeLjFT6Abv3jke+Pksv76aPENA4u+uziksPJMWvEovxZ3wyzJNI4T7R66dMnKL5LkBI2It7/ZguoRFQsvgs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=185.176.79.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=Huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.18.186.231])
	by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4TzXw66VT8z67byW;
	Tue, 19 Mar 2024 21:42:30 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (unknown [7.191.163.240])
	by mail.maildlp.com (Postfix) with ESMTPS id D76BF1400D4;
	Tue, 19 Mar 2024 21:42:59 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Mar
 2024 13:42:59 +0000
Date: Tue, 19 Mar 2024 13:42:58 +0000
From: Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To: Sean Anderson <sean.anderson@linux.dev>
CC: Jonathan Cameron <jic23@kernel.org>, "O'Griofa, Conall"
	<conall.ogriofa@amd.com>, "linux-iio@vger.kernel.org"
	<linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Message-ID: <20240319134258.0000574d@Huawei.com>
In-Reply-To: <7ddf8d4a-5b68-432d-93c1-ff270403cb60@linux.dev>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
	<20240314154824.37150a54@jic23-huawei>
	<a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
	<DM6PR12MB4217EAA1049F815F234EE6D18B282@DM6PR12MB4217.namprd12.prod.outlook.com>
	<3b481539-0c9c-4110-ad03-bd252e80efb0@linux.dev>
	<20240316133627.5d2bf585@jic23-huawei>
	<7ee83f15-88fc-4530-84b7-b8ee31663dbc@linux.dev>
	<20240318152446.00001345@Huawei.com>
	<7ddf8d4a-5b68-432d-93c1-ff270403cb60@linux.dev>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: lhrpeml500003.china.huawei.com (7.191.162.67) To
 lhrpeml500005.china.huawei.com (7.191.163.240)

On Mon, 18 Mar 2024 11:28:49 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> On 3/18/24 11:24, Jonathan Cameron wrote:
> > On Mon, 18 Mar 2024 11:18:43 -0400
> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >  =20
> >> On 3/16/24 09:36, Jonathan Cameron wrote: =20
> >> > On Fri, 15 Mar 2024 13:47:40 -0400
> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >    =20
> >> >> Hi Conall,
> >> >>=20
> >> >> On 3/15/24 09:18, O'Griofa, Conall wrote:   =20
> >> >> > [AMD Official Use Only - General]
> >> >> >=20
> >> >> > Hi,
> >> >> >=20
> >> >> > I think there was a fix for this issue applied to the version tha=
t was running on 5.15 that didn't seem to make it into the upstream driver.
> >> >> > Please see link for reference https://github.com/Xilinx/linux-xln=
x/commit/608426961f16ab149b1b699f1c35f7ad244c0720
> >> >> >=20
> >> >> > I think a similar fix to the above patch is may be beneficial?   =
  =20
> >> >>=20
> >> >> These patches look functionally identical to me.   =20
> >> >=20
> >> > Because there are no channels with scan index between
> >> > 22 * 2 + 16 (that patch) and 22 * 3 (your patch) that is
> >> > the effect is indeed the same. But given the issues is the
> >> > 64 limit on maximum scan index, 22 * 3 =3D 66 is an ugly value
> >> > to compare with.
> >> >=20
> >> > I'm still very against the use of scan_index for anything other
> >> > than scan indices (which is why partly how this bug wasn't noticed
> >> > in the first palce). So the check should be scan_index !=3D -1
> >> > and uses of those values elsewhere in the driver should be fixed
> >> > (which looks simple to do from a quick glance at the code).   =20
> >>=20
> >> OK, so how do the sysfs files get named then? =20
> >=20
> > Using channel and channel2 as appropriate (+ index and modified
> > which change the meaning of channel2) - scan_index never had
> > anything to do with sysfs file names - just the value in
> > bufferX/in_xyz_scan_index =20
>=20
> I tried to prototype setting scan_index to -1, but when registering chann=
els I saw
>=20
> [    1.637049] iio iio:device0: tried to double register : in_voltage_raw
> [    1.637245] xilinx-ams ffa50000.ams: Failed to register sysfs interfac=
es
> [    1.637433] xilinx-ams: probe of ffa50000.ams failed with error -16
>=20
> And AIUI .channel is filled in by ams_parse_firmware.

Is indexed set for the channel?  Check it at the point of calling
devm_iio_device_register() as the code that builds the channels in this
driver is complex, so maybe it's getting overwritten?

There might be a core bug somewhere, but there are other drivers using
-1 scan index without hitting this problem so my first instinct is
something is getting wrongly set in the driver.

Jonathan

>=20
> --Sean
>=20
> >>=20
> >> --Sean
> >>  =20
> >> >>=20
> >> >> --Sean
> >> >>    =20
> >> >> >> -----Original Message-----
> >> >> >> From: Sean Anderson <sean.anderson@linux.dev>
> >> >> >> Sent: Thursday, March 14, 2024 5:30 PM
> >> >> >> To: Jonathan Cameron <jic23@kernel.org>
> >> >> >> Cc: linux-iio@vger.kernel.org; O'Griofa, Conall <conall.ogriofa@=
amd.com>;
> >> >> >> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.o=
rg; Lars-Peter
> >> >> >> Clausen <lars@metafoo.de>
> >> >> >> Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_cha=
nnels in
> >> >> >> scan_mask
> >> >> >>
> >> >> >> Caution: This message originated from an External Source. Use pr=
oper caution
> >> >> >> when opening attachments, clicking links, or responding.
> >> >> >>
> >> >> >>
> >> >> >> On 3/14/24 11:48, Jonathan Cameron wrote:     =20
> >> >> >> > On Mon, 11 Mar 2024 12:28:00 -0400
> >> >> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >> >> >> >     =20
> >> >> >> >> ams_enable_channel_sequence constructs a "scan_mask" for all =
the PS
> >> >> >> >> and PL channels. This works out fine, since scan_index for th=
ese
> >> >> >> >> channels is less than 64. However, it also includes the
> >> >> >> >> ams_ctrl_channels, where scan_index is greater than 64, trigg=
ering
> >> >> >> >> undefined behavior. Since we don't need these channels anyway=
, just     =20
> >> >> >> exclude them.     =20
> >> >> >> >>
> >> >> >> >> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> >> >> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>     =20
> >> >> >> >
> >> >> >> > Hi Sean,
> >> >> >> >
> >> >> >> > I'd ideally like to understand why we have channels with such =
large
> >> >> >> > scan indexes.  Those values should only be used for buffered c=
apture.
> >> >> >> > It feels like they are being abused here.  Can we set them to =
-1
> >> >> >> > instead and check based on that?
> >> >> >> > For a channel, a scan index of -1 means it can't be captured v=
ia the
> >> >> >> > buffered interfaces but only accessed via sysfs reads.
> >> >> >> > I think that's what we have here?     =20
> >> >> >>
> >> >> >> From what I can tell, none of the channels support buffered read=
s. And we can't
> >> >> >> nai=CC=88vely convert the scan_index to -1, since that causes sy=
sfs naming conflicts
> >> >> >> (not to mention the compatibility break).
> >> >> >>     =20
> >> >> >> >
> >> >> >> > I just feel like if we leave these as things stand, we will ge=
t bitten
> >> >> >> > by similar bugs in the future.  At least with -1 it should be =
obvious why!     =20
> >> >> >>
> >> >> >> There are just as likely to be bugs confusing the PL/PS subdevic=
es...
> >> >> >>
> >> >> >> FWIW I had no trouble identifying the channels involved with thi=
s bug.
> >> >> >>
> >> >> >> --Sean
> >> >> >>     =20
> >> >> >> > Jonathan
> >> >> >> >
> >> >> >> >     =20
> >> >> >> >> ---
> >> >> >> >>
> >> >> >> >>  drivers/iio/adc/xilinx-ams.c | 8 ++++++--
> >> >> >> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >> >> >> >>
> >> >> >> >> diff --git a/drivers/iio/adc/xilinx-ams.c
> >> >> >> >> b/drivers/iio/adc/xilinx-ams.c index a55396c1f8b2..4de7ce598e=
4d
> >> >> >> >> 100644
> >> >> >> >> --- a/drivers/iio/adc/xilinx-ams.c
> >> >> >> >> +++ b/drivers/iio/adc/xilinx-ams.c
> >> >> >> >> @@ -414,8 +414,12 @@ static void ams_enable_channel_sequence(=
struct
> >> >> >> >> iio_dev *indio_dev)
> >> >> >> >>
> >> >> >> >>      /* Run calibration of PS & PL as part of the sequence */
> >> >> >> >>      scan_mask =3D BIT(0) | BIT(AMS_PS_SEQ_MAX);
> >> >> >> >> -    for (i =3D 0; i < indio_dev->num_channels; i++)
> >> >> >> >> -            scan_mask |=3D BIT_ULL(indio_dev->channels[i].sc=
an_index);
> >> >> >> >> +    for (i =3D 0; i < indio_dev->num_channels; i++) {
> >> >> >> >> +            const struct iio_chan_spec *chan =3D
> >> >> >> >> + &indio_dev->channels[i];
> >> >> >> >> +
> >> >> >> >> +            if (chan->scan_index < AMS_CTRL_SEQ_BASE)
> >> >> >> >> +                    scan_mask |=3D BIT_ULL(chan->scan_index);
> >> >> >> >> +    }
> >> >> >> >>
> >> >> >> >>      if (ams->ps_base) {
> >> >> >> >>              /* put sysmon in a soft reset to change the sequ=
ence */     =20
> >> >> >> >     =20
> >> >>    =20
> >> >    =20
> >>=20
> >>  =20
> >  =20
>=20


