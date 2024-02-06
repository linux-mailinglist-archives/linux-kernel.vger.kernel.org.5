Return-Path: <linux-kernel+bounces-54363-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E35AA84AE3B
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 06:57:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9964128677A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 05:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D03A81211;
	Tue,  6 Feb 2024 05:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h4RtbnBf"
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9DC8003E
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 05:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707199071; cv=none; b=CYB+WkfyYTksBEeXG9FZYfbVYyl58npihZ+bPVq2hcYyH8xAniKqavfhJrROmacbV7yPfW3K9LEJkXE/8hSpIJ8Qu3v2FCShGMYsO2SIQnRbrw2PgEznOAPm34dwo15eRzGZgKbCJVPwN068uVwZxVNqkAq2tZHzQnlZlvVr4tY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707199071; c=relaxed/simple;
	bh=ysU08zj4Hg/RYgoGDggCvO60aVp5MmHmJq2MC6dL0VE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=En4BrtMLmtEUdo1nBglVeAwjjptZqDJx5LTvGS+bbNojaz7bZlFTGZJaF/GA01yaatH7vXia60dexeetkrfEj+dnHoR8YCC4ZC9Pt+ZynGR/SS7E0WBJ2Bl/Bwn/OcypQy5M9V0Udn/AYvf6ktgqqryfUv6hdLKIJGge9wWVl5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=h4RtbnBf; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-6040d33380cso53953757b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 21:57:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707199068; x=1707803868; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Wmo8OZ+RD3WMbukSfHahLE4n7rr4rX9TbI2saroDAe0=;
        b=h4RtbnBf/uLQ1ZRD7HxSb6mBzYQu3mAkqU9cQTbgxzMPx/pGpAbAJYSTlYMXwRGXND
         JIPRf3jhDnfqca3+yu4CeADEF1IZ2ApOSWRR99KbVYWaWFfATFGggxQetXJfYxLBmfgW
         ssZbBrIP/oOb3fSy29goQlQ6m3NFaNzse0bylewfER9h1HoGs9B/WH15ZSDeY8Oh6rB0
         2E8o4byt0fIGH2B7mKq5B+mvWC1xgx8ebEbugI9bEWQo8YMsz2uZhS8HKegbn6VraONY
         4BFxibQvTmYgu/Kf0pCui1PROFwWEXXwGaiDTTjH1ZjSLP6ZHk22lrsH24mmcwWzTH+G
         PZOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707199068; x=1707803868;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wmo8OZ+RD3WMbukSfHahLE4n7rr4rX9TbI2saroDAe0=;
        b=SgLnRIdJw+Yue+N07meWcOi0AxKZwrQwb0Pd9Or/q056t0xmB7z0kFSMNmqpikTuX7
         7/bdBunbF1eG9SaLDV5veJNpXDqjtyYEe43s8Ux7mV0XogocIVdjky1Hh67xY4TSbgEz
         ZiC7SZwa2To3Hs9kRXn8GYckle6qBpyb4+evkVljCXNf8o56LWBjF6Ad5ncdqO69l1MF
         EhyEXX8AFikVbnKD9Ysi8YwRTyAmhzX0Yyn1TFjrpjdhZ3cfOdPhlIaUOuOIJs9J5J2/
         +KSKsjAbTGbdgVp7mvFWflOOfaqfDnyOYqBjac56SH+qIPO08GuB7wyG8iK5CtsZVxw7
         NXoQ==
X-Gm-Message-State: AOJu0Yz2Ec5SWLNTORFzk80Tl+DGa/f/jQE4DfslFHsCVd0k8PQ2BsOA
	XvpUdGf4nBz2Mo3iLoJZw6VbGdmrvgb3homtv5ds0kXKzCzqt5CET1htLmraokCUhWL+C88liD7
	Du+E2jodAmVufAXQ80SNC2393YRdD8vqZc5DdTw==
