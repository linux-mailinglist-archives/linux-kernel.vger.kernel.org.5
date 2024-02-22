Return-Path: <linux-kernel+bounces-76382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E34F85F67A
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 12:06:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 137DA1F280E1
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 11:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 806DD3FB1F;
	Thu, 22 Feb 2024 11:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="poKh/tGv"
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 239A73FB03
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 11:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708599977; cv=none; b=eG0aAmWFriuFeMdi+GMOuFBNCdb1tv/y4ynCLNg07kpNAQ3h/iZSKMZiZUVmAlrvQeppTyl4QP6nmbGtxpN3HxbPgsxt92OhVV6lTown4BbeCDdbAdg+f4rp+/5EE/ozX5E7sL7GvQFaYPG3YDO+nK0z7Qir3RMM45SNtsJmH1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708599977; c=relaxed/simple;
	bh=eUO2pULCAOjDoFdOGE3rfjqQB4Mduld03rcv2+usukY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vycwm7HlojuN4OLN9Yl686uFFcSCtLxkrwi/R5KPq8FLf90CDP4K3roH9hgZMqKGeB22dsYjINvqhnAI7VV8nXk6UffyaXcxQg+gkDU1nUm15kN5OFawOnSxQ+XnpGYuytOranBHq0IBlZIq19k/Qk5kPhiFKHMXq1BLI9tgnhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=poKh/tGv; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5129cdae3c6so2028097e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 03:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708599974; x=1709204774; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SMIMrYAG8AdHEKxeFmFBefuPoTIONeLm4jsBhqGprBA=;
        b=poKh/tGvzzPbXLXnVfTfwH+Z/8KfF3n9tNdhaKqE0Yc/3ffMfGrBhakNh9ujnrWHgV
         3cfsThy0YIWiPvdjOS/jB8t2ITESXQIVGoGW7hTrjXyFLtxQE0Wf+qY7oxUxDCoOqxRi
         Gss0QbYe+3uEOvs4uQ4+CkGFHKF7jxth9BNSWCMPb7VsFOoazLrKIXg/65K3yFl6+Hvg
         1rtb/iOIT2EmlKRF/Ies+61J1MgUreuwi9hG+3rRGEIYuUslR+1ldlwkuvG0M2vSip6b
         z/g38Hu+x30h1EL+wOqZcg64/r4ar6GZsqcyHA9/EwcPzuvnpvxiSpJ6vvpmCb9gbY8c
         4f3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708599974; x=1709204774;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SMIMrYAG8AdHEKxeFmFBefuPoTIONeLm4jsBhqGprBA=;
        b=r+909JNNHnCX3qBYyYXsuv7HYCW5tvGdu6KXevrn2+QbK/1yJ/pVGDdJhTO1va9nt4
         ioWiZYNNK2JFavXcW577fd/1QPSwHsEPQ23bQLwlgoaUCZK+Blb19NqIsm/DqNgC2/Mv
         Og1X4EoYn4/6kTmibJfUVyayo+ANdJK0V77fy0xoOuVjA9XzJlbi7PsGcKUXCo5Xrgj3
         eb25E4QIQPSsPK0sv6pIrxpcTHagv+44SzvPfXvtstg1yPQA7KrYNhGhqkXrpLqFirvL
         AYb42X6IQ5W3GEE/iQhPyvKXUFAWYctognBDrcgXnhZ7BOFbU6ALE7qNu7TTpnKfnvCD
         gKdw==
X-Gm-Message-State: AOJu0YxQeFU4Z4KEuSqlAV1QfnSWFm/2zTw+TD3VU+nJtg9HAitYXCrC
	cvLZSnfHozgGrog6o+eXgST+AvhWLW1AqsS9EwFy3ag1TBG168UQBVEyTUvUYUA=
X-Google-Smtp-Source: AGHT+IHiLSfsaDdgn2k5rjMUiJNduHZR3YSa1xmVy7cLP8thmp4ILrPRdvUpIp7j6hHay03gDR5OLg==
X-Received: by 2002:a2e:92ce:0:b0:2d0:b27e:2437 with SMTP id k14-20020a2e92ce000000b002d0b27e2437mr13380930ljh.39.1708599974326;
        Thu, 22 Feb 2024 03:06:14 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id d2-20020adfef82000000b0033b75b39aebsm19978761wro.11.2024.02.22.03.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 03:06:13 -0800 (PST)
Message-ID: <4dc3ee0d-ca11-4574-a47d-8d9aed83e31c@linaro.org>
Date: Thu, 22 Feb 2024 12:06:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] thermal: intel: Adjust ops handling during thermal
 zone registration
Content-Language: en-US
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux PM <linux-pm@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>,
 Linux ACPI <linux-acpi@vger.kernel.org>, Lukasz Luba <lukasz.luba@arm.com>,
 Zhang Rui <rui.zhang@intel.com>,
 Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
 Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
References: <4551531.LvFx2qVVIh@kreacher> <3213551.5fSG56mABF@kreacher>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <3213551.5fSG56mABF@kreacher>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 14/02/2024 13:49, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> 
> Because thermal zone operations are now stored directly in struct
> thermal_zone_device, thermal zone creators can discard the operations
> structure after the zone registration is complete, or it can be made
> read-only.
> 
> Accordingly, make int340x_thermal_zone_add() use a local variable to
> represent thermal zone operations, so it is freed automatically upon the
> function exit, and make the other Intel thermal drivers use const zone
> operations structures.
> 
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Reviewed-by: Stanislaw Gruszka <stanislaw.gruszka@linux.intel.com>

Reviewed-by: Daniel Lezcano <daniel.lezcano@linaro.org>

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


