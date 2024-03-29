Return-Path: <linux-kernel+bounces-125165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E1422892184
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 17:20:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F771C2427F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3769B85C52;
	Fri, 29 Mar 2024 16:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nyunFQHw"
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DAF85942
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 16:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711729244; cv=none; b=qiN/JzRiPftSefZRkXvfdgrmtgI3orYdpcPNi6N8aRodYuB1kocGrdvXMpibs4pbNqGCWxnmNeJLraV+meUNwXNMewsmsm4t69qHPH/XKZncjBEhCleg74Qb57dLWgXnqJRoiwWpH7mFptE6W2hviKfDlTLOGLn9shpjKQXCvLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711729244; c=relaxed/simple;
	bh=aNV9rU7rNrtAHY4j9cGg2iNrlDQzSv+NWW6nridB+o4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UBhGVmkoq785tkoaknOjCHYI8o2bSbvXj8BOdpfEdLcTxDASBE2GCQhnOHBT94X3Oujuhk5NRxNYnKP/iK18+0ly3PGwpX7Yy9kReAZkjAs1F0+DrAt0GLXqiIknNh19YOYXXerM7IQVlJlHvpo8L7YJyKWpo4pP1dsBPBr1A30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nyunFQHw; arc=none smtp.client-ip=209.85.208.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2d6fd3cfaa6so29761341fa.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 09:20:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711729241; x=1712334041; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nv3nKG3kt1KExo6n8MktRZ2ubBO2o5feKCsd61d5ipk=;
        b=nyunFQHwBy0+TCKUoThhWMuGSOkvKrgYWjmJKo70EsExNouwEVj0aGjD8CfFDPt7Qv
         /dE3ql2uUNCVAQWmJhGiasfTx2i9t5sgaEUhehcQzEOE0sMuig40bp4XaHxDbRTMQksQ
         p4aRcNq5b6xXLpG5foe2Td7Vh4Opey44p0IKHT5sxFBnfeGPUFosJRaHm2w0l41/BHa2
         LEWBTw5OYmsL9JzpSRL5ZEF/e4o8rDlTNNoaFH4DArKzWv0rvqKw8v0fgB4HRcpLWf3I
         N395qSRmpKa9QYVzrtgl5eewTxVS056hZqTMcQrm3c5SbZfKGh1mn5sdQic5eiAbX65E
         mL+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711729241; x=1712334041;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nv3nKG3kt1KExo6n8MktRZ2ubBO2o5feKCsd61d5ipk=;
        b=CkLAPM0V4so6u3InpTWM3DhwCInW8t3DlkSZyv84m02yMopIPbS8BkNiypeCjTNPcR
         UiWgHXBhK5ZGYTomjUO8kvuWgT6j/kd6Z4ibcixHrFmkLZuwl0kC6BiqUzIFoA42AuHd
         vHPbYam/jBDifvW5+Vo50ga6Dm3nMbu49IYFkbvbJi31QSB095eAv/Rxlc57IH11Y2XJ
         a3jaGD1TqnvAz6Gpj5dhH5Gc5pFcXW/Q0PjT1cobsFIrR3NUcZdnlvomnmGNrihoogIL
         g1wQL7oPwjKsRqVEl2GRq9VMZVkAWbNa0+KoMm0QJ9BYTb6hD11DMBTordB0+zTD+e5U
         iOjA==
X-Forwarded-Encrypted: i=1; AJvYcCUK1qESmk9CpSfo8mMWVMGBb60rBZSUXCbjBzaWWcjU4w3zO5VfLH1/gUyTxHeVKux7S82iIYBYHoY2zU4rhHxMJEdovL2bb4wVY8OC
X-Gm-Message-State: AOJu0YxJusSCmFs1iKaoIPsu/08nlV3+T4yel1hkK782z+qbp6UTq/Xu
	qqQX1efRoZH/wtqM02mXKtvOYR0HfmSfBQOvELRwdqNVdKwrMc9uJt7im+umkp4=
X-Google-Smtp-Source: AGHT+IFkqPrhomWaxduOdYh034fYe2OmWOQleSdfiah9gsEO+++4wFQjI0nbDJP5t3PvIV15vROuyQ==
X-Received: by 2002:a2e:3c12:0:b0:2d7:1731:191d with SMTP id j18-20020a2e3c12000000b002d71731191dmr1357519lja.3.1711729240746;
        Fri, 29 Mar 2024 09:20:40 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id n18-20020a05600c4f9200b004148c3685ffsm5964877wmq.3.2024.03.29.09.20.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 09:20:40 -0700 (PDT)
Message-ID: <16999076-4ec6-4193-8a90-40a3f530a0b5@linaro.org>
Date: Fri, 29 Mar 2024 17:20:39 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] thermal/drivers/tsens: Add suspend to RAM support for
 tsens
Content-Language: en-US
To: Priyansh Jain <quic_priyjain@quicinc.com>,
 Amit Kucheria <amitk@kernel.org>, Thara Gopinath <thara.gopinath@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: quic_manafm@quicinc.com
References: <20240328050230.31770-1-quic_priyjain@quicinc.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240328050230.31770-1-quic_priyjain@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/03/2024 06:02, Priyansh Jain wrote:
> As part of suspend to RAM, tsens hardware will be turned off.
> While resume callback, re-initialize tsens hardware.
> 
> Signed-off-by: Priyansh Jain <quic_priyjain@quicinc.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


