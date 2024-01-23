Return-Path: <linux-kernel+bounces-35514-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF0383923C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 16:13:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAC81C20F7A
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 15:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 905135FBB0;
	Tue, 23 Jan 2024 15:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c65gSC6b"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58F595F858
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706022786; cv=none; b=bZLqfcqi5TVnGVZveU+lmc54JuwFGdLhrloyjVAGr2nk/oDeX/V7RXXvNnEC1HfIyoUl0H+YJoi+W2dO5z+UygiQ9yc8Upo8RDCO7DsxlPqkQndfetdLbVDsLDly3taJdkFcQez1BuwDHUQVvTz+MN+qBgehEYjHMo3tAMUqweg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706022786; c=relaxed/simple;
	bh=6tx6GUIj8nDlMvxi21kmbAgfHDM80qvccPclPzxZPWg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mEK9OrEJjida27XyFMcbn5i2EmxK7byDL06TjJx0eIs6RELgjiYEfFzFuh0bgdSg/GvmOkdjMnN8EU9Bevx+HpgOG20lL+6fX6c5SV9r7WNHAiZOgSEOFuTEJ0e5rABhG2sc7hITjRx7qPFpBGvaEnft2t+2m1fI70tY5w1C5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c65gSC6b; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5edfcba97e3so45051567b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:13:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706022784; x=1706627584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tBvO8IK4oJfr/fyXW7CtKCvOhpCr33xrej++q9qJr0A=;
        b=c65gSC6bHG+9uPnUrKRcGbmOc3872dzB16aiIUacSu799oV8JG+jhmOYPJ74qrnlUw
         JzXAIKdwlYalS9fbcq6zygFmliW2+8bH8URijLxWosxgfIXUJLPmNbJSO6hhGOVy67Wk
         ATdNrVJ4rqcSSHHNHMfpJHh6RKvKcJDGOtO5KVY7uSqkfLXCFigV/EA77fqtfPBMRBJD
         GTzVahJ6TW1Y9lSFqmq/RA2Xc7Bd+yg8IFBlgh8YG/+TOfjQ7jgq4Z4+N7y/+omj+RHG
         b1Z2RVULCFIfxPjDE4967sqVFGIEybXobIa8YOsH9v+Glhf3JYADywXSTwSCBGUYXGQv
         VLSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706022784; x=1706627584;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tBvO8IK4oJfr/fyXW7CtKCvOhpCr33xrej++q9qJr0A=;
        b=JDkdd81VMrKIz6xTO9zcrf+P2m23fGcqUSzecYXeyUzI7a+J2VF7xeKaTK4c663Ex5
         lzdh9RPHis1HoYs/brbgLEFgqP0pl9FjudtesDhBpD7Xs8ISciTbZV1Ksik6E+elo5TJ
         qpK689/NSrd3xvmXajTSIcdl8f1RqbLYu5WCXqJpHR1otuoDdjadwJwCUgeMLYcrtpt0
         aka5yisN4CUoQlm34Bcuh5JdeIpMmnEMYjNHQmGQ4Y2SKgbWqQWiZ6w259B6C7Kr4ADC
         qO5rhNRnATYdHCEDp78Rhfl5B1Gigg7FtIm9dOysQ+u5oV4lCZcDTRPl486+Db1Q+J8Y
         3LGg==
X-Gm-Message-State: AOJu0YzGdKcjL5gwZZ/AhCHSwO3zsUXuCgsbjOMHDW9PCdeJALOz9St8
	o4mVIfky8dtvnAOYMgayo9F9zIs0YKHnr2ZpDX0Iz6awP+gRVcckaupHl8dtfpD6buHp7TinnOs
	uWtVqLf3Yh/VS4V81THeS44uz/8CkbEkzAi2LdA==
X-Google-Smtp-Source: AGHT+IErCELn6TxJa7wNsGtNjkmE3tZd5G1HCba+hmniY9ftSq65RDRxr6aS4cBge5u/RPP9/HtEHOlyAlzQ++QTT6A=
X-Received: by 2002:a81:7bc3:0:b0:5ff:7f44:5d94 with SMTP id
 w186-20020a817bc3000000b005ff7f445d94mr4970224ywc.80.1706022784316; Tue, 23
 Jan 2024 07:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116094935.9988-1-quic_riteshk@quicinc.com>
 <20240116094935.9988-3-quic_riteshk@quicinc.com> <20a8efd1-e243-434e-8f75-aa786ac8014f@linaro.org>
 <CAA8EJpqQVuS+yqXQ2y5sNQrRVg7tcQAJ3ywsEjg+O=7TkUZWLQ@mail.gmail.com> <99a9a562-9f6f-411c-be1c-0a28fc2524dd@quicinc.com>
