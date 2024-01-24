Return-Path: <linux-kernel+bounces-37063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1E1D83AADA
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 14:23:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 996971C29582
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 13:23:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2659D77F14;
	Wed, 24 Jan 2024 13:23:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uD0zyZ3W"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C577F00
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 13:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706102584; cv=none; b=BgibrN7ae50RT8OyBrwpcEaAE+S3T5xFrMyPpPsaoJqTChPwqg1t8o5aj0D88YKAR0yG8hmjcj1fPfbHWBoLo8utHbW5P9az426RNAtPpJMdfEtG5FC2RvqKBOBtpi6ks4kJgZBKkHgNvA1Rlj8kPGdGeZb51Vs21iGYDXUVLS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706102584; c=relaxed/simple;
	bh=T4RmIf7VkFcj8d4ZpyZYR6aCfDUYT5c7VXzocciPTWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TmIdcJUs99iTr5Zm9XvXeUlF8gIm5L/Q+qWlkqjEWKxFhynO1xDtNuGr8od92DhXnJ3yIBqhkc/80J0l3X56rOXGatEa+hBsMWTxHSbfgR+gBUqJutyE5XFk+nDBGxj9qzhWDUMOM1AouLDGLzfjbSwpHaBUODPasS/MglNHrEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uD0zyZ3W; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2cf0390eddbso34224701fa.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 05:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706102579; x=1706707379; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=11kgJruv5+K6DtBwAzB0hg6cqT5dVQUnLRiLI1MHmYk=;
        b=uD0zyZ3W418Hxi0Js3RwCmxwiRCtoGnjxb0h0/tQysBALQdB2/OWkRmEsDP2gBSNw4
         kaN/W34x9citNgxI9wqsLmvQnVKUdluigoZhVN5uRf/mGO8kIZirN2s/O7F1FwA5TJq4
         VnVUhdyFE8T8bDyd2Gi9kYOIAgkTSXyUvEZOb9LyDwLd2vPZhgaapsEW5rnzneRnX8bK
         CR2zMjEhL5ypjwWUc6q5b3G3G3reCCEDS+uqQSUq7CSdV9G5i9XFvL2DCRA7uXwET6tF
         mAMvnDM9BcVqjVjU8lIjya4EZQKKgAerx3BnqsjHpzJOcqLIIRKQpJlZtSAkClixNDm8
         3gbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706102579; x=1706707379;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=11kgJruv5+K6DtBwAzB0hg6cqT5dVQUnLRiLI1MHmYk=;
        b=pvQ/dlGuLzDf/fR3dT1R4WRtQaj489Ek/TKfkhfZheLz57cT9+7+8HNY4uRBMVMQ/4
         qy+z2eUMbp0Y1gMNx3qnXldCIQuZurHyssYNpp6MI3gK86pJe4IBHj5SvWiw1yDL0M7G
         oBJUemi/9H/7iuLjzwY4MvE4C9PyijloAJ8S7DCtaP81Wckx7pRf/5gB1a/Tq2zYSisI
         vNR7AaK3VHKf984+ozO2kk5n61rJebSJj4cZA2EZk8uiaO1NcmKW+4bKvIyA9C8nc26n
         GdKXrWjkx/leJJkbpzaW62gCt7LP9N8iSKiyNVBfGc1n3ujVWSLV1XfilGpZnAytEtFF
         3JiA==
X-Gm-Message-State: AOJu0Yxm1FRTUdVO4gBn5ty+w0LVaWalwZQN2Is0htLLPbV1L/ay4zFK
	Uz+9k7GpG5nH1NkKNltTrzuu6Dejj6BadBnwapgCoFfvr0w2d4ktBkKflgKRZ98=
X-Google-Smtp-Source: AGHT+IGCJx8XZDV9wXehwa6+blBx6gU7Yw+6Pl2WRXQb/rId7vUfO2+yja1A4V5G91EOYOUuQjTl2g==
X-Received: by 2002:a19:4305:0:b0:50e:6909:7f68 with SMTP id q5-20020a194305000000b0050e69097f68mr3327351lfa.117.1706102579410;
        Wed, 24 Jan 2024 05:22:59 -0800 (PST)
Received: from [172.30.205.123] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id u6-20020ac25186000000b0050e70a5b804sm2589732lfi.302.2024.01.24.05.22.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 05:22:59 -0800 (PST)
Message-ID: <9feae876-5170-4b57-8cd4-dbf35dddbefc@linaro.org>
Date: Wed, 24 Jan 2024 14:22:55 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/14] arm64: dts: qcom: sc8280xp: Drop PCIE_AUX_CLK from
 pcie_phy nodes
Content-Language: en-US
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240124-pcie-aux-clk-fix-v1-0-d8a4852b6ba6@linaro.org>
 <20240124-pcie-aux-clk-fix-v1-9-d8a4852b6ba6@linaro.org>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240124-pcie-aux-clk-fix-v1-9-d8a4852b6ba6@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 1/24/24 08:36, Manivannan Sadhasivam wrote:
> PCIe PHY hw doesn't require PCIE_AUX_CLK for functioning. This clock is
> only required by the PCIe controller. Hence drop it from pcie_phy nodes.
> 
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---

So, I have a small phytest module that basically does this:

phy_get
phy_init
phy_set_mode_ext(PCIE_RC)
phy_power_on

To load it, I skip PCIe init (comment out the node), then wait for clk
and pmdomain unused cleanup, then load the phytest module to ensure that
I'm not piggybacking off of the RC's resources.

I tried it out on the CRD, on PCIE2A (NVMe)

Without this patch, the PHY seems to init fine

With this patch, I get:

(1) qcom-qmp-pcie-phy 1c24000.phy: phy initialization timed-out


Kicking the PCIe GDSC from the PHY, I additionally get:

(2) gcc_pcie_2a_cfg_ahb_clk status stuck at 'off'


I think we expected (2), but is (1) okay?

Konrad

