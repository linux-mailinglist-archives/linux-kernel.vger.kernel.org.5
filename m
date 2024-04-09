Return-Path: <linux-kernel+bounces-137156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A05389DDB8
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 17:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CA86B1C22A0E
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 15:04:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAAA12D210;
	Tue,  9 Apr 2024 15:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibExW2lO"
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BA6212FF84
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 15:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712675062; cv=none; b=WmfD44Tic4DvPtq441sEyHaXRzVLlGsB8S9BGoR3wSXrvFzdVLgJprnLQaXCtzPFoI04yEZAyHpqx+PeHc+CFVRdvFj32K/4EgGJvT/Ct/px7EiOGgU/cDMNelomlNrBF/zq2c90aDMTlfLOs6ck+vivvqJ5DVBd8xQdgP9Ylqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712675062; c=relaxed/simple;
	bh=ssen+WDRW3hqF3y3gAI7KjfM6Zb3SAVS5pRaVtu5ya8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AFDH9AdOnd7gnsDuDT6l622mzJ+V1HpGV8AnuqA1qR/h27vvJ11fcfgka3GVaOEK+1YdaRAOIbOXvDWmCpJvqXRD9KSqw6gsVmB+8l1/0JpGqkWokJDvOIZPQkZPBxDGFkVzJesyhqJ7nE9dFx9EpiyGFwfVLZPa1ZrPVpla1KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ibExW2lO; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2d8b2389e73so6010811fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 08:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712675058; x=1713279858; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3YM+s20cdEdse7t7bN3iKiAdYaiSxxuKdZKKsCgmaYw=;
        b=ibExW2lOTRLTYJMF5CjRfqUXmoTJKkGQ10QXFP6JYNALJP5NdP8ZnajpNpEZXMj7HN
         fhVrEAe5Jyr02ARfUIKLeqmBM03/wWCAt3b41O4SK5owlMmOdyDoOP+zovzC0VelOFsR
         GL66zVe+G5NbXn3qVY1F8Hdq6JQD7pOBxtw5/k/U91ULHutRbEiltMBQDvP7Xp5nOnod
         CH+XWbCR32sJS6xUgBD6o1tSHdhTBcT9sUMZJnTNavp2wCurVRsFCLTU1+q08qeDVVT1
         a996YyzSCjcFsRKu7d2SJM6DhXFTETCztVDQpVqQfbh+sooUK3/8meEJOF9QN8tdx49z
         BotA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712675058; x=1713279858;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3YM+s20cdEdse7t7bN3iKiAdYaiSxxuKdZKKsCgmaYw=;
        b=TDyLc38iO3CWukAB5QzezsXfeUDDcIMpKwYsHDF2EwxHZH6UppKSHkd/OvKpuleDp9
         z9GQ14mOk6H0o9EAUWsb0du5PeAiJIwPEC5/o2UjxbrZMx9y9OtShGpaJWKoRPUytTtK
         EoTJ1j9C6AUJJH96bGd85Uujaoyx6Gkavfcn2qTch9r6CPZbvd9W5VZ1ojAO7sIkV9WZ
         AhvSbY6rGt/LTHZvzg2BrhycyPgn0RFJgZrr1VsOgSmqg/ny84ZagPChcDxA9XwMfPQD
         XsVwq8mr+m2Ah7ZTnVTJ/mNzku6Ntb97vkpWQcovWTJsF+lcVaIRQ79fqtUe0XrUhLyX
         ogNw==
X-Forwarded-Encrypted: i=1; AJvYcCW6WJXfOCscRqGeSjuOrXQ8dff9xY60LVZgpo8wbSr9zuhL+yu+hi55L0qsDhyT0QAs9P4ai1yn3iEtdOqjBfCYQuHSzYr7HJIVL7f8
X-Gm-Message-State: AOJu0Yz/Gd+96LlNNyqOKDyGzesG17N9HzmsGHRRRkAnyntxS3O57Aki
	b0gbBosx3Wzr/+ar7ZNqpwR2uR4+olND7ecP1Z9Y6rKceJutvKmKYYbZ/ilSiaM=
X-Google-Smtp-Source: AGHT+IGoHv754pdfAq6TjWUEj3Tebb540y8BjG8KDvn0k1jGyKTq4jOdTq4eg0QQygBFoeLLrn8fzA==
X-Received: by 2002:a2e:7d12:0:b0:2d8:7200:38ff with SMTP id y18-20020a2e7d12000000b002d8720038ffmr64570ljc.24.1712675058205;
        Tue, 09 Apr 2024 08:04:18 -0700 (PDT)
Received: from [172.30.205.99] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id j14-20020a2e850e000000b002d88d978484sm841131lji.132.2024.04.09.08.04.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 08:04:17 -0700 (PDT)
Message-ID: <a8ea0f53-40c0-4fc5-94fc-a88f8e0319ac@linaro.org>
Date: Tue, 9 Apr 2024 17:04:14 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/6] soc: qcom: smem: Add pcode/fcode getters
To: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: Bjorn Andersson <andersson@kernel.org>, Rob Clark <robdclark@gmail.com>,
 Abhinav Kumar <quic_abhinavk@quicinc.com>, Sean Paul <sean@poorly.run>,
 Marijn Suijten <marijn.suijten@somainline.org>,
 David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, devicetree@vger.kernel.org,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20240405-topic-smem_speedbin-v1-0-ce2b864251b1@linaro.org>
 <20240405-topic-smem_speedbin-v1-2-ce2b864251b1@linaro.org>
 <zc5u7ixaser6ekl3sltzxccstu63tpydxybquxz5hcasj4cmfo@csjwfifugeod>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <zc5u7ixaser6ekl3sltzxccstu63tpydxybquxz5hcasj4cmfo@csjwfifugeod>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/6/24 04:21, Dmitry Baryshkov wrote:
> On Fri, Apr 05, 2024 at 10:41:30AM +0200, Konrad Dybcio wrote:
>> Introduce getters for SoC product and feature codes and export them.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---

[...]


>> +	/* Ensure the value makes sense */
>> +	if (raw_code >= SOCINFO_FC_INT_RESERVE)
>> +		raw_code = SOCINFO_FC_UNKNOWN;
> 
> This looks like a c&p from the previous function. Should we be comparing
> the raw_code with a SOCINFO_PC_ constant?

Looks like!

Konrad

