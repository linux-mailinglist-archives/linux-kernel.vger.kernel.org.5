Return-Path: <linux-kernel+bounces-87167-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1671E86D08C
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:26:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C5FC9289504
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:26:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BEDC6CC04;
	Thu, 29 Feb 2024 17:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jyuudsHt"
Received: from mail-ua1-f46.google.com (mail-ua1-f46.google.com [209.85.222.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 270766CC02
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:26:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709227602; cv=none; b=SVVw6yScOZzoVr7uVmDQhn24uyXCHicM8xwGaA06umNdR6mxZtROSWztNLFVOexRcWe6a+zeYYRmKFlBL3Uokb/UEn7U4um5fvJj+CKisgZ7Xp9Ulci85syz0eWX/3itVIs1gBi9SjCdTTYCaQBQ3EDu9gJ/hpA2Pu9/Vqemu6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709227602; c=relaxed/simple;
	bh=SyjKEYVew5m9zUU9ZMwdROqu52vc9bJrfOA47hQzAww=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ye7/aB9VNzZo0QAblf/UVj0+6LExtOoH3liUSdSN6TEyUB4RntVIDpg7K0WeDnzwctVML0zeNhYzb2nbIsbF4badsGSd34et2tKALDuLUiMsGN2W09f52LmnsJ9aWAVgUCvqeaqRO8S1AvLLrpgIhrJZKzQgzQap9KNNp4U8Oo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jyuudsHt; arc=none smtp.client-ip=209.85.222.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f46.google.com with SMTP id a1e0cc1a2514c-7cedcea89a0so618843241.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:26:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709227600; x=1709832400; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SyjKEYVew5m9zUU9ZMwdROqu52vc9bJrfOA47hQzAww=;
        b=jyuudsHtZ2ZYs1WZcU/W8nrOO4dCsdKtmJwb65ec3niioqB2cirsmFCYLTmlGPseBo
         gTHJfUo8Z5jEkXDvr+wqh5xGrZ6Dyc55I3V5a3HlNA9/TCcWwDiPpv1Xcnsko9AeqAFk
         IEu8rIwTaN79DXOERGDUJwFJjJzOCT+QsW6zT6a+O6o5yfIM+q0/hvA1jAG74JMA9kp8
         Yz8MlL4NFdd/Ghy0/H76phParkGKAoIrhjGwXzjV40gG6DrN1+YXfLuukvZkYpsBMqIO
         c1dImv+MXSODmDyVTsEwTwBZKVaYNuxds5e/cz4l0V6AA3K/X7iyTw78g28l7rj2I1FI
         BUQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709227600; x=1709832400;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyjKEYVew5m9zUU9ZMwdROqu52vc9bJrfOA47hQzAww=;
        b=tME5VzNRNc04TqW5AS+Rq8aXXp6yVxYNXwPs8YDpTatvb15M0Xo7bdmUDg5ONe5yy3
         pOSg6LimEfk4tvrjzYYhEhBD5S5JIX7JeRTTT+a7evKyRwJcfZ/mnuHQZJWYrPJ5YzYd
         tecahqhurmQdvusl0NcMVkC/a6r3byOIakrDv4VtxF5dZp2yjEAVoW4jjUYhhOHf6Qru
         vzdBQv9pImHwExxzj5UVVF+qatdQjwgroLGfjYpF2jv2hunqPNPQO33waIqYNh8E3zhv
         atPQz90LHkZycyhxshX0L916APW9zCLbY4m5lQKGuuXXuTOla5W/fYO4ej4b9w05MPRK
         SJ6g==
X-Forwarded-Encrypted: i=1; AJvYcCXSeQ6VQJBH8fEzHYKFFMD1VcEei0Mcc4B5A3YvFGBHIClVivwwsmm+xJdg5QTdozKlBYsdKIVrSV0VJotJUUG9lIxa7tg3wuEV2OWQ
X-Gm-Message-State: AOJu0YwQE3XbEaHIwesb7VXLkIoFFkWGhn5rQ+rWTgTYEycBFhb6lOCc
	WeU2ETkXcKQiCnUfh1KyebqU2gO81cG4QGkQxOSLXNk8xB8ObqsXKiiRcYGyAA1rUooMJMz+xyC
	UihomZBEiJBS5EpYakp0ZM0o1ME1sovRvGqUv7g==
X-Google-Smtp-Source: AGHT+IENN9hkUa/eueNHGpnumeQR0qC+f2AJiya9lAHk3TbgLuACYT7KNIIao33kBn6o5QD5xMiLvm3jT6mR6rwCkz0=
X-Received: by 2002:a1f:e082:0:b0:4d3:3a0f:77ce with SMTP id
 x124-20020a1fe082000000b004d33a0f77cemr2902281vkg.13.1709227600036; Thu, 29
 Feb 2024 09:26:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221192846.4156888-1-andriy.shevchenko@linux.intel.com>
 <CAMRc=MdvYdx6x=gSiOZ3SXAdJORnqhsNW79G2c7wABofWARwFw@mail.gmail.com>
 <ZddLRAqxFr7v3Zqs@smile.fi.intel.com> <CAMRc=Mdxtx-wh3HGu+SNrCwfSq0PEm3fG7hK_6wPAk2uzk8xpA@mail.gmail.com>
 <ZddOKTP73ja6ejTc@smile.fi.intel.com> <CAMRc=Mf_w_E4B7c_Uj1WV3zv9DbmJ22oFvJJwtd-+3oUDVcvXA@mail.gmail.com>
 <ZeCw3pzHdrXw46of@smile.fi.intel.com>
In-Reply-To: <ZeCw3pzHdrXw46of@smile.fi.intel.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 29 Feb 2024 18:26:29 +0100
Message-ID: <CAMRc=MdKFvAefKxLnovxnQt_tpiW+dCviWXKuHqg3vqHhEtPNA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpiolib: Fix the error path order in gpiochip_add_data_with_key()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>, 
	Linus Walleij <linus.walleij@linaro.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 5:29=E2=80=AFPM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> > >
> > > I'm sorry I really need more (morning) coffee, maybe you can simply u=
pdate
> > > yourself or submit a correct fix?
> >
> > Ok, I'll apply this and send a fix on top of it.
>
> I don't see any progress with this. Do I need to do something?

No, it just fell through the cracks. I applied this now and sent my
own fix on top.

Bart

