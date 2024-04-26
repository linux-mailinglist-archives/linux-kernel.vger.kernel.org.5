Return-Path: <linux-kernel+bounces-159828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E409F8B34D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:03:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 127761C20C25
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:03:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F04AE142E97;
	Fri, 26 Apr 2024 10:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="USJDmzH4"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72D67140E30
	for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 10:03:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714125790; cv=none; b=BP6F+JtFl1qAISf0I1wODP84JUt6YHkD6S7ZQTADuS+9y/qjQ53pLm/yeoCIy9G5MqNXJMrbuqlPqQCpqLamr1fxX74fKv9iQX7EhZa4MVEoBrH/BANnVkGt0LEzlGFM/KtmSZpA3T2pOTCgc2xzZmvwbG71a9zRuIewONuxAM0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714125790; c=relaxed/simple;
	bh=ryP7QOTYlztIm8nqNij3nVjhL1SYpQUIEozyw+/HVzI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=kv1cxktq9rH2VQQL/dhM6Kw/c6+IcZ1QLZySjX2EHXSpHf36NUckv1ZeML/HyhwARcTh/rkkins/6C4ThtY7HfXbr6HbICH/jt7f5ay6gGZJeaPd+X9S5gvutbr2jsilqRm4vbuM1YEUB7BIQqoP7yrlozSaw0rr3hT/Hmb6m+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=USJDmzH4; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51a7d4466bso234613666b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Apr 2024 03:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714125787; x=1714730587; darn=vger.kernel.org;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NZroSo8iMfP3vk8OTX3L1wntYEviDHYNgM+pqywM7tQ=;
        b=USJDmzH4BOdZ6ax+cjfpiOwTi+m9lMHO0XVE7I3E6se0sNEPhlcPMxunC5fmMKIc4E
         PG3J6uqniXgd/OclOplVVK9YU28MQbRZJ5fzgYfdelfod3Q/axuJioQIvbd/YmCt4NeL
         AF2T1jlvKwtRct08LvN26GoorbOcMt2y++kfeSwO/WPFFJs42Yshec115ZIOgPHtgblg
         aWCLyA87IRKwwQMD4vDWhDNLeVotJYdfTcz+oSR4q1HcYSke0/Mn8HZyycfo7BrEp4js
         W3szRXeQDGt3TglDIta8ZpL87Rt0VIQfk6KoqIArUImMzgTFqqPDU1V80mVCQJms2gmv
         pVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714125787; x=1714730587;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NZroSo8iMfP3vk8OTX3L1wntYEviDHYNgM+pqywM7tQ=;
        b=F43VAD/nZbtWvEAPNzzr0dGEzLD1/QSiqJwcI5JAO8V9SMDvf4lHRnnW+VUA0XC9Ub
         XfjqVO+G6x+pRb63coWybqvKu8Wz0g/NayWaHLx+/0R0YjVS0eXAHeXXrcxdESgQVFj+
         SLS1G5AVUQ6kM8W0rtFOrjcmyxFD/NKc9wdM2hee+JkxAAHPvokbYt9jr167jq9FAbI5
         7Apti/J1sAOuH0LnEnkMf/EKEBs1+9La/JLCdMwWUNg1YHt+uVpZOIbui+irAs31KRXt
         02SBgHzIbGpNhZQgRZZsdg1Sx7SF7KvnudqqrEuoUuqgUFEDmFRZLhAKirbPQmRUGIn/
         Wfzg==
X-Forwarded-Encrypted: i=1; AJvYcCWm3zR5EKptt8RrSGcbLAJfYUK/wxausg2g5LwkE6vT/7A90RAAK4nGoMhV3rOV6cAojM0fNpQzUk8HsD9g7BRHsEHjKlVqMUPjYljZ
X-Gm-Message-State: AOJu0YzxzK3aWrEVTurhkW3x6TkHR0PyBYYrvx8wMVSrH1hjksX8Ll+B
	x7BWrE21HOCDODNupiaZcq1hqXzDIFkSiqKu8dd4EVRsZlcCL6QCJziD3brIO1E=
