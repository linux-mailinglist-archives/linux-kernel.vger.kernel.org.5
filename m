Return-Path: <linux-kernel+bounces-134611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 298E189B39B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 20:48:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D9A611F21BD5
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 18:48:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B526B3D0BD;
	Sun,  7 Apr 2024 18:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Pyl6UNvI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9E2B3BBFE;
	Sun,  7 Apr 2024 18:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712515718; cv=none; b=gofvjAdxHOqLqNj+0w1gG3jGPGjnDDDLrOS1enDyC7uFW+vSAVL44rMabG6Q2iydarqd0M1AH2Qdl6mcEPKJ9M20nALCAA74sNvoN37tXbB4tcdF5gvtCyxBISyckFkGTqzBfOHt573aQ3JGVlPrzQ7OMiKsRKSGRF5pZ4soVBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712515718; c=relaxed/simple;
	bh=YGFL1rkFv9aHtvgb46NeWxJpN7qYol8+cNvtNhFDkCk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AGyQErEzweMi/1AP5fNz9gF6jAeVroUd3W++ava0sfnPzxveWIsJ5yKC4JA0mQJ2I1gqBVgURNEVcAActrfcgpZQHTxhhshbmjEOuza2/FLFaXimMqH8czi1HgWdwkUsVwR6/7snB2t8zqdipbJuLM2pMlXScMcYyVHBBVP9fLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Pyl6UNvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E9CCC433C7;
	Sun,  7 Apr 2024 18:48:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712515717;
	bh=YGFL1rkFv9aHtvgb46NeWxJpN7qYol8+cNvtNhFDkCk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Pyl6UNvIbYI3c4IpK/hoKJTP/kgWHmMsvZ1wbHIcTFpvfe6hQNnVhV4PCE4mh14W1
	 YebkZ3hZy4p7pIFeRykLxhZ3wYBVEv1OaFf+Jb8fmfmz6ItLA/WBTJ/RXPDrZYiO8U
	 UdKWyXxVqBwO2N9t65LfWwJFZc82BoklTIb0/ZCD6SVztRkuSLBtIGZzXRKisPeoq9
	 wVOh4Bx8iUnXk27FE0DwVLBBw4Txb0bRlxFuadNJhX43ppfumwtWATCxEzmL+Mw8Kt
	 7wLrrPBVCSofKJhXXSpqYTUaZ2Ut3c8vTHOiLWabRZZJlhd8BVNzb6Qrq2GpvQFKit
	 aJW8RejIGGZnA==
Date: Sun, 7 Apr 2024 13:48:34 -0500
From: Bjorn Andersson <andersson@kernel.org>
To: Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc: freedreno@lists.freedesktop.org, Rob Clark <robdclark@gmail.com>, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Sean Paul <sean@poorly.run>, 
	Marijn Suijten <marijn.suijten@somainline.org>, David Airlie <airlied@gmail.com>, 
	Daniel Vetter <daniel@ffwll.ch>, Kuogee Hsieh <quic_khsieh@quicinc.com>, 
	dri-devel@lists.freedesktop.org, seanpaul@chromium.org, swboyd@chromium.org, 
	quic_jesszhan@quicinc.com, quic_bjorande@quicinc.com, johan@kernel.org, 
	linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] drm/msm/dp: call dp_hpd_plug_handle()/unplug_handle()
 directly for external HPD
Message-ID: <ale6wbwzkfagcg2q6glb4vsxu3pthhkk3tquv2ixlatbdryqvh@xscsq2h6emho>
References: <20240406031548.25829-1-quic_abhinavk@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240406031548.25829-1-quic_abhinavk@quicinc.com>

On Fri, Apr 05, 2024 at 08:15:47PM -0700, Abhinav Kumar wrote:
> From: Kuogee Hsieh <quic_khsieh@quicinc.com>
[..]
> diff --git a/drivers/gpu/drm/msm/dp/dp_display.c b/drivers/gpu/drm/msm/dp/dp_display.c
> index d80f89581760..bfb6dfff27e8 100644
> --- a/drivers/gpu/drm/msm/dp/dp_display.c
> +++ b/drivers/gpu/drm/msm/dp/dp_display.c
> @@ -1665,7 +1665,7 @@ void dp_bridge_hpd_notify(struct drm_bridge *bridge,
>  		return;
>  
>  	if (!dp_display->link_ready && status == connector_status_connected)
> -		dp_add_event(dp, EV_HPD_PLUG_INT, 0, 0);
> +		dp_hpd_plug_handle(dp, 0);

If I read the code correctly, and we get an external connect event
inbetween a previous disconnect and the related disable call, this
should result in a PLUG_INT being injected into the queue still.

Will that not cause the same problem?

Regards,
Bjorn

>  	else if (dp_display->link_ready && status == connector_status_disconnected)
> -		dp_add_event(dp, EV_HPD_UNPLUG_INT, 0, 0);
> +		dp_hpd_unplug_handle(dp, 0);
>  }
> -- 
> 2.43.2
> 

