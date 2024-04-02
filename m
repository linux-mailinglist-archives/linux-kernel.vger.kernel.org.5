Return-Path: <linux-kernel+bounces-127214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 45F81894825
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 02:04:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA1F41F21BA2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 356C5D518;
	Tue,  2 Apr 2024 00:04:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gCV41nB7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C75FD2E5
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 00:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712016251; cv=none; b=EG94wkh0tmUdUnCTUtth9317RAWtaESUVtmOGpLQEpEAoVIBw0N3ixgq89U5CDuCtvcyuArQ6IiP7NT30BhXPVSuMYPHwg+3EghM2A3HpWm/LnTIUdIZk+aHZf7UcSudLbzxo62qhFd5Exgxcl7K0XhdsGuPnwkJcCVIZgBrIBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712016251; c=relaxed/simple;
	bh=3KJUgnaTGHoZsMQESW1SKaX90zJEGC7vi1C4okmuHq4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bw0f0mp6IouxN7kzy9m97NCMB3W18uDMQi8iySQOAKdcvRBwHBFRr02b7CZNF+nrOe+VAyYtASvYCdwvVh/751lEbq2TLwv0lOlBN4pHlbdl0FpMJbKXxdZLf3Mf2n3z72YSSsPe4xG4tBS1bLrMozbOOy7vpTRP/Ei1HouNneI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gCV41nB7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3419C433F1;
	Tue,  2 Apr 2024 00:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712016251;
	bh=3KJUgnaTGHoZsMQESW1SKaX90zJEGC7vi1C4okmuHq4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=gCV41nB7cwuTj6eZo/I75KfeID3R1YwSQG53CXeUkv5gRV9MzWgZYvfC5C07Oe7v2
	 Z/RggWTpXbWhMoS/2Lm0MofKJiC2hqzYiIBhMNlK/9zNMjs6qQD36rsEdl7qyNQISI
	 7uIMBmk/N82zVonthKMKr7SlRQ8YeyiG9KzceZAbHpQdJft75L9PZMPLT9twPOw8TV
	 6uIVbSfztvp6k114sUC2mYfIXW9xgn5ohcpbZlKgtVUhwoXaIE0k3lRPExhJbt90mj
	 oTkg4gJkuA0PsUCLGBltb2zS3Ddbz8M5oqDuKZQQiz83p0pDWO3qirvcv8v8MdF8lE
	 cgTRrSh1ORrGw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 8FEB8CE074C; Mon,  1 Apr 2024 17:04:10 -0700 (PDT)
Date: Mon, 1 Apr 2024 17:04:10 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Thomas Gleixner <tglx@linutronix.de>,
	LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	Anna-Maria Behnsen <anna-maria@linutronix.de>
Subject: Re: [PATCH 2/2] timers: Fix removed self-IPI on global timer's
 enqueue in nohz_full
Message-ID: <ed13826a-d2d3-4999-8d9e-77dfc6245e1c@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240318230729.15497-1-frederic@kernel.org>
 <20240318230729.15497-3-frederic@kernel.org>
 <464f6be2-4a72-440d-be53-6a1035d56a4f@paulmck-laptop>
 <1b5752c8-ef32-4ed4-b539-95d507ec99ce@paulmck-laptop>
 <ZfsLtMijRrNZfqh6@localhost.localdomain>
 <6a95b6ac-6681-4492-b155-e30c19bb3341@paulmck-laptop>
 <ZfwdEROGFFmIbkCM@lothringen>
 <bf8689c2-0749-47cb-9535-53cf66e34f5e@paulmck-laptop>
 <797f44f9-701d-4fca-a9f4-d112a7178e7b@paulmck-laptop>
 <ZgstlCZn0l9wSv7H@pavilion.home>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZgstlCZn0l9wSv7H@pavilion.home>

On Mon, Apr 01, 2024 at 11:56:36PM +0200, Frederic Weisbecker wrote:
> Le Mon, Apr 01, 2024 at 02:26:25PM -0700, Paul E. McKenney a écrit :
> > > > _ The RCU CPU Stall report. I strongly suspect the cause is the hrtimer
> > > >   enqueue to an offline CPU. Let's solve that and we'll see if it still
> > > >   triggers.
> > > 
> > > Sounds like a plan!
> > 
> > Just checking in on this one.  I did reproduce your RCU CPU stall report
> > and also saw a TREE03 OOM that might (or might not) be related.  Please
> > let me know if hammering TREE03 harder or adding some debug would help.
> > Otherwise, I will assume that you are getting sufficient bug reports
> > from your own testing to be getting along with.
> 
> Hehe, there are a lot indeed :-)
> 
> So there has been some discussion on CPUSET VS Hotplug, as a problem there
> is likely the cause of the hrtimer warning you saw, which in turn might
> be the cause of the RCU stalls.
> 
> Do you always see the hrtimer warning along the RCU stalls? Because if so, this
> might help:
> https://lore.kernel.org/lkml/20240401145858.2656598-1-longman@redhat.com/T/#m1bed4d298715d1a6b8289ed48e9353993c63c896

Not always, but why not give it a shot?

							Thanx, Paul

