Return-Path: <linux-kernel+bounces-55099-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D8B8D84B7B3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:22:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C6A3B288EA
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1BF9132484;
	Tue,  6 Feb 2024 14:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R2GnfRAX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03DD6132464
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 14:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707229314; cv=none; b=C2CCG5EF2z7MLfNOJ3xre0It/G4ZbZ3UbjFasOXm/x6B60+YyGpWP9pgzjjBrwgKcWalcmIIChTyLbR+i5TOykfzTKcVmAj4NHWChmXzTleYkoj76ThOJ/jGt4wFJcQavOmiCDoGpQ0Vzz4+Zfxl6sj2bPUlptxtKeOt6PeG6jI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707229314; c=relaxed/simple;
	bh=RUTHevF5MwbseyZgKH+07BgbAUcplH0ajmEO4J9WH38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bGEz0+O39o21DG3ikTvDGDMy3bYjydiu8wuBAt8YfHSu94/z+8hwp1cZoTANqJ0k1KK7KSq2s+ap6uhzm3gg/Hpw91Po96SBH2h9vw3gREyndYVBBCmcrQuj96ehTR2yfrs6VBMZ9uBPTyrhtLU/OIOJq+hG0fGyxMVIVSvdAo8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R2GnfRAX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2123AC433F1;
	Tue,  6 Feb 2024 14:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707229313;
	bh=RUTHevF5MwbseyZgKH+07BgbAUcplH0ajmEO4J9WH38=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R2GnfRAXCXIcN4LUkAN+4M+h5JAztETmCVnjqJgUI1KRW3ggf5P9x460C0qNgmaRS
	 Xa2iu2tsRF+ovdtWOGV1RCbsd/+V30TxmFhpeZgDv3ba/0WcJ1lABqaAWzQ9nNlMq9
	 d5VHaR7ZvUO/T4wthV4+cfIiWQ50Bu7hfIHaMmKASzWXK6tgCBrBFk17iKVjfkE9SK
	 gApdf3lqydNtAtYBgk0jgqQXiUNzehgW8lJwwr4vw+2DbIlpxZP1u2r6FHWLiWi9eG
	 /INK9ZItji4XzlrarGWFRQX3p3fxPi7UvIJTUlqXeZYPQhSM4sKj6hN6Wiy1Wz0EUw
	 XzgemrAZh4arQ==
Date: Tue, 6 Feb 2024 15:21:50 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	John Stultz <jstultz@google.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Eric Dumazet <edumazet@google.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Arjan van de Ven <arjan@infradead.org>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Rik van Riel <riel@surriel.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sebastian Siewior <bigeasy@linutronix.de>,
	Giovanni Gherdovich <ggherdovich@suse.cz>,
	Lukasz Luba <lukasz.luba@arm.com>,
	"Gautham R . Shenoy" <gautham.shenoy@amd.com>,
	Srinivas Pandruvada <srinivas.pandruvada@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>
Subject: Re: [PATCH v10 18/20] timers: Implement the hierarchical pull model
Message-ID: <ZcJAflq1vLx3k-cl@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZcAQZ8-gbEYaQflu@pavilion.home>
 <87eddp3ju0.fsf@somnus>
 <ZcIyWJxeLy4GaTbM@localhost.localdomain>
 <878r3x3cl8.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878r3x3cl8.fsf@somnus>

Le Tue, Feb 06, 2024 at 03:13:23PM +0100, Anna-Maria Behnsen a écrit :
> When remote is not set, and the group is not active (but it's not top
> level), walk_done will be set to true. Then goto check_toplevel. There
> walk_done and the groupstate migrator check is both true. But it is not
> top level... and the next goto unlock will also not happen and
> data->firstexp will be set. No?

Bah yes of course, walk_done doesn't mean we are in the top then, you're right.

> 
> >> 
> >> There is another issue in here. When the event could be ignored and it
> >> is propagated because of e.g. remote timer handling, then the timerqueue
> >> dance is done nevertheless. It's not a big problem (as the ignore flag
> >> is set and event is removed of queue when revisting the timer queue),
> >> but its obviously more work than it is required to have.
> >
> > Right. I guess it doesn't hurt to delete it from the timerqueue if present and
> > then update group->next_expiry accordingly. But it's certainly not useful
> > to requeue it :-)
> >
> 
> This would be the plan to keep the delete but drop the requeue in this
> case.
> 
> With those two things, the tmigr_update_events() wants to be changed a
> little more.

For the best!

Thanks.

