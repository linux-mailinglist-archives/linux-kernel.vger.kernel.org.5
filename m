Return-Path: <linux-kernel+bounces-131500-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E17858988BB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9DB0028A530
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3F11272D3;
	Thu,  4 Apr 2024 13:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="STX2NdSO"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2B086ADC
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 13:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712237083; cv=none; b=rG6vMpKX4533mMKu8MWJAYasGnQIWiKqNUd3Xdt9bPKVAHAJvLMBQR3H4bEmx/SUOhud/mlZ8JM04y/0pizTUWWiFD/p1IVkvqGOC+UMnojy2ycT3h6SWVeL7DrMkwv2yXmOQqw3DjNKAeR+y39a9Orru4HxWfMmYjJgvXmAKzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712237083; c=relaxed/simple;
	bh=nBXwkA4A0krstFpyvfjsEVO0w0Xz+CnGhEwhMIz2nxA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Sn/8hHoXq6YSjmW4ZFFcRvjSO2Q2c5XGurPilGmKeG2Eitq48bLcn1+1SaEe4s8KZxnCmuQTVygGUzTihdSGcMNGBBuNqvV79yyErXQ/93C4OWobUzS7vZ2TxTZa4Laxa2kpEDrwGoBL2dMTaG1g76Hey9ag2iG7KSzu8I4F+po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=STX2NdSO; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d23114b19dso11257211fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 06:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712237080; x=1712841880; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QPezEfD0t1esOw49T38S7/dvcH4ZrRMz2JA7Keo/jF4=;
        b=STX2NdSOVMuHrqgjp5g0ZlGQ3/lhfA1n/DToyUa6dsG1jme+LaJV+O+ZDeiU1YN0ST
         UlqSF+RKNCBNLs/P7taD2sF1Wp/peVWN3MnryMvCCae5gPD5XmBLfDZCAWX8xEUX32iX
         QGQgA+veb2nXHXHAqxi6rA734/xn+TouYaU7uwAo1gF7nOaKboymvviE+YJ4s3GVN1tZ
         q4XHZM+1HHEMF5MriJOKsiBCHqS+HblnZcB23DlFxUajGItk3Rlu398kxgXNTLeFOWr4
         livV6E/0xQZO/lwC2K1dfZUZqY3kYTH3iWknanPYamF76AzNzuovVSyTo/+WPSUFwgzi
         yBSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712237080; x=1712841880;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QPezEfD0t1esOw49T38S7/dvcH4ZrRMz2JA7Keo/jF4=;
        b=HkCrGJOi0lKsf31Kge0TcETil+YxlguvSvSMvw0qsEI/RT79M2OmeiLeWkkyCcdG/A
         vWdvXBjHPc5DJA4dsw3raodgDmsRZgdSOoc5PsRhS4Pr1+tMEvGSkultbId3jtqp90XE
         3h5dMwfNmjHw4P2V/orU58eKwPAkx/pXu8ONF32FNU+IpVumUO9qyuLJs8Rx2Jo2HJ0V
         E0IGngtRZSx/DcuV2oDIbX7HfNcobiNHcuWisabfKW5uTwNRu8fCfIoqRw14mMQ1ndun
         xGl2nDc8t9tBaQxbZGYqbnoXDliigfbJQYq0yfhz+nYYsXrMDAPTmHQlIjsCC8wetmAX
         q7Rg==
X-Forwarded-Encrypted: i=1; AJvYcCWnY4NdEG4Drhqxcgn5FxVj4udXS3R/NVudcBumZnD0FqdVMAa+nIzzTXpTLKq8YTRJWsblFQQ5su39liIipzGO2OOezJf61T/ml1MG
X-Gm-Message-State: AOJu0YybACX4BFUyKIClX6CP3e/ZN3lKPCMukpscQLl1Gf0KBue58BKC
	ZtFEFsILuLGz0alTRa3WLcXdpBjOr5LncONYrmblBXcDphONObp8dVBMR1/PjFw=
