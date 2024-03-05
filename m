Return-Path: <linux-kernel+bounces-93008-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B5EC3872959
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:23:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56F811F2448B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85A1312BEA3;
	Tue,  5 Mar 2024 21:23:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WOB8SWF+"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23BCB12A153
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673806; cv=none; b=p/d9bG/Rhrkb+XLmN2Iy7Ew3ADb01yq92SGDM1s2Ha4gFz8BKs/nilYOPgdsbPIDusIiwP7J5khCzJn0snpfWf2+aYYJjW/0/41rJ5vcxRyVRXWsBoTsldUv9WmoCDWt837l9XEs5v/H39wJHw/hemqdOe6vecmyhYivcrltWQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673806; c=relaxed/simple;
	bh=+sYqzS7S/emEX62cjyaYV4mxk/5PcBUF1vVXL8oH5qs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tebA42N1g//O2XKqSAV4ShrQOB60DlR7OBQybHfJud2MI+4SKJRn9zS1WCvZT3cMNqtNTtqJ2wvTHdJ6X0MxyT1pk3s3ltgWUywcw4c/5sTT8VED/7kM5NhP5Mbs5tnEADedSaYUtgYiS8SLeqK8rG8AuiI49tz3R+LaLXlmgi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WOB8SWF+; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so78856401fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 13:23:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709673803; x=1710278603; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yAzL8mGHJidCO1zLUY5C0p3Ij1T1ldDFSZfozw6PSaI=;
        b=WOB8SWF+1cFzp6WqmgoClYw2Y8HsasUHUNVWzyL9YuoKkliO2UiphOuPzWLR/OLO5o
         5UtmysfrMT3C8C9FLfIybH5Fpoc7prwPqV6LEfK7xoL8K2lOBFIT5KFZTpZsC7uJh20A
         P5dYgzTJWJUvHEH0EydNLUi+HU9g2ZkhjzuF7piBSByNDUvvK4R2IoiN3y6u1SZENytG
         9yofIKXCPmYRycmYudlyEKOJMzK7B3fvgJjBrmRwZl8/uitK8IpMcm1ztjgLC4ZHSaaB
         0mNp4J8q6kxGMkwt9Llz9Ejae6Z1RQuG77dsAAMBQpKqfwA3I0vjy/hXqQEUUhuXG1x2
         bgNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673803; x=1710278603;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yAzL8mGHJidCO1zLUY5C0p3Ij1T1ldDFSZfozw6PSaI=;
        b=jK9EZuBpwoqGYEWGNlUWZCfLpXb6JYqSMWJIaJZxmaH60oHb8hzR5SLvL3OJSmAVyJ
         iCrroUKrXBVabPx9Ys8jhBjjdPdYF6wZBVp1fufK/G/AYZZlTTgep60uXmRuL0s1Q+ay
         VfiTKO0STZtzvPjNuc07k6FR98PRHtUUMFaGMDju9Vcf110PlK89+M2KJzCo8ryCLPSA
         rU1ny8TUuGTFOTZSbFCXXsI6wGc/Ylhvcj+GxxxURs63U8SpISglT7YQtTYSfPWB6254
         FgEx5zu9C+ECTt5Mm7Vez3sfrJGtFJjmAkLyN9FzpYfGaJ2mHRLEthz/fRTzGi/7QYEX
         SHCQ==
X-Forwarded-Encrypted: i=1; AJvYcCVT+uenMHVJlbwk4CcN/pV07MGWnzdTDF6qrnYJAapd6s881rU7DUs+Of+jeD53TwS5/IpGHcJgNKvV9ZHrywVIBdh0vhMRu7ahAfdP
X-Gm-Message-State: AOJu0YzRedhqiseE7Xps20STeTi+qdiw5DM+tzLsINgwzJv6edXP7slL
	ZxovssK5JrNkSm+zPJ2B+iShXT7mZ+3BL871h+tT+4lIX62F+HUjkkSoqAGmqhhp3BZQMAtopKQ
	VU21O3A==
X-Google-Smtp-Source: AGHT+IEFyN9DKvKwqLB6pX1c6+uDTipw2rDoJN2LgnZsNQN4gdBtSi0xVYlhK/bRXcoWDQgIDlyffQ==
X-Received: by 2002:ac2:5f05:0:b0:513:4766:2713 with SMTP id 5-20020ac25f05000000b0051347662713mr1866058lfq.59.1709673803199;
        Tue, 05 Mar 2024 13:23:23 -0800 (PST)
Received: from [172.30.204.154] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id b5-20020ac24105000000b00512e594e235sm2331651lfi.242.2024.03.05.13.23.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:23:22 -0800 (PST)
Message-ID: <0a28b69d-e55a-4e54-8d2f-e92b06baf71c@linaro.org>
Date: Tue, 5 Mar 2024 22:23:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: qcs6490-rb3gen2: Name the regulators
Content-Language: en-US
To: Bjorn Andersson <quic_bjorande@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240227-rb3gen2-regulator-names-v1-1-63ceb845dcc8@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240227-rb3gen2-regulator-names-v1-1-63ceb845dcc8@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/27/24 18:39, Bjorn Andersson wrote:
> Without explicitly specifying names for the regualtors they are named

regulators

> based on the DeviceTree node name. This results in multiple regulators
> with the same name, making debug prints and regulator_summary inpossible

impossible

> to reason about.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

