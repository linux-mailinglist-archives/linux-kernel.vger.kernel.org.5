Return-Path: <linux-kernel+bounces-86712-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B831786C969
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 13:46:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C831C21A0B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 12:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30767D403;
	Thu, 29 Feb 2024 12:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UYbQHJJK"
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 945497D087
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 12:46:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709210771; cv=none; b=C/ATb3XPhwNjvBUrcRcU/4Ps76Qaj9GPN8zNgrdw8artKxbNJ2LKyiZnjLb7lMlFS3L3lSkjZ8ESOJvWSGy2Eh6MoT1liiOzPj1qUd8Beae9QTeKsNvWG7tbEMdPFeGHJZgmSW8yK1oSgT9fUoePjo8NN8lzHsZtzrVhBAP6z+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709210771; c=relaxed/simple;
	bh=WZ9GC1UAZA9PhjCIOq74EvlVw5d0YIJ1tOkPKmdkzyM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Et2FesINuWXNksYnvAHmiim6GnkS3bLgQiFEbv9S+WYEm9coww3dFfGAHJA47Zzs6AkMZ1BszqLRve9OFzfVNN+CKCdJp58CHdI5iaA6uKdSN/+BqyLjRaw2BTjT1rWB29JuvMOEJoL7Yn+0KgzICa6LSbybYmFq7axAxXt+Qs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=UYbQHJJK; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-a3ed9cae56fso381198666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 04:46:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709210766; x=1709815566; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Clp72FczazQSKbLIcT40/U9haor6HXf5C1kMTuaxg/s=;
        b=UYbQHJJK+uFxNgP0/RpAxE6dJwWPBFBkHhTnqcqW1PPPyTKFyfJ7ThPuJHPWW6CID0
         qN3RGEMA6YBYx6+1byyY93+CFbv5LRBXOm1mE6msVUiT2XZ1ugQKgwu6hZw/vZST55fV
         sP5dmRGLDspaf6Szro7j9Hr/KC4gxSdt7DTlQEG5lzKISmK0fyxbf4v5HD6tP0nkN2DB
         MQr42B7Hx5TJZzmcEmpYRksRkUvSEwT00pXkqHgPCXPgo75796+rKkNaLIIdmPswpajn
         njb6msTdzV0c2eDBENlVsXPX0mX+M2k5vkZCh7IAUhp2m9MSenTjzMJp52H3lJDpDmSP
         cixQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709210766; x=1709815566;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Clp72FczazQSKbLIcT40/U9haor6HXf5C1kMTuaxg/s=;
        b=TCEq0Ip+mhnj+EBXy3QCPvdFyya8yjr/wqM+eKcFK3btrxUQkQH3KwxBNdNgFbYXv6
         r8OLrBDAKtde8JmJtiYrEGCsPA8Af+p2a4U2u848E23b7EVTNkecjNSFgVMBG0EFMfgi
         WAnZfd6akOryGjQB3CZS67NVBY14KOFmF3P7Z6mDmHade3dnUbrEhgaqtasbnVmEoxew
         boOFpOxGNeBSe8z9lOEG1B2lmWUzaROPCbuVrCSk+N08tMGXRHuqPhayyQnGY3T/fV54
         dfR73efhuFpWgCnf1I/oINNdf9wD1a+OX1uzcKBGzti0sHB3t1Nz2k6oX8CnakhSECMj
         FLOA==
X-Forwarded-Encrypted: i=1; AJvYcCWKsZyZIFk8NXD93LwXW6d7pck1ZckfX4rjTIjPn9Ixpdqd2sT59kU/wInFQaxxV09TEjt9Exs7tnOTwg21boI0TzbLP6S2+qJIGSIg
X-Gm-Message-State: AOJu0Yz8nZuOiueSg17vge6gbEPAJ/MpgSnqgcyGOU70Q/agM8Ul/448
	fZPxliTIK5uEIB6Cr+NJSUJEdnNLdkVIrOgJ9YV3vj3NNmmwokiwLlev9QYqIRg=
X-Google-Smtp-Source: AGHT+IEbc5TOsBDYIZbxJZluVIqRpWDGJIcTKTs2jSWq0poKpB4ruewhGMO+AuZvX14rCHkXubUxhg==
X-Received: by 2002:a17:906:71d6:b0:a44:eb5:dd4a with SMTP id i22-20020a17090671d600b00a440eb5dd4amr1240876ejk.25.1709210765889;
        Thu, 29 Feb 2024 04:46:05 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id cx10-20020a170907168a00b00a3cf9b832eesm655991ejd.40.2024.02.29.04.46.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Feb 2024 04:46:05 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.9, part two
Date: Thu, 29 Feb 2024 13:46:00 +0100
Message-Id: <20240229124600.405016-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

On top of previous pull request.

Best regards,
Krzysztof


The following changes since commit 2f542c937c48c2bd5a8ddf180b417fbe7152559f:

  dt-bindings: memory-controllers: narrow regex for unit address to hex numbers (2024-01-25 12:04:09 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.9-2

for you to fetch changes up to e46076906722ee6f9e7fd5abad7f909cd11a26af:

  memory: stm32-fmc2-ebi: keep power domain on (2024-02-27 10:18:04 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.9, part two

1. Renesas RPC-IF: add bindings for R-Car V4M.
2. Tegra MC: correct and extend support for Tegra234 memory controller.
3. STM32: add support for Flexible Memory Controller on MP25 SoC.
4. NXP WEIM bindings: convert to DT schema.

----------------------------------------------------------------
Christophe Kerello (5):
      dt-bindings: memory-controller: st,stm32: add MP25 support
      memory: stm32-fmc2-ebi: check regmap_read return value
      memory: stm32-fmc2-ebi: add MP25 support
      memory: stm32-fmc2-ebi: add MP25 RIF support
      memory: stm32-fmc2-ebi: keep power domain on

Geert Uytterhoeven (1):
      dt-bindings: memory: renesas,rpc-if: Document R-Car V4M support

Jon Hunter (3):
      memory: tegra: Correct DLA client names
      memory: tegra: Add BPMP and ICC info for DLA clients
      memory: tegra: Fix indentation

Sebastian Reichel (1):
      dt-bindings: bus: imx-weim: convert to YAML

 Documentation/devicetree/bindings/bus/imx-weim.txt | 117 ----
 .../fsl/fsl,imx-weim-peripherals.yaml              |  31 +
 .../memory-controllers/fsl/fsl,imx-weim.yaml       | 204 ++++++
 .../memory-controllers/mc-peripheral-props.yaml    |   1 +
 .../memory-controllers/renesas,rpc-if.yaml         |   1 +
 .../memory-controllers/st,stm32-fmc2-ebi.yaml      |   7 +-
 drivers/memory/stm32-fmc2-ebi.c                    | 729 +++++++++++++++++++--
 drivers/memory/tegra/tegra234.c                    |  48 +-
 .../bindings/fieldbus/arcx,anybus-controller.txt   |   2 +-
 9 files changed, 963 insertions(+), 177 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/bus/imx-weim.txt
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim-peripherals.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/fsl/fsl,imx-weim.yaml

