Return-Path: <linux-kernel+bounces-104031-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC66C87C80F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:42:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8224B283442
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 03:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 928CFDDA5;
	Fri, 15 Mar 2024 03:41:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Jb1Rt4Ce"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE135D528
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 03:41:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710474095; cv=none; b=TbYmP85fdin3GJJrCw+StO6d7F9//tuoEk40KRbIuKuaKe3jdIU1GkN458YB23q5LrravlaDM4UtaBU7FaPRud9jBIRMV2P60o8Qi2pJXfb0tMESWSs/Nl/mRqVm7Sqp722WiWTWoO0x46sP056SwJY7eYshmJWxSvMgYe9gYSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710474095; c=relaxed/simple;
	bh=HWsGCEmO2AXE45l6AUH2mlElxf0ufvAwcsY57vC0FRM=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=uaZIXkhmNvbrVGRP1x7rzUesBIkDDz5vyHrcO60zxeWhGgIVUOlUIHO1ZdfnC3qM1uKJr/mr1Zj1qV/LCDwCEVnScyr37iFbduskA4ELONqAlOwj1Yuxv6LKim7fNiWmHJutHDcnItnQevUHCQL3ACv52IrLZEmmt3Lx53uXjdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=Jb1Rt4Ce; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [127.0.0.1] ([76.133.66.138])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42F3de723195829
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 14 Mar 2024 20:39:40 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42F3de723195829
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1710473984;
	bh=d12bgbWcboIeLzPqweVBTKg7Wy5TnLglhiQB0KflxuE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=Jb1Rt4Ce4pcqjp00IixnEU0v/Uu7UQkorVXSeDw6i/ntNT45vLWnbKCQj62J6guYk
	 xu3rh4V9isDZu7pLQjh8crm8G0HhnbaB2zAmrZ/IspQFKExfW6MplY6U59A+iwzezy
	 2HXq6D6FNxtYCB3MYJB8x+7EW3853RsC3ILRThV90Bh1qUdcmYfA8DWMU21JDFX6ja
	 TGwvSIWJqPn8IdNhwdG5/sIxxkyTd3ga1+gaHwjZLloC6jBuPfOUzjJ81qVK7Li5uA
	 KzI6iRovLwf11OwPSaLiK5k8HZPnz63SYnV9dzIfHZ0sxLxOOdOEO8rM0ysgaW9KTm
	 TX2qdoW5Q2UDw==
Date: Thu, 14 Mar 2024 20:39:36 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
To: Pasha Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>
CC: Kent Overstreet <kent.overstreet@linux.dev>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, akpm@linux-foundation.org, x86@kernel.org,
        bp@alien8.de, brauner@kernel.org, bristot@redhat.com,
        bsegall@google.com, dave.hansen@linux.intel.com, dianders@chromium.org,
        dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
        hch@infradead.org, jacob.jun.pan@linux.intel.com, jgg@ziepe.ca,
        jpoimboe@kernel.org, jroedel@suse.de, juri.lelli@redhat.com,
        kinseyho@google.com, kirill.shutemov@linux.intel.com,
        lstoakes@gmail.com, luto@kernel.org, mgorman@suse.de, mic@digikod.net,
        michael.christie@oracle.com, mingo@redhat.com, mjguzik@gmail.com,
        mst@redhat.com, npiggin@gmail.com, peterz@infradead.org,
        pmladek@suse.com, rick.p.edgecombe@intel.com, rostedt@goodmis.org,
        surenb@google.com, tglx@linutronix.de, urezki@gmail.com,
        vincent.guittot@linaro.org, vschneid@redhat.com
Subject: Re: [RFC 00/14] Dynamic Kernel Stacks
User-Agent: K-9 Mail for Android
In-Reply-To: <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com> <2cb8f02d-f21e-45d2-afe2-d1c6225240f3@zytor.com> <ZfNTSjfE_w50Otnz@casper.infradead.org> <2qp4uegb4kqkryihqyo6v3fzoc2nysuhltc535kxnh6ozpo5ni@isilzw7nth42> <ZfNWojLB7qjjB0Zw@casper.infradead.org> <CA+CK2bAmOj2J10szVijNikexFZ1gmA913vvxnqW4DJKWQikwqQ@mail.gmail.com>
Message-ID: <39F17EC4-7844-4111-BF7D-FFC97B05D9FA@zytor.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

