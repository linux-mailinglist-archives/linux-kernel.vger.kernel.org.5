Return-Path: <linux-kernel+bounces-100684-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37579879BD1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 19:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69A931C22AEF
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 18:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE2B1420DE;
	Tue, 12 Mar 2024 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LHuIv6DQ"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA165914E
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 18:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710269116; cv=none; b=EPIeUAqSmuW8YR01mkUjyMIOqa+2wfSiOpM8bjjfUQYeOHBxTtRY4gQVWdHIGtO80aoPQ/Nc6Sivcg+hGuIA6lddiagsA/hs5FDCc/ASh1JjhlsOLEfYYts6H9YvoIlAowHUM4yBJUjACxfHHKnbvF1hfy/PSVOdJZA8eob1UrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710269116; c=relaxed/simple;
	bh=mFTiZ2wd/WRZ34m7EIqEpy/tEPn2YrHtaKLY20O46rI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=V8Y8Td53f6nP95Yk7shl8JwB0dXrVFpVsDHJjXnKWWji5EoeZa6ygliDA1AJN96Ne2eC9Iah4cObcIPNcv3yeIDP8MaDFRf5sBG+uxWyAjnjQ+7nIV5c/5ct3Bvhw/fa8mZS6/EntArnOtRoEvnCx9ZLwkcwAe6zqYLIfzH5Xko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LHuIv6DQ; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51331634948so119170e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 11:45:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710269112; x=1710873912; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oYvui7NOyxMvM6bvDvI6oELVEpcakMEK3Pa/BMDX54A=;
        b=LHuIv6DQTFQTZIBNEIv4Y60Zy4vEMGWuxYm1Cse3uzVXSszSLalGhn2ji9mqNr34WK
         HYDDO3rRPiiMn9nziVSFr+yFGMoAeHzO0okMF0/CkxN7Omdblq1TFRDGtJBeLRnBm9fx
         LDTQgSsY8+CCP17gQ5O9cZ0zcuDD8O9EDsZk2BFXaoWvEpyctNjoUsGu0CymOkxIXbpU
         w76u9criQTAI8wbhrntOJDVsdIP4SezM9Jy/hAMtCrU8a4lmZ8+cjP4RHEZwVfpwjyWW
         g5AosxOjRenIRhkZyezV9gHaHnioSQ2hGXZq+19TCt2ZV3/kEDEgmdRr3J57RA1xhBBt
         Ppug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710269112; x=1710873912;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oYvui7NOyxMvM6bvDvI6oELVEpcakMEK3Pa/BMDX54A=;
        b=m4WqGKKOpr6dOIj01yo7moNFNux2Qf57LB1t/o0RzgH7ZlvSQvD322HU/RdpPCikny
         PEe8dbgG3N4JiwHLNnWlfFmnjQQZC7icxrugXQnLw2nEatsZAhCcQCCwUsbzyWMhRK9b
         niNVQmvkYO0yt0Tonm5XgqZBmQX92kVH+kKO/14YujmqKHjMY8hln/MbhaaMBVaUJMDA
         XT2pK/W7Y3/+9PHt5YaaJRl2tBVLLwxGGn34XK6U3mM/IPUL6NiS4mfvt+LmHOg42PIK
         9gwObvgcbE30GNPVA5oMtk3+HddvSQ9ggyDIgrCCl2H/uM0Lxy2nAyZetw3TLA+76i0D
         Lizg==
X-Forwarded-Encrypted: i=1; AJvYcCVBAtv3m9BBpUstNZ30fW5vHJYVCra4KQu+h3MRfHT1pBr+AkA9eLEriD0F+1p+1RRV71S2vH8xxCKID+cNdnw7DdYtOxAMvNP6F42z
X-Gm-Message-State: AOJu0YxkucLb1ilbYtU1w3wv8wJSZwjNFFfSJTr2L2IHZ6nQQPUNYNmO
	2KCNp0LD+tSUznJG2W3rGs1uW06dWQQZqXZP+pMYf7uxvLXI/C7ws6Zia5OkQL4=
X-Google-Smtp-Source: AGHT+IF4f0OFvoQYPMgs4+2Z3SEeD3NCDQNRnV5sPYZXnBLRlvgPl+hsoID1mTQEGBnuIatascpQdw==
X-Received: by 2002:a19:770d:0:b0:513:c480:d03e with SMTP id s13-20020a19770d000000b00513c480d03emr135246lfc.18.1710269111994;
        Tue, 12 Mar 2024 11:45:11 -0700 (PDT)
Received: from [172.30.204.193] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id t8-20020a056512068800b005139a231b41sm1676845lfe.161.2024.03.12.11.45.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 11:45:11 -0700 (PDT)
Message-ID: <10adf6cd-131c-46a3-9bd1-1f0af24931d9@linaro.org>
Date: Tue, 12 Mar 2024 19:45:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] ARM: dts: qcom: msm8974-sony-castor: Split into
 shinano-common
Content-Language: en-US
To: Luca Weiss <luca@z3ntu.xyz>, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Bjorn Andersson <andersson@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240310-shinano-common-v1-0-d64cd322ebca@z3ntu.xyz>
 <20240310-shinano-common-v1-1-d64cd322ebca@z3ntu.xyz>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240310-shinano-common-v1-1-d64cd322ebca@z3ntu.xyz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/10/24 12:41, Luca Weiss wrote:
> In preparation for adding the Sony Xperia Z3 smartphone, split the
> common parts into shinano-common.dtsi.
> 
> No functional change intended.
> 
> Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> ---

I give you the green light to also add newlines between subsequent
subnodes (e.g. under blsp2_i2c5) while at it ;)

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

