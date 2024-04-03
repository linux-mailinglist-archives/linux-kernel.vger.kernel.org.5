Return-Path: <linux-kernel+bounces-129051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BF528963D9
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 07:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D9311C23106
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 05:11:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F347946537;
	Wed,  3 Apr 2024 05:11:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="whgPDScP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23681645;
	Wed,  3 Apr 2024 05:11:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712121072; cv=none; b=HcpE5uWtwIb3Z9xy8+x2Cr0ZsGDjhLAOMqZPXPYx6+H/E23zqIYsi4QYZe1QxrhMQR7AenkVi3JIQELe01KApn+TjF3LZw3GXpAB5K8QLCJOJbE2PmFsPABDkv+wZ2MCMtdT9zGB8alpf+trOFBIcSwK2cUtZQvzM8HK2ERpLFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712121072; c=relaxed/simple;
	bh=T9MKyL0Zcn/MBAFQd4GiMUaz82CINlxa5onm2hdqIFc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qi4glJMVZo6twm4llGF3v2pKX2ZRdmMfAmHJc7NZGo6VXE+6BSa13m84EQVVVc3epzGJf1lhsAiJU7nBzdNgz31Nurkh4d9q+pPQ1LdrzyRtfuoC8K+gIv+suDcgmrJ3MdHXkhg8X20Cya+fEBDTjBZZ8/NoQmNCikUFB0ITyyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=whgPDScP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F319AC433C7;
	Wed,  3 Apr 2024 05:11:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712121071;
	bh=T9MKyL0Zcn/MBAFQd4GiMUaz82CINlxa5onm2hdqIFc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=whgPDScPUWSD3vvHP8tZsIVB+ziBCCcwZBIYgk/Y9wdUhPLxu2t9jDw4G99SN35tS
	 2WiTsOtTRbQlETx8ZjQXC9HYRF2hihaSmTcngrmjc94hv7wBATGzV9eBJ/IP5lOgGS
	 IJ60C718Ohk47fuKA18h4IDrBDbf5bX/IJ+voKzM=
Date: Wed, 3 Apr 2024 07:11:04 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Tejun Heo <tj@kernel.org>, Sasha Levin <sashal@kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Hibernate stuck after recent kernel/workqueue.c changes in
 Stable 6.6.23
Message-ID: <2024040328-surfacing-breezy-34c6@gregkh>
References: <ce4c2f67-c298-48a0-87a3-f933d646c73b@leemhuis.info>
 <ZgylCe48FuOKNWtM@slm.duckdns.org>
 <b6cdb17f-206c-4dff-bb45-a60317e0a55e@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6cdb17f-206c-4dff-bb45-a60317e0a55e@leemhuis.info>

On Wed, Apr 03, 2024 at 06:26:24AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 03.04.24 02:38, Tejun Heo wrote:
> > On Tue, Apr 02, 2024 at 10:08:11AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> >> Hi stable team, there is a report that the recent backport of
> >> 5797b1c18919cd ("workqueue: Implement system-wide nr_active enforcement
> >> for unbound workqueues") [from Tejun] to 6.6.y (as 5a70baec2294) broke
> >> hibernate for a user. 6.6.24-rc1 did not fix this problem; reverting the
> >> culprit does.
> >>
> >>> With kernel 6.6.23 hibernating usually hangs here: the display stays
> >>> on but the mouse pointer does not move and the keyboard does not work.
> >>> But SysRq REISUB does reboot. Sometimes it seems to hibernate: the
> >>> computer powers down and can be waked up and the previous display comes
> >>> visible, but it is stuck there.
> >>
> >> See https://bugzilla.kernel.org/show_bug.cgi?id=218658 for details.
> >> Note, you have to use bugzilla to reach the reporter, as I sadly[1] can
> >> not CCed them in mails like this.
> >>
> >> Side note: there is a mainline report about problems due to
> >> 5797b1c18919cd ("workqueue: Implement system-wide nr_active enforcement
> >> for unbound workqueues") as well, but it's about "nohz_full=0 prevents
> >> kernel from booting":
> >> https://bugzilla.kernel.org/show_bug.cgi?id=218665; will forward that
> >> separately to Tejun.
> > 
> > Sorry about late reply
> 
> No problem at all, really, thx for your reply!
> 
> > but that commit is not for -stable. It does fix an
> > undesirable behavior from an earlier commit, so it has the Fixes tag but it
> > has a series of dependencies that need to be backported together
> 
> Not sure if you know, but the stable team apparently recently backported a
> bunch of other workqueue commits as well; I see 10 from a quick look here:
> https://lore.kernel.org/all/20240326223803.2647796-1-sashal@kernel.org/
> 
> $ git log --grep='workqueue:' --oneline v6.6.22..stable/linux-6.6.y -- include/linux/workqueue.h kernel/workqueue*
> 7df62b8cca38aa workqueue: Don't call cpumask_test_cpu() with -1 CPU in wq_update_node_max_active()
> 5a70baec2294e8 workqueue: Implement system-wide nr_active enforcement for unbound workqueues
> b522229a56941a workqueue: Introduce struct wq_node_nr_active
> bd31fb926dfa02 workqueue: RCU protect wq->dfl_pwq and implement accessors for it
> 5f99fee6f2dea1 workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
> 4023a2d9507691 workqueue: Move nr_active handling into helpers
> 6c592f0bb96815 workqueue: Replace pwq_activate_inactive_work() with [__]pwq_activate_work()
> bad184d26a4f68 workqueue: Factor out pwq_is_empty()
> 82e098f5bed1ff workqueue: Move pwq->max_active to wq->max_active
> 43a181f8f41aca workqueue.c: Increase workqueue name length
> 
> And there is also "workqueue: Shorten events_freezable_power_efficient name"
> in the queue for the next 6.6.y release:
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git/tree/queue-6.6
> 
> That leads to the question: what is the better patch forward here: pick
> up what's is missing or back out?
> 
> Side note: I have no idea why the stable team backported those patches
> and no option on whether that was wise, just trying to help finding the best
> solution forward from the current state of things.

The Fixes: tag triggered it, that's why they were backported.

> > which would
> > be far too invasive for -stable, thus no Cc: stable.
> >
> > I didn't know a Fixes
> > tag automatically triggers backport to -stable. I will keep that in mind for
> > future.
> 
> /me fears that more and more developers due to situations like this will
> avoid Fixes: tags and wonders what consequences that might have for the
> kernel as a whole

The problem is that we have subsystems that only use Fixes: and not cc:
stable which is why we need to pick these up as well.  Fixes: is great,
but if everyone were to do this "properly" then we wouldn't need to pick
these other ones up, but instead, it's about 1/3 of our volume :(

I'll gladly revert the above series if they shouldn't have been
backported to stable, but from reading them, it seemed like they were
fixing an issue that was serious and should have been added to stable,
which is why they were.

This is also why we have review cycles, so maintainers can let us know
if they want us to drop them :)

thanks,

greg k-h

