Return-Path: <linux-kernel+bounces-48164-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04249845825
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:52:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D9171F2A1C9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:52:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F47E86652;
	Thu,  1 Feb 2024 12:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i7H6xVNk"
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF36D86649
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791921; cv=none; b=QZOwpXG/MYx9CTT4lkWVWbnfrXSDG64OzwyGZ8S0QONRCLSH4Ufuz6Z5z42R+TUNBA6zSQbAMIABPlcP3tRJV0i9sLo2kWmo4qsOj4zIM3l+6pBMDufrvga1uOpgif8qRGvUiABbE2pPyysg7LbsOia/b1SbQnI0ylTjnR1aa3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791921; c=relaxed/simple;
	bh=h2mSKtqOnzsmGzhW1noP9srYgl4twW8yuazPvZGHQ6w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rp65aOFC1yQJJF96PWZvUmblQjuMaMG/R3/BC14FFNOeaADTYmz1mE3qprrgdFWxg4dGKnX4ysBnaQWRN9ZMFpTrDXKHIYMflhDBQ00LdiqOUOs/NmCoLKhZDLgSL2azuIB3P9POo9+XWijZLSKIWH42YFycdTprfqMOmfT4+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=i7H6xVNk; arc=none smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-68c820a25a0so233386d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706791919; x=1707396719; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=weoByurLTD5f879C/MSz1GGLsfMhdIMFAUH5IcvF+Gs=;
        b=i7H6xVNkYm8BW1ju1fdxFuKQiKHVVxTS7pPQfCKPoSJpU24q6jiMfBolr41QPkhIt0
         r2NTD2rrZxnJPv1x/TXcrEkR07NFXRy0bE7s8E95naCFdTymGzqtRmd8geAlJfS1wKH8
         zxRv0l9ip3Mc73rugtNsuedK696R2ntFGnmu4cjqVmfTxYPNoGJPp8I5QvmYD2oS6PM3
         Yzm3YoJKdc1D2l53uHFXc9dNtr7Lg3lENr1UDPjoTJsoNhXFp5Vsznf8sNAp80Z823yN
         2Svhz2PHdzDb4RWhTrn0huhXZHizELjwiBx2zJKd8QwqXJD9MKrymx216HSSzA2JK4CE
         MdQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706791919; x=1707396719;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=weoByurLTD5f879C/MSz1GGLsfMhdIMFAUH5IcvF+Gs=;
        b=mG+HOpCOutgBpi1vsgXYHQmAADyGPfJl1jTQY5AgYJFD9OwwhJEzWHE5uOJvWFcbbZ
         +w4gny0OoNy17yhPOHtTTZJhOmfFPGIrKeVZ1Y5y/zK1zo/w4DEdzp9ZYncfeBOA1Eut
         xSMXGqypxy3b8SJA+WdjXS1uas0aYHa2yLDWOeOnyENd6ODTS9hYM54vqqW0eO/qZLrB
         CjQe8o2N/hBu2Ww0vPYc30wrGnZertWg33Cvt3robpBQQkbAW9PJugLJ8W2uMjIwRzP9
         GTEAZl2dl2dabuk8EY0+pMqA7FnD4A7Qv5FsKVMnDmeMjW0Mt6uMdc7+JVSO1b5QIqGy
         DwOg==
X-Gm-Message-State: AOJu0YzCp9zs7sPnThJ5JBYGTWClBkpj1IynTSTHoMahIdm06bNK/CXD
	QzS4scJZIRhzOx15BM0ZWOEGCz8Dc6osLubGnFgx7y7yERCF5WtjY/rM8jXm0cos+u96WmEpW5f
	yxV9rq2kb+M15oYwH2Xc00kE7Dpqy5IFrKH1mWg==
X-Google-Smtp-Source: AGHT+IHgSoknuuzS25Fpw49ZLC4Y8bfK4zoT8o2iXaPQVImDDvoLvfleUoohLl84R97TiX7NmQhLUmMcGlCRfQ0KQaA=
X-Received: by 2002:a05:6214:1c4e:b0:686:261a:76a0 with SMTP id
 if14-20020a0562141c4e00b00686261a76a0mr6259620qvb.52.1706791918775; Thu, 01
 Feb 2024 04:51:58 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129211912.3068411-1-peter.griffin@linaro.org>
 <20240129211912.3068411-2-peter.griffin@linaro.org> <fb530eb8-e32b-4faf-81f3-efc334ebf241@linaro.org>
