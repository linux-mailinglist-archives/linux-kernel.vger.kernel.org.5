Return-Path: <linux-kernel+bounces-2648-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D0A06815FE0
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 15:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 42A86B21FB5
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 14:40:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50941446DF;
	Sun, 17 Dec 2023 14:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=crapouillou.net header.i=@crapouillou.net header.b="uy1KddWp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from aposti.net (aposti.net [89.234.176.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49BD44373;
	Sun, 17 Dec 2023 14:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=crapouillou.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=crapouillou.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
	s=mail; t=1702824030;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=3UMKMOKGFl2fsIk9JhzL3lZuepQtAoYkfTj1MeKujzM=;
	b=uy1KddWps0AePYoqIJQe60Ly9AIztA/27M7bgs1tRIE82KoJhxbQwp5Gcay+lASSadjIFg
	idLEPWloaFPGPsR7u5J6MTK/boVNts1tBFg2vpQ3jp0xzsGVU0hwZtggKmD6LFbO7cnL37
	1h5GxTev4lKjD3Gfzn3DDXbfCzZmcYc=
Message-ID: <11e0d8b13cc835d8f99046110842d6bc569ff7a8.camel@crapouillou.net>
Subject: Re: [PATCH 06/15] memory: jz4780-nemc: Convert to platform remove
 callback returning void
From: Paul Cercueil <paul@crapouillou.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>, 
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel@pengutronix.de, linux-mips@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Date: Sun, 17 Dec 2023 15:40:29 +0100
In-Reply-To: <fa609b805a7ed6e4c6ce81464528ea4163625d67.1702822744.git.u.kleine-koenig@pengutronix.de>
References: <cover.1702822744.git.u.kleine-koenig@pengutronix.de>
	 <fa609b805a7ed6e4c6ce81464528ea4163625d67.1702822744.git.u.kleine-koenig@pengutronix.de>
Autocrypt: addr=paul@crapouillou.net; prefer-encrypt=mutual;
 keydata=mQENBF0KhcEBCADkfmrzdTOp/gFOMQX0QwKE2WgeCJiHPWkpEuPH81/HB2dpjPZNW03ZMLQfECbbaEkdbN4YnPfXgcc1uBe5mwOAPV1MBlaZcEt4M67iYQwSNrP7maPS3IaQJ18ES8JJ5Uf5UzFZaUawgH+oipYGW+v31cX6L3k+dGsPRM0Pyo0sQt52fsopNPZ9iag0iY7dGNuKenaEqkYNjwEgTtNz8dt6s3hMpHIKZFL3OhAGi88wF/21isv0zkF4J0wlf9gYUTEEY3Eulx80PTVqGIcHZzfavlWIdzhe+rxHTDGVwseR2Y1WjgFGQ2F+vXetAB8NEeygXee+i9nY5qt9c07m8mzjABEBAAG0JFBhdWwgQ2VyY3VlaWwgPHBhdWxAY3JhcG91aWxsb3UubmV0PokBTgQTAQoAOBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheAAAoJEHPua9InSr1BgvIH/0kLyrI3V0f33a6D3BJwc1grbygPVYGuC5l5eMnAI+rDmLR19E2yvibRpgUc87NmPEQPpbbtAZt8On/2WZoE5OIPdlId/AHNpdgAtGXo0ZX4LGeVPjxjdkbrKVHxbcdcnY+zzaFglpbVSvp76pxqgVg8PgxkAAeeJV+ET4t0823Gz2HzCL/6JZhvKAEtHVulOWoBh368SYdolp1TSfORWmHzvQiCCCA+j0cMkYVGzIQzEQhX7Urf9N/nhU5/SGLFEi9DcBfXoGzhyQyLXflhJtKm3XGB1K/pPulbKaPcKAl6rIDWPuFpHkSbmZ9r4KFlBwgAhlGy6nqP7O3u7q23hRW5AQ0EXQqFwQEIAMo+MgvYHsyjX3Ja4Oolg1Txzm8woj30ch2nACFCqaO0R/1kLj2VVeLrDyQUOlXx9PD6IQI4M8wy8m0sR4wV2p/g/paw7k65cjzYYLh+FdLNyO7IW
	YXndJO+wDPi3aK/YKUYepqlP+QsmaHNYNdXEQDRKqNfJg8t0f5rfzp9ryxd1tCnbV+tG8VHQWiZXNqN7062DygSNXFUfQ0vZ3J2D4oAcIAEXTymRQ2+hr3Hf7I61KMHWeSkCvCG2decTYsHlw5Erix/jYWqVOtX0roOOLqWkqpQQJWtU+biWrAksmFmCp5fXIg1Nlg39v21xCXBGxJkxyTYuhdWyu1yDQ+LSIUAEQEAAYkBNgQYAQoAIBYhBNdHYd8OeCBwpMuVxnPua9InSr1BBQJdCoXBAhsMAAoJEHPua9InSr1B4wsH/Az767YCT0FSsMNt1jkkdLCBi7nY0GTW+PLP1a4zvVqFMo/vD6uz1ZflVTUAEvcTi3VHYZrlgjcxmcGu239oruqUS8Qy/xgZBp9KF0NTWQSl1iBfVbIU5VV1vHS6r77W5x0qXgfvAUWOH4gmN3MnF01SH2zMcLiaUGF+mcwl15rHbjnT3Nu2399aSE6cep86igfCAyFUOXjYEGlJy+c6UyT+DUylpjQg0nl8MlZ/7Whg2fAU9+FALIbQYQzGlT4c71SibR9T741jnegHhlmV4WXXUD6roFt54t0MSAFSVxzG8mLcSjR2cLUJ3NIPXixYUSEn3tQhfZj07xIIjWxAYZo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le dimanche 17 d=C3=A9cembre 2023 =C3=A0 15:29 +0100, Uwe Kleine-K=C3=B6nig=
 a =C3=A9crit=C2=A0:
