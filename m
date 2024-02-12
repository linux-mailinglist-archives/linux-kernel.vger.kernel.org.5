Return-Path: <linux-kernel+bounces-62509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B56178521EC
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 00:00:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6284B1F2334C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 23:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBF184F895;
	Mon, 12 Feb 2024 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="VzRsKRyI"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2714F1F6;
	Mon, 12 Feb 2024 22:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707778782; cv=none; b=dMvUIpkeRJYui9s62zMK36WW0s9A3+v5lZiwRHHr34SL+FkcUaflByjWkBhBQAJVuFdfiEfG/gZ1IOVVu4z/yQHrr45RPpQuNMOKcwujtsv9flAv9GbUtn0xQQy81x+0Qx1k0UNVkjVXuEtFiUaZUoyXzw9dO4rNo2Z9KlEeJpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707778782; c=relaxed/simple;
	bh=vR/K496rPA2KU+aba4Uu2IC/4oIYinSUxJ9EgHzvb30=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaT0S6TyI2Tc5mUNA5rKpEfplHIigACyYfwDe7yXf5/eHdoSqViuMH3ss973rqnL/iEPhatzpfvgUiur+2I9LgB5XfuVhzN1iEvYT6SOIG65IRoA5E3NKdDaBYoSl+FeQjvnnhX7dnNs09yGN+7LByia3ScRC0Rj8RvGTKuVkv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=VzRsKRyI; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from pendragon.ideasonboard.com (unknown [109.130.69.237])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id CB11B2D8;
	Mon, 12 Feb 2024 23:59:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1707778776;
	bh=vR/K496rPA2KU+aba4Uu2IC/4oIYinSUxJ9EgHzvb30=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=VzRsKRyIm/u78yM0TPPGDEjCyjn2uwfGVk22wjzOznum1khiuJrpVSi8gHqA0l6FY
	 djWvyfgXx4yqkHGgBe45uEhcix4qTg4OF9m6HtzR93dtZ0J1O96G3ej19wAoKn4Gzo
	 sHAJkXLAJd1sve4N2Y9yQec0Yvxkfz9Wfaw7jlEs=
Date: Tue, 13 Feb 2024 00:59:40 +0200
From: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>,
	linux-media@vger.kernel.org
Subject: Re: [PATCH v9 1/6] media: uvcvideo: Fix negative modulus calculation
Message-ID: <20240212225940.GA19316@pendragon.ideasonboard.com>
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-1-55a89f46f6be@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220920-resend-hwtimestamp-v9-1-55a89f46f6be@chromium.org>

Hi Ricardo,

Thank you for the patch.

On Wed, Mar 15, 2023 at 02:30:12PM +0100, Ricardo Ribalda wrote:
> If head is 0, last will be addressing the index 0 instead of clock->size
> -1. Luckily clock->head is unsiged, otherwise it would be addressing
> 0xffffffff.

I'm not following you. In the expression

	(clock->head - 1) % clock->size

clock->head is an unsigned int, and 1 as a signed int, so the result of
the subtraction is promoted to an unsigned int. When clock->head is 0, the expression evaluates to

	0xffffffff % clock->size

clock->size is a power of two (hardcoded to 32 at the moment), so the
expression evaluates to 31, as intended.

Am I missing something ?

> Nontheless, this is not the intented behaviour and should be fixed.
> 
> Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index d4b023d4de7c..4ff4ab4471fe 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -732,7 +732,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
>  		goto done;
>  
>  	first = &clock->samples[clock->head];
> -	last = &clock->samples[(clock->head - 1) % clock->size];
> +	last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];
>  
>  	/* First step, PTS to SOF conversion. */
>  	delta_stc = buf->pts - (1UL << 31);

-- 
Regards,

Laurent Pinchart

