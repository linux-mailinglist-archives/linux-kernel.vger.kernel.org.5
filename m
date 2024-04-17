Return-Path: <linux-kernel+bounces-149049-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BC58A8B07
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 20:26:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F34341F21C2A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 18:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88F0D17333F;
	Wed, 17 Apr 2024 18:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="GfaAyplw"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434117D410
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 18:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713378406; cv=none; b=NwmD1Nf+Gxxb4VgJ38OjZkx8WfcZ42IOhKzYLohWlkUuworQPy8g3WPmFlPEE2Cb1KwUJ5egWtXWciPaFUZ7FjzgVPCel7uztdiiPQlskIToSQYH/sXRzcGhBD11s9ZCL4ybXHkelaK0fPrQYlOLMj5Lkf9MQeBWgaKOBzDOmxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713378406; c=relaxed/simple;
	bh=3dknlcFz/QMVlRrD32WKtzwT/ylS7mZP6cn5ZZvV1HM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=TwqlltrjLkFxfsDGjzKILqPfy3rCBmJvCTi17PW7WViRIvwMRisD/t8qT9aez+9jaECOmlLk/ig5Fks+zqVd+1uyz1HTSybQA7YK9RfUz5uO/Ud2mpqvz8ZDTxGPx1m/fJIjEqfvi2VKTE5ANRH5lqLD1qEtjT4F9ubdO/pHm8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=GfaAyplw; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1713378402;
	bh=3dknlcFz/QMVlRrD32WKtzwT/ylS7mZP6cn5ZZvV1HM=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=GfaAyplwcIIlBPNdN53+E+412sK8ILblwe7C92Xl9QKBAyrYiUsXY1+EgfXntbZ8m
	 YEu19ab2mDqWgzMhORCBFB2ZpbNro0OdIesQkccbrBBfS6V5cLpfTxhzZuXrqHxL4e
	 GqWScJzzhMzy89/0hHFrS5Rz4OnciKDOUAUUbeOU=
Received: from [127.0.0.1] (unknown [IPv6:2001:470:683e::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id DD880668F9;
	Wed, 17 Apr 2024 14:26:39 -0400 (EDT)
Message-ID: <783299e235ca75db9610ea85b5577a6dd02930e1.camel@xry111.site>
Subject: Re: [PATCH v8 2/2] x86/mm: Don't disable PCID if the kernel is
 running on a hypervisor
From: Xi Ruoyao <xry111@xry111.site>
To: Sean Christopherson <seanjc@google.com>, Dave Hansen
 <dave.hansen@intel.com>
Cc: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>, Andy
 Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Thomas
 Gleixner <tglx@linutronix.de>,  Ingo Molnar <mingo@redhat.com>, Borislav
 Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,  x86@kernel.org,
 linux-kernel@vger.kernel.org, Andrew Cooper <andrew.cooper3@citrix.com>
Date: Thu, 18 Apr 2024 02:26:38 +0800
In-Reply-To: <ZiATnwBHJThDNpxk@google.com>
References: <20240413044129.52812-1-xry111@xry111.site>
	 <20240413044129.52812-2-xry111@xry111.site> <Zh8Oli5MIyekLrbu@google.com>
	 <20240417172222.f4h2csf4xkffccqn@desk>
	 <399bbc9d-ae75-4754-8ce9-af563df15a38@intel.com>
	 <ZiATnwBHJThDNpxk@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-04-17 at 11:23 -0700, Sean Christopherson wrote:
> On Wed, Apr 17, 2024, Dave Hansen wrote:
> > On 4/17/24 10:22, Pawan Gupta wrote:
> > > > > =C2=A0static const struct x86_cpu_id invlpg_miss_ids[] =3D {
> > > > > +	/* Only bare-metal is affected.=C2=A0 PCIDs in guests are OK.=
=C2=A0 */
> > > > > +	{
> > > > > +	=C2=A0 .vendor	=3D X86_VENDOR_INTEL,
> > > > > +	=C2=A0 .family	=3D 6,
> > > > > +	=C2=A0 .model	=3D INTEL_FAM6_ANY,
>=20
> Just in case we go this route (I hope we don't), this should probably be:
>=20
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* Only bare-metal is affected=
=C2=A0 PCIDs in guests are OK.=C2=A0 */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 {
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .vendor=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 =3D X86_VENDOR_ANY,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .feature=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 =3D X86_FEATURE_HYPERVISOR,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 .driver_data=C2=A0=
 =3D 0,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 },
>=20
> to make it clear that the goal is to match only the feature.=C2=A0 Matchi=
ng Intel P6
> suffices because that's what the other entries in the array all check, bu=
t it
> makes subtle, confusing code even more subtle and confusing.

Agreed.

/* snip */

> > > >=20
> > Let's just do the X86_FEATURE_HYPERVISOR explicitly in the code instead
> > of trying to cram it into the invlpg_miss_ids[] check.=C2=A0 It's way e=
asier
> > to understand with an explicit code check.
>=20
> +1.=C2=A0 And it doesn't rely on the HYPERVISOR entry being the first ent=
ry, which
> is doubly evil.

So I'll go with the explicit checking in v9.  I'll send it tomorrow.

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

