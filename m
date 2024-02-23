Return-Path: <linux-kernel+bounces-78446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 519018613A1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 15:10:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9E91F21E73
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 14:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615C48003B;
	Fri, 23 Feb 2024 14:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="V10aeQA/"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC027F7CE
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 14:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708697400; cv=none; b=rTxkYljgFOiFW8ns+xPLJapgfi4M8yeVxbw8FaaEwQT5YnjlWZEyr5rzFyM6Pvhp+Kt7wZ+Vf9fM/shzTFlwbB/POiiqKdV4m+XanRaY6tLo+7dh1G0irWUsQ4+omtg9s5tzNpOmhJ9eDULy4nbfCORpYbyhKulxcGrGH4WY6zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708697400; c=relaxed/simple;
	bh=3G+g6BllPc9uaOzGwZYVR1zgjhxCkWMKXZdNcBY+4oU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JUpe9oTT+VTPQl8+Klw84DKWSqpjXsKE2N3pcjsqNcQdMI9RbAed3U3Ly0T34Y1wlFBjYtgscX2sjYQo9a0fmtlvJzn2XNCqklieaRjHlpsJZPvhvPM8V70/w4PPDPvjDIA2MgDDWT6+vzYbUT6VBaW8vr7WH2lkSd7om9NIBIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=V10aeQA/; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-608841dfcafso4029167b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:09:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708697397; x=1709302197; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eAPyItCVDT4gWeCeZAeUVS+cG21PhVeYpJuB3UozBoI=;
        b=V10aeQA/QH/Hn1FWKsMdj0/Shn5WVt++h15iqdhEaodT4qTsmo4swkMQlZMz3NjFQF
         sQG0AHy3rlPPBi5ZHi5IaMyFOI545NKnQYtqxxPBlLOngysG+X70y250EzdIPFdzLx7u
         T3Jjqfu5UwKCXqxEZPPY4txj/W6bIbjVKPKgE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708697397; x=1709302197;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAPyItCVDT4gWeCeZAeUVS+cG21PhVeYpJuB3UozBoI=;
        b=iRDAcjLTVSKu/hCrgvSKX4gNLG3vff1ohDlDZxNWJkMiifj+8GPFQT4NrVgLRUMUr3
         JpJQRHM5HdDv0K8/eCFwUwOocP/IHTZhr0k8IuWMzWGw0WVUTYpUaGNLHJRbuyLDocBz
         Nnd3xb6yX/QvW14djxiVnyG4zwbIvu5P31pCjxizOFtqOS+LLUEo8Qnn+4Ub36OEKWH3
         sHfPVV3yJN1QVJ5PblNuOLRXG+F6+p6+p4V43k5CDarerJQY1cTlI5aNID6pqVKpfIBZ
         cH39zTmlFVUhUXW9PnVfGF+tPZMDHMF+lV5n1ltqySzZHCny5uoMlxyrihPuT7S6l6H1
         q5Jw==
X-Forwarded-Encrypted: i=1; AJvYcCXmM1koTf+ZPFq8xiUwVe9OSFhkwlL2p3hUMzeU9okcipFBKM0U5ci1JBDUxLY+CeNj8rBmNy5jwIvbPGIAsdRsAOFsTUt4AMs8l1o5
X-Gm-Message-State: AOJu0YxsLsufyv5IaOKrEGlPJ09DCiI/unDBDaXrOUaMk/ilpOeM7LyU
	WRGZE2ikYfcqTftKqAPiVxQAI4eAc9wmC2p8ucV3Hb/K1Sk0xYU2JEIbZ+edH6Vpp3un+MbUyes
	=
X-Google-Smtp-Source: AGHT+IFPIvMZp54+oOOmkyxv5O846GO1gVL+Tkx0qPnhUybi59jdFy+fdFnLo1tXDy29z7DsusP8vg==
X-Received: by 2002:a81:af54:0:b0:607:805a:6da4 with SMTP id x20-20020a81af54000000b00607805a6da4mr2387978ywj.2.1708697396941;
        Fri, 23 Feb 2024 06:09:56 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id r65-20020a0dcf44000000b00603eb201977sm3590231ywd.70.2024.02.23.06.09.56
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 06:09:56 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-608959cfcbfso4481007b3.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 06:09:56 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVz5puBxAcBQJSEHbhvhJ4Y7421epSh+YZyiToJIYUSm5ULPM8IlKFwZVQ+1bwEDTWsJc90NeDUpWxnpFXorb9tR+CwnPPDepE3BSlv
X-Received: by 2002:a05:690c:97:b0:5ff:42f2:ef75 with SMTP id
 be23-20020a05690c009700b005ff42f2ef75mr2664803ywb.16.1708697395524; Fri, 23
 Feb 2024 06:09:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-uvc-host-video-decode-start-v1-1-228995925c70@pengutronix.de>
In-Reply-To: <20240221-uvc-host-video-decode-start-v1-1-228995925c70@pengutronix.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 23 Feb 2024 15:09:39 +0100
X-Gmail-Original-Message-ID: <CANiDSCtFRugwLX-9jLUwkvxxvO2EFZES6899qcdfnoeQwX3fOQ@mail.gmail.com>
Message-ID: <CANiDSCtFRugwLX-9jLUwkvxxvO2EFZES6899qcdfnoeQwX3fOQ@mail.gmail.com>
Subject: Re: [PATCH] uvc_video: check for fid change early in decode_start and
 avoid wrong error counting
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

