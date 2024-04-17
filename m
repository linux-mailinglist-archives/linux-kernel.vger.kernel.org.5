Return-Path: <linux-kernel+bounces-148097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D2228A7DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 271D2B233D2
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 08:02:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 065787640D;
	Wed, 17 Apr 2024 08:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="XXai84ep"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8266C768EA
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 08:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713340944; cv=none; b=sDixSfiGm70EWMemyVEsJMoQtLkUvSbUf5K/ebATrDxEBLEF5UcMirZCRENJMCjdUvvZPvFLOEf7Vus0w99xTHzt6qTIQtDdXuxaKVTGPp2uBXd0nCzw9oIUptZhOZEyZasyZl9Xi7rSnITIBpHwiWCBkvNr7WE+Hfk2OMF+LQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713340944; c=relaxed/simple;
	bh=kEOiWKonPM4uH3ufhh6aTojqf5wSc1drns11/mbS0g4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hk8brhqGgkyhQU7tXpxNFBjehf3UKYiIKkaSIWJfjMfMUFJBiy8lvuVGnjzUklBhR3o5VpzXoCnLtdOOlPxum2kVEEdkmvjFnOcKRgeI4XYi2u6stgDXbkpMRUs5WdnjRcR9gwzuUdDeo8KpFn/qcP6l1eqZWUmUDxQuXjIJ3ng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=XXai84ep; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1713340927;
	bh=kEOiWKonPM4uH3ufhh6aTojqf5wSc1drns11/mbS0g4=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=XXai84ep3T/u9Wyn73oSX0rwD5Pxa2EZ1MDnLOXfIobE9OBoGfFz0ZXSsi5MEUt1E
	 rw1ecFiehkID4sPKyrQF7OGRThqEZC2Ec5e1Kbw2s47shrDzHwu3pNkkf5EeqfCceN
	 atmCWezFSOjUiGouN99rVhLSmuAK3RyiMWxhc0ZI=
Received: from [IPv6:240e:358:118b:fc00:dc73:854d:832e:8] (unknown [IPv6:240e:358:118b:fc00:dc73:854d:832e:8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 73D7E670D4;
	Wed, 17 Apr 2024 04:02:02 -0400 (EDT)
Message-ID: <a4c72d6722189c074bd46f01d95c9aaa966a2687.camel@xry111.site>
Subject: Re: [PATCH v8 2/2] x86/mm: Don't disable PCID if the kernel is
 running on a hypervisor
From: Xi Ruoyao <xry111@xry111.site>
To: Sean Christopherson <seanjc@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>, Michael Kelley
	 <mhklinux@outlook.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, 
 Andy Lutomirski
	 <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas Gleixner
	 <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov
	 <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, 
	linux-kernel@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>
Date: Wed, 17 Apr 2024 16:01:55 +0800
In-Reply-To: <Zh8Oli5MIyekLrbu@google.com>
References: <20240413044129.52812-1-xry111@xry111.site>
	 <20240413044129.52812-2-xry111@xry111.site> <Zh8Oli5MIyekLrbu@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-16 at 16:49 -0700, Sean Christopherson wrote:
> On Sat, Apr 13, 2024, Xi Ruoyao wrote:
> > The Intel erratum for "incomplete Global INVLPG flushes" says:
> >=20
> > =C2=A0=C2=A0=C2=A0 This erratum does not apply in VMX non-root operatio=
n. It applies
> > =C2=A0=C2=A0=C2=A0 only when PCIDs are enabled and either in VMX root o=
peration or
> > =C2=A0=C2=A0=C2=A0 outside VMX operation.
> >=20
> > So if the kernel is running in a hypervisor, we are in VMX non-root
> > operation and we should be safe to use PCID.
> >=20
> > Cc: Dave Hansen <dave.hansen@linux.intel.com>
> > Cc: Michael Kelley <mhklinux@outlook.com>
> > Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
> > Cc: Sean Christopherson <seanjc@google.com>
> > Cc: Andrew Cooper <andrew.cooper3@citrix.com>
> > Link: https://lore.kernel.org/all/168436059559.404.13934972543631851306=
tip-bot2@tip-bot2/
> > Link: https://cdrdv2.intel.com/v1/dl/getContent/740518=C2=A0# RPL042, r=
ev. 13
> > Link: https://cdrdv2.intel.com/v1/dl/getContent/682436=C2=A0# ADL063, r=
ev. 24
> > Signed-off-by: Xi Ruoyao <xry111@xry111.site>
> > ---
> > =C2=A0arch/x86/mm/init.c | 8 ++++++++
> > =C2=A01 file changed, 8 insertions(+)
> >=20
> > diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
> > index c318cdc35467..6010f86c5acd 100644
> > --- a/arch/x86/mm/init.c
> > +++ b/arch/x86/mm/init.c
> > @@ -275,6 +275,14 @@ static void __init probe_page_size_mask(void)
> > =C2=A0 * microcode is not updated to fix the issue.
> > =C2=A0 */
> > =C2=A0static const struct x86_cpu_id invlpg_miss_ids[] =3D {
> > +	/* Only bare-metal is affected.=C2=A0 PCIDs in guests are OK.=C2=A0 *=
/
> > +	{
> > +	=C2=A0 .vendor	=3D X86_VENDOR_INTEL,
> > +	=C2=A0 .family	=3D 6,
> > +	=C2=A0 .model	=3D INTEL_FAM6_ANY,
> > +	=C2=A0 .feature	=3D X86_FEATURE_HYPERVISOR,
>=20
> Isn't this inverted?=C2=A0 x86_match_cpu() will return NULL if the CPU do=
esn't have
> HYPERVISOR.=C2=A0 We want it to return NULL if the CPU *does* have HYPERV=
ISOR.

Hmm, but it seems not possible to let x86_match_cpu() to always return
NULL if the CPU does have HYPERVISOR.  If I read x86_match_cpu()
correctly it cannot do an inverted feature match.  Or am I
misunderstanding something here?

Instead this makes x86_match_cpu() return an entry with driver_data =3D 0
if the CPU have HYPERVISOR, thus boot_cpu_data.microcode <
invlpg_miss_match->driver_data will always be false when the CPU have
HYPERVISOR and PCID won't be disabled.

> > +	=C2=A0 .driver_data	=3D 0,
> > +	},
> > =C2=A0	INTEL_MATCH(INTEL_FAM6_ALDERLAKE,	0x2e),
> > =C2=A0	INTEL_MATCH(INTEL_FAM6_ALDERLAKE_L,	0x42c),
> > =C2=A0	INTEL_MATCH(INTEL_FAM6_ATOM_GRACEMONT,	0x11),
> > --=20
> > 2.44.0
> >=20

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

