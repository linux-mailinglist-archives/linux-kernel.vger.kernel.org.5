Return-Path: <linux-kernel+bounces-57055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E9C4884D374
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:07:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 792EC2876A8
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 969D9127B69;
	Wed,  7 Feb 2024 21:07:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="wliovv4a"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A8EF127B58
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 21:07:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340071; cv=none; b=uDFfT0aef5i4L6P+hMMLNFFHr4gWszkg0wEDKKSbn29QLh2kVxCCYUCTvc/wlhUz3XlEeGUmQhoZnXwyYKal413jrps+UQL59M/ETko+NMpPdvEPgZ2apxwCHeQecx6AQUN1xlB0GXyIi0UM+9uO5dehFI+9yB4IeLgKl+REeFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340071; c=relaxed/simple;
	bh=3+K0JHb4O++NG2qWKdASN7tNJhwYArUzScEMeR8uFJ4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=avLmBpH6Ormg4lrRM83Aiw5aD3QNvhBqaENouC51jyDli/AloyXZZ43LnjMOgx0kMj78o6jVS/J8XqXsGsRrv7uL1b0IHPlnKNzuW/JIpqM6Vpl4o3lh1HQ9vt5ks+ESklOq+OoKsZjHjNprF/1r1Wb1C3WBUWDYVW8IkzDir2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=wliovv4a; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-428405a0205so89561cf.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 13:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707340069; x=1707944869; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3+K0JHb4O++NG2qWKdASN7tNJhwYArUzScEMeR8uFJ4=;
        b=wliovv4aFygG3OiXb9dd279KPSjBxIwu/B4OgsZHoAvy2f6mEsx+2sZGr0Qh991vEe
         oG0SIo/XSzvCUXnuK/VpHJbd39Jb0R+3DsRqPV62WKxJlK5/qFgZo9zDQ9M4Ysa6n9S1
         OovFJnWFtNOiDOq14+tOkeJi7hfZLcHP5lnpOTEQ+f4qaqkWdaZ4128ppTBqVByZI5FS
         vvXw/Qy5F7AFToBTH6eiAvczjvS6Zs8zPIi4KiBMAQ29JKX9gW+oqvUo+j7vpbeLIoCJ
         fcE8EC9igykulNK2pfTWqcZMh5EjEfLAqRr0kQHhM2FDZWcw/VmvmlY0TFmlCrAlmQHj
         IuJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707340069; x=1707944869;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3+K0JHb4O++NG2qWKdASN7tNJhwYArUzScEMeR8uFJ4=;
        b=pfkiOXZlCKZr6j3r5yYlx0h7fk2rYYCR1NRn8IyQZYwWu0XOrid6UpnTPhxZB4/nP9
         7YEiXWE90mjg5FQYQfi75/P4H2Ce2tn61vFABhlY+IXbrvAGWwvJJOxeE/+7jNrrwrlr
         3MtkLxrKMYw1mvEjfFnOR2XMzmlTADiMkdTxU0xA05QidpsJbpbr2X11mt6jzHpMPrVX
         23QX7wdBu7dP2zUrgGXBqO/T+VeuaAEfVJp1yMg8b7LR9I4B62+JUB50CCMosX4Qa4XR
         veliC1OgIKnAFjkZIGaGVTFd0xr2MWxS3upLXpPGCHDrml2a1jxJeqCFDnkbpmWDnnE6
         zxjw==
X-Gm-Message-State: AOJu0YwlebuwMRzyjoGpk8QMsLuBMS1Y8xm86TGy3PxLE8lJvb2VKbHL
	IYuwPWk6UOyCvOgz4xFvfTYbKWITxueXxmQEFpS62rALZT6vb2MlcxPOVCVvLgT9rNA5SEO3BAI
	qORxKRKYEfEkmFSzlz+dWHOAFJE+tH2yFX9aQ/bbERNuIdltk9U/j
X-Google-Smtp-Source: AGHT+IFDTWsEXAUSLB8+5iolXkuB8IWj0qoWoDo12DjqvPEqB1M3oTcGJ1UKhEtzKXiSe/KLMnbYiZ5ZWJaTZCqlqPY=
X-Received: by 2002:a05:622a:1190:b0:42c:4486:5466 with SMTP id
 m16-20020a05622a119000b0042c44865466mr236351qtk.4.1707340069017; Wed, 07 Feb
 2024 13:07:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207011803.2637531-1-saravanak@google.com> <CAL_JsqLh6dLWjGoAFFxZXncMTY0Vw4M=Ahba1q64_M-dpZ2BXQ@mail.gmail.com>
In-Reply-To: <CAL_JsqLh6dLWjGoAFFxZXncMTY0Vw4M=Ahba1q64_M-dpZ2BXQ@mail.gmail.com>
From: Saravana Kannan <saravanak@google.com>
Date: Wed, 7 Feb 2024 13:07:11 -0800
Message-ID: <CAGETcx-bXktAay_c9q-WSyLXCwbqmZsFocn4vah_+BcZK0cgXw@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Improve remote-endpoint parsing
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	Xu Yang <xu.yang_2@nxp.com>, kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:11=E2=80=AFAM Rob Herring <robh+dt@kernel.org> wr=
ote:
>
> On Wed, Feb 7, 2024 at 1:18=E2=80=AFAM Saravana Kannan <saravanak@google.=
com> wrote:
> >
> > Some changes to do a more accurate parsing of remote-endpoints. Making
> > fw_devlink a tiny bit more efficient and the debug logs a bit cleaner w=
hen
> > trying to debug fw_devlink.
> >
> > Rob,
> >
> > Can we get this into 6.8-rcX please?
>
> I'm failing to see how this is 6.8 material?

It's a bug fix that's making the remote-endpoint tracking more
accurate. I thought stuff like this would be okay for rcX. But if you
want to hold it for later, that's ok too.

-Saravana

