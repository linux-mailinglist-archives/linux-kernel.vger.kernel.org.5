Return-Path: <linux-kernel+bounces-35046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31326838AFE
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 10:55:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AABBFB25B16
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 09:55:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9C195A0F3;
	Tue, 23 Jan 2024 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AS2hSVaF"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ECE95A0E9
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 09:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706003699; cv=none; b=G1agy/tICV25a99mredQyUcgFnhpO8tIt5t4nMzHH4AV08frqidMb43Vddy5W6ICkub0XCTUh7jhU96Z4YIeHgo4Kbfqdq1d5q5W+F0vZBsvFKbXxxETmS8J/IAArwluz4pfOtatuob0mLz6EBtZ70X16W1PhmkGBu+R9dt5kcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706003699; c=relaxed/simple;
	bh=s9+X44rPvtMGKpTNWIFeGkpPDxkX8dmkzY3qoWw0MEg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JXDG9Onb/Jo2jvdrktU307JwFqdcRH18wjKIaeu4UdRh0Z2+/FqcNvMaS1V3q80/uV+cW0M3SCRYnO9+ougGn3N+aS9dQXAAXzCC/lNR6uPGPkb94X1WPVm1JruOl2xAYPTW2VV6rwRymewJbZE2yYJxQM1FgMsrFoFWKEj4VM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=AS2hSVaF; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33921b95dddso1944495f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 01:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706003696; x=1706608496; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Im8GtCvE7H26gkn/fdW7k+g4Cg7EiQCmiyIP3+igXQU=;
        b=AS2hSVaFOPuPZ7iRgo43bn97pX4mFEmUJyRDZzU1Sche6I6ZQ5ma/ABTD+cgxSz8Hz
         joTNvO1OcAkqQDGijJgqQ509dx4LFTuzevvIKjik/fuS+z0Eg/t69tO+uePlTwdkkz4Z
         dEKgXYic56E7Q5Dk6WWyf75kZB0+4xBUHLTfDd2/3iFOj+pfQw+d/LCreqhGiPoJsfU4
         sXQHbUbiPxHhJ6gjoVZtYGgDBzd7tnsAxDNk2YSqm6P+0JONO0/OYY0AQIUIXDDBMBv9
         5P9i772SvcqQIiD5RzBjuTVH2us2QwCv0VbfVMpq+GWzG+S28lulIk3NayWRmLWKCtfE
         XfGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706003696; x=1706608496;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Im8GtCvE7H26gkn/fdW7k+g4Cg7EiQCmiyIP3+igXQU=;
        b=YYNsdUKm1ZixoqgUo808iN9baSsx1Wvgm5897inRmS9OTmiXQfw3LnBtHAMI2VcPjv
         GeJ06SDORz+lpxUPAm5tusyuutii4cDoZVVJayG8n3RWM8JHWY71X52XUCWEZSadVow7
         TVIx4EnPSYFjFT7W6liuef0Lj5afK1x/otyqRfHnWn4+tHvY5dv2pBaltF+5l+VgpKlv
         3NsSn0JA+VASO+L4liabpufzNrTepJ8KGGVPt3iEVUUwbx/Y9a4Qi7OhJCMV1C5FgIJK
         7/9vMQ0wX/84OHCOmp1mxfPJRbam1+Y0DNpDpkNAUKRXDhFKEwTCrdULRdJIyDCeV2de
         B/8g==
X-Gm-Message-State: AOJu0YzqHp5Ar5SM00jLfFJR3zPOF9mBcMB6k0VR+q0eyIZ9weHgM1+N
	zhuAAh2o1ba8JtcobqDDK1GuWbxlg7rrguaSfW/539XkZiUlnBCZYdxWy+rvRco=
X-Google-Smtp-Source: AGHT+IHw/B87/PaQqzMO5KRdBZBLAqtogyyjUnxTtDRW9gb+I3AZovHZMua5klsp86mAFZRTrAyj7A==
X-Received: by 2002:a05:600c:2183:b0:40d:1d1c:ffaa with SMTP id e3-20020a05600c218300b0040d1d1cffaamr335809wme.169.1706003695716;
        Tue, 23 Jan 2024 01:54:55 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id l34-20020a05600c1d2200b0040e89ade84bsm21649964wms.4.2024.01.23.01.54.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Jan 2024 01:54:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: mturquette@baylibre.com, sboyd@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
 Varada Pavani <v.pavani@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, alim.akhtar@samsung.com, 
 aswani.reddy@samsung.com, pankaj.dubey@samsung.com
In-Reply-To: <20231219115834.65720-1-v.pavani@samsung.com>
References: <CGME20231219115856epcas5p371abeb4264f60309e597b90954e6d58c@epcas5p3.samsung.com>
 <20231219115834.65720-1-v.pavani@samsung.com>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: clock: Fix spelling mistake
 in 'tesla,fsd-clock.yaml'
Message-Id: <170600369366.35728.6701987973179299907.b4-ty@linaro.org>
Date: Tue, 23 Jan 2024 10:54:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Tue, 19 Dec 2023 17:28:33 +0530, Varada Pavani wrote:
> Fix typo 'inteernal' to 'internal' in 'Documentation/devicetree/
> bindings/clock/tesla,fsd-clock.yaml'.
> 
> 

Applied, thanks!

[1/2] dt-bindings: clock: Fix spelling mistake in 'tesla,fsd-clock.yaml'
      https://git.kernel.org/krzk/linux/c/5b62ea0b85ea8e11945f862fd2eee16ac3a45d4b

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


