Return-Path: <linux-kernel+bounces-48215-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA1FC8458AC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:17:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8EE391F24F85
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:17:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134065CDEE;
	Thu,  1 Feb 2024 13:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VgXFykib"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5AA8B5CDE7
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:17:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793422; cv=none; b=i7hiAiHJUo1R/Ok1IUeb6NPnuiqZueSXJLpbR6R78kjBnB0IrKGiq2X2FX4HN6MXs00P2rk7QBckgAkB04k0g1mbtkjHZEDKVfOxzmdN1x0xtF+lSnr5xPclUr1DWJeJTjFyvgxUDA4a17drnmZCIcvi9Z9b9rtimqag3kn9sXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793422; c=relaxed/simple;
	bh=OLBe443w++AiKqYIoVZ8KOoTi3tcEc1S4hGe+VRqdc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qMBP2ZuoHEM5xCwMsweja8XxNdkwjanbXOuMbEKJfkE87oDYAvugwbONQnC5ZusuFXRSrW3/f6YVebKJkFo41Or6PJ/qAlZg3VQ+2g788c4c2abINoT86zt+iSfNxUCIlOblxeahED/zZgYKxuwh7EuwjT2jU5YLGbcSbj2gUq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VgXFykib; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EF8CC433F1;
	Thu,  1 Feb 2024 13:17:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706793421;
	bh=OLBe443w++AiKqYIoVZ8KOoTi3tcEc1S4hGe+VRqdc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VgXFykibJC0Pi+DUS1e5rb4fePfmGmx9igLktbi7TTxdptV+xSWj7I0HevmG7I/Pj
	 JvZexHZ1RawiWYw7h7NOOAvDENzD9p4E/uKTlB+Uup6WEx5/okjg/9K+F3qsFoix5h
	 pZ5yJwPm57N2hUNtMfgPxx1+g2MokCNfLuIVsG/pK9BeTVXn/jg3mANUaMpahGy5Un
	 UEbSAVUgaYY0e467GxRYhCjZpODjGrOjkycv54N5lk+U/eX4g4AeBr6PaBouSRipVD
	 zSJ2EGug7DAwEQ5omvdk82HM7XcP3vAKdVn5NBkurNuBrZQ7lMo9Z6NpJ/FzIwynD5
	 7ZJI8183ecUqw==
Date: Thu, 1 Feb 2024 14:16:58 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>, Peng Liu <liupeng17@lenovo.com>,
	Joel Fernandes <joel@joelfernandes.org>
Subject: Re: [PATCH 03/15] tick: Remove useless oneshot ifdeffery
Message-ID: <ZbuZyu2XmRO-UVCY@localhost.localdomain>
References: <20240131231120.12006-1-frederic@kernel.org>
 <20240131231120.12006-4-frederic@kernel.org>
 <87ttmsikud.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ttmsikud.fsf@somnus>

Le Thu, Feb 01, 2024 at 10:40:10AM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > tick-sched.c is only built when CONFIG_TICK_ONESHOT=y, which is selected
> > only if CONFIG_NO_HZ_COMMON=y or CONFIG_HIGH_RES_TIMERS=y. Therefore
> > the related ifdeferry in this file is needless and can be removed.
> >
> > Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> 
> It's a nitpick, but shouldn't the ordering of sob and reviewed-by be the
> other way round?

I've seen it both ways here and there, I'm not sure if there is a strict rule
for it...

> Thanks,
> 
> 	Anna-Maria
> 

