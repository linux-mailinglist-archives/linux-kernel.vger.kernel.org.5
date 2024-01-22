Return-Path: <linux-kernel+bounces-32770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D397835FE7
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 100491F22BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CBAF3A1C9;
	Mon, 22 Jan 2024 10:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bnCvsehv"
Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F39003A1BB
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920191; cv=none; b=f0s2ynazRADifrgwa822Nrsc6St/Ly82Re4n2j8iyJI3yTiLcjIKKN0nh2P5EtNpy3FTw2SJS856x6bI7NMI49fQjFyAW2yB5PQXeocyCxMin/HvTgQ0K5HFib5nrAJgP7+Lq8VWcR1KO6J3ci/cm59u0MitBcC+Gh2b4fKYglw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920191; c=relaxed/simple;
	bh=5oqYQROB0Kj2f8NSD92TqgIP99V4g9fCFB4CjLVyyV4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=p66Jv+bREiAIxSJF3+MiJYW27B8B3WQdLW/mYZSq/meD8kljK3HbAdPtQ+AVf5ILbE3q7jH3B07qjaUKuprSRU30N7Ps6zginBWlMsdlrwE5ToumNmOkLwJNMA4Or8kigxgZJKj9mObAUzH2dgqFSyRVWQkSXQHDJwedAHr7Aoo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=bnCvsehv; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-4b87d79a7d8so388595e0c.3
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:43:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1705920188; x=1706524988; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eZ55j/ic0rlHf/Ykc3pQwAhrvY4/zhXCceLbvJQAmvM=;
        b=bnCvsehvxEoBF5LmcVhP8uirvA4ngWAmg2rnk0onf3bAuENo3HVNp5Dikn1+7QpiCw
         dttXHjMAhsBOES80Zmavh3pXt1N1c56+DPM83Q493gTWExiFa32SUB8QtqyiiVvhaE7n
         XTCaOlmj5ClUVnWooQyfrgv4jd4yxxz16KbS0+Bou3BFO6A0+PbLXW0F+lgb0AMKHL2u
         muXlyGlJK6i2aYftSntivhucnD+R2K84lAFEzaJoDhVEVuXLCaGRigPLg8/stk7whaZf
         GLKYy8+K0d5btkkcj6V9lV4DCzMtWD3y/B6LW8HhPaE4oUSw3Gc7ekLNu5xg6UAJiOQb
         RrVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920188; x=1706524988;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eZ55j/ic0rlHf/Ykc3pQwAhrvY4/zhXCceLbvJQAmvM=;
        b=xCxbfvVQ+8g145jDAE3XVn7baVdz3ATTlJ2Bpr1RxryqdvFhhNR/QJ9o0y9fm7VMKI
         IrpgBWhtHZcNTq8k+HPP/07+u8tu6IM/Ojcp7B92w1gopim9Qv8RTzbYw8tsosDhBsoB
         9BwlzGqE1YmOYDvlkGrXYqXxre6oDV5NKeyPp0UvaBtYQzNWfJBiJQnRfQ6LSTYNU0x/
         n4C7fJmCw6A19KWlU/Qya5GcsXI7jHWpTKT2YyoMcVK6nKpS0DSu5wV2oXUmA+CIa1RJ
         A5KuKw4N7Mo7dKAW8znfENRcejPOOQEA2/Yr2sfv8XCWHy1kwDfJr4I20lSQmfoSUD3H
         UDcg==
X-Gm-Message-State: AOJu0YyKCo7rxT8EqMy0fYsZA51VUJu1UHR1uLu8NWsw0OTDmqJVeapR
	QscWhM9Rxey0rb96+DRjJ2Q8nfEv2T71kim0cjzwORdfhhAI3K3kgOy/JU9UEYD/GjusX+We/jE
	b/9pvXJcs7feYmcVFF9bBNIut63d1snh4GlnsFA==
X-Google-Smtp-Source: AGHT+IF1TIaX+t9YjEAstpv56CbaerSKTUHPfO230BN/T3RswE0B36KNdIUciwzmYxJsCxfuy7UdE7RTQ9m1WbEgsd8=
X-Received: by 2002:a05:6122:3bd1:b0:4b6:dccf:72f1 with SMTP id
 ft17-20020a0561223bd100b004b6dccf72f1mr973391vkb.7.1705920187881; Mon, 22 Jan
 2024 02:43:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240109073849.10791-1-Wenhua.Lin@unisoc.com>
In-Reply-To: <20240109073849.10791-1-Wenhua.Lin@unisoc.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Mon, 22 Jan 2024 11:42:57 +0100
Message-ID: <CAMRc=Mf+UJN3BXBMrQxqLqRJrbmgoJ4kU_B5Mr+7MHvYt_aYvw@mail.gmail.com>
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

Applied with Acks from Chunyan.

Bartosz