In-Reply-To: <99a9a562-9f6f-411c-be1c-0a28fc2524dd@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 23 Jan 2024 17:12:53 +0200
Message-ID: <CAA8EJppj+cDnw7p4yANvF0FmEhX3+L5xUq8w3TeevAGhcpo1Yg@mail.gmail.com>
Subject: Re: [PATCH 2/2] arm64: dts: qcom: qcm6490-idp: add display and panel
To: Ritesh Kumar <quic_riteshk@quicinc.com>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>, andersson@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	catalin.marinas@arm.com, will@kernel.org, quic_bjorande@quicinc.com, 
	geert+renesas@glider.be, arnd@arndb.de, neil.armstrong@linaro.org, 
	nfraprado@collabora.com, m.szyprowski@samsung.com, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	quic_abhinavk@quicinc.com, quic_rajeevny@quicinc.com, 
	quic_vproddut@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Tue, 23 Jan 2024 at 15:43, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>
>
> On 1/16/2024 6:27 PM, Dmitry Baryshkov wrote:
>
> > On Tue, 16 Jan 2024 at 14:06, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >> On 1/16/24 10:49, Ritesh Kumar wrote:
> >>> Enable Display Subsystem with Novatek NT36672E Panel
> >>> on qcm6490 idp platform.
> >>>
> >>> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> >>> ---
> >>>    arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100 +++++++++++++++++++++++
> >>>    1 file changed, 100 insertions(+)
> >>>
> >>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> >>> index 2a6e4907c5ee..efa5252130a1 100644
> >>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> >>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> >>> @@ -9,6 +9,7 @@
> >>>    #define PM7250B_SID 8
> >>>    #define PM7250B_SID1 9
> >>>
> >>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> >>>    #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >>>    #include "sc7280.dtsi"
> >>>    #include "pm7250b.dtsi"
> >>> @@ -38,6 +39,25 @@
> >>>                stdout-path = "serial0:115200n8";
> >>>        };
> >>>
> >>> +     lcd_disp_bias: lcd-disp-bias-regulator {
> >>> +             compatible = "regulator-fixed";
> >>> +             regulator-name = "lcd_disp_bias";
> >>> +             regulator-min-microvolt = <5500000>;
> >>> +             regulator-max-microvolt = <5500000>;
> >>> +             gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
> >>> +             enable-active-high;
> >>> +             pinctrl-names = "default";
> >>> +             pinctrl-0 = <&lcd_disp_bias_en>;
> >> property-n
> >> property-names
> >>
> >> all throughout the patch
>
> Thanks, I will update in the new version.
>
> >>> +&gpu {
> >>> +     status = "disabled";
> >>> +};
> >> Hm.. generally we disable the GPU in the SoC DT, but that doesn't
> >> seem to have happened here..
> >>
> >> Thinking about it more, is disabling it here necessary? Does it
> >> not fail gracefully?
> > Missed this.
> >
> > I'd say, I don't see a reason to disable it at all. The GPU should be
> > working on sc7280 / qcm4290.
>
> With GPU device node enabled, adreno_bind failure is seen as the
> "speed_bin" was not populated on QCM6490 target which leads to display
> bind failure.

Excuse me please. The GPU node for sc7280 already has speed_bin, which
points to qfprom + 0x1e9, bits 5 to 9.

Do you mean that qcm6490 uses different speed bin location? Or
different values for the speed bins?

> Spoke with GPU team and on QCM6490 board, only CPU rendering is
> supported for now and there is no plan to enable GPU rendering in near
> future.

This sounds like having the feature disabled for no particular reason.
Both the kernel and Mesa have supported the Adreno 635 for quite a
while.

> In this regard, what do you suggest
>
> 1) Disable GPU in QCM6490 DT (as per the current patch)
> 2) Disable GPU in the SoC DT, but enable it in other platform DTs. (This
> will prompt change in all the dt's and we don't have all the devices to
> test)

The second option definitely follows what is present on other platforms.

> Please let me know your views on it.

Please enable the GPU instead.

-- 
With best wishes
Dmitry

