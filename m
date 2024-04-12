Return-Path: <linux-kernel+bounces-142769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96F308A2FE7
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:53:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 00F57B23ECF
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49E1B84A37;
	Fri, 12 Apr 2024 13:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eX0d57Ux"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F0127FBA0
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 13:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712929982; cv=none; b=KsXgE/HLWDdTR/hWXigS1C8HSU9dr7tuxiJelWVdb/DN9R+6KY4zqPENCQmtw+UFeU/iOEllT2q/fWDNaayzbrkJXT35Abhic38peEo1y82oWCbmkc/THbww35SM0RgCrRtYs15MWgr6c31AxQb4tgax0+ZcHp6vbkC4iPMpIbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712929982; c=relaxed/simple;
	bh=lmYHzw6QDccq7zE9WMD+hghdZZp/DAeyoyWN+65IBI4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pOTzDmSLxZbhItJsPU2cOFXcH1rvrlu/Zd0HtPKCNORF9Mc6BnidX+DG4RRw7GY/BjiJXEXAHiZZ4nwGMyGbGEtCmzwz9ATeDJbIfZpndhEOAIH97ftNIK0ha6l9eMnEO28DEb1IXSMFS0GMyWnjRsdoWruOpGDNl1oodEf5PBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eX0d57Ux; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343cfa6faf0so698929f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 06:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712929979; x=1713534779; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rEAfIJh3npv+ugJo42LqSvAY6wk6qnmEdvhAb3YjCy4=;
        b=eX0d57UxuBfPTp+hbVso4wVaUHVJ7bcHaIV24+5sCC9DotBYqKLUjoWPACK78bQbCA
         ZhQbnguj3bBf5kIArT02iiN8kzAyfhfOawsgzV+D1z4LclDH6xhkGpBJWXMOKYaPYb6Q
         FcpLTAgQV+2TuKp3Nc+8dK0uv9yyftFbD2PTWGirTrH+jONRuBBpGXrgrnU2OPxkVD+P
         boZhbE4VWpiTTOQaUmCsCEQ+PdV5auPtCLfg4Ee6zux+NM0DDM0VURfvpYeIJ8a8/22h
         3JcJVD+pBWMSe2oJ3aYqGMvu9oqeNss54iUw71J+14LnyuPT82xgGVJbGMmmrDWTDoQl
         WV7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712929979; x=1713534779;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rEAfIJh3npv+ugJo42LqSvAY6wk6qnmEdvhAb3YjCy4=;
        b=XPuo0wOLgoYfZXEp1tQbWKx3kuOV4gt/Xp4WA0rPhPv2QCIv4w8x/Nl7aJVyxNvTds
         nbrPxsL86m2hUWgTYb/Uiuwuiim2wUUtqAcjkDtS2VspmvZ7KUOJ8tXX3EsujdVwJ5CC
         dALC5aY/DRFNUoT53Of3Eo9osRf2oiIZbAo83bS7ytqcwgMQBkZzbusAIiQvK2/aEagc
         Qw5KvcYjBd9ybjrJ0SPYDbMqF8liwDkLvybqLjwek1L/pSEDWBdmKBCj0+pNXdmDPVZ3
         5GZsTzffCFwCAOX+Bf0GFGlBtpCwLCcmS/3YJw6UYZoCPPGMe1zcHVmKHdo0fTbUaa46
         SeFw==
X-Forwarded-Encrypted: i=1; AJvYcCUFtroFNg7LPjVvXrfrvtwRXDajQ+Fu5+Xt99cVly0fkdHgROO0mC6Ah/rCacuwB90DDR536FuzSbHdleJNBz0i04RgEywSu1P53xgW
X-Gm-Message-State: AOJu0Yz3JV4iVGPgA5AvfR6PRKJUGVZZvKrKAX8JYP572OEbm0t//bUo
	/nHJhEinxaESV8+wn5sGjmqu4+LoPqKijoJzAiwy7X1nStyVssbjngagpGvGnXE=
X-Google-Smtp-Source: AGHT+IHDe7iQ4Smu79z5KPqwyl8s3cTUQEWyP7LPDjNtdzPBYwjyRu9Oou1yi7ssHkfwe/1Dz68KgA==
X-Received: by 2002:a5d:4f84:0:b0:346:66d8:f7ac with SMTP id d4-20020a5d4f84000000b0034666d8f7acmr2310175wru.31.1712929979425;
        Fri, 12 Apr 2024 06:52:59 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id bg25-20020a05600c3c9900b004162d06768bsm8985908wmb.21.2024.04.12.06.52.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Apr 2024 06:52:58 -0700 (PDT)
Message-ID: <e9a3eede-f910-4bd9-afd7-1b6117cf6eff@linaro.org>
Date: Fri, 12 Apr 2024 14:52:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/34] Qualcomm video encoder and decoder driver
To: Hyunjun Ko <zzoon@igalia.com>, quic_dikshita@quicinc.com
Cc: agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-media@vger.kernel.org, mchehab@kernel.org, quic_abhinavk@quicinc.com,
 quic_vgarodia@quicinc.com, stanimir.k.varbanov@gmail.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <20240412071325.810465-1-zzoon@igalia.com>
Content-Language: en-US
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20240412071325.810465-1-zzoon@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/04/2024 08:13, Hyunjun Ko wrote:
> Hi,
> 
> I'm trying this series of patches for enabling /dev/video0 on sm8650 hdk but failed.
> After modprobing, lsmod says just like the follwoing:
> 
> root@hdk8650:/lib/modules/6.7.0-rc3+# lsmod
> Module                  Size  Used by
> iris                  110592  -2
> v4l2_mem2mem           20480  -2
> videobuf2_memops       12288  -2
> videobuf2_v4l2         20480  -2
> videobuf2_common       45056  -2
> videodev              176128  -2
> 
> 
> This series looks for sm8550 device though, my question is that this series have been tested on the device (sm8650 hdk)? or do you expect this should work on it?
> 

Different SoCs so despite how close they look in version numbers, you'd 
expect at a minimum some clock and/or power-domain churn - even if there 
is a 1:1 mapping in register numbers and offsets.

We wouldn't ordinarily expect to be able to be able to move SoC versions 
so easily - 8550 and 8650 have similar SoC version numbers but, this is 
not necessarily an indicator of silicon IP block version reuse.

---
bod

