Return-Path: <linux-kernel+bounces-99686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A122C878BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 01:04:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D23791C210E1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:04:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E5CBB658;
	Tue, 12 Mar 2024 00:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jH+2Iac9"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F4186AD48
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 00:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201844; cv=none; b=bA24Xyr+keFvHZRCC21HeGodjJqgfdptYAxDZ4WLPkH5JVWXX9sVW6dIkC9w/AFf1/EJ13hz9QLoN3YVmRZ8bHmOt7QwcgVNhgKqKJJuJIWPVJRQCx2YwjP/2knCzGPZ5P0i3rhSSPEmytyf7RrE63EhiAgmZeiZ4LTkswSpD3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201844; c=relaxed/simple;
	bh=GtWzUpROLy03of4DzRBU4Zj6eH43yIsxZ63cj2+uvk0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DHg1L2x7Fv0IFLXD9lwJkDTRNRpu7WnVTch8ysK0eVnEltH3BSwl/J5W8syjr3EVhS4aU0OLWPtiVpwTSocNeAGfTFVlncaUjTm4qZBt3SIcKpwDuWzcUkiHMH6Jn9sHlZ4v9D78UF8BPwhAhuP61fGyWb2dPkPCtThEyvYB0/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jH+2Iac9; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51323dfce59so3339423e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 17:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710201841; x=1710806641; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BQpqFFicQ5YfomKVXzegGQYmkOjou4tROZ8z6s/Q/bE=;
        b=jH+2Iac9k/rDZ+xgG4jZbQpeTCnJDJB4jJsSVdVz5AeAtzD6pzaGz4cz9IXSrPwrpM
         pU7opKFPH0m5gFm8LebMbVLf/Vtl1jYIWASRUFNlydkzDLry3I+va7l2K1z2NlO49RvX
         rZEI6N8UmxWrO/4CIZ6smHIU1jDpFvI7jPJ1MIl1/c8B6+8k2UYVp9prAMY3Gt6hXQnF
         2TRBiv7uuedsyTAoH9ZaY4Djf/Wf9cyZ5DAkqdGEKwlhLr5Z7dbVNS0I+gVyV96Nuybc
         nyYzHqKmnZxy/blq3zeknbaOtSY0nUB992Ka0mTmk5UY2pSU6FsYaL2T22qe9mltJ/Fq
         yHMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201841; x=1710806641;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BQpqFFicQ5YfomKVXzegGQYmkOjou4tROZ8z6s/Q/bE=;
        b=XOnX9KA3xcrmPk/DhoBZsCYhPhvES3MhfQ3/14EC4klU60VKZoYW+sthkFt6bx/NUf
         fGSAlpR1g2S1LSnUSHXBy5InTb+SuGGg+XdqcqgCA50X2duzji647uuWGSghe5nli/9p
         VF2YddoeCL6vRouBxYxxE4KYKP46Tx+3jQQHW8qRZzbMf/25OKouY4jStaX13mooFmXO
         s/D44ffFYEBZGAUkdEeB/7agmz9k2K/nyiK8fFhwaLyaRqbuGosVC3s1P4y0fNIOT5M5
         i/n1Jyoi69tYjYyw9yulgnr8Zg99HxKRPJbXK/0uIiU85oCyP+SLZEy6xiEyGxI9gxc3
         noKQ==
X-Forwarded-Encrypted: i=1; AJvYcCV8ptwgHUVHSYes2g3I0IRkbPCubUXIn3bgjEa9XXhfCwjlCAbobyg8Xwcyv1cdujvRCI31wFzqMDqV9ssV7NXFByxMr+iSxk4tQO5z
X-Gm-Message-State: AOJu0YxdGaXJuNtcDkdlVNqvc4kGnCDrN6xKIVO4v6G8YWAb30Q4JwIW
	G+eAEsWYFcUBL11wsrm/A8FOaZp+RXd4kV2wEgVTsebPGWlJEUGsq+ki+X5bSAI=
X-Google-Smtp-Source: AGHT+IH6yRmOXext+BOdsK7e8To7SfioRgtqDEWmkaxrfNU+TvvgE17KOn0grChRMEn/Uu4NSlYjhQ==
X-Received: by 2002:a19:ca17:0:b0:513:3fa6:efe3 with SMTP id a23-20020a19ca17000000b005133fa6efe3mr5254639lfg.8.1710201841082;
        Mon, 11 Mar 2024 17:04:01 -0700 (PDT)
Received: from [172.30.205.61] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id n16-20020ac24910000000b00512ebe62693sm1300360lfi.255.2024.03.11.17.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 17:04:00 -0700 (PDT)
Message-ID: <e787706d-b5ef-40bd-9fa8-fed784a9d7b7@linaro.org>
Date: Tue, 12 Mar 2024 01:04:00 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] arm64: dts: qcom: qdu1000-idp: enable USB nodes
Content-Language: en-US
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Komal Bajaj <quic_kbajaj@quicinc.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Amrit Anand <quic_amrianan@quicinc.com>
References: <20240311120859.18489-1-quic_kbajaj@quicinc.com>
 <20240311120859.18489-3-quic_kbajaj@quicinc.com>
 <CAA8EJpqMWBWAEUCiJXm0x7zjZYbP8SkRDgu+w+goYjB=8JBN0A@mail.gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <CAA8EJpqMWBWAEUCiJXm0x7zjZYbP8SkRDgu+w+goYjB=8JBN0A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/11/24 13:14, Dmitry Baryshkov wrote:
> On Mon, 11 Mar 2024 at 14:10, Komal Bajaj <quic_kbajaj@quicinc.com> wrote:
>>
>> Enable both USB controllers and associated hsphy and qmp phy nodes
>> on QDU1000 IDP.
>>
>> Co-developed-by: Amrit Anand <quic_amrianan@quicinc.com>
>> Signed-off-by: Amrit Anand <quic_amrianan@quicinc.com>
>> Signed-off-by: Komal Bajaj <quic_kbajaj@quicinc.com>
>> ---
>>   arch/arm64/boot/dts/qcom/qdu1000-idp.dts | 24 ++++++++++++++++++++++++
>>   1 file changed, 24 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> index 89b84fb0f70a..126bc71afd90 100644
>> --- a/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> +++ b/arch/arm64/boot/dts/qcom/qdu1000-idp.dts
>> @@ -500,3 +500,27 @@ &tlmm {
>>   &uart7 {
>>          status = "okay";
>>   };
>> +
>> +&usb_1 {
>> +       status = "okay";
>> +};
>> +
>> +&usb_1_dwc3 {
>> +       dr_mode = "peripheral";
> 
> Are these ports really peripheral-only?
> 
>> +       maximum-speed = "high-speed";

More importantly, are these ports really HS-only?

Konrad

