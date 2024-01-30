Return-Path: <linux-kernel+bounces-44870-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3418D842858
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:48:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8C401F27254
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:48:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C4F82D99;
	Tue, 30 Jan 2024 15:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lUS5fZ58"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32486A32D;
	Tue, 30 Jan 2024 15:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629725; cv=none; b=SEjGAt9fj2Y4MptGW1mP8wyC94u6BdFxQfLzHMO35FlsjH9oFgQuEtTEgS9z75RhgQMXYi+rLwCzQ1ML40dtT9c/7RaxYa7MDTrZ6ofysrzI7Dfv8q3vorBsnCIrlYXo33/9NdO1hiAFTvQ7nQVa0RMVzKH3yW5z6r3M5CY6RYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629725; c=relaxed/simple;
	bh=yTujMnql4yUMoznvweOoKBZMoA56VqLnJzwfD5oRz4s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=No91CywcAO4QA3Q52BDD5Z865tyFqQ+rcwvBpWH4u4yonu4YRLImjGo0rIQ0vQnq1yq89UtzPBi374t8stm2IAqvwzNgIyMSsu9zQexiHK3T6njbJkKyPvzJsqfPg/K2zbyEfQlIVaRqijfzg1Kos7mFBttQd+BYvDlAwWIE9BM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lUS5fZ58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C6EEC433C7;
	Tue, 30 Jan 2024 15:48:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629724;
	bh=yTujMnql4yUMoznvweOoKBZMoA56VqLnJzwfD5oRz4s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lUS5fZ58kdH7Ue/vpJzExyh9NPNINmBBRVTB8leklIHb9m7ocPsDE7B+FMOXGsmk8
	 iv/5s3LSC6JGOSQlJR+mcWfwBWBs7EK2fyDLm7BorgPsE0NiFkSXgxY6tzbVdTQiW3
	 Jvghi1vX+bwCCscsHDrzChvzctsFqkY7BRAWQJzUAwTGsvwyqZtPBTEa8WNxcs0yEO
	 GLfKc7CyiLEojwb1iOFByB4qMuSgu1tsj5AMR9Yg0R8E/MfXPHcZ7YD4Wx9UMeZNSZ
	 4HySbmInYgcgeUlcrCKWKTqHPEKpq7cQ38Z0icnWmeAJ8+7mgNaCvqnMON8yk0GViP
	 CA9Ii6T6XRjrQ==
Date: Tue, 30 Jan 2024 16:48:41 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Neeraj Upadhyay <neeraj.iitr10@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 1/8] rcu/exp: Remove full barrier upon main thread wakeup
Message-ID: <ZbkaWbpufZ6q-jLZ@localhost.localdomain>
References: <20240129232349.3170819-1-boqun.feng@gmail.com>
 <20240129232349.3170819-2-boqun.feng@gmail.com>
 <ZbkaBO99-6ZuNCcR@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZbkaBO99-6ZuNCcR@localhost.localdomain>

Le Tue, Jan 30, 2024 at 04:47:16PM +0100, Frederic Weisbecker a écrit :
> Le Mon, Jan 29, 2024 at 03:23:39PM -0800, Boqun Feng a écrit :
> > From: Frederic Weisbecker <frederic@kernel.org>
> > 
> > When an expedited grace period is ending, care must be taken so that all
> > the quiescent states propagated up to the root are correctly ordered
> > against the wake up of the main expedited grace period workqueue.
> > 
> > This ordering is already carried through the root rnp locking augmented
> > by an smp_mb__after_unlock_lock() barrier.
> > 
> > Therefore the explicit smp_mb() placed before the wake up is not needed
> > and can be removed.
> > 
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> 
> [Offlist]

And yes that was not offlist, my fingers betrayed me!

> 
> For further posting, don't forget to add your own SoB while posting patches :-)
> 
> Thanks!
> 

