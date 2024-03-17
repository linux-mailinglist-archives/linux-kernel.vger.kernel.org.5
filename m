Return-Path: <linux-kernel+bounces-105513-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FCC787DF91
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 20:14:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C756028112B
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5EEC1EA8F;
	Sun, 17 Mar 2024 19:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Czq4BK2u"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96171EEE0;
	Sun, 17 Mar 2024 19:14:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710702867; cv=none; b=V08jszVs04zKnMDkxh505k2MDFmQbOzNJbr6pIofb/RWuOQktbbnImdmAbWij1CnXmUuM5vVWr6sEP5A0U60ztQdVL22j7+4Vp+YLR1ZA+gZwnEiqXbHufTOqbNHtflnHgigitpRIOEFdnTElisSgHwmoQXXstwj5wuBYYEmjeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710702867; c=relaxed/simple;
	bh=fztyQgbF2q1PoJtiGulktjTHyUhlHcKdvlGV1V2IrWY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dtux6rqEfxC6UOD78q422XuAP1ZKonNlkgSUo5OC2EhZYhy+kr46BHN0ulwyYimX/28yZMhsBvCDvGlrjuFcr1hBvNkGDkBjlTsOMc3bdAhdDkAK/RBoIikhk01ZcqftABeNIs7Nv/pOGUpsoSAu2ayQXwyXLNBnwNGcG//27Z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Czq4BK2u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24F67C433F1;
	Sun, 17 Mar 2024 19:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710702866;
	bh=fztyQgbF2q1PoJtiGulktjTHyUhlHcKdvlGV1V2IrWY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Czq4BK2uZkizeJ8j9pxUjylVlTTZiixjX/OQAeXZE3CCK3ozdfkU3QT6VfDA8EVdb
	 QwJECovGef+zpZH1YYoBZbnusq5LB7GgKd9aYM3WPjvowQbmDNXblNlPr384UbAHrH
	 Ty+5SEprnxK3ewfqWkYu27lx55p5eQXuI4qOzeyqP8XrOdIDKmaHX2F/opT2USpUVK
	 +FusKo2TRReDaiOTfNGPscYskM2UXGBGxDKyEuRwGJPRGJ9KjzXg9ciMEEiERGbQyY
	 WGsEbV4HBY24+Ot9Pj4Wl0tRgL9myDmj/GdcTx94cxoFswDbS2GsYbTY8P+d2Wet8H
	 7eljF77ZnHYHQ==
Date: Sun, 17 Mar 2024 13:14:24 -0600
From: Rob Herring <robh@kernel.org>
To: Jan Dakinevich <jan.dakinevich@salutedevices.com>
Cc: Takashi Iwai <tiwai@suse.com>, Kevin Hilman <khilman@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-sound@vger.kernel.org, linux-amlogic@lists.infradead.org,
	Jerome Brunet <jbrunet@baylibre.com>, linux-kernel@vger.kernel.org,
	Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
	kernel@salutedevices.com, devicetree@vger.kernel.org,
	linux-clk@vger.kernel.org, Jaroslav Kysela <perex@perex.cz>,
	Philipp Zabel <p.zabel@pengutronix.de>, alsa-devel@alsa-project.org,
	Conor Dooley <conor+dt@kernel.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Michael Turquette <mturquette@baylibre.com>,
	linux-arm-kernel@lists.infradead.org,
	Mark Brown <broonie@kernel.org>, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 18/25] ASoC: dt-bindings: meson: axg-pdm: claim support
 of A1 SoC family
Message-ID: <171070286359.2088899.4357091464110739659.robh@kernel.org>
References: <20240314232201.2102178-1-jan.dakinevich@salutedevices.com>
 <20240314232201.2102178-19-jan.dakinevich@salutedevices.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240314232201.2102178-19-jan.dakinevich@salutedevices.com>


On Fri, 15 Mar 2024 02:21:54 +0300, Jan Dakinevich wrote:
> Add "amlogic,a1-pdm" compatible string alias to "amlogic,axg-pdm".
> 
> Signed-off-by: Jan Dakinevich <jan.dakinevich@salutedevices.com>
> ---
>  Documentation/devicetree/bindings/sound/amlogic,axg-pdm.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 

Acked-by: Rob Herring <robh@kernel.org>


