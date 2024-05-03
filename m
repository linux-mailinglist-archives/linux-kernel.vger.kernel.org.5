Return-Path: <linux-kernel+bounces-167391-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ED168BA8DE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF59128151F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:36:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2250214EC6F;
	Fri,  3 May 2024 08:35:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVoPWxH8"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F16014EC5B
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 08:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714725355; cv=none; b=lsKx7RHRj9q1MStKBwJlxyZNTNfvZxk7GG4k+lDfeh2/0ZxWCdqvZaAM3hlbb2q85FdTkDpW4hjJY150ILeC7r+k9xoUsM0kMcQKrMcL91JueUS6i+mX0eA04xLYQ9BMnECskCyEh9GVAF8d5c3KT/r77V8GGEHv4sPQPAW7sv0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714725355; c=relaxed/simple;
	bh=9O/jNqh6RwmgdZzcMSapBkNN6fAwW++OTzSrfYouXXo=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=KTlxfmbgLKQ7wugkKd6NRhDK9zNVK7QwD4Qx7Jva9GEj8/7UbAUZIvpKtODcZGJ4UHhuAqw+v2EqLq0hp48OBjUvl/lyLH7wLt/xLarTdq1TqnrFF78wnvBPJmoO13Uj7KidNZk7xfaPAuYHoVa5430y9e+p15Wn4hqguXhzBVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ZVoPWxH8; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-418e4cd2196so68698975e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 May 2024 01:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714725351; x=1715330151; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iTVoaXYQmknTRotS0tITeOIG625SY8vKLkmu8tNzGoo=;
        b=ZVoPWxH8hwls600Sg2o+HgrsHUQsCEgd4gWZhggJfru1zKMWNxw1KDBQwfNivnyrFA
         jacFR8YavHYMUSPMJlR2tDXZ3Lz5RWILgVTv533yhQuiBorHOG0LUZMWLN/wo3D/eYt6
         ZxUceEI93CbA8IDuSnfEA2SxlY24PyF50F3jmir/JVh4ZpoCp/NLXjNzsWAdXZJWpzcS
         qXy9ZcyVZzFzV4usUPlk2vw3aAh3Ld5EAp0X4YgXC266lCftFFf5gUCTBSLTKsEa0AYm
         /K+0lCyll7WEzSiOsZc90OZSR5NCB03y592w8QkRiS0qOfoQ/hiP9DbA66F/fx2tyj6i
         e3cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714725351; x=1715330151;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iTVoaXYQmknTRotS0tITeOIG625SY8vKLkmu8tNzGoo=;
        b=HgIolej2DE5Mn1byIkZ4vYda0JH30Jgl4R7KAh6NTlqT74V4rNv1cheNjIT/HJEcNO
         8dZJmLtquuvPgWYTPfqW3VVYdQLrLJamZeZxXReAnnT5beqo3O5EivyqOLrCmcH6bq9P
         VamZrtsZBdzFkYUVkJ7LACdbunKW3mt89/uRvxmK1KDVJdSBN+oqIi8EHcERmF/Bz8xQ
         j2OIO3C+W17CD/RWD1F2dmWOhYcj/NSz0QJSbOgPJLpoxP3l0nbkKry3aoXkpwpKJqRg
         CpF5BJMHx03GYEmMYCRjp4n6V+J32Idos0TmbsV/esGFZHqScOKpMU4JhQYDrfvSsC8Z
         cGUA==
X-Forwarded-Encrypted: i=1; AJvYcCX/+6Mr8nB5ExAAcDAUN+mkQL8klAt7MhoaCy+kCLZwVWh9znAehvYl88S9kpCOpHi3crSfiDD00T3LByGRNiRZz/TZRn3vehXd1J5+
X-Gm-Message-State: AOJu0Yw5EkQ0ZfSh3RHrlPeuqar619bd5ln1kX4rRDFrO8UapP6PRVWk
	8pz6rnSo6h42s+YQUMNzRII1JixcpE5R/m61U3ab/Y5D7q/VlPZTKs0g7tThnR0=
X-Google-Smtp-Source: AGHT+IEaH132tk7uwiYiRvUBCXYBTDRxXpWqfkCiUIhl2McL0yL4H6XUTvSvhKnOsvbYovTodugoeg==
X-Received: by 2002:a5d:526d:0:b0:34d:2447:9f8f with SMTP id l13-20020a5d526d000000b0034d24479f8fmr1381314wrc.5.1714725350966;
        Fri, 03 May 2024 01:35:50 -0700 (PDT)
Received: from [127.0.1.1] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id dh11-20020a0560000a8b00b00349c54d6cefsm3171986wrb.54.2024.05.03.01.35.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 May 2024 01:35:50 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Peter Griffin <peter.griffin@linaro.org>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com
In-Reply-To: <20240430-gs101-apm-clocks-v1-1-b2e2335e84f5@linaro.org>
References: <20240430-gs101-apm-clocks-v1-1-b2e2335e84f5@linaro.org>
Subject: Re: [PATCH] clk: samsung: gs101: mark some apm UASC and XIU clocks
 critical
Message-Id: <171472534930.18059.10164022477086463014.b4-ty@linaro.org>
Date: Fri, 03 May 2024 10:35:49 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.13.0


On Tue, 30 Apr 2024 10:54:59 +0100, André Draszik wrote:
> The system hangs when any of these clocks are turned off.
> 
> With the introduction of pinctrl clock support [1], the approach taken
> in this clock driver for the APM clocks to rely solely on the
> clk_ignore_unused kernel command line option does not work anymore and
> the system hangs during boot.
> 
> [...]

Applied, thanks!

[1/1] clk: samsung: gs101: mark some apm UASC and XIU clocks critical
      https://git.kernel.org/krzk/linux/c/6b32d7474e9b833dc7fadc1b4d4f08af9bd87fde

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


