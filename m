Return-Path: <linux-kernel+bounces-152489-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBD8D8ABF32
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 14:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ECC91F210F3
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Apr 2024 12:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E083412E6A;
	Sun, 21 Apr 2024 12:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="k5ilTl9u"
Received: from mail-lf1-f41.google.com (mail-lf1-f41.google.com [209.85.167.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46A75F4F5
	for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 12:40:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713703257; cv=none; b=NIhklFUCFZt9WxzmRE5eivxtdX8hW7AyqABIoQ+2muEnw4Y2bjToRbsQirDjqfZn59Tf6PwPYVf8R4ujg4vmsW6lRfIZ/psWNSKY4A3NJQppo97zfYZkscE+aQx7rgJXQQkePd0SRXHOVqnQymRSNcziZZVlYtexFXKqXQLJ+tE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713703257; c=relaxed/simple;
	bh=dW1kOcEifwRzl1KNeRx0Q79M3bKyTBZ23icIQkSBoC0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=sbQG8YMhNiGEsjrg9llnJky1QKV358hGY1l5kQ0JSTUWMN++LvtJm0Wkvcw+nbWxZLt8/zc/hau2GiJHZzg6d30VzXOg80B3DZ67y/Lfra/3w93OWexbi0CMuHI4RCX4udioT8cZ2BSx15z0Ihrpd6DKc5U1N18Rlx6OYoPdK8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=k5ilTl9u; arc=none smtp.client-ip=209.85.167.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f41.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so3842317e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 21 Apr 2024 05:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1713703253; x=1714308053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDWs0sR/inffoYLG1YK+PRz8MadYcoIAfPJ+iCtLyCs=;
        b=k5ilTl9uVwQ3IJe8PL8Re1gBrCk0vxhLsmoR7dcSvB1zkrmeSJxd2qUTzUUAqMLhPF
         gtjiguUqpkOBAjGsl+qQb+JfkHCXj2DpIGaPbfoN/4qXf6dbLU3bzUn3v9JBmg08eJDc
         cN6/TWWcqe7wmGq45MJNOpAjXDec+3jpAdl3kveqfExGJGIzIjuM/kfWWDcrWGMheoRX
         cFpLY0y77Wy8xg3nvFbqodSy33jCr+cz8pklaG/7TJnnbmTmoWAVOWpF4d/WdodIgxc9
         voGTYsFGesegM05FKWRX6Ok6XaPlQKsgB9LZfgjygStXKALbRO//ILlENrRfAnDVyWCg
         EKvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713703253; x=1714308053;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDWs0sR/inffoYLG1YK+PRz8MadYcoIAfPJ+iCtLyCs=;
        b=q1OdCsgJu6ntKxoaXeKfCEJKuJ7fduzDymgA8GbzLeRTpPOOU8raYw1ou/j+CY5tAk
         zRiKIaMPuZ2EjN7EBwUJhgWWX/PNizd5cBiFoESyplpwQJptOuFXRNysOrXHEOauC45G
         uTVgv9UmI+PEUsIW6i7rxeuC+vgvCmE02/OTPiC/TO2zTVnnBlY7EcS2IXZzZJOsQqmT
         V4NXY9oDmG/ZkryC4RN3JBcNsc0lJZ/GD8FAIU0pb842l+pBsummpwS/BAlthpevLvOL
         56bqI4ZEHenwDjFN6tXTdXfvu3g3q6GP55kads8EmV4PD9/XqVZ8rkAL56zvKjzxMkpd
         obGA==
X-Forwarded-Encrypted: i=1; AJvYcCVVl40dMMc6Ymw+kViTjHM4kl/uzbJiWGBwW0PARlNTUh66XYrwQ7kuxPEO1x/IUimrjE05UYWUSCkmicXv9ks9zrqjplXrEXkZ97Jm
X-Gm-Message-State: AOJu0Yw6u7FTuNhRcvnirxZ1Tf0OSl8mhkX4u0s+bHaFmk9jZ6hkrrdj
	HyGvpGAywb2Q1vV2KIkXYyUOAWOtKbgAnt4stWUpx5EhwL0jHPB1bWgrErH+8iI=
X-Google-Smtp-Source: AGHT+IEWdOo1Q+ZLBU7EGvnAwixYTvlLURdGzWdqXO7xeJZLJ8TnWUAGg5TAEz2bOh2jpRN43KzqzQ==
X-Received: by 2002:a05:6512:2158:b0:518:8c8c:db58 with SMTP id s24-20020a056512215800b005188c8cdb58mr5854116lfr.65.1713703253107;
        Sun, 21 Apr 2024 05:40:53 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.53])
        by smtp.gmail.com with ESMTPSA id 16-20020a170906319000b00a5544063372sm4499209ejy.162.2024.04.21.05.40.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 21 Apr 2024 05:40:52 -0700 (PDT)
Message-ID: <7145d28c-307a-423d-a744-f18a9a0c4141@tuxon.dev>
Date: Sun, 21 Apr 2024 15:40:50 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/2] Fix the regulator-state-standby definition
Content-Language: en-US
To: Andrei Simion <andrei.simion@microchip.com>, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 mihai.sain@microchip.com
Cc: linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240404123824.19182-1-andrei.simion@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240404123824.19182-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 04.04.2024 15:38, Andrei Simion wrote:
> make dtbs_check DT_SCHEMA_FILES=microchip,mcp16502.yaml
> 
> at91-sama7g5ek.dtb: mcp16502@5b: regulators:VDD_(CORE|OTHER)|LDO[1-2]:
> regulator-state-standby 'regulator-suspend-voltage' does not match any of
> the regexes 'pinctrl-[0-9]+' from schema
> $id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#
> 
> at91-sama7g54_curiosity.dtb: pmic@5b: regulators:VDD_(CORE|OTHER)|LDO[1-2]:
> regulator-state-standby 'regulator-suspend-voltage' does not match any of
> the regexes 'pinctrl-[0-9]+' from schema
> $id: http://devicetree.org/schemas/regulator/microchip,mcp16502.yaml#
> 
> This patch series proposes to correct the typo that was entered by mistake
> into devicetree definition regulator-state-standby by replacing
> regulator-suspend-voltage with regulator-suspend-microvolt.
> 
> --------------------
> v1 -> v2:
> - drop "boot" from title
> - put in commit message a snippet with the warning to explain the chang
> --------------------
> Andrei Simion (2):
>   ARM: dts: microchip: at91-sama7g5ek: Replace regulator-suspend-voltage
>     with the valid property
>   ARM: dts: microchip: at91-sama7g54_curiosity: Replace
>     regulator-suspend-voltage with the valid property

Applied to at91-fixes, thanks!


