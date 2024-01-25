Return-Path: <linux-kernel+bounces-38644-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFD083C396
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:26:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA771C230CA
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:26:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0880250242;
	Thu, 25 Jan 2024 13:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="c6tC7PP7"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030B94F89A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:26:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706189174; cv=none; b=JOKthADVNoAYWPp6m+iVgQGR+1PnaT0h/JhIJXS3MF9JIMHAaDu16suy2NEXy7cdyHndMeqLxSaJTnSA7fZA39tWjMipqQFgw2auGd/G0B44WmYCvdGMcJNmUL8xol8Q5RSD2xkCwrZZnIGXOLZB5BRUuMQif/KPBlUNgvLh/Ac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706189174; c=relaxed/simple;
	bh=OdEnES3N2mwllexWqQO9ngtOXv9U9R5XkdDBtoztrUI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=D+qwpNNprizWdlycg6/qVRSlAleSFSRMZBlP5E1TE1gPHzAp1Ymp+eADhRgAPIUoMiN+9MSwBpnW8ViwmBZqIGUHa3bFYZFurKk2oIo45OQ8yiWmoYUpJaimr/bujvAEQkyMsza18NP6bPytPft0Bd0JGre+VIfD0WbINlDPRq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=c6tC7PP7; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-db3a09e96daso5914620276.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 05:26:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706189172; x=1706793972; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qD1ZKWE0B9mPlYYZai7EguRVWmOqxII0xx7XOFkWAvA=;
        b=c6tC7PP70AgRMIeyqpLR7YYjfpVeryL4Kngj2RozYNUgX/e4q61Jn6wVHXf1HK7jUr
         LaZrhlZYlQsCg5r9mLCkZuBeQLIB2VYOyeCGl5luonGMeRI5z/JfdcDiGF7Ty6rKl/Tu
         nze57boxpe1RBq8yBjPcFxxXV+l7BVM6zy0/kp62KN3v8W/X4FN7OVQw3vY3sTmI5u8S
         cZ0zdzel5eCqoAVu2XTl2FXZ0AmAKsB6uRZmld7YpZ36OYo5U2x0Rj/HoFL9uwvVhVLL
         3derQGcx5NF9hi0fvgAxWh8RBqKbGgrDl/zXXp8H8HQt03+WMQTeJF8j8ZibHQkx1xKW
         kWCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706189172; x=1706793972;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qD1ZKWE0B9mPlYYZai7EguRVWmOqxII0xx7XOFkWAvA=;
        b=HD+GRGiRtgkv6NW4AsZzI9t5hc9BwzipHgf/7EzIGDjYVKNosIzZGYuUV8G4t32hWx
         ltqaz04oBTfbgRaUww6konLXEClAZsDeqo9v1RuhokF8iRQb9+bSsh5Z8iIn61igu66L
         dJbwBn/nFPmSnoXIHXT01YwBesW6JZ5kL2rDrc0GaaZOhsuzZdOew1yNHYSrQP3tLaBB
         E/UC8J17uWshKkzLL9tjSic7cc2JeXFIHvKyUSj6p0QJLR1aWYRSmOEKFAxVLcUA/czs
         S5fIZtWTXSqlStuBe/Ba9aAU7GcQ9uPRWFq4KULCOa4dbhCn41Q04+O6p1Dzg/WmJPUY
         c2IA==
X-Gm-Message-State: AOJu0Yy4Dl3jY3cQz1LBG5xnnORIszh6WyycwCtGXXrxtX4u0rBOdjQc
	Nmjm4ShLdouAlRSt9xxbgkH7H4Jpfn3GYYBxGhJKDFJ0xajrXzyveRU2BuNeuNQGYaQMfIqElbf
	Iyqx1CHKkIaN6HqsosLH3xe9gTmHEuKSfJjKe/Q==
X-Google-Smtp-Source: AGHT+IFe89d6zyjO+YVRArNJDGtlX2xvQWPn8+Np5QJNilc4XliEI6Sh9RXsgvzDuDIT6vKU4P54YP3WHrkAxW9tJO4=
X-Received: by 2002:a5b:f41:0:b0:dbd:b105:3a49 with SMTP id
 y1-20020a5b0f41000000b00dbdb1053a49mr643374ybr.91.1706189171975; Thu, 25 Jan
 2024 05:26:11 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125130626.390850-1-krzysztof.kozlowski@linaro.org> <20240125130626.390850-5-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240125130626.390850-5-krzysztof.kozlowski@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 25 Jan 2024 15:26:01 +0200
Message-ID: <CAA8EJpouB7MevdAagJe6QH_D2NRxBZ-88PFYpZF5fieapoRdJQ@mail.gmail.com>
Subject: Re: [PATCH 5/6] arm64: dts: qcom: sm8550: describe all PCI MSI interrupts
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
>  arch/arm64/boot/dts/qcom/sm8550.dtsi | 24 ++++++++++++++++++++----
>  1 file changed, 20 insertions(+), 4 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

