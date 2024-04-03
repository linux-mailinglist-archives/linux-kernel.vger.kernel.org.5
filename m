Return-Path: <linux-kernel+bounces-130594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DC8B897A39
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 22:46:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C16761C258F3
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16B5F155A58;
	Wed,  3 Apr 2024 20:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="BLKOzWGV"
Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783D05DF0E
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 20:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712177160; cv=none; b=dDRMDJTV1gMi/nvsWThgvyGpsgnrpr+UOkldLBBYT/ihK4cInED/e7AlCT3yYtGeF3JtgpdH8xdo8pcFDOj6AOsqZuEeCYaksys0UQbu9PPRplas8TfrQQFiFSOdLDNSNlPOqKf06ynQnLHKPdoaDeGWFcLCY37xMjDNEcaBT8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712177160; c=relaxed/simple;
	bh=5qSG2aA7zP86uqE7QONcq5Fa+fMoEGvSuBVv5RvKfgI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CUYRCJdnmBOckfjMm49UWkojoJMDVZfhYY3F5HXzF9TrEEGLA7UpAdlYBwb/QGTNjDAxkwpCLPrueEptby7LG0/s6c4MNrOqeCpHnD9GOVyK8SqSdiddvHpTH0TL4f5NC95fXOM4Vn1C8A90FtTAjnm/O3IELJ9UJ5rUax+nP28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=BLKOzWGV; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-2d83dddcd65so3629651fa.1
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 13:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712177156; x=1712781956; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=itlV3Ei52sbNGGLJPwsBC3H98Sks2mSob1+Tdb5KXBg=;
        b=BLKOzWGVGY2d5v2ZrsI/3tJMx6PfueJWJwdVuHfKPiF9jBtzfiZ+BNf4CWelDPB9zP
         AxkUpWiBw6edIR9VuaUFKNohUXYErQDWTP+sTGc0ms/t19dZpWA6KnQGg2kCOwpcjPqa
         gcLFaqp95q5dfOSu9tzVjTBNDIoB4fnBsRyPY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712177156; x=1712781956;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=itlV3Ei52sbNGGLJPwsBC3H98Sks2mSob1+Tdb5KXBg=;
        b=jLCxh89zM5lwAb6hBLeKG+mKBOcYBHngDLHS9tkD6e6pzj4bsnB2kXWLVCSQxU7bV6
         u7UeXCv2y+edbUpF4ZDpklq9vkWd63C5lCu21+yUcGxi58bRXDptuOXrYbjP4g/77ZXV
         6oz1MY/SYd9p20b8jrX3cQqrKQBJrmfA4xfa4WM2V1QPFOUhyK/VXVTS9nd5NE3dQXq6
         K/Mehp1iF3z6/NU7OyRduJTrb3t0e9wkewy7CMbDLBFWs/iIx5AoOEi7MVtM+jSzTCb6
         t3Ja/mK5CGn3soP9ddFZH9xeSqvJV8cRLY6GAIb5WB2/+lLZnivEvRj1ROdHdSKDuTC8
         TYMA==
X-Forwarded-Encrypted: i=1; AJvYcCV1fIdNqnpSKVH5eIWppmB2ZTJUUndCYMuKK4dbNkEkvSDHWd8VqiuBhMT12fukWFWqwpyG1pnpLLzAiWl7NUv+Sx4Ni+/9fRO20oCK
X-Gm-Message-State: AOJu0YyIwiARn4Ia4IDnYythxLs10foI1Yg+ocxs08KvsA8Sd00/hbGR
	YnjXOFHz5WYxYCUPRkCwJrkz/VbPloK0yl+s1AWeHpxYm9fwwUPj+O7sqEokTeM8MryrGFfMfbo
	oUQ==
