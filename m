Return-Path: <linux-kernel+bounces-137454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F0C789E262
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4FAF91C22C71
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00454156994;
	Tue,  9 Apr 2024 18:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NkxYjiG2"
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71276156861
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 18:17:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686622; cv=none; b=JEgf3GhAE/ZhqBtO6nxocY66VMc5GMhhWkAdcc/xT87DlFWU70yf/9y8MHrLcyr3gxHwDJD/my60YJMkJXyNuE/qVjKvsrX/7demqRVeKgKLjdToS5iZEKfm3+lYHriYn9cd2QNOmBd9pHKsypBXsoSr6rH5uvMbQc10qVhwl3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686622; c=relaxed/simple;
	bh=8v7Bw7Ml2qSXocRuYkT6D/f4NYEZj9FMUacUtYK7PxQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UUOEVE3yUPqlOSf9D+bWmYXmJZCoHRFZGC7HV93CNHrPEs1aRA3TOiqFINn7LmUd8IkU+4mCm2o6AY0HBaTARZwBYsHmMYjY6kO2SRzOmEeH0f1rpZD3q/uZ0tf7YZecMIO7wn9wHfA20vlxYgNJysY8bhqyicfZ9MNZaiMBBzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NkxYjiG2; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-516cbf3fd3dso6863226e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 11:17:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712686619; x=1713291419; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwRcEqJdl/aKPcyjjUDw4PrMEBdsdFKPMiKh/b3NCj0=;
        b=NkxYjiG27JOn6YNUPIHrMmshU6ip4pbLatylyNZUeFkgXkhlH68Bz1VUkCcjP5FX06
         meJpageOM9/wIFE9wAJvoA5gqGKBKCLHXOmCOXibTZF0OBYecjOVxFqO8OyPE8yyMPNQ
         X/Qs7wn4AsbjklvKP6RbXBZ6txByD2uLVEG9HHSPDbOPHtgGSlKdCsQMlGq+SoR8MtYS
         c6k7jVa1Nn6RaVk3SrFIaN+/tHXWSMcXV/patllyDu0e0fmXuOYH9IJnuyoS48CFVCrn
         6Blk60SAVKH+ZTT1HQeQlTkTVxEGdGH9BffOZn/FfHuTCV+TF9vaVOo8XGgU9kH7tZFi
         ve6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712686619; x=1713291419;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwRcEqJdl/aKPcyjjUDw4PrMEBdsdFKPMiKh/b3NCj0=;
        b=crKh4NRx0LHIivlrkdtJkCazoL2+gURQV/g5EB3GlcvFrnUyxBuVb/zW33z9UDeVpA
         lND1mp4It44Db1zt7nQPl9dDxzjIIa8SMW/5+X34V/mqD4jwmHnAZDnuMT6MiRfDDsvV
         y1jUPdBg29hhOv1Ie5EdJsuJf3AdM6CpEVJZzw+XbRmgcCnZ9nqkALpfSBr7jNt963qW
         rTqxnygagoBa3d/JRDc16SI3yeribuRBdBrDlmyVV5/LmVO/pk/4NlN2bnYnWKVoVnSj
         gn+Tba2HD/IlRFR2k5Vr8yqxgsLTkh9Y8uwbzblblPx7XHh6pxq5q4jkd5lksZd37P3g
         i1Dw==
X-Forwarded-Encrypted: i=1; AJvYcCVsMAhHkmevwjFv8AFVeEfAh8Up8KLnKMOeBZqTZzfP9t3cDo4YAkq9kNmQNBahdPcQJD0BU7qDvSgi8t4wAv3rVxA8c+01uwIV4vF5
X-Gm-Message-State: AOJu0YxVJ1Z/kGMVQxPbGA+ZDzsXAVZasaUla4WcZZyWmDtjcdt9fQNc
	YSbfEJCVSGtY0tGXYwBho78urNr8bn69ZiT8QxnmJx3rM2AzxtpoziK6o1HJNoU=
X-Google-Smtp-Source: AGHT+IFi97DTqvvh7mVWzHxai8ZC6jdD8XWkBMYhCggo9XKB7YbQyLLHUqoq4tjk99obPxsTaf1bQQ==
X-Received: by 2002:a05:6512:2c95:b0:516:c600:64e8 with SMTP id dw21-20020a0565122c9500b00516c60064e8mr200709lfb.1.1712686618619;
        Tue, 09 Apr 2024 11:16:58 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id x7-20020ac259c7000000b00516dc765e1esm1276627lfn.267.2024.04.09.11.16.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 11:16:58 -0700 (PDT)
Message-ID: <bc15138c-211a-4b97-8d64-45d2d11b21e9@linaro.org>
Date: Tue, 9 Apr 2024 20:16:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 03/19] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v3-0-79f23b81c261@linaro.org>
 <20230911-topic-mars-v3-3-79f23b81c261@linaro.org>
 <80c0ecb3-1157-1d7a-0829-c3b68b65f17f@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <80c0ecb3-1157-1d7a-0829-c3b68b65f17f@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/5/24 10:26, Dikshita Agarwal wrote:
> 
> 
> On 3/27/2024 11:38 PM, Konrad Dybcio wrote:
>> To make it easier to understand the various clock requirements within
>> this driver, add kerneldoc to venus_clk_get() explaining the fluff.
>>
>> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>   drivers/media/platform/qcom/venus/pm_helpers.c | 28 ++++++++++++++++++++++++++
>>   1 file changed, 28 insertions(+)
>>
>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>> index ac7c83404c6e..cf91f50a33aa 100644
>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>> @@ -23,6 +23,34 @@
>>   
>>   static bool legacy_binding;
>>   
>> +/**
>> + * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
>> + * @core: A pointer to the venus core resource
>> + *
>> + * The Venus block (depending on the generation) can be split into a couple
>> + * of clock domains: one for main logic and one for each video core (0-2 instances).
>> + *
>> + * MSM8916 (and possibly other HFIv1 users) only feature the "main logic"
>> + * domain, so this function is the only kind if clk_get necessary there.
>> + *
>> + * MSM8996 (and other HFIv3 users) feature two video cores, with core0 being
>> + * statically defined a decoder and core1 an encoder, with both having
>> + * their own clock domains.
>> + *
>> + * SDM845 features two video cores, each one of which may or may not be
>> + * subdivided into two encoder/decoder threads.
>> + *
>> + * Other SoCs either feature a single video core (with its own clock domain)
>> + * or one video core and one CVP (Computer Vision Processor) core. In both cases
>> + * we treat it the same way (CVP only happens to live near-by Venus on the SoC).
>> + *
>> + * Due to unfortunate developments in the past, we need to support legacy
> why unfortunate? please re-phrase this.

It's unfortunate because another binding has been created to
represent the same hardware to solve a "problem" that could have
been dealt with using a couple lines of C and that we now need to
carry support for.

Konrad

