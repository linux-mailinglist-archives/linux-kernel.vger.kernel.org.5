Return-Path: <linux-kernel+bounces-38473-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 238F183C06B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 12:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B1FCB1F24F68
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 11:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E86EB5BADB;
	Thu, 25 Jan 2024 11:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tXUmYTYV"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218F17735
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706180678; cv=none; b=ZfZ88186I29JK0g0klZ3QOC7qVyxD3M2/12Rg9LYL3GdM1CH4n/iYOsl95d+Vxz/0JUsHraSBsUSELy2+LnyKqcnB+wK7uqu1jNbnWaMca4KRADkcYLoi3v8YmVpPicNeuAfkekQ1+/YJj2yTraCBaTTevQ5paF3qwAIUlXiSMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706180678; c=relaxed/simple;
	bh=Ts9q+13xetCVwAeVTuiXnLneaHqI4vRmZWMNM3PN1Cs=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=tp0D0jC42JP42BM53n4+OWIx2JrlT0EaIr8dOC7X2qHX5I9XdK26qFOAF2TuqR7vleU3WBU1eicZ4l4lqH/8BkrNsJAomd8lL9Wbtoh/0zByqezoBJFyxKTG+kMbVku7eYnDFOJAHRAsMKLd8e5bTMu1r30qhi6GymY60j81oNs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=tXUmYTYV; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2cf3a04ea1cso4675291fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 03:04:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706180674; x=1706785474; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqKqhdtGXtBOJU6ppRXF6CRxwiYujmvPhfvNz+SyAaQ=;
        b=tXUmYTYVa0WLhR88zn0j9XmDE0X3ehOYjh3Zk1fUhLLINqr6Hj+itidQ2n0qii1eFr
         JTLZoGYVDxCO40ah+4LuRc1MT8Sj5IbV5vhrc/yjYBoLaOsXD5Mxul4yLQ0w1T2kG2Ag
         4gqB/CSj+jNiI9S5jTPsrVIERjNBMTozr/1feTgYASrebfQP6NYdXv/C8C7Az9V5rTpu
         Vw4cIlU5o138T7huGn4Qtd8eng1F37V60Gr1BF74q6WG4jrFsQucEEy0+GHeO1w7LHU8
         LBLXT57KqvvkaOYRe0eYt63On4CCUpMqd5tSyg0HZ0mKMCg5F6/VPn+frA87lkQAeCH4
         ON2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706180674; x=1706785474;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IqKqhdtGXtBOJU6ppRXF6CRxwiYujmvPhfvNz+SyAaQ=;
        b=F8765pibxKc98PRPLNU2zf1++BpaYv7Sm50wCdc0yVQ1qSOwtzeMqo+4efBHncfRzK
         yBZjjPkXr/ota4oYYYuuIh8BNQ1MNdbJlyilbRiHnbrdFe5YZV+lTY4TD67QmkYr8npe
         22lAtm2Y3aKAVw54yyoeg7useeFIf4mTBlUIB6saFn9rPEG65SnDbLdVjS9glmvojPId
         1fnm4WuX3TxChOF9mLZjv5VAvayeK84/Mf62OdNBhEFdN3U4v3TGZxbNc7Wb5chGHeqf
         dLIkoJs7ApLW03Hti5stBMJWxX1RNykPYjbHgaGZXPlUr6t3NGBxtgDt8Fguf7prJnot
         pcpg==
X-Gm-Message-State: AOJu0YzlJkuAAFfZKG+UQpfzzsCWZQbhlR/688NkFLfM11UTtJUtEjzC
	UWgVOwcCAELrWMpOHa1sOgeHqNQ29sxeYUfKbPTRdGxiMPCVVakeC5V49cPj7dA=
X-Google-Smtp-Source: AGHT+IHRN0EYIlVEghtEqMxeg1S3Go+WMINZWoqrHECHlbWMgqI/DcQDJtzKvV4+NTQvJ6/PflKb+w==
X-Received: by 2002:a2e:300d:0:b0:2cd:9503:f91 with SMTP id w13-20020a2e300d000000b002cd95030f91mr465395ljw.15.1706180674614;
        Thu, 25 Jan 2024 03:04:34 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id tj3-20020a170907c24300b00a2fde3a8097sm209847ejc.74.2024.01.25.03.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 03:04:34 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, Dmitry Osipenko <digetx@gmail.com>, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-tegra@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240123083517.21091-1-krzysztof.kozlowski@linaro.org>
References: <20240123083517.21091-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] dt-bindings: memory-controllers: narrow regex for unit
 address to hex numbers
Message-Id: <170618067286.174727.5575658659915083123.b4-ty@linaro.org>
Date: Thu, 25 Jan 2024 12:04:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 23 Jan 2024 09:35:17 +0100, Krzysztof Kozlowski wrote:
> Regular expression used to match the unit address part should not allow
> non-hex numbers.
> 
> 

Applied, thanks!

[1/1] dt-bindings: memory-controllers: narrow regex for unit address to hex numbers
      https://git.kernel.org/krzk/linux-mem-ctrl/c/2f542c937c48c2bd5a8ddf180b417fbe7152559f

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


