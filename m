Return-Path: <linux-kernel+bounces-39456-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF33F83D169
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 01:22:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0DA211C24DF6
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 00:22:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3210816;
	Fri, 26 Jan 2024 00:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RmvsWzwh"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F557E2
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706228521; cv=none; b=qNLBW12uKBv3QujNxJsAcQZK88Ch84L/lBReyEG6znT8Xq4eJwEOnuznSSWzsQV50eZ607lkO98aHTfErtfU0GuyjKQ1T9K21RwGOSw1oT3g7bfSviiG3XeXC3bh1e/z8hmBV0wJKJ2JvCRX7nrVGmfICX+w81Tq1lBtVgV4qeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706228521; c=relaxed/simple;
	bh=QrCvh2bDVmQVhbZy1e0kGFeRP9qJbI85tKvDb1mTQrg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WGzdZfkSQTqSBD1/sc+QUOvWq2HyvfkHUyP9ha6chnvj5s8NZIUZ/uluCstaTyyToagejq8Fg6b6OXe5ekWie49Z7qgOxTPTE83rzSGnekrnBXMbg/KvJ2fCUxpJpg4S4FJp2pokKqN1XOarhF0UTPgdMPZQbHb3IrKRJ1NMiKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RmvsWzwh; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc2308fe275so6383545276.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 16:21:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706228519; x=1706833319; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XrbGD9nhu09VbWmra4xDpvbma+oaLmacGCLBgklrSUo=;
        b=RmvsWzwhavUjq1AC+FKseIM5zk/ELvLlcuFnO/zFX043ilLWONPaoLLPF2FG3ZA+P1
         C5CZartLiVid1Te52NhZAz3PI1q8y8SZOcoBaCeq3AVSMdxemXZVeqHcKts7uEUv40lO
         AfnCFYxAUwxct+7kiH8QjMfR+kyDS0f2zlwX0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706228519; x=1706833319;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XrbGD9nhu09VbWmra4xDpvbma+oaLmacGCLBgklrSUo=;
        b=KcFTzeQjLHO98c4nm0je7Kgbb54irQCjYWS8lcymbo8X1qtPA4ccsVruCsh2yxZ64l
         ag/5VlBufW1qFO5i1N0DtvnmsuavxpqeQG1tVYYn6dHVImH/iM16qJ/2YM9uYA4qSW6Y
         ul3BjeK4SsugM9OGFka3uHqzJd2/j0zMpmrm/fmMFN5LzMOYF/f1qHWis12Dy31+oeA5
         BMSUftgC3al3dIabiG1K/77xmrHXrmkju3iBisCIlN+VZIKX3RSWScHDPjZXFDIqHn9B
         Pwj83KecsvkpVS0MvemmUz5aMWZJBZ1jJu0Ivxt4Z3h82jFRYnHCAcJOX41oRrJtYlyr
         aV3A==
X-Gm-Message-State: AOJu0YzzTKXY+daYC/Hft1fKMaobnMi306c06pxxd3/jOxnN8BYnncR/
	/yRWpSfuE50mUgVCvO4Pdqwi/VRYPmfAkgTSk/ikBI1qX9iPBaZCIUEdn9+4AeCE82dDG3W1B4R
	IEQQFdNhwawt3A7rJ385qrBexU184BTS2c1XI
X-Google-Smtp-Source: AGHT+IEfeg2FKKJuV9m6qG4eLrGvQu+qOTRhRFjoZLik4/bWQ3prpv89FI6li2fQntezwSxka1dOBpSSL+KAcu9h9K8=
X-Received: by 2002:a25:f911:0:b0:dbf:67f0:efc5 with SMTP id
 q17-20020a25f911000000b00dbf67f0efc5mr518538ybe.119.1706228518825; Thu, 25
 Jan 2024 16:21:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125004456.575891-1-abhishekpandit@google.com>
 <20240124164443.v2.2.I3d909e3c9a200621e3034686f068a3307945fd87@changeid> <2024012512-haphazard-mobster-f566@gregkh>
In-Reply-To: <2024012512-haphazard-mobster-f566@gregkh>
From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
Date: Thu, 25 Jan 2024 16:21:47 -0800
Message-ID: <CANFp7mWzA5df9iFpCWFRpXuOP06yDmBehYDYNACjrW2fPvp_Ow@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] usb: typec: ucsi: Update connector cap and status
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Abhishek Pandit-Subedi <abhishekpandit@google.com>, 
	Heikki Krogerus <heikki.krogerus@linux.intel.com>, linux-usb@vger.kernel.org, 
	jthies@google.com, pmalani@chromium.org, 
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>, Neil Armstrong <neil.armstrong@linaro.org>, 
	Rajaram Regupathy <rajaram.regupathy@intel.com>, Saranya Gopal <saranya.gopal@intel.com>, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 3:03=E2=80=AFPM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
>
> On Wed, Jan 24, 2024 at 04:44:53PM -0800, Abhishek Pandit-Subedi wrote:
> > diff --git a/drivers/usb/typec/ucsi/ucsi.h b/drivers/usb/typec/ucsi/ucs=
i.h
> > index bec920fa6b8a..94b373378f63 100644
> > --- a/drivers/usb/typec/ucsi/ucsi.h
> > +++ b/drivers/usb/typec/ucsi/ucsi.h
> > @@ -3,6 +3,7 @@
> >  #ifndef __DRIVER_USB_TYPEC_UCSI_H
> >  #define __DRIVER_USB_TYPEC_UCSI_H
> >
> > +#include <asm-generic/unaligned.h>
>
> Do you really need to include a asm/ include file?  This feels very
> wrong.

I didn't see any header in include/linux that already had these
unaligned access functions so I opted to include
asm-generic/unaligned.h. Is there a reason not to use an asm/ include
file?

>
> It's also in the wrong place, AND why "asm-generic"?  That also feels
> wrong.

asm-generic is definitely wrong; I misunderstood how these headers are
supposed to be used (should be just asm/unaligned.h).
For ordering, I took a look at some other files and it looks like
<asm/...> goes below the <linux/...> includes. This also probably
deserves documenting in the style guide.

>
> thanks,
>
> greg k-h

