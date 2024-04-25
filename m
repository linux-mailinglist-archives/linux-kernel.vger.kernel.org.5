Return-Path: <linux-kernel+bounces-157868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3728C8B179F
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 02:00:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2375285475
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 00:00:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA872B9B7;
	Thu, 25 Apr 2024 00:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="iMjaJ6VT"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA23E139E
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714003238; cv=none; b=ZMzcoAwb8TwR1fEzKzgFID65fBL2C6PwpCVQZzvKx2s0It4OR1HpSEHoRdP0qBIdyOtD+o3iFU8092Rau852qjgsfVWFacBAcsv8AXMZKvl7/DOwdE3cVBv9KBwmKajEC1syUBlhnD02AS8G5LBvwgblLDeBDPACsX43Srv/8bs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714003238; c=relaxed/simple;
	bh=MBEImIE/uf/WSqljiC9XbZNccgouCdO8Skm4a/1yecU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FL6TucjJcrMBJCutl8iUe66FHcRIpDrfx9rfHg//ifogySs6wA+kzBMMPILJzUoaggRcEYpUY8sos2hXuUAq//Ydc9qyv3ioKWVCGSq+qF1+skhRq5SIDLhHmWw/hpWY0wevCtrWZRdLs5sxlIKThkbP/vQHMBRH4vjbKYGEPwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=iMjaJ6VT; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so500997276.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 17:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714003236; x=1714608036; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8amuByFemR4m00/qLVXHYywQQB/OO/nQVwREqVEGLXs=;
        b=iMjaJ6VTO6QzBbOQsShcIZdpJmlk8p0WE6lBOGeIXijjWg21TZNxSSEjouFgrCHR3V
         KdJgCbTU7BhnXmnkWbkwaN+KSWrK4nLLEAmdNaf10GzBKNCayf7g9TzihSAjx6DM2Jg8
         8P6BL08ndLUmnsvJgXsYzAHRr1ysx7eAOlDxM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714003236; x=1714608036;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8amuByFemR4m00/qLVXHYywQQB/OO/nQVwREqVEGLXs=;
        b=GlDWAGpMGPYS5S/rMTwYjHuQwNdscCdWlfBv7mWMztKkRiwsIWC7IDOkGgRu29gdy6
         /Atiz2FNysS5kuBoEA1D49gw7upO1O17ek47WuRUWR5ES0ZzuFr6arpPMitAcU5l1lQH
         wExU9MPtS0mSq8SZ8rMIPUyHMDlqksa2tbDwQzzFQ8k3AhTnZ3KZEvocJ2h7/TzEgVmJ
         g7xFM+YGo5yeVbOp4mw9LIwJIpoL7LsHI/EQs0/aoQz/DrIijv1unVAHqatHsv2dT5/h
         i8z6BYscQKY/7kfPkxh1eq9rruVGcYRw4P0Sluz+ap1vCOemX2bcd5Qlu0sZDflrgGnn
         IYgg==
X-Forwarded-Encrypted: i=1; AJvYcCUeu4DMa0svHe+7+ZYj0CxN4LViBc4L1PFAIAN48crwuqi4iHBmzcZNMosMw7iVdxT/IJc4N7opOps7cm7DrA4+ZeBX+7EPE562qFda
X-Gm-Message-State: AOJu0YzSSXeH3h4XKQ1KGMCe95w9F8Fwd+EXvV84xdMoP1Z7Pax2/nbM
	2hMsLIdL+FRgr78l8BhJSo5X9cv7gJ+3wOyupioiPj5yJ/qHfZv6EnwL208o9fPYjSIluutInOs
	AitbjW/JavYLEHZWuqykEenIb4hXJGSdZhGvc
X-Google-Smtp-Source: AGHT+IH7S3Ay2JrJHBsmbPvnAj1QI5yAXv3Ej/lVdIrjvv1IozZI+l3zW9bj/sSEleLf2fkzcVwUwR3dmow/4Hn/FWc=
X-Received: by 2002:a25:26d2:0:b0:dcf:b5b7:c72 with SMTP id
 m201-20020a2526d2000000b00dcfb5b70c72mr4116337ybm.0.1714003235737; Wed, 24
 Apr 2024 17:00:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424014821.4154159-1-jthies@google.com> <20240424014821.4154159-2-jthies@google.com>
 <CAA8EJpq_DujhwoJ87Cg4gZ4LNdPu4i93EQ0VeKrCJPkeDj9ThQ@mail.gmail.com>
