Return-Path: <linux-kernel+bounces-86686-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 88CA286C908
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:20:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A4D8287178
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:20:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E093C7D081;
	Thu, 29 Feb 2024 12:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bV0ljLJs"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DD6B7D060
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709209229; cv=none; b=nMEHf2ALw778Mh4iIyc4cTp9n9vJFtiXHr0Ha5kJq3Kau7OriGwHfxIpQ8WOuecEg0w3ma/vCHxML1OSo9NyZpT9XWB8JcXTCOCgXkntpyxGDpvYQu9MU4BXde8t9k0rv0mTY3vwiDIhWwtAytyFRXlHqwQhBPQ44edIY6Iyyqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709209229; c=relaxed/simple;
	bh=t3T3nzjH4yLLDmY7ceHX7NGlnylBse4d450fwq8jtb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUz4JBW927PLoMj/yqzSFHl4vUE4TtZhGw0n+SFsv+bE3Ge7lStOSblyR4j2SiMBn6n2gBR0XqZxlwldC3I4wjufAXA+GBbDQgh0L5SHA9vPzLNlRYW8Ug11zb8AulJ+nC8MjyNmeccHwkWt9cQyOOcr4gAkI6nHapMUkLcH7CQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bV0ljLJs; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2d28e465655so10743421fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709209225; x=1709814025; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0vjzIB8u0IabtEYVRJzJAEQ3mD04zR5ijVvS5JF9Y6Y=;
        b=bV0ljLJsnKGd2TcJdvZm1mPKKYlRZ/EiYJjfHVuMoIUDtNy+/4KBDX4JMOpZr+MDUX
         8JAVwS0kvP4QdXbt7QPYgvbcSYEsTPtMG1JTkkFyFpiFzssSOZoIlCDBPGWZwJzu8Zav
         sWAKtYDtPkq+PvcVDpsnnRzsCwbWIP9PyubVkRrPt0HAL+0WFvT8B1SFRb4rFUcULhsQ
         lPrs/bzhh/sf7fNo/tRv16WCGmzx4ATc6pgOvbt8R6eravEcpJJJEzmUqqfZdym6bamY
         2i3n87OtH0JPXpUbZuyhUtiar19u18mA1PHnp8lZiQ33MjAiQsJ/ltPtqpmi4EemwdsG
         8AlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709209225; x=1709814025;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0vjzIB8u0IabtEYVRJzJAEQ3mD04zR5ijVvS5JF9Y6Y=;
        b=GIWNMpFjZR8VyuBRAn1I4YO3YSOgzhb35AVi8lLv82EgTKeyJUKPfgtHkEby116YDT
         aRjDl2dDVRG/QdIoQ7ZRuMvMrRH6bPXehOrpnUTN1kyNz0xGgFSEG03dIYpO1OKWqNrV
         Ur/+mYOIFDvXNGOnBTr/hqlQLnzc4uVUjc/UGysp8CNZzAcMM0sJmdkvCMR3KFE7b8OM
         IzGx6LE/MWpUrhA10l5FycppMRNw6U7TbXYa8OW701a6Y4NBd7D1aFlshVm8hWvb/LET
         WmSsX5pATtUF7aZsGNTEtutBBurrVCQnUHeTNxyrJn9lk27H4BSxpcIKGwKWqGvfsFYO
         J9+Q==
X-Forwarded-Encrypted: i=1; AJvYcCXKkZfQDReMDQyDluRapxHRYydo5EhWQe7nlXiwFQRvqj2L6A1xEAUC+0dXNLG/p8Acc2alUXbwDdtg7B9zkdvNtJ/dTgxAl7XxqP/o
X-Gm-Message-State: AOJu0Yx/qAky+oK+cQt9pT2Cet152swgxh+o5KLtvcRZ/AY4LfhfMelA
	a/dR6leHXV9Q9X8Pd++VuiybA5kWMGwSt4eL2TlnAaS7VE7G7Q87qXfQqqBP1aM=
X-Google-Smtp-Source: AGHT+IG8n5Uwvbvs8YE19xuHslAxDWVpeTnYjInoghHURNZKQMGqmCLjO4J8AQclmPxxrOwq2z/Afg==
X-Received: by 2002:a05:651c:19a3:b0:2d2:6c75:9a67 with SMTP id bx35-20020a05651c19a300b002d26c759a67mr1670331ljb.38.1709209224600;
        Thu, 29 Feb 2024 04:20:24 -0800 (PST)
Received: from ta2.c.googlers.com.com (110.121.148.146.bc.googleusercontent.com. [146.148.121.110])
        by smtp.gmail.com with ESMTPSA id dx14-20020a05600c63ce00b004129f28e2cdsm5009121wmb.3.2024.02.29.04.20.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:20:24 -0800 (PST)
From: Tudor Ambarus <tudor.ambarus@linaro.org>
To: krzysztof.kozlowski@linaro.org,
	s.nawrocki@samsung.com,
	cw00.choi@samsung.com,
	semen.protsenko@linaro.org
Cc: alim.akhtar@samsung.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	peter.griffin@linaro.org,
	andre.draszik@linaro.org,
	linux-samsung-soc@vger.kernel.org,
	linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	willmcvicker@google.com,
	kernel-team@android.com,
	Tudor Ambarus <tudor.ambarus@linaro.org>
Subject: [PATCH 0/4] clk: samsung: introduce nMUX to reparent MUX clocks
Date: Thu, 29 Feb 2024 12:20:17 +0000
Message-ID: <20240229122021.1901785-1-tudor.ambarus@linaro.org>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce nMUX() for MUX clocks that can be reparented. There are MUX
clocks that are dedicated per IP. The reparenting of the MUX is
safe without affecting other IPs.

Follow with 2 patches for GS101 to propagate the USI SPI clock rate. nMUX
is used in GS101 to reparent the USI MUX to oscclk. Tested with USI6 and
USI13 SPI.

Fix USI SPI clock propagation in exynos850 by allowing MUX reparenting
for the dedicated USI MUX clocks. Stop propagating the rate change from
the USI muxes to the common bus dividers (dout_apm_bus and dout_peri_ip).
Other leaf clocks (HSI2C, I3C) are no longer affected on SPI rate
change. USI SPI clock range remains the same. Exynos850 patch is not
tested!

All 4 patches can go as fixes, since they fix the clock rate range for
gs101, and stop affecting other leaf clocks for exynos850. I don't mind
however if K choses to queue these for next.

Tudor Ambarus (4):
  clk: samsung: introduce nMUX for MUX clks that can reparented
  clk: samsung: gs101: propagate PERIC1 USI SPI clock rate
  clk: samsung: gs101: propagate PERIC0 USI SPI clock rate
  clk: samsung: exynos850: fix propagation of SPI IPCLK rate

 drivers/clk/samsung/clk-exynos850.c |  15 +-
 drivers/clk/samsung/clk-gs101.c     | 225 +++++++++++++++-------------
 drivers/clk/samsung/clk.h           |  20 +++
 3 files changed, 147 insertions(+), 113 deletions(-)

-- 
2.44.0.278.ge034bb2e1d-goog


