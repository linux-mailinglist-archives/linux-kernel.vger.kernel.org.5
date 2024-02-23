Return-Path: <linux-kernel+bounces-77961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE88860D5D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:58:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 780EE286CF1
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B3B1B7F9;
	Fri, 23 Feb 2024 08:58:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="pwMM3GwF"
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 690161B59E
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 08:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708678698; cv=none; b=iQHKLpj9nH1Qos+qsGWlcIWNM+5RcleyBsGu4e0S2DMAVF6zaCUQVUfx7igvJbPYV+4/D48lWVOR/5ikRnn/0LoFvwvxoDJIByF58rjfm2naLycqRCgiwHV9gDM3bpSgQLkhW9znEDe1zLbuwZ/v7VLYiIbQbsSh/4NQinuLKZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708678698; c=relaxed/simple;
	bh=RLhd7qhilfOEGtRcVtu/Mz8cYidTto0DEhynq7GPsgE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sh40yxryVqIMyU2epR3h7wHmonq99FgPaE/oC1g5xRkEqEvxiDwbUrKgbpp17YRHCElYXWdrBZr1OOpaQeZz3ELf9K94MFNhBdu/d/nNzsyBRtoxZhdAsTVwZ0qRSO+cBCcl5CHqPUvQTI5iXmOaDziW6W1iWqUpTmIRQ/mJX5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=pwMM3GwF; arc=none smtp.client-ip=209.85.217.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-vs1-f45.google.com with SMTP id ada2fe7eead31-47044462962so28450137.1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 00:58:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708678696; x=1709283496; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RLhd7qhilfOEGtRcVtu/Mz8cYidTto0DEhynq7GPsgE=;
        b=pwMM3GwFG1vtuJFVhPcltNmXMdwE5zK7WCSoi9dCnQ28z3kmGwKFzBu9MV3/G5U9eY
         R9AsPkinyOfrTs4IXU5hw8OnhgLOdK17N+ABixFN7oZliA39Xo6nJUY0EZE5kEXgXsjf
         juO/6nGfu3CDE9HFIet87XtXpmHwCe692W43K2OdXudRiDfGIVVQpjWarAyyrgD4PvTb
         A1H9w/Nc1ZGf9X2cUoMD8Y8zhpjJqMsO/D2/beH+6g6inCnUTHHjYmubFltYwTTMb7dE
         LNuCAwegn4F2mnK27RttctCK+zbuv9s0YMvAyeYYl277l4dY24l6zh3dKyUt7pZADsvc
         aiCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708678696; x=1709283496;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RLhd7qhilfOEGtRcVtu/Mz8cYidTto0DEhynq7GPsgE=;
        b=Zy02BWm4lpVhH6AA5grbyQB5nogKYoASp6HX5CGjUhcOHy6FOtht3Kt5nm85TAytVt
         N5Iu/TVR0guBoa4kY214u2SZHcPfTzeK9gdfITYiiQfAnskxtX8ygftqNNgKszMOc5wj
         9KfDvgsyrtOB8+JybY6QgdnWcRjLSnyR9moRFUj8kuqWbkywloe0lcapum7jq3KsNvy8
         IK1MYtdPCp0C8DXIHfB6/aPUhUsyC32bbIUEf0a9q1qaEz6yTv1Okb1wmouP0Cws/cQf
         M2n+fGo0DpFyozWRqadSGcY77tw6yNyXZzjmcdBwGA/KJuDsgaGGXZEGxDVW1oT06maG
         DntQ==
X-Forwarded-Encrypted: i=1; AJvYcCWStxTeLkOIffsUqQ6i1uCaFEetSmqMLPEhf8UEE08uQDyRv9Be1uXlEFgKoGA5gTvLhFQf3hyp64GdaC/PtLq001zaUkPKxF6OuDhq
X-Gm-Message-State: AOJu0YwJOOcz56vuikJ6s3Mzi5lhSYAFTTvk/cFlKPk6+VlTMWfybqid
	D7600SU1pnsxC7XLHvDbjWEf0FAcfY4w9uBy4ll5gWOFdkKGwr2CSqBFL2d5myNjhMy/2pUG7IP
	FPGbBVU1ihzgYD4k+rnfye37ktqLR36RtLpXbKw==
X-Google-Smtp-Source: AGHT+IGqMdtDrEnxt1J9qHmJj25RU9IrbUByJvWaLHbMztnXmiCKb+ttA6tN2tXEYCkSVRk4k6/V2C+1NNwDiOYjK/k=
X-Received: by 2002:a05:6102:54a3:b0:46e:e861:fb09 with SMTP id
 bk35-20020a05610254a300b0046ee861fb09mr1258425vsb.2.1708678696218; Fri, 23
 Feb 2024 00:58:16 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221102103.10099-1-brgl@bgdev.pl>
In-Reply-To: <20240221102103.10099-1-brgl@bgdev.pl>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Fri, 23 Feb 2024 09:58:05 +0100
Message-ID: <CAMRc=MdQkO4B+-szx0Q98S3hFdM2RA9c5JCRpG3zCuy-hZf2wQ@mail.gmail.com>
Subject: Re: [PATCH] gpio: don't warn about removing GPIO chips with active
 users anymore
To: Bartosz Golaszewski <brgl@bgdev.pl>, Kent Gibson <warthog618@gmail.com>, 
	Linus Walleij <linus.walleij@linaro.org>, Herve Codina <herve.codina@bootlin.com>
Cc: linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 21, 2024 at 11:21=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl=
> wrote:
>
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> With SRCU we can now correctly handle the situation when a GPIO provider
> is removed while having users still holding references to GPIO
> descriptors. Remove all warnings emitted in this situation.
>
> Suggested-by: Kent Gibson <warthog618@gmail.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---

Patch applied.

Bart

