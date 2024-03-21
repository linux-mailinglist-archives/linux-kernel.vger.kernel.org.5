Return-Path: <linux-kernel+bounces-110495-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC35885FB7
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 18:26:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B03661F2484F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 17:26:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E6CD133406;
	Thu, 21 Mar 2024 17:25:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q5fmhoDq"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D77913175D
	for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 17:25:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711041936; cv=none; b=cHyWKyGc9aG5DpcsUwwKeh9GKezue6FMOgvUBiQY5y9qV0TqQuTtfpjnve5AS0cC/uKKC+oBPPWtlUaUPuPCr0bfTBfWlnrHbwcllnzyt0bSdsPwMq2isfwtH4CI4Y1cfQtJBILaxwoNjRq7rIHRsJ8TbC1WstR4CQWF6UR0FzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711041936; c=relaxed/simple;
	bh=tzLyvs7HcITvZy2SLeDlzKPKDAvxzPz3QeAl0srd2kM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GO9tzB2omqDH6TbG7xrDtcPKJm+zxVkHsbkDXAb+XI3ytmky7qKbv6MBRf7Jh8HZPHCmOEv4OFf4frfy7fA71FkXqJNNVqElcBY/VsFwnoDHHiZwBxFvc+oFfZff2KGmzuCSmGWgrBdAA5fXanM6Ak5SH2pfpwHJg955zjnaDGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Q5fmhoDq; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d46c2e8dd7so15020771fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 10:25:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711041932; x=1711646732; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tRBkydo4iL6GNIo9VuK+sRcHXGRAdy7FiD0d40q49mA=;
        b=Q5fmhoDq1p7ZKB4byx+fxOQBu64C4ohyu5MfzDHeytchUE8sGzOIkWaTDhLt+oIXCu
         vzjve0oFRgvKiaGHlxcIFmrmSaERKHNHnNLJjzChH0lR5d65c/lkFQbPuxCh6CeV8G2r
         avbvhd2sn1YZxLJsFxtO1uYr9HYPYq9xseJy09QMMwo1suE/iNZzXZgCHjfBCKa/QeUA
         KspEPUY1quCgYq5JXAMv5Uvsu1AMhZ0d285QADx6TcSVe377nPwhq1QvG3NGNx3yWePd
         pB/PAWMA4zS0cE8u8pFs8WmTIr2DB7WNjYpe77AwPKDqzppcihw2XW9jB5EnzZm3Bcmd
         U1+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711041932; x=1711646732;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tRBkydo4iL6GNIo9VuK+sRcHXGRAdy7FiD0d40q49mA=;
        b=DT/kETg0Hd1jvU7W4RnQRubg5fs33r/OKxcLrtBT2/b6rq+n4BDI2e/PG2lyRvdZCe
         NC1sgArkc7auTqBiQr6g/UtfgmKHbCc5WN2XGkn1ZKHKmMZwRf4Cdiv0iSeemalRWE22
         WvS4ItV/Xf+DCdKE6cr/eBSTHtCIgmepXNqvlzpWMRqK21cdKqnACDxGMEkip7cVMkJk
         kgi5hLrZY+IW5w6bk6gPRyRzS17HOP81XQNtoa1xVejexwC8wftH8Dfa41CkSvaOxpqF
         92UqvTys2x2NNh5uhsRO4QVtweHdzEBE4cf/o82VvpV7AdduD1Ti5aXIKrnw7EcWEXWf
         Ktpg==
X-Forwarded-Encrypted: i=1; AJvYcCWtW1tczDxOyNKfVCgxHrjY9C17PufkndKgwSiRmrIO+ztgcicAbvnbBlsxPiSHDlL41Z4dTqMIolR7OQ8F9cGr8UQAcAUruTPcNM/L
X-Gm-Message-State: AOJu0YymsYJaS2WnJ8/OgmjY8Oqi5GhDyAeHqWHeHybt7b8rGoBy7LrQ
	LsH3ipaxxBb7idg/dO3T0o7r7K9DAKFYe8YfrX8yVLbY/l+oCdoGNjuMvM13Kk4=
X-Google-Smtp-Source: AGHT+IHrN9hd+5miWuYAgdozoiw3KTFiep55MuLkXG8T+NijirFPCwjWqLRb4mVSGYXrrzSiJ5bWMw==
X-Received: by 2002:a05:651c:2ca:b0:2d4:6d12:71f7 with SMTP id f10-20020a05651c02ca00b002d46d1271f7mr117412ljo.15.1711041932431;
        Thu, 21 Mar 2024 10:25:32 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id i2-20020a05600c354200b0041464451c81sm385263wmq.20.2024.03.21.10.25.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:25:31 -0700 (PDT)
Message-ID: <ebdeceae-62b6-4674-ab19-a3252d52f296@linaro.org>
Date: Thu, 21 Mar 2024 18:25:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/31] Clean up thermal zone polling-delay
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, cros-qcom-dts-watchers@chromium.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240319-topic-msm-polling-cleanup-v1-0-e0aee1dbcd78@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 19/03/2024 17:13, Konrad Dybcio wrote:
> A trivial follow-up on the changes introduced in Commit 488164006a28
> ("thermal/of: Assume polling-delay(-passive) 0 when absent").
> 
> Should probably wait until v6.9-rc1 so that the patch in question is
> in the base tree, otherwise TZs will fail to register.
> 
> FWIW, Compile-tested only (except 8280).
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Are you sure these changes are correct. They are not related to commit 
488164006a28.

If the sensor has interrupt support, then it can specify:

	polling-delay = <0>;

As a zero polling value can be omitted in the DT then it can be removed.


Then when a trip point is crossed, the interrupt fires but then it must 
sample the temperature of the thermal zone to do the mitigation.

I doubt polling-delay-passive must be removed. The changes you 
introduced just disable the mitigation and that will lead to board wild 
reboots.

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


