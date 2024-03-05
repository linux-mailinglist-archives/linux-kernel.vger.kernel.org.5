Return-Path: <linux-kernel+bounces-92868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B7A6872739
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 20:02:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 278E1287ADC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 19:02:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AEE422F08;
	Tue,  5 Mar 2024 19:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="3Vx/ki12"
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CC41BC26
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 19:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665343; cv=none; b=BFUTzJcLz3+6nEJeKojo9NY4KB/tyk7Y1OZB4p4UGF/NikxxJkjHAxjNJHrOPtFs3d4A0nF0m8/NcCl7VtlAVu3uqV0EgGDbNpp7WJzSYi0mWhTA+mb/n5kVOiSEZj/qYkjArPffoTH3C95fQgCludFrMkfOdgokTQTuH/l5ZZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665343; c=relaxed/simple;
	bh=K6FkNMPBXHerOI4xPkbioCN3A0D3+Ds7NwZGpoSSfe0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RGOW+WZ/0Ob1FEfD3LZSyLv0LLmaJdJvOmWxqnI0oNRj68T1tpfYY0IalH53eIYFQdtr5isHWn3VrSmvAZ8WVtAO6L89BxGFVpF7tIodpjTIIbSEplaVt0bqt+U0ehOavhGLbVzEP04Djip2dAvf5PivQ4jsJnzTdeZjoP1QEok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=3Vx/ki12; arc=none smtp.client-ip=209.85.167.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-oi1-f175.google.com with SMTP id 5614622812f47-3c1f5e14bdbso761003b6e.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 11:02:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1709665341; x=1710270141; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xBwFyKsVTwVp75+p2nwkinAD6Bz4XTPqba7sPzbW0JE=;
        b=3Vx/ki12OkG9eSjnqNnLIPf1HkuxdA4XBPXIjRZ9w58KHKzpNCzgY0JVed9PmQs4LI
         rZ9jlpK49HC9sqwvDjREV8J9VNn+GE0NBnJwCflbv/bNI2/Y9OFwYBuxnnShhpAhTSkx
         1zTiNizcpawsWPFQywsIh2ahOgYWYVqehEtp9Q9RBAQ9HGeKw4e4shhvgdGvKgxFm3Po
         J3JKs9BO5ZEWtdifoNqtqap/d3dvVHwj2Y1MZW40JnEFckLOvySJaxgUoaizGMe+EsqL
         UAMGnPMZ99nyV2tg3WTSwaXWHiN/wUYiUiwXzo5w4uwMxTZQYkD5XSgy2RQGOZWqdzbA
         cXdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709665341; x=1710270141;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xBwFyKsVTwVp75+p2nwkinAD6Bz4XTPqba7sPzbW0JE=;
        b=DSs/gpT17EnnLy5zgoh7mo2W7Q3sReU218HKZ0p7WjRLbjI+gXaM8xGFksLuGUvVvk
         dMLwVKt8Qc9pDfssgI+AjmSDe2UFUWp6/5qISq9BeyFbttq9FyZW11mpsOeAjg7gfuSI
         V2p98J8vPxFCOH/L9nqqYy7Kpzv7dpUpe1XjB4c3A/XtkwndIIS9pS0snDJ3Vq2LYUZR
         xEnup/bFCyeOX0R1SN+sBfMk5mXxALVnZq59alJI24saQZNYJGXu+sytAFDbACVC+wG5
         TmxTeCQU2zeoxONbk/T95fc73YOsw8g9LMLV8LF25CoYdOmcdXAagpWPxJbnCvQSZNod
         mOdQ==
X-Gm-Message-State: AOJu0Yz2xUi/clDkkm2tl7wae1mPJHHG4O2nZD1aJyy56SltM2ODfeGV
	eLhRFoNhN/1EcGBiJyqvOfMVAXQoL81ZP+xNCVbFe1GbCcnZjSXlftlVAt0k0pUJBA3t0Yo1//8
	lmkFtWgk02vaPkNDN9XMxKU1WCGbCafSsmx5RNA==
X-Google-Smtp-Source: AGHT+IEWrieqCghcMtuAiU8+E4g1wtb0MN+anUUpKGJrOGNU5YfOBzlImhJC+Y9W4AXeVKQmrFK59za9cu/REtKiSrk=
X-Received: by 2002:a05:6808:14d:b0:3c2:1944:e2f9 with SMTP id
 h13-20020a056808014d00b003c21944e2f9mr223145oie.17.1709665340696; Tue, 05 Mar
 2024 11:02:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240305002124.7552-1-warthog618@gmail.com>
In-Reply-To: <20240305002124.7552-1-warthog618@gmail.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Tue, 5 Mar 2024 20:02:09 +0100
Message-ID: <CAMRc=McneyUZztqtdrsbGG1E+DWhBxq2cQH7OWMEStaJjKLkCA@mail.gmail.com>
Subject: Re: [PATCH] selftest: gpio: remove obsolete gpio-mockup test
To: Kent Gibson <warthog618@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, 
	linux-gpio@vger.kernel.org, bartosz.golaszewski@linaro.org, 
	andriy.shevchenko@linux.intel.com, christophe.leroy@csgroup.eu, 
	shuah@kernel.org, bamv2005@gmail.com, Pengfei Xu <pengfei.xu@intel.com>, 
	Yi Lai <yi1.lai@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 5, 2024 at 1:26=E2=80=AFAM Kent Gibson <warthog618@gmail.com> w=
rote:
>
> With the removal of the ARCH_NR_GPIOS, the number of available GPIOs
> is effectively unlimited, causing the gpio-mockup module load failure
> test that overflowed the number of GPIOs to unexpectedly succeed, and
> so fail.
>
> The test is no longer relevant so remove it.
> Promote the "no lines defined" test so there is still one load
> failure test in the basic set.
>
> Fixes: 7b61212f2a07 ("gpiolib: Get rid of ARCH_NR_GPIOS")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Reported-by: Yi Lai <yi1.lai@intel.com>
> Closes: https://lore.kernel.org/linux-gpio/ZC6OHBjdwBdT4sSb@xpf.sh.intel.=
com/
> Signed-off-by: Kent Gibson <warthog618@gmail.com>
> ---
>  tools/testing/selftests/gpio/gpio-mockup.sh | 9 +++------
>  1 file changed, 3 insertions(+), 6 deletions(-)
>
> diff --git a/tools/testing/selftests/gpio/gpio-mockup.sh b/tools/testing/=
selftests/gpio/gpio-mockup.sh
> index 0d6c5f7f95d2..fc2dd4c24d06 100755
> --- a/tools/testing/selftests/gpio/gpio-mockup.sh
> +++ b/tools/testing/selftests/gpio/gpio-mockup.sh
> @@ -377,13 +377,10 @@ if [ "$full_test" ]; then
>         insmod_test "0,32,32,44,-1,22,-1,31" 32 12 22 31
>  fi
>  echo "2.  Module load error tests"
> -echo "2.1 gpio overflow"
> -# Currently: The max number of gpio(1024) is defined in arm architecture=
.
> -insmod_test "-1,1024"
> +echo "2.1 no lines defined"
> +insmod_test "0,0"
>  if [ "$full_test" ]; then
> -       echo "2.2 no lines defined"
> -       insmod_test "0,0"
> -       echo "2.3 ignore range overlap"
> +       echo "2.2 ignore range overlap"
>         insmod_test "0,32,0,1" 32
>         insmod_test "0,32,1,5" 32
>         insmod_test "0,32,30,35" 32
> --
> 2.39.2
>
>

Applied, thanks!

Bart

