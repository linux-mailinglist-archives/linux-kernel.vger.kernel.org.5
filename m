Return-Path: <linux-kernel+bounces-32888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E8F0783616F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:27:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2786B1C260AA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8433F3FE5F;
	Mon, 22 Jan 2024 11:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FAj2Vecy"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4937E3B293
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922110; cv=none; b=Q+clv6rlU6EAZTO8z94HjYpBqnIH/WRFA6SNCJ4CjqOlerFGnuX1U7q53B2JE4dADpT7w+iZ23tXsgUS1i36xcM8dW6QRK4Q3W7mOsW8Gkf+lXKyLns0g590uhrF5NdSG54cjuJ6Lx9Zuvn4mQS2m3lyqe9PjbtzUckqCek5Q8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922110; c=relaxed/simple;
	bh=r8Nk1nx6WxSIMVymXyEYbaNTmlQxretGrAviShA+EBo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=N5aMtd/RHrdyGGE/lT8X2wXIvp56N5nj/Y3YmbAixYHkO2kzS7U0NqWl9yJ3d/PeRDvOAIBNrQpv5LcgKJV8rxDw6aH0q+f3f4vH5/DyV022wxTKYmvfnLuVC+QWN6JEPPreF+ngT1+XcAbM/V+nQbpWGO5xmiAUEq4aE57fmhI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FAj2Vecy; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50f11e3ba3aso4170996e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705922107; x=1706526907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NNov5U8xwt5sXc4zpQlR2bDbhB2WJGrcQShsm6KSU98=;
        b=FAj2Vecymga4EtujHYU+w8hWUSUX6xMHvVxynewoxu+nQSQDqcYrIZo8YAFLxsFo+r
         tstfVGrRpSWkvYJqm2fOFu+E7pV9Ga/FxdSCQfkjDANZ6wJX8CqJO169OqhivnhrCb+I
         cwj11fFqCJsq9Zyw9s0wdNZ0F9Nz9vGbB1TrpbW4eqNZdNF7RbWNZ4ydoe2pnver8BpS
         yNTRR20QtO6nboBMDMJ+Wz0HDqmaMGhGiopd94FHyBgJcpVgBC5BkPDZEChoVLEpheoD
         963TC2uKybIzCvUb532jy4P/DnlE4AV6n+zmCWrvlasT40YC8psVCoAemWkG6h5LlBbx
         VHSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922107; x=1706526907;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NNov5U8xwt5sXc4zpQlR2bDbhB2WJGrcQShsm6KSU98=;
        b=bwqGZ30PsrucCPGL9KtKlpdmk00tCj1wicSabjYLs0fy16PiX+kDhix2cK5yo2xlya
         JVJidjGT3oJ1NpwaOTpIGHCxyLuHaGiBLvMupT75EQSDKxyzrXEgaaxLaAxQ8/mYmbMf
         y0VFmmcSEs+5c3LdjPDz3y6o4FXG/fNjXqzSI7A+pjlXExpRSHflEiNV8RUdSC+ZfaRI
         AaTB3Wk5BkAa0zR2xWLGtlUVFtLsQ0OHEpyekhIrgG1o4EdpTNhRDRG5kyo73/kI2rbb
         u//SHfWTF2teNElbYwe14UxZa2VT/IyorP1eA1r3xW6acCLaJl/XW6NzEXj7VrCQottn
         UF9w==
X-Gm-Message-State: AOJu0YwV62maIoWMYovWL9HQcvxnINk5ynpaoDO+pA55zQKWqYYOVnrT
	Cf74mAIy3n0D3gkWAnPOsnWHVepAROZPmvh0RttWiA6xEp9Rk3gR0OwIA290mls=
X-Google-Smtp-Source: AGHT+IFgx632zKE2RrfuyNYoFBwMDaIkfXdub3lk9XW5AkcMqYmr9BQPIRXB0qcwQPwG3mp6Xa8pAQ==
X-Received: by 2002:a19:770c:0:b0:50e:7f88:d34e with SMTP id s12-20020a19770c000000b0050e7f88d34emr1578498lfc.33.1705922107286;
        Mon, 22 Jan 2024 03:15:07 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id h27-20020a056402095b00b0055c643f4f8asm179422edz.32.2024.01.22.03.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:15:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Mateusz Majewski <m.majewski2@samsung.com>
Cc: Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <20240116140839.1029395-1-m.majewski2@samsung.com>
References: <CGME20240116140859eucas1p138fd10cf371ed1e1681a5bdd7e26e74d@eucas1p1.samsung.com>
 <20240116140839.1029395-1-m.majewski2@samsung.com>
Subject: Re: [PATCH v2] ARM: dts: exynos: disable polling in Odroid
 XU3-related devices
Message-Id: <170592210599.45273.13462998358002591317.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 12:15:05 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 16 Jan 2024 15:08:39 +0100, Mateusz Majewski wrote:
> After having switched to dynamic trip points, we no longer have a
> hardware limit for trip point count and can support as many as we want
> without polling.
> 
> 

Applied, thanks!

[1/1] ARM: dts: exynos: disable polling in Odroid XU3-related devices
      https://git.kernel.org/krzk/linux/c/ccbc2b02c22e79f08edb3d7e1584910c0f38e213

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


