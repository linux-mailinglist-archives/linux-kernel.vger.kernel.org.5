Return-Path: <linux-kernel+bounces-98898-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71D0D8780D2
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:43:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 950C71C2110C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:43:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF36A3FBAA;
	Mon, 11 Mar 2024 13:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GV/0NXmK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA363FB9A;
	Mon, 11 Mar 2024 13:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710164601; cv=none; b=KKwI0s6o8bFSKKd0gs9zGVSmNpMT1ncxikBfLiyPaiPpLspez6aPOSCfAlJc7AqYNw0a8y+9/q7+sqcJdQniDRgimnLllXVPlRbXr+CeWDErF8pDKDGmvLA2lpbsNZ2JVBSKuSf7TytqriAaiYNroIzDliUwshKjhHVU5Cb2Yw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710164601; c=relaxed/simple;
	bh=EQLrk4lEo8JQyIRC1uzMsMtwYo6qr93Gpah+oQB54Gc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NriHqes5Mc8KRzi2/lznbhj2vHiOEbGgTzFAsz1mFO/i55cr7AQV5jSeElpXfVBsgz8PuMXQT2BDuwayBKdMoPIJQHub0S44/jTz+vgqB7akq/KbosX71AZNyZkWkeDQccbJyUlAUk/rlAO5ghrRZVFdGoiy1x73HlvJhBJgozk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GV/0NXmK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260F3C433F1;
	Mon, 11 Mar 2024 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710164601;
	bh=EQLrk4lEo8JQyIRC1uzMsMtwYo6qr93Gpah+oQB54Gc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GV/0NXmKMKHV8YsKqvZ+lK8pIUdJzyxA2KrxaL3W1WqST9taiaQwzwIqO1omg1sZ5
	 PWMdbV67YUfyxv3wwKt0Rzj96o+Us3aiwDyeUFwTOYYODX/NPbV+Gzenj645QjZS0W
	 rpOYfjNrsi8LQfl+f1jz4k/MJ+ocGec1oe/RUdjrOcYffzOoJ0rUfkECBUFa9gXfQ0
	 HX0N+H6AvK5YsByEZX3pQWmBxzx7CPfDFXOjrJtCD3R9aTKNdmY3UAbO6wrPR686oi
	 UlLMIN2IM0JtuCB7El2on1+lK96Z7LcADOn0ss8uX+EFI/qHTl1WUCVq+JMxAbFflW
	 yGhh0+NIX74cQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rjfw3-000000004f7-2Bbs;
	Mon, 11 Mar 2024 14:43:24 +0100
Date: Mon, 11 Mar 2024 14:43:23 +0100
From: Johan Hovold <johan@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	Daniel Thompson <daniel.thompson@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Bjorn Andersson <quic_bjorande@quicinc.com>,
	quic_jesszhan@quicinc.com, quic_sbillaka@quicinc.com,
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
	linux-arm-msm@vger.kernel.org, regressions@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: drm/msm: DisplayPort hard-reset on hotplug regression in 6.8-rc1
Message-ID: <Ze8Ke_M2xHyPYCu-@hovoldconsulting.com>
References: <Zd3kvD02Qvsh2Sid@hovoldconsulting.com>
 <ZesH21DcfOldRD9g@hovoldconsulting.com>
 <56de6cfb-fe0f-de30-d4d0-03c0fbb0afbb@quicinc.com>
 <ZeyOmJLlBbwnmaJN@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZeyOmJLlBbwnmaJN@hovoldconsulting.com>

On Sat, Mar 09, 2024 at 05:30:17PM +0100, Johan Hovold wrote:
> On Fri, Mar 08, 2024 at 09:50:17AM -0800, Abhinav Kumar wrote:
> > On 3/8/2024 4:43 AM, Johan Hovold wrote:
> 
> > For this last remaining reset with the stacktrace you have mentioned 
> > below, I do not think this was introduced due to PM runtime series. We 
> > have had this report earlier with the same stacktrace as well in earlier 
> > kernels which didnt have PM runtime support:
> 
> > But, it seems like there is another race condition in this code 
> > resulting in this issue again.
> > 
> > I have posted my analysis with the patch here as a RFC y'day:
> > 
> > https://patchwork.freedesktop.org/patch/581758/
> > 
> > I missed CCing you and Bjorn on the RFC but when I post it as a patch 
> > either today/tomm, will CC you both.
> 
> Ok, thanks. I'll take a closer look at that next week. It's not clear to
> me what that race looks like after reading the commit message. It would
> be good to have some more details in there (e.g. the sequence of events
> that breaks the state machine) and some way to reproduce the issue
> reliably.

