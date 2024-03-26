Return-Path: <linux-kernel+bounces-118918-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6CF88C137
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEAB1C3D985
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFE56CDAF;
	Tue, 26 Mar 2024 11:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ff4qgSIY"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A7F3548F0;
	Tue, 26 Mar 2024 11:49:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453766; cv=none; b=EWPEzdYIv5enwfVlbqd9epjJr/Mr7Q38LXSyeCuiGUwTVYB54qpFhDf5kb+enxAm9496zhB8igWYX75kV6L3u3SOKm+CWZQNvO4Iy36capAHoNb+PWFkVNSy7C9PaJCq3ExbZGEtdmYQarUcxLUAFso08nlNTxZ5fIfJubpXV/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453766; c=relaxed/simple;
	bh=ma57VUI0N6NfIsuEAjh7CSgl2Wttd/rBTVP3o+v5T0A=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=S1bn3vYbTsS9zzAX1C1/a3xmNfGgzAcFWVnaWw2g9+i5yr1Lvxp9E+i2M7fqXTT/TMSd3mFgTrOrUnEugGKx2h/mM8oYlhdjV2RhJWjCUcChndzD+TQ99Vpv+GicXE230I+suaIaG6vbcA8BEnNT1/hpMCluthrygwcfLMoC+Oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ff4qgSIY; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711453764; x=1742989764;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=ma57VUI0N6NfIsuEAjh7CSgl2Wttd/rBTVP3o+v5T0A=;
  b=ff4qgSIYcRiATMPUTnS+cxwTqg14ODLv7l0/hg/xefvY2m9xXGmzwASh
   RU1W2EcMlYHXwP0hIueqkII9tPNi6pr2+PCPLszMYXC5Fz4BMu+xBWLsp
   1SLpGXQ4oEVHYSHQIH2/10pEfg6IZPRabMz1j4mLQdO/5EiZTjYqChj0d
   pvkwGmjFy00/GQABqPQhR4BJ2ap2pyL0E03+URzucepKvrgCWRuj2+Al9
   nldxImIHtAnieimprF/maISy9QdusvQ7jpskcHR2qaAciXl3tgZCgz4My
   /qsciUqQzd9YcxfRLW4F4XZ/xoVRyt1K6PYHbPgs7W+zkOHuIQ9iGxFCj
   g==;
X-CSE-ConnectionGUID: IMaGeflSTlm04YzNam5Egg==
X-CSE-MsgGUID: 4Fs6VecETI2fMwfENAucmg==
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17043712"
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="17043712"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 04:49:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,156,1708416000"; 
   d="scan'208";a="16014379"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 04:49:21 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Tue, 26 Mar 2024 13:49:16 +0200 (EET)
To: Luke Jones <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/9] platform/x86: asus-wmi: add support for 2024 ROG
 Mini-LED
In-Reply-To: <9962eb39-23b8-470c-aab9-698f10c80358@app.fastmail.com>
Message-ID: <13a24576-da89-95b8-4ed2-c24b5ba54a21@linux.intel.com>
References: <20240325054938.489732-1-luke@ljones.dev> <20240325054938.489732-2-luke@ljones.dev> <2cadcf26-7b99-3b32-8441-1b3939cf93b4@linux.intel.com> <9962eb39-23b8-470c-aab9-698f10c80358@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323328-123968063-1711453452=:1084"
Content-ID: <4af481a0-3df1-fb51-9340-c76dc95d2617@linux.intel.com>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-123968063-1711453452=:1084
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: QUOTED-PRINTABLE
Content-ID: <2fe8638a-8dad-ab77-13ea-f5eb0404094e@linux.intel.com>

On Tue, 26 Mar 2024, Luke Jones wrote:
> On Tue, 26 Mar 2024, at 2:47 AM, Ilpo J=E4rvinen wrote:
> > On Mon, 25 Mar 2024, Luke D. Jones wrote:
> >=20
> > > Support the 2024 mini-led backlight and adjust the related functions
> > > to select the relevant dev-id. Also add `available_mini_led_mode` to =
the
> > > platform sysfs since the available mini-led levels can be different.
> > >=20
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > ---

> > > @@ -2109,10 +2110,27 @@ static ssize_t mini_led_mode_show(struct devi=
ce *dev,
> > >  struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > >  int result;
> > > =20
> > > - result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_MINI_L=
ED_MODE);
> > > - if (result < 0)
> > > - return result;
> > > + result =3D asus_wmi_get_devstate_simple(asus, asus->mini_led_dev_id=
);
> > > =20
> > > + /* Remap the mode values to match previous generation mini-led.
> > > + * Some BIOSes return -19 instead of 2, which is "mini-LED off", thi=
s
> > > + * appears to be a  BIOS bug.
> > > + */
> > > + if (asus->mini_led_dev_id =3D=3D ASUS_WMI_DEVID_MINI_LED_MODE2) {
> > > + switch (result) {
> > > + case 0:
> > > + result =3D 1;
> > > + break;
> > > + case 1:
> > > + result =3D 2;
> > > + break;
> > > + case 2:
> > > + case -19:
> >=20
> > Can you confirm this -19 really does come from BIOS? Because I suspect=
=20
> > it's -ENODEV error code from from one of the functions on the driver si=
de
> > (which is why I asked you to change it into -ENODEV).
>=20
> Yes it does. It is rather annoying. What happens in this case is that=20
> `2` is written to the WMI endpoint to turn off the MINI-Led feature,=20
> this works fine and it is turned off, there are no errors from the write=
=20
> at all - verifying the accepted limits in dsdt also shows it is correct.=
=20
>=20
> However, after that, the read fails once.

Hi,

I'm left a bit unsure how to interpret your response. If "read fails", it=
=20
would indicate that -ENODEV originates from asus_wmi_evaluate_method3(),=20
asus_wmi_get_devstate() or asus_wmi_get_devstate_bits(), not from BIOS? So=
=20
which way it is?

After reading some more code, I think I figured out the answer myself.
However, that raises another question... So lets now take a step back and=
=20
walk through the code:

Your patch does:
=09result =3D asus_wmi_get_devstate_simple(asus, asus->mini_led_dev_id);

asus_wmi_get_devstate_simple() calls asus_wmi_get_devstate_bits() with
ASUS_WMI_DSTS_STATUS_BIT mask that is 0x00000001.

If there's no error, retval is masked with that ASUS_WMI_DSTS_STATUS_BIT=20
forcing the return value to 0-1 range so:

a) I don't think -19 can originate from BIOS but comes from kernel side.
b) How can it ever return 2 (mini-LED off) ?????

> And only if that `2` was=20
> written. `0` and `1` write fine, and read fine also. I hope I've managed=
=20
> to describe and clarify what I'm seeing here.
>=20
> I'm happy to change -ENODEV. No problem, queued on my todo list.


--=20
 i.
--8323328-123968063-1711453452=:1084--

