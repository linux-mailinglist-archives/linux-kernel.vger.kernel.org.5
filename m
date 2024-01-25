Return-Path: <linux-kernel+bounces-38276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A594583BD70
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 10:35:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55472281E61
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 09:35:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB102031E;
	Thu, 25 Jan 2024 09:33:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KFbLaFf+"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49A74200C7;
	Thu, 25 Jan 2024 09:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706175183; cv=none; b=PcjP/Ey6Bp7Qex8qk5QewE7sAe+NBgyTQeQtrar77vfeRHUdMunTP/p/JPiJimmlG3qFc+3S1Al926ikE8VTp1ESVpsbhCTY+AMn5x1bxYMQaC9L162HoC7DSEsOs9CzvysPAzN9+k3co5NdJviZcOT2kS7tS7C9T9EuXqW1mJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706175183; c=relaxed/simple;
	bh=x5hqVLU8CoA4s0xQoY88RQhPoRuUkCm6lyBsX2EB/Gw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ba6Zoz295wO5g9XzL7rUee9R64JHFKbCY8VhsKRHaGR7XDSXqNE+WY4rGxBw7L21Wa3fyagbRkfdEHzUiUV61DaJwwNwtHY58jv5FDna8WBJA3Y3AaPQ49Cs35klxYEodfQbldXyzMtlZGDhqpIe0f7R4Yyqtghp16fMuodFt3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KFbLaFf+; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5100cb238bcso3642204e87.3;
        Thu, 25 Jan 2024 01:33:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706175179; x=1706779979; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WXpA01mh+uoqFSOs4uTrSuWJ4K282ZLZOddu5UiLmkI=;
        b=KFbLaFf+LCPumyRb7GgHquV958M7oNqgKvNBBc8p7zQQGPlPwOQ4Lu3f1+ayv8hhfO
         MCB1IaZ5SKbOKOluRQ+Qix44I8d/qHZaNj2aTa7jNBIrm5wH0DzytsNMO+F2gJxnk72c
         Y4IrO4z1GAYPbt1FyKmMackEZReOcehv8J6gqrc3l6oY6CFG9BFmLNkPzogVuNHD24UF
         5+IYmDDe37XtpKya1BeL9QVd/RURZexH/x5pGxCfFlhgxRe6vIZy85EURLZNMFhnDpDd
         fT/xn4Yvf1lyrZSIapRqWJteM4Tq1M0lapEfF+kWD/5ZnjRE0gOwFg1H0+KZyLlYJWpF
         Yy1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706175179; x=1706779979;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WXpA01mh+uoqFSOs4uTrSuWJ4K282ZLZOddu5UiLmkI=;
        b=S/A5i7mvLAUggi1X9f/lU5GIP8M+rY6dRx7LwqlTBqh05FqqPWsP9tKuAdsCzAGfDp
         ++0tvhQqAF+fcPvui6TSk2IiIELZtfNGw0WEHHGfYWUihAMdXnmpa2MyHqGKoSJdzH8z
         9vORoU/sX0LaC2w4Z2OhI5ILU5zXTQNtaMKT6L8LeRmTP877l3BqOdJfIPqCW5hmLecg
         yhdrZ9yUsA46B0YfQWoWNaaWvAIS3T3d1N9DdiG+o24GsD81LwbHkGROopohfsWUMn1y
         1BpGWtypbYrFVDr7q4fMpmTJw2ujcwPQzy3XeIL3+uHmBeS/iYk0BSIzaGqcpBzXznyp
         PN+w==
X-Gm-Message-State: AOJu0Yw6pdkVbezJdh6BbDsZ1txhCWxdbQo3IM41i7LiGOnZbH1tuZkn
	0tL6C0XoEgW3RNsVAGMaFnTiTiwgvWVcfg6YR5HaD8OgJLbhc6QP18vFOFyVbng420NSi+el1MZ
	em/rG5y1WTrjYkaIPubrIz9vtjJM=
