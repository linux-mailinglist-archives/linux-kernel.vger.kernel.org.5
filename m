Return-Path: <linux-kernel+bounces-100093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A8248791B3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 11:09:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E386281AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 10:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A708A78660;
	Tue, 12 Mar 2024 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bwpDKae3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BB33D3A7;
	Tue, 12 Mar 2024 10:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710238146; cv=none; b=BeZYDQSkxeRT446SvfmiZkhnpKCuAr4+xjpuakJHZFoMU4FuY1Yr9dp/0Rx8tITYG2Cgi5Anb7QTnUnLwgdcwurqg2KQK1Keo/5GwudOj0ZhYAxake7L16E4PN09zpeXls5idgex16ZsHsc7NpbDSUFW+xRpAC02Ugm0uDK6IAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710238146; c=relaxed/simple;
	bh=AbfRb7Kg3IljFjwdymBcsCC9K7rYKzeKaZKP5Wl6L6w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FBI3FKk1+F+oP6FZskuQFUga1UDvuV6rRAhtqXYw6j63vGp2TiSlyBQ+QUX0py/Xf/d6kzIsgxnAER6IrhrLMPIjDh0M2TBcX1pJ8XPK18D0F5T5BLLrI6ad1Ieech3FagFI0r+Nb2vHFB4skoM6566n/Tbyht4XPNnjV7eN6ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bwpDKae3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EAFEC433F1;
	Tue, 12 Mar 2024 10:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710238145;
	bh=AbfRb7Kg3IljFjwdymBcsCC9K7rYKzeKaZKP5Wl6L6w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bwpDKae3eYTmJz4L6IDtofbiuUok6opahnBlZq94FCd30Y3GIjgNw5ETcXZQ0R+cL
	 HaVf2wBHGruoBOsRZVGRviZ1ELu8yX06EEA21vuhSVigxG4hDCAzW7P8DOFxHhWJKd
	 z8bcmOa/UpsQNkrTnjbroOkwelh2nknMidzWfeDIW/o23UvQW4xWEg2fhyxzpgGpLW
	 9QBWdpPN5bn7kaDc2jQpgX+8oGSdx+NOgY1SAmr/VYd1fHJb/Uti/hOAfVDbNppxkX
	 4ef4Nrwf20XwYhy7qlq0EX2CV1Yf6hq0v+Z06RdToUb3X/WzEfa2H4GZZE/BG6NWRH
	 px3uHIF7tsqkw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rjz4J-000000007YQ-0ATZ;
	Tue, 12 Mar 2024 11:09:11 +0100
Date: Tue, 12 Mar 2024 11:09:11 +0100
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
Message-ID: <ZfApxyVAJMK4bL8O@hovoldconsulting.com>
References: <20240308214532.1404038-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308214532.1404038-1-quic_abhinavk@quicinc.com>

On Fri, Mar 08, 2024 at 01:45:32PM -0800, Abhinav Kumar wrote:
> There are cases where the userspace might still send another
> frame after the HPD disconnect causing a modeset cycle after
> a disconnect. This messes the internal state machine of MSM DP driver
> and can lead to a crash as there can be an imbalance between
> bridge_disable() and bridge_enable().

Can you be more specific here? What steps would lead to this issue and
how exactly does is mess with the state machine? Is there an easy way
to reproduce it (e.g. by instrumenting the code with some sleep)?

The hotplug code is really convoluted and having a clear description of
the problem is needed to evaluate the patch (including when revisiting
it some time from now when I've forgotten about how this state machine
works).

As you know, we ran into a related issue on sc8280xp (X13s) since
6.8-rc1, but that did not involve any user space interaction at all.

For reference, there are some more details in this thread:

	https://lore.kernel.org/all/Ze8Ke_M2xHyPYCu-@hovoldconsulting.com/
 
> This was also previously reported on [1] for which [2] was posted
> and helped resolve the issue by rejecting commits if the DP is not
> in connected state.
> 
> The change resolved the bug but there can also be another race condition.
> If hpd_event_thread does not pick up the EV_USER_NOTIFICATION and process it
> link_ready will also not be set to false allowing the frame to sneak in.

How could the event thread fail to pick up the notification event? Or do
you mean there's a race window before it has been processed?

> Lets move setting link_ready outside of hpd_event_thread() processing to
> eliminate a window of race condition.

As we discussed in thread above, this patch does not eliminate the race,
even if it may reduce the race window.
 
> [1] : https://gitlab.freedesktop.org/drm/msm/-/issues/17
> [2] : https://lore.kernel.org/all/1664408211-25314-1-git-send-email-quic_khsieh@quicinc.com/
> 
> Fixes: 8a3b4c17f863 ("drm/msm/dp: employ bridge mechanism for display enable and disable")
> Signed-off-by: Abhinav Kumar <quic_abhinavk@quicinc.com>

> @@ -466,6 +466,8 @@ static int dp_display_notify_disconnect(struct device *dev)
>  {
>  	struct dp_display_private *dp = dev_get_dp_display_private(dev);
>  
> +	dp->dp_display.link_ready = false;

As I also pointed out in the other thread, setting link_ready to false
here means that any spurious connect event (during physical disconnect)
will always be processed, something which can currently lead to a leaked
runtime pm reference.

Wasting some power is of course preferred over crashing the machine, but
please take it into consideration anyway.

Especially if your intention with this patch was to address the resets
we saw with sc8280xp which are gone since the HPD notify revert (which
fixed the hotplug detect issue that left the bridge in a
half-initialised state).

> +
>  	dp_add_event(dp, EV_USER_NOTIFICATION, false, 0);
>  
>  	return 0;

Johan

