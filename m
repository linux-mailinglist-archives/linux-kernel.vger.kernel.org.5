Return-Path: <linux-kernel+bounces-83387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B40A586975D
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 15:20:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7192B2A574
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 14:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97CE013EFF4;
	Tue, 27 Feb 2024 14:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b="lPUTGKxS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NPNMT8iD"
Received: from new2-smtp.messagingengine.com (new2-smtp.messagingengine.com [66.111.4.224])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9028913DBB3;
	Tue, 27 Feb 2024 14:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.224
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709043543; cv=none; b=NpiEFzp5GbYrQTiDiCowNp9hdkMYody/xhmLD768WJJR2Mh/HNysg9Nr6wkyTO0jCfvYVV94TIqI0Qqz4oQjTzk/upl6HAcxzmhAv0NJoZ2qQfecYhwPDkIshK3wH7ZDN7WVwNr/ytOi5qKIGtB0X4/v6EDdN/ij7HmWh1RfWYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709043543; c=relaxed/simple;
	bh=A0FSY37d+vGzCQkk6DyCbgJvMDTFHRlUqhEcd+SIv+U=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=raAGq+m+fkfn7kvBxaNnDJROWdQUg4qn+vOAUqhOu6Y5oP3utHAOOo9EhhyXaah/ULbHDx5NpN8wf+WTEmFy+XG58aMFp++Y2UyoGCvyXApNbOvDhlwO3xzK90CkjS3G9AnbNzxwfO2oaBIEGYq64o2hOMyUpJb0rs190flsmyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de; spf=pass smtp.mailfrom=arndb.de; dkim=pass (2048-bit key) header.d=arndb.de header.i=@arndb.de header.b=lPUTGKxS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NPNMT8iD; arc=none smtp.client-ip=66.111.4.224
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arndb.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arndb.de
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailnew.nyi.internal (Postfix) with ESMTP id 8717758176A;
	Tue, 27 Feb 2024 09:19:00 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute5.internal (MEProxy); Tue, 27 Feb 2024 09:19:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1709043540;
	 x=1709050740; bh=lgwXV027qrMgBZRGGg484htOjeaxN2ck0Zcve0Dmzhs=; b=
	lPUTGKxSZWT3KviA8nwQtQixUNSRKDoofN2NivSWKtva1+uopGcYEEr4RC46c0a4
	vwDyryLlG3/SO1o0IgHaIAKElGDgOIftHdg/t1LowfBfp6kWJ/02DSeWOd9gO01Y
	i2xNDAt65lcr61a9rbStiacnnPLSzVXxNfz+qirJEOwE6l4Mjsb9FPSq6beDfONs
	IfFnZ9bxqqqY3xHHTJ0xelGfB0mkN5vK/R1PlQWSfAeazO2LUPLczof7Is+mk4YY
	dS7xeAUB8mFbzZwvSoSrgsd+tbYj/Jm83Sm5bzumIEzMe8eZVlLb2zqJj5ACbn1Q
	xHdhr1utw0PFFSmpN8T17A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1709043540; x=
	1709050740; bh=lgwXV027qrMgBZRGGg484htOjeaxN2ck0Zcve0Dmzhs=; b=N
	PNMT8iDaqBhcmripVnSD6nS3Lv42kN3UYBW99FRUWa3TpEGbwqC5etBXkzZPJQ97
	b46+HgX1sO+sVYOqI7WWoftMMpP1d6mFgSc+COHXzownsJ7ep9c7luzipVKN/JSm
	WvBS91t32eqhnz4okM6kGJHX7ja6nxAsDWD2f8/n1iyXi5CXN1O8cRQmzdP0MN3P
	lXLGSaSOyRMNG2Klv5JGjNbEL+jZ99PzUXZkK0dRYXnY7Sh9tCeVVIPOdKairDq/
	hVJllB8wVwsQCnLlNf4DWkeeaaUPJ42yyj0cK8PqRkYPiog+0wCNiowoUDAfMSZ0
	TxOSo3YO5XIRZlykzYViQ==
X-ME-Sender: <xms:Uu_dZWjk9CPDDtuHUq0spRBOyt_ieWSB_NQxrFGLmr24EkUFHc8YHg>
    <xme:Uu_dZXDMUFx8ZF-9sPWppPSzjc83i6I1db9CmveKWGMIeJFPSdAeNSa88BpcqoNFB
    jVJuLbK_PRbbcnDDkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrgeehgdefkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:Uu_dZeEDtHRL9UWe85NwoKrx0otX3SNqDfDiZ5hOf70Z6GsgUqDdIw>
    <xmx:Uu_dZfQ4cWIo6G3rC1HFzafsQ2XymenYLV7MaNYtE0ltPhY45Lm3AA>
    <xmx:Uu_dZTw8lPg-bwLBWej0tpp3R0mNAVRklOB_4I0L7nRbPx69459aug>
    <xmx:VO_dZbOruGZOL_Pr3S4l_raiy6WMSNlORBuJgrWys66FFVcptlS8dQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id 8FBCAB6008D; Tue, 27 Feb 2024 09:18:58 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-153-g7e3bb84806-fm-20240215.007-g7e3bb848
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <7b62e73d-d3fa-4432-807d-c2e667814b17@app.fastmail.com>
In-Reply-To: 
 <CAMuHMdXQYPtL0J4Phm81S1qWpi7no=1r4uStbLd8zbjn7fcWQw@mail.gmail.com>
