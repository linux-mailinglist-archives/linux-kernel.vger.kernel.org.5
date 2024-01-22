Return-Path: <linux-kernel+bounces-32889-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A80836173
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:27:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB631F24ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBA98405F0;
	Mon, 22 Jan 2024 11:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UZvbA9Aw"
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1573FE51
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922112; cv=none; b=uzY2bZ3tSCLhAInDM+oDWWczxX1FvrsKCqURK0xgJ6rYVzEKkV//vDhrJeEm5A74qRFkjgnUU3t37W/sle71AQr4Rsh/YrE6noYbD6emU9XL/5621JryzOgU4xBp96BwxtQCQ/SVHv8tI8RkutP7GdgS9I4uVqHpLI8dqTOqm0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922112; c=relaxed/simple;
	bh=FrLltAYAafwmNfsSwZb6drJlItmOLUVtoXUr0w3aI3g=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=QDG+syojMynyJnf8hxKgIU8qElL0dZ8UkgxCKlqTIYcd7ZdTckk7LMPcEkBkacN3qiNJ9SxwnqRuiz9iT3FaeRYAbsOqHg6lg7xfW7uVhP1xOKyO5tvcPPjvjyfQRIxHw1IZOSELy74dM3+T3aWn2cUiPeTn86nABEIYoV0FfGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UZvbA9Aw; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-55a354a65afso2613029a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:15:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705922108; x=1706526908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OHbd+XvZHal91iZVjgEUlEy32Vop+2YCwqb7bnIY+aY=;
        b=UZvbA9AwHPV41Po3K2xMTI65cdc4d4LKucqsxr1tYCIInF5CwgG/aquP5p+ejn54zw
         Xmw7fETijokVoKptBaOrFSFEHxhCKQMScg3sGjS36P2w7yPQrKXEtfZbrUG4h8QVJ/6A
         m/kN4/wBHqRxHZMran8KGAM6a4+AJXt9gPSLhr0gQhXybC9L1KQxc2OMTvwo1ivjZg21
         GPS3K0n7kEtNkSBgVmbiBP1F3+DvVSVMQ1L9DQIzz8Eh0SYcLiAulw8rTSR81RPiMCJo
         3UUFp6AZ8cXSkMI8x8xncy4kTRj6XHIbpBLkjgKRArWetbATBCGnUfq3XBuBKGvQcXRT
         xpYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922108; x=1706526908;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OHbd+XvZHal91iZVjgEUlEy32Vop+2YCwqb7bnIY+aY=;
        b=kU5v2eDgAOpYMg9YrVBKrjvB6PJWFsCnstTQG0nMg7eWMldwAh/qH1fE3g3oANaF3a
         ARz5ziSH5Y5WRKhJ7Zmaic5972r5WNxNpezpaM0xElwZy/2rdulHkTrTd5GfHhH+KN/x
         xcc7rGYonT7O2Ew4wE9J7Uv4rLvYLC2XAFN9/NCmgiGxXgWin+MlQDKYI9JupY8iq+Bm
         uKOafAUx7uLUYgDG9hJwJGy0uHq/brjUnKgM7YGg00pBhmU0HpPDO6lRR0oSkIb0Q6LQ
         tdWpRbzw88rPvLkt+C1BNJ8D17kckfcNF4WF8B81CyHP7xSs2bzJ4wG93eCAN2BLBqSV
         5HPg==
X-Gm-Message-State: AOJu0YxsHEdt6KjNRWr6zbc3OOCMSvukMYVhczyhZZqR/vur4JVxqWH+
	K/EFe7rAncoBFWPF6y3DWr1wfA0Z/5qNU+ybbzCc5f8mzeiMSRIxBEhEdCht6Wg=
X-Google-Smtp-Source: AGHT+IGN2jpvmAMaNOzfz+OiH67F8gD9wv2bgKogmBc069zcmzFB9DMlj+GkpZ+chu6sUiM7wjZGoA==
X-Received: by 2002:aa7:d883:0:b0:559:ac5b:1a8 with SMTP id u3-20020aa7d883000000b00559ac5b01a8mr1589347edq.80.1705922108741;
        Mon, 22 Jan 2024 03:15:08 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id h27-20020a056402095b00b0055c643f4f8asm179422edz.32.2024.01.22.03.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:15:08 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: LKML <linux-kernel@vger.kernel.org>, 
 Mark Hasemeyer <markhas@chromium.org>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Tzung-Bi Shih <tzungbi@kernel.org>, Raul Rangel <rrangel@chromium.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Andy Shevchenko <andriy.shevchenko@intel.com>, 
 Rob Herring <robh@kernel.org>, Sudeep Holla <sudeep.holla@arm.com>, 
 Alim Akhtar <alim.akhtar@samsung.com>, Conor Dooley <conor+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org
In-Reply-To: <20231220165423.v2.6.I06b059021de1bf6103e60a73211f078f2af75d17@changeid>
References: <20231220235459.2965548-1-markhas@chromium.org>
 <20231220165423.v2.6.I06b059021de1bf6103e60a73211f078f2af75d17@changeid>
Subject: Re: (subset) [PATCH v2 06/22] ARM: dts: samsung: exynos5420:
 Enable cros-ec-spi as wake source
Message-Id: <170592210746.45273.11030827655294566757.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 12:15:07 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Wed, 20 Dec 2023 16:54:20 -0700, Mark Hasemeyer wrote:
> The cros_ec driver currently assumes that cros-ec-spi compatible device
> nodes are a wakeup-source even though the wakeup-source property is not
> defined.
> 
> Add the wakeup-source property to all cros-ec-spi compatible device
> nodes to match expected behavior.
> 
> [...]

Applied, thanks!

[06/22] ARM: dts: samsung: exynos5420: Enable cros-ec-spi as wake source
        https://git.kernel.org/krzk/linux/c/8f51b5290ff4f8a9f1c634cf42ca37cd9e90018c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


