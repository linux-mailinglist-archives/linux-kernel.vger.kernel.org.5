Return-Path: <linux-kernel+bounces-167975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14DF78BB1C4
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 19:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A41DA1F24FEF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 17:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B001586CC;
	Fri,  3 May 2024 17:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EL5/FoHh"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80299157E8B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 17:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714756998; cv=none; b=RuO2FX2rO/ldAbRDFxWVq74XM/IqXZB/++xme+A/muPyRr4pdmYEKRJ7EHU1feVoJp/fCpkzikFeHC0S1CGAj3RrHuaOZdWxmsFVTHg7LuxU6RzXEarY4juOnkTuDZMPpWknwDa2rJuN0HfGbZ34iw5Yimg2twIl8o66dqb5E50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714756998; c=relaxed/simple;
	bh=BKIB1SmHgO50yZ8teXLHsBvGp/yjJo0D/FQDuulfMCY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BvrvbLvTsEeG2q31GWVrMp4mrAKR5p0Vu5a/l+NkfwvOMG7XlGAD0lWL/ZL5qKzAfPU/eFTC2yuFqAPvYRmLWFethCxpXKVTFtAwRz2/oAfk8hGm6a54PXrMNijbdhu2o8iuYvdLz6q0gs7vV6iN7YeSdKS1Q8Hl6nn07+MEMtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EL5/FoHh; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-41b9dff6be8so52126065e9.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 10:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714756995; x=1715361795; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=q3CD5UXCVdUAuu9Git8MNtIns8eazGXSqXwABAZaYsE=;
        b=EL5/FoHhOn2fScAuH4OcptPkqSKEUXTZyjhLgj8CKjarAT8Pjjjn4r3RejjCGzPU7V
         Kew6Q3iE/bIEl3sAnkjq6+FplVxZDRKJaoyltBMjJlceljl+p/R9kn6u+CIudh4J/dnn
         bOXRh653zSD0at9R7lQm6qJbpYEPlsvaoMZND9Q/kp/zLcYXaRzx3IntQ2BQbzFvbeno
         M01R5MyngX2WiJiP1Uak/8Zw1RTGgU1cSVCAsQiP6fxDl6x9RUN6BsXRcpcnCHM8ijVu
         NY4IoSG8rtI2x1PqaYR77boDXTFN3IMwcGJW7wXj0Qa/Q85BcxEkMvBHMs4dolC1mfyA
         7ieg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714756995; x=1715361795;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=q3CD5UXCVdUAuu9Git8MNtIns8eazGXSqXwABAZaYsE=;
        b=RJdEBI9ZJYheq4DE/Q0QYnTmBAjlL3VqnwN9eQnkpyiT1UEfQ8iKrBMPndbC7VUBZe
         tM3bc/Muu0euqsA03ErSO3qELHzbtTzLbTyrzMjqAmnl5WESwfPUZKCHkES9radRz+4G
         FvbWvw2TLF8SgCyfcKxMhYzXY+8g41E5bIMsvkioSoTYXRdle0Fm+j3CV/8QHiVIPl4w
         VyO3evhVutWikV4FZyX3TEe1teTTAVay2YZutzrqWCQ60qB2I2PEcDNW4zN202qLC/iH
         NjfPCDl1L9r5fhQ1w2vTzZ+X9/xvTMz6Tvw/gQjH/bLmYUPAwH+OqwoHrCMAQfXB1ae0
         go9Q==
X-Forwarded-Encrypted: i=1; AJvYcCVZgN06R4V/F/GkP5pZal/tmUw+ceuZr5sLQTnIn1Fu5Tb456kDOXn12LriKJinwu3TomlfBn+owWwxROk7wkTqWliKMZpHaeNImZrw
X-Gm-Message-State: AOJu0YzKRBpRQcAg04KaZCTtZQOarPW39wt0Wf4CjSe44VSANgI4OhlO
	WjOJxqG0xiEkeWO5irObzZwW11beL2sJiKlIAQGVl9cH5RfebDkaDxaWfwANHH4=
X-Google-Smtp-Source: AGHT+IFEowCuCwylixROUmg388nE+53RnlyVy2ckn+NBiq4MgMTwgGq1VkW2j1XllliZ4Dtr1Mh5dA==
X-Received: by 2002:adf:e586:0:b0:34d:2343:b881 with SMTP id l6-20020adfe586000000b0034d2343b881mr2771056wrm.43.1714756994641;
        Fri, 03 May 2024 10:23:14 -0700 (PDT)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id p13-20020a5d638d000000b0034de69bb4bcsm4181590wru.85.2024.05.03.10.23.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 10:23:14 -0700 (PDT)
Message-ID: <6f9dc240-277a-4222-a175-18c959269353@linaro.org>
Date: Fri, 3 May 2024 19:23:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Mediatek lvts_thermal driver: Fix wrong lvts_ctrl
 index
Content-Language: en-US
To: Julien Panis <jpanis@baylibre.com>, "Rafael J. Wysocki"
 <rafael@kernel.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>, Matthias Brugger
 <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
 Nicolas Pitre <npitre@baylibre.com>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
References: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
From: Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <20240503-mtk-thermal-lvts-ctrl-idx-fix-v1-0-f605c50ca117@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 03/05/2024 17:35, Julien Panis wrote:
> PATCH 1/2 is a minor change: it just removes 2 unused members from
> 'struct lvts_ctrl_data'.
> 
> PATCH 2/2 is a major bug fix: it fixes a situation where a wrong
> array index is used as 'struct lvts_ctrl_data' type item.
> 
> Signed-off-by: Julien Panis <jpanis@baylibre.com>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog


