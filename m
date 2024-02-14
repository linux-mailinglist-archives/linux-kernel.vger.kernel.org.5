Return-Path: <linux-kernel+bounces-65681-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DD4985505A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 18:31:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0FDB1C28FA6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:31:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED7984FAE;
	Wed, 14 Feb 2024 17:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Karhp3sv"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A9D60864;
	Wed, 14 Feb 2024 17:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707931817; cv=none; b=cglDJEi/GbHD0Er5Mwb/ODPduMjDASTV1v0SRzroFywBMQPrZT3HU7pXxvuZ0stJnbgPvQ47UslAm0ctg60Fd1dbn/hkrEhe8lUT1eh/b0L13h6WGIuGup1wjiKZEqlbxuEyCBSdGO+TOK+xKi3L1RsAZ6NhoLz7YqyhPZteGRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707931817; c=relaxed/simple;
	bh=HZ9qmZcSPuSY5jAIcE8p58JuGYdTY069mXCOJcDpe+A=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TtGGPbPrRqfajow/thxKLl6MpT4bg+idEAXuxsLXERDs7qps7PDGxyQIBJB68rbknaWcije99q6G1FXNBi+2j/hBbarF2z2ybkXaQigVWbMtMbAdcc4C3AxORmMPv8oPtfeMeQMPdGPwpaM3QNwjM1jSotzBqXX0kELQQbtg74M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Karhp3sv; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41EHT9Md1365136
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Wed, 14 Feb 2024 09:29:10 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41EHT9Md1365136
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1707931753;
	bh=R/WZDnYxdeV5OyBWOlSWPYnEQWKsUCZqUR6ROzvXOGQ=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Karhp3sv7I69fUq4o03GusN7WmxeIL1g02tzWTMbqWYwa8rpE4F1Qd0ORGR8zqYfn
	 oVPUqRkdfZvxBwFgVSazeiWvh0txeGtmQSLnJkK2WdnbGip6sk5DhtJD/6Zqfz4yFF
	 zgYAIcF1l4ICoNf8NsFejjvw5FCplSlnH+9mXxhAB68gt0h+P7AvX2l8JoPySzMTgQ
	 3y63hqU4N1qpTXUCXSJVLinu9sylffFKUXFb4qSE9Rm0CUHjxZ0ImiTecH7u87L4IB
	 IUMD2Gg12lP3hrdDrpWAdLhhzM0GRvMn36iQI468u7BZr6cBRX+eUoH+YZiDQ1mExg
	 /4wv4070anAMg==
Date: Wed, 14 Feb 2024 09:29:06 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: =?UTF-8?Q?Petr_Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>
CC: Dave Hansen <dave.hansen@intel.com>,
        Petr Tesarik <petrtesarik@huaweicloud.com>,
        Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        Andy Lutomirski <luto@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, Xin Li <xin3.li@intel.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Kees Cook <keescook@chromium.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>, Ze Gao <zegao2021@gmail.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Kai Huang <kai.huang@intel.com>, David Woodhouse <dwmw@amazon.co.uk>,
        Brian Gerst <brgerst@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>,
        Joerg Roedel <jroedel@suse.de>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Tina Zhang <tina.zhang@intel.com>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Roberto Sassu <roberto.sassu@huaweicloud.com>,
        Petr Tesarik <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 0/8] x86_64 SandBox Mode arch hooks
User-Agent: K-9 Mail for Android
In-Reply-To: <20240214174143.74a4f10c@meshulam.tesarici.cz>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com> <c424618c-d6c6-430a-8975-8851a617204e@intel.com> <34B19756-91D3-4DA1-BE76-BD3122C16E95@zytor.com> <20240214174143.74a4f10c@meshulam.tesarici.cz>
Message-ID: <9EF956AB-DF48-4DAA-AB42-0FBC513ECA22@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 14, 2024 8:41:43 AM PST, "Petr Tesa=C5=99=C3=ADk" <petr@tesaric=
i=2Ecz> wrote:
>On Wed, 14 Feb 2024 07:28:35 -0800
>"H=2E Peter Anvin" <hpa@zytor=2Ecom> wrote:
>
>> On February 14, 2024 6:52:53 AM PST, Dave Hansen <dave=2Ehansen@intel=
=2Ecom> wrote:
>> >On 2/14/24 03:35, Petr Tesarik wrote: =20
>> >> This patch series implements x86_64 arch hooks for the generic SandB=
ox
>> >> Mode infrastructure=2E =20
>> >
>> >I think I'm missing a bit of context here=2E  What does one _do_ with
>> >SandBox Mode?  Why is it useful? =20
>>=20
>> Seriously=2E On the surface it looks like a really bad idea =E2=80=93 b=
asically an ad hoc, *more* privileged version of user shave=2E
>
>Hi hpa,
>
>I agree that it kind of tries to do "user mode without user mode"=2E
>There are some differences from actual user mode:
>
>First, from a process management POV, sandbox mode appears to be
>running in kernel mode=2E So, there is no way to use ptrace(2), send
>malicious signals or otherwise interact with the sandbox=2E In fact,
>the process can have three independent contexts: user mode, kernel mode
>and sandbox mode=2E
>
>Second, a sandbox can run unmodified kernel code and interact directly
>with other parts of the kernel=2E It's not really possible with this
>initial patch series, but the plan is that sandbox mode can share locks
>with the kernel=2E
>
>Third, sandbox code can be trusted for operations like parsing keys for
>the trusted keychain if the kernel is locked down, i=2Ee=2E when even a
>process with UID 0 is not on the same trust level as kernel mode=2E
>
>HTH
>Petr T
>

This, to me, seems like "all the downsides of a microkernel without the up=
sides=2E" Furthermore, it breaks security-hardening features like LASS and =
(to a lesser degree) SMAP=2E Not to mention dropping global pages?

All in all, I cannot see this as anything other than an enormous step in t=
he wrong direction, and it isn't even in the sense of "it is harmless if no=
one uses it" =E2=80=93 you are introducing architectural changes that are m=
ost definitely *very* harmful both to maintainers and users=2E

To me, this feels like paravirtualization all over again=2E 20 years later=
 we still have not been able to undo all the damage that did=2E



