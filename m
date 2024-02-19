Return-Path: <linux-kernel+bounces-71022-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC0BE859F9F
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 10:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75615285623
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 09:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57E1523763;
	Mon, 19 Feb 2024 09:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfdOuapX"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 385972374C
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708334573; cv=none; b=Yb42PuigL1iVLIAyagjWBDkY99EYeaPpBOuLf6LpOjSHXTLvtf1Kgnh8R/qYcl+av7s5jWxIx2FiB49jCW+2S09MYvPj1+UKVu3OsD4oVq+HuKIeLOBbK2+0tD6qP7X1LwPpJ7xJDRIAPxLZP3WINtOTMIFrpUFnv5UUonfYCmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708334573; c=relaxed/simple;
	bh=pF0TR3qOdDZ2bsasfoojepgW2ZMQCvSykRkSSHZmDLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Yz152NgeZXNxw5wm7CeDatHBgGfef9GYLZvaDgQwIzS+hpYwUOrLqjUb4TyupUl+8L3dL/AkG/1dqjcUeoX6ikBstA2YJx5z7T7WF7WTifpKQZ5S08QX1G4T/IwTBAGniEMFbZbsnlFRtDhioo1RB2zabfGAWbGBvtOKrNhByiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfdOuapX; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-7875c347a29so106626885a.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 01:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708334571; x=1708939371; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hhTvSxJ/x2znzcmUqwk3cNw7/IqA0HFzE48+6BdqiDY=;
        b=FfdOuapXURx7BmbO7iRdz8J0wMOQ9C0ECN4icZzeF/ej2Hk+TMws7nSTQpAVCA48BH
         DsTiyivUfoKDRMqgnLi4IWQ2dYAYw0ICHD7LgRrU6ZwE8wCMzd/pMlD0PUrP9z/vG1CM
         o6wl7jjYuFUOlSpvGz2W7LAVmoVNPzvvgZv55CmVDyXEJLy4lTeOARkduRcre1TKlXwD
         yqWbo4DbzcfGHT5ozc9ZqMSYCuIbbXSc2vdUeEkJPQOw9j6hw7Mi3Y0n/zpSI5MJe3jv
         V0t313Zh19Gp59yen36SpPll1YmrI6aK/XvrFDM8gWZIxDjByoc1hYgUL1td/3edjbHj
         ajhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708334571; x=1708939371;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hhTvSxJ/x2znzcmUqwk3cNw7/IqA0HFzE48+6BdqiDY=;
        b=WlcD9uTazjXMe9FUQ3OoN56BPHE92S7adBVGLn8vuEjqLhvPx2HsL/YaaJai8G/zLP
         anpAeFvd3MkpkZMI0zfXJiJtqdMAeyPkZTJBrjXAZ7Q0cN9wlCoMspC4uYtnCCu/yDfY
         bpvPcMZo/Pair8K5UsJAKaW3HjL4eFPRM9naZe/9o1+H2QZ+Pp/1cESPBdfNu9faLmCY
         CsNVNS5OxSIoLkcU3YGbriiPUp51gL2LxUvYKvCXYyeIK8OhsZpGmcfODGK1j3Kuy8LD
         lGunq4Zh8ysAUtgC2c7WP1/vnf5p77bExEbbigKeP76H5PzTUqubqtggGQyqUaOK0qap
         V0Eg==
X-Forwarded-Encrypted: i=1; AJvYcCXf600naQevw5aIt2Wj8JVOEsRtsGfp61+9+Xiuz4035FhRa4zogICNi/PhdBonN7QiJD73lSTiIh0cVVygaLX34YvMpTGuiz8Iupi4
X-Gm-Message-State: AOJu0YzjCi6ROg9gar5wZZwIEx3SXiUhV1ADno+upuvJFp/1S49NORzI
	pSS1RK+uQMteSu4x/hBAlsYvO/S5P0E3M59Pxwuhto6XdGfsU5PYqXC2qEffSNcSq6Gsa6ZTssv
	juEFAIMp7DwZDuk5g93NBH7un1zU=
X-Google-Smtp-Source: AGHT+IFuIiX9Klg05+nDcgu9WHG5wGy+trNSqxBYHJHIbn5D7zNfdvsCP6yfkUy9j83LXocbUhqEr10z9ldP/Mh3fmg=
X-Received: by 2002:ac8:6ec6:0:b0:42d:d010:edb7 with SMTP id
 f6-20020ac86ec6000000b0042dd010edb7mr10996685qtv.28.1708334571040; Mon, 19
 Feb 2024 01:22:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240217211246.28882-1-mo.c.weber@gmail.com> <510574c4-ad26-4fc2-93c4-7b67737f8eb1@moroto.mountain>
 <236d985c-1835-410f-b0b5-cacbd5fbf930@moroto.mountain>
In-Reply-To: <236d985c-1835-410f-b0b5-cacbd5fbf930@moroto.mountain>
From: Moritz Christian Weber <mo.c.weber@gmail.com>
Date: Mon, 19 Feb 2024 10:22:40 +0100
Message-ID: <CAMn1LHB2H6hqMZLOWrQEN-hRQf3LTRU_q-6ggu4=qRDiU5=inw@mail.gmail.com>
Subject: Re: [PATCH v2 0/8] Staging: vc04_services: bcm2835-camera: Fix code
 style checks
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: florian.fainelli@broadcom.com, linux-staging@lists.linux.dev, 
	linux-rpi-kernel@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ok.. thanks for the explanation. Did not want to ask back stupidly
what the script was actually complaining about without providing a
suggestion on what I understood what it was asking for. I will submit
a version 3 patch for the braces and a separate blank line patch with
both good cover letters.

Best regards,
Moritz

On Mon, Feb 19, 2024 at 9:17=E2=80=AFAM Dan Carpenter <dan.carpenter@linaro=
org> wrote:
>
> On Mon, Feb 19, 2024 at 10:38:30AM +0300, Dan Carpenter wrote:
> > On Sat, Feb 17, 2024 at 10:12:38PM +0100, Moritz C. Weber wrote:
> > > Resubmit these patches to fix multiple code style checks for better r=
eadability, consistency, and to address errors indicated by Gregs patch bot
> > >
> > > Moritz C. Weber (8):
> > >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> > >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> > >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> > >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> > >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> > >   Staging: vc04_services: bcm2835-camera: fix blank line style check
>
> This blank line patch would be still separate of course.
>
> > >   Staging: vc04_services: bcm2835-camera: fix brace code style check
> > >   Staging: vc04_services: bcm2835-camera: fix brace code style check
>
> regards,
> dan carpenter
>

