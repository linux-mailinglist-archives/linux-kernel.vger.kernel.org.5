Return-Path: <linux-kernel+bounces-107829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9390C880230
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 17:27:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34959B2557C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 16:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 571C185656;
	Tue, 19 Mar 2024 16:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SBtZH+62";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nXRvnYew"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C4998564D;
	Tue, 19 Mar 2024 16:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865267; cv=none; b=YVWn8AnA60R/p7a/rw3jgtZS7jLKNXBr2EjxMgu2bcPWC+X3W4D8pMtJaDk1urC/XNGLpxkmgpOTOY1Wv7cEf1rnOp4du1/CCccb6USO60fEs0TU0r8PE9XaMUVGvnbWRJd7bUu8v1pEvQeV7UEEX/RCAVbD/FVdecweuSv73ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865267; c=relaxed/simple;
	bh=wTm5U6x3uYqWqcyzthPHTTnwV2LKEGlDvsrBEYqages=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kig+ibbbSQNOTtydLnFHSkT8MAzAYleEYC5H1/gnvmr4u4JnikEthOfGCL3+XtgZmR9fU8y2ghLak4dUHGHNuDCFBIihAhemH/jf06cHsOeDGVlMIQwqcP/seqpG6SYhEf+GKXOiE9nfD/77dew7/JhxYjUjeb2GyLfdM68ybqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SBtZH+62; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nXRvnYew; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1710865264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yenY2Vkhy6GkKeu7wEXm3Qzp0FvE3p3ABGWsdwNLMhU=;
	b=SBtZH+62dvz0BRJd62JcEx/NHZHqz76EMk89ppMY8V1Y+FEuRBsqgmzHRqHBYF9cbXFsG0
	DgCuAcQlR/WrglhEyHcX/HTFTLVbKvW4Sm9A6UYoDvdDAeBvfmb6L38DT0vuKbtjz++vEP
	j3VsaioP0JUf04rnr0Kb9X36QxLHGxmwcNtR30GV/qWYaBrty5laRSFNYV2SSRjYz3N7X/
	y+cLMa0QlvbFEA7gsG3gUJTr1jxP1WlShl7z4+Y5J8jjDMWfrlDYLqstbSuDQLXuWbJy5R
	lCnF03S1OuWiYneiDXhJSdZ0dxN3xqQiRpJEJP1nlS+UfQE+Rks4swXUMHUUbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1710865264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yenY2Vkhy6GkKeu7wEXm3Qzp0FvE3p3ABGWsdwNLMhU=;
	b=nXRvnYewtxYWC9pfbI/wLrWa0rp06IAovv/dYm902Mj+8pyU49rdkkzKiJ0NGpu0mucJkU
	orxlepmlL0ouo2AA==
To: Arnd Bergmann <arnd@kernel.org>, Linus Torvalds
 <torvalds@linuxfoundation.org>
Cc: Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>,
 x86@kernel.org, Uros Bizjak <ubizjak@gmail.com>,
 linux-sparse@vger.kernel.org, kernel test robot <lkp@intel.com>,
 oe-kbuild-all@lists.linux.dev
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
In-Reply-To: <28ceb124-b634-44e0-bcd4-848fc3b0be7a@app.fastmail.com>
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
 <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
 <877ci3j80k.ffs@tglx> <87le6fih5w.ffs@tglx>
 <28ceb124-b634-44e0-bcd4-848fc3b0be7a@app.fastmail.com>
Date: Tue, 19 Mar 2024 17:21:03 +0100
Message-ID: <87edc6i45s.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Mon, Mar 18 2024 at 20:13, Arnd Bergmann wrote:
> FWIW, I did some experiments a few weeks ago on 32-bit ARM,
> using a fairly minimal kernel in a virtual machine, and
> checking the runtime memory consumption rather than compile-time.
> In a kvm guest with 32MiB RAM, I saw a difference of multiple
> megabytes in memory usage:
>
> Linux testvm 6.8.0-rc4-00410-gc02197fc9076-dirty #1 SMP PREEMPT armv7l
> root@testvm:~# free
>            	total   used    free  	shared  buff/cache   available
> Mem:       	26932   14956   1732   	    52       12800   	11976
> Swap:      	16360    3632   12728
>
> Linux testvm 6.8.0-rc4-00410-gc02197fc9076-dirty #2 PREEMPT armv7l
> root@testvm:~# free
>            	total    used  	free  	shared  buff/cache   available
> Mem:       	26932   13744  	5648        32       10092   	13188
> Swap:      	16360    3880  	12480
>
> There is a little difference between runs, but this does seem
> significant enough to keep it. The SMP build was with
> CONFIG_NR_CPUS=2 (the smallest supported compile-time number),
> but running on a single-CPU qemu instance.

With a SMP=y, NR_CPUS=1 build on x86 64bit I get:

               total        used        free      shared  buff/cache   available
Mem:        32882056      498068    32590580        4884      128884    32383988
Swap:         998396           0      998396

Same config just SMP=n:

               total        used        free      shared  buff/cache   available
Mem:        32885804      461704    32635284        4876      119480    32424100
Swap:         998396           0      998396

So the delta for available is ~40 MiB.

But if I look at it with init=/bin/sh on the command line then the delta
is significantly different:

With a SMP=y, NR_CPUS=1 build on x86 64bit I get:

               total        used        free      shared  buff/cache   available
Mem:        32883680      324120    32822728         216       10864    32559560
Swap:              0           0           0

Same config just SMP=n:

               total        used        free      shared  buff/cache   available
Mem:        32885804      326876    32821972         216       11100    32558928
Swap:              0           0           0

Delta available = 632 KiB

I haven't had the time to stare at that in detail, but comparing
/proc/meminfo for the full boot case above does not immediately give me
a hint. It's confusing at best...

Thanks,

        tglx


