Return-Path: <linux-kernel+bounces-140719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 008018A1836
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:08:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 327ED1C2193E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:08:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F6D1798E;
	Thu, 11 Apr 2024 15:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="to815qwe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 473D017735
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:08:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712848091; cv=none; b=KBAFLIApJY6K1vWwZ8ZmmW0sIiTaH4VSkHlzjpOx5Glxq1nVZOwRopnOaExNjo2E/hthD7zxonfZWWhjlsGbE0YGHqO3k4se2i1EOYtXgJNYri+6Tbq1MfzPhxiLXHaOeOMdpyNUkiBwOdo6as6zTUIYxx4VRIioSoWFGj/dUFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712848091; c=relaxed/simple;
	bh=SzzKMkdyb3myA6zNSYzjTuGGXEZ4LdIPFjD8WtxpVLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T9R9k5sFcuBlrEU46Cj3cNoH4irGBjMybd5sMFifps7GugwK7zxbzsX79/LyeD381vxsApJ6krpenZRXlMNKz9J9HYtfFSQ2fF69K4YlNSEqdFzuDgMb0jmVn1fPFm7ts1Fz67uN1QS26DYBPmncrYls+6VkEobQs3Qg5FRVC0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=to815qwe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61C4AC113CD;
	Thu, 11 Apr 2024 15:08:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712848091;
	bh=SzzKMkdyb3myA6zNSYzjTuGGXEZ4LdIPFjD8WtxpVLI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=to815qweE4QcMoFbhOkPm6cYTmSy3fJitDiXQDm0RwmnF9K7cx/SBFvVghz28PHBy
	 k90jggAcoMC7/15nFI6Mj2mIevX08p9MyKpg2gAtkuRBaDzZz4ZAs+0asrLC36JnFt
	 PvEc+N9npnc3hYH3e6tvZSXPe7pERr3GheA3LQlwNeW7lmaZ/wB7nGsKi3cjsmkM5Y
	 XHjAPV10JKRck30b7J74omPaQoWrFoWLWb8MDBQlnnHjQafybi4N+2pDT9mn3c1c0a
	 b2WvjSMvpLx8L2uksLABaCl3/UmD9R8mxeqfb+fMAxww6vleJfHb6NAKFbcd2jOw44
	 ct9OqQRESptxw==
Date: Thu, 11 Apr 2024 08:08:08 -0700
From: Josh Poimboeuf <jpoimboe@kernel.org>
To: Nikolay Borisov <nik.borisov@suse.com>
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
	KP Singh <kpsingh@kernel.org>, Waiman Long <longman@redhat.com>,
	Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH 5/7] x86/bugs: Only harden syscalls when needed
Message-ID: <20240411150808.ukeoq54nrjtdd65g@treble>
References: <cover.1712813475.git.jpoimboe@kernel.org>
 <97befd7c1e008797734dee05181c49056ff6de57.1712813475.git.jpoimboe@kernel.org>
 <124f4871-1275-47af-b513-297b870708b2@suse.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <124f4871-1275-47af-b513-297b870708b2@suse.com>

On Thu, Apr 11, 2024 at 09:20:17AM +0300, Nikolay Borisov wrote:
> On 11.04.24 г. 8:40 ч., Josh Poimboeuf wrote:
> > Syscall hardening (i.e., converting the syscall indirect branch to a
> > series of direct branches) may cause performance regressions in certain
> > scenarios.  Only use the syscall hardening when indirect branches are
> > considered unsafe.
> > 
> > Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
> > Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
> 
> Why fiddle with syscall mechanism if the bhb scrubbing sequence mitigates
> bhb? AFAIU (correct me if I'm wrong) the original idea was to have use
> syscall hardening instead of the BHB sequence but since it became clear
> that's not sufficient bhb scrubbing completely subsumes the direct branch
> approach in the syscall handler?

I agree, but I think Linus wanted it for some reason.  I might not have
gotten the X86_FEATURE_INDIRECT_SAFE conditions right, maybe Linus can
clarify.

I'm going to experiment with having objtool find all indirect branches
reachable 66 branches from syscall entry.  If we converted all those to
direct branches then the SW loop wouldn't be needed.

But until then I don't see much point in the syscall direct branches.
We could just disable it completely until if/when it's really needed.

-- 
Josh

