Return-Path: <linux-kernel+bounces-154082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 138EE8AD735
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 00:24:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADFDA282A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 22:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1741F932;
	Mon, 22 Apr 2024 22:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nYBixQ6x"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742A11CD37
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713824663; cv=none; b=r6wXumQ3wRKMDIYCi01KyVPi6aXv8R8ycTvAdlKXN5Ga1sKJSzYTykEeeGSiYLvYa64YYt5Gch2+g9is/+hX5tSwbzImOakB2oeyfBW8VvcD02vEu0zQ/ET98qMcdLBFPvh79KXa42lhCPrT56I0XAi4qK5vSzKh/wJCSPou4B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713824663; c=relaxed/simple;
	bh=4H/UTL2tuxVd8OleaGxdWC7iJFGzLA8ApcwZcZO0dBM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eqtxH0fw0U16TBgRx1hlQ54NJDYks7yqu6sxDRXTOTcAJlPKPP3eO0CeQx1t2Azp1F385jwUgLhFYzBOgETCBj9ZKrWdWig6lSVBWaWJaFFXotkZYdjQH9hQEqg3UfPGSvid6E3euw7yK7hNctqsc8UqkmrbxXgEwbQcG4eu/24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nYBixQ6x; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e8bbcbc2b7so36295365ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:24:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713824662; x=1714429462; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=jFXegbvm/zCPgH6ZadPqT1AeUHhGPj/sxwdQgR9pPaY=;
        b=nYBixQ6xzqLYnbCUl5twjOkGR+YfE2MO/AnrVEPG4iAZV0v8i0g9Z7BWUQYiGY9xhf
         38TlPfL+uiDv0ImvoQbKICD6PaNYPOVFIj+3q2OVqsrSZfQ6yRnuOP6ex3lvNuTJNfRS
         6hiIqHxaMI+Bq71hCio9a1H+6XK3gPyIZx0TNdO/iCuT186tWNlV2SvOpNb6uOwBVS/X
         00WoHbbGOd9GPBPr7Y/Gx7/+Dz+GP5Qh8e/4ESyCVl47MV5S1SGA1sQj0E2ytZ7YSffJ
         htTQCyikDyz0xV2EoooYtAO2HhDp5+gLDuNSUMXf2mQKAH1glxVgLUzq71m995Eu8xTA
         gLkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713824662; x=1714429462;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jFXegbvm/zCPgH6ZadPqT1AeUHhGPj/sxwdQgR9pPaY=;
        b=WnK4X6lvX+SWd1WDI/Z2y9vHU1h6lm6W90fQaLNK5EdVCiesruNvpR/vu46CMmHqTH
         AVJpa17UGf3KB/LRdGLfet1dfB0EDE9w9/jifxrJ3GTNcusS3ZlSVF72p+TeC+IY4Cje
         7U6xtKVjz3ECKHzp5MbhoUwC3K7l+8HYWQ0fz7zvReG6m2kmKxU4x0pw3wvHDV9TOXmG
         P4AdUOskV/u9LGDuNiNJihg31HjoW8+6fMxh9JM3dpiqIqMIK/bwVP/lMxm/tuEMVC2p
         3UzRV7wBszunSuqHSQdyeOUfG8L1qlp9o9vGzw1brirlM5+gpdASK1dJaaITe/Dxpb78
         F1fQ==
X-Forwarded-Encrypted: i=1; AJvYcCUDW+PVgAGkfyOGGSafP5MJoRicWsZ5Q4qLpGD4mYmf1xah1UGVamnVkYKvJgDyYS3zig1f5lC/x51pTUvS4K56Z9MWwaUFikbfPfbW
X-Gm-Message-State: AOJu0YyMoIE7aT60xxwld9iigNVjYWOyoM7AD5evJFcTj0G9c3UuQEbp
	4YlZu3gUJW8nXplppWjBMRME/o4Ji7aszFoAApGxDhqLQdhTbMOM9XMYF10cvw==
