Return-Path: <linux-kernel+bounces-153658-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B05DC8AD13F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 17:49:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D3B741C215E5
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 15:49:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ECD0153569;
	Mon, 22 Apr 2024 15:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b="meKbb9Mz"
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17142152DE9
	for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 15:49:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713800954; cv=none; b=tA2h3PoppAyKwKxk01oC43am5qaSQI5xN4pVuoqrHNV1THqhN+fiw8xb+YYYNswokse0KZfbv7RLBLsFODbw3fiu/PNjFn1Scw7SOzd4bOKlg3hEn+57CtagI/cyA4QPPhDF1sCfRplJvqQLLBtUzT0OgQkqQLnESPui3cWXTPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713800954; c=relaxed/simple;
	bh=8+kJGqKc4FvegZyfV/dJDORM3KjEZ2wD83pdhlBjSSY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lUAiuAQd0IyS5oH1DRjGLV6F1zOyDIA7w0W1Q1+b6JF0qRqhEeVbyAr39tQcZKaORlbbnODXKWw+Oy0e+30IV55mUDZ3Z+CDSBtQ0tlbDk1paKNYdjzej0pay1cjGYwVw1TUO6ufnA0hNq1T3GrS4hNkIHsB9ivEopnNxskiFh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca; spf=none smtp.mailfrom=ndufresne.ca; dkim=pass (2048-bit key) header.d=ndufresne-ca.20230601.gappssmtp.com header.i=@ndufresne-ca.20230601.gappssmtp.com header.b=meKbb9Mz; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndufresne.ca
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=ndufresne.ca
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-69b40061bbeso23930746d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 08:49:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndufresne-ca.20230601.gappssmtp.com; s=20230601; t=1713800951; x=1714405751; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zOvrIiNG0aaKsjuJ5ZDvsbyhs27QkgdQ17ctSNHHXUs=;
        b=meKbb9MzZ5q1UMLUAeD4ym+XJYETMKYiZzwu7YQZgiv/10kFPxaJuEup/eYIcCm2eN
         84MmD6n1WjLN6P1kysyapieA6EkkoYGLMsIZlIGDR4YBiwy8JeDgsHSfO3p5lq5+dZr/
         VEuz2TiU3RGdQgdHeYQH74ENseS7+yhOmQfNJN4ueNRekdBIBxE3SCHIB0xqpuolOb23
         S+NTyiyMgltvJNlf9Qk+3pLlEfm8PDDpzAiiZ3X4w9D4MnxfD1CnLoVvV8heum/u8u2c
         ClL41kPMIa9IdSC6H0kCy+i2GAxs4NkqT1BpuR3/QsYwF10fmAW0WT3o/B+zwlDUb45S
         9fZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713800951; x=1714405751;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zOvrIiNG0aaKsjuJ5ZDvsbyhs27QkgdQ17ctSNHHXUs=;
        b=cDtxY1lk+gidOY8ZJjgWT61H3Kq+99B5RC3KtHUPI70Tv3gW5sJgHJFSTtiPqI7Wdw
         GsM3m1MeVXJI4h2rzVbj9JL7OLJAKFwj1JadIROrWLjUNIVJCExlonZZl4xCW2UAQX1a
         3uFxg+1Vmnzk0rgkzOfx+jmMjqjeFLQAV+SZNfrD8amxGa/FAbbFHw4OLkhhs2e+TbUe
         XLN5qLKiujO+z+WTpLwzuR2T87TWaWv+fZ/H9Da3d1O75QVnQfFr/WxlAjYSPXRkMQR/
         DjxoWaryYYTD7uN7UjFDvRy50C9NduFi7t9yLU99t6iZ8M+15Lz2Ej8dXScWYFMy3Vof
         rBwQ==
