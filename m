Return-Path: <linux-kernel+bounces-86670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86AE086C8BD
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:05:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4269428D2DB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:05:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF5097CF15;
	Thu, 29 Feb 2024 12:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bYqNAAko"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F3AE59B6A;
	Thu, 29 Feb 2024 12:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709208343; cv=none; b=afVrmkPhrDtlM8te2jQpPbZqiAvtdTAFUDCGUGPKwpIVpTMcJaUFPnt2IiWHcyFvQ4qDi1QPWDvQQdhiTS+V8d5eD2HGWMQJgB4CRNDlYP0J9M/C56habJ13zLfhbvIbrvu2Wfwn6mdSvzmRCXECVm0JmwO2wDNdzp2i75cMeqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709208343; c=relaxed/simple;
	bh=rASCOjdaALxOwnv1fyM1Ja2P+ffC4nwmUFnWAi0dR5E=;
	h=From:Date:To:cc:Subject:In-Reply-To:Message-ID:References:
	 MIME-Version:Content-Type; b=durjHR56oy4xQWvAkocp+u+k6CruMet3hfkUmvvwJ7jpdZ2XPJK/9M8DELEdpys4LaIAtsIGpdUWDmFZNOgU/F/x6Jnhxy98KDyiANT7MJiZwN+/1cJJbMqk5GhozeC11raviB+9FlzC8m2J4V5y+3mdxdWTt5kcDkJumQhB3O0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bYqNAAko; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709208342; x=1740744342;
  h=from:date:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=rASCOjdaALxOwnv1fyM1Ja2P+ffC4nwmUFnWAi0dR5E=;
  b=bYqNAAkoNvh63trp5AzX/0jgHyl5rvEIstcWPt3f04RdNsEuRjrmbNFl
   jE2eU3JfUigoS+B1V7QWH5RjActf2JIOpdgCrkK/LuYuvHZV0UqlPjdUC
   KpTsbw4jIHAIVoEnuKkUzoADJmAobqgEFuCGTABnj72pI5JvTc8Fa3JfH
   uKAo5ugffZMv6UMKxSZL0J4O7GhH8+g4xzseD6MRGviVfdauyZUToEmQx
   JtFVwnu/yDl7wZ+5csiZQvtR54WcFLwdARQ4b9y4B8UA5M30dn1/ROlAZ
   Tpmfl3Veo8AgGANKttLoD0Ps4/8PAcKQpqWPG++rMouzC+Sb0ipzF0SI5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10998"; a="6619175"
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="6619175"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 04:05:42 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,194,1705392000"; 
   d="scan'208";a="30994683"
Received: from ijarvine-desk1.ger.corp.intel.com (HELO localhost) ([10.246.51.250])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Feb 2024 04:05:39 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Date: Thu, 29 Feb 2024 14:05:35 +0200 (EET)
To: Armin Wolf <W_Armin@gmx.de>
cc: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>, 
    Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org, 
    LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] platform/x86/amd/pmf: Fix possible out-of-bound
 memory accesses
In-Reply-To: <63ba267a-27db-456e-be32-2efe27fa26e1@gmx.de>
Message-ID: <78bcd4cf-5573-a99f-5d8d-dd22d106dafd@linux.intel.com>
References: <20240227145500.299683-1-W_Armin@gmx.de> <20240227145500.299683-2-W_Armin@gmx.de> <2dd63b5b-cf60-9f28-55b3-35eab537dc9b@linux.intel.com> <0e70681f-85c2-43f9-822a-2e07776c37c9@amd.com> <63ba267a-27db-456e-be32-2efe27fa26e1@gmx.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323328-511328752-1709208335=:1005"

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323328-511328752-1709208335=:1005
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE

