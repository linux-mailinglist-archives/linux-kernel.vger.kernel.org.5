Return-Path: <linux-kernel+bounces-76753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F2C85FBFA
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 16:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF16728928A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 15:12:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 207D214D433;
	Thu, 22 Feb 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VeZNiHxt"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF52A14AD14
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 15:11:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708614718; cv=none; b=mjAorcmmxFKACT3S9jB23RNKU3WFKdAEuWoVD5JAFIdCRaVjtELnTGYf1zE/SaLozNbz1jbZ3sNHHjHWfvD3hSfshnViaGdRiyBjQCFe1JsPUEfWyqP2/LJ7LR7n1K8Pk34jRLkuvwkD7EH38n4qlmo4j99JY32XYf25Z/h0V6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708614718; c=relaxed/simple;
	bh=2nHeGSw/Y0bu/0rFODKaGA3bo8+cj6tJuf8IA1hGEH8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AaroHtpFKongwCEZ+fb7JYitIc3PTEUrFmbU1m3jmtrl2yyRjK4Cw8/3Dzw4eDfzCFJ1NVZGzSKf/nf48BM9zgUFxqVX+7RJGCadWMVXTX3Ed0OU10KlEuoFLNK90n9IVzhvMpDmka2juOqcK6iUdjEDMvcLNVXJPtvxHacTDnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=VeZNiHxt; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41278553016so14119455e9.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 07:11:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708614714; x=1709219514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZdeavs8ARZ4Wp8jVIIq5rYX8CQepVWYtNx7IdtKagA=;
        b=VeZNiHxtvtZwKy/iwYUtH6ubigGXm4t/ZNRSfgRtK3OZMuYCQwPvzTbMuIUamhdduY
         N+nOlR4+VsstAAJUxg6kRM/BQ9a19WZ95EAgO9xbOY6XXCc38dEUEEMQ1sHsYudUCYcz
         sOaXg57w0KMBZr3tuM457coSnaQnP+c08o8KaXdxir0eLieYLRAQBbyFJMzx6PQAFqlk
         X2Ng/f9JJR0MtXqLKzWLbECZBCpCyOtnWlYGiR0/3jb9KgkuxFSxlWdOEkBrv41yvNca
         DbNDZmuODTjp6NcpMj8U2MDsNr/sdN0eDbBHaqJwKRoH2+u2CReT5YdSy8Z2NYw9p262
         VxXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708614714; x=1709219514;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZdeavs8ARZ4Wp8jVIIq5rYX8CQepVWYtNx7IdtKagA=;
        b=ADW0eB4qgCb9CyaPrnHROm7oK3KOIB3FIhM20ymN7swLuzRU+YlZKCfp0IKPbvBR5F
         OoieJeGuZoDv3CzXjnZ8Hl76uuR81RHpCJrvp7XTf2HEi6CWxOP08GWupdY3+Orla8/8
         W4pAtvH3qSQE5oTqU1Jp1A76zmrJ1qSPozPfkNeh4kp5RCjqKjZm8ojK5zG0Wmn5gfRJ
         TWUSfEeBxCp8B7Zvkjrnlpr4fp8yr0kM7ZTaZkslexZ05UVgHkXhQdAFL4YhODDzb+rE
         vjh/xhMeODTle86muB1rMMch3/aMKfCwDfpw0ne3rEaItbzHQGS8DpcqE59xWvN57l1l
         9DFw==
X-Forwarded-Encrypted: i=1; AJvYcCWhl7/32yqyLkX0uNaH34j+Vg5q+bcgcSvK8VWfCA8hv9GWaF3qiwJU3yPpXF4l58/gNn60wqeO+ZB+B4TPq1YK6mEspuwuFVUU/Hzz
X-Gm-Message-State: AOJu0YzHdOJMEtBg479PqoJVlqr0CcIDlEEMN/349EbvFjaijvW0hQTk
	ATFHzwwsVme9nrAiUP9jyga21/fxWCER78tponpSaRIvcXp82+y7Vov9pXXBz+Y=
X-Google-Smtp-Source: AGHT+IH5VhU9UCTY6WCZTJEB3gZr9zWbimtj+EBEQnbqM+B6oMV2+MqMrPueMl04ish8T7F7PfrFzw==
X-Received: by 2002:a05:600c:190f:b0:412:8560:1baf with SMTP id j15-20020a05600c190f00b0041285601bafmr1129700wmq.26.1708614714030;
        Thu, 22 Feb 2024 07:11:54 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id b15-20020a05600c4e0f00b004128f41a13fsm369363wmq.38.2024.02.22.07.11.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 07:11:53 -0800 (PST)
Message-ID: <e0a65f94-73b8-4a27-87d8-8fa3d8e88e7c@linaro.org>
Date: Thu, 22 Feb 2024 16:11:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/9] thermal: intel: Set THERMAL_TRIP_FLAG_RW_TEMP
 directly
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: Lukasz Luba <lukasz.luba@arm.com>, LKML <linux-kernel@vger.kernel.org>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Zhang Rui <rui.zhang@intel.com>, netdev@vger.kernel.org,
 Ido Schimmel <idosch@nvidia.com>, Petr Machata <petrm@nvidia.com>,
 Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 linux-wireless@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Manaf Meethalavalappu Pallikunhi <quic_manafm@quicinc.com>
References: <6017196.lOV4Wx5bFT@kreacher> <3281804.44csPzL39Z@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3281804.44csPzL39Z@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12/02/2024 19:34, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Some Intel thermal drivers need/want the temperature of their trip
> points to be set by user space via sysfs and so they pass nonzero
> writable trip masks during thermal zone registration for this purpose.
> 
> It is now possible to achieve the same result by setting the
> THERMAL_TRIP_FLAG_RW_TEMP trip flag directly, so modify the drivers
> in question to do that instead of using a nonzero writable trips mask.
> 
> No intentional functional impact.
> 
> Note that this change is requisite for dropping the mask argument from
> thermal_zone_device_register_with_trips() going forward.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---

I've reviewed the changes. Some changes in the DTS are opaque for me, so 
I can not give my reviewed-by tag but the acked-by


Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