In-Reply-To: <fb530eb8-e32b-4faf-81f3-efc334ebf241@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Thu, 1 Feb 2024 12:51:47 +0000
Message-ID: <CADrjBPoQmTRsFYRtxBxdvAoKK816O8XN3=hOJ3vBt8wbbbk-=Q@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: samsung: exynos-pmu: Add regmap support for
 SoCs that protect PMU regs
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: arnd@arndb.de, linux@roeck-us.net, wim@linux-watchdog.org, 
	alim.akhtar@samsung.com, jaewon02.kim@samsung.com, semen.protsenko@linaro.org, 
	kernel-team@android.com, tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
	saravanak@google.com, willmcvicker@google.com, linux-fsd@tesla.com, 
	linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-samsung-soc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Hi Krzysztof,

On Tue, 30 Jan 2024 at 16:01, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/01/2024 22:19, Peter Griffin wrote:
> > Some Exynos based SoCs like Tensor gs101 protect the PMU registers for
> > security hardening reasons so that they are only accessible in el3 via an
> > SMC call.
> >
> > As most Exynos drivers that need to write PMU registers currently obtain a
> > regmap via syscon (phys, pinctrl, watchdog). Support for the above usecase
> > is implemented in this driver using a custom regmap similar to syscon to
> > handle the SMC call. Platforms that don't secure PMU registers, get a mmio
> > regmap like before. As regmaps abstract out the underlying register access
> > changes to the leaf drivers are minimal.
> >
> > A new API exynos_get_pmu_regmap_by_phandle() is provided for leaf drivers
> > that currently use syscon_regmap_lookup_by_phandle(). This also handles
> > deferred probing.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  drivers/soc/samsung/exynos-pmu.c       | 227 ++++++++++++++++++++++++-
> >  include/linux/soc/samsung/exynos-pmu.h |  10 ++
> >  2 files changed, 236 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/samsung/exynos-pmu.c b/drivers/soc/samsung/exynos-pmu.c
> > index 250537d7cfd6..7bcc144e53a2 100644
> > --- a/drivers/soc/samsung/exynos-pmu.c
> > +++ b/drivers/soc/samsung/exynos-pmu.c
> > @@ -5,6 +5,7 @@
> >  //
> >  // Exynos - CPU PMU(Power Management Unit) support
> >
> > +#include <linux/arm-smccc.h>
> >  #include <linux/of.h>
> >  #include <linux/of_address.h>
> >  #include <linux/mfd/core.h>
> > @@ -12,20 +13,159 @@
> >  #include <linux/of_platform.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/delay.h>
> > +#include <linux/regmap.h>
> >
> >  #include <linux/soc/samsung/exynos-regs-pmu.h>
> >  #include <linux/soc/samsung/exynos-pmu.h>
> >
> >  #include "exynos-pmu.h"
> >
> > +static struct platform_driver exynos_pmu_driver;
>
> I don't understand why do you need it. You can have only one
> pmu_context. The moment you probe second one, previous becomes invalid.
>
> I guess you want to parse phandle and check if just in case if it points
> to the right device, but still the original code is not ready for two
> PMU devices. I say either this problem should be solved entirely,
> allowing two devices, or just compare device node from phandle with
> device node of exynos_pmu_context->dev and return -EINVAL on mismatches.

Apologies I didn't answer your original question. This wasn't about
having partial support for multiple pmu devices. It is being used by
driver_find_device_by_of_node() in exynos_get_pmu_regmap_by_phandle()
to determine that the exynos-pmu device has probed and therefore a
pmu_context exists and a regmap has been created and can be returned
to the caller (as opposed to doing a -EPROBE_DEFER).

Is there some better/other API you recommend for this purpose? Just
checking pmu_context directly seems racy, so I don't think we should
do that.

Peter

[...]

