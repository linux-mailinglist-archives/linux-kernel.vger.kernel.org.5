Return-Path: <linux-kernel+bounces-163488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C41158B6C04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:42:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E819E1C21EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BD33F9E0;
	Tue, 30 Apr 2024 07:42:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TdXxaxXs"
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764013EA72
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714462966; cv=none; b=N65tYa0gGsFO2qJABQtK1/V3kzpyR4uyAwmJtfcpgnJ52gJyW1nhUscOViATw2Lg1vn1dm3QPvJV1EjZK+RvtKaCJcb5NuCjJ/a2X+RDV/UB+mWWyh6NTJh3TrNtCyOgZi8NIagImHZvvyrzxmKWnmnUKEPr5Bn4mLICl5vegV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714462966; c=relaxed/simple;
	bh=6rOSQeWbEhAv8MCLaqz4msA0/THApX/ROztnBEcH/ZI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=akIgmkvYN4J7pH7JRCmXbWyYrLS1Ulp0F0TtYe5Vl01PZ7klhWILWKif9M/1yVEciqMWoGf7Q/39ECcWFM73h9cYX6EIPcm/PnvSZa+EacEbO30dHv1x6l9QRTVQMY1WdX1fOrZrTidK13BA3Cc5twJDARGBX7i7PDKDJ9L6Bw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=TdXxaxXs; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a51a7d4466bso587616066b.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714462962; x=1715067762; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5p+Hhe5o0oz9SnrKznY0Fc+JFHlQEV01P0MQ+lMur0=;
        b=TdXxaxXsJ00JCbd4wmYYur+0wi5UWdEXowlZwsXZJTVUhOmLJbm4DchDvOG1A4e449
         ldyDHYDL33k3hVJPInivhD9pYDQ6dgoxmux0Ofsoga8pXHkTrDKgAVuNvL0SIc9jYxc/
         NNg2p6JNO2BL2z5lVkoVqfJ1ex2Y+fhxiULsy22sr1KMAObAxsrYwBq3tt2AxopMDB9w
         xF1fGQ8RdCPl5F7PzeqSKCMUu7T5WWUsTEwIXyfhwYIa8dGfAj0EnsiTbeI++Uw/OJEs
         21aZX2UCCjkD4jD6dKO8PNvwBAQ7fUqNE/qtRomTH1Nz1ArqwhNfvyIxCd43qu2NqECl
         4hHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714462962; x=1715067762;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5p+Hhe5o0oz9SnrKznY0Fc+JFHlQEV01P0MQ+lMur0=;
        b=M9qZuVOxvrqYN2QDGNacunVPgz03iBi3OY/ALgcTH5/dbtKOd1UZc4EBNBe1QWWj9x
         FUV2qV/ExwdVWbmmrx+C/ggq3eEvG8adJhCuffVEt1hKR1Og35ky2dc1ABfMVvHskp0I
         RYgUutEyQqrskff14/F94mhTKUdCU1zmlVhc3Gi9WjVlzFcs3sGiRr1umK9l/UDfPYH/
         TkM5XPNCOZ8xaFZqevzHE8Dx13p0GAhLkNBE1bgnG26MnAM1zWSsCdLqtlcW5E8NUdtG
         2om6hPRlPzmFvK91xxEW8fH3aeyz76lINPSeOzCPJdYBpCy03pQtXgQRvauwp3xwdtts
         08Jw==
X-Forwarded-Encrypted: i=1; AJvYcCVkqa94eAoPQZo9PeMJU+lEY71KJFEe7tPCqPZs+Z76xfPyqCXO6CiNHnYeUXwrQrAk+EF5XXDqzL6RzzHG7nnfAj3ehBR9mt7hYpA5
X-Gm-Message-State: AOJu0YwlQggQe7sx+kdGkLonxR4JEtmy8GAviLG/5E22N/hanXEk07mN
	veHkshKriqiWApFEmncAncCNmIHD/tn2iGCNRv5x//F6H8UBirp9oXKJWTcvzTc=
X-Google-Smtp-Source: AGHT+IGBMuRm0U6K3jNaqA1YmMlR1gvfu8aRSrgUg/G0JYE7jjhY0WN5zoh6hbRFgw5euhqtv+xtKw==
X-Received: by 2002:a17:906:378d:b0:a52:1770:965 with SMTP id n13-20020a170906378d00b00a5217700965mr7467711ejc.42.1714462961803;
        Tue, 30 Apr 2024 00:42:41 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id p11-20020a170906a00b00b00a55892e840bsm13175844ejy.205.2024.04.30.00.42.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 00:42:41 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: kernel test robot <lkp@intel.com>
In-Reply-To: <20240430060304.12332-1-krzysztof.kozlowski@linaro.org>
References: <20240430060304.12332-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] pinctrl: samsung: drop redundant drvdata assignment
Message-Id: <171446296047.37280.9740688458228801878.b4-ty@linaro.org>
Date: Tue, 30 Apr 2024 09:42:40 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Tue, 30 Apr 2024 08:03:04 +0200, Krzysztof Kozlowski wrote:
> Fix W=1 warning:
> 
>   drivers/pinctrl/samsung/pinctrl-samsung.c: In function ‘samsung_gpio_set_direction’:
>   drivers/pinctrl/samsung/pinctrl-samsung.c:633:42: warning: variable ‘drvdata’ set but not used [-Wunused-but-set-variable]
> 
> 

Applied, thanks!

[1/1] pinctrl: samsung: drop redundant drvdata assignment
      https://git.kernel.org/pinctrl/samsung/c/e5b3732a9654f26d21647d9e7b4fec846f6d4810

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


