Return-Path: <linux-kernel+bounces-93004-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AF47787294B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 22:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E0B891C2151A
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 21:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38EDC12B177;
	Tue,  5 Mar 2024 21:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KhMJjh1f"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE15F134BD
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709673552; cv=none; b=I/kVMCKoHLwCQxnOB9ubCIKvTOc30EosJbQ4wbj5lJFlp2brp3s28czG3bhUCIpgHLf33ozi6TtXOpcIQTSZIRmGz9Y/W1qh25Kiy0m0hBo0a3KvsM2/TaEfD3FyUNPnNYdRheKFBkLend2TpOXmFavkXuxr3jwknQh0b81rZOk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709673552; c=relaxed/simple;
	bh=BJFDyvdTEMTW5MSbpMK871B8ihwn7AOJZYaiIQHZIxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z28qyrnWxA2rpKmeNB2pBpuoHc17bXU8HBZbaM0ilhArWfVcIb01RUcxu07EcTDDTUAZWv+NPiSqVYYt4NvaNqwmzxsP9HzHVaojF5BuC9trRAXjmtnPLO1qUOXX09Q9gUeHX2vErBEZuX1Js0JcXJ//SMtjCsFp1gYykG30Jpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KhMJjh1f; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5132010e5d1so1586045e87.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Mar 2024 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709673549; x=1710278349; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rx0dXZC0eo9mnWpqD7RaNvBESO2LzAYpoVOQUXDj5TM=;
        b=KhMJjh1fIu6Ye0R8yS3wrPAaLsIGyehJy2vLkSBndDfCxf/hvd/pzR8+/DrH6BXBqU
         +1yvoJNeGgtBmwq2OlMWAtTi0aO+KEh2Px+FgCHoVObJFTPLvHLJzq5EC7pmiPZ9OoxC
         /PNgqYhcA0JNAN4IjdzTaEI4XPD9SnIBJgsbVoAAudTCLT+WMi0TeNgm5Z5tDdREhlGx
         GIIQf6U53b30Q0AEH2ev8vxEn0ik9zEZQmsXASXTS09UFkw8haErRfyZFP9kix/TLp9C
         P8FgEyAqracIgHDMRQbK1k/EJc37zCmTnoK2jK2HymvP6Rf70HQtPcPtTJBX99LA4DfF
         +a0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709673549; x=1710278349;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rx0dXZC0eo9mnWpqD7RaNvBESO2LzAYpoVOQUXDj5TM=;
        b=Qa4a+KighR7ptNHxasy9VIUpkLapKsMMZMTRJiNsaH0ynmMFlqknxZtYoamTi2QKLK
         Xdy1E4bz3a6VlFmfi9GNb4oVaFq6KJDNJ/nRnBwYUgGuhZp/uXpl8xtZnYShMe26SpK6
         tpTQkDnypr1AN92FLF1ZXL6v0WY5+MtBe9jdQ0rdwZVM2cXs+1AjnCOEyCxOlOFqKlJ9
         u2pqVaKnnbMeiyGF6FaqNKgJSnfMsHpCdOKRPVIYlmj0E47Z2qgVUR7IQqYh9CPAnryC
         kzlCuGVDrV9r7pSXx1GwJ6M8Sr7kyDvJrp6z0JIhjYOSaI4nkAkF9RvKc8l134BRvI9W
         HZXw==
X-Forwarded-Encrypted: i=1; AJvYcCWzjJDD4li40VJnkjL1avtGJQ3Uznn1wlU9lwhHxslsb9EuP8uvdt9xA6232/fmCI/BfJIvW2D6VsaGejyrc9BGlkWkScG1qN807bvA
X-Gm-Message-State: AOJu0YzWBr+F2LVTTMkOBXgGn3rtoxmV++9unixnabz5uckkZiliq9if
	MnNlO2ayizy7uvHVVKaM9Y6m5epnWJlYCFYl5ZBEm3ZEstm44oHzC3T/wyaYkIo=
X-Google-Smtp-Source: AGHT+IGEpTYRkNLmD7fnHi70eyo0sSY88oYVLPgLJn7LSx5tVyosvtZnPjCHcH2gKOSCl+aDVEqsTA==
X-Received: by 2002:a05:6512:3b10:b0:513:4a0c:b6e1 with SMTP id f16-20020a0565123b1000b005134a0cb6e1mr2677590lfv.62.1709673549109;
        Tue, 05 Mar 2024 13:19:09 -0800 (PST)
Received: from [172.30.204.154] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id f14-20020a0565123b0e00b0051326e76ac5sm2245658lfv.306.2024.03.05.13.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Mar 2024 13:19:08 -0800 (PST)
Message-ID: <8dbcd393-580b-4c29-9d6f-42988a5e7655@linaro.org>
Date: Tue, 5 Mar 2024 22:19:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] slimbus: qcom-ngd-ctrl: Add timeout for wait operation
Content-Language: en-US
To: Viken Dadhaniya <quic_vdadhani@quicinc.com>, andersson@kernel.org,
 srinivas.kandagatla@linaro.org, linux-arm-msm@vger.kernel.org,
 alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc: quic_msavaliy@quicinc.com, quic_vtanuku@quicinc.com,
 quic_anupkulk@quicinc.com, quic_cchiluve@quicinc.com
References: <20240304134228.16627-1-quic_vdadhani@quicinc.com>
From: Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20240304134228.16627-1-quic_vdadhani@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/4/24 14:42, Viken Dadhaniya wrote:
> In current driver qcom_slim_ngd_up_worker() indefinitely
> waiting for ctrl->qmi_up completion object. This is
> resulting in workqueue lockup on Kthread.
> 
> Added wait_for_completion_interruptible_timeout to
> allow the thread to wait for specific timeout period and
> bail out instead waiting infinitely.
> 
> Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
> ---

Fixes: a899d324863a ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
Cc: stable@vger.kernel.org

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

>   drivers/slimbus/qcom-ngd-ctrl.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
> index efeba8275a66..c27076d8b7db 100644
> --- a/drivers/slimbus/qcom-ngd-ctrl.c
> +++ b/drivers/slimbus/qcom-ngd-ctrl.c
> @@ -83,6 +83,7 @@
>   
>   #define QCOM_SLIM_NGD_AUTOSUSPEND	MSEC_PER_SEC
>   #define SLIM_RX_MSGQ_TIMEOUT_VAL	0x10000
> +#define SLIM_QMI_TIMEOUT_MS		1000

This could be inlined instead

Konrad

