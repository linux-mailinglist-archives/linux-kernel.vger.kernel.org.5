Return-Path: <linux-kernel+bounces-163055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D048B644F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 23:07:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24D8728732A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:07:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C209718412A;
	Mon, 29 Apr 2024 21:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Sb2qCSJI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11DDC184122;
	Mon, 29 Apr 2024 21:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714424580; cv=none; b=MytEXxEfll5TTJn9zaDd8QumDLGwyIq5xDKgyED7m5jMCLCRY1Ikp5Hgo2Ne5Pr9KBcEsTi5Jf6XrWJivvL8C26q+zWjdsEnrC5QJfpzdNGUaCadiTPKZQ6hWWPgb69PbIsY3FdIP+wEmNU4xXz6hygaKN308lWAobkSUYUaYf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714424580; c=relaxed/simple;
	bh=MQuCrwMPjl9SahlT1RpXugY0MT/jSs2oen0IKRVjKHs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z5CauvSE2aU4+aXVdIWmYWSh18YeZJDTW4POFvczRBg4YfGZa2TIKDYqPKbvq5mj43KPNIjo+YiFStxu9CJxkZAGai7Ugla2EP5xMH1mNQVbm5/AWRSqnOA7BQsNL7JSO/iWH07u1LjRIzA85Rj2J4WA0s4dC2YcWM5aNvUZP30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Sb2qCSJI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90702C4AF18;
	Mon, 29 Apr 2024 21:02:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714424579;
	bh=MQuCrwMPjl9SahlT1RpXugY0MT/jSs2oen0IKRVjKHs=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=Sb2qCSJI+U6H2vKGi+t74y2Aj4Iwox1NMPXsO5TnHT4t2Y6tHgUCYfd7hFGMDVk9s
	 w6Q4BY25EWRIQCHDutRZGCxq5kMmA0fWNqXE6Q5FVjEI5hsBvDJllSNoKvXsSA12gA
	 AVYiKPdwcfXBGchT1ibikRqbgXJdUvKRFw1uC4p5imBc81iu/KICiIsfSh32i4Lffr
	 kK5DN3bMLNbgv7I8NUJaDlk44lKKyBgHXluz3HHZfpkpILV9fYbfCHOt5J/NWS54nG
	 hRm8KnkM/ngUID+6XAP9bWzZwFPBtECN5C37O9O1uD4TVoqL/eObHOpnSZwsCR+m1Y
	 KkSEV3PiftUJw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 3A47ECE0B6B; Mon, 29 Apr 2024 14:02:59 -0700 (PDT)
Date: Mon, 29 Apr 2024 14:02:59 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>
Subject: Re: [PATCH 0/4] rcu/nocb cleanups
Message-ID: <73c6f9fd-5f3f-44c4-9955-dd022fda7f59@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240425141835.19776-1-frederic@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240425141835.19776-1-frederic@kernel.org>

On Thu, Apr 25, 2024 at 04:18:31PM +0200, Frederic Weisbecker wrote:
> Hi,
> 
> Some cleanups before converting (de-)offloading to only work on offline
> CPUs.

Seeing no objections, I have queued this series for testing and
review.

							Thanx, Paul

> Frederic Weisbecker (4):
>   rcu/nocb: Fix segcblist state machine comments about bypass
>   rcu/nocb: Fix segcblist state machine stale comments about timers
>   rcu/nocb: Use kthread parking instead of ad-hoc implementation
>   rcu/nocb: Remove buggy bypass lock contention mitigation
> 
>  include/linux/rcu_segcblist.h |  88 +++++++++-----------
>  kernel/rcu/tree.h             |   1 -
>  kernel/rcu/tree_nocb.h        | 149 ++++++++++------------------------
>  3 files changed, 79 insertions(+), 159 deletions(-)
> 
> -- 
> 2.44.0
> 

