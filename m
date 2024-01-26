Return-Path: <linux-kernel+bounces-40558-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E94A83E270
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 20:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2A484B23F5C
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 19:23:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42289224DA;
	Fri, 26 Jan 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zDUE7lCj"
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B219224D8
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 19:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706297017; cv=none; b=nnlsIgKvmTwXP7x1b3uhWI/vbtgM1dY8pl495CyLy0hHHYO021XTRpahQf/Enw1TvzJr/QUNHRaL+DuMFNoHWG9X3N3kxuUFkgi5LkkqiGvPBj8KuppSl9VwW8E7JuZ62tXXIQ6z6h+JihQy66aR3hVClKE6DqNsh6/mqDK469c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706297017; c=relaxed/simple;
	bh=TtYMN3GShHRZCc1Drpo4X80E/CnRWO/M7L6zj37FsEg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UobI2VILhH4DFIZLPSHpHxKqA+rgBH6I8aqTudd1EO3SE5f0V+wMBFWPPtkt7HOT7lUiUdIfmHjupPdQnp0JhIanWD4MzaXNYl2g0q6Ybq2OVekGtLdec1UY9PjluN/kPyEUQlTfFEYBrUHMi/BVSP3HYHaZgrfGOP8WPLnsCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zDUE7lCj; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-2907a17fa34so777453a91.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:23:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706297015; x=1706901815; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pci4l1Zh4vLDqka8iPuTXs2/4isIF6x5bfsHnKL71CI=;
        b=zDUE7lCjImOXhTG4/rDFQGpnDXGjcRVnYsBekoisGzpNNit2dPB/9KRa0O6ecOBXQ8
         o3GCo/zm7MlY3gDBs35gV8FdxGL/ELKZl+o2H7I7tMQHDaB+gpQ8A8XRc9d/VIoFb67l
         gFYUj7St4fv6ZwgwBHNheVvc0+/XRrdY7scmXIvmRDwkY5VWWGCcjOsjjaBC13Go72oS
         JNvQp2zzs57LEpc6Va4FvIKXkNKPB3rjta7oJIMWevnyaWa81GW3TnFEpf4N/2MG9TCl
         uUHp4Qe2S3TdlDwuymM0VbJCACrHaVr20uJ5fqHY2Jmlzj2lHTp4xKfMyyqbl9Yu1c4a
         qUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706297015; x=1706901815;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pci4l1Zh4vLDqka8iPuTXs2/4isIF6x5bfsHnKL71CI=;
        b=PMYK539/Lug3VzRwx7OvcAfJ/wxJZgH/Z/Hwv+3eg4yaYVjDVjuBuVFxaRa4u79v3g
         dtNkWx7StPX5CvPSvzbxc8/xgtXNaKoBN1CAWhpjnLylh+lwP0YzYBnXs3H2YCAseF5m
         iFsb8YFmVD89CTrWenMxCyJfHiOhiFWV5Q8WMlo1eL4H0aSFPZ0yDukS0AjzFBgwkXRh
         OjAuokBFwX2/ls0zRL8UrGtFwPr55BVO4+DRli/a4VO1C9qXYDzqAzjTbHjQE8ymHMkQ
         QYtlko7SPccslzTPEukzYWx/UkzI/A1XIc9Z2qb56ksiSubMehcLs76D8XDw0ESos/UV
         4uzA==
X-Gm-Message-State: AOJu0YyGxOQaStRN9icBNnYjzMQYSE8bhJU0FqF61ZIQso65zNkju50u
	vkbbqiXYhMRkn+EwuG+KKwHA2SOzlSnpjJJVGTmbcj7K4JVwFf7W3xYlN64TS0tr3yo7LwZOnbW
	fiwf4zO8FIJ9muVfVlR9kCBHKvEmNjqt0Vo98eA==
X-Google-Smtp-Source: AGHT+IFyVG+TAGYzMvyT5Wl++btmO1JDRT8TGoWOEDu8WDjuLaYb7yHih34riUmaKg0bO8OqD8M0VDuhQbwcWOYhlCA=
X-Received: by 2002:a17:90a:b28d:b0:294:3cb1:a8c5 with SMTP id
 c13-20020a17090ab28d00b002943cb1a8c5mr351761pjr.28.1706297015515; Fri, 26 Jan
 2024 11:23:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125145007.748295-1-tudor.ambarus@linaro.org>
 <20240125145007.748295-24-tudor.ambarus@linaro.org> <1e117c5c-1e82-47ae-82f4-cdcf0a087f5f@sirena.org.uk>
In-Reply-To: <1e117c5c-1e82-47ae-82f4-cdcf0a087f5f@sirena.org.uk>
From: Sam Protsenko <semen.protsenko@linaro.org>
Date: Fri, 26 Jan 2024 13:23:24 -0600
Message-ID: <CAPLW+4kTUmG=uPQadJC5pyfDvydvr1dKnJY6UxQva2Ch-x7v3g@mail.gmail.com>
Subject: Re: [PATCH v2 23/28] spi: s3c64xx: retrieve the FIFO size from the
 device tree
To: Mark Brown <broonie@kernel.org>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, andi.shyti@kernel.org, arnd@arndb.de, 
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-arch@vger.kernel.org, andre.draszik@linaro.org, 
	peter.griffin@linaro.org, kernel-team@android.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 25, 2024 at 11:33=E2=80=AFAM Mark Brown <broonie@kernel.org> wr=
ote:
>
> On Thu, Jan 25, 2024 at 02:50:01PM +0000, Tudor Ambarus wrote:
>
> > Allow SoCs that have multiple instances of the SPI IP with different
> > FIFO sizes to specify their FIFO size via the "samsung,spi-fifosize"
> > device tree property. With this we can break the dependency between the
> > SPI alias, the fifo_lvl_mask and the FIFO size.
>
> OK, so we do actually have SoCs with multiple instances of the IP with
> different FIFO depths (and who knows what else other differences)?

I think that's why we can see .fifo_lvl_mask[] with different values
for different IP instances. For example, ExynosAutoV9 has this (in
upstream driver, yes):

    .fifo_lvl_mask =3D { 0x1ff, 0x1ff, 0x7f, 0x7f, 0x7f, 0x7f, 0x1ff,
0x7f, 0x7f, 0x7f, 0x7f, 0x7f},

And I'm pretty sure the comment (in struct s3c64xx_spi_port_config)
for .fifo_lvl_mask field is not correct anymore:

     * @fifo_lvl_mask: Bit-mask for {TX|RX}_FIFO_LVL bits in
SPI_STATUS register.

Maybe it used to indicate the bit number in SPI_STATUS register for
{TX|RX}_FIFO_LVL fields, but not anymore. Nowadays it looks like
fifo_lvl_mask just specifies FIFO depth for each IP instance.

