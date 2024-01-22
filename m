Return-Path: <linux-kernel+bounces-33006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2D68836320
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21E2E1C21CCB
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAA593E477;
	Mon, 22 Jan 2024 12:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IaObIRu2"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 883A63CF43
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705926060; cv=none; b=kVVxQgkA2/KHa3WynY1y5jtmR3SEaK9kajzGoge6UjXCdH2cugAe8HrrQC0mLvDTIwbygklolGkUxBwT4hIcjGvPix/lBFIHXzeZiIslN7h2mseywCcezkQN+r0NFPjDnHY18LX4DWOFwpuokkcHp7eZgmdSgD7YUgQ4dANrA2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705926060; c=relaxed/simple;
	bh=YZ1z2j1kI4ddtowX/6pc2qFb6DJElIuVdVyPI0aRULs=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=i7VbqzDYya1DGYumZN3ALICpJUGmlX8HKpefXuePfMSuCkovCueVdjC4Ti+1cKwVcbPhdDTaZD0RZR+twwZ6mu7dRziy1CHJ00i4jBPT83PZSF521mPca++qk47J/P0Fwg+62InybHQEGI8be0n5VVBbjK1AZz3NhrrJXuNOSjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IaObIRu2; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33934567777so1136082f8f.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 04:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705926057; x=1706530857; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kABQclCWxHgPnu9QJU5EL2/wY8bNoLCbrJHvsKEUK0g=;
        b=IaObIRu2LGHDgBjnVeOjxwqm2b5YccPLyvTxj1G16DYPhRyhEMEkJN1wWToBIjpYy2
         Glf64g2ijuCgXNjrA6VYzE8Eva9guW15yCdBR+t/o4R1VyFDF6GSuZ6dG+FFihuLxYz1
         gnlAYQbMOu9sWzjyBSwLYBvjwrGUFzdr5l/LQEZXmu//7bp+uijA/bJZkIfAJuoqYEDW
         fKprjcjkFJZRdoHY5TSJf296I6BB96HtTLwkdmktn4gIFUj2TztSEyc7g7DQiAqwoDx2
         IwZzqauTGZidfT2w6oKjymJEBovlFPW7EhxXqultjXu6CO2GmgQya1KDWshqUfpPa/9M
         kl5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705926057; x=1706530857;
        h=content-transfer-encoding:mime-version:date:message-id:subject
         :references:in-reply-to:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kABQclCWxHgPnu9QJU5EL2/wY8bNoLCbrJHvsKEUK0g=;
        b=dIZqwI+yREj6WF+PQL5c6azRi7YUZQYCFMO83G9tUPvOfTbyXJB5JcmnH9TefY/1Q1
         LWRhjppZFOA4W8BdhkXbiuTDS9efkO0GVIxJdS5w0zAf2fyrsjJRDhFZTQxh0fpPXXOg
         lKg/Oppvm7EpGHWow+i4yPEexN4IKaT7eiILLOaZljzW9UBelQZSKF6fCq2IvB4dMJYL
         9YKnBhstj1grS7dxb44iLy/K7Jfmaf/1k2s+YSyKvSmDIPs7RhzQJv0CpR3zfeziAP+O
         9P9tKTiUU9aiBaYe8WfiDdB0E6unn41y7h0iUGv4NVhSvtDtyv2q3m619ioRj5EDC9PR
         0LLg==
X-Gm-Message-State: AOJu0YwqyTZ/j21zKWwtTyRXHI2WRYdFZpQ+UtqPRMrRR08n8fBd7F2Y
	0xvCR/3uj9k2UaXeaN0OVMPTmalnQw6A1qh3/nF0EDiKRO3IsHmW9wyVeFjISJ8=
X-Google-Smtp-Source: AGHT+IFhqjuIwtg+QmXyJ4f9r6mNt1zxG6VLayec6ocn6/EHmN5XOjRCUa+vR9FMXnsULV8fzYl/Dg==
X-Received: by 2002:a05:600c:4d02:b0:40e:49bd:a2ba with SMTP id u2-20020a05600c4d0200b0040e49bda2bamr2368821wmp.86.1705926056443;
        Mon, 22 Jan 2024 04:20:56 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d5091000000b003392d3dcf6dsm4585801wrt.0.2024.01.22.04.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 04:20:55 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Tudor Ambarus <tudor.ambarus@linaro.org>
Cc: peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org, 
 alim.akhtar@samsung.com, s.nawrocki@samsung.com, tomasz.figa@gmail.com, 
 cw00.choi@samsung.com, linux-arm-kernel@lists.infradead.org, 
 linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, andre.draszik@linaro.org, 
 semen.protsenko@linaro.org, willmcvicker@google.com, 
 kernel-team@android.com
In-Reply-To: <20240122114113.2582612-1-tudor.ambarus@linaro.org>
References: <20240122114113.2582612-1-tudor.ambarus@linaro.org>
Subject: Re: [PATCH v5] clk: samsung: gs101: add support for cmu_peric0
Message-Id: <170592605426.49653.1635174301896899185.b4-ty@linaro.org>
Date: Mon, 22 Jan 2024 13:20:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.4


On Mon, 22 Jan 2024 11:41:13 +0000, Tudor Ambarus wrote:
> CMU_PERIC0 is the clock management unit used for the peric0 block which
> is used for USI and I3C. Add support for all cmu_peric0 clocks but
> CLK_GOUT_PERIC0_IP (not enough info in the datasheet).
> 
> Few clocks are marked as critical because when either of them is
> disabled, the system hangs even if their clock parents are enabled.
> 
> [...]

Applied, thanks!

[1/1] clk: samsung: gs101: add support for cmu_peric0
      https://git.kernel.org/krzk/linux/c/4bd800aaf96f880d45b1a28b2f78549a0f5a3a1c

Best regards,
-- 
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


