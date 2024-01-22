Return-Path: <linux-kernel+bounces-32776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 79639835FF9
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC3D71C242DA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:45:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B2883A292;
	Mon, 22 Jan 2024 10:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gSSAl8JJ"
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4604939ACD
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920298; cv=none; b=U/78FufpM1KR1yXSPzz1SuYudJCRCEmkFK2npdrCKbAcjscpsMO/VxrEx8Im2h7fPcfvPpJuaiWHZsvKJXnSC9wUOH/LiCYQKRpsO4oJlBIwCCEQ2ojiNoIPOnVL2UAi/zX9U0mp1n1uJd9/dgmt1DSk7P9Av3XGUUW9ivEEwo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920298; c=relaxed/simple;
	bh=D/FSZYu2c7Uvn49WFGy+srvKlo3F49S7wmxM0BUoYsc=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hAsYLHOvIijPZvCgyfyZSJxgUv3vm+FwJx6cZABfqpdUM9uxBzPk9sJOWVcrq6UqI36hzZRmUTySB12GSXu9LMK/wHzu9rngmSdQxrFYq4t0QDROcFibUwqy6mpmyPqjLDxc1hs/9dgkQr6SMAAKG6me47WpKzzzZ8jbYpFS4gU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=gSSAl8JJ; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-40eaf3528dfso4558505e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:44:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705920295; x=1706525095; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JdpeDxdNLT9OV/2cTFPVotxifc8fm3oA29SrSED19Zk=;
        b=gSSAl8JJqkra0Zr4JXngAUqKuaM+v+2ky++d7OoFYdu4V/5nUPVZE2jVYqdSqqYfzm
         xp5zJChnvFxys5DwhaOWoippdpNMuzss+G0JOoyNXch6YuiYWCx71AIZH6jwjp3BeEYy
         uSzGuy/zquYLo5YE5lmq3zVrT9bMFq07wL5dqZZl+5v6vsJKpfk/+Ke58/fw6bo2cGWk
         jUG3g8MsdJAQYU61ZXp1Ih5fmmueoSrYK2JwmITmfwAgyxeyoa7qEAITBTthYI5fjrQo
         rQ8YqErLvZGIAgY+oaUHvn4nmxo/u56iRLScG6ko+Sf+9G1XO0tn21CIw1VppDfcA2gO
         rtiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920295; x=1706525095;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JdpeDxdNLT9OV/2cTFPVotxifc8fm3oA29SrSED19Zk=;
        b=pA6c/hn4cXqYYIW2aKs2sXGpwy/kI39oRdsZOv0E9wSa2BEq2Mmhd2z33HjCZSLz+O
         7lc4XJelR1l9sC8a1dCK3kVLnWkItCZZ53p8pvZSWdFIJcUolXKumE66eWjILN/Km64p
         /Dk/vARAtB0X55oEoRJlMKKX+3kszEI2LQBr+Vm9bKT8Lr71swj4KgkRHE9NJrO7bIae
         kDRUojLSo5kMUfeBkwe9zZ99i7PuIWzbeBc+aYJ8MwFGaqFxM0kMV9X7oy3MQKjI3sEa
         29B4zFjLLtenO9EDYYFPFErrbINlBIkwt3U7NFzQ+O6m6Ip8AoboIAHcJclYYRPsnuz8
         iUxg==
X-Gm-Message-State: AOJu0YxpbsGQ9IlIg5oJZ+GTbt50BrSlA4CHkEg+LYMTZ3OY6qvY07ti
	pmN7YVpxtHYVxAsONP2ESgNREEg7VcRXjMzzFUhdnDiKZPapiygta4eeIlDxg9E=
X-Google-Smtp-Source: AGHT+IFC29R5NfzfmcvFUnFVv9EKcUADduSChc6hEHJOJqXTBgdXDd/uvVnVjKPhRqfNQSZEe7kfIw==
X-Received: by 2002:a05:600c:2a8d:b0:40e:49bd:a2d3 with SMTP id x13-20020a05600c2a8d00b0040e49bda2d3mr2285508wmd.139.1705920295418;
        Mon, 22 Jan 2024 02:44:55 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id f18-20020a05600c155200b0040d87100733sm38858312wmg.39.2024.01.22.02.44.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:44:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc: patches@armlinux.org.uk, Alim Akhtar <alim.akhtar@samsung.com>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20240114052751.17242-1-rdunlap@infradead.org>
References: <20240114052751.17242-1-rdunlap@infradead.org>
Subject: Re: [PATCH] ARM: s5pv210: fix pm.c kernel-doc warning
Message-Id: <170592029431.39082.9342673926900228188.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 11:44:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 13 Jan 2024 21:27:51 -0800, Randy Dunlap wrote:
> Use the correct function name in the kernel-doc comment to prevent
> a kernel-doc warning:
> 
> arch/arm/mach-s5pv210/pm.c:61: warning: expecting prototype for s3c_pm_do_restore(). Prototype was for s3c_pm_do_restore_core() instead
> 
> 

Applied, thanks!

[1/1] ARM: s5pv210: fix pm.c kernel-doc warning
      https://git.kernel.org/krzk/linux/c/52524ff0558b57e8b78d05d645456b0a77c787bf

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


