Return-Path: <linux-kernel+bounces-19489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 42A90826DB4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 13:22:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6970B20B8C
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 12:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 203FE405D6;
	Mon,  8 Jan 2024 12:21:53 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B0C1405CD
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 12:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rModK-0007ah-HH; Mon, 08 Jan 2024 13:21:34 +0100
Received: from [2a0a:edc0:0:900:1d::4e] (helo=lupine)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rModJ-001FLl-AR; Mon, 08 Jan 2024 13:21:33 +0100
Received: from pza by lupine with local (Exim 4.96)
	(envelope-from <p.zabel@pengutronix.de>)
	id 1rModJ-00090a-0m;
	Mon, 08 Jan 2024 13:21:33 +0100
Message-ID: <eb41618782e1cd80d469a65bcdbf640ebbfb4f5c.camel@pengutronix.de>
Subject: Re: [PATCH v2 1/4] reset: gpio: Add GPIO-based reset controller
From: Philipp Zabel <p.zabel@pengutronix.de>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Srinivas
 Kandagatla <srinivas.kandagatla@linaro.org>, Banajit Goswami
 <bgoswami@quicinc.com>,  Bjorn Andersson <andersson@kernel.org>, Konrad
 Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,  Conor Dooley
 <conor+dt@kernel.org>, Jaroslav Kysela <perex@perex.cz>, Takashi Iwai
 <tiwai@suse.com>,  alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org,  linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org,  linux-kernel@vger.kernel.org
Cc: Bartosz Golaszewski <brgl@bgdev.pl>, Sean Anderson
 <sean.anderson@seco.com>
Date: Mon, 08 Jan 2024 13:21:33 +0100
In-Reply-To: <20240105155918.279657-2-krzysztof.kozlowski@linaro.org>
References: <20240105155918.279657-1-krzysztof.kozlowski@linaro.org>
	 <20240105155918.279657-2-krzysztof.kozlowski@linaro.org>
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

On Fr, 2024-01-05 at 16:59 +0100, Krzysztof Kozlowski wrote:
> Add a simple driver to control GPIO-based resets using the reset
> controller API for the cases when the GPIOs are shared and reset should
> be coordinated.  The driver is expected to be used by reset core
> framework for ad-hoc reset controllers.

I don't know how evil it is to set a parent-less platform device's
of_node to another device's node, but I like the simplicity of a
single-GPIO reset controller driver more that I had expected.

[...]
> diff --git a/drivers/reset/reset-gpio.c b/drivers/reset/reset-gpio.c
> new file mode 100644
> index 000000000000..cf0a867cbc5f
> --- /dev/null
> +++ b/drivers/reset/reset-gpio.c
> @@ -0,0 +1,121 @@
[...]
> +static void reset_gpio_of_args_put(void *data)

This should probably be called reset_gpio_of_node_put().

> +{
> +	of_node_put(data);
> +}
[...]

regards
Philipp

