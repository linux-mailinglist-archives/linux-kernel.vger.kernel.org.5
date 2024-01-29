Return-Path: <linux-kernel+bounces-43426-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E86CC8413B2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 20:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 757E9B21610
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 19:43:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C524E6F071;
	Mon, 29 Jan 2024 19:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WRzzmOYH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14E4A4C631;
	Mon, 29 Jan 2024 19:43:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706557424; cv=none; b=N79yKaST9eCQ+GzNdmH4SRJPHSKVaFHoH2Hc6FglLm1SdmQ2Grn1RB/XS1IzGKX3kvzYgClpVmeXZpXjNrmtgbPsnhQMZ0spU9vD5y8SdO/v2qTB//qxvUbPks+ajGz+riKBDrABFNodJX/nzr2PG4X3kv5phsiHHxTtIKBtLC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706557424; c=relaxed/simple;
	bh=+kaFS2NgmQ+6YLaDrDI1LndSwxmLUual7mbaca44+Sw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QCsk7hJb+d4k7aP2nhMS1JenIuSCnNQg9IS6KLxvJZsTOcVbPfIMkSchR5rQtXuKom3PjMplalU+Splt1QHyt/Q4XCsgAcEQAs+d/nVmh8E8lKmPYHQlxGj21eK2RZa0cA+0yX1qfl9XvYFL3OZ51yF5ri/FEBvMpu5hk0EpwaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WRzzmOYH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74898C433C7;
	Mon, 29 Jan 2024 19:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706557423;
	bh=+kaFS2NgmQ+6YLaDrDI1LndSwxmLUual7mbaca44+Sw=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=WRzzmOYHLjnlzFiQmNUd0G0jaliD1Fly8FfIQkAnmRThGJwwujXbTtGNEHxbZf5qr
	 2cWz9bTj7icljDJA9TrPQstDL9GYTMWOmecIBBbsRDU1GFCI6incxI0nN5IlmoX73l
	 kpeFr3GqvHAP4mW8XlAUX0FVKpIEpvRHwUvoB69EvHdzx320gn2z8NF5JYBwIMB1Qq
	 9oP8N8tM542rd5S5ofVGKYs4XyPtOL3O3JjsCqLgdU6TvD5wJ8hVDjZrnYdplvbw6p
	 VkBGKqF3FNbxmRBsW+2hy1+cMHtaFQBqfIV46t1r8jMAhHubDJH05b8/CYZSr1xx7q
	 kmk/WbqwiYG0g==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 0E166CE0ADB; Mon, 29 Jan 2024 11:43:43 -0800 (PST)
Date: Mon, 29 Jan 2024 11:43:43 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Uladzislau Rezki <urezki@gmail.com>
Cc: RCU <rcu@vger.kernel.org>, Neeraj upadhyay <Neeraj.Upadhyay@amd.com>,
	Boqun Feng <boqun.feng@gmail.com>, Hillf Danton <hdanton@sina.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Oleksiy Avramchenko <oleksiy.avramchenko@sony.com>,
	Frederic Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH v4 0/4] Reduce synchronize_rcu() latency(v4)
Message-ID: <adb813a3-e24e-4fb3-b1cf-fad5a571fe9a@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240104162510.72773-1-urezki@gmail.com>
 <620b475d-eef8-4396-9d3a-d3dcf1d70f9a@paulmck-laptop>
 <ZbfQ5cOkeReti7J0@pc636>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbfQ5cOkeReti7J0@pc636>

On Mon, Jan 29, 2024 at 05:23:01PM +0100, Uladzislau Rezki wrote:
> On Fri, Jan 26, 2024 at 11:07:18PM -0800, Paul E. McKenney wrote:
> > On Thu, Jan 04, 2024 at 05:25:06PM +0100, Uladzislau Rezki (Sony) wrote:
> > > This is a v4 that tends to improve synchronize_rcu() call. To be more
> > > specific it is about reducing a waiting time(especially worst cases)
> > > of caller that blocks until a grace period is elapsed. 
> > > 
> > > In general, this series separates synchronize_rcu() callers from other
> > > callbacks. We keep a dedicated an independent queue, thus the processing
> > > of it starts as soon as grace period is over, so there is no need to wait
> > > until other callbacks are processed one by one. Please note, a number of
> > > callbacks can be 10K, 20K, 60K and so on. That is why this series maintain
> > > a separate track for this call that blocks a context.
> > 
> > And before I forget (again), a possible follow-on to this work is to
> > reduce cond_synchronize_rcu() and cond_synchronize_rcu_full() latency.
> > Right now, these wait for a full additional grace period (and maybe
> > more) when the required grace period has not elapsed.  In contrast,
> > this work might enable waiting only for the needed portion of a grace
> > period to elapse.
> > 
> Thanks. I see it. Probably we also need to move "sync" related
> functionality out of tree.c file to the sync.c or something similar
> to that name. IMO. 

I would prioritize moving the kfree_rcu() code out of tree.c quite
a ways over moving out the synchronous-wait code.  ;-)

							Thanx, Paul

