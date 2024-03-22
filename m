Return-Path: <linux-kernel+bounces-111217-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 577C6886947
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 10:31:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 777F41C24030
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 09:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B210720B3D;
	Fri, 22 Mar 2024 09:29:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gDBBgBJY"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26A3F8FB
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711099762; cv=none; b=P7kqXisUdKoQ3B6tv9mhDmALbmIVAxiBY+RtrXpY2HgtmwWSo3LIYX5opPfiisGjJ5lztNhieo7UwbIwFIAsATDLwhAuBTudkUnMn1PkqyOP0rTLlh9kSvtP6289Q7JO8RdG71d20Y5BR9teVb98V3IaWIILXIuP+ITF4y8CaoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711099762; c=relaxed/simple;
	bh=jMhYX92bX0+vMk1M5ZgqlQ2n3cIBs+In3AcE7fbzqBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cu0olhOKXI/h8zOuwgOSkU2GuepIp1NXhG33bplQ0A3LVyt15HzEYuNcgG8Dyww2WvaeENERw0zCrC1zDmpsBQz+p5hRZZdNdf6svvV+F6X8ffY3SToJ+TICbmhbjn8b36oe+rmI2hbBhR6n9Pz9ShVb+r71vuGPGSkr5FO9Kh0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gDBBgBJY; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4d44e2e9f13so703474e0c.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711099760; x=1711704560; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=nZvtGqTa73gh7kUTMmd8F/7eYyLnJTG6tNdg5WPt/L0=;
        b=gDBBgBJYMWQ5sakGObJ2dQ+Qx5i78r3rPttBxFvVJ6fI8cZBbZuH7rWtRgQFCL6Ldu
         xIb0bY6k8u0JqyxAF8eSgsBGUq1Wg1YuAjVE+61jLa7Icv6Dn7pareISIW4UnSrMrsMh
         kdptw5E4ww35Ie3hZdzzQ0Nu+dq3gC0BESyFo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711099760; x=1711704560;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nZvtGqTa73gh7kUTMmd8F/7eYyLnJTG6tNdg5WPt/L0=;
        b=rxouLRpROtdv2w1iNJDah3ThQyt8DtLDAa0GHq6lUK+DIMJ3pB4fuU1E/nTa4hauoa
         VV78dX/q3X6k2hneIoyNvQKZRRy6bav8b7xBPpsbND+GBMYeoEw4sa6gl5/ewD+VAl63
         t1H+J72geWi5eS5ezCHHtrBHgye0xMgnizPsEbD/zXfpmTRDoh1hdNe1ucMn0mCRDc5z
         YMyCH7irdUaRTBbq24WcU6yPU589yDubjiaO7ORYcJ0Dz3UArBuay8jxcCtotZQTMdz0
         xIXOn1alNRiuyaRdFkMLO6QEJrEgY23D/RjdVvlUlFnC6vsgLRTS6mpmLfCXILegaKvh
         MnHw==
X-Forwarded-Encrypted: i=1; AJvYcCW1XxK6Jzkb1ckDvIcnGyTJce7qIwh952UH8+NKacP7TlbAW3kKgNFH//CGHXdDjZ+FBuvKzjMyJUHdK0X/9Om20F/k9OBruPzS3zAY
X-Gm-Message-State: AOJu0YzJV2azlvKRy2I2/cDGWzvM7MgYrdZOeaTigQmXySbjM9Jsn2ki
	L/h0ZZRYvZi21u8yx+dXFTtzwoIeU/kARyj3Dt4FjmLjNRJDJx4ftU41Ig8SbepfeCjxMGvW15E
	=
X-Google-Smtp-Source: AGHT+IHc1mm92JW8u5JyPQqAGiGIgzsaGLuK4u4tU8fNfcEtbzDKS9dhrP9uIXf1umuS3cqXOFBw4g==
X-Received: by 2002:a05:6122:4113:b0:4d4:19e9:db0 with SMTP id ce19-20020a056122411300b004d419e90db0mr1898816vkb.0.1711099759617;
        Fri, 22 Mar 2024 02:29:19 -0700 (PDT)
Received: from mail-ua1-f41.google.com (mail-ua1-f41.google.com. [209.85.222.41])
        by smtp.gmail.com with ESMTPSA id a5-20020a056122012500b004d41b9843e6sm242984vko.12.2024.03.22.02.29.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 02:29:19 -0700 (PDT)
Received: by mail-ua1-f41.google.com with SMTP id a1e0cc1a2514c-7de446125f7so656426241.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 02:29:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCVK4pd8XrsIS2gukxHLz6Rf2atA3rdA6Dyr4cg0XfENw7rjeFcj/jG4jPvaoTsmvpImE/4kdFPTaYeGmSWWr/aO4Cn9Ql0YoquFmaTt
X-Received: by 2002:a1f:140b:0:b0:4d8:770f:65a7 with SMTP id
 11-20020a1f140b000000b004d8770f65a7mr185723vku.9.1711099758263; Fri, 22 Mar
 2024 02:29:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20220920-resend-hwtimestamp-v9-0-55a89f46f6be@chromium.org>
 <20220920-resend-hwtimestamp-v9-1-55a89f46f6be@chromium.org>
 <20240212225940.GA19316@pendragon.ideasonboard.com> <CANiDSCuoskaERyyzuLen+ReGHBNnOrFducbWYAvFQ6HfbUCPcg@mail.gmail.com>
 <20240219104046.GB13043@pendragon.ideasonboard.com> <CANiDSCsqYHModDZCi2hooDYsFgu+bN_OioBGEJQJuZgdiJO=ug@mail.gmail.com>
 <20240321215047.GA20938@pendragon.ideasonboard.com> <20240322091948.GA10059@pendragon.ideasonboard.com>
