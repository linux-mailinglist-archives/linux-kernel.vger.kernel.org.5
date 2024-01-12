Return-Path: <linux-kernel+bounces-24815-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 503D482C2E7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:39:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E33F71F23CC4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 013876EB5E;
	Fri, 12 Jan 2024 15:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dFmxTTQg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="no5JwyVt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CECA6EB45
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 15:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1705073985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67Uy+xhGrqYkO1Av45A28fcnjxtc8LhN+2a/aHhmapI=;
	b=dFmxTTQg/dIndngXy7D1328VAC8fb38C9VJ4X1o3ewLia4TGVa9wAtDOjN0+/tn/tRpujV
	hbh5LXDTTCqQHhYT3mTEyAAZqmEGBWZLrJE6qluvISNJTVIKgoWZEk1b57KsImdMsBPVgt
	/JX8eA9gR3Lt1CTncgjo6J8hfe4RhOoz4CudQ3ouZ/UVZHkp5gJ9lVltG8OtSV8ZgHzHd5
	MCW1fPS5uM9WGEeXwkTr1AHELcycksqU7RjxqetguO/YZIxREZXXOUMGJKRf5+rY1zhUyi
	sH8/RDv6Y3UGc9kjiWJ89iRul4oE/iTtxytlKdG9a3s4tb3ydLtYssF2L8TQmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1705073985;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=67Uy+xhGrqYkO1Av45A28fcnjxtc8LhN+2a/aHhmapI=;
	b=no5JwyVtQJcvBedZG3HEST21xAghCRMvMEWZEAok147fvhdFDCeIZXVEwDQIxvEw7eNqLO
	p1U7FWpW9+LwcHCg==
To: "Zhang, Rui" <rui.zhang@intel.com>, "Brown, Len" <len.brown@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: "jgross@suse.com" <jgross@suse.com>, "x86@kernel.org" <x86@kernel.org>,
 "arjan@linux.intel.com" <arjan@linux.intel.com>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "Tang, Feng" <feng.tang@intel.com>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ray.huang@amd.com"
 <ray.huang@amd.com>, "andrew.cooper3@citrix.com"
 <andrew.cooper3@citrix.com>, "Sivanich, Dimitri"
 <dimitri.sivanich@hpe.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
 "Mehta, Sohil" <sohil.mehta@intel.com>, "andy@infradead.org"
 <andy@infradead.org>
Subject: Re: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
In-Reply-To: <dbad0f6f9dee5851aa21ffae9e8877cf23645af5.camel@intel.com>
References: <20230807130108.853357011@linutronix.de>
 <20230807135028.381851690@linutronix.de>
 <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
 <871qarlvub.ffs@tglx> <87y1czkdlg.ffs@tglx>
 <ff58623cdf63dc75fc245fd18ee776465f4bb3b8.camel@intel.com>
 <87frz5jmnl.ffs@tglx> <87a5pdjk54.ffs@tglx>
 <dbad0f6f9dee5851aa21ffae9e8877cf23645af5.camel@intel.com>
Date: Fri, 12 Jan 2024 16:39:44 +0100
Message-ID: <87edemimrj.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12 2024 at 09:14, Zhang, Rui wrote:
> On Wed, 2024-01-10 at 16:14 +0100, Thomas Gleixner wrote:
>> On Wed, Jan 10 2024 at 15:19, Thomas Gleixner wrote:
>> > > This is the order in MADT,
>> > > $ cat apic.dsl=C2=A0 | grep x2Apic
>> > > [030h 0048=C2=A0=C2=A0 4]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Processor x2Apic ID : 00000010
>> > > [040h 0064=C2=A0=C2=A0 4]=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0 Processor x2Apic ID : 00000011
>> ...
>> > > and this is the order in Linux (from CPU0 to CPUN)
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x2APIC ID of logical processor =3D 0x=
20 (32)
>> > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 x2APIC ID of logical processor =3D 0x=
10 (16)
>> >=20
>> > What a mess...
>>=20
>> And clearly not according to the spec
>>=20
>> =C2=A0 "The second is that platform firmware should list the boot
>> processor
>> =C2=A0=C2=A0 as the first processor entry in the MADT."
>>=20
>> Oh well. There are reasons why this is written the way it is.
>
> This is indeed a violation of the ACPI spec and we should modify the
> order in MADT. But this doesn't bring any actual effect as Linux
> already handles this, right?

It brings the effect that we can detect when we are not booting (kexec
case) on the actual boot CPU because then the first enumerated APIC ID
is not the same as the boot CPU APIC ID. No?

> For the BSP APIC ID 0x20, I didn't find out a specific reason why we
> have to do it in that way, but it is still legal.

Linux does not really care in which order the APICs are enumerated.

> We may need to figure out another way to distinguish the kdump kernel.

Having the first enumerated APIC in the MADT as the actual boot CPU is a
sensible and functional way. Everything else including the silly kexec
boot parameter is error prone.

I agree that MADT is error prone too given the fact that not even Intel
can get it right....

Thanks,

        tglx

