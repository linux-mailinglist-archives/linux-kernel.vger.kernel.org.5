Return-Path: <linux-kernel+bounces-122829-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D688FE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C2DA71F24BB3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:26:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF7B47E57F;
	Thu, 28 Mar 2024 11:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VMVJqDhv"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA317CF2B
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 11:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711625158; cv=none; b=L656aObDkvO+kY88WZBLIgFCQnDPdSbGqFoU34ggB0UJrUM+i0dEM4GIjllmYyEbRkF3lhowhk5MFutAP+BMelw8f1sdE/rZFoshWNXDZvvZ2J+W2Aj04UUH/86rZg85LbEHqpDBNI4WMN3aJQ4Vuk7Im0MOfYOauIG9c+MDRDo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711625158; c=relaxed/simple;
	bh=WIGa0icyLnmu/oBvATbqagwvaa7vtUvlqfZhWt9ytEY=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=iYUyttB9N1l3h4niLZz9V5HvHNKzih8ooqyjzWtS9HoXA58gP/E4N+3DyrL8MnknIMUzpvxizi5DfFDu949wp9vEIpSEHxMD7rmolqycmvTc3RtR5N4yEyil1EB3Bio5UqmUkT65XpE3K+c7pNTfQ1vCfqYEOO5WsaKmhpiGh44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VMVJqDhv; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d24a727f78so9564781fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 04:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711625155; x=1712229955; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WIGa0icyLnmu/oBvATbqagwvaa7vtUvlqfZhWt9ytEY=;
        b=VMVJqDhvhHnUFn2skoGxBtE/T+sN/kvp5HoRlLlKBSfK/akZfL3cKMf06LHNZl0yPB
         PhNd6RhzEvjzupCBvObvvz2u1qZGkUApHPs9BTwhyDTLHFaGT6dD64zM/Keo/3FXxcfb
         IvFLL1mO/eHG64qS7Msni8MdSZOXeze1WU808mnjDJKMrcNLsYIUU09ca7CnhSzC5TV6
         f6yXPkdk9TFiFdIq1yS+iNhYxMetoKzxCKYkYeI2NVnxgW4jxrLhQ/Ci0kVjfSl15b0+
         quYUQ9rdb0K6i6ZKESeNXU6I0UgGdo3DpFIKeYG4abxa5sOBtA+IMPiM/b02XSZHAAo6
         JLkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711625155; x=1712229955;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WIGa0icyLnmu/oBvATbqagwvaa7vtUvlqfZhWt9ytEY=;
        b=Ud8hyevi35BTqNuDnB48w5iDhFWHhZy3Vv/w6H0Vg2Allj8EWdpBzgpuA5/MOOdRhC
         MdKdmOaHr/xEgr/A71APAveO/oUjRpjsBG3P8TVVfmkH6jRgip9HBLC10/dKUV6ECHQj
         JrKDGa3VKq+8Dj19plOl2KOXQQnJ+mcugMX0JWZKAOpar9VE1tTZn8ZWDi/b4RbBJskR
         cGo/NF9ORtlEW1tDbO5fKmfL14xHLgCdVPlfGbgxbAg7jjWFGfKjZwpqVeSB92BimKkc
         ozrMv7RQGBTP1JkX7gy4Svn+SCF8RxOsWRv9yzoyZ5vvf8p8zm+SR5o3g4BjV7WC/dEM
         ipOw==
X-Forwarded-Encrypted: i=1; AJvYcCUOYMAF9mSbbzpSzjiPMIczxKkNPms3so5pv8vv446dcXqG537I3uXhxZhsEovwPOsO9eO86VX5/+I8v14JDlQdOgZekK/HwHNC+O6O
X-Gm-Message-State: AOJu0Ywr3UxgotOctKRUdx8iPf5uyPhCenn1P/cM05y4CvMHubzukF7x
	dMH32epZy4+Ov5J7XlNw7acTfG9xLze5CO198+nXtL7jZ1VaGoY1KWfRiYje+Gw=
