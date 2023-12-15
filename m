Return-Path: <linux-kernel+bounces-1809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C2BB815461
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:13:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C3D21F2574B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 23:13:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB98266AA0;
	Fri, 15 Dec 2023 23:12:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="rmx3YA5t"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B8166AB5;
	Fri, 15 Dec 2023 23:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 3BFNBwQr3824813
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Fri, 15 Dec 2023 15:11:59 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 3BFNBwQr3824813
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1702681920;
	bh=+cXHO0Rfxn/vgBJcrqdK1W3/bGHpwCG6TjuMmGG7kLo=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=rmx3YA5tXNNdJ3o6ByrvWBHrXw9btigN8zRwBe41aiDPCzIZrp7YO1mgkvWbTKDU1
	 Ef5ZOT0FC7RaQtfa3hN3WjbvV52Lk4fKaZQAVrk3OMj9y1thd24zIPPEbpHRv4k/A1
	 VbPdpYJjew2lmwZYhlqxW27EjStvIuOWo96Qx3GsyfdNeMpxgbMyjumj9s+ZmkNxAj
	 FIU/mpQ3yBT+UV9MK+2dOR+NEafoBVsYVVHFD4bWsZ0VUbb/yTSL28uVJTVO7Pp/Js
	 oGTjX9Q9JXi+beu2T17RBHpD5R8e+4n1gzV7/hHOAeAc4rLbeiqIP/Tq2RcuTPTVHY
	 247LcYleNMsEQ==
Date: Fri, 15 Dec 2023 15:11:56 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>, Chris Koch <chrisko@google.com>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, linux-doc@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org
CC: Cloud Hsu <cloudhsu@google.com>
Subject: Re: [PATCH] kexec: allocate kernel above bzImage's pref_address
User-Agent: K-9 Mail for Android
In-Reply-To: <b086fd82-2989-4987-a3f6-021a4ae9bec4@intel.com>
References: <20231215190521.3796022-1-chrisko@google.com> <b086fd82-2989-4987-a3f6-021a4ae9bec4@intel.com>
Message-ID: <F7B5D2B9-9CBF-4BF0-8665-6EF14A416168@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On December 15, 2023 1:17:00 PM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom=
> wrote:
>On 12/15/23 11:05, Chris Koch wrote:
>> A relocatable kernel will relocate itself to pref_address if it is
>> loaded below pref_address=2E This means a booted kernel may be relocati=
ng
>> itself to an area with reserved memory on modern systems, potentially
>> clobbering arbitrary data that may be important to the system=2E
>>=20
>> This is often the case, as the default value of PHYSICAL_START is
>> 0x1000000 and kernels are typically loaded at 0x100000 or above by
>> bootloaders like iPXE or kexec=2E GRUB behaves like this patch does=2E
>>=20
>> Also fixes the documentation around pref_address and PHYSICAL_START to
>> be accurate=2E
>
>Are you reporting a bug and is this a bug fix?  It's not super clear
>from the changelog=2E
>
>
>> diff --git a/Documentation/arch/x86/boot=2Erst b/Documentation/arch/x86=
/boot=2Erst
>> index 22cc7a040dae=2E=2E49bea8986620 100644
>> --- a/Documentation/arch/x86/boot=2Erst
>> +++ b/Documentation/arch/x86/boot=2Erst
>> @@ -878,7 +878,8 @@ Protocol:	2=2E10+
>>    address if possible=2E
>> =20
>>    A non-relocatable kernel will unconditionally move itself and to run
>> -  at this address=2E
>> +  at this address=2E A relocatable kernel will move itself to this add=
ress if it
>> +  loaded below this address=2E
>
>I think we should avoid saying the same things over and over again in
>different spots=2E
>
>Here, it doesn't really help to enumerate the different interpretations
>of 'pref_address'=2E  All that matters is that the bootloader can avoid
>the overhead of a later copy if it can place the kernel at
>'pref_address'=2E  The exact reasons that various kernels might decide to
>relocate are unimportant here=2E
>
>>  =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D	=3D=3D=3D=3D=3D=3D=3D
>>  Field name:	init_size
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 3762f41bb092=2E=2E1370f43328d7 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -2109,11 +2109,11 @@ config PHYSICAL_START
>>  	help
>>  	  This gives the physical address where the kernel is loaded=2E
>> =20
>> -	  If kernel is a not relocatable (CONFIG_RELOCATABLE=3Dn) then
>> -	  bzImage will decompress itself to above physical address and
>> -	  run from there=2E Otherwise, bzImage will run from the address wher=
e
>> -	  it has been loaded by the boot loader and will ignore above physica=
l
>> -	  address=2E
>> +	  If the kernel is not relocatable (CONFIG_RELOCATABLE=3Dn) then bzIm=
age
>> +	  will decompress itself to above physical address and run from there=
=2E
>> +	  Otherwise, bzImage will run from the address where it has been load=
ed
>> +	  by the boot loader=2E The only exception is if it is loaded below t=
he
>> +	  above physical address, in which case it will relocate itself there=
=2E
>
>I kinda dislike how this is written=2E  It's written almost like code
>where you're spelling out the conditions=2E  I prefer something much
>higher-level=2E
>
>	This gives a minimum physical address at which the kernel can be
>	loaded=2E
>
>	CONFIG_RELOCATABLE=3Dn kernels will be decompressed to and must
>	run at PHYSICAL_START exactly=2E
>
>	CONFIG_RELOCATABLE=3Dy kernels can run at any address above
>	PHYSICAL_START=2E  If a kernel is loaded below PHYSICAL_START, it
>	will relocate itself to PHYSICAL_START=2E
>
>>  	  In normal kdump cases one does not have to set/change this option
>>  	  as now bzImage can be compiled as a completely relocatable image
>> diff --git a/arch/x86/kernel/kexec-bzimage64=2Ec b/arch/x86/kernel/kexe=
c-bzimage64=2Ec
>> index a61c12c01270=2E=2E5dcd232d58bf 100644
>> --- a/arch/x86/kernel/kexec-bzimage64=2Ec
>> +++ b/arch/x86/kernel/kexec-bzimage64=2Ec
>> @@ -498,7 +498,10 @@ static void *bzImage64_load(struct kimage *image, =
char *kernel,
>>  	kbuf=2Ebufsz =3D  kernel_len - kern16_size;
>>  	kbuf=2Ememsz =3D PAGE_ALIGN(header->init_size);
>>  	kbuf=2Ebuf_align =3D header->kernel_alignment;
>> -	kbuf=2Ebuf_min =3D MIN_KERNEL_LOAD_ADDR;
>> +	if (header->pref_address < MIN_KERNEL_LOAD_ADDR)
>> +		kbuf=2Ebuf_min =3D MIN_KERNEL_LOAD_ADDR;
>> +	else
>> +		kbuf=2Ebuf_min =3D header->pref_address;
>>  	kbuf=2Emem =3D KEXEC_BUF_MEM_UNKNOWN;
>>  	ret =3D kexec_add_buffer(&kbuf);
>>  	if (ret)
>
>Comment, please=2E
>
>It isn't clear from this hunk why or how this fixes the bug=2E  How does
>this manage to avoid clobbering reserved areas?

Also, this really should go to stable, so please add the appropriate Cc:=
=2E

