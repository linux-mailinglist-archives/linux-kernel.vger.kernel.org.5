Return-Path: <linux-kernel+bounces-117906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C1A688B11F
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:16:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DE521C62905
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC3F64F1E2;
	Mon, 25 Mar 2024 20:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="iuCw32tm"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9204C637
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 20:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397675; cv=none; b=u7ZQP3AdMprOv9PigQSoZoqlERgYE3h5flAynmbxXKHoGYPgHG1LjIGB+zIEcZVhoC7zxSQ0am4rlrfN5vuwfkIKsVYRDWs7prR7v3JU146Ypebd/mhp9RJb5Rjdk2N05uSzA4B1q4CRWs+1ZzNkdOszcvvN6bzjxU8iAKrxYM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397675; c=relaxed/simple;
	bh=y/Copnmio+r4JHJn7cH1SHr0SKFHmhJFbDXHchbZThs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=X/vey5XF6im0g1IeWHkbysCeHYvtvX/gLUu9Z/5rP3Bzl8aAuzRgue/BrqIvF2+VEqdvDi8l4BAuyfPq1EtZUEFeSEKuFusNibvKbSEahbTcR6Ml15bLMQ2X2EhGfR3ZvTpC8CZ300okpEY+Lq2yTugVp1b1NM7H2IHmLgMs7uc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=iuCw32tm; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d6dda3adb9so11226971fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 13:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1711397671; x=1712002471; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y/Copnmio+r4JHJn7cH1SHr0SKFHmhJFbDXHchbZThs=;
        b=iuCw32tmWhnvpIewveu6AYiYQem76Mvuok28exwJhKuuVd9PPE3un09zFyzpvWdRCI
         TZAgsWjtKBs9iUKm9xLnRdpCeXrwLHmzTQ12WFULfOw+pLRcf7IpcXjAmu1DzvQqeWJa
         s8H0kNyJtbA4e3VwLQPNXDk32TUumk7eYDBv/2xA0aYs71xBTurLoZfCp838PSBMSuTv
         Oo5XXzKCJ5hoknalahHv1ODni1grES9CSg6/6j+6Tx8jrdqkaynTSv7IwSTKM0eowuw2
         aGtWqxcOV8O7XK07cWN8s+HEZF58qR1/aQAeA65XXbZSlyXcWWJaH/snXMGk23zF4h/w
         x6kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711397671; x=1712002471;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/Copnmio+r4JHJn7cH1SHr0SKFHmhJFbDXHchbZThs=;
        b=NXzVj+NEm2j0f7Kb6IJNNg3VHDkxaWe7O/ySKhWmibkUO8izWg/+Fw5c7QjX7xnbiP
         qVVg5KtED5ThtP51PozmzHnhzbDQo/ZUtpVh8SFW+b0sbwVqrFQnlQ/q3LEV9gn62K2S
         C5ySykau0+UoZymBpU9rOWXcH7vdOVfYMF7cU34xcxij+1njqwO7mtHx4cD9ewSsS6n+
         6P6UqrLSo7jmXBfsGKlT/d967YipLRUgrxH0xsfhjnHr33o9D52ffggmItH5OI/jMbnI
         LhTpQYdD2aDb4LfgnN1XMzKsTthFpi1DVnrf4iuUp3JihFVzC1KS77ku1JVAVn13Oie/
         6UZQ==
X-Forwarded-Encrypted: i=1; AJvYcCVjS/P/Y3KkPyZVUk8vGNBGnL0XGoEnU/Xt3GfltMoaEQzICY4NCtfgTLNabbicY/5E8WqsXKw9xBTWaeUJrCQPdSjR8fna2h7MWd7N
X-Gm-Message-State: AOJu0YzvoE7ZwaClDbGhvX7ytYs79CwG87c6wQuUG6jDA2iLDc6hm22G
	Z572DSmP+DoOvsbdZTvi+CAzkKWq7UqnmGnZyhn5Ph3y8fpTX/9eMFUBk6OlTg9eKkl5gwRHhcS
	aDGQks/VyO873SB9aZjdjbrP8uTV+NHMVR8KIOQ==
X-Google-Smtp-Source: AGHT+IFxfzGP4GDD9D61DOApZnzJcZ5mRVakIzo2HcSyu+da0kxkxSHBt5x0XHbve5H0YnB5oZP4U6ETJVrQilfX3uE=
X-Received: by 2002:a05:651c:b0f:b0:2d6:a2cd:bb8c with SMTP id
 b15-20020a05651c0b0f00b002d6a2cdbb8cmr657809ljr.10.1711397670501; Mon, 25 Mar
 2024 13:14:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319-adding-new-ad738x-driver-v5-0-ce7df004ceb3@baylibre.com>
 <20240319-adding-new-ad738x-driver-v5-4-ce7df004ceb3@baylibre.com>
 <20240324130135.35f4b0eb@jic23-huawei> <CAMknhBGmM7yt1JR1tW4SS5RLGpN9PtnMrf0WvZ-bhU-gSv3YUQ@mail.gmail.com>
 <20240325200625.5a07cec4@jic23-huawei>
In-Reply-To: <20240325200625.5a07cec4@jic23-huawei>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 25 Mar 2024 15:14:19 -0500
Message-ID: <CAMknhBHNhL62A8KY3vnNqQm+c+5M-0=w3qAWN=54FxYGjicUQw@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] iio: adc: ad7380: add support for
 pseudo-differential parts
To: Jonathan Cameron <jic23@kernel.org>
Cc: Mark Brown <broonie@kernel.org>, Julien Stephan <jstephan@baylibre.com>, 
	Lars-Peter Clausen <lars@metafoo.de>, Michael Hennerich <Michael.Hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Liam Girdwood <lgirdwood@gmail.com>, linux-iio@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel test robot <lkp@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 25, 2024 at 3:06=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
>
> >
> > But given that this is a common pattern in many IIO drivers, maybe we
> > make a devm_regulator_get_enable_get_voltage()? This would return the
> > voltage on success or an error code. (If the regulator subsystem
> > doesn't want this maybe we could have
> > devm_iio_regulator_get_enable_get_voltage()).
> >
> > If the dev_err_probe() calls were included in
> > devm_regulator_get_enable_get_voltage(), then the 10+ lines of code
> > here and in many other drivers to get the regulator, enable it, add
> > the reset action and get the voltage could be reduced to 3 lines.
>
> I like this proposal a lot. RFC, so it's visible outside the depths
> of this thread?

Yes, I can send an RFC separately so it doesn't hold up this patch/series.

> Particularly good as it will keep the regulator opaque in the same
> fashion as devm_regulator_get_enabled()
>
> As you say, we have a 'lot' of instances of this (quick grep
> suggests > 50 in IIO alone and smaller numbers elsewhere).
>

