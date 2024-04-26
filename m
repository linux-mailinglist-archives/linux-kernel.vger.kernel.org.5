Return-Path: <linux-kernel+bounces-160492-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA8528B3E35
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 19:32:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0AA3F1C22E87
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 17:32:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C19DF15ECDB;
	Fri, 26 Apr 2024 17:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="gyw4c2r+"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB30A13D529
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 17:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714152456; cv=none; b=LctFPWN+UwzWC5B3sK2CdJZKmivIBBWsvvpQf5owGL6GYdJqZB4PI1VcWxW22wanVddci4Zi1CXPwe0AXfBV+k7GB2RcskBoN7lA3oxEqQ4t+rvmS9jF2s8PAUSVM19++lw1j2rIQJxAk7mCXcrkM33xKA0HklYGUYQiGCRy5P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714152456; c=relaxed/simple;
	bh=CQbW8bFR+5CgJO4xI+Gz7Vs+daMlPtddT/SebYdgPcc=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=ARqmQJbZJklPfQBWxsmQ7KSJtFs6kAc1w0agQtNdJXePpxAJGLP6qV9yr48wbSDaT3VBDnHqzpRCFRQOlaemKQ2NBcvZXQ9XfoKWly8885OUrwuda6NIQcSkehklX9QgMBXJIbDoniTeUG6+kNmPZMreQqAJD20zQnKMfc3aHUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=gyw4c2r+; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 43QGqYiM2606441
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 26 Apr 2024 09:52:36 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 43QGqYiM2606441
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024041401; t=1714150357;
	bh=P1DjMKrM/knIFGSMl2AY75fhjxkSvrXCAaSH3ZCdtdw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=gyw4c2r+EEQICek1iuBElC5tvBNZ0mOP/DONV6gvtj/rK8/Wbsd4xfdAIAQ5/6mSr
	 PQIaeS6AXmDlVUU7mX0MjLtj5Gcao4yyQvhuLvfoiORx0qu9kHjV6CNin+rSd3PWNl
	 lCZCDlCtBzSEFH6DNK47sK2/hAMk5ulOB2rOBWQlC37FME9L4d6eHQzIO7AWc4HHyn
	 oo64LeHAev2ioxLCWkIm5pSTaBB1dWDiL4XM4f/kxcJlylIwDmaMR7NYmeGlh5pa0p
	 hT1j1AWHtxSCYndTudqnoJJ4esp3pHfZS/3TyJDFihxXF2LGelEtUp3sWxMxb8Em4b
	 OFGoO0Cm4hCxg==
Date: Fri, 26 Apr 2024 09:52:30 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Byungchul Park <byungchul@sk.com>, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
        jbohac@suse.cz, dyoung@redhat.com
CC: kernel_team@skhynix.com, linux-kernel@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v2=5D_x86/e820=3A_apply_=27mem=3D=27_boot_co?=
 =?US-ASCII?Q?mmand_while_reserving_memory_using_boot=5Fparams?=
