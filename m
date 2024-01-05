Return-Path: <linux-kernel+bounces-17462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AD6B824D90
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 05:04:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDEF71F231BC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 04:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A49539C;
	Fri,  5 Jan 2024 04:03:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="PZYwagwf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9218538B
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 04:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 4054370r073557
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 4 Jan 2024 20:03:08 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 4054370r073557
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2023121201; t=1704427389;
	bh=SnC/4SLOc+IpabTEpVg7for4AVHORb87ZuavsdwBIiw=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=PZYwagwfnTHkUuqtMtJ0f9g4OK3BPi3qGGjWyb8EGPj9WSKXLe4fcPrchnbk1hfNE
	 CT5xHDQHuz8tA81bRhtynwIefw7uBn/C5Xz/JYKVMMDFO4OQsOYtms81RimGnaPZIe
	 22r9y23pEBQVoFWgD5Btc0Qf23NmaAP3GvgzBKfVoO2ypWmQHBPgOWEIdpAobQ343d
	 IoLAMBwrbRfD3/e9uk7OVNpCO15sQdrJWN0osZ1C3sukbs5RaSyZbiN4bQT3w/Y3Sp
	 rOcJRhVE/Sa+XmCfjzuM2JopvxEOWOX75mWHVMPBueT/BZonm1pNHEv1Y/V7BslbO1
	 zPhIIzTMhlIow==
Date: Thu, 04 Jan 2024 20:03:05 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: Andrew Cooper <andrew.cooper3@citrix.com>,
        Elizabeth Figura <zfigura@codeweavers.com>,
        Sean Christopherson <seanjc@google.com>
CC: x86@kernel.org, Linux Kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Ricardo Neri <ricardo.neri-calderon@linux.intel.com>,
        wine-devel@winehq.org
Subject: Re: x86 SGDT emulation for Wine
User-Agent: K-9 Mail for Android
In-Reply-To: <11f2135c-2b64-4a90-95ee-358c3f6117b5@citrix.com>
References: <2285758.taCxCBeP46@uriel> <ZZV65qJuJ67E_n9O@google.com> <1C37C311-CF8A-44EC-89B5-D826EF458708@zytor.com> <2451911.jE0xQCEvom@uriel> <B042BACA-839E-4A42-9BAA-AC7E58624250@zytor.com> <11f2135c-2b64-4a90-95ee-358c3f6117b5@citrix.com>
Message-ID: <AF7CF603-081F-4EA4-B149-3BFEE6AB6319@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On January 4, 2024 6:47:04 PM PST, Andrew Cooper <andrew=2Ecooper3@citrix=
=2Ecom> wrote:
>On 05/01/2024 1:02 am, H=2E Peter Anvin wrote:
>> Note that there is no fundamental reason you cannot run the Unix user s=
pace code inside the VM container, too; you only need to vmexit on an actua=
l system call=2E
>
>I know this is going on a tangent, but getting a VMExit on the SYSCALL
>instruction is surprisingly difficult=2E
>
>The "easy" way is to hide EFER=2ESCE behind the guests back, intercept #U=
D
>and emulate both the SYSCALL and SYSRET instructions=2E=C2=A0 It's slow, =
but it
>works=2E
>
>However, FRED completely prohibits tricks like this, because what you
>cannot reasonably do is clear CR4=2EFRED behind the back of a guest
>kernel=2E=C2=A0 You'd have to intercept and emulate all event sources in =
order
>to catch SYSCALL=2E
>
>I raised this as a concern during early review, but Intel has no
>official feature to take a VMExit on privilege change, and FRED
>(rightly) wasn't an appropriate vehicle to add such a feature, so it was
>deemed not an issue that the FRED design would break the unofficial ways
>that people were using to intercept/monitor/etc system calls=2E
>
>~Andrew
>
>P=2ES=2E Yes, there are more adventurous tricks like injecting a thunk in=
to
>the guest kernel and editing MSR_LSTAR behind the guest's back=2E=C2=A0 I=
n
>principle a similar trick works with FRED, but in order to do this to
>Windows, you also need to hook checkpatch to blind it to the thunk, and
>this is horribly invasive=2E

*In this case* it shouldn't be a problem, since the "guest operating syste=
m" would be virtually nonexistent and entirely puppeted by Wine=2E


