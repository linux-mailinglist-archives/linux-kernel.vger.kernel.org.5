Return-Path: <linux-kernel+bounces-167349-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50A578BA856
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:09:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 47A62B2119B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:09:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D001148849;
	Fri,  3 May 2024 08:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PkMRn9rF"
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com [209.85.208.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E521487E9
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714723736; cv=none; b=C0iXJWegtH159fuCFYyCNJIRrGjREndNbcDp5Ec8R123Ee4+rpg/tmnHCu7qUggTjBHKsQ6lxjXde/d82zNQ2B8kOzvPNsvAMQXcZApFNToUeKocrwb5R6MVAV9BVWOzIYxJVaifOWrCxwaDpnnU7xeeMHLS8KpKHzsINZ2SnaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714723736; c=relaxed/simple;
	bh=7qQTzG9i8KLzJJyyK6v5uKKev+BF4EWHDk9zrcLv0m8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ABkhg2AuBS9lOULXJN3F7kaUZf7kGLzUB4fRuTruY5qcYU1SGNrP3BVrip75JILSQ0yTozqz6t7Z5Nl7EbNA3tiqeloO/0znYRF2nEEIavqs/NSMTN8AImOIAcLfMMbNWX78h+JwjgcFSG/FszMzcWUVZsvbqXHzTWTovWLzRdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PkMRn9rF; arc=none smtp.client-ip=209.85.208.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2db7c6b5598so113645411fa.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:08:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714723732; x=1715328532; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9F32g4MjpRz2uIAU44wJHuksonJ+RwP1zeSV74QN6B0=;
        b=PkMRn9rF+tpXpYn2yYPeTlN0KUIZGIQerhBQQ33P+TJOAxT0Iey/nbhLiJ6dmD2DdH
         JViZ+tIzWlzUkxV3gkjIGVh1ayzYy2usZPN8CDj3tJUFa3iU44BP0ukqhvT8/9FwMvK7
         psMKjDC/GPRq53BEEHQxGpaFP7CC/oKmrCY/q4Plf4Aod+YQexyZnvwEzb+675PPozvb
         EirNhLy6p6BOJv3n1B1JFKY7lx4/vd7Ea5i6BofxOGQi2NQ+KvdYb9YGvqGgmA66P3qB
         cfxg2oZq5TXSf1mgjbchm7NSgy1zrRp7WLrtsa9lgVPbyLX+msvh0bb+vnEXp0puWc/H
         NMjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714723732; x=1715328532;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9F32g4MjpRz2uIAU44wJHuksonJ+RwP1zeSV74QN6B0=;
        b=GqnL2mZzgYwtL3REd/vo9ebiVne2lXfxriyUbYkpvISDMH2k8sYgnPvr4IX6IacpVY
         kb0SHgec/eA4olC8m/njfgl2wPHRQk0QN9IfryQ4LTxQQHSi0zgcg4RUNAUIUg9fDbO5
         3/MmoOetKFp2Mwa6NrzrpR4QFoVy0PnU86oDiaxIVg9bFkS7TV/XcYyj1KoLJfUofUk3
         cui9m+3q3SUCOqOyoMUaMfOesH1pStVyTlaFlt0hCGMYuIKxs2xTHIDfeNzNAufQvNwR
         ASgaIBajUEWs8tHAYdVSmv+dlYzF4f0r9gJ96sjCTcFbXmPTIPtdGgdQ/iyMFREqT9G1
         3FSA==
X-Forwarded-Encrypted: i=1; AJvYcCW6vF2VVScEJsprPW5esLqwZsf2ECqmhwh2egJCWcu379xKgcOdhxvu8ZbNMKJNnMQlBY2kqq64y91hLE8XWExeS+2rQBQ6BV26f/Li
X-Gm-Message-State: AOJu0Yz3yZsCejK+O7BNrtzYBBus02l3YeH45A/cn6g5Gm+zSqQE/9x2
	fIftW2hPHjszra6fAJKgnMkXfmso7EUVVwVZ7wxwJxVvDFMzEUz1IYRrLenokgQ=
X-Google-Smtp-Source: AGHT+IEyVSxtgBjxgwR445qD/sr1uxqCDskSMlyg7yV9YjhIzBtojmFjs//+3uZsQR/8QqR1GYTL8Q==
X-Received: by 2002:a2e:b0d5:0:b0:2dd:7712:efcf with SMTP id g21-20020a2eb0d5000000b002dd7712efcfmr1255172ljl.10.1714723732369;
        Fri, 03 May 2024 01:08:52 -0700 (PDT)
Received: from [192.168.1.119] ([37.251.223.213])
        by smtp.gmail.com with ESMTPSA id v18-20020a05600c445200b0041bf21a62bcsm8456940wmn.1.2024.05.03.01.08.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 May 2024 01:08:51 -0700 (PDT)
Message-ID: <a2886f72-210e-41a1-aae0-c079a4d11396@linaro.org>
Date: Fri, 3 May 2024 09:08:49 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mfd: Use full path to other schemas
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-renesas-soc@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com
References: <20240503072116.12430-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From: Tudor Ambarus <tudor.ambarus@linaro.org>
In-Reply-To: <20240503072116.12430-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 5/3/24 08:21, Krzysztof Kozlowski wrote:
>  .../bindings/mfd/samsung,s2mpa01.yaml         |  2 +-
>  .../bindings/mfd/samsung,s2mps11.yaml         | 12 ++---
>  .../bindings/mfd/samsung,s5m8767.yaml         |  4 +-

Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>

