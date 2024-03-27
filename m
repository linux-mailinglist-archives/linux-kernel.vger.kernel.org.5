Return-Path: <linux-kernel+bounces-120633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 865FA88DA9E
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:56:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B76501C245D5
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 09:56:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 870B43BBD3;
	Wed, 27 Mar 2024 09:56:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b="O9YMWmJx"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EB6381DD
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 09:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711533361; cv=none; b=cV1Hv0qTKVnffmeFFWwLOcQMmfYHR9dMgCik65NaqzOS8tm2f3mXpufSnHm/p/p8JZhjgLfrYkuChqIvrwrOQX1RUq95k0w4ZdAA/Yj21pimWYbOJcq6Gts0slFSdAEV+PME/xPafaXh5V66BABi5xeri0pF/T+1gLSxUsd2fyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711533361; c=relaxed/simple;
	bh=bsl5mlaY8cNqyw4oUG32H7euTa4u8AfSfG4rvl5y9Qw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BauzGEUGkIa6Jq9y6vAGAe4AZfmDCUZydKVrBTPqT3RA3r93qqzFdbVDFhMidGPZB0GjwTvbSUGyTiu7W7ENQM8DCA75qjpCt6DIAclvFZ68OsMBGXeTcKd2u7ohm3hjd8T8ajnjnE5SIBu6b702NTrv5Kc+4dHmm47zpB97oYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie; spf=none smtp.mailfrom=nexus-software.ie; dkim=pass (2048-bit key) header.d=nexus-software-ie.20230601.gappssmtp.com header.i=@nexus-software-ie.20230601.gappssmtp.com header.b=O9YMWmJx; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=nexus-software.ie
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nexus-software.ie
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d29aad15a5so81610331fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 02:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nexus-software-ie.20230601.gappssmtp.com; s=20230601; t=1711533357; x=1712138157; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jSvnWidHd7x1wPI9eyKH1ULMOk/MMh1qH/IqJxdxFNI=;
        b=O9YMWmJxyTmLmP4Q8HFMVUUm5LcC+0Z7AxIJToprD9IMmfh/KN2dsIdgnSAayv7Zx1
         BrzSvWTykeYyGJgqHRM3mzLgLH6Qr7V0mZun6bkLCFybHLS7EB6rK08c6GK4gkPHmO95
         w+5Z82RhLPmP/AcElwFRx/Pu0tnIWugG4dRbAuj1WSKtME4IWtbb8WLcsLlRrGeAM1u8
         lAo9Xfy18nkxG82mYA3Jr+LuCkoOkOqrG0qzAb6+vuWRBRlNs0a0DKxNC/c/emBbcGtP
         8gdSHT+qSrHCUUA0WlhCMGLA94d0j04nJoBgIxrvcL11n5AgR1KOGwDaJwqILQ2kosjN
         z3HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711533357; x=1712138157;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jSvnWidHd7x1wPI9eyKH1ULMOk/MMh1qH/IqJxdxFNI=;
        b=gOdaws1+SW74cD2o3Pu3N79QSrx2MUAkagtRnRAn6eC2WNeRWYGreVrws5UmLEsbWH
         sjb1BecTaEYWt0fb6LvTEDKNq9HMRujq/84TdrP3aFpgr194flLgHu8dMvmNPdWYVRK3
         YWOQkP/v3WBCBq27SpAJrV/Z4IuK5pulPlR+BxKbSB86KRuxsCX1Q4SZ4Bf8mkueeaa6
         gHjfakit8zt71EFkxDQBfMw3cP5cQWqjLwSZBzvUwK4uRbkFogMWiTzVmvG/wdiMeGMy
         2ISfZc9iEcdOx4AK0U/H+BKPYznJv7fo4NzdJ4bt/ZbEpTIp5WKNnjoZE0vyYlTHi7We
         6xfg==
X-Forwarded-Encrypted: i=1; AJvYcCViwd85wJRs4GAbGt0gGDu7mHmDTP45y4b9rIw7JzITCmo8GXL6ljyJCyj8b6jA+QRvPh1FJZP1a1EquPtyKrVs8mfq9pgSCdYu/GGI
X-Gm-Message-State: AOJu0YzTHFAUFbpfrfs7ANfOu2HdDFHetNR2UTAmSB5K3jcWWB04cljx
	0qD2PQKVLTNSMdU5uMZ69E6CGjfP5sJOGQTHx4S0KHJ4xh5BITAKWiySWTKM960=
X-Google-Smtp-Source: AGHT+IFw/7ZLAi36bN7TwpWrmHEI/IaB3nTNikltKHCbY/u3xwMKPK8WN26Ir2ty+IvIQZGG0TLPYA==
X-Received: by 2002:a2e:b5ae:0:b0:2d6:f67a:cca9 with SMTP id f14-20020a2eb5ae000000b002d6f67acca9mr1150752ljn.33.1711533357297;
        Wed, 27 Mar 2024 02:55:57 -0700 (PDT)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id d8-20020a05600c3ac800b004149455335csm1532653wms.12.2024.03.27.02.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 02:55:56 -0700 (PDT)
Message-ID: <072aacd2-fedf-485a-970e-a705748cc92e@nexus-software.ie>
Date: Wed, 27 Mar 2024 09:55:55 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/20] media: venus: pm_helpers: Add kerneldoc to
 venus_clks_get()
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>, Andy Gross <agross@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-3-3dac84b88c4b@linaro.org>
 <b6d6beab-39f5-4f00-8427-52b662181864@linaro.org>
 <30945f7a-b18b-483a-bc43-99f913fb98c3@linaro.org>
Content-Language: en-US
From: Bryan O'Donoghue <pure.logic@nexus-software.ie>
In-Reply-To: <30945f7a-b18b-483a-bc43-99f913fb98c3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 26/03/2024 21:23, Konrad Dybcio wrote:
> On 6.03.2024 1:20 PM, Bryan O'Donoghue wrote:
>> On 09/02/2024 21:09, Konrad Dybcio wrote:
>>> To make it easier to understand the various clock requirements within
>>> this driver, add kerneldoc to venus_clk_get() explaining the fluff.
>>>
>>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>>> ---
>>>    drivers/media/platform/qcom/venus/pm_helpers.c | 28 ++++++++++++++++++++++++++
>>>    1 file changed, 28 insertions(+)
>>>
>>> diff --git a/drivers/media/platform/qcom/venus/pm_helpers.c b/drivers/media/platform/qcom/venus/pm_helpers.c
>>> index ac7c83404c6e..ea0a7d4601e2 100644
>>> --- a/drivers/media/platform/qcom/venus/pm_helpers.c
>>> +++ b/drivers/media/platform/qcom/venus/pm_helpers.c
>>> @@ -23,6 +23,34 @@
>>>      static bool legacy_binding;
>>>    +/**
>>> + * venus_clks_get() - Get Venus clocks that are not bound to a vcodec
>>
>> Get non-codec Venus clocks.
> 
> No, this is not necessarily the case.. these may still include
> vcodec clocks, that are specified under the root venus node (which
> is the only way we'd like to keep)
> 
> I applied the rest of your suggestions, do I keep your rb?
> 
> Konrad
> 

Sure

BTW, I plan to test this series when I can - do you have a working tree ?

---
bod

