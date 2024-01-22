Return-Path: <linux-kernel+bounces-32893-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id CD484836182
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:28:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C3441C26106
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:28:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4EDD41760;
	Mon, 22 Jan 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZhLTcjv"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 745F64122E
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922119; cv=none; b=pRKvn70jhCXiSbQWwEYILBqtMnUXjJdtMNvIXZVY2RdOngJT5qoL5x9fbY0LfC4iqVMPN6bipdsOPPfmtJ0jg69trdyo+fg1lc5MaV5ZHidp+ssrU+u3a9P73vmVkHnJ5K/X3GDOvfXgX76mZtWpJH5uXUqvHs//Oo3TbZPu+M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922119; c=relaxed/simple;
	bh=sBhXk0iAvmnXKdKuq3EM3icTN0+ZEsMN1H17Lp5WitQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=auEZ+gLhG8yR5s1W+p5FUgHdz4FV2dNzq7Hp/p5+fyEL4T7CbtzmhChphUbIpsZ9zguxkoDP5UvM7+nbQVphF89bjFqvUOdISfQQ813BNqzXq/UEQzRYCBfP7hV85FWTC6X7pW6R+LG9+Pjk+Wup8UuH3cDnLZc4/W2iztgWaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZhLTcjv; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-55a9008c185so2757696a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705922115; x=1706526915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYvtByBMmibUCUZcFilpUEWd0hC7XPo/IrPVWnAuEF8=;
        b=UZhLTcjvE0ZAg/jfoS95HWO04R80AF2ndbV/z4y9WRbDLkD7Gl7YXWzPcjqWX+ETP6
         OscKhDb3C4BI5RyYtsZeupENOm91YG6rGp6KJNRdPUDRNapn6lXP9echW9P+TrI5JIix
         +CkzSdLHHm5Q4xnzIzX1bMB0qz0afSGVWr/GKCqS5DNKKnNMJ8qgaCL/+yU84j6V7Jj4
         CDucigVg3JTmy+w/JUJz9YGRcbAd0Yba0guEumTsVsL78Ptb+IADQys/J8Zc+wYKm6eZ
         JVJUQ+VIaTs5cRavYcXHYSaYo7BV1VS9DCaJNroaWvA+ARszYDhzlnmbFX8vubSzsh5f
         xU5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922115; x=1706526915;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QYvtByBMmibUCUZcFilpUEWd0hC7XPo/IrPVWnAuEF8=;
        b=JokniKmwHere6OhyqU5o3KsiDrNH2JSDtrYPrWm2XWSMi2XfFyuP+hlchKDd8/3IYu
         yjCnwn5kyi+oXJSKOdnX/CyJY9tlvRyZEU/k0yRWU/0i/KeGG1IsRFQ1HFvdTl5DkKkZ
         Mqt0b3pi27+ol0ZAIFSjkW39Fd6FF73bNF8iju0DSeTstIEnTKqdP0l8Ng/w/guxNhVE
         KbQckqdEwhAW3AAPOuAHhW9F+uakA0ifVHXad+/AzbMYsmcGhNg7ybeLAQhqlbSwlht0
         xW5fN213DncH547tjPBwV660Uxqdpjclr9RN/IzP8ic9ojbDyLTySJx21mRuLqS7cl/1
         6P3Q==
X-Gm-Message-State: AOJu0YypqbgvvBmdzxK1so/POoqV80s9b1bdBbnQusXKePBpNFQy5G4v
	ltVZRLNYq48GYVEqyFTVnJCGzHTvz6nZ9TsWZJLgppcLh9oCPQgIHFKTcZLsaHw=
X-Google-Smtp-Source: AGHT+IEZONRRWwPg55Bl6j+qg9gT2tMH2N7hRshFExy3U+WwV/uEC+1jiGK+QgUlbmP5FuFEZwo/rg==
X-Received: by 2002:aa7:d750:0:b0:559:b1b0:4437 with SMTP id a16-20020aa7d750000000b00559b1b04437mr5881853eds.5.1705922115799;
        Mon, 22 Jan 2024 03:15:15 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id h27-20020a056402095b00b0055c643f4f8asm179422edz.32.2024.01.22.03.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:15:15 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, 
 daniel.lezcano@linaro.org, tglx@linutronix.de, conor+dt@kernel.org, 
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
 cw00.choi@samsung.com, mturquette@baylibre.com, sboyd@kernel.org, 
 Peter Griffin <peter.griffin@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-team@android.com, 
 tudor.ambarus@linaro.org, andre.draszik@linaro.org, 
 semen.protsenko@linaro.org, saravanak@google.com, willmcvicker@google.com
In-Reply-To: <20231222165355.1462740-3-peter.griffin@linaro.org>
References: <20231222165355.1462740-1-peter.griffin@linaro.org>
 <20231222165355.1462740-3-peter.griffin@linaro.org>
Subject: Re: (subset) [PATCH 2/3] clk: samsung: gs101: register cmu_misc
 clocks early
Message-Id: <170592211404.45273.11848415644684146235.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 12:15:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Fri, 22 Dec 2023 16:53:54 +0000, Peter Griffin wrote:
> Update cmu_misc so it is registered early, as it contains
> the gate which clocks the Multi Core Timer (MCT). This clock
> is required early in boot, otherwise exynos_mct will fail
> obtaining the clock.
> 
> Note this wasn't previously an issue as exynos_mct wasn't
> enabled.
> 
> [...]

Applied, thanks!

[2/3] clk: samsung: gs101: register cmu_misc clocks early
      https://git.kernel.org/krzk/linux/c/163cd42fc49081964e0fc6f0b1e94b6b50eb85f5

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


