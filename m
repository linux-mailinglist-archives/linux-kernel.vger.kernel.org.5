Return-Path: <linux-kernel+bounces-70482-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BDB885987C
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 19:22:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1A6281A0F
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 18:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C5676F50A;
	Sun, 18 Feb 2024 18:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L1MhpMHs"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6427B6F091
	for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 18:21:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708280513; cv=none; b=DJiUJUar1LPopX9UjA9bcR5YuSJtHw+co4Bz9HnQEpNZIKsTdi51LlcjJ1Nnl/7Ac7Viopa1gARYmGbOfW1pDAwkkrqsGqOwNyKXp3TlX5l19C8bVxB/UQlSZ0KV5Z2TJKw/URdg8gcUZEvpH1Rck5V8ihg5AU9NlnN4SQbRxTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708280513; c=relaxed/simple;
	bh=YlcJjgqG+KY+nDkBNXqVqzCZnS4bJbaRlFsl8ki2188=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DSWXXohKG5KeQqi4Mtv/HbxxyQX4KvGeOE2e9kqzmGI7mTp+AqozGWnmCNBvq7S8D+wzVy/bP8mBSVQBiV33A6U4OwNcewnvnUDdH1SXDET3EnpLlAvqfr606x4QPFCswW+ANNlBjCWAMhbb6MgmfjUF1afHxNrKmJ6riQq37ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L1MhpMHs; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33d4f4b30beso62069f8f.2
        for <linux-kernel@vger.kernel.org>; Sun, 18 Feb 2024 10:21:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708280510; x=1708885310; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NJeQ4s/dF1xmsrXWqyzJPeUB9FNDeuqtjlU/RMGfQnM=;
        b=L1MhpMHsa2mJIJAgla3AKX178Ird7TZMxf90i6Q/z1AgnE6h2vJuW86lMCWWVaij4R
         v5/7C3PrhY8MGOU37ckarMxklFgf8xGqChtwJomensVGpovleCRqR3du4YgBwcEJYda6
         TDY6TAJUrtqSGyypi8DnOEgBGZaK8mJTUc5N/wWsYCi2Q5G9CWqu+pdnI9fF86GZm+AS
         jVmR5Ukx9FJvUBOzUDibBqRABlXcuG/MBZEmMycdVcIWUbMtsDnYAZI4g4QYS9v+UQ4T
         MiFOhvRf8WiFWEfvjmGoFHAfecuwIRjfwNSb4KB0ukc2XT9s4gG2lRFKGq+KVcspL4hO
         UcIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708280510; x=1708885310;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NJeQ4s/dF1xmsrXWqyzJPeUB9FNDeuqtjlU/RMGfQnM=;
        b=M8xaZFN7ocW3ctG06Nz/dYQuHbqEKetv7zMatBGhB28PW/zeFPNC7LObn3tZ2vifN/
         xuwFSJXAJ3cWBnQgb8MQK5IKtnejNyEKGMkmtl7mRuNllfUPibe/RHsC9ylsv9z0sn3m
         AkkwXIb2voGj54UGvBMcBNTfgBxixfy2wwB8YIOy5l1CECT1Zi7qs8QHrJY9rWcAUWh3
         cCCsR6Lvec6I/dNjllHurLiPrL76pAYk/RrVc+kuknCkMucehv5J6l+nyWagK809SPBf
         Wdtk7yTSOsi06TbcJgdiiKE2stMcNoitqyAWclWMNyxtoAuKlNuJV6ZBrVbsgECq45rm
         Cl9w==
X-Forwarded-Encrypted: i=1; AJvYcCV/g/WImRoQn6uMzhF5NitSyZp4ZnHla6GBFagdzASRz8HoQh/JsRFNGm0RnXW9gXuPx2FQ1KyGe4VoRXFL4YTbRxIvLRM0Cs1mXUnL
X-Gm-Message-State: AOJu0Ywa3kTlSLhAdPRXiZudlNQ7uxI+TKX08NYMIBLttkatSCMuH9/L
	uLAoL/oLxrLdX7rTh/wR6J8GbTnJzoGyoV49cal5k9ntu8WlhDCQC+IXq8ty5Uc=
X-Google-Smtp-Source: AGHT+IFGBwlBDblusdfCCYJ6QOIzpX9Y/EbyxKJg0nx5peFXbTPuSanMLt+OiKKeIiEY8GGMt5q+Zw==
X-Received: by 2002:a5d:430d:0:b0:33b:65b3:e51b with SMTP id h13-20020a5d430d000000b0033b65b3e51bmr7725445wrq.48.1708280509886;
        Sun, 18 Feb 2024 10:21:49 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id s3-20020a5d4ec3000000b0033ce06c303csm7867116wrv.40.2024.02.18.10.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Feb 2024 10:21:49 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 3/4] ARM: dts: samsung: for v6.9
Date: Sun, 18 Feb 2024 19:21:40 +0100
Message-Id: <20240218182141.31213-3-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240218182141.31213-1-krzysztof.kozlowski@linaro.org>
References: <20240218182141.31213-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt-6.9

for you to fetch changes up to 60f1164e21cc04666d23b63e1153af74e7a5650d:

  ARM: dts: samsung: exynos5420-galaxy-tab-common: add wifi node (2024-02-07 16:22:01 +0100)

----------------------------------------------------------------
Samsung DTS ARM changes for v6.9

1. Disable thermal polling by Linux in Eynos5422 Odroid XU3 boards,
   because drivers implement now proper dynamic trip points management.

2. Mark crosc-ec-spi in Peach Pi and Peach Pit as wake-up source, to
   reflect the hardware capabilities.

3. Samsung P4 Note (Exynos4412): add accelerometer.

4. Samsung Galaxy Tab (Exynos5420):
   - Reduce available RAM to avoid conflict with TrustZone.
   - Add WiFi on MMC.

----------------------------------------------------------------
Henrik Grimler (2):
      ARM: dts: samsung: exynos5420-galaxy-tab: decrease available memory
      ARM: dts: samsung: exynos5420-galaxy-tab-common: add wifi node

Mark Hasemeyer (2):
      ARM: dts: samsung: exynos5420-peach: Enable cros-ec-spi as wake source
      ARM: dts: samsung: exynos5800-peach: Enable cros-ec-spi as wake source

Martin Jücker (1):
      ARM: dts: samsung: exynos4412-p4note: add accelerometer and gyro to p4note

Mateusz Majewski (1):
      ARM: dts: samsung: exynos5422-odroidxu3: disable thermal polling

 arch/arm/boot/dts/samsung/exynos4412-p4note.dtsi   | 51 ++++++++++++++++++++++
 .../dts/samsung/exynos5420-galaxy-tab-common.dtsi  | 34 ++++++++++++++-
 arch/arm/boot/dts/samsung/exynos5420-peach-pit.dts |  1 +
 .../dts/samsung/exynos5422-odroidxu3-common.dtsi   | 16 +++----
 arch/arm/boot/dts/samsung/exynos5800-peach-pi.dts  |  1 +
 5 files changed, 91 insertions(+), 12 deletions(-)

