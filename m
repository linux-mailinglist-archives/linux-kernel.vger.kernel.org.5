Return-Path: <linux-kernel+bounces-151855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7377E8AB4D2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 20:11:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FDB11F22CDC
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 18:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAFCD13BAFF;
	Fri, 19 Apr 2024 18:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qdQauAQd"
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1813AD02
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 18:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713550311; cv=none; b=Yw3uCLas00kuUcew+bWTR6S96fmphvsdCRCzlseN87RG9fzwOh0jOQ6PFxQ1NeYkuAgsfr9Fl/oFbwzPyXPb/SwsfNEyCV6pATXGwQCJ/dKwNIOc4t1BJrp8yxgjcMF+fskIRwycYGjvd9fxuasuE7sdxF3tCjXI14LEYooFtnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713550311; c=relaxed/simple;
	bh=kpDp/tDKF6u8aQQFzTlCZlZ2nmv/pCiyMG5DCRNEMH4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BDDf4K2sHkODUmm2zZgff7UO9bSLtoqlHmr//fS9jdm+kh5ESDNkyovBv6adyodMt05U3doUYWE3epM4KB0gUCOazL/7Koxv01FAnpvcHacdZviSY7AVdH+6B4K8SKAV0R/hT6l3sUdvQVVz2YAand3aKDE4C0/Zo6uQ8Fh4e8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qdQauAQd; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-dcd7c526cc0so2583262276.1
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 11:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713550308; x=1714155108; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=hyxqidtiL/NTat07i5sxE7s0Wa8dugW75yP7YmoWNV8=;
        b=qdQauAQdielGwknHNSZDpQqZT4cnbb1pz34Rtwk3LcuLpI78LuA1eagJnUytdXq3kF
         CfZx5rzs10T3ZCVwibjYxE3MDqq5b+FDEIhYBEvygRDIre8gN7/bybyeyiUwAUMwx1C5
         /O6Xha+bVb2yphtRC/lW/W3fhhXqU7galr57vZGkSEJJU+PdO1ntJpavUiOTdJ1M9M32
         YlXByQIQ+/nnbReU1HaOAcF0jDXWCbyjgjTxBytdQXpIY6hDrC2U3OXm0FKbCw/PYODU
         3wzhydkE0ERsfmD6sQd2p7cjXXMjz6rhocpAIDpf9dcYDzIHtGLSJTf5r4tHkm45zKoU
         T+Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713550308; x=1714155108;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hyxqidtiL/NTat07i5sxE7s0Wa8dugW75yP7YmoWNV8=;
        b=AzASoFqNxhMPVkRwmvWlCgvVB3fkOZSB0Oaq2zkxvffLOAe+4qVyKK5w2j9JmTkdrO
         exTQiOgN7sA+cSiqKOp/OgiRr8y0PW5U541TntpW62GInw3o7qMlU7yjSV2AWGZOPX7Q
         ll5kg3PcljkCRv5nnnqaF1OevGsgXauSH8t3eFZ9rXz78vGvsLWi1AF1WW+pJ8WUThYp
         EHdiMWB2KRT7xAMAoFvOaHVgZ1k4c8GAWLP8iZsrvkQpE+tQP7LWHrqw8XzC/l6oothV
         03v+oy6XJfC6g0eh5a03LXyi+3OChV9TWIHiKMH7aUfy93XSSfh6pEYU8+pRW+X8UjwS
         UuBg==
X-Forwarded-Encrypted: i=1; AJvYcCV7OMkBDlpgosCigZ8cq9iN+P6IJCKKOYOF79vU7QUJrDfiwCfJYQo46Hf0bhx2Y7AO23mn1qG1UUYoBN/fhkrMlI0cZWJDArw80PQs
X-Gm-Message-State: AOJu0YztDSX2H2b5qdnYOYI8FSYo6k0TCwn1eIaHFLOzuRzxdt3KVRjU
	19XIiB1Pp+mEiBs3S6ZyX4uDD4eU3WRkj0voQnvDouHBd1sJqzYLl6dxI9gilbvj9G3DNoAC/ue
	JlwJ8rX2UWj8/RKKRtuKVWG3LyEx1sCGl+MlBzA==
X-Google-Smtp-Source: AGHT+IGcWi/OG56+hiuPqFqYIVOD3gn8BVTrYH92OTVBqaeRKs+lfGtmgMgHUQk5ZN8KQBFfqn+s6lCL73G+tbty58A=
X-Received: by 2002:a25:8548:0:b0:dc6:c32f:6126 with SMTP id
 f8-20020a258548000000b00dc6c32f6126mr2862185ybn.22.1713550308636; Fri, 19 Apr
 2024 11:11:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240419-x1e80100-dts-fix-mdss-dp3-v2-0-10f4ed7a09b4@linaro.org> <20240419-x1e80100-dts-fix-mdss-dp3-v2-1-10f4ed7a09b4@linaro.org>
In-Reply-To: <20240419-x1e80100-dts-fix-mdss-dp3-v2-1-10f4ed7a09b4@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 19 Apr 2024 21:11:38 +0300
Message-ID: <CAA8EJpomLDLf0QwKXV1s2VTqxxQsKLJEGdyYYbWKGEP8A4uyyw@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] arm64: dts: qcom: x1e80100: Drop the
 link-frequencies from mdss_dp3_in
To: Abel Vesa <abel.vesa@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Rajendra Nayak <quic_rjendra@quicinc.com>, Sibi Sankar <quic_sibis@quicinc.com>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 19 Apr 2024 at 19:14, Abel Vesa <abel.vesa@linaro.org> wrote:
>
> The link-frequencies belong in mdss_dp3_out. Drop them from mdss_dp3_in.
>
> Fixes: 1940c25eaa63 ("arm64: dts: qcom: x1e80100: Add display nodes")
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/x1e80100.dtsi | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/arch/arm64/boot/dts/qcom/x1e80100.dtsi b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> index f5a3b39ae70e..5f90a0b3c016 100644
> --- a/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> +++ b/arch/arm64/boot/dts/qcom/x1e80100.dtsi
> @@ -4095,8 +4095,6 @@ port@0 {
>
>                                                 mdss_dp3_in: endpoint {
>                                                         remote-endpoint = <&mdss_intf5_out>;
> -
> -                                                       link-frequencies = /bits/ 64 <8100000000>;
>                                                 };
>                                         };
>

Not to mention that limiting DP output to HBR3 only is wrong.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

