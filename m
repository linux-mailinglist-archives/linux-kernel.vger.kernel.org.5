Return-Path: <linux-kernel+bounces-76320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DE31585F59A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:26:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 93DCA1F268BA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:26:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179463A1B4;
	Thu, 22 Feb 2024 10:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nxAkwHqU"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52D001B59E
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 10:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708597537; cv=none; b=DrKsL4vNu4lghwv23Bo6EP9hB2k12sF6VO0WnI+q6UbCzsuc1ivyjltD2aHn2eGr9rfJjMZwWN68PBLyhO1ZXZepWUwAXGOIRLc07ACSnQQXApZM//G8RI0QC6UPa5ZdngJ/OJyEW66bLUljb48UXTVuwKv5UKILHE+zFk10JIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708597537; c=relaxed/simple;
	bh=jHPeddCOy8adCP656HMcnAP37nqYydpbombti7EBDIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=YISJuYC5hm0gTWgsigG01DCnk6zy/XRLCb4123G742OLz6IySwX1pmu9rdyik5oxW58nNrBecPV1SwBPCP9WxXMke42gizuAFhdqgRTo1zTGMxoiiTqrdepZ15oJINlmm9omGMr2h8kwH4UC5VVDsPtd0RZQT2bdkojV3ScFcnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nxAkwHqU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37246C433C7;
	Thu, 22 Feb 2024 10:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708597536;
	bh=jHPeddCOy8adCP656HMcnAP37nqYydpbombti7EBDIk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=nxAkwHqU+R+Kp6rbn5CUCbGP6KAw1DjTcTxtaEGUXshLGYsnxzYvRJ9raS11UKufV
	 LJeZYGip/mcbOQBGnMmmLszgLwN6zLy/BhWmOgaW4vRduPFuAGU8lgpw40+e/SPQ0s
	 XHoWM22Oy17zerDDigG2kllnkUz+Vfdo8u41faAsxj4ZT6c1/TjShru6VePy26dlTx
	 gI5w6DdixYP/wByiCIQui3ByA/HpIb3FOG4hczQl2Vu9mMP2DNaxagsLknTpWwzE28
	 i8RUwJYV1jYvQAhOsizY5MDDs92BATZQirZMQ3q+gMBQZax5BVZTEH0cLelg5fJjpy
	 k3SNC5tzy4GVA==
Date: Thu, 22 Feb 2024 11:25:33 +0100
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
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Christian Loehle <christian.loehle@arm.com>
Subject: Re: [PATCH v11 18/20] timers: Implement the hierarchical pull model
Message-ID: <ZdchHZCcE/LkxBYt@lothringen>
References: <20240221090548.36600-1-anna-maria@linutronix.de>
 <20240221090548.36600-19-anna-maria@linutronix.de>
 <ZdZ87whmpul8xIBI@pavilion.home>
 <87jzmwnc9y.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jzmwnc9y.fsf@somnus>

On Thu, Feb 22, 2024 at 09:17:29AM +0100, Anna-Maria Behnsen wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Wed, Feb 21, 2024 at 10:05:46AM +0100, Anna-Maria Behnsen a écrit :
> >> Placing timers at enqueue time on a target CPU based on dubious heuristics
> >> does not make any sense:
> >> 
> >>  1) Most timer wheel timers are canceled or rearmed before they expire.
> >> 
> >>  2) The heuristics to predict which CPU will be busy when the timer expires
> >>     are wrong by definition.
> >> 
> >> So placing the timers at enqueue wastes precious cycles.
> >> 
> >> The proper solution to this problem is to always queue the timers on the
> >> local CPU and allow the non pinned timers to be pulled onto a busy CPU at
> >> expiry time.
> >> 
> >> Therefore split the timer storage into local pinned and global timers:
> >> Local pinned timers are always expired on the CPU on which they have been
> >> queued. Global timers can be expired on any CPU.
> >> 
> >> As long as a CPU is busy it expires both local and global timers. When a
> >> CPU goes idle it arms for the first expiring local timer. If the first
> >> expiring pinned (local) timer is before the first expiring movable timer,
> >> then no action is required because the CPU will wake up before the first
> >> movable timer expires. If the first expiring movable timer is before the
> >> first expiring pinned (local) timer, then this timer is queued into an idle
> >> timerqueue and eventually expired by another active CPU.
> >> 
> >> To avoid global locking the timerqueues are implemented as a hierarchy. The
> >> lowest level of the hierarchy holds the CPUs. The CPUs are associated to
> >> groups of 8, which are separated per node. If more than one CPU group
> >> exist, then a second level in the hierarchy collects the groups. Depending
> >> on the size of the system more than 2 levels are required. Each group has a
> >> "migrator" which checks the timerqueue during the tick for remote expirable
> >> timers.
> >> 
> >> If the last CPU in a group goes idle it reports the first expiring event in
> >> the group up to the next group(s) in the hierarchy. If the last CPU goes
> >> idle it arms its timer for the first system wide expiring timer to ensure
> >> that no timer event is missed.
> >> 
> >> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
> >
> > Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
> >
> > Though I must confess I only had a shallow look at group creation (init_group,
> > get_group, connect_child_parent, setup_groups, add_cpu, and tmigr_init). But for
> > the rest, I'm running out of bad scenarios. Time for the rest of the world to
> > find them!
> >
> > Thanks for the hard work!
> 
> Thank you for your support!
> 
> Did you saw the v11a for this patch? It is only a cleanup - it removes
> an unused variable. Just asking, because Review was for plain v11 patch.

Yep, I reviewed the 11a one, with the "leftmost" variable off.

Thanks.

