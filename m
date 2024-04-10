Return-Path: <linux-kernel+bounces-138209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3DE89EE15
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:55:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B3A8C1F22664
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 08:55:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF9B155742;
	Wed, 10 Apr 2024 08:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="BC1sVjt9"
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8142F154BFE;
	Wed, 10 Apr 2024 08:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712739297; cv=none; b=Niyr2PIvCBW7oRQj/DmGIDfwMB2Vt7r4rEJ85SG37f16aRQ75WM4Afhct9pzhAujlFpRSJzjU26DBjMmU7bNkmkeYKcnJved7xgMRl+d4KGTuIQ6gQkBcgqiNHCV6o4ic1cruo6bjlZS8mgj9bEoTLIjVniMmiC8qYZhnIaKfho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712739297; c=relaxed/simple;
	bh=Z4OFHRpr3nmIyEO1k7F/aAyiG8qyK/DH8BQ8AL7YSc8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=g1z2gctwk7R5Kgde9JeDJx1EVYlPhaZVjN06aF7czZ+/cOklEzJPRwNzI7+p4ucoL9QWrY7f4nKHpSKEfmQ6EFfEi2AhJzchH+mKRRTIVV3I6pIi5MWbfXYEy7YPjuuPos3LsheT4nFJGSauIsHtTUBgDIfDTWJmc1m4b0XtA48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=BC1sVjt9; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=U7D8PI3wu075m0OUTFPGJL2EXXEYUI1OP6LrQdtjtEU=; b=BC1sVjt9yA5JEifjOYOfUfCkr7
	Q/HTFvQuc1LjQLEuKCQ5fc69H/+KR3wjyjVr60K1YRmz1jLkbtWfPazYVPIDzeaC4aKeQHwomz6Ht
	BW4tXcB0Qxhe9vzA++6LtrYuBv/HFGPWtxBD6QH9QvA+9B3ykudPiCMENAi9Rjvf445T5xCZlKX/+
	Luwyl+2k3fHCOy9hPr2dpUq1VO/1yQg8HzcVwK5JjU3BH7C4No0/8bPVhFr1LXvv8c/ov7fvEM3x/
	vvlTLNNKr32zGV24MWqnC6rtCn4x6evvI7zABZOwJYrYcvj1RFtYdBlw1mVJiqLfcJ2lT4rWxzdZi
	mTwJ/ewQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1ruTj7-000000080U0-3lnr;
	Wed, 10 Apr 2024 08:54:42 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 88ED53004D5; Wed, 10 Apr 2024 10:54:41 +0200 (CEST)
Date: Wed, 10 Apr 2024 10:54:41 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Atul Pant <quic_atulpant@quicinc.com>
Cc: mingo@redhat.com, juri.lelli@redhat.com, vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
	mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
	rafael@kernel.org, daniel.lezcano@linaro.org, kernel@quicinc.com,
	linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Disable RT-throttling for idle-inject threads
Message-ID: <20240410085441.GA21455@noisy.programming.kicks-ass.net>
References: <20240410045417.3048209-1-quic_atulpant@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240410045417.3048209-1-quic_atulpant@quicinc.com>

On Wed, Apr 10, 2024 at 10:24:15AM +0530, Atul Pant wrote:
> We are trying to implement a solution for thermal mitigation by using
> idle injection on CPUs.  However we face some limitations with the
> current idle-inject framework. As per our need, we want to start
> injecting idle cycles on a cpu for indefinite time (until the
> temperature/power of the CPU falls below a threshold). This will allow
> to keep the hot CPUs in the sleep state until we see improvement in
> temperature/power. If we set idle duration to a large value or have an
> idle-injection ratio of 100%,  then the idle-inject RT thread suffers
> from RT throttling. This results in the CPU exiting from the sleep state
> and consume some power.
> 
> To solve this limitation, we propose a solution to disable RT-throttling
> whenever idle-inject threads run. We achieve this by not accounting the
> runtime for the idle-inject threads.

Running RT tasks for indefinite amounts of time will wreck the system.
Things like workqueues and other per-cpu threads expect service or
things will pile up and run to ground.

Idle injection, just like every other RT user must not be able to starve
the system of service.

If your system design requires this (I would argue it is broken), look
at other means, like CPU-hotplug (which I also really detest) -- which
takes down the CPU in a controlled manner and avoids the resource
issues.

