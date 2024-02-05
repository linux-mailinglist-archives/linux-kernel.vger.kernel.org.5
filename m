Return-Path: <linux-kernel+bounces-52185-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BEFEB849515
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:08:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48837B209B7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:08:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3755C11199;
	Mon,  5 Feb 2024 08:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="RifFOAdx"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DB9F11193
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707120507; cv=none; b=etjHacerxAL9csD1dbxmar+k5SwQFdTMXC1CiiTbiQmv1Wa7noCKoOb2A83Z8HyH2U0G5xKmkMuy5SFvfiw7ebGZB3EEurp20e3fEdTTXzQPQpwVtalh+jM1fLxAfwa9RXSwig9v3Ah2bD6R1gA0MjV5zTqrV5cJU+60njmB9P8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707120507; c=relaxed/simple;
	bh=RJo0jMGfwLG8I+tsPvz5m11NBRG+h8zzgj5Z6Oy0ums=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mme5Gpodnhe1spYSC2KkxPirn77KTTul8Holo4OO6wu1bgUO0xLHa0maJ1kL44H5QE3hGEb30bGN2tSe5Z1wXPuoJZ3QJt9s3Ft8buBMpzC0eRdH0zFZjAPZPuPjhcat2LzboV4ZJaZj+KmO1/Na00Sqf6VATiK0ah2WSPKU5B0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=RifFOAdx; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (99.141-128-109.adsl-dyn.isp.belgacom.be [109.128.141.99])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2835A667;
	Mon,  5 Feb 2024 09:07:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707120421;
	bh=RJo0jMGfwLG8I+tsPvz5m11NBRG+h8zzgj5Z6Oy0ums=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RifFOAdxtCkdaa1VnsMD2TKrpOXLsevtEoZrISrDE8BOLghB4ZQw67j6xdSDDR8tl
	 e2v2utQyFZh5cuAnWxOg8A2OW9Z/OAkyPy87HEEsEnVDSjvM8cTqpm9cv6d2PjUJGW
	 msEUCKaAZQdVYF4vKyhVXTNMlaM/GD7HLK+drWvg=
Date: Mon, 5 Feb 2024 10:08:24 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Anatoliy Klymenko <anatoliy.klymenko@amd.com>
Cc: maarten.lankhorst@linux.intel.com, mripard@kernel.org,
	tzimmermann@suse.de, airlied@gmail.com, daniel@ffwll.ch,
	michal.simek@amd.com, dri-devel@lists.freedesktop.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/5] drm: xlnx: zynqmp_dpsub: Fix timing for live mode
Message-ID: <20240205080824.GH6804@pendragon.ideasonboard.com>
References: <20240124025402.373620-1-anatoliy.klymenko@amd.com>
 <20240124025402.373620-3-anatoliy.klymenko@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240124025402.373620-3-anatoliy.klymenko@amd.com>

Hi Anatoliy,

Thank you for the patch.

On Tue, Jan 23, 2024 at 06:53:59PM -0800, Anatoliy Klymenko wrote:
> Expect external video timing in live video input mode, program
> DPSUB acordingly.

Are there no designs where the DPSUB operates in non-live mode, but uses
a video clock from the PL, for instance to use a different clock
frequency ?

I don't think that use case is very common, so I'm fine with this patch
in order to properly support the more common use case of live input, and
leave the PL clock without live input use case for later.

> 
> Reviewed-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 

No need for a blank line here.

> Signed-off-by: Anatoliy Klymenko <anatoliy.klymenko@amd.com>

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

> ---
>  drivers/gpu/drm/xlnx/zynqmp_disp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/gpu/drm/xlnx/zynqmp_disp.c b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> index 407bc07cec69..8a39b3accce5 100644
> --- a/drivers/gpu/drm/xlnx/zynqmp_disp.c
> +++ b/drivers/gpu/drm/xlnx/zynqmp_disp.c
> @@ -1166,7 +1166,7 @@ void zynqmp_disp_enable(struct zynqmp_disp *disp)
>  	/* Choose clock source based on the DT clock handle. */
>  	zynqmp_disp_avbuf_set_clocks_sources(disp, disp->dpsub->vid_clk_from_ps,
>  					     disp->dpsub->aud_clk_from_ps,
> -					     true);
> +					     disp->dpsub->vid_clk_from_ps);
>  	zynqmp_disp_avbuf_enable_channels(disp);
>  	zynqmp_disp_avbuf_enable_audio(disp);
>  

-- 
Regards,

Laurent Pinchart

