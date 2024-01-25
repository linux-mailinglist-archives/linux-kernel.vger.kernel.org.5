Return-Path: <linux-kernel+bounces-38641-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 86F8283C38B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F3C21C2371B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:24:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04E034F8B1;
	Thu, 25 Jan 2024 13:23:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lBQOarpj"
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D414C4F209
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:23:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189036; cv=none; b=MLemJXKtdoDK1i2fQNKT3l+Jr9rpJbste8aB2wiGJf0BzInRSSnAnO9keVflm5I1j3D+zvR0if/p63D8dk7m04gE1qSEZCRyF/Q4PC4DHuSUS9ZuuoYQ56+pK1Cvn9rK8laQZZ+ebKExTRJa9+mdbBSne/wxhfnTp14lvBcDw8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189036; c=relaxed/simple;
	bh=9slEGncr5sZ2i+sO83m3sEyUhFhOGIiWij0i1fDgPT4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WTFbWXteyxqzR4wHvjWZc/O1gLym//ER/rqnrb+qdMe+8y1GU9wqItlDl/mF4yILR5OkscJRHXZFbSmqcddVNqhk7vMODduL1KrFR3ZOkiar4GmfvWx+Jh5y2VYObZKKZzr76GRBoNQdcAb9GlHpsSzuMCeB6b1icCZjcYBoz3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=lBQOarpj; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-5ff7dd8d7ceso59744807b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706189034; x=1706793834; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SKIQmJv3IRL1HN1k5v1jdt5ZpUKF/3uDhIJJ9D50Mw0=;
        b=lBQOarpjyA1FJnCIE0Z18AoNBqAJmpqliteXzsHIPPC+64kiHBhwqXNrHQESWUb2SX
         W9k9XEikVoyH9WFgNMAr76vSnwcfneJ2aQTo+RPv/dMDed5C+ziFRjUoXisqK5hWX6qr
         b8qYWAZU8T560VNM1Q2C3YFcr9jqt8H0pmiTpzvb70s++c08l4yT4iI4j8GVRHlkreNz
         SgP6ysDXjiY25TzGQfopvwWVJT2AsEohNUVZBTrb1mz2KWDyYSIlueYOxqsxgofdnKUR
         gVUWnKtU3m5yb0xoESXhe97kLM/A+wrq1yFchSYAv9DItTd88RRFvkCYLg/s3ku/HDHp
         KafA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706189034; x=1706793834;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SKIQmJv3IRL1HN1k5v1jdt5ZpUKF/3uDhIJJ9D50Mw0=;
        b=OH5mhTfJsK1gI6qe3U6eFO/VKaMq6Drx23HHZnbkmXn+1P6Axw8p7d50BWxIzqgQck
         Cf+CnoOm1wj7fenXpB33DmGpVH8ab+5+ORQNNdbfnt+7f+n5RP+93rlCCr2X+gTLpWeC
         wOSH7s66/JNysBGUO+L9mjJyCP5Ouu9F1/+ECG4kRC0m2OaP4g4o6LMpAiQSteOnz8GR
         FbMVkxZ3Q8FJZXDgKjIHuz6evjceD3csbpC1eNfOizbtq7nCfXPtZ4oAC1RPsLDuCnQo
         4Xk9j+pB2wX7oyRMzEX1/NUvcLqNQPSSivDeBasiTN3W8ZX71I+YzTs8ELJw5JzZ1WWm
         ZsXg==
X-Gm-Message-State: AOJu0Yy7FHjDu8VIBdXTUJhDvGG+1pQRqmSb/GsEJRA+TyIZiE/lEIkz
	KUpkzovpakfpbCvrZ/DsqG0fmLCWNOiU7667X7p1WwXh+uWMzn6EbPGtzgEOysn+YuPxt+QpnCt
	R0ruYDlfoLMM6g2u+EKnGPdZUHB4jmcN//GoJOQ==
X-Google-Smtp-Source: AGHT+IGHbJyy+W+hk2nttEPhM/r+2iuDN2cokkfPGX1Gz3cB4l5gZ9pEXayzRvDCgHB/mdI4i0pwoIKX4YkikR4KGNE=
X-Received: by 2002:a81:ad4a:0:b0:5ff:4842:9ea6 with SMTP id
 l10-20020a81ad4a000000b005ff48429ea6mr664617ywk.47.1706189033971; Thu, 25 Jan
 2024 05:23:53 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125130626.390850-1-krzysztof.kozlowski@linaro.org> <20240125130626.390850-4-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240125130626.390850-4-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Jan 2024 15:23:43 +0200
Message-ID: <CAA8EJpo_GUgfYZOgmbCyhO0Oe=RRC0+LP2kZTbSV5wHob4X8=Q@mail.gmail.com>
Subject: Re: [PATCH 4/6] arm64: dts: qcom: sm8450: describe all PCI MSI interrupts
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Jan 2024 at 15:08, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> Each group of MSI interrupts is mapped to the separate host interrupt.
> Describe each of interrupts in the device tree for PCIe hosts.  Only
> boot tested on hardware.
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>  arch/arm64/boot/dts/qcom/sm8450.dtsi | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

