Return-Path: <linux-kernel+bounces-110399-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34F5D885EBA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:54:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9888E1F213CD
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82DF81332A7;
	Thu, 21 Mar 2024 16:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mQYwfrRK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E91112B7E;
	Thu, 21 Mar 2024 16:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711039258; cv=none; b=L3XaVyLriFyUeE3dFEiTy4BRR73zwSZje6WCqamQtsfOkoekwzJowyEtoIPFwK1fixEWgrh/+K4qHW3Lk+qaGjpwUzZPV+b50M1ikxZwLJnOfTP8y4/6tVoSzZnGaEIVF4fH2Qqf2drr63M+YcxqUgf4k6HIinG2bFuoFNXmtGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711039258; c=relaxed/simple;
	bh=Rg3Qyg/aCiHbBDT5o4Egzs5J5LChZshjXRXkzKdFYoY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MPg85tYRU76/lmcUA5eqeJon8IwRua5/ew6Rf6xUBTfrH8ljD8OpK74dCMwFirlnFf6H18l1Q3VBWPH1Tcjw5D19FnuLlI1yndth8H+d3anDet5TNBDbx37EguHkzFI43u/do+v5BMAYBRgK2JfLHT0mPFSxHUdRnfN37aIvTd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mQYwfrRK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F2E6C433C7;
	Thu, 21 Mar 2024 16:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711039258;
	bh=Rg3Qyg/aCiHbBDT5o4Egzs5J5LChZshjXRXkzKdFYoY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=mQYwfrRKlmBpZtRh1sVLmwtfHGxXtsJlqNmo7dVaTfOapv2REcGyrzPgytUQaNsI1
	 cPcLN3qiahtFIPWyKZ9T0fAXrFHKwVQBW34wxyRIZ+hWmtkfcx16FKQdwwcBPgl5XE
	 2plqgCGYA+6yi+IWm9viO2oONOtI1aevMJiH9zsCSJwaztgUoMSmAzrloaPWlHyRTG
	 t2mvRCCC5ujTAaLOxyYLvyIqrgvJogGFKxW2a8frOJwoaHeD4Ge0G/UPjzE/2tH/z4
	 w1GL3bt+o9ASG47/cPbHsBesEatxUqiOdqij4KhEp2AIHI/lE+jKwOWiQqeuZAjYFE
	 tzRX8goZyCciQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rnLTV-0000000082A-2Ev6;
	Thu, 21 Mar 2024 17:41:06 +0100
Date: Thu, 21 Mar 2024 17:41:05 +0100
From: Johan Hovold <johan@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Sean Paul <sean@poorly.run>,
	Marijn Suijten <marijn.suijten@somainline.org>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Kuogee Hsieh <quic_khsieh@quicinc.com>,
	dri-devel@lists.freedesktop.org, swboyd@chromium.org,
	quic_jesszhan@quicinc.com, quic_parellan@quicinc.com,
	quic_bjorande@quicinc.com, Rob Clark <robdclark@chromium.org>,
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/msm/dp: move link_ready out of HPD event thread
Message-ID: <ZfxjISnPhplKDDxc@hovoldconsulting.com>
References: <ZfApxyVAJMK4bL8O@hovoldconsulting.com>
 <ZfCFsmNv62-KMkA6@hovoldconsulting.com>
 <ZfCKDGq9n9WG3Quj@hovoldconsulting.com>
 <8e125a99-543d-8328-a2a9-100e223e4faf@quicinc.com>
 <ZfFhXG5yd6O29spS@hovoldconsulting.com>
 <ec2cba17-5644-6cf6-f6c9-d37d7ca56204@quicinc.com>
 <ZfMaEIzv3Z3ny3y0@hovoldconsulting.com>
 <9313aa00-41f0-15af-a646-3f4e4b3098c7@quicinc.com>
 <ZfRv5le7Bfdiwrk_@hovoldconsulting.com>
 <a1152afe-b652-d83e-05e4-25c07292b568@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a1152afe-b652-d83e-05e4-25c07292b568@quicinc.com>

On Mon, Mar 18, 2024 at 11:01:25AM -0700, Abhinav Kumar wrote:
> On 3/15/2024 8:57 AM, Johan Hovold wrote:
> > On Thu, Mar 14, 2024 at 09:30:57AM -0700, Abhinav Kumar wrote:

> >> The race condition is between the time we get disconnect event and set
> >> link_ready to false, a commit can come in. Because setting link_ready to
> >> false happens in the event thread so it could be slightly delayed.
> > 
> > I get this part, just not why, or rather when, that becomes a problem.
> > 
> > Once the disconnect event is processed, dp_hpd_unplug_handle() will
> > update the state to ST_DISCONNECT_PENDING, and queue a notification
> > event. link_ready is (before this patch) still set to 1.

