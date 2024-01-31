Return-Path: <linux-kernel+bounces-46422-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDEE843F65
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 13:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 719D21C2AB15
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 12:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD9C779DCC;
	Wed, 31 Jan 2024 12:27:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H1kcHeM/"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84D0778B78
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 12:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706704023; cv=none; b=qRzYuWmoxYY1kYwepRgmUlAkRRmRy0YMz6iGMcg5XIOFiW56FpGvhXMWho5O7dX5xmBcqlRTvYDRkpc81sySkg78L6B4HvhBnUPOQgBSR4Z7TDTqkapyAD3j1uU9GhH4NTyGAON25nwtY6H2RoK2NF4KbYkcXfLPoW/r9z6Ku70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706704023; c=relaxed/simple;
	bh=H9HsAc6EPMnurDsAxVdEA3FB5kKp89C8i+CXaQzDOPY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hJaH/G+TYJSKJLC/KUU6UWTVJsgvPJ19kKeyomhQCRLWChCjjG7M48aMBqyaw1/EeBcp+R82khDRa/HAzgcisQQUQwSmVi6s0OxwPVcOaUo9zY5yeJISpEn2yXaluFEvw3ULJ6DccyzdDB+Z0/HijOQVVNiCxWlDtrCgIaxjV2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H1kcHeM/; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-6001449a2beso37063997b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 04:27:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706704019; x=1707308819; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5L/tMbC6cusFxl6pPtmgbyUWE6zqIJ5tXoW7n67BpgU=;
        b=H1kcHeM/vaq0oJ0fr5yde6rIKw5tn0Mc7nH6KGnPx6RMFbOuhfksqsxY24Gp2ZVbRN
         pWgfB2gGE5qYbaTMF3j9jPGep+U7Ugn+jfcNqK0YDB1qIaXEQ3rZRo9QI7fhS8OGBdVd
         qO05ilH1WCqa+Dnn2faAa5aPWNBCgkTGilvzN27BQwaRuY2ubvfHphmeiiDcyyX+4HLi
         ittVFCuRHUhp2owtYbgqlNO7ILkx9Y8JGbSQ3FvhzfcpEQindj0W5Bp3H45Rdlci4Rxa
         F8XSHUQNbs67pGSHXPevVUsMkMdvG3IVHugGqPbDKLuhmHokafqlSFnlcy0gqjZtkw3O
         OHiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706704019; x=1707308819;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5L/tMbC6cusFxl6pPtmgbyUWE6zqIJ5tXoW7n67BpgU=;
        b=tCKauGguM3z1o7i9/dKw7ARO9f5VLUS6Fakjq82lntah/7q/uIvL3laZqrJpUNXCgw
         vkmLoTh/PBZ9oFqpaO2EAPBkQCuLXY88GmctTG+ZzQbapd8653E/h9sQATlxjZRoTG0N
         c9W9TUOzmW8YIrc7ovvii4m72F6CpOQzI4hSoQT2g+P1BWyCNOwZ29PXgWLjml0n9KWh
         1iZP+Tm+l2IclAMV+VmFX3AyNJB9X/I72sTKwRgfts8dcSd4cEtUE18TjM3K46j3caDC
         bR8QUKYBiz3rk+9C06VBN3Y4zLrKqiwS44hz5mOSLzQq18IV8zZe6MXEVHa4q6AdpMD1
         F20A==
X-Gm-Message-State: AOJu0YztYM1SQidZ1/YAVu84JbasBndDArnWzSugceO5hwwtre+Wgg7h
	ZIQHtybbKbwXxvpHgkuiGZO/xEu+xHpSubyCZEkYQ0+lLeZHojSWR0JjZLVLAcedf2X81i8WlCw
	aXfkh6fsz9t/+xwTFoWjUTFv0Dji1gJka+5k/Sg==
X-Google-Smtp-Source: AGHT+IExYmsDKD7JI6oFpFxZmf5OrGsPJTsIRy8SKXYafhZhPWCKnGPjAVGUqWeYdTGmEHNqG1M57c/2/8Su1nWdyHM=
X-Received: by 2002:a25:acda:0:b0:dc3:6990:99eb with SMTP id
 x26-20020a25acda000000b00dc3699099ebmr1464707ybd.55.1706704019522; Wed, 31
 Jan 2024 04:26:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240131102003.2061203-1-amadeus@jmu.edu.cn> <20240131102003.2061203-2-amadeus@jmu.edu.cn>
In-Reply-To: <20240131102003.2061203-2-amadeus@jmu.edu.cn>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Wed, 31 Jan 2024 14:26:48 +0200
Message-ID: <CAA8EJpo01ZoqLt=fyL1Pau0DVhCL=38yEdnCThA7=AnLyS98yA@mail.gmail.com>
Subject: Re: [PATCH 2/3] arm64: dts: qcom: ipq6018: add ipq6000 CPU OPP tables
To: Chukun Pan <amadeus@jmu.edu.cn>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Wed, 31 Jan 2024 at 12:23, Chukun Pan <amadeus@jmu.edu.cn> wrote:
>
> Some IPQ6000 SoCs don't have pmic chips, and fused 1.2GHz.
> Add a separate CPU OPP tables for these SoCs.
>
> Signed-off-by: Chukun Pan <amadeus@jmu.edu.cn>
> ---
>  arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi | 49 +++++++++++++++++++++++
>  1 file changed, 49 insertions(+)
>  create mode 100644 arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi
>
> diff --git a/arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi b/arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi
> new file mode 100644
> index 000000000000..acb4774da33e
> --- /dev/null
> +++ b/arch/arm64/boot/dts/qcom/ipq6000-opp.dtsi
> @@ -0,0 +1,49 @@
> +// SPDX-License-Identifier: (GPL-2.0+ OR MIT)
> +/*
> + * IPQ6000 without PMIC (MP5496) CPU OPP tables
> + */
> +
> +/ {
> +       cpu_opp_table: opp-table-cpu {
> +               compatible = "operating-points-v2-kryo-cpu";
> +               nvmem-cells = <&cpu_speed_bin>;
> +               opp-shared;
> +
> +               opp-864000000 {
> +                       opp-hz = /bits/ 64 <864000000>;
> +                       opp-microvolt = <725000>;
> +                       opp-supported-hw = <0xf>;
> +                       clock-latency-ns = <200000>;
> +               };
> +
> +               opp-1056000000 {
> +                       opp-hz = /bits/ 64 <1056000000>;
> +                       opp-microvolt = <787500>;
> +                       opp-supported-hw = <0xf>;
> +                       clock-latency-ns = <200000>;
> +               };
> +
> +               opp-1200000000 {
> +                       opp-hz = /bits/ 64 <1200000000>;
> +                       opp-microvolt = <850000>;
> +                       opp-supported-hw = <0x4>;
> +                       clock-latency-ns = <200000>;
> +               };

I don't see this OPP entry in the existing table. If it is supported
by the SoC, please add it to that table instead.

> +       };
> +};
> +
> +&CPU0 {
> +       operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&CPU1 {
> +       operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&CPU2 {
> +       operating-points-v2 = <&cpu_opp_table>;
> +};
> +
> +&CPU3 {
> +       operating-points-v2 = <&cpu_opp_table>;
> +};
> --
> 2.25.1
>
>


-- 
With best wishes
Dmitry

