Return-Path: <linux-kernel+bounces-32895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A37F683618E
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:29:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449E21F27A4A
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620764CE1E;
	Mon, 22 Jan 2024 11:15:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xJoXbqWF"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C714CB4E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922123; cv=none; b=NKWM3M31Jtra06ZKzxT/CNIgJsH6omHwlmDvbPhVsonEee94lSfQloPeoqOlqP1Fu/ukkZ3CcDcHnxMf/e3Q6XehVym/mZ7qPJwpw6r7FaD7uMiDfEPUjrlpsGF+vv3LjEo31V7NUNMD3WZve/ytk1M9P3FdJvmG2AAYp5CBcDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922123; c=relaxed/simple;
	bh=3OixjCfC/vJBPrYQJIXZMxFyo9r6DQ/0hGmJhx+9Fd8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=gXT7ubnu8gQKe9hZKPdhiWiQQvR+UVMfggcO2ul7vBhG6H8iu0VhMx9HRfqjQlH0K5nCX0wDtLDmT166EquBkbRecvI+3cTpKC0oVesULWSg5xfcMURGF3PR5wHBWa5gVk+CfZvIOo2xy+hd17F42qwIL9zytQvwFAv7+9AiDHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=xJoXbqWF; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2cca5d81826so35164661fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:15:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705922119; x=1706526919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uJF6RPp4ByF2+TpwJUkUjfXUjHYpkhqnvraoyw5sHp0=;
        b=xJoXbqWFuMXe2YZG4229AZeSws9Z1UCUl3Iuw+AiEWUnPyZAVvZOvMjOPKGpgquxyo
         VdztJcuxHfIV2YRMW2DRkGnXMijjN32JmMKaWG7avPUF+cSp+veG5IZva3LhPLhrVSfq
         WQYQci8D8NMUCDSG8TghY3RZN0f6J62GZ4YmE6z+6YDkBBJrhynSgB3+MuNcJgsDbsj5
         gYDH3iVRvZMmJm8l9nrE+lHiaPCdwmaVrPgdKcqCHaVWzccdOqGyhA7pGR1nUWGN+fOI
         D4RkRnpelYKQgcvkd3MZ462+SXA1zqMrBy0zxdbWWfIiUtId5TmNUodA587bE3XnJ+O1
         gkyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922119; x=1706526919;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uJF6RPp4ByF2+TpwJUkUjfXUjHYpkhqnvraoyw5sHp0=;
        b=SqtrLU5ZIop0XuIcg1Rc9xwtmkEVGeoWnje17/B564Zv/topINseKXH4+ANtGrbFpY
         1pXLXf2kV8qlnqsMd6TuwnGUN5LgrnbqNntINJle9gIMAkLZfOz0L24SzwQq8dxbKBCe
         Qa+hEH64qIxGBmVQxYHBBoWO5Ig3tt6A3XMVEIcdMnovbGcts+0C42xwtwfWj5NkA7ul
         ddysJJoNrEMMh99QLuWY34gmzC/jUw5Lqg2yJuBCCxoqh6vgB7mYmA3MWeLS93KCDMR2
         eNS4ybgEvltznB/6OwW1pv4q3jvEoL0rIfwq5gq8fuq8E1rejeTQULTBbrwx3/d6d1Lc
         Hovg==
X-Gm-Message-State: AOJu0Yyep6Eu3SwrkusnwcCnSRPQJUFCV3u6Yvz3HWLZyLmAH9AZx69e
	6qtGggkM++73voo/GzJKNDgr98nu04OJFzOnaMHuq2jtyplscA4YkfzKWYoHfYo=
X-Google-Smtp-Source: AGHT+IEWwHRPP8j2MklwDstm9sjp83vi0PaCTfFzTs8W1vQy9YTYKn67IjFrwor3Obo97PYCN+qTnA==
X-Received: by 2002:a2e:80d6:0:b0:2cd:827d:e37b with SMTP id r22-20020a2e80d6000000b002cd827de37bmr1770344ljg.59.1705922119546;
        Mon, 22 Jan 2024 03:15:19 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id h27-20020a056402095b00b0055c643f4f8asm179422edz.32.2024.01.22.03.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:15:19 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: andi.shyti@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com, 
 tomasz.figa@gmail.com, cw00.choi@samsung.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 andre.draszik@linaro.org, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 Wolfram Sang <wsa@kernel.org>, Rob Herring <robh@kernel.org>
In-Reply-To: <20240119111132.1290455-3-tudor.ambarus@linaro.org>
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
 <20240119111132.1290455-3-tudor.ambarus@linaro.org>
Subject: Re: (subset) [PATCH v4 2/8] dt-bindings: i2c: exynos5: add
 google,gs101-hsi2c compatible
Message-Id: <170592211777.45273.11208171574563746801.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 12:15:17 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Fri, 19 Jan 2024 11:11:26 +0000, Tudor Ambarus wrote:
> Add google,gs101-hsi2c dedicated compatible for representing
> I2C of Google GS101 SoC.
> 
> 

Applied, thanks!

[2/8] dt-bindings: i2c: exynos5: add google,gs101-hsi2c compatible
      https://git.kernel.org/krzk/linux/c/a0f80b86ff53c2bb99662008269096ecb45d7288

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


