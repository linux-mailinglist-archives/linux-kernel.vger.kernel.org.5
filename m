Return-Path: <linux-kernel+bounces-42159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B070383FD44
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 05:43:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E8312854D4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0501433D7;
	Mon, 29 Jan 2024 04:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nZO9iMUz"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C4A433BC
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 04:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706503418; cv=none; b=RbpV3QAG0mhWbMUAMjXZ+IecUGjKDymQsHEFsAdu+hGM9LJZumbpfSZPxjCn/y1cGQUgYyNH6VXMy0FpPLDWe9z0UJYnJcs0+W3zP6Ge/ir2c+7eV0L6DVCAv6PmIpPRWQ/2a14MU6S8m0T28UmRdaXbz9Zfzv2Ybw+LgQ/Ilzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706503418; c=relaxed/simple;
	bh=KEMyZetHyT4ZTwsJA/dqGBL0UDf2ztNiYH7ALHFA6hY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ozVu9qGWM6docKhA5rU9ae1rS+oI0TdIzF4+08Pgkx57/q6LIk9Q0QHTY3DU4BX+DzHR0H9WpQuo1MknSue/gEx6Wpji2xRI9DdQXgyP+nddDds/HNgE8o6kuHDqnSmpdZnKOa3aKbqiPX+LutKyTn16ZJswpVRdThy494ReY00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nZO9iMUz; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51020ec19b1so2620e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 20:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706503415; x=1707108215; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9LUUJgMf4wSU1c4mOlh8wB+/iHiXWhoEQ7XvlFHKLY=;
        b=nZO9iMUzkzoi7ims8/m40nYrF5N/d3L73jpzGt6Na7OvGDdBwcG0n9N0IkmgWPXgpj
         FgLUkFva1zFRzaARTdhaRRlOrQeOj1NdFXIAg0aAUHYmUToti3GTcn/8nCSRj0nRH7vw
         pXdn6PYkvyh77ZznH252pjl1z6MZUIG+sVK6IjjQgc2RwJF2KdxE/B7qvOw01C2mHvdJ
         uE/Hy8KXXdttxEz5whWOr17r1Ag8pdR+V9mwOtNdMeqkw/Vt/Do41ajk8wMaMBmhe4QU
         Fe9WmqOxUIksJ5CC2bhemiFa7U8zsCKHv2QFo3fcKNALWy5qVlOEKoEy7Z2ez3jxXyVv
         nJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706503415; x=1707108215;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=A9LUUJgMf4wSU1c4mOlh8wB+/iHiXWhoEQ7XvlFHKLY=;
        b=qJk85Y60EMcxuue4S9CK+z8w9Qh7t8jNlrkJyqDfvVohD0AzxaU+pCzYOgh1DcqsiB
         M1ojFgR1Yo+qfFX4pHG2TXel6v3Lcr+HohzNm7zRN/nKSquGh93r+cLMo4fY2qiFSf5L
         Z/lDusSigzXwmWWZrmr8pUNSQetDh97FsYh1kj4BSMqR4VFC+dGRIEvYOCENBEZT2Ilo
         EUheoOcWYAV80vZqf/N0s6LQRGccKe98xoa/JINScnkFij+dwPONsUGsVjchrb8XgQ9t
         Q5poC8RL6dAxfCG4lCF7/PGrgTB7iWM5EmtXelEgiqrhV9GkLj1Kj4qPBEbVYpN+LKOC
         jB6Q==
X-Gm-Message-State: AOJu0Yzulre7R8K1L8hef/EpZeDMaxtX1qN8hKIkXMn4SltasM3WurJA
	jWhR74bPmCdM743TJ87Zydn8rsF8Rj4rtMgYFrvNA8OAbUayemVtCItiD9gka+2repLur3Tl0Jw
	WLQQDm8yHv4pH3jlOe/LYN9e94HzCDc9S3njb
X-Google-Smtp-Source: AGHT+IFzrABIMMNFKWEklTz+hQsuaQAe0PizMVP7egZysLMvLyAr9M3qE6gCj6h0Qvt7HHzlYbldorBjpnjEeA62DRw=
X-Received: by 2002:a05:6512:2803:b0:510:1656:adec with SMTP id
 cf3-20020a056512280300b005101656adecmr337207lfb.6.1706503414839; Sun, 28 Jan
 2024 20:43:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126061153.2883199-1-vamshigajjela@google.com> <ZbNq9q5mM6kRq7c3@hovoldconsulting.com>
In-Reply-To: <ZbNq9q5mM6kRq7c3@hovoldconsulting.com>
From: VAMSHI GAJJELA <vamshigajjela@google.com>
Date: Mon, 29 Jan 2024 10:13:22 +0530
Message-ID: <CAMTSyjqOj64z3-mDm1pdQ5bi9ZM3j_cr7iSdCtvo40RyJrh38Q@mail.gmail.com>
Subject: Re: [PATCH v1 RESEND] spmi: hisi-spmi-controller: Fix kernel panic on rmmod
To: Johan Hovold <johan@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
	linux-kernel@vger.kernel.org, manugautam@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 26, 2024 at 1:48=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Fri, Jan 26, 2024 at 11:41:53AM +0530, Vamshi Gajjela wrote:
> > Ensure consistency in spmi_controller pointers between
> > spmi_controller_remove/put and driver spmi_del_controller functions.
> > The former requires a pointer to struct spmi_controller, while the
> > latter passes a pointer of struct spmi_controller_dev, leading to a
> > "Null pointer exception".
> >
> > 'nr' member of struct spmi_controller, which serves as an identifier
> > for the controller/bus. This value is assigned a dynamic ID in
> > spmi_controller_alloc, and overriding it from the driver results in an
> > ida_free error "ida_free called for id=3Dxx which is not allocated".
>
> No Fixes tag?
There isn't a bug, I will remove word "Fix"
>
> > Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> > ---
> >  drivers/spmi/hisi-spmi-controller.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/hisi-sp=
mi-controller.c
> > index 9cbd473487cb..af51ffe24072 100644
> > --- a/drivers/spmi/hisi-spmi-controller.c
> > +++ b/drivers/spmi/hisi-spmi-controller.c
> > @@ -303,7 +303,6 @@ static int spmi_controller_probe(struct platform_de=
vice *pdev)
> >
> >       spin_lock_init(&spmi_controller->lock);
> >
> > -     ctrl->nr =3D spmi_controller->channel;
This remains applicable, however, it could lead to a failure in the
spmi_ctrl_release, I
will refactor the patch to address this.
also "spmi_del_controller" is removed from 6.7.2
> >       ctrl->dev.parent =3D pdev->dev.parent;
> >       ctrl->dev.of_node =3D of_node_get(pdev->dev.of_node);
> >
> > @@ -326,7 +325,8 @@ static int spmi_controller_probe(struct platform_de=
vice *pdev)
> >
> >  static void spmi_del_controller(struct platform_device *pdev)
>
> This function does not exist in mainline so presumably this is some bug
> you've introduced in your downstream driver that you're trying to fix.
>
> So this patch looks all bogus.
spmi_del_controller is present until in 6.7.2, I have made this patch
in last week of Dec,
I should have checked before resending, apologies.


>
> >  {
> > -     struct spmi_controller *ctrl =3D platform_get_drvdata(pdev);
> > +     struct spmi_controller_dev *spmi_controller =3D platform_get_drvd=
ata(pdev);
> > +     struct spmi_controller *ctrl =3D spmi_controller->controller;
> >
> >       spmi_controller_remove(ctrl);
> >       spmi_controller_put(ctrl);
>
> Johan

