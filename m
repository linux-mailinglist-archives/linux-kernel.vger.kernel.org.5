Return-Path: <linux-kernel+bounces-100391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E01F38796D1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:49:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236C21C216D5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:49:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F22F57B3E2;
	Tue, 12 Mar 2024 14:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RtrFKblJ"
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88AE47AE7D
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 14:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710254939; cv=none; b=jduzmAU+L6mFU4jCy9H6CGtOAanVzDgESJAez6aiXi4WTHHaxJmDHHf5p09gk6N4sQskCT/LIy4rpMsz2zQ2UMJXnl9K4jhgi1//MO/BpX/ki28liV6f/d8jJfOdsgL77dTCdn0QnyFw4gWLHmrseUAbKr9fiwK/T2yFWtLgIFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710254939; c=relaxed/simple;
	bh=ehkMxhxSjg2XhZ+RvTxPDoX4lka61fp6faUzxorfi84=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CLQvUq7eoJIYdUZzPh0BlFT255okwfB9Ym7n/IfoNqFKmKV8xA8NCQIeixd5DZL4U45/TvQcaDqugnxtScebLi7FF7w06zZkp6ITYeV4VcuRpPV1wT+gH4ykc1j9kpRWViJwXL1pqjAk54wfRwV0ecSl7JiBSmcRAnkdJKZ3fqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RtrFKblJ; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-5135e8262e4so6042211e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 07:48:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710254936; x=1710859736; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vJBqb//ttMSi9W/J8xNh1OgzHq9LQEMmCQTMHoiXJQM=;
        b=RtrFKblJhTpI3m+rAIBHeKDsKFS4vpc/kMF4iNMEA4GYNZtK19+pv54+1wiqMA4USq
         bRq5zz7D9jMa3Yov47A7MQfWm3SbXUJ+kjSQ66dVHD2qP/8GTgRshH79D+q33UnlJvp3
         sZXWqffpzSuatewNEbqMVtPDMYmLaETiU35MmX06nHkOUQ7Jv/JBoKsHULXXU5KjBPsp
         RSP/gVdb8mDKFFUyWVAKEIAQRFKQPu9O88DkOFNV/nriuVfrs/YG6lTLlqpoeEpIzNtb
         /M6zrkaemMZjvfnWWDkMUWxZ0fIHbeBTAv/ai7tj/uDK0iuNdKBB5HTRlVUFz4Het1Nr
         1GKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710254936; x=1710859736;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vJBqb//ttMSi9W/J8xNh1OgzHq9LQEMmCQTMHoiXJQM=;
        b=MmlS0n3liE1N08GjCoZIDBXo4z23GQr1t0R7P94pSB6lLE7DkIgxYurYHsU34KYsRa
         F3OeopRB/27dA1ayI1JyJR3H7Y4P7//IYdeFP/Zx/rQtjcKXa8f0peb2K6VzajkSPoyJ
         X2AVhNggCD1pAbu8rt8wE2Px0xhidxDqCf50VlSQArqksT9Lhjb9GoBsFmzlHvU4xhD8
         oAcmXk5iQJXxsRTRjIjarO/sJ+Ip9yvv6YK3diaQvZB25GgQj7NyOYbpZw+QJ1aAIUO0
         PkVjA1mjTsy5op7yFgemdRV4/Ocj6u3AJbsug1o/Q33nbHuPcmGlnr7NQ3pgpLZlckc7
         CkSg==
X-Forwarded-Encrypted: i=1; AJvYcCVzW0W6aVC5LQLIuXshNBpQNgCTAdPK9rHDcyoaxJofU0deJ8sn51wQvBIVcxqppdYfTOewrrGq9gns3HkP6rxq2+I1EfFnbss42m/C
X-Gm-Message-State: AOJu0YwhyK2Xg9u6USKc88u/hVh2YGptS8FH75OUZWJ9ESYnrzo89chu
	eFLVoe24VC2oUi57kkFJ5brdyen2I18oErU54bwujqLVgHQ1sfr7iWc+s41AQ5w=
X-Google-Smtp-Source: AGHT+IHlExnmfR4kT+GhrIroVdprVrNybDbEQkw70027XzchLm1fcSlfQMkG5CBosKWyjRZqZe0c7g==
X-Received: by 2002:ac2:599b:0:b0:512:e57d:c9c9 with SMTP id w27-20020ac2599b000000b00512e57dc9c9mr6198989lfn.13.1710254935601;
        Tue, 12 Mar 2024 07:48:55 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i26-20020a198c5a000000b00513177e424csm1653978lfj.168.2024.03.12.07.48.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 07:48:55 -0700 (PDT)
Message-ID: <a8da3a73-11de-4b46-8dfc-f05335c22b08@linaro.org>
Date: Tue, 12 Mar 2024 15:48:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: sm8650: add support for the
 SM8650-HDK board
Content-Language: en-US
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240223-topic-sm8650-upstream-hdk-v1-0-ccca645cd901@linaro.org>
 <20240223-topic-sm8650-upstream-hdk-v1-2-ccca645cd901@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240223-topic-sm8650-upstream-hdk-v1-2-ccca645cd901@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/23/24 09:52, Neil Armstrong wrote:
> The SM8650-HDK is an embedded development platforms for the
> Snapdragon 8 Gen 3 SoC aka SM8650, with the following features:
> - Qualcomm SM8650 SoC
> - 16GiB On-board LPDDR5
> - On-board WiFi 7 + Bluetooth 5.3/BLE
> - On-board UFS4.0
> - M.2 Key B+M Gen3x2 PCIe Slot

finally somebody made the right call..

> - HDMI Output
> - USB-C Connector with DP Almode & Audio Accessory mode
> - Micro-SDCard Slot
> - Audio Jack with Playback and Microphone
> - 2 On-board Analog microphones
> - 2 On-board Speakers
> - 96Boards Compatible Low-Speed and High-Speed connectors [1]
>    - For Camera, Sensors and external Display cards
>      - Compatible with the Linaro Debug board [2]
>      - SIM Slot for Modem
>      - Debug connectors
>      - 6x On-Board LEDs
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---

With Vlad's comments addressed:

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