X-Google-Smtp-Source: AGHT+IH+R9/XEh5MDFKwcKvN1122YGkm05bcyEuArFy7J3lbwWjm15zjwXjtYTmM97101cB17yqIknzWzpzCcwMYKxI=
X-Received: by 2002:a81:a882:0:b0:604:76c3:7b3c with SMTP id
 f124-20020a81a882000000b0060476c37b3cmr758325ywh.6.1707199068531; Mon, 05 Feb
 2024 21:57:48 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206-gpio-keys-v1-1-7683799daf8d@quicinc.com>
In-Reply-To: <20240206-gpio-keys-v1-1-7683799daf8d@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 6 Feb 2024 07:57:37 +0200
Message-ID: <CAA8EJpqo6p+S4JirhGybGsiG0X9Evdb3LEVgorsewEcRT8LMgg@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcm6490-idp: Add configurations for gpio-keys
To: quic_huliu@quicinc.com
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 6 Feb 2024 at 04:21, Hui Liu via B4 Relay
<devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>
> From: Hui Liu <quic_huliu@quicinc.com>
>
> Add configurations for gpio-keys to enable pon_key and pon_resin
> key.

Configuring gpio-keys is a requirement for enabling the pon_key and
pon_resin, so the commit message is incorrect.




>
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 43 ++++++++++++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> index acf145d1d97c..4199ebf667af 100644
> --- a/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> +++ b/arch/arm64/boot/dts/qcom/qcm6490-idp.dts
> @@ -9,6 +9,7 @@
>  #define PM7250B_SID 8
>  #define PM7250B_SID1 9
>
> +#include <dt-bindings/input/linux-event-codes.h>
>  #include <dt-bindings/leds/common.h>
>  #include <dt-bindings/regulator/qcom,rpmh-regulator.h>
>  #include "sc7280.dtsi"
> @@ -39,6 +40,24 @@ chosen {
>                 stdout-path = "serial0:115200n8";
>         };
>
> +       gpio-keys {
> +               compatible = "gpio-keys";
> +               label = "gpio-keys";
> +
> +               pinctrl-names = "default";
> +               pinctrl-0 = <&key_vol_up_default>;

pinctrl-names should come after pinctrl-0

LGTM otherwise

> +
> +               key-volume-up {
> +                       label = "volume_up";
> +                       gpios = <&pm7325_gpios 6 GPIO_ACTIVE_LOW>;
> +                       linux,input-type = <1>;
> +                       linux,code = <KEY_VOLUMEUP>;
> +                       wakeup-source;
> +                       debounce-interval = <15>;
> +                       linux,can-disable;
> +               };
> +       };
> +
>         reserved-memory {
>                 xbl_mem: xbl@80700000 {
>                         reg = <0x0 0x80700000 0x0 0x100000>;
> @@ -421,6 +440,17 @@ vreg_bob_3p296: bob {
>         };
>  };
>
> +&pm7325_gpios {
> +       key_vol_up_default: key-vol-up-state {
> +               pins = "gpio6";
> +               function = "normal";
> +               input-enable;
> +               bias-pull-up;
> +               power-source = <0>;
> +               qcom,drive-strength = <3>;
> +       };
> +};
> +
>  &pm8350c_pwm {
>         status = "okay";
>
> @@ -448,6 +478,19 @@ led@3 {
>         };
>  };
>
> +&pmk8350_pon {
> +       status = "okay";
> +};
> +
> +&pon_pwrkey {
> +       status = "okay";
> +};
> +
> +&pon_resin {
> +       linux,code = <KEY_VOLUMEDOWN>;
> +       status = "okay";
> +};
> +
>  &qupv3_id_0 {
>         status = "okay";
>  };
>
> ---
> base-commit: 23e11d0318521e8693459b0e4d23aec614b3b68b
> change-id: 20240206-gpio-keys-138bbd850298
>
> Best regards,
> --
> Hui Liu <quic_huliu@quicinc.com>
>
>


--
With best wishes

Dmitry