Hi Michael

In your code when is  uvc_video_stats_update() called or
stream->sequence incremented in normal use case?

I might be interpreting it wrong, but it seems like if buf->bytesused
is !=0 that code is never called.

Regards!


On Wed, 21 Feb 2024 at 23:53, Michael Grzeschik
<m.grzeschik@pengutronix.de> wrote:
>
> When the uvc request will get parsed by uvc_video_decode_start it will
> leave the function with -EAGAIN to be restarted on the next frame. While
> the first wrong parse the statistics will already be updated with
> uvc_video_stats_decode.
>
> One value e.g. is the error_count, which therefor will be incremented
> twice in case the fid has changed on the way. This patch fixes the
> unnecessary extra parsing by returning early from the function when the
> fid has changed.
>
> Signed-off-by: Michael Grzeschik <m.grzeschik@pengutronix.de>
> ---
>  drivers/media/usb/uvc/uvc_video.c | 64 +++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 7cbf4692bd875..fce5349b5f9fa 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1068,11 +1068,43 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
>
>         fid = data[1] & UVC_STREAM_FID;
>
> +       /*
> +        * Store the payload FID bit and return immediately when the buffer is
> +        * NULL.
> +        */
> +       if (buf == NULL) {
> +               stream->last_fid = fid;
> +               return -ENODATA;
> +       }
> +
>         /*
>          * Increase the sequence number regardless of any buffer states, so
>          * that discontinuous sequence numbers always indicate lost frames.
>          */
>         if (stream->last_fid != fid) {
> +               /*
> +                * Mark the buffer as done if we're at the beginning of a new frame.
> +                * End of frame detection is better implemented by checking the EOF
> +                * bit (FID bit toggling is delayed by one frame compared to the EOF
> +                * bit), but some devices don't set the bit at end of frame (and the
> +                * last payload can be lost anyway). We thus must check if the FID has
> +                * been toggled.
> +                *
> +                * stream->last_fid is initialized to -1, so the first isochronous
> +                * frame will never trigger an end of frame detection.
> +                *
> +                * Empty buffers (bytesused == 0) don't trigger end of frame detection
> +                * as it doesn't make sense to return an empty buffer. This also
> +                * avoids detecting end of frame conditions at FID toggling if the
> +                * previous payload had the EOF bit set.
> +                */
> +               if (buf->bytesused) {
> +                       uvc_dbg(stream->dev, FRAME,
> +                               "Frame complete (FID bit toggled)\n");
> +                       buf->state = UVC_BUF_STATE_READY;
> +                       return -EAGAIN;
> +               }
> +
>                 stream->sequence++;
>                 if (stream->sequence)
>                         uvc_video_stats_update(stream);
> @@ -1081,15 +1113,6 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
>         uvc_video_clock_decode(stream, buf, data, len);
>         uvc_video_stats_decode(stream, data, len);
>
> -       /*
> -        * Store the payload FID bit and return immediately when the buffer is
> -        * NULL.
> -        */
> -       if (buf == NULL) {
> -               stream->last_fid = fid;
> -               return -ENODATA;
> -       }
> -
>         /* Mark the buffer as bad if the error bit is set. */
>         if (data[1] & UVC_STREAM_ERR) {
>                 uvc_dbg(stream->dev, FRAME,
> @@ -1124,29 +1147,6 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
>                 buf->state = UVC_BUF_STATE_ACTIVE;
>         }
>
> -       /*
> -        * Mark the buffer as done if we're at the beginning of a new frame.
> -        * End of frame detection is better implemented by checking the EOF
> -        * bit (FID bit toggling is delayed by one frame compared to the EOF
> -        * bit), but some devices don't set the bit at end of frame (and the
> -        * last payload can be lost anyway). We thus must check if the FID has
> -        * been toggled.
> -        *
> -        * stream->last_fid is initialized to -1, so the first isochronous
> -        * frame will never trigger an end of frame detection.
> -        *
> -        * Empty buffers (bytesused == 0) don't trigger end of frame detection
> -        * as it doesn't make sense to return an empty buffer. This also
> -        * avoids detecting end of frame conditions at FID toggling if the
> -        * previous payload had the EOF bit set.
> -        */
> -       if (fid != stream->last_fid && buf->bytesused != 0) {
> -               uvc_dbg(stream->dev, FRAME,
> -                       "Frame complete (FID bit toggled)\n");
> -               buf->state = UVC_BUF_STATE_READY;
> -               return -EAGAIN;
> -       }
> -
>         stream->last_fid = fid;
>
>         return data[0];
>
> ---
> base-commit: 3bf0514dc6f36f81ee11b1becd977cb87b4c90c6
> change-id: 20240221-uvc-host-video-decode-start-af53df5924cd
>
> Best regards,
> --
> Michael Grzeschik <m.grzeschik@pengutronix.de>
>
>


-- 
Ricardo Ribalda

