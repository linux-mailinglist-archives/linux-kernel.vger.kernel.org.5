Return-Path: <linux-kernel+bounces-38367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 773AC83BE65
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:11:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F5D1C22F87
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3491CA84;
	Thu, 25 Jan 2024 10:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bnNUq+5s"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E86821BC59;
	Thu, 25 Jan 2024 10:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706177456; cv=none; b=fnPygsU2/6VeXP2H0ByM/9qG6VpW9NVU1F5fXeemGpDWQOBAjh9tcp51UUNnvPQwFStOEVCDiqUpDLDkdR+d1rfKpDwVs1k+UM2QUCAwzKNphdipNCC3VculiKBWPu5Lj3V7iCoDUaSRGI0G4+N7GApcBQTF2kX9vXl8LM9rZBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706177456; c=relaxed/simple;
	bh=DrCpUka4LE7f28/xZ1+9p8HGvQNODuskxIvCYYf144U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=svtKSnSmnUld9fvhNb34i/P6QKVDXZMBdwtxP35vWwRd1+uS2cdsMRBzLF3nwQbXEzv+BsBzus2RSctVZJ36lx3PXFMjFLohRovexTpXJaYEuEXgekZWvAn9pQlJqWKPl94AzcpYQuJujotch6CeP/DsMA8YlXDAId+d2Kfua6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bnNUq+5s; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-50eabd1c701so7495510e87.3;
        Thu, 25 Jan 2024 02:10:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706177453; x=1706782253; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DrCpUka4LE7f28/xZ1+9p8HGvQNODuskxIvCYYf144U=;
        b=bnNUq+5szB1dE36e7AkeyN0aswf3vUo7Xwgovtc0S6Dg6BurDsK0N4tmYjNjBZegfP
         MxJsL9q1Uk/BJN1TJ+u3y51zkJb+uvBuPQPszgOvC1bkpmNH7XGMqVyY7cyFBH4Vywo1
         zfTVAiKYrnG+jSed2JLKQIQFMgRl/DXZOC4Vx/oE13+JoIuNono75wFIIkCGvi+tMUVd
         dELJRwZEpnaSqeIeUD6WG5v0V/KNy7BB35K4tHmpzwOX3kqLfkwW/9ufYFY7uQTBZQHP
         7Mo/fvCrl9c4sJav+hLRFcyn94fWGo6VeGxW4Xab8M0+Ul0Un/T6dDj9UiZJ5n7UFEa2
         uo3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706177453; x=1706782253;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DrCpUka4LE7f28/xZ1+9p8HGvQNODuskxIvCYYf144U=;
        b=TCWJg9auIFQC4U6frlgvjVcKJu/UV8VKQHRNsWvQMMn5dCked2UUaPymDHFR4qW3EJ
         fC2trnxpv2YBaXnLHYsNLAKNjzXMcfgZ6O7E1fTyqDTVZDan5MkxFL+3h0LPMiN2Ewf3
         BHR7mTjYgu1b+TrOPjRA0hPCGv8x6km4XPwcHr+TFbJp46SzdRelBfKydwYfCUl9BSQV
         QvmIQ7gQhnwc2bZ8MeTZ7KBDJiFn2NI/5JI2CNiyAnSa+K/AeMANzGfsGAUEyh6P2vcL
         W9jlrbvgXzhVAAzAKp7pwI42PUOxkU6ltgsvOtSQZPZGlU2TvRwpo5h9OZc7EDFL1JeG
         BBBw==
X-Gm-Message-State: AOJu0YwDD7Y7HuJTERfvjRCmWGx5xoOFWPHicFWohs+JELxpPp/s7iv3
	Lxw5JZWABCydGqTAe3VvoyZU7OcKgUGzyf9hjms2HsbgTDiVh8VUYk//cjHE4RMcBOimqFxkO1x
	U1Dzawen4ubJ1WJ7aFI/qGfpn6zo=
X-Google-Smtp-Source: AGHT+IEpIDWyl6tFm+r49tMS3Z+8PP4EdyyPXZikf9e6m3sNiCyizIlXH8ymocrkSQalk5NR4qt9fpxCV5mQmwC4Q/g=
X-Received: by 2002:a2e:a277:0:b0:2ce:d2d:72a0 with SMTP id
 k23-20020a2ea277000000b002ce0d2d72a0mr528628ljm.104.1706177452638; Thu, 25
 Jan 2024 02:10:52 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <6b2d5694-f802-43a4-a0fd-1c8e34f8e69a@kernel.org> <CAGWkznHK5UPajY2PG24Jm7+A0c9q+tyQzrPdd=n3tp0dgX+T0w@mail.gmail.com>
 <95082224-a61d-4f4b-bc96-1beea8aa93a9@kernel.org> <CAGWkznGe+37K7_E34G_MZQXNxoLuM3E0mY=BZCGpyiq+TB_PoA@mail.gmail.com>
 <CAGWkznGJejDMZsryPpS-11mb50wMhhQe-=sNoV4_iO5ogVLtLQ@mail.gmail.com> <15d07953-aeff-460e-81fe-ea7fc2f6145d@kernel.org>
In-Reply-To: <15d07953-aeff-460e-81fe-ea7fc2f6145d@kernel.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 25 Jan 2024 18:10:41 +0800
Message-ID: <CAGWkznF_mQdA0ebTfyXKnJ0xu6v=iqhr9yDJ4DohL38mRgeTrw@mail.gmail.com>
Subject: Re: [PATCHv3 1/1] block: introduce content activity based ioprio
To: Damien Le Moal <dlemoal@kernel.org>
Cc: "zhaoyang.huang" <zhaoyang.huang@unisoc.com>, Andrew Morton <akpm@linux-foundation.org>, 
	Jens Axboe <axboe@kernel.dk>, Yu Zhao <yuzhao@google.com>, 
	Niklas Cassel <niklas.cassel@wdc.com>, "Martin K . Petersen" <martin.petersen@oracle.com>, 
	Hannes Reinecke <hare@suse.de>, Linus Walleij <linus.walleij@linaro.org>, linux-mm@kvack.org, 
	linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
	steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 5:54=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 1/25/24 18:37, Zhaoyang Huang wrote:
> > Actually, the activity information comes from page's history (recorded
> > at page cache's slot) instead of user space in step(1) and can be
> > associate with bio in step(2) or iterate the bio in step(3)
> > page fault(or vfs)(1)
> > |
> > alloc_pages
> > |
> > add_page_to_pagecache(get the page's activity information)
> > |
> > fs_readpage
> > |
> > bio_add_page(2)
> > |
>
> set your prio here. No change to the block layer needed. That is FS land.
Yes, that is what I suggested in patchv3 which keeps the block layer
clean by introducing a set of helper functions which wrap up the
activity things for FS utilization.
>
> > submit_bio(3)
>
>
> --
> Damien Le Moal
> Western Digital Research
>

