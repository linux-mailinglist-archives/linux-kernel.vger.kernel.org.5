Return-Path: <linux-kernel+bounces-89387-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B12F86EFB4
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 10:00:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3969A283C4F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Mar 2024 09:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD32112E52;
	Sat,  2 Mar 2024 09:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="HypS2qBO"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E874125C4
	for <linux-kernel@vger.kernel.org>; Sat,  2 Mar 2024 09:00:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709370004; cv=none; b=p93r6NJnztnNF/zWo1lcK9POjmjsylzkOh/3Ukj64aF7S3Q7+R6URCd+Okpkvz0trRWgWhR6QTPBT8b3KWVATkBYrHlgj0kpVEd1K0IrdRGzRlJ0zt6GeeyZUn9Ns9JORPAX3mhDfIITQxM4fFNR+zfRnQuY3mZnXHb+xVC18Ks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709370004; c=relaxed/simple;
	bh=eCQzoCFbOFPzXODq2rUOGKdBd463E6JRcHrunmqfO4A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8ananriPDWlooXX5Yno5grHSnDHdCYuHHecLiAqjtkfdGXjAwD6Z874852GkaddB08mbfK0+mIW3DMp3+MdVMN66dOEA9fa5kDnfu1JnnoDGn31JFWaiS97RwBEzeZDzvFtYTnDlAHCZIXtU58WYKiBvPB/WuldWQlHIfreUkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=HypS2qBO; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7d5bbbe592dso1623157241.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 01:00:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709370001; x=1709974801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eCQzoCFbOFPzXODq2rUOGKdBd463E6JRcHrunmqfO4A=;
        b=HypS2qBO7mdDDipmFt5k2cJmciuoo0hTjTSE2Lsvem+lZcjwWRwu3DxOAjvYCmjije
         CbKFLV9ZW+qKDwmPV5X0TnHsieS6wJdF68VNwhMgur26xkCado2NTijI1phm9pd3CbVH
         fVHfz/0WSbbadsvdcAvWyRBZdZf4n/nNA7AfxNRpmeIWeDlQ0NmoGlHC1SR2n3fXdZdW
         O3XbvERVOFdTYvvAhExN46Dpw0YbdK0eTW66y3BLon9WPIrXpz+fcIPh9I1yEQFNT9fQ
         dxrZ+6PYav4432iQD4uFLAVgSN3qudP+52oKFsjWPs1/nmxKe+q4qOSUNdOfihLhc4gG
         aO+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709370001; x=1709974801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eCQzoCFbOFPzXODq2rUOGKdBd463E6JRcHrunmqfO4A=;
        b=IRjfnnvmbTRU2rQ1CM0NE2b4P412bqru4REZ3/BVFIi1XK0qRlDC+L4N/FODPZUTwS
         6nJ3KfE09ubmtueCj5ImgZjMBlZtfgQSI+OqB7cwW1+V7dTIk4yMsYdZu6gE1+LX5WxK
         cPauz418nuIzEan81eg6E+BSTGmdK6w4LmInUjDBUrg4moIFjNUPThp1VKB6gAwEY43a
         ZaXXsD8kU1GcZdwfgdrFmH9usYnvoXtzZ5iPYvUTSj8jD1WQCWJWW9oNHD/5Ce16Dl+/
         QIZY7ObJbdrPBsIgbRP52BTchP8mIrGOIfnUCkpakkbU8kuRBS7hxS/CR+1Vwg/L4vX2
         1Nfw==
X-Forwarded-Encrypted: i=1; AJvYcCWW5B/aBdCEDqdnSCrEU0Vbx/1KAY9lRnCPw+M3uBDXLpiv0AQHNhyyUAn1Dgq2xkJ1i8nl4sX28HV4FY/GMXGY1PfaBYTLdJkVTKbz
X-Gm-Message-State: AOJu0YwqmdkfBmtFqCVUtAbtuFJ9pJdeo46/iX1SLMssCFzMjpUUhwdE
	62gXQJ+ivO100E9V+N0FuHIdvgiMuSZzeoKn5cuqhodXU0K0U6Ykj3V303O2v2vlKIIyjuYBC7v
	H7AyjKJK9FdZMMg+W3b0CNL3lmjEbq5KESkOVCQ==
