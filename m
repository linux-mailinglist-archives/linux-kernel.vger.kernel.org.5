Return-Path: <linux-kernel+bounces-102411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B331987B25E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:56:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B064B324A0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:23:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C19153364;
	Wed, 13 Mar 2024 19:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xbc5I1y6"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C9D346426
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710357405; cv=none; b=myjrMg+9Zqz7cOOFWQqgwjPzsMwHnSDC1GphgksSIv+lIqSxFhPiwgS5HNwoWJdGNv5u6SVqWc9hq957qlXPBwt5WrhOyCIqHwI5k5tXiHxfN4eMqrAHvoUNLufD3K2+RlSGpEec+At1kZYEJl6iWqrdna8kwb+GHzm69SVFwkk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710357405; c=relaxed/simple;
	bh=m4KPPUj/LPNlflg1pckaoyEc6VURIxmSzIkFnMsSQfA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BGDtGqyFQZlazofonKj8rt9rAeSF+TvKRRg1zVMaf1CpROtT/JySFjOCUTn/o04k3b3ww2opBf417VGM9Ytya4Tme2qDHh7ztN45dOm7iXV+Y6jYfigbQSWK19tO8yEWCz6yg57cLQtnsHDc7FaIAdU8c6DMJfNfkskz3aA9dik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xbc5I1y6; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-d9b9adaf291so97209276.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710357402; x=1710962202; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xvlDSWo+A7vodGITM/kTc7PRJIQ2/gEr0xBeu2xtrlo=;
        b=xbc5I1y6r6sQ+pICTeQWv+d7/7J2pCZIGTJr/kUOnd2TZnLKpmY4j4WF+Zi6rBYWK9
         jAR7zIerVo6NEg6zf94uS3/zH+r4ZfNxHdjiI5/fzJS7H1xakk4Zb0tYMF/ZZYcFhQN4
         EXkXZV2GRNW4ZoueHxCiIcRrwzAHJLTdOWTjfwqQWSXFf9XJQAoH1yWUE1dfXQXH9drH
         5bqwodZ9H2FnzaAt43T5y/fmmhRhhv+oNKGG5AsT/K0Cw/DOLgnOC26ZyTsCyzFfI39S
         JubmydrAuG24jgD7Y0+z68cUnMyp6xoKRTmDIS2zZyaR7uG0zgHe8hEz76MfvpfrVclb
         OMBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710357402; x=1710962202;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvlDSWo+A7vodGITM/kTc7PRJIQ2/gEr0xBeu2xtrlo=;
        b=Tjnpbv2NsUF8KYHMTIwgnVUw9Jq1IfXJqPSkXNUo3dYkCFQxHglfdRy8DG5z0AMsVr
         aPBsqoxunAGsblRfznm2KcpymaWhAj5FxPjEf67W2YZrrxf+U/8XUq7qY1kWxqiSKBgV
         ZQuV9gqw1Icewsp6aucbJ3m8B/Pe2YMv+0oKSZLwZG4e3NQf+RZMfT8P5Ae0etyzvHSt
         1bZT1GfTwndS5CTZDA2B6heJmLwLaaEUA/O7KhCZNb8pNHWuVLAj0oXi5mRqWqzgu9HT
         Y6Uo37d4OUs9lCBcv2iBmPPkWrwTXVrwWYhtY7tGzui3ZRpcDLetRZ/m2uVES976qJL6
         Iq2g==
X-Forwarded-Encrypted: i=1; AJvYcCU5/sERLdAM84PJHHFS0yiuV83YVo6G1R8+YAin1nJjArIwBJCV1FrPpcSDD1gU9t8oBba7I58EZdLFmpFwvThhjkkeKRtdA2zKTNiB
X-Gm-Message-State: AOJu0Yx9NW2mzpcnzaxEKG1sQvypdYzONKKzYD+fCdc4DUhfs3kDHD9V
	1DcBcXujQUiwR+2eCmhPyqFavm+2wvhyP2g7o4D2nyBEuZYg4ttqkXVnN2UM9ThR1YnKN9nVgPn
	You1QbhDVJNVzZWzhZNXed+32OlilYApdgFXkYQ==
