Return-Path: <linux-kernel+bounces-93000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B069872937
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:15:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C60C1C22E63
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9EC312B170;
	Tue,  5 Mar 2024 21:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PDj8jKDj"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510B818E29
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:15:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673324; cv=none; b=YrLURmukvheD4tIjZrPFPrc13PUsTvUsFLOpJIBKpC8TzSOnHPLjCuVAb22zjC8M/+o4CW2nlT3zLG8DcsBSKcVWuggdeDKD6MtsVXznJ2CZkL6LNBd6/PBsJzKIYw/tCWxLFtvm6R9OLlbYWPDhyn+Vitd9V6Tn3CGFry36pBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673324; c=relaxed/simple;
	bh=q3qpCtpfaHgKL4O+ohs+zw2E99BCzpPBfbg0sK2q/Ow=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jHKUtTQPqbt+e4JGFFs4EAzKs/SgKnJNKPwMG5+lI/8Rd3KUYBMJThUmeOn+59Zvr7Xmj3YPrkaWLkSdsIrsx7PzJQfsB6M3bw7VQ15xAs09LPBdDsEBaMfk5lNJ8/v/Un2VdIyl5oiWgxvTXMl5gfqTgfFStvhfNi/PiUFCjGE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PDj8jKDj; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5135ab96dcbso202784e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 13:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709673320; x=1710278120; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lcLlYhRVUjayvEg2I+ONza/QYQQIRBBumX2Ta0R39NM=;
        b=PDj8jKDjILv/dXLC0/1HoGiF5UjOYb4vMlDo5zHW3PqWNxycCF7phjP+ZSQXWj77oS
         aLwtO9IwZfIYhRu7Z2H8obDl6U3bPR5ZVX1oGLEEZXKaUd8vGIcJ1EhqRC3YXTXpH94K
         7RNY0wZ0PsFHmFpYrGBHGq66dcMzfc0cGyy5tW28ytqh75mpZ2OKQUnwtSqFW+29K8QP
         fz6iayckSyS0Slrh+063h5+VQmi9iXxlYLza1KoyFnMaJW6n/ILUWzR/d6PEW2UZkjWj
         OxpFglpFEmikoj3ogH1sMTvSE9tjCPgLr9TWfoMA13jF+cdcQOCrwzHKozivhTR9Igo1
         /RUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673320; x=1710278120;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcLlYhRVUjayvEg2I+ONza/QYQQIRBBumX2Ta0R39NM=;
        b=sLfSYrNs1a4yPzyoQhe7Fisy2WdD6Vj0NoYSQSRxkwU8O2nR1aLgFXlbWnHN/SoevF
         +UpOAmwLRKk5528FX7zyuT5lRcgUQiRWIPypUS8BAsFJUMdXb3/5uhWmBpQKMeYlG+OI
         fXv0kPPPBeMfLZPcxhfbba2+H80eysKfPQrMzh9vyzTABnZ5l30AKekr3IZ2hzF4sVuN
         zZ3fNiadwTGZiKCzZqCrwlz3BvQoTk0UWA+Vsn5tLNRrHAt/kG/co01u/GWB7y1QOezP
         aggO0YixngHsfVjYjOeSlj+eqtHrOXiQ/Jz3sX7XBCMxRFgZGRGhNsxlGKQOhjsVh457
         LyXA==
X-Forwarded-Encrypted: i=1; AJvYcCWUSYXtsmsrDNUwLqWuamPiBrStZvhvE0/7WhKo44nSGRzMSXuDbzDDduU173TYdDwV1v5Vq97uwtTB7BWjK5/qk/G4CvEZh3G624Hv
X-Gm-Message-State: AOJu0Ywdu3y5q3oulSE0fIl9MpXKqOWV5MoV7UsqHIf7hye9NX/3tW/V
	1mt9CDAE3p767YOnqyEDlQZdayrENrWzoUf3xNKZHmiQpnDnKc1rSm4Nmdhc4hY=
X-Google-Smtp-Source: AGHT+IHdbN7lKKMKvsDIF7x0cETyUnPKYUVcgnXel+Ffrs8Vy4TYbaQOKxKx/8wKuc6TZ8iFva4IWQ==
X-Received: by 2002:ac2:434c:0:b0:513:346a:5a16 with SMTP id o12-20020ac2434c000000b00513346a5a16mr1068589lfl.9.1709673320317;
        Tue, 05 Mar 2024 13:15:20 -0800 (PST)
Received: from [172.30.204.154] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id i10-20020a198c4a000000b0051330fe710dsm1994042lfj.169.2024.03.05.13.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:15:19 -0800 (PST)
Message-ID: <d655a4db-89a8-4b03-86b1-55258d37aa19@linaro.org>
Date: Tue, 5 Mar 2024 22:15:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] firmware: qcom_scm: disable clocks if
 qcom_scm_bw_enable() fails
Content-Language: en-US
To: Gabor Juhos <j4g8y7@gmail.com>, Bjorn Andersson <andersson@kernel.org>,
 Sibi Sankar <quic_sibis@quicinc.com>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240304-qcom-scm-disable-clk-v1-1-b36e51577ca1@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/24 14:14, Gabor Juhos wrote:
> There are several functions which are calling qcom_scm_bw_enable()
> then returns immediately if the call fails and leaves the clocks
> enabled.
> 
> Change the code of these functions to disable clocks when the
> qcom_scm_bw_enable() call fails. This also fixes a possible dma
> buffer leak in the qcom_scm_pas_init_image() function.
> 
> Compile tested only due to lack of hardware with interconnect
> support.
> 
> Cc: stable@vger.kernel.org
> Fixes: 65b7ebda5028 ("firmware: qcom_scm: Add bw voting support to the SCM interface")
> Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
> ---

Taking a closer look, is there any argument against simply
putting the clk/bw en/dis calls in qcom_scm_call()?

Konrad

