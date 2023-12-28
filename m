Return-Path: <linux-kernel+bounces-12390-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BC5381F415
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 03:18:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9FB891F21A21
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 02:18:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 513521104;
	Thu, 28 Dec 2023 02:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A17rYsN1"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A992EDB;
	Thu, 28 Dec 2023 02:18:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FC27C433C7;
	Thu, 28 Dec 2023 02:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703729925;
	bh=ICAwhWKhehGd9vTcF3nvOWXD/lnnob/w5a+Pw7RVLdM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=A17rYsN1fPklVSK2EvGIWyMWX8PsKzd//HE+0ueCjMHwmbBTppTPXL+DEvEtCl45c
	 yKZXqanh6uYjmLNu/nzVnbAkWJ+K6HUnpRiJpzM0XEVS1c/QnSoeTtSeAzWKkW5uLe
	 EhKMuHm3iwHPyELp4dNTBYfmTwaSCZS2ecU7c+mxIG8pV8vQm4P9yLmDYNZP1BmNV2
	 5wMoaPdOKDsry6/7iLtZDhVmmvSzIS0RML5Uf07i+Dh6o82Av0vU4b3jMt5uZ8lmE2
	 GaOM6Fsy+R03nW5jlPPZBUdnPoQbRoc0ZJH02Iot86Af6S0ynA9710K+T531cDQhJJ
	 78KHUPhKtmKUw==
Date: Thu, 28 Dec 2023 10:18:40 +0800
From: Tzung-Bi Shih <tzungbi@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Mark Hasemeyer <markhas@chromium.org>,
	LKML <linux-kernel@vger.kernel.org>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Sudeep Holla <sudeep.holla@arm.com>,
	Raul Rangel <rrangel@chromium.org>,
	Benson Leung <bleung@chromium.org>,
	Bhanu Prakash Maiya <bhanumaiya@chromium.org>,
	Chen-Yu Tsai <wenst@chromium.org>,
	Guenter Roeck <groeck@chromium.org>, Lee Jones <lee@kernel.org>,
	Prashant Malani <pmalani@chromium.org>,
	Rob Barnes <robbarnes@google.com>,
	Stephen Boyd <swboyd@chromium.org>, chrome-platform@lists.linux.dev
Subject: Re: [PATCH v3 24/24] platform/chrome: cros_ec: Use PM subsystem to
 manage wakeirq
Message-ID: <ZYzbAIloJ9k28thL@google.com>
References: <20231226192149.1830592-1-markhas@chromium.org>
 <20231226122113.v3.24.Ieee574a0e94fbaae01fd6883ffe2ceeb98d7df28@changeid>
 <ZYxgQn8L7ENkc0AJ@smile.fi.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZYxgQn8L7ENkc0AJ@smile.fi.intel.com>

On Wed, Dec 27, 2023 at 07:34:58PM +0200, Andy Shevchenko wrote:
> On Tue, Dec 26, 2023 at 12:21:28PM -0700, Mark Hasemeyer wrote:
> > -	irq = platform_get_irq_optional(pdev, 0);
> > -	if (irq > 0)
> > +	irq = platform_get_irq_resource_optional(pdev, 0, &irqres);
> > +	if (irq > 0) {
> >  		ec_dev->irq = irq;
> > -	else if (irq != -ENXIO) {
> > +		if (should_force_irq_wake_capable())
> > +			ec_dev->irq_wake = true;
> > +		else
> > +			ec_dev->irq_wake = irqres.flags & IORESOURCE_IRQ_WAKECAPABLE;
> > +	} else if (irq != -ENXIO) {
> >  		dev_err(dev, "couldn't retrieve IRQ number (%d)\n", irq);
> >  		return irq;
> >  	}
> 
> Still I do not like ambiguity behind irq > 0 vs. irqres.start.
> 
> For this, and if needed others, return plain error.
> Seems I gave the tag for the previous patch, consider
> that tag conditional (it seems I missed this).

On a related note, I was confusing a while because of the differences:

platform_get_irq_optional() and platform_get_irq_resource_optional():
Return: non-zero IRQ number on success, negative error number on failure.

acpi_dev_get_gpio_irq_resource():
Return: 0 on success, negative errno on failure.

acpi_dev_gpio_irq_get():
Return: Linux IRQ number (> %0) on success, negative errno on failure.


How about let platform_get_irq_resource_optional():
- Return 0 on success and negative errno on failure.
- The callee needs to retrieve the IRQ number from irqres.start.
?

