Return-Path: <linux-kernel+bounces-44868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 785B7842854
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:47:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F24B4B28756
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C530582D99;
	Tue, 30 Jan 2024 15:47:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ix0GOQRt"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14AE1EAC7;
	Tue, 30 Jan 2024 15:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706629640; cv=none; b=WI6/5YnZvpg5MYa1/civgbYCb6E+xcYjOPIr1QNx3unXbH3GPk4c5+sJXoT21/1Mahcj2+yaxwHapCDXM6muFCwjn6QspX4903v0yygiAIp7Ei4/o1OtUWwOkrRfMp10UcPc4OfXamhY6b+ws5yk32e+EY3hg+ol9es7wcgebu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706629640; c=relaxed/simple;
	bh=0hFwLWXv8l3iNEb/nuzAgNh+gJ5cbBJy4si1SQRC4bo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QHSj2d/aRQAPADhNnD4Aa5KYs1ORvxraOgcz2Ble7JsGL5/WOVpU16vj2NGNmjJCuuRu/tk2jYCy4fwBCpjrNBah/Ur+qhRsjel9DXShOIwNvrHma40ct+REKWMuqNZ8XJlp2EYmfHfFSfD/2IKxN+RtSv95+logIbpYiuxYhUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ix0GOQRt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 020B1C433F1;
	Tue, 30 Jan 2024 15:47:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706629639;
	bh=0hFwLWXv8l3iNEb/nuzAgNh+gJ5cbBJy4si1SQRC4bo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Ix0GOQRtOz7fneqJfzWP5PA2tQgzY2RdPx4tapT7pgubGixjlcwsCUFEh9+xAukWK
	 yDyXrZvfWQd/YJCZAN2X7M9jSa2XLkwEI2CcVbuJqh/FRQXpA8R3Kj1uTWyHlYeh90
	 k31hVH8QEgp31up2iWQKKydsr7FyQN94ln8O701m5a4yFVdlf5RhpRaqYWtZok3GOf
	 qbCIzNCv2qBmnplDnP4wWKjnFj3vd80zyR4fXOgRRfUBsQA8QwKGBmpa7FWJsic8+e
	 hLjUXbL9yvec8G7wGs9NPfgFQasFG7+mz/tUNkCLGkPLlhJYF6TLlIdbKL1jUWqOqO
	 D9IQ6hyodnjwg==
Date: Tue, 30 Jan 2024 16:47:16 +0100
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
Message-ID: <ZbkaBO99-6ZuNCcR@localhost.localdomain>
References: <20240129232349.3170819-1-boqun.feng@gmail.com>
 <20240129232349.3170819-2-boqun.feng@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240129232349.3170819-2-boqun.feng@gmail.com>

Le Mon, Jan 29, 2024 at 03:23:39PM -0800, Boqun Feng a écrit :
> From: Frederic Weisbecker <frederic@kernel.org>
> 
> When an expedited grace period is ending, care must be taken so that all
> the quiescent states propagated up to the root are correctly ordered
> against the wake up of the main expedited grace period workqueue.
> 
> This ordering is already carried through the root rnp locking augmented
> by an smp_mb__after_unlock_lock() barrier.
> 
> Therefore the explicit smp_mb() placed before the wake up is not needed
> and can be removed.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

[Offlist]

For further posting, don't forget to add your own SoB while posting patches :-)

Thanks!

