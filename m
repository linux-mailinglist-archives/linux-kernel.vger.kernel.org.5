Return-Path: <linux-kernel+bounces-96375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EDF80875B64
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 01:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B5081C20E4E
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 00:06:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56CB37FA;
	Fri,  8 Mar 2024 00:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mYGuQAF9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881BC364;
	Fri,  8 Mar 2024 00:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709856367; cv=none; b=h838OpvpxFEvDCumQtYsdvosY7kLPIxNDohA8CWF1RvhhZ9SmPfOf4RfI1sFV/bqnjlFHF24wGp6Np74a/taTY90R6Bu5fALTZecmJmgW4GYgu6g8YNh1XwGTQrdf1XLT4qFutYduKb2ASlVUzKXn6DnfIxS7DbjRfy56w52i7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709856367; c=relaxed/simple;
	bh=44zl7rfKT4IfdYlB187fgWbtwbHF6PjnpC1W4yMdDIo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ktCpDfx7o91xQsWgRnV76vruz0KVXlsSHAu8UEkybP5H9fCbZisyIxBX+6y2X7ImqFqEVisTHobwVwj2DYmLgq60q/rx8YQRD8OcmwydJBIXbRB4uZqvRThr6vbA9lpLypJNkhzDFwG0lVRVfK7K15x4nhCKOyPTBtbjNkwQb/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mYGuQAF9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7FDC433C7;
	Fri,  8 Mar 2024 00:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709856367;
	bh=44zl7rfKT4IfdYlB187fgWbtwbHF6PjnpC1W4yMdDIo=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=mYGuQAF9LhM6og9CvmxgVC8xHcPsqW774Ij+nj5CqQxJ6/Do8PvIJfkDdjuluPDtX
	 zwEGbATBwQo/l5YDRq6+BQD/1Os6OpjKncJQQoGH+b6P64rdeEGvkFqSKHgATxDrB9
	 1hcGg1S9+roihyx/2YAofMMOlu548z44+C20dAYPJ/h4eicGWBnSxS6AcGdcDH60WI
	 4jafaUAybp6JiXmeCa5xu5ww5oXEVySGpyspvq6PdQZJ6BZOvTV4+ltJ5TVavZFcGv
	 vIy2o3lAG4PcSH3sMsjj+JsvP4erEm8mikBrqLtb+TxvsG8tqriUt9tB2xHGVTpjur
	 0fvFhXODBcK2Q==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id AB3B7CE0716; Thu,  7 Mar 2024 16:06:06 -0800 (PST)
Date: Thu, 7 Mar 2024 16:06:06 -0800
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Joel Fernandes <joel@joelfernandes.org>
Cc: linux-kernel@vger.kernel.org, frederic@kernel.org, boqun.feng@gmail.com,
	urezki@gmail.com, neeraj.iitr10@gmail.com, rcu@vger.kernel.org,
	rostedt@goodmis.org, Neeraj Upadhyay <neeraj.upadhyay@kernel.org>,
	Josh Triplett <josh@joshtriplett.org>,
	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>
Subject: Re: [PATCH] [RFC] rcu/tree: Reduce wake up for synchronize_rcu()
 common case
Message-ID: <ccbdf4d4-6972-430c-a479-0d20b318213b@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240307234852.2132637-1-joel@joelfernandes.org>
 <CAEXW_YQ-TZB-1gpxvf7v+QAZhHtzV5waBA1VemtgEwNktSp=ww@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAEXW_YQ-TZB-1gpxvf7v+QAZhHtzV5waBA1VemtgEwNktSp=ww@mail.gmail.com>

On Thu, Mar 07, 2024 at 06:52:14PM -0500, Joel Fernandes wrote:
> On Thu, Mar 7, 2024 at 6:48 PM Joel Fernandes (Google)
> <joel@joelfernandes.org> wrote:
> >
> > In the synchronize_rcu() common case, we will have less than
> > SR_MAX_USERS_WAKE_FROM_GP number of users per GP. Waking up the kworker
> > is pointless just to free the last injected wait head since at that point,
> > all the users have already been awakened.
> >
> > Introduce a new counter to track this and prevent the wakeup in the
> > common case.
> >
> > Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> > ---
> 
> Forgot to mention, this is based on the latest RCU -dev branch and
> passes light rcutorture testing on all configs. Heavier rcutorture
> testing (60 minutes) was performed on TREE03.

Very good, thank you!

Uladzislau, could you please pull this into the next series you send?
I can then replace your commits in -rcu with the updated series.

							Thanx, Paul

