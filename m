Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40C457CA0DF
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 09:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231926AbjJPHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 03:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231902AbjJPHkY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 03:40:24 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98C06FF
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:40:17 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-406609df1a6so40823505e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 00:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697442016; x=1698046816; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EAtJw5I02+M4NX4Wxm2A7PUjyX02pVvIFRZ++HnPuHM=;
        b=MtQnb3xjvnOKBMQrrbCu9ZfgSt3sTE/h03IctPsPLVg85qcztzQuU8b/3Kc5F+VDxo
         PIx9hAt4cznqBKkf3iKQIraB9puUWe3BvFg72rLMSb4pAdTix1wS+lutIuKJ8q3GdCpN
         LezeOD6Bj7lx4ezFsQ2JWixLS9VaevuMouro3Vf6avdi2v4zDc1sP+accuctEYf9mBi5
         S8h515bnoFoRqFxvYxwKopyqv0g0utLcaleZBSCrD/HbiRHJdSZbHWYIOdcesRvCUq8v
         qMmTuLgnV3QnTbtGtTx9GkCgTYgJX1PKaNuIp6Jqx0bXbxUvXWS4NnJ/BFVNTfjs0mM3
         FkgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697442016; x=1698046816;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EAtJw5I02+M4NX4Wxm2A7PUjyX02pVvIFRZ++HnPuHM=;
        b=PWbUIjuE8kmrTG408m9Rk7SGjDGAe1JhQVmGkg/pE7jNkW5iei9HYD30obSy48Ya/r
         HkyuO6yxc66sT8tLRg+ISgD74fEV1NwaWs9Tt5337lccwuVSKY8UqNHF8rEH3Sr3Dzeg
         QAR5QdJlZwwX0ggNHvYY9mwLofjbF61AXmTUgZTWalIranJ1bx8yAncn+hC8G7yKV3CS
         5DO25JZsnZ3ZYsGZ0hhcTDdOxw+HkxfM/yCzBXTFhoKvZQipBA/Uytn8Ym3rU6a3B7fR
         guMi4vM4bNfZgNylMYO2J+XVmr7JGfJVDuVov4bmexFfNwsxBFSORbepC9P8ybx1m0qY
         WBoQ==
X-Gm-Message-State: AOJu0YwgpkmGB/Lz07Ue9t8HhcUMu7Eq4D0ubhznDCPwRkAG5DnKHww1
        e5fD2IDvghpUJoY0COps/oElOnNoO67Ossyd1TY=
X-Google-Smtp-Source: AGHT+IHpFlcoknVg3TkhbIQBqUPuHHzpTaEMITFzmQqb0w6qOmHpi3Gw53k/Qc2Qree41QStkY28KA==
X-Received: by 2002:a7b:c4cb:0:b0:401:cb45:3fb8 with SMTP id g11-20020a7bc4cb000000b00401cb453fb8mr29200023wmk.38.1697442015670;
        Mon, 16 Oct 2023 00:40:15 -0700 (PDT)
Received: from krzk-bin.. ([178.197.219.154])
        by smtp.gmail.com with ESMTPSA id g18-20020a05600c4ed200b003fe1fe56202sm6488442wmq.33.2023.10.16.00.40.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 00:40:15 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.7
Date:   Mon, 16 Oct 2023 09:40:13 +0200
Message-Id: <20231016074013.28286-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.7

for you to fetch changes up to 09de3691daab15ae125cbf32f9f72fc90eada49d:

  memory: Use device_get_match_data() (2023-10-12 15:42:16 +0200)

----------------------------------------------------------------
Memory controller drivers for v6.7

1. Atmel: Use __counted_by annotation.
2. Tegra: Add Tegra234 clients for RCE and VI.
3. Cleanup:
 - Use device_get_match_data() to simplify the code,
 - Make "additionalProperties: true" explicit in Devicetree bindings.

----------------------------------------------------------------
Jon Hunter (1):
      memory: tegra: Add Tegra234 clients for RCE and VI

Kees Cook (1):
      memory: atmel-ebi: Annotate struct atmel_ebi_dev with __counted_by

Rob Herring (2):
      dt-bindings: memory-controllers: Make "additionalProperties: true" explicit
      memory: Use device_get_match_data()

 .../bindings/memory-controllers/ingenic,nemc.yaml  |  1 +
 .../memory-controllers/renesas,rpc-if.yaml         |  2 +
 .../bindings/memory-controllers/ti,gpmc.yaml       |  2 +-
 drivers/memory/atmel-ebi.c                         | 16 +++---
 drivers/memory/brcmstb_memc.c                      |  9 ++--
 drivers/memory/fsl-corenet-cf.c                    | 11 +---
 drivers/memory/tegra/tegra234.c                    | 60 ++++++++++++++++++++++
 7 files changed, 77 insertions(+), 24 deletions(-)
