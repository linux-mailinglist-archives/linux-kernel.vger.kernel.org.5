Return-Path: <linux-kernel+bounces-156286-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CB788B00CF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 07:07:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0197A280AAF
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 05:07:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B27315445E;
	Wed, 24 Apr 2024 05:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="PcRFAO1D"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C6F3154446
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 05:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713935229; cv=none; b=BvnMERX56dPAZuCX/izW5LgtMuNKMG4zmK4sZIu5raV2Xxruk9kHKIdSKMNrgv48phxH7bOXVFRmr6dT1634Vc5sLlGB8mztGBqXBSxCHsB5CuZ870cz4VKgqvHoQ0ICKqNPHt4zwWe+z+QV7F37qVoXEwfEDFNWo7aiWd58FoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713935229; c=relaxed/simple;
	bh=Lk3PLm3Gfb1mNmfzQUXGR2vrGnJls8eyTcpJVzybKVs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jopMZIehDxLUoiHLPkzl2BfZ9DfCXFtgfgwJegmPzPcbDVWdkWh6XJgQeLbqM3ag2FIua0lJXFjEU9SpP115YK2wYZyegaywxo86SBqOBTJ++jCdCU/BDskTRx/OMWiLVVlzYqH2bdBAOZXQjrFDoUQ6yv3dJu0aWKzG/opV8CY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=PcRFAO1D; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6eff9dc1821so6280446b3a.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 22:07:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713935228; x=1714540028; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bkydz7s4xFQnidnY/kVqWK4VwSyfY+u4s1nUp1fyAbk=;
        b=PcRFAO1DJ2WuMrcviANemlkzDy5MvbnN8nKu3XYzpJMnQAWQH5w/60Nses10Uv83ju
         ZoV0wmjP7C/EnE/iVmmHtFZjuNG93RWLqMqIfSZfU6NjUCfns2cOMWgogZ8HuVrJQmeh
         umOir6G61X+1zQHUgKAwONchpJNTBne6maRdI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713935228; x=1714540028;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bkydz7s4xFQnidnY/kVqWK4VwSyfY+u4s1nUp1fyAbk=;
        b=CDSEqoZWBTIQ012jZExH/SBIjd0B9kSCD6Qzdj9yK2U9RqLon1EKv4mZkDOqu307VK
         /5INgA/YDMIVXsUk/BlTORt+c8MEkQkADV5YLyl+qQjhMBcXgUGQr9MZvR2NEJtq/WGU
         MYBjK6+AX19QOJj31G/MJGOhLdg5+GUFepE95SiGPdxFuF/DWUNBTA3ba11s7JrFHwT0
         SAJH5J6nEAw3Ke1kQROXvi521jj0v50RMxRDHq4mbVVTpRznfNBTgDgZG5o7VrUTRAL3
         s5bVFJJspEXXduyfM9GwqCPPchnodpL0qtKfQ5CAoR4TT4hLdsqJV8YYjJ3F0J8/93Pa
         EO9Q==
X-Forwarded-Encrypted: i=1; AJvYcCURrItkIoqv15MSktVkbMrlrh24n03p3ZQhOwsUy06g3ZX1QXyVAMRsNiu7dlglhrG2WgVfpqoBOmJB2UGlyNwFlxU214iMv5yNNaHH
X-Gm-Message-State: AOJu0Yym8wt1U9/ZbLJyYvu+qitDOoCCcWWz2iLyDvBPWTnV2RnP79+l
	Joj053h3UhckK3BUfokT4wehwJvhGq7/TyhVs4XBLLi/Tubx5q52ecJ3YVoEwg==
X-Google-Smtp-Source: AGHT+IEgB6peZS3/oAFNZ/nQnWXNOG37QUJ3eIKaX93VxmG95NGvQoAgRMI4gwI6bUv+2QLdAmyMxQ==
X-Received: by 2002:a05:6a00:2306:b0:6ea:ab45:6605 with SMTP id h6-20020a056a00230600b006eaab456605mr1801276pfh.4.1713935227685;
        Tue, 23 Apr 2024 22:07:07 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id e21-20020a62ee15000000b006e729dd12d5sm10504399pfi.48.2024.04.23.22.07.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 22:07:07 -0700 (PDT)
Message-ID: <99242a7c-53bf-4227-9623-7bc092f564b3@penguintechs.org>
Date: Tue, 23 Apr 2024 22:07:05 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Bluetooth: qca: set power_ctrl_enabled on NULL returned
 by gpiod_get_optional()
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240422130036.31856-1-brgl@bgdev.pl>
Content-Language: en-US
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <20240422130036.31856-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/22/24 6:00 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Any return value from gpiod_get_optional() other than a pointer to a
> GPIO descriptor or a NULL-pointer is an error and the driver should
> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> power_ctrl_enabled on NULL-pointer returned by
> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.

Nack. This patch does fixes neither the disable/re-enable problem nor 
the warm boot problem.

Zijun replied to this patch also with what I think is the proper 
reasoning for why it doesn't fix my setup.

> 
> Reported-by: Wren Turkal <wt@penguintechs.org>
> Reported-by: Zijun Hu <quic_zijuhu@quicinc.com>
> Closes: https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> ---
>   drivers/bluetooth/hci_qca.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
> index 92fa20f5ac7d..739248c6d6b9 100644
> --- a/drivers/bluetooth/hci_qca.c
> +++ b/drivers/bluetooth/hci_qca.c
> @@ -2327,9 +2327,12 @@ static int qca_serdev_probe(struct serdev_device *serdev)
>   		    (data->soc_type == QCA_WCN6750 ||
>   		     data->soc_type == QCA_WCN6855)) {
>   			dev_err(&serdev->dev, "failed to acquire BT_EN gpio\n");
> -			power_ctrl_enabled = false;
> +			return PTR_ERR(qcadev->bt_en);
>   		}
>   
> +		if (!qcadev->bt_en)
> +			power_ctrl_enabled = false;
> +
>   		qcadev->sw_ctrl = devm_gpiod_get_optional(&serdev->dev, "swctrl",
>   					       GPIOD_IN);
>   		if (IS_ERR(qcadev->sw_ctrl) &&

-- 
You're more amazing than you think!

