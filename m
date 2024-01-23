Return-Path: <linux-kernel+bounces-34447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F48B837CA6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:13:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CE19BB28103
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:59:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24A9214C59B;
	Tue, 23 Jan 2024 00:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="NR/AlsA7"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C02B514AD2B;
	Tue, 23 Jan 2024 00:21:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705969269; cv=none; b=IlyxtpcUI2EZS6ivS8enF4XZSvlRjnw0r7ePWsK8Pevm9/3fVMXTRlGk/9QFXZIsLVc5UGv09MEOl//uwV/SELL84YCMxH0ghuPEnytFyR5uIaAM9iWNckYjPuHlzUA5o45fMTv7w43YkX820HD2EgAfKULZFbgDk0paYucWQ/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705969269; c=relaxed/simple;
	bh=m55lPpC+NBSE/XcmCcD0E6mFq9o/I9MNWdauqqDofbk=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=liJsnAWKL7UqpFgQyy2vA+WRWaS+h2d31h89skP4AMlVG9JMHh5g0df7F8wDKL1pLsPsCCP3ZCCNh96OnqAveMeyMQU2uxhLI6RYLQ/yk8+fqGJc+tic1eW9vy/TwTfQmvVrj2ECIxgixR7apGslRXWsRFobtxD8J7a1cnnJJEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=NR/AlsA7; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40N0HoLc2798528
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 22 Jan 2024 16:17:50 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40N0HoLc2798528
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1705969072;
	bh=naevb4PslKTi+uWE0rIwkjLfQkOH3+GqKQddGwCKH50=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=NR/AlsA7je5VAyZlNPTZHvXBBzujylBLOIxmnxF4bzZa+iaBvnN8bscZ+p5JkQaJH
	 ktK2PFVspY/AnvBR1rDjgiy5C0pQbhgGOCSnz2c+7QoE2VKG/r5QNRvd9rUsX6u926
	 B18RybD5ChPM2oeC+/dkh75st/RyLCw4gBhEDZ/8NXV1GEGVVBn5HwNKITtSiD+b6B
	 RNxHsmhbX42aaKRVUIOUymXOHS/xUCX8Nxf7gg67sU9XnG8TdgCwPUGRJ89WxOxQA0
	 OHPPuDDGIkVBhGIrtxVa5Ur7uJX/H/QbZqQXpUttoMMbAuhTGzmigvLcbNcDG5iX8f
	 xhMr6LuORnThg==
Date: Mon, 22 Jan 2024 16:17:48 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Alexey Makhalov <alexey.makhalov@broadcom.com>,
        Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        virtualization@lists.linux.dev, bp@alien8.de,
        dave.hansen@linux.intel.com, mingo@redhat.com, tglx@linutronix.de
CC: x86@kernel.org, netdev@vger.kernel.org, richardcochran@gmail.com,
        linux-input@vger.kernel.org, dmitry.torokhov@gmail.com,
        zackr@vmware.com, linux-graphics-maintainer@vmware.com,
        pv-drivers@vmware.com, namit@vmware.com, timothym@vmware.com,
        akaher@vmware.com, jsipek@vmware.com, dri-devel@lists.freedesktop.org,
        daniel@ffwll.ch, airlied@gmail.com, tzimmermann@suse.de,
        mripard@kernel.org, maarten.lankhorst@linux.intel.com,
        horms@kernel.org, kirill.shutemov@linux.intel.com
Subject: Re: [PATCH v6 7/7] x86/vmware: Add TDX hypercall support
User-Agent: K-9 Mail for Android
In-Reply-To: <c01cecef-db06-49d8-aa2e-548908c65861@broadcom.com>
References: <20240109084052.58661-1-amakhalov@vmware.com> <20240109084052.58661-8-amakhalov@vmware.com> <ff370e42-f48b-4c62-9b44-9d4031cd78b0@intel.com> <4CF87BC4-E8C8-4584-A275-5A985D5A18A1@zytor.com> <c01cecef-db06-49d8-aa2e-548908c65861@broadcom.com>
Message-ID: <351B1153-9CBE-4774-9FAF-770F9F36856E@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 22, 2024 4:04:33 PM PST, Alexey Makhalov <alexey=2Emakhalov@broa=
dcom=2Ecom> wrote:
>
>
>On 1/22/24 10:28 AM, H=2E Peter Anvin wrote:
>> On January 22, 2024 8:32:22 AM PST, Dave Hansen <dave=2Ehansen@intel=2E=
com> wrote:
>>> On 1/9/24 00:40, Alexey Makhalov wrote:
>>>> +#ifdef CONFIG_INTEL_TDX_GUEST
>>>> +unsigned long vmware_tdx_hypercall(unsigned long cmd,
>>>> +				   struct tdx_module_args *args)
>>>> +{
>>>> +	if (!hypervisor_is_type(X86_HYPER_VMWARE))
>>>> +		return ULONG_MAX;
>>>> +
>>>> +	if (cmd & ~VMWARE_CMD_MASK) {
>>>> +		pr_warn_once("Out of range command %lx\n", cmd);
>>>> +		return ULONG_MAX;
>>>> +	}
>>>> +
>>>> +	args->r10 =3D VMWARE_TDX_VENDOR_LEAF;
>>>> +	args->r11 =3D VMWARE_TDX_HCALL_FUNC;
>>>> +	args->r12 =3D VMWARE_HYPERVISOR_MAGIC;
>>>> +	args->r13 =3D cmd;
>>>> +	args->r15 =3D 0; /* CPL */
>>>> +
>>>> +	__tdx_hypercall(args);
>>>> +
>>>> +	return args->r12;
>>>> +}
>>>> +EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
>>>> +#endif
>>>=20
>>> This is the kind of wrapper that I was hoping for=2E  Thanks=2E
>>>=20
>>> Acked-by: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>>>=20
>>=20
>> I'm slightly confused by this TBH=2E
>>=20
>> Why are the arguments passed in as a structure, which is modified by th=
e wrapper to boot? This is analogous to a system call interface=2E
>>=20
>> Furthermore, this is an out-of-line function; it should never be called=
 with !X86_HYPER_VMWARE or you are introducing overhead for other hyperviso=
rs; I believe a pr_warn_once() is in order at least, just as you have for t=
he out-of-range test=2E
>>=20
>
>This patch series introduces vmware_hypercall family of functions similar=
 to kvm_hypercall=2E Similarity: both vmware and kvm implementations are st=
atic inline functions and both of them use __tdx_hypercall (global not expo=
rted symbol)=2E Difference: kvm_hypercall functions are used _only_ within =
the kernel, but vmware_hypercall are also used by modules=2E
>Exporting __tdx_hypercall function is an original Dave's concern=2E
>So we ended up with exporting wrapper, not generic, but VMware specific w=
ith added checks against arbitrary use=2E
>vmware_tdx_hypercall is not designed for !X86_HYPER_VMWARE callers=2E But=
 such a calls are not forbidden=2E
>Arguments in a structure is an API for __tdx_hypercall()=2E Input and out=
put argument handling are done by vmware_hypercall callers, while VMware sp=
ecific dress up is inside the wrapper=2E
>
>Peter, do you think code comments are required to make it clear for the r=
eader?
>
>

TBH that explanation didn't make much sense to me=2E=2E=2E

