Return-Path: <linux-kernel+bounces-75677-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E63985ED4A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 00:43:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59A3F28268B
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 23:43:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCF7212BEAE;
	Wed, 21 Feb 2024 23:43:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S03UIuqp"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7767D12A16B
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 23:43:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708559018; cv=none; b=HkI9vAHdLKHK/EU73GBpN4gdD9gq2NaIFXI7MyrhcCpnGuqfKjm1Y6afh04wETB/f83ZzX0NMXqnFvbP1T/pWRwacaO+nbqDDRTNAcYpXAbxompqIS6xbnzGfWaaZSsiRHUSGNHYWYqRb7HtXc6PNJDahRups/DGLkPg0J3gLoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708559018; c=relaxed/simple;
	bh=Ocajx83ibWHvbfJ1+CvYXV36LVgL6jeOfiN/sCyB6xI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b+wd5SjjiDto5nLPUPBnZ3ZKMTHVISOVkOK99r9SggD2O/Gmdto94LiUc2x3y5ParZo4YIhfabYOS+l8NnG4jBfJmyVZgHRPXzGINUl1Z3tFo6y5ezWDEdaqpy12w1CL1RPbrAD+n6k6/trMPxQWkCXr2gS+bql8P9fpVqCmamk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=S03UIuqp; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-60879e3e3ccso12670577b3.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 15:43:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708559015; x=1709163815; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=TeKcSZmt65tsmCjLBYpPtTH5m7PahVEvnN3gp1BBP6k=;
        b=S03UIuqpIiys+dttCDJwkezY4STNjI17OplyJisLJsOPfD/bTMpbJ34N2Ly8aMvO36
         3vNPNAtUd0f0hjdyMWDmWPOV9x2DNvAFjlgmyzd2plJ2F7Y1l2OVgK+YvmtU2Nf/lJNa
         6BbNmUF2kN2OitsZPv8OnK8rA+KD3LeU9w6L0VdH57neIBi0zjYkvFHUWNlDFtgQSwHN
         xwh/ovmHoeuM7OGkWu3+brjAca2PdRo7cbnomTzUtoaanO8RfPpM5I85vYJ7ZQyK+CHN
         QkNSYhkoqCi9yDOxW+Kf76wxo9hufAu8jryrbJvjWct2tlG0K19K+gP1XsmMAOXDCj/x
         f8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708559015; x=1709163815;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TeKcSZmt65tsmCjLBYpPtTH5m7PahVEvnN3gp1BBP6k=;
        b=cfyRHtJESisQw4DkfrLfd8MuVN9RI/EzkgXdx21jMY3q382m12o/yzT1JnxBN70vy4
         yvRts9/8bfAzbMSZ4Y3F1Jcha/8AOA1UZWV3JPkBl4lnyF3J8+MpNWBjbxW7qiD4uv0T
         1a70OY4q6CUbcVF0oBy4Ts6yBUM6Xz9cjO/9FIIcHVt/No4t4CjsQ69bikAQ5FuEq7Ly
         mgGIvn983UqIoWP5yirHlT/7nPMG/PbC5VUyPoc2z4Q86n4nlZKO12Grb5yF5I9lWX7a
         5ZHxW70eCzAIMP4p5SN83si/OGKwQ8hEi2blVfaheEJ0lt1FkfPf9G0/xLd/KnEojgOM
         lA7w==
X-Forwarded-Encrypted: i=1; AJvYcCUCqLu/3LY55Ystfg3Bx7/0LvEROcgCryM9PxE9FdQOB7Y8V2L48o/X7UCNEa2iteSdTsAdIOVEKNl4l+IyV+ucQ4awJTLGcpSiGT/C
X-Gm-Message-State: AOJu0Yx7gHBzC752WWbrD0JZJeW+pMuudaFwtExFgKTqh1MJxqjbV75t
	ACHTzhcpbhORpfZMCsbuCfHXE9uEDnE2mrG2PAPnAXoR76fT/Qp3TvPXxTgrs8uqa6Vz9CHE1YG
	a1fv6epVYOG9i17TllQOWY2u+Ocq8WcnXsnVbTFbxlv9rkfl1Tqc=
X-Google-Smtp-Source: AGHT+IG23RX3mHSoDqoErDFyzvZxTP87XzpGlNSEMdnMYBP/pD9KffhOLUtQrxf/OysVvdyJWsXBSnZq8SFvxdWTc9E=
X-Received: by 2002:a81:7e47:0:b0:604:9232:9df with SMTP id
 p7-20020a817e47000000b00604923209dfmr18226833ywn.50.1708559015381; Wed, 21
 Feb 2024 15:43:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240221-rb3gen2-dp-connector-v1-0-dc0964ef7d96@quicinc.com> <20240221-rb3gen2-dp-connector-v1-9-dc0964ef7d96@quicinc.com>
In-Reply-To: <20240221-rb3gen2-dp-connector-v1-9-dc0964ef7d96@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 22 Feb 2024 01:43:24 +0200
Message-ID: <CAA8EJpq7yhbyoJHsRxdek=3XJ154nt+e5OLAE9ucPV5p-FOrEA@mail.gmail.com>
Subject: Re: [PATCH 9/9] arm64: defconfig: Enable sc7280 display and gpu clock controllers
To: Bjorn Andersson <quic_bjorande@quicinc.com>
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, cros-qcom-dts-watchers@chromium.org, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
	Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org, 
	dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 22 Feb 2024 at 01:19, Bjorn Andersson <quic_bjorande@quicinc.com> wrote:
>
> Enable the SC7280 display and gpu clock controllers to enable display
> support on the QCS6490 RB3gen2.
>
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  arch/arm64/configs/defconfig | 2 ++
>  1 file changed, 2 insertions(+)
>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>


-- 
With best wishes
Dmitry