X-Google-Smtp-Source: AGHT+IFqZI2EX6TGMrhgOaiItUVC4QA3lp6lQjXgOmzliiIzZJRkthk8yLel6nW0qHdN359C7X9+Sg==
X-Received: by 2002:a17:906:16d7:b0:a58:86c0:1275 with SMTP id t23-20020a17090616d700b00a5886c01275mr1579547ejd.30.1714125786723;
        Fri, 26 Apr 2024 03:03:06 -0700 (PDT)
Received: from puffmais.c.googlers.com (8.239.204.35.bc.googleusercontent.com. [35.204.239.8])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906705400b00a555ef55ab5sm10417289ejj.218.2024.04.26.03.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Apr 2024 03:03:06 -0700 (PDT)
From: =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
Subject: [PATCH v2 0/5] HSI0 and HSI2 support for Google Tensor gs101
Date: Fri, 26 Apr 2024 11:03:03 +0100
Message-Id: <20240426-hsi0-gs101-v2-0-2157da8b63e3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIANd7K2YC/23MQQ7CIBCF4as0sxYzQBXjynuYLqaFwiQGDBiia
 bi72LXL/yXv26C4zK7Addggu8qFU+yhDgMsgaJ3gm1vUKhGHJUWoTAKXyRKQWTMRZ/lvBJBPzy
 zW/m9Y/epd+DySvmz21X+1r9MlQKFWrS18wkXo/D24Eg5HVP2MLXWvrUuOfelAAAA
To: Peter Griffin <peter.griffin@linaro.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Alim Akhtar <alim.akhtar@samsung.com>, 
 Krzysztof Kozlowski <krzk@kernel.org>, 
 Sylwester Nawrocki <s.nawrocki@samsung.com>, 
 Chanwoo Choi <cw00.choi@samsung.com>
Cc: Tudor Ambarus <tudor.ambarus@linaro.org>, 
 Will McVicker <willmcvicker@google.com>, kernel-team@android.com, 
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org, 
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 =?utf-8?q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>
X-Mailer: b4 0.12.4

This patch series enables the HSI0 and HSI2 (high speed interfaces) for
gs101:

- HSI0 feeds the USB block and is a prerequisite to get USB working.
- HSI2 feeds PCIe and UFS

The parts added here have been verified to work OK without the
clk_ignore_unused kernel command line option.

Signed-off-by: André Draszik <andre.draszik@linaro.org>
---
Changes in v2:
- My v1 just contained HSI0, but due due to changing similar areas in the
  code, I've also added Peter's HSI2 clock patches from
  https://lore.kernel.org/all/20240423205006.1785138-1-peter.griffin@linaro.org
  to this series so as to preempt any merge conflicts. Namely:
  * hsi2 bindings
  * hsi2 DT
  * hsi2 cmu clock driver
- drop patch 'dt-bindings: clock: google,gs101-clock: add HSI0 clock
  management unit' as already applied
- cometic updates to patch 4: 'clk: samsung: gs101: add support for
  cmu_hsi0' (macro name, a whitespace, subject line)
- Link to v1: https://lore.kernel.org/r/20240423-hsi0-gs101-v1-0-2c3ddb50c720@linaro.org

---
André Draszik (2):
      arm64: dts: exynos: gs101: enable cmu-hsi0 clock controller
      clk: samsung: gs101: add support for cmu_hsi0

Peter Griffin (3):
      dt-bindings: clock: google,gs101-clock: add HSI2 clock management unit
      arm64: dts: exynos: gs101: enable cmu-hsi2 clock controller
      clk: samsung: gs101: add support for cmu_hsi2

 .../bindings/clock/google,gs101-clock.yaml         |  26 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  26 +
 drivers/clk/samsung/clk-gs101.c                    | 976 +++++++++++++++++++++
 include/dt-bindings/clock/google,gs101.h           |  62 ++
 4 files changed, 1090 insertions(+)
---
base-commit: bb7a2467e6beef44a80a17d45ebf2931e7631083
change-id: 20240423-hsi0-gs101-aa778361bfaa

Best regards,
-- 
André Draszik <andre.draszik@linaro.org>


