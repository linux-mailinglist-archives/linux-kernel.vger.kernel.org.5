Return-Path: <linux-kernel+bounces-123649-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF0C890C39
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 22:08:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470021C227C2
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:08:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7F813B293;
	Thu, 28 Mar 2024 21:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iEyYmbUE"
Received: from mail-yb1-f175.google.com (mail-yb1-f175.google.com [209.85.219.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2109A13AD37
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 21:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711660053; cv=none; b=WTRIUqOIj2kke6aOA0B7bStqkg1IGGSLOS44xrmLIaW5wiVPh1ukwFxsqp/Z4ce9wRnIzlgmqsc8qP0RFUUayt2PfZJxvRX0EW4mZb1TEMx1+CjpZfxKlk9flzIESP+goWC09RrVLuKJ+81+5R4kSDHRDvqNgbDIAwgAxf9W9Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711660053; c=relaxed/simple;
	bh=x20Z9wO4XWd6/hqsTvUJ9C5xuiCT/PGoUlQnMNRKhnA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rpiFGvkTGxeSpyjL2dulXwnms0CTz8O+9o3ana6xWWo6dwUYDRJ9KfBKy28t3I9t1O60l6cBZmZ2ymwNZn2pdL/4u7/XXfUX2sa+qTk+ihXQlxl2AmYJCBLDi8U+PekUGjthY2bnCpcUspyf0UWRFC8nRsyRAGjyX3fdvkeJrf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iEyYmbUE; arc=none smtp.client-ip=209.85.219.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f175.google.com with SMTP id 3f1490d57ef6-dbed0710c74so1289035276.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 14:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711660049; x=1712264849; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x20Z9wO4XWd6/hqsTvUJ9C5xuiCT/PGoUlQnMNRKhnA=;
        b=iEyYmbUEKVoEMLSfm+1dgqqjW6ZSjsrKhnwEgQhuqVelEQdeGl+DinyIFq09FvZxsc
         icO69KX7mM0OQMgX+nUaflyBQNaEhqo4tIgCtqWh9nf0Z6M/a2GEuOOgtKDonzgxoDIt
         mK04J3Y/5BcUoV9owDicNq5Ty8wxETWzZNsz4USadunTA7W4uhginvNOklE9YF34bX/v
         HS3wUdPaMudoWNlzBrOv5AgAI//49/9nGrfOroUnKzEajzVfO4OeiXgLh7vb9zIvBAC8
         B6LunEHMRIMgVXBENEfOEncCnEIYXkkfpYu5fnNsLhCF/n8XwOthAQ/VUuCNIEU3pa86
         9mIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711660049; x=1712264849;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x20Z9wO4XWd6/hqsTvUJ9C5xuiCT/PGoUlQnMNRKhnA=;
        b=YaDcBmn5Snnh/mVkoQWKDNCIpMrTjbCDlG7bVGxTKTy82R+yjLVgXBVOP5MBrGjrX5
         LIC9eqGwZw7PNC0jclLuH9JZbeQEoyZZF+Fez8VqCVU2sz4xW8RX2ErCkvhW67PulTiI
         htH6/HGvjsZRfuPypL750RY+Bv7NVKSYu/KuG8f5U3LoX2psyWPUbtZJz4kwifxvXd6g
         snD/L1cm+29ksb0Ip5b6RvwEyNRn9aqVtFjSOhM6kNG4XF1YUITjihOImaZH+IoyCk8X
         TCPAe2g1VqyZq/CysL0z1i5g1SWys8WFvVOUmbBBslbikIof39cuYyW03xAKQBQ5KRc3
         /Q5w==
X-Forwarded-Encrypted: i=1; AJvYcCXqJnHkVuUAbNnCRkPWzxOTeZlC0Sf0i2+LDcF5nqsjkFkI+d+HxI2Nr5nZ+bf1vprDBcVlmxCP8h5hMkg9IrJgACursPgGibDGudjB
X-Gm-Message-State: AOJu0YwN8YBBVm5PnGrXvFBTZ1n1jDgdU/QBRRZfb60DMQ6ToMCqCCwp
	6z4MFjpa4nbatn+5xvGHNs2En4uxmfRLMdUVt9J1JSpuMkznnWvxGqOMvjVdm5QvQoKmbjgapeF
	y1VjYu8rYanVnUlGS5rsIyES/4SFyM6l+BX1B9Q==
X-Google-Smtp-Source: AGHT+IEZ00FIAL54100s1/gTVa8Y+4TfoCNoj6CJTr4a+YUNR3bthOuQhK7OnCvzxoRuhI+9C1J8CAiCPfUv2a7d2bw=
X-Received: by 2002:a25:9e83:0:b0:dc6:bbbd:d4f4 with SMTP id
 p3-20020a259e83000000b00dc6bbbdd4f4mr470298ybq.33.1711660049195; Thu, 28 Mar
 2024 14:07:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240102-j7200-pcie-s2r-v4-0-6f1f53390c85@bootlin.com> <20240102-j7200-pcie-s2r-v4-2-6f1f53390c85@bootlin.com>
In-Reply-To: <20240102-j7200-pcie-s2r-v4-2-6f1f53390c85@bootlin.com>
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 28 Mar 2024 22:07:18 +0100
Message-ID: <CACRpkdYemzkVW4fjBtHtFPaa-Uy969j5Ti2zmRgjFiZK+jGS7g@mail.gmail.com>
Subject: Re: [PATCH v4 02/18] pinctrl: pinctrl-single: move suspend()/resume()
 callbacks to noirq
To: Thomas Richard <thomas.richard@bootlin.com>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Andy Shevchenko <andy@kernel.org>, Tony Lindgren <tony@atomide.com>, 
	Haojian Zhuang <haojian.zhuang@linaro.org>, Vignesh R <vigneshr@ti.com>, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Janusz Krzysztofik <jmkrzyszt@gmail.com>, 
	Andi Shyti <andi.shyti@kernel.org>, Peter Rosin <peda@axentia.se>, Vinod Koul <vkoul@kernel.org>, 
	Kishon Vijay Abraham I <kishon@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
	Lorenzo Pieralisi <lpieralisi@kernel.org>, =?UTF-8?Q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
	Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-omap@vger.kernel.org, linux-i2c@vger.kernel.org, 
	linux-phy@lists.infradead.org, linux-pci@vger.kernel.org, 
	gregory.clement@bootlin.com, theo.lebrun@bootlin.com, 
	thomas.petazzoni@bootlin.com, u-kumar1@ti.com, 
	Andy Shevchenko <andy.shevchenko@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 4, 2024 at 4:36=E2=80=AFPM Thomas Richard
<thomas.richard@bootlin.com> wrote:


> The goal is to extend the active period of pinctrl.
> Some devices may need active pinctrl after suspend() and/or before
> resume().
> So move suspend()/resume() to suspend_noirq()/resume_noirq() in order to
> have active pinctrl until suspend_noirq() (included), and from
> resume_noirq() (included).
>
> The deprecated API has been removed to use the new one (dev_pm_ops struct=
).
>
> No need to check the pointer returned by dev_get_drvdata(), as
> platform_set_drvdata() is called during the probe.
>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>

Since this patch looks independent from the rest I ripped it out of the
patch series and applied it to the pinctrl tree for kernel v6.10.

Yours,
Linus Walleij