References: <20240226161414.2316610-1-arnd@kernel.org>
 <20240226161414.2316610-4-arnd@kernel.org>
 <CAMuHMdWRBQF95fJ+NkPUdvpu5VfRm2WyTnvdqB1Xe7d4vsvY2g@mail.gmail.com>
 <164616c2-94f6-40e8-86e0-850dc8da212e@app.fastmail.com>
 <CAMuHMdXQYPtL0J4Phm81S1qWpi7no=1r4uStbLd8zbjn7fcWQw@mail.gmail.com>
Date: Tue, 27 Feb 2024 15:18:38 +0100
From: "Arnd Bergmann" <arnd@arndb.de>
To: "Geert Uytterhoeven" <geert@linux-m68k.org>
Cc: "Arnd Bergmann" <arnd@kernel.org>,
 "Thomas Gleixner" <tglx@linutronix.de>,
 "Vincenzo Frascino" <vincenzo.frascino@arm.com>,
 "Kees Cook" <keescook@chromium.org>,
 "Anna-Maria Gleixner" <anna-maria@linutronix.de>,
 "Matt Turner" <mattst88@gmail.com>, "Vineet Gupta" <vgupta@kernel.org>,
 "Russell King" <linux@armlinux.org.uk>,
 "Catalin Marinas" <catalin.marinas@arm.com>, guoren <guoren@kernel.org>,
 "Brian Cain" <bcain@quicinc.com>, "Huacai Chen" <chenhuacai@kernel.org>,
 "Michal Simek" <monstr@monstr.eu>,
 "Thomas Bogendoerfer" <tsbogend@alpha.franken.de>,
 "Helge Deller" <deller@gmx.de>, "Michael Ellerman" <mpe@ellerman.id.au>,
 "Christophe Leroy" <christophe.leroy@csgroup.eu>,
 "Palmer Dabbelt" <palmer@dabbelt.com>,
 "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
 "Andreas Larsson" <andreas@gaisler.com>,
 "Richard Weinberger" <richard@nod.at>, x86@kernel.org,
 "Max Filippov" <jcmvbkbc@gmail.com>, "Andy Lutomirski" <luto@kernel.org>,
 "Jan Kiszka" <jan.kiszka@siemens.com>,
 "Kieran Bingham" <kbingham@kernel.org>,
 "Andrew Morton" <akpm@linux-foundation.org>,
 linux-kernel@vger.kernel.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 "linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, "Greg Ungerer" <gerg@linux-m68k.org>
Subject: Re: [PATCH 3/4] arch: define CONFIG_PAGE_SIZE_*KB on all architectures
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024, at 12:12, Geert Uytterhoeven wrote:
> On Tue, Feb 27, 2024 at 11:59=E2=80=AFAM Arnd Bergmann <arnd@arndb.de>=
 wrote:
>> On Tue, Feb 27, 2024, at 09:54, Geert Uytterhoeven wrote:
>> I was a bit unsure about how to best do this since there
>> is not really a need for a fixed page size on nommu kernels,
>> whereas the three MMU configs clearly tie the page size to
>> the MMU rather than the platform.
>>
>> There should be no reason for coldfire to have a different
>> page size from dragonball if neither of them actually uses
>> hardware pages, so one of them could be changed later.
>
> Indeed, in theory, PAGE_SIZE doesn't matter for nommu, but the concept
> of pages is used all over the place in Linux.
>
> I'm mostly worried about some Coldfire code relying on the actual value
> of PAGE_SIZE in some other context. e.g. for configuring non-cacheable
> regions.

Right, any change here would have to be carefully tested. I would
expect that a 4K page size would reduce memory consumption even on
NOMMU systems that should have the same tradeoffs for representing
files in the page cache and in mem_map[].

> And does this impact running nommu binaries on a system with MMU?
> I.e. if nommu binaries were built with a 4 KiB PAGE_SIZE, do they
> still run on MMU systems with an 8 KiB PAGE_SIZE (coldfire and sun3),
> or are there some subtleties to take into account?

As far as I understand, binaries have to be built and linked for
the largest page size they can run on, so running them on a kernel
with smaller page size usually works.

One notable exception is sys_mmap2(), which on most architectures
takes units of 4KiB but on m68k is actually written to take
PAGE_SIZE units. As Al pointed out in f8b7256096a2 ("Unify
sys_mmap*"), it has always been wrong on sun3, presumably
because users of that predate modern glibc. Running coldfire
nommu binaries on coldfire mmu kernels would run into the same
bug if either of them changes PAGE_SIZE. If you can run
coldfire nommu binaries on classic m68k, that is already
broken in the same way.

      Arnd

