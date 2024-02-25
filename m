Return-Path: <linux-kernel+bounces-80188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D24BB862B89
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:12:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8D3D1281709
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:12:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DFF01B80C;
	Sun, 25 Feb 2024 16:11:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l6cTyOrU"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1EAA1AACD
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877462; cv=none; b=ZEjZxYJpZH+FHO6Lfnag1VM4/9Rm/DjZ3HpTzo405G/1i8G5UzPUR9GGXwk/k5I+Q2VqMiwN2QJHMNEka6AJ7Uci5ofYkP620LnKIdsXZPxXxu3F9vLTRQHWplt/Q11r1zjtt629cHODUen5KdpRzTgVmhtpG0xQo9TRBE89DxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877462; c=relaxed/simple;
	bh=QBa7Y3AGR9N0gR69nFXfx/CX8Gh6cMWpZsRsN/2yQSo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=oM/yy7g89GwIdO5oK+Yv0UBChEe3OBlLzvyxEMGbHwQuwH7KhMadV6aj5jYRgxb+igIn6g8tDwmmtIsM41nmAHjqI6uCO1mCGjZmDhfHVy5GH1rOJWAZBGbl5jpY6lLFinHIZXylnrHqcxRrqLe0UFuCOUrk/DQvbY+hweQLxTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=l6cTyOrU; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d2305589a2so33829791fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:11:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708877459; x=1709482259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y5YyMqPimo9XUHgL83+xZtwboRxx5/IrUrU5gbAjYaw=;
        b=l6cTyOrUUtKpmUjEw35t90DPpeGc+HYmcYGXc+mLQ/tXaa1OYrN6P+oGrxZCtoHnlZ
         EziIyIob7WYEkTtYwMQPoZUy4JTaWwCWR6E9ix0lJPA0SHIg+tkzYqeFUaeB0eQF5wXI
         UfABURC08UnzC3JEyVYzMCEi4R2Ph62C6kOd/HlfM+Zj0s2oYLjKJIh2+94RzUYLquoo
         KdKXSpRIYFYuRyvzq962SMv5xd2ezuG95n5wEGs2OTKegPLj6589PcN3ro3Szo2H+KZr
         03NVng4iObqydVs1Q+WElQsr1skK54M34SfaTkzVi4b52LJji1ff+MHGxW04InVhmLvM
         tByA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877459; x=1709482259;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y5YyMqPimo9XUHgL83+xZtwboRxx5/IrUrU5gbAjYaw=;
        b=kWCBoS1hX4RrSm0nL+XJe+rRRemY0C8rjPUCi0Gsyvk1RuHtFHAUX1PQsv1kte4YVB
         xrerDV2qJG/yRE9F/EbcBd6bbV6iku6Y47bfEMbPT3A6xZCqw4xBotPnjRY4g0GzWKpm
         mDhVEAXoaafJP9FBaBXjz/E2uDRdsNbtb6g9m/HVThOWEh1LkaCL8fFzPqjYMmghP2IH
         f2kewsTRRKnw37f/wcSLfmV+Ba4phZyYX+GOqXqeGkjAk4MOEL2o5x/SkXb35guadMCK
         pxw6RFgR1kCITxgHDSkstbWHmWSbrV/IOPhNxRAtezMzwd7NnrwW4yWfnhM/+5tBKFMc
         5aqw==
X-Forwarded-Encrypted: i=1; AJvYcCXpX0R3jdJsqf/iXcPCzFtsIk1MIzX29Vxyis1IE2afB7vqhhBCOHot0X0FlPS/QkfIvIqpQe6kfgxWcIHEeChk/Gx4KxjWNaQmOkSG
X-Gm-Message-State: AOJu0YwBSpN8VSZxWMwl2fKCwW0iE7I/jkP0Ofn8M5Mzxvbs00aECtfo
	jN1utgQtR7rcLkB5qs5HiHcANP99i9Y1yONxmyuEN2BQPJAmId99ZvnrNpCYQ0M=
X-Google-Smtp-Source: AGHT+IFLY64OJZ09kr5YonBW3qBy4LeKF5vqhWb20kSxzQsvNK4am8dCdGHvlpfqKNUziIRdPCfQ7w==
X-Received: by 2002:a2e:3213:0:b0:2d2:4054:2fab with SMTP id y19-20020a2e3213000000b002d240542fabmr2649973ljy.37.1708877459151;
        Sun, 25 Feb 2024 08:10:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e7215000000b002d2697570fcsm579184ljc.93.2024.02.25.08.10.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:10:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, 
 Sam Protsenko <semen.protsenko@linaro.org>
Cc: Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Tomasz Figa <tomasz.figa@gmail.com>, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240224202053.25313-6-semen.protsenko@linaro.org>
References: <20240224202053.25313-1-semen.protsenko@linaro.org>
 <20240224202053.25313-6-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH v3 05/15] clk: samsung: Use single CPU clock
 notifier callback for all chips
Message-Id: <170887745713.215710.13782897214681477333.b4-ty@linaro.org>
Date: Sun, 25 Feb 2024 17:10:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 24 Feb 2024 14:20:43 -0600, Sam Protsenko wrote:
> Reduce the code duplication by making all chips use a single version of
> exynos_cpuclk_notifier_cb() function. That will prevent the code bloat
> when adding new chips support too.
> 
> Also don't pass base address to pre/post rate change functions, as it
> can be easily derived from already passed cpuclk param.
> 
> [...]

Applied, thanks!

[05/15] clk: samsung: Use single CPU clock notifier callback for all chips
        https://git.kernel.org/krzk/linux/c/c9bc1f778625b0ae93641e6d14d83b62d16e549d

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


