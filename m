Return-Path: <linux-kernel+bounces-66550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D5C4855E41
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:33:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28A2EB324EE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:33:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A11217C61;
	Thu, 15 Feb 2024 09:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BhTmjOIQ"
Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6947EDDA5
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 09:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707989544; cv=none; b=PpEIgZ/TowZTvkVSkVbYT/t0s1MI+SIC2TSvlCbDeCoIL1NWeuOvm+plW4q1nt2EBVTEPGjbsgoDmyQXJPmkdR9d7pSfySxW65vL3SkSGrBQq2t7ZGYNS66rasvUj6dMEUo5MkZHXF/jWTw7XDLeB2PSadLp9DWCNZ17bHW+jzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707989544; c=relaxed/simple;
	bh=t8fjnbGI5gCrFfnFsadlQGU4sXRofYXA6zNJI24MqTw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cozsx5cupn5qZZHTNltdBuYeX3DvO9/lDyfjhmOMz770TpyEs/9jsEe4Xu/4uBBP2HYwVaqfQQsGQs7Ur/Bp+E3dDgmqyeG6OKpTkEm+ebj7a6KYjK5qCygoDO21SdpzeSmYUeYsw3z3byNpI5khRHMbhqd/JtIhs3QCQr0RJFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=BhTmjOIQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-dcbef31a9dbso426842276.1
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 01:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707989541; x=1708594341; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xhsL/cUAT42+vhfZnH+MnscoqoxI62SZOZMcf2180Ao=;
        b=BhTmjOIQCLkZdId60uaR6cEW8Lj2t9+jOOCJ0tj43srt+SyBfBc76ASRp80I2vJP9l
         8GmEBVCwP5fFKDa4+pZw9fQIIXEezxinoRkq5OuW/8NrkZWCER1JXCu0V5A5qwutvjUl
         /l8ZR4CfN5XZtaYpP95gGBGZzLB2TpMZmtEArns1V1eg1iX8fLuGtmNBWU962cTUu/6v
         YQvm7HuXneV9dJYEjUGiRsVMGtbz7RHoAVx3SYrlXlAN7vzVoHGXBpHL3ITyabsJF8qq
         D7slb8ZjwczuiJNOzBQisdqQK8Ad4Et0Lra1I0zmuAq/mCeiMNdCtC2qITbJpE6qtIj/
         hUsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707989541; x=1708594341;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xhsL/cUAT42+vhfZnH+MnscoqoxI62SZOZMcf2180Ao=;
        b=LUIRnG/53bvk9v91K3vXJCTm3F9B9CpqAKzfq6yZgv4ui2ZFgvTLlEuHswHnx84NqV
         hMqqyNNfDmLa0XcSoikXEzLg+GhfSa5ghTHNxlDJOnwhtHSVZpXc7WXC6bwGAfk1YnbK
         3mXspnLTxqfUbi5iZdaXSQE7AFJ4ojt3dtS7eAM0lzaosJfObJ5rMHQ8SxVa6xY45y1J
         KkAQezOd5FiYeHsfYc1JyRfQwsXPqmMIjh9k0U3DridlbwqDikfsQ7UiWJA7LtNZnGKN
         dcZcy0dSCl8plBiB2bu6gyUGb3/b4SK3ON7/MZwoSXf3Uy8IcZ9n+tR1C4t+5RA3IptJ
         kMrw==
X-Forwarded-Encrypted: i=1; AJvYcCWvxXBRkOTR7u085J+N4jt2W5Y45DkWgn5dO4ktmM3vaL7WqpLNCgTnW0bE/pqTKhv/qKX21OrQi5kSWAU2aQEQ/+x6VvwPHZZjJlab
X-Gm-Message-State: AOJu0YxSAq7afD+iFzd9lGuW+Ru/5ODfiTfqT8Pe2pFAGwyIhx84R+EN
	gUEUBDvyC+NjTZqUc58w8jEryJ7AyaKRdR/DdlvEo37X6h/cYF+hOrHjd7AZAEfj33RtEi5p2fz
	hVkPLRAekdVgn1o7Ny+3cL/YBLxZXeMYXEY8MTA==
