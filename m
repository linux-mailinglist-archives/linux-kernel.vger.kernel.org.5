Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FE8F810A1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 07:15:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378541AbjLMGPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 01:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233240AbjLMGPV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 01:15:21 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C822E8
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:15:27 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-54cdef4c913so15041184a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 22:15:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702448125; x=1703052925; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oFLJyY/AoSsrATUYN2/LL/H3Uqh2viH08QvQNsb6evo=;
        b=OnMrUZb3eCIyVTCFXN/FgDGSk7jhYGMxqMikj37fvg2wHjCqMAZBfcKwxjuDJpHPrM
         ZKDwrR8uO3Pjy/TT4OQhto9H0uEH+gpUJXzAieVxhKHM9v4HRjUG5bCcDi36h8WiyKd6
         U8GC3qvo2mOaHyLm4UoBjmUGnrnWvRRyo/HWY1yM0CSrpxRqHBP7ZsHfuxlPBVCg3OiO
         VQR2AHjGHYqXV6XAYtmbVktoa6VhZ40g38U/yiuzC/17c3kkNN1gpC8eiMOBWmQtvgc/
         hJfzTDcJXfK5g2KsZhDdnv1gPg7XSJcJZVbrarZbZllk0uzDIv5fCW+UmdcsH/bw/plM
         2Vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702448125; x=1703052925;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oFLJyY/AoSsrATUYN2/LL/H3Uqh2viH08QvQNsb6evo=;
        b=gBH7IQxkIvxHDMCgvJPtBL+KbY7sPJiBVcNSmoF17TD1kwxLw+5SasI0U4Jl9WMEZy
         FNmsJHGQv8W620NrImSX9qKL6plt2SxiggNJO5TXdIYFBKCWjzDQPsmrp5/PucG6lzhk
         mqHWOQKU7lZFwd22xQZiL4MPf4MmqcFG0x178TS9jrXP97I0DcGkKfBhtoKMvpJwHHtX
         r7yxdGlX4IZad1s6FtE6grT6k/b9YODDln1vfbjqM4gJbR9BATCQSWT0tz13cYTT8p8e
         uunABUk3w1MQbp3Fo9BGeTTTHveIGfy8w8rs5cvIrv+xR0UPLKBIOcsH3GPCXrHVXO1Y
         XEZw==
X-Gm-Message-State: AOJu0Yw4wwt2T8ZX1Jjo2iSgml80/BQomzSrUPaugMDK+9pOKhunUYZU
        ek6SqQf7OGt0U0b6ty8sGDjqBw==
X-Google-Smtp-Source: AGHT+IHGwghhhqakImxuubxRqXzBGnSektPNowNWBqz9BZDJDu/14/SoeddJwpQ2DwkxYnh76dAJMQ==
X-Received: by 2002:a17:906:51de:b0:9f2:859f:713e with SMTP id v30-20020a17090651de00b009f2859f713emr8317782ejk.3.1702448125555;
        Tue, 12 Dec 2023 22:15:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id tx27-20020a1709078e9b00b00a1c85124b08sm7303185ejc.94.2023.12.12.22.15.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 22:15:25 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] memory: drivers for v6.8
Date:   Wed, 13 Dec 2023 07:15:23 +0100
Message-Id: <20231213061523.4803-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-mem-ctrl.git tags/memory-controller-drv-6.8

for you to fetch changes up to 4a23d0f9814c38308dc82b6dbc466666a400b27d:

  memory: tegra: Protect SID override call under CONFIG_IOMMU_API (2023-12-06 11:22:24 +0100)

----------------------------------------------------------------
Memory controller drivers for v6.8

Few improvements for Tegra Memory Controller: Override the SID
programming in the device, if firmware or bootloader left it in bypass
mode, e.g. after resuming from suspend.  Skip prorgamming the SID, if
given Memory Controller client does not support it.

----------------------------------------------------------------
Ashish Mhetre (3):
      memory: tegra: Add SID override programming for MC clients
      memory: tegra: Skip SID programming if SID registers aren't set
      memory: tegra: Protect SID override call under CONFIG_IOMMU_API

 drivers/memory/tegra/tegra186.c | 19 +++++++++++++++++++
 include/soc/tegra/mc.h          |  1 +
 2 files changed, 20 insertions(+)
