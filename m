Return-Path: <linux-kernel+bounces-140692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF058A17CD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:48:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8E16CB2375F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57C73DF43;
	Thu, 11 Apr 2024 14:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b="QWS4LBIf"
Received: from xry111.site (xry111.site [89.208.246.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC91D530
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.208.246.23
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712846898; cv=none; b=nHTx1ooG9d3grytDl9s++ZHD7sBLt9XrQczab9ccunFITxMomocfl3cnWcaagYuIXF/SVbNxXvQeR7eseToGU1QB6egT/ZG5f9vWT4zDQr6JdOfBL2Ids7IzLvj8999xoLsmJHnd4Uin4O1PNZFuV7CqgYVY/m1nTg4CiVbfBRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712846898; c=relaxed/simple;
	bh=wjBgk7029GiJIT3ORMbsWBEnFRbSTbg6nXwPGUXtmG0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=r7A+Dia36kfnuNIswsVahdVqODBhZv5l0w0NCrO9/6G3y17mgw+qAsGvPmGrdbeh9gqA4JXV2jSl8j2R0EA2byy93N2yHLgvjD06bND9tVNSG/R5Db21n7muzx6h5iC2WWcQc7QhQtrWyODOG2c+4cSLA4HpsBmUvNnfXGjTQ+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site; spf=pass smtp.mailfrom=xry111.site; dkim=pass (1024-bit key) header.d=xry111.site header.i=@xry111.site header.b=QWS4LBIf; arc=none smtp.client-ip=89.208.246.23
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xry111.site
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xry111.site
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1712846894;
	bh=wjBgk7029GiJIT3ORMbsWBEnFRbSTbg6nXwPGUXtmG0=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
	b=QWS4LBIfeGBLa4KXZ/CG7I2X2Lp5C5rrVF3/E861PnlYV+IY8vE4OhXSl44VztRiz
	 9KP/WqY3yHGTnKUxjntHFH38wJhQ8h7NTaV9kjWicwVu+3lvS30ejWgPy764e3Z3Qo
	 SWcE3noACDMma+WjU6RX+YCgO/ymTajdvPXdcrBU=
Received: from [192.168.124.10] (unknown [113.200.174.104])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id A475466EB0;
	Thu, 11 Apr 2024 10:48:11 -0400 (EDT)
Message-ID: <1f5d53596e2ac8948332570e3bda17c3877fd499.camel@xry111.site>
Subject: Re: [PATCH v6] x86/mm: Don't disable INVLPG if "incomplete Global
 INVLPG flushes" is fixed by microcode or the kernel is running in a
 hypervisor
From: Xi Ruoyao <xry111@xry111.site>
To: Dave Hansen <dave.hansen@intel.com>, Dave Hansen
 <dave.hansen@linux.intel.com>, Michael Kelley <mhklinux@outlook.com>, Pawan
 Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: Andy Lutomirski <luto@kernel.org>, Peter Zijlstra
 <peterz@infradead.org>,  Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar
 <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, "H. Peter Anvin"
 <hpa@zytor.com>, x86@kernel.org, linux-kernel@vger.kernel.org, Sean
 Christopherson <seanjc@google.com>, Andrew Cooper
 <andrew.cooper3@citrix.com>
Date: Thu, 11 Apr 2024 22:48:07 +0800
In-Reply-To: <3ee70b6c-3399-43f9-8934-cb5a0e51f006@intel.com>
References: <20240411104822.6429-1-xry111@xry111.site>
	 <3ee70b6c-3399-43f9-8934-cb5a0e51f006@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Thu, 2024-04-11 at 07:44 -0700, Dave Hansen wrote:
> On 4/11/24 03:48, Xi Ruoyao wrote:
> > +	/*
> > +	 * The Intel errata claims: "this erratum does not apply in VMX
> > +	 * non-root operation.=C2=A0 It applies only when PCIDs are enabled
> > +	 * and either in VMX root operation or outside VMX operation."
> > +	 * So we are safe if we are surely running in a hypervisor.
> > +	 */
>=20
> When you revise this, could you please work to make this more succinct?
> The Intel language on these things tends to be a bit flowery and is not
> always well-suited for the kernel.

Oops, bad timing.  I just sent v7 before getting this reply.

I'm not a native English speaker, so could you give some hint about how
to write this comment clearly?

> Also, saying that the erratum "claims" this casts doubt on it.=C2=A0 That=
's
> counterproductive.=C2=A0 I believe the current documentation is correct.=
=C2=A0 My
> original ce0b15d11ad8 ("x86/mm: Avoid incomplete Global INVLPG flushes")
> should have considered virtualized systems immune to this issue.

Then do we need a "Fixes: ce0b15d11ad8" for the patch keeping PCID
enabled for guests?

> I agree that it sounds weird.=C2=A0 It _is_ weird that systems running un=
der
> hypervisors aren't affected.=C2=A0 But that's all it is: a weird bug.=C2=
=A0 The
> documentation is correct.

Yes, these hardware issues are just weird to me...

--=20
Xi Ruoyao <xry111@xry111.site>
School of Aerospace Science and Technology, Xidian University

