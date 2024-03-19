Return-Path: <linux-kernel+bounces-107321-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3482A87FB07
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 10:44:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C7930B219B3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 09:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 638FC7D3E4;
	Tue, 19 Mar 2024 09:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="L8QflLpl"
Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 766EC7CF39
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 09:44:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710841451; cv=none; b=p8ZsPinQyDjoN1d+lQKq3sPyyivGkPD7+hQx8gXKojViQBBPW0eN/sjL6KbMOzcE5DHCiKibfagyDVKc0nZ86h+dKFf8uneiFtiI8q9C6AcbIGGHlkdVNSZ8UnaGXj4bxmN4JQzWTvwUamgnL8kAQYQ+h3mlI19dc+PBNGZX6XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710841451; c=relaxed/simple;
	bh=K7dtrPof1myHFZzVXEfpBube4p7ne5/TRvoxTuThrgs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XY57srAnh+c7Sfv6nTAuvWvtWnwxPS5pJ/YL52o06i+Hn2Nl6GoAxvanU9RQ2DQPGQjwtplJa9rOL3FN1pJbg4i/eFBYgP8STGuzjPe2whEyfJG3Jzv/g9W2VVdxxc2678yf6B8ElmwXLYT49anP7GrRMXvhYuBjAhhYX5VXli0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=L8QflLpl; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-7e096ab9287so145019241.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1710841448; x=1711446248; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PjhFfrCCtfd6iQXKxWQJyRMtTzL2WM41bcwqi12J3Jk=;
        b=L8QflLpl0/STWUpC/KoP2WBuozCTtDfUSvEuTSDJyRw6HfeaVBtp7zk7nV4c6KQjKa
         8w+B0tyxf2eWlp56ZWh4UIjzzbpxi2ZSAP7jAsMCb39LdBtwzMGtKZ7Ug2X1jXYqVwyy
         LkHRdA/LBxK/ADh4cPpt2UxWK5E4KIIRFawls=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710841448; x=1711446248;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PjhFfrCCtfd6iQXKxWQJyRMtTzL2WM41bcwqi12J3Jk=;
        b=AjORP1rCLl5pzrRTjtJ1qVic9kl/hneuLEUwZcl3smjP+BkYDRlA3URXi9SarEINwt
         NX+6B/41j5kE41dICqEoE4ZzD/F1eaLz1SfmDKfTcTlSi/XVBLfBdbaXHiHyHRzLoEUv
         OKaBnGTzkKZUqx1L3zUOR/4sEa27Ok0UJQxswMrgKjj+9UAPBb84Ep6EIVVzAo5e/pAi
         4yQAOmEYgO9N+iyVtzVMkXyVElYmACk0uF/gGT2Nu2DhsVF/VNhZA5sshTBWNhZYdPvw
         MNE6ftF6T25nl8T7y5GItr/K0CSGA3Xqzfrora2QMhYsqzvUSca8Zq8S1Ms9eOfcDd+5
         6h3g==
X-Forwarded-Encrypted: i=1; AJvYcCWbbUmrpKX09zJrzmtWmfAkqPed8LmTSR/ocHst4ZYLeGUwv/RN7S9bJuuwXKr4HN79OkWuuseVChGnsQxGaWqBjJhrvksrclKcz5r0
X-Gm-Message-State: AOJu0YyGofVUF1W1NKmRFuWs3GxAq5NGW8bgKdqBDmLcDmxggHtjdDKD
	/B7eQNArruxa/UYUVoUJIvj4674UkRb+nj76EJmcAqwDV/BDxp8Jjw3qcsVKHnt3O3n0wKnbjYc
	=
