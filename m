Return-Path: <linux-kernel+bounces-48917-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8DF884632A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 23:09:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 86A351F260DD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 22:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 188FA3FE5D;
	Thu,  1 Feb 2024 22:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cxe6l4WZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46694405CF;
	Thu,  1 Feb 2024 22:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706825369; cv=none; b=e3+ZH7VdRQsH63T43gtIgfvGGRfGpcf9tmFaRVTILLxfETFE8L8MONo1ffqErTllINpeTR/1+qqzxq4tFT7ApDFSdsWtLlbMovBHY1A73+iq0dx+7WumXWpTauwqElNwQ6i2x7Ha5fUoIgYPmrIDSl38dBVHs/h7KNxz0Qy6tAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706825369; c=relaxed/simple;
	bh=E/2UIRa0Ph8g1t1LGEPJDYyOP+zaTTR1+LxJRQzZuxc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C8mQpPgEdpHEeW2Y5KPNQYOXNvNybmtBDGu+9c36HVYMvRYSTwNsfluqvxCVq0Lw2aa5dvW5ZM9l7gZpbEKp3oCJ2QDvJouJVPxbAv1NdsY2aLIdv+5Fc+N1c+NVVwSFJeUnGxFWYCbBQbxwzVblcDo6CEkjD3z3c1oXcFUkp+o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cxe6l4WZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0376CC433C7;
	Thu,  1 Feb 2024 22:09:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706825368;
	bh=E/2UIRa0Ph8g1t1LGEPJDYyOP+zaTTR1+LxJRQzZuxc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cxe6l4WZDdSVpOLVeIE4Qdg5MIw8fyuPjfsN2K1Ola6oh5m1WuTfjX12BkPZ2pPPk
	 NwdHJDa/2tP2G/9iHsCOZca8Z6whjWxmsLe2RfpdBreV0U55D5Dg6Cl32ngwoqNSo7
	 A8RUVw1nqJqy8OOddkt3ZJJh98f+sEGDa+ZMD/e6JZNcUeQE/IDuyjQa7IrcjrVqKG
	 6b5FEGrXUXMJryjaYFXmBy8KgEI9EDFeLEw0ZuRr+Tsf2trkdM4vJ6r8Bj5ALPbgrl
	 WQ4XKEqh6961T5s7A+HZQVKAX8pCRhrfHY89tWSbMwZOsueA61sa2RdEvpqPojhIoS
	 J052JZifcZksA==
Date: Thu, 1 Feb 2024 15:09:26 -0700
From: Nathan Chancellor <nathan@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>, Mike Isely <isely@pobox.com>,
	Tiffany Lin <tiffany.lin@mediatek.com>,
	Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
	Yunfei Dong <yunfei.dong@mediatek.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Subject: Re: [PATCH 2/3] media: usb: pvrusb2: Fix Wcast-function-type-strict
 warnings
Message-ID: <20240201220926.GB2240065@dev-arch.thelio-3990X>
References: <20240128-fix-clang-warnings-v1-0-1d946013a421@chromium.org>
 <20240128-fix-clang-warnings-v1-2-1d946013a421@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240128-fix-clang-warnings-v1-2-1d946013a421@chromium.org>

On Sun, Jan 28, 2024 at 02:12:21AM +0000, Ricardo Ribalda wrote:
> Building with LLVM=1 throws the following warning:
> drivers/media/usb/pvrusb2/pvrusb2-context.c:110:6: warning: cast from 'void (*)(struct pvr2_context *)' to 'void (*)(void *)' converts to incompatible function type [-Wcast-function-type-strict]
> drivers/media/usb/pvrusb2/pvrusb2-v4l2.c:1070:30: warning: cast from 'void (*)(struct pvr2_v4l2_fh *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict] drivers/media/usb/pvrusb2/pvrusb2-dvb.c:152:6: warning: cast from 'void (*)(struct pvr2_dvb_adapter *)' to 'pvr2_stream_callback' (aka 'void (*)(void *)') converts to incompatible function type [-Wcast-function-type-strict]
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>

