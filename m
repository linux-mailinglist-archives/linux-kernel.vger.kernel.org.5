Return-Path: <linux-kernel+bounces-38637-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2747183C382
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:20:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C2341C2376E
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C86874F885;
	Thu, 25 Jan 2024 13:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OV4eAlWQ"
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E07C4F88D
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706188831; cv=none; b=cIbQfVmxKd+bAmVSy9E1UNWWIkYAqLVVdmrSzctlt7InQM0jacEGEmgntXpNRmkY8JzwpfQvOFnrAAT1zw8P4IQv8kAtRgKeupYKwoeoYXcdnKaPeuDpOslLv2fho2/qKQ4aW8wnBCleVHY1Z996x1CPVHTYdDkMNSupeAmvFuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706188831; c=relaxed/simple;
	bh=2CXZJyrp6iFAL52EdLsPOSjvjlG8Sc9qL+jXy8nmaq4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RlRnsLnmtVUGgWlNvUQWPEm0BIun5B1Ugp7ZD9BnEax/nL+xO6sjytq5+jlmH5cAUGdzTR9abon+BRIlsDqJZ1am3kMA+oKrCoegBBBLsyIGnimc2aqotYchf71+u2dClMThgkfFJb1P6305V2S6TRgGQtDjZW18qptmCrh+jNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OV4eAlWQ; arc=none smtp.client-ip=209.85.128.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-60032f9e510so25709827b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706188828; x=1706793628; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/tDYjrG3ipq52LMTw0BWl8QpdFX3vh/NkpzYZn5kvI8=;
        b=OV4eAlWQtnnpl+44dPi7J6QmE0pbkfGrn7za1dLXjbgkcDzEu4iLouie/1ThplPUK9
         c+suiAtBjb/GgjUR04CdzfT/Ao1hjAzEwPRHa4qNUFKDxi87FH5J/t6hMnJAbn5O7Tns
         cAbqLnAZg0SXujqWlRS/XsuAiB3HtdRQjxV7FDsDcy7oHrtbM93EFnBDK01bWcnsAtv8
         idJLEJ6Gjctl4wVM8Mv0V2/2uDTHIIlqfjzqCin6NCfq2Nf09TAH2/XHIUEf552NryN9
         /oyBWWNfl78+7h983jB1+WmNM+TV4eIdfJlVdVVFFAPlHvGHN0SOhvgETLPog0Scz2Is
         s/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706188828; x=1706793628;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/tDYjrG3ipq52LMTw0BWl8QpdFX3vh/NkpzYZn5kvI8=;
        b=LiY3YHXgf6QjkwHB6UYr1ddqVzEMm8pI8kf2nTwrDNCMVj8yBkX7GEfoPCB/msdB4g
         5v79q9hfiPipUAAApXH0i6tjrgxRkhrGjSjuq80p/DasMLwB93O60gWN0NLtP0qrDL08
         7w5Buvo9AmbjVnUfBqguju0kU1ZQNjt0qt2Xg5K4vDLgtfIi6Il5ob4xUV+7AEZWQ3pt
         90VpJIbUwUi2MHuDjHOIy5uY/uRXyd36mGBxRO5m/Wvd9wcCNdMMJYEKdeJVo0IOU+3g
         eYeiAaHAcqyBlWilieQUDY0LHffRDdL6qgu5hLW425IxBMyi81jBXjoW4DQt7OeE+nfS
         WJ6A==
X-Gm-Message-State: AOJu0YxEwgluy3ewEoFc12GgFjOtK7r5vc4owxK6szapufBpVigkYMkH
	xvNjY5T5SHOr2gRcfiYHjvw/xSzPNiykaqKIJSJI1+WePhw2n8Azre8Rj9SOkT+Gajf4Ug9EISD
	k+W7xIle/jnhWCKkNFlrc/mNciwijvToi9VG/pg==
X-Google-Smtp-Source: AGHT+IE/kKFnSV92jQGZrCw/siQiblRmVM3ZbROR/NC3wHXCuWovvQn3XOanm79yGEAm93sv5KHZUGzXEC/l5zgL8n4=
X-Received: by 2002:a81:b65b:0:b0:5ff:7dd8:2b4f with SMTP id
 h27-20020a81b65b000000b005ff7dd82b4fmr592216ywk.94.1706188828076; Thu, 25 Jan
 2024 05:20:28 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125130626.390850-1-krzysztof.kozlowski@linaro.org> <20240125130626.390850-3-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240125130626.390850-3-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Jan 2024 15:20:17 +0200
Message-ID: <CAA8EJpqazduHm1DYwGDLjDupRgLXpP+oJXfpwpVfSnBBeTC+5Q@mail.gmail.com>
Subject: Re: [PATCH 3/6] arm64: dts: qcom: sm8350: describe all PCI MSI interrupts
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 15:07, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Each group of MSI interrupts is mapped to the separate host interrupt.
> Describe each of interrupts in the device tree for PCIe hosts.  Not
> tested on hardware.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8350.dtsi | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