User-Agent: K-9 Mail for Android
In-Reply-To: <20240426044018.GA24557@system.software.com>
References: <20240423102320.GA47818@system.software.com> <20240424010313.25264-1-byungchul@sk.com> <20240426044018.GA24557@system.software.com>
Message-ID: <B5CC9695-EFBF-405E-B5D2-69B2B6BC00FD@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On April 25, 2024 9:40:18 PM PDT, Byungchul Park <byungchul@sk=2Ecom> wrote=
:
>On Wed, Apr 24, 2024 at 10:03:13AM +0900, Byungchul Park wrote:
>> I might miss something=2E  Please lemme know if I go wrong=2E  Thanks=
=2E
>
>I started to work on it since I wanted to limit memory boundary using
>'mem=3D' boot command but it doesn't work=2E  However, while looking arou=
nd
>the code in more detail, I found the issue is about which one should
>have higher priority between:
>
>   1=2E boot command limiting memory boundary e=2Eg=2E 'mem=3D',
>   2=2E setup data of memory map from bootloader, boot_params=2E
>
>Based on the current code, setup data from bootloader has higher
>priority than boot command so the setup data can overwrite the user
>defined limit specified in boot command=2E  Is it inteded?
>
>   If yes, I should stop posting=2E
>   If not, I will keep posting with the following - v3=2E
>
>	Byungchul
>
>---
>
>diff --git a/arch/x86/kernel/e820=2Ec b/arch/x86/kernel/e820=2Ec
>index 6f1b379e3b38=2E=2E3bc593235b76 100644
>--- a/arch/x86/kernel/e820=2Ec
>+++ b/arch/x86/kernel/e820=2Ec
>@@ -879,6 +879,7 @@ static void __init early_panic(char *msg)
> }
>=20
> static int userdef __initdata;
>+static u64 userdef_mem_limit;
>=20
> /* The "mem=3Dnopentium" boot option disables 4MB page tables on 32-bit =
kernels: */
> static int __init parse_memopt(char *p)
>@@ -905,7 +906,10 @@ static int __init parse_memopt(char *p)
> 	if (mem_size =3D=3D 0)
> 		return -EINVAL;
>=20
>-	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
>+	if (userdef_mem_limit)
>+		userdef_mem_limit =3D min(userdef_mem_limit, mem_size);
>+	else
>+		userdef_mem_limit =3D mem_size;
>=20
> #ifdef CONFIG_MEMORY_HOTPLUG
> 	max_mem_size =3D mem_size;
>@@ -966,7 +970,10 @@ static int __init parse_memmap_one(char *p)
> 		else
> 			e820__range_remove(start_at, mem_size, 0, 0);
> 	} else {
>-		e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1);
>+		if (userdef_mem_limit)
>+			userdef_mem_limit =3D min(userdef_mem_limit, mem_size);
>+		else
>+			userdef_mem_limit =3D mem_size;
> 	}
>=20
> 	return *p =3D=3D '\0' ? 0 : -EINVAL;
>@@ -1050,6 +1057,11 @@ void __init e820__reserve_setup_data(void)
> void __init e820__finish_early_params(void)
> {
> 	if (userdef) {
>+		if (userdef_mem_limit)
>+			e820__range_remove(userdef_mem_limit,
>+					ULLONG_MAX - userdef_mem_limit,
>+					E820_TYPE_RAM, 1);
>+
> 		if (e820__update_table(e820_table) < 0)
> 			early_panic("Invalid user supplied memory map");
>=20
>---
>> 	Byungchul
>>=20
>> Changes from v1
>> 	1=2E before - handle boot_mem_limit assuming the default is U64_MAX=2E
>> 	   after  - handle boot_mem_limit assuming the default is 0=2E
>>=20
>> --->8---
>> >From e8bf247d6024b35af5300914dcff9135df9c1d66 Mon Sep 17 00:00:00 2001
>> From: Byungchul Park <byungchul@sk=2Ecom>
>> Date: Wed, 24 Apr 2024 09:55:25 +0900
>> Subject: [PATCH v2] x86/e820: apply 'mem=3D' boot command while reservi=
ng memory using boot_params
>>=20
>> When a user specifies 'mem=3D' boot command, it's expected to limit the
>> maximum address of usable memory for the kernel no matter what the
>> memory map source is=2E  However, 'mem=3D' boot command doesn't work si=
nce
>> it doesn't respect it when reserving memory using boot_params=2E
>>=20
>> Applied the restriction when reserving memory using boot_params=2E  Whi=
le
>> at it, renamed mem_size to a more specific name, boot_mem_limit=2E
>>=20
>> Signed-off-by: Byungchul Park <byungchul@sk=2Ecom>
>> ---
>>  arch/x86/kernel/e820=2Ec | 15 +++++++++------
>>  1 file changed, 9 insertions(+), 6 deletions(-)
>>=20
>> diff --git a/arch/x86/kernel/e820=2Ec b/arch/x86/kernel/e820=2Ec
>> index 6f1b379e3b38=2E=2Ee3f716128caf 100644
>> --- a/arch/x86/kernel/e820=2Ec
>> +++ b/arch/x86/kernel/e820=2Ec
>> @@ -880,11 +880,11 @@ static void __init early_panic(char *msg)
>> =20
>>  static int userdef __initdata;
>> =20
>> +static u64 boot_mem_limit;
>> +
>>  /* The "mem=3Dnopentium" boot option disables 4MB page tables on 32-bi=
t kernels: */
>>  static int __init parse_memopt(char *p)
>>  {
>> -	u64 mem_size;
>> -
>>  	if (!p)
>>  		return -EINVAL;
>> =20
>> @@ -899,16 +899,16 @@ static int __init parse_memopt(char *p)
>>  	}
>> =20
>>  	userdef =3D 1;
>> -	mem_size =3D memparse(p, &p);
>> +	boot_mem_limit =3D memparse(p, &p);
>> =20
>>  	/* Don't remove all memory when getting "mem=3D{invalid}" parameter: =
*/
>> -	if (mem_size =3D=3D 0)
>> +	if (boot_mem_limit =3D=3D 0)
>>  		return -EINVAL;
>> =20
>> -	e820__range_remove(mem_size, ULLONG_MAX - mem_size, E820_TYPE_RAM, 1)=
;
>> +	e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit, E820_=
TYPE_RAM, 1);
>> =20
>>  #ifdef CONFIG_MEMORY_HOTPLUG
>> -	max_mem_size =3D mem_size;
>> +	max_mem_size =3D boot_mem_limit;
>>  #endif
>> =20
>>  	return 0;
>> @@ -1036,6 +1036,9 @@ void __init e820__reserve_setup_data(void)
>>  		early_memunmap(data, len);
>>  	}
>> =20
>> +	if (boot_mem_limit)
>> +		e820__range_remove(boot_mem_limit, ULLONG_MAX - boot_mem_limit,
>> +				E820_TYPE_RESERVED_KERN, 1);
>>  	e820__update_table(e820_table);
>> =20
>>  	pr_info("extended physical RAM map:\n");
>> --=20
>> 2=2E17=2E1

mem=3D typically should cap the usable memory at that address=2E At one po=
int in history we also allowed it to add memory at the top, but modern syst=
ems have too complex memory maps; the memmap=3D option can be used for that=
, however=2E