X-Google-Smtp-Source: AGHT+IFLn99CGv4sdrAuE5UL2gt0hPKmOGUXMqFOOn4D4NKQJgGiAEDtULrsMjW+XEVnzxPTn7/YlQ==
X-Received: by 2002:a05:6122:2804:b0:4c0:25db:3618 with SMTP id en4-20020a056122280400b004c025db3618mr1798002vkb.0.1710841448024;
        Tue, 19 Mar 2024 02:44:08 -0700 (PDT)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id k24-20020a056122107800b004d405b8328csm1285536vko.37.2024.03.19.02.44.06
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 02:44:07 -0700 (PDT)
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-4d42ac6a0bcso1560080e0c.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 02:44:06 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVNwBwHsF8Wk6g3LbCdg7Iq9T2MUUQuMcyKMrWfdSSHL2lJiXKceC4/aVuuIucVuHjW0NdWi3OuqojiAqavvZhW/BFvk0OX5l//waio
X-Received: by 2002:a05:6122:4a88:b0:4d3:39c3:717c with SMTP id
 fa8-20020a0561224a8800b004d339c3717cmr1832304vkb.1.1710841446521; Tue, 19 Mar
 2024 02:44:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb4f7f29a94231c5fa404f7492dba8e7fd9fbb23.1686746422.git.soyer@irl.hu>
 <088902f67634fb0931da7b045e05afe5c8197cdc.1700505816.git.soyer@irl.hu>
In-Reply-To: <088902f67634fb0931da7b045e05afe5c8197cdc.1700505816.git.soyer@irl.hu>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 19 Mar 2024 10:43:52 +0100
X-Gmail-Original-Message-ID: <CANiDSCsXeuNLHSGhqYjkRoyhgW6MZo1xufONbYdm42OcRrj2ng@mail.gmail.com>
Message-ID: <CANiDSCsXeuNLHSGhqYjkRoyhgW6MZo1xufONbYdm42OcRrj2ng@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] media: uvcvideo: uvc_ctrl_get_rel_speed: use 0
 as default
To: Gergo Koteles <soyer@irl.hu>
Cc: Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
	Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Gergo

I missed sending the reviewed-by sorry :)

Btw, do you still have access to the device? Could you tell me what
you get from  and UVC_GET_MAX, UVC_GET_MIN for
UVC_CT_PANTILT_RELATIVE_CONTROL and UVC_CT_ZOOM_RELATIVE_CONTROL ?

Thanks!

On Mon, 20 Nov 2023 at 19:53, Gergo Koteles <soyer@irl.hu> wrote:
>
> Devices with pan/tilt controls but without pan/tilt speed controls
> return 1 for the default value of V4L2_CID_PAN_SPEED or
> V4L2_CID_TILT_SPEED. For these controls, the value of 1 means a
> move and that's not a good default.
>
> Currently, for these controls the UVC_GET_DEF query returns
> bPanSpeed or bTiltSpeed of CT_PANTILT_RELATIVE_CONTROL.
>
> According to the UVC 1.5 specification, the default value of bPanSpeed
> or bTiltSpeed should be 1 if the pan/tilt control doesn't support
> speed control.
>
> "If the control does not support speed control for the Tilt control,
> it will return the value 1 in this field for all these requests."
>
> This patch modifies the uvc_ctrl_get_rel_speed to return hardcoded 0
> for UVC_GET_DEF query, because that's the stop or don't move value
> for these V4L2 controls.
>
> Previous discussion
> Link: https://lore.kernel.org/all/CAP_ceTy6XVmvTTAmvCp1YU2wxHwXqnarm69Yaz8K4FmpJqYxAg@mail.gmail.com/
>
> Signed-off-by: Gergo Koteles <soyer@irl.hu>
Reviewed-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/usb/uvc/uvc_ctrl.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/media/usb/uvc/uvc_ctrl.c b/drivers/media/usb/uvc/uvc_ctrl.c
> index 5e9d3da862dd..e131958c0930 100644
> --- a/drivers/media/usb/uvc/uvc_ctrl.c
> +++ b/drivers/media/usb/uvc/uvc_ctrl.c
> @@ -444,9 +444,10 @@ static s32 uvc_ctrl_get_rel_speed(struct uvc_control_mapping *mapping,
>                 return -data[first+1];
>         case UVC_GET_MAX:
>         case UVC_GET_RES:
> +               return data[first+1];
>         case UVC_GET_DEF:
>         default:
> -               return data[first+1];
> +               return 0;
>         }
>  }
>
>
> base-commit: be9aac187433af6abba5fcc2e73d91d0794ba360
> --
> 2.42.0
>
>


-- 
Ricardo Ribalda

