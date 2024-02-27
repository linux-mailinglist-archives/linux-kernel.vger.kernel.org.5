Return-Path: <linux-kernel+bounces-83611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACE27869C32
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:34:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4AA5D2918A3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:34:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEAC81DA4D;
	Tue, 27 Feb 2024 16:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="bQi6gSNI"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30EB71CD3E;
	Tue, 27 Feb 2024 16:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051675; cv=none; b=rBExxNvBihiN68w6LWyXgf5YBGnLfDoC1qSvcFiZBGfPusEjckB5NN6ykMkK/DPbyhZa6JNA8qNZR6x34J9mT/YPY7x8gmgimkxQVkMsZhJQNMFtpo0Z020TBPU9WaUo5rgHbwWr15Y7r+rjyKhss0dGnFZKkHe1zMx546PEQaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051675; c=relaxed/simple;
	bh=qEBzGDkMgdmuVcguzq0GaV4UtJ8S4emKApf0/ZnZ10I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=EfWE56UKDs2Bt3SNTN9VeC7/I4tZzRhd3scjpc8SAU57BHkvCJOlEkWhogRvskxF4RB1SvdOZrD8gYvLWHZIUAAhmRGZDvVIWnM4uOG6fzsW1ZfagGW87SxRcv4ki20EDtSfU6JcLIXBOImtr32owY46hh4FSxjFr/Y/ubWz+wY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=bQi6gSNI; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.208.254])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41RGX2Fr2314875
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Tue, 27 Feb 2024 08:33:04 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41RGX2Fr2314875
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1709051587;
	bh=HZEOIHwb3V/1D7cUZ0XGo95NAMXuauNS76pNRRQm74s=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=bQi6gSNI2dHkBGn7f/jCZgoUd4XQubS6qAYN6gV9F9dgEAW/vnJQMK0sB22MR4D8w
	 ScGNcWkjsOxumSmuy3xxyDRZ0ZHbaF/XHuVneV1M4suypKmwYm7C/SrD2gl79S+c20
	 827pMMF9fa5pP1BMp1E0zQbKK7reyiUikwP+Iqd82hsIC7Z1h73P+JdYyOf4cNikSX
	 rOGg7erwmnmmHmQ2soL8cL0zQj6Y6eJ8oMY7mX1uNS1Xx8h5RDAwa2mxhKqnIbwkij
	 Sc+knQnBy89soQHa2e5NMYPLek/KdPTlQo+/NjBwjOMDhOGSrnj64UuI12rLNM9/kv
	 k3WRmf5HPf9hA==
Date: Tue, 27 Feb 2024 08:32:51 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: =?ISO-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>,
        Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>
CC: Guixiong Wei <guixiongwei@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Luck <tony.luck@intel.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        Guixiong Wei <weiguixiong@bytedance.com>, Jann Horn <jannh@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        Chris Wright <chrisw@sous-sol.org>,
        Jeremy Fitzhardinge <jeremy@xensource.com>,
        Roland McGrath <roland@redhat.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH] x86, relocs: Ignore relocations in .notes section
