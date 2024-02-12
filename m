Return-Path: <linux-kernel+bounces-61689-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 939EF851563
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:37:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6A09FB243E0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:37:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFFCE47793;
	Mon, 12 Feb 2024 13:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nwwQIhOZ"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68C443BB31
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744468; cv=none; b=tBiRs5BCVyDy8Y2yKrPpM+wTkHesx+Z8oXZ7KLl5yzFClHP3mH9dm8G/D+qgk/0ldLis3I6KoZessmkUakDKmrxQ0bDpIKl1NeWG4jX8t0Jzf9ozB+CWvXzmcnF4VVmAwmWcMU5mxlKAESf51T/1t5hjpj0U7cCsjvXCsFNjacI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744468; c=relaxed/simple;
	bh=Pzid5VzqMw7NFHi/Bpd3vXctcXS4gU4pJSvps3B5q3c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CzQwgh3CgyHDBBz9yN5BqpUzurf4IFs5Zn7xcHOlmsMMv61kAakQtnFiVK2X1AHm2uJmTXw0GYjzTpBgr9NIea2QeFCCblkyY/ZGqMNFT9zkAYuTagzSWQVKNkssTihslWe2ae9Vr0PX/dvK2y9G+BKDn2gp7ZP1QE5/ekDj18w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nwwQIhOZ; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-dcbc6a6808fso188940276.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:27:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744465; x=1708349265; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vau0u582e/BzBLvL1+v01Dg8WYI7gOwAbmPsNQJ/3cw=;
        b=nwwQIhOZuOQhNk5F58Y2hZp4tmS9YbdVtSMWd3aeTxt0OLoN1+8P596OJrNCuzR9hk
         IXho4ARD5DXZGt3OU1vAFP9KM4LR56jmTmMPEytFKhxZWE2RIfR4qy+cO6LThdtIK1ZZ
         PPv8AUJ387Wq6asf3Ur8CsdYNocmlwWxl6syGrsst5d5mEN+RnrNXpEBbZnu1z+voewz
         MWJSTNlArh6VFhBRcEiw+A50FA15nrSOXNAr8uvQlRSQ6bx+OqkG+y866G04S3pHjnq4
         hLQ1FskaQ+7P5qvFO+VPPj/gOFDXsFIB4d71lQYAwQx9jVFoBLJY7BGrCNEBK6WXB0Jz
         /ahg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744465; x=1708349265;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vau0u582e/BzBLvL1+v01Dg8WYI7gOwAbmPsNQJ/3cw=;
        b=U+RQfV+dlFH4k2i/EYASBAgDrK9nGWxQ+edupss7QzeYVfTjFYWFa7ncrcre6PNUot
         Fc2KYd8pnTrKbRNN25OLhOTYdLy2G++j6EL7p96/RltvcyH9Ud7NQy1RyQnVJfWPrYll
         0IithaCxenF2LsCtUQAaxS4m4qvXS+7h9gq0jnBdF54zk7AiY4RolUCb7b0ISz6QBiK2
         SfkI3kuCmzTtPFh6t5hbFc8HDcfm400f3E1lll8eCivF9sZ0O8DNIrPArK4KlOnYKfjN
         BM+KcfypeesOwwX8WZY6e1xfsDn8auDY+AKJJD4KtTvF/A8EqDHohS//QJKOwCfl62oG
         YpSw==
X-Gm-Message-State: AOJu0YyGfk7cge+qNjFYpSdLHB0nRxWATXjUmJOr4MlHPkduF358Cc1G
	BikN7975LVPHek8Tvig4j7Nwi5p1r+3wGfU2gta92v/sm48+G2zwmVieIJL5BbFgbDZO6W1JeOQ
	vpLvkCyxq5ltoOqvKdRSFG9DquqfNpNf+nsOZnQ==
X-Google-Smtp-Source: AGHT+IHQ0ZRz7PMXuybHo/Y1O2A8BwWG3h7isMAuW3IuKDdEMatIUaD2RbHJdlEZ1UrAAHV/W1VGA+F6v3XLRK+L0wo=
X-Received: by 2002:a05:6902:2007:b0:dc6:b0ce:97d with SMTP id
 dh7-20020a056902200700b00dc6b0ce097dmr5768975ybb.29.1707744465295; Mon, 12
 Feb 2024 05:27:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240116094935.9988-1-quic_riteshk@quicinc.com>
 <20240116094935.9988-3-quic_riteshk@quicinc.com> <20a8efd1-e243-434e-8f75-aa786ac8014f@linaro.org>
 <CAA8EJpqQVuS+yqXQ2y5sNQrRVg7tcQAJ3ywsEjg+O=7TkUZWLQ@mail.gmail.com>
 <99a9a562-9f6f-411c-be1c-0a28fc2524dd@quicinc.com> <CAA8EJppj+cDnw7p4yANvF0FmEhX3+L5xUq8w3TeevAGhcpo1Yg@mail.gmail.com>
 <9d1c684f-51ac-4d9c-a189-940ff65e0cab@linaro.org> <7932ccbb-3b41-49e2-bb88-9c2633002a0d@quicinc.com>
In-Reply-To: <7932ccbb-3b41-49e2-bb88-9c2633002a0d@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 12 Feb 2024 15:27:34 +0200
Message-ID: <CAA8EJppdJqBz=+2Lq4XEXptPoudHS_N7Qs0cjJ9bx2EZwP07dw@mail.gmail.com>
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

