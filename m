Return-Path: <linux-kernel+bounces-126252-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED76893442
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 19:01:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E940C2869F0
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 17:01:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4181215B0E5;
	Sun, 31 Mar 2024 16:42:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UQNzZuDF"
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3067B145FE0;
	Sun, 31 Mar 2024 16:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903324; cv=fail; b=FbKBzeX3+Gm/JHQWPa/q1MbXzbfCL2AvUIe0JDPtIRF2kw1FMRcBpvFO11OQvfZGfJE/QHW3BkPqVBJG8V52n1DBKrBEtqjbjumuasnba7AQ/kvEbHToJ64Km5MuRDMrxhjA5buAokcIjuw+dFWyvWL4PE3dv39dYXy9YUdzzTY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903324; c=relaxed/simple;
	bh=hDskNYVNkcabhlJ/P/r27gZ0SZBEUJm2K50pq3H0LI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=J1EkGHIrplIR1IX03GvKRn9UL7C1b3FWLwXml4hOM/CgT96eGsx9nvd4/wXyzylKb//e0Qy7Azey+XpRCX0qIy/vrNTQ8gVKP1I5VhTAt3mhcU5bJiTo6GkfCDUqwIbSXn6NqcXsaudGGvKYFWHCG2Z9/gIXouoH+SwGyHo/J30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org; spf=fail smtp.mailfrom=linaro.org; dkim=fail (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQNzZuDF reason="signature verification failed"; arc=none smtp.client-ip=209.85.221.44; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=linaro.org
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 07B9120184;
	Sun, 31 Mar 2024 18:42:00 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BGXC7R3Qr9vC; Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