In-Reply-To: <CAA8EJpq_DujhwoJ87Cg4gZ4LNdPu4i93EQ0VeKrCJPkeDj9ThQ@mail.gmail.com>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Wed, 24 Apr 2024 17:00:24 -0700
Message-ID: <CANFp7mVGYhMYXdCGEJQ9GoqB-kpk4UquUWEcvqVnRFMrih+R9Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] usb: typec: ucsi: Fix null deref in trace
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Jameson Thies <jthies@google.com>, heikki.krogerus@linux.intel.com, 
	linux-usb@vger.kernel.org, pmalani@chromium.org, bleung@google.com, 
	andersson@kernel.org, fabrice.gasnier@foss.st.com, gregkh@linuxfoundation.org, 
	hdegoede@redhat.com, neil.armstrong@linaro.org, rajaram.regupathy@intel.com, 
	saranya.gopal@intel.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 23, 2024 at 7:06=E2=80=AFPM Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Wed, 24 Apr 2024 at 04:48, Jameson Thies <jthies@google.com> wrote:
> >
> > From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> >
> > ucsi_register_altmode checks IS_ERR on returned pointer and treats
> > NULL as valid. This results in a null deref when
> > trace_ucsi_register_altmode is called. Return an error from
> > ucsi_register_displayport when it is not supported and register the
> > altmode with typec_port_register_altmode.
> >
> > Reviewed-by: Jameson Thies <jthies@google.com>
> > Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> > ---
> > Changes in V2:
> > - Checks for error response from ucsi_register_displayport when
> > registering DisplayPort alternate mode.
> >
> >  drivers/usb/typec/ucsi/ucsi.c | 3 +++
> >  drivers/usb/typec/ucsi/ucsi.h | 2 +-
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucs=
i.c
> > index cb52e7b0a2c5c..f3b413f94fd28 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.c
> > +++ b/drivers/usb/typec/ucsi/ucsi.c
> > @@ -361,6 +361,9 @@ static int ucsi_register_altmode(struct ucsi_connec=
tor *con,
> >                 switch (desc->svid) {
> >                 case USB_TYPEC_DP_SID:
> >                         alt =3D ucsi_register_displayport(con, override=
, i, desc);
> > +                       if (IS_ERR(alt) && PTR_ERR(alt) =3D=3D -EOPNOTS=
UPP)
>
> This makes it ignore EOPNOTSUPP if it is returned by the non-stub
> implementation. I think the current state is actually better than the
> implementation found in this patch. I'd suggest adding a comment to
> ucsi_register_displayport() stub instead.

So originally on my system, I didn't have the displayport driver
config enabled. My expectation was that the alt-mode would show up but
would not be controllable (like all other alt-modes without drivers).
What ends up happening is that no alt-mode shows up and trying to
enable the trace crashes.

When the displayport support isn't there, I think it should just be
enumerated as a normal, unsupported alt-mode.



>
> > +                               alt =3D typec_port_register_altmode(con=
->port, desc);
> > +
> >                         break;
> >                 case USB_TYPEC_NVIDIA_VLINK_SID:
> >                         if (desc->vdo =3D=3D USB_TYPEC_NVIDIA_VLINK_DBG=
_VDO)
> > diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucs=
i.h
> > index c4d103db9d0f8..c663dce0659ee 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.h
> > +++ b/drivers/usb/typec/ucsi/ucsi.h
> > @@ -496,7 +496,7 @@ ucsi_register_displayport(struct ucsi_connector *co=
n,
> >                           bool override, int offset,
> >                           struct typec_altmode_desc *desc)
> >  {
> > -       return NULL;
> > +       return ERR_PTR(-EOPNOTSUPP);
> >  }
> >
> >  static inline void
> > --
> > 2.44.0.769.g3c40516874-goog
> >
>
>
> --
> With best wishes
> Dmitry