> This is the case I am thinking of:
> 
> 1) Disconnect event happens which will call dp_hpd_unplug_handle() but 
> link_ready is not false yet.
> 
> 2) There is a commit with a modeset, which shall trigger 
> atomic_disable() followed by an atomic_enable()
> 
> atomic_disable() will go through disable clocks and set hpd_state to 
> ST_DISCONNECTED.
> 
> 3) atomic_enable() will not go through because we will bail out because 
> state was ST_DISCONNECTED.
> 
>          if (state != ST_DISPLAY_OFF && state != ST_MAINLINK_READY) {
>                  mutex_unlock(&dp_display->event_mutex);
>                  return;
>          }
> 
> 4) Now, if there is another commit with a modeset, it will go and crash 
> at atomic_disable()

Right, that's what I described in the mail you replied to but that still
doesn't answer what triggers those mode sets.
 
> > Here a commit comes in; what exactly are you suggesting would trigger
> > that? And in such a way that it breaks the state machine?

> Like we have seen, the commit can either come directly from userspace as 
> one last frame (the original bug I had given the link to) or from the 
> __drm_fb_helper_restore_fbdev_mode_unlocked() which happened in 
> sc8280xp's case. This is totally independent of the hpd_thread() with no 
> mutual exclusion.

Right . Still not sure about the details about "that last frame" issue,
that you saw in the past, and if that's still an issue or not. You
claimed that you had fixed that, right?

> This commit() can come before the link_ready was set to false. If it had 
> come after link_ready was set to false, atomic_check() would have failed 
> and no issue would have been seen.
> 
> My change is making the link_ready false sooner in the disconnect case.

Yes, but again, and as you have confirmed, you're only papering over the
issue at such a mode set can still come in before you set link_state to
false.
 
> > One way this could cause trouble is if you end up with a call to
> > dp_bridge_atomic_post_disable() which updates the state to
> > ST_DISCONNECTED. (1)
> > 
> > This would then need to be followed by another call to
> > dp_bridge_atomic_enable() which bails out early with the link clock
> > disabled. (2) (And if link_ready were to be set to 0 sooner, the
> > likelihood of this is reduced.)
> > 
> > This in turn, would trigger a reset when dp_bridge_atomic_disable() is
> > later called.

> Yes, this is exactly what I have written above.

Thanks for confirming.

> > This is the kind of description of the race I expect to see in the
> > commit message, and I'm still not sure what would trigger the call to
> > dp_bridge_atomic_post_disable() and dp_bridge_atomic_enable() (i.e. (1)
> > and (2) above) and whether this is a real issue or not.
> 
> I have explained what triggers the disable/enable call below.
> 
> > Also note that the above scenario is quite different from the one I've
> > hit and described earlier.

> Why is that so? Eventually it will also translate to the same scenario. 
> I would like to understand why this is different. I think in your case, 
> probably we do not know what triggers the modeset, but its a minor 
> detail like I have written before.

The state transitions are different and the enable event comes in
before the bridge has been fully tore down unlike in the scenario we
outlined above.

And it's certainly not a minor detail, as in the sc8280xp VT case,
those spurious hotplug events that trigger the atomic_enable would not
have caused any trouble if it wasn't for the case that the bridge was
stuck in the ST_MAINLINK_READY state.

That explains why the hotplug notification revert in rc7 made a
difference on sc8280xp. 

You're talking about an entirely different and, as far as I can tell,
hypothetical scenario where are user executes a modeset while pulling
the plug. This is certainly not why we had a number of user suddenly
starting to hit this crash after they upgraded to 6.8-rc1.

And, just to be clear, we know what triggers the modeset in the VT case,
and I posted a detailed explanation with a strack trace here:

	https://lore.kernel.org/lkml/Ze8Ke_M2xHyPYCu-@hovoldconsulting.com/

> >> It will be hard to reproduce this. Only way I can think of is to delay
> >> the EV_NOTIFICATION for sometime and see in dp_bridge_hpd_notify()
> >>
> >>           else if (dp_display->link_ready && status ==
> >> connector_status_disconnected)
> >>                   dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> >>
> >> as dp_add_event() will add the event, then wakeup the event_q.
> > 
> > Sure that would increase the race window with the current code, but that
> > alone isn't enough to trigger the bug AFAICT.
> > 
> >> Before the event thread wakes up and processes this unplug event, the
> >> commit can come in. This is the race condition i was thinking of.
> > 
> > Yes, but what triggers the commit? And why would it lead to a mode set
> > that disables the bridge?

> Commit was triggered from the userspace as it did not process the 
> disconnect event on time and the userspace was triggering a couple of 
> modesets by by changing the mode on the CRTC from 1080P to NONE to 1080P.
> 
> [drm:drm_atomic_helper_check_modeset] [CRTC:60:crtc-1] mode changed

But *why* would user space do that? Pushing out another frame would
generally not trigger a modeset, right?

And as I've alluded to repeatedly, your patch only seems concerned with
something like the above, where a hypothetical user space is triggering
modesets after receiving a notification.

And we know that that is not relevant for the crashes I've seen as there
is no user space processing any events in my VT or X setup.

Johan