X-Forwarded-Encrypted: i=1; AJvYcCW0tkJWdCXTL2Baf031ml0BAudFGWjmrKODwjPwsayraMcgMeLbFJhvgroqGjWTykYt6VVH4DDGbfAPjvdmM0tTgKXGkPBYSWOqrSM1
X-Gm-Message-State: AOJu0YzPuuzGc8BTHEexHrkvxzXDnI4JgLIwsC0a6qcIiif4kWfGNS43
	nhTcvWUnzxw3E6LBEB4ngwOYoGkx7lC1QQbLVB5/bU0we91zdjUCViciEmpG5LQ=
X-Google-Smtp-Source: AGHT+IE3Bq8tLbi/XvedFxKP/vXgB2Slr/fd2putnR6Hk36vUZQFDg9vrhAsJgkdeDpTvevbTxVe3w==
X-Received: by 2002:a05:6214:c45:b0:6a0:5c0c:c857 with SMTP id r5-20020a0562140c4500b006a05c0cc857mr14050963qvj.18.1713800950977;
        Mon, 22 Apr 2024 08:49:10 -0700 (PDT)
Received: from nicolas-tpx395.localdomain ([2606:6d00:17:6448::7a9])
        by smtp.gmail.com with ESMTPSA id b4-20020a0cf044000000b0069b1e2f3074sm4365358qvl.98.2024.04.22.08.49.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Apr 2024 08:49:10 -0700 (PDT)
Message-ID: <3cc5a7dbd5c0f03d6137e0795fae69f5533a8f9f.camel@ndufresne.ca>
Subject: Re: [RESEND PATCH v2 4/4] media: chips-media: wave5: Support YUV422
 raw pixel-formats on the encoder.
From: Nicolas Dufresne <nicolas@ndufresne.ca>
To: "jackson.lee" <jackson.lee@chipsnmedia.com>, "mchehab@kernel.org"
	 <mchehab@kernel.org>, "sebastian.fricke@collabora.com"
	 <sebastian.fricke@collabora.com>
Cc: "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hverkuil@xs4all.nl" <hverkuil@xs4all.nl>,  Nas Chung
 <nas.chung@chipsnmedia.com>, "lafley.kim" <lafley.kim@chipsnmedia.com>,
 "b-brnich@ti.com" <b-brnich@ti.com>
Date: Mon, 22 Apr 2024 11:49:09 -0400
In-Reply-To: <SE1P216MB1303F475980132394E5E79DAED122@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
References: <20240311105623.20406-1-jackson.lee@chipsnmedia.com>
	 <20240311105623.20406-5-jackson.lee@chipsnmedia.com>
	 <3ba3445e820e14730794e85fb4322e5aa57e1119.camel@ndufresne.ca>
	 <SE1P216MB1303F475980132394E5E79DAED122@SE1P216MB1303.KORP216.PROD.OUTLOOK.COM>
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

Hi Jackson,

