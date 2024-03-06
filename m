Return-Path: <linux-kernel+bounces-93965-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F2B5873795
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 237131F2130F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 13:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C098130E2D;
	Wed,  6 Mar 2024 13:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DZ9HSJKp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D0A112D742
	for <linux-kernel@vger.kernel.org>; Wed,  6 Mar 2024 13:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709731174; cv=none; b=h/WYg04lkxMPMynlbRfQLEiG1QGb/CNi9MO7Et57GaNIzPtSVaLNY+wW9NsFAOttLJwkTiXfznepsnOBKOCPGm8sBlVB65a+mg0P1cYQM0iZISZ1GmsEMxBrVWB4HFoOMfWydVj8Vs5cWuGjFVhHmb5zTpt9tGE+UsObtXQcWT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709731174; c=relaxed/simple;
	bh=+1UnuQnf/LyqbBxxuD32IaDzT1t4IRlkFzEvr8mcnvE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NH6kcdbvBRV9c0rp1SI6/Pen3HuohqNUaDlZ3UjDkn3wr3Rf/LZsyvT853etGCQ1EwBNVnUMaN2vQKRS3J33dFBDUZqlIN65Hmi66DgzEQbL1ZH9FDj7kmPju/PHQVm1Zx/VmoDkp4DuW0FeePc+28/Q3E63O0ypjE6LoKM1ip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=DZ9HSJKp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-412f692be21so4018535e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 05:19:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709731171; x=1710335971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=f5cNrhfZq9pdhzlYdh0TnEQMMStZp8mSh+S72NM+w1E=;
        b=DZ9HSJKpwDpiPaWokcT2Wv27Xan2794lpkNJy0gdiOSwUvJeWPMj74Ru8UOwtJRNbJ
         kTxEuHMW8n0JmVxGDL5gPlNhLIZNQwxr+wOqhbbOlozAhaZ1C2GfE+h4y9lUWU9QXBFS
         esegUvNg4D9ewwo5cY3AS/LGuIAsArbJM1sBUgF/SfNBhyjNITpoTOYQxbwrg3DTeUhd
         rY8cXCrhJEo4SazBLh/MVmfLz0zujOAlWHPPK8yyhmDVSlPRm8N8lAp7yPzpggNDqZzT
         7k1Q/QBPu3iSuXB2V7+d8S1KMLELPVcOAIIaGVJlzrL6V+hdNFa4EoAmy47UjetoSV3P
         dTdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709731171; x=1710335971;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f5cNrhfZq9pdhzlYdh0TnEQMMStZp8mSh+S72NM+w1E=;
        b=xCyxtbFEfVjZN24Tl6xiNcLLwB5x7IdaVh4qhRAaoui401vTb37xAC+UAIId5V3RP4
         5XCjhq8vPkB8uiUQD0iZGnhM5BF6TqCjUtKsG6KvhaqULS/gC+GtT7XwIsDU+K8E/5fY
         xtjvWmj307o1RzHdz81zak+dfkt0bnkk+mB2OPPruC3j+1Dc8/0qyWPMN3x8BrDSFBhi
         +xCgkOwvFXDCizm2Vp+meZccmhzmYleF6JMVO0h/X7aif+6pRs7/IL1IA+MHOfRkd1wc
         GvCPZQfxPzpAspoZhi00SmvfjBXIRSFPwHT7lGJGdIkCOXjHvWov8/b7xrdVSJQtAXF6
         NKeQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxv3dbaD74k0B68N6G8lHPBMYHpr7In7zwMlRyXi69YlpqmeibnSv72f7K6Flz8I78Zdl/vTo/RRzYYdgWCenUVLm4qTSNS2OKpWRD
X-Gm-Message-State: AOJu0YweGWuVQxozgh3RC6498Vazpfwrj/6ZDLVPYT/by8ugSpZOBjc7
	E4QGbVQFpkPtSuwbFkPE1pS43m/KX1ueWiG/xYs3g3i9Ada5dzFS1b2WS2+C7LM=
X-Google-Smtp-Source: AGHT+IGXrx3fxcNvDo/dCTnXE23sKVj53w6gS0mbDdpoUEKKWG4Jh7EN/sGvulC9XnL8uUGbmWo1sA==
X-Received: by 2002:a05:600c:4749:b0:413:410:1642 with SMTP id w9-20020a05600c474900b0041304101642mr13628wmo.10.1709731171651;
        Wed, 06 Mar 2024 05:19:31 -0800 (PST)
Received: from [192.168.0.102] ([176.61.106.68])
        by smtp.gmail.com with ESMTPSA id a6-20020a05600c348600b00412f778c4e3sm1544564wmq.23.2024.03.06.05.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 05:19:31 -0800 (PST)
Message-ID: <6cfda2b5-b5c9-4d03-87a6-1c31013ecacd@linaro.org>
Date: Wed, 6 Mar 2024 13:19:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/20] media: venus: core: Use GENMASK for dma_mask
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
 Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Andy Gross
 <agross@kernel.org>, Bjorn Andersson <andersson@kernel.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Dikshita Agarwal <quic_dikshita@quicinc.com>,
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: Marijn Suijten <marijn.suijten@somainline.org>,
 Stanimir Varbanov <stanimir.varbanov@linaro.org>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20230911-topic-mars-v2-0-3dac84b88c4b@linaro.org>
 <20230911-topic-mars-v2-11-3dac84b88c4b@linaro.org>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230911-topic-mars-v2-11-3dac84b88c4b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09/02/2024 21:09, Konrad Dybcio wrote:
> The raw literals mean very little. Substitute it with more telling
> bitops macros.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>

