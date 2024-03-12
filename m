Return-Path: <linux-kernel+bounces-99684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE3ED878BC0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:03:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4D022281C08
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:03:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B894A1D;
	Tue, 12 Mar 2024 00:03:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VNf9KMMe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90A5A4687
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:03:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201784; cv=none; b=OCteKq0XjkaDuAShyEvJ5eJg/09UX619bA6u93VJlMZiOCNNxZt9SWMnUU3EQj0FyIXRkOsR2W54PJEfwu5PUc0o7XB1m3/8GlkgKugUjAeFW+IgnqIjOsa4r0saHlCUiu6ykzlmToNK8sPDia6J936q/jxTlhKpJK2aoGhVV1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201784; c=relaxed/simple;
	bh=Xy1IpNmkx74HkGHEnoD2Rn57bHRubcUlWf43hiM06HU=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Z5G05U8SOsoW1qkW9JYowvkWw6Eir731WaRQufaLgAT7yqwt+cH3Mr7gOtE4AfkH1tG3h89rfkYncol62iDlYohZheAp4pkoQVhZkdyyzocIfc8wm62mYmKrGufMLd+EDKWijAxQf8COu+8eCDXYFvt1kh7NICPqxAgwTt9qgus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VNf9KMMe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8EACC433C7;
	Tue, 12 Mar 2024 00:03:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710201784;
	bh=Xy1IpNmkx74HkGHEnoD2Rn57bHRubcUlWf43hiM06HU=;
	h=In-Reply-To:References:Date:From:To:Cc:Subject:From;
	b=VNf9KMMeLDyE9G+vJ4mXaNp6zAKBDawH04UUWIEvTVPl2kAlULYPjl4IMg+uGdPs3
	 /zVyBXkWt4ruxoypyrt0wuyMVLZe+eLdmjjJSyrXNV5oo8eqZf8YNH1UL4A3VeuVKP
	 3aw6kK2QhJ5aaUih+Y0n5ffC0qj3zBv/iq7IrMbJ/69mkJXrhrwIHewl0HnqHRDxvW
	 C/GDWTt38hmyeABgWh1T+n9lytDVuAreg7R8tyntm6+9+eC0YdtW/mgaMIQyToFYwL
	 E/batZoUL7TktOsOYoue24skDMUbD7kBF5G0bpZI/WQwNJZwwRO7Duu/Nm1PnJiPxN
	 s0x04kf9oUMHw==
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailfauth.nyi.internal (Postfix) with ESMTP id 889931200043;
	Mon, 11 Mar 2024 20:03:01 -0400 (EDT)
Received: from imap48 ([10.202.2.98])
  by compute3.internal (MEProxy); Mon, 11 Mar 2024 20:03:01 -0400
X-ME-Sender: <xms:tJvvZS_9RC28yQ_G-Y-SxJAQUOZSDz0kTrMQ0-uMNSv9BGLycuS2bQ>
    <xme:tJvvZSsjIrMPJV2F9LRqn3j2wahHI9qEaxTJ6BaaCg9Fvp5ehteYg0jGdWxetFMDj
    swKcgrvNOtQ8w7OgSQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrjedvgddukecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehn
    ugihucfnuhhtohhmihhrshhkihdfuceolhhuthhosehkvghrnhgvlhdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudevffdvgedvfefhgeejjeelgfdtffeukedugfekuddvtedvudei
    leeugfejgefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprghnugihodhmvghsmhhtphgruhhthhhpvghrshhonhgrlhhithihqdduudeiudek
    heeifedvqddvieefudeiiedtkedqlhhuthhopeepkhgvrhhnvghlrdhorhhgsehlihhnuh
    igrdhluhhtohdruhhs
X-ME-Proxy: <xmx:tJvvZYDzJZ7cD5H93_omIC5KIkMc7SwYvh2jVTyLaqvuu5X_xSW5oQ>
    <xmx:tJvvZacZ0S2DuDQG__YGrfmyJfpaM7T95Q0uknuMfceqtnu7VMbViw>
    <xmx:tJvvZXO6SxN7xc1WVHh_X8gbEXChURRBeysNm475K4HTfoItuvpj3w>
    <xmx:tJvvZUlRrF05LtNG5R831fzxgxQ9kMOXCLqFrPPePbDbLU01Ahhb2w>
    <xmx:tZvvZQMS-C-G1_K7hY_lJFYBae0KPmksZnGRfx893CyjHAXngiS5yaNrgz3mNL3U>
Feedback-ID: ieff94742:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 7165C31A0066; Mon, 11 Mar 2024 20:03:00 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-251-g8332da0bf6-fm-20240305.001-g8332da0b
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <11e673cf-8bfa-4493-ab86-2f1f97ddd732@app.fastmail.com>
In-Reply-To: <08EFDEDB-7BBB-4D9C-B7E5-D7370EC609BE@gmail.com>
References: <20240311164638.2015063-1-pasha.tatashin@soleen.com>
 <20240311164638.2015063-12-pasha.tatashin@soleen.com>
 <3e180c07-53db-4acb-a75c-1a33447d81af@app.fastmail.com>
 <bedfa55b-b1d0-4e59-8c94-dbc5f8485a7f@intel.com>
 <ef0419dd-9d7b-4b77-b63a-5f11aaefb570@app.fastmail.com>
 <08EFDEDB-7BBB-4D9C-B7E5-D7370EC609BE@gmail.com>