X-Google-Smtp-Source: AGHT+IGkADdtN1mMLXtaIdn0lPMexO5D2dMsVYyowLWZrS5qQ0efw/GQZfsikN97vSgTP/fv04OVtw==
X-Received: by 2002:a17:903:228a:b0:1e5:b82:2f82 with SMTP id b10-20020a170903228a00b001e50b822f82mr18378767plh.42.1713824661534;
        Mon, 22 Apr 2024 15:24:21 -0700 (PDT)
Received: from google.com (57.92.83.34.bc.googleusercontent.com. [34.83.92.57])
        by smtp.gmail.com with ESMTPSA id f16-20020a170902ce9000b001e78d217fd9sm8647548plg.16.2024.04.22.15.24.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 15:24:20 -0700 (PDT)
Date: Mon, 22 Apr 2024 22:24:17 +0000
From: Carlos Llamas <cmllamas@google.com>
To: Alice Ryhl <aliceryhl@google.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org,
	joel@joelfernandes.org, kernel-team@android.com,
	linux-kernel@vger.kernel.org, maco@android.com, surenb@google.com,
	tkjos@android.com
Subject: Re: [PATCH 2/4] binder: migrate ioctl to new PF_SPAM_DETECTION
Message-ID: <ZibjkV3aweBq4uVB@google.com>
References: <20240417191418.1341988-3-cmllamas@google.com>
 <20240418081222.3871629-1-aliceryhl@google.com>
 <ZiRUcEtIypy1n4Xj@google.com>
 <CAH5fLgi96g-vQY-kzEZtkjgidqLy5dOSyFS=8dTE_QtQcpu4=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH5fLgi96g-vQY-kzEZtkjgidqLy5dOSyFS=8dTE_QtQcpu4=Q@mail.gmail.com>

On Mon, Apr 22, 2024 at 10:52:57AM +0200, Alice Ryhl wrote:
> On Sun, Apr 21, 2024 at 1:49 AM Carlos Llamas <cmllamas@google.com> wrote:
> >
> > On Thu, Apr 18, 2024 at 08:12:22AM +0000, Alice Ryhl wrote:
> > > Carlos Llamas <cmllamas@google.com> writes:
> > > > @@ -5553,7 +5553,8 @@ static long binder_ioctl(struct file *filp, unsigned int cmd, unsigned long arg)
> > > >                     goto err;
> > > >             }
> > > >             binder_inner_proc_lock(proc);
> > > > -           proc->oneway_spam_detection_enabled = (bool)enable;
> > > > +           proc->flags &= ~PF_SPAM_DETECTION;
> > > > +           proc->flags |= enable & PF_SPAM_DETECTION;
> > >
> > > The bitwise and in `enable & PF_SPAM_DETECTION` only works because
> > > PF_SPAM_DETECTION happens to be equal to 1. This seems pretty fragile to
> > > me. Would you be willing to do this instead?
> > >
> > > proc->flags &= ~PF_SPAM_DETECTION;
> > > if (enable)
> > >       proc->flags |= PF_SPAM_DETECTION;
> > >
> >
> > I don't think it is fragile since PF_SPAM_DETECTION is fixed. However,
> > I agree the code is missing context about the flag being bit 0 and your
> > version addresses this problem. So I'll take it for v2, thanks!
> 
> Thanks! By fragile I mean that it could result in future mistakes,
> e.g. somebody could copy this code and use it elsewhere with a
> different bit flag that might not be bit 0.

Oh, I see. Yeah that would be a problem.

> 
> > > Carlos Llamas <cmllamas@google.com> writes:
> > > > -                   if (proc->oneway_spam_detection_enabled &&
> > > > -                              w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
> > > > +                   if (proc->flags & PF_SPAM_DETECTION &&
> > > > +                       w->type == BINDER_WORK_TRANSACTION_ONEWAY_SPAM_SUSPECT)
> > >
> > > Maybe I am just not sufficiently familiar with C, but I had to look up
> > > the operator precedence rules for this one. Could we add parenthesises
> > > around `proc->flags & PF_SPAM_DETECTION`? Or even define a macro for it?
> >
> > I think this is fairly common in C but I can definitly add the extra
> > paranthesis if it helps.
> 
> Yeah, makes sense. Thanks!
> 
> With the mentioned changes, you may add:
> Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Done. Thanks!

