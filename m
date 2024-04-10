Return-Path: <linux-kernel+bounces-139160-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2261B89FF43
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 19:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D1D312849EE
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 17:57:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DAD317F376;
	Wed, 10 Apr 2024 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZnfKzdLO"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E06B17F36E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 17:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712771869; cv=none; b=rSR21PYaQurBck9BCtNa5gqmTeXRbA+JalJnSY3u9EovZfoFONF1XdBoM7kUpze5UI8QrqIdeM09pDvLFgN7mILdjIWiaPWHlC2Fx5VMblNYiN7nDKDF/+ZgUMl9VMX1WHmnr4van0GaJRc/S3u0HW9MXkZGGJpHMyEEwatadus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712771869; c=relaxed/simple;
	bh=KSSlk8bsMALzU4aLOuDQa//L0banKdQVAiOoA5qSe4g=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=k/8S6vrzBlhL/6JARzOOa7XoypmkQZ/GCRdENcOgm47eRNdH1BKGYYO+JgGPWcDhT7Yh9Usi0PPNDwJzV/D3VM2Ge6br1FMkPRmFAliBGMgVq+CGmYpwWpllxv6owewb5LoVH0x3hJR9kLg6VTzqeIQRnxKbH4ISHeHhycZ3rws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZnfKzdLO; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-516cbf3fe68so8653447e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 10:57:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712771866; x=1713376666; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4VriGxSmeAMrd0HbAi17rP97R4YzqX84RVPW8DEU7SU=;
        b=ZnfKzdLO/4IMEV7kbHAfKh+shAIF8ik3U6tXW67i05NSKi7M3bUYX8rRFTiXyp6Cu7
         0qzdsvqZ9Ctrq/qyOlrVIW+rYJH7+5e1rodVxsJtjJo4/GfDpJKlBtPp3bEwRkoGN4/z
         RyZIVhsMuyefSQ0WmUCDtNVUF3VnwNF2FfJJlH+BnBA22f67HW8k5MUadV8u3S4m/2I1
         2v63R6eQsqWp5TvKC+9PHpohjb3ntEyV4Q9XRhBMpQ3WIJTm6uKDBleGXBVrtN2QnPCp
         ko2i33Ywibxalei5L/NuQvJzaWGJdIjQDjL9wE/YFzvG9gtGOOQgT/VXJFY/35eqKBPX
         KomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712771866; x=1713376666;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4VriGxSmeAMrd0HbAi17rP97R4YzqX84RVPW8DEU7SU=;
        b=uwL0+M2n/NdAJl/2YoZ6Le3J1m36cp0JolTxiCTN/wFeJdFUH3VRZhLC62fl30YyW/
         GMjY+RGteu5Xw1rJLu3wl5xzfp+hcpHgRs7grgcQuUO/S5rXcXSYVHRNXPfQ+Jdsf90M
         6GI44F+wEZQnp3J7hRGWVfdKAfpiLQcPFtutg6xkbQf9JRx2fuwIIwtghC0KKW8hgnlc
         xoXZHlj/cf80/HT6bfpd28+zgRdZ0KCE/6SsfGMk9/gJzCe5RmY6tcNs9d0l9G0O02kc
         gjX328CUqti07ewMlNhKi+Oq58HeURphnutOoTWm9SxxXYbdKsCiHUObI1Vk/3M4jac2
         aw6Q==
X-Forwarded-Encrypted: i=1; AJvYcCXWsHL4i13HAKXVwGAVP55rbIc2CIliHgQ34vcFg1b3j1bHqbJlt8y/4GUKwCYMIJ/+BaDPqPmywBKUPUHYFV94OlHRlfXM+QVc2oBd
X-Gm-Message-State: AOJu0Yz9IycrT9pbUz99UOTDbP5i9pCRAl9mfFzJpHIVUk7tKsZJ7enc
	Sy1zmoiwCXL3rfoUMeceG1qBt8QsYtIeNjzF58Q9O+0Hzguyrq4INYW2S0K6yKk=
X-Google-Smtp-Source: AGHT+IEMn+7QOBZoSPpCqOFaNsmBHfuxXi2Pq5xTIAsOtgQ9XvtVpkTgTWFxslo2PrKeDv5iStEd/g==
X-Received: by 2002:ac2:4198:0:b0:515:d1b9:3066 with SMTP id z24-20020ac24198000000b00515d1b93066mr2133456lfh.46.1712771866030;
        Wed, 10 Apr 2024 10:57:46 -0700 (PDT)
Received: from [172.30.205.26] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id y18-20020a196412000000b00516ce0257a8sm1915241lfb.105.2024.04.10.10.57.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 10:57:45 -0700 (PDT)
Message-ID: <16bba953-d6f9-4701-8b95-56b3231c5f6d@linaro.org>
Date: Wed, 10 Apr 2024 19:57:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] clk: qcom: fix module autoloading
To: Krzysztof Kozlowski <krzk@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240410155356.224098-1-krzk@kernel.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240410155356.224098-1-krzk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/10/24 17:53, Krzysztof Kozlowski wrote:
> Add MODULE_DEVICE_TABLE(), so modules could be properly autoloaded
> based on the alias from of_device_id table.  Clocks are considered core
> components, so usually they are built-in, however these can be built and
> used as modules on some generic kernel.
> 
> Signed-off-by: Krzysztof Kozlowski <krzk@kernel.org>
> ---

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

