Return-Path: <linux-kernel+bounces-35607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AF818393EE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:58:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 542572890E0
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3075D6166E;
	Tue, 23 Jan 2024 15:58:31 +0000 (UTC)
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE37612D6
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706025510; cv=none; b=jPtBMyZriQ5Sr5NTCLw4MyuamKnHnnfsI31z6gjTDcVj3gTIcNmXYOuONVTPA85t89wQuKYef2bMLVdJoXkHq07S2zhXRu5EFguTcR9tAqV/H+rppp52+dovofZ0NKtqgarVN4+8Bx2qAZGruSEdCoweBNh8OBEwZum4zeqRdgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706025510; c=relaxed/simple;
	bh=FLYjzYMkf6E9zjSakhvrb6+IxLdSbdz6QkWTCjb64SE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=OJ9fycWfzDoByjPBZdbsdgOdCmkeUale+r5IwudCwIYoypRXmcM7yhEcSL9+NaW6XgkkREFCnFaBe30yZXm5ESDgNOmpScOd7Xzq6dNtQvUMwo7yZN1GfFGS+2ZHz4OfWm0JxZyrE+cE9d/Y1f2KYdtISFLKxLYu4pLYxQC3KXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSJA5-0005N6-Sq; Tue, 23 Jan 2024 16:58:05 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSJA1-001rVX-T3; Tue, 23 Jan 2024 16:58:01 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rSJA1-000Br9-2d;
	Tue, 23 Jan 2024 16:58:01 +0100
Message-ID: <9e426d8cb630a1015133027424635ea4615b3be4.camel@pengutronix.de>
Subject: Re: [PATCH v4 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami
 <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley <conor+dt@kernel.org>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Viresh Kumar
 <viresh.kumar@linaro.org>, Frank Rowand <frowand.list@gmail.com>, Jaroslav
 Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
 linux-arm-msm@vger.kernel.org,  alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org,  devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org,  linux-pm@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Chris Packham
 <chris.packham@alliedtelesis.co.nz>, Sean Anderson <sean.anderson@seco.com>
Date: Tue, 23 Jan 2024 16:58:01 +0100
In-Reply-To: <20240123141311.220505-5-krzysztof.kozlowski@linaro.org>
References: <20240123141311.220505-1-krzysztof.kozlowski@linaro.org>
	 <20240123141311.220505-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: p.zabel@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org

On Di, 2024-01-23 at 15:13 +0100, Krzysztof Kozlowski wrote:
> Devices sharing a reset GPIO could use the reset framework for
> coordinated handling of that shared GPIO line.  We have several cases of
> such needs, at least for Devicetree-based platforms.
>=20
> If Devicetree-based device requests a reset line, while "resets"
> Devicetree property is missing but there is a "reset-gpios" one,
> instantiate a new "reset-gpio" platform device which will handle such
> reset line.  This allows seamless handling of such shared reset-gpios
> without need of changing Devicetree binding [1].
>=20
> To avoid creating multiple "reset-gpio" platform devices, store the
> Devicetree "reset-gpios" GPIO specifiers used for new devices on a
> linked list.  Later such Devicetree GPIO specifier (phandle to GPIO
> controller, GPIO number and GPIO flags) is used to check if reset
> controller for given GPIO was already registered.
>=20
> If two devices have conflicting "reset-gpios" property, e.g. with
> different ACTIVE_xxx flags, this would allow to spawn two separate
> "reset-gpio" devices, where the second would fail probing on busy GPIO
> request.
>=20
> Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ [1=
]
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>=20
> ---
>=20
> Depends on previous of change.
> ---
>  drivers/reset/core.c             | 213 +++++++++++++++++++++++++++++--
>  include/linux/reset-controller.h |   4 +
>  2 files changed, 204 insertions(+), 13 deletions(-)
>=20
> diff --git a/drivers/reset/core.c b/drivers/reset/core.c
> index 4d5a78d3c085..6e81b8d35055 100644
> --- a/drivers/reset/core.c
> +++ b/drivers/reset/core.c
> @@ -10,9 +10,13 @@

Oh, and

#include <linux/cleanup.h>

>  #include <linux/export.h>
>  #include <linux/kernel.h>
>  #include <linux/kref.h>
> +#include <linux/gpio/driver.h>
> +#include <linux/gpio/machine.h>
> +#include <linux/idr.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
>  #include <linux/acpi.h>
> +#include <linux/platform_device.h>
>  #include <linux/reset.h>
>  #include <linux/reset-controller.h>
>  #include <linux/slab.h>

regards
Philipp

