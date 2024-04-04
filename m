Return-Path: <linux-kernel+bounces-131878-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 302D0898D0D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 19:13:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1D561F23ACC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 17:13:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D58A01CAA2;
	Thu,  4 Apr 2024 17:12:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="EEVemeH5"
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AAE12AAE8
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712250772; cv=none; b=PdLelEnYqzUORmL6zD6n3Dbr8pJxGS1Al5cLvNqlRIVCr51LS5pqrE36Mw9cRa8rANnC3jtQGgN//KimF7zvRZqNyRQo1ZNaeSAWAwkHbDtF/0E176LGEfGnmeuURWTx3pD4q5Y9rVcX7B7Labl3DzvTd8v3VDX+tVl4xs9YO4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712250772; c=relaxed/simple;
	bh=q2vSnLkZdK+cF5cwh1lLcPQrmaY/O+d2loT+u8w1Gjg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mn+C2yLrhuWhEtFUnsoWtJ8jKG8RhjjVtyCT44OMCvxYGH3Ui66tjMsrGWoj9eXAbbqKBf+AGFm0wj/5J2QGEBSmbZMALkZp6n6lQou5hdIC3rodk9OtEJQi3toGcvhtVrPNWwxSmzAHT/lNHWuNWQZQxaYxYhV5BfHtAQLUJz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=EEVemeH5; arc=none smtp.client-ip=209.85.160.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f181.google.com with SMTP id d75a77b69052e-434453346ccso7123521cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1712250769; x=1712855569; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CrvNXh1BQUyZBtc3CRIqLlUYNYDJkZ5+/l+Xgjsutwo=;
        b=EEVemeH50Z3f8Mw5CK6jPAQd2P3yqCaPJ0r9V9EUcDp7SihhCumnebeli42G0B69Fr
         SBk9o0whnPCdnQCtRUYk9ZeJHVXlUjIr+wq//4xN4zcnbNa97zCFLYp8UAm2JphcTohM
         /2DKYMi22TC4aN0r916C+UDYhIc4GaZ+wqhm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712250769; x=1712855569;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CrvNXh1BQUyZBtc3CRIqLlUYNYDJkZ5+/l+Xgjsutwo=;
        b=TYwy7vrZjHeGJrb3oS2ECKZTIDkKgKesnG43WQ3W9rvr83Iig1c3YZlwzyw/TpAB4q
         hNFaFuNwqTgvw3Sq/pFb0apkamW0PtuzH8hq8RR1BViW34PHVp1lm/yALsGsF0G9AylO
         JGi6tPObJSeefUnzn3djDBOuGKX3OBbXjjCEHGwZ160Lqwd3khLVWyfVTNNMAq2/TEZB
         FOgTkdeDgaWNq4q+ozc3ZcjPG3GHlBKPzJlWyNqgOL19oDs4ep9GZ3iWFuGzomb5qUIJ
         HWhkGadZUGf37nAeiiNTkzRn+GFfPjqfs10Rln8E+8O6VOrAiG3GW9RWmwa8DAWFfnrF
         pZ0A==
X-Forwarded-Encrypted: i=1; AJvYcCUZFCLR5RrQ+rkHqz6x4r6uku60KmIXnNAQlx5d7Y+bnsz5MDuRPERs/XaKdyEUP05UqPAGzGSWtsVCn7w/yc1tHYvGj53lbePNj1ec
X-Gm-Message-State: AOJu0YwKtcf47pR5Bw+3n+eFkF5GcYGKQ4VkaLgFeWujDvTfqwjyOlcw
	KliCuxg8HWLuo0LGhi6t5SGQn1g4Tbt6PNJItk5EZNc2fTYl/od2Bk353yz1EkGq0I01MMHUOv/
	eD36K
