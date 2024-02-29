Return-Path: <linux-kernel+bounces-87269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52BB786D1F2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 775851C21957
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE287A13C;
	Thu, 29 Feb 2024 18:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QNUL5IJt"
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38BD70AE1
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230874; cv=none; b=Po1SSNHs0Tbi3MVAJ1MJYbI0QDRfF0t5f/5AKd8rfp7Pg6FnqlNagBTZw6bpEfkVjchm7ID9NOpkJ05x8p7u5wX6LVStt8fDgD30Ep7RMJ52IZMJ6JW6rxvB+ci6/5iEWyihzVrYLP8LnJkZYviTBeZ01fca/xHHD0wZaMXr4Bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230874; c=relaxed/simple;
	bh=6URP3Ds0u1PbWJz6vrGB6hFeTqqwpMnTxISizxF7jUY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rL4HTvRQNRbB4QbNC00Q3ZLP+m7enefDHQPhzlNHeIg39sFH7Hi/d/DcFq0TBhrAdSCXcjhOzmkyEbZGpH5561uAu1eaHlcxZtDM5f+ZzooyX36byK7sqPz5CHFD5dAfUwN8yDO0RGIPzZufdiax1yCwOq5of1Dyu0Q0INRp2aA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=QNUL5IJt; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-220a0cacf9fso335470fac.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:21:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709230872; x=1709835672; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=coF2Crmlhb1FW6THGiXNdR+FS2vkbtT+MwPkcCLE6Nw=;
        b=QNUL5IJtm/RrXUppI6SVYAhgO8/xGQQMUaykr1EGwjdN9SGE8OHOogyU213eyC8OGj
         44Vkp84UCkMEf0HbKAFv4xAAY7oBfsEQLgTRqbmmkbjX5m910SCnXZUeb+65bLgoOzQR
         fJOEnhhp5L0Fh4PZzYKz5cw3ixAp5IgjSjjjg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709230872; x=1709835672;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=coF2Crmlhb1FW6THGiXNdR+FS2vkbtT+MwPkcCLE6Nw=;
        b=oyINTMCfnlndFYh7jEVwgL4FxOGWOAI8RVX5RPG6li68GBQvqHdi7o04z+/vAKwRPJ
         675zl6AJym4UV1tUEAdfovHTz130wdlQXPkGsh77XGFKpX7nUTSiV+cQ7fKStr0u6zeg
         hyhD45NLITYJ8q1MqxEh1maV8TLO0BIRHZM/c0UjuJrx61V5A1Ys9eQb0ipqBeKUM3Ud
         C4im4UMOJuwdK7cMHefwicJcaIypLtN9EOUOhXvp94LcwGwvwF0KiDLEvVd2HNIepxRt
         oBqn8zrWP2o4vJtwooaaZNKHIvI0XRTCRzUb511inf4EUFM2+PA5ZY0Lt0iVtYYEVBRi
         XkpA==
X-Forwarded-Encrypted: i=1; AJvYcCWXzaYMLZn77SA2mDZoXf+n57QLh3FZF4yiXiUr8VhvLonY1lmWz0qQVNm7BBFk+/KOIdxg6j79O1yjdlJjUAE2xMdhERJaYsN42+g0
X-Gm-Message-State: AOJu0YzJfeMt0Ov7Et/ztCl2Iv7gGdwNwNQiNoi7hV9xUlo4DXDURS/p
	C2xj2C9w2nkBChzU0QfcB9Z57V1jdnGmCRXiG19z8Qavm75cJYLGX+1ksi1vZfkCQUJDjtgMMak
	=
X-Google-Smtp-Source: AGHT+IGRNV7FCQfXtT67Kxa4AVwzPlbhI2WNZGlAOjmYUtJsUaoRL+6nyZ8N6rCMPFRw1tkcvV7rxg==
X-Received: by 2002:a05:6871:287:b0:21f:c801:cecf with SMTP id i7-20020a056871028700b0021fc801cecfmr2858280oae.16.1709230871901;
        Thu, 29 Feb 2024 10:21:11 -0800 (PST)
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com. [209.85.219.54])
        by smtp.gmail.com with ESMTPSA id kf6-20020a056214524600b0068c95ebd14csm1000110qvb.2.2024.02.29.10.21.10
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 10:21:11 -0800 (PST)
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-68fdc714187so5095036d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 10:21:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWUKAD/SzaE9AQX69BBYxo8fb9Ce9JWWxA9QFhPcCptzwqUar8zPR+tiCssqIKjXWUTCjpGRCiv2ZGdqyV0L0xyFeZEE2r5uYlBoney
X-Received: by 2002:a05:6214:b29:b0:690:4a75:d9aa with SMTP id
 w9-20020a0562140b2900b006904a75d9aamr1873343qvj.56.1709230870341; Thu, 29 Feb
 2024 10:21:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-uvc-host-video-decode-start-v2-1-88c6e17e487a@pengutronix.de>
In-Reply-To: <20240221-uvc-host-video-decode-start-v2-1-88c6e17e487a@pengutronix.de>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 29 Feb 2024 19:20:53 +0100
X-Gmail-Original-Message-ID: <CANiDSCtCse74oK_nCcJXRRQ__RnAAfYEFzfftty58stsFVKoYg@mail.gmail.com>
Message-ID: <CANiDSCtCse74oK_nCcJXRRQ__RnAAfYEFzfftty58stsFVKoYg@mail.gmail.com>
Subject: Re: [PATCH v2] uvc_video: check for fid change early in decode_start
 and avoid wrong error counting
To: Michael Grzeschik <m.grzeschik@pengutronix.de>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@pengutronix.de
Content-Type: text/plain; charset="UTF-8"

Hi Michael

So if my understanding is correct, what you want to achieve is to
avoid double stats_decode when the function returns -EAGAIN.

Wouldn't it be simpler to simply move uvc_video_clock_decode() and
uvc_video_stats_decode() before

stream->last_fid = fid;

just at the end of the function? Or am I missing something?

Besides being a small and documented function,
uvc_video_decode_start() is difficult to follow :), So I might be
saying something stupid

Regards



On Sat, 24 Feb 2024 at 23:52, Michael Grzeschik
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
> Changes in v2:
> - Moved the EAGAIN bailout after the sequence handling as mentioned by Ricardo Ribalda
> - Link to v1: https://lore.kernel.org/r/20240221-uvc-host-video-decode-start-v1-1-228995925c70@pengutronix.de
> ---
>  drivers/media/usb/uvc/uvc_video.c | 64 +++++++++++++++++++--------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> index 7cbf4692bd875..af368c45c4297 100644
> --- a/drivers/media/usb/uvc/uvc_video.c
> +++ b/drivers/media/usb/uvc/uvc_video.c
> @@ -1068,6 +1068,15 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
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
> @@ -1076,20 +1085,34 @@ static int uvc_video_decode_start(struct uvc_streaming *stream,
>                 stream->sequence++;
>                 if (stream->sequence)
>                         uvc_video_stats_update(stream);
> +
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
>         }
>
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
> base-commit: e89fbb5bc21a10a0de2bb878d4df09f538dc523b
> change-id: 20240221-uvc-host-video-decode-start-af53df5924cd
>
> Best regards,
> --
> Michael Grzeschik <m.grzeschik@pengutronix.de>
>
>


-- 
Ricardo Ribalda