User-Agent: K-9 Mail for Android
In-Reply-To: <0443c7c2-1c3f-4cf8-940d-88306956832a@suse.com>
References: <20240222171840.work.027-kees@kernel.org> <0443c7c2-1c3f-4cf8-940d-88306956832a@suse.com>
Message-ID: <18FD83CD-CCD3-44DE-A086-2317739BB488@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 27, 2024 8:13:35 AM PST, "J=C3=BCrgen Gro=C3=9F" <jgross@suse=
=2Ecom> wrote:
>On 22=2E02=2E24 18:18, Kees Cook wrote:
>> When building with CONFIG_XEN_PV=3Dy, =2Etext symbols are emitted into =
the
>> =2Enotes section so that Xen can find the "startup_xen" entry point=2E =
This
>> information is used prior to booting the kernel, so relocations are not
>> useful=2E In fact, performing relocations against the =2Enotes section =
means
>> that the KASLR base is exposed since /sys/kernel/notes is world-readabl=
e=2E
>>=20
>> To avoid leaking the KASLR base without breaking unprivileged tools tha=
t
>> are expecting to read /sys/kernel/notes, skip performing relocations in
>> the =2Enotes section=2E The values readable in =2Enotes are then identi=
cal to
>> those found in System=2Emap=2E
>>=20
>> Reported-by: Guixiong Wei <guixiongwei@gmail=2Ecom>
>> Closes: https://lore=2Ekernel=2Eorg/all/20240218073501=2E54555-1-guixio=
ngwei@gmail=2Ecom/
>> Fixes: 5ead97c84fa7 ("xen: Core Xen implementation")
>> Fixes: da1a679cde9b ("Add /sys/kernel/notes")
>> Signed-off-by: Kees Cook <keescook@chromium=2Eorg>
>> ---
>> Cc: Borislav Petkov <bp@alien8=2Ede>
>> Cc: Thomas Gleixner <tglx@linutronix=2Ede>
>> Cc: Ingo Molnar <mingo@redhat=2Ecom>
>> Cc: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>> Cc: x86@kernel=2Eorg
>> Cc: "H=2E Peter Anvin" <hpa@zytor=2Ecom>
>> Cc: "Peter Zijlstra (Intel)" <peterz@infradead=2Eorg>
>> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation=2Eorg>
>> Cc: Tony Luck <tony=2Eluck@intel=2Ecom>
>> Cc: Kristen Carlson Accardi <kristen@linux=2Eintel=2Ecom>
>> Cc: "J=C3=BCrgen Gro=C3=9F" <jgross@suse=2Ecom>
>> Cc: Boris Ostrovsky <boris=2Eostrovsky@oracle=2Ecom>
>> Cc: Stefano Stabellini <sstabellini@kernel=2Eorg>
>> Cc: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam=2Ecom>
>> Cc: Guixiong Wei <weiguixiong@bytedance=2Ecom>
>> Cc: Jann Horn <jannh@google=2Ecom>
>> ---
>>   arch/x86/tools/relocs=2Ec | 10 ++++++++++
>>   1 file changed, 10 insertions(+)
>>=20
>> diff --git a/arch/x86/tools/relocs=2Ec b/arch/x86/tools/relocs=2Ec
>> index a3bae2b24626=2E=2E0811fff23b9c 100644
>> --- a/arch/x86/tools/relocs=2Ec
>> +++ b/arch/x86/tools/relocs=2Ec
>> @@ -733,6 +733,16 @@ static void walk_relocs(int (*process)(struct sect=
ion *sec, Elf_Rel *rel,
>>   		if (sec->shdr=2Esh_type !=3D SHT_REL_TYPE) {
>>   			continue;
>>   		}
>> +
>> +		/*
>> +		 * Do not perform relocations in =2Enotes section; any
>> +		 * values there are meant for pre-boot consumption (e=2Eg=2E
>> +		 * startup_xen)=2E
>> +		 */
>> +		if (strcmp(sec_name(sec->shdr=2Esh_info), "=2Enotes") =3D=3D 0) {
>
>Instead of a strcmp(), wouldnt't =2E=2E=2E
>
>> +			continue;
>> +		}
>> +
>>   		sec_symtab  =3D sec->link;
>>   		sec_applies =3D &secs[sec->shdr=2Esh_info];
>>   		if (!(sec_applies->shdr=2Esh_flags & SHF_ALLOC)) {
>
>=2E=2E=2E a test of "sec_applies->shdr=2Esh_type =3D=3D SHT_NOTE" work as=
 well?
>
>In the end I'm fine with both variants, so:
>
>Reviewed-by: Juergen Gross <jgross@suse=2Ecom>
>
>
>Juergen

A type check would probably be better=2E=2E=2E

