Return-Path: <linux-kernel+bounces-61025-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14C95850C65
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 00:52:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4712C1C209C1
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 23:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2C17752;
	Sun, 11 Feb 2024 23:52:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="ErQpVAL1"
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [46.235.227.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68555175AC;
	Sun, 11 Feb 2024 23:52:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.235.227.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707695540; cv=none; b=DCX3JkONSOhbUXGTVBvfjRy6VaIs+1PuZGOrdCahODgPd3H3l9T0b/3K69NxiHI6mRhlS0cWfE3XYq0H1arpX1oQ43i9kD8s5Po+4Lq0NVwEmrpXNj1yQuZbD4Gz6q/x6fgmtWJVoJRIgraNuVTGCujTu+UcpYUmFxUvH7cmcVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707695540; c=relaxed/simple;
	bh=yCd/erocB2whCzAU44Y85T8o/7uo1qHeqEXWr3kGZc0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DepP/tAWdnGOSo4s1ZP1IFfsCd2TogPRIJ8ilOelbpfex1GEcgkS5fBl5upgdLEtUrwwtBgVH69nXaGJZGC8AP3V7Bg2Pexg6KSyqIRslFZEL37+pJAtAoFj2P6khiYH5jcA4U0zE7rUnoKnkcD03rVBJIWVbPdkpwDtCnbj54U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=ErQpVAL1; arc=none smtp.client-ip=46.235.227.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1707695531;
	bh=yCd/erocB2whCzAU44Y85T8o/7uo1qHeqEXWr3kGZc0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErQpVAL1YfvE6DSHTa4qhdxHD9W1KR3gMUB1dg/XuxVTqOuUF3odKGTbAcZlwSo5u
	 i0hSkQqseLC1O4MVuQYOXRcGBduVg9UQQWdkUQBVHez1SVoHWarf7WoDb1C9PyeV1E
	 pm0XdFJcCWIp5Sf4uvQipNVstdkD3vX/kQSYIn1qjH430Dmz10kMpGthBQa+Vb4ZvQ
	 t9IFwNxR5ceyWie9l88nBtVEAIZghEOKhtjU62GVn8cwySUsr68cLe51ytGe/l0x+u
	 lv2Jwtr5wFcWxj29pLyw6c1El/hGRWuU15vmaEP5yoadvQ0sK7nUo+0Hx8bitwtlBs
	 GkFXEKAKMQPaQ==
Received: from mercury (cola.collaboradmins.com [195.201.22.229])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: sre)
	by madrid.collaboradmins.com (Postfix) with ESMTPSA id E5CC137810EF;
	Sun, 11 Feb 2024 23:52:10 +0000 (UTC)
Received: by mercury (Postfix, from userid 1000)
	id 56CCC106043F; Mon, 12 Feb 2024 00:52:10 +0100 (CET)
Date: Mon, 12 Feb 2024 00:52:10 +0100
From: Sebastian Reichel <sebastian.reichel@collabora.com>
To: Andrew Davis <afd@ti.com>
Cc: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
	Cristian Ciocaltea <cristian.ciocaltea@gmail.com>, Florian Fainelli <florian.fainelli@broadcom.com>, 
	Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Sean Wang <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>, 
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-actions@lists.infradead.org, linux-arm-msm@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH v3 18/19] power: reset: syscon-poweroff: Move device data
 into a struct
Message-ID: <glaiaikudbtuahnwnqoduretcnmrpb7lg2gerlnntcltrjfcko@4vgjb4v66rad>
References: <20240208170410.67975-1-afd@ti.com>
 <20240208170410.67975-19-afd@ti.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="kaire7t4f3nkubt5"
Content-Disposition: inline
In-Reply-To: <20240208170410.67975-19-afd@ti.com>


--kaire7t4f3nkubt5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Andrew,

On Thu, Feb 08, 2024 at 11:04:09AM -0600, Andrew Davis wrote:
> Currently all these device data elements are top level global variables.
> Move these into a struct. This will be used in the next patch when
> the global variable usage is removed. Doing this in two steps makes
> the patches easier to read.
>=20
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collab=
ora.com>
> ---
>  drivers/power/reset/syscon-poweroff.c | 36 +++++++++++++++------------
>  1 file changed, 20 insertions(+), 16 deletions(-)
>=20
> diff --git a/drivers/power/reset/syscon-poweroff.c b/drivers/power/reset/=
syscon-poweroff.c
> index 1b2ce7734260c..4899a019256e8 100644
> --- a/drivers/power/reset/syscon-poweroff.c
> +++ b/drivers/power/reset/syscon-poweroff.c
> @@ -15,15 +15,19 @@
>  #include <linux/pm.h>
>  #include <linux/regmap.h>
> =20
> -static struct regmap *map;
> -static u32 offset;
> -static u32 value;
> -static u32 mask;
> +struct syscon_poweroff_data {
> +	struct regmap *map;
> +	u32 offset;
> +	u32 value;
> +	u32 mask;
> +};
> +
> +static struct syscon_poweroff_data *data;

This patch is broken without the follow-up patch, since data is
never allocated. You need to move the memory allocation from the
next patch to this one.

Greetings,

-- Sebastian

--kaire7t4f3nkubt5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmXJXaIACgkQ2O7X88g7
+pqWHw//YjP5WDl7ANWk9IYw2vdEU3+QH1H7FGbUoqOS9I3NQYsyulnSSNcpgNPR
cjcrY/JjHY1YgnpjYOpTVZo7wA3IiBcEs/cW27nmZPAChYMMxjpxSqFHFAJHziP5
TAbPTHQVwEXT8/UVC5+SH4lJpTu3TvEdd5dvDfwDxndhtZN4LD4sfi4sicqZqPXT
o7z1rrkiTsrxG7bPlOkwSYDJMHda4vRThjNCViOMNGZvVXCv9xl8wLZakhCzG0Kq
yLmeSZlrAHd9hliX3lGOGJVrCEGpURn1qmXIJcKHKsbhX9FJwtC4R5BJYRQ6lVYs
rLIrMAaomMFfys+1qKV9JaJQRzcsjmWLhS1jjZSuAgbXNdwEWti+lzkTZHUedIM7
eSTFGlRWQehHEt6ScfZYS5ng6hjpw6VOPJpeXfocH/06HKbHFal8AHgVRNxnq/m1
dvTON6w0wbbMOuZD99CbIdSbSM7b6fVEHuipwiVC7ma0+1q/SUTC9wdcP6EHlCUm
oMqCuNcfTlmPuyV2XDN2Z/gcZukKdgsS0nxf9G1rennT0ksQAVyhOsz/RhjtTHEP
Y36rClmKr7j81XO4fu37OCnEX6qGff/EYnV5M2d5Dx/Qog/dbcUQ+VsezYtnx5uH
+cQcEKfBdCmbqY2EmZZaM/0y/r7Ch0AETaeS9bKv30yNqsH4Dhc=
=X1uU
-----END PGP SIGNATURE-----

--kaire7t4f3nkubt5--

