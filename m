Return-Path: <linux-kernel+bounces-60945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 902D1850B70
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 21:20:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DB0D1F21CE5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 20:20:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0A865EE6B;
	Sun, 11 Feb 2024 20:20:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q/xQ3d+8"
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BB10149E12;
	Sun, 11 Feb 2024 20:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707682827; cv=none; b=KcUxgxN79UEbbJxllfhgE56irIkcgSdmkYIUhL4a5KOwxiIYmbbW2e4agYG/BHbIoiKgntuu7QquA6oZrQu8fQiloFOHj5WhG9qyQRZ9bktf2v6nS7urfRJcC7ZJX56uKHmxne21yr/qeR95Zgj6SYizBCF4HYpOMo0drS8rAxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707682827; c=relaxed/simple;
	bh=bzOg8Vyf1KgrI24EqX1HmE/A9hdeNubSy72njvMixRI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lpjS417fJtLmRs3VjCcIFjlXHdKIYKa5cThh407eD0G2payQmkvW9ArzFZkX06IDvlEgsEEAP1bOjkeoqRgrVWqwj1sXSlFsPfXOi8AS4dzlbPDNr0Mn6jQcD+ublITZa93DJFWCxGO3xhL30HUjDwNt+I0N5UiWEnTdn1hNKro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q/xQ3d+8; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50eac018059so3284508e87.0;
        Sun, 11 Feb 2024 12:20:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707682823; x=1708287623; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ghy+50tCdn+Q71lUqzEnDQMJYH/opBg7prwVaaY4Heo=;
        b=Q/xQ3d+8p2DNCCXLpz++2GSMQz68rdNAmlDEEpa6sbd7/GthxFQ/FThp7SGG0PeWgI
         w8qCPmB70yRLtagLufI0ZmKPrkMkDbh+E8ws5Lr7nHHdSAIO0F42zLiWkJn0ZhMoT2LY
         eF0+RZ2Agj6J0bGQAxQRTXPnAXi0lFV3H0iVM9EiQu/lenFdL8YEQYHGnf420LBEFuYM
         BgKRKzoauZWgtfoTM60NNApCdYxJC3m5HWlJ3abr22OneLYRtZqJDvGdoGo3aqJq0/0i
         QU+84ZJzjHIXycnoBA0kL/ODgLO2vIIpAfDQ37SfAv1xR+Yc4wQ31Gy97rutwZfmnhhV
         eArA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707682823; x=1708287623;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ghy+50tCdn+Q71lUqzEnDQMJYH/opBg7prwVaaY4Heo=;
        b=Wjo9sXA7WjBWkHwTAeNMzy/9atTCSe/mAmPyPYgCp0iQxHGO8GobF0GOA/T93Deb4f
         FomP+PeFSauxAIYuvAZ3J/nVtSNT63iah60vo0AEOMDTPXWmH0BUyCEn5BCBCbmHyM6g
         jMMZR4Ja/rD9OJpWGNEJe0WNhsWVynrAaTtX64oa+dRSNs537MFw+p5d9AB+9EEVTIG0
         fgMnUBR9YAtb1Y6CMfXBWGS/Vm+edLQy88b+A7eBGudyWma+dvQNXG9fsjcq1bybTOth
         agho/y3z2LJQDqv5YfPrPtVQrR5XIROjkOSLUFGJBMr0d/tabMSmRBrqMldum+aq2vOu
         3YBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVeZ2ADL8WBphwbdYwqJcYPZ/llo0FPGGebu067RYoh76JGd/+kx5dX/8fNB/ptcNrPZn8vj6rrJX6v7iHQhUlY9tRrEqkmgdpyUqh7dY3venEK92Hir2M2AZxYBImvppAM3c7mlM20
