Return-Path: <linux-kernel+bounces-107827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 48C0C88022A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:26:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B49811F248F2
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:26:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8116385284;
	Tue, 19 Mar 2024 16:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jvEmWCxW"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9897657C3;
	Tue, 19 Mar 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865246; cv=none; b=VB4LXfhc2QvbLkj/Lb5X6nlkxJ4wM/TU3aUYj0ppnjVJElNXOXtkij9Sses/kw7kYQ3KTJc6LVzAI1aGdqWj3CTJxrW6hA1qMlPY37nDt9ZSER3VbCyvymP754PNNLlNW/5ENHiuH1OKo263f3lOyVCSgOEneJJJXoxX4i2cuUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865246; c=relaxed/simple;
	bh=maiGrk6h7z4RLEGDRsY+uLsYguYLp2lmoogaMSSzcK4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=btI3sn9z3Hqzz37pevIRHTFeM2Htx+iFVQEFHQKdCF0cpAR/Tbh+cBPNh5Z7Eu40cwbMvLV+qcBdISfkHI6fi0I0bkHL5bFWXJbpSWUNL38y+B/9zNPMD/vLAhM3ZTr0+TVuBnWsattfYmvfxXGZB/4xlhvpuPTYhi8Dii1OnKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jvEmWCxW; arc=none smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710865245; x=1742401245;
  h=message-id:subject:from:to:cc:date:in-reply-to:
   references:content-transfer-encoding:mime-version;
  bh=maiGrk6h7z4RLEGDRsY+uLsYguYLp2lmoogaMSSzcK4=;
  b=jvEmWCxWDLA2FYvd841i/F0tdGJFgcr+pKpnglxwLPzevD3scOPVp++W
   l7RYlsYvU2IAAMtv80SlxIaYbD7qi7yE1B3HX0iNX+QEclHaDmtnYe34+
   /PW7lEqqR5/fhtBMc+WnYSXWVPCkqFWZrEsPkM7C6+b/MU2AMAjilkvRc
   5txhVAwdqK26ozGRZeWmyjMFeU92khsUbmeRzcMn3L9p6GaMctOsUUHne
   8Oghanri+SsIAOMeBKHL9l8cZ2gmSd+xpXo8Xg0MEAzZaziNfu35Aiw1z
   Ro3fsMHZCTXChPtJ/ry574VqZLlugOcP+PTuQSpTP7/ApuYapC7kVf7G/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11018"; a="5958745"
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="5958745"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 09:20:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,137,1708416000"; 
   d="scan'208";a="13925891"
Received: from spandruv-desk1.amr.corp.intel.com ([10.209.55.117])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 09:20:43 -0700
Message-ID: <a2bdac6a8914a76ed122438547f3697611299c0f.camel@linux.intel.com>
Subject: Re: [PATCH] thermal: intel: int340x_thermal: replace deprecated
 strncpy with strscpy
From: srinivas pandruvada <srinivas.pandruvada@linux.intel.com>
To: "Rafael J. Wysocki" <rafael@kernel.org>, Justin Stitt
	 <justinstitt@google.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui
 <rui.zhang@intel.com>,  Lukasz Luba <lukasz.luba@arm.com>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-hardening@vger.kernel.org
Date: Tue, 19 Mar 2024 09:20:26 -0700
In-Reply-To: <CAJZ5v0j=cYbqyfi6y45hnu+Y_tvMGYb9p6d=kpsOA0AsxBoy3g@mail.gmail.com>
References: 
	<20240318-strncpy-drivers-thermal-intel-int340x_thermal-acpi_thermal_rel-c-v1-1-08839fbf737a@google.com>
	 <CAJZ5v0j=cYbqyfi6y45hnu+Y_tvMGYb9p6d=kpsOA0AsxBoy3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-19 at 12:39 +0100, Rafael J. Wysocki wrote:
> On Mon, Mar 18, 2024 at 11:36=E2=80=AFPM Justin Stitt
> <justinstitt@google.com> wrote:
> >=20
> > strncpy() is deprecated for use on NUL-terminated destination
> > strings
> > [1] and as such we should prefer more robust and less ambiguous
> > string
> > interfaces.
> >=20
> > psvt->limit.string can only be 8 bytes so let's use the appropriate
> > size
> > macro ACPI_LIMIT_STR_MAX_LEN.
> >=20
> > Neither psvt->limit.string or psvt_user[i].limit.string requires
> > the
> > NUL-padding behavior that strncpy() provides as they have both been
> > filled with NUL-bytes prior to the string operation.
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memset(&psvt->limit, 0, sizeof(u64));
> > and
> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psvt_user =3D kzalloc(psvt_len, GFP_KE=
RNEL);
> >=20
> > Let's use `strscpy` [2] due to the fact that it guarantees
> > NUL-termination on the destination buffer without unnecessarily
> > NUL-padding.
> >=20
> > Link:
> > https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-=
on-nul-terminated-strings
> > =C2=A0[1]
> > Link:
> > https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html
> > =C2=A0[2]
> > Link: https://github.com/KSPP/linux/issues/90
> > Cc: linux-hardening@vger.kernel.org
> > Signed-off-by: Justin Stitt <justinstitt@google.com>
>=20
> Srinivas, any objections?
No

Reviewed-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>

>=20
> > ---
> > Note: build-tested only.
> >=20
> > Found with: $ rg "strncpy\("
> > ---
> > =C2=A0drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c | 4 ++--
> > =C2=A01 file changed, 2 insertions(+), 2 deletions(-)
> >=20
> > diff --git
> > a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> > b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> > index dc519a665c18..4b4a4d63e61f 100644
> > --- a/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> > +++ b/drivers/thermal/intel/int340x_thermal/acpi_thermal_rel.c
> > @@ -309,7 +309,7 @@ static int acpi_parse_psvt(acpi_handle handle,
> > int *psvt_count, struct psvt **ps
> >=20
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (knob->type =3D=3D ACPI_TYPE_STRING) {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 memse=
t(&psvt->limit, 0, sizeof(u64));
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(psv=
t->limit.string, psvt_ptr-
> > >limit.str_ptr, knob->string.length);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strscpy(psv=
t->limit.string, psvt_ptr-
> > >limit.str_ptr, ACPI_LIMIT_STR_MAX_LEN);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 } else {
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psvt-=
>limit.integer =3D psvt_ptr-
> > >limit.integer;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 }
> > @@ -468,7 +468,7 @@ static int fill_psvt(char __user *ubuf)
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 psvt_user[i].unlimit_coeff =3D
> > psvts[i].unlimit_coeff;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 psvt_user[i].control_knob_type =3D
> > psvts[i].control_knob_type;
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 if (psvt_user[i].control_knob_type =3D=3D
> > ACPI_TYPE_STRING)
> > -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strncpy(psv=
t_user[i].limit.string,
> > psvts[i].limit.string,
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 strscpy(psv=
t_user[i].limit.string,
> > psvts[i].limit.string,
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ACPI_LIMIT_STR_MAX_LEN);
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 else
> > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 psvt_=
user[i].limit.integer =3D
> > psvts[i].limit.integer;
> >=20
> > ---
> > base-commit: bf3a69c6861ff4dc7892d895c87074af7bc1c400
> > change-id: 20240318-strncpy-drivers-thermal-intel-int340x_thermal-
> > acpi_thermal_rel-c-17070c1e42f3
> >=20
> > Best regards,
> > --
> > Justin Stitt <justinstitt@google.com>
> >=20


