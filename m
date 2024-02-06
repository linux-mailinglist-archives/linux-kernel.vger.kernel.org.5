Return-Path: <linux-kernel+bounces-54688-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9DF84B281
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 11:29:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0BC111C235D0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 10:29:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0584912E1F9;
	Tue,  6 Feb 2024 10:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSWhy8p0"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0B512E1F1
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 10:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707215362; cv=none; b=gAjPfTrLRolxtDG0RAusXoDN6y4E0JvhSCi3Dg6HPL8LQeG+g8+33MJulmYTkSEExvJLYIgC2qU/GkdLChd6b8Xbu3fVobhQGLV2B2wnUiDQhO4O5Cqtd7VnyNPyRqiGCGVBaOtqHXJzPuO+MlGEoUzVpo1k/uQpprZlkFgMomM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707215362; c=relaxed/simple;
	bh=qZo0fMDFgva/0AZ58JuIrIfcF7XfwF0vqjw37fr6Aek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Nb7QqLDQ3oqOFshBjDawkHgIguP0f9gt7GQkBYhutmKauQzHoOW7kEHiacCKBt/BvVv1Z0HLGnYYhwKSkm30w1ZtelH1aMWWcvgOJqSASaE7I+VDN51G/1hDKJvGGeCexxSX4URuUfHd/2sX1tbqsiUAZKbJyeSUZ9gGBgDyMts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSWhy8p0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67CE1C433F1;
	Tue,  6 Feb 2024 10:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707215361;
	bh=qZo0fMDFgva/0AZ58JuIrIfcF7XfwF0vqjw37fr6Aek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gSWhy8p0jSa1Xl+mwC35FZP7E93PMJhgY9rkU/iKX+puSZ5pfYXa7VTM3u2Nn9B8s
	 RCwsl/ROzYUHmep7na7HCD/4HIFM9/COW+kQTMzwJRGDYkzITq3SCcUwaBgtuSIZUv
	 CJrnNWu9zkycjsV/gRD7Pkf9VyjZ+oc+yOLmehNgufeDUwEhScG2DStKmCoUhpT10R
	 ivYx35eGbWDX8IdtocQsGMfVoU9c0hp1gOPVIBGCfC1OwN2gyjZ4oueHD3+iAVhs1V
	 owBU/NL3gzx2Czo/CN0aZGpRwBfyPZAt6XarRUixUWpRfowImdIQueHCcWnJuSybJg
	 JQ8j6UpsSLINA==
Date: Tue, 6 Feb 2024 11:29:19 +0100
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
Message-ID: <ZcIJ/1p9jbmPP4tF@lothringen>
References: <20240115143743.27827-1-anna-maria@linutronix.de>
 <20240115143743.27827-19-anna-maria@linutronix.de>
 <ZbuzMeKlCgebhJZ-@localhost.localdomain>
 <87bk90i2ja.fsf@somnus>
 <ZbvYJysR7gnaQiNg@localhost.localdomain>
 <87y1c3lxec.fsf@somnus>
 <87y1bzqbsx.fsf@somnus>
 <ZcFFSgjcDcuz7Swv@pavilion.home>
 <87jznh3o10.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87jznh3o10.fsf@somnus>

On Tue, Feb 06, 2024 at 11:06:19AM +0100, Anna-Maria Behnsen wrote:
> Frederic Weisbecker <frederic@kernel.org> writes:
> 
> > Le Mon, Feb 05, 2024 at 02:29:34PM +0100, Anna-Maria Behnsen a écrit :
> >> Anna-Maria Behnsen <anna-maria@linutronix.de> writes:
> >> 
> >> > Frederic Weisbecker <frederic@kernel.org> writes:
> >> >
> >> >> Le Thu, Feb 01, 2024 at 05:15:37PM +0100, Anna-Maria Behnsen a écrit :
> >> >>> Frederic Weisbecker <frederic@kernel.org> writes:
> >> >>> 
> >> >>> > Le Mon, Jan 15, 2024 at 03:37:41PM +0100, Anna-Maria Behnsen a écrit :
> >> >>> > Heh, I was about to say that it's impossible that timer_base_is_idle()
> >> >>> > at this stage but actually if we run in nohz_full...
> >> >>> >
> >> >>> > It happens so that nohz_full is deactivated until rcutree_online_cpu()
> >> >>> > which calls tick_dep_clear() but it's a pure coincidence that might
> >> >>> > disappear one day. So yes, let's keep it that way.
> >> >>> 
> >> >>> I instrumented the code (with NOHZ FULL and NOHZ_IDLE) to make sure the
> >> >>> timer migration hierarchy state 'idle' is in sync with the timer base
> >> >>> 'idle'. And this was one part where it was possible that it runs out of
> >> >>> sync as I remember correctly. But if I understood you correctly, this
> >> >>> shouldn't happen at the moment?
> >> >>
> >> >> Well, it's not supposed to :-)
> >> >
> >> > Hmm, let me double check this and run the tests on the instrumented
> >> > version...
> >> 
> >> I added a prinkt() to verify what I think I remember. I was able to see
> >> the prints. So it seems, that the coincidence that nohz_full is
> >> deactivated until rcutree_online_cpu() already disappeared.
> >
> > Nice, then I guess it can become a WARN_ON.
> 
> Either I misunderstood something, or wasn't able to explain what I
> wanted to say.
> 
> I understood, that nohz full is disabled (by coincidence) until
> rcutree_online_cpu() which comes after the timer migration CPU hotplug
> AP. This means, that the check whether timer base is idle or not,
> shouldn't be required in tmigr_cpu_online() to keep cpu idle or mark it
> active in the hierarchy. But we could keep it in case coincidence
> disappears. No?
> 
> So I added a printk() when timer base is idle in tmigr_cpu_online(). And
> I was able to see the prints. This means, nohz full is _not_ disabled
> when executing tmigr_cpu_online(), or am I wrong?
> 
> So when I replace the printk() with a WARN_ON() it will definitely
> trigger. So I'm not sure if this is what you want to have :)

Yes, silly me, I thought the tick dependency was set on all hotplug
operations but it's only cpu down. So this piece doesn't need to change
AFAICT.