Reviewed-by: Nathan Chancellor <nathan@kernel.org>

> ---
>  drivers/media/usb/pvrusb2/pvrusb2-context.c | 5 +++--
>  drivers/media/usb/pvrusb2/pvrusb2-dvb.c     | 7 ++++---
>  drivers/media/usb/pvrusb2/pvrusb2-v4l2.c    | 7 ++++---
>  3 files changed, 11 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-context.c b/drivers/media/usb/pvrusb2/pvrusb2-context.c
> index 1764674de98b..16edabda191c 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-context.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-context.c
> @@ -90,8 +90,9 @@ static void pvr2_context_destroy(struct pvr2_context *mp)
>  }
>  
>  
> -static void pvr2_context_notify(struct pvr2_context *mp)
> +static void pvr2_context_notify(void *data)
>  {
> +	struct pvr2_context *mp = data;
>  	pvr2_context_set_notify(mp,!0);
>  }
>  
> @@ -107,7 +108,7 @@ static void pvr2_context_check(struct pvr2_context *mp)
>  			   "pvr2_context %p (initialize)", mp);
>  		/* Finish hardware initialization */
>  		if (pvr2_hdw_initialize(mp->hdw,
> -					(void (*)(void *))pvr2_context_notify,
> +					pvr2_context_notify,
>  					mp)) {
>  			mp->video_stream.stream =
>  				pvr2_hdw_get_video_stream(mp->hdw);
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
> index 26811efe0fb5..8b9f1a09bd53 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-dvb.c
> @@ -88,8 +88,9 @@ static int pvr2_dvb_feed_thread(void *data)
>  	return stat;
>  }
>  
> -static void pvr2_dvb_notify(struct pvr2_dvb_adapter *adap)
> +static void pvr2_dvb_notify(void *data)
>  {
> +	struct pvr2_dvb_adapter *adap = data;
>  	wake_up(&adap->buffer_wait_data);
>  }
>  
> @@ -148,8 +149,8 @@ static int pvr2_dvb_stream_do_start(struct pvr2_dvb_adapter *adap)
>  		if (!(adap->buffer_storage[idx])) return -ENOMEM;
>  	}
>  
> -	pvr2_stream_set_callback(pvr->video_stream.stream,
> -				 (pvr2_stream_callback) pvr2_dvb_notify, adap);
> +	pvr2_stream_set_callback(pvr->video_stream.stream, pvr2_dvb_notify,
> +				 adap);
>  
>  	ret = pvr2_stream_set_buffer_count(stream, PVR2_DVB_BUFFER_COUNT);
>  	if (ret < 0) return ret;
> diff --git a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
> index c04ab7258d64..590f80949bbf 100644
> --- a/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
> +++ b/drivers/media/usb/pvrusb2/pvrusb2-v4l2.c
> @@ -1032,9 +1032,10 @@ static int pvr2_v4l2_open(struct file *file)
>  	return 0;
>  }
>  
> -
> -static void pvr2_v4l2_notify(struct pvr2_v4l2_fh *fhp)
> +static void pvr2_v4l2_notify(void *data)
>  {
> +	struct pvr2_v4l2_fh *fhp = data;
> +
>  	wake_up(&fhp->wait_data);
>  }
>  
> @@ -1067,7 +1068,7 @@ static int pvr2_v4l2_iosetup(struct pvr2_v4l2_fh *fh)
>  
>  	hdw = fh->channel.mc_head->hdw;
>  	sp = fh->pdi->stream->stream;
> -	pvr2_stream_set_callback(sp,(pvr2_stream_callback)pvr2_v4l2_notify,fh);
> +	pvr2_stream_set_callback(sp, pvr2_v4l2_notify, fh);
>  	pvr2_hdw_set_stream_type(hdw,fh->pdi->config);
>  	if ((ret = pvr2_hdw_set_streaming(hdw,!0)) < 0) return ret;
>  	return pvr2_ioread_set_enabled(fh->rhp,!0);
> 
> -- 
> 2.43.0.429.g432eaa2c6b-goog
> 

