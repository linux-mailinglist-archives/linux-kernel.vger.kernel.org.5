Return-Path: <linux-kernel+bounces-87752-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF2186D885
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 02:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BF3D1C2101C
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 01:03:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E3E2B9C0;
	Fri,  1 Mar 2024 01:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Q0z8rjuy"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EEEB2AE91
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 01:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709254984; cv=none; b=usggtJC8LYkQmj93ybT64xDE/zegY9h/nirpMdYw3oopM1sh4bf+hDIjN2ytQAWvTEFeYtnL0L5R6/Y7dDqJmUVlPH/f65AlZKH4Ts0EEIur1STMJgbZpTOMRRtx4yZiTlBtyjvnse0REfjMY2j2rF1qQsyFAsmbfnDHEeV7CHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709254984; c=relaxed/simple;
	bh=05MZYy4lDluBOriklmJ4PdhytCgIptWMcjTspjOqH2I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=QkwAQwNDw4ritJ2u1EcEXSpGt7PBAaLoL3Qk33DZM9QZHU8+gN+sN43FNMHCRYkP4I0LSVU9wuMRNgQ2FroVosGV1owVooCg0QRQR9Z6cSOuveyCWUQxqAfSLt0YnZaphgsr2hqxyYOnY42pxuMsTuQrnFsISlbcGbvnsbJ0G+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=fail (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Q0z8rjuy reason="signature verification failed"; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42111jqq3251933
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 29 Feb 2024 17:01:47 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42111jqq3251933
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1709254907;
	bh=05MZYy4lDluBOriklmJ4PdhytCgIptWMcjTspjOqH2I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Q0z8rjuyYpIgo8y/BO5JvUzXwUsSMj1zmSwiHAPkj4SgseuKS3l4SNUsXOfjC0weF
	 zKE5Dqi46WDpFtyvnAWq4D8bSkK8zikXejdRLcn/3F9DcUIWKRmjQoDbjqUQnfykE1
	 763vNAXyjIhGC5u4HVxTx8pfyl3ApcL8Bz5XDHMrRk/0Itx+O2fYsPaNu4iHl+fEfr
	 hdr0CgqrK+z+ZZou9h+URYHmEZq5830ZGVKwfrEp4PSAeWx+vXR0jLA1fJq0SyZXj+
	 RScA04ADCRFOlx+YB9EDh2dcw9W6e2V9eUbrAqBcRymnU+P9u+fL5efyD5HNnXmpES
	 mT3UIc3R3L7bA==
Date: Thu, 29 Feb 2024 17:01:43 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: David Laight <David.Laight@ACULAB.COM>,
        "'Thorsten Blum'" <thorsten.blum@toblux.com>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
CC: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Wei Liu <wei.liu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] x86/apic: Use div64_ul() instead of do_div()
User-Agent: K-9 Mail for Android
In-Reply-To: <7e46123775e64898bd7c467328125ee0@AcuMS.aculab.com>
References: <20240227114333.1718-2-thorsten.blum@toblux.com> <7e46123775e64898bd7c467328125ee0@AcuMS.aculab.com>
Message-ID: <96394DFF-43D7-4877-AA47-FC847FD26184@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>=20
>> Change deltapm to unsigned long and replace do_div() with div64_ul()
>> which doesn't implicitly cast the divisor and doesn't unnecessarily
>> calculate the remainder=2E
>
>Eh? they are entirely different beasts=2E
>
>do_div() does a 64 by 32 divide that gives a 32bit quotient=2E
>div64_ul() does a much more expensive 64 by 64 divide that
>can generate a 64bit quotient=2E
>
>The remainder is pretty much free in both cases=2E
>If a cpu has a divide instruction it will almost certainly
>put the result in one register and the quotient in another=2E
>

Not on e=2Eg=2E RISC-V=2E




