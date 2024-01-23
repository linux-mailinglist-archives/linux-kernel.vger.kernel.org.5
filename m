Return-Path: <linux-kernel+bounces-35971-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5409E83994F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 20:13:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 871FA1C2339D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6A082D64;
	Tue, 23 Jan 2024 19:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Dz0yCv1W"
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBD93811F3
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 19:12:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706037163; cv=none; b=VmKw+kZI4h92demXJbNnwng/+n+Y4WLkYUmrvsoBi8RWMv6bpkoYkOF+gs4E246KB+BfN1Atwo+L2RAUcS0sAGqFrjxK4SkQOvZTR0PYT+UI1vIGv5BM7Ncr+mwuTzfmvVJaUjUbEv0GaN2nJWTLEl8sUge9bmbZzmbEUg9xaIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706037163; c=relaxed/simple;
	bh=WCVA+pw6+iSTOLRgl4ne/CK558PaHhdGFi3Vw7EsWbw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FxQDg7SHSHVT9psMU3Dr/nxKQ+q5eAwAFHUdoywVzSYOnZ03C8ubWhZXl3lKHvLFjF0OoGlb15v0gQdmG+3QBiTdxwitnFviFFJHV1Uikj/zzqHVEE38xIY+8okGZnWjZtspMg9yTAtuVqSm4q+wgX04XOv3Ih8XRTYqUiKndZo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Dz0yCv1W; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-6dbe5014eb5so1402438b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 11:12:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706037161; x=1706641961; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e2MABtBJt1eXd29le+TwN8zaGu6n3A3BwV6SbBkk6qw=;
        b=Dz0yCv1Wb5j2tjMpJ8RNMgaOMsukFpHHfj8sl0z94creHFxYFp/i8DHixA1b2w1IDF
         0mrB1kqP6cKQWvDGP4QJKfjC3+TgCPFg6e1Xsg0uMvn8+KLqZgtFZpdAgnHGM5OaTUJ8
         eVgRjYt7sL/5YJGdxTmYccDSvlWwBZal0+Lf03vO3a/urfEyZt9WVNLjZVTLzBvNv9oD
         5v629bLhJ9fh+2t4bW/j0MA3E2ZwTvaFJI0BBrErBEZFvw+ueNSOKna7MsJHiEdZYoQC
         MBAXtfW1eQWOOL/4wmgnyjEGtVIbjLZXpdVkl5WbHVKiloZpdji1FEwlFglKVzb4zLc+
         fASA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706037161; x=1706641961;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=e2MABtBJt1eXd29le+TwN8zaGu6n3A3BwV6SbBkk6qw=;
        b=A/d5FpT5RN0MHsKYlS4HzrhXOVqqsZD+WUvulxtP4Yg1vixvWCsAdsE4FplouiEYMv
         opB3vKO6hpziqBBMS+8q7/b1G7Kj/LiYrTQjbcE/2o+WO3U9/0NJgk8WoZiNSUjkNCi3
         wklt5Zgzy3nAQGetY9CSF90nInxLc0pqOZnQC7kYhq74vFbHFK6DlxSPpMn+36UPMWRz
         pBokSFMss370m2u9jh1Ih0dix1/87b/OUPAsZtG1PsbU0kIbr3uM+mj1F6eMY2ww4QM6
         yd7ApX4W6lowAefAGvtwM8Ty6bzgnjghi7zK4WcpCa2i9EWV0N6O5tblrclae8JJNSfQ
         6gKg==
X-Gm-Message-State: AOJu0YzwkVy4vbHR3ssEH19OtO78J/8rZywXL8+EZDJJ9og9upr0dO+p
	0MHspsnGvRifF5NJWYvViwkVN3qjtKyUkzExEplNk1v/LNnRqhjTq+nun2VK7QgSrCbu/bl6MQ6
	MHpBAZIjPCaZsn2cIztFEA0nMhZ7E1f1VC5Mpww==
X-Google-Smtp-Source: AGHT+IEzLIMx9KeDTQS/RcAgL4Xbbq/ry/ea+tOIU85SHc2O3G0CyeBj+EbdDdjeqw61KFQX1x1wVDePvwu4sqxtXrM=
X-Received: by 2002:a05:6a00:1901:b0:6db:d589:1d62 with SMTP id
 y1-20020a056a00190100b006dbd5891d62mr3904501pfi.7.1706037161193; Tue, 23 Jan
 2024 11:12:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240123153421.715951-1-tudor.ambarus@linaro.org> <20240123153421.715951-7-tudor.ambarus@linaro.org>
In-Reply-To: <20240123153421.715951-7-tudor.ambarus@linaro.org>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Tue, 23 Jan 2024 13:12:30 -0600
Message-ID: <CAPLW+4=36DeyQ+v83j6ZqHM4wubet3gnVDvZVptn6oS-pdEhYA@mail.gmail.com>
Subject: Re: [PATCH 06/21] spi: s3c64xx: remove else after return
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: broonie@kernel.org, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2024 at 9:34=E2=80=AFAM Tudor Ambarus <tudor.ambarus@linaro=
org> wrote:
>
> Else case is not needed after a return, remove it.
>
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/spi/spi-s3c64xx.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/spi/spi-s3c64xx.c b/drivers/spi/spi-s3c64xx.c
> index 9ce56aa792ed..db1e1d6ee732 100644
> --- a/drivers/spi/spi-s3c64xx.c
> +++ b/drivers/spi/spi-s3c64xx.c
> @@ -406,12 +406,10 @@ static bool s3c64xx_spi_can_dma(struct spi_controll=
er *host,
>  {
>         struct s3c64xx_spi_driver_data *sdd =3D spi_controller_get_devdat=
a(host);
>
> -       if (sdd->rx_dma.ch && sdd->tx_dma.ch) {
> +       if (sdd->rx_dma.ch && sdd->tx_dma.ch)
>                 return xfer->len > FIFO_DEPTH(sdd);
> -       } else {
> -               return false;
> -       }
>
> +       return false;
>  }
>
>  static int s3c64xx_enable_datapath(struct s3c64xx_spi_driver_data *sdd,
> --
> 2.43.0.429.g432eaa2c6b-goog
>

