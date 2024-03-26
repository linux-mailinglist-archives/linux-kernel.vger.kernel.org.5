Return-Path: <linux-kernel+bounces-118575-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB1D188BCCA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 09:50:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECD321C343F4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 08:50:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA34E182B9;
	Tue, 26 Mar 2024 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y0f6r7tz"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A2741D696
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 08:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711443012; cv=none; b=AXEapwtoLM8YBxrRV13wESZEf943SrajJaP9ogXZO45v8yrkyJGrFMC2Q24n0alicw/jyqcMIIgY9fw4AmAVyuyDe62KIlCytOWZ3JqCq/yGWq3/kUOf71IHRna2zZZzQX1EYhI3AmUW8L4toT0BAHI53O+Ag3GrKLaUx8CuAKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711443012; c=relaxed/simple;
	bh=k/3BTC2/MjXvCIvTQq98EM6QtHwdBLO7nWv/TVfz+GQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mW688tQsMoikKhBZe5pmV5Mg1H20RXgaumwyuCzUgALrslabyyxGB3XEfYl/pzQPc5KmlHeovfBtFpKqg8HGnv38p88/qy/bLcjnBbB+4/kpX73fjqpOiYhesTRV1uqKNQTveRq/cvIXWTQXCJhKZT+fEBxDIlhbbixBCG3DCw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Y0f6r7tz; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-430c76fbf05so33207891cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:50:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711443009; x=1712047809; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=z3pBKOTW270Vha3g5EEZPuJtAMCR1sK7GVofzSa+F8c=;
        b=Y0f6r7tz5dXR6NKQIMBCP15LMoPv2sc357RwNbuQhEyP2cI9nR1M2R8LjTWz8+3DDI
         HgoQqXCq/bmZje8iMFmDBgSE1zSEjgnaowyVsne8DlZwrgHcfSwI1wSDeCndgIAFshwl
         9fG2+HhoeEcfAWoJ4aj6zCoTbvQyoUU2comas=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711443009; x=1712047809;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z3pBKOTW270Vha3g5EEZPuJtAMCR1sK7GVofzSa+F8c=;
        b=gI6CFZ71wap3nLvvPmKEx0X5xZLbS3nB/Mc0CIQpW1YSaVvrrZ5y7k/SO8SWjFTlIc
         DcPXmBGAj2oliwHWpCpeGQl/jBNXW7OzdSsekwt2O+qfj0GyPf7nVWE8kT3SFnNF8sD0
         58dwdAsCT5Z4jPvXZMuqq3/cZiFg1og99AbjhLen1XPbATjadvvAdeqyquwMvwSx+iaX
         uFA3MpG+IFddhsokWm1qqMn26t/WNjiqh9+FPjH60Mh4Aq0savi1PWQGStD6hy9MKc86
         xALTehvYt3bjnXWWeoyNGJ2ad4b/f0oW/tt/8XrN3W9b4phl8oiHLiN10GQZ8e08ueFo
         go/g==
X-Forwarded-Encrypted: i=1; AJvYcCX5r+ts06W3ob14xg+Hw4MjaNulaRpyJJPCUPyBYy9DrJ8MkEi4oFO8YNOWpEQJIo3W5QhgoY6Nf3D8j0cfmVJKVQHrere12XDd0l3n
X-Gm-Message-State: AOJu0YyHnR8Q6jIJauonYBOBwD72pfyJ7LoPkN+KE6Vt0240VU/tXQC2
	uGLkI0QNIz7Igr1SNwBeB6vaLbmGglzpNupElxmFDOcPl26DWjhzNqeH5qfkDPZtuDvkBJB+036
	qEA==
X-Google-Smtp-Source: AGHT+IH/tfynzB+6dEDjaXkoecOrY7yFYhycloTisuLN6seFmzEqkFbow5JYDpg/hQ33GuMdMN7iVQ==
X-Received: by 2002:ac8:7d84:0:b0:431:481e:fc81 with SMTP id c4-20020ac87d84000000b00431481efc81mr8983465qtd.12.1711443009695;
        Tue, 26 Mar 2024 01:50:09 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id z9-20020ac875c9000000b00430c76f0c86sm3439778qtq.80.2024.03.26.01.50.09
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 01:50:09 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-696719f8dfcso23337556d6.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 01:50:09 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCV4PH6AKjhPwzTQVVonrVvDVfwLyKBCEzDkfXfjgToM+Q2qh8Oq51VI66Y8YW06bkCMVIHKlyKq13fjzsDhxSM+JptyGB/XFdgI6IfD
X-Received: by 2002:ad4:5e8f:0:b0:696:306f:7a54 with SMTP id
 jl15-20020ad45e8f000000b00696306f7a54mr10615890qvb.48.1711443008808; Tue, 26
 Mar 2024 01:50:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240325-guenter-mini-v3-0-c4bc61d84e03@chromium.org>
 <20240325-guenter-mini-v3-2-c4bc61d84e03@chromium.org> <20240326084217.GB1041856@google.com>
In-Reply-To: <20240326084217.GB1041856@google.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Tue, 26 Mar 2024 09:49:52 +0100
X-Gmail-Original-Message-ID: <CANiDSCuc2AKqhAXBq6tmxZ0oK2WamuSOwJJ4qFBrJ56w8_9JKA@mail.gmail.com>
Message-ID: <CANiDSCuc2AKqhAXBq6tmxZ0oK2WamuSOwJJ4qFBrJ56w8_9JKA@mail.gmail.com>
Subject: Re: [PATCH v3 2/3] media: uvcvideo: Refactor the status irq API
To: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, Guenter Roeck <linux@roeck-us.net>, 
	Max Staudt <mstaudt@chromium.org>, Tomasz Figa <tfiga@chromium.org>, 
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Alan Stern <stern@rowland.harvard.edu>, 
	Hans Verkuil <hverkuil-cisco@xs4all.nl>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Sean Paul <seanpaul@chromium.org>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>
Content-Type: text/plain; charset="UTF-8"

Hi Sergey

On Tue, 26 Mar 2024 at 09:42, Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (24/03/25 16:31), Ricardo Ribalda wrote:
> >  drivers/media/usb/uvc/uvc_driver.c | 13 ++-------
> >  drivers/media/usb/uvc/uvc_status.c | 57 ++++++++++++++++++++++++++++++++++++--
> >  drivers/media/usb/uvc/uvc_v4l2.c   | 22 ++++-----------
> >  drivers/media/usb/uvc/uvcvideo.h   | 10 ++++---
> >  4 files changed, 68 insertions(+), 34 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> > index 17fc945c8deb6..b579644ac0745 100644
> > --- a/drivers/media/usb/uvc/uvc_driver.c
> > +++ b/drivers/media/usb/uvc/uvc_driver.c
> > @@ -2116,7 +2116,6 @@ static int uvc_probe(struct usb_interface *intf,
> >       INIT_LIST_HEAD(&dev->streams);
> >       kref_init(&dev->ref);
> >       atomic_set(&dev->nmappings, 0);
> > -     mutex_init(&dev->lock);
>
> Where is this getting initialized?

in uvc_status_init((). It is now called status_lock

But it should be init before  (ep == NULL)... otherwise it will not
work in devices without the int_ep.

Let me send a new version

Thanks!




--
Ricardo Ribalda

