Return-Path: <linux-kernel+bounces-131929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 306A9898DA2
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 20:00:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5390B1C2854E
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 18:00:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23F4A130A7F;
	Thu,  4 Apr 2024 17:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="PMDetWDO"
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0DB12D770
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 17:59:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712253576; cv=none; b=s7vrnQzrGGJhVzDAhp9XuKzmMjxI3gRYdmZPMgTYTfG9MVCWt6iTBt/iNUUjTRNY/OIGqKrGDQ+Fkhzg5yNvO481oqJsjSgzQZ9Zq8g5L3hPNNzqvAziJrTdqB2dAta65h035LEbIy9hd/L68K60AYMlxvacNzY+ckZDLFpJoqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712253576; c=relaxed/simple;
	bh=9BK5X696fOVNw8qgEtaf8iePyUePYxaCiHXlX+XZAxk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=CvFSVbMZnw0ZWx2yrMyQSUEmGIVDCstsZnefk2uO060sfkvAra4Nn2aVYSdH+hf6Y7m3Q8D1B1zIu4ccQ3kVpWqKra4ElREmdhH6CROP10GFArTO3PkfE91CCsnTpkBgGg7WWmTri77BQ6hm8fXKFSvB7Cw8HRioGxwKpzvr39g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=PMDetWDO; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-6e89bdd4e3fso689041a34.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 10:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1712253574; x=1712858374; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=gtbOwmF31Kwl4TtfLzGBtUJJifAFG8EYmATKNI7DLsY=;
        b=PMDetWDOFjs77zGSEeyicz8GaEGpddVrBYof/JjciU7N8v2+t5odeAsgVAPftCBFVM
         wufdkgPlj7DOClRuGyo8di5bzPSavEXIjlPJZo0XWnK/RrIGB76z4bXUSjQUpgP9ePDk
         ouV6yvULW52yviZe3u6rS+E+R9Rck27tJZftml5aHWhU/LJRDs4OB+4G4+cfUgx5mZj4
         hBy96EtiJ9fczHiML5KHqoB7ATeNHdG7VcBEXE6TSuyZQx7QeSyF8HFsY1yVUXkPnDxg
         52ESrlxtgUFPNzhChkBU/HlAWEYWAS4vZjCvQ6Gylqwi+zksTU2hLlNMLplyw2QJJ6tb
         GEoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712253574; x=1712858374;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtbOwmF31Kwl4TtfLzGBtUJJifAFG8EYmATKNI7DLsY=;
        b=Wk01qqtK0dokqOb4+W3JZukP956ENDsRDX023bB3xowtCgfO2DoIh2tfhK+vJNrX/W
         8+Xo6+oEIbHGa/+RKwk6vayFp1ExNAIpHGCZoPzX8ySJU/yRlGU325w5HRX0A1t+kOJ/
         fJ0gxonpHcGmP+2VFJsv64sXvl1VtKgguOiB5kdbTvubazpqxYF1y2EYVrqcjf1ECCLE
         7I9WGQ4dDq63vBaHO3Iup7bogHQLxqzT9nWv/4epQayEoBBCqtopMLxmMYpdGwyznh6/
         fXIUx/5dScEOffeqs0bMNKEFUQAeTMafosFu/DjKW6V0hRoa4jkU9gSX4KVNxPQSs5AA
         UgJg==
X-Forwarded-Encrypted: i=1; AJvYcCUAcx0Pdw2h86ZjAun348IP4oCC4jPBV+PrplsMdM8QgL3cFZkHugwNOoG2XC8ATvNuonWXI6kwdwQ92SN/oU1AmGGQeFt0iZFVb+AF
X-Gm-Message-State: AOJu0Yy1984//1dUMQiQ485Qkx5nimEBIPStNeafOy2QQZ4CJXtyqPXc
	jyPmhB0oOCmK1hwje/v33kIgdzDQxia1NGRitxkmCLCtKATO75Vdk9adlzg/m1E=
X-Google-Smtp-Source: AGHT+IFYhq0L3gKO1QVmkYzFz1+veAdcyYTGN019NpAj6tZTzQ4zvNjtwKR8OUKV4sfG/YOgLvTArg==
X-Received: by 2002:a9d:7cc1:0:b0:6e8:9461:1eb5 with SMTP id r1-20020a9d7cc1000000b006e894611eb5mr3240908otn.38.1712253574062;
        Thu, 04 Apr 2024 10:59:34 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448:fa75:a4ff:fe45:b56])
        by smtp.gmail.com with ESMTPSA id xx10-20020a05620a5d8a00b0078a3a648bc3sm6066080qkn.2.2024.04.04.10.59.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 10:59:33 -0700 (PDT)
Message-ID: <e4d01c27aa976c44e0b7122e39111be062a4deb4.camel@ndufresne.ca>
Subject: Re: [PATCH] media: verisilicon: AV1: Be more fexible on postproc
 capabilities
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: Benjamin Gaignard <benjamin.gaignard@collabora.com>, 
	ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de, mchehab@kernel.org, 
	heiko@sntech.de
Cc: linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
	kernel@collabora.com
Date: Thu, 04 Apr 2024 13:59:33 -0400
In-Reply-To: <20240328093439.18712-1-benjamin.gaignard@collabora.com>
References: <20240328093439.18712-1-benjamin.gaignard@collabora.com>
Autocrypt: addr=nicolas@ndufresne.ca; prefer-encrypt=mutual; keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi,

Le jeudi 28 mars 2024 =C3=A0 10:34 +0100, Benjamin Gaignard a =C3=A9crit=C2=
=A0:
> RK3588 post-processor block is able to convert 10 bits streams
> into 8 bits pixels format.

Does it come with any HDR to SDR capabilities ? cause stripping off 2 bits =
means
that tone mapping will cause a lot of banding as it won't have the expected
precision. I'm simply trying to make up the big portrait so we don't just o=
ffer
yet another foot gun. But perhaps its fine to offer this, its just that we =
don't
have a mechanism to report which pixel format in the selection will cause d=
ata
lost.

Nicolas

>=20
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> Fixes: 003afda97c65 ("media: verisilicon: Enable AV1 decoder on rk3588")
> ---
>  drivers/media/platform/verisilicon/rockchip_vpu_hw.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c b/drive=
rs/media/platform/verisilicon/rockchip_vpu_hw.c
> index f97527670783..964122e7c355 100644
> --- a/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> +++ b/drivers/media/platform/verisilicon/rockchip_vpu_hw.c
> @@ -82,7 +82,6 @@ static const struct hantro_fmt rockchip_vpu981_postproc=
_fmts[] =3D {
>  	{
>  		.fourcc =3D V4L2_PIX_FMT_NV12,
>  		.codec_mode =3D HANTRO_MODE_NONE,
> -		.match_depth =3D true,
>  		.postprocessed =3D true,
>  		.frmsize =3D {
>  			.min_width =3D ROCKCHIP_VPU981_MIN_SIZE,


