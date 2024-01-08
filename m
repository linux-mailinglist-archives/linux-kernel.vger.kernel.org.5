Return-Path: <linux-kernel+bounces-19822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA34B8274B8
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 17:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A7E2B2218B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 16:13:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156EC524D5;
	Mon,  8 Jan 2024 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MryeaLoj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7Njo6jTX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1BDA524BE
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 16:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704730411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvUicjBGSwsOvS9W+LrZ7jgrjMu62sy16+o7dUgEHbs=;
	b=MryeaLojWfH2yhRaf1vw56iklZGvdAIoTWIK4uXmq0UFT/0fq1C71Xsej8sJdx59PGmVcq
	uJL4HfJGyvYvZqt4/SaDtlv+KlPljsG8eAWeJtOBcdEHwKTxfbar2HorfgXKt7NbuBbWqH
	SAb/lGb+lrhpD6Sk4RGwsOYmA8yMJ/WFQi2b36x8er1y6ZrNVv6L4bHUErefYWJ66gn028
	XOGUXIHU55bLuaQVeLy86oh3CtfYK7qE0VVyofUGUZ/t8VKd82EfxLYmke7/9C8G3CSJSQ
	0Cjjgkx6qMUepfNcR5sc5vSK4VY0kwkw10ZF6iZY0t3D6+nY3JI2Iuq+3OpGLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704730411;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rvUicjBGSwsOvS9W+LrZ7jgrjMu62sy16+o7dUgEHbs=;
	b=7Njo6jTXxM6xfnG0RlXhzmcBIF3m+NX3FjEA5zX5dXqVKNXyl560bTdTrc6tMUFu9WZXNG
	PfCI5ezoB0p99FDQ==
To: "Zhang, Rui" <rui.zhang@intel.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Cc: "jgross@suse.com" <jgross@suse.com>, "arjan@linux.intel.com"
 <arjan@linux.intel.com>, "kprateek.nayak@amd.com"
 <kprateek.nayak@amd.com>, "x86@kernel.org" <x86@kernel.org>,
 "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
 "thomas.lendacky@amd.com" <thomas.lendacky@amd.com>, "ray.huang@amd.com"
 <ray.huang@amd.com>, "andrew.cooper3@citrix.com"
 <andrew.cooper3@citrix.com>, "Sivanich, Dimitri"
 <dimitri.sivanich@hpe.com>, "paulmck@kernel.org" <paulmck@kernel.org>,
 "Mehta, Sohil" <sohil.mehta@intel.com>, "andy@infradead.org"
 <andy@infradead.org>, "Tang, Feng" <feng.tang@intel.com>
Subject: Re: [patch 37/53] x86/cpu: Detect real BSP on crash kernels
In-Reply-To: <871qarlvub.ffs@tglx>
References: <20230807130108.853357011@linutronix.de>
 <20230807135028.381851690@linutronix.de>
 <7443f3200ef0be756566059e8c9b0657f3cefcff.camel@intel.com>
 <871qarlvub.ffs@tglx>
Date: Mon, 08 Jan 2024 17:13:31 +0100
Message-ID: <87y1czkdlg.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 08 2024 at 15:54, Thomas Gleixner wrote:

> On Mon, Jan 08 2024 at 14:11, Zhang, Rui wrote:
>>> +static __init void check_for_kdump_kernel(void)
>>> +{
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0u32 bsp_apicid;
>>> +
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0/*
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * There is no real good way=
 to detect whether this a kdump()
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * kernel, but except on the=
 Voyager SMP monstrosity which is
>>> not
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * longer supported, the rea=
l BSP has always the lowest
>>> numbered
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * APIC ID. If a crash happe=
ned on an AP, which then ends up
>>> as
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * boot CPU in the kdump() k=
ernel, then sending INIT to the
>>> real
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * BSP would reset the whole=
 system.
>>> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
>>
>>
>> Hi, Thomas,
>>
>> Unfortunately this causes a regression on Intel Meteorlake platform,
>> where the BSP APIC ID is NOT the lowest numbered APIC ID (instead,
>> CPU12, the first Ecore CPU, has APIC ID 0).
>
> Bah. Let me think about that.

In which order are the APICs/CPUs enumerated by ACPI?

