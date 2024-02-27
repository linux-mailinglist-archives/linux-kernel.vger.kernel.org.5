Return-Path: <linux-kernel+bounces-82835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B39C868A4A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 08:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB18B1F24C87
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D08855E6B;
	Tue, 27 Feb 2024 07:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="A2pwS+qT"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E551553E00
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 07:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020721; cv=none; b=m6f2oMjq/MJznNOaigzF4Qud5SUI7y1CNv7DzFK4OcOIADO6GKCywuEXSa5LF1s+z9PjeJBwtjBblL5j8b1B23qum2beXAIlpZUWc6OuEL3f+aGKtTsW498XSanxu24FJXHMhGR8n6FeSWRy8zObtZDDBu/URPXoAAyQ0SSW+a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020721; c=relaxed/simple;
	bh=/ew7vIeLEuM/TCI7njTkckWnYO2dVksctCFiWGxakDM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=CiE4xvzNcptED3CSxK5Kx7I36YYZ/OxuhbitART2QbHLtiBAefzm2JCZjLBgaYRzLtlsG7d9fdVuKirCM5WOWGIXiDWXPzONnVobzZcFgi+MlqR28Rftrn/Ly8si+gUSs7D4q8Uv+V+RkLkn5o1u5BssxsQrygrptaxc1TnIJd4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=A2pwS+qT; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a3ddc13bbb3so603509066b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 23:58:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709020718; x=1709625518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ic80dLEyZy6kdVJF7joUFUuNP61uTBpqR9Za88+XI28=;
        b=A2pwS+qTQzBQgPiW144YdOmdFP1LbuoxQHAEvJ1cs4yZHqcs4n+GHVJ7vql/7nET9W
         1PjlyJJHWCwfW1nnR3J5zZYSIRn9uGUgCv6t+CJ3Sj3NAfED8B0zrEMRRWqStBQ5THfT
         Gm298p+S7ug+8ndExDumcwNpGNxYDwh+pReOtRVP42mkLaqmVMdT1bXMJLaVwhMqNr36
         HKO6DcjD06fCdRCiaRYfWHUFwkBus0key7uqFuSp5ZkN15Q9bfCV3rhO+yne7B66KyG3
         LJO2G2BMUcNsh8HDJsNNbyo9rPsh2wByWXZmK830+5E9YnwmAkt6b48m/U8XmmjXfFne
         8u1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020718; x=1709625518;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ic80dLEyZy6kdVJF7joUFUuNP61uTBpqR9Za88+XI28=;
        b=SuUpMoelnFS3RVSwRcEdmw7NX4NFASFccygsmL6vGVGjDsaQTDZDRUb2ybSlm57XXV
         8+8rPJnrwa2nrcKayF+DTVsKOUH+PyT7U4HbUIqkA2cEjPMKWVYzHu0t00aDByOO7Xc9
         9dXLtg2nlzVlGtLsDlojHQEk3hUoOzROIQal9J9XM1jtjhys5S98FAF0YtN3VCzE/HzD
         0UnRtES+Gq0T+lFFKg03n9x+W01eTaoHo/j87Tyj+ZTqq+/I2MgnJpj1UhiO/2tjAjo8
         9+XZAVN4AIFrHkb+8crjGcawstiMxAA99c5HHm8NH2oK1shpD3SGrRmg8n86LQbNqaed
         kENQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAPZRRPDrwglv3BApoxdsgfXi8il6za3bxWCIrgq9KPIgjnxbdrKjxNS8RLnlfEZunP2qrJs3jlvvVmwKhZjOepd1V5ivSC/51KiJF
X-Gm-Message-State: AOJu0Yzsx6lGdBEW5JF6kz1Cb2AEMkTyfjHAeKYlR7hBvHdWyZuM2+5F
	gYPTROAbJq5rjznXW5qVy7WCpfdV9AnWiwGRWGl5pGQ3VgG+JoiUbLDlfbd3ft0=
X-Google-Smtp-Source: AGHT+IFTBK9hxL6b/DxdG3pgJ4lkvuj80VlJ9MESHK5mlD8V/Sd4fRjlluYaVaQPIm8Rcyfo6sMoVg==
X-Received: by 2002:a17:906:fa8d:b0:a3f:f8a7:e1f7 with SMTP id lt13-20020a170906fa8d00b00a3ff8a7e1f7mr8339780ejb.5.1709020718353;
        Mon, 26 Feb 2024 23:58:38 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id bg26-20020a170906a05a00b00a3d0a094574sm503467ejb.66.2024.02.26.23.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:58:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Chanwoo Choi <cw00.choi@samsung.com>,
	linux-clk@vger.kernel.org,
	Sylwester Nawrocki <snawrocki@kernel.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] clk: samsung: drivers for v6.9