X-Google-Smtp-Source: AGHT+IGo2HcfVD2s8rsl4Q6UKE4zYlvCOdCjsO2WiOwy9pC6rfEmy2MtkOAphVrWtXxWh32cSnZlcfv9SsjiJWqGlD8=
X-Received: by 2002:a25:d68b:0:b0:dc6:aed5:718a with SMTP id
 n133-20020a25d68b000000b00dc6aed5718amr968831ybg.26.1707989541228; Thu, 15
 Feb 2024 01:32:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240215-topic-sm8650-gpu-v2-0-6be0b4bf2e09@linaro.org>
 <20240215-topic-sm8650-gpu-v2-2-6be0b4bf2e09@linaro.org> <CAA8EJprpYEhGi5b+uWGWtOa+qbSwUR8C0j9NLC+ah_-nvy-=Ng@mail.gmail.com>
 <ffb16ef6-fc9a-42b1-b9c3-4e8f6b52d849@linaro.org>
In-Reply-To: <ffb16ef6-fc9a-42b1-b9c3-4e8f6b52d849@linaro.org>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date: Thu, 15 Feb 2024 11:32:10 +0200
Message-ID: <CAA8EJpobWYu8LoHZarOw82z78=kLJrKH0P4ncK6sX7zE1nHuqQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] dt-bindings: arm-smmu: Document SM8650 GPU SMMU
To: neil.armstrong@linaro.org
Cc: Rob Clark <robdclark@gmail.com>, Abhinav Kumar <quic_abhinavk@quicinc.com>, 
	Sean Paul <sean@poorly.run>, Marijn Suijten <marijn.suijten@somainline.org>, 
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>, 
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
	Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>, 
	Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>, Joerg Roedel <joro@8bytes.org>, 
	Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>, 
	linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	freedreno@lists.freedesktop.org, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	iommu@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Thu, 15 Feb 2024 at 11:29, Neil Armstrong <neil.armstrong@linaro.org> wrote:
>
> On 15/02/2024 10:25, Dmitry Baryshkov wrote:
> > On Thu, 15 Feb 2024 at 11:20, Neil Armstrong <neil.armstrong@linaro.org> wrote:
> >>
> >> Document the GPU SMMU found on the SM8650 platform.
> >>
> >> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> >> ---
> >>   Documentation/devicetree/bindings/iommu/arm,smmu.yaml | 7 +++++--
> >>   1 file changed, 5 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> index a4042ae24770..3ad5c850f3bf 100644
> >> --- a/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> +++ b/Documentation/devicetree/bindings/iommu/arm,smmu.yaml
> >> @@ -93,6 +93,7 @@ properties:
> >>                 - qcom,sm8350-smmu-500
> >>                 - qcom,sm8450-smmu-500
> >>                 - qcom,sm8550-smmu-500
> >> +              - qcom,sm8650-smmu-500
> >>             - const: qcom,adreno-smmu
> >>             - const: qcom,smmu-500
> >>             - const: arm,mmu-500
> >> @@ -508,7 +509,10 @@ allOf:
> >>     - if:
> >>         properties:
> >>           compatible:
> >> -          const: qcom,sm8550-smmu-500
> >> +          contains:
> >> +            enum:
> >> +              - qcom,sm8550-smmu-500
> >> +              - qcom,sm8650-smmu-500
> >
> > Doesn't this cause warnings for non-GPU SMMU on this platform?
>
> No because it doesn't add those to required, it simply allows clock the properties.

Can we further constrain this branch so that it is applicable only to
the Adreno SMMUs (and enforce requirement)? And maybe constrain the
second if-branch so that it doesn't apply to the Adreno SMMUs?

>
> >
> >>       then:
> >>         properties:
> >>           clock-names:
> >> @@ -544,7 +548,6 @@ allOf:
> >>                 - qcom,sdx65-smmu-500
> >>                 - qcom,sm6350-smmu-500
> >>                 - qcom,sm6375-smmu-500
> >> -              - qcom,sm8650-smmu-500
> >>                 - qcom,x1e80100-smmu-500
> >>       then:
> >>         properties:
> >>
> >> --
> >> 2.34.1
> >>
> >
> >
>


-- 
With best wishes
Dmitry