X-Google-Smtp-Source: AGHT+IHxQ6oC2gc6rcZk3YNSwuAx2gP4tF/4HZtUouOwsxhn8qihlmo0/iffMIzbiAwhntff+hr/3Q==
X-Received: by 2002:ac8:5dd4:0:b0:434:3e7c:ff29 with SMTP id e20-20020ac85dd4000000b004343e7cff29mr320518qtx.8.1712250769370;
        Thu, 04 Apr 2024 10:12:49 -0700 (PDT)
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com. [209.85.219.41])
        by smtp.gmail.com with ESMTPSA id cf10-20020a05622a400a00b004343f36ab58sm2235482qtb.81.2024.04.04.10.12.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Apr 2024 10:12:48 -0700 (PDT)
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-6993bc144a4so1095066d6.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:12:48 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUiRkV1V++69dDtui5H/Io3HPFjjDNV6uzK08tydnX3TaRsU17piY5+agtqBMHCEFeKD3Rp4DLOr4WRlgV32vGV+1D4WQ/C2uRLndXd
X-Received: by 2002:ad4:5949:0:b0:699:39ce:7453 with SMTP id
 eo9-20020ad45949000000b0069939ce7453mr286213qvb.33.1712250767706; Thu, 04 Apr
 2024 10:12:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230501-uvc-align-v1-1-0f713e4b84c3@chromium.org>
 <20240322115606.GA31979@pendragon.ideasonboard.com> <CANiDSCuB0jABPPsoj0RxJ2UbV1UD0i5WwnubySDB0p7LocNJDQ@mail.gmail.com>
 <20240404010414.GF23803@pendragon.ideasonboard.com>
In-Reply-To: <20240404010414.GF23803@pendragon.ideasonboard.com>
From: Ricardo Ribalda <ribalda@chromium.org>
Date: Thu, 4 Apr 2024 19:12:30 +0200
X-Gmail-Original-Message-ID: <CANiDSCtkWtnJT28fzRuo8Tk7U3Z1OyeY0MuM3X26mbUaq9QXAQ@mail.gmail.com>
Message-ID: <CANiDSCtkWtnJT28fzRuo8Tk7U3Z1OyeY0MuM3X26mbUaq9QXAQ@mail.gmail.com>
Subject: Re: [PATCH] media: uvcvideo: Explicit alignment of uvc_frame and uvc_format
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>, linux-media@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Laurent

On Thu, 4 Apr 2024 at 03:04, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Hi Ricardo,
>
> On Fri, Mar 22, 2024 at 03:26:39PM +0100, Ricardo Ribalda wrote:
> > On Fri, 22 Mar 2024 at 12:56, Laurent Pinchart wrote:
> > > On Mon, May 01, 2023 at 04:49:31PM +0200, Ricardo Ribalda wrote:
> > > > Struct uvc_frame and uvc_format are packaged together on
> > > > streaming->formats on a sigle allocation.
> > >
> > > s/sigle/single/
> > >
> > > > This is working fine because both structures have a field with a
> > > > pointer, but it will stop working when the sizeof() of any of those
> > > > structs is not a muliple of the sizeof(void*).
> > > >
> > > > Make that aligment contract explicit.
> > > >
> > > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> > > > ---
> > > > This is better than 3 allocations, and do not have any performance
> > > > penalty.
> > > > ---
> > > >  drivers/media/usb/uvc/uvcvideo.h | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/media/usb/uvc/uvcvideo.h b/drivers/media/usb/uvc/uvcvideo.h
> > > > index 9a596c8d894a..03e8a543c8e6 100644
> > > > --- a/drivers/media/usb/uvc/uvcvideo.h
> > > > +++ b/drivers/media/usb/uvc/uvcvideo.h
> > > > @@ -252,7 +252,7 @@ struct uvc_frame {
> > > >       u8  bFrameIntervalType;
> > > >       u32 dwDefaultFrameInterval;
> > > >       u32 *dwFrameInterval;
> > > > -};
> > > > +} __aligned(sizeof(void *)); /* uvc_frame is packed on streaming->formats. */
> > >
> > > Don't we need u32 alignment here, not void * alignment, given that
> > > uvc_frame is followed by an array of u32 ?
> >
> > Let me make sure that I explain myself :)
> >
> > I made a small program in compiler explorer:
> > https://godbolt.org/z/7s9z8WTsx that shows the error that I want to
> > avoid
> >
> > When we have a structure like this:
> >
> > struct n_foo_bar {
> >    int n;
> >    struct foo *foo;
> >    struct bar *bar;
> > };
> >
> > We expect that *foo and *bar point to memory addresses with the right
> > cpu alignment for each struct. Otherwise accessing foo and bar could
> > be slow or simply not work.
>
> So far, so good.
>
> > In the driver we are doing something like this to allocate the structure:
> >
> > int size
> > struct n_foo_bar *out;
> >
> > size = n*sizeof(struct foo)+n*sizeof(struct bar) +sizeof(struct n_foo_bar);
> > out = malloc(size);
> > if (!out)
> >   return out;
> >
> > out->foo=(void *)(out)+sizeof(struct n_foo_bar);
> > out->bar=(void *)(out->foo)+n*sizeof(struct foo);
> >
> > But that only works if sizeof(struct foo) is a multiple of the
> > alignment required by struct bar.
>
> The real requirement is a bit more complex, it's sizeof(struct n_foo_bar) +
> sizeof(struct foo) that needs to be a multiple of the alignment required
> by struct bar (and even that is simplified, as it assumes that malloc()
> returns a pointer aligned to the requirements of struct bar, which in
> practice should always be the case).
>

