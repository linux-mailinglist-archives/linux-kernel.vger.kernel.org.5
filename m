Return-Path: <linux-kernel+bounces-127114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 150598946D3
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:56:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46F8F1C218C0
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 21:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 076C055C3C;
	Mon,  1 Apr 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DGHPGO1p"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 482D755792
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 21:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712008599; cv=none; b=AoHkwgkkezuEg+yjHg6quIYnRddNnxCJ0jEGmswuER3IDYMlMZCkqYyrlE4R3dNJnTqfXj2nUlnODFo7XKIUnITogKPuerxIKAKHz56qcD4/dpM322Hud7O55hfzxFSBSA5UldUVwiDMNwWf1ZEOMfnrxC4Efk+VFaxUQn8viLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712008599; c=relaxed/simple;
	bh=6k5BrjOuMeQB/WSl+ly2g5AtD0c2vDIBP07u7b9MxN0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZvenqjPgyuI5IWE1YxYmM8J/JGsjid1qsxh3DxnQ30usgiIjj/sXtXI0owDKEEHeBj3dLsxEQxHSiHzMDa5hcb1SVFM3FlkoqEAP1FgP6gnCdC0w9sYg2EUGe8G79m5CM9TncfjgMUGR8Y4jjy4o4tzGFB2Ql5R3pCd1+UfSQiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DGHPGO1p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C436C433C7;
	Mon,  1 Apr 2024 21:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712008598;
	bh=6k5BrjOuMeQB/WSl+ly2g5AtD0c2vDIBP07u7b9MxN0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DGHPGO1pjbSvbZfmQHmu66cGRmgZD1wO0PrDbfnlVh593aDmgzXhFYSwaaNtXSnRO
	 daipjZX5dKsVWEmuYeR13abZDAELBCJYw4vfBN9QxqTiIgLqBSm3qmIoqli1bCwW6X
	 YVv4GrVY9quvMyZ5m2C7WoAcZVhpbtBAH+RmAJ0hnxx450ocmOh1gwDn0rNxSI0LiL
	 zjmS9/B5Zp6CWDd6CYBkAhBoKOjWtEjiW18PlJdWL7e70/FxypCS64eJf0fZ2XQ4sa
	 FwiSXbURee2yz5Dn+rjHPQ7D5POUJDK9Gf1NP/CQFO/QXs9njhbjMtNvVBGhxdg4b0
	 EB3tYayIKuK2Q==
Date: Mon, 1 Apr 2024 23:56:36 +0200
From: Frederic Weisbecker <frederic@kernel.org>
To: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <ZgstlCZn0l9wSv7H@pavilion.home>
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <797f44f9-701d-4fca-a9f4-d112a7178e7b@paulmck-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <797f44f9-701d-4fca-a9f4-d112a7178e7b@paulmck-laptop>

Le Mon, Apr 01, 2024 at 02:26:25PM -0700, Paul E. McKenney a écrit :
> > > _ The RCU CPU Stall report. I strongly suspect the cause is the hrtimer
> > >   enqueue to an offline CPU. Let's solve that and we'll see if it still
> > >   triggers.
> > 
> > Sounds like a plan!
> 
> Just checking in on this one.  I did reproduce your RCU CPU stall report
> and also saw a TREE03 OOM that might (or might not) be related.  Please
> let me know if hammering TREE03 harder or adding some debug would help.
> Otherwise, I will assume that you are getting sufficient bug reports
> from your own testing to be getting along with.

Hehe, there are a lot indeed :-)

So there has been some discussion on CPUSET VS Hotplug, as a problem there
is likely the cause of the hrtimer warning you saw, which in turn might
be the cause of the RCU stalls.

Do you always see the hrtimer warning along the RCU stalls? Because if so, this
might help:
https://lore.kernel.org/lkml/20240401145858.2656598-1-longman@redhat.com/T/#m1bed4d298715d1a6b8289ed48e9353993c63c896

Thanks.

> 
> 							Thanx, Paul

