Return-Path: <linux-kernel+bounces-67137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873798566E4
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:07:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B9D291C218D5
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 15:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5392132C15;
	Thu, 15 Feb 2024 15:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EC/xk6Ve";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q3F+Rr+I"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AC8412B162
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 15:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708009629; cv=none; b=NKf/P8JJIbk2Bl1Al0J8QyU0Ew+1Z+ZD5hAAfJIvGG025LxhQj8R21rV6rQ+7yF0gFXIoG5NeVGxuWeR7ke05rN0FmqiupTbvpFeeBM8oEwa1cFhw+D5fGQLXHACqc2qZPhTDn7NHk6TMCDdsYjOxYyNhJWizaQCA4j3iwi72rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708009629; c=relaxed/simple;
	bh=2h7Nalua6B7zD6VVA6BFd2ENrLxcOo7tFBbNQHN80Zg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=j2n/H5X7yuF1LEqfEZQuNIRo8S5DMstCkXR38iUd4fwhRVRdk7Bg04wYpH2JTzEIyIy1U1Jt707/MjYBP/SXmKkwUXyK6gFgg924SfWFIx2ipp8SMDvWFfTXvHZ91gPE2sBSCbo3juFjA+GnXnCS3G7/HNBlvd/6Amr/kWHGB60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EC/xk6Ve; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q3F+Rr+I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708009625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kjFECKwp/gnEjyA2W0gSKVNPHcDB8rT+e0g8GRi/vA=;
	b=EC/xk6VeD1mldde92+gNANHelHktQHrxKuMk2WVBC2C77r0s9S4a4p+E8QY9B6UOpQsx93
	z8n25jcnOL7RWbPWrrh53SLwgpNDQG6cwq2UFnfWqwAuoTQf9fNGYUhEo1s/ge782p1C5w
	y/2x/Jrz3pzoNCi6d7AKUgKFCtkGfgYIkQxm94W2v8XOCHMiO/rkTDEywTwUKb5N0KJAVb
	JhBg8HuDmEMzG2fZ1kENCP8G4maYzeCVSfY9boWNAVA0Lqu+AhHC/U55UJjoxxyiumUZh/
	LqDvnwM6GlssjVVTTAiztX1HVyw8Bv2EAilUjjcNiTIZooGXTLCHg33SeHGddQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708009625;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kjFECKwp/gnEjyA2W0gSKVNPHcDB8rT+e0g8GRi/vA=;
	b=Q3F+Rr+It5GbOBoiUEy2iO5W961PEpIcI8HWMvg9cVDk0PUYtCUwQT2sqTXVo3lEe9y1va
	O4KE7WXkIUtVksDg==
To: Andy Shevchenko <andy.shevchenko@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Tom Lendacky
 <thomas.lendacky@amd.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Sohil Mehta <sohil.mehta@intel.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>, Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Wang Wendy <wendy.wang@intel.com>
Subject: Re: [patch V6a 01/19] x86/cpu: Provide cpuid_read() et al.
In-Reply-To: <CAHp75Vdo7-JqQuZ9ni5a=M3fFM76h4Gr5Babu6hEn0NO-tqpJg@mail.gmail.com>
References: <20240212153109.330805450@linutronix.de>
 <20240212153624.516965279@linutronix.de> <878r3mg570.ffs@tglx>
 <CAHp75Vdo7-JqQuZ9ni5a=M3fFM76h4Gr5Babu6hEn0NO-tqpJg@mail.gmail.com>
Date: Thu, 15 Feb 2024 16:07:05 +0100
Message-ID: <87edddepgm.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 15 2024 at 10:49, Andy Shevchenko wrote:

> On Wed, Feb 14, 2024 at 10:29=E2=80=AFPM Thomas Gleixner <tglx@linutronix=
de> wrote:
>>
>> Provide a few helper functions to read CPUID leafs or individual registe=
rs
>> into a data structure without requiring unions.
>
> ...
>
>> +#define cpuid_subleaf(leaf, subleaf, regs) {           \
>> +       BUILD_BUG_ON(sizeof(*(regs)) !=3D 16);            \
>> +       __cpuid_read(leaf, subleaf, (u32 *)(regs));     \
>> +}
>> +
>> +#define cpuid_leaf(leaf, regs) {                       \
>> +       BUILD_BUG_ON(sizeof(*(regs)) !=3D 16);            \
>> +       __cpuid_read(leaf, 0, (u32 *)(regs));           \
>> +}
>
> ...
>
>> +#define cpuid_subleaf_reg(leaf, subleaf, regidx, reg) {                \
>> +       BUILD_BUG_ON(sizeof(*(reg)) !=3D 4);                      \
>> +       __cpuid_read_reg(leaf, subleaf, regidx, (u32 *)(reg));  \
>> +}
>> +
>> +#define cpuid_leaf_reg(leaf, regidx, reg) {                    \
>> +       BUILD_BUG_ON(sizeof(*(reg)) !=3D 4);                      \
>> +       __cpuid_read_reg(leaf, 0, regidx, (u32 *)(reg));        \
>> +}
>
> I'm wondering if we can use static_assert() instead of BUILD_BUG_ON()
> in the above macros.

Probably.

