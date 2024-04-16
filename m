Return-Path: <linux-kernel+bounces-146804-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8572D8A6B3A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 14:37:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B56EE1C20FD0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 12:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 425201804A;
	Tue, 16 Apr 2024 12:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cKMYswuQ"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965AF5B682
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 12:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713271070; cv=none; b=RlO3vZk03V6FmadnAx65j8lcmk4nvknt9UaqiK55B062JemaslaDe9/CrTvtchNkeRyg7INft0WdJT+5SJPo29QBRs72e4sVbJZphaZW6o3Kcngs92HlAC9AIe4gkxl0wGZA1NacEmfEyicSajrmCC6FZSohCFskMSFkRPHLx+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713271070; c=relaxed/simple;
	bh=4LJ6HXrr7/zGMxHWwNvwLQ04Lnb+7C3+Akuq4JYINEo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YIfZCDJV8VTzbZdCAiKHyVeRtwMI6Y9BrmkQ9z/LLINUwKrC8Zm6+z4bmdiWibL4K/ltHL6rQRpRvDpN+GOiLwjRys28X7J8MZfjcaIhkxInTGMpmMeFaENUw/9f9uOL6NHhk/08Ahm+gf5oDkZrZKAD9C7msqcAlXeAAYIDDFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cKMYswuQ; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-617ddc988f5so49930777b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 05:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713271066; x=1713875866; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=STIdOPhZdYvo112wyFBuLZo9s9LDl2Qu/p6eL5RFdqw=;
        b=cKMYswuQgZEgwzR1koQDAyGsBxb4EB1KCyuqReRXmBwa8wYQ6+2R5KXqrddpRIAQ4c
         F4X0bJV1fZpuJk6pC1cO94UZthvSZX57xXRumPWhbfNILLAuMqVHmydrcrFYd5TZDqoL
         cqi1vNDCzJCFGaSOkJvtlkZG9AYDKA9FMWCrGnLWhP3HTS5L4yCp3IjNeHaQQDL3+Jt0
         nDdH3WWMAArezeNHY+lgIXXvTJB+1/GHBfzKZVtDUI8MPQDrx3CfRiMOmu6Qd8uK2XCu
         WbTYHmEAHRaVtJzh63a+QycwcfwHIappfO08eFJN5RelCIG6ndgcGuDgc3HzLj5EGgoq
         L3Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713271066; x=1713875866;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=STIdOPhZdYvo112wyFBuLZo9s9LDl2Qu/p6eL5RFdqw=;
        b=eshNa60HEg73nRP25yb55b70ZNckpgK1UvSu6vqMHAdmKq+3NvPFENh8do+Ahf9ARY
         B8uWzDSijwPka0Ud5r5aEWWIqVMmwQeklPqrABveDoIDIL6Ff1bp5gE9UQwNOZ9bL2b0
         t9XUBQMjX9AWND/Aqn0gSMVGKOwDXr1q12B28/X56xr77AR2ppNFQEaCZpzZG+tx5AJj
         jbWwA3OWGjTaDXG7OT7oOzqEvGZSeXXDFwy2aCJlinlYoVPcR4Lny+ue1WXnyPrdh4m8
         rxGk5JGZFUrvF+dSmB/hhexNSeY7/xxepARZ6zpARCxFRO6gBQS/wBQBInsAsDh8E0rC
         TXQw==
X-Forwarded-Encrypted: i=1; AJvYcCXbCtNW8p2HkGr+fyT0n6YhQw7ns8gRIwB4Dh2DQManyd9ytP00J6Gi8FU6XmHpcj4UsqS7JGZTJz++ta0hgWiKmT5Ok6Yn4ZZdbTmy
X-Gm-Message-State: AOJu0YwuRackW4Cjs8+3MOBwRt3MrTFc6QkSK+koMmbx2Om+kMdDhCx2
	y/ZZXkC+jruimf/rLfbGx0myLyXGrjCJDLRIPEsDPOAo3pc7ZJTIbgzNDIk4DgZWTY7OnstyeK4
	Yf6m+OHwVlGmXbdbEUMmEUU8GF8NfT8wjpT0LkQ==
X-Google-Smtp-Source: AGHT+IFeOA4awc8p/M3BUkgYhbJYeLw7xEDVGKxA6dOrgdfoPaGNeyp56yT+LyP9EbyhGTUoUXAgTBz2Xy3BL/MSook=
X-Received: by 2002:a5b:186:0:b0:dcd:4d:d342 with SMTP id r6-20020a5b0186000000b00dcd004dd342mr10998368ybl.50.1713271065794;
 Tue, 16 Apr 2024 05:37:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240416-pm8xxx-vibrator-new-design-v11-0-7b1c951e1515@quicinc.com>
 <20240416-pm8xxx-vibrator-new-design-v11-1-7b1c951e1515@quicinc.com>
In-Reply-To: <20240416-pm8xxx-vibrator-new-design-v11-1-7b1c951e1515@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Tue, 16 Apr 2024 15:37:35 +0300
Message-ID: <CAA8EJpr0wV-Fgyyf7tQ-HheYPNmDvCkj4vWL-9rd=gmXrAXOMw@mail.gmail.com>
Subject: Re: [PATCH v11 1/3] input: pm8xxx-vibrator: refactor to support new
 SPMI vibrator
To: quic_fenglinw@quicinc.com
Cc: kernel@quicinc.com, Andy Gross <agross@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, linux-arm-msm@vger.kernel.org, 
	linux-input@vger.kernel.org, linux-kernel@vger.kernel.org, 
	devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Tue, 16 Apr 2024 at 05:44, Fenglin Wu via B4 Relay
<devnull+quic_fenglinw.quicinc.com@kernel.org> wrote:
>
> From: Fenglin Wu <quic_fenglinw@quicinc.com>
>
> Currently, vibrator control register addresses are hard coded,
> including the base address and offsets, it's not flexible to
> support new SPMI vibrator module which is usually included in
> different PMICs with different base address. Refactor it by using
> the base address defined in devicetree.
>
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  drivers/input/misc/pm8xxx-vibrator.c | 41 ++++++++++++++++++++++--------------
>  1 file changed, 25 insertions(+), 16 deletions(-)
>

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry

