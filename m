Return-Path: <linux-kernel+bounces-157857-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 284C88B1766
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 01:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 942B11F23BD5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 23:47:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7849C16F270;
	Wed, 24 Apr 2024 23:47:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sj5JSfzK"
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F217D16F0F3
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 23:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714002455; cv=none; b=TJFTp/mX1l6SFUM3O+FKaa07blofjhtbxBMXo284ham+aWPbGUwRmPUmNjK5vSpuiJZU9lF+HD0xDM6ipZP1vU7G5uYkHIYokdf3FLV7S0/R/2IPjiMxp6G+GAWp4sdoAKNr2VZQV/eiO3DXxjBvlMsRfQlyaUvKIsCfNnCyllA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714002455; c=relaxed/simple;
	bh=OMKvIJ7aZmnQ9wSxcW/ZI5sON1e/NHXRACIEAc/ndPg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HU0BhS8ZRE5UelmcusWlBFYzKPiBJOsOXmePtllmEZ/T0MHUtrf9rsXaTljd1lUunY8jEZgVz/3BzxMZwR2pSYtL0eTFkwts4fXFw+VitMYz0yO83RwwL4XHb4Ru3aWeIN0Ylgd4EMjMhuMuSId3/CY+Ywh+7CSUwpP79ARY/TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=sj5JSfzK; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-de54cb87998so461580276.2
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 16:47:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714002452; x=1714607252; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/1tN60EyOoTTpXwgrDNf6TzRWNHHafqzCbKwzrT6DXE=;
        b=sj5JSfzKTVevknleMSOnHiamY9JV8h6cuDNwAp7wOalckZRZNiJGfHYAGf+FHR0yt0
         U4nujAI8HbJOv/AoSnfw/cFspn7WzRIqw6gEDh6vZbTS/0if4ShZqpe3DO2LyOqeBeGK
         1l+bhnQ4hNRWwvm3mtpUde3pJ/+81vyROCucPs8UmlxU4VW30gMJ76W1jCTjDB50Su+8
         UEHt24ja4Nzp0WhnHzlNoLleijs3s9bgdaskdTMyei/x9G/7ZBp2CBbC7dWXzqANsnqr
         dBmedBNaodhmD2ShdYFPI99GU7XEjjEnK2rTkF/hqF41fqTF3V2w2C/RXj7sUdMa6XFp
         J+SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714002452; x=1714607252;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/1tN60EyOoTTpXwgrDNf6TzRWNHHafqzCbKwzrT6DXE=;
        b=vZAh+zYI48SKdHi/NKLJIiILD0QsbEI88/qiKsn1X8nDccO4AzMjAejjjY1p9QXjzI
         byDDEIHpxTJZdn/b7Ct2eDyIA5Oyttdl2mIyK2Qyu7LyvWR+uNMNEytMPVimCiQ5vFlg
         RLlnZBh4cb3rtaHztJvs292XfVoprFfVXuKhOthM7DLriH/T7PhGdX6GJYiR3LjzminS
         TihgkzbN4KCevENN4TVrZNf0q81q6xLbsDjX6fbdHfsE3tb0NBWVweF0djRmVXvbY/U+
         C1I0vrsqnnqmue8N+ljmR+8RCggma7vp2r9c1jFt605EYL3vg0XHiwhv72sc+4huW75J
         M4zQ==
X-Forwarded-Encrypted: i=1; AJvYcCVSqjs0UHk2AOLwNDIRwb+LMbKv3uvt25pldNcRLnbi+Xz5rKO75+WdORX0/eeBOKtUnxkHp2Eby1hakPm3+aXAcV1+qU7hQvQAPKc5
X-Gm-Message-State: AOJu0YxBKWqL/g71lO8hIAk3Z5PlI+7/km1PCIPxSBqxSbheRGwhNuEb
	pOq49cyBwNA/gVainYFJtBe0CBs/8mziYw4Zr495pR5arhogsimrdVXifK7nBgB3oEEmAehHr/b
	hP26P52PU15cJEcsgnat0lkhshC1+oh+fTkt5Ww==
X-Google-Smtp-Source: AGHT+IH0ZhfG0Ni5n3NvfJ4JxKJary36xcWzUlVDAwrOHVIi0Ry6H9C6abzNJBTJEw8IWgmGC7WDcLOnbeiLdcitnGQ=
X-Received: by 2002:a25:664a:0:b0:de0:d3af:f52f with SMTP id
 z10-20020a25664a000000b00de0d3aff52fmr4141531ybm.49.1714002451985; Wed, 24
 Apr 2024 16:47:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240424024508.3857602-1-quic_tengfan@quicinc.com> <20240424024508.3857602-4-quic_tengfan@quicinc.com>
In-Reply-To: <20240424024508.3857602-4-quic_tengfan@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Apr 2024 02:47:21 +0300
Message-ID: <CAA8EJprceDUBtcrT0XLc7V9e0Joyw21YZD9=DONjTTfNM9chBw@mail.gmail.com>
Subject: Re: [PATCH v7 3/4] arm64: dts: qcom: add base AIM300 dtsi
To: Tengfei Fan <quic_tengfan@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh@kernel.org, 
	krzk+dt@kernel.org, conor+dt@kernel.org, keescook@chromium.org, 
	tony.luck@intel.com, gpiccoli@igalia.com, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-hardening@vger.kernel.org, kernel@quicinc.com, 
	Fenglin Wu <quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset="UTF-8"

On Wed, 24 Apr 2024 at 05:46, Tengfei Fan <quic_tengfan@quicinc.com> wrote:
>
> AIM300 Series is a highly optimized family of modules designed to
> support AIoT applications. It integrates QCS8550 SoC, UFS and PMIC
> chip etc.
> Here is a diagram of AIM300 SoM:
>           +----------------------------------------+
>           |AIM300 SoM                              |
>           |                                        |
>           |                           +-----+      |
>           |                      |--->| UFS |      |
>           |                      |    +-----+      |
>           |                      |                 |
>           |                      |                 |
>      3.7v |  +-----------------+ |    +---------+  |
>   ---------->|       PMIC      |----->| QCS8550 |  |
>           |  +-----------------+      +---------+  |
>           |                      |                 |
>           |                      |                 |
>           |                      |    +-----+      |
>           |                      |--->| ... |      |
>           |                           +-----+      |
>           |                                        |
>           +----------------------------------------+
>
> Co-developed-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi | 403 +++++++++++++++++++
>  1 file changed, 403 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/qcs8550-aim300.dtsi


> +
> +&pcie_1_phy_aux_clk {
> +       clock-frequency = <1000>;
> +};

Please rebase on top of
https://lore.kernel.org/linux-arm-msm/20240422-topic-sm8x50-upstream-pcie-1-phy-aux-clk-v4-0-868b15a17a45@linaro.org/

> +
> +&pcie1 {
> +       perst-gpios = <&tlmm 97 GPIO_ACTIVE_LOW>;
> +       wake-gpios = <&tlmm 99 GPIO_ACTIVE_HIGH>;

Please add pinctrl configurations for pcie0 and pcie1

With that fixed:

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> +};
> +
>

--
With best wishes
Dmitry

