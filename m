Return-Path: <linux-kernel+bounces-32758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FA4835FBD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BF552881C6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:32:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D430F3A1DA;
	Mon, 22 Jan 2024 10:32:02 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 840D73A1C2
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705919522; cv=none; b=q8gDKwtyKhhVh35K/WUgy0f1tXsEZuYmGKJ67KQNUJj4d80BwIPXSanz7cSFAeonjkWhu+g0wmVjgmUN1NKeAchZKPcb2ArAaJfJ5L+9p1HkIaW32RwxZ/WKxZUx7jnIKTDrhpDfUG670FYWVZt968upPOmNnk/l6gHdQ6pc+Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705919522; c=relaxed/simple;
	bh=KAlfgGQ/MAfkQYeGKUwMnf4LD+P82YLtjfk03BIrXi8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ftviCxNUPWnM5jIhzbNcsD1AU+gXODuwhy3gfdbBj7lIawDN05jiBvKStw5Fe4WWSNobas0q5bU7T6+tegiCzsjl3ijrhfNdPOCGkysWAL1np1oPyVQIGv98Xy0nkgkIW3vBqYTJxetdGGCVzrsg9T9Zxgn3GTj+3zjTrxwcyEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rRrah-0000aJ-TJ; Mon, 22 Jan 2024 11:31:43 +0100
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <sha@pengutronix.de>)
	id 1rRraf-001ZTQ-7T; Mon, 22 Jan 2024 11:31:41 +0100
Received: from sha by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
	(envelope-from <sha@pengutronix.de>)
	id 1rRraf-001BEt-4b; Mon, 22 Jan 2024 11:31:41 +0100
Date: Mon, 22 Jan 2024 11:31:41 +0100
From: Sascha Hauer <s.hauer@pengutronix.de>
To: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Cc: Sandy Huang <hjc@rock-chips.com>,
	Heiko =?iso-8859-15?Q?St=FCbner?= <heiko@sntech.de>,
	Andy Yan <andy.yan@rock-chips.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
	error27@gmail.com
Subject: Re: [PATCH] drm/rockchip: vop2: add a missing unlock in
 vop2_crtc_atomic_enable()
Message-ID: <20240122103141.GU4700@pengutronix.de>
References: <20240119190841.1619443-1-harshit.m.mogalapalli@oracle.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240119190841.1619443-1-harshit.m.mogalapalli@oracle.com>
X-Sent-From: Pengutronix Hildesheim
X-URL: http://www.pengutronix.de/
X-Accept-Language: de,en
X-Accept-Content-Type: text/plain
User-Agent: Mutt/1.10.1 (2018-07-13)
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: sha@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Fri, Jan 19, 2024 at 11:08:40AM -0800, Harshit Mogalapalli wrote:
> Unlock before returning on the error path.
> 
> Fixes: 5a028e8f062f ("drm/rockchip: vop2: Add support for rk3588")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>

Reviewed-by: Sascha Hauer <s.hauer@pengutronix.de>

Thanks for fixing this.

Sascha

> ---
> This is based on static analysis. Only compile tested.
> Note: Smatch found this.
> ---
>  drivers/gpu/drm/rockchip/rockchip_drm_vop2.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> index 85b3b4871a1d..fdd768bbd487 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> @@ -1985,8 +1985,10 @@ static void vop2_crtc_atomic_enable(struct drm_crtc *crtc,
>  		clock = vop2_set_intf_mux(vp, rkencoder->crtc_endpoint_id, polflags);
>  	}
>  
> -	if (!clock)
> +	if (!clock) {
> +		vop2_unlock(vop2);
>  		return;
> +	}
>  
>  	if (vcstate->output_mode == ROCKCHIP_OUT_MODE_AAAA &&
>  	    !(vp_data->feature & VOP2_VP_FEATURE_OUTPUT_10BIT))
> -- 
> 2.39.3
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

