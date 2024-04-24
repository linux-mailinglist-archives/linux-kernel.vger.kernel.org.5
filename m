Return-Path: <linux-kernel+bounces-156932-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DC2B8B0A80
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 15:10:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF649285308
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54DC315ADA5;
	Wed, 24 Apr 2024 13:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b="PRM3mWPy"
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3720115B151
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713964225; cv=none; b=TuAGy1Eubh11m3ISd8w7DLUJrvp08vLl9JnA0oUlyn+g2SEXPwxNKmhrlnoMHfiXyNZKs3IYpKx0WBz2s/YLyICSVwRJlb3vbmP4eTsrjJCcDP4xOAOmDSK8UOTosW04hm8/OdtX3r7B0ZXKjpA5hgohTKiPqlpJkYIWqkXqvCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713964225; c=relaxed/simple;
	bh=OefCvQ2x2IZXcgNdABhPCAcs1PW3cTeYzxWmJEpDiw8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OYxaN6ibGMZEda1PvanzXgMM1UBI/WFvPB8lUEB2MNWSW5rPoFan4nIyY4SwniY4m67C4X4HLtJkTNc4wWShtol1zAXpaEMLxluZ+OcI5z+Jojmk17y3f2C9B/K6Xoc0sFJR3Zq8uz23aL4y0kYmjDvtJRoP3KEDnwicI9KKLag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org; spf=pass smtp.mailfrom=penguintechs.org; dkim=pass (1024-bit key) header.d=penguintechs.org header.i=@penguintechs.org header.b=PRM3mWPy; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=penguintechs.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=penguintechs.org
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1e3ca546d40so56874265ad.3
        for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 06:10:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=penguintechs.org; s=google; t=1713964223; x=1714569023; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Sydl+4yFYinKXmdPTE5nn5HGpzz6QFMBENvh2i5loOE=;
        b=PRM3mWPy+3RVNeSsfGkMdvomu9dVjir3bEAaNWBpOxmRpHfR9XKZnX6qlKGvRTevTj
         6BXvzPBAdbrNa7QfMoBDzico67O3DRUvT+Z/mr8gwSYObHgDuFjoPBCR9UrExEAxLmQW
         pdZmfex7QDQ7/o7vhgUoYJqKaiJDqqpD/PItY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713964223; x=1714569023;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Sydl+4yFYinKXmdPTE5nn5HGpzz6QFMBENvh2i5loOE=;
        b=DkmgUnSXKzlmGL6ZJIk5SJIBQVHot8iRcCqji37OBPvBoIbtQ8qqVgkZf39twDkcTD
         YjwrY7B7OuPcq3JY4oBMsAi8js7O54+t4iaEPqRqWkuTLIslSSPrPAWJyBISF7FGDx5J
         Q87sVnUnFIpuV+C9i9MDyw2xkMAnPNd4MgrOKbShSN1SDWCfxRsrH0MuPYopXaJxRhRh
         1b7zdKwKfdo84tJiO0vGWXP5wuA4wN+Y3yBLIMiTNQyOKLlnzYmtExuVQ5W+JgbDklTp
         OAYn7F1sHUpreHttdy9BxSBBnrquD8L/pKLC/UqqYHMt9pp9oq3dfAqpiGQ37H5zeJJu
         H2OQ==
X-Forwarded-Encrypted: i=1; AJvYcCXSEz1iaOZJWHJHbrhbR/g7CjaB7qN2alzdAaYDnvh3J1AxixIiRgASVytY8fJgcm2t8U5hPREmyehfsimDSlnA5SChNAlre3w2Xrxw
X-Gm-Message-State: AOJu0Yxs1rm4rK+xWkcwjrmJv8wbuFvRTxxOIfSkwz+1Me/9o+6atsa1
	UN5ZUBtL+TfrGOV0ihKaqEf6tKaZX+l4fKGgN5AV4btyk8vRxisAlKriO1+vmDd5+HbgnGSMipY
	8OWki
X-Google-Smtp-Source: AGHT+IENMZx7a5JN5bQLy2lo1eJGSELBdY0Fm2u/7eAZkB+kc4140yF/vjh6YqzxR99qe6U0lTo0vQ==
X-Received: by 2002:a17:902:ecc6:b0:1e9:214a:4175 with SMTP id a6-20020a170902ecc600b001e9214a4175mr2782600plh.22.1713964223368;
        Wed, 24 Apr 2024 06:10:23 -0700 (PDT)
Received: from ?IPV6:2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08? ([2601:646:8700:dd30:5f3e:5ba7:e0ea:9a08])
        by smtp.gmail.com with ESMTPSA id jj1-20020a170903048100b001e2526a5cc3sm11830928plb.307.2024.04.24.06.10.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Apr 2024 06:10:22 -0700 (PDT)
Message-ID: <ba9b0e6e-3601-4460-ab5c-a02eb7708a4f@penguintechs.org>
Date: Wed, 24 Apr 2024 06:10:21 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] Bluetooth: qca: set power_ctrl_enabled on NULL
 returned by gpiod_get_optional()
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>, Marcel Holtmann
 <marcel@holtmann.org>, Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Zijun Hu <quic_zijuhu@quicinc.com>
References: <20240424122932.79120-1-brgl@bgdev.pl>
From: Wren Turkal <wt@penguintechs.org>
In-Reply-To: <20240424122932.79120-1-brgl@bgdev.pl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/24/24 5:29 AM, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>
> 
> Any return value from gpiod_get_optional() other than a pointer to a
> GPIO descriptor or a NULL-pointer is an error and the driver should
> abort probing. That being said: commit 56d074d26c58 ("Bluetooth: hci_qca:
> don't use IS_ERR_OR_NULL() with gpiod_get_optional()") no longer sets
> power_ctrl_enabled on NULL-pointer returned by
> devm_gpiod_get_optional(). Restore this behavior but bail-out on errors.
> While at it: also bail-out on error returned when trying to get the
> "swctrl" GPIO.
> 
> Reported-by: Wren Turkal<wt@penguintechs.org>
> Reported-by: Zijun Hu<quic_zijuhu@quicinc.com>
> Closes:https://lore.kernel.org/linux-bluetooth/1713449192-25926-2-git-send-email-quic_zijuhu@quicinc.com/
> Fixes: 56d074d26c58 ("Bluetooth: hci_qca: don't use IS_ERR_OR_NULL() with gpiod_get_optional()")
> Reviewed-by: Krzysztof Kozlowski<krzysztof.kozlowski@linaro.org>
> Signed-off-by: Bartosz Golaszewski<bartosz.golaszewski@linaro.org>

Tested-by: "Wren Turkal" <wt@penguintechs.org>


Like this?
wt
-- 
You're more amazing than you think!