Received: from mailout2.secunet.com (mailout2.secunet.com [62.96.220.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 6F1F9207D1;
	Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 6F1F9207D1
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout2.secunet.com (Postfix) with ESMTP id 5895A80005E;
	Sun, 31 Mar 2024 18:41:59 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:41:59 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:02 +0000
X-sender: <linux-kernel+bounces-125634-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com>
 ORCPT=rfc822;steffen.klassert@secunet.com;
 X-ExtendedProps=BQAVABYAAgAAAAUAFAARAPDFCS25BAlDktII2g02frgPADUAAABNaWNyb3NvZnQuRXhjaGFuZ2UuVHJhbnNwb3J0LkRpcmVjdG9yeURhdGEuSXNSZXNvdXJjZQIAAAUAagAJAAEAAAAAAAAABQAWAAIAAAUAQwACAAAFAEYABwADAAAABQBHAAIAAAUAEgAPAGIAAAAvbz1zZWN1bmV0L291PUV4Y2hhbmdlIEFkbWluaXN0cmF0aXZlIEdyb3VwIChGWURJQk9IRjIzU1BETFQpL2NuPVJlY2lwaWVudHMvY249U3RlZmZlbiBLbGFzc2VydDY4YwUACwAXAL4AAACheZxkHSGBRqAcAp3ukbifQ049REI2LENOPURhdGFiYXNlcyxDTj1FeGNoYW5nZSBBZG1pbmlzdHJhdGl2ZSBHcm91cCAoRllESUJPSEYyM1NQRExUKSxDTj1BZG1pbmlzdHJhdGl2ZSBHcm91cHMsQ049c2VjdW5ldCxDTj1NaWNyb3NvZnQgRXhjaGFuZ2UsQ049U2VydmljZXMsQ049Q29uZmlndXJhdGlvbixEQz1zZWN1bmV0LERDPWRlBQAOABEABiAS9uuMOkqzwmEZDvWNNQUAHQAPAAwAAABtYngtZXNzZW4tMDIFADwAAgAADwA2AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50LkRpc3BsYXlOYW1lDwARAAAAS2xhc3NlcnQsIFN0ZWZmZW4FAAwAAgAABQBsAAIAAAUAWAAXAEoAAADwxQktuQQJQ5LSCNoNNn64Q049S2xhc3NlcnQgU3RlZmZlbixPVT1Vc2VycyxPVT1NaWdyYXRpb24sREM9c2VjdW5ldCxEQz1kZQUAJgACAAEFACIADwAxAAAAQXV0b1Jlc3BvbnNlU3VwcHJlc3M6IDANClRyYW5zbWl0SGlzdG9ye
	TogRmFsc2UNCg8ALwAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuRXhwYW5zaW9uR3JvdXBUeXBlDwAVAAAATWVtYmVyc0dyb3VwRXhwYW5zaW9uBQAjAAIAAQ==
X-CreatedBy: MSExchange15
X-HeloDomain: a.mx.secunet.com
X-ExtendedProps: BQBjAAoAWIOmlidQ3AgFAGEACAABAAAABQA3AAIAAA8APAAAAE1pY3Jvc29mdC5FeGNoYW5nZS5UcmFuc3BvcnQuTWFpbFJlY2lwaWVudC5Pcmdhbml6YXRpb25TY29wZREAAAAAAAAAAAAAAAAAAAAAAAUASQACAAEFAAQAFCABAAAAHAAAAHN0ZWZmZW4ua2xhc3NlcnRAc2VjdW5ldC5jb20FAAYAAgABBQApAAIAAQ8ACQAAAENJQXVkaXRlZAIAAQUAAgAHAAEAAAAFAAMABwAAAAAABQAFAAIAAQUAYgAKACEAAADYigAABQBkAA8AAwAAAEh1Yg==
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 62.96.220.36
X-EndOfInjectedXHeaders: 17954
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=139.178.88.99; helo=sv.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125634-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 5156320872
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711789509; cv=none; b=jVxLiQBaz2kUFNd6cZzx2WTEtBSZTsHRuJ17M+VaMxz6f4H6itBy5O2gUnyOitRgS2V/mX2nn+3kY5xsfdWmXkYYbbcPZ3TbJqJd3O9BKHmWMTATZygN+zZQossm9ujrE5tiyfhsX+VxhFwxRadeHkajlR4FrEuDCb+WJ5PhLPc=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711789509; c=relaxed/simple;
	bh=BRPSbu5SXLCSBTdAcz9esHtN7vO2IfNM9BQEiL1ym18=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=PRwH45OKBlGzMdPXtgS5taLQxFoTtjC75gxk3PXe2n7ztSryct/Qhnv2RUua39lIWuTCvep6wgzQZyu82XRmP70SCFrIqqt13guvpuEeeQj18Y+UxAbNMN1qfZgY+audtkYlB6mcQdigRzO6yr4bPTukgNdHNCV+i32QdArEXOQ=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UQNzZuDF; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711789506; x=1712394306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=cjfde955e+AfD7bCuWniLgBVv4tolPtzhxIYBfKnkBs=;
        b=UQNzZuDFtYsY1n/UKACajuGM4Ydes01PQR60kumU3NuhxsK8Ypjtt/Upq/OzRMk1q9
         oy+pH/25kUe8ZBtnDB9AU3jY9TRyzOSdY5bsXecMnhiV73yvhOyI8GokWn/2EIk7Zey1
         Q1dgzg/CREMXB3jMwXVGsxINeJ7mDDAR+AG2K7rhB6D2w+fjOPAIxyIfLDPVQHShMBER
         luVVJr4g6ztXPXAup+oEIZgAkJUSNJyvZ1bWixyePmjq9QXHeknA2ZME4OGWjUh52Rya
         fLvekdaNC/Q2oJFlzT8BxnmCKYG47I84ngGG0GCwQ/OA3ARxsisY960cN2ZDEHboJRRs
         VtwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711789506; x=1712394306;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cjfde955e+AfD7bCuWniLgBVv4tolPtzhxIYBfKnkBs=;
        b=ZTXS9iCLI6dTiyWAFlH452rUXGjAfzZjAjdUlIdEcuHS4q/vK/ouav6JV8I7UehJus
         o+VlLBuZdwhHgQQ4lBnnI9LdtUO4P+mmttOotPwoLbnLUK0fBbQu8zb84OJHIblbuxf9
         xJNTa8kr/e8eSViIuuAOQyN4+nnKVQmvuxtdn2YKFPC+roIs7MQ2jCksp49I2c2YkSu9
         47PXcuL8zmUh1ImD/BwIpl92MNO22Y4dzLmEiGnk1yaGdSAA4jG7/Dkts0wRq+H2g3UD
         eqE55Ud7K2V7M3s9AXeC14WNnTUyFxRBLMcsSmbyuN5OK5+fnxL8TCXyb+s3hZ9HKLkd
         eu+Q==
X-Forwarded-Encrypted: i=1; AJvYcCUqP4Q11XYIWuhn0oaZeE6mXwouj1tYgyT6Zn316S7eEiWvTniLC5mx3THUDtubyqV0ayiSYRDAIGGS05Hx6p7p7O2Fd9Zvwu4CvOr0
X-Gm-Message-State: AOJu0Yw5lZ/0P0KUGX2MdsW1+AgMbLiEOebSS9EQI/nYdZztyhBh9DBq
	QBzWAtn/5h4JuryLchwv7DKdcFsQ+c7JE59yZE1wrBCzewHC5aiJlgZW/v/HRj0=
X-Google-Smtp-Source: AGHT+IG2+IzU78xgARzqG1oeVmcbSAccuJka4sSnj1FR48vqsvncAIv0oanr1fRTfha5FvmBhLc2Gw==
X-Received: by 2002:a5d:6451:0:b0:341:b9ee:753d with SMTP id d17-20020a5d6451000000b00341b9ee753dmr2716884wrw.53.1711789505556;
        Sat, 30 Mar 2024 02:05:05 -0700 (PDT)
Message-ID: <36547f9d-1331-4e9d-96dd-a36bd64c7cbf@linaro.org>
Date: Sat, 30 Mar 2024 10:05:03 +0100
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: qcom: pm6150: correct Type-C compatible
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Danila Tikhonov <danila@jiaxyga.com>, linux-arm-msm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240328074544.5076-1-krzysztof.kozlowski@linaro.org>
 <7f28584c-0e9a-44bf-b0c1-7f7a2acfb847@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <7f28584c-0e9a-44bf-b0c1-7f7a2acfb847@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On 30/03/2024 08:07, Gabor Juhos wrote:
> 2024. 03. 28. 8:45 keltez=C3=A9ssel, Krzysztof Kozlowski =C3=ADrta:
>> The first part of the compatible of Type-C node misses ending quote,
>> thus we have one long compatible consisting of two compatible strings
>> leading to dtbs_check warnings:
>>
>>   sc7180-idp.dtb: usb-vbus-regulator@1100: compatible:0: 'qcom,pm6150-vb=
us-reg,\n qcom,pm8150b-vbus-reg' does not match '^[a-zA-Z0-9][a-zA-Z0-9,+\\=
-._/]+$'
>>   sc7180-idp.dtb: /soc@0/spmi@c440000/pmic@0/usb-vbus-regulator@1100: fa=
iled to match any schema with compatible: ['qcom,pm6150-vbus-reg,\n        =
  qcom,pm8150b-vbus-reg']
>>
>> Reported-by: Rob Herring <robh@kernel.org>
>> Fixes: f81c2f01cad6 ("arm64: dts: qcom: pm6150: define USB-C related blo=
cks")
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  arch/arm64/boot/dts/qcom/pm6150.dtsi | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/arm64/boot/dts/qcom/pm6150.dtsi b/arch/arm64/boot/dts/=
qcom/pm6150.dtsi
>> index 11158c2bd524..b20a639cddf3 100644
>> --- a/arch/arm64/boot/dts/qcom/pm6150.dtsi
>> +++ b/arch/arm64/boot/dts/qcom/pm6150.dtsi
>> @@ -71,8 +71,8 @@ pm6150_vbus: usb-vbus-regulator@1100 {
>>  		};
>> =20
>>  		pm6150_typec: typec@1500 {
>> -			compatible =3D "qcom,pm6150-typec,
>> -				      qcom,pm8150b-typec";
>> +			compatible =3D "qcom,pm6150-typec",
>> +				     "qcom,pm8150b-typec";
>=20
> The warning in the commit description is related to the
> 'usb-vbus-regulator@1100' node, whereas this fixes the compatible of a di=
fferent
> one.
>=20
> Did you want to fix both?

D'oh! There are two of them! Thanks for the catch. Yes, I want to fix
both of them :)

Best regards,
Krzysztof



