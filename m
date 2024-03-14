Return-Path: <linux-kernel+bounces-103771-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDB3C87C436
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 21:21:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 94444281A31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 20:21:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D05B763E8;
	Thu, 14 Mar 2024 20:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JiGgULrq"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B73C73539;
	Thu, 14 Mar 2024 20:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710447614; cv=none; b=e/YY0nz9fUdcd4ZE7HzTliBVlyTGoTv0r+GUjHNR/ms7E0zKSMPFDwUtER8cA0dU3zlq38VTaw+A0obENdYIV8od8zR2LUrz1UgS3z3vvyGk2wkbsvZbh88oAmAq4/xXye5JdzHeOZlSgD8QC7TkyU7GeLD4cpamL443+XjvHNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710447614; c=relaxed/simple;
	bh=cy3JVoqeyW0KH3SWl1WPmlAiApJJBcq4bi9azOVKekw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sNOgcvhftCOpiZJf9O/s0UnWVSkF9PpSEUScgowHGkaaj4Ysc+F56O2LBleVyillEeURaRpnULNF2zymrwHy/3DTuoAkYqOCdDpQBBAXy83n86GNXCAhfzkfA7p2DEtUBrCx5bKWulfWxr8E7nTEPbZ9l4RqHhJ8xDBfpFGI8Og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JiGgULrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160F0C433C7;
	Thu, 14 Mar 2024 20:20:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710447613;
	bh=cy3JVoqeyW0KH3SWl1WPmlAiApJJBcq4bi9azOVKekw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JiGgULrqLSJsLtSgR8WM03tmpRc3CMAFhR/bfDoeU+9LPGerE4Pc/mPwuhUZoVf+p
	 UhfvwuKWV9A0L6E9N9z+dI1nAQEd+BGX6oagzqpUMnCBzIiWOyDGMfu0ZezDpH/OKQ
	 XVLEEhf/zPktdjGWnL2bR0gy+R/qfXYcKrVcndfus/hEcBOVKe4HU01b0F7ZeHmLI5
	 RtvgBv/aMi21Mn/NlgpRoIR3I6sv+Pgcx0F8yJBID1e7imSz3zmMbO0bZys0UFCndM
	 FfRrgj7/173xy3VGd9djYP6FlvpiiGVV+K4QDnrGYph8/LR5bOYayXEUEI9CM2EFtX
	 k2B1rVZXvmBrA==
Date: Thu, 14 Mar 2024 13:20:11 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: James Prestwood <prestwoj@gmail.com>
Cc: Jeff Johnson <quic_jjohnson@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Karel Balej <balejk@matfyz.cz>, dimitri.ledkov@canonical.com,
	alexandre.torgue@foss.st.com, davem@davemloft.net,
	dhowells@redhat.com, herbert@gondor.apana.org.au,
	keyrings@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-modules@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com, mcgrof@kernel.org,
	mcoquelin.stm32@gmail.com, linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org, iwd@lists.linux.dev
Subject: Re: [REGRESSION] Re: [PATCH] crypto: pkcs7: remove sha1 support
Message-ID: <20240314202011.GB1132@sol.localdomain>
References: <005f998ec59e27633b1b99fdf929e40ccfd401c1.camel@sipsolutions.net>
 <f2dcbe55-0f0e-4173-8e21-f899c6fc802a@gmail.com>
 <20240313194423.GA1111@sol.localdomain>
 <b838e729-dc30-4e18-b928-c34c16b08606@gmail.com>
 <20240313202223.GB1111@sol.localdomain>
 <db86cba4-0e61-441d-8e66-405a13b61a3c@gmail.com>
 <20240313221043.GC1111@sol.localdomain>
 <f0492c92-1015-48e3-bfce-598c7a4843d1@quicinc.com>
 <20240313230611.GD1111@sol.localdomain>
 <a4d24b2c-7dbf-4354-9514-f8a253aac14b@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a4d24b2c-7dbf-4354-9514-f8a253aac14b@gmail.com>

On Thu, Mar 14, 2024 at 04:52:47AM -0700, James Prestwood wrote:
> IWD uses AF_ALG/keyctl for _all_ its crypto, cipher, and checksum needs.
> Anything that wifi requires as far as crypto goes IWD uses the kernel,
> except ECC is the only exception. The entire list of crypto requirements
> (for full support at least) for IWD is here:
> 
> https://git.kernel.org/pub/scm/network/wireless/iwd.git/tree/tools/test_runner_kernel_config

That's quite an extensive list, and it's not documented in the iwd README.
Don't you get bug reports from users who are running a kernel that's missing one
of those options?

> For KEYCTL_PKEY_* specifically we use it for all asymmetric crypto
> operations, (query), encrypt, decrypt, sign, verify.
> 
> I'll be honest, the AF_ALG/keyctl support in ELL was mostly done by the time
> I started working on IWD so I was not aware the documentation was so poor.
> That is an entirely separate issue than this IMO, and I'm happy to help with
> getting docs updated to include a proper list of supported features. In
> addition maybe some automated testing that gets run on kernel builds which
> actually exercises this API so it doesn't get accidentally get broken in the
> future? Docs/tests IMO are the proper "fix" here, not telling someone to
> stop using an API that has existed a long time.

I looked into the history, and it seems the KEYCTL_PKEY_* APIs were added as a
collaboration between the iwd developers and the kernel keyrings maintainer.
So, as far as I can tell, it's not that the kernel had an existing API that iwd
started using.  It's that iwd got some APIs added to the kernel for themselves.
KEYCTL_PKEY_* don't seem to have been adopted elsewhere; Debian Code Search
doesn't return any notable results.  keyctl does provide a command-line
interface to them, but I can't find any users of the keyctl commands either.

Then, everyone disappeared and it got dumped on the next generation of kernel
developers, who often don't know that this API even exists.  And since the API
is also poorly specified and difficult to maintain (e.g., changing a seemingly
unrelated part of the kernel can break it), the results are predictable...  And
of course the only thing that breaks is iwd, since it's the only user.

It would be worth taking a step back and looking at the overall system
architecture here.  Is this the best way to ensure a reliable wireless
experience for Linux users?

Maybe it's time to admit that KEYCTL_PKEY_* was basically an experiment, and a
different direction (e.g. using OpenSSL) should be taken...

(Another issue with the kernel keyrings stuff is that provides a significant
attack surface for the kernel to be exploited.)

If you do decide to continue with the status quo, it may be necessary for the
iwd developers to take a more active role in maintaining this API in order to
ensure it continues working properly for you.

AF_ALG is on *slightly* firmer ground since it's been around for longer, is
properly part of the crypto subsystem, and has a few other users.  Unfortunately
it still suffers from the same issues though, just to a slightly lesser degree.

> I'm also not entirely sure why this stuff continues to be removed from the
> kernel. First MD4, then it got reverted, then this (now reverted, thanks).
> Both cases there was not clear justification of why it was being removed.

These algorithms are insecure, and it's likely that the author of these commits
thought that there were no remaining users and nothing would break.  Removing
them is a worthy goal for code maintenance purposes and to avoid providing
insecure options that could accidentally be used.  The AF_ALG and KEYCTL_PKEY_*
APIs are very easy to overlook and I suspect that the author of these commits
did not know about them.  These APIs are rarely used, not well specified, the
availability of them and specific algorithms varies by kernel configuration, and
userspace only uses a subset of the algorithms in the kernel's museum of crypto
primitives anyway.  So it's plausible that there are algorithms that no one is
using or that at least there is a fallback for, so can be safely removed...

- Eric

