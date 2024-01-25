Return-Path: <linux-kernel+bounces-38622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CC6D183C34E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3EA1C22837
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64CD950A9F;
	Thu, 25 Jan 2024 13:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Rfedy4bS"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7293050A95
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188116; cv=none; b=rQzabYUPFmxwrQSRSi1XDipomshzB2MPb5G1GKGnqHtS+pqsOEEvezWKwoEPLl9TY1gI9uyd8CU7L64NsTFN/oAP8wRjIXKP35zVFLMBU4xB5BHR3I4QZfAENb6rdOc5n8/IyWUGT52nbZN4FwX8fMYtr4L5i7YSM/FNQiJssTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188116; c=relaxed/simple;
	bh=DQw6SkbRWKUw+mEBZpF+BrHQJGhjrIcRv8sDzH/zTLY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=O8vdwBX2jnV9nk/3y/zRKBc4kFuGMlV2raHvGHYu7YTa567dpv/cwa3p7TUnztQ0Ef3xIhdjOjydRa8VFNhr5RBUh5DAenpD5UqbMMYiNRxpT/mXjTPNwuxdEbGuV+MqoNPf4zSyVQdwSyRdzVzIb4EfyOd94vqu5tW/vSi5jzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Rfedy4bS; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 40PD7ohH017921
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 25 Jan 2024 05:07:51 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 40PD7ohH017921
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024011201; t=1706188071;
	bh=aI9WJx+jYvQnEIH6Q4cNpzmMxlGwehYlGZIFWqI/BWw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Rfedy4bS6fJrYJhVwO0eqYNK7BQP/zUgo78ry7Yr0XwJ/z0GYR+jw0elS1t+7qCWH
	 8jYPWWx353vfXtxz0fwzh6DmXxtGax3lWkP6ubcNm7/3hSjbdwSg+IIq4u52f/6Xqm
	 LQk/AGVLDC0LpVfmwfoPPnLEdFQKRRce8Csw+vAu5q9Q6IZ0DT05i7lpvtEAKxGFRi
	 BBFCAY/BSVeceaGljlVQAXzLTlxiENwcU1R69l62KrL3V8tzF4v1xonvmRFz1gMejh
	 q2Egm2lH+Mp1L9GWFfPTTjMrLJOxNyktGMpWiJTNNZyfZF+Ock1ycy2/XIwtHNAMcz
	 Pt4KCLg3iqLHw==
Date: Thu, 25 Jan 2024 05:07:47 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andi Kleen <ak@linux.intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
CC: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Kai Huang <kai.huang@intel.com>,
        Sean Christopherson <seanjc@google.com>
Subject: =?US-ASCII?Q?Re=3A_=5BPATCHv3=2C_RESEND=5D_x86/trampoline=3A_Bypass_co?= =?US-ASCII?Q?mpat_mode_in_trampoline=5Fstart64=28=29_if_not_needed?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ZbIwfp-jOOlPNb1z@tassilo>
References: <20240124131510.496803-1-kirill.shutemov@linux.intel.com> <ZbIwfp-jOOlPNb1z@tassilo>
Message-ID: <E4904B95-C2EC-4FAF-9CB7-8F377CEA6972@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 25, 2024 1:57:18 AM PST, Andi Kleen <ak@linux=2Eintel=2Ecom> wro=
te:
>> +	/* Paging mode is correct proceed in 64-bit mode */
>> +
>> +	LOCK_AND_LOAD_REALMODE_ESP lock_rip=3D1
>> +
>> +	movw	$__KERNEL_DS, %dx
>> +	movl	%edx, %ss
>> +	addl	$pa_real_mode_base, %esp
>> +	movl	%edx, %ds
>> +	movl	%edx, %es
>> +	movl	%edx, %fs
>> +	movl	%edx, %gs
>> +
>> +	movl	$pa_trampoline_pgd, %eax
>> +	movq	%rax, %cr3
>> +
>> +	jmpq	*tr_start(%rip)
>
>Still think we should add a far jump here so that we run on a defined
>code segment=2E It probably doesn't matter since there are likely no
>IRETs before reloading anyways, but it seems cleaner=2E
>
>-Andi
>

Agreed=2E

