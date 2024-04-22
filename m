Return-Path: <linux-kernel+bounces-154041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF2938AD67D
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 23:23:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A43B1F21A5B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 21:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E8E1CABD;
	Mon, 22 Apr 2024 21:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BcsoZQxT"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DE8D1CAAE;
	Mon, 22 Apr 2024 21:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713820998; cv=none; b=VJF8m9ue1xfc/FjXB7++NSx01C38jDYw+y2iLTS15qZ3jqd0V5mCWasDynb4nxgrE2PlfQgQOjhhQbQBNpIAvld965znJFps3ZMQWGdJpyVfkBlHixvig64KuePDovgNPKs92izFsdE532+LJXXBEkU/eFZKsseLHa1ckI95h/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713820998; c=relaxed/simple;
	bh=tzeHjNaEfBO3NYlDT6yxKwXd370qrhnCwbKZBnOVPz0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=fkQzMDrO6N/T9ZYNPn7XYiUdROMJVYDhV62R6WO3CMNEjdANMVU9HSr9JXzchpSifb4FOkj6iO4+lmb9TBu+AHgzecO+p98l/uK6V8KO0HyY399c24ufoHi7y0IiWaF3revZ77jQ84bQQvF6Dt+2D2tY+/32ef1XyP3cYERY7BY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BcsoZQxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87751C113CC;
	Mon, 22 Apr 2024 21:23:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713820997;
	bh=tzeHjNaEfBO3NYlDT6yxKwXd370qrhnCwbKZBnOVPz0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BcsoZQxTNpD3enev7vPNdMAe2JB2Hw85rbfMFUABtUjUYRGPvLjPacvxXGtszleh7
	 wU1b42feVmMU4MAy24hIsg3trEuYD3F8C1UZMfiV8+oFl2J/SRn7aEKQduxYgCyGq9
	 ed+oKyLoiQFFrkRNTvfCCX+8wKEtxxcK5KVek8Hh9f6IYV4266vFyPXdxJkdZ6D4Ly
	 OhxC2WFiOcnhAmRZik5b+bLM803UDg+QFXf+raexu5aoSjf9elJXWv7D9xSmukwMOl
	 xZn5bTkP4RmlG2FQYYiPRbv0NPL91ykW13DjjEQ7GtBuOBYn3G7rLqk6yZdlWhEXC2
	 dPY7kcdZtWJ0Q==
Date: Mon, 22 Apr 2024 16:23:15 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Tejun Heo <tj@kernel.org>
Cc: Linux regressions mailing list <regressions@lists.linux.dev>, 
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug 218665 - nohz_full=0 prevents kernel from booting
Message-ID: <zyu6awsydy5ypb7tn7wzgumxbh4qrw2g5luc3w6trzlnmtu64v@c4knsvtk532w>
References: <5be248c6-cdda-4d2e-8fae-30fc2cc124c0@leemhuis.info>
 <enqg6mcuhvff7gujjbapdiclicl3z6f2vnggcsg65pexipyr3o@4men5fhyt3vb>
 <28c84b3b-f68f-4f45-8da1-9c3f9a342509@leemhuis.info>
 <7kugx5ivbplwwrcq5zp37djtpakl55b3pfy36gpbsbcx43dpcs@uheu6iv7gm7h>
 <81149f18-0132-4ace-8c71-1b75790a88e4@leemhuis.info>
 <Zh8H_vG2dQLOjoIB@slm.duckdns.org>
 <51942e58-a5a3-4dcd-80c1-6735c7b5cc1e@leemhuis.info>
 <ZiCAXq-jS1Z6vgCK@slm.duckdns.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZiCAXq-jS1Z6vgCK@slm.duckdns.org>

On Wed, Apr 17, 2024 at 04:07:26PM -1000, Tejun Heo wrote:
> Hello, Thorsten.
> 
> On Wed, Apr 17, 2024 at 07:48:33AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> > > Can you elaborate why Bjorn's case is different?
> > 
> > Well "not booting at all when using 'nohz_full=0'"[as reported two
> > times] and "I start neovim, send SIGSTOP (i.e. ^Z) to it, start another
> > neovim instance and upon sending SIGSTOP to that instance all of
> > userspace locks up - 100% reproducible."[while no 'nohz_full=0' in use]
> > at least on the first sight to and outsider sound a lot like different
> > problems to me -- but of course that impression might be wrong and you
> > know better about these things.
> 
> You are right. That is very different.
> 
> > > I was assuming it was the
> > > same problem and that Oleg's fixes would address the issue.
> > 
> > Bjorn, could you give it a try?
> 
> Yeah, I'm curious whether it's just a different symptom of the same problem.
> 

Sorry for the late reply, had to step back to v6.8 on my work machine
and didn't retry this in a timely manner.

I've now confirmed that my problem with Neovim was resolved in v6.9-rc3,
through the introduction of:
73eaa2b58349 ("io_uring: use private workqueue for exit work")

Regards,
Bjorn

