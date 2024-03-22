Return-Path: <linux-kernel+bounces-111608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E85E886E7D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 15:27:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 09249281D1E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 14:27:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86B8247F59;
	Fri, 22 Mar 2024 14:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GEPdN/g0"
Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCCB3F9FD
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 14:26:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711117620; cv=none; b=CiuYVT+IKgISz6nEmqTTexhNtdIL/BuzGZwUp+DXSyUS4rtE9CujHCfmWGT/tOUwcdVpWxJjqXKVjsfYPU2C5QdSeO2fGYH9i+UQR1aJwMiCYDjIpZYcRs1HmDwni+x0zFlUh/2OLGFoWXSwLZ/ylgL+SatPWvhEjB14KTkzTiA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711117620; c=relaxed/simple;
	bh=XKmE4GGCnJAJ2FT1o/SNODogJpU5VPlXFcs/cGXSd1U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ntyj/elbTycp6c8dwbA0N3PlUzvzR5LKEVw4cdWQQMABiepbquPV6mub85/fWL7xgXEKTaxj44wbM6p3BuSeD5GIKWMZtNZfaIoqU7sXna5rUeGz4Dg2J5x+yDTSwJFipdrcAU2DAb2Q1wf2N2ssCh4H4+uaOIrPgPmLdABKsm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=GEPdN/g0; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-430ad286ab8so12841981cf.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1711117616; x=1711722416; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+BtKM6YzSssBOA8wzP4FAf2/h79Yzs7wpPMofYXSEwM=;
        b=GEPdN/g0NjsLmbVSXQ4vYS4oYb7WvwdWv2v28NTmGsR3vGsqivvfDXhD6+RHhSpPWJ
         4W/Eo8C1/B0y7/LSgW5ff9voZfPhsEifzqu8gDIhrZsWy2acsWZ+PdsVKO2YjfJI8owE
         tAVYBH3Ml0Tfw3Its3t56meZzDIZZ1TdNZ/WI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711117616; x=1711722416;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+BtKM6YzSssBOA8wzP4FAf2/h79Yzs7wpPMofYXSEwM=;
        b=oGMRRmjB7/geVbkQwiMAA4+tbqET4KodX+GRCLBpgsCTSoGc4+csS4GpuLk2bqDTZJ
         vMEr2yV2TIHUqyxafSgYbUI1Xrprr0oLPhUOwTGk5dApFTXNH7/XMNrO6We+vdN5j1+c
         Y11FiUi6zcKLIIOceFN6sMDgNa+5W7wkLJyj++OP2BVDHon0+80dBs1QVaxIrxx/5P8B
         RaF7Fa766xeZJdHKuP78bFgQwlZz2zolHzvijYAE30gLd5yFB9JSO+Z93Hd0378vpJ60
         WZxgVkfQZdrhGNDeMupgR8X7owFD9za6caDvuZ1Q/JhI/ISTIDLY1U5PMzA2DtKaWbhF
         ZdNw==
X-Forwarded-Encrypted: i=1; AJvYcCUpCWWddMGyEomT2dBsP0hoA/Xgl2e+j4TMNpqYA2MVwSuEDCI4i0/y5FJxg1ODK1zJk6wOSFlGKtqfLZrlwkxV9d9xlQTrSFrZxLA5
X-Gm-Message-State: AOJu0YwO6RLiysvDC6oUUmiM3muG4YErdW2a6y0Fbm3jmnmRhIA9J/09
	nO/DnwwqB6Z8m4+3Ddamm9OJ4A/P7wPhZqUfc2HBhBeNRWtr4k9TzWpi9WA5XjgnyF8kuBQ7/V8
	=
X-Google-Smtp-Source: AGHT+IGV/if8bYsHKsri54YhpnMH6nCULlTLPkXJqXm2u4ihS/P3YWwt+U7PMfqdSBnPUeSvtAmMBA==
X-Received: by 2002:a05:622a:11d3:b0:431:378d:afa with SMTP id n19-20020a05622a11d300b00431378d0afamr897868qtk.34.1711117616079;
        Fri, 22 Mar 2024 07:26:56 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id bs18-20020ac86f12000000b0042f0504229esm898599qtb.60.2024.03.22.07.26.55
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Mar 2024 07:26:55 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-690cd7f83cdso13147536d6.3
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 07:26:55 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXobhsb7iOFmPrSWF9/YpUQdOnFMXCfYDviNPq2aVvWhc08h5Bey6G2srfm9XCUJuU3qHk0MPwDdZKP4y4AX/ryvGiPXG8N9xf3MdeG
X-Received: by 2002:a05:6214:f01:b0:691:59ad:ff46 with SMTP id
 gw1-20020a0562140f0100b0069159adff46mr3034248qvb.30.1711117615005; Fri, 22
 Mar 2024 07:26:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230501-uvc-align-v1-1-0f713e4b84c3@chromium.org> <20240322115606.GA31979@pendragon.ideasonboard.com>
