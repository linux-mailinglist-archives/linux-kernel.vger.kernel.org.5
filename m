Return-Path: <linux-kernel+bounces-110977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A53A4886691
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:03:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B4C21F21EC1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AB28C2C6;
	Fri, 22 Mar 2024 06:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XX6awNg3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B665CBA27
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711087418; cv=none; b=KtUzdwHOwC9BVq1UfWDvCuH6E4PMiwcYgZOLlpg2W+aJrXM+iPSdxNOlyXLI0oxoNA4Hh+IL6WoXwI/L6+fL+LkqzG36rW/o7w4zx9UOy0jbNcHmL8jMCLSCzG66hksSWNfQHIbPnC+Rwt2F1xXPBlE5EbUm1dWfOYz4SAAObwE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711087418; c=relaxed/simple;
	bh=+F0G6/in2BkDnVYQ5O0+3PsxGKOO/xMJWzK9fMJp3iI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YcXhSf5Ax78P2IkrdVmDwOdSMTKlRdhIqzZXlWp+sITni/3xrG4E8A6i+lMp2XBvz+/+DxONSqz2N0adJzGZTbH4gY2BKtqwPT6KEU1YjWgCCV77jXBdsWAb2OB1pnuZn5bZudiiIBSRzTf1SqzQzAdfTnmI+wnZ80ufRdnEE4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XX6awNg3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-513ccc70a6dso3012474e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:03:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711087415; x=1711692215; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I8i4ISxVR8Vcds10kSP2s7EbKkeC6qcjl4f7d2GHj58=;
        b=XX6awNg30vbmFEm4PSqiLURIN9YDVnWtBHWP7UYYuLFbF40QLO0LZkqD+CPsx1cvPQ
         eVC3JBAd0pdovKUmhB54aZ+1DWW/cAOpfSUQCcIGcLBLiZslXuya+X6fhxDpeKuUPdzu
         bwz/v0vtfk9mEg62N0xmnLHDH32EL5ihE4nr5YN8WLzuA9cQgFJNJbI06u9qJpb9qKI8
         KrSoVVXbgkB6qWh8QfLNv0JuE2oAfADV0T+c/1dYMjqlHgP77+rJnTW3Z+3f7FfpIxA/
         PV56TSgOay7VqgFBXmsu65gBtAd32icWlgI7glh/C7gvAqSH3K9ticS7F3bm+YwKu3fw
         v07w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711087415; x=1711692215;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I8i4ISxVR8Vcds10kSP2s7EbKkeC6qcjl4f7d2GHj58=;
        b=NA6BpBZcroYocnYFMiifO1sErNNUGP4e4Ese2PNhNer9carD9MsYrB8fP+AMJJ4mXy
         dAy/aucS1FgD6Hi86qvkYQcuae+SMXR4mcYu51tOu8iB+cxx1ap5VppNFFhypSfDN0UI
         ZD5vScnrnSZhkRQPGDxnxJO8M2BGeTzOTGqQb2m96YfNPfFxIajIjck7SlTapO788ojN
         4UidADRBja8A6SdiHATWoEhx1WeuZ1YlkBVTxtAfSOhGPlHTiRq6mgwMlbJCybyrnhRS
         ywiGBSuTVCcTeomBrg66bRWZF+2DBOK0AgwcJEVpqTeFJpBx6ooHH8Rl9tXYRYd9iLl9
         MO/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWir4kypsROq6RV9m4vOnYIXgaXkAdGDVi/kUORoasOWQCzrq6ZK2QU0pBfcbkqzURGwEmjRaZRDQSPOM9jLBP34tl+Rrktf+7VX4hU
X-Gm-Message-State: AOJu0Yyrnp/7sYBIeeClxalYr7EXtr8jYHiKGGV7IfImrOGXAepiOdaM
	uuvRaww3bVgraT9tlkfF8eq2ESu0Wqhkjiwlh3Qr8I2A9xGP/xs3gBFOdDfIW60=
X-Google-Smtp-Source: AGHT+IFeh91zYr2/thjRhjCzq5/V11b6kxCDQYooaG+eWV7na7otGmaC8T8O9VoR8QXuDeMAjFwF+A==
X-Received: by 2002:a05:6512:1cc:b0:513:80cd:e80b with SMTP id f12-20020a05651201cc00b0051380cde80bmr1153756lfp.29.1711087414849;
        Thu, 21 Mar 2024 23:03:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id h17-20020a1709063b5100b00a4636d9d28dsm650260ejf.69.2024.03.21.23.03.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 23:03:34 -0700 (PDT)
Message-ID: <affc1b03-7a23-4fd8-bf85-4155bcd41df1@linaro.org>
Date: Fri, 22 Mar 2024 07:03:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: dt-bindings: jcore,spi: convert spi-jcore to
 dtschema
To: Kousik Sanagavarapu <five231003@gmail.com>, linux-kernel@vger.kernel.org
Cc: devicetree@vger.kernel.org, linux-spi@vger.kernel.org,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240321180617.35390-1-five231003@gmail.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240321180617.35390-1-five231003@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/03/2024 19:02, Kousik Sanagavarapu wrote:
> Convert existing bindings of J-Core spi2 to dtschema.
> 
> No new properties are added.
> 
> Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
> ---
> Changes since v1:
> - changed the subject line to conform.
> - dropped desc for "clock" and "clock-names" properties.
> - cleaned up stuff.

You miss many other changes... Some unusal properties appeared.

..

> +---
> +
> +$id: http://devicetree.org/schemas/spi/jcore,spi.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: J-Core SPI controller
> +
> +description:
> +  The J-Core "spi2" device is a PIO-based SPI controller which used to
> +  perform byte-at-a-time transfers between the CPU and itself.
> +
> +maintainers:
> +  - Kousik Sanagavarapu <five231003@gmail.com>
> +
> +allOf:
> +  - $ref: spi-controller.yaml#
> +
> +properties:
> +  compatible:
> +    const: jcore,spi2
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  clock-names:
> +    items:
> +      - const: ref_clk
> +
> +  spi-max-frequency:
> +    $ref: /schemas/types.yaml#/definitions/uint32

No, drop. From which other SPI binding did you take it? I asked you to
look at existing code.


Best regards,
Krzysztof


