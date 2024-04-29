Return-Path: <linux-kernel+bounces-162864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 308968B617A
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:57:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68D11F2226B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B7B913AA51;
	Mon, 29 Apr 2024 18:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RzN8xxuN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DB9F13AA3E;
	Mon, 29 Apr 2024 18:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714417033; cv=none; b=NCVRn0vR0DXpyYs8iNwIJC1kJ5xCIstqz5B0G/rUPid3nwIo9EQebWaXA5fC6adnlokPxej03CsnCA6Fo5Am6Uxv5GQwjM2VBqk4IYDP1TiD/CKgMunN9IOU67AuK5iZH4EHrpbi1+XPPZLkj+yx8sA9gB7ZZGgPLvX1GrCTnQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714417033; c=relaxed/simple;
	bh=JPhM08qiIm2VPcY/dT/N4bnCIIV5koeei+mRAeSp5+A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qh/Ll3Jia0XwXAuPBTmaEFjdUgsDiUvnB4y87a+5kDGrRKsH6hxG1GjO6taPFc8YHrG5dynSfJ48pAXEDvl9/Kblp82p4EL99EsL5vW5H6u8Y2CxIfacbH+tPO/w2nHNmjSufw873VsNI+K5WAZTRcJnfPJao8fBbuG7+TmoYhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RzN8xxuN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EFC1C113CD;
	Mon, 29 Apr 2024 18:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714417033;
	bh=JPhM08qiIm2VPcY/dT/N4bnCIIV5koeei+mRAeSp5+A=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
	b=RzN8xxuN+H8TkP+Zf+9rXYpOrXBA1MIsz5FBx73BTH8X5HMsX+qMi8rpL3yk01AUw
	 nclIz63IYBCVz9DZBORvCvWuRx5H8A+MH/hOTbRYWd3cVEpmXw17n0BkYgzCCSLcYa
	 lLADpCKKVO9yrsiPt1CVOBsifdxGw4sIZBDvHtN4hxWc4EUZ3PpA/OejwO02abNYEF
	 u7eziIoEXhl6Tz+pFv0KCI8sPeUzQPYYdLsErfKIoh1LXy3TtL+pz0nRggrtNe7Wyn
	 QEjJTzSBI/qqkDO1Zb+ay2tMOcDtbSXRvC8mu7L7B0fFDFC1RHkDReIiXA6Dcey/p9
	 SkTk+Tvozaa/w==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
	id B6826CE0B6B; Mon, 29 Apr 2024 11:57:12 -0700 (PDT)
Date: Mon, 29 Apr 2024 11:57:12 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: Frederic Weisbecker <frederic@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>,
	Boqun Feng <boqun.feng@gmail.com>,
	Joel Fernandes <joel@joelfernandes.org>,
	Neeraj Upadhyay <neeraj.upadhyay@amd.com>,
	Uladzislau Rezki <urezki@gmail.com>,
	Zqiang <qiang.zhang1211@gmail.com>, rcu <rcu@vger.kernel.org>,
	"Eric W . Biederman" <ebiederm@xmission.com>,
	Lai Jiangshan <jiangshanlai@gmail.com>
Subject: Re: [PATCH] Revert "rcu-tasks: Fix synchronize_rcu_tasks() VS
 zap_pid_ns_processes()"
Message-ID: <c5111e49-613d-492b-aa51-1be4d6101aa0@paulmck-laptop>
Reply-To: paulmck@kernel.org
References: <20240425142404.19927-1-frederic@kernel.org>
 <20240429110328.GB1101@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240429110328.GB1101@redhat.com>

On Mon, Apr 29, 2024 at 01:03:28PM +0200, Oleg Nesterov wrote:
> On 04/25, Frederic Weisbecker wrote:
> >
> > This reverts commit 28319d6dc5e2ffefa452c2377dd0f71621b5bff0. The race
> > it fixed was subject to conditions that don't exist anymore since:
> >
> > 	1612160b9127 ("rcu-tasks: Eliminate deadlocks involving do_exit() and RCU tasks")
> >
> > This latter commit removes the use of SRCU that used to cover the
> > RCU-tasks blind spot on exit between the tasklist's removal and the
> > final preemption disabling. The task is now placed instead into a
> > temporary list inside which voluntary sleeps are accounted as RCU-tasks
> > quiescent states. This would disarm the deadlock initially reported
> > against PID namespace exit.
> >
> > Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> > ---
> >  include/linux/rcupdate.h |  2 --
> >  kernel/pid_namespace.c   | 17 -----------------
> >  kernel/rcu/tasks.h       | 16 +++-------------
> >  3 files changed, 3 insertions(+), 32 deletions(-)
> 
> LGTM. FWIW,
> 
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>

Queued, thank you both!

							Thanx, Paul

