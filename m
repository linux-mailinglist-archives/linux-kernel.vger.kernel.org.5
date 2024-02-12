Return-Path: <linux-kernel+bounces-61911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CB2BF851846
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 879E7287387
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A69A3C6A3;
	Mon, 12 Feb 2024 15:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1YZBWIS+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ddIc2QxS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AECB3C495
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:39:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707752354; cv=none; b=LON0w273s7x2SLSMZGCxaEJMomlfkBUa8OuctKWF3mG7OgnHu44Qcc6xtVCnwoPEX1YSvRjVlxLPRBGu+DMaVYWo5XuF1rB9htLqXohlpvCqHGxh6P7PEHPMkrfxJFqfUPAa6FSSlF18aU+W6/2rTlPGispF0OxofG9589dw9uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707752354; c=relaxed/simple;
	bh=wjeNhK7kZBVuy9heSHBrmzMbANAKwBW8sfFYoS7YiDg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=M5F/Y4ChTqGpf8Lo1YfMRnByJdPFPj9yf8fP8qi61cVm41E6LSiU3dWBrtIvHX9m8r2q7ild6tjOpnKPkCdpviEwdoC7ZfBCbSuWxTaM53P0EcEVJkWOmIn0Kd915/g3RIB5a3BQceCDIifPSVvFevXjPxFnX1Mov7cuAPgwECg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1YZBWIS+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ddIc2QxS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707752351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzwovLOo0zq9drJi/JKb20aPld1efJPp16/7MuySCxE=;
	b=1YZBWIS+5XX7YwgmivTZVFmvj0dOUr/OZcuSaiuXTPhO+HVEs4vKMxtKi+8uHdwJ9vYAH8
	0nu3AuXp9RGWomNW0kDF5evKr1JP7ONMN4YTjzvfqcyDOXXIdsIoaq0WMCaEthtez74b24
	oOg4YUo/8Dzdyr17GgbN5jfhfoCdWJOtRp2wWufCOiRaFVv154VySCVVmymJQrrzjJvfOC
	Z7h6L53t7CExhPxflxxkiFeCfYomNhf/zpKJNgck7T4U0UXuw8uHfdcaPgcb2caQA2PxP7
	xLCNvzmfOsRKQUiybh8Xciwo06aKyUPL7nekKL0dQFbkp51xbYp7twb2CfWc+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707752351;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XzwovLOo0zq9drJi/JKb20aPld1efJPp16/7MuySCxE=;
	b=ddIc2QxSaWoASmSmg74hBd9py8FvL0afXJ9gxpXwCPBF++Lc1OgJ3T0QGyilp8hThyRlAd
	xAQSWWpKFvvF8HAQ==
To: Ashok Raj <ashok_raj@linux.intel.com>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, Tom Lendacky
 <thomas.lendacky@amd.com>, Andrew Cooper <andrew.cooper3@citrix.com>,
 Arjan van de Ven <arjan@linux.intel.com>, Huang Rui <ray.huang@amd.com>,
 Juergen Gross <jgross@suse.com>, Dimitri Sivanich
 <dimitri.sivanich@hpe.com>, Sohil Mehta <sohil.mehta@intel.com>, K Prateek
 Nayak <kprateek.nayak@amd.com>, Kan Liang <kan.liang@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, "Paul E. McKenney" <paulmck@kernel.org>,
 Feng Tang <feng.tang@intel.com>, Andy Shevchenko <andy@infradead.org>,
 Michael Kelley <mhklinux@outlook.com>, "Peter Zijlstra (Intel)"
 <peterz@infradead.org>, Andy Shevchenko <andy.shevchenko@gmail.com>, Wei
 Liu <wei.liu@kernel.org>, Ashok Raj <ashok.raj@intel.com>
Subject: Re: [patch V2 01/22] x86/cpu/topology: Make the APIC mismatch
 warnings complete
In-Reply-To: <ZbIvis3zHeQLZerL@araj-dh-work.jf.intel.com>
References: <20240117124704.044462658@linutronix.de>
 <20240117124902.403342409@linutronix.de>
 <ZbIvis3zHeQLZerL@araj-dh-work.jf.intel.com>
Date: Mon, 12 Feb 2024 16:39:11 +0100
Message-ID: <87ttmdk7z4.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jan 25 2024 at 01:53, Ashok Raj wrote:
> On Tue, Jan 23, 2024 at 02:10:04PM +0100, Thomas Gleixner wrote:
>> From: Thomas Gleixner <tglx@linutronix.de>
>> 
>> Detect all possible combinations of mismatch right in the CPUID evaluation
>> code.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> 
>> ---
>>  arch/x86/include/asm/apic.h           |    5 ++---
>>  arch/x86/kernel/cpu/common.c          |   15 ++-------------
>>  arch/x86/kernel/cpu/topology_common.c |   12 ++++++++++++
>>  3 files changed, 16 insertions(+), 16 deletions(-)
>
> [snip]
>
>> --- a/arch/x86/kernel/cpu/topology_common.c
>> +++ b/arch/x86/kernel/cpu/topology_common.c
>> @@ -177,6 +177,18 @@ void cpu_parse_topology(struct cpuinfo_x
>>  
>>  	parse_topology(&tscan, false);
>>  
>> +	if (IS_ENABLED(CONFIG_X86_LOCAL_APIC)) {
>> +		if (c->topo.initial_apicid != c->topo.apicid) {
>> +			pr_err(FW_BUG "CPU%4u: APIC ID mismatch. CPUID: 0x%04x APIC: 0x%04x\n",
>> +			       cpu, c->topo.initial_apicid, c->topo.apicid);
>> +		}
>> +
>> +		if (c->topo.apicid != cpuid_to_apicid[cpu]) {
>> +			pr_err(FW_BUG "CPU%4u: APIC ID mismatch. Firmware: 0x%04x APIC: 0x%04x\n",
>> +			       cpu, cpuid_to_apicid[cpu], c->topo.apicid);
>> +		}
>
> Should we consider tainting the kernel when there is any mismatch?

No strong opinion about that.

