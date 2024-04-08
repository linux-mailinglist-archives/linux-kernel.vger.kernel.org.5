Return-Path: <linux-kernel+bounces-135257-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A08D389BDE3
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 13:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 405C71F21C60
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 11:17:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4C86657A3;
	Mon,  8 Apr 2024 11:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hP1fTcwB"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4291C65191
	for <linux-kernel@vger.kernel.org>; Mon,  8 Apr 2024 11:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712575058; cv=none; b=aM8sra56CvIua7fzUauPR6KVhod/26/fhvOFOurUh67ATuz/PSISGzW6RC8+teoxAmlkDsNGw05gD1RnobfjzuPhJMaXB0c1xkt7JR4HjMOfvbk+mb6BgulldtYpTdlSjUOs0zXxJrZOTmqi8htYJ4Mzd3VLVr20RokJBS0ACYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712575058; c=relaxed/simple;
	bh=Q2nAS9zJ5JzsultoypBp3VoX2SI43T/nUwIWrT9F5dU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tr0ecpLlLYacIvuRVsc3+dITd2s7o2m64JQUFLppT7j+p8exVIM1O3stagGXCyERxrMzlWMuedPujNC4PviN1XXrS3pi5WqwO4Wnr7oyFwN7oPIG/u3lTs7VlYD8GFbVe77fdW5iBbCyzXJ0hTjVDdRhnxNC4rez29PCYa/Vqd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hP1fTcwB; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-56e2b3e114fso3752509a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 04:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712575054; x=1713179854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yBhvJyC0h/XUjt9/wmeeQD+qmq3q42Avp/CPkanLhDk=;
        b=hP1fTcwBZByo4Y+45s5GXR7aHrEROqV6MdQoZKZkHoVZ7Ay29G7f9oSnA+6+rr9JYg
         v6mtLGFVMTeydZSnRPMm7YnV96q7lxdkkkJwBUBQl3CURPXC64I1PwiHXX0q1Y7tW9eZ
         IUAxSWMf6XgWfZbssfD/vwEnuJhBE5qy51gyCK/uaG/05yx8QmbZLdVP4uWC4K28hBaz
         M9NSor8KtxvOTxzmrCCMV2QbcljLAL7WQPshR54yMDHw3UUgXjCO4uWxiEVPcAhcDt6h
         o14r2yFr7xGYdzj5Yi3iwoCWLliBFsW2MT7kn1hfe8bPPebXDEjbGRTSsJmIyNQLGnFG
         R3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712575054; x=1713179854;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yBhvJyC0h/XUjt9/wmeeQD+qmq3q42Avp/CPkanLhDk=;
        b=Pisu+UONeIQyuJGcqa1I6aRz2uagK6/kHEOC2SyML9GIXoINbbKifcx/Bkv/D8rZ/W
         Kvr7SE2ObAA5qoj6UAgaeJYNYevtnRda+y24643ZkCf5LGYT7xHcTgEit3i7VUfsCvjY
         GumS4J3vULQYbQH10CablMmMiL7wpdg9VT++I2YVCgnXZGnsjhjBd/iZecqoP7VfgZ8Q
         eFhWb3mn3w16B7UYEAwNdyjt4eVzbVqqyZNZiu8r5IuJ9QvSZhCWDM1rXX9PH2tfda3N
         zZoZVW+7qF8B0onkEeA7A15nAi/qTnbdeHwOjKsg9kgrkIiPV7OpoV8JQoTqzgah6e/D
         NpmQ==
X-Forwarded-Encrypted: i=1; AJvYcCU8NRgzUF1f/1CiBiM0KcN6c5C4SPpEqI7a7QLHJ2OaQKhkU/z01G7v1KIHBPONWzt4teKeJLRMq3IbH5FgdrtPJgmMhE7S9I0asgal
X-Gm-Message-State: AOJu0Yx3cXoxYZBJTqRC2wHQJnfSGcAGi/Zx3vhhUzmRWepPsyKt+URO
	Kn91bQp7ltFKv9nRlpPlXZ4rONdrOQ9AQVJgzqz3A2bpnqZs3JDjOQX3xQbrxdw=
X-Google-Smtp-Source: AGHT+IGb++DvvZ312cO8dp/qa2cKF1dzcCoupByRCCKaIvaJRQsuaSwGsyypDPNTydTPn7xIAAROOw==
X-Received: by 2002:a50:bac6:0:b0:56e:bad:36b with SMTP id x64-20020a50bac6000000b0056e0bad036bmr5379371ede.21.1712575054510;
        Mon, 08 Apr 2024 04:17:34 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id p15-20020a05640243cf00b0056c2d0052c0sm3979188edc.60.2024.04.08.04.17.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Apr 2024 04:17:33 -0700 (PDT)
Message-ID: <ab9affc8-de68-4ec9-bdfc-02131191bc3a@linaro.org>
Date: Mon, 8 Apr 2024 13:17:32 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv3 1/2] dt-bindings: usb: typec: anx7688: start a binding
 document
To: Pavel Machek <pavel@ucw.cz>, phone-devel@vger.kernel.org,
 kernel list <linux-kernel@vger.kernel.org>, fiona.klute@gmx.de,
 martijn@brixit.nl, samuel@sholland.org, heikki.krogerus@linux.intel.com,
 gregkh@linuxfoundation.org, linux-usb@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org, megi@xff.cz
References: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZhPMHdt6r/4D99Zg@duo.ucw.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 12:51, Pavel Machek wrote:
> Add binding for anx7688 usb type-c bridge. I don't have a datasheet,
> but I did best I could.
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

..

> +  cabledet-gpios:
> +    maxItems: 1
> +    description: GPIO controlling CABLE_DET (C3) pin.
> +
> +  avdd10-supply:
> +    description: 1.0V power supply going to AVDD10 (A4, ...) pins
> +
> +  dvdd10-supply:
> +    description: 1.0V power supply going to DVDD10 (D6, ...) pins
> +
> +  avdd18-supply:
> +    description: 1.8V power supply going to AVDD18 (E3, ...) pins
> +
> +  dvdd18-supply:
> +    description: 1.8V power supply going to DVDD18 (G4, ...) pins
> +
> +  avdd33-supply:
> +    description: 3.3V power supply going to AVDD33 (C4, ...) pins
> +
> +  i2c-supply: true
> +  vconn-supply: true

There are no such supplies like i2c and vconn on the schematics.

I think this represents some other part of component which was added
here only for convenience.



Best regards,
Krzysztof


