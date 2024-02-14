Return-Path: <linux-kernel+bounces-65452-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA39854D43
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:48:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4EF3B1F23D73
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 15:48:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C0405D8FA;
	Wed, 14 Feb 2024 15:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fJErqcrb"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0963B5D757
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 15:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707925682; cv=none; b=l2XkzelD0AVW79HC2YU7ASKfd2B4dLPBbAXM9bAp7M9UzDxZXezTdJxvf5gZZixvubDLCwd4wwOyzclHJ4Ic/w1I2hUzgbKq6k3RXMQ4TXFEvrobtfxaAB0C4cw2Pis79bga7dGtUtzYDTagzfENY3Lo8YbAphGkEXQ9yz/W0D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707925682; c=relaxed/simple;
	bh=OXo9CJObNilBsOGumalkvDIP0Qjf2R+AA2nb7vEMJFg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=dedNYVi1S0X5x9c69wDD3JE1M5nW5KnE2Kq3whU5Whoe2272zdkaxToxHTSU1pHYy8SgFYlUXp8ygZrNyCAsgdnaq9IP4oHKL4QeVVtf2vk+MQlq408IArRFH//aTkmKS43gKoidX9ugRmJoAqqb0SUXHqsUXphnqJyqStxFp3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fJErqcrb; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-55a179f5fa1so7715680a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 07:48:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707925679; x=1708530479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=McuX+46GCJMWVVIeDmGS2EesDa+qgN6dZa0RniqPfYY=;
        b=fJErqcrbwLtPl4rojjxpSNTwlp5EjJvRQrN08CpPv1JBvWA2oanw+uDYAbgMX4ECAo
         C3OQNoLLD7D6q7TO6n37fxA3hMVT0djzuy8Mrf096l2/KCHRY5xXIaTb4PZkM3duU9Ur
         NTk/a61jafgQFUxwpuaP2Ha968HOpCgnJuSkF941+WGl/N/VT6qFCoI0rRVEgtdgtQAi
         ntBgREnSfRpjnMkO7id5IuMcwqm55ZTCCfuqDsyzfb6ddBKEHV3yrlAW/1e3jqYHBOyn
         x5odjTG+Jwtal1dHoHO+ZVdmE/MZJ8Nzc4AtQCEN3SvHS/hKagj6p+FXiCOlBZc3Hd2k
         R2oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707925679; x=1708530479;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=McuX+46GCJMWVVIeDmGS2EesDa+qgN6dZa0RniqPfYY=;
        b=O4z/tp16yMC+lAMQ9R9u5EFLN6dhDqypxpRyMvhSm0zJ/H9WfD7p6xc0kM+gyx+/X2
         9JKJnEdcL3a3n+hbjjYOzW7+g4OUi4AcoCXnymmR+Y0kQYSOBqXKuWyH5ob6XI6CnRTJ
         wcbx9iBU75BkZBMBeebJQrfRkfZb2EBFpjiDix0unytIoM1t4nBZxIl8VZ6czWGBIpvT
         wLENYKPpDrEO/VQvEVLyC0jQ0iMTOqFjJZYNN+YMjV/T27eCP4s4PQF0cgpnBx5Z6Wv+
         ieRc0Bzvw9xmnWaJ/1U4PwWQzMNHRq2McuAMBXP2KKSH3rJV29Q3j8/f5h1g8SXUyWZQ
         t4rg==
X-Forwarded-Encrypted: i=1; AJvYcCVQZStqmOsjA2pMYY2+nh5mdcVjl/69If3SwBnfbInekm/sLliCiDaGuS3pXuyJTZYgBdpa1ITZkcGgZDum+zvg6v5IIa+HdcnuS+R0
X-Gm-Message-State: AOJu0YwPmkV34Ug0k9LRCLEKrjavl8oY/X9UQztgHnV+4x5gxljhmF3P
	Fxkv3jhloVQVw9sOhJwcMC25GS1qbxx22ljj0pcTXJQztpq5qbhAgE7KE2/cXRo=
X-Google-Smtp-Source: AGHT+IGvFxgX5xtNHTBtY0C7eJHL1+eIyCwo+5PZLWqptHy/PaLq5avuplbL8is2vdZyJDDISqW3aw==
X-Received: by 2002:aa7:d752:0:b0:562:10a7:9ebc with SMTP id a18-20020aa7d752000000b0056210a79ebcmr2286734eds.18.1707925679279;
        Wed, 14 Feb 2024 07:47:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUUz6FmQmF5wn3+zPS6iPau8SZ/a9b4GG47ZBDtTcZsdbARlczj3X3HDZ7VCr4lYdZgGmw0O3qjxKmLBU+SNQqg8cyJdgFpE0goL9yS3+Y/ch/8yobscE2JRBajb8iw24jXUFK9bhYBAdnPuNh9swYTi4+1tpo92mLZHrijTpWPJ08TKi7hOFrH0ZqpnQfJ/NdP7xUsW/VCJIuzQKq5zQk1jtQ2nrNmh7mgbD+jjI5bY3KC5AAlPttLPp9vcGJS7Sfcneb8xquWCn+DNrDMJm3QnmWo0secBSBTV7X29e25Otd4DfnXTlGt1JMjL0lTUGahkBeXTx5UjIOPiRCQsMhFM/VF31zzl5c31y48nNt1ocIGfTKGZgwM
Received: from [127.0.1.1] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id p2-20020a056402044200b0056200715130sm1424435edw.54.2024.02.14.07.47.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:47:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Rob Herring <robh@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Jonathan Corbet <corbet@lwn.net>, 
 Christoph Winklhofer <cj.winklhofer@gmail.com>
Cc: devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-serial@vger.kernel.org, linux-doc@vger.kernel.org
In-Reply-To: <20240214-w1-uart-v7-3-6e21fa24e066@gmail.com>
References: <20240214-w1-uart-v7-0-6e21fa24e066@gmail.com>
 <20240214-w1-uart-v7-3-6e21fa24e066@gmail.com>
Subject: Re: (subset) [PATCH v7 3/3] w1: add UART w1 bus driver
Message-Id: <170792567823.152954.6100416373090677412.b4-ty@linaro.org>
Date: Wed, 14 Feb 2024 16:47:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Wed, 14 Feb 2024 07:36:15 +0100, Christoph Winklhofer wrote:
> Add a UART 1-Wire bus driver. The driver utilizes the UART interface via
> the Serial Device Bus to create the 1-Wire timing patterns. The driver
> was tested on a "Raspberry Pi 3B" with a DS18B20 and on a "Variscite
> DART-6UL" with a DS18S20 temperature sensor.
> 
> The 1-Wire timing pattern and the corresponding UART baud-rate with the
> interpretation of the transferred bytes are described in the document:
> 
> [...]

Applied, thanks!

[3/3] w1: add UART w1 bus driver
      https://git.kernel.org/krzk/linux-w1/c/178cf9db9e6d8fb0c026098c8f2d1fd92ae3d79b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


