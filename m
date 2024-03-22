Return-Path: <linux-kernel+bounces-111254-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59DE58869C3
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF48F285298
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:54:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5E27225AF;
	Fri, 22 Mar 2024 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aouaI61O"
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56CFA383BA
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711101243; cv=none; b=VRqL4d3wmktPdnJuugJxrikgzXMJ8EHlqqRih/gYX7MVdZbcajSJ2MwSGrOUVTXn419XY4r98IyQD4J6+BbCj8Cbo082oMUvsUGHY+e0uLPPY7rDkHAgCBuxdmE+LqsMaUBGA2hDsvdeH3st8yKuGQYNymX42WPnKwIDcwZpv8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711101243; c=relaxed/simple;
	bh=vjqEObL0QUT0FRkhgE1k7Zaz2Z1i6sWZd0ubJaupmIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=najr+jhC8D4oFokJ3wiMi5ES/NFQn25TxRjFhArnfT++CLShOJ5IBTsj/9Musw1COYKPPw48KYn0ShKw+ysRORvBE4cCqGW3vKBln5B44DUUmbLmxkpEmBiyONHevvgnYl3PS0sDwDxMc+S+pZ1vt14vtDPJ0NnNNJRsUFfGF1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aouaI61O; arc=none smtp.client-ip=209.85.160.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f179.google.com with SMTP id d75a77b69052e-42a0ba5098bso13664681cf.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711101240; x=1711706040; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=8WbPf4u/guZtL0UBxRr9aD1eeF4y1ReSS6bv+KKsBZY=;
        b=aouaI61O10wMESOg5XL662lDhULohs7faebQWsCOuGc1CQ5xUeiufqpsQJygwG1zk0
         sdXNuQhBEsqypSKYfLghR+Mlqb9NSVcXtwsZqSquVP+lZSfGi9Vt7d9GR5k6tSRsdGcd
         wHLZ7wre65LSlQ7Yqj1C7nN9VuBcbVEK7YSec=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711101240; x=1711706040;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8WbPf4u/guZtL0UBxRr9aD1eeF4y1ReSS6bv+KKsBZY=;
        b=OGw2bgzejZ0/pKY+YJBOEo/yCYl1hCUWpwpV+Az/ALfmThF26yTrDQvA0upwteRS7K
         BhjcsyElNED8tYHFrCSsAnIxl+4RDMxdgcYo/LfArRfk218TjaPGPCoGEKXzUYSjD2T/
         9Kp1lpoElFj0GYT2oAzH3WdF14Ilb0x+Shn99dv3JxxM4q3gcYF3rAmW2YToWvuQSjhq
         It4XtuR8NiL127zU2M884z+E3ud6boaax+6ncmX4dkLgMkT+vZeXnDXsd9K4xdl80q4D
         0XL4HJNS/KfS5sJThRt2Blaw4MiLK44AREjhO5a9DL9wR6EZaP+F79xT+9rU9MfLJ/Cm
         mFcQ==
X-Forwarded-Encrypted: i=1; AJvYcCUOyFSQ+uRHNVtbjTJQFJACY/qWpp1kHTTW/E/dLsfZt20g72nXVbM3innW5Cl4J7qZ0ezzn7oV7y2ffvKTiJ5/QAx88v5roUANSqLg
X-Gm-Message-State: AOJu0YzFxgoaGQ5OkZHOnqfIAlrv/v+oyJ+5GhSmAlQDV7swSHaURa5F
	vw9n5C0OTJPR+ZVUspam1fLVz98QmjBjD2MUVRndpx/ofBLtNbeQKFWjVF+O14x+oTlMHiI7rA4
	=
X-Google-Smtp-Source: AGHT+IEDAuZ746jQsVlJxHcmOv82BqhMpt/e/MpO+zwOqoaDEw9vHSz/yZncpHLSQwz07egVU6VKBQ==
X-Received: by 2002:a05:622a:103:b0:431:2a9d:9429 with SMTP id u3-20020a05622a010300b004312a9d9429mr1709066qtw.2.1711101239943;
        Fri, 22 Mar 2024 02:53:59 -0700 (PDT)
Received: from mail-qv1-f43.google.com (mail-qv1-f43.google.com. [209.85.219.43])
        by smtp.gmail.com with ESMTPSA id br14-20020a05622a1e0e00b0042efe24b76esm723471qtb.58.2024.03.22.02.53.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 02:53:59 -0700 (PDT)