I was able to reproduce the reset with some of my debug printks in place
after reapplying the reverted hpd notify change so I have an explanation
for (one of) the ways we can up in this state now.

This does not match description of the problem in the fix linked to
above and I don't think that patch solves the underlying issue even if
it may make the race window somewhat smaller. More details below.
 
> > > We now also have Bjorn's call trace from a different Qualcomm platform
> > > triggering an unclocked access on disconnect, something which would
> > > trigger a reset by the hypervisor on sc8280xp platforms like the X13s:
> 
> > > [ 2030.379583] Kernel panic - not syncing: Asynchronous SError Interrupt
> > > [ 2030.379586] CPU: 0 PID: 239 Comm: kworker/0:2 Not tainted 6.8.0-rc4-next-20240216-00015-gc937d3c43ffe-dirty #219
> > > [ 2030.379590] Hardware name: Qualcomm Technologies, Inc. Robotics RB3gen2 (DT)
> > > [ 2030.379592] Workqueue: events output_poll_execute [drm_kms_helper]
> > > [ 2030.379642] Call trace:
> 
> > > [ 2030.379722]  wait_for_completion_timeout+0x14/0x20
> > > [ 2030.379727]  dp_ctrl_push_idle+0x34/0x8c [msm]
> > > [ 2030.379844]  dp_bridge_atomic_disable+0x18/0x24 [msm]
> > > [ 2030.379959]  drm_atomic_bridge_chain_disable+0x6c/0xb4 [drm]
> > > [ 2030.380150]  drm_atomic_helper_commit_modeset_disables+0x174/0x57c [drm_kms_helper]
> > > [ 2030.380200]  msm_atomic_commit_tail+0x1b4/0x474 [msm]
> > > [ 2030.380316]  commit_tail+0xa4/0x158 [drm_kms_helper]
> > > [ 2030.380369]  drm_atomic_helper_commit+0x24c/0x26c [drm_kms_helper]
> > > [ 2030.380418]  drm_atomic_commit+0xa8/0xd4 [drm]
> > > [ 2030.380529]  drm_client_modeset_commit_atomic+0x16c/0x244 [drm]
> > > [ 2030.380641]  drm_client_modeset_commit_locked+0x50/0x168 [drm]
> > > [ 2030.380753]  drm_client_modeset_commit+0x2c/0x54 [drm]
> > > [ 2030.380865]  __drm_fb_helper_restore_fbdev_mode_unlocked+0x60/0xa4 [drm_kms_helper]
> > > [ 2030.380915]  drm_fb_helper_hotplug_event+0xe0/0xf4 [drm_kms_helper]
> > > [ 2030.380965]  msm_fbdev_client_hotplug+0x28/0xc8 [msm]
> > > [ 2030.381081]  drm_client_dev_hotplug+0x94/0x118 [drm]
> > > [ 2030.381192]  output_poll_execute+0x214/0x26c [drm_kms_helper]
> > > [ 2030.381241]  process_scheduled_works+0x19c/0x2cc
> > > [ 2030.381249]  worker_thread+0x290/0x3cc
> > > [ 2030.381255]  kthread+0xfc/0x184
> > > [ 2030.381260]  ret_from_fork+0x10/0x20
> > > 
> > > The above could happen if the convoluted hotplug state machine breaks
> > > down so that the device is runtime suspended before
> > > dp_bridge_atomic_disable() is called.
> 
> > Yes, state machine got broken and I have explained how in the commit 
> > text of the RFC. But its not necessarily due to PM runtime but a 
> > sequence of events happening from userspace exposing this breakage.
> 
> After looking at this some more today, I agree with you. The
> observations I've reported are consistent with what would happen if the
> link clock is disabled when dp_bridge_atomic_disable() is called.
> 
> That clock is disabled in dp_bridge_atomic_post_disable() before runtime
> suspending, but perhaps there are some further paths that can end up
> disabling it.