On Wed, 28 Feb 2024, Armin Wolf wrote:
> Am 28.02.24 um 12:16 schrieb Shyam Sundar S K:
> > On 2/27/2024 21:15, Ilpo J=C3=A4rvinen wrote:
> > > On Tue, 27 Feb 2024, Armin Wolf wrote:
> > >=20
> > > > The length of the policy buffer is not validated before accessing i=
t,
> > > > which means that multiple out-of-bounds memory accesses can occur.
> > > >=20
> > > > This is especially bad since userspace can load policy binaries ove=
r
> > > > debugfs.
> > IMO, this patch is not required, reason being:
> > - the debugfs patch gets created only when CONFIG_AMD_PMF_DEBUG is
> > enabled.
> > - Sideload of policy binaries is only supported with a valid signing
> > key. (think like this can be tested & verified within AMD environment)
> > - Also, in amd_pmf_get_pb_data() there are boundary conditions that
> > are being checked. Is that not sufficient enough?
>=20
> IMHO, amd_pmf_get_pb_data() only checks if the length of the binary is
> between 0 and the maximum buffer size.
>=20
> If for example the binary contains only 4 bytes, then there will be an
> out-of-bounds access when trying to read the cookie and length.
>=20
> Or if the length is bigger than the binary buffer, then the driver just
> updates the buffer length even if the buffer is too small.
>=20
> I think the driver should catch such cases and return an error.
>=20
> (Please note that we are talking about the binary buffer, not the interna=
l
> structure of the remaining policy binary itself).

Yes. Out of bound accesses are not okay during validation even if the
binary itself would get rejected at a later stage. It doesn't matter if=20
the interface is only for debug or wider scope.

> > > > +=09if (dev->policy_sz < POLICY_COOKIE_LEN + sizeof(length))
> > > > +=09=09return -EINVAL;
> > > > +
> > > >   =09cookie =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_OFFSET);
> > > >   =09length =3D *(u32 *)(dev->policy_buf + POLICY_COOKIE_LEN);
> > > This starts to feel like adding a struct for the header(?) would be b=
etter
> > > course of action here as then one could compare against sizeof(*heade=
r)
> > > and avoid all those casts (IMO, just access the header fields directl=
y
> > > w/o the local variables).
> > Not sure if I get your question clearly. Can you elaborate a bit more
> > on the struct you are envisioning?
>=20
> I think he envisions something like this:
>=20
> struct __packed cookie_header {
> =09u32 magic;
> =09u32 length;
> };
>=20
> >=20
> > but IHMO, we actually don't need a struct - as all that we would need
> > is to make sure the signing cookie is part of the policy binary and
> > leave the rest of the error handling to ASP/TEE modules (we can rely
> > on the feedback from those modules).
> >=20
> > > Shyam, do you think a struct makes sense here? There's some header in
> > > this policy, right?
> > Yes, the policy binary on a whole has multiple sections within it and
> > there are multiple headers (like signing, OEM header, etc).
> >
> > But that might be not real interest to the PMF driver. The only thing
> > the driver has to make sure is that the policy binary going into ASP
> > (AMD Secure Processor) is with in the limits and has a valid signing
> > cookie. So this part is already taken care in the current code.

Clearly the PMF driver is interested in the header which contains
the cookie and length fields as proven by the code (even if that's for=20
the validation purposes only). I'm not asking about add various other=20
headers which are of no interest.

> > > There are more thing to address here...
> > >=20
> > > 1) amd_pmf_start_policy_engine() function returns -EINVAL & res that =
is
> > >     TA_PMF_* which inconsistent in type of the return value
> > >=20
> > ah! it has mix of both int and u32 :-)

I was talking more on a logical level not so much about C type itself.=20

It is confusing to return error in two ways: as -Exx values and=20
TA_PMF_* which are positive. As a general rule (IMO), the HW specific=20
errors should be mapped to -Exx codes at latest when a function returns=20
also -Exx code which is the case here.

--=20
 i.


> > Armin, would you like to amend this in your current series? or else I
> > will submit a change for this in my next series.
>
> I can do so, but i will be unable to send a new patch series for the rest=
 of
> this week.
>=20
> > > 2) Once 1) is fixed, the caller shadowing the return code can be fixe=
d as
> > >     well:
> > >          ret =3D amd_pmf_start_policy_engine(dev);
> > >          if (ret)
> > >                  return -EINVAL;
> > >=20
> > >=20
>=20

--8323328-511328752-1709208335=:1005--

