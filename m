Return-Path: <linux-kernel+bounces-35849-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D1276839757
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 19:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4AC111F2D5F4
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 18:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D58A61674;
	Tue, 23 Jan 2024 18:09:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZgBFiqNI"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086EB8121F
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:09:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706033382; cv=none; b=WzA1X05NnxqYRxV3/l/ivTavGesPYO+Xn3S5huZOnmeGVZgiLST0WZvQGW69PzRmT35cWd06pIY+ahklmBPLK+j+LRUYUOgakUUrh7xbFTOr3K6LJrTv6S1oVM/lZENG3Umv+ctbe+k5pdONKQC2VPAh1ng+bli53DWBJXOH4lM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706033382; c=relaxed/simple;
	bh=rbL2CuKEPfhYPRUKnKTCYlD5HBaIevd0hu+UdJ0LJTM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QnpLdK02oC6HLX32f7VWiYFNVVRdYeH1TOKZUkJB2DASQsO7+PfYqOh2Tg487L7JlX5fWA6MiStrE9tEULqjetizcXSIlt+UFzYjYwoXMam4u5xcSCpDbEmqM/WnlWkJDeIMqUdfIiYy6hobfmek3xJzuvUuJBYDdSUAY2b1FJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZgBFiqNI; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-50f1c524010so4922346e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 10:09:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706033379; x=1706638179; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QZN6uzlZ6X9O8OT09FqEaEZ9I2AGFnhu8FJmaqkLSSQ=;
        b=ZgBFiqNI7RtRbR6KlgNG7Vj0XwkLpIW4fYRt3Qa93Eehb8jkYqvM6ihbrq5wsh/CAB
         zrvqzJR5AHjUrRV9vCqQizAhwMbSsNu5jYBKChkS/0JUGLdvZN38Xv1726nI6Igt1reM
         aSogAm4zYY9RcLQDr4QIPy7VPUz6WgnridxHBYUsSvjsJND2XYuiKgbkb7A1xWs4QQTM
         DA1a7JYNGYv7gVdMq0QxNcOEVo14TPE+UVupIvCVYeDB6+QxnEoC6bvDZydbolQTuIbr
         Woz2JClnECD509chlgwIHW6m2AaqxMCE330ckCbtfX8HFw8g6Z1k8HiZXZXeKiHJ+fGo
         amCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706033379; x=1706638179;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QZN6uzlZ6X9O8OT09FqEaEZ9I2AGFnhu8FJmaqkLSSQ=;
        b=Xe5xKtfG0ACuhNCjypNMCQGjsedwiooiWaZpwdf29PQWCFS6lojSFcQApv8DkwHutH
         pi5YzFdUdVQi1fSt/+qgQhuXLrK2l652zsZOLvynjEHnMVDrX6rIbCI6ClK5450/OrHo
         CiDiRECDiK7c/Y/Ce9XzaFsaTtk63hYYET/eED2OWSV1XELrtgo9S6o++EO4LJM3LpX7
         mTVrpK4bu9Oo9IkwaLH5XCWv/X/lT1OAkQ5jIk2RrAz8luvj6jvYV+KCvm6yHejQaA3K
         /YspvWDN7yRN0KyvTkklDFcEyHl/SshZQ6CIyNy1rpXawVkD8FFIQFyHbLlHYUYTA6pD
         MZtg==
X-Gm-Message-State: AOJu0YwarXYb8FhRYNiERKN26y6iflosKGmPbPaPtW1r+UmCV7RGnc/8
	Nx5wlTr5aA2HceAysOfe1o6gWPRd2C4vb/p26RS02b7KmVzcrfY1wDthn3igVgY=
X-Google-Smtp-Source: AGHT+IEAox1Ti0aslRK2tKFYxgZQeO+haDl9IHXbMvt8AwqlGHnVUlnn1ehrKT2Oh+/WKAScnOH1tg==
X-Received: by 2002:a05:6512:3e01:b0:50e:45d7:eee7 with SMTP id i1-20020a0565123e0100b0050e45d7eee7mr1887070lfv.26.1706033379038;
        Tue, 23 Jan 2024 10:09:39 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id d17-20020a05651233d100b0050e8e88b529sm2344518lfg.237.2024.01.23.10.09.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 10:09:38 -0800 (PST)
Message-ID: <b0f4236a-c87e-4d50-b1a0-42ed5b015b86@linaro.org>
Date: Tue, 23 Jan 2024 19:09:37 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 05/11] arm64: dts: qcom: x1e80100: Add TCSR node
Content-Language: en-US
To: Abel Vesa <abel.vesa@linaro.org>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Sibi Sankar <quic_sibis@quicinc.com>,
 Rajendra Nayak <quic_rjendra@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240123-x1e80100-dts-missing-nodes-v4-0-072dc2f5c153@linaro.org>
 <20240123-x1e80100-dts-missing-nodes-v4-5-072dc2f5c153@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240123-x1e80100-dts-missing-nodes-v4-5-072dc2f5c153@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/23/24 12:01, Abel Vesa wrote:
> Add the TCSR clock controller and halt register space node.
> 
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---

The former - yes, the latter - ?

Konrad
>   arch/arm64/boot/dts/qcom/x1e80100.dtsi | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index be69e71b7f53..2b6c55a486b2 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -2606,6 +2606,14 @@ tcsr_mutex: hwlock@1f40000 {
>   			#hwlock-cells = <1>;
>   		};
>   
> +		tcsr: clock-controller@1fc0000 {
> +			compatible = "qcom,x1e80100-tcsr", "syscon";
> +			reg = <0 0x01fc0000 0 0x30000>;
> +			clocks = <&rpmhcc RPMH_CXO_CLK>;
> +			#clock-cells = <1>;
> +			#reset-cells = <1>;
> +		};
> +
>   		gem_noc: interconnect@26400000 {
>   			compatible = "qcom,x1e80100-gem-noc";
>   			reg = <0 0x26400000 0 0x311200>;
> 