X-Google-Smtp-Source: AGHT+IGCj0lA5dN/B2yp+OD+528HQG5PFAGNdGHEAiSO4auzLNSkEbR22dWErgTN7TtZRWb8VzDCxQ==
X-Received: by 2002:a2e:8796:0:b0:2d4:5f50:1fa with SMTP id n22-20020a2e8796000000b002d45f5001famr380509lji.41.1712177156308;
        Wed, 03 Apr 2024 13:45:56 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com. [209.85.221.48])
        by smtp.gmail.com with ESMTPSA id r17-20020a056402019100b0056c4a0ccaacsm8361023edv.83.2024.04.03.13.45.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 13:45:55 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-33eee0258abso110949f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 13:45:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUDfXh2LGHxKFx8xsFV34qIGYi8CBpDAc/OJ9HxSjwy3GhXYsWeMRsUxhsxT1DFiLYillg8655ZM83ITe1oC4VgyMIrMbSiEzipJ3e1
X-Received: by 2002:a05:6000:190:b0:33e:cf4d:c581 with SMTP id
 p16-20020a056000019000b0033ecf4dc581mr421503wrx.41.1712177155304; Wed, 03 Apr
 2024 13:45:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240403-uvc-fix-relative-ptz-speed-v1-0-624c9267f745@securitylive.com>
 <20240403-uvc-fix-relative-ptz-speed-v1-2-624c9267f745@securitylive.com>
In-Reply-To: <20240403-uvc-fix-relative-ptz-speed-v1-2-624c9267f745@securitylive.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Wed, 3 Apr 2024 22:45:42 +0200
X-Gmail-Original-Message-ID: <CANiDSCvfFuQSa5j7Zs-skXmPGTHRtGVH3moA8w=AG1BF1m=dLw@mail.gmail.com>
Message-ID: <CANiDSCvfFuQSa5j7Zs-skXmPGTHRtGVH3moA8w=AG1BF1m=dLw@mail.gmail.com>
Subject: Re: [PATCH 2/3] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix
To: johnebgood@securitylive.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linh.tp.vu@gmail.com, soyer@irl.hu
Content-Type: text/plain; charset="UTF-8"

Hi John

Can you squash all the patches in one and resend as v3?

When you send a new version of your patch, you want to send it as PATCHvX

b4 should do this automatically for you:

- just go to the original branch
git checkout b4/uvc-relative-ptz-speed-fix

- then edit the change with something like
git rebase -i

- then edit the cover to describe the changelog with
b4 prep --edit-cover

-then submit
b4 submit

I will comment on your 2/2... but it should be squashed into your 1/2

Thanks!


On Wed, 3 Apr 2024 at 21:58, John Bauer via B4 Relay
<devnull+johnebgood.securitylive.com@kernel.org> wrote:
>
> From: John Bauer <johnebgood@securitylive.com>
>
> Made recommended changes from Ricardo. I explored the case where
> the minimum could be > 0 but less than the maximum. If this were
> to occur the range of -maximum to maximum would still apply correctly
> however there would be a range from -min to min that would possibly
> not apply. It would be possible to capture the probed minimum and
> check against that when setting the controls.
>
> Signed-off-by: John Bauer <johnebgood@securitylive.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 13 ++++++-------
>  1 file changed, 6 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index b389ab3ee05d..04300a782c81 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1322,6 +1322,10 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>                 break;
>         }
>
> +       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
> +               v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
> +                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
>                 switch (v4l2_ctrl->id) {
>                 case V4L2_CID_ZOOM_CONTINUOUS:
> @@ -1332,8 +1336,7 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>                          * value cannot be probed so it becomes the additive
>                          * inverse of maximum.
>                          */
> -                       v4l2_ctrl->minimum = -1 * mapping->get(mapping, UVC_GET_MAX,
> -                                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +                       v4l2_ctrl->minimum = -v4l2_ctrl->maximum;
>                         break;
>                 default:
>                         v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
> @@ -1342,10 +1345,6 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>                 }
>         }
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
> -               v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
> -                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> -
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_RES)
>                 v4l2_ctrl->step = mapping->get(mapping, UVC_GET_RES,
>                                   uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
> @@ -1940,7 +1939,7 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>                 case V4L2_CID_ZOOM_CONTINUOUS:
>                 case V4L2_CID_PAN_SPEED:
>                 case V4L2_CID_TILT_SPEED:
> -                       min = max * -1;
> +                       min = -max;
>                 default:
>                         break;
>                 }
>
> --
> 2.34.1
>
>


--
Ricardo Ribalda

