Return-Path: <linux-kernel+bounces-72768-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 679AD85B87E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DCBC1C218D3
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:03:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC760DE7;
	Tue, 20 Feb 2024 10:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Pb7JZOqN"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54D20605A5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708423418; cv=none; b=hNXGcMhL8phskCzlQ/TWr8e8Zjscv5OoHFe4vSgCtcOFrxw5GTAUvsua/75eGKkLN509pVPjY3j6ZTtdmbtVsqNHU05MTzWtOMQE5qaIcBHq0aW24TzB+x2LSzS/HkyPX73Njog1YiG9PP8Kyo1deIWKTxRTD9RaTUnXB3DBuvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708423418; c=relaxed/simple;
	bh=fCVM9fIx+QlZSaT2+jH9KFDPXgF5LsvTXo9cBJsA8E0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HTHM0ayl94l6Msq6GnxNGE3Ct9ZO5ayTAgn94nVFEYve+88DO17chL5IOpSfzfO7XFfJgQ6ElXzn5+jLAwV2oKOiUCyhlgkAwFtVZQpjlTIl5dcUUSz/xbXTPFv6eFOOkEveJ1XqhTpSlnOAtzATl0GqDz6YziK7muA3+4lzLP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Pb7JZOqN; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d1094b549cso76907851fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 02:03:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708423414; x=1709028214; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tPnQexsRXJiNv+6Xh39SXpzjoFxV7a2HocmDFObIvII=;
        b=Pb7JZOqNa+pJ6vsEO8h9GCP0FzOaqg61z74o0UvCeWgd3cWv2SW2eqPhrS1IifrU+s
         8MMTV0+L3+nMUeSrx3D2xLoG+FQZbq2/CUXS53NxayX69NSaualUv36kSmWBcUt3Yt2/
         PoNIv3KEJEOQiJ+3viXGCSmiMInK6bllWc2sQbY9qdWPwekb5tLG+NleW7ZAXgF1k3Js
         AuZGCJsu8PAIR6fZ92AEVjQeZ6hr5agKwSwbT5NNvKlAh9oxkGQmqKYyFVhgrTwtSsCb
         SZC0cXDmorLcq5++Kc0UU9tRjwZXL6VrDQrJjUR0d+wvWcx/I4jVKC7YP7nvn9LEvxJb
         Gtdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708423414; x=1709028214;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tPnQexsRXJiNv+6Xh39SXpzjoFxV7a2HocmDFObIvII=;
        b=CtlKyerTchZqoBNQtkkj+O7mTvLw0OJXIU0YEyIwu8o6Dm5uQyfPkZ8nx1k0unDXX/
         gmzaxmnlUxt2YcSlQ6FZh2nPZ4CtDB5Sw2VvlRgUzWHqtNRETWPY61mKxBEvZxsJv4Rc
         NGWY1J+1TymuPgaORgLkMhdKxZxjdJ7Rk4LQEnRRdL5BM5ULNq6IekME0p8ka2xTmUIZ
         2//2z6bGXsuTpPAqtAUC7naHlKRUNj9c7iTGezXnAtirkODNNshCPq8RKUSiTYi4XP+h
         IMwzgzxwRruupo6aVW9/pwpgXqkU1YcZwOKuRUjhdFUG4SaOPUdfurx/A4jYCWA6qqxP
         4Uew==
X-Forwarded-Encrypted: i=1; AJvYcCVsSiNWOoGqZi7vOC3sQKjvBSiOG96OI3nI0JzzpsRCKeskcFhUBwYqd2u4AHVy93HJweKY8eJaXbP+y5vpLwq86qDc0XjWTqWOFbT3
X-Gm-Message-State: AOJu0YzSoC6RSlLRuVtph7DxtGnRu9JbYlYJWpgzJGAJoYdmbiDGzBO/
	yZDWn+ZX7BtCJXs+oP46ItvSSSmEaDQHp5bvnw6PiaKkDwCMFhseMuuwcKZHa8Y=
X-Google-Smtp-Source: AGHT+IEPY4diBzcZEzsnFr0+2CA8TYPIUOfHX7OUpwZ6ThGMdcjalTAKRrYBdcY2wLvk0txXManmkw==
X-Received: by 2002:a05:651c:b2b:b0:2d2:2fb3:38f9 with SMTP id b43-20020a05651c0b2b00b002d22fb338f9mr6147863ljr.13.1708423414559;
        Tue, 20 Feb 2024 02:03:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id az19-20020adfe193000000b0033d6ff7f9edsm839756wrb.95.2024.02.20.02.03.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 02:03:34 -0800 (PST)
Message-ID: <466c26b0-e7e0-4feb-bf37-be2af7136300@linaro.org>
Date: Tue, 20 Feb 2024 11:03:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/2] dt-bindings: leds: Add NCP5623 multi-LED
 Controller
Content-Language: en-US
To: Abdel Alkuor <alkuor@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>, Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 ChiYuan Huang <cy_huang@richtek.com>, Lukas Bulwahn
 <lukas.bulwahn@gmail.com>, Jean-Jacques Hiblot <jjhiblot@traphandler.com>
Cc: ChiaEn Wu <chiaen_wu@richtek.com>, Alice Chen <alice_chen@richtek.com>,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240217230956.630522-1-alkuor@gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240217230956.630522-1-alkuor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/02/2024 00:09, Abdel Alkuor wrote:
> NCP5623 is DC-DC multi-LED controller which can be used for RGB
> illumination or backlight LCD display.
> 
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


