Return-Path: <linux-kernel+bounces-129320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0808C89688D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:27:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6FC9289F59
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:27:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B336EB73;
	Wed,  3 Apr 2024 08:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="PrynK8X/"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4DF6EB4C;
	Wed,  3 Apr 2024 08:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132470; cv=none; b=t+IkVuPtfLxam62wZxn1i1EkEpg4EXoIoIJJ2Srva06NqPW3FRBtwZxiVwty1p/2hYB2Fxp0/8jZfteE5Gkvbe7r03HnbAWug0ho3KhxmNUfT6hcbHAYQsq9BnfLEriVnF4gyZ1G7Pn0ZB6xrkbpcshgzyk86/V6RIFeEzQYDKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132470; c=relaxed/simple;
	bh=2ymn81XuhMJBQNb1n7q7kDeZWjVqWfG2FeFn4C7QNh8=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=cx8IKUqyu186SXR3YT/2wvyQuFQA/+ufpG/FUqYe8uFKa4+iG30kIYce17GUbq7u26a7+ln3sTCie5XrTBPwXJxlg0h/MIs5TsRXIvS/8xvh28cjY967gGlZs4ckGIVDIe8Mrjk9VjeJr2qrh20o1uLO6kXnonh0owF+I0Nad2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=PrynK8X/; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712132470; x=1743668470;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=2ymn81XuhMJBQNb1n7q7kDeZWjVqWfG2FeFn4C7QNh8=;
  b=PrynK8X/iczD1rrA3w3xb44acQCKVsJptJIHe6IpkIeDCSKt0PBr6bDu
   AvebJHOSVonSScNYSP7DBso8R8jpHtXkff0UyRi+tLr1lg4HCnPpaOKIm
   mvOqQ5OAeRlTNTQ0FA/Z4l0aqpqvnlB9VypVifOVOXf3K0TmpkiHKZ120
   OI6X3Z34H8uzDSx4VL4htxxKJp4a+NTqNZwQiLRtPuJ3Zy2hpYJOidh9h
   D1loB0o1CYtgylI+KNgANhHBOkwB2LP93nvUewsLJwkDEwjY2YwEBz1tF
   eB9bbesk0iZ+Rr2EEaMzxKe642aynsifNpOtdQgji0+x5+sS6HmkF0qlv
   A==;
X-CSE-ConnectionGUID: xULLFY75RNq07h6zp9yYgA==
X-CSE-MsgGUID: +279yEJIRWSgoFh/w5MapQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11032"; a="29826699"
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="29826699"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:21:09 -0700
X-CSE-ConnectionGUID: Jmmd9za4RQi0EK94ZoYXGg==
X-CSE-MsgGUID: OFX3mc4OTUOBOoo7FnJ+lg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,176,1708416000"; 
   d="scan'208";a="55795064"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.245.247.24])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Apr 2024 01:21:06 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Wed, 3 Apr 2024 11:21:02 +0300 (EEST)
To: Luke Jones <luke@ljones.dev>
cc: Hans de Goede <hdegoede@redhat.com>, corentin.chary@gmail.com, 
    platform-driver-x86@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 5/9] platform/x86: asus-wmi: store a min default for
 ppt options
In-Reply-To: <4555327.yiUUSuA9gR@fedora>
Message-ID: <678014c5-5d2d-7128-88ea-c71a71410dd3@linux.intel.com>
References: <20240402022607.34625-1-luke@ljones.dev> <20240402022607.34625-6-luke@ljones.dev> <89b0c0ea-30ce-28c6-19d2-ebd113b17935@linux.intel.com> <4555327.yiUUSuA9gR@fedora>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-667445792-1712132462=:1449"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-667445792-1712132462=:1449
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 3 Apr 2024, Luke Jones wrote:

> On Tuesday, 2 April 2024 11:49:50=E2=80=AFPM NZDT Ilpo J=C3=A4rvinen wrot=
e:
> > On Tue, 2 Apr 2024, Luke D. Jones wrote:
> > > Laptops with any of the ppt or nv tunables default to the minimum set=
ting
> > > on boot so we can safely assume a stored value is correct.
> > >=20
> > > This patch adds storing of those values in the local struct, and enab=
les
> > > reading of those values back. To prevent creating a series of byte ho=
les
> > > in the struct the "<name>_available" bool is removed and
> > > `asus_sysfs_is_visible()` uses the `ASUS_WMI_DEVID_<name>` directly.
> > >=20
> > > Signed-off-by: Luke D. Jones <luke@ljones.dev>
> > > ---
> > >=20
> > >  drivers/platform/x86/asus-wmi.c | 127 +++++++++++++++++++++++++-----=
--
> > >  1 file changed, 99 insertions(+), 28 deletions(-)
> > >=20
> > > diff --git a/drivers/platform/x86/asus-wmi.c
> > > b/drivers/platform/x86/asus-wmi.c index b795f9c1941f..c80afa385532 10=
0644
> > > --- a/drivers/platform/x86/asus-wmi.c
> > > +++ b/drivers/platform/x86/asus-wmi.c
> > > @@ -262,13 +262,13 @@ struct asus_wmi {
> > >=20
> > >  =09u32 gpu_mux_dev;
> > >  =09
> > >  =09/* Tunables provided by ASUS for gaming laptops */
> > >=20
> > > -=09bool ppt_pl2_sppt_available;
> > > -=09bool ppt_pl1_spl_available;
> > > -=09bool ppt_apu_sppt_available;
> > > -=09bool ppt_plat_sppt_available;
> > > -=09bool ppt_fppt_available;
> > > -=09bool nv_dyn_boost_available;
> > > -=09bool nv_temp_tgt_available;
> > > +=09u32 ppt_pl2_sppt;
> > > +=09u32 ppt_pl1_spl;
> > > +=09u32 ppt_apu_sppt;
> > > +=09u32 ppt_platform_sppt;
> > > +=09u32 ppt_fppt;
> > > +=09u32 nv_dynamic_boost;
> > > +=09u32 nv_temp_target;
> > >=20
> > >  =09u32 kbd_rgb_dev;
> > >  =09bool kbd_rgb_state_available;
> > >=20
> > > @@ -1020,11 +1020,21 @@ static ssize_t ppt_pl2_sppt_store(struct devi=
ce
> > > *dev,>=20
> > >  =09=09return -EIO;
> > >  =09
> > >  =09}
> > >=20
> > > +=09asus->ppt_pl2_sppt =3D value;
> > >=20
> > >  =09sysfs_notify(&asus->platform_device->dev.kobj, NULL,=20
> "ppt_pl2_sppt");
> > >  =09
> > >  =09return count;
> > > =20
> > >  }
> > >=20
> > > -static DEVICE_ATTR_WO(ppt_pl2_sppt);
> > > +
> > > +static ssize_t ppt_pl2_sppt_show(struct device *dev,
> > > +=09=09=09=09       struct device_attribute=20
> *attr,
> > > +=09=09=09=09       char *buf)
> > > +{
> > > +=09struct asus_wmi *asus =3D dev_get_drvdata(dev);
> > > +
> > > +=09return sysfs_emit(buf, "%d\n", asus->ppt_pl2_sppt);
> >=20
> > Use %u for u32 values. This applies to all sysfs_emits in this patch.
>=20
> Thought checkpatch or the compiler would catch that. Done.
>=20
> I've added your reviewed tag due to the simplicity of the change requeste=
d. I=20
> hope this was okay.

Hi,

Please don't add Reviewed-by tags automatically in the future. Its=20
meaning is not that the person has looked the patch.

--=20
 i.

--8323328-667445792-1712132462=:1449--

