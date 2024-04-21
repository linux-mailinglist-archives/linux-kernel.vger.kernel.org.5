Return-Path: <linux-kernel+bounces-152447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED6FE8ABE9C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 07:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 167A41F211B9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 05:25:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E1238C07;
	Sun, 21 Apr 2024 05:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fdsS0b1W"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84064437
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 05:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713677144; cv=none; b=OMi5pJJGOUsZcpq5aCgwYakCokUWGix2rUzDWrfZuUbSNOGng3p51jUHHzquBvzEux6h1wWtGTmCJy1b8NhcoEb8Esl6bfKEjwCpcAhuM15uwLh0tFrO2OosqzMd5FW6MdvkfwscwZHtJJGElSIBZBHEcDffYyJoCp+ZZ9RFEBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713677144; c=relaxed/simple;
	bh=8897UkikHcygbe4N3ix+irQK9I4HgjF9WNURVeDcTNs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=TEEAioUryZWh8i3QltOgfaV2GFfXR3BHmqZ4JFE4emzLdmkYmoQtANSvLFty4lR12PXlcYm4eBXJ3sfpj9kckxgAPnK4uyUB8KROo89cdNDgoU1GDuSKJIed1+y40HPGoBn/PH+RNKtz9gIcqlmE+IIQNsjSBiZfOJrO7wxRFQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fdsS0b1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA8FFC2BD10;
	Sun, 21 Apr 2024 05:25:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713677144;
	bh=8897UkikHcygbe4N3ix+irQK9I4HgjF9WNURVeDcTNs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fdsS0b1WJV6G/qdyQzYD9Pl8zYlOKJxpZ1Ayb/UU/a5MRpjpBgufPbw+Kt5rO+E7f
	 tcyOGMQaTecPjubm7xtHmXAxRp6G4cj5/or209HBQ7qzrLg6oqboqSYZXsPncT9Wod
	 FEG2cw1WFafbBJsGpc4v0n4MMxWOkqIiGGFv8Dp9Spz1IkJIOHnAKNd8fPmTJI/46j
	 iSjJ8VgoodV2dZAYGY4NtGyudxs+8sIaYEn9QhgPefgYr8f25gbe9R5xxsAP+VdDhz
	 7Gp+kDNQIj9qzC8jcWBl6T8bxcRu/GzlU+5WEQE/VFajSy1eSyMmcjQ9APrUQFS/uZ
	 ZGF2IgORgQqsw==
Date: Sat, 20 Apr 2024 22:25:40 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: x86@kernel.org, linux-kernel@vger.kernel.org,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alexandre Chartre <alexandre.chartre@oracle.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sean Christopherson <seanjc@google.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Nikolay Borisov <nik.borisov@suse.com>,
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>, Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH v4 3/5] x86/syscall: Mark exit[_group] syscall handlers
 __noreturn
Message-ID: <20240421052540.w7gtahoko2qerhqq@treble>
References: <cover.1713559768.git.jpoimboe@kernel.org>
 <3b99cb2919c88ab3d353337423b2f0f1b9173f0a.1713559768.git.jpoimboe@kernel.org>
 <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0c410ba5-0e42-43b6-80b8-a69c5419a97d@paulmck-laptop>

On Sat, Apr 20, 2024 at 06:58:58AM -0700, Paul E. McKenney wrote:
> On Fri, Apr 19, 2024 at 02:09:49PM -0700, Josh Poimboeuf wrote:
> > The direct-call syscall dispatch functions don't know that the exit()
> > and exit_group() syscall handlers don't return.  As a result the call
> > sites aren't optimized accordingly.
> > 
> > Fix that by marking those exit syscall declarations as __noreturn.
> > 
> > Fixes the following warnings:
> > 
> >   vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
> >   vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation
> > 
> > Fixes: 7390db8aea0d ("x86/bhi: Add support for clearing branch history at syscall entry")
> > Reported-by: "Paul E. McKenney" <paulmck@kernel.org>
> > Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Looks good, but it does not apply on top of current -next and I don't
> trust myself to hand-apply it (something about having just got off of
> a flight across the big pond).
> 
> Could you please let me know what else do I need to pull in to be able
> to cleanly apply this one?

This patch has a dependency on an earlier patch in the set:

  https://lkml.kernel.org/lkml/982d05a2f669140f26500bee643011896d661094.1713559768.git.jpoimboe@kernel.org

Though I think it's not a hard dependency and I could reverse the order
of the patches if needed.

-- 
Josh