On March 14, 2024 8:13:56 PM PDT, Pasha Tatashin <pasha=2Etatashin@soleen=
=2Ecom> wrote:
>On Thu, Mar 14, 2024 at 3:57=E2=80=AFPM Matthew Wilcox <willy@infradead=
=2Eorg> wrote:
>>
>> On Thu, Mar 14, 2024 at 03:53:39PM -0400, Kent Overstreet wrote:
>> > On Thu, Mar 14, 2024 at 07:43:06PM +0000, Matthew Wilcox wrote:
>> > > On Tue, Mar 12, 2024 at 10:18:10AM -0700, H=2E Peter Anvin wrote:
>> > > > Second, non-dynamic kernel memory is one of the core design decis=
ions in
>> > > > Linux from early on=2E This means there are lot of deeply embedde=
d assumptions
>> > > > which would have to be untangled=2E
>> > >
>> > > I think there are other ways of getting the benefit that Pasha is s=
eeking
>> > > without moving to dynamically allocated kernel memory=2E  One icky =
thing
>> > > that XFS does is punt work over to a kernel thread in order to use =
more
>> > > stack!  That breaks a number of things including lockdep (because t=
he
>> > > kernel thread doesn't own the lock, the thread waiting for the kern=
el
>> > > thread owns the lock)=2E
>> > >
>> > > If we had segmented stacks, XFS could say "I need at least 6kB of s=
tack",
>> > > and if less than that was available, we could allocate a temporary
>> > > stack and switch to it=2E  I suspect Google would also be able to u=
se this
>> > > API for their rare cases when they need more than 8kB of kernel sta=
ck=2E
>> > > Who knows, we might all be able to use such a thing=2E
>> > >
>> > > I'd been thinking about this from the point of view of allocating m=
ore
>> > > stack elsewhere in kernel space, but combining what Pasha has done =
here
>> > > with this idea might lead to a hybrid approach that works better; a=
llocate
>> > > 32kB of vmap space per kernel thread, put 12kB of memory at the top=
 of it,
>> > > rely on people using this "I need more stack" API correctly, and fr=
ee the
>> > > excess pages on return to userspace=2E  No complicated "switch stac=
ks" API
>> > > needed, just an "ensure we have at least N bytes of stack remaining=
" API=2E
>
>I like this approach! I think we could also consider having permanent
>big stacks for some kernel only threads like kvm-vcpu=2E A cooperative
>stack increase framework could work well and wouldn't negatively
>impact the performance of context switching=2E However, thorough
>analysis would be necessary to proactively identify potential stack
>overflow situations=2E
>
>> > Why would we need an "I need more stack" API? Pasha's approach seems
>> > like everything we need for what you're talking about=2E
>>
>> Because double faults are hard, possibly impossible, and the FRED appro=
ach
>> Peter described has extra overhead?  This was all described up-thread=
=2E
>
>Handling faults in #DF is possible=2E It requires code inspection to
>handle race conditions such as what was shown by tglx=2E However, as
>Andy pointed out, this is not supported by SDM as it is an abort
>context (yet we return from it because of ESPFIX64, so return is
>possible)=2E
>
>My question, however, if we ignore memory savings and only consider
>reliability aspect of this feature=2E  What is better unconditionally
>crashing the machine because a guard page was reached, or printing a
>huge warning with a backtracing information about the offending stack,
>handling the fault, and survive? I know that historically Linus
>preferred WARN() to BUG() [1]=2E But, this is a somewhat different
>scenario compared to simple BUG vs WARN=2E
>
>Pasha
>
>[1] https://lore=2Ekernel=2Eorg/all/Pine=2ELNX=2E4=2E44=2E0209091832160=
=2E1714-100000@home=2Etransmeta=2Ecom
>

The real issue with using #DF is that if the event that caused it was asyn=
chronous, you could lose the event=2E

