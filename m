Return-Path: <linux-kernel+bounces-36705-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A08483A548
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:24:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A00B81F22A03
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:23:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 553DB18E29;
	Wed, 24 Jan 2024 09:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqGqtlSM"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B51B599
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 09:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088108; cv=none; b=brWKfdGE0DzWWXTyCy1GyUt6kjiiyg7WbEmwRKJ9lzFJAi2ZeUB9j6X9KR2tAQXrdsiWmuLp02WGkQReSIykiz9JRIFfsoowZzYCSRJvMN+5ZLws9aoRAWDz01wUm7HFXnwGD+XaEVfoT3hWn2nSidqVmrwxi9ChqYAuyx7Scpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088108; c=relaxed/simple;
	bh=eF+zjiEZUQuKsPtg6bAJeNDrxHW3hVhj8Si24oj2+Z4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=aHTCsGli42LwF+ZM/aMgP7EirryXPMiK+c56yeg7RSNJW8BEc33zBfZfT8c/sv/PwyAALyyzUCkuAyew9rGq9sIw1oPzhFR8BL2TOm6iNC2hw2b92pbuSKe6ujK5uKooAtgQROniSR0SXlrHlxEKIzugFmTHrGrTyLMX7MpIJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uqGqtlSM; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-510133ed214so290667e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 01:21:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706088105; x=1706692905; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=IC++pEzL4ZnERNcYi29RUcf4swv7sgMAYOvkDj2rEI0=;
        b=uqGqtlSMa38hdsgpvsN2tMQiJ80+RdNx3Tmk/6FuI8BJw2K9hrFnim09ElK7tdplUz
         i8+klwrWgorbEuPAI2v0Hh1tyZ3EZ5U/JR6B70gu0hyM++U8I1TNiojF6oTWvS/MUX9o
         4KKSfRm+6mlgLmMnb8eXdKoJbsbinj5cevwI0DcfSIVgK+DELDto8FEOeUpu2rW4pEwG
         vSLcwuxy5LTqymLeKgMcDm1+VBx5kUUN81Fike9LdfypAeZG1y/Z57jcNVutDd4tt9Cn
         wfvapFDUjSLusXfQMxLKo6Kb/yYti/XBnn5mj4zS6C5lQwrLO56AjkDPq6ij/yXJSxRG
         gXxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706088105; x=1706692905;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IC++pEzL4ZnERNcYi29RUcf4swv7sgMAYOvkDj2rEI0=;
        b=OEeXojqf9OwP3CA9utODX0QfW7o5R1jSXJNyXyDiEYa/6atSwm1ObcW+9hcesxvxbP
         TuehDAxl+GIVlYag6UA1yNNCvKXdhtOq8Rsz97aYgai1x8JsaHCruP/S7/x4thpLrARs
         DDr7YoF0AfwTjeGgNwa8M2KCrkq3/ySl4fx8IwUc9r1YTsxNJO3zds29HXUlesHnTx8Y
         7HsztuknoAO75G56PVOVl+XmMKfBd5agZ2VlgKtZxE022k46+B56LMPQZsxYQwHoae3j
         4pBNQjd+KDn0M8HXIno96FLynjO0mkKw3aTNdQ10IJvAIUYo4NrrkEQ9uqdvb7NyLk7D
         KaWQ==
X-Gm-Message-State: AOJu0YxiI+k+l+tSwQrVjO7Fjr3pgVIOji2PZReqBDAv7jzt4LKhj2xQ
	aqBdJaj4BLpML59EDdBDd4Ey0smLLLWI0q0mtJhlCa1BN4qykZaBtAFeaLkbbUw=
X-Google-Smtp-Source: AGHT+IEoYvX5ImUeYU+16v/15tdK/S4Fr5ldyMNN4WvuO6GvQxlrpO1w2+L1HPxfqJrOi6yJv0guLA==
X-Received: by 2002:a05:6512:6d3:b0:50e:e0af:4efb with SMTP id u19-20020a05651206d300b0050ee0af4efbmr3997062lff.104.1706088104912;
        Wed, 24 Jan 2024 01:21:44 -0800 (PST)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id q20-20020a05600c46d400b0040e395cd20bsm48914383wmo.7.2024.01.24.01.21.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jan 2024 01:21:44 -0800 (PST)
Message-ID: <4b8bc0bf2f1fd87183276816522e92f7b0c3b1fd.camel@linaro.org>
Subject: Re: [PATCH 08/21] spi: s3c64xx: move error check up to avoid
 rechecking
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, broonie@kernel.org, 
	andi.shyti@kernel.org, arnd@arndb.de
Cc: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org,  alim.akhtar@samsung.com, linux-spi@vger.kernel.org, 
 linux-samsung-soc@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-arch@vger.kernel.org, peter.griffin@linaro.org,
 semen.protsenko@linaro.org,  kernel-team@android.com,
 willmcvicker@google.com
Date: Wed, 24 Jan 2024 09:21:43 +0000
In-Reply-To: <20240123153421.715951-9-tudor.ambarus@linaro.org>
References: <20240123153421.715951-1-tudor.ambarus@linaro.org>
	 <20240123153421.715951-9-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Tudor,

On Tue, 2024-01-23 at 15:34 +0000, Tudor Ambarus wrote:
> @@ -538,13 +538,8 @@ static int s3c64xx_wait_for_dma(struct s3c64xx_spi_d=
river_data *sdd,
> =C2=A0			cpu_relax();
> =C2=A0			status =3D readl(regs + S3C64XX_SPI_STATUS);
> =C2=A0		}
> -
> =C2=A0	}
> =C2=A0
> -	/* If timed out while checking rx/tx status return error */
> -	if (!val)
> -		return -EIO;
> -

This change behaviour of this function. The loop just above adjusts val and=
 it is used to
determine if there was a timeout or not:

	if (val && !xfer->rx_buf) {
		val =3D msecs_to_loops(10);
		status =3D readl(regs + S3C64XX_SPI_STATUS);
		while ((TX_FIFO_LVL(status, sdd)
			|| !S3C64XX_SPI_ST_TX_DONE(status, sdd))
		       && --val) {
			cpu_relax();
			status =3D readl(regs + S3C64XX_SPI_STATUS);
		}


That doesn't work anymore now.

Cheers,
Andre'