Date: Mon, 11 Mar 2024 17:02:40 -0700
From: "Andy Lutomirski" <luto@kernel.org>
To: "Nadav Amit" <nadav.amit@gmail.com>
Cc: "Dave Hansen" <dave.hansen@intel.com>,
 "Pasha Tatashin" <pasha.tatashin@soleen.com>,
 "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
 linux-mm <linux-mm@kvack.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "the arch/x86 maintainers" <x86@kernel.org>,
 "Borislav Petkov" <bp@alien8.de>,
 "Christian Brauner" <brauner@kernel.org>, bristot@redhat.com,
 "Ben Segall" <bsegall@google.com>,
 "Dave Hansen" <dave.hansen@linux.intel.com>, dianders@chromium.org,
 dietmar.eggemann@arm.com, eric.devolder@oracle.com, hca@linux.ibm.com,
 "hch@infradead.org" <hch@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>,
 "Jacob Pan" <jacob.jun.pan@linux.intel.com>,
 "Jason Gunthorpe" <jgg@ziepe.ca>, jpoimboe@kernel.org,
 "Joerg Roedel" <jroedel@suse.de>, juri.lelli@redhat.com,
 "Kent Overstreet" <kent.overstreet@linux.dev>, kinseyho@google.com,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 lstoakes@gmail.com, mgorman@suse.de, mic@digikod.net,
 michael.christie@oracle.com, "Ingo Molnar" <mingo@redhat.com>,
 mjguzik@gmail.com, "Michael S. Tsirkin" <mst@redhat.com>,
 "Nicholas Piggin" <npiggin@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Petr Mladek" <pmladek@suse.com>,
 "Rick P Edgecombe" <rick.p.edgecombe@intel.com>,
 "Steven Rostedt" <rostedt@goodmis.org>,
 "Suren Baghdasaryan" <surenb@google.com>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Uladzislau Rezki" <urezki@gmail.com>, vincent.guittot@linaro.org,
 vschneid@redhat.com
Subject: Re: [RFC 11/14] x86: add support for Dynamic Kernel Stacks
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable



On Mon, Mar 11, 2024, at 4:56 PM, Nadav Amit wrote:
>> On 12 Mar 2024, at 1:41, Andy Lutomirski <luto@kernel.org> wrote:
>>=20
>> On Mon, Mar 11, 2024, at 4:34 PM, Dave Hansen wrote:
>>> On 3/11/24 15:17, Andy Lutomirski wrote:
>>>> I *think* that all x86 implementations won't fill the TLB for a
>>>> non-accessed page without also setting the accessed bit,
>>>=20
>>> That's my understanding as well.  The SDM is a little more obtuse ab=
out it:
>>>=20
>>>> Whenever the processor uses a paging-structure entry as part of
>>>> linear-address translation, it sets the accessed flag in that entry
>>>> (if it is not already set).
>>>=20
>>> but it's there.
>>>=20
>>> But if we start needing Accessed=3D1 to be accurate, clearing those =
PTEs
>>> gets more expensive because it needs to be atomic to lock out the pa=
ge
>>> walker.  It basically needs to start getting treated similarly to wh=
at
>>> is done for Dirty=3D1 on userspace PTEs.  Not the end of the world, =
of
>>> course, but one more source of overhead.
>>=20
>> In my fantasy land where I understand the x86 paging machinery, suppo=
se we're in finish_task_switch(), and suppose prev is Not Horribly Buggy=
 (TM).  In particular, suppose that no other CPU is concurrently (non-sp=
eculatively!) accessing prev's stack.  Prev can't be running, because wh=
atever magic lock prevents it from being migrated hasn't been released y=
et.  (I have no idea what lock this is, but it had darned well better ex=
ist so prev isn't migrated before switch_to() even returns.)
>>=20
>> So the current CPU is not accessing the memory, and no other CPU is a=
ccessing the memory, and BPF doesn't exist, so no one is being utterly d=
aft and a kernel read probe, and perf isn't up to any funny business, et=
c.  And a CPU will never *speculatively* set the accessed bit (I told yo=
u it's fantasy land), so we just do it unlocked:
>>=20
>> if (!pte->accessed) {
>>  *pte =3D 0;
>>  reuse the memory;
>> }
>>=20
>> What could possibly go wrong?
>>=20
>> I admit this is not the best idea I've ever had, and I will not waste=
 anyone's time by trying very hard to defend it :)
>>=20
>
> Just a thought: you don=E2=80=99t care if someone only reads from the =
stack's=20
> page (you can just install another page later). IOW: you only care if=20
> someone writes.
>
> So you can look on the dirty-bit, which is not being set speculatively=20
> and save yourself one problem.

Doesn't this buy a new problem?  Install a page, run the thread without =
using the page but speculatively load the PTE as read-only into the TLB,=
 context-switch out the thread, (entirely safely and correctly) determin=
e that the page wasn't used, remove it from the PTE, use it for somethin=
g else and fill it with things that aren't zero, run the thread again, a=
nd read from it.  Now it has some other thread's data!

One might slightly credibly argue that this isn't a problem -- between R=
SP and the bottom of the area that one nominally considers to the by the=
 stack is allowed to return arbitrary garbage, especially in the kernel =
where there's no red zone (until someone builds a kernel with a redzone =
on a FRED system, hmm), but this is still really weird.  If you *write* =
in that area, the CPU hopefully puts the *correct* value in the TLB and =
life goes on, but how much do you trust anyone to have validated what ha=
ppens when a PTE is present, writable and clean but the TLB contains a s=
tale entry pointing somewhere else?  And is it really okay to do this to=
 the poor kernel?

If we're going to add a TLB flush on context switch, then (a) we are bei=
ng rather silly and (b) we might as well just use atomics to play with t=
he accessed bit instead, I think.

