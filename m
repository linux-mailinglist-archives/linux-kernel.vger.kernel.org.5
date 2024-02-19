Return-Path: <linux-kernel+bounces-71556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E885F85A70B
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 16:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1A85CB24687
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 15:10:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B52C3A1B6;
	Mon, 19 Feb 2024 15:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GifgBcs7"
Received: from mail-qk1-f180.google.com (mail-qk1-f180.google.com [209.85.222.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9FD3381CE
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 15:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708355252; cv=none; b=ZpduBpdIPmEYhxteQsK4fEZpdJhYPZmvHsbis1qt9SLFvhruQuADH4FU06LMmtIhH5AY57Ik+JYM4J7BH0kGEROPshdMYUNNRUk5LLgcYOkRN1lZZONa0Mwc5qLUYGWiokz/PF24IE9Jm9r79tBnBJOIGO+/YbxGqPYdRibeO4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708355252; c=relaxed/simple;
	bh=k3ZpLmugxJI2lN4OSzxdrG3rd3He9lfcuqv7S/sFMB8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AuXne/rZ5mX2FzyEOii9zRmZKXLuuBN7d31ZL0rR/0ShiArUfcpxJaEVecDrK0QDHtih2FItWZjSNXyGga4+un1mQOVR92DpwnptJJ1Wsd6j7/TcG46/cB+4SgceslNlQ+qBfJ4wMAnp8sVEXhVnONNP4awyI3LGb11VwpQpTgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GifgBcs7; arc=none smtp.client-ip=209.85.222.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qk1-f180.google.com with SMTP id af79cd13be357-78684496b10so246498385a.3
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708355249; x=1708960049; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2nL77bInzFplBZ+VWzOztLM8N7iZgudzQjJjsipF2Gk=;
        b=GifgBcs7qGwKeDAWLSORImKFfb7q2wwwcn9banqLZJIxgQOpQ0OWnFSMTWkPqEmdat
         Z1qP5qT7LXv6+N1HOLdthvoXXJkvr8WTkwk0V3M0Qf9H1ByleTL10BzOog92uyDTDUp9
         KvVkfdgSfVCoxal0j22hildODDD5f3T7cO4A4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708355249; x=1708960049;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2nL77bInzFplBZ+VWzOztLM8N7iZgudzQjJjsipF2Gk=;
        b=Mro7yYSbAYpkCEb/DXurqcKO287j9Tey+Q6+ngnHXJ0LCtdxtFvvv9tPB8TnLYBfru
         1v+YQzJWJg3kIfs6JUJJmYqOsSAppIha14vwM0KbfWyr11DGl0zZx4Z001Y51Rk7uQkI
         U5csRW58sTSAPgkUAfHtYLMlz9s9GpZmHd7Dorb0FP88ieNMYzWnUqd+Wdwt1J5IZV2U
         +zlvPgfyHVBwtfh60crOxDrQS+8XJur1SAdDFKQLlE2cSXrnYv+g+SU5IwyekHB+i6kG
         EfuFzZimOS7pChE3ajQmcUHZSaSd67SOEnkyLRhyk6IeUTuYeqeAz6JpalSp0zJwtZYF
         pJwg==
X-Forwarded-Encrypted: i=1; AJvYcCXurxk3S80c5ChrF/lfckESu0v4a1qSPej05AtgL0vcOhQYuNiz/3E1DVmOWNxunfAv1mcdbp+lwCWXfj0uWirj1G0OLoTtJRlvZHkW
X-Gm-Message-State: AOJu0YzBuSYbes1Xc48gwAg362g2IfenJIlWqrTzMVtupNeuJZwxa2QA
	XLWHithIl82XOYoupSUnvSoJUIjc1WLae3JagkSuoo5rDSV8yZDtMMmufIf2CuL2m0HMVc5/2tY
	=
X-Google-Smtp-Source: AGHT+IENjVh6sfVg+0c7/IMqU5h+gXJsOZbHaPxzN1gpOzeF804Fi2aA2zv2vZxnqDKOdfO6WYTNrg==
X-Received: by 2002:a0c:da03:0:b0:68f:2ba6:c885 with SMTP id x3-20020a0cda03000000b0068f2ba6c885mr12324748qvj.48.1708355249575;
        Mon, 19 Feb 2024 07:07:29 -0800 (PST)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id nw8-20020a0562143a0800b006819bb31533sm3308150qvb.99.2024.02.19.07.07.28
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Feb 2024 07:07:28 -0800 (PST)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-68f78705798so3119276d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:07:28 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVUqBN9cXx7zP+5fELVpeltkFm7oc5fHcWv0/CeD4/TbjGLcnPTPktsmSshyoo/u/aegR4z5QZMiaIU0ioON33pkiWF/oRr9DTRkVV1
X-Received: by 2002:a05:6214:62c:b0:68f:611d:9a2b with SMTP id
 a12-20020a056214062c00b0068f611d9a2bmr5361673qvx.63.1708355248348; Mon, 19
 Feb 2024 07:07:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-1-55a89f46f6be@chromium.org>
 <20240212225940.GA19316@pendragon.ideasonboard.com> <CANiDSCuoskaERyyzuLen+ReGHBNnOrFducbWYAvFQ6HfbUCPcg@mail.gmail.com>
 <20240219104046.GB13043@pendragon.ideasonboard.com>
In-Reply-To: <20240219104046.GB13043@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Mon, 19 Feb 2024 16:07:12 +0100
X-Gmail-Original-Message-ID: <CANiDSCsqYHModDZCi2hooDYsFgu+bN_OioBGEJQJuZgdiJO=ug@mail.gmail.com>
Message-ID: <CANiDSCsqYHModDZCi2hooDYsFgu+bN_OioBGEJQJuZgdiJO=ug@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] media: uvcvideo: Fix negative modulus calculation
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Mon, 19 Feb 2024 at 11:40, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Mon, Feb 19, 2024 at 11:28:03AM +0100, Ricardo Ribalda wrote:
> > On Mon, 12 Feb 2024 at 23:59, Laurent Pinchart wrote:
> > > On Wed, Mar 15, 2023 at 02:30:12PM +0100, Ricardo Ribalda wrote:
> > > > If head is 0, last will be addressing the index 0 instead of clock->size
> > > > -1. Luckily clock->head is unsiged, otherwise it would be addressing
> > > > 0xffffffff.
> > >
> > > I'm not following you. In the expression
> > >
> > >         (clock->head - 1) % clock->size
> > >
> > > clock->head is an unsigned int, and 1 as a signed int, so the result of
> > > the subtraction is promoted to an unsigned int. When clock->head is 0, the expression evaluates to
> > >
> > >         0xffffffff % clock->size
> > >
> > > clock->size is a power of two (hardcoded to 32 at the moment), so the
> > > expression evaluates to 31, as intended.
> > >
> > > Am I missing something ?
> >
> > Take a look to: https://godbolt.org/z/xYeqTx6ba
> >
> > The expression only works because the size is a power of two. In this
> > set I am allowing sizes that are not powers of two.
>
> Could you then update the commit message to explain that ?
>
> I'll review the rest of the series this week.
Thanks

Will update with the following text after the review:

The tail of the list lives at the position before the head. This is
mathematically noted as
```
(head-1)  mod size.
```

Unfortunately C, does not have a modulus operator, but a remainder
operator (%).
The reminder operation has a different result than the modulus if
(head -1) is a negative number and size is not a power of two.

Adding size to (head-1) allows the code to run with any value of size.

>
> > > > Nontheless, this is not the intented behaviour and should be fixed.
> > > >
> > > > Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > >  drivers/media/usb/uvc/uvc_video.c | 2 +-
> > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > index d4b023d4de7c..4ff4ab4471fe 100644
> > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > @@ -732,7 +732,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
> > > >               goto done;
> > > >
> > > >       first = &clock->samples[clock->head];
> > > > -     last = &clock->samples[(clock->head - 1) % clock->size];
> > > > +     last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];
> > > >
> > > >       /* First step, PTS to SOF conversion. */
> > > >       delta_stc = buf->pts - (1UL << 31);
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

