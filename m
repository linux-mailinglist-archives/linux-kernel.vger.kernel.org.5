Return-Path: <linux-kernel+bounces-119961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6849588CF77
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 21:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B6201C38567
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 20:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8822B13D60A;
	Tue, 26 Mar 2024 20:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pl8VFNUN"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFF4112AAF6
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 20:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711486570; cv=none; b=b1BpbaqhRaSw2SFlpw8JTbygn+Qy+sYBJXkwPI+HP9vBy9mh2WClY4mF5A8p4LSofSXMNEYrj4O/0alpFpuThg2ft6GCRdQDHfcPldXOUNJ6Ocikx/MNqAO5S8VnDP+BRrShz/libkdnkOH377Pzu7QapXZlloChYt74N07sRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711486570; c=relaxed/simple;
	bh=UGL3g3WW8UZNhvmvUjoG0l9OJM6+ptsPxd26CQCIAjA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dfJEw7QKLrJfJg8A6FqClGVblfpybo+IKMifpr7Y/1FbC7zePkZWrn4Ao9u5LROXYlbQDbbeFobqacuf3iiDRQs+M2izEIefL7B9Pcr23wEss4p5VFjWBdwBDHhlpFuOQiOvhEoN0Zfq8yzvYBA1IskWX+eWjbVAjGouHadvXkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pl8VFNUN; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-56c147205b9so413327a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 13:56:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711486567; x=1712091367; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nMVtKrRsw2i1yeelgF/l8Z25S1qZqSS8aW7I+SuE7gc=;
        b=Pl8VFNUNgM9++BI3h1E//4RbXbtNzgE6HMIkVI51TPHgOM4Ya2al+2aTIdTqKcceur
         ic1tT4JL0WxCjtlyzGHKhkuds7qTX6/YSJwPO6j3nRMntqPUQbmk5Lgr9BnzV95CBJ9v
         y9ehb9O1kCRPRCOQqw5h8L3x/FvNMepWW5GRuIxgfWG3khsWoichR8zsSZ4kw2QhewVN
         YUz7NUcZNdylGWbz8hMWNgr+EXh/iQciLeG5fbNpYI8NzgDCeMCudKGx++tLCxXXkEhU
         i0s9CWj9UASAAi6ouHgdHi6zMjj7yhyRcwf9dzmbPVd2ZiaeIDWQBf1ZS6qBREYFIrpR
         tCHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711486567; x=1712091367;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nMVtKrRsw2i1yeelgF/l8Z25S1qZqSS8aW7I+SuE7gc=;
        b=tJoKUL5o/iI1LJU/guq7WWZnxPwKjdcVOsxrJKWPgpExuHmI5gWMwq1hwnBhkRzE6V
         CBi7hq/867683FzG1Pd/fdwEX8SGtk/PfYuitdffxOhbvhzaubH4hzbIkfW5ftw1hRVx
         Mi4OXFVCfTbeJoENep21XaqZ6e5R0EL+pskSuYLpm7kTp0DJbZwLej8KCj8BXSH6zD/H
         kp3RG9NBonC83JEr84IZv+CR8xHkwdTRoNISxuicdL1UtA2OqrprrY5zG4aVM/OM3iOZ
         kG/VNtgTuYSTsRvoEotgzgnkH0SotIljpqIQVj1UtbsVvofaX+AMLLQCZFpFnCGY2hTE
         q24A==
X-Forwarded-Encrypted: i=1; AJvYcCUlXT/EMQRcTziBVVEQVjfAV5XBuxZlqqiAExRja2XOn1Xk4/kOpuG7TyS4EbMCYJZyqiFSyyLJVNSPdNk63SSrGiPYeu0bLUpT7Kwt
X-Gm-Message-State: AOJu0YwWcIDagcQsUpEBSoqIlVueO3m87gLdVjJwZN6exOdBLRuqfA2I
	NfJ9pJ5AjU767CSBp0vjCLtpvBIjoDjUj4sXjjd1hS/MA7dQFSi7wOqLncxBIAU=
X-Google-Smtp-Source: AGHT+IHqPhjt2nMau4/qjkaXKBiyLhwj5q9raUunTst8tmkizJNAqpvPDWUC1UW/2sAt24RKJOvSaA==
X-Received: by 2002:a50:9303:0:b0:56c:16c9:cb00 with SMTP id m3-20020a509303000000b0056c16c9cb00mr2432019eda.12.1711486567052;
        Tue, 26 Mar 2024 13:56:07 -0700 (PDT)
Received: from [192.168.92.47] (078088045141.garwolin.vectranet.pl. [78.88.45.141])
        by smtp.gmail.com with ESMTPSA id s21-20020a056402037500b0056bdc4a5cd6sm4532213edw.62.2024.03.26.13.56.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 13:56:06 -0700 (PDT)
Message-ID: <d59896bb-a559-4013-a615-37bb43278b2e@linaro.org>
Date: Tue, 26 Mar 2024 21:56:04 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/4] interconnect: qcom: icc-rpmh: Add QoS
 configuration support
To: Odelu Kukatla <quic_okukatla@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>, Georgi Djakov <djakov@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Kees Cook <keescook@chromium.org>, cros-qcom-dts-watchers@chromium.org,
 "Gustavo A . R . Silva" <gustavoars@kernel.org>,
 linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, quic_rlaggysh@quicinc.com,
 quic_mdtipton@quicinc.com
References: <20240325181628.9407-1-quic_okukatla@quicinc.com>
 <20240325181628.9407-2-quic_okukatla@quicinc.com>
Content-Language: en-US
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20240325181628.9407-2-quic_okukatla@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25.03.2024 7:16 PM, Odelu Kukatla wrote:
> It adds QoS support for QNOC device and includes support for
> configuring priority, priority forward disable, urgency forwarding.
> This helps in priortizing the traffic originating from different
> interconnect masters at NoC(Network On Chip).
> 
> Signed-off-by: Odelu Kukatla <quic_okukatla@quicinc.com>
> ---

[...]

>  
> +	if (desc->config) {
> +		struct resource *res;
> +		void __iomem *base;
> +
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +		if (!res)
> +			goto skip_qos_config;
> +
> +		base = devm_ioremap_resource(dev, res);

You were asked to substitute this call like 3 times already..

devm_platform_get_and_ioremap_resource

or even better, devm_platform_ioremap_resource

[...]

> @@ -70,6 +102,7 @@ struct qcom_icc_node {
>  	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
>  	struct qcom_icc_bcm *bcms[MAX_BCM_PER_NODE];
>  	size_t num_bcms;
> +	const struct qcom_icc_qosbox *qosbox;

I believe I came up with a better approach for storing this.. see [1]

Konrad

[1] https://lore.kernel.org/linux-arm-msm/20240326-topic-rpm_icc_qos_cleanup-v1-4-357e736792be@linaro.org/


