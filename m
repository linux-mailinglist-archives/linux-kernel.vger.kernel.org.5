Return-Path: <linux-kernel+bounces-147555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 05EE98A762E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 23:17:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3215E1C22B08
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 21:17:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BCEB5CDD0;
	Tue, 16 Apr 2024 21:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="iTQO/N3G"
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0047D1E864
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 21:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713302233; cv=none; b=WCInxGgtmAIos9UoRcxx5MKvOAz9vBasqqGUXaalZD/jiDzQFpzUHcj9vPfdyh8Dl88Vq5x5aqfEZyQdagBPN+M760qzCZ5pf5quBzIbVrGbsBQkGNbBNdkyo/IYYU5eXnMpm7L8+YH41aHIUPuZXX9scArdXVN57Qs6JGleZds=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713302233; c=relaxed/simple;
	bh=eW0+TtsohUH9CaW6bbrr3GrY8ovGxIw12PSymqVtzIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNWvJjcr3mWNs5hnOpR3qqYAF5da07wfBXr0Qm0/y1Akahr0PVLYGfDvUZ7Ovic490I9zl9DPvArQZkqyT/xefrZx9TevWTpyXp9wwsrXkKkboakMpHDraJUclj/fkrOqL0KkmbF6/ERy9rmqu/2UzYpy3EsB1+vIlARfmz83ds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=iTQO/N3G; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso6153347e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 14:17:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713302230; x=1713907030; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7VtGiyOmv3LjfZ2ORMBzfO1xFPZa7kUNTsJeqps7G5g=;
        b=iTQO/N3GE3WnTqCk3cq7wwVLic2RScvyTBjmuP5amcWugciuQCAqK4GqNqFnGTWGuW
         coL551Emvpr75xiYFBTDSc/GsFqEUcbDpHHzFWOBND7wpo8T/EVFPRkJHhxQRWU/tDeR
         G2cbSlJ1nmMWaV5oPxpF+9h63EPO8EYJ4GWSILv0PxR/plagU57Gzme6pBneKJrj7NW+
         RyGoaSplAqaG01cpY7WiVN50jCItY6gGVtmg/qIJHjdzMGhP+sGDwGRBY209N1+h54xd
         jue5Ixh18PtSxuF4gtsq/CYPxklV2X5jbT0qcDmkzH/M4KwHfsC43R4VTHRVsOmlspEB
         lUAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713302230; x=1713907030;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7VtGiyOmv3LjfZ2ORMBzfO1xFPZa7kUNTsJeqps7G5g=;
        b=Y38xGSdSjWMPlRpe78iH6qZAaxATEQnjU6ZclkWZ7W332vJ1KJCChKB7r/NBOdkfA5
         unlhZWHuTEeMvqblFMI0SkYzh25ZXoxmjzmZWLvCpA1JKMBK6FDta2sFhYC3tG2KLd+Y
         6Y1d3V0OhGnIMmK1gK1HlgW3Y2CaIOrfoSqFQNsKvEjf2scnazEjN9+oadrxBdr4LWWR
         rW1ZlH5cNycDAdMtX0PA4MGzQzHlnx1bIlRl1yjpiR45eBvrRLDWzC9UoU8XltN3sVLu
         veEUDWk/K1V0OkHA29zFH2j1QtBlccxUWNjCFWIrhjd11tALGgyLET3du6xo/O2Cone0
         cBSw==
X-Forwarded-Encrypted: i=1; AJvYcCWDAAtJ9Qy5YchqMxyf8K3ITQSdGGAuapAtDYcZr/wp0TiQjik95rUCI02KKwsfOHiGg5Me9liWS2WvPeERkgGS0JIsBkrBMpc00W5O
X-Gm-Message-State: AOJu0YzJpZzrtgSK//nfl4mZhX8KL5AjukJ5ik2bR7W9Am4v6ySvqSuc
	2axXJZ0xJBXyAFitencSeLUcSy8IBCNzJvrfP5sUN9xfwkoXDkORTBY7QEKcEyTeIZFMHGNdZa8
	X/NeIDrRF9B4+m2rRiaBxxoZUDr/NNF/T4FWUTw==
X-Google-Smtp-Source: AGHT+IG/dwM3JibMnMy9d0unvQ0xf9KGXFI7cArPxai6hEB4fz+b8Rj2viDAhFf3QhPcQOLzGYmF/+Acs+p6DdT2J/k=
X-Received: by 2002:a05:6512:3d91:b0:519:26c9:669a with SMTP id
 k17-20020a0565123d9100b0051926c9669amr2491258lfv.11.1713302230073; Tue, 16
 Apr 2024 14:17:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240410072102.1200869-1-andy.shevchenko@gmail.com> <ZhpC3lLD-BHqJEZz@ishi>
In-Reply-To: <ZhpC3lLD-BHqJEZz@ishi>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 16 Apr 2024 23:16:59 +0200
Message-ID: <CAMRc=MerqbYue_uubSkr0ta3wr+yQxfFMfk+vAUZa+C2oR+udQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] gpio: sch: Switch to memory mapped IO accessors
To: William Breathitt Gray <wbg@kernel.org>
Cc: Andy Shevchenko <andy.shevchenko@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Andy Shevchenko <andy@kernel.org>, 
	Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 13, 2024 at 10:31=E2=80=AFAM William Breathitt Gray <wbg@kernel=
org> wrote:
>
> On Wed, Apr 10, 2024 at 10:21:02AM +0300, Andy Shevchenko wrote:
> > Convert driver to use memory mapped IO accessors.
> >
> > Signed-off-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>
> Acked-by: William Breathitt Gray <wbg@kernel.org>
>
> A minor suggestion below, but I find this patch accepted as-is.
>
> >  static int sch_gpio_probe(struct platform_device *pdev)
> >  {
> > +     struct device *dev =3D &pdev->dev;
>
> In general I think this is a good variable to define to simplify all the
> &pdev->dev appearing throughout this callback, but I'd rather have seen
> it as its own patch so we could change all the other uses of &pdev->dev
> at once without distracting from the memory-mapped I/O change of this
> particular patch. Not really necessary, but maybe at some point in the
> future a follow-up patch doing such a cleanup would be nice.
>
> William Breathitt Gray

I applied it as is, if anyone wants it, this can be sent on top of it.

Bart

