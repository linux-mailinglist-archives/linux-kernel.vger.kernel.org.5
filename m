Return-Path: <linux-kernel+bounces-32894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C4C85836188
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:29:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77BF71F248E6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 11:29:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ACB4437A;
	Mon, 22 Jan 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ps9aw/DW"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535514174D
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 11:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922120; cv=none; b=CDEG08OdZ+MCqO9B3VZdKjEJFh4W7+onBw2QbE//zW0zCg6TpZ2Aj/uKmpFAf1nIt8/NrxPM8Dk/azMzieEfXdqwA2a/7u+ycs4s1BaFQslFD+hmBH+UhKhJmP7TphwZbn8rTuILtEUitVNyaJ7Buhvh0F+ZO6U+gI00cDO5KwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922120; c=relaxed/simple;
	bh=794SmaQ54MTymb/u9d7+gEUbL2vd8+0mViFrNstCDK0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=bYXNor1XS2eEZUrMYGMgN+CoXj0uwSJfqLUF062lFS+wMG8P2f9LNXEGM43EFj/da8Nu/UjVdfZDBckbHfiXyRGGicT5BwVqqANPHvJR1YbsMuBRVjb7qG3/P8mXyrX5AFPhbLO27GNDrWvUllAbmL4f7q87d0MrJ7AZ7VHP+VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ps9aw/DW; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55a684acf92so3037571a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 03:15:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705922117; x=1706526917; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vytVuxKwk7apMR9cep+8YcY9zbRhD9DG8uyD8/fCDqc=;
        b=ps9aw/DWu1JTZWqOSk8yTMxeqLJp8ISgAzkoegiLdh3Gy0swnQR2N3mcJAzQ9nvEFI
         qiLbdd5+7Y4Ys8klwWhgVUkwh7NRrUsDGNXfOkzXqbJRM2TYDQ2hsbeelMU8WpdM1kbX
         9d5XionESYl/UfHtPAyME70R8xVCtng9c1qSb8Kn9c2Z3QxT0uAcYov0NvZaxqpiPB4Y
         o/mI070sHnbpM9lUVQvnIQ9ZYYw+PzRGqsIYSR7EDSDaPoxwVA4SP+tCsE6OX+yVwdZi
         nafnfWh/SrqwHOBqPBirwocd/whSYkTiMfJfMzuDIrKocy+IdZsIMl6G/AXpIg2bl6K8
         P2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922117; x=1706526917;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vytVuxKwk7apMR9cep+8YcY9zbRhD9DG8uyD8/fCDqc=;
        b=HlsQy4ydwCsyBGKXN3WPla/eAw2KZSFpRFuZOcYrze/YSIwAjJ4OG98azE+AitvTFZ
         LfFMCY2n+zwOf9Nbba0RldXfCvPMfNh7A5pZ7yMdRyoKL2dRZ9He8/M5V2pMLciXOEkV
         +35wnvLZxBcva1SOJs6hn+HLlCcV5uDkuZbfRpXUhM2d2DR6AM8Gijr36bRnHyUKg6ED
         TLKTHvdscSIXKe9Ak5swMq5TD01gWhr7r17r/rJjCfu+zIWMvdC5QkdVbX9drB3tdRJN
         seKPXU9//DqMnwXnbpEWyR+uUMFZlO3yi9TsoJbWHSIQslMA+u2mEdBFxOi1Vz2EMBb0
         i8kg==
X-Gm-Message-State: AOJu0YwZX22S5uHsTntGxLoEbpa/KhfVlggFlzNJwQZdp97nB+Dgb79y
	V0tRB1uCBY/+Ngpt1GeWtETHcTi0vzTQFF8J1Gaf76rEz9jz3cADzA7MpYBSabA=
X-Google-Smtp-Source: AGHT+IEDDoaQ5FumWXcQ+GiNDG8GKYL9DoSZ+GpQ9roqhxjxGEabcOEJ7bXH7bZ9xuE5vQasN6xjJw==
X-Received: by 2002:a05:6402:3586:b0:55a:480b:6430 with SMTP id y6-20020a056402358600b0055a480b6430mr1723594edc.116.1705922117679;
        Mon, 22 Jan 2024 03:15:17 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id h27-20020a056402095b00b0055c643f4f8asm179422edz.32.2024.01.22.03.15.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 03:15:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: andi.shyti@kernel.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com, 
 tomasz.figa@gmail.com, cw00.choi@samsung.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 andre.draszik@linaro.org, semen.protsenko@linaro.org, 
 willmcvicker@google.com, kernel-team@android.com, 
 Rob Herring <robh@kernel.org>
In-Reply-To: <20240119111132.1290455-2-tudor.ambarus@linaro.org>
References: <20240119111132.1290455-1-tudor.ambarus@linaro.org>
 <20240119111132.1290455-2-tudor.ambarus@linaro.org>
Subject: Re: (subset) [PATCH v4 1/8] dt-bindings: clock:
 google,gs101-clock: add PERIC0 clock management unit
Message-Id: <170592211606.45273.847576093222095843.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 12:15:16 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Fri, 19 Jan 2024 11:11:25 +0000, Tudor Ambarus wrote:
> Add dt-schema documentation for the Connectivity Peripheral 0 (PERIC0)
> clock management unit.
> 
> 

Applied, thanks!

[1/8] dt-bindings: clock: google,gs101-clock: add PERIC0 clock management unit
      https://git.kernel.org/krzk/linux/c/b393a6c5e65652a19733978c3711c7c05c497594

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


