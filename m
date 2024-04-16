Return-Path: <linux-kernel+bounces-146732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 718FF8A6A04
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 13:57:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DD9831F216B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 465D812A157;
	Tue, 16 Apr 2024 11:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qAWrIJSB"
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 220A3129A67
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 11:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268625; cv=none; b=N4hL6wdrgNLFqHCL7E8bASIx+aP8zFJm1itHc7bqaEH/iO/2S5MKLASsZ1hAVWx3UyiKg3C8rvtFpPevGKWF4Bw5brf51tjdnLFhZcGUIQlN0Fs2EO4DenUOR4NgnSwmksVHA1RsQdWvw6QKxcpskH27Lyi0tllkJ/1qeQl0BAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268625; c=relaxed/simple;
	bh=vIl3v//FVA36XrKiforyh9hY0/yXzSMuW90U1Lzldf4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EyFwSfqa+eEKAgarOzTiMEvT6oreEhLRNLcOXumy/FG1nxP+Hihd0fTNIwjiUEFdRX1meVkyV81kwqgfS5opxHNqoDg3l8VriduGKYMjWO/sr+/W0naug5U6zMBrAEji0MM/6C/YYwCGP6Woot2fBLu2b2XQ5Gh4u4J6yVrOCa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qAWrIJSB; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-5aa1e9527d1so3060247eaf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 04:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713268623; x=1713873423; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ophtYrF9IpPwZurMvgYV2hp9I3BGj1tkL8j63ZRtc2I=;
        b=qAWrIJSBaImnX5AI81q+IaPhDKBY5xYc6kTf40ixeVO8Vn8qqUOGKLZNpdiyguEcD8
         osusODQ1FeE3OolyPUzXBkJE5b6qYdrRFT1i4fBvgC3SuI/JWDWh8RajZkmP5f8+rhnw
         aaILeP6Aunaf8nFMdBvn1gp/IE12Kp2Nl5SYLhcpDt51Tu7y7qYQdcigN91BrCrpAKtu
         EqqhQXRBoa7Z/Z4N3fJKss6XN93vDpG9jLh4XUi4GgGdo3iyFuW1qbVK/ESFRwJ6O75r
         OeWWLX8AHiWzM6QmHV2B4lNH/sNEEEv8G/9ltoIAwNgOxtZLTO7f12qmS2QXTDadUhlP
         qP6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713268623; x=1713873423;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ophtYrF9IpPwZurMvgYV2hp9I3BGj1tkL8j63ZRtc2I=;
        b=nABVNf8fUKc3V2SUbHS4mpzR+vQ7YAnATO5XxGTnoTXpa1h9Ix2BXcMzFQ2pFDJc/f
         36zgoWINhwfcetuZclvlC5zivaas3axLCzr0VQ3bsSxabY4BhiiNiTqQ13n5sIWri89u
         pjGj7Qzrw7ESu7GzkeXWlotAljWqJs64JwzAof7Q9uG93Mc0Sh+QUgjPs3RTcsAd6JlV
         vaeLXguCAzoGHkf6OdhjKpD4dvQftEqzvPvGo3QKhoYD7OpPnJ8Qz1x6rmya3aHXfE66
         jcyXrNr+6+cqU73Pi+IbN4P9XW5m/s8vATt4Q/Re1fucsk9H1muabgSZEB55Tn+E01zq
         50kQ==
X-Forwarded-Encrypted: i=1; AJvYcCVw8X1OYnjGEG2UaFb7Q1qGNbRWuL1QYD1xOuBPdVA4dl1K69i3xB/Zsy4S9/b38niueeKoHAiXcUNCY14w6CvBlzlyEq2b0qD6rCMp
X-Gm-Message-State: AOJu0YyQC8M7JqPviE/9c9r6asVICgwHTdLl2dyVOdybDFmp2NdoVP9X
	a6Qrm9y1ualXMOBywKH5vw8En94I/jBsyY/EhZwQ3olat6WyMDyMK4+tVZXjT6v4Ck5pOUW/l2I
	fjEm2wOnTz8W9aY/pIwP0yBUHODSNnhmWmsjhRw==
X-Google-Smtp-Source: AGHT+IGdAJXHt7mAsVZuzt9JgE7vdWoLagtGQT3T15A+kBPHpQZl6zuXKVT8ycszrHB5VvpVeZdYSex6pwkAq/Bp7sg=
X-Received: by 2002:a4a:aecb:0:b0:5ac:9efc:3b02 with SMTP id
 v11-20020a4aaecb000000b005ac9efc3b02mr5501112oon.8.1713268621486; Tue, 16 Apr
 2024 04:57:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404122559.898930-1-peter.griffin@linaro.org>
 <20240404122559.898930-6-peter.griffin@linaro.org> <391a874522a4141b4bc7f0314a9e50d27142123a.camel@linaro.org>
In-Reply-To: <391a874522a4141b4bc7f0314a9e50d27142123a.camel@linaro.org>
From: Peter Griffin <peter.griffin@linaro.org>
Date: Tue, 16 Apr 2024 12:56:50 +0100
Message-ID: <CADrjBPqwLt6gzwMpkZvxp5sC-owdDYUN91F0-nV2NvEzek_v9g@mail.gmail.com>
Subject: Re: [PATCH 05/17] arm64: dts: exynos: gs101: enable cmu-hsi2 clock controller
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org, 
	alim.akhtar@samsung.com, avri.altman@wdc.com, bvanassche@acm.org, 
	s.nawrocki@samsung.com, cw00.choi@samsung.com, jejb@linux.ibm.com, 
	martin.petersen@oracle.com, chanho61.park@samsung.com, ebiggers@kernel.org, 
	linux-scsi@vger.kernel.org, linux-phy@lists.infradead.org, 
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org, 
	linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, tudor.ambarus@linaro.org, 
	saravanak@google.com, willmcvicker@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Andr=C3=A9,

Thanks for the review.

On Fri, 5 Apr 2024 at 08:38, Andr=C3=A9 Draszik <andre.draszik@linaro.org> =
wrote:
>
> On Thu, 2024-04-04 at 13:25 +0100, Peter Griffin wrote:
> > Enable the cmu_hsi2 clock management unit. It feeds some of
> > the high speed interfaces such as PCIe and UFS.
> >
> > Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
> > ---
> >  arch/arm64/boot/dts/exynos/google/gs101.dtsi | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/exynos/google/gs101.dtsi b/arch/arm64/=
boot/dts/exynos/google/gs101.dtsi
> > index eddb6b326fde..38ac4fb1397e 100644
> > --- a/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> > +++ b/arch/arm64/boot/dts/exynos/google/gs101.dtsi
> > @@ -1253,6 +1253,18 @@ pinctrl_hsi1: pinctrl@11840000 {
> >                       interrupts =3D <GIC_SPI 471 IRQ_TYPE_LEVEL_HIGH 0=
>;
> >               };
> >
> > +             cmu_hsi2: clock-controller@14400000 {
> > +                     compatible =3D "google,gs101-cmu-hsi2";
> > +                     reg =3D <0x14400000 0x4000>;
> > +                     #clock-cells =3D <1>;
> > +                     clocks =3D <&ext_24_5m>,
> > +                              <&cmu_top CLK_DOUT_CMU_HSI2_BUS>,
> > +                              <&cmu_top CLK_DOUT_CMU_HSI2_PCIE>,
> > +                              <&cmu_top CLK_DOUT_CMU_HSI2_UFS_EMBD>,
> > +                              <&cmu_top CLK_DOUT_CMU_HSI2_MMC_CARD>;
> > +                     clock-names =3D "oscclk", "bus", "pcie", "ufs_emb=
d", "mmc_card";
> > +             };
>
> This doesn't build because you didn't add the clock ids in the binding pa=
tch.

These clock IDs are for cmu_top, not cmu_hsi2. They were added as part
of the initial gs101/Oriole upstream support series in the following
commit

commit 0a910f1606384a5886a045e36b1fc80a7fa6706b
Author: Peter Griffin <peter.griffin@linaro.org>
Date:   Sat Dec 9 23:30:48 2023 +0000

    dt-bindings: clock: Add Google gs101 clock management unit bindings

    Provide dt-schema documentation for Google gs101 SoC clock controller.
    Currently this adds support for cmu_top, cmu_misc and cmu_apm.

    Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>
    Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
    Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
    Link: https://lore.kernel.org/r/20231209233106.147416-3-peter.griffin@l=
inaro.org
    Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

regards,

Peter

