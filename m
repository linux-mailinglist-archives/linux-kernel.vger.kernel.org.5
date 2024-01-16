Return-Path: <linux-kernel+bounces-27731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C816882F4F9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 20:04:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EDCA81C23689
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 19:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7B651D546;
	Tue, 16 Jan 2024 19:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wl1DsCKo"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9D3F1D69E
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 19:03:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705431827; cv=none; b=a44I/ZXCQeJMwjY4fd+Kv3JwpAU+x6oycSIdW6BUxGhADwvi2Eq1GrspSkPens6kAscWh1gxRZhHWft8cUXyHhtDBjT+Vk2q/H1bS7Ze/iojUY5huoiZnt2rqUPfQQYxqC89K5b7s7Fh9/KcsojzGdxM4pMEjg5KroBjxVQ4Ioc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705431827; c=relaxed/simple;
	bh=VZA7GkqNOsfGprEcp87CCflAFYwG+5mMjyW9KlFZQn4=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 References:In-Reply-To:From:Date:Message-ID:Subject:To:Cc:
	 Content-Type:Content-Transfer-Encoding; b=QjDpi61L/5Y7/jf6VnFBrndDfvgkp20ViGioQ3WB00TyN4NFeDLxWOTBSLFvnlafNvJsvIBRmlJ/A36LacgPDjDMFi/OmAKGM6PGCaSDVBaVIipwpKIrhkbvtxv4rICNB9EggGsptENyEJRfnvNjccO4asZyxOceTuPFDXyfbHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wl1DsCKo; arc=none smtp.client-ip=209.85.215.181
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cde7afa1d7so4831296a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705431825; x=1706036625; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFfdvwq+VA0URYaPaSoMqo8iUhwVlg2dLRJaPWnJEaM=;
        b=wl1DsCKoZi5lhSn6aBjbNo4OCibtXReGj6Ct0mD9Ssrx1fhtqwdO1xKqXlBs1tVAwl
         49a2sjup+mlL/Q+84agOxNIPABuSoEK5H/PaaeHy8EsFhTBXAyojP2dfd1P+liju6OHa
         JDMME0y4wY5ZTt+FNaHXSLtXfaB21/ikaDeztQu8J5q3g/3/6H7v893ZdjCUHK59Mf34
         lmF8kLDYsjHgIi8B8g1VvFBiy8iFcY9wgfvkRhyeCIwH9XQHTfBpn5xOzAZIqKsUNqdN
         xqf+ky7WAXIqnRiatDZdWfdHodbBZdkyQ1D2pKSxvCUkKJXYB1VrsmrDdIum0NzmoKIA
         nWMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705431825; x=1706036625;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uFfdvwq+VA0URYaPaSoMqo8iUhwVlg2dLRJaPWnJEaM=;
        b=WdXxqN3rmjvBffVS2CH0YQezanq7WlRrT+JIC0HpU/aN0zegmlQkAsWjGgoUxkbUgd
         xahMVw1yK6v+LR3dugvgRyAPSGmoY62ZlRLqysd4kWeUQiCbEPdshWaUIFfvuhlT7PEM
         38HmO024pEZjg4PfrN98s4Q04SRKaSUba1L+us50YFY883IeO+7AB6l/JypJChqbU/ZX
         RczeRnG4UzX63DTWBnGnIzTyeYnC9uC1sZbW+t520vIklMBAItFTMfzimlxMcY/e8kcB
         C2UVXusl3WPMeepKxrV31yA/9AwNvfD98c4lAukeGjYoeLlLo1BSa8YmJ+nFKgtlvaD0
         4k0A==
X-Gm-Message-State: AOJu0YzSX3+xYbslgRTkbXgMviRJcmP+70PjN7VJU4kfOnXxijfyP/2y
	HzyiZLgwiWkpyPfoYv0x2BounNT+JZh5XNIOqI5e12e/WhpPTw==
X-Google-Smtp-Source: AGHT+IEPnUs5s+u4n2M6rGcq0735SPknT/v+moyBMuh8kF4qV4x/ZF7cpKSU/gDRB07cac8VXhFT6ikMNp/8rp5YiPo=
X-Received: by 2002:a17:90b:70e:b0:28b:fa2e:ca56 with SMTP id
 s14-20020a17090b070e00b0028bfa2eca56mr4085660pjz.29.1705431825086; Tue, 16
 Jan 2024 11:03:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240110102102.61587-1-tudor.ambarus@linaro.org> <20240110102102.61587-18-tudor.ambarus@linaro.org>
In-Reply-To: <20240110102102.61587-18-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 16 Jan 2024 13:03:34 -0600
Message-ID: <CAPLW+4k091328krLB_KdHyobG-pR--Rt5WaN6c1ccpgdV8ry7Q@mail.gmail.com>
Subject: Re: [PATCH 17/18] tty: serial: samsung: shrink port feature flags to u8
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: krzysztof.kozlowski@linaro.org, alim.akhtar@samsung.com, 
	gregkh@linuxfoundation.org, jirislaby@kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
	andre.draszik@linaro.org, peter.griffin@linaro.org, kernel-team@android.com, 
	willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 10, 2024 at 4:25=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> There's a single flag defined as of now. Shrink the feature flags to u8
> and aim for a better memory footprint for ``struct s3c24xx_uart_info``.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---
>  drivers/tty/serial/samsung_tty.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/samsung_tty.c b/drivers/tty/serial/samsun=
g_tty.c
> index 5df2bcebf9fb..598d9fe7a492 100644
> --- a/drivers/tty/serial/samsung_tty.c
> +++ b/drivers/tty/serial/samsung_tty.c
> @@ -90,7 +90,7 @@ struct s3c24xx_uart_info {
>
>         /* uart port features */
>
> -       unsigned int            has_divslot:1;
> +       u8                      has_divslot:1;

But that's already a bit field. Why does it matter which type it is?

>  };
>
>  struct s3c24xx_serial_drv_data {
> --
> 2.43.0.472.g3155946c3a-goog
>
>

