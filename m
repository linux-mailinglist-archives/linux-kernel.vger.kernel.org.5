Return-Path: <linux-kernel+bounces-127883-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E736895234
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 13:54:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41D31F2419B
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 11:54:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FFAF6996F;
	Tue,  2 Apr 2024 11:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nYoq6rMr"
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CDB4664AB
	for <linux-kernel@vger.kernel.org>; Tue,  2 Apr 2024 11:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712058853; cv=none; b=NJWURgDdF2Hj6c063Bjox0Eo88UuQ4MrSO6a4SCPXK6VpykRdtHL4S4MX86svGRiOcJEvKb3hgD22G8bXlPqOJ4xdv5l7K3phK/HBsMT/gV5emDOhyECWHs4DivMaELB3XsDIIC0z0u6+i47YzSNRB5ny5u9C9cglyVvE+uYwd8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712058853; c=relaxed/simple;
	bh=Se/I7Y5JnZQb/yv46fjeYpcBq8EX4h+IXo2QmYqhaLk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tjiiuSgPoe+T88ztuBH/6zfkkZ9P3uWNztcP6BQFsSN4YSx13H9atOKyPtW66MclRKQw7kasYjtiAmN999O7vfNB6H7tXJEhN8f6pCI3pfYql0Z2qXaX0UQkH038MPiIr7lMpIqKDN93P+wg/q21Gj6zcPOAmxfR/4T0Ht6kb8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=nYoq6rMr; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-22200c78d4fso2930022fac.1
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712058850; x=1712663650; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=D+tHVM1BhEEgMtmWgfi7Hpgb2iPhmeBdqYyZc0u0XaA=;
        b=nYoq6rMrFKep79AbzR5AzXjydhtaLeiEypoCC3Y6KXG2CUuylVvfnibUI9E+vO7xJo
         o2D8nHkBfDpcBPkLphobojWJ6eKWQll4yF0m9AvSE85WYofKa3K2QcVx2nbTTe11izoD
         xdoKTU3MFtRDL/OifghDaV9kU5YJbQxCBkH28=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712058850; x=1712663650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+tHVM1BhEEgMtmWgfi7Hpgb2iPhmeBdqYyZc0u0XaA=;
        b=QsgLAELdJDlMk/3EpDL+f3JJxI1xx/y4xC7qQYrI4kvu3A+SITzeo397H/ihWatn4R
         vEY7fgBPl3/x9bzJQg94emTPJyIVZ6C3raTruxJBfnm4ZWVxuGzn8Ipv1tD2M9YfZK3G
         p0NXvVQ5yahjbfXaOEChOu59nugsa/rM9VxtGfdZdg1IbAv64AuuvZ/KkqTMqwJJideY
         6ESVjKtBXNn20IFAt4SwLDQkka+EmmhxHwh31BzvOBXn7m4ZGds18fuVMsOC+c4hXMhA
         iX+sEOAgiX/v+OSZqJ/u9VO0/BEEyZ0i6PWJJVktyj5EIcemCLP3ZuTSj6LfK+PeUN/x
         1zog==
X-Forwarded-Encrypted: i=1; AJvYcCUxHpPp8T2V+HUxdDek/GF5LFnJ8tIqo/xflA/31JlhY9xPd1NPHHc+vcnu1fDw7uL1UhzynrJfbq/cxyNtuwIAu+77PZgEm4O9oeKV
X-Gm-Message-State: AOJu0YyGSKU+3iswAaFr0812TKpbteZkMiRAv3tg32cSvNHj1PNTkbGU
	EYWie21RX3+AMIm02M6i36NWpTQD2M5uKE9rNDbL1km85BmITKuMME1Av/4WfmjZ+HndivSsRLI
	Vew==
X-Google-Smtp-Source: AGHT+IFG2w/0TpuO9yVOJGet9Al7xsshoCmj1oPSoXlOZGjCYLC5QWaG8jQx+0vMWAgMFtk8epvtew==
X-Received: by 2002:a05:6870:9a08:b0:22e:7eb:991d with SMTP id fo8-20020a0568709a0800b0022e07eb991dmr11984775oab.36.1712058850374;
        Tue, 02 Apr 2024 04:54:10 -0700 (PDT)
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com. [209.85.210.52])
        by smtp.gmail.com with ESMTPSA id xm12-20020a0568709f8c00b0022e13ec6e47sm2355512oab.33.2024.04.02.04.54.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Apr 2024 04:54:10 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6e67d42422aso3259167a34.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Apr 2024 04:54:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXQglwjoNrNOEp657Rev8r4uF08ombtv7Bv5D60nTWRF0wbupCPME/k6QEV3yGc9n1WfXomGvL2OERK1eAovmHgUk4PCUs7oV0DPFcQ
X-Received: by 2002:a05:6830:1bc9:b0:6e8:a28e:8d5 with SMTP id
 v9-20020a0568301bc900b006e8a28e08d5mr4483126ota.1.1712058849319; Tue, 02 Apr
 2024 04:54:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240328-uvc-fix-relative-ptz-speed-v1-0-17373eb8b2be@securitylive.com>
 <20240328-uvc-fix-relative-ptz-speed-v1-1-17373eb8b2be@securitylive.com>
In-Reply-To: <20240328-uvc-fix-relative-ptz-speed-v1-1-17373eb8b2be@securitylive.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 2 Apr 2024 13:53:53 +0200
X-Gmail-Original-Message-ID: <CANiDSCsyj-Zfzo+1Sxgzz_fQ4Df9rjc_Cj66Bokni_6oJk41Fg@mail.gmail.com>
Message-ID: <CANiDSCsyj-Zfzo+1Sxgzz_fQ4Df9rjc_Cj66Bokni_6oJk41Fg@mail.gmail.com>
Subject: Re: [PATCH 1/2] media: uvcvideo: UVC minimum relative pan/tilt/zoom
 speed fix
To: johnebgood@securitylive.com
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linh.tp.vu@gmail.com, soyer@irl.hu
Content-Type: text/plain; charset="UTF-8"

Hi John

Maybe you could add a function like


static bool is_relative_ptz_ctr(__u32 id)
{
          switch (xctrl->id) {
           case V4L2_CID_ZOOM_CONTINUOUS:
           case V4L2_CID_PAN_SPEED:
            case V4L2_CID_TILT_SPEED:
                     return true;
          }
          return false;
}

to figure out if a control is relative or not, and avoid code duplication.



On Fri, 29 Mar 2024 at 00:18, John Bauer via B4 Relay
<devnull+johnebgood.securitylive.com@kernel.org> wrote:
>
> From: John Bauer <johnebgood@securitylive.com>
>
> The minimum UVC control value for the relative pan/tilt/zoom speeds
> cannot be probed as the implementation condenses the pan and tilt
> direction and speed into two 16 bit values. The minimum cannot be
> set at probe time because it is probed first and the maximum is not
> yet known. With this fix if a relative speed control is queried
> or set the minimum is set and checked based on the additive inverse of
> the maximum at that time.
>
> Signed-off-by: John Bauer <johnebgood@securitylive.com>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 37 ++++++++++++++++++++++++++++++++++---
>  1 file changed, 34 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index e59a463c2761..b389ab3ee05d 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -1322,9 +1322,25 @@ static int __uvc_query_v4l2_ctrl(struct uvc_video_chain *chain,
>                 break;
>         }
>
> -       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN)
> -               v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
> -                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> +       if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MIN) {
> +               switch (v4l2_ctrl->id) {
> +               case V4L2_CID_ZOOM_CONTINUOUS:
> +               case V4L2_CID_PAN_SPEED:
> +               case V4L2_CID_TILT_SPEED:
> +                       /*
> +                        * For the relative speed implementation the minimum
> +                        * value cannot be probed so it becomes the additive
> +                        * inverse of maximum.
> +                        */
> +                       v4l2_ctrl->minimum = -1 * mapping->get(mapping, UVC_GET_MAX,
> +                                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +                       break;
> +               default:
> +                       v4l2_ctrl->minimum = mapping->get(mapping, UVC_GET_MIN,
> +                                               uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
> +                       break;
> +               }
> +       }
>
>         if (ctrl->info.flags & UVC_CTRL_FLAG_GET_MAX)
>                 v4l2_ctrl->maximum = mapping->get(mapping, UVC_GET_MAX,
> @@ -1914,6 +1930,21 @@ int uvc_ctrl_set(struct uvc_fh *handle,
>                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MIN));
>                 max = mapping->get(mapping, UVC_GET_MAX,
>                                    uvc_ctrl_data(ctrl, UVC_CTRL_DATA_MAX));
> +
> +               /*
> +                * For the relative speed implementation the minimum
> +                * value cannot be probed so it becomes the additive
> +                * inverse of maximum.
> +                */
> +               switch (xctrl->id) {
> +               case V4L2_CID_ZOOM_CONTINUOUS:
> +               case V4L2_CID_PAN_SPEED:
> +               case V4L2_CID_TILT_SPEED:
> +                       min = max * -1;
> +               default:
> +                       break;
> +               }
> +
>                 step = mapping->get(mapping, UVC_GET_RES,
>                                     uvc_ctrl_data(ctrl, UVC_CTRL_DATA_RES));
>                 if (step == 0)
>
> --
> 2.34.1
>
>


-- 
Ricardo Ribalda

