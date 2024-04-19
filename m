Return-Path: <linux-kernel+bounces-151277-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B79458AAC54
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C767281046
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13B467C6CC;
	Fri, 19 Apr 2024 10:01:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R8MS3ldv"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32E26FE14;
	Fri, 19 Apr 2024 10:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713520896; cv=none; b=qt3Vw+sm9XRCdpiYYNUD0iqzV5kkZPVmrdWpPq5BZLyjs3FmG01jZYWSR3XrpmJd0X+yUattXePuyd1nCv6kceWVUfOefE9YB9rpJ1dQBMDL1+4+h7VzLVkjwdTPlcQ/AuPK5yug28WkVPRs77dw6p5xT8kIcxExIU3pp+3dXgs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713520896; c=relaxed/simple;
	bh=dOufSjti/zcqrIC1+5xROb4jVk+JZABAKL12SGSR8/I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XdNYfUD1Xok5/e40pRcVVK5vYmYuhaahCcriXVUGjsKIZrtaTCLhGLVH2p7MYxV026O7Od7SanT6fRlYFOhaZLvGpIysqw/LCyVg91kjbHD5zCSWcoAJra5Oq1x5KLosH95zZgaQMxTsvcDTR0f0/JQ8nXv9nhMzH/AnmYJtJdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=R8MS3ldv; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (117.145-247-81.adsl-dyn.isp.belgacom.be [81.247.145.117])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6F2B055;
	Fri, 19 Apr 2024 12:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1713520839;
	bh=dOufSjti/zcqrIC1+5xROb4jVk+JZABAKL12SGSR8/I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=R8MS3ldviIQXqJd9xpEpHHvSrvRRFcOnfMUpiE+kvSfCEdBJjsbJ+0WwGKBsNTIPD
	 yHBwYhY2QT7UJ0vHPIGJ19q1hvoD3NWJwTJ/7QWwttURogS/dv6CvU3LJoyUqNM9b3
	 sLl3jbZeIZUFWVCXP6kQHfRO7EtwYCF7hCj0JBM8=
Date: Fri, 19 Apr 2024 13:01:19 +0300
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hugues Fruchet <hugues.fruchet@foss.st.com>,
	Alain Volmat <alain.volmat@foss.st.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	Sowjanya Komatineni <skomatineni@nvidia.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Hans Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>,
	Abylay Ospan <aospan@netup.ru>,
	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
	Dmitry Osipenko <digetx@gmail.com>,
	Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
	Sylvain Petinot <sylvain.petinot@foss.st.com>,
	Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
	Vikash Garodia <quic_vgarodia@quicinc.com>,
	Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
	linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
	linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
	Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: Re: [PATCH v2 03/26] media: uvcvideo: Refactor iterators
Message-ID: <20240419100119.GC12651@pendragon.ideasonboard.com>
References: <20240419-fix-cocci-v2-0-2119e692309c@chromium.org>
 <20240419-fix-cocci-v2-3-2119e692309c@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240419-fix-cocci-v2-3-2119e692309c@chromium.org>

Hi Ricardo,

On Fri, Apr 19, 2024 at 09:47:49AM +0000, Ricardo Ribalda wrote:
> Avoid using the iterators after the list_for_each() constructs.
> This patch should be a NOP, but makes cocci, happier:
> 
> drivers/media/usb/uvc/uvc_ctrl.c:1861:44-50: ERROR: invalid reference to the index variable of the iterator on line 1850
> drivers/media/usb/uvc/uvc_ctrl.c:2195:17-23: ERROR: invalid reference to the index variable of the iterator on line 2179
> 
> Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index e59a463c2761..a4a987913430 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1850,16 +1850,18 @@ int __uvc_ctrl_commit(struct uvc_fh *handle, int rollback,
>  	list_for_each_entry(entity, &chain->entities, chain) {

What happened to
https://lore.kernel.org/all/20220301075839.4156-1-xiam0nd.tong@gmail.com/
? :'-(

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

>  		ret = uvc_ctrl_commit_entity(chain->dev, entity, rollback,
>  					     &err_ctrl);
> -		if (ret < 0)
> +		if (ret < 0) {
> +			if (ctrls)
> +				ctrls->error_idx =
> +					uvc_ctrl_find_ctrl_idx(entity, ctrls,
> +							       err_ctrl);
>  			goto done;
> +		}
>  	}
>  
>  	if (!rollback)
>  		uvc_ctrl_send_events(handle, ctrls->controls, ctrls->count);
>  done:
> -	if (ret < 0 && ctrls)
> -		ctrls->error_idx = uvc_ctrl_find_ctrl_idx(entity, ctrls,
> -							  err_ctrl);
>  	mutex_unlock(&chain->ctrl_mutex);
>  	return ret;
>  }
> @@ -2165,7 +2167,7 @@ static int uvc_ctrl_init_xu_ctrl(struct uvc_device *dev,
>  int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
>  	struct uvc_xu_control_query *xqry)
>  {
> -	struct uvc_entity *entity;
> +	struct uvc_entity *entity, *iter;
>  	struct uvc_control *ctrl;
>  	unsigned int i;
>  	bool found;
> @@ -2175,16 +2177,16 @@ int uvc_xu_ctrl_query(struct uvc_video_chain *chain,
>  	int ret;
>  
>  	/* Find the extension unit. */
> -	found = false;
> -	list_for_each_entry(entity, &chain->entities, chain) {
> -		if (UVC_ENTITY_TYPE(entity) == UVC_VC_EXTENSION_UNIT &&
> -		    entity->id == xqry->unit) {
> -			found = true;
> +	entity = NULL;
> +	list_for_each_entry(iter, &chain->entities, chain) {
> +		if (UVC_ENTITY_TYPE(iter) == UVC_VC_EXTENSION_UNIT &&
> +		    iter->id == xqry->unit) {
> +			entity = iter;
>  			break;
>  		}
>  	}
>  
> -	if (!found) {
> +	if (!entity) {
>  		uvc_dbg(chain->dev, CONTROL, "Extension unit %u not found\n",
>  			xqry->unit);
>  		return -ENOENT;

-- 
Regards,

Laurent Pinchart