Turns out there are paths like that and we hit those more often before
reverting e467e0bde881 ("drm/msm/dp: use drm_bridge_hpd_notify().

Specifically, when a previous connect attempt did not enable the bridge
fully so that it is still in the ST_MAINLINK_READY when we receive a
disconnect event, dp_hpd_unplug_handle() will turn of the link clock.

[  204.527625] msm-dp-display ae98000.displayport-controller: dp_bridge_hpd_notify - link_ready = 1, status = 2
[  204.531553] msm-dp-display ae98000.displayport-controller: dp_hpd_unplug_handle
[  204.533261] msm-dp-display ae98000.displayport-controller: dp_ctrl_off_link

A racing connect event, such as the one I described earlier, can then
try to enable the bridge again but dp_bridge_atomic_enable() just bails
out early (and leaks a rpm reference) because we're now in
ST_DISCONNECTED:

[  204.535773] msm-dp-display ae98000.displayport-controller: dp_bridge_hpd_notify - link_ready = 1, status = 1
[  204.536187] [CONNECTOR:35:DP-2] status updated from disconnected to connected
[  204.536905] msm-dp-display ae98000.displayport-controller: dp_display_notify_disconnect - would clear link ready (1), state = 0
[  204.537821] msm-dp-display ae98000.displayport-controller: dp_bridge_atomic_check - link_ready = 1
[  204.538063] msm-dp-display ae98000.displayport-controller: dp_display_send_hpd_notification - hpd = 0, link_ready = 1
[  204.542778] msm-dp-display ae98000.displayport-controller: dp_bridge_atomic_enable
[  204.586547] msm-dp-display ae98000.displayport-controller: dp_bridge_atomic_enable - state = 0 (rpm leak?)

Clearing link_ready already in dp_display_notify_disconnect() would make
the race window slightly smaller, but it would essentially just paper
over the bug as the events are still not serialised. Notably, there is
no user space interaction involved here and it's the spurious connect
event that triggers the bridge enable.

When the fbdev hotplug code later disables the never-enabled bridge,
things go boom:

[  204.649072] msm-dp-display ae98000.displayport-controller: dp_bridge_hpd_notify - link_ready = 0, status = 2
[  204.650378] [CONNECTOR:35:DP-2] status updated from connected to disconnected
[  204.651111] msm-dp-display ae98000.displayport-controller: dp_bridge_atomic_disable

as the link clock has already been disabled when accessing the link
registers.

The stack trace for the bridge enable above is:

[  204.553922]  dp_bridge_atomic_enable+0x40/0x2f0 [msm]
[  204.555241]  drm_atomic_bridge_chain_enable+0x54/0xc8 [drm]
[  204.556557]  drm_atomic_helper_commit_modeset_enables+0x194/0x26c [drm_kms_helper]
[  204.557853]  msm_atomic_commit_tail+0x204/0x804 [msm]
[  204.559173]  commit_tail+0xa4/0x18c [drm_kms_helper]
[  204.560450]  drm_atomic_helper_commit+0x19c/0x1b0 [drm_kms_helper]
[  204.561743]  drm_atomic_commit+0xa4/0xdc [drm]
[  204.563065]  drm_client_modeset_commit_atomic+0x22c/0x298 [drm]
[  204.564402]  drm_client_modeset_commit_locked+0x60/0x1c0 [drm]
[  204.565733]  drm_client_modeset_commit+0x30/0x58 [drm]
[  204.567055]  __drm_fb_helper_restore_fbdev_mode_unlocked+0xbc/0xfc [drm_kms_helper]
[  204.568381]  drm_fb_helper_hotplug_event.part.0+0xd4/0x110 [drm_kms_helper]
[  204.569708]  drm_fb_helper_hotplug_event+0x38/0x44 [drm_kms_helper]
[  204.571032]  msm_fbdev_client_hotplug+0x28/0xd4 [msm]
[  204.572395]  drm_client_dev_hotplug+0xcc/0x130 [drm]
[  204.573755]  drm_kms_helper_connector_hotplug_event+0x34/0x44 [drm_kms_helper]
[  204.575114]  drm_bridge_connector_hpd_cb+0x90/0xa4 [drm_kms_helper]
[  204.576465]  drm_bridge_hpd_notify+0x40/0x5c [drm]
[  204.577842]  drm_aux_hpd_bridge_notify+0x18/0x28 [aux_hpd_bridge]
[  204.579184]  pmic_glink_altmode_worker+0xc0/0x23c [pmic_glink_altmode]

> > > For some reason, possibly due to unrelated changes in timing, possibly
> > > after the hotplug revert, I am no longer able to reproduce the reset
> > > with 6.8-rc7 on the X13s.
> 
> > I do not know how the hotplug revert fixed this stack because I think 
> > this can still happen.

So, while it may still be theoretically possible to hit the resets after
the revert, the HPD notify revert effectively "fixed" the regression in
6.8-rc1 by removing the preconditions that now made us hit it (i.e. the
half-initialised bridge).

It seems the hotplug state machine needs to be reworked completely, but
at least we're roughly back where we were with 6.7 (including that the
bus clocks will never be turned of because of the rpm leaks on
disconnect).

Johan

