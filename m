Return-Path: <linux-kernel+bounces-70798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFFC0859C87
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 08:04:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43F24B218DF
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 07:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1E242033B;
	Mon, 19 Feb 2024 07:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iTZ0R1TQ"
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20D320320
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 07:03:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708326238; cv=none; b=jVZiVJl0Fznhb8H6LE+UioEB3URLsuSKYimkrqU0ciDzNrrGbOYZHWDFMju/enOHjjpcKtD+TH47fQWvj7QkirX0UWxl8YHBTPcU2dHEWl1uz9s8nvE+vUHLBwPkj6YCRFJJjR/NR/2ml9PzHal/tPZWl+gls5A5kCedsMnbRxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708326238; c=relaxed/simple;
	bh=jnk57gCiieofwPwLYmr+wTfZHf9tdNcTYMX0JS5uUUc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tay2IsQYdtnNXgCegHD8ioE9ZjeT5jRqevbKBTsQqh9Oi7YZIWIRLsuCguWHX7Opc8iz8OLxk1QU77rYs604DBrR7Xp70xiLkbZqK62Y9XnOXYR+q78fYbGA0DAVVjEA9ogBeEWn/am+IKL7K/FC+SMLI2kZx2UtV+WbFEBTJR8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iTZ0R1TQ; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-7874a96a0a8so150393585a.1
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 23:03:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708326236; x=1708931036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BP0dtJPdqQuZ/KVSMPsLh0JG4MWEZdheL3lSe0slG5c=;
        b=iTZ0R1TQqy8ljcn0X6PSiOos7uVtUpO277V+HdP6+Z4poelU3bH4owO9bYmlydDCd9
         tgynsoN2CPZqLgoP2nxn2/1JC5OlbuTe8EOlYbzcvmGTmZgds9FvJX5u37hl+0BiVcVE
         oAPLXWZtlaFeut71mV1e9+s4dyZ68dRMP7Uep8+TC/TL/6qBWsWQj2gCSnqbz2jNhfOq
         EE4hdpevCEdUduYn4Qe6d5erp7Dmb0oTLvKcNL5m+Jmu8i2LPireKAVOmw2WWMdBNej5
         8toK2BX8ZLC+QieNOCSz1a+k4/6Z0puEqdmKzr7SpMqAsKaQEFPU2UTCC1FplcZZ48s/
         ACKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708326236; x=1708931036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BP0dtJPdqQuZ/KVSMPsLh0JG4MWEZdheL3lSe0slG5c=;
        b=s911p7ffpJQa9HPkstDBAe+ocTgIVqKjHAgqPSVdQ/nuMkbi7oVI8IbicPpZL0KFcb
         wFULr0Iyb9Ea7/z8jHoEOr1HHMidxsE7n5Ja0DijcJtK8lwFBegKUZ6bDF6DQTDM+GdI
         DKTDpdTj8/g4NO7drQAd5fLY7a6ky5yh67grvwEfKHlZoFQ0P4ULbV6T6rDiVggqioFn
         rP7YJL+hzvHzF2gr0+3AScUTzVKKha7XT2zdNwTnMgYX88+MAruef3TfxBehcnh0FHcV
         OCQ3tX9ic3InqwBmVeoJn8XT5/l6lZJuecMkRHqYFm/pSMDuTaES3dnBrGiD+J6xbWZL
         DMMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXmzYgICFEkHqCjvUPl97Fbw5HZ0SNYB5mQuJ23Esm/CQoHvRm6Ek5TbS7qZSrmfYtsvdToKtWElBzU6Tg6ZighkACJq2xpSCnHqo02
X-Gm-Message-State: AOJu0Yxkl0ot1tnS7w38smBMSLJ2yUjC2+hhjODBnuHFu4MNO8UYhuPi
	XbAyNIAnCmJ9fPC54K4Manlmfp+e0uKOwnj/1AwZv/pt3m0xxD77k/mnKn8omgRKrpmjXAOmJsS
	ufCaShNvvs8qar2DJGfYhXIYE3ys=
X-Google-Smtp-Source: AGHT+IFC5DXOGGgbErS5vNxZkRm4l/bwqJ08oU0c9ApJInOMa7c2fC9oWE+hoZBKwPWEubc3vYF8WyfT6NBk/Rx3eeA=
X-Received: by 2002:a05:620a:414a:b0:787:564d:d94c with SMTP id
 k10-20020a05620a414a00b00787564dd94cmr9283390qko.30.1708326235688; Sun, 18
 Feb 2024 23:03:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215220647.4096-1-mo.c.weber@gmail.com> <8fe8c4bf-5fa3-4bfc-9535-b48df12f80ff@moroto.mountain>
In-Reply-To: <8fe8c4bf-5fa3-4bfc-9535-b48df12f80ff@moroto.mountain>
From: Moritz Christian Weber <mo.c.weber@gmail.com>
Date: Mon, 19 Feb 2024 08:03:44 +0100
Message-ID: <CAMn1LHB_XKNx_9VortrmxAmPrHxY--wp4eyUpg0GzjCjOvjv3A@mail.gmail.com>
Subject: Re: [PATCH] Staging: vc04_services: bcm2835-camera: fixed several
 brace coding style checks
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: florian.fainelli@broadcom.com, linux-staging@lists.linux.dev, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Dan,
thank for highlighting this. I have redone, split and resubmitted the
whole patch yesterday due to the issues Gregs patch bot raised. The
patches build, are checkpatched and also survive a last look. The two
issues that I introduced and which you raised have been not reproduced
in the new submission.

Best regards,
Moritz

On Mon, Feb 19, 2024 at 7:39=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> On Thu, Feb 15, 2024 at 11:06:47PM +0100, Moritz C. Weber wrote:
> > @@ -406,12 +405,11 @@ static void buffer_cb(struct vchiq_mmal_instance =
*instance,
> >           is_capturing(dev)) {
> >               v4l2_dbg(1, bcm2835_v4l2_debug, &dev->v4l2_dev,
> >                        "Grab another frame as buffer has EOS");
> > -             vchiq_mmal_port_parameter_set(
> > -                     instance,
> > -                     dev->capture.camera_port,
> > -                     MMAL_PARAMETER_CAPTURE,
> > -                     &dev->capture.frame_count,
> > -                     sizeof(dev->capture.frame_count));
> > +             vchiq_mmal_port_parameter_set(instance,
> > +                                           dev->capture.camera_port,
> > +                                           MMAL_PARAMETER_CAPTURE,
> > +                                           #N(#O(#O(#O(#O(&dev->captur=
e.frame_count,
>                                               ^^^^^^^^^^^^^^^^
>
> Wut?
>
> > +                                           sizeof(dev->capture.frame_c=
ount));
> >       }
> >  }
> >
> > @@ -420,11 +418,11 @@ static int enable_camera(struct bcm2835_mmal_dev =
*dev)
> >       int ret;
> >
> >       if (!dev->camera_use_count) {
> > -             ret =3D vchiq_mmal_port_parameter_set(
> > -                     dev->instance,
> > -                     &dev->component[COMP_CAMERA]->control,
> > -                     MMAL_PARAMETER_CAMERA_NUM, &dev->camera_num,
> > -                     sizeof(dev->camera_num));
> > +             ret =3D vchiq_mmal_port_parameter_set(dev->instance,
> > +                                                 &dev->component[COMP_=
CAMERA]->control,
> > +                                                 MMAL_PARAMETER_CAMERA=
_NUM,
> > +                                                 &dev->camera_num,
> > +                                                 **sizeof(dev->camera_=
num));
>
> Also Wut???
>
>
> regards,
> dan carpenter
>

