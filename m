Return-Path: <linux-kernel+bounces-33986-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8519D837174
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 19:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F8A01F2C977
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:59:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3FF50279;
	Mon, 22 Jan 2024 18:32:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="B1RosA8X"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E12DD3D0B0;
	Mon, 22 Jan 2024 18:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705948323; cv=none; b=JOOApoaFPpUwhXM3VXyZeoZaBhe5r2PlZtujpAVz0voZnpKeEKtzACH0NFlVnnbeqR7PZCV8HognVVNT12BbMo1GsJ4Fm/WR4s7qmEbTyFTUzDgAn8ChQoSqrNPf/8KVz0ru5vVcDQSeNxgrJXv1iBF5tVqwCEYKqKSRd0iA5NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705948323; c=relaxed/simple;
	bh=kQYBY/jXz8XA7HEvelLlvWZgjv2fyiFiZrCrN+kAE08=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=NnhqfN1cU0YDAhbV7Qu45jPpwWNUbMTgh9PQ0kzmDswsDObraD89e2gDRUKET7LZyS4QxI1hmtxlPKbGidCAz0EHlB57d5ZKp/mpOvPukyIowF2RVv+xENCMbaFLV3v4uU8WUEvHaUnD73nSCyFoHvQIsLvg6+M128Q5i+Eer3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=B1RosA8X; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40MIT1AI2664504
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Mon, 22 Jan 2024 10:29:02 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40MIT1AI2664504
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1705948144;
	bh=QCjl5w8ff3CMR72Hnb5PjbDlccx4tDMem9MqU3fld3c=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=B1RosA8XsV29moVdedwgLHhWvwsgILXvhW0cnqL3kqssx8+LP2fpVpgeXP9elD+pG
	 NvP3sVoclLIjbwKnJtlAMdYoFQMsyieqlPFdo6OwulQ/CTo54EDpJIA9BovLdM+pmu
	 d01iK1nRDbI/rd8sIVmU8kcgadwO7+KRZB7EUefGT2GJ1ua6yaK5wDWwrmFekPex5M
	 mGs21wFLqCpmX3iylKsnWRYBebobQrpZzaC7JYOqHM0t0KQmyPnueVibdAVZFRxSTX
	 43ctnDUMiixOANgCaQYJixq3Kjoe0zg/DosWuidgtZ/8IjJfD5RJ2+c0LiUsfjpQVW
	 V2QG0At5ci/BQ==
Date: Mon, 22 Jan 2024 10:28:58 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Dave Hansen <dave.hansen@intel.com>,
        Alexey Makhalov <alexey.makhalov@broadcom.com>,
        linux-kernel@vger.kernel.org, virtualization@lists.linux.dev,
        bp@alien8.de, dave.hansen@linux.intel.com, mingo@redhat.com,
        tglx@linutronix.de
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
In-Reply-To: <ff370e42-f48b-4c62-9b44-9d4031cd78b0@intel.com>
References: <20240109084052.58661-1-amakhalov@vmware.com> <20240109084052.58661-8-amakhalov@vmware.com> <ff370e42-f48b-4c62-9b44-9d4031cd78b0@intel.com>
Message-ID: <4CF87BC4-E8C8-4584-A275-5A985D5A18A1@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 22, 2024 8:32:22 AM PST, Dave Hansen <dave=2Ehansen@intel=2Ecom>=
 wrote:
>On 1/9/24 00:40, Alexey Makhalov wrote:
>> +#ifdef CONFIG_INTEL_TDX_GUEST
>> +unsigned long vmware_tdx_hypercall(unsigned long cmd,
>> +				   struct tdx_module_args *args)
>> +{
>> +	if (!hypervisor_is_type(X86_HYPER_VMWARE))
>> +		return ULONG_MAX;
>> +
>> +	if (cmd & ~VMWARE_CMD_MASK) {
>> +		pr_warn_once("Out of range command %lx\n", cmd);
>> +		return ULONG_MAX;
>> +	}
>> +
>> +	args->r10 =3D VMWARE_TDX_VENDOR_LEAF;
>> +	args->r11 =3D VMWARE_TDX_HCALL_FUNC;
>> +	args->r12 =3D VMWARE_HYPERVISOR_MAGIC;
>> +	args->r13 =3D cmd;
>> +	args->r15 =3D 0; /* CPL */
>> +
>> +	__tdx_hypercall(args);
>> +
>> +	return args->r12;
>> +}
>> +EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
>> +#endif
>
>This is the kind of wrapper that I was hoping for=2E  Thanks=2E
>
>Acked-by: Dave Hansen <dave=2Ehansen@linux=2Eintel=2Ecom>
>

I'm slightly confused by this TBH=2E

Why are the arguments passed in as a structure, which is modified by the w=
rapper to boot? This is analogous to a system call interface=2E

Furthermore, this is an out-of-line function; it should never be called wi=
th !X86_HYPER_VMWARE or you are introducing overhead for other hypervisors;=
 I believe a pr_warn_once() is in order at least, just as you have for the =
out-of-range test=2E