> The .remove() callback for a platform driver returns an int which
> makes
> many driver authors wrongly assume it's possible to do error handling
> by
> returning an error code. However the value returned is ignored (apart
> from emitting a warning) and this typically results in resource
> leaks.
>=20
> To improve here there is a quest to make the remove callback return
> void. In the first step of this quest all drivers are converted to
> .remove_new(), which already returns void. Eventually after all
> drivers
> are converted, .remove_new() will be renamed to .remove().
>=20
> Trivially convert this driver from always returning zero in the
> remove
> callback to the void returning variant.
>=20
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

Acked-by: Paul Cercueil <paul@crapouillou.net>

Cheers,
-Paul

> ---
> =C2=A0drivers/memory/jz4780-nemc.c | 5 ++---
> =C2=A01 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/memory/jz4780-nemc.c b/drivers/memory/jz4780-
> nemc.c
> index e5a93e7da15f..fb6db2ffe71b 100644
> --- a/drivers/memory/jz4780-nemc.c
> +++ b/drivers/memory/jz4780-nemc.c
> @@ -384,12 +384,11 @@ static int jz4780_nemc_probe(struct
> platform_device *pdev)
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> -static int jz4780_nemc_remove(struct platform_device *pdev)
> +static void jz4780_nemc_remove(struct platform_device *pdev)
> =C2=A0{
> =C2=A0	struct jz4780_nemc *nemc =3D platform_get_drvdata(pdev);
> =C2=A0
> =C2=A0	clk_disable_unprepare(nemc->clk);
> -	return 0;
> =C2=A0}
> =C2=A0
> =C2=A0static const struct jz_soc_info jz4740_soc_info =3D {
> @@ -408,7 +407,7 @@ static const struct of_device_id
> jz4780_nemc_dt_match[] =3D {
> =C2=A0
> =C2=A0static struct platform_driver jz4780_nemc_driver =3D {
> =C2=A0	.probe		=3D jz4780_nemc_probe,
> -	.remove		=3D jz4780_nemc_remove,
> +	.remove_new	=3D jz4780_nemc_remove,
> =C2=A0	.driver	=3D {
> =C2=A0		.name	=3D "jz4780-nemc",
> =C2=A0		.of_match_table =3D
> of_match_ptr(jz4780_nemc_dt_match),


