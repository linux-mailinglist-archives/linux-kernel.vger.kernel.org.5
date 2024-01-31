Return-Path: <linux-kernel+bounces-46948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8C78446C2
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 19:08:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06A7F28BC75
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 18:08:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82CAA12FF7A;
	Wed, 31 Jan 2024 18:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="nBHmYp1U"
Received: from mail-ua1-f42.google.com (mail-ua1-f42.google.com [209.85.222.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 286E312DDB6
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 18:08:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706724516; cv=none; b=WVG/yodWFaF3JXCJZcCBZ77uGTvyVhtn1xItlw645uoNAjQKUyWPppg5NeiFsEQyYXlYb7cZOJb6bQg7vCZ3FU2TjD0DLqbsMu5cPr5C8wYEJSEscc/hzrDEzpOecAWQBCIfLx3xYIce/UE+Num5DGaGbw7DNj07jfTxl7Cyzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706724516; c=relaxed/simple;
	bh=/TqVe9oPbkha3IG0Da9VATsWwyM9nTOpqGNcQqestL0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgMFfL1LYy7G9TVmA6mJDMbcRkoGBr8GBmmfzBVkDxFR0e9KQfbA0h5AtuunQn7ZjYEoSiB2KTQ+BNKmLcnCIObnW1RmDzBul/4dBoJ/1cch8+udKIK+LAu7fI1kUxayfe/CNReGGS2Oip7Hcd1JWC6GoQoIaoOp/XgprAzOJ0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=nBHmYp1U; arc=none smtp.client-ip=209.85.222.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-ua1-f42.google.com with SMTP id a1e0cc1a2514c-7d5c2502ea2so42623241.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 10:08:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1706724514; x=1707329314; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/TqVe9oPbkha3IG0Da9VATsWwyM9nTOpqGNcQqestL0=;
        b=nBHmYp1Uuxr1sHICTyKntcPSlpXo1fWE5HjCLJIic/Hixx4NPPhedNhisc13iwB17Y
         ycVd8mfBia/+ttcqR3ou6ZHOiK2UUwB9SaDzPm42W8sXxyxgSKRVVTZ/PJ9H5hnlpxTS
         AFi4t6moy4MAbB8OPH1RcinD/YV2byiba89GQf/v9XLnejCPwas19onM6hBpqdzUQn8X
         LKZLOgvYGIqtDTnjR3RMA/i+JH7edHR0LHYUzaPFABx6zgsnkODIqVqXO/OwY5QY/9xM
         bLQhVROPRMeSE3dv2bXK+TaD5a+4bu9tpUO3O9PPysFHmWfsoZH6jzl5PbI5p3KlIbnD
         F/jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706724514; x=1707329314;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/TqVe9oPbkha3IG0Da9VATsWwyM9nTOpqGNcQqestL0=;
        b=rIPh/UresRRC+WhxWDsc8eCLZLtl0KCOeD2GY2Gxf7nFs3bCqokCKkxeBn/YL44aW1
         ubtWJiqvUYEIJ5IYbEoLkywzMuxfwjRv3YAsfXqqf9fzWlEtRcvOHCl2eAILmzm3P2EC
         scrOXYIZev9jR6CMgRuovl46i/xalYOwc9mi8p+N176d8oZ3nIJPDHIzpi5wr1+yzddv
         HM1Jgr02HKcUUXxud2MXC81l9XcPABpZjWKku2EwBWqpQpQohudjdFGJsihkDQAnHdnE
         XrCsg5LLmUwMCkHuw4U+iomq0UbsJMhjYm1W/Cpv7//avkXk67pCHufuinrpJ/qjGdFU
         CLNg==
X-Gm-Message-State: AOJu0YzFW2vByn5sAklFmm+8PTqWd499iGI5Mvg9YKg+80vmT1m4j74s
	XzgYwX65ajifxRXCpkpwt/6FYzKcE/6/xhBNpvUBiMucAVIwxGHGuuw6D5w8nf/XWMT2LCJxJ+r
	qvoN7aJHZgPPlaCtfERCXnbEd0ZQfIwWRjZHN9w==
X-Google-Smtp-Source: AGHT+IHSR1zkm9u0xTdCg4AnwUx5UxJxm92+kZ7qjzL2ndLDeyODEpEu4Tn2VdVNfFi3Lzs7lb3SIDs3OHvqs+2kpEE=
X-Received: by 2002:a05:6122:a20:b0:4bd:4356:40bc with SMTP id
 32-20020a0561220a2000b004bd435640bcmr2650075vkn.5.1706724513929; Wed, 31 Jan
 2024 10:08:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130124828.14678-1-brgl@bgdev.pl> <20240130124828.14678-4-brgl@bgdev.pl>
 <CACRpkdY_9=2Uqo9=ZEDrn+RFGdPkq73ZRYLVCbh6BLMzU9LZ_A@mail.gmail.com>
In-Reply-To: <CACRpkdY_9=2Uqo9=ZEDrn+RFGdPkq73ZRYLVCbh6BLMzU9LZ_A@mail.gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Wed, 31 Jan 2024 19:08:22 +0100
Message-ID: <CAMRc=Mdh5f_hrAh8BO4P9s0o_t9cT8FdfiY24-PQnPVz7QRZFA@mail.gmail.com>
Subject: Re: [PATCH 03/22] gpio: remove unused logging helpers
To: Linus Walleij <linus.walleij@linaro.org>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 31, 2024 at 6:39=E2=80=AFPM Linus Walleij <linus.walleij@linaro=
org> wrote:
>
> On Tue, Jan 30, 2024 at 1:48=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.p=
l> wrote:
>
> > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > The general rule of the kernel is to not provide symbols that have no
> > users upstream. Let's remove logging helpers that are not used anywhere=
.
> >
> > Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Seems unrelated to the rest of the patches but OK.
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
>
> Yours,
> Linus Walleij

It's kind of related because I'm later modifying the logging helpers
so I'm saving myself some work.

Bart

