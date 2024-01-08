Return-Path: <linux-kernel+bounces-20057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 83F8A8278CF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 20:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A912A1C22BA4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 19:58:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EE9754FB9;
	Mon,  8 Jan 2024 19:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="utQ7+oPC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B66954FA0
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 19:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 408JvoVv1846939
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 8 Jan 2024 11:57:50 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 408JvoVv1846939
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1704743871;
	bh=OvVaGxXbtl8/6PnA6OwplLOVm05R7l9BfkoSY3JmNfk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=utQ7+oPCAshQvOiLQ+dzNplaKqA3wvChiw6bNBexa9ySBPxrS4PGA7KrBRSfan51J
	 RnDtbzzurXsqvDkyYvDLv3GzhGh2C6ghk8XoeZ8y8m7o912hWf8VgShfrgW0K738jm
	 SjTcczZ4ImT/1GFUD3G2wValts+67napeSEeDzcrK/wEyKPj68YmNKgpq/xwTtPOD1
	 TZ2GSHflkkosFxDSdytqHdr21nlNmIJxrahhQ/v249hA3m4aA9XxM4WXAphlO9DTgI
	 Uw4EYYG0n5QWQGoSiOz6Mwud/GwP+FvrqM5r9KQd+Jh5eyqWIKDfijv1olVge8z2Sy
	 0HyoLCx+TiXFg==
Date: Mon, 08 Jan 2024 11:57:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Borislav Petkov <bp@alien8.de>, Aleksander Mazur <deweloper@wp.pl>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/Kconfig: Transmeta Crusoe is cpu family 5, not 6
User-Agent: K-9 Mail for Android
In-Reply-To: <20240107194716.GDZZr/xBl3+G8O7i7E@fat_crate.local>
References: <1517697968-19014-3-git-send-email-tedheadster@gmail.com> <20240107140609.2c1709e3@mocarz> <20240107194716.GDZZr/xBl3+G8O7i7E@fat_crate.local>
Message-ID: <30A7BB83-E44A-4082-B5DE-AB9FBF0AB555@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 7, 2024 11:47:16 AM PST, Borislav Petkov <bp@alien8=2Ede> wrote:
>On Sun, Jan 07, 2024 at 02:16:57PM +0100, Aleksander Mazur wrote:
>> I found out I am no longer able to boot kernel compiled with CONFIG_MCR=
USOE=3Dy on
>> my HP t5300 with CPU: Transmeta(tm) Crusoe(tm) Processor TM5500 (family=
: 0x5,
>> model: 0x4, stepping: 0x3)=2E It says:
>>=20
>> > This kernel requires an i686 CPU, but only detected an i586 CPU=2E
>> > Unable to boot - please use a kernel appropriate for your CPU=2E   =
=20
>>=20
>> It looks like this is caused by 25d76ac888216c369dea91768764728b8376979=
9 which
>> started setting X86_MINIMUM_CPU_FAMILY=3D6 for MCRUSOE while CPUID give=
s family=3D5=2E
>>=20
>> I was able to fix the problem with a patch included below=2E It just ch=
anges
>> X86_MINIMUM_CPU_FAMILY to 5
>
>=2E=2E=2E for MCRUSOE=2E
>
>> No other change was necessary (using -march=3Di686
>> seems fine)=2E
>>=20
>> /proc/cpuinfo:
>> processor	: 0
>> vendor_id	: GenuineTMx86
>> cpu family	: 5
>> model		: 4
>> model name	: Transmeta(tm) Crusoe(tm) Processor TM5500
>> stepping	: 3
>> cpu MHz		: 532=2E091
>> cache size	: 256 KB
>> fdiv_bug	: no
>> f00f_bug	: no
>> coma_bug	: no
>> fpu		: yes
>> fpu_exception	: yes
>> cpuid level	: 1
>> wp		: yes
>> flags		: fpu vme de pse tsc msr cx8 sep cmov mmx longrun lrti constant_=
tsc cpuid
>> bugs		: cpu_meltdown spectre_v1 spectre_v2 spec_store_bypass l1tf mds s=
wapgs itlb_multihit mmio_unknown
>> bogomips	: 1064=2E18
>> clflush size	: 32
>> cache_alignment	: 32
>> address sizes	: 32 bits physical, 32 bits virtual
>> power management:
>>=20
>> --- a/arch/x86/Kconfig=2Ecpu
>> +++ b/arch/x86/Kconfig=2Ecpu
>> @@ -375,7 +375,7 @@
>>  config X86_MINIMUM_CPU_FAMILY
>>  	int
>>  	default "64" if X86_64
>> -	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MP=
ENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCRUSOE || =
MCORE2 || MK7 || MK8)
>> +	default "6" if X86_32 && (MPENTIUM4 || MPENTIUMM || MPENTIUMIII || MP=
ENTIUMII || M686 || MVIAC3_2 || MVIAC7 || MEFFICEON || MATOM || MCORE2 || M=
K7 || MK8)
>>  	default "5" if X86_32 && X86_CMPXCHG64
>>  	default "4"
>
>Care to turn this into a proper patch with your SOB etc?
>
>Thx=2E
>

This is correct; Crusoe (TM3xxx/5xxx) implemented a 686 user level ISA but=
 a 586 system level ISA=2E

So please make a formal patch and add:

Acked-by: H=2E Peter Anvin <hpa@zytor=2Ecom>

