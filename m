Return-Path: <linux-kernel+bounces-112805-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C5E887E5B
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 19:31:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3FB81C20EFD
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 18:31:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA6DD7469;
	Sun, 24 Mar 2024 18:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="SMb0ksJ4"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EF4815BF
	for <linux-kernel@vger.kernel.org>; Sun, 24 Mar 2024 18:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711305105; cv=none; b=dgDb+CNtIQyQaAyiAGHrpR0RFiaRt1Pb0H7tEGvbmRahqVXm5JKHSLfh38nk+tFSNWdh+IhtUdoDlTYeeBXTec9lOYLBt2xQucDYIG6BdVCeQBqf2otY/Xx5elZraYBxwK7KLeOfJ3Y1b/tHLbE6KeNIRZ9DJAibE7Piymc3Jtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711305105; c=relaxed/simple;
	bh=uT3yI8Uw1SouPMeSzpY+y7bPttkZ7cNJNJQKqFxOnT4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zvh7rR5ziE/RPv83+5RbkJKxW5N9H5YVb5rXbFlRbPl8NFOAzzZHviwDIx8GaiKyxfJDTtUYD2bJHDeV7k5Jf6A45LBr1cjNS0oIDcj5GajksBAFJXeHw+6WhutK/rxdMbbKQhI4aPFonpRCBiP8NvkKsyNEr61KUdBbjtlQPnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=SMb0ksJ4; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1711305100;
	bh=uT3yI8Uw1SouPMeSzpY+y7bPttkZ7cNJNJQKqFxOnT4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=SMb0ksJ4ugEmykdfN1+cHUKjBNnqFS5Yvc7N+COJTWzMbY5Tk1eOlo4P5a9s7vxff
	 d8dny4h8VHVT0M0d1Og6mq9BzCgQ2IwwTGdcjwKPaJhfqBbqQCL47bL1U1cq9T7RRA
	 ZSPftAmjtlBOkU1QlYW8kFrPPktW+/vOJa0Jz2RM=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 128CD1A3FB4;
	Sun, 24 Mar 2024 14:31:38 -0400 (EDT)
Message-ID: <6cb0333cb0e60aa9f7e914af26c605d075f90d61.camel@xry111.site>
Subject: Re: [PATCH] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Xi Ruoyao <xry111@xry111.site>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 25 Mar 2024 02:31:37 +0800
In-Reply-To: <319db7f3-7ce1-4096-a168-e5869c7a42f6@intel.com>
References: <20240324170630.76084-1-xry111@xry111.site>
	 <319db7f3-7ce1-4096-a168-e5869c7a42f6@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Sun, 2024-03-24 at 11:29 -0700, Dave Hansen wrote:
> On 3/24/24 10:06, Xi Ruoyao wrote:
> > +/*
> > + * INVLPG issue is fixed with intel-microcode-20240312 for all
> > + * affected models.=C2=A0 This table is taken from the release note
> > + * of this microcode release.
> > + */
>=20
> That comment is much more changelog material than code comment material.
>=20
> > +static const struct x86_cpu_desc invlpg_miss_fixed_ucode[] =3D {
> > +	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE,		2, 0x34),
> > +	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE,		5, 0x34),
> > +	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE_L,		3, 0x432),
> > +	INTEL_CPU_DESC(INTEL_FAM6_ALDERLAKE_L,		4, 0x432),
> > +	INTEL_CPU_DESC(INTEL_FAM6_ATOM_GRACEMONT,	0, 0x15),
> > +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE,		1, 0x122),
> > +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_P,		2, 0x4121),
> > +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_P,		3, 0x4121),
> > +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_S,		2, 0x34),
> > +	INTEL_CPU_DESC(INTEL_FAM6_RAPTORLAKE_S,		5, 0x34),
> > +	{}
> > +};
>=20
> Why is this listing individual steppings?=C2=A0 That seems nuts when the
> issue affects *all* steppings or at least the invlpg_miss_ids[] table
> says it affects all steppings.
>=20
> The right way to do this is to take the existing table:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INTEL_MATCH(INTEL_FAM6_ALDERLA=
KE=C2=A0=C2=A0 ),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INTEL_MATCH(INTEL_FAM6_ALDERLA=
KE_L ),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INTEL_MATCH(INTEL_FAM6_ATOM_GR=
ACEMONT ),
>=20
> and simply add the fix version:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INTEL_WHATEVER(INTEL_FAM6_ALDE=
RLAKE,=C2=A0	=C2=A0 0x034),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INTEL_WHATEVER(INTEL_FAM6_ALDE=
RLAKE_L,=C2=A0	=C2=A0 0x432),
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 INTEL_WHATEVER(INTEL_FAM6_ATOM=
_GRACEMONT, 0x015),
>=20
> Then you do:
>=20
> 	c =3D x86_match_cpu(invlpg_miss_ids);
> 	if (boot_cpu_data.microcode >=3D c->data)
> 		return 0; // no mitiagtion
> 	// affected, do mitigation
>=20
> Then there's *one* table listing each model once and no steppings.=C2=A0 =
I
> thought there's another example of this _somewhere_ but I couldn't find
> it in two minutes of grepping.

Hmm, I also thought there should be this thing but I couldn't find it...
Let me try again.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

