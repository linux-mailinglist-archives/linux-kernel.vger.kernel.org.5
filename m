Return-Path: <linux-kernel+bounces-42416-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC08840116
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EE3281C2285E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 09:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F65654FA6;
	Mon, 29 Jan 2024 09:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jlJYNiyT"
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1002E54BED
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 09:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706519673; cv=none; b=Uq3Bqx4S9p6n4YHbhaAto1twnOjRJHrexTSqyz+Ah0kIWcRwPc81F11Wm7jiupR+21SWOQ4+hq1/eLsJ6hqlh8W8M1Gc0KEAmSSU3HfA9/KQOB4UfMTKxSu0cs6VMXf+dKa8IuVIsYjxDI8BL3XcZadp3Yb/Z4YFFDprczP28xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706519673; c=relaxed/simple;
	bh=vuRFhnAb0QvxdIswU7JMO3BMfaGNmH0kJhYkDLBQUeo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YwLKAkAwucLZbo3wANLc9XLe8XO6bj5/uTWgVghzFQF+8q74n7ixhNjtsYfT5S3PF0DjSepjD8DmRXlls/3cBjJNKRi5gJ+4yMktC7gxP0CjtpLjqNFjOx0r329wT0mtPT2Lat/cImZYyUHdsrMrTHWndVD5+h2o2wjVy67yW8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jlJYNiyT; arc=none smtp.client-ip=209.85.219.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f46.google.com with SMTP id 6a1803df08f44-68c41c070efso8482876d6.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 01:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706519670; x=1707124470; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIls3X+c7u3FdSJgCYO346X8vHVfzQy7RDRpONBzCs8=;
        b=jlJYNiyTVvtCtg+W42yTvBOR+eF7IDtXW19YrGQoYR0fz9hYHWLMTooGXy68RIDP4O
         9L7diEFLbNwW8nEBkDTPXGR7SnXPSpb2dMhVcz1D5no8zUvizefhkfAmVYrsQKYs6gQm
         0UrZxQD7bHWBg0on7Ew3ftl+YiZ1ToVuQazzemK20U23e/fSi31AGCdeZqxepDoB4Yxo
         0grg5qzjVXXFl7lARcVN5qbqAU1T0AZHDYiQtZcDIsHQJnqkrWLeTXFhHrwROPR4CYhW
         OiHoiO2RN8E5nepxFGIAn7rEBFydbg1mP4UjVPKn8DeFPxvYbY6+46yD6V0I1Rwzp6JH
         y6Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706519670; x=1707124470;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mIls3X+c7u3FdSJgCYO346X8vHVfzQy7RDRpONBzCs8=;
        b=bZkRwDt8Idu6OZMjh2vGhx6t5UDxbUz4IllqXs/UE//TtL1DsFzjIUgaaENXa/KSqw
         SQrhLhH8nyglu7xu51K8bXFlhECw3NZ0sLpSAl6QfynmCxs44z0pKxtW1YhjaS4O+qLW
         uWQF/5Yco5Ie4yfTpwLjfD1kMEEKYsviSjv9gcl6GUy4geTBw0WCEF9nmXw8uGY/vi7t
         cgCxhbKv9YaKnrOCmyoEG3DlZOvffcKu8XHTFh0V2gBoadRX8ajWlwFGoptex3Li1wSo
         JuFjG4QReNUW4ve884B6jIapSF9IZTBR+wkSd9N78vxi4yLTVyGxdcx8QVZyGxEilH+R
         Q+VA==
X-Gm-Message-State: AOJu0YyYWr75kuTEeRp8Y4QtWmscO1z74Rsb2oTNJuBNpQ8a5udQ6gf5
	MDD0HZXiuEJWSLOc/yiz3/w13lzC4kUAElK5NkuQN4anH9ad//q1zWIm6Xvk+/H2tM7z8p6c1o2
	ZT8kpntldbUNvWdW3Gw1z5C9nmpADK5H+Xy2m4w==
X-Google-Smtp-Source: AGHT+IFOcIWuTItyZKqMTQd4K9HAAjevtLTdNnIelgtBGxUq4gOyJJ5yPRFVzaiTjsZLBGg/m4xqzyKcXshN7qzswkE=
X-Received: by 2002:a05:6214:1927:b0:68c:4523:cb74 with SMTP id
 es7-20020a056214192700b0068c4523cb74mr2758364qvb.21.1706519670005; Mon, 29
 Jan 2024 01:14:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240127001926.495769-1-andre.draszik@linaro.org> <20240127001926.495769-2-andre.draszik@linaro.org>
In-Reply-To: <20240127001926.495769-2-andre.draszik@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Mon, 29 Jan 2024 09:14:18 +0000
Message-ID: <CADrjBPpOrxczkLxeo7QpaOGy31SUriKUQmQe9QcRQKniEXg99g@mail.gmail.com>
Subject: Re: [PATCH 1/9] clk: samsung: gs-101: drop extra empty line
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-kernel@vger.kernel.org, kernel-team@android.com, 
	tudor.ambarus@linaro.org, willmcvicker@google.com, semen.protsenko@linaro.org, 
	alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
	cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, 27 Jan 2024 at 00:19, Andr=C3=A9 Draszik <andre.draszik@linaro.org>=
 wrote:
>
> There is an extra empty line here which doesn't exist in any of the
> other cmu code blocks in this file.
>
> Drop it to align cmu_top with the rest of the file.
>
> Signed-off-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>
> ---

Reviewed-by: Peter Griffin <peter.griffin@linaro.org>

>  drivers/clk/samsung/clk-gs101.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs=
101.c
> index 4a0520e825b6..27debbafdce4 100644
> --- a/drivers/clk/samsung/clk-gs101.c
> +++ b/drivers/clk/samsung/clk-gs101.c
> @@ -25,7 +25,6 @@
>  /* ---- CMU_TOP --------------------------------------------------------=
----- */
>
>  /* Register Offset definitions for CMU_TOP (0x1e080000) */
> -
>  #define PLL_LOCKTIME_PLL_SHARED0                       0x0000
>  #define PLL_LOCKTIME_PLL_SHARED1                       0x0004
>  #define PLL_LOCKTIME_PLL_SHARED2                       0x0008
> --
> 2.43.0.429.g432eaa2c6b-goog
>