Received: by mail-qv1-f43.google.com with SMTP id 6a1803df08f44-6967312fadaso218246d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:53:58 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWc4YFE1jGiY0GXcvuprbNhFk2TvTv8VwoboWXMgkhySeAMBsTlBsLdVUSbILknMhGLZry2IH+OgAFn+kdvVJCYn3nF3a0QFG3cw4r6
X-Received: by 2002:ad4:5e89:0:b0:696:45f2:a3f4 with SMTP id
 jl9-20020ad45e89000000b0069645f2a3f4mr1891856qvb.63.1711101238442; Fri, 22
 Mar 2024 02:53:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-6-55a89f46f6be@chromium.org> <20240322093522.GN18799@pendragon.ideasonboard.com>
In-Reply-To: <20240322093522.GN18799@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Mar 2024 10:53:42 +0100
X-Gmail-Original-Message-ID: <CANiDSCvZc9CyqkJ5Noz_vzisErVk+dzHW2GUGchQnG2h=d6oTw@mail.gmail.com>
Message-ID: <CANiDSCvZc9CyqkJ5Noz_vzisErVk+dzHW2GUGchQnG2h=d6oTw@mail.gmail.com>
Subject: Re: [PATCH v9 6/6] media: uvcvideo: Fix hw timestamp handling for
 slow FPS
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi

On Fri, 22 Mar 2024 at 10:35, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Wed, Mar 15, 2023 at 02:30:17PM +0100, Ricardo Ribalda wrote:
> > In UVC 1.5 we get a single clock value per frame. With the current
> > buffer size of 32, FPS slowers than 32 might roll-over twice.
> >
> > The current code cannot handle two roll-over and provide invalid
> > timestamps.
> >
> > Revome all the samples from the circular buffer that are more than two
>
> s/Revome/Remove/
>
> > rollovers old, so the algorithm always provides good timestamps.
>
> Wouldn't it be better to support multiple rollovers instead ?

I believe one second is enough to provide a good ramp for the clock
interpolation,
with as little as 1/4 we are getting results good enough to pass CTS.

To support multiple roll-ups we would need to keep track of the
"generation" of every timestamp, and numerical overflows will start to
be an issue....

IMO it is better to fix what we have broken and If we ever need more
accuracy we could add a follow-up patch later.


>
> > Note that we are removing values that are more than one second old,
> > which means that there is enough distance between the two points that
> > we use for the interpolation to provide good values.
> >
> > Tested-by: HungNien Chen <hn.chen@sunplusit.com>
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> >  drivers/media/usb/uvc/uvc_video.c | 24 ++++++++++++++++++++++++
> >  drivers/media/usb/uvc/uvcvideo.h  |  1 +
> >  2 files changed, 25 insertions(+)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > index 1db0d1bc80e6..c58b51207be6 100644
> > --- a/drivers/media/usb/uvc/uvc_video.c
> > +++ b/drivers/media/usb/uvc/uvc_video.c
> > @@ -471,8 +471,31 @@ static void uvc_video_clock_add_sample(struct uvc_clock *clock,
> >  {
> >       unsigned long flags;
> >
> > +     /*
> > +      * If we write new data on the position where we had the last
> > +      * overflow, remove the overflow pointer. There is no overflow
> > +      * on the whole circular buffer.
> > +      */
> > +     if (clock->head == clock->last_sof_overflow)
> > +             clock->last_sof_overflow = -1;
> > +
> >       spin_lock_irqsave(&clock->lock, flags);
> >
> > +     /* Handle overflows */
> > +     if (clock->count > 0 && clock->last_sof > sample->dev_sof) {
> > +             /*
> > +              * Remove data from the circular buffer that is older than the
> > +              * last overflow. We only support one overflow per circular
> > +              * buffer.
> > +              */
> > +             if (clock->last_sof_overflow != -1) {
> > +                     clock->count = (clock->head - clock->last_sof_overflow
> > +                                     + clock->count) % clock->count;
> > +             }
> > +             clock->last_sof_overflow = clock->head;
> > +     }
> > +
> > +     /* Add sample */
> >       memcpy(&clock->samples[clock->head], sample, sizeof(*sample));
> >       clock->head = (clock->head + 1) % clock->size;
> >       clock->count = min(clock->count + 1, clock->size);
> > @@ -605,6 +628,7 @@ static void uvc_video_clock_reset(struct uvc_clock *clock)
> >       clock->head = 0;
> >       clock->count = 0;
> >       clock->last_sof = -1;
> > +     clock->last_sof_overflow = -1;
> >       clock->sof_offset = -1;
> >  }
> >
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 07b2fdb80adf..bf9f5162b833 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -499,6 +499,7 @@ struct uvc_streaming {
> >               unsigned int head;
> >               unsigned int count;
> >               unsigned int size;
> > +             unsigned int last_sof_overflow;
> >
> >               u16 last_sof;
> >               u16 sof_offset;
> >
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

