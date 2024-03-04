Return-Path: <linux-kernel+bounces-90110-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 72EDB86FA79
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 08:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97AFFB20CB3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 07:07:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4339134A3;
	Mon,  4 Mar 2024 07:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v3BwV6w6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TzZh3cXI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6374912E4F;
	Mon,  4 Mar 2024 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709536067; cv=none; b=QwVetv2OrmF+zpD4/pSxb7eVS/p+QeaQg6n28sC3Q1w5D72dEGMbUEbIrX7HmbfDSJiltTajTY2Q1tFA9s7dThOOwyuf/H27weYCIi1urpicOmiex/yYxclpWuiPce0KTanxx+O3b80lwoHAJ/eQ335AceTrj/ZDXCLZ2loUM2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709536067; c=relaxed/simple;
	bh=60SVu1KVHedJVfxJcO9wjvgnDUx3m4ZLvGGuTu8iRX0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QQek5yBSqipQATADpbQ8+z2Fy2pLItvq04t67wj1CC+EMctzS7Gq7Kdhfpu5HiGT0LLKkeDcIsOF0n3yWDkZawEsNCfgaOVoq3jKUyG0eFMD7dOpA0IifJ6fRyJu5OWJp5jxMDjdRZt/XPNpF8WX948DZlmBFM2MlSJKn3kfng0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v3BwV6w6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TzZh3cXI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709536064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60SVu1KVHedJVfxJcO9wjvgnDUx3m4ZLvGGuTu8iRX0=;
	b=v3BwV6w6KaPN4Wp25kEa7zvrQRv6IeRbPnlSIPu2PjFRPH+HNW72t7QKZBcqIITs/lfF7R
	lFb6pnVU2HmFXmU5SDSpeP0Ob/R2Tdu0NMhrVkLjLFdfHK+aWEHVEH4BJYgIl0NQTKeic2
	8ll0FlaW93mvS4DRPSc5/uvxvcoQ7aM7cdfv02ISV0LuSruoN4fWsfLvnZ84v2IsWsqIJe
	ZwX7RMPMARvPgCbDA6YSAy7+RWXl2JLOD1rTD6lGaL6pvTI7I96G2tYPAERAowHB3ezSBp
	XNJUZnT43aFVL645x0uvcubl4sVNSjIDo8N67Fzb8aP6u3QJM8o5uN6bn17kfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709536064;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60SVu1KVHedJVfxJcO9wjvgnDUx3m4ZLvGGuTu8iRX0=;
	b=TzZh3cXIGv03GDF2Z7s7WIsb9G3jhkVcJ3YJBatqRbF/mjku8eCQSY0YyabxKE0oMYXcnh
	kYWQLoGOIectnTBQ==
To: Uros Bizjak <ubizjak@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, kernel test robot
 <lkp@intel.com>, oe-kbuild-all@lists.linux.dev,
 linux-kernel@vger.kernel.org, Arjan van de Ven <arjan@linux.intel.com>,
 x86@kernel.org, Luc Van Oostenryck <luc.vanoostenryck@gmail.com>, Sparse
 Mailing-list <linux-sparse@vger.kernel.org>, "Paul E. McKenney"
 <paulmck@kernel.org>
Subject: Re: arch/x86/include/asm/processor.h:698:16: sparse: sparse:
 incorrect type in initializer (different address spaces)
In-Reply-To: <CAFULd4aEe2KU=UXEt2=GeLQq2uTSFvydBiwAdSa7B6T61Am=5w@mail.gmail.com>
References: <202403020457.RCJoQ3ts-lkp@intel.com> <87edctwr6y.ffs@tglx>
 <87a5nhwpus.ffs@tglx> <87y1b0vp8m.ffs@tglx> <87sf18vdsq.ffs@tglx>
 <87le70uwf0.ffs@tglx>
 <CAHk-=wiWhfdc4Sw2VBq_2nL2NDxmZS32xG4P7mBVwABGqUoJnw@mail.gmail.com>
 <87edcruvja.ffs@tglx>
 <CAFULd4bVEUBEidTLbHNzRaJbSjXm99yC8LT=jdzFWb7xnuFH7g@mail.gmail.com>
 <87bk7vuldh.ffs@tglx>
 <CAFULd4arHT+_fy9_oUNpmsvyfVPGaeB_pdeuqVS3UTpP5R757A@mail.gmail.com>
 <CAFULd4b0HN6eUJsOW6po8Hf16T3eMhjdKUvw-TS8yncNn-+Vyw@mail.gmail.com>
 <87bk7ux4e9.ffs@tglx>
 <CAFULd4aEe2KU=UXEt2=GeLQq2uTSFvydBiwAdSa7B6T61Am=5w@mail.gmail.com>
Date: Mon, 04 Mar 2024 08:07:43 +0100
Message-ID: <878r2ywk3k.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 04 2024 at 06:42, Uros Bizjak wrote:

> On Mon, Mar 4, 2024 at 12:49=E2=80=AFAM Thomas Gleixner <tglx@linutronix.=
de> wrote:
>>
>> On Sun, Mar 03 2024 at 21:24, Uros Bizjak wrote:
>> > On Sun, Mar 3, 2024 at 9:21=E2=80=AFPM Uros Bizjak <ubizjak@gmail.com>=
 wrote:
>> >> On Sun, Mar 3, 2024 at 9:10=E2=80=AFPM Thomas Gleixner <tglx@linutron=
ix.de> wrote:
>> >> > That's so sad because it would provide us compiler based __percpu
>> >> > validation.
>> >>
>> >> Unfortunately, the c compiler can't strip qualifiers, so typeof() is
>> >> of limited use also when const and volatile qualifiers are used.
>> >> Perhaps some extension could be introduced to c standard to provide an
>> >> unqualified type, e.g. typeof_unqual().
>> >
>> > Oh, there is one in C23 [1].
>>
>> Yes. I found it right after ranting.
>>
>> gcc >=3D 14 and clang >=3D 16 have support for it of course only when ad=
ding
>> -std=3Dc2x to the command line.
>>
>> Sigh. The name space qualifiers are non standard and then the thing
>> which makes them more useful is hidden behind a standard.
>
> With GCC, you can use __typeof_unqual__ (please note underscores)
> without -std=3Dc2x [1]:
>
> "... Alternate spelling __typeof_unqual__ is available in all C modes
> and provides non-atomic unqualified version of what __typeof__
> operator returns..."
>
> Please also see the example in my last post. It can be compiled without -=
std=3D...

With gcc >=3D 14. Not so with clang...