In-Reply-To: <20240322115606.GA31979@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Fri, 22 Mar 2024 15:26:39 +0100
X-Gmail-Original-Message-ID: <CANiDSCuB0jABPPsoj0RxJ2UbV1UD0i5WwnubySDB0p7LocNJDQ@mail.gmail.com>
Message-ID: <CANiDSCuB0jABPPsoj0RxJ2UbV1UD0i5WwnubySDB0p7LocNJDQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Explicit alignment of uvc_frame and uvc_format
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Fri, 22 Mar 2024 at 12:56, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> Thank you for the patch.
>
> On Mon, May 01, 2023 at 04:49:31PM +0200, Ricardo Ribalda wrote:
> > Struct uvc_frame and uvc_format are packaged together on
> > streaming->formats on a sigle allocation.
>
> s/sigle/single/
>
> >
> > This is working fine because both structures have a field with a
> > pointer, but it will stop working when the sizeof() of any of those
> > structs is not a muliple of the sizeof(void*).
> >
> > Make that aligment contract explicit.
> >
> > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > ---
> > This is better than 3 allocations, and do not have any performance
> > penalty.
> > ---
> >  drivers/media/usb/uvc/uvcvideo.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > index 9a596c8d894a..03e8a543c8e6 100644
> > --- a/drivers/media/usb/uvc/uvcvideo.h
> > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > @@ -252,7 +252,7 @@ struct uvc_frame {
> >       u8  bFrameIntervalType;
> >       u32 dwDefaultFrameInterval;
> >       u32 *dwFrameInterval;
> > -};
> > +} __aligned(sizeof(void *)); /* uvc_frame is packed on streaming->formats. */
>
> Don't we need u32 alignment here, not void * alignment, given that
> uvc_frame is followed by an array of u32 ?

Let me make sure that I explain myself :)

I made a small program in compiler explorer:
https://godbolt.org/z/7s9z8WTsx that shows the error that I want to
avoid

When we have a structure like this:

struct n_foo_bar {
   int n;
   struct foo *foo;
   struct bar *bar;
};

We expect that *foo and *bar point to memory addresses with the right
cpu alignment for each struct. Otherwise accessing foo and bar could
be slow or simply not work.

In the driver we are doing something like this to allocate the structure:

int size
struct n_foo_bar *out;

size = n*sizeof(struct foo)+n*sizeof(struct bar) +sizeof(struct n_foo_bar);
out = malloc(size);
if (!out)
  return out;

out->foo=(void *)(out)+sizeof(struct n_foo_bar);
out->bar=(void *)(out->foo)+n*sizeof(struct foo);

But that only works if sizeof(struct foo) is a multiple of the
alignment required by struct bar. We are "lucky" now because we have a
pointer in each struct and that gives us a void* padding. ... but if
we ever remove that pointer from the structure we will be in a bad
position.

With the  __aligned(sizeof(void *)); I want to explicitly say:

"Ey, this struct is embedded in another struct and they are allocated
contiguously"

Does it make more sense now?

>
> >
> >  struct uvc_format {
> >       u8 type;
> > @@ -266,7 +266,7 @@ struct uvc_format {
> >
> >       unsigned int nframes;
> >       struct uvc_frame *frame;
> > -};
> > +} __aligned(sizeof(void *)); /* uvc_format is packed on streaming->formats. */
>
> Same here, technically we need to ensure that the following uvc_frame
> will be aligned. void * alignment will give us that now, but that's not
> the actual constraint.
>
> Wouldn't it be better to handle the alignment constraints explicitly
> when allocating the memory ? It's not that uvc_frame and uvc_format have
> intrinsic alignment constraints, the constraints are only needed because
> of the way memory is allocated.
>
> >
> >  struct uvc_streaming_header {
> >       u8 bNumFormats;
> >
> > ---
> > base-commit: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
> > change-id: 20230501-uvc-align-6ff202b68dab
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

