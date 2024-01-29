Return-Path: <linux-kernel+bounces-42148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D29E583FD0C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 04:58:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 900FF284E08
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 03:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 86AEC1078D;
	Mon, 29 Jan 2024 03:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XrDCUYag"
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA3511737
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 03:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706500677; cv=none; b=mJ7T257jwgzVK67/RqJa8AAvdL1mYPQK9+7i9OHfVWWaUCHteVLj7jUPVt6yOlHqaleqrv/ehI8ID3M+3jFS3enNKBjLNZVcSKynyH2TEUTwGuSw80pfHHQIjoNn7+Xe2CfKwSJ8VxPxovAw6E90g/uLKnhziC8qsQUg3uzM9vU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706500677; c=relaxed/simple;
	bh=/MQsZbzA6Kf+NGX5pqU34m2qRTbkSuz8iLgvvB48ojk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kdzQ/xZIWwWSs0Euo35UoJcdtmSMty8hPzcNsYFCVoGOACchDebcsz+iOZfoq7Ubch1H4k9PAouWLcZhlszJXaL2INLBzT3tNLCNOqx6Z+9RYL89RJtPlb4bNaMxs/BMV0nBrDwrT7td4TCy4CDj7TbM5dQaHYRdr226GQka3ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XrDCUYag; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-dc68150f46fso347832276.3
        for <linux-kernel@vger.kernel.org>; Sun, 28 Jan 2024 19:57:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706500675; x=1707105475; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DvmPqZ2pCOoetWcGfoB/FaWoKJR0XDZxmCTI8i3VR3Y=;
        b=XrDCUYaghyIsu0kEfayRT1YqXHj74rgQoWmbUc2VmEhC+dczANg73x0WnZwtHimAup
         yfkABuIs293oQ7bkq0wA9fy0rVPBiAakpPbamo0N5f9ItG9RLovXX49pRn5OIZ3owWSO
         mvwk8AmoI4Pylku9Dp4xj/x3CiLW8xKHaoSnnCI5z5SQXr5JGxX5/t+rOfeNo50PnACh
         98pvnofG4t5TNRULZX3O2zLrGhG6W2qAYNIFDtFEFa7dafttFfSIpRwAukw7rmEmFjT2
         Wh/YWV93ejTDu0cxOJxZ6iKgR4NOnjRyJOynP9freQY70eyYpRaZf7ioDYT2l+pIwhuk
         U7UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706500675; x=1707105475;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DvmPqZ2pCOoetWcGfoB/FaWoKJR0XDZxmCTI8i3VR3Y=;
        b=GUnIrKYeF+aq0hoU7fpF9WSwmLM/NLL89xucBgSBo3mzXqx9j++ZpB4vDJXoNTsTQ3
         jiiCLMdJPxjyOxBZWRyMDOmigiw7KUy0QZANEm7J0CZMWABVYoX7w6Gng4ivB/KYBzUv
         CX0kAM+Bvce48pgHREcRlLh2LLEXXar0yakjnog0WfRx7D30NutxHBmvSzsrnmSd1H3g
         0lpHk6ab2G5jE00NPIkOKHfU6EKOUaneT5sSCZDB5R65Dorl8MeZuYWN4xBciM/hj6X6
         vrONB4TAxFf9QJSQQ40TwgtJo2cOutRjz1CT6GehB5LBBPWaPIHnM4tuXAtgHwql89a3
         WBBw==
X-Gm-Message-State: AOJu0Yyuawycu+5Q1B5/gH3DMwpM1S85V5l5n26TsmNKanmOsi+4HudS
	znyttwn+D6RLimDS74TVne14eK2/8XnaPh54L6s4aq74zuiF0sggiaefKY1Ttlo3hLACOVP83QP
	zXL+EMuVkOllqubdFftAvB3WIkwwnu6JzVQZAgA==
X-Google-Smtp-Source: AGHT+IHHJE7QfYMSAo4pwo06wVe38j/cMyogdzalD6/6Amc2mnF49VZzPcHCZuW12LqprR6B8vjAM2QrCN08H/aME1s=
X-Received: by 2002:a5b:181:0:b0:db5:4ece:ad01 with SMTP id
 r1-20020a5b0181000000b00db54ecead01mr2816423ybl.25.1706500675105; Sun, 28 Jan
 2024 19:57:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240126-lpg-v6-1-f879cecbce69@quicinc.com>
In-Reply-To: <20240126-lpg-v6-1-f879cecbce69@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Mon, 29 Jan 2024 05:57:44 +0200
Message-ID: <CAA8EJpqqn7TPKf+h1U+Jo1wrDgeatUHJ=S4QKtN6n45=k6eSRA@mail.gmail.com>
Subject: Re: [PATCH RESEND v6] arm64: dts: qcom: qcm6490-idp: Add definition
 for three LEDs
To: quic_huliu@quicinc.com
Cc: Andy Gross <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>, 
	Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Fri, 26 Jan 2024 at 04:57, Hui Liu via B4 Relay
<devnull+quic_huliu.quicinc.com@kernel.org> wrote:
>
> From: Hui Liu <quic_huliu@quicinc.com>
>
> Add definition for three LEDs to make sure they can
> be enabled base on QCOM LPG LED driver.
>
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---
> Changes in v6:
> - Updated the seperate LEDs nodes to multi-led setting.
> - Link to v5: https://lore.kernel.org/r/20240115-lpg-v5-1-3c56f77f9cec@quicinc.com
>
> Changes in v5:
> - Rephrased commit text, replaced qcs6490-idp to qcm6490-idp.
> - Removed the unnecessary full.
> - Link to v4: https://lore.kernel.org/r/20240112-lpg-v4-1-c4004026686b@quicinc.com
>
> Changes in v4:
> - Removed "label" definition and added "function" definition.
> - Link to v3: https://lore.kernel.org/r/20231215-lpg-v3-1-4e2db0c6df5f@quicinc.com
>
> Changes in v3:
> - Rephrased commit text and updated the nodes to qcm6490-idp board file.
> - Link to v2: https://lore.kernel.org/all/20231110-qcom_leds-v2-1-3cad1fbbc65a@quicinc.com/
>
> Changes in v2:
> - Rephrased commit text and updated the nodes to board file.
> - Link to v1: https://lore.kernel.org/r/20231108-qcom_leds-v1-1-c3e1c8572cb0@quicinc.com
> ---
>  arch/arm64/boot/dts/qcom/qcm6490-idp.dts | 28 ++++++++++++++++++++++++++++
>  1 file changed, 28 insertions(+)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