struct n_foo_bar, has two pointers: foo and bar. Because of the
padding, Its sizeof has to be a multiple of sizeof(void *).
We only care about the sizeof(foo).

And malloc has to provide an alignment of at least sizeof(void *),
otherwise the implementation is pretty broken :)

for kmalloc the alignment is ARCH_KMALLOC_MINALIGN


> > We are "lucky" now because we have a
> > pointer in each struct and that gives us a void* padding. ... but if
> > we ever remove that pointer from the structure we will be in a bad
> > position.
>
> We have three levels in uvcvideo. The top-level structure (your
> equivalent of n_foo_bar), struct uvc_format, has a pointer to an array
> of struct uvc_frame. The second level, struct uvc_frame, has a pointer
> to an array of u32. All three are then allocated in one go,
> contiguously.
>
> The largest field in uvc_frame is a pointer, so the alignment
> requirement will be fulfilled if struct uvc_format is aligned to
> sizeof(void *). When it comes to struct uvc_frame, however, its size
> needs to be a multiple of sizeof(u32), not of sizeof(void *).

OK, we might save 2 bytes :), at the cost that we cannot reshuffle the
fields in the top-level struct.

>
> Given that the alignment constraints are not intrinsic to these
> structures, I think it would be better to handle them when allocating
> the memory. Something along the line of

This is what I was trying to avoid, but with the __alignof__ macros it
does not look that bad...

Maybe we should just make 3 allocations instead of having our mini
malloc implementation :)

Let me send a v2

Thanks!

>
> diff --git a/drivers/media/usb/uvc/uvc_driver.c b/drivers/media/usb/uvc/uvc_driver.c
> index f33a01dbb329..cbc40d663e4f 100644
> --- a/drivers/media/usb/uvc/uvc_driver.c
> +++ b/drivers/media/usb/uvc/uvc_driver.c
> @@ -687,8 +687,11 @@ static int uvc_parse_streaming(struct uvc_device *dev,
>                 goto error;
>         }
>
> -       size = nformats * sizeof(*format) + nframes * sizeof(*frame)
> +       size = nformats * sizeof(*format);
> +       size = ALIGN(size, __alignof__(*frame)) + nframes * sizeof(*frame);
> +       size = ALIGN(size, __alignof__(*interval))
>              + nintervals * sizeof(*interval);
> +
>         format = kzalloc(size, GFP_KERNEL);
>         if (format == NULL) {
>                 ret = -ENOMEM;
>
> plus a corresponding change when calculating the pointers to the frames
> and intervals just after.
>
> > With the  __aligned(sizeof(void *)); I want to explicitly say:
> >
> > "Ey, this struct is embedded in another struct and they are allocated
> > contiguously"
> >
> > Does it make more sense now?
> >
> > > >
> > > >  struct uvc_format {
> > > >       u8 type;
> > > > @@ -266,7 +266,7 @@ struct uvc_format {
> > > >
> > > >       unsigned int nframes;
> > > >       struct uvc_frame *frame;
> > > > -};
> > > > +} __aligned(sizeof(void *)); /* uvc_format is packed on streaming->formats. */
> > >
> > > Same here, technically we need to ensure that the following uvc_frame
> > > will be aligned. void * alignment will give us that now, but that's not
> > > the actual constraint.
> > >
> > > Wouldn't it be better to handle the alignment constraints explicitly
> > > when allocating the memory ? It's not that uvc_frame and uvc_format have
> > > intrinsic alignment constraints, the constraints are only needed because
> > > of the way memory is allocated.
> > >
> > > >
> > > >  struct uvc_streaming_header {
> > > >       u8 bNumFormats;
> > > >
> > > > ---
> > > > base-commit: 58390c8ce1bddb6c623f62e7ed36383e7fa5c02f
> > > > change-id: 20230501-uvc-align-6ff202b68dab
>
> --
> Regards,
>
> Laurent Pinchart



-- 
Ricardo Ribalda

