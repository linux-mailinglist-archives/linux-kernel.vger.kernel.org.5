Return-Path: <linux-kernel+bounces-56729-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E9E84CE3F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 16:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB8B5285CF4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 15:39:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D37680BF9;
	Wed,  7 Feb 2024 15:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QUKs2XCl"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52D08004C
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 15:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707320310; cv=none; b=FWMTHjfl1MiepMOzZfvxplGpXlZdyyWciAEyVkenmE192lWSdc3xDDjjQ+FutLzKwxLukK2TKaFYqi4SqpbNA4lrfGjn5E93xSqDqqKAeagEDDiad4QqM/yzIdYUvt9JTQiKjg3fHQpNgok/xLfdunC2RpR/4btqI0U9J3XIGPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707320310; c=relaxed/simple;
	bh=ZWJ2fuksDz8u5TB6EH7M/D1Xg/5ySwPXMM0tvokLEYs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=asH0nTXPGxVPlQbmCzqym3UURtXtJxox93xtkQRwVuZyn48g1u1Xv7Ny47/Mglsp4QxHZkwoqVC2zGJghtnyEbFDQmaO0A5yJ9RF0esohKccEkGkQ2TQ7tnYuif3+o8VLje+E9nPU3PJO2pApZBGqARWWLGsZcHnxvNV4qHzHLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QUKs2XCl; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40fd2f7ef55so11157945e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 07:38:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707320307; x=1707925107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S7lx4rrfuIWnW5mJuPPkI8UfAuAK3avv4ybgNPIN/64=;
        b=QUKs2XClvMH0Cp/yFU/czlwtOKaywMtvttYCfcLgxuaIrctFHAbklk/Kwc4ogIY9x7
         8ZQ2T/HwS3T+eY8TmYXpu1uE67rjQT5TDLkJ5lISWJBIZ23Qrf9BSX0TPiL8ljfjpoDM
         PSBKdyjDv9LP74But+WwUJtV4bipVDXPT7pceWUGMdh33UENJEJkvKDFnHlzl/l69nyG
         Si099ogPRx3yrChn8IAsXdyB+AB9PULWr2aU4AaWZ8ARwTTZo6wMm/vcDufkh8OpJBZl
         aVUByQBHz30ijZSLQiZxMJfEYIqUdpNgk1YfRukuxiZtCbOpa+STl6HtyuLQOKrj/QBc
         e4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707320307; x=1707925107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S7lx4rrfuIWnW5mJuPPkI8UfAuAK3avv4ybgNPIN/64=;
        b=wJUGvDCK3LcwUJP169442OcgMaTmkajfP9zZwwKWMSAA+Ngzfr7blp1YDWOasSYy/A
         ozMa83MQfrtOo408+CWRCn8lkz+J3Wy9Af9kDuue5YaF9q85YbX6HNY2iVRozibcVNgC
         Hvkt7l2mfl6AwwPQgA0s2sK9gkO2kie1jziUSexWrJwJArZKQL4vlI6BLPhv8fENd4RJ
         RTfEBK77r1HWGc1g01aVqu3O2ISuzOSvACKNFdDCjSBpT7b0QB8TzNmqs6vsUSfTDNwo
         wDtQY0Nsn0MwHyqxvID4lgMxvaiBgkfItaiIyaKBT+GXIx75wLWKs6LDjHRPt6lnH140
         x7Jg==
X-Gm-Message-State: AOJu0Yw9zz78cY/ypRBFBj4hyG2sgx/EwyJl1AA5goJFKWRKRuSAToJa
	SDrccSTly7R6ltnYMmRVZgJ7+t6P/gbr1ZLf+/isSUmK6iCe7TD+gqxbg/mWEhE=
X-Google-Smtp-Source: AGHT+IFhCskKoeqkai1R18bRIczhygPyUEH2tFh0beZoCJLAb/0BPzw+H3RyCqbm79MxZ8gPLd4VvA==
X-Received: by 2002:a5d:4989:0:b0:33b:fed:656a with SMTP id r9-20020a5d4989000000b0033b0fed656amr3545820wrq.35.1707320306993;
        Wed, 07 Feb 2024 07:38:26 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXAhCrtzpTfYcQrcrJFlM2VE5F3w0Xh3sTuYS71tndlrLEa8xoTqwD/tR0xgXEO8Yc7dwoKk3wFXFpE7wsudXGjv2yfS1oOHK/N+dEP8welOaaNXsl6f9rU/qCEk50BYqcInoAtZQi3vajtAijgceASeIIH7heuIgPT+B25cPsXhoBYI9iU+6HKQ9DqTrGZajA7Qc7+2LubyqzLWx/fU0WZ9PicFNgAhbnQsxFd7+XrdYdfxt0eNV8dnogR2BSiLC+slp7GbPLmjekXEDffTBCVIX+HxDrgIIDUz5brcygFkUcJ1Oj4wmdQatw04cJ7USQMOBpehvFQ03Y/MkmHMyMur4tBF6ur8WoOkixDpY4fXWWcVd7gKUxliGOhymYfITrzGlpqbPhrMikIgjYyswGuFFZ7kykq97GNLNZDsvHcrrliaa7qU1ZH+0T5SQEXXKvzKLWJJTlZrUMbFJlRaXYPFre36JNDav3lDJ2xexkL8to+7PsuOavf2/5bTYUy2V/p554KazMO7xmp6VZtu6MEZKG/yuBdR7dOH7/sTwIp15vHs9Y67g+lCeHstodhII3z9Gfjo4UlbZ8r98kNdnn8PeJF5AxWmPafn/MmkRu5nPejqeTwysbdNG9bFwv9MBXsJBqoJYMLowpfnw8ZTeEkun/cIAqnBg6k9WwJg5olzAs=
Received: from krzk-bin.. ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c024700b0040ef0e26132sm1307678wmj.0.2024.02.07.07.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 07:38:26 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: peter.griffin@linaro.org,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	kernel-team@android.com,
	tudor.ambarus@linaro.org,
	willmcvicker@google.com,
	semen.protsenko@linaro.org,
	alim.akhtar@samsung.com,
	s.nawrocki@samsung.com,
	tomasz.figa@gmail.com,
	cw00.choi@samsung.com,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: (subset) [PATCH v3 3/7] clk: samsung: gs101: add support for cmu_peric1
Date: Wed,  7 Feb 2024 16:38:15 +0100
Message-Id: <170732026218.120770.1198714836508934799.b4-ty@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201161258.1013664-4-andre.draszik@linaro.org>
References: <20240201161258.1013664-1-andre.draszik@linaro.org> <20240201161258.1013664-4-andre.draszik@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit


On Thu, 01 Feb 2024 16:11:39 +0000, André Draszik wrote:
> CMU_PERIC1 is the clock management unit used for the peric1 block which
> is used for additional USI, I3C and PWM interfaces/busses. Add support
> for muxes, dividers and gates of cmu_peric1, except for
> CLK_GOUT_PERIC1_IP which isn't well described in the datasheet and
> which downstream also ignores (similar to cmu_peric0).
> 
> Two clocks have been marked as CLK_IS_CRITICAL for the following
> reason:
>     * disabling them makes it impossible to access any peric1
>       registers, (including those two registers).
>     * disabling gout_peric1_lhm_axi_p_peric1_i_clk sometimes has the
>       additional effect of making the whole system unresponsive.
> 
> [...]

Applied, thanks!

[3/7] clk: samsung: gs101: add support for cmu_peric1
      https://git.kernel.org/krzk/linux/c/2999e786d7e9596a0057d70098e339d59d7e72f9

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

