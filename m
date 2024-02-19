Return-Path: <linux-kernel+bounces-71907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0DFE85AC59
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 20:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CDDE283EBE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 19:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B15C5466C;
	Mon, 19 Feb 2024 19:47:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b="XLmyjSXV"
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9EB53E23
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 19:47:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372038; cv=none; b=HuYGSDpysGf3k6m6nyacXxo5mgoo98rkybLGJJgy+ToMI76MniFober27D++2AurfbshryT9DX/Gbj8juGO2BQJmIeUX95RBvCvnYlGvZxaOgLqJcQlVwo6LulZ2jzeoYeOyOB10sE0z9icLFwLeDqAU3CLzGb/1dPpPs6u+C40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372038; c=relaxed/simple;
	bh=DUEcOGJ/rk/h3tWGjgVTrpMETTt0JGs4Wy0hdmAe7hc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=IwkF3yHSYXL2NvvLGtkvxr+JPowXDBLcZPjwx+dqgqDeNAY83OkZUqRH9vRS0RXtOx46Sm4WJBjpJvRi7xDDYHjesHJYs78CYthLkDVgckUY4TwWEbfUnaCLSqQQQ44YoVWb/ii23ZGEz9qxaiR94eLq8gl8OK91YBLueBdN/NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre-com.20230601.gappssmtp.com header.i=@baylibre-com.20230601.gappssmtp.com header.b=XLmyjSXV; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2d109e7bed2so62082271fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:47:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20230601.gappssmtp.com; s=20230601; t=1708372035; x=1708976835; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DUEcOGJ/rk/h3tWGjgVTrpMETTt0JGs4Wy0hdmAe7hc=;
        b=XLmyjSXVo+QrZsw56/6y5wko9M58YoqckmwPn7YSTnJ/wx3/+LSB05Ry8C67muEgAn
         OSsjHKYvLcBbwIm+e399HA5BszIw5pfaJSIl+Ytmj4z1Z3V+3tyGLOydXaOThogoIN5D
         RGTBfPSy8u5LOp5PBxalDAGEvB+XiFv/pW2ZxbQVFLhVmA9icDJn4PsJV4McbvOPtOlN
         mSbLDBxE9q2d9HZ6Lc1bHmwhStHXAa3n56ngTYxuoPhIg6gjQ+jSWWTP0ttZlo3E0QM4
         jSHXRu2CMe8NO5BIxeJOfZevdGQOXv5H+9tTze39y/fkMOMpCfrnE+8EzNZef6TePogp
         yuEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708372035; x=1708976835;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DUEcOGJ/rk/h3tWGjgVTrpMETTt0JGs4Wy0hdmAe7hc=;
        b=UxZikmunT9Q+BHVyqC/X9khzyxMACRqHecwC3hfPqzHm/iSmoYElf5EBOc/8a2OQov
         Md2r80zGOF9aTnGO6dE29VrSYp1HUBbwnpKutepmjMtAtOFtH5qq1J6wah1M4lTyXPdQ
         DJ0B9Q/M4GJF/qiyyBmk3DUprYR7StfQiBUiJZG9a+zX0ZCmuvuAjc/LYcONDObctGSa
         GkvflLWAVZeuCXAQVAxH2tDcWfvMzA+vpsMoRdSXVQ4/EHu3qEhGFMAvpczRbUkaZ4T+
         XKSWlAV5BCdHvoq9eorCcUQDOc40Y7UnHfOCRn+1X69N94YthmZArWtyLIp7UGVztJkK
         YiNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHz3K43C1SSk+xcxXx6MFpxG26nMMVC9RUOWRHZb2wjR3VwLW3I1Ijje6R/HIkagiJGFKvIyhrLrEAg+36Kc2mH+sxiSIq4upUjKqW
X-Gm-Message-State: AOJu0YzShWso7L8sdi/VYKIJL2nxmiGVVzHqEV26aiyUR8GL8WdIPTNH
	d5mw4s49SXJrvBwv3VAxe8+dpsoCiIG5f2i3sLui1soAYaOVKbKdlSPPQa51HyDouAT5NxaIEk7
	x1BKPPGiIN70E7u8dNNeGF5GIDIS3a7vz2fF0+w==
X-Google-Smtp-Source: AGHT+IHE5s1bWp7Lf0AEexy1WLGcMX0Xnpkd5+kSp3lWcLT3lfjbcJg3I29Wo+/9DZEaxxVZN3gD4R3V3ERbgvjwPck=
X-Received: by 2002:a2e:7202:0:b0:2d2:3a8e:e2b4 with SMTP id
 n2-20020a2e7202000000b002d23a8ee2b4mr2113220ljc.42.1708372034915; Mon, 19 Feb
 2024 11:47:14 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110-ad7380-mainline-v4-0-93a1d96b50fa@baylibre.com> <20240110-ad7380-mainline-v4-2-93a1d96b50fa@baylibre.com>
In-Reply-To: <20240110-ad7380-mainline-v4-2-93a1d96b50fa@baylibre.com>
From: David Lechner <dlechner@baylibre.com>
Date: Mon, 19 Feb 2024 13:47:03 -0600
Message-ID: <CAMknhBGkUP2Tdze5Fa_0qTcCP_OgcTxtczKYZiH1icfuTAEe+g@mail.gmail.com>
Subject: Re: [PATCH v4 2/2] iio: adc: ad7380: new driver for AD7380 ADCs
To: linux-iio@vger.kernel.org, devicetree@vger.kernel.org
Cc: Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Jonathan Cameron <jic23@kernel.org>, Michael Hennerich <michael.hennerich@analog.com>, 
	=?UTF-8?B?TnVubyBTw6E=?= <nuno.sa@analog.com>, 
	Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, linux-kernel@vger.kernel.org, 
	Stefan Popa <stefan.popa@analog.com>, Julien Stephan <jstephan@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 2:29=E2=80=AFPM David Lechner <dlechner@baylibre.co=
m> wrote:

..

> +
> +/* fully differential */
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7380_channels, 16);
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7381_channels, 14);
> +/* pseudo differential */
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7383_channels, 16);
> +DEFINE_AD7380_DIFFERENTIAL_2_CHANNEL(ad7384_channels, 14);
> +

Similar question to [1] in light of [2]: Since AD7383 and AD7384 are
pseudo-differential, should we handle them differently? I.e. add
aina-supply and ainb-supply DT properties for the negative inputs
(typically a V_REF / 2 supply) and remove the differential flag from
the channel spec.

[1]: https://lore.kernel.org/linux-iio/CAMknhBH2Pqa9xpPxnTCxJegVTbOG-QDeJA4=
YrQUPfj+hfSs73A@mail.gmail.com/
[2]: https://lore.kernel.org/linux-iio/CAMknhBF5mAsN1c-194Qwa5oKmqKzef2khXn=
qA1cSdKpWHKWp0w@mail.gmail.com/

