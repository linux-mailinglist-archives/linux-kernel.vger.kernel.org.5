Return-Path: <linux-kernel+bounces-36082-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 70B35839B40
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 22:39:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4CC0C1C21D2F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 21:39:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE8963A8F5;
	Tue, 23 Jan 2024 21:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NJNDYrC+"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99D244C67
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 21:39:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706045983; cv=none; b=UkggOWvJa8hZqIpIafLUJJ5d8WxW7CzIpqelONQFgTcUq7mEa78wqDIqhcgBsm5HpFgDr0jJNnma/zktq7tTlw8U9SRfhPNs+a2IgVU6+a1zDN6IttrF+EPLEpEJ0drbUHJLl6H/qpSo4Szhy71S2kgY8Q3/gTzZ3IJBtVfORqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706045983; c=relaxed/simple;
	bh=eGUZA3C7Jf4gExxMvQzpPkgWGftWT2JC9Wha80xEiNI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=WeLlL90EOHOzCcyoZFBZtYO2cSgKX7v1uMUvTJLCSg+dpglKKI/wz/Np/xFstHnLGwnlXyBhLX8vhAYGqGZ/LM/8JCS1JAbWR5NnEB7UmxDUJsQTIzS5nO1LGn7cRYTAgFa2Emg/qDY2kmVfNDgNS+FQ0tsXZMDRnIZKlnaGA1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NJNDYrC+; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eb033c192so14178065e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 13:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706045980; x=1706650780; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ueWDJyoR6lihERqmkD5MS4/jsBMmv90xMW2vkc0xgr4=;
        b=NJNDYrC+xcRp1ttTURz2n/DQ3Xum8EJII9n2iCaMXwUllD4EsiVDi+CJD7kt1GASRs
         DYzXHFj9sDIlOW7QWcr3lapIMQ4oxeB1LwoINKgFW+whCNdzRcg105rv8VBHvOGVg5to
         TvHf7DimuvWMQukj3DVIFTUuB1P/zrp/Boeb1zVOw3CKfW0yFMr2CyPt1MUIHee7pwZT
         9dIm4PknoXJ1nX1WmHgAYXZXCuiE+IcbhCQhz//bK26K2aREbjQRlreeYjJISjq4f7K7
         Un9lHbNay5tZSqN6mu/QAQ2t6zAHlOa47L1JGpbQWqPLsE4JEyDlJCXEos6UKOghX0F9
         kqxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706045980; x=1706650780;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ueWDJyoR6lihERqmkD5MS4/jsBMmv90xMW2vkc0xgr4=;
        b=nHaxsVHGQm3yTd0Zo4hJlSGgDdFpygKNhHJH1kf+0Ame2BP6amc0p67IScWInBolW0
         VDfbfcBTP5Y0mZUDMf0IMYiP/LwIIyU9bQlkze9SuDO4yB3A2Jq8Ou+DequQXy/VabCQ
         +C2V8czVCvOLma60hBH7XpoJc53GS0e+ms+bzNX6EOXM44UajH+29GS7pKj9YQQWRCtb
         JDqhC01TqO2PXorLEVUXapLxQXtXaf66sCwW+13aPO0KwXo9C8X+p3A9S1sqVXOyasEu
         mRn8nC+qW8FIkBw87aTkR2b3c5xCzoGqTGD2UPCMNAwqId6r/ANJpwfAAbUe1SEDeb0f
         fnuw==
X-Gm-Message-State: AOJu0Yy2H5d9UKab6yB0IJWLfzqbW2ANg5mCFP0ZB8VEskCAtYKsX+Fr
	Y28IOgoHQyhPgsY3eoTQWG9Ra4oufArioWSxY6WOSr8ss1xwBnZ+77JxpuEsJlI=
X-Google-Smtp-Source: AGHT+IFopSwfJS8bvwR2UJd3+EmQRW7cLZjvcawhldvpUWaLdgOQz8HutQasQ0kVDyvgvG72YYDD9g==
X-Received: by 2002:a05:600c:4c19:b0:40e:4c31:affa with SMTP id d25-20020a05600c4c1900b0040e4c31affamr101652wmp.138.1706045979854;
        Tue, 23 Jan 2024 13:39:39 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id df10-20020a5d5b8a000000b0033947d7651asm1971377wrb.5.2024.01.23.13.39.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 13:39:39 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: =?utf-8?q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
Cc: Santosh Shilimkar <ssantosh@kernel.org>, linux-kernel@vger.kernel.org, 
 kernel@pengutronix.de
In-Reply-To: <20240123170846.1362597-2-u.kleine-koenig@pengutronix.de>
References: <20240123170846.1362597-2-u.kleine-koenig@pengutronix.de>
Subject: Re: [PATCH v2] memory: emif: Drop usage of platform_driver_probe()
Message-Id: <170604597893.13131.15390870521547732814.b4-ty@linaro.org>
Date: Tue, 23 Jan 2024 22:39:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4


On Tue, 23 Jan 2024 18:08:47 +0100, Uwe Kleine-König wrote:
> There are considerations to drop platform_driver_probe() as a concept
> that isn't relevant any more today. It comes with an added complexity
> that makes many users hold it wrong. (E.g. this driver should have
> better used __init instead of __init_or_module to mark functions only
> relevant to .probe() and mark the driver struct with __refdata.)
> 
> This fixes a W=1 build warning:
> 
> [...]

Applied, thanks!

[1/1] memory: emif: Drop usage of platform_driver_probe()
      https://git.kernel.org/krzk/linux-mem-ctrl/c/f0b203bf9bbc89d3230d6a3d6254d11f7a4b6064

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


