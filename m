Return-Path: <linux-kernel+bounces-32769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E2C835FE2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:41:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40E1C1F223CA
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 10:41:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BBF53A1BF;
	Mon, 22 Jan 2024 10:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z8uwKABG"
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0BF73A1A6
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 10:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705920085; cv=none; b=KWrHoocM5wqjK158A8geIYkjhGKqwkPzOV+goP9E25uXrCZ8ODLKLM08Pj7Cna8Qv6lxMM0KGjM8v0qm0ObqyUtFQ2bXV88+KPXV3Lw7q4kbgSnhrew7StmbRr76TR3j0nVtgsyGXInLvKmhR0+7BE7OqpKm+CPIxLSIu4j2O7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705920085; c=relaxed/simple;
	bh=HZ0Hdg/F68IPYAxwGbTZxdDbtscFYuGai9J7k/bcoEo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SOa6RGzzlkpaU7UHy3MPyubt2PZQb/i7DRGWMo/kg8wnbaTGwMYE8afjsg4sNFBs3YVYOIZ1Ugm6tg2U+1GLUsAfSdpSWgBo4oUJC51tyN8bdL9ozL5tDrPC1Ci+kQoTOsx8emVPBLK3bbjtylDcff3t7rjnkxpn5ITSig1E5xY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Z8uwKABG; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40eac352733so10183545e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 02:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705920082; x=1706524882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tJBEU9hHJcfzWOiHAuwhZ3FGFs6n9fqS4Ii6C+nRlzU=;
        b=Z8uwKABGOicDo2gIUJJG6UDuqdfLX/HOwze7vvb5eBEh9LsyFpodxnrd1nk/Ct6akW
         /GEY8AZKC4isW9BjGtlwvzLZ7XIYTOqgASSht2nnuJ4kPhsW1mU+j+/z04VFHh6QdXW+
         2evjzBiP3SHkOHSB0ZNgllM509UD2qJy0ZLIZuXkUip/NpIMaJ9qJTfHDj3prZl0EW4t
         yR6FfPAxWAqOUuNfJZZ88JY6kXi0N4kEkuFqbGduj3+vy4w0J+qJQ9hfSGf4NKOlO8oi
         RmBmLknFf3DNVWF82HcmZ21Uec5JDkEuP8npkYzDK/rEOAkyKc/P6fKugmtN+LGttP/X
         FlQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705920082; x=1706524882;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tJBEU9hHJcfzWOiHAuwhZ3FGFs6n9fqS4Ii6C+nRlzU=;
        b=FOwJgY7swdoIfb/+x+opprFQ75/GeTDNkJrWuV3POKCuYvoj165hpS8zW/CvXGeBvT
         R95d5IW+Dc79py7sSKJyWFdK0obvTCG9pMrMKobtn+7D81md2TyldMO2jVJYs6UlUNbM
         jUPgh07Ee6/93Xh/lM4LyIjA9PE7gpgzcBqu3udahrdOtXOYX5NznHlydwUNy6XSBFOY
         TFws7+wdB1RiFL431nN2gz8EKoU34xAabAT+UBDQgZtm1azGO4NsdoH4m2MJjQctA3Rl
         iTknbA61gKnYRJwuhjtjGeaIvuBClDjq9uVsOdyMcttXMo1IPwnovyyiE34lCggyQlYG
         lBtg==
X-Gm-Message-State: AOJu0YyoKpRzUXgLK4JcsQ4J1SuKUvLCcLjbJ5cSNfpRBK93FM2C/ZO0
	F5d375u+ccG/YimbzqUI/PoBOFQKj0dT2rC1rUZXlaYQUZMvc4BzfsmBpvUVoZU=
X-Google-Smtp-Source: AGHT+IHIKMd1D6GufkmdDAUEkH6X9Zo/gAkdVkY6970R1/IWSOsKtCHbix6qN81ySf5gXV1iFmui+w==
X-Received: by 2002:a05:600c:4286:b0:40e:596a:985b with SMTP id v6-20020a05600c428600b0040e596a985bmr2207230wmc.160.1705920082126;
        Mon, 22 Jan 2024 02:41:22 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0040e86fbd772sm20129483wmb.38.2024.01.22.02.41.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 02:41:21 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, 
 peter.griffin@linaro.org, Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: mturquette@baylibre.com, sboyd@kernel.org, conor+dt@kernel.org, 
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
 cw00.choi@samsung.com, semen.protsenko@linaro.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 kernel-team@android.com, willmcvicker@google.com
In-Reply-To: <20240109114908.3623645-1-tudor.ambarus@linaro.org>
References: <20240109114908.3623645-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH v2 0/3] GS101: rename cmu_misc clock-names
Message-Id: <170592008004.38238.17769921542052483911.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 11:41:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 09 Jan 2024 11:49:05 +0000, Tudor Ambarus wrote:
> Rename the cmu_misc clock-names to just "bus" and "sss" because
> naming is local to the module, so cmu_misc is implied. As the bindings
> and the device tree have not made a release yet (v6.8), comply with the
> renamed clocks in the device tree and the clock driver.
> 
> The patch set is expected to be queued through Krzysztof's tree as he
> was the one that queued all the previous gs101 patches.
> 
> [...]

Applied, thanks!

[1/3] dt-bindings: clock: gs101: rename cmu_misc clock-names
      https://git.kernel.org/krzk/linux/c/1755c4b0372a2cf1e7124956b8cfebcb51083208
[2/3] arm64: dts: exynos: gs101: comply with the new cmu_misc clock names
      https://git.kernel.org/krzk/linux/c/80c86ff6800b857c8008cebe7b8d22a6e574e68d
[3/3] clk: samsung: clk-gs101: comply with the new dt cmu_misc clock names
      https://git.kernel.org/krzk/linux/c/d76c762e7ee04af79e1c127422e0bbcb5f123018

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