In-Reply-To: <20240322091948.GA10059@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Mar 2024 10:29:03 +0100
X-Gmail-Original-Message-ID: <CANiDSCuxytDTC73Ni51h9v7yCZ46D5489fvt0Hy0ugcm=jcKRQ@mail.gmail.com>
Message-ID: <CANiDSCuxytDTC73Ni51h9v7yCZ46D5489fvt0Hy0ugcm=jcKRQ@mail.gmail.com>
Subject: Re: [PATCH v9 1/6] media: uvcvideo: Fix negative modulus calculation
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	linux-kernel@vger.kernel.org, "hn.chen" <hn.chen@sunplusit.com>, 
	linux-media@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Fri, 22 Mar 2024 at 10:19, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> On Thu, Mar 21, 2024 at 11:50:48PM +0200, Laurent Pinchart wrote:
> > On Mon, Feb 19, 2024 at 04:07:12PM +0100, Ricardo Ribalda wrote:
> > > On Mon, 19 Feb 2024 at 11:40, Laurent Pinchart wrote:
> > > > On Mon, Feb 19, 2024 at 11:28:03AM +0100, Ricardo Ribalda wrote:
> > > > > On Mon, 12 Feb 2024 at 23:59, Laurent Pinchart wrote:
> > > > > > On Wed, Mar 15, 2023 at 02:30:12PM +0100, Ricardo Ribalda wrote:
> > > > > > > If head is 0, last will be addressing the index 0 instead of clock->size
> > > > > > > -1. Luckily clock->head is unsiged, otherwise it would be addressing
> > > > > > > 0xffffffff.
> > > > > >
> > > > > > I'm not following you. In the expression
> > > > > >
> > > > > >         (clock->head - 1) % clock->size
> > > > > >
> > > > > > clock->head is an unsigned int, and 1 as a signed int, so the result of
> > > > > > the subtraction is promoted to an unsigned int. When clock->head is 0, the expression evaluates to
> > > > > >
> > > > > >         0xffffffff % clock->size
> > > > > >
> > > > > > clock->size is a power of two (hardcoded to 32 at the moment), so the
> > > > > > expression evaluates to 31, as intended.
> > > > > >
> > > > > > Am I missing something ?
> > > > >
> > > > > Take a look to: https://godbolt.org/z/xYeqTx6ba
> > > > >
> > > > > The expression only works because the size is a power of two. In this
> > > > > set I am allowing sizes that are not powers of two.
> > > >
> > > > Could you then update the commit message to explain that ?
> > > >
> > > > I'll review the rest of the series this week.
> > > Thanks
> > >
> > > Will update with the following text after the review:
> > >
> > > The tail of the list lives at the position before the head. This is
> > > mathematically noted as
> > > ```
> > > (head-1)  mod size.
> > > ```
> > >
> > > Unfortunately C, does not have a modulus operator, but a remainder
> > > operator (%).
> > > The reminder operation has a different result than the modulus if
> > > (head -1) is a negative number and size is not a power of two.
> > >
> > > Adding size to (head-1) allows the code to run with any value of size.
> >
> > Could you please add
> >
> > This does not change the current behaviour of the driver, as the size is
> > always a power of two, but prepares for reworks that will change the
> > size to a non power of two.
> >
> > or something similar ?
> >
> > > > > > > Nontheless, this is not the intented behaviour and should be fixed.
> > > > > > >
> > > > > > > Fixes: 66847ef013cc ("[media] uvcvideo: Add UVC timestamps support")
> >
> > I think this should be dropped, the patch doesn't fix an issue, but
> > prepares for further changes that add new features. I'd also like to
> > update the commit message to avoid stating "Fix", to avoid this being
> > picked for stable kernels automatically.
>
> After reviewing the whole series, it seems that clock->size stays at its
> current value of 32. Do we thus need this patch ?

I remember that at some point, when I changed the size, it had been
really painful to figure out why the code was not working.

I'd rather keep this patch with a different commit message.

"""
This does not change the current behaviour of the driver, as the size is
always a power of two, but avoid tedious debugging if we ever change its size.
"""

WDYT?


>
> > > > > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > > > > ---
> > > > > > >  drivers/media/usb/uvc/uvc_video.c | 2 +-
> > > > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > > >
> > > > > > > diff --git a/drivers/media/usb/uvc/uvc_video.c b/drivers/media/usb/uvc/uvc_video.c
> > > > > > > index d4b023d4de7c..4ff4ab4471fe 100644
> > > > > > > --- a/drivers/media/usb/uvc/uvc_video.c
> > > > > > > +++ b/drivers/media/usb/uvc/uvc_video.c
> > > > > > > @@ -732,7 +732,7 @@ void uvc_video_clock_update(struct uvc_streaming *stream,
> > > > > > >               goto done;
> > > > > > >
> > > > > > >       first = &clock->samples[clock->head];
> > > > > > > -     last = &clock->samples[(clock->head - 1) % clock->size];
> > > > > > > +     last = &clock->samples[(clock->head - 1 + clock->size) % clock->size];
> > > > > > >
> > > > > > >       /* First step, PTS to SOF conversion. */
> > > > > > >       delta_stc = buf->pts - (1UL << 31);
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