Date: Tue, 27 Feb 2024 08:58:35 +0100
Message-Id: <20240227075835.33513-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On top of the previous fixes pull request - my previous tag
samsung-clk-fixes-6.8 - due to context dependencies.

Best regards,
Krzysztof


The following changes since commit d76c762e7ee04af79e1c127422e0bbcb5f123018:

  clk: samsung: clk-gs101: comply with the new dt cmu_misc clock names (2024-01-22 11:40:12 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-clk-6.9

for you to fetch changes up to 61f4399c74d0677ee64e42f7b8d4ab01ee39de45:

  clk: samsung: Add CPU clock support for Exynos850 (2024-02-25 17:07:34 +0100)

----------------------------------------------------------------
Samsung SoC clock drivers changes for 6.9

Google GS101:
1. Register the CMU MISC clock controller earlier, so the Multi Core
   Timer clocksource can use it.
2. Add PERIC0 and PERIC1 clock controllers.

Exynos850:
1. Add PDMA clocks.
2. Add CPU cluster 0 and 1 (CMU_CPUCLK0/CMU_CPUCLK1) clock controllers.
3. Propagate SPI IPCLK rate change to parents, so the SPI will get
   proper clock rates.
4. Refactor the generic Samsung CPU clock controllers code, preparing it
   for supporting Exynos850 CPU clocks.

----------------------------------------------------------------
André Draszik (4):
      clk: samsung: gs101: gpio_peric0_pclk needs to be kept on
      dt-bindings: clock: google,gs101-clock: add PERIC1 clock management unit
      clk: samsung: gs101: drop extra empty line
      clk: samsung: gs101: add support for cmu_peric1

Krzysztof Kozlowski (2):
      Merge tag 'samsung-dt-bindings-clk-6.9-2' into next/clk
      Merge tag 'samsung-dt-bindings-clk-6.9-3' into next/clk

Peter Griffin (1):
      clk: samsung: gs101: register cmu_misc clocks early

Sam Protsenko (15):
      dt-bindings: clock: exynos850: Add PDMA clocks
      clk: samsung: exynos850: Add PDMA clocks
      clk: samsung: exynos850: Propagate SPI IPCLK rate change
      dt-bindings: clock: exynos850: Add CMU_CPUCLK0 and CMU_CPUCL1
      clk: samsung: Improve clk-cpu.c style
      clk: samsung: Pull struct exynos_cpuclk into clk-cpu.c
      clk: samsung: Reduce params count in exynos_register_cpu_clock()
      clk: samsung: Use single CPU clock notifier callback for all chips
      clk: samsung: Group CPU clock functions by chip
      clk: samsung: Pass actual CPU clock registers base to CPU_CLK()
      clk: samsung: Pass register layout type explicitly to CLK_CPU()
      clk: samsung: Keep CPU clock chip specific data in a dedicated struct
      clk: samsung: Keep register offsets in chip specific structure
      clk: samsung: Pass mask to wait_until_mux_stable()
      clk: samsung: Add CPU clock support for Exynos850

Tudor Ambarus (2):
      dt-bindings: clock: google,gs101-clock: add PERIC0 clock management unit
      clk: samsung: gs101: add support for cmu_peric0

Varada Pavani (1):
      dt-bindings: clock: tesla,fsd: Fix spelling mistake

 .../bindings/clock/google,gs101-clock.yaml         |  28 +-
 .../bindings/clock/samsung,exynos850-clock.yaml    |  42 +
 .../devicetree/bindings/clock/tesla,fsd-clock.yaml |   2 +-
 drivers/clk/samsung/clk-cpu.c                      | 564 +++++++++----
 drivers/clk/samsung/clk-cpu.h                      |  53 +-
 drivers/clk/samsung/clk-exynos3250.c               |   2 +-
 drivers/clk/samsung/clk-exynos4.c                  |   9 +-
 drivers/clk/samsung/clk-exynos5250.c               |   5 +-
 drivers/clk/samsung/clk-exynos5420.c               |  16 +-
 drivers/clk/samsung/clk-exynos5433.c               |  10 +-
 drivers/clk/samsung/clk-exynos850.c                |  43 +-
 drivers/clk/samsung/clk-gs101.c                    | 940 ++++++++++++++++++++-
 drivers/clk/samsung/clk.h                          |   5 +-
 include/dt-bindings/clock/exynos850.h              |  56 ++
 include/dt-bindings/clock/google,gs101.h           | 129 +++
 15 files changed, 1661 insertions(+), 243 deletions(-)

