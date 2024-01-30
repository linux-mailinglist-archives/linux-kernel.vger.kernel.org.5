Return-Path: <linux-kernel+bounces-44317-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C30DB84202C
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 10:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7FEDC28E191
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 09:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFEC260DD4;
	Tue, 30 Jan 2024 09:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uYnXincS"
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A07960BBA
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 09:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706608318; cv=none; b=Bgi38cRqWB6nH/pIjLRUXhpqAQfWgAIvtL/iFrfljExgXcdDZJHiqwaRwm30k1XACA+gRLtOna4bG1iDCjsBprdIQyBzWYjbQhc6L+OPiaxSX0aShv68LQhCQhfL3h1GacremLo3BypuCEkT3mZxrvmgexo8n/5ZTR7jR1PvrXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706608318; c=relaxed/simple;
	bh=sUNr3myzPwzcEzPZLydh/Sxr+xAwn5eWM0IALXoUSC8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LpRNgEjoaXo9rEovLzXevJNxXSR4n4Y6zFnlpPzhARG2xjXuPmLYTiBuoHC12Dw5ilMzu6dIURypTPV4vcMhe1ubeHVCsWRHcEzvk/qThmPWGL3hE6MUdlXPq1KES9eCqg6IlFRDq9QKTvWxxxs2mH/hH719s4WRwqsifYMZzeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uYnXincS; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40e80046264so47084455e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 01:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706608314; x=1707213114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UHvebLwHuRfKrhRhx4zUZc+osrZ3cO5ITZcXKlhy5f4=;
        b=uYnXincSowyG+p9UEdPDnvxIzmU9GOBSzNhyzKWgWRsHxYxJsgmlN8l73pqeqMgJiH
         W3FLzDp9V1a4NogDlV5H1k248SFmxfaAhFaGXvy+2xX1w0ghHvdHtyUoKilqpwW0kimv
         irpXAEmjuNAD4/StG/16/I9RtqUQBH7xybZf4x+8WvJiIjR03h7Mg+Ju0ipADKFW0o6Y
         UtGo5chTuX8tks8DceGJ2nErQ0g305MQvJkl4lTc3CXnzi2Dpd+8g0LSqtlkfRvLQBTa
         h9yp2/x5R1D6Yus6NsAKqqqL9V7/KOfcBuEEQOWlRt+BxIoW2oB/IMNTXqdGY51W90E5
         IVaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706608314; x=1707213114;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UHvebLwHuRfKrhRhx4zUZc+osrZ3cO5ITZcXKlhy5f4=;
        b=jji/81bCnJNmCwpg/OAXuKKFnf/lybuiZ0xhzJujKFNCHRUufSSn7un08Ib+BZrkOt
         dSbDOAlY5gO85OmDJ/kcqN0ajKPZd4C30fB+JKeIkvb+KGLr2DrsoVo3UkqABntD7ORk
         bZKt91OdGd1P7uTz04PlQWljGwmQB5gZaLIxJbH3PKKBCPUGzTGhD5yFS7W4g0xLhrgl
         F0DJu7PnZSWT32PDllfNB+0jHlpQG8LWQSsMl14LNTkYp/I0QgFlFAZunPjFs3fFVeBl
         pM/DOkt39S/u+YnqK5xwdKYKx8Jj5wirMhI/IY0mW432vKSlW49XydvGzaRk3HY2ii4C
         TERw==
X-Gm-Message-State: AOJu0YyoVPNkUodn5I0hgoxklKF+m1LBKUfX7fwUrZ17lrtSi+BW1RgY
	31O+j7suoEj51ahuYOG9SJLgLlieIy3pNB313jyBTEpmch73KLs6fmiA+fmNHG8=
X-Google-Smtp-Source: AGHT+IF38u7/UMq2Ehe06B1hdRlnUG7cUccj6aYmXDUSxOCpUZXxCEPO+lNn+j1151l0KXe8fxwwHw==
X-Received: by 2002:a05:600c:4d96:b0:40e:d319:4792 with SMTP id v22-20020a05600c4d9600b0040ed3194792mr6064680wmp.22.1706608314364;
        Tue, 30 Jan 2024 01:51:54 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id u7-20020a05600c138700b0040d8ff79fd8sm12646748wmf.7.2024.01.30.01.51.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 01:51:54 -0800 (PST)
Message-ID: <57a5ca95-9d79-45cb-89dd-fa7a3a6ad228@linaro.org>
Date: Tue, 30 Jan 2024 10:51:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] thermal/drivers/mediatek/lvts_thermal: Fix a memory leak
 in an error handling path
Content-Language: en-US
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 "Rafael J. Wysocki" <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Balsam CHIHI <bchihi@baylibre.com>
Cc: linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, linux-pm@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <481d345233862d58c3c305855a93d0dbc2bbae7e.1706431063.git.christophe.jaillet@wanadoo.fr>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <481d345233862d58c3c305855a93d0dbc2bbae7e.1706431063.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 28/01/2024 09:38, Christophe JAILLET wrote:
> If devm_krealloc() fails, then 'efuse' is leaking.
> So free it to avoid a leak.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