Le lundi 22 avril 2024 =C3=A0 04:30 +0000, jackson.lee a =C3=A9crit=C2=A0:
> Hi Nicolas
>=20
>=20
> > -----Original Message-----
> > From: Nicolas Dufresne <nicolas@ndufresne.ca>
> > Sent: Friday, April 19, 2024 6:06 AM
> > To: jackson.lee <jackson.lee@chipsnmedia.com>; mchehab@kernel.org;
> > sebastian.fricke@collabora.com
> > Cc: linux-media@vger.kernel.org; linux-kernel@vger.kernel.org;
> > hverkuil@xs4all.nl; Nas Chung <nas.chung@chipsnmedia.com>; lafley.kim
> > <lafley.kim@chipsnmedia.com>; b-brnich@ti.com
> > Subject: Re: [RESEND PATCH v2 4/4] media: chips-media: wave5: Support Y=
UV422
> > raw pixel-formats on the encoder.
> >=20
> > Le lundi 11 mars 2024 =C3=A0 19:56 +0900, jackson.lee a =C3=A9crit=C2=
=A0:
> > > From: "Jackson.lee" <jackson.lee@chipsnmedia.com>
> > >=20
> > > Add support for the YUV422P, NV16, NV61, YUV422M, NV16M, NV61M raw pi=
xel-
> > formats to the Wave5 encoder.
> > > All these formats have a chroma subsampling ratio of 4:2:2 and theref=
ore
> > require a new image size calculation as the driver previously only hand=
led a
> > ratio of 4:2:0.
> > >=20
> > > Signed-off-by: Jackson.lee <jackson.lee@chipsnmedia.com>
> > > Signed-off-by: Nas Chung <nas.chung@chipsnmedia.com>
> > > ---
> > >  .../chips-media/wave5/wave5-vpu-enc.c         | 59 +++++++++++++++++=
--
> > >  1 file changed, 54 insertions(+), 5 deletions(-)
> > >=20
> > > diff --git a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > index 5a32bb138158..77657f63a169 100644
> > > --- a/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > +++ b/drivers/media/platform/chips-media/wave5/wave5-vpu-enc.c
> > > @@ -39,6 +39,24 @@ static const struct vpu_format
> > enc_fmt_list[FMT_TYPES][MAX_FMTS] =3D {
> > >  		{
> > >  			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV21M,
> > >  		},
> > > +		{
> > > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV422P,
> > > +		},
> > > +		{
> > > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV16,
> > > +		},
> > > +		{
> > > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV61,
> > > +		},
> > > +		{
> > > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_YUV422M,
> > > +		},
> > > +		{
> > > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV16M,
> > > +		},
> > > +		{
> > > +			.v4l2_pix_fmt =3D V4L2_PIX_FMT_NV61M,
> > > +		},
> > >  	}
> > >  };
> > >=20
> > > @@ -101,13 +119,30 @@ static int start_encode(struct vpu_instance *in=
st,
> > u32 *fail_res)
> > >  	struct vb2_v4l2_buffer *dst_buf;
> > >  	struct frame_buffer frame_buf;
> > >  	struct enc_param pic_param;
> > > -	u32 stride =3D ALIGN(inst->dst_fmt.width, 32);
> > > -	u32 luma_size =3D (stride * inst->dst_fmt.height);
> > > -	u32 chroma_size =3D ((stride / 2) * (inst->dst_fmt.height / 2));
> > > +	u32 stride =3D inst->src_fmt.plane_fmt[0].bytesperline;
> > > +	u32 luma_size =3D (stride * inst->src_fmt.height);
> > > +	u32 chroma_size =3D 0;
> >=20
> > The helper introduced in previous patch also calculate sizeimage for ea=
ch
> > planes, so no need for this code anymore.
>=20
> Your comment means the below code?=20
>=20
> 	u32 luma_size =3D inst->src_fmt.plane_fmt[0].sizeimage
> 	u32 chroma_size =3D inst->src_fmt.plane_fmt[1].sizeimage
>=20
> =09
> >=20
> > >=20
> > >  	memset(&pic_param, 0, sizeof(struct enc_param));
> > >  	memset(&frame_buf, 0, sizeof(struct frame_buffer));
> > >=20
>=20
> The below code could be removed.
>=20
> > > +	if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV420 ||
> > > +	    inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV420M)
> > > +		chroma_size =3D luma_size / 4;
> > > +	else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12 ||
> > > +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21 ||
> > > +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV12M ||
> > > +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV21M)
> > > +		chroma_size =3D luma_size / 2;
> > > +	else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV422P ||
> > > +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_YUV422M)
> > > +		chroma_size =3D luma_size / 2;
> > > +	else if (inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16 ||
> > > +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61 ||
> > > +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV16M ||
> > > +		 inst->src_fmt.pixelformat =3D=3D V4L2_PIX_FMT_NV61M)
> > > +		chroma_size =3D luma_size;
> > > +
>=20
> Is That right?

Yes, using the src_fmt seems accurate for the encoder.

cheers,
Nicolas

