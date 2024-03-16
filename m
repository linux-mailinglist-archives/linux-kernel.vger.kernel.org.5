Return-Path: <linux-kernel+bounces-105187-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D604887DA4C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 14:36:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56AD4B2133D
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 13:36:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B6918C1A;
	Sat, 16 Mar 2024 13:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PO0TnXNO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57082F4A;
	Sat, 16 Mar 2024 13:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710596202; cv=none; b=DqzD1syLxEC0lxvjWcmi21c3cbxwMtITEDa1CJ0JSWOY1NcmNRW1RdVU75UPcHmYmTx+ajMLIpQ64GndGfZ9CZxKX1/OCSJuWAl2sxeY86xnfzxLMYFlDt8XBluFbwJdajOYa1Vs45S0hZRvaUPfvwEVx8/arTltF1k2IlOnspk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710596202; c=relaxed/simple;
	bh=XdPZXsL26Mxip3HHx+7NpZ0egkvJ9o2OTxsp0p3pia0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GkTEBzOZLNbYXGbBlofyTL6c/FmznHsBvlQHxJM4W/GHwYDPexCYoOthu6c64PbQB02AzAaG9aBIRJS8nNUysswTd6xeD4WnhseerOq3o2G9ysRM1u+W++owD3gcKAEMOpsoH+dYtevbE5BNKETxie5NLO5Xyt4VSdK58AJSkWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PO0TnXNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C9CC433F1;
	Sat, 16 Mar 2024 13:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710596202;
	bh=XdPZXsL26Mxip3HHx+7NpZ0egkvJ9o2OTxsp0p3pia0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PO0TnXNOGamjsfEbRH6yEFyRPVD8RjF2gBrc8MCuTjX/19Iec1G3oDKOTADkQ6JbF
	 hvs/YoBB0J5dU2Swq4I4wb4a3LmIwn3n50IsHVK5Dc2z2r7mZjUxSPfeYADMOuxli9
	 8NbBW2cLqq8M0gffAXC1i7JZS5fPzpbJqFXyiwZAzPGtgDjWtKtbt+JUYkL2G6GdgO
	 W0GoWLgEYUptw8RLHEve+Jgk1KAZDI+HK1RImUJOZuZXUsLS09ICXtBLLeZxBMlJOj
	 IrmzUGewQ6AFLe/Zw5+Ng7AwnBYr9flOS/jlrkfYkV0qsJuKx8zxyKy7bZkmtniAWC
	 tRD9eBkMqTZfg==
Date: Sat, 16 Mar 2024 13:36:27 +0000
From: Jonathan Cameron <jic23@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: "O'Griofa, Conall" <conall.ogriofa@amd.com>, "linux-iio@vger.kernel.org"
 <linux-iio@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels in
 scan_mask
Message-ID: <20240316133627.5d2bf585@jic23-huawei>
In-Reply-To: <3b481539-0c9c-4110-ad03-bd252e80efb0@linux.dev>
References: <20240311162800.11074-1-sean.anderson@linux.dev>
	<20240314154824.37150a54@jic23-huawei>
	<a9ed95ec-aafe-49f6-93dd-c94c73620de2@linux.dev>
	<DM6PR12MB4217EAA1049F815F234EE6D18B282@DM6PR12MB4217.namprd12.prod.outlook.com>
	<3b481539-0c9c-4110-ad03-bd252e80efb0@linux.dev>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 15 Mar 2024 13:47:40 -0400
Sean Anderson <sean.anderson@linux.dev> wrote:

> Hi Conall,
>=20
> On 3/15/24 09:18, O'Griofa, Conall wrote:
> > [AMD Official Use Only - General]
> >=20
> > Hi,
> >=20
> > I think there was a fix for this issue applied to the version that was =
running on 5.15 that didn't seem to make it into the upstream driver.
> > Please see link for reference https://github.com/Xilinx/linux-xlnx/comm=
it/608426961f16ab149b1b699f1c35f7ad244c0720
> >=20
> > I think a similar fix to the above patch is may be beneficial? =20
>=20
> These patches look functionally identical to me.

Because there are no channels with scan index between
22 * 2 + 16 (that patch) and 22 * 3 (your patch) that is
the effect is indeed the same. But given the issues is the
64 limit on maximum scan index, 22 * 3 =3D 66 is an ugly value
to compare with.

I'm still very against the use of scan_index for anything other
than scan indices (which is why partly how this bug wasn't noticed
in the first palce). So the check should be scan_index !=3D -1
and uses of those values elsewhere in the driver should be fixed
(which looks simple to do from a quick glance at the code).

