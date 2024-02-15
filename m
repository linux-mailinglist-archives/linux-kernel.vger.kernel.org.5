Return-Path: <linux-kernel+bounces-66400-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 073C2855C30
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:18:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C5191C220C8
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9676414282;
	Thu, 15 Feb 2024 08:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="X+NfAZLU"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A6E13FEB;
	Thu, 15 Feb 2024 08:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985066; cv=none; b=IgcGOkL0dsvIN6zgMCG88VTEHTymzmk1vhzf1w80HNYgRY1SKJf+H651CV3SFoGhCz5hv0SSrlgmrypGAvCU6Luqd8suzAFb9iqLQpVwslnZ8XOaXnDvtm+C5tYonYwnJR4ekuU/JNN2QCc5lXvyvuH3IuOFCdBn0ca+/Qvllfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985066; c=relaxed/simple;
	bh=iHnSVR/o4PCirzYxOuLSrGJ0jY9TGuRvF1WutqVts7I=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=OqO1eb2lP/CttRYvcEVorfTYgfW68RW7Ri4karMgypxWvukI140AjOidb430BotcpDtlWEdCjF+TAeNTG11U9d99a5tD0FgFdBXvd/WODrwzQo/w/JmXdLB2AK+/v9ZOW744Yq4ZgMAVwbu8eeMWYnuPhN1mEQsZbjJg0aEleO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=X+NfAZLU; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 41F8GFuv1589561
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 15 Feb 2024 00:16:17 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 41F8GFuv1589561
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1707984986;
	bh=DD0WdTiLzRbhyl1lU6s1kmEpZNGlVGntzwYvTp/OgxY=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=X+NfAZLU3AMZ2IHW0uaYerX383bpCn8RbHJGNuGmq0cjQKG5LrKDq33I2OEvQYSLT
	 0NjaCa63zhtLiBZ30Q20vrgl1PEsarU7x8PGas74tO1ekvQpoY0qlTKxfgaBcNJti2
	 cY14+GNfZX47M1q+NL67uYeVxlNCLFKuKmzUbZVYCs18pynaAPZ7IJwPmv+IAGfb5W
	 LvJdMxN6A0iTLGNYgPgq/jJJ3gG1mxO+tN8dO40AkGvrYzCWE3ZLK4bT5Gm74mBhgr
	 dhdhGST5bk/3fyOdCd0rH2nNPJXr3kHC6NDDBNa7pPz0pwYownaMNn02nXNmX79rcT
	 41J1Ehzh2xorg==
Date: Thu, 15 Feb 2024 00:16:13 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
To: =?UTF-8?Q?Petr_Tesa=C5=99=C3=ADk?= <petr@tesarici.cz>,
        Xin Li <xin@zytor.com>
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
In-Reply-To: <20240215075932.66fef954@meshulam.tesarici.cz>
References: <20240214113516.2307-1-petrtesarik@huaweicloud.com> <c424618c-d6c6-430a-8975-8851a617204e@intel.com> <20240214192214.78734652@meshulam.tesarici.cz> <c66fa3f4-13f0-4355-9bf4-34fec31182de@zytor.com> <20240215075932.66fef954@meshulam.tesarici.cz>
Message-ID: <5434F240-2F74-4D9F-8BEE-220C8EC53C0F@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On February 14, 2024 10:59:32 PM PST, "Petr Tesa=C5=99=C3=ADk" <petr@tesari=
ci=2Ecz> wrote:
>On Wed, 14 Feb 2024 10:52:47 -0800
>Xin Li <xin@zytor=2Ecom> wrote:
>
>> On 2/14/2024 10:22 AM, Petr Tesa=C5=99=C3=ADk wrote:
>> > On Wed, 14 Feb 2024 06:52:53 -0800
>> > Dave Hansen <dave=2Ehansen@intel=2Ecom> wrote:
>> >  =20
>> >> On 2/14/24 03:35, Petr Tesarik wrote: =20
>> >>> This patch series implements x86_64 arch hooks for the generic Sand=
Box
>> >>> Mode infrastructure=2E =20
>> >>
>> >> I think I'm missing a bit of context here=2E  What does one _do_ wit=
h
>> >> SandBox Mode?  Why is it useful? =20
>> >=20
>> > I see, I split the patch series into the base infrastructure and the
>> > x86_64 implementation, but I forgot to merge the two recipient lists=
=2E
>> > :-(
>> >=20
>> > Anyway, in the long term I would like to work on gradual decompositio=
n
>> > of the kernel into a core part and many self-contained components=2E
>> > Sandbox mode is a useful tool to enforce isolation=2E
>> >=20
>> > In its current form, sandbox mode is too limited for that, but I'm
>> > trying to find some balance between "publish early" and reaching a
>> > feature level where some concrete examples can be shown=2E I'd rather
>> > fail fast than maintain hundreds of patches in an out-of-tree branch
>> > before submitting (and failing anyway)=2E
>> >=20
>> > Petr T
>> >  =20
>>=20
>> What you're proposing sounds a gigantic thing, which could potentially
>> impact all subsystems=2E
>
>True=2E Luckily, sandbox mode allows me to move gradually, one component
>at a time=2E
>
>>  Unless you prove it has big advantages with real
>> world usages, I guess nobody even wants to look into the patches=2E
>>=20
>> BTW, this seems another attempt to get the idea of micro-kernel into
>> Linux=2E
>
>We know it's not feasible to convert Linux to a micro-kernel=2E AFAICS
>that would require some kind of big switch, affecting all subsystems at
>once=2E
>
>But with a growing code base and more or less constant bug-per-LOC rate,
>people will continue to come up with some ideas how to limit the
>potential impact of each bug=2E Logically, one of the concepts that come
>to mind is decomposition=2E
>
>If my attempt helps to clarify how such decomposition should be done to
>be acceptable, it is worthwile=2E If nothing else, I can summarize the
>situation and ask Jonathan if he would kindly accept it as a LWN
>article=2E=2E=2E
>
>Petr T
>

I have been thinking more about this, and I'm more than ever convinced tha=
t exposing kernel memory to *any* kind of user space is a really, really ba=
d idea=2E It is not a door we ever want to open; once that line gets muddle=
d, the attack surface opens up dramatically=2E

And, in fact, we already have a sandbox mode in the kernel =E2=80=93 it is=
 called eBPF=2E 