X-Google-Smtp-Source: AGHT+IEpAN37g8lQLWY17BHVRMY5kv2VlCPoXzDwLx7v6JaIe9FJuFcnMcVKK5aAhAryJtEYCMvqwl5apgN50iGJRsM=
X-Received: by 2002:a19:6554:0:b0:50e:aa1e:d994 with SMTP id
 c20-20020a196554000000b0050eaa1ed994mr305289lfj.91.1706175179064; Thu, 25 Jan
 2024 01:32:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125071901.3223188-1-zhaoyang.huang@unisoc.com>
 <6b2d5694-f802-43a4-a0fd-1c8e34f8e69a@kernel.org> <CAGWkznHK5UPajY2PG24Jm7+A0c9q+tyQzrPdd=n3tp0dgX+T0w@mail.gmail.com>
 <95082224-a61d-4f4b-bc96-1beea8aa93a9@kernel.org>
In-Reply-To: <95082224-a61d-4f4b-bc96-1beea8aa93a9@kernel.org>
From: Zhaoyang Huang <huangzhaoyang@gmail.com>
Date: Thu, 25 Jan 2024 17:32:47 +0800
Message-ID: <CAGWkznGe+37K7_E34G_MZQXNxoLuM3E0mY=BZCGpyiq+TB_PoA@mail.gmail.com>
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

On Thu, Jan 25, 2024 at 4:26=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org>=
 wrote:
>
> On 1/25/24 16:52, Zhaoyang Huang wrote:
> > On Thu, Jan 25, 2024 at 3:40=E2=80=AFPM Damien Le Moal <dlemoal@kernel.=
org> wrote:
> >>
> >> On 1/25/24 16:19, zhaoyang.huang wrote:
> >>> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >>>
> >>> Currently, request's ioprio are set via task's schedule priority(when=
 no
> >>> blkcg configured), which has high priority tasks possess the privileg=
e on
> >>> both of CPU and IO scheduling.
> >>> This commit works as a hint of original policy by promoting the reque=
st ioprio
> >>> based on the page/folio's activity. The original idea comes from LRU_=
GEN
> >>> which provides more precised folio activity than before. This commit =
try
> >>> to adjust the request's ioprio when certain part of its folios are ho=
t,
> >>> which indicate that this request carry important contents and need be
> >>> scheduled ealier.
> >>>
> >>> This commit is verified on a v6.6 6GB RAM android14 system via 4 test=
 cases
> >>> by changing the bio_add_page/folio API in ext4 and f2fs.
> >>
> >> And as mentioned already by Chrisoph and Jens, why don't you just simp=
ly set
> >> bio->bi_ioprio to the value you want before calling submit_bio() in th=
ese file
> >> systems ? Why all the hacking of the priority code for that ? That is =
not
> >> justified at all.
> >>
> >> Furthermore, the activity things reduces the ioprio hint bits to the b=
are
> >> minimum 3 bits necessary for command duration limits. Not great. But i=
f you
> >> simply set the prio class based on your activity algorithm, you do not=
 need to
> >> change all that.
> > That is because bio->io_prio changes during bio grows with adding
> > different activity pages in. I have to wrap these into an API which
> > has both of fs and block be transparent to the process.
>
> Pages are not added to BIOs on the fly. The FS does bio_add_page() or sim=
ilar
> (it can be a get user pages for direct IOs) and then calls bio_submit(). =
Between
> these 2, you can set your IO priority according to how many pages you hav=
e.
Please correct me if I am wrong. So you suggest iterating the
request->bios->bvecs(pages) before final submit_bio? Is it too costly
and introduces too many modifications on each fs.
>
> You can even likely do all of this based on the iocb (and use iocb->ki_io=
prio to
> set the prio), so before one starts allocating and setting up BIOs to pro=
cess
> the user IO.
Actually, the activity information comes from page's history (recorded
at page cache's slot) instead of user space in step(1) and can be
associate with bio in step(2) or iterate the bio in step(3)

page fault        \
(1)
                              (2)                       (3)
                          allocate_pages=3D=3D>add_page_to_page_cache(get
activity information)=3D=3D>xxx_readpage=3D=3D>bio_add_page=3D=3D>submit_bi=
o
vfs read/write  /
>
> --
> Damien Le Moal
> Western Digital Research
>