Jonathan


>=20
> --Sean
>=20
> >> -----Original Message-----
> >> From: Sean Anderson <sean.anderson@linux.dev>
> >> Sent: Thursday, March 14, 2024 5:30 PM
> >> To: Jonathan Cameron <jic23@kernel.org>
> >> Cc: linux-iio@vger.kernel.org; O'Griofa, Conall <conall.ogriofa@amd.co=
m>;
> >> linux-arm-kernel@lists.infradead.org; linux-kernel@vger.kernel.org; La=
rs-Peter
> >> Clausen <lars@metafoo.de>
> >> Subject: Re: [PATCH] iio: xilinx-ams: Don't include ams_ctrl_channels =
in
> >> scan_mask
> >>
> >> Caution: This message originated from an External Source. Use proper c=
aution
> >> when opening attachments, clicking links, or responding.
> >>
> >>
> >> On 3/14/24 11:48, Jonathan Cameron wrote: =20
> >> > On Mon, 11 Mar 2024 12:28:00 -0400
> >> > Sean Anderson <sean.anderson@linux.dev> wrote:
> >> > =20
> >> >> ams_enable_channel_sequence constructs a "scan_mask" for all the PS
> >> >> and PL channels. This works out fine, since scan_index for these
> >> >> channels is less than 64. However, it also includes the
> >> >> ams_ctrl_channels, where scan_index is greater than 64, triggering
> >> >> undefined behavior. Since we don't need these channels anyway, just=
 =20
> >> exclude them. =20
> >> >>
> >> >> Fixes: d5c70627a794 ("iio: adc: Add Xilinx AMS driver")
> >> >> Signed-off-by: Sean Anderson <sean.anderson@linux.dev> =20
> >> >
> >> > Hi Sean,
> >> >
> >> > I'd ideally like to understand why we have channels with such large
> >> > scan indexes.  Those values should only be used for buffered capture.
> >> > It feels like they are being abused here.  Can we set them to -1
> >> > instead and check based on that?
> >> > For a channel, a scan index of -1 means it can't be captured via the
> >> > buffered interfaces but only accessed via sysfs reads.
> >> > I think that's what we have here? =20
> >>
> >> From what I can tell, none of the channels support buffered reads. And=
 we can't
> >> nai=CC=88vely convert the scan_index to -1, since that causes sysfs na=
ming conflicts
> >> (not to mention the compatibility break).
> >> =20
> >> >
> >> > I just feel like if we leave these as things stand, we will get bitt=
en
> >> > by similar bugs in the future.  At least with -1 it should be obviou=
s why! =20
> >>
> >> There are just as likely to be bugs confusing the PL/PS subdevices...
> >>
> >> FWIW I had no trouble identifying the channels involved with this bug.
> >>
> >> --Sean
> >> =20
> >> > Jonathan
> >> >
> >> > =20
> >> >> ---
> >> >>
> >> >>  drivers/iio/adc/xilinx-ams.c | 8 ++++++--
> >> >>  1 file changed, 6 insertions(+), 2 deletions(-)
> >> >>
> >> >> diff --git a/drivers/iio/adc/xilinx-ams.c
> >> >> b/drivers/iio/adc/xilinx-ams.c index a55396c1f8b2..4de7ce598e4d
> >> >> 100644
> >> >> --- a/drivers/iio/adc/xilinx-ams.c
> >> >> +++ b/drivers/iio/adc/xilinx-ams.c
> >> >> @@ -414,8 +414,12 @@ static void ams_enable_channel_sequence(struct
> >> >> iio_dev *indio_dev)
> >> >>
> >> >>      /* Run calibration of PS & PL as part of the sequence */
> >> >>      scan_mask =3D BIT(0) | BIT(AMS_PS_SEQ_MAX);
> >> >> -    for (i =3D 0; i < indio_dev->num_channels; i++)
> >> >> -            scan_mask |=3D BIT_ULL(indio_dev->channels[i].scan_ind=
ex);
> >> >> +    for (i =3D 0; i < indio_dev->num_channels; i++) {
> >> >> +            const struct iio_chan_spec *chan =3D
> >> >> + &indio_dev->channels[i];
> >> >> +
> >> >> +            if (chan->scan_index < AMS_CTRL_SEQ_BASE)
> >> >> +                    scan_mask |=3D BIT_ULL(chan->scan_index);
> >> >> +    }
> >> >>
> >> >>      if (ams->ps_base) {
> >> >>              /* put sysmon in a soft reset to change the sequence *=
/ =20
> >> > =20
>=20


