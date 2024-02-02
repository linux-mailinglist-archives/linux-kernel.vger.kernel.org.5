Return-Path: <linux-kernel+bounces-49967-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29947847235
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:51:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE2C2B24705
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 14:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C80C1419B0;
	Fri,  2 Feb 2024 14:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AhnnXlwx"
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com [209.85.219.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B3814198F
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 14:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706885500; cv=none; b=chIPjtifYNydVAkmK39Vs+THZbtwRr8BQ34w2DlS1kWCuytT6w2DzofIcGFzexevuswZH/0hNR450HpfnhpuFxoyzIx96wRXjkYlR2hiD90+ReNrUq448jMIzRMHBug2CFVAUGuCrrEtr4FEfRhWv0jzMLMelejnfVG+DA+nD+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706885500; c=relaxed/simple;
	bh=pi5rb7Tmyn/7tYX8PooVljl6kCdTTto2zjA8GuBlpAY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LExCTdzo2ZTRrIOcIn/VWER7R+B8hRcrYfj0G9YnF4jpHDmGtSGUPauauWgTZOEMm/y8WQM5VKXJUmmVo7FpWKifp8LiD63/QZlyjlIc+c37+LLDlGOmCQMkB3QjVs4D0mU4dlW7+dB7NPPzZX6tszANej1QBH6WmsuCHodm4h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AhnnXlwx; arc=none smtp.client-ip=209.85.219.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f174.google.com with SMTP id 3f1490d57ef6-dc6de8a699dso1664455276.3
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 06:51:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706885498; x=1707490298; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5ilE578MCSWuARlueVH7UntettuBsn2jGRybz77noas=;
        b=AhnnXlwxIZOs19Mv3JIjQFABk3L2h0YBoug9D4lQdOsMdGSAFeEnooAGf89g8Q9jm3
         qhmngmocgRaMRbkpL0Hixa69ENOM6CAufNcRzRe2ZjpmJY7NGKblf4dIowT3qT2liRAd
         ggmvyIEJMob9r1eBdr9q3ixebl3go4ln2iIO/tR04+agLLIZZLw+1/UvsqPvx02ZLUTs
         9/ZvWoEQ+aqQv5SnrRM57epENLo1fNsvR2Mp58bDLb2w51QdlNMibVSTsCIkrt1u9dKv
         NeZQBZYWtRf1Bihn/WdAbvEZVf/JfS90cNQBGcpLKPvqATpItU6UmbzGgP/YXaaIvvMT
         IIZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706885498; x=1707490298;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5ilE578MCSWuARlueVH7UntettuBsn2jGRybz77noas=;
        b=tL2zVDcDOMQslPXiZoIEPFrNMm2BmGvywGiLdP5AdIUrnQEftazQFFD2T07p7vqyrC
         LhVoOa6EdYxfsREuG9qiolhOgb5DJqeZtwHa+KzkiR2LBCpLI8tXYiZKWPzo2uXrV5cC
         cEMycffJKWs7iWm4HACY3Tm0kgO35xV2xtL6DbZ235oU416OdTQNRvyp0xk6ro5eAop+
         Kq9b1QGT2W5thHLEZaeZ2aQuHOA//fuho6SSuUAvv6MhN4IDJmlD4rHkiyeU+yCaKwTG
         AB8oalZHvBaTXA635AjEZvGWt2dxJVFtFkCmt9mvqt4ZBRZahB0aYZPo38YpPAWPhX5W
         l39Q==
X-Gm-Message-State: AOJu0YyTXp8BY//JB0adqh740i0aN8X5VuaBtIavEPY28qujeNbwu6tC
	n40/L9AtmbIyv2NctrVwCSq5+4ZdPQoTFvqWYBcmdtOQmccb3hspbomg1RPM7Stf9UIo214+56R
	AOL86Xu7JWxlh3vosZhU+T7eoMn/0m8Auldf8+w==
X-Google-Smtp-Source: AGHT+IGAu6APLA2kU8DipKtx/vB6ojLEggEiEM1eRwpgZew+E0GgfuIW0deCZUiuf3ZHZKYpE++k4dcdLQJ7ztG9oM4=
X-Received: by 2002:a81:52c4:0:b0:5ff:569c:d349 with SMTP id
 g187-20020a8152c4000000b005ff569cd349mr8284638ywb.19.1706885498324; Fri, 02
 Feb 2024 06:51:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202133638.4720-1-quic_wasimn@quicinc.com> <20240202133638.4720-2-quic_wasimn@quicinc.com>
In-Reply-To: <20240202133638.4720-2-quic_wasimn@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Fri, 2 Feb 2024 16:51:27 +0200
Message-ID: <CAA8EJpqARMwKhybgsFDKNZ=-uSAY=j4ocdZ=ax5U1KVPNXBTCg@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: arm: qcom: Document rb5gen2-hdk board
To: Wasim Nazir <quic_wasimn@quicinc.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, kernel@quicinc.com
Content-Type: text/plain; charset="UTF-8"

On Fri, 2 Feb 2024 at 15:37, Wasim Nazir <quic_wasimn@quicinc.com> wrote:
>
> Document board bindings for Rb5 gen2 hardware development kit.
> Rb5gen2-HDK is using Rb5 gen2 SOM which is based on QCS8550 SoC.
> RB5gen2-HDK is development kit used for IOT solutions.

What is the actual marketing name for the SoM and the carrier board?
The RB5gen2-HDK doesn't follow the previous example of the RB* boards
and doesn't sound in tune with the RB3gen2 submission.
Could you please sync up internally and come up with two similar names
for the platforms with similar purpose?

>
> Signed-off-by: Wasim Nazir <quic_wasimn@quicinc.com>
>
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 9cee874a8eae..ce5b5dfe0e46 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -104,6 +104,7 @@ description: |
>          qcp
>          qrd
>          rb2
> +        rb5gen2-hdk
>          ride
>          sbc
>          x100
> @@ -915,6 +916,14 @@ properties:
>            - const: qcom,qcm8550
>            - const: qcom,sm8550
>
> +      - items:
> +          - enum:
> +              - qcom,qcs8550-rb5gen2-hdk
> +          - const: qcom,qcs8550-rb5gen2
> +          - const: qcom,qcs8550
> +          - const: qcom,qcm8550
> +          - const: qcom,sm8550
> +
>        - items:
>            - enum:
>                - qcom,sa8155p-adp
> --
> 2.43.0
>
>


-- 
With best wishes
Dmitry

