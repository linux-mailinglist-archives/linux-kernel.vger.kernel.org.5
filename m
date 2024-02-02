Return-Path: <linux-kernel+bounces-49809-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 213EC846FA4
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 12:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CCACE288905
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 11:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C385A13E215;
	Fri,  2 Feb 2024 11:59:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YJ1tkzRA"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FB313E202
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 11:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706875190; cv=none; b=UinzkC0RpS5jrWosiT6PmtfeASMVQAkU63QpcEDEXzuycscS9uUxHO0+sX84SZW1LREFQlP7Ad9CwwMnc7nyLdSa/cyBeHExgWAn6a70/ySecT7L3MVy5bM8jXFnIPF02V59nVVqk3p5BQJIP2NNFkavhuevH9PaMWQucBfbiLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706875190; c=relaxed/simple;
	bh=L8zXmEnzQ5MDk6tEi/iStuhq3qZ3Z7XK7nETbU4DHjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=INEGsexLTkLo9Ho8CHk87nkflrV/6LA0oq/UxhtiD1LIK8taWKor7S5BT5qv+CG+WMBxp8t3lZCmJcDkMfD0HaFMe8+3iot3ws7yqDKBrRunGnvSlJnKXxoKb6OFZfTdJRJ3ag3f5Wfp1/lbtd4P0/PNzSRw6taVPOWo7s0MQDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YJ1tkzRA; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5113a1f2867so592e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 03:59:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706875186; x=1707479986; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vwqouXfBLYTxxgjJE3IaFJ/MSu5vbDO0XYucXN4S1vE=;
        b=YJ1tkzRA+rKhp1MP9aAIunHpqPSh5WGquytshxHuoiolb0jE05PbpX5DI79MilWnND
         stFR/dN9Q+hkPzKogZdXoJ8w8mUC30Lvi6yg3uoh+8C1r8u0ogQJiHprj6iYptAr+77J
         qCmKDVSVP2uXMYaIpu2z04QzV+8gKt8Z5UUDneV1cK0F/PsWfNLZQ9a2Iqt3iPbajqEy
         iaCtWjX2TnWD0AV7wFzqEScITPo/UQRsb6EduVnnICHiPFz6JoIDsIjxDoi7rdyV0OLF
         3uqJYfKs4yvZO5yz8932KCvXREhPfzLfD72+XQUgR3bjU8UPegpOU4jyvUPJ1BdRnkiC
         LrUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706875186; x=1707479986;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vwqouXfBLYTxxgjJE3IaFJ/MSu5vbDO0XYucXN4S1vE=;
        b=lDKRSN2EA7tt8s6WPawirVqsiGhAGmOP6zesVXAKEHQLb6YxhM85errWbhAZ4Ux5s3
         GPIBZp/ATlX8QeCJrXsT6yk9elg6berAKDIX47+/19dlg5av75i55zZ6MjKKCngTahLy
         Uo8MfdjagoWLfqS3pHzefS59Vgxs7Q0mAI6FEkSCoIF/xiK3pIQqPYB5bRUSh8MUe/jM
         7l+K3GnZHLFxNvFX5WE6JSv2fb8tvXlYOD7ONaL9zdQaMNi5EwCqV0bfbKvq6egK216R
         aaiyE+PhwfqQFj30DSPT/PLxdTEv0KdCK3UlV4ovFzLtmV6cJ4ipETTGHqtJaS7UOaWO
         OlyQ==
X-Gm-Message-State: AOJu0YyTz2HWBTDhJ581FWaEG+qGFYPluJnysTLL2XXhsOEPNqWbCxCu
	uzjLkz0izA+LbxikTTQtQcAjU1Z+YE9fIt4WfdhnzUBQOFQ4zBWZYg8tTQxFDb4TerlZZtNTOEt
	1AtwZtdP2MMI6rmvYPRcAobllbyOJGhrPxyknTL12q40lBiZsdpDd9BY=
X-Google-Smtp-Source: AGHT+IEid8gatCGV/bONxMObm6GKu/fQf3qGJAHzXoMyDs7HJGOUHsddNItCG0T6dELiQucFWW6QmJSkY7qnzt+K43Y=
X-Received: by 2002:a19:5f11:0:b0:511:318b:a6bb with SMTP id
 t17-20020a195f11000000b00511318ba6bbmr60959lfb.1.1706875185881; Fri, 02 Feb
 2024 03:59:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126061153.2883199-1-vamshigajjela@google.com>
 <ZbNq9q5mM6kRq7c3@hovoldconsulting.com> <CAMTSyjqOj64z3-mDm1pdQ5bi9ZM3j_cr7iSdCtvo40RyJrh38Q@mail.gmail.com>
 <ZbdUW3GYVu6zF9QQ@hovoldconsulting.com>