X-Google-Smtp-Source: AGHT+IEWHh0Ctaa5g16fNMt4g7gBrPzAyrnWxhO+d4dNl2ZiaY9Bn69hrV+muBoeAYW8Wrtjx8jTNw==
X-Received: by 2002:a2e:95d9:0:b0:2d7:21f:90ef with SMTP id y25-20020a2e95d9000000b002d7021f90efmr1699128ljh.1.1711625154661;
        Thu, 28 Mar 2024 04:25:54 -0700 (PDT)
Received: from draszik.lan ([80.111.64.44])
        by smtp.gmail.com with ESMTPSA id fb7-20020a05600c520700b00414969894a1sm3877017wmb.13.2024.03.28.04.25.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Mar 2024 04:25:54 -0700 (PDT)
Message-ID: <3b9d28405f01c7bc23075492dbb501ebde0edbfa.camel@linaro.org>
Subject: Re: [PATCH v2 3/3] clk: samsung: gs101: propagate PERIC0 USI SPI
 clock rate
From: =?ISO-8859-1?Q?Andr=E9?= Draszik <andre.draszik@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>, peter.griffin@linaro.org, 
	krzysztof.kozlowski@linaro.org
Cc: alim.akhtar@samsung.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 willmcvicker@google.com, kernel-team@android.com, s.nawrocki@samsung.com, 
 cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 semen.protsenko@linaro.org, linux-clk@vger.kernel.org,
 jaewon02.kim@samsung.com
Date: Thu, 28 Mar 2024 11:25:53 +0000
In-Reply-To: <20240326172813.801470-4-tudor.ambarus@linaro.org>
References: <20240326172813.801470-1-tudor.ambarus@linaro.org>
	 <20240326172813.801470-4-tudor.ambarus@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2-1 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2024-03-26 at 17:28 +0000, Tudor Ambarus wrote:
> When SPI transfer is being prepared, the spi-s3c64xx driver will call
> clk_set_rate() to change the rate of SPI source clock (IPCLK). But IPCLK
> is a gate (leaf) clock, so it must propagate the rate change up the
> clock tree, so that corresponding MUX/DIV clocks can actually change
> their values. Add CLK_SET_RATE_PARENT flag to corresponding clocks for
> all USI instances in GS101 PERIC0: USI{1-8, 14}. This change involves the
> following clocks:
>=20
> PERIC0 USI*:
>=20
> =C2=A0=C2=A0=C2=A0 Clock=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 Div range=C2=A0=C2=A0=
=C2=A0 MUX Selection
> =C2=A0=C2=A0=C2=A0 ------------------------------------------------------=
-------------
> =C2=A0=C2=A0=C2=A0 gout_peric0_peric0_top0_ipclk_*=C2=A0=C2=A0=C2=A0 -=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 -
> =C2=A0=C2=A0=C2=A0 dout_peric0_usi*_usi=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /1..16=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 -
> =C2=A0=C2=A0=C2=A0 mout_peric0_usi*_usi_user=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0 -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0 {24.5 MHz, 400 MHz}
>=20
> With input clock of 400 MHz this scheme provides the following IPCLK
> rate range, for each USI block:
>=20
> =C2=A0=C2=A0=C2=A0 PERIC0 USI*:=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 1.5 M=
Hz ... 400 MHz
>=20
> Accounting for internal /4 divider in SPI blocks, and because the max
> SPI frequency is limited at 50 MHz, it gives us next SPI SCK rates:
>=20
> =C2=A0=C2=A0=C2=A0 PERIC0 USI_SPI*:=C2=A0=C2=A0 384 KHz ... 49.9 MHz
>=20
> Which shall be fine for the applications of the SPI bus.
>=20
> Note that with this we allow the reparenting of the MUX_USIx clocks to
> OSCCLK. Each instance of the USI IP has its own MUX_USI clock, thus the
> reparenting of a MUX_USI clock corresponds to a single instance of the
> USI IP. The datasheet mentions OSCCLK just in the low-power mode
> context, but the downstream driver reparents too the MUX_USI clocks to
> OSCCLK. Follow the downstream driver and do the same.
>=20
> Fixes: 893f133a040b ("clk: samsung: gs101: add support for cmu_peric0")
> Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>

Acked-by: Andr=C3=A9 Draszik <andre.draszik@linaro.org>


