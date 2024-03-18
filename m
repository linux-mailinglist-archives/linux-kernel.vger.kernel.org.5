Return-Path: <linux-kernel+bounces-105798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA5087E4AC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 09:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5BD28286B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 08:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41E4C24B29;
	Mon, 18 Mar 2024 08:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S9BgWtpT"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0200422EF0;
	Mon, 18 Mar 2024 08:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710749044; cv=none; b=Ty/eCzhWd3ZQmd8n+JY9iqlq22K/TErFi1Jjbgs5KI2ZBLsR1eE6Lf82WOkCsEV3y2CRblmS3Q0Z6EoMB76Qhyw++t+n/gMqCU4U2ri9IizygZ2be7nmsPYeTgP0UpFSPW052eqFQPqG7LoVplAjZ/PrcXF0MJXvihA1q1LZb7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710749044; c=relaxed/simple;
	bh=3vCmEnziX5UWEvuq2/xW38kFQuJcvuKMTOZmCAWUM28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jepCy1DoRJC9xYYl6Rq71v6bRxovKc3oheaGaZBWe7BpfXZ4rZ2l9eodrhpIhKYLyk6ia3I+xT0GcPO8AmJEWBYDuWe501kcGYKCqB9Dm+2oQxjQY0+3bVXJDwckDdSxgHwfkNp5CuhcgNodnU//K9+oc3Q2i95T2JFSlbn6T1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S9BgWtpT; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4140efa16caso5748325e9.0;
        Mon, 18 Mar 2024 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710749041; x=1711353841; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8HsTPymUGbTk8Dhu5GzvAiOTv3BjGohUx/HMVJVNg0Y=;
        b=S9BgWtpTI/Bkrwvb3w0/kWZAOXfVuerqxGORgcB5YSjxOLVU9WwbnimAC1TzaMXLGT
         bWBu7u8v5OXrr3V/xaqX5iWi8mea4T/vW3FE9hT3OtQ/jv05vxwUCsn1JwWDWDtJek4P
         fSC4IlB+KaCEi9OFgHvQjjdppp6/SfnGOeRnCwU90K39a6rhz3SYQjiCUgKpQJvhfanv
         GCIeAut25Dyp0v9jP8bS8tCs3rbGI2z3U3v+j4Pji/S6/n79BQnRZGT7Tvt8lGtMX4I2
         vIztyBUr5BoSzep5OhSQHKPXsSmyZgOGSAbu++cFherSwta+wKjazQZW/igSED8ImigW
         qmng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710749041; x=1711353841;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8HsTPymUGbTk8Dhu5GzvAiOTv3BjGohUx/HMVJVNg0Y=;
        b=PSgCJNsIbMjMEAYLQnznVMpNSMrKgYmcTGQCg+nkQo8L9ny5jQYIvwgdRfIW8R/lcy
         qug6+DtSezg1F0PMrcBeh56YAb/1ErIMiR+zd3n5tF/uE0ijZ1Nb/Gk0CZ9RDYy7SCW3
         admN2aXEKvAohaN+Zdc7fyfRYoTnqcjKyMg6pOovoo1uQl6rlbRIgylnJsGhRZDZPGDf
         ozSB1LjDE3nLiu1ltqRA0PsECbreDUlZ42R6MWVcl6Szw3YekO07rIScfZuqiu7oCmj3
         HdmB3A+5I+Ymx9fWK5s+iKsyBIrV6RG5NLPeYgjo/m4p1YPGJeAUUvwPvVQ+/Yv9jaZ8
         gyYQ==
X-Forwarded-Encrypted: i=1; AJvYcCXvUfKlhZvwQRAmw0RH1ADJ3pZN6m7jm1g85GSpeT7fJewsD9AtYEj4ijgvgYF7UDzTMH9v2xeMiyyVCJVySy7+6EKvefg/J+p6hllik8IDmbxwVVX5HAWLkCq47Wa8GgE5BAX9FBJM7Gcv+w5lAoJOPjC50T4UJ2yrYuqOJtEv
X-Gm-Message-State: AOJu0YwB4iaBLw7Azat5tXd7b1QJzvDl9tevDGiyJ3tLMQhvYI8z4EGn
	c6pXm+kvygwtLwHaM/adjzJH6XqvlJOU1uf5M/pNX5ychvG3KJJO
X-Google-Smtp-Source: AGHT+IHiIcwaCjaAYDBE/L1WHBdH7fRwmwDNjKgiKAAV6Ck86e4BFePlref4DCZaMSV55hpgKkJz7Q==
X-Received: by 2002:a05:600c:4fce:b0:413:2e2b:bad2 with SMTP id o14-20020a05600c4fce00b004132e2bbad2mr8908160wmq.5.1710749041214;
        Mon, 18 Mar 2024 01:04:01 -0700 (PDT)
Received: from [192.168.20.170] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.gmail.com with ESMTPSA id f13-20020a05600c154d00b00413f25d9104sm13634639wmg.40.2024.03.18.01.03.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 01:04:00 -0700 (PDT)
Message-ID: <781ea033-6749-4a3b-bc2c-14bb753dcdb6@gmail.com>
Date: Mon, 18 Mar 2024 09:03:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] clk: qcom: apss-ipq-pll: use stromer ops for IPQ5018
 to fix boot failure
Content-Language: hu
To: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Sricharan Ramabadhran <quic_srichara@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
 Gokul Sriram Palanisamy <quic_gokulsri@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <20240315-apss-ipq-pll-ipq5018-hang-v2-1-6fe30ada2009@gmail.com>
 <7d0e81fd-8cc2-46f2-bc12-759a0d48e3ae@quicinc.com>
From: Gabor Juhos <j4g8y7@gmail.com>
In-Reply-To: <7d0e81fd-8cc2-46f2-bc12-759a0d48e3ae@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

2024. 03. 18. 6:39 keltezéssel, Kathiravan Thirumoorthy írta:

..

>> Changes in v2:
>>    - extend commit description due to the changes
>>    - add a comment about why CLK_ALPHA_PLL_TYPE_STROMER_PLUS register offsets
>>      are used
>>    - constify hw clock init data (Stephen)
>>    - change pll_type in ipq5018_pll_data to CLK_ALPHA_PLL_TYPE_STROMER (Konrad)
>>    - Link to v1:
>> https://lore.kernel.org/r/20240311-apss-ipq-pll-ipq5018-hang-v1-1-8ed42b7a904d@gmail.com
> 
> 
> I don't see a reason why my tags are dropped, nevertheless

Sorry, that is my fault. Since I have modified the patch, I was not sure that
the tags are applicable to the new version or not.

> Tested-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Reviewed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>

Thanks!

-Gabor


