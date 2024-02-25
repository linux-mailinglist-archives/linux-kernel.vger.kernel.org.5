Return-Path: <linux-kernel+bounces-80186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8115D862B82
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 17:11:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BF8C2816FA
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Feb 2024 16:11:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4784918EA2;
	Sun, 25 Feb 2024 16:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZQtRTzY8"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA821759F
	for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 16:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708877458; cv=none; b=MJT3RHQZCemQYy0ih0x+iXabPlezRoQ6lWu3nTBLPuWHCiQUa1WnlJllUbLQl50zaPnlf1DfO49la8jfxF3308SxNchEJr5JwDth5A8qAQ+8DteWGQ35CNnAgF+Cv7h+0y/6I1JxLuzg5SHZHzxVr+GRihx56kZffMY8gA7Yr44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708877458; c=relaxed/simple;
	bh=TyHcB0dGMLo+vpH3FsETA6ho9nRIZUIMh3EY+giPVOs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d4LGYYunQl6NQZiFRG1+MZLrL2KWOFAHbzYGyALFjKotqoCw+JdE0bXYztG6QFaETPlC7TbaOfCa6XSjxoYf2QMn4NZnX9GaDOLQk36Q1CxXEA3YgaXdbibr3TadFGs4epT4dWRXHh+YmrmKE81dfZ+yqogyeQGLrPt/G1Tqgew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZQtRTzY8; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d21a68dd3bso31896261fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 25 Feb 2024 08:10:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708877455; x=1709482255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rsMTaBWSoQvKTw8PXqopEDazdmQVOYa6vIXgCYwTsVc=;
        b=ZQtRTzY8mTsPIYr84YWqHqS7EMycDuvjInlvaU+EGjyhCE6DyovHA18snZgVndwILj
         CQsaeGQZp1aEXBZLl0iXWPnwjZOYpY3LfOLA1NHpJ1Mj5OsnyQFlV0N2sNQrOU68WUs+
         vuz7bQhoW8HSTZw1cIPvQyoMnjBc6MZSbjELPRLj9tjYFGm1yJ5h4eSPigMQKInb79Tb
         b0SJr78adGNaJvbtXa7lMIX8PbB5SlhuHTbhbtuJgrbJzfIwqkDz0k7RmCEl5q52Rfkd
         uVtw064IHTocOwh5STcAaDUW3b6JX9J53/zJSwHFTRQBE/owiM4u69RNQOw8vOOuQ4Uq
         vs2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708877455; x=1709482255;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rsMTaBWSoQvKTw8PXqopEDazdmQVOYa6vIXgCYwTsVc=;
        b=cGsxsXbrnCAahJ681ZM+KixpR5wvX33wXTD0d0itlGLIVlhJMGNRzUj4c+f/93o2hS
         NOXz7Sfexw9SwcqJgKy7tO2zMTyit9cINcepgTVfcgZn19o47OrQqha9thEskbkWDgHR
         C/JmInGFsguTsGzHdJ5mfM5ozY+VrbJOr5ZruhlE3e1+xaJXp4/4qPeOnzllVFVOugnm
         HXlZ8C57Hl/kkMLeGPtyi98iuppAF8McHxqUWWX7cT2B9zKoz8e9yVaynZS9oAid7Gds
         XqIneXrFi6bNW6GvVV7mq7UVnejklTJIaeXD0rmCulg/T+SMAzzbDj7BgKHAfmzOsCC7
         5ReA==
X-Forwarded-Encrypted: i=1; AJvYcCVcrDQPZsYQVaPIw4OG7PG4A1tQ40GAPlAdmHgUR66Vn+tk/XYZlNdQU9kCMcm7t16vVKdQn3h31htecvezPIH9QPv94Cu4kjhMwRe3
X-Gm-Message-State: AOJu0YxVplxHJ4ysznF8FgoJ+0XoXwDgEjXbH4cCOPmG9j5v0edxKw+E
	Y92Hn2UBWPBw5A4aaEjDEyTp4Cm6vA6CN3oVm9qaQyzWyBxARF+ITeWMGmQs5AA=
X-Google-Smtp-Source: AGHT+IEwJ32mFqsaDiozmjM7M94ym1LusN0fZdXuSF4NZ0A15Cye/UItZ7bGtwk7w9CIqCAFilxLIg==
X-Received: by 2002:a2e:8515:0:b0:2d2:215e:157c with SMTP id j21-20020a2e8515000000b002d2215e157cmr2729011lji.7.1708877454974;
        Sun, 25 Feb 2024 08:10:54 -0800 (PST)
Received: from [127.0.1.1] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id n21-20020a2e7215000000b002d2697570fcsm579184ljc.93.2024.02.25.08.10.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Feb 2024 08:10:54 -0800 (PST)
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
In-Reply-To: <20240224202053.25313-4-semen.protsenko@linaro.org>
References: <20240224202053.25313-1-semen.protsenko@linaro.org>
 <20240224202053.25313-4-semen.protsenko@linaro.org>
Subject: Re: (subset) [PATCH v3 03/15] clk: samsung: Pull struct
 exynos_cpuclk into clk-cpu.c
Message-Id: <170887745282.215710.3873782882089335493.b4-ty@linaro.org>
Date: Sun, 25 Feb 2024 17:10:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Sat, 24 Feb 2024 14:20:41 -0600, Sam Protsenko wrote:
> Reduce the scope of struct exynos_cpuclk, as it's only used in clk-cpu.c
> internally. All drivers using clk-pll.h already include clk.h as well,
> so this change doesn't break anything.
> 
> No functional change.
> 
> 
> [...]

Applied, thanks!

[03/15] clk: samsung: Pull struct exynos_cpuclk into clk-cpu.c
        https://git.kernel.org/krzk/linux/c/a36bda74ede4c33dfa95482b56058f13fb64a426

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


