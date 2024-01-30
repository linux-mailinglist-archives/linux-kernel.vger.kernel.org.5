Return-Path: <linux-kernel+bounces-44869-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13644842856
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:47:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 463FB1C23B0A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A8EC85C44;
	Tue, 30 Jan 2024 15:47:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55D3EAC7;
	Tue, 30 Jan 2024 15:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629657; cv=none; b=PNMgIUkk6X08U6EN1HFrJCn38tKcwDw9QwHcdDkPZhEfphrInFurKVWa6hfGqFozUyp9M9yY9vIf5llnmRhSKlOKYJ1rntimlE+uSMf5kHSX38ZJdDh5zwrzjAP6k8mlDaThsKShu4P4I/WdWnFBpiPlZwwN/htFHE47UZ4Gnk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629657; c=relaxed/simple;
	bh=i90vzquGaAgEgkVRLiIGQT0UuPWTjwtk15FaHVx8JBs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NoI9Q+7nfP4NLR8dNEiDc0D2cU/hHY9RbSYtyZJS12jqH1P8Ac/sqIOT8V+voe0OuLrxoFjGPMxThf6dBIeAfGRLTy93iTeoFFDrLc68cBmXNS+mcWWT8ZFNsKzDqK9NicrxY4MLGWqOVo12jKgLf0FQPt2wSoFS2SxdtQ/BGBY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B2701DA7;
	Tue, 30 Jan 2024 07:48:15 -0800 (PST)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.58])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6B3513F762;
	Tue, 30 Jan 2024 07:47:30 -0800 (PST)
Date: Tue, 30 Jan 2024 15:47:26 +0000
From: Dave Martin <Dave.Martin@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] arm64/signal: Don't assume that TIF_SVE means we saved
 SVE state
Message-ID: <ZbkaDjyuYVEct+kl@e133380.arm.com>
References: <20240119-arm64-sve-signal-regs-v1-1-b9fd61b0289a@kernel.org>
 <20240130115107.GB13551@willie-the-truck>
 <b0ed6698-bc65-48fb-96b8-0cd077448196@sirena.org.uk>
 <ZbkLY+gz7Az1OgNK@e133380.arm.com>
 <7027bd80-1fea-493a-83d7-ffef4e548f08@sirena.org.uk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7027bd80-1fea-493a-83d7-ffef4e548f08@sirena.org.uk>

On Tue, Jan 30, 2024 at 02:53:45PM +0000, Mark Brown wrote:
> On Tue, Jan 30, 2024 at 02:44:51PM +0000, Dave Martin wrote:
> > On Tue, Jan 30, 2024 at 02:09:34PM +0000, Mark Brown wrote:
> 
> > > That said if this is preempted ptrace *could* come in and rewrite the
> > > data or at worst change the vector length (which could leave us with
> > > sve_state deallocated or a different size, possibly while we're in the
> > > middle of accessing it).  This could also happen with the existing check
> > > for TIF_SVE so I don't think there's anything new here - AFAICT this has
> > > always been an issue with the vector code, unless I'm missing some
> > > bigger thing which excludes ptrace.  I think any change that's needed
> > > there won't overlap with this one, I'm looking.
> 
> > I'm pretty sure that terrible things will happen treewide if ptrace can
> > ever access or manipulate the internal state of a _running_ task.
> 
> > I think the logic is that any ptrace call that can access or manipulate
> > the state of a task is gated on the task being ptrace-stopped.  Once we
> 
> ...
> 
> > I haven't tracked down the smokeproof gun in the code yet, though.
> 
> Yes, exactly - this feels like something that surely must be handled
> already with exclusion along the lines that you're describing but I
> didn't yet spot exactly what the mechanism is.

I think the critical thing is the task_is_traced() check in
kernel/ptrace.c.  This seems to be what gates every ptrace call that
requires a traced task (i.e., stopped under ptrace).

So long as nothing during the delivery of a single signal can trigger a
ptrace-stop itself, I think ptrace can't get in the middle of it.  This
would imply calling the signal delivery code recursively (not just
raising one signal while delivering another).  I'd be pretty confident
that this is meant to be impossible from a design standpoint.


> > From memory, I think that the above forced flush was there to protect
> > against the context switch code rather than ptrace, and guarantees that
> > any change that ctxsw _might_ spontaneously make to the task state has
> > already been done and dusted before we do the actual signal delivery.
> > This may be a red herring so far as ptrace hazards are concerned.
> 
> Indeed, it's all about the current task and won't help at for ptrace.

Agreed

Cheers
---Dave

