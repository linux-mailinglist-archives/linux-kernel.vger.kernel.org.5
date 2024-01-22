Return-Path: <linux-kernel+bounces-32637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B3DD835E4B
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:34:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF0D9282789
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 09:33:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31E6F39FC9;
	Mon, 22 Jan 2024 09:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="mCg0coWk"
Received: from mail-ua1-f49.google.com (mail-ua1-f49.google.com [209.85.222.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2034239AD6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 09:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705916021; cv=none; b=RaxR2Q6M6jjw0mhiH0HuGMKhEr1m8ZEx5OJ/EMked8LiAkWEjEmcUmIP+NOOdhpLWdWhiOU6XW9FMd6TuFed90i/FrqLwV4AD+bm6GFTff63OHb63DnTJz4Jrhkycm7xmlv1HhaUHjIK57EtVJ7RHgVg1LlAWC3ITtP9mRjnEqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705916021; c=relaxed/simple;
	bh=A4OLVR1U5sP3BcJwe2KfRh8bKYvqXPPv7B/ABm1pOgU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zi+94b21jWkI3LSRhewzfrCOaDXZQ/u8wdqNICwvpG4v5qGKRNNOavIcP0WwVqXn9CCQxyr+hVukTF4pYcDcFJLhA2+42tXHZa8dScRf0IrjYWuhVAMH09t6gdho6gHIXq39UDF1JPERoCA14cF2I1GYJgh1h4qQs9f75dosxeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=mCg0coWk; arc=none smtp.client-ip=209.85.222.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f49.google.com with SMTP id a1e0cc1a2514c-7cecc0a662dso901357241.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 01:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705916019; x=1706520819; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OB0KQZsTaykP5uaI0wj0BAvpVtT3DPRwwyH1LKYHhoo=;
        b=mCg0coWkBjwnf7wK7DC161CYnF2ZyxFAiWVYPCy5b4H6fJmnYQxdLN4gZkgS5j9suw
         ATi5hX845GjlCfppl1K2Fqoicx6edSahUeAXYpDaOecctovkPtpfCzmUbcolLYEsl75h
         Szgiy6/j0pn65B0+ikJUPqjLDoIFgkR2q2l2flUuqww6Cab96Cz8+AeoTbnp1XS+HQ1E
         13LM86MkbcV+oB/Cn/HOdZemKOX/1bXNzwiImWlLsLgpQU76IkGyXSzXUZ5FVJjIGco6
         8vkltjpEaX23na4NAsJ5wUNSNx8fu5FFVzVFqVQZPC6CqpPYaxKhmXZAZop8oLeocycP
         P0EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705916019; x=1706520819;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OB0KQZsTaykP5uaI0wj0BAvpVtT3DPRwwyH1LKYHhoo=;
        b=SrwCyb882P+N9OVJRZVqb9qhY7BPmlM0Bp3yWPKyAbwiYxUnyFPh7DJPfmvpaCd3gL
         mIBoqUVgJdfj9M+cyUqczTo5p/g62CFtm3mqEaoxlM6a+VAY4nVu+tFjRXeCO152ypB4
         Emh3lwlJYsZheb6snh7z9QLXrmCEplti7ao+whHgc46t+tFdBbzTe3KD9b+OC9tX+3PO
         86xFgXsoCHvnzeOGAVh22luEN5cpanulMf+rOP+Zj6wCh24ZQTU1wcHImKbQcdLYQpfH
         D52/uF+3WuSvF6KcAYGI4aBF3uAoxqjb6ze71D2aCI+3OwtT8zbE0w45RgRsvbwKZBBz
         +hOQ==
X-Gm-Message-State: AOJu0Yz/ZDWQIoT0JrhPx+mYWXMmEk5526YJPoUi6sPtlJ0eG/x3dnA0
	KNAwS0fJG4AB/uPnfzKfQoCFy36+y+QhToxGOtLBwvNggHubcwxP1o3jnOXvuZnauposSaaVsQH
	372Nybc3crIAhAWJTtqKoeAkv+HZtSLqSrD3uWA==
X-Google-Smtp-Source: AGHT+IFpe/zMWRW1pGpT6CeZ0tmnmNb2Td5Ajn3RviQSYC9NVUJEaRRmoCGLuplnb/dOV9OwpbBaqVjkAInLQpJCjfc=
X-Received: by 2002:a1f:4a87:0:b0:4b7:6c2f:fdb0 with SMTP id
 x129-20020a1f4a87000000b004b76c2ffdb0mr733556vka.0.1705916019043; Mon, 22 Jan
 2024 01:33:39 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109073849.10791-1-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240109073849.10791-1-Wenhua.Lin@unisoc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jan 2024 10:33:28 +0100
Message-ID: <CAMRc=Mei0w8tCXFd-vO_SZLxYkNUWCqbEBV59Go-2LdXKs11nA@mail.gmail.com>
Subject: Re: [PATCH V4 0/2] gpio: sprd: Modification of UNISOC Platform EIC Driver
To: Wenhua Lin <Wenhua.Lin@unisoc.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Andy Shevchenko <andy@kernel.org>, 
	Orson Zhai <orsonzhai@gmail.com>, Baolin Wang <baolin.wang@linux.alibaba.com>, 
	Chunyan Zhang <zhang.lyra@gmail.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, wenhua lin <wenhua.lin1994@gmail.com>, 
	Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 9, 2024 at 8:39=E2=80=AFAM Wenhua Lin <Wenhua.Lin@unisoc.com> w=
rote:
>
> Recently, some bugs have been discovered during use, and patch1
> are bug fixes. Also, this patchset add optimization:
> patch2 optimization the calculation method of eic number.
>
> Change in V4:
>
> -Add Fixes tag in PATCH 1/2.
> -Change commit message in PATCH 1/2.
> -Add clearing interrupt to debounce and latch mode in PATCH 1/2.
>
> -Change commit message in PATCH 2/2.
> -Delete SPRD_EIC_VAR_DATA macro in PATCH 2/2.
>
> Wenhua Lin (2):
>   gpio: eic-sprd: Clear interrupt after set the interrupt type
>   gpio: eic-sprd: Optimize the calculation method of eic number
>
>  drivers/gpio/gpio-eic-sprd.c | 42 +++++++++++++++++++++++++++---------
>  1 file changed, 32 insertions(+), 10 deletions(-)
>
> --
> 2.17.1
>
>

Hey,

Can we get an Ack and (preferably) a Tested-by from the SPRD
maintainers, please?

Bart