On Mon, 12 Feb 2024 at 14:28, Ritesh Kumar <quic_riteshk@quicinc.com> wrote:
>
>
> On 1/23/2024 11:34 PM, Konrad Dybcio wrote:
> >
> >
> > On 1/23/24 16:12, Dmitry Baryshkov wrote:
> >> On Tue, 23 Jan 2024 at 15:43, Ritesh Kumar <quic_riteshk@quicinc.com>
> >> wrote:
> >>>
> >>>
> >>> On 1/16/2024 6:27 PM, Dmitry Baryshkov wrote:
> >>>
> >>>> On Tue, 16 Jan 2024 at 14:06, Konrad Dybcio
> >>>> <konrad.dybcio@linaro.org> wrote:
> >>>>>
> >>>>>
> >>>>> On 1/16/24 10:49, Ritesh Kumar wrote:
> >>>>>> Enable Display Subsystem with Novatek NT36672E Panel
> >>>>>> on qcm6490 idp platform.
> >>>>>>
> >>>>>> Signed-off-by: Ritesh Kumar <quic_riteshk@quicinc.com>
> >>>>>> ---
> >>>>>>     arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 100
> >>>>>> +++++++++++++++++++++++
> >>>>>>     1 file changed, 100 insertions(+)
> >>>>>>
> >>>>>> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> >>>>>> b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> >>>>>> index 2a6e4907c5ee..efa5252130a1 100644
> >>>>>> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> >>>>>> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> >>>>>> @@ -9,6 +9,7 @@
> >>>>>>     #define PM7250B_SID 8
> >>>>>>     #define PM7250B_SID1 9
> >>>>>>
> >>>>>> +#include <dt-bindings/pinctrl/qcom,pmic-gpio.h>
> >>>>>>     #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
> >>>>>>     #include "sc7280.dtsi"
> >>>>>>     #include "pm7250b.dtsi"
> >>>>>> @@ -38,6 +39,25 @@
> >>>>>>                 stdout-path = "serial0:115200n8";
> >>>>>>         };
> >>>>>>
> >>>>>> +     lcd_disp_bias: lcd-disp-bias-regulator {
> >>>>>> +             compatible = "regulator-fixed";
> >>>>>> +             regulator-name = "lcd_disp_bias";
> >>>>>> +             regulator-min-microvolt = <5500000>;
> >>>>>> +             regulator-max-microvolt = <5500000>;
> >>>>>> +             gpio = <&pm7250b_gpios 2 GPIO_ACTIVE_HIGH>;
> >>>>>> +             enable-active-high;
> >>>>>> +             pinctrl-names = "default";
> >>>>>> +             pinctrl-0 = <&lcd_disp_bias_en>;
> >>>>> property-n
> >>>>> property-names
> >>>>>
> >>>>> all throughout the patch
> >>>
> >>> Thanks, I will update in the new version.
> >>>
> >>>>>> +&gpu {
> >>>>>> +     status = "disabled";
> >>>>>> +};
> >>>>> Hm.. generally we disable the GPU in the SoC DT, but that doesn't
> >>>>> seem to have happened here..
> >>>>>
> >>>>> Thinking about it more, is disabling it here necessary? Does it
> >>>>> not fail gracefully?
> >>>> Missed this.
> >>>>
> >>>> I'd say, I don't see a reason to disable it at all. The GPU should be
> >>>> working on sc7280 / qcm4290.
> >>>
> >>> With GPU device node enabled, adreno_bind failure is seen as the
> >>> "speed_bin" was not populated on QCM6490 target which leads to display
> >>> bind failure.
> >>
> >> Excuse me please. The GPU node for sc7280 already has speed_bin, which
> >> points to qfprom + 0x1e9, bits 5 to 9.
> >>
> >> Do you mean that qcm6490 uses different speed bin location? Or
> >> different values for the speed bins?
> >>
> >>> Spoke with GPU team and on QCM6490 board, only CPU rendering is
> >>> supported for now and there is no plan to enable GPU rendering in near
> >>> future.
> >>
> >> This sounds like having the feature disabled for no particular reason.
> >> Both the kernel and Mesa have supported the Adreno 635 for quite a
> >> while.
> >
> > 643 [1], [2]
> >
> >>
> >>> In this regard, what do you suggest
> >>>
> >>> 1) Disable GPU in QCM6490 DT (as per the current patch)
> >>> 2) Disable GPU in the SoC DT, but enable it in other platform DTs.
> >>> (This
> >>> will prompt change in all the dt's and we don't have all the devices to
> >>> test)
> >>
> >> The second option definitely follows what is present on other platforms.
> >>
> >>> Please let me know your views on it.
> >>
> >> Please enable the GPU instead.
> >
> > +1
> >
> > Konrad
> >
> > [1]
> > https://gitlab.freedesktop.org/mesa/mesa/-/merge_requests/25408/diffs?commit_id=b1e851d66c3a3e53f1a464023f675f3f6cbd3503
> > [2]
> > https://patches.linaro.org/project/linux-arm-msm/cover/20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org/
>
> Thanks for the help. After applying missing patches from series
> https://patches.linaro.org/project/linux-arm-msm/cover/20230926-topic-a643-v1-0-7af6937ac0a3@linaro.org/
> in my local build, GPU is working fine. GPU disablement change is not
> needed. I will send new version of patch removing GPU part and
> addressing other review comments.

Thank you!

-- 
With best wishes
Dmitry

