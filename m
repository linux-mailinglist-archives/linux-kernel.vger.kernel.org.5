Return-Path: <linux-kernel+bounces-153033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5515C8AC81E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 10:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 11547280404
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 08:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C40B54BD6;
	Mon, 22 Apr 2024 08:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wWCDV8Jc"
Received: from mail-yb1-f181.google.com (mail-yb1-f181.google.com [209.85.219.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E115453380
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713775991; cv=none; b=Su1jt8+cHUsxqqAVvKBKf1XZ7WEnWbPcgO955tdxwRySAZDqfkHnlZZ57w/ZcWZrM/D7nvYhKjZy1PgSx6Emo+N6EZxNyrfDxawxm+Gj/opRbrJn+SU5OZdXXm/hP6Nby5pBf7LOuL+garMvUoOxdxnrLX0G58pBEno4KLaVKx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713775991; c=relaxed/simple;
	bh=tc1YFCLIzw0cQqXheGK0vA+hR2mqFn4ZzGTZtzlGTrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IrN1MDDkVp5hmg45YYWIEbCABEXm2Yg7lZS2Jd8E9RZMQbSTdeRjkfs0wDRDn7Bu5xsEbIxcUXtVZNxR9eC/SJ3CDe4zroOu6gVEJx7azJ07naEWtFLZnUYLgtjRnMjv1EjIjGLsAL+BWex/rxFsvEyHcO/xOoSr85QLk6opvHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wWCDV8Jc; arc=none smtp.client-ip=209.85.219.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f181.google.com with SMTP id 3f1490d57ef6-de45e596a05so4484386276.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 01:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713775989; x=1714380789; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lN1tQRzEerHdmzjmn4cRyuYt4HVRT1txxhBtvZ2kMiw=;
        b=wWCDV8JcRqRQXy58ydxUZI5DGVuxK2hrwAh0UYWX9rNOTiEHR/MtDupsJEhNs7lwMt
         v/CUUWqcB3E24L7sj/d+tnuQWmAw67Wi8HzMtnuussxaScpcrg0er041ylHzkrNW6RcM
         VCcw/tJwrWncslc1r380a+1280uhDCoo0i1g9NiOqy69qkbxRckGLJCqskt2S8mwYJy3
         CW+gVVkrprtJcHYEzHqk2e41EIxBTfBnlnLT8KSLM2ZbnF9fYH1d12lA057GgicIL2lS
         c6P3cLOs8GxuF0SFMRMIFelzw/wJnneeb2Dms1pUiZwJxyOYWs5VtvqGt8xn/f7I6uoI
         P8Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713775989; x=1714380789;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lN1tQRzEerHdmzjmn4cRyuYt4HVRT1txxhBtvZ2kMiw=;
        b=plNjc/P4+Wg/0XgycX/StgUU6RBwSfxBlj9XBKY2qfgoImXM4FKaPg6WQgrOz+lsCG
         s75vlKZInEzcTn2LYiGpvw0IpqDKD9yBVdZeW3CmLHILHszT5+JjsnbPA5ebX3RUGil8
         FMQJETaZLywAvj6MTm+otKI9Ea2muqYkBtoR9DbmNYHbG+JSTKPafIliMYlgxphJnjxY
         eMfD436RBzhI7MHokshwHfpaKinJ5lGIEC5TL7I0pqyIBPbJ4+ioS60AirNDrvNMAl7d
         8qRSxoLMIOR96mn/LQmcx0/Z6533odnIAlqz5GjMQ3s9LszNJSFJNdyluNviaoQiCrM8
         NHiw==
X-Forwarded-Encrypted: i=1; AJvYcCV3RHcod5LkGsoAE/IBfZ8AnXLcPIr/7GP/sWcCMZEEUIt0ShdYM9zpIUMPsJsc3PeLOVmN9E7LmzdgP4mfeUoqylB1RGgzBexSiO69
X-Gm-Message-State: AOJu0YypJwHCJ+0xBJCTAVkywYa3YiHXPpNura7emeRtHEXVucvlKqV1
	Uq/yUv2xDVQka7431hsGS5oCTCMR589IqZnKT542iQDofSs+sP8Fb+sTMbPbodYH8KuGRmrmcJd
	x3/gbaaXTw06ss1xXdSfAQyUHHgCdUdQMJMZJ
X-Google-Smtp-Source: AGHT+IHiWq6aKJVjmRYs6eoqRfnvo8yT5HLI3JcYkmFYWskHKOoqRZww/Gi0ZWtCrvhIddoIB2UxLZSS6zfATaWX3Xc=
X-Received: by 2002:a25:c789:0:b0:dc7:32ea:c89f with SMTP id
 w131-20020a25c789000000b00dc732eac89fmr8266839ybe.15.1713775988625; Mon, 22
 Apr 2024 01:53:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240417191418.1341988-3-cmllamas@google.com> <20240418081222.3871629-1-aliceryhl@google.com>
 <ZiRUcEtIypy1n4Xj@google.com>
In-Reply-To: <ZiRUcEtIypy1n4Xj@google.com>
From: Alice Ryhl <aliceryhl@google.com>
Date: Mon, 22 Apr 2024 10:52:57 +0200
Message-ID: <CAH5fLgi96g-vQY-kzEZtkjgidqLy5dOSyFS=8dTE_QtQcpu4=Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] binder: migrate ioctl to new PF_SPAM_DETECTION
To: Carlos Llamas <cmllamas@google.com>
Cc: arve@android.com, brauner@kernel.org, gregkh@linuxfoundation.org, 
	joel@joelfernandes.org, kernel-team@android.com, linux-kernel@vger.kernel.org, 
	maco@android.com, surenb@google.com, tkjos@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Apr 21, 2024 at 1:49=E2=80=AFAM Carlos Llamas <cmllamas@google.com>=
 wrote:
>
> On Thu, Apr 18, 2024 at 08:12:22AM +0000, Alice Ryhl wrote:
> > Carlos Llamas <cmllamas@google.com> writes:
> > > @@ -5553,7 +5553,8 @@ static long binder_ioctl(struct file *filp, uns=
igned int cmd, unsigned long arg)
> > >                     goto err;
> > >             }
> > >             binder_inner_proc_lock(proc);
> > > -           proc->oneway_spam_detection_enabled =3D (bool)enable;
> > > +           proc->flags &=3D ~PF_SPAM_DETECTION;
> > > +           proc->flags |=3D enable & PF_SPAM_DETECTION;
> >
> > The bitwise and in `enable & PF_SPAM_DETECTION` only works because
> > PF_SPAM_DETECTION happens to be equal to 1. This seems pretty fragile t=
o
> > me. Would you be willing to do this instead?
> >
> > proc->flags &=3D ~PF_SPAM_DETECTION;
> > if (enable)
> >       proc->flags |=3D PF_SPAM_DETECTION;
> >
>
> I don't think it is fragile since PF_SPAM_DETECTION is fixed. However,
> I agree the code is missing context about the flag being bit 0 and your
> version addresses this problem. So I'll take it for v2, thanks!

Thanks! By fragile I mean that it could result in future mistakes,
e.g. somebody could copy this code and use it elsewhere with a
different bit flag that might not be bit 0.

> > Carlos Llamas <cmllamas@google.com> writes:
> > > -                   if (proc->oneway_spam_detection_enabled &&
> > > -                              w->type =3D=3D BINDER_WORK_TRANSACTION=
_ONEWAY_SPAM_SUSPECT)
> > > +                   if (proc->flags & PF_SPAM_DETECTION &&
> > > +                       w->type =3D=3D BINDER_WORK_TRANSACTION_ONEWAY=
_SPAM_SUSPECT)
> >
> > Maybe I am just not sufficiently familiar with C, but I had to look up
> > the operator precedence rules for this one. Could we add parenthesises
> > around `proc->flags & PF_SPAM_DETECTION`? Or even define a macro for it=
?
>
> I think this is fairly common in C but I can definitly add the extra
> paranthesis if it helps.

Yeah, makes sense. Thanks!

With the mentioned changes, you may add:
Reviewed-by: Alice Ryhl <aliceryhl@google.com>

Alice

