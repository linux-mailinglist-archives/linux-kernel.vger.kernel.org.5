Return-Path: <linux-kernel+bounces-37207-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F171383AC8C
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 15:56:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 308E01C21710
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688A92B9D6;
	Wed, 24 Jan 2024 14:52:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiInJE32"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1FC0362
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 14:52:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706107956; cv=none; b=aXT9biLntJpjE5foEsVE7psy74hL29e14++Ep/kbNxLkgtk1bcL2cBUj/HGXzpJyQ9bYqU6IEebUvRr1bdZ7bX1UKPI4a9+9L8NRapc8bP+kF5qKsoGyGTmakqvgwlpsQNUH3GpxwW+DG4gl+mCu/M8RBwnXOpJCcq+Zk0lz3as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706107956; c=relaxed/simple;
	bh=PgUauHGGR60fPglyTjPAB/5swegamxCnZ5ahUXY87eY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=K0yPL1QxRHVpvlJ5hC80wMrf4qQMaynOct8Z+mJ/S80gviVXbXwzeag8q2lQd5qD6BBJphn6aZ53zHFmM8X/ubr/CWrDc+FbsGB7ff3rUtqcTEypBJafyPaC57RxI8VYpZyX4Ndwn+TwqOEu7zyereROYeGGPJYjUO/0lbhsFaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiInJE32; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9757FC433C7;
	Wed, 24 Jan 2024 14:52:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706107956;
	bh=PgUauHGGR60fPglyTjPAB/5swegamxCnZ5ahUXY87eY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aiInJE32WSG4IVDgZHIN//8kLNzqbo0uSMdZv4E3IgOZ/ELh7r05W1jC0jCkQKZTd
	 qkhoTK+Fh8Q3wTCIlyEA/OJvk7nQZQR/GySBg+4ih1H/EDk7BQBeEzZgn6is/rHNW+
	 LwwV3CtyHmhhkeHBSuvWncEmn3MjdMR/+CzitHXgXLjvMVNDTDOdyGqoeqccZhnZwv
	 Fu/LsFySfWViAaiFczdQ/Xg4dwpe5t6xB8SnFPE29kuIVh9paDPacZThWBNqwSDvOm
	 9a9ZunhtR8zE2iQhZ5l/LGMPMfUrhv+tgAk4P8qQyilj8kgTyXmjOX6beuc+zGS9mR
	 GhzPcQmAGiBWA==
Date: Wed, 24 Jan 2024 15:52:33 +0100
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
Subject: Re: [PATCH v10 17/20] timers: Introduce function to check timer base
 is_idle flag
Message-ID: <ZbEkMRfP_v7Jt81y@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-18-anna-maria@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240115143743.27827-18-anna-maria@linutronix.de>

Le Mon, Jan 15, 2024 at 03:37:40PM +0100, Anna-Maria Behnsen a écrit :
>  flag
> 
> To prepare for the conversion of the NOHZ timer placement to a pull at
> expiry time model it's required to have a function that returns the value
> of the is_idle flag of the timer base to keep the hierarchy states during
> online in sync with timer base state.
> 
> No functional change.
> 
> Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>

