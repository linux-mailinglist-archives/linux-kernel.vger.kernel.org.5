Return-Path: <linux-kernel+bounces-139802-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D59548A07DF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 07:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B7BA283A4A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 05:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D603EEADD;
	Thu, 11 Apr 2024 05:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="KOWj8/6F"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE51FBB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 05:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712814255; cv=none; b=nhllQRFOSGLUHTLuReCPu9SqNdcDi02zqhdpKNmE313T5ras9FNNBFh4km5wbGhbi5dzOAq5csGswFH+Ge7yD7i6QOao4KZWfLRjkXNdVWvkCIx0Q+XEBwPsYzh4u64axsGnmgC4QoAdJwo6GSc9hSDbQyaYkOMWpuWzv1M8mCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712814255; c=relaxed/simple;
	bh=PoX3VR6mX7cWIItNfToD8IFe75eNHPdkN9a85sokL8Y=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=JUz7qEtmNNFUBIiD3chrdDba3e1YhqAkVwZmviy5afzyQ4CdkmipzU3E5Id9LXosE8x1D8IF1qu05vFCzChOEg5JFyw0a3SLa+TgStjbCJlUjEzR5pOfkwBUe0Tgr4ScTe7rncZQoYAfOx0AkBqA7mTmYEgX4n9Wgt5uJBJgXjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=KOWj8/6F; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1712813926;
	bh=PoX3VR6mX7cWIItNfToD8IFe75eNHPdkN9a85sokL8Y=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=KOWj8/6FlwUXJ85gdx6nYLGSno2kKd8SkFZX+ov3fOdVB2ypkJd4OVKBHNlkF75/k
	 LK3BMQ4MsanUa+JSa+Hcu2IUraJ5lAIef0s6zBG+sXqRunsw/3PnUZ54pTDhMt1Aug
	 lKoARbOn1zVNYAg284THY3avG6cyRgWY8vK9oox0=
Received: from [IPv6:240e:358:11a8:c800:dc73:854d:832e:7] (unknown [IPv6:240e:358:11a8:c800:dc73:854d:832e:7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id 1EAA967163;
	Thu, 11 Apr 2024 01:38:39 -0400 (EDT)
Message-ID: <8e12f79a8275ffa40858763acade4d54b3e96212.camel@xry111.site>
Subject: Re: [PATCH v2] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode
From: Xi Ruoyao <xry111@xry111.site>
To: Andrew Cooper <andrew.cooper3@citrix.com>, Sean Christopherson
	 <seanjc@google.com>, Michael Kelley <mhklinux@outlook.com>
Cc: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Andy Lutomirski <luto@kernel.org>, Peter
 Zijlstra <peterz@infradead.org>, Thomas Gleixner <tglx@linutronix.de>, Ingo
 Molnar <mingo@redhat.com>,  Borislav Petkov <bp@alien8.de>, "H. Peter
 Anvin" <hpa@zytor.com>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,  Dexuan Cui
 <decui@microsoft.com>
Date: Thu, 11 Apr 2024 13:38:33 +0800
In-Reply-To: <d82cf14a-e949-4265-ae37-ec01685e1080@citrix.com>
References: <20240324190503.116160-1-xry111@xry111.site>
	 <SN6PR02MB41576028614CB7FE9A11EBEBD4362@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <Zg7S5dk3J4Zc82nj@google.com>
	 <d1cc1f7c-9df0-4e3c-88ae-aedcd556ba95@citrix.com>
	 <Zg7jLn-lV55Yh6mH@google.com>
	 <SN6PR02MB415717D76F71C023A574841ED43C2@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <f8df14f3-ae6a-4e08-927a-7a7c2ebe8352@intel.com>
	 <SN6PR02MB4157FDA1C431A92873AA1AAED4002@SN6PR02MB4157.namprd02.prod.outlook.com>
	 <ZhSdSwqUprIgLVtr@google.com>
	 <d82cf14a-e949-4265-ae37-ec01685e1080@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-04-09 at 08:56 +0100, Andrew Cooper wrote:
> On 09/04/2024 2:43 am, Sean Christopherson wrote:
> > On Mon, Apr 08, 2024, Michael Kelley wrote:
> > > From: Dave Hansen <dave.hansen@intel.com> Sent: Thursday, April 4, 20=
24 11:09 AM
> > > > On 4/4/24 10:48, Michael Kelley wrote:
> > > > > I agree one could argue that it is a hypervisor bug to present PC=
ID to the guest
> > > > > in this situation. It's a lot cleaner to not have a guest be chec=
king FMS and
> > > > > microcode versions. But whether that's practical in the real worl=
d, at least
> > > > > for Hyper-V, I don't know. What's the real impact of running with=
 PCID while
> > > > > the flaw is still present? I don=E2=80=99t know the history here =
..
> > > > There's a chance that INVLPG will appear ineffective.
> > > >=20
> > > > The bad sequence would go something like this: The kernel does the
> > > > INVLPG on a global mapping.=C2=A0 Later, when switching PCIDs, the =
TLB entry
> > > > mysteriously reappears.=C2=A0 No PCIDs switching means no mysteriou=
s
> > > > reappearance.
> > > Xi Ruoyao's patch identifies these errata:=C2=A0 RPL042 and ADL063.=
=C2=A0 In the links
> > > to the documents Xi provided, both of these errata have the following
> > > statement in the Errata Details section:
> > >=20
> > > =C2=A0=C2=A0=C2=A0 This erratum does not apply in VMX non-root operat=
ion.=C2=A0 It applies only
> > > =C2=A0=C2=A0=C2=A0 when PCIDs are enabled and either in VMX root oper=
ation or outside
> > > =C2=A0=C2=A0=C2=A0 VMX operation.
> > >=20
> > > I don't have deep expertise on the terminology here, but this sounds
> > > like it is saying the erratum doesn=E2=80=99t apply in a guest VM.=C2=
=A0 Or am I
> > > misunderstanding?

> > Huh.=C2=A0 My read of that is the same as yours.=C2=A0 If that's the ca=
se, then it probably
> > makes sense to have KVM advertise support if PCID is available in hardw=
are, even
> > if PCID is disabled by the host kernel.
>=20
> My reading is the same also.=C2=A0 Seems like VMs are fine.

So... Should I sent a v6 with the hypervisor checking reverted [ i.e.
always enable PCID if boot_cpu_has(X86_FEATURE_HYPERVISOR) ]?

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

