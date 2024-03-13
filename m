Return-Path: <linux-kernel+bounces-101211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3924187A40A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:18:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5496EB21720
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:18:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C469199D9;
	Wed, 13 Mar 2024 08:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kfvaO2p/"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793651946B;
	Wed, 13 Mar 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317910; cv=none; b=ibMbPwqk4Rjh75H+MNil4HeLMdZz+EstgaEqFyEJGa9BLVxF1jbPkcjXs5FeoCrSI9dqegTaA03QYedIRkP7J8NGofdYCLkHUnXW0WmD/NoVjj2KSrVZv6PC9sas2+LjZM8QC1AxwDHUf7jV/6g1bxsW8QnbUNrjnEc+X7Ak7yI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317910; c=relaxed/simple;
	bh=zE7IZcvHdDf3t51MnDNR20hcSgbHGaXRCq5k//ri3Dk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=p/CpqescJNZVMXdiez7FtqYIv07ZEoxEL/7ANPvnp0ZM6PP8aX1W1n57RiZ93TiVeIVcgkDnlca3jldVkjC8+TMuWfrWTz6TJW8/Nf3GgXVjDKt2eEEDeaksfly/i13CSrSFHZt1+dW9ykhBNvwFkwXwO1TUXdtTDwVG7ruSJRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kfvaO2p/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1C0C433F1;
	Wed, 13 Mar 2024 08:18:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710317910;
	bh=zE7IZcvHdDf3t51MnDNR20hcSgbHGaXRCq5k//ri3Dk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kfvaO2p/xA/6WQYMqWpUtHkwzvcv435FG1luuy0SdnIxrdLGbVbBn1xJkO86ckMdk
	 ngqqHAzFfuK1K98SoFG4lRGOm45/HcSs58eq0NmXtEYaudEvOsjWBS7nZFaGjx9tEr
	 4PBWv7NK1l8Q1718PUvdFR+0O9Jq9OrCuVvOArDJLbdEnRCX+uurBgu2Gh/x39ijev
	 O9sjQebpCmyWLZBYdR2hCo4NwZ35Aboml0wzmJBlJ6yVxyEdyrnHGK9GWaIEAmwAWW
	 tNXeLWq6Y662cuLDXmsz7LfduvXoz7JAbchyI1mW7Pk6xFHCYYxU6c+YXW0XanwQ4q
	 H/ax0Le7rdWPg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rkJoq-000000007Vb-2jag;
	Wed, 13 Mar 2024 09:18:36 +0100
Date: Wed, 13 Mar 2024 09:18:36 +0100
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
Message-ID: <ZfFhXG5yd6O29spS@hovoldconsulting.com>
References: <20240308214532.1404038-1-quic_abhinavk@quicinc.com>
 <ZfApxyVAJMK4bL8O@hovoldconsulting.com>
 <ZfCFsmNv62-KMkA6@hovoldconsulting.com>
 <ZfCKDGq9n9WG3Quj@hovoldconsulting.com>
 <8e125a99-543d-8328-a2a9-100e223e4faf@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e125a99-543d-8328-a2a9-100e223e4faf@quicinc.com>

On Tue, Mar 12, 2024 at 10:39:46AM -0700, Abhinav Kumar wrote:
> On 3/12/2024 9:59 AM, Johan Hovold wrote:

> >> Heh. This is getting ridiculous. I just tried running with this patch
> >> and it again breaks hotplug detect in a VT console and in X (where I
> >> could enable a reconnected external display by running xrandr twice
> >> before).
> >>
> >> So, please, do not apply this one.
> > 
> > To make things worse, I indeed also hit the reset when disconnecting
> > after such a failed hotplug.

> Ack, I will hold off till I analyze your issues more which you have 
> listed in separate replies. Especially about the spurious connect, I 
> believe you are trying to mention that, by adding logs, you are able to 
> delay the processing of a connect event to *make* it like a spurious 
> one? In case, I got this part wrong, can you pls explain the spurious 
> connect scenario again?

No, I only mentioned the debug printks in passing as instrumentation
like that may affect race conditions (but I'm also hitting the resets
also with no printks in place).

The spurious connect event comes directly from the pmic firmware, and
even if we may optimise things by implementing some kind of debounce,
the hotplug implementation needs to be robust enough to not kill the
machine if such an event gets through.

Basically what I see is that during physical disconnect there can be
multiple hpd notify events (e.g. connect, disconnect, connect):

[  146.910195] usb 5-1: USB disconnect, device number 4
[  146.931026] msm-dp-display ae98000.displayport-controller: dp_bridge_hpd_notify - link_ready = 1, status = 2
[  146.934785] msm-dp-display ae98000.displayport-controller: dp_hpd_unplug_handle
[  146.938114] msm-dp-display ae98000.displayport-controller: dp_bridge_hpd_notify - link_ready = 1, status = 1
[  146.940245] [CONNECTOR:35:DP-2] status updated from disconnected to connected
[  146.955193] msm-dp-display ae98000.displayport-controller: dp_bridge_hpd_notify - link_ready = 0, status = 2

And it is the spurious connect event while the link is being tore down
that triggers the hotplug processing that leads to the reset.

Similarly, I've seen spurious disconnect events while the plug in being
inserted.

> A short response on why this change was made is that commit can be 
> issued by userspace or the fbdev client. So userspace involvement only 
> makes commit happen from a different path. It would be incorrect to 
> assume the issues from the earlier bug and the current one are different 
> only because there was userspace involvement in that one and not this.
>
> Because in the end, it manifests itself in the same way that 
> atomic_enable() did not go through after an atomic_disable() and the 
> next atomic_disable() crashes.

Right, but your proposed fix would not actually fix anything and judging
from the sparse commit message and diff itself it is clearly only meant
to mitigate the case where user space is involved, which is *not* the
case here.

Johan