X-Google-Smtp-Source: AGHT+IGTFC6f7wUdK+L9p4HEQkbr21KxcwtfSbwfdHJXskErtbV5zw1A2Mcf/B5CrvjSLLpmMODnMnLjoM/0CR/ddF4=
X-Received: by 2002:ac5:cccd:0:b0:4c0:24e6:f49d with SMTP id
 j13-20020ac5cccd000000b004c024e6f49dmr3136575vkn.1.1709370001367; Sat, 02 Mar
 2024 01:00:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227113426.253232-1-herve.codina@bootlin.com>
 <CAMRc=MeSMTnPUYGyJir4fc=6=Gnw_MVP9wfEKMQ6Ck33FYCrRA@mail.gmail.com>
 <CACRpkdZbGUd-u3ZcmmK1POSEq8z9J1aDhbGPAbcR6guKuEpEFQ@mail.gmail.com>
 <CAMRc=MeqiYZv3ViHRKKUsXTqG5Pc8Ev2jUcN=A4VuX3RU7dDtw@mail.gmail.com> <CACRpkdYWDzu+VMQOYO_Sh1NM2ei=VRC-0df4teAZjirfrTB67A@mail.gmail.com>
In-Reply-To: <CACRpkdYWDzu+VMQOYO_Sh1NM2ei=VRC-0df4teAZjirfrTB67A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Sat, 2 Mar 2024 09:59:50 +0100
Message-ID: <CAMRc=MdLmU3uezKSg2d83HSZ3wYXFx68oGshx_yJyvJToN261Q@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] gpio-cdev: Release IRQ used by gpio-cdev on gpio
 chip removal
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Herve Codina <herve.codina@bootlin.com>, Kent Gibson <warthog618@gmail.com>, 
	Saravana Kannan <saravanak@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>, 
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 9:15=E2=80=AFPM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Fri, Mar 1, 2024 at 8:21=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> > Agreed and the big picture - just like with the reason behind the SRCU
> > rework - is the fact that even static GPIO chips defined in ACPI or DT
> > can be unbound. Unless you want to make the decision that we
> > arbitrarily suppress_bind_attrs for all GPIO chips which I don't think
> > you do.
> >
> > I have shown in the discussion under the previous iteration that a
> > static GPIO chip defined in DT that is also marked as an
> > interrupt-controller may have interrupts requested directly from its
> > irq domain bypassing the .to_irq() callback. As long as this GPIO chip
> > may be unbound (and we do not restrict this) it means the splat
> > mentioned here can be triggered from user-space with a simple rmmod
> > because a requested irq does not increase the module reference count
> > nor do device links seem to work for interrupts not associated with a
> > struct device explicitly.
> >
> > I DO want to fix it, don't get me wrong. I don't want to just leave it
> > like this, especially since we've made so much progress with
> > hotpluggability recently. I just don't believe this is the right fix,
> > I will try to come up with a solution that addresses the issue
> > globally.
>
> OK I trust you to come up with something better for sure!
>
> With regards to the ability to unbind/rebind drivers from sysfs, true.
> I have heard about that as a counterargument to many things.
>
> The problem is that I have never heard about a user unbinding/binding
> a driver from sysfs for anything but debugging a drivers ability to
> bind/unbind. Partly I feel that thing should just be moved
> to debugfs given the usecase and because it just looks like a way for
> attackers to provoke crashes given how some drivers look.
>
> Yours,
> Linus Walleij

That's not the only thing - device unbind can also be triggered by
removing the module providing the driver which is a completely normal
operation for user-space.

Bart

