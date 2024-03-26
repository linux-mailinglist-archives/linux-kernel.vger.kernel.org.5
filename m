Return-Path: <linux-kernel+bounces-120011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 033C988D01C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 22:32:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9719F1F811F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:32:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B89613D88F;
	Tue, 26 Mar 2024 21:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pEh+Bz04"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2D313D62B
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 21:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488748; cv=none; b=OvxYhYm8q10Keohtd7MsUigVCWJuRsN4fwTJFz1KsP7G1egKUfFzlKya1QwaRxJfn1MGmjUssEmE4NyC2KDOnLvEIy53SgOR2Bfto1ltCOqJsqfgJEaSlTmWfgT71V6RaxomWgnUbtFbL+d4SgqeG9cOKfj5gzK8Vz2DO56fVFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488748; c=relaxed/simple;
	bh=1dm40cDdeMpgpRTjQv0KN9TR6MPwebnR1YooLNmkU0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GPwItyId46rJ3UzVYIfuZ8ICGmRIMGEnw8Ev5+2/3ybdbVV0FpSQiuIAMS2NdDX2eRAkv2lqooDLyvulGu7XONdZiCUIaHqblLa8XnnyH1BvuxACK8V+pRNMGi9v5gdCcAYKNGZnbsvwnzGQ81HAQz023ZTPQuPgUocfkFz15x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=pEh+Bz04; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-56bc5a3aeb9so7931806a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 14:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711488745; x=1712093545; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=5V+UiNTGgTTrT1uOZTo3eDRM/tjDWB5U2T/YBxyC/vc=;
        b=pEh+Bz044mN8wxZlMGbUAsCo9/gX8rE9mvoPJ5tgp+KbORhVzlKelV0frkBSx8GtoR
         LHNw2r9c+HC21VHKX1mZ5ZwI74uVM6NaBGbBb8fon7BZDOv4Jz6DhsX1G+BEaVTvSgeb
         +ljbZA1WX3yt4V+7XZl3B8Ls+azg3NBXr/2CvW+okSNoTw1edudYruxjg+A4+rHPFakR
         hexin7ZPXk7C3U4FrVGYsg6DNNvJQ46xikQYeIJTZv5SAgKV7ppobw7Ck3x0hASEe+dj
         xhGQfdOKhr7TzxQis1RX3qxWf3pVxsV7652hnziVZC8yNMb1EnHfaKB+erM3CvwsD4HI
         illg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711488745; x=1712093545;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5V+UiNTGgTTrT1uOZTo3eDRM/tjDWB5U2T/YBxyC/vc=;
        b=LHtJne0Ck4qIkWZjQIOC79uFXp5Req0q5GRbA8dSQ6Be3KRqfz1Nk0GZ9Ih/MNRgcd
         hzqLeJgRmClKWY4/23xOSqkdmWEnhvhdZ3sFtPP0NmiHZYVya9CErk8IBWVWb3PSkH+b
         AYw9BBXYc5nbH6x/clv1UR8PMCMEv35kY+TF5/jBXw7hxb93WoqTLHkcBMr7a/ftuFr/
         5WAhZ0tcnrGrJocDPOrw0Cex6c4GHGaTgqvaKMMm5+Wl5oRs0qEFSJnb7j+CPvEqay/c
         5sfeM3cIlUEz7jes4K5DU4CeavEvhtZrKDTzt0J4xiKO7eK+eeuL/t0uVq9ZHupKxDqh
         qrgw==
X-Forwarded-Encrypted: i=1; AJvYcCUf43+uXNfZwg5hUA6Xg40JdvXkFZaULNHPP8FEu17uKPr7kon6bN0sRpJC7t6UCQEUFd+qF/f9Iw68f43NN7mtRQ0HvRp9D1/ZRXVI
X-Gm-Message-State: AOJu0Yx2iKO0oxRgXWvI+mgPv6GRheD1c+N+qpqIZ0S56aQBHpjztVgY
	/WBDhvemVoF3NXiaDU3dvFFEmxpTZEYojEyu2H37C+GrYLnNDCIt1/rGRTqS1kOOov9LAlq/sGJ
	2
X-Google-Smtp-Source: AGHT+IE1hkUVGjcL3n033Amye66iyg4mLT7F/pL/r9rm59ZY9BIJ01gdQm8uJOeoRJaN//19FrHAIA==
X-Received: by 2002:a17:906:c046:b0:a4d:f56a:199c with SMTP id bm6-20020a170906c04600b00a4df56a199cmr700957ejb.4.1711488745010;
        Tue, 26 Mar 2024 14:32:25 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id m10-20020a170906234a00b00a46ee3c31afsm4582471eja.154.2024.03.26.14.32.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 14:32:24 -0700 (PDT)
Message-ID: <64d2d15a-f5f2-4bdc-8f43-a7e8dd108ace@linaro.org>
Date: Tue, 26 Mar 2024 22:32:22 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] interconnect: qcom: qcm2290: Fix mas_snoc_bimc QoS
 port assignment
To: Stephan Gerhold <stephan@gerhold.net>
Cc: Bjorn Andersson <andersson@kernel.org>, Georgi Djakov
 <djakov@kernel.org>, Shawn Guo <shawn.guo@linaro.org>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240326-topic-rpm_icc_qos_cleanup-v1-0-357e736792be@linaro.org>
 <20240326-topic-rpm_icc_qos_cleanup-v1-2-357e736792be@linaro.org>
 <ZgMs_xZVzWH5uK-v@gerhold.net>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <ZgMs_xZVzWH5uK-v@gerhold.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26.03.2024 9:16 PM, Stephan Gerhold wrote:
> On Tue, Mar 26, 2024 at 08:42:33PM +0100, Konrad Dybcio wrote:
>> The value was wrong, resulting in misprogramming of the hardware.
>> Fix it.
>>
>> Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/interconnect/qcom/qcm2290.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
>> index 96735800b13c..ba4cc08684d6 100644
>> --- a/drivers/interconnect/qcom/qcm2290.c
>> +++ b/drivers/interconnect/qcom/qcm2290.c
>> @@ -164,7 +164,7 @@ static struct qcom_icc_node mas_snoc_bimc = {
>>  	.name = "mas_snoc_bimc",
>>  	.buswidth = 16,
>>  	.qos.ap_owned = true,
>> -	.qos.qos_port = 2,
>> +	.qos.qos_port = 6,
>>  	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
>>  	.mas_rpm_id = 164,
> 
> The mas_rpm_id is also wrong, I think it should be = 3. This looks
> wrongly copy pasted from BIMC_NRT. The qos_port on the other hand was
> copied from BIMC_RT. I wonder how that happened. :')

Looks like you're right ;) I'll submit it in a separate series, preferably
after this one..

Konrad