X-Google-Smtp-Source: AGHT+IEduUHtt74VENoCnyr89b+JuexyutgMvD8JlfHuxsB6QwCU4z2b/0JpvtHhUtME9mQB30djjdIHm/gROlYYTEE=
X-Received: by 2002:a25:f621:0:b0:dd1:4908:7a91 with SMTP id
 t33-20020a25f621000000b00dd149087a91mr3207599ybd.49.1710357402201; Wed, 13
 Mar 2024 12:16:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240313-videocc-sm8150-dt-node-v1-0-ae8ec3c822c2@quicinc.com> <20240313-videocc-sm8150-dt-node-v1-3-ae8ec3c822c2@quicinc.com>
In-Reply-To: <20240313-videocc-sm8150-dt-node-v1-3-ae8ec3c822c2@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 13 Mar 2024 21:16:34 +0200
Message-ID: <CAA8EJprrrSTLBoLGMSJw3g9BEcL6y+To1tr65b+AzNz01MgjTg@mail.gmail.com>
Subject: Re: [PATCH 3/3] arm64: dts: qcom: sm8150: Add video clock controller node
To: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, Michael Turquette <mturquette@baylibre.com>, 
	Stephen Boyd <sboyd@kernel.org>, Ajit Pandey <quic_ajipan@quicinc.com>, 
	Imran Shaik <quic_imrashai@quicinc.com>, Taniya Das <quic_tdas@quicinc.com>, 
	Jagadeesh Kona <quic_jkona@quicinc.com>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-clk@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 13 Mar 2024 at 13:11, Satya Priya Kakitapalli
<quic_skakitap@quicinc.com> wrote:
>
> Add device node for video clock controller on Qualcomm
> SM8150 platform.
>
> Signed-off-by: Satya Priya Kakitapalli <quic_skakitap@quicinc.com>
> ---
>  arch/arm64/boot/dts/qcom/sa8155p.dtsi |  4 ++++
>  arch/arm64/boot/dts/qcom/sm8150.dtsi  | 13 +++++++++++++
>  2 files changed, 17 insertions(+)
>
> diff --git a/arch/arm64/boot/dts/qcom/sa8155p.dtsi b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> index ffb7ab695213..9e70effc72e1 100644
> --- a/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sa8155p.dtsi
> @@ -38,3 +38,7 @@ &rpmhpd {
>          */
>         compatible = "qcom,sa8155p-rpmhpd";
>  };
> +
> +&videocc {
> +       power-domains = <&rpmhpd SA8155P_CX>;
> +};
> diff --git a/arch/arm64/boot/dts/qcom/sm8150.dtsi b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> index a35c0852b5a1..6573c907d7e2 100644
> --- a/arch/arm64/boot/dts/qcom/sm8150.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sm8150.dtsi
> @@ -14,6 +14,7 @@
>  #include <dt-bindings/clock/qcom,dispcc-sm8150.h>
>  #include <dt-bindings/clock/qcom,gcc-sm8150.h>
>  #include <dt-bindings/clock/qcom,gpucc-sm8150.h>
> +#include <dt-bindings/clock/qcom,videocc-sm8150.h>
>  #include <dt-bindings/interconnect/qcom,osm-l3.h>
>  #include <dt-bindings/interconnect/qcom,sm8150.h>
>  #include <dt-bindings/thermal/thermal.h>
> @@ -3715,6 +3716,18 @@ usb_2_dwc3: usb@a800000 {
>                         };
>                 };
>
> +               videocc: clock-controller@ab00000 {
> +                       compatible = "qcom,sm8150-videocc";
> +                       reg = <0 0x0ab00000 0 0x10000>;
> +                       clocks = <&rpmhcc RPMH_CXO_CLK>,
> +                                <&gcc GCC_VIDEO_AHB_CLK>;
> +                       power-domains = <&rpmhpd SM8150_MMCX>;
> +                       required-opps = <&rpmhpd_opp_low_svs>;

Should not be necessary anymore.

> +                       #clock-cells = <1>;
> +                       #reset-cells = <1>;
> +                       #power-domain-cells = <1>;
> +               };
> +
>                 camnoc_virt: interconnect@ac00000 {
>                         compatible = "qcom,sm8150-camnoc-virt";
>                         reg = <0 0x0ac00000 0 0x1000>;
>
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

