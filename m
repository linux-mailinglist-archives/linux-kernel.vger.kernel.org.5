Return-Path: <linux-kernel+bounces-44843-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3541842810
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 16:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF51928C34B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 15:30:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24FE823D6;
	Tue, 30 Jan 2024 15:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qxur3Siw"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA009823A7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 15:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706628603; cv=none; b=n9XNvloDQTyOrHrgfvstgrteBLJKOmKQcL+h2E/2lyQ7/kSd7QBkjgQlqRE3zVH40Dfn5pJWJSCzPOdLdE44TTSmHAJnoiADEaZOYIQfDdAlpNtVdFShS3MHgZ5FnSSpGUwfyMwJRKgNNUoiQhUOhriAko+nsXYHBpfkHAjG1/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706628603; c=relaxed/simple;
	bh=80jbZzlmEWIV6mLzBxKiN05mY7enQN9I6AWRUplkQ6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QNki38YbUkeEx02vHX/SVwkKUnw7M9L/nys4p9V5x9wY9RkNJZzMGFHrK51jejvjk68K882JD1xir+HD2RvFop30itkqSmFlxrWBeisUUK6dGjC5CiWg1L4U0d4zhF2NdHw6m5Lco/A6hVBMbv6gSSwYimH+jMpY1vR/vMp9s5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qxur3Siw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D852AC433C7;
	Tue, 30 Jan 2024 15:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706628602;
	bh=80jbZzlmEWIV6mLzBxKiN05mY7enQN9I6AWRUplkQ6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Qxur3Siw7jzRJYmcS60JgXwxJb0Sdpt8yptfeZyt473WUWurFT5547UMYRNrzsSv4
	 kINJKoosiEtOq4nv+Y5sphQWwQ90lMMMd4DGOXfpwpWA4RS/1kjSZqEMUTDu7I88/z
	 7EHxZBUtMks6fxeOE82IGq6eDLiZ30mKRYoa0oMsL3fFnrZbH+Xi1l6zxExCYf7E4D
	 2nbGglx/IO8CHkyuARQrf60Usr3x/P47ixVuln64dq7rBxUVX9qjKvu3tH1cShJBKx
	 gXv5/d6jYohnF48mx2EvpgjgOiVVE3W4OYFoxlVDQVgYTZ8jSvx7SCVbEUh0mqEe4o
	 97RzP5ah24olw==
Date: Tue, 30 Jan 2024 16:29:59 +0100
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
Message-ID: <ZbkV9wVxFhQxujb3@localhost.localdomain>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbJwol4QoSgz0QlH@lothringen>
 <877cjtcuv4.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <877cjtcuv4.fsf@somnus>

Le Sun, Jan 28, 2024 at 04:58:55PM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> >> +
> >> +			if (tmigr_check_lonely(topgroup))
> >> +				return READ_ONCE(topgroup->next_expiry);
> 
> When I hand in tevt->global as a parameter, I'll need to compare the
> first expiry of the toplevel group and the tevt->global value and return
> the earlier expiry. Only a single child is active in top level, so it
> might be that this CPU is the last active CPU in hierarchy.
> 
> I didn't check all the way to the top whether all groups are
> 'lonely'. So when the top level group has only a single active child, it
> is also possible that the child of the top level group has two active
> children... Then a return of KTIME_MAX would be also a more precise
> forecast.
> 
> This quick check is there to keep the overhead minimal when checking
> whether it might be possible to go idle. So I don't know, if we should
> add this additional check per level (which is pretty simple when using
> group->parent for walking the hierarchy). What do you think?

Not sure. Maybe if the tree never exceeds 3 levels (does it?) it's ok to
do the walk?

Thanks.

