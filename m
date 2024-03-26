Return-Path: <linux-kernel+bounces-119572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 016CB88CA91
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 18:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 720FCB23F55
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 17:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2FF61C6B5;
	Tue, 26 Mar 2024 17:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iUEVgwaR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1382E1C2AF;
	Tue, 26 Mar 2024 17:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711473524; cv=none; b=X4iT7aTpVlgiOIpMMC7GxGpaIKhOefAQYZyYEWbX4bbBPBSLSmn7OPlhbAhWx7YD1StRoLlvN7+G2m73EdOQrHY+VaklcWKkjJ2xRORzIWldUFemuRSLA2SuTr3KbZXzDE8RXOdGHvfz1yzFoY30ywFpOc48/mFucT7t5dfsm6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711473524; c=relaxed/simple;
	bh=OELWXVXqN2pN+dBq4GD1HVskjaEZn6Buw4ZbYGID18o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ecXK5D599gnJxmHXxpHSGPzLz0ecBoONOt+ctHL9x8pnO354cp2GJlhw+DrsVqurAp4guw0rN1dIAZBcurZfJuKtreK0KtFUKLt4kmS9xp0F8yU+jb83Xom9WCWjF2KPnq6GbtJaBvYqs2n3LbN+/r1fNdBpZA4CSr8JXNU6V5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iUEVgwaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34370C433F1;
	Tue, 26 Mar 2024 17:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711473523;
	bh=OELWXVXqN2pN+dBq4GD1HVskjaEZn6Buw4ZbYGID18o=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iUEVgwaRX6aZT96UVqp/fsF/1hcY/RgzUvzjtwC5cX1+hGXneR17p20DLXj0hIRXg
	 v8K42vdYEcJFrPhrvT/0JqQW14LJn43VfImA/3ZCK2r4vGCxporMdRwsik+G0BL58Z
	 iOQT+Od3cOvcfCS2sh8ciYDevDXN74aV/3iCSu8tcRcsFDg/Ixrxp+1EmpSVSnpgHb
	 KCCYBndtAMg4d6OV6dJI2ZyxCyBW269zKSgNY0KEAAFDHerUHeB2/t9WuwNn3tcKeg
	 8GMeJdJj+41O5Y/16Za6KQ7TLfqj35YX2B1NwWkueaDev+Qp+FJ2dlOz9ZlGVHxLb/
	 Z2c32NPbyiKuw==
Date: Tue, 26 Mar 2024 18:18:40 +0100
From: Frederic Weisbecker <frederic@kernel.org>
To: Anna-Maria Behnsen <anna-maria@linutronix.de>
Cc: Boqun Feng <boqun.feng@gmail.com>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	Joel Fernandes <joel@joelfernandes.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	linux-kernel@vger.kernel.org, kernel-team@meta.com,
	paulmck@kernel.org, mingo@kernel.org, rcu@vger.kernel.org,
	neeraj.upadhyay@amd.com, urezki@gmail.com,
	qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
	chenzhongjin@huawei.com, yangjihong1@huawei.com,
	rostedt@goodmis.org, Justin Chen <justin.chen@broadcom.com>
Subject: Re: [PATCH] timer/migration: Remove buggy early return on
 deactivation [was Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU
 changes for v6.9]]
Message-ID: <ZgMDcGOagCjfIB3i@localhost.localdomain>
References: <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com>
 <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx>
 <ZfN0wY41pU5UjP8T@boqun-archlinux>
 <ZfOhB9ZByTZcBy4u@lothringen>
 <87zfulrlnn.fsf@somnus>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zfulrlnn.fsf@somnus>

Le Tue, Mar 26, 2024 at 05:41:00PM +0100, Anna-Maria Behnsen a écrit :
> Frederic Weisbecker <frederic@kernel.org> writes:
> Now propagation goes on as GRP0:0 is completely idle. When executing
> tmigr_update_events() in the next step of walking the hierarchy via
> tmigr_inactive_up(), the arguments for tmigr_update_events() are set in
> the following way:
> 
>   group = GRP1:0
>   child = GRP0:0
> 
> Then at the begin of tmigr_update_events() the group event of child is
> updated - so all ignored events are removed (T0i), and the
> child->groupevt and child->next_expiry is updated with T1. This
> reevaluated child->groupevt is then queued/updated in the GRP1:0
> timerqueue.
> 
> So T1 will be handled!
> 
> As there is no parent, the top level group event is updated (see goto
> label "check_toplvl") and T1 will be still the first event.

Bah! Good point, I got confused there...

> 
> > Fix those issues with removing the buggy related early return. Ignored
> > child events must not prevent from evaluating the other events within
> > the same group.
> 
> I would prefere to keep this early return but skip it, when there is
> !group->parent (only a single level in hierarchy).
> 
> Then it would prevent taking the group lock and making some random
> event updates which are done nevertheless on the next iteration of the
> hierarchy walk.

Ok sounds like a good plan!

Thanks.

> 
> Thanks,
> 
> 	Anna-Maria
> 

