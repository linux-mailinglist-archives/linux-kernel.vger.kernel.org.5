Return-Path: <linux-kernel+bounces-139250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABAA18A0080
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 21:19:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A3E4B2235F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:19:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1055181313;
	Wed, 10 Apr 2024 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr0apBBM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FAEF53372;
	Wed, 10 Apr 2024 19:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712776775; cv=none; b=iAaPDy8LaSzh1fX3GvyPHK+7PQdkjrncCszuImRn0WrFXESfwYf7VjmA9KNgpuSRbnlbXSXsYSOyjCDCKVoqDmgsBirEhfpzDnhfZZRgakWiD5pYat0hVAL4lIih86oSMUf5I/DTKHJn7SO6DYq0XmWl6PAY2dFHWKRq8icUAuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712776775; c=relaxed/simple;
	bh=K++b5c401KCoXtWP4zJWdo7+5dgf/l3qUVTQ7zgCO1A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Fnbr9yvWXCtiQto2MjqaBDPlQBJN4JNEVCP0ELvn5S8fKlGxl+7bORrooIsQo5N6DDI6rL9sUtgIhRCRxgBslVFhAqVT/+ut8Lo40Er1xiHpSogtOMnrNuqtOz1Jv77KPPBf/1w+6May7IMpQbhbiMJvDvTp1mCMLwK5QU94u6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr0apBBM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC58FC433C7;
	Wed, 10 Apr 2024 19:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712776774;
	bh=K++b5c401KCoXtWP4zJWdo7+5dgf/l3qUVTQ7zgCO1A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=jr0apBBMdx0mEdxt0iMc+VLX/jeBy0z1fRlAU7NTEQ8bA/wmki/1aNR1Nut6vg5Yb
	 SzNq+XpsWcfBelYlt1OBrEN169bwu2SI5dLlxni9jHDVNl9mHf/QTeCaCR3QRgn1BH
	 5/2QSshwjRl0RoYGGjmWQZ4eOOzaQriZ7DhyFkWlcu3zMw2m89mBOpdlQchWL8XGtR
	 HA/rqPWtDdiY3UjlrkV2YeyqTxMm5oryZT3KR+t5BlQ7oBL0HaTyhwHjWICFqFmJ+S
	 /Q/q3U+QYGd/fPVzyn25z8qIzFRVe6djGrhawlStV1coNIkISsMSyiVkWWAw5WP/PR
	 wF5mannKW7g9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id 70856CE1104; Wed, 10 Apr 2024 12:19:34 -0700 (PDT)
Date: Wed, 10 Apr 2024 12:19:34 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Frederic Weisbecker <frederic@kernel.org>
Cc: Valentin Schneider <vschneid@redhat.com>, rcu@vger.kernel.org,
	linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
	Neeraj Upadhyay <quic_neeraju@quicinc.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH 2/2] context_tracking, rcu: Rename RCU_DYNTICKS_IDX to
 CT_DYNTICKS_IDX
Message-ID: <af3eed7e-a889-4008-ba47-045483ab79fc@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240327112902.1184822-1-vschneid@redhat.com>
 <20240327112902.1184822-3-vschneid@redhat.com>
 <Zg6tYD-9AFPkOOsW@localhost.localdomain>
 <1ef9d1f9-16a2-4ddc-abd5-6c3b7cde290f@paulmck-laptop>
 <ZhZqX0YqlzPoOK2b@localhost.localdomain>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZhZqX0YqlzPoOK2b@localhost.localdomain>

On Wed, Apr 10, 2024 at 12:30:55PM +0200, Frederic Weisbecker wrote:
> Le Tue, Apr 09, 2024 at 12:53:03PM -0700, Paul E. McKenney a écrit :
> > On Thu, Apr 04, 2024 at 03:38:40PM +0200, Frederic Weisbecker wrote:
> > > Le Wed, Mar 27, 2024 at 12:29:02PM +0100, Valentin Schneider a écrit :
> > > > The symbols relating to the CT_STATE part of context_tracking.state are now
> > > > all prefixed with CT_STATE.
> > > > 
> > > > The RCU dynticks counter part of that atomic variable still involves
> > > > symbols with different prefixes, align them all to be prefixed with
> > > > CT_DYNTICKS, as CT_DYNTICKS_MASK already is.
> > > > 
> > > > Signed-off-by: Valentin Schneider <vschneid@redhat.com>
> > > 
> > > It used to be that RCU extended quiescent state and dynticks enter/exit
> > > were coupled. But this isn't the case anymore. Nowadays RCU stops watching
> > > some time later after dynticks is entered.
> > 
> > I knew that consolidation of atomic operations was too good to last...
> > 
> > > I wonder if we shouldn't take advantage of that cleanup for a meaning that
> > > really reflect that RCU stops watching from there.
> > > 
> > > Paul what do you think? CT_EQS_IDX ? CT_RCUEQS_IDX? CT_RCUOFF_IDX? ...?
> > 
> > "After what you just did?  You can just RCU off!!!"
> > 
> > Sorry, couldn't resist...
> > 
> > I am having a hard time getting too excited about the name.  I could
> > suggest CT_RCU_WATCHING_IDX, but that isn't exactly the shortest
> > possible name.
> 
> I really like CT_RCU_WATCHING. It says everything. The _IDX isn't even
> needed after all. What do you think?

Works for me!

							Thanx, Paul

