Return-Path: <linux-kernel+bounces-79102-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9D50861D97
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:26:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92212284C9D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:26:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9D6146E7E;
	Fri, 23 Feb 2024 20:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="YJ4kvSwN"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB1E143C63
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 20:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719993; cv=none; b=L46ZpY6yKrgohJ+PFaQcbdLPP0wjjNXJruaZ8yCRO++2ehkj67a2LwP89MF0L3UYfvwReZ/Zg2U/VjwOvCOEBnYzt2qwcBTYYSz3hewDqXXRCxrQsWV8xYXe4j9q6M9CFU8vjcyXZ5iNhuajANOT7FUL4PeRhWTboDswz7vnqlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719993; c=relaxed/simple;
	bh=HLyr7ROhGCkL/lP6m/kzuKlFdq6kVvke+W6BoS0546c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sx1GTe52IAJx+Tnl8hd2DNkKxGBsdUR67Fn01dhpBsIs47EBk+LojJH6l8oI2o99lM3QhljBAmZnxMNdZmmRpH2eTWITVWlkNJKTmPrLuiCA7sfUC8tCKAygBbt6e3IkBn3eRDBQrFlRjJUYusCRT/7E4/nN3xl0kOSfQ4MCUQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=YJ4kvSwN; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-512bb2ed1f7so978570e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1708719990; x=1709324790; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yWvb/XHq8Q6aqJeOLoCWDDoxD9++zMqFobMcAAQVRZw=;
        b=YJ4kvSwN1o3fvJxQUfJd3vp3gjFwiq9H+JpdE+LadrV8LrNJbQ78ebO3q+dus6zP7r
         9p1DdVN+VCzxHxYq1x3/yakAFPu17x43QHpqqO8WWlEKu541JCY4HpitkWFVAOZ0P0mt
         suNr1pgycMZ3Ell/ZGRSgDhfLpBVypfYK/qU0jBNgp3rm2DC+Pv7V9aB/1BxkTU9BxEY
         PxtZc34bbEfjGUp7YMSpcaFc8DCKHpBcjxgcHvGZhOmyq4vCISlWULGzPSoBw7zax2Zf
         9jIgW51DipHiyfpdORRUtvA+ou1XpWS6Z0TfOyZNRFvAsJcr6AGOY86lHcmXfN8Z3f/f
         Kalg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708719990; x=1709324790;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yWvb/XHq8Q6aqJeOLoCWDDoxD9++zMqFobMcAAQVRZw=;
        b=XdYQk7ST2in0EwxEP5SY0b/y03P/kX9CEtmuzyLC6xtXoQxtg1dKLIX98mm85SkkRT
         aRsFsmxaOyL7hiumahD+7Z2ABYSVfa3oKoZ9LeDntkLSIAgswuunpytBZwSMWfZnttL7
         G7ICTi1XvBOSOTH3t3EKtL1PUXxTZ8uX+vR9uDV5aMoCrYh52r4hbKm4WIb9raAkTcWR
         vBGBJdC4IhAnN6qHEijsfy+F+nACeh1c7St8a/aUySmGy1bg31lrmBDoGUd3vRZIu3nD
         Ii6NPyqf7BJ2eDg9YeGT3ofYE4k2LR8UT0zEuvkcLorj24OGmJNPcCmHdmElWwS7+hPr
         Iffw==
X-Forwarded-Encrypted: i=1; AJvYcCXDk8tERral8bDh8J8WjsSgRvO0nUX7/DaXXm83dT0kQGUCUUq2GFDoios6yQor6lZpvrjuGd1gGIaFOTxeSQoZrYGyle7lgpmnYx6i
X-Gm-Message-State: AOJu0YzJ7rKXOj8cYInsi/I7O//NX/h7itwBrmLE7l2qABMsQbmBJ83U
	YKV+BXfcpMUP5hdhKjagFIW2PyKxM7Sw9sMpCfbFWE4XNeyKcjIdfDb+Kd+DhpY=
X-Google-Smtp-Source: AGHT+IGttiG5Da1sOkxUUNjUGvccyWpMoFitUkXOpJSSCZE0jVizCC5ZXtBlPVnpupdAyuTr4zySeA==
X-Received: by 2002:a05:6512:3a93:b0:512:be76:ad37 with SMTP id q19-20020a0565123a9300b00512be76ad37mr510524lfu.32.1708719989625;
        Fri, 23 Feb 2024 12:26:29 -0800 (PST)
Received: from [192.168.50.4] ([82.78.167.99])
        by smtp.gmail.com with ESMTPSA id fw14-20020a170906c94e00b00a3f04112c0csm3705544ejb.221.2024.02.23.12.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 12:26:29 -0800 (PST)
Message-ID: <19f3ee5e-bb7d-4677-93a1-452e5c0854b8@tuxon.dev>
Date: Fri, 23 Feb 2024 22:26:27 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] Add initial support for Microchip SAMA7G54
 Curiosity board
Content-Language: en-US
To: Mihai Sain <mihai.sain@microchip.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com,
 andre.przywara@arm.com, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: cristian.birsan@microchip.com
References: <20240215091524.14732-1-mihai.sain@microchip.com>
From: claudiu beznea <claudiu.beznea@tuxon.dev>
In-Reply-To: <20240215091524.14732-1-mihai.sain@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 15.02.2024 11:15, Mihai Sain wrote:
> This patch series adds initial support for Microchip SAMA7G54 Curiosity board.
> 
> Changes in v3:
> --------------
> 
> * Update flexcom 10 node in order to match previous flexcom definitions.
> * Use alphanumerical sorting in Makefile.
> * Remove adc subnode from flx10 node.
> * Use C style comment.
> 
> Changes in v2:
> --------------
> 
> * Remove bootargs.
> * Use phandle style for clock nodes.
> * Use color and function for gpio-leds.
> * Remove status okay from leds, nand, eeprom, pmic, flash.
> * Use generic name like pmic for mcp16502 regulator.
> 
> Mihai Sain (3):
>   dt-bindings: ARM: at91: Document Microchip SAMA7G54 Curiosity
>   ARM: dts: microchip: sama7g5: Add flexcom 10 node
>   ARM: dts: microchip: sama7g54_curiosity: Add initial device tree of the board

Applied to at91-dt, thanks!


