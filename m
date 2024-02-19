Return-Path: <linux-kernel+bounces-71125-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5883D85A0FB
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:28:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 14DBF28365F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:28:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0C2828DA5;
	Mon, 19 Feb 2024 10:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="bptmoBWB"
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D99C25626
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 10:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708338502; cv=none; b=Cg5sZES7iZR5XNQQtoSGUe3ShnBG+OZbmzG/KDcJMZ4yK+sMaF3h3o0gCfbTAQWmzan+DecR7FzZOjtL8y0t+bBoXeX0AONFoe13TSFaN2lIIp2bnNW6Zpkvd3s69INbZPcUrPyfh5O/cbVDOeA9JAySTBao2Zw8CaW9AHOLbE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708338502; c=relaxed/simple;
	bh=iYEBmJAiZbDHquX5J9zr+Y0/ZXalcfLXS+y4zzeLWyo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iQqWfdFdI8lemqWVZlRnrK4RpwKZI4jjGw0hVUmAxJSVFGB4sICemuLfhcB84rlkFPUxXENvhkma9ka3lQpJ7CncSkipmFmjX7h356mla9FB5Hkk7Lb6mpboxR8aF7Oj2enexploYjymOUOPfVReF79l8fCpH8eX9OObbSDr2tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=bptmoBWB; arc=none smtp.client-ip=209.85.219.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-68f51ba7043so12236396d6.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:28:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708338499; x=1708943299; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=b6mgSrluIqEO45OZ9CPAhxzFHqfPHFQOqZgtTo0EQsQ=;
        b=bptmoBWBGk/sQeSf+XImIluL/QL+g4/z1Za/QRHZS6ZO5SzVOoOWosWHb3VD6fkhAf
         BAwz2ivSeX3mUWvKHjxh2XcszJV1ikzvVgkalVafcoOJ/KT//XSBwGnKCB/LjuVJwQJk
         hzOi9KlMKtveDme0wLezJQgXTnqe90Bv9CjV0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708338499; x=1708943299;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b6mgSrluIqEO45OZ9CPAhxzFHqfPHFQOqZgtTo0EQsQ=;
        b=PT0NxE43rT/WRn1cmuXk9LimsNnPNHrjWuFZ8yYt689h9PVn5Juk2KwleEedhvOM/b
         xI670qC0ZUDfC065i3W0ZQQ5fCSrArGxZrGfW7Jx1tU2QxsfbLVDnLh46mMFaCf553sA
         T+qAppVJajqkeIHI1xVHdLvbbpmCtD4XByHBNpzigMQ353fAztOrpM12B+EReK2jCmHq
         guPx/kohk/d0WmMJuHju6lHmHpOVQz/Pxe0XW4dolHGXQzn7MxnBw9e3Jpz3vG59DCzh
         SmsPLYR7/50rLixANAphRAxVzOo7RHgvw0sVVB8GNU/3KxzrEYIZXU4Wa+eqJhRbwOUV
         PzNA==
X-Forwarded-Encrypted: i=1; AJvYcCUR4TpI4NmZYKJc44xpjf6wJzo/ApBLGvdqxEUmBLsmCwXCUmi2s1FOV5Alce8j6XchytrG/4xQWzhBkushLmwcKe+ep5Euysrfr85R
X-Gm-Message-State: AOJu0Yw6WHO/j1pTNnGqiocqGv5AddSitYG3m77fdm2ttrkHdYIM/H4h
	qgWfANCjKpTwPk6cYI+REadtsPC0y63ArTcs6x6gK2CwlJUOUQq3VqELWZcXQz1a9ZvTFG1yceU
	=
X-Google-Smtp-Source: AGHT+IHLQI9TiNBRxk3gg2t54vq8gUh7a7Or+gAzVgtpTetfI6cLXF3bKdop9ZgW5ZfZkYpN4GwBDw==
X-Received: by 2002:a05:6214:4404:b0:68f:5d17:8ce with SMTP id oj4-20020a056214440400b0068f5d1708cemr4633496qvb.1.1708338498927;
        Mon, 19 Feb 2024 02:28:18 -0800 (PST)
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com. [209.85.219.45])
        by smtp.gmail.com with ESMTPSA id mb9-20020a056214550900b0068f7fee5a88sm285756qvb.76.2024.02.19.02.28.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 02:28:18 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68f54a65ae2so6825936d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 02:28:18 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUe1E2gJaoIhLWjMz7NbZxkwNYRJCz50WOnTLamui5YtqKuRT+cN3n3KH6I/38aUxVeCmPCvxNzw1wPWHHRtPIxknXZr7EJV79NUfqS
X-Received: by 2002:a0c:971a:0:b0:68f:4d2d:3f34 with SMTP id
 k26-20020a0c971a000000b0068f4d2d3f34mr6594470qvd.39.1708338497675; Mon, 19
 Feb 2024 02:28:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-1-55a89f46f6be@chromium.org> <20240212225940.GA19316@pendragon.ideasonboard.com>
In-Reply-To: <20240212225940.GA19316@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 19 Feb 2024 11:28:03 +0100
X-Gmail-Original-Message-ID: <CANiDSCuoskaERyyzuLen+ReGHBNnOrFducbWYAvFQ6HfbUCPcg@mail.gmail.com>
Message-ID: <CANiDSCuoskaERyyzuLen+ReGHBNnOrFducbWYAvFQ6HfbUCPcg@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] media: uvcvideo: Fix negative modulus calculation
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Mon, 12 Feb 2024 at 23:59, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Mar 15, 2023 at 02:30:12PM +0100, Ricardo Ribalda wrote:
> > If head is 0, last will be addressing the index 0 instead of clock->size
> > -1. Luckily clock->head is unsiged, otherwise it would be addressing
> > 0xffffffff.
>
> I'm not following you. In the expression
>
>         (clock->head - 1) % clock->size
>
> clock->head is an unsigned int, and 1 as a signed int, so the result of
> the subtraction is promoted to an unsigned int. When clock->head is 0, the expression evaluates to
>
>         0xffffffff % clock->size
>
> clock->size is a power of two (hardcoded to 32 at the moment), so the
> expression evaluates to 31, as intended.
>
> Am I missing something ?

Take a look to: https://godbolt.org/z/xYeqTx6ba

The expression only works because the size is a power of two. In this
set I am allowing sizes that are not powers of two.

Regards!




>
> > Nontheless, this is not the intented behaviour and should be fixed.
> >
> > Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index d4b023d4de7c..4ff4ab4471fe 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -732,7 +732,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
> >               goto done;
> >
> >       first = &clock->samples[clock->head];
> > -     last = &clock->samples[(clock->head - 1) % clock->size];
> > +     last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];
> >
> >       /* First step, PTS to SOF conversion. */
> >       delta_stc = buf->pts - (1UL << 31);
>
> --
> Regards,
>
> Laurent Pinchart



--
Ricardo Ribalda

