Return-Path: <linux-kernel+bounces-59312-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F4B084F533
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 13:32:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F05C7285F6E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 12:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC1953716F;
	Fri,  9 Feb 2024 12:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="mRo80Z20"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 222BE37147
	for <linux-kernel@vger.kernel.org>; Fri,  9 Feb 2024 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707481927; cv=none; b=t5cOKTcxGPSTQYmQl0MElhG/2B1dFOhOCqbRQssemo6Wcp0nP8OFBrXXsMETMerrkyykQWnK3i0KPM8iDiQcQJxM40FddVYBgzPcvH2gN1xNtqqC8dPogFwS+gVmRK1ad6bWaplal1Mo/gjjOg0JRyarpTRyYbxjGKkS76KExuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707481927; c=relaxed/simple;
	bh=vuzeVL8ENhRaU0enciWl9Devo54cDMBpxGGadOWRB6c=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=DKyocaNW5Q0W1I9LUoQlUfwGhlxR9c/Ovc8I7kTHgsXrCnzchofq3w+by6AbkVpxipo/1lPTW6ab0o56L+bHxxZY1u2qsC6dajJUuT0L4dM9kLvGOblWCamrZhX4chC8qX4IHeZvjTfB67iAFtlAQEZA5vprG+FdtwzulWeHJIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=mRo80Z20; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a2a17f3217aso108698566b.2
        for <linux-kernel@vger.kernel.org>; Fri, 09 Feb 2024 04:32:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707481922; x=1708086722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Or+7TV33UjjLnzKrdJHHM1U4dB+jQLRVi5nUD3I/5qk=;
        b=mRo80Z20qPeOemXXDzgc9rhxW6fzRqXIKTNTsMtlSyWgvZxiOJPJO+F+PijuiCpnbk
         jOPK2LQd/eQMr4Eia43AVtrjvZfWT3LLJIKmZHE5GiezyF72LnF/o7zHVOP+iS0+ykZ2
         6cq9m7JtwG3RjkRzPeVBzYoofkz5WvrFkLMFIi4rf8OiEhmECWHpkxM2O4K3ia5wtQuu
         AmOX3mMi0G3pcbXQENX6i94z4rKOpLxKFwKmNvZFghI4PaW6oILgnmeWKmKwVOnvS6lc
         yJfd1nPAdJsbZ7Fgq6MbIIT6VKRBnnyxVs2JTnhjJMavobn7z+7WCQT1z9SCEZXDA4a2
         ddNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707481922; x=1708086722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Or+7TV33UjjLnzKrdJHHM1U4dB+jQLRVi5nUD3I/5qk=;
        b=hdqdiyc7LxgUC8XLO/HM2RMO3zlTyKMryoXSfJsKMzVJKOl06SSJl73qqrg/vdAOyp
         HkFYZ2/P1eojqTpC8UPhUjYhoANrZm5FjfErlZFizafypddIodKShA/uYqv1EhKP++ws
         E4bIiu75qMIh16biMf1N9cJPxJcs72yaVdcPvEjd9qYS8PkrSiiZQff8cRDiLFh96eWR
         LjzCc07o5r1QvqXtRVz3DPLW6hNkKQ/hM/A3LEgLHCl5MoScbFxpB3k4j0WmPzyOLMbI
         a5/EQHYSAiz+CF09nxlAeI3cyByWlDgwCINJaA3KTfYpEI1X3liDfsvXKuU++9RxpNMt
         EGBQ==
X-Gm-Message-State: AOJu0YwNlk3FDSZLUbu88a2DX5uapE1T2b2VuhoxbW1gXl9AwhGODUZv
	YnRuDIforlpUX5N4OquCjgcam9cbEKtZjxjc1qFNMYU/Eg2xuzSrFL1WFUq5FnuFxurDeKZxsDo
	BEKY=
X-Google-Smtp-Source: AGHT+IEj752jsa1mlfenpseUAJ3Dy+D08f0ucMRiMLkgNgZPgadQnjiwhwFQMn4/JVjeBV0AQ8fYvw==
X-Received: by 2002:a17:907:175e:b0:a38:984e:2e5a with SMTP id lf30-20020a170907175e00b00a38984e2e5amr1103863ejc.33.1707481922377;
        Fri, 09 Feb 2024 04:32:02 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXPWizAxbPQghB/0XjNG9xvU9op6+8x2fIZERWVKdSmy1YWH4cND3733FPafW3b+GXFlR4wI2jCFyHJ8BTZqd5fIByEpOFUd15UyBXvydGs/L0zDoRpHnSVG3HyjN3xutvszptxt+N305dGkaiQKWmD+VuQBspNkbt/MS+jIH6Y3DG/0XfaN3iFcXaan8lVWoq873bZxIJl+BE3M60l5+L62zqBxK5GJw2Ot1tnWy8=
Received: from [192.168.1.116] (abyl12.neoplus.adsl.tpnet.pl. [83.9.31.12])
        by smtp.gmail.com with ESMTPSA id cw3-20020a170907160300b00a381ca0e589sm717897ejd.22.2024.02.09.04.32.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 09 Feb 2024 04:32:01 -0800 (PST)
Message-ID: <d0133a63-51bb-41e9-826e-61495fef419c@linaro.org>
Date: Fri, 9 Feb 2024 13:31:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] interconnect: qcom: constify things
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240208105056.128448-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2/8/24 11:50, Krzysztof Kozlowski wrote:
> Still some things were left non-const.
> 

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad

