Return-Path: <linux-kernel+bounces-132512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 18893899612
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 08:59:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B8ED28629E
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 06:59:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60EB528DBC;
	Fri,  5 Apr 2024 06:59:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NHF5Aqee"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138FD24B5B;
	Fri,  5 Apr 2024 06:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712300344; cv=none; b=Ow+yarwnmShzODYd76djfSzYFYsGPFZ9d/aLVR3/O56H9GMNEerPx+HPALg98WwpviH1hJZKG+W8m44ipjSgqu2SpUf2xCl9SXpkvreWtXBJ+BWxZJ/c6H3y8C+I5c7q1H8o8IP03H8Hvhrb3hDR3h7H5dDGd3PTAGG141gNECI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712300344; c=relaxed/simple;
	bh=pUg3n1Irw/j3lwjLbn/K2qRZnbg0yPoUrDBFEOcFtzw=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jIY/6pXzjmfFYOj+7aMCbpaipT4Ab7J6bRuRTvFs9aV+5rID7wX5KA4wH654e0y+ZLwbwq2m+3eRcd+ROh2H4aJExyH7g2gy4IxmnHM3drTmgnYRwBRWZePiFi055J8AfepI1s4eV6WoUxDB2tTgXayOWX3mZ2qTucYk02WKmnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NHF5Aqee; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3434c6e1941so856538f8f.0;
        Thu, 04 Apr 2024 23:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712300341; x=1712905141; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NtsP9N3Y/UsOibduuzAW0/izjs/GyV9mM2aDGvk1f1Y=;
        b=NHF5AqeeS/aNR3eL2DNwlBeIgJ2zZPtX1bUe8qFwjtGo52YhB0H0Y0cMmwZqvhqoxI
         Hdl7ki6huYdCFTCfTTpPfmfCrZaZNRkJ+jhBUiUzqMc/oHQGidb4p6HSl3t3cD5nlcbE
         diDtHOfOMp8niA8cv0vihgR6Fpey/+FH4RS1kbkFT/tUVoXkFQRt8g4iFSsa/7x1/M/p
         vAL9vJAlAXtI7VRp3e1L8SB+ZVC+Jfce81RTMLi+eB/1IN45JE+0XdoAAudNrJjxK/in
         Yqc5gaPPuIwymvMR8DxebRWiB7UnapbNOxD9ZsxMufiqkpq2/YThDpDej9bU0GuxTIh5
         cjbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712300341; x=1712905141;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:to:from:subject:message-id:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NtsP9N3Y/UsOibduuzAW0/izjs/GyV9mM2aDGvk1f1Y=;
        b=mRZPWyuvhI9yjxWB49SQD8LWV2QEpqEwU+M18OIouKNevwP7NT6WJUVM5UDZNQrGXa
         UoODUesPDoeYjaN/IeG/X0tifxRVTBUy8RXic3MQjRmIQcBUVaXTZPHjrV7VnbakVxie
         W3JYJNmKf1R5/K8vlFEfJsnoIn0xQoLKo7N6L9vWTqxG7/bQqSOqWQQuB0sZW0Xu+cEJ
         dcTC39DplzkuW1SBw1dUsh+UgZhe2wxQBV6qZQR4fh2lFDc4UFayBw4nZXokkTUxBuzl
         m2v8EOE0LUTw9SeFAKGF9MV/4x5WxzEC4EcVXF4vn/dWV9dWKwLLmgWPBqlQvcKqZqZN
         Ko/A==
X-Forwarded-Encrypted: i=1; AJvYcCURqg0BjnqnV4D4dItj2OgeHFHQpuPbtYmPUJ39KvvufZ91LEKlCTIf1Ag8sCkxNuwsELuaHbnl7AtnFZJdVkO3qThAjIgOIfs/zWGKYUo8QQURjjdHvj8gm2RQrsZQ7fKWs3upiMGC
X-Gm-Message-State: AOJu0Yw4Z/k+jkGKwYGtCUJU8Hf7xCQG3WP0oKfNNKdx+vQ3srlI6bTI
	7JDfbvjcCBBkeyhW8MHdeHSYbyEIgkivyOymTzukFt3Og2nD7vgx
