Return-Path: <linux-kernel+bounces-56417-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2070E84C9E6
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 12:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82B451F25272
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 11:47:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC3A1D526;
	Wed,  7 Feb 2024 11:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrmXKPIA"
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B94E1B7F0
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 11:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707306445; cv=none; b=sR56DKh/fXqHCJNMm7279UsA3+6EYeYwGgonolNRAXMcJcbyiatkTSAE0Xjf950EFIp2qPdi2Rm+75sAeg4sOsIUuepYwbA0sdya0rKvoLf0cPnzta3DrQXvrGO32Bzt2r+so4D72meCEnTf/uj9cFGgkPDInKuKWM6iSXUVkmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707306445; c=relaxed/simple;
	bh=bk9mKLUBkiVeKV9Jlt3UQtxCYxjxQfDKf8LJgvf2SIs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pxnW9BU96VFKeXI4yYlh9PDN9TjwdkztOx2ExTA9vo+V+2/x938cdmUOhqiZnD3ARJwL3/gnHso3eEmEvD3xKzm9aaPNRvWQmo7EHvttke/IwEGeikD+ed5RvJGhpsgQvjdD1+wlAnC+jk2WGsAVAacElMbsSNEKb3u/uKtn0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XrmXKPIA; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-604545fee99so5035017b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 03:47:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707306443; x=1707911243; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=IBdEAORytiIoqLtaxVLqe0PceqtibKVmrzJCQ1csK14=;
        b=XrmXKPIA6wddI6GfdCcknuhhKrRiCBJPgpzRp9jfg7HxQS21Ly9HBuu0cgIbqwGCCL
         ZNUFeeOWZkIn9NobtdkNOlZ9TaM+TYYbzw6M39IeCb/D05YXX8RPhznw8Aatl/XfHVU4
         JPkfGTFtei7Kf6mI4I7fBUEkOKuTxkmZ8mEChxoeHsM8OEBkr+bLBL6SLRdEtBL3t/pz
         jLtbPpDpcDAKfppSOoVJXaRRF8o5KXBv6sdxJfaBRvbx/O4QkKteh2lsYqC+ok4mqKiJ
         Av3pPgwnRQ9TDQhku83bcaFIgbW8hFtOz8KS02Cz7+lgnL5PPi6vh8srrWEZ9GG71PE8
         dOFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707306443; x=1707911243;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IBdEAORytiIoqLtaxVLqe0PceqtibKVmrzJCQ1csK14=;
        b=TqtOuwh/AJZ1WoB32/TbJfArX1IhMlILYLQtJrveIzyAK+gM2ToxNyCYsSdHodh0YQ
         S7teHoYXybXXYm6BgPiF/gfhBlGQrxRpzh+S7klV9HzWpa1/4+qlELatOlW5OQTTs7dM
         xVVKlcbCDCS3Kci76k+c9hyb1C3XjwFk4pH64ubDM2v9d8leNvVTKoqc54Nu2g3QGmIO
         gPG2ASGZAgQ5hHeQc16JC3CiWlCNidSi3ob/BVdcbVbjhpFqXrPKUUMfgmy18TesqPLE
         UxWDNAxQT+LPs0mjub5b5qsL4wDucaePkQr7nNZX322IJO6GLu4/ddXiZzdpJV/RlofT
         Zd8A==
X-Forwarded-Encrypted: i=1; AJvYcCUIMwa8en8yrD0skE10QsR+havQFbCckvW6rZqd8q6V8OGqMpt8+tb8CHQtAkk1KIilBiyf32fG/AwtzbESXQKAvvLqvJ8afqnpw+RU
X-Gm-Message-State: AOJu0Yz7PNdy5h/nW41WuSaOo3/xO4ZifvbTCmAiyi0Vq/t5OaF3KPq9
	cTnEsyDcRgrx+fP9+sq8PUf9fM23Q+ns+hvz/YBwyqBgfUmTTyvxyzzFKWOeN2/C+wB5Bnyef21
	YA06lj5Yijev/KpdfwObHh6lCBZ2GCoSeKwj+cA==