In-Reply-To: <ZbdUW3GYVu6zF9QQ@hovoldconsulting.com>
From: VAMSHI GAJJELA <vamshigajjela@google.com>
Date: Fri, 2 Feb 2024 17:29:32 +0530
Message-ID: <CAMTSyjp3MJvzQ5wnsssWOHqDiB5YD==TzOXNNjJQ9sL-_-Mfkw@mail.gmail.com>
Subject: Re: [PATCH v1 RESEND] spmi: hisi-spmi-controller: Fix kernel panic on rmmod
To: Johan Hovold <johan@kernel.org>
Cc: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>, Stephen Boyd <sboyd@kernel.org>, 
	Johan Hovold <johan+linaro@kernel.org>, Caleb Connolly <caleb.connolly@linaro.org>, 
	linux-kernel@vger.kernel.org, manugautam@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2024 at 1:01=E2=80=AFPM Johan Hovold <johan@kernel.org> wro=
te:
>
> On Mon, Jan 29, 2024 at 10:13:22AM +0530, VAMSHI GAJJELA wrote:
> > On Fri, Jan 26, 2024 at 1:48=E2=80=AFPM Johan Hovold <johan@kernel.org>=
 wrote:
> > >
> > > On Fri, Jan 26, 2024 at 11:41:53AM +0530, Vamshi Gajjela wrote:
> > > > Ensure consistency in spmi_controller pointers between
> > > > spmi_controller_remove/put and driver spmi_del_controller functions=
.
> > > > The former requires a pointer to struct spmi_controller, while the
> > > > latter passes a pointer of struct spmi_controller_dev, leading to a
> > > > "Null pointer exception".
> > > >
> > > > 'nr' member of struct spmi_controller, which serves as an identifie=
r
> > > > for the controller/bus. This value is assigned a dynamic ID in
> > > > spmi_controller_alloc, and overriding it from the driver results in=
 an
> > > > ida_free error "ida_free called for id=3Dxx which is not allocated"=
.
> > >
> > > No Fixes tag?
>
> > There isn't a bug, I will remove word "Fix"
>
> Both of the issues you point out above sounds like bugs that deserve a
> Fixes tag.
ACK
>
> > > > Signed-off-by: Vamshi Gajjela <vamshigajjela@google.com>
> > > > ---
> > > >  drivers/spmi/hisi-spmi-controller.c | 4 ++--
> > > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > >
> > > > diff --git a/drivers/spmi/hisi-spmi-controller.c b/drivers/spmi/his=
i-spmi-controller.c
> > > > index 9cbd473487cb..af51ffe24072 100644
> > > > --- a/drivers/spmi/hisi-spmi-controller.c
> > > > +++ b/drivers/spmi/hisi-spmi-controller.c
> > > > @@ -303,7 +303,6 @@ static int spmi_controller_probe(struct platfor=
m_device *pdev)
> > > >
> > > >       spin_lock_init(&spmi_controller->lock);
> > > >
> > > > -     ctrl->nr =3D spmi_controller->channel;
>
> > This remains applicable, however, it could lead to a failure in the
> > spmi_ctrl_release, I
> > will refactor the patch to address this.
> > also "spmi_del_controller" is removed from 6.7.2
>
> No, this has not changed in 6.7.2, it has been removed from 6.8-rc1.
ACK
>
> > > >       ctrl->dev.parent =3D pdev->dev.parent;
> > > >       ctrl->dev.of_node =3D of_node_get(pdev->dev.of_node);
> > > >
> > > > @@ -326,7 +325,8 @@ static int spmi_controller_probe(struct platfor=
m_device *pdev)
> > > >
> > > >  static void spmi_del_controller(struct platform_device *pdev)
> > >
> > > This function does not exist in mainline so presumably this is some b=
ug
> > > you've introduced in your downstream driver that you're trying to fix=
.
> > >
> > > So this patch looks all bogus.
>
> > spmi_del_controller is present until in 6.7.2, I have made this patch
> > in last week of Dec,
> > I should have checked before resending, apologies.
>
> The bug you found was apparently accidentally fixed by commit
> 490d88ef548d ("spmi: hisi-spmi-controller: Use
> devm_spmi_controller_add()") in 6.8-rc1 but I don't see any record of it
> having been backported yet.
>
> As it depends on new helper function that will likely not happen either.
>
> Perhaps you can split your patch in two separate fixes and ask the stable
> team to backport the driver-data one.
Sure, I will split this into two as suggested, Thanks.
>
> > > >  {
> > > > -     struct spmi_controller *ctrl =3D platform_get_drvdata(pdev);
> > > > +     struct spmi_controller_dev *spmi_controller =3D platform_get_=
drvdata(pdev);
> > > > +     struct spmi_controller *ctrl =3D spmi_controller->controller;
> > > >
> > > >       spmi_controller_remove(ctrl);
> > > >       spmi_controller_put(ctrl);
>
> Johan