X-Google-Smtp-Source: AGHT+IFOV0vx06Mwcrc3cTYRhkWOotSTL3QGIXw6WKI1DyRFX6MrrCFP6WKAxdAeHCfli1UKqOf7iQ==
X-Received: by 2002:a5d:6705:0:b0:343:6f87:fe33 with SMTP id o5-20020a5d6705000000b003436f87fe33mr461580wru.7.1712300341138;
        Thu, 04 Apr 2024 23:59:01 -0700 (PDT)
Received: from ?IPv6:2003:f6:ef16:e300:6c47:9f78:b083:629a? (p200300f6ef16e3006c479f78b083629a.dip0.t-ipconnect.de. [2003:f6:ef16:e300:6c47:9f78:b083:629a])
        by smtp.gmail.com with ESMTPSA id dr20-20020a5d5f94000000b0033ea499c645sm1265764wrb.4.2024.04.04.23.59.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 23:59:00 -0700 (PDT)
Message-ID: <00ed6785db2b43ec3727f42c71dc2c8dd1b627f1.camel@gmail.com>
Subject: Re: [PATCH v2 1/1] iio:imu: adis16475: Fix sync mode setting
From: Nuno =?ISO-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
To: Ramona Gradinariu <ramona.bolboaca13@gmail.com>, 
	linux-kernel@vger.kernel.org, jic23@kernel.org, nuno.sa@analog.com, 
	linux-iio@vger.kernel.org
Date: Fri, 05 Apr 2024 09:02:33 +0200
In-Reply-To: <20240405045309.816328-2-ramona.bolboaca13@gmail.com>
References: <20240405045309.816328-1-ramona.bolboaca13@gmail.com>
	 <20240405045309.816328-2-ramona.bolboaca13@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.0 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Fri, 2024-04-05 at 07:53 +0300, Ramona Gradinariu wrote:
> Fix sync mode setting by applying the necessary shift bits.
>=20
> Fixes: fff7352bf7a3 ("iio: imu: Add support for adis16475")
> Signed-off-by: Ramona Gradinariu <ramona.bolboaca13@gmail.com>
> ---

Not sure there was a reason to drop my tag... Anyways:

Reviewed-by: Nuno Sa <nuno.sa@analog.com>

> changes in v2:
> =C2=A0- added u16 value to call __adis_update_bits to fix build error
> =C2=A0drivers/iio/imu/adis16475.c | 4 +++-
> =C2=A01 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/iio/imu/adis16475.c b/drivers/iio/imu/adis16475.c
> index 01f55cc902fa..060a21c70460 100644
> --- a/drivers/iio/imu/adis16475.c
> +++ b/drivers/iio/imu/adis16475.c
> @@ -1289,6 +1289,7 @@ static int adis16475_config_sync_mode(struct adis16=
475
> *st)
> =C2=A0	struct device *dev =3D &st->adis.spi->dev;
> =C2=A0	const struct adis16475_sync *sync;
> =C2=A0	u32 sync_mode;
> +	u16 val;
>=20
> =C2=A0	/* default to internal clk */
> =C2=A0	st->clk_freq =3D st->info->int_clk * 1000;
> @@ -1350,8 +1351,9 @@ static int adis16475_config_sync_mode(struct adis16=
475
> *st)
> =C2=A0	 * I'm keeping this for simplicity and avoiding extra variables
> =C2=A0	 * in chip_info.
> =C2=A0	 */
> +	val =3D ADIS16475_SYNC_MODE(sync->sync_mode);
> =C2=A0	ret =3D __adis_update_bits(&st->adis, ADIS16475_REG_MSG_CTRL,
> -				 ADIS16475_SYNC_MODE_MASK, sync->sync_mode);
> +				 ADIS16475_SYNC_MODE_MASK, val);
> =C2=A0	if (ret)
> =C2=A0		return ret;
>=20
> --
> 2.34.1
>=20


