Return-Path: <linux-kernel+bounces-94452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ADECD874003
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 19:55:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68CC7286850
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 18:55:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAC54136647;
	Wed,  6 Mar 2024 18:54:55 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7165E13E7C0
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 18:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709751295; cv=none; b=iB35LZilBMnAeipb5V3aGja44Zw5M5Z17G8+sxS3u616YxvDFTv8DaxBHscSFPDmWm1aUgNjESjuiVEwo9ScrWlufBtLIyi6XC78+mOnZH73t9sjVqHxfiiziA5jUz7yPJHO9lpl1+yuGkMiOduHYRSfw5gIAq7wb0c2v1ahCVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709751295; c=relaxed/simple;
	bh=XVWvLjdsX32ZmRa0CwqnidrODKERDiQECVzC7kjs1fg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=D/eZ+OZkVu5fGEEq4+K0npUntGDMYA91t1UQbDY+vw667msK2f/FRV7qU1cXuxYuMAqVmRSvIOL9Q4LrZjsM5NBcHAnu3mwpiCdypcPbpyij34hZKuIUQzafjsCJJaU24zJYqvl3vOgmSEuc4DhlwnVH451Ub6ZIZZgk4FSldUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B25FFC433C7;
	Wed,  6 Mar 2024 18:54:53 +0000 (UTC)
Date: Wed, 6 Mar 2024 18:54:51 +0000
From: Catalin Marinas <catalin.marinas@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Dave Martin <dave.martin@arm.com>,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4] arm64/fpsimd: Suppress SVE access traps when loading
 FPSIMD state
Message-ID: <Zei7-0RMCpiWw49e@arm.com>
References: <20240122-arm64-sve-trap-mitigation-v4-1-54e0d78a3ae9@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240122-arm64-sve-trap-mitigation-v4-1-54e0d78a3ae9@kernel.org>

On Mon, Jan 22, 2024 at 07:42:14PM +0000, Mark Brown wrote:
> This indicates that there should be some useful benefit from reducing the
> number of SVE access traps for blocking system calls like we did for non
> blocking system calls in commit 8c845e273104 ("arm64/sve: Leave SVE enabled
> on syscall if we don't context switch"). Let's do this by counting the
> number of times we have loaded FPSIMD only register state for SVE tasks
> and only disabling traps after some number of times, otherwise leaving
> traps disabled and flushing the non-shared register state like we would on
> trap.

It looks like some people complain about SVE being disabled, though I
assume this is for kernels prior to 6.2 and commit 8c845e273104
("arm64/sve: Leave SVE enabled on syscall if we don't context switch"):

https://bugs.launchpad.net/ubuntu/+source/glibc/+bug/1999551/comments/52

I assume we may see the other camp complaining about the additional
state saving on context switch.

Anyway, I don't see why we should treat blocking syscalls differently
from non-blocking ones (addressed by the commit above). I guess the
difference is that one goes through a context switch but, from a user
perspective, it's still a syscall. The SVE state is expected to be
discarded and there may be a preference for avoiding the subsequent
fault.

> I pulled 64 out of thin air for the number of flushes to do, there is
> doubtless room for tuning here. Ideally we would be able to tell if the
> task is actually using SVE but without using performance counters (which
> would be substantial work) we can't currently tell. I picked the number
> because so many of the tasks using SVE used it so frequently.

So I wonder whether we should make the timeout disabling behaviour the
same for both blocking and non-blocking syscalls. IOW, ignore the
context switching aspect. Every X number of returns, disable SVE
irrespective of whether it was context switched or not. Or, if the
number of returns has a variation in time, just use a jiffy (or other
time based figure), it would time out in the same way for all types of
workloads.

-- 
Catalin

