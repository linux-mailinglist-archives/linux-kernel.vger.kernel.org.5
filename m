Return-Path: <linux-kernel+bounces-158111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CB548B1BC1
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:19:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D3D11F24FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:19:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CB226E5E8;
	Thu, 25 Apr 2024 07:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twhPcKFP"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 066606BFAC
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029547; cv=none; b=k9z84/Hb0DZiLChoJkhjD+D+w6Yc0mKauMBROWsruABiSixdOUeefTdOE37ND5NyHx1A7+ADxygBq+4T4nTkuK90wWwwfnlUqqszNkYgKmhm/FHzXxuEKzjdwuwbJ0IQdmxI/Hs1QR/FStU3d98uoC5Y3BhGQ1LHNGI1i6Fr/xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029547; c=relaxed/simple;
	bh=ufI2zcLTn2csgH9AexYYedelSXPGBL/36WoMZX7qNPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QSesZPbJ8Zv6M4rGcFlUhSCKSGaKe76EZ6odhJsGn6a5GUC0vPj16zOnuJsjh2HDqRh0cRICqGvjJVj55cc2f3lidS5MUQu2F846FsdxFnwDUeYQP5/n98Hhw0Z8dAGfi8CKqIJ6VBPVf0RxGq+FmCTeA6di+du9CRxflw4D/To=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=twhPcKFP; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a519e1b0e2dso85436566b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714029543; x=1714634343; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FDtBGib/Y6SrLcaq1T7Za9185cOkevaJjpxXmDQw774=;
        b=twhPcKFPury9WSSAvSwk+TXXronFlZHxEJ9Wrdr9TYqIeGESSgce8qufG8vMZ8ONOp
         lZNX6Pvbqix9M9xILEiQfBCw6ZKBECBsww9KENUG++GT8TeV2HblGgInCesmlhdqjONZ
         w53qfNK4+/8yBLWrL+RQYp31/I+aqxRWVtoJm84P2235lvdL6T0EWnPZh4uh0KWf1g6f
         CXYGyrCLeygjC1a+arnUDdsIBD9dsmDRmL9pkLHygHtaB7jD91flEC2xdlgP8m8NjZVV
         32cIdnXLitZ/OSqRdT6f+k6joHjD/LKo9NN9Klj9ueO7Y8bYo92dXKx6RHzKa0/iuq6v
         8ftw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029543; x=1714634343;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FDtBGib/Y6SrLcaq1T7Za9185cOkevaJjpxXmDQw774=;
        b=F9ofKOBshSNTF4zMygA5nYFxR4xhnUKdCuljWp1t5QVXnPwspMDyFX8X15BQDFTBAo
         UWQ1pwDXnAreV41LmI1FefVLrfht74xmCBdoGOafiuROuaQPq0okvIrZADz6TEoZK3c0
         2UH3JeepCH8iHwVg4Lg2uRi233vbdbi+PalN+wP2C7tp9j4vFvvBo4oIYlShjA+xDkKj
         xuDFRLZF+X7RjS3r34k41LPfgiokdf9GAg+4pFIrvqyNFvfVdV1Lr7MLiB7TQC8SBZT5
         ZvHpjRLKr3t9xardDf6UkYHfZZ3JoJxh38h8YEh4y+oqkWAAsNRSwN7sWnEhbbmDUD4X
         8tKA==
X-Forwarded-Encrypted: i=1; AJvYcCWb0z+iNqQAc3PzYi4Nfd0Ku02pCJdXAQMO5Pi+0p8k+KgbiWdNYN17pQOY3IJLnEJ7AqVKQwoI7/+cFaTlyQBTeFZhjI2vrKRYizwz
X-Gm-Message-State: AOJu0YwOod9OAWo47HFhAYGNmACazhZBF7EqzDbv40OmwNSULBXuqTqj
	TSfFZCqFeC9qcnEoen423RE302mgEsJgWqWaUhnnKme7skvBONhlweEcIHkof3g=
X-Google-Smtp-Source: AGHT+IHcW+odnUXlsGsaZcYoRQyADpE9jTnNF7imEjFFLWjqptBhedzpNGemXljntpCtWYL/qIg9/w==
X-Received: by 2002:a17:906:3953:b0:a52:4394:888b with SMTP id g19-20020a170906395300b00a524394888bmr3292157eje.65.1714029543241;
        Thu, 25 Apr 2024 00:19:03 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id hd38-20020a17090796a600b00a556f41c68asm9091174ejc.182.2024.04.25.00.19.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 00:19:02 -0700 (PDT)
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
Subject: [GIT PULL 2/2] arm64: dts: samsung: dts for v6.10
Date: Thu, 25 Apr 2024 09:18:55 +0200
Message-ID: <20240425071856.9235-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240425071856.9235-1-krzysztof.kozlowski@linaro.org>
References: <20240425071856.9235-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The following changes since commit 4cece764965020c22cff7665b18a012006359095:

  Linux 6.9-rc1 (2024-03-24 14:10:05 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.10

for you to fetch changes up to a45c3a9b1ef9571741d40bf10f22ce3c60bc5111:

  arm64: dts: exynos: gs101: define all PERIC USI nodes (2024-03-28 10:51:16 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.10

1. Add FIFO depth to each SPI node so we can avoid matching this through
   DTS alias.  Difference SPI instances on given SoC have different FIFO
   depths.
2. Exynos850: add clock controllers providing clocks to CPUs.
3. Google GS101: few cleanups and add missing serial engine (USI)
   interface nodes.

----------------------------------------------------------------
André Draszik (1):
      arm64: dts: exynos: gs101: reorder pinctrl-* properties

Sam Protsenko (1):
      arm64: dts: exynos850: Add CPU clocks

Tudor Ambarus (6):
      arm64: dts: exynos5433: specify the SPI FIFO depth
      arm64: dts: exynosautov9: specify the SPI FIFO depth
      arm64: dts: exynos: gs101: move serial_0 pinctrl-0/names to dtsi
      arm64: dts: exynos: gs101: move pinctrl-* properties after clocks
      arm64: dts: exynos: gs101: join lines close to 80 chars
      arm64: dts: exynos: gs101: define all PERIC USI nodes

 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |   5 +
 arch/arm64/boot/dts/exynos/exynos850.dtsi          |  26 +
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi       |  12 +
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts |   4 +-
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       | 791 ++++++++++++++++++++-
 5 files changed, 823 insertions(+), 15 deletions(-)

