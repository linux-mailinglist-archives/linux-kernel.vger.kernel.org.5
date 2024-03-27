Return-Path: <linux-kernel+bounces-121897-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BF02088EF1E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:24:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D44221C2DEA2
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EACA7152188;
	Wed, 27 Mar 2024 19:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hDCd2SW8"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 676BE14F116
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711567438; cv=none; b=t4dyLvGyO3TdcDMkqHP7N2y0qECwUPn5rAxT+EGP1F7CInIhja5Udm0sjQwlIqZqunJOvwq2b526xRh1Jsg3sj8SVI9/KWiAYCjE6/3BDIJEm3vk+ejV08wzSs7ErBg+pM98Mhs9xEPsMlHQflddHk97vm2O7CHLeAHU7N+veRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711567438; c=relaxed/simple;
	bh=vjEvrisXs0PaTIn6yTzeC7Qp/wJlnRMLb5/DytcPMgc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AlmUqpMEGVI1qSfZ0/f52dLTnVzxskRHt+NARRH4ZS0HGKCUxUSCbERAauVCqn+vU5muNXSGoLHjTjQ4m1ZFsveMvM0u9oskaM9pXV/kPr8kNkRmgPz1lFJ8n8wfYsWiR0AsyUwa+YQrwN8NHPHqNvvtitGBS/nUf06u1t0UhMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hDCd2SW8; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a4a393b699fso36942466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:23:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711567435; x=1712172235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mXh1hk1oPeStdknju80ZXZITRIxNJc+CZyjjCVnDwcI=;
        b=hDCd2SW8RocW5ld/peH5sWY8+9uXr0ghFmYZGSbbpz0buZLbez2FHtgDBokIgtRHn1
         zXv/KXedRrpdyiSJLHVjLO++iARqaQ4hVaOxXDsYqN/rt7yAJvyrfejFWQkoVivTZWWV
         x/CG71f1IuU/gTFYj251Tn/eDg+JWnScrrJXx9WU7Ey7KvZr4F4N1jYMkR3XhdoxKPCT
         2ewg9YEwFPBPYhu6dRAOaK2ZjmBL02AMS2wuMyWFmLkG3A+f3sAbJQZSPaQ3zu6nPFQn
         1nB7UAXkPXCIJfyV//o8wo+OKyBoTADKRGDCqkZhaYsV7Ztxe3unOzenhf31XLrOXpmH
         KhTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711567435; x=1712172235;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mXh1hk1oPeStdknju80ZXZITRIxNJc+CZyjjCVnDwcI=;
        b=FW3hwaq8RObw4psUJm9eCYDOVvrNqS4pRYyKOoKnlsJlFU/gm5MuwE3chRHGy9/G/m
         FCTFBVr5TLvcgsl3VSkMkm4/bLDvTs3jflGFKPizxmiOyk33qa1mevPXUK+wZ6vhevUG
         dMg3P5eEQqf+F0O9boP1AqkAZF1AOYzvE2xifoP6Ze1ABI+xW/rZTZkoT5XwObkPwJU+
         Qs9f2YQev2LqCDkPl0RfWZDTyF5r8+CWXdHIlVDEL2aFxgs+fCd/obfBzyLYCofCCLhu
         HGUNWRAdkIh99OUaX8Ftk9FBc3T55b4ztYZmv/WSqy52oMRrQowKDXrfZFsYblbuC4Mq
         7XIg==
X-Forwarded-Encrypted: i=1; AJvYcCWXY7mwgBrKKXJC4oyEdgS4ZhfACobomqMRjp/faYNz0r8cr900H21O6i2LddZsSJd+qk3rsRa9mthl1mxVvgPDqYmvXGWs+PTf4WjC
X-Gm-Message-State: AOJu0YzI+m1NfUh5LxCuHp4iCvpBd1Gb7+el4RK50cLU0QZWNzlZ094h
	BpAs7Qh3xMMikHdKjXRuzVrok43CxKv361mOYDgGymHJlv2NNIIIeD8gP7CkW3Q=
X-Google-Smtp-Source: AGHT+IGWWBaCyjo8hryoRHrSa9yjNZ26cymjZzL1fb8Jp2J2Fo3NE7EzwYtjC5Qmh4YUteTcnyJNDQ==
X-Received: by 2002:a17:906:57c7:b0:a47:3cd5:b3f1 with SMTP id u7-20020a17090657c700b00a473cd5b3f1mr182772ejr.35.1711567434658;
        Wed, 27 Mar 2024 12:23:54 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b00a47459e7371sm5425614ejb.79.2024.03.27.12.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 12:23:54 -0700 (PDT)
Message-ID: <65669ccc-3d95-496f-aa82-4ecbf4c11290@linaro.org>
Date: Wed, 27 Mar 2024 20:23:51 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: iommu: arm,smmu-v3: Add SC8280XP
 compatible
To: Robin Murphy <robin.murphy@arm.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Will Deacon <will@kernel.org>,
 Joerg Roedel <joro@8bytes.org>, Rob Herring <robh@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 iommu@lists.linux.dev, Johan Hovold <johan+linaro@kernel.org>
References: <20231219-topic-8280_smmuv3-v2-0-c67bd3226687@linaro.org>
 <20231219-topic-8280_smmuv3-v2-1-c67bd3226687@linaro.org>
 <9b2a681e-1191-4cf7-8da7-14aa2c1fa455@arm.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <9b2a681e-1191-4cf7-8da7-14aa2c1fa455@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19.03.2024 2:53 PM, Robin Murphy wrote:
> On 2024-03-09 1:31 pm, Konrad Dybcio wrote:
>> The smmu-v3 binding currently doesn't differentiate the SoCs it's
>> implemented on. This is a poor design choice that may bite in the future,
>> should any quirks surface.
> 
> That doesn't seem entirely fair to say - the vast majority of bindings don't have separate compatibles for every known integration of the same implementation in different SoCs. And in this case we don't have per-implementation compatibles for quirks and errata because the implementation is architecturally discoverable from the SMMU_IIDR register.
> 
> We have the whole mess for QCom SMMUv2 because the effective *implementation* is a mix of hardware and hypervisor, whose behaviour does seem to vary on almost a per-SoC basis. I'm not at all keen to start repeating that here without very good reason, and that of "documenting" a device which we typically expect to not even be accessible isn't really convincing me...

From my POV as an arch dts maintainer, this often ends up being the only
way to retroactively add some conditional action into the code - the kernel
is supposed to be backwards compatible with older device trees.

And so far it's been almost by luck that all of the smmuv3 implementations
have been a straight copy-and-paste of the reference design (or close enough),
I don't believe this will be for much longer.

Konrad

