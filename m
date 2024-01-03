Return-Path: <linux-kernel+bounces-15991-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 77FC28236AA
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 21:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 161831F2299F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 20:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F30EE1D691;
	Wed,  3 Jan 2024 20:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lwn.net header.i=@lwn.net header.b="j5PHTXdn"
X-Original-To: linux-kernel@vger.kernel.org
Received: from ms.lwn.net (ms.lwn.net [45.79.88.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA5431D681;
	Wed,  3 Jan 2024 20:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lwn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lwn.net
Received: from localhost (unknown [IPv6:2601:280:5e00:7e19::646])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ms.lwn.net (Postfix) with ESMTPSA id 980251C33;
	Wed,  3 Jan 2024 20:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 ms.lwn.net 980251C33
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=lwn.net; s=20201203;
	t=1704313821; bh=H7TXJw6dQEQvwm1EXNrX3GZKv2TSI8Mhwx5sNEHJLR4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=j5PHTXdn/jFPsLKcWbOYVlr9Up5jR46UoVj4ua9y4vonIgCq3Nm8B1dnaQSma2k71
	 5bqE0ERM4uQJHFl6z87L42G53KHAw+XrEZKvrYv+PJRkbfzz7Bf8DQt+wWWMzOjinB
	 xyGiz7jkuU8I7/igYCT9umlCSLF7FlNhZmRPeFH+rLf1ATCKmsjkWwstu/oDA6VoDL
	 h7snkKDDQ2Qy924FbRPoeJ6PCwKSo1YH5mFDaKpnlCY34G8Wwd/Sa3ANflo/nRqECV
	 L+lpRthRpAHpwm6FDHURXjDdtXa75vcFs35J9Uzs+dyW5wn3RyVQ7ebUrDpSXATDDr
	 c/I930ZzwFdqA==
From: Jonathan Corbet <corbet@lwn.net>
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>, Thomas Gleixner
 <tglx@linutronix.de>, x86@kernel.org, linux-doc@vger.kernel.org
Subject: Re: [RFC PATCH] kernel-doc: handle X86 DEFINE_IDTENTRY() variants
In-Reply-To: <20240102061700.3807-1-rdunlap@infradead.org>
References: <20240102061700.3807-1-rdunlap@infradead.org>
Date: Wed, 03 Jan 2024 13:30:20 -0700
Message-ID: <87il4a9n37.fsf@meer.lwn.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Randy Dunlap <rdunlap@infradead.org> writes:

> Teach scripts/kernel-doc to handle the various DEFINE_IDTENTRY*() flavors.
>
> This corrects 2 kernel-doc warnings:
>
> arch/x86/entry/common.c:211: warning: expecting prototype for int80_emulation(). Prototype was for DEFINE_IDTENTRY_RAW() instead
>
> arch/x86/kernel/apic/apic.c:2170: warning: expecting prototype for spurious_interrupt(). Prototype was for DEFINE_IDTENTRY_IRQ() instead
>
> The script uses 'uname -m' to determine if it is running on i386 or x86_64
> or something else. It also uses "ARCH=<arch>" in the environment variables
> to allow for overriding the processed ARCH.
>
> Alternatively, we could remove the "/**" kernel-doc markers from those
> 2 functions. There are 60 uses of DEFINE_IDTENTRY*() that I see and
> only 2 of them have kernel-doc comments.

So I feel like I'm missing something here; the docs build should be the
same regardless of the architecture it's running on, right?  So why do
we need architecture checks in kernel-doc?

Honestly, it might be better to just remove the kerneldoc comments
rather than add this much more complexity.

Thanks,

jon