X-Gm-Message-State: AOJu0Yxco8BQyyAk4GwRtFa6z9X0eX/d6o00ivWU0DbQLSsHZ9qmUz3Y
	rQSOig6YqZsSbTOz+g+O/BUyJHN8Go8RZ+g9smvadKWmymlCY73IXBmmo3sRYk0kdwPRD3WweoV
	bQJyM4XxvJ8XasR1j2QTmL7OCu2leNtX1dGI=
X-Google-Smtp-Source: AGHT+IGvMI321riUERBvC4pbau1JUIcDEnIaKRgVlbb5SqUFZzTnaPHWCY0g3YW3LT18QZjb8VXsymHxr6x5Pb+zHcU=
X-Received: by 2002:ac2:5bd2:0:b0:511:5b4e:1063 with SMTP id
 u18-20020ac25bd2000000b005115b4e1063mr3243010lfn.24.1707682822979; Sun, 11
 Feb 2024 12:20:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20231208073119.29283-1-dinghao.liu@zju.edu.cn>
 <20231210133228.5fd425ea@jic23-huawei> <20231217132800.27e83a01@jic23-huawei>
 <ZckdEDbAqin1Fsgt@surfacebook.localdomain> <20240211193711.518b76d7@jic23-huawei>
In-Reply-To: <20240211193711.518b76d7@jic23-huawei>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Sun, 11 Feb 2024 22:19:46 +0200
Message-ID: <CAHp75VdEwxVG3qnZJgx_VKZPOkRcqHUiLcvJj3cBAnJh90Wt0g@mail.gmail.com>
Subject: Re: [PATCH] iio: core: fix memleak in iio_device_register_sysfs
To: Jonathan Cameron <jic23@kernel.org>
Cc: Dinghao Liu <dinghao.liu@zju.edu.cn>, Lars-Peter Clausen <lars@metafoo.de>, 
	Alexandru Ardelean <alexandru.ardelean@analog.com>, linux-iio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Feb 11, 2024 at 9:37=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Sun, 11 Feb 2024 21:16:32 +0200
> andy.shevchenko@gmail.com wrote:
>
> > Sun, Dec 17, 2023 at 01:28:00PM +0000, Jonathan Cameron kirjoitti:
> > > On Sun, 10 Dec 2023 13:32:28 +0000
> > > Jonathan Cameron <jic23@kernel.org> wrote:
> > >
> > > > On Fri,  8 Dec 2023 15:31:19 +0800
> > > > Dinghao Liu <dinghao.liu@zju.edu.cn> wrote:
> > > >
> > > > > When iio_device_register_sysfs_group() fails, we should
> > > > > free iio_dev_opaque->chan_attr_group.attrs to prevent
> > > > > potential memleak.
> > > > >
> > > > > Fixes: 32f171724e5c ("iio: core: rework iio device group creation=
")
> > > > > Signed-off-by: Dinghao Liu <dinghao.liu@zju.edu.cn>
> > > > Hi.
> > > >
> > > > Looks good to me, but I'd like to leave this one on the list a litt=
le
> > > > longer to see if anyone else has comments.
> > > >
> > > Guess no comments!
> >
> > This patch does not fix anything.
> >
> > Yet, it might be considered as one that increases robustness, but with =
this applied the
> > goto
> > https://elixir.bootlin.com/linux/v6.8-rc3/source/drivers/iio/industrial=
io-core.c#L2007
> > can be amended, right?
> >
>
> I'm lost.  That goto results in a call to
> iio_buffers_free_sysfs_and_mask(indio_dev);
> which continues to undo stuff from before that call.
> Now if it did
> iio_device_unregister_sysfs(indio_dev);
> (as per the label above it in the cleanup) then I'd agree.

Ah, it's me who hasn't noticed the word "buffer" in the goto label.
Yes, you are right!

> Perhaps I'm misreading the code flow here?
>
> All this code is supposed to be side effect free on error so I'm
> keen on the change even if there is another path where it gets cleaned
> up that I'm missing.

Everything is fine, sorry for the noise.

--=20
With Best Regards,
Andy Shevchenko

