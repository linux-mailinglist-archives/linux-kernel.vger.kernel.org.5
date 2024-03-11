Return-Path: <linux-kernel+bounces-98478-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FD33877A9F
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 06:33:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C5431F21545
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 05:33:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5065BA57;
	Mon, 11 Mar 2024 05:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="h1QDfWAb"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E914AD49
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 05:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710135207; cv=none; b=eYsXIbMbDGwOkCpEa0X6JkEQQ204QS1YfUsyNLY/xtBTuH8gm9lQ6FLMRdSRlev4tLmTTdRM7xMVLxGGBVKnZH+pJGoGczIqUp9174qvCcjOcgBl953Guq1mlhSh2TTe8HHGONyJGEMuipwRW4pObQLkK4eWuIGat5taTNQ/gqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710135207; c=relaxed/simple;
	bh=c1Jj/OKOwdyFxgT7GUzFPkMOL5JdpYnIhGVChT3rhow=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=th9KQhijpNqumyg4cttMvKl/oj1yHFmka9H87KShqydz6B5REOyF3RKv/bIrl8OUp89JygiyH7fZNPY64OA7SUI0zJHZ0XthFhIEdlIpZ4o4xLVLBQDJ6jWzDJ2sBUXvlexV8CvM4Vx24YyXl8PR9bw26Q5qHOrt6E5YWRwn/i4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=h1QDfWAb; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-41329af9093so2303935e9.3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 22:33:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1710135204; x=1710740004; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vf6ziAHwUB2iJxvqWItef7Hb+US6TkER3A1h79B0rxw=;
        b=h1QDfWAbcqT2qTDNOpD9xWbTVQ/p9IKiCCyMx6bTLylACr6lX65y4+74dSpQo2R7U7
         ESCQrJ0yzsCrCrF1E1V2DJwIU82sKSW6UNMpG9gZ2h6kYNxIaLn68HcpqNiX0eLyw9ec
         A5ztRnu5MNeeW+yLQF+i2FN7G5rF90d7ziqcmBuf1vRbmqUQzjx0GFk6K80f2t+bXhUf
         Pq4kcDs5YW+7EH1OP+/ZubGC4F121wz4BNZyxzgaU0Z6fLmJWwY6aZDasEHc+Uni5avc
         MgSmeUKNu9av1BTw1stt2XlKuFsCoVJOtC5EkTqZ9YVctB1aApse+eCBKnfS9hDNIljO
         ca5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710135204; x=1710740004;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vf6ziAHwUB2iJxvqWItef7Hb+US6TkER3A1h79B0rxw=;
        b=mM0L+gpNIghrRrugXvErXgTrjV/BYQuHeFl613RzXSU8/IththMaDHyz25AyG3Wznh
         ZhsburkwKpaNYZx5twBMlfAXaBKjPmkf4fPQBGHrl8upDXFDPUQwdYRoNQbU4vVJz+lx
         j3TUlgcScHBFis5NL6p3eWldt+SB+mUJf9Ir79huebU4QCBEXeRuD5RewBK56xo4mo4k
         bP1ajJvUtbG9y9Gj9kmP1nHtytZ/jTBV58hWhrdSq323dANIOZk/jEs+S6qgcR/yZ74F
         DKEWl3yYACSFr8NPof/UOeB0ftSkEQiV2hTVi6rLUbnzKxuwdVC8dGHftYpXPh2KKrPE
         JUgw==
X-Forwarded-Encrypted: i=1; AJvYcCWq9hoD+6bGFr0aUcULCn9+ppYC4sPwMhimrN6lNHSeZDHwEJDJsHduq2gitHpQGdy1mqdD+Db3ArU7Gqg6lIw3nidPNm6Miki7RmoW
X-Gm-Message-State: AOJu0YwBnFpGO7YCi3DZD/2+QEIrsNkMQdnIHgDHu5chY0iASBm3W2mD
	Be/ruccAJLPZIjOz1MSkRgQP1EGa1hUaZY/0GqnKsrO93p53bEuE/N2AnyofTqo=
X-Google-Smtp-Source: AGHT+IEV6Dqj56Jek3twInrP0sgJFDroTs6oFuScAjrE9QYaNK7R1/xlZYPyG9aBwUn2LAuU44piKQ==
X-Received: by 2002:a05:600c:3848:b0:413:2aa2:a601 with SMTP id s8-20020a05600c384800b004132aa2a601mr665165wmr.0.1710135203653;
        Sun, 10 Mar 2024 22:33:23 -0700 (PDT)
Received: from [192.168.50.4] ([82.78.167.38])
        by smtp.gmail.com with ESMTPSA id je1-20020a05600c1f8100b00412c1d51a0dsm7705109wmb.45.2024.03.10.22.33.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 22:33:23 -0700 (PDT)
Message-ID: <02e7ad87-cd30-4042-be57-b60f897fde67@tuxon.dev>
Date: Mon, 11 Mar 2024 07:33:21 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 22/39] dt-bindings: clk: at91: add sam9x7 clock
 controller
Content-Language: en-US
To: Varshini Rajendran <varshini.rajendran@microchip.com>,
 mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240223171342.669133-1-varshini.rajendran@microchip.com>
 <20240223172741.672694-1-varshini.rajendran@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240223172741.672694-1-varshini.rajendran@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

s/dt-bindings: clocks: at91/dt-bindings: clocks: atmel,at91rm9200-pmc

in patch title.

On 23.02.2024 19:27, Varshini Rajendran wrote:
> Add bindings for SAM9X7's pmc.
> 
> Signed-off-by: Varshini Rajendran <varshini.rajendran@microchip.com>
> ---
> Changes in v4:
> - Added the sam9x7 compatible in the allOf section
> ---
>  .../devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml         | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> index c1bdcd9058ed..eb5cd33ea9aa 100644
> --- a/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> +++ b/Documentation/devicetree/bindings/clock/atmel,at91rm9200-pmc.yaml
> @@ -43,6 +43,7 @@ properties:
>                - atmel,sama5d4-pmc
>                - microchip,sam9x60-pmc
>                - microchip,sama7g5-pmc
> +              - microchip,sam9x7-pmc

These used to be alphanumerically sorted

>            - const: syscon
>  
>    reg:
> @@ -89,6 +90,7 @@ allOf:
>              enum:
>                - microchip,sam9x60-pmc
>                - microchip,sama7g5-pmc
> +              - microchip,sam9x7-pmc

Same here.

>      then:
>        properties:
>          clocks:

