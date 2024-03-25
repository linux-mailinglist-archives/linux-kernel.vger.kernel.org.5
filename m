Return-Path: <linux-kernel+bounces-116924-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D64F88A535
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3150D1C3BBA3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6417A374;
	Mon, 25 Mar 2024 11:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="OK/isPdT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qv+awkv1"
Received: from wfhigh1-smtp.messagingengine.com (wfhigh1-smtp.messagingengine.com [64.147.123.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FD21BB063
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 11:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.123.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711365336; cv=none; b=DLXacpNsVvHB9hYRmrru0IrKdzwl6JKLC9e5HacpTtHXd83IKcgFXqLBrxM6rfwatsXWRL7r5BRc/SVVR9Je/oQAGQ8/NfVv+mJNA+OWi61Zyui/B64CekNkV8zf8L5FQqPlUYlw2I8orX4GGhtE268uggShGk1syNqeOt386hY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711365336; c=relaxed/simple;
	bh=opKIsZlMHtQnbJCvVr82tpAN2qU/VqAhSCB8KlJlM5M=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=ImG1wXXcb5T/QaZJ3258vm8A1M+xmwZmssxQzea1xs15d2q6gbkFHwjbUcRigFXy66USx5XTop5h8db0fgFGjg6ft4zsGeuccTtzdlhHk6aCDVNRh1tF0Xg/iouYoGNSI5zSCRvVa5USDCEYCWHOQ4U/09rwyFAu4l327WlLO2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=OK/isPdT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qv+awkv1; arc=none smtp.client-ip=64.147.123.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.west.internal (Postfix) with ESMTP id 0646718000B9;
	Mon, 25 Mar 2024 07:15:31 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Mon, 25 Mar 2024 07:15:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1711365331; x=1711451731; bh=z4Kn3pYXpg
	iAUzuK6QDRYyQRhLD9Dn62eTCOSq5cUP0=; b=OK/isPdTFrqQI/4cMYOrrqmGXY
	50PVXN4faVpZIDcM+nQKPpcJsp8HKY6A9pBrXO25gQi+mYZ4l5Q4806IAHF61oe6
	vYdvO37FtnvSCUNe5a/4Z1MNY7hoJeXyKtWc67mhdln7SQLItMMxArbqaU9LN4Kf
	BTeyDytZXE798uApFj79OBg/0EAduNeiSLTZkWADUBGZyjLKzJ1eTOSDvo761KeS
	iCJkRAEtxRB6m051iHakUQ5tVjstrcpLVuMHAVRuQQ7qPL6EPTmKGfFJ9x8dzq2w
	jI9k6qR7nfTjEml7e8cc4AjeEwpv2ffj//ESIkh7r2OALMAelwzZC0gC7dKA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1711365331; x=1711451731; bh=z4Kn3pYXpgiAUzuK6QDRYyQRhLD9
	Dn62eTCOSq5cUP0=; b=qv+awkv1sbrET62JITAJj90ptP70MGbPz7R3Gjx4kMkc
	cl2bPh7jZ8YuPY3qLCzYTTX/TzqNJjKeAP+eEBHzGfomJd6PcC0dLfEUUlaxui8l
	gTK14QDH8bkmPJ7yk+LuZ8gRtpuX+8XnRBjI5AxvEJcIXJvrLvWfBVl1ZEUITyT5
	/UmJ3BDZQHoNWi/WWcv9visDEDgFXxghMrfBH791hSWJlKGIFrEMci+d8/rNPb/P
	Td6RUt9NUsKD4sKU8ybS8GiKybSzzr2K0pMKfMnbQ1Z+alinCTYDcTA/3Hh8BEhN
	F4ruMTa6bkaZvYLcf+c7FIOkUb9gedPC+Buh2OTrVg==
X-ME-Sender: <xms:0lwBZtFlkc1Qusdnb7X2qc5O0CWLEcLcEBVz8OlPKUaCbcGqsekPzw>
    <xme:0lwBZiU8BIvpw8bBNAUhMi8oIO_Ic0R5pZdW6LgrSzenfIXwDAVYhzSfWSJd714kK
    78uKdQlMT8eje1xaso>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledruddutddgtddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:0lwBZvIxU3418h9r7_7_YGXQCVYmdnfBlE3H_f4MCoT8-b-nocsmwA>
    <xmx:0lwBZjEcR7SytizyU22xpbU8_2_DAUqKXq-Uarh7GAkD9xsFaFu8Cg>
    <xmx:0lwBZjXLCl1abgLtHWhjhGIrmxqsqxmcUNBzteNe55B7idOBI1plJg>
    <xmx:0lwBZuO_7Btlq_JCa03ENVLAqth5_XaUIJX8CVB7X5ZR7h7Nq75iUQ>
    <xmx:01wBZla5cOtoDHFvE1nxDg54FdptwvAiX3FXDwD3x8cpjOZP958RLMOmAn8>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8969FB6008D; Mon, 25 Mar 2024 07:15:30 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-332-gdeb4194079-fm-20240319.002-gdeb41940
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <eaa73bca-1e81-4a6f-a89f-e63329d359f9@app.fastmail.com>
In-Reply-To: <1883cf6b-7756-405b-a843-d8ae31e01d61@ghiti.fr>
References: <20240313180010.295747-1-samuel.holland@sifive.com>
 <CAHVXubjLWZkjSapnsWJzimWg_2swEy7tQ-DQ6ri8yMk8-Qsc-A@mail.gmail.com>
 <88de4a1a-047e-4be9-b5b0-3e53434dc022@sifive.com>
 <b5624bba-9917-421b-8ef0-4515d442f80b@ghiti.fr>
 <b0a07878-a9f1-40aa-b177-423b05137d2e@app.fastmail.com>
 <1883cf6b-7756-405b-a843-d8ae31e01d61@ghiti.fr>
Date: Mon, 25 Mar 2024 12:15:10 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Alexandre Ghiti" <alex@ghiti.fr>,
 "Samuel Holland" <samuel.holland@sifive.com>,
 "Alexandre Ghiti" <alexghiti@rivosinc.com>
Cc: "Palmer Dabbelt" <palmer@dabbelt.com>, linux-riscv@lists.infradead.org,
 "Albert Ou" <aou@eecs.berkeley.edu>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 "Charlie Jenkins" <charlie@rivosinc.com>, guoren <guoren@kernel.org>,
 "Jisheng Zhang" <jszhang@kernel.org>,
 "Kemeng Shi" <shikemeng@huaweicloud.com>,
 "Matthew Wilcox" <willy@infradead.org>, "Mike Rapoport" <rppt@kernel.org>,
 "Paul Walmsley" <paul.walmsley@sifive.com>,
 "Xiao W Wang" <xiao.w.wang@intel.com>, "Yangyu Chen" <cyy@cyyself.name>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] riscv: Define TASK_SIZE_MAX for __access_ok()
Content-Type: text/plain

On Mon, Mar 25, 2024, at 08:25, Alexandre Ghiti wrote:
> On 24/03/2024 23:05, Arnd Bergmann wrote:
>> On Tue, Mar 19, 2024, at 17:51, Alexandre Ghiti wrote:
>>>
>>> The use of alternatives allows to return right away if the buffer is
>>> beyond the usable user address space, and it's not just "slightly
>>> faster" for some cases (a very large buffer with only a few bytes being
>>> beyond the limit or someone could fault-in all the user pages and fail
>>> very late...etc). access_ok() is here to guarantee that such situations
>>> don't happen, so actually it makes more sense to use an alternative to
>>> avoid that.
>> The access_ok() function really wants a compile-time constant
>> value for TASK_SIZE_MAX so it can do constant folding for
>> repeated calls inside of one function, so for configurations
>> with a boot-time selected TASK_SIZE_64 it's already not ideal,
>> with or without alternatives.
>>
>> If I read the current code correctly, riscv doesn't even
>> have a way to build with a compile-time selected
>> VA_BITS/PGDIR_SIZE, which is probably a better place to
>> start optimizing, since this rarely needs to be selected
>> dynamically.
>
>
> Indeed, we do not support compile-time fixed VA_BITS! We could, but that 
> would only be used for custom kernels. I don't think distro kernels will 
> ever (?) propose 3 different kernels for sv39, sv48 and sv57 because the 
> cost of dynamically choosing the address space width is not big enough 
> to me (and the burden of maintaining 3 different kernels is).
>
> Let me know if I'm wrong, I'd be happy to work on that.

My feeling is that in most cases, users are better off with a
compile-time default, given that the addressable memory has
a factor of 512 between each step. With sv39, I think you are
limited to having all RAM in the first 128GB of physical
address space, and each process is limited to 256GB virtual
addressing, but this is already covers pretty much anything
you want to do on small systems that run a custom kernel.

On most desktop/server/cloud distros, hardwiring sv48 is
probably sufficient if all general purpose machines support
this, and it should be enough even for commercial databases
that micro-optimize 100TB datasets through a permanent mmap(),
as well as most NUMA systems with discontiguous memory.
This adds a little cost over hardcoded sv39, but is still
faster than a boot-time sv39/sv48 config that most users
will not be aware of.

Once enterprise distros certify systems beyond a few dozen
TB of RAM, they probably need to enable the boot time
detection, until then I think the few users with gigantic
systems will probably be fine running a custom sv57
kernel. At that point, that distro can start shipping a
kernel with boot-time detected page table sizes.

     Arnd

