Return-Path: <linux-kernel+bounces-116821-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65FB488A438
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:22:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1A2362E5B3C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:22:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08A0D82D9F;
	Mon, 25 Mar 2024 10:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="aedx3Los"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6801292C1
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 10:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711362078; cv=none; b=mkn1WmthCn493pijKfOWaHqLVhueE9Fgx1X8dn7Ni1EYCgjuoUkjtQi5InYm5J+eS4DvXC0/3V/gbWwaPHfmxUKYMXmGbJAmQaFh0Phv/6CLmvxw6XZVEVwTeUbMFC2+81EFbK2Qcy9hGI00rl9o+o5UGxo/IvPTw2qpAztXCy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711362078; c=relaxed/simple;
	bh=8oHCVzt5yIb74wmNUTV10DqPItz7YPxCF7swqVQr49U=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MLPkxFuuvzeguligD8qv7sEkPyjDpPXOgHee4ToU7F0ynP1ndfv1wlZ9EA5JqNUcyTdoWWkRtCvpUYT4/3rGGvClqOeDF2avAfOUw8JbKeX/iU7D1+u0X1dU6F3JPCAWFavsQ5BdNxkTq6ZJWbapCcVnC/zmdo9nJIz7BlNc5iI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=aedx3Los; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711362074;
	bh=8oHCVzt5yIb74wmNUTV10DqPItz7YPxCF7swqVQr49U=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=aedx3LosWnycWhoUKUQxWcO43FLghyNrBU94sTqD/bVbqnIBu2geV+Lcc/rHZahmh
	 isBB2Ab7IWqvIVUXqlfC0Mu+YFX7wk1NRG4Uj3jGHdJ5BIQfH1IaWTJBnl4IFxGnwE
	 QODllf9B7qaP4bg6uvCSRA/i8tHf/zMqaQ1IZc/g=
Received: from [IPv6:240e:358:11fe:a000:dc73:854d:832e:8] (unknown [IPv6:240e:358:11fe:a000:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 7BCDF66EE2;
	Mon, 25 Mar 2024 06:21:09 -0400 (EDT)
Message-ID: <c8dfca5f964701ce614d364ed7b18fa930aa2f61.camel@xry111.site>
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Xi Ruoyao <xry111@xry111.site>
To: Michael Kelley <mhklinux@outlook.com>, Dave Hansen
	 <dave.hansen@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Dexuan Cui
 <decui@microsoft.com>
Date: Mon, 25 Mar 2024 18:21:04 +0800
In-Reply-To: <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
References: <20240324190503.116160-1-xry111@xry111.site>
	 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Mon, 2024-03-25 at 04:57 +0000, Michael Kelley wrote:
> From: Xi Ruoyao <xry111@xry111.site> Sent: Sunday, March 24, 2024 12:05 P=
M
> >=20
> > Per the "Processor Specification Update" documentations referred by the
> > intel-microcode-20240312 release note, this microcode release has fixed
> > the issue for all affected models.
> >=20
> > So don't disable INVLPG if the microcode is new enough.
> >=20
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> > =C2=A0arch/x86/mm/init.c | 32 ++++++++++++++++++++------------
> > =C2=A01 file changed, 20 insertions(+), 12 deletions(-)
> >=20
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index 679893ea5e68..c52be4e66e44 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -261,33 +261,41 @@ static void __init probe_page_size_mask(void)
> > =C2=A0	}
> > =C2=A0}
> >=20
> > -#define INTEL_MATCH(_model) { .vendor=C2=A0 =3D X86_VENDOR_INTEL,	\
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .family=C2=A0 =3D 6,			\
> > -			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .model =3D _model,			\
> > -			=C2=A0=C2=A0=C2=A0 }
> > +#define INTEL_MATCH(_model, _fixed_microcode)	\
> > +=C2=A0=C2=A0=C2=A0 { .vendor		=3D X86_VENDOR_INTEL,	\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .family		=3D 6,			\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .model		=3D _model,		\
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data	=3D _fixed_microcode,	\
> > +=C2=A0=C2=A0=C2=A0 }
> > +
> > =C2=A0/*
> > =C2=A0 * INVLPG may not properly flush Global entries
> > - * on these CPUs when PCIDs are enabled.
> > + * on these CPUs when PCIDs are enabled and the
> > + * microcode is not updated to fix the issue.
> > =C2=A0 */
> > =C2=A0static const struct x86_cpu_id invlpg_miss_ids[] =3D {
> > -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE=C2=A0=C2=A0 ),
> > -	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L ),
> > -	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT ),
> > -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE=C2=A0 ),
> > -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P),
> > -	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S),
> > +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x34),
> > +	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x432),
> > +	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x15),
> > +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE,	0x122),
> > +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_P,	0x4121),
> > +	INTEL_MATCH(INTEL_FAM6_RAPTORLAKE_S,	0x34),
> > =C2=A0	{}
> > =C2=A0};
> >=20
> > =C2=A0static void setup_pcid(void)
> > =C2=A0{
> > +	const struct x86_cpu_id *invlpg_miss_match;
> > +
> > =C2=A0	if (!IS_ENABLED(CONFIG_X86_64))
> > =C2=A0		return;
> >=20
> > =C2=A0	if (!boot_cpu_has(X86_FEATURE_PCID))
> > =C2=A0		return;
> >=20
> > -	if (x86_match_cpu(invlpg_miss_ids)) {
> > +	invlpg_miss_match =3D x86_match_cpu(invlpg_miss_ids);
> > +	if (invlpg_miss_match &&
> > +	=C2=A0=C2=A0=C2=A0 invlpg_miss_match->driver_data > boot_cpu_data.mic=
rocode) {
> > =C2=A0		pr_info("Incomplete global flushes, disabling PCID");
> > =C2=A0		setup_clear_cpu_cap(X86_FEATURE_PCID);
> > =C2=A0		return;
>=20
> As noted in similar places where microcode versions are
> checked, hypervisors often lie to guests about microcode versions.
> For example, see comments in bad_spectre_microcode().=C2=A0 I
> know Hyper-V guests always see the microcode version as
> 0xFFFFFFFF (max u32 value).=C2=A0 So in a Hyper-V guest the above
> code will always leave PCID enabled.
>=20
> Maybe the above should have a check for running on a
> hypervisor and always disable PCID without checking the
> microcode version.=C2=A0 That's the safe approach, though there are
> other similar cases like bad_spectre_microcode() that take
> the unsafe approach when running as a guest.=C2=A0 I don't know
> what's best here .....

Then generally maybe we should set boot_cpu_data.microcode to 0 if a
hypervisor is detected?  Or checking against hypervisors at every place
where we check the microcode revision will be nasty.

And I'd prefer they say 0 instead if 0xffffffffu if they must lie about
the microcode revision.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