X-Google-Smtp-Source: AGHT+IGQmgN4lJV2lpVJU3mhUKZlqNZeXns1+EfXYUyDWZiVaRGvSCitx9bvLEZ6p75HORpuQBSnccf5GLqoIeuTOxw=
X-Received: by 2002:a81:d80b:0:b0:5fa:564:afad with SMTP id
 d11-20020a81d80b000000b005fa0564afadmr4599487ywj.7.1707306443214; Wed, 07 Feb
 2024 03:47:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com>
In-Reply-To: <20240207-enable_pcie-v1-1-b684afa6371c@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 7 Feb 2024 13:47:11 +0200
Message-ID: <CAA8EJpqjm_2aE+7BtMkFUdet11q7v_jyHbUEpiDHSBSnzhndYA@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Add PCIe nodes
To: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, quic_vbadigan@quicinc.com, 
	quic_ramkri@quicinc.com, quic_nitegupt@quicinc.com, quic_skananth@quicinc.com, 
	quic_parass@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Wed, 7 Feb 2024 at 12:42, Krishna chaitanya chundru
<quic_krichai@quicinc.com> wrote:
>
> Enable PCIe1 controller and its corresponding PHY nodes on
> qcs6490-rb3g2 platform.
>
> PCIe switch is connected to PCIe1, PCIe switch has multiple endpoints
> connected. For each endpoint a unique BDF will be assigned and should
> assign unique smmu id. So for each BDF add smmu id.
>
> Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts | 42 ++++++++++++++++++++++++++++
>  1 file changed, 42 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> index 8bb7d13d85f6..0082a3399453 100644
> --- a/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> +++ b/arch/arm64/boot/dts/qcom/qcs6490-rb3gen2.dts
> @@ -413,6 +413,32 @@ vreg_bob_3p296: bob {
>         };
>  };
>
> +&pcie1 {
> +       perst-gpios = <&tlmm 2 GPIO_ACTIVE_LOW>;
> +
> +       pinctrl-0 = <&pcie1_reset_n>, <&pcie1_wake_n>;
> +       pinctrl-names = "default";
> +
> +       iommu-map = <0x0 &apps_smmu 0x1c80 0x1>,
> +                   <0x100 &apps_smmu 0x1c81 0x1>,
> +                   <0x208 &apps_smmu 0x1c84 0x1>,
> +                   <0x210 &apps_smmu 0x1c85 0x1>,
> +                   <0x218 &apps_smmu 0x1c86 0x1>,
> +                   <0x300 &apps_smmu 0x1c87 0x1>,
> +                   <0x400 &apps_smmu 0x1c88 0x1>,
> +                   <0x500 &apps_smmu 0x1c89 0x1>,
> +                   <0x501 &apps_smmu 0x1c90 0x1>;

Is the iommu-map really board specific?

> +
> +       status = "okay";
> +};
> +
> +&pcie1_phy {
> +       vdda-phy-supply = <&vreg_l10c_0p88>;
> +       vdda-pll-supply = <&vreg_l6b_1p2>;
> +
> +       status = "okay";
> +};
> +
>  &qupv3_id_0 {
>         status = "okay";
>  };
> @@ -420,6 +446,22 @@ &qupv3_id_0 {
>  &tlmm {
>         gpio-reserved-ranges = <32 2>, /* ADSP */
>                                <48 4>; /* NFC */
> +
> +       pcie1_reset_n: pcie1-reset-n-state {
> +               pins = "gpio2";
> +               function = "gpio";
> +               drive-strength = <16>;
> +               output-low;
> +               bias-disable;
> +       };
> +
> +       pcie1_wake_n: pcie1-wake-n-state {
> +               pins = "gpio3";
> +               function = "gpio";
> +               drive-strength = <2>;
> +               bias-pull-up;
> +       };
> +
>  };
>
>  &uart5 {
>
> ---
> base-commit: 70d201a40823acba23899342d62bc2644051ad2e
> change-id: 20240207-enable_pcie-95b1d6612b27
>
> Best regards,
> --
> Krishna chaitanya chundru <quic_krichai@quicinc.com>
>
>


-- 
With best wishes
Dmitry