X-Google-Smtp-Source: AGHT+IGxgH9A5s0WiNgOB7bXFCAvV00A/PQ0OT0BzurZEBZ4YAccdY+QiP2+2qjmMUfFLq93x9ZqAg==
X-Received: by 2002:a2e:7c0a:0:b0:2d8:274a:db16 with SMTP id x10-20020a2e7c0a000000b002d8274adb16mr2125485ljc.17.1712237079816;
        Thu, 04 Apr 2024 06:24:39 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id v3-20020a5d59c3000000b00341cc9c1871sm20435575wry.0.2024.04.04.06.24.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Apr 2024 06:24:39 -0700 (PDT)
Message-ID: <61f427ab3793def23d80d94457ff1568cae5ee11.camel@linaro.org>
Subject: Re: [PATCH 08/17] clk: samsung: gs101: add support for cmu_hsi2
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, mturquette@baylibre.com, 
 sboyd@kernel.org, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
  vkoul@kernel.org, kishon@kernel.org, alim.akhtar@samsung.com,
 avri.altman@wdc.com,  bvanassche@acm.org, s.nawrocki@samsung.com,
 cw00.choi@samsung.com,  jejb@linux.ibm.com, martin.petersen@oracle.com,
 chanho61.park@samsung.com,  ebiggers@kernel.org
Cc: linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	saravanak@google.com, willmcvicker@google.com
Date: Thu, 04 Apr 2024 14:24:37 +0100
In-Reply-To: <20240404122559.898930-9-peter.griffin@linaro.org>
References: <20240404122559.898930-1-peter.griffin@linaro.org>
	 <20240404122559.898930-9-peter.griffin@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Hi Pete,

Thanks for this!

I haven't reviewed this, but one immediate comment...

On Thu, 2024-04-04 at 13:25 +0100, Peter Griffin wrote:
> [...]
> diff --git a/drivers/clk/samsung/clk-gs101.c b/drivers/clk/samsung/clk-gs=
101.c
> index d065e343a85d..b9f84c7d5c22 100644
> --- a/drivers/clk/samsung/clk-gs101.c
> +++ b/drivers/clk/samsung/clk-gs101.c
> @@ -22,6 +22,7 @@
> =C2=A0#define CLKS_NR_MISC	(CLK_GOUT_MISC_XIU_D_MISC_ACLK + 1)
> =C2=A0#define CLKS_NR_PERIC0	(CLK_GOUT_PERIC0_SYSREG_PERIC0_PCLK + 1)
> =C2=A0#define CLKS_NR_PERIC1	(CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK + 1)
> +#define CLKS_NR_HSI2	(CLK_GOUT_HSI2_XIU_P_HSI2_ACLK + 1)

Can you please keep the #defines alphabetical (hsi before misc).

> =C2=A0
> =C2=A0/* ---- CMU_TOP ---------------------------------------------------=
---------- */
> =C2=A0
> @@ -3409,6 +3410,560 @@ static const struct samsung_cmu_info peric1_cmu_i=
nfo __initconst =3D {
> =C2=A0	.clk_name		=3D "bus",
> =C2=A0};
> =C2=A0
> +/* ---- CMU_HSI2 -------------------------------------------------------=
--- */

and this code block should be earlier in the file

> [..]
=C2=A0
> =C2=A0static int __init gs101_cmu_probe(struct platform_device *pdev)
> @@ -3432,6 +3987,9 @@ static const struct of_device_id gs101_cmu_of_match=
[] =3D {
> =C2=A0	}, {
> =C2=A0		.compatible =3D "google,gs101-cmu-peric1",
> =C2=A0		.data =3D &peric1_cmu_info,
> +	}, {
> +		.compatible =3D "google,gs101-cmu-hsi2",
> +		.data =3D &hsi2_cmu_info,
> =C2=A0	}, {

and this block should move up

> =C2=A0	},
> =C2=A0};
> diff --git a/include/dt-bindings/clock/google,gs101.h b/include/dt-bindin=
gs/clock/google,gs101.h
> index 3dac3577788a..ac239ce6821b 100644
> --- a/include/dt-bindings/clock/google,gs101.h
> +++ b/include/dt-bindings/clock/google,gs101.h
> @@ -518,4 +518,67 @@
> =C2=A0#define CLK_GOUT_PERIC1_CLK_PERIC1_USI9_USI_CLK		45
> =C2=A0#define CLK_GOUT_PERIC1_SYSREG_PERIC1_PCLK		46
> =C2=A0
> +/* CMU_HSI2 */

and all these defines, too.



Cheers,
Andre'


