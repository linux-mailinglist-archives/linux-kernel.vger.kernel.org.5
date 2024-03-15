Return-Path: <linux-kernel+bounces-104044-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A294F87C841
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 05:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C51C81C20FAC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 04:18:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70F76DDA3;
	Fri, 15 Mar 2024 04:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="CSFH5JgN"
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8AA1A38DA
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 04:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.137.202.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710476328; cv=none; b=S/UhBZMUkDB8/8UWFl28m7VGI0zVcpaBy8qIyS0T6eglKY60jdWfseGV41CqxyFK55Kd57oAVtoVibJ6zf5jGb74o9pp1EYJp37fJ35hQzXl0ApANzbl4pyXnKSlcow1E4onFEg1gKItqVPUJqo19EJWAU4tDBvI7AggopZeZ/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710476328; c=relaxed/simple;
	bh=q8ySlQnqmjbXttSatm/eJsBZ9frl9YXNLg8meFJvomI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=PrIQIxQRPrZdHP1gsqJAEJ2xxOM82uthzd0D49RoBEiZZc0UErfK0QyOZyN0lcLcT0exaOjVNmawlnmROXMSzfZx1bQfWAZOWLE8JJLzILDIWWdeDuPtBodqoWXY9AA2nksLBNEFPyA8sdPZRVyr3kht+8gHiea1OWZZza+eUrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com; spf=pass smtp.mailfrom=zytor.com; dkim=pass (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b=CSFH5JgN; arc=none smtp.client-ip=198.137.202.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=zytor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zytor.com
Received: from [IPv6:::1] ([172.56.209.149])
	(authenticated bits=0)
	by mail.zytor.com (8.17.2/8.17.1) with ESMTPSA id 42F4HbST3212843
	(version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
	Thu, 14 Mar 2024 21:17:38 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 42F4HbST3212843
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
	s=2024021201; t=1710476260;
	bh=SqTMj4Wh5NZGzZUAYRDmqwL2zLRWoDv8b2DEKp/sWFI=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:From;
	b=CSFH5JgNWS/jPex56HKrFi/r98Nnzn25mAlG0LJSb7vIkt8HASQQEmqQWjs3H/Hv5
	 0ZmTJ/d/VxdLK5Ol+C1D4LO/ItcRzotgN6pz6kSr+qaSW/YK6Q328B8PsWwC2YRduB
	 kxdxjxdWUAP4uLr8flRFP+ghFXXvsFM4auclsDvsYVShgjAHmK/g31BXmEYXEnV88u
	 APmWgk2ghsDTm5zRVJMk3NJSoPAlh02X+lA4RSghif4a5UU9j0HT9sqFwRNOP674NW
	 EWmwMAxcbPgA55wzFZ/IGdUZZIXdFvcyIIlxsxauGe4miwc/zX3rFpTP75PD7Q+1Qc
	 tHKtw80MC5++w==
Date: Thu, 14 Mar 2024 21:17:27 -0700
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
Message-ID: <A5238E27-88DB-4758-B630-22F17501AFD5@zytor.com>
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

From=20a reliability point of view it is better to die than to proceed with =
possible data loss=2E The latter is extremely serious=2E

However, the one way that this could be made to work would be with stack p=
robes, which could be compiler-inserted=2E The point is that you touch an o=
ffset below the stack pointer that is large enough that you cover not only =
the maximum amount of stack the function needs, but with an additional marg=
in, which includes enough space that you can safely take the #PF on the rem=
aining stack=2E

