Return-Path: <linux-kernel+bounces-58047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C71E84E099
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 13:21:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 48CA2286CD5
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 12:21:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 413C974E01;
	Thu,  8 Feb 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="K8GvBnLw"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DA476021
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 12:20:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707394859; cv=none; b=qqYHTgytXb1OK02pywX7gDraiYkpKJLITyHIpGZmY6/AkvU2czH7HL1qLcSpJIfBdMlLEe4R36ddyi2Cl6HInjf3W3F/wr7t+jZ9Ul0ydFNP1hqgUSRUeZF1ZvJHMGsLD65BlWtfFLkv43NOkBWkaw+F+qrRN2EPDNH3CAoVUvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707394859; c=relaxed/simple;
	bh=iBRxCFNg530HZ3mowLtmdXeppw43BoOmKkPx98+KxGQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=KvFd9jSAcrCqe53L9vkpGdR3xA0ROES9Oab+eu33hmOUxzRcZpl86s6ymhcycaCeq86gVzfyxqq40PJbX+5tEg0wXVIGpc3E+fan2mWkiIS6p0Rp+124WWti0dPpQhOw2T6E6J77a63BxitEKPcWn4E+klGfbBbkGu6kwM4Dh/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=K8GvBnLw; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-604b0ae6babso1581767b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 04:20:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707394856; x=1707999656; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iBRxCFNg530HZ3mowLtmdXeppw43BoOmKkPx98+KxGQ=;
        b=K8GvBnLwHDN4ObdcyJyFaoH9q+VbIqnV8NsNRrlyp58VcSfxZMGELlSZF45/KXtbx9
         qCJK5qlXOeFGVP2fL0KJeboSCqV0mit4eQ5ofcOWREo+cdmzcubPlKbGxpCortBifVch
         il2W/xp68lTaFbrOvKMoEF++Xsqir1pHh+wnty2utmZrqHH/sgn7nwaFh43+tHWoc/6k
         o9Ll1eU8Jo4FHthMwC6UHUOwKlZSSRhGcNN+cM7svR9WXa4yUzAfCusHM3hunkOkms/p
         c/B5TpVaqHTwUd3xxNeeHPxa/BJ/PK/TnVz2Yht5T+/0WJSTTvKE9QSFLhSw20zGHFij
         8wAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707394856; x=1707999656;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iBRxCFNg530HZ3mowLtmdXeppw43BoOmKkPx98+KxGQ=;
        b=dpIwoq9oP1/Dw160rrmhE8JELPx92HKIiNYkYxUXIN+jupzly7zJo/G77/wDhgxRmA
         83TGRRvlIvd2smwkHb6BSQAJR+3TOnGGADLi7aEYt0/mxUAK8U9CeCwONPDBxX7cHf14
         d9UAOTQjaMSD1g3ipHqqJzVw9PXYel8Jq64Xr+uwKdYmfkcHcl1kKKOokqSstit4eQXF
         Hzan2llsG7pAFTFRlm5OmtDAE2wvFtMEdmswpukMBovTU81tIsAvghZ4v0LtX9TuhSFX
         NrAt/NhL0o51dbeSmR2XLAUeHWSWFACiTbZ6Qhh4BWughNOqVGwKOluQYOk0YuqIqIzN
         lsTw==
X-Forwarded-Encrypted: i=1; AJvYcCVMUun2oVgcEEg3p+LpABMypZ6Tdyrp7VnsdaLhmQr9i6wFs9u8o0z+FgRgzyHnwLFMKzBrAr2xvsa0sr9GNEKDuyMersFBQ/lf1l6e
X-Gm-Message-State: AOJu0YyzfFQ7VIEkqGscCLM9CRyQ7DUdFwqsmdGz/m4QIUOM64QrhmRM
	/tvg3RDwhMebBncxGfzHms/S6HPrw1OfrCyOd6gsBNpujfNLDs9IPWgq2iHKIvf6maqxxgyfnmq
	/46p3o9RauMqPClhJMjAlwNyl7BJgcQm5cB+9Lw==
X-Google-Smtp-Source: AGHT+IHKhaZnnM7h0sNB0ERbnAD1jv4LPYRxgzkjQ5lvuf4L29l+0F15fpZHLoEl+PkN17TnOypsBH/bxF0yT9EzVQ4=
X-Received: by 2002:a81:b3c1:0:b0:604:7a6a:9d58 with SMTP id
 r184-20020a81b3c1000000b006047a6a9d58mr8271515ywh.25.1707394856481; Thu, 08
 Feb 2024 04:20:56 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240208095920.8035-1-brgl@bgdev.pl> <20240208095920.8035-17-brgl@bgdev.pl>
In-Reply-To: <20240208095920.8035-17-brgl@bgdev.pl>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 8 Feb 2024 13:20:45 +0100
Message-ID: <CACRpkdYV8Q9LRdZ4A4hGUmWsyEFkOeMkCOv1_nyPZS4ccpeY6A@mail.gmail.com>
Subject: Re: [PATCH v3 16/24] gpio: sysfs: don't access gdev->chip if it's not needed
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Kent Gibson <warthog618@gmail.com>, Alex Elder <elder@linaro.org>, 
	Geert Uytterhoeven <geert+renesas@glider.be>, "Paul E . McKenney" <paulmck@kernel.org>, 
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Wolfram Sang <wsa@the-dreams.de>, 
	linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 8, 2024 at 10:59=E2=80=AFAM Bartosz Golaszewski <brgl@bgdev.pl>=
 wrote:

> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>
> Don't dereference gdev->chip if the same information can be obtained
> from struct gpio_device.
>
> Suggested-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij

