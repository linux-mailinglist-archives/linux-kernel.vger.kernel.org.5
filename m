Return-Path: <linux-kernel+bounces-61182-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF605850E75
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:03:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27921C21780
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:03:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 282EC12E4A;
	Mon, 12 Feb 2024 08:01:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n1GFIS8a"
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5FAE13AE8
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707724863; cv=none; b=PfHYCongnEvXv8tdSPTgdksfJoKS1SGVCoYFnNulSF1PwN66HUOLz6V8EP0S0dZkd8cgMLCngjULd3+BzFeVcYf8Rfkquajh4CJ/mPakcH1nctPMjOHDmh59GkafcaU1do9POOxclXDbtbCc/r7KcTHLf4Jx8zPl7IcQZ75Ih18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707724863; c=relaxed/simple;
	bh=bgv5RdC77n/PTT/J371lb6F7hPd7oWmVCVjSctYXnWM=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=ZVVErggkaAEyVl0qC3WKTOsinruQKHY19nXohdk24oSsNpfGWg3OpPTKqk2RVZFH5zWOapcQjEXI2ah6RV54mbe3lt28EOM5KUJryhyRZNJ0Z1XCTnTA7nU2Y2Uo80JkhJmCbC+dAI9PLkVYDZ7xXRyV4O6zuqup2yM78w/xT5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n1GFIS8a; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2d094bc2244so35633181fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 00:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707724860; x=1708329660; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHvXGwviFkH/t0WncAdojj7zBVQIStnGPAIN9rB+ikY=;
        b=n1GFIS8aIF+yt05dMykBnB8amBIHLGBGPiFOx8H+iQVsuWfmimQZ5jPWjqFeOE0wMg
         28b0yuZnfF6Rm+l76cqypSIuqUh8AFbzJ0xpwvtOB3pmh35eHhVvC+Q+Y+3SzWay3D1D
         8Ggb1ysi+gptwwvl9eC8sjZvUUjA3CMP37N9D8qC4w5RL1cRGi2tGao36uOv+Q5eomNX
         KqZowvyNxtm1WQLo9aDorvuxBsv7mjkIr25uOe2943rZ0SF+j6/1KSKcHVNJRmvcETmh
         4CV7nwEWxi9GstuQldlXatFnwtW8FEkaQOVd7G+ZfVqVXqk0JdhK3ewLsZJ4d6UGel9p
         UtLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707724860; x=1708329660;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHvXGwviFkH/t0WncAdojj7zBVQIStnGPAIN9rB+ikY=;
        b=AfGKBWajNdDlYqSnfDjSPsALw4boOm4CHP4iG4gWwe8mUpBUfMR6yYLI3qW7cXWJFc
         xesynP9/F2/cUSEXPpJaKV810QpDeJy1jmFqrcmnDcz/h8KKCz5VzDky3v1alhClbVXd
         SN8XkYvLvl9N9Fat/ixOmq0AUqewq8kyA5cj8y6bnkb8ztP4+2u1JvuICEwK789Uql6D
         ihMQRVuLiEZjgj9OFcyu2HFPV1rJUMY7izEDGdISNBCV1rI534iAzVs36Sw4MuHKymxh
         8BChB9FRAnMcb2lQe05HidycACDYXo2XgfAiXFSEOFJwQcOMcEneTdxmeZkj+whWF5iX
         64rw==
X-Forwarded-Encrypted: i=1; AJvYcCVn5VrVH4cDsFM8sm+rabYprxsK4eXxTDehhbdqrj3wE3S796ZG89myzt+e4g7SqqvhZJUjctlFS6lJrWeK/oc5t0GMKvsvUbO20Nu7
X-Gm-Message-State: AOJu0YxKzu0G0uoZ4aPfdPSn9959PoT7aTRY+Z/vAfdKHLLRShjDxdIf
	m7AklaCE3lf5550/oni/OKfew6+Ncd8PpoaY2K+vRFI7iszyvAGLdUAZJjNiyokfcfe7Ohj21Bt
	o
X-Google-Smtp-Source: AGHT+IEOUip9Mfu7SWwu7DiRZPOo1T4hbkFaQCvsdxfTEnT6DqFQGp+WtTXerXpUdHVySOE0+14mtg==
X-Received: by 2002:a2e:91c9:0:b0:2d0:e0cc:7865 with SMTP id u9-20020a2e91c9000000b002d0e0cc7865mr3534647ljg.43.1707724859882;
        Mon, 12 Feb 2024 00:00:59 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVVgpiYXorB3X/EWxB3hse9pm60pVWCUp88yliSb4p/J4bCT4xuKU7dVVVpDLzhaXlhjRL1FNKMJteyxB+wiqPz6UwZE4rItNKVmNf6yyJkOg0b+EIa/2R6j5C332LN6VO+wPxim7fL3dYVSFC2fFkKYQY/ABPP8K1j8RjOqJd4lxa77TwIkjAW3MDZfvmD/5kkye3Q+UMbv1FZ7cQcN0cQtrsJgfqwQDTRcdBU4TJw9DTMzNnxzEv6
Received: from [127.0.1.1] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id x9-20020a2e3109000000b002d0ceefd3e9sm1315818ljx.99.2024.02.12.00.00.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 00:00:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Alim Akhtar <alim.akhtar@samsung.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
In-Reply-To: <20240211-bus_cleanup-arm-v2-1-3de9e8af7cbd@marliere.net>
References: <20240211-bus_cleanup-arm-v2-1-3de9e8af7cbd@marliere.net>
Subject: Re: [PATCH v2] ARM: s3c64xx: make s3c6410_subsys const
Message-Id: <170772485844.8549.14056972492264035636.b4-ty@linaro.org>
Date: Mon, 12 Feb 2024 09:00:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sun, 11 Feb 2024 12:57:09 -0300, Ricardo B. Marliere wrote:
> Since commit d492cc2573a0 ("driver core: device.h: make struct bus_type
> a const *"), the driver core can properly handle constant struct
> bus_type, move the s3c6410_subsys variable to be a constant structure as
> well, placing it into read-only memory which can not be modified at
> runtime.
> 
> 
> [...]

Applied, thanks!

[1/1] ARM: s3c64xx: make s3c6410_subsys const
      https://git.kernel.org/krzk/linux/c/a3891621d4a0783ae178d6f2845517e3dd571dd4

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


