Return-Path: <linux-kernel+bounces-108886-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6438B881160
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 12:56:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950D91C228B4
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC0B3EA9C;
	Wed, 20 Mar 2024 11:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MVGXaG9W"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F32628D;
	Wed, 20 Mar 2024 11:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710935761; cv=none; b=hu9ccVhD5oWu+d8REHkNkudlTPXfW/41sPUdxlO1J3CrTVpVCLNvOG749eQ5zrYHMalz12qRfu63CTyHYwsSWD7FWbGPfbeROHZKDOTduop7wcqiUnhrABJZKMqQe2dptFwLEpiYpv2Jq+2KqSOSH3QEbnCGMK0P+4Fw3oi/4mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710935761; c=relaxed/simple;
	bh=q8QhaNhNNYX8Elx4g8xFrYMI0TdoKH97Luxe5R3MT/4=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=sAcsIF5oWhI23KIM8muiY8NvFzetxQrdPr+u16dkpheqTwcJN0+DIFB5Pgol1LRUzygdniI9XV2FeGQn95m4+STL7+nhZzhWzr0V0y+bUQc0v7rMov3Nuwl5bfUicv5I5gwpdCU2e+XKv1b1Y0cXd18gq7HB5JPq2RkV/WXzW7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MVGXaG9W; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710935759; x=1742471759;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=q8QhaNhNNYX8Elx4g8xFrYMI0TdoKH97Luxe5R3MT/4=;
  b=MVGXaG9Wn8oPH1rMbKrMDWD7BsX3Lzo3xoD4lMp+MTL8fa1BR/SdZ4XC
   4tz5KpeAHPpf+oKNbvGpidfznANO+yPIn24n7OFyKAdQ3213bY3luMuSF
   FRj9/VHqSeL+FCGvqoxsXtocEaLPTFMw8L2qdMYokK7c5JbdoX8/Sr0BQ
   HkpXbERDmJus04pVrQhvi6361G9IKgbgcDFBO1q19fo9uy9uymRIKOHGP
   HKFhkPyAtIA1RBbIAv8U3JpLq0fAWny/dhANw5WdmXvu7KRPrNxQSkXEr
   OHHQQbOHBpM6c2AAnzjNlYs2brPxVN1rWQR+LgqkabUxBF/I0MZLboIE2
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="17258357"
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="17258357"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:55:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,140,1708416000"; 
   d="scan'208";a="14109562"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.16])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Mar 2024 04:55:56 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 20 Mar 2024 13:55:52 +0200 (EET)
To: Luke Jones <luke@ljones.dev>
cc: platform-driver-x86@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] platform/x86: asus-wmi: support toggling POST sound
In-Reply-To: <7276ec7b-9b00-4241-a4eb-a8997daeba5c@app.fastmail.com>
Message-ID: <bdcc3052-1403-8c2f-f703-66180394c461@linux.intel.com>
References: <20240310061715.16531-1-luke@ljones.dev> <5f853562-cbe0-32d7-2644-d42d2bb9e060@linux.intel.com> <7276ec7b-9b00-4241-a4eb-a8997daeba5c@app.fastmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-1644597700-1710935752=:1037"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-1644597700-1710935752=:1037
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 20 Mar 2024, Luke Jones wrote:
> On Wed, 20 Mar 2024, at 6:48 AM, Ilpo J=C3=A4rvinen wrote:
> > On Sun, 10 Mar 2024, Luke D. Jones wrote:
> >=20
> > > Add support for toggling the BIOS POST sound on some ASUS laptops.
> > >=20
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > ---
> > >  .../ABI/testing/sysfs-platform-asus-wmi       |  7 +++
> > >  drivers/platform/x86/asus-wmi.c               | 54 +++++++++++++++++=
++
> > >  include/linux/platform_data/x86/asus-wmi.h    |  3 ++
> > >  3 files changed, 64 insertions(+)
> > >=20
> > > diff --git a/Documentation/ABI/testing/sysfs-platform-asus-wmi b/Docu=
mentation/ABI/testing/sysfs-platform-asus-wmi
> > > index e32b4f0ae15f..f3c53b7453f0 100644
> > > --- a/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > > +++ b/Documentation/ABI/testing/sysfs-platform-asus-wmi
> > > @@ -194,3 +194,10 @@ Contact: "Luke Jones" <luke@ljones.dev>
> > >  Description:
> > >  Set the target temperature limit of the Nvidia dGPU:
> > >  * min=3D75, max=3D87
> > > +
> > > +What: /sys/devices/platform/<platform>/boot_sound
> > > +Date: Jun 2023
> > > +KernelVersion: 6.9
> > > +Contact: "Luke Jones" <luke@ljones.dev>
> > > +Description:
> > > + Set if the BIOS POST sound is played on boot.

> > > @@ -2106,6 +2107,55 @@ static ssize_t panel_od_store(struct device *d=
ev,
> > >  }
> > >  static DEVICE_ATTR_RW(panel_od);
> > > =20
> > > +/* Bootup sound ****************************************************=
***********/
> > > +
> > > +static ssize_t boot_sound_show(struct device *dev,
> > > +      struct device_attribute *attr, char *buf)
> > > +{
> > > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > > + int result;
> > > +
> > > + result =3D asus_wmi_get_devstate_simple(asus, ASUS_WMI_DEVID_BOOT_S=
OUND);
> > > + if (result < 0)
> > > + return result;
> > > +
> > > + return sysfs_emit(buf, "%d\n", result);
> > > +}
> > > +
> > > +static ssize_t boot_sound_store(struct device *dev,
> > > +       struct device_attribute *attr,
> > > +       const char *buf, size_t count)
> > > +{
> > > + int result, err;
> > > + u32 snd;
> > > +
> > > + struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > > +
> > > + result =3D kstrtou32(buf, 10, &snd);
> > > + if (result)
> > > + return result;
> > > +
> > > + if (snd > 1)
> > > + return -EINVAL;
> >=20
> > Why not just use kstrtobool()?
>=20
> Consistency with other methods mostly. Plus the possibility that asus=20
> might do something like add different sounds. I'll change it if a revert=
=20
> back to kstrtou32 later doesn't break things.

Hi Luke,

I'd tend to think it's not the most likely scenario. But if they still do=
=20
something like that, the code could do both kstrtou32() and kstrtobool()=20
to keep the sysfs interface backwards compatible.

But it isn't end of the world for me if you want to keep it as=20
kstrtou32().

Annoyingly the other kstrtou32()s may not be easily converted over to=20
kstrtobool() because u32 formatting accepts 16-based values too such as
0x0. Perhaps hex format wouldn't be used by anyone but the risk is still=20
there and the benefits are not that high.


--=20
 i.

--8323328-1644597700-1710935752=:1037--

