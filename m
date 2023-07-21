Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6840F75C83A
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:50:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230319AbjGUNuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjGUNuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:50:17 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48959273E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:14 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fb4146e8deso17810205e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 06:50:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1689947413; x=1690552213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jzDN3rUK7N/Nj7i2zhkTUZdxm+FjSAWAWWXiJ9jyKGM=;
        b=t0IebwfVFX4TVylqwkakMpBgBQh87vfKWrGUNUOGzIH2q68bgsJqzbgWODqFiL5QC/
         GXytADzQh9cplYCNSC9D5prSf/1AEcCeatSWoiyF6fknD0eumdfEUHRT+hzeG+AdzV/f
         5xQfu/G5kZGC25X5FnDvQsmDrXCjscvOBE0x7rAMq2ACs1wETCZcnTsGCipAqDD/9FPw
         729xvuAyF72IckCzZP7K3eoIw9VYgDr1fJ8GB+Xs6xvAd8gCrwC7RPJG9M+dggiT+GRE
         PF2smvKCVgnflYNGw2XkTflHg1wuq2EH5oYSHjucXpwjJnM6KdCk/TKcKlTrjN0DSTf5
         HuTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689947413; x=1690552213;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jzDN3rUK7N/Nj7i2zhkTUZdxm+FjSAWAWWXiJ9jyKGM=;
        b=i2nSF/KsKim2YYOi2yZ5DIbMsT4i7syoyBryc8aahtBMUEBfDWEyhpWLMk1844ESwp
         d5a5Qud+9hAhL5Ezxfg3lj+7oukykrJSgJEbtFL8Q3VkH8nHdJqtlKiZ2Xl0tX2WHlfr
         WpYy6lJsuo9cjAhZu7NLufinRQML+sCq9I0huvR9Dw5bvZuJVbPNoptPSVapgQ4LHnaW
         TqC7MTloA6wsU4tbUrxKFQZ8G1D2xJUPpMPvjSfb+njxkfStsUKzp8JonnptSSrt1p3W
         C2/FvPpk+GAAzrXfV7KfyRr93MVsF5yf8XXs7Dc+JdpIKBb0B3EY5afMnoYZHwyqQabn
         JmJg==
X-Gm-Message-State: ABy/qLaIkXPdsMAfT2mAFIT18uuUj1jKa++pW0chjcfHSGnsEzmvXWOq
        pwJrjMzVkTOz6oN7gtpcaDOyMQ==
X-Google-Smtp-Source: APBJJlEIRmsAY46OfrfXA0DVxMEDacjRJS458pI9GfBHW1DQAPi+8ykOPdPJDZ9Z1VWRe3AYrj7QiQ==
X-Received: by 2002:a1c:f313:0:b0:3fc:855:db42 with SMTP id q19-20020a1cf313000000b003fc0855db42mr1573194wmq.34.1689947412657;
        Fri, 21 Jul 2023 06:50:12 -0700 (PDT)
Received: from blmsp.fritz.box ([2001:4091:a247:82fa:b762:4f68:e1ed:5041])
        by smtp.gmail.com with ESMTPSA id c14-20020adfed8e000000b00313e4d02be8sm4233980wro.55.2023.07.21.06.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Jul 2023 06:50:12 -0700 (PDT)
From:   Markus Schneider-Pargmann <msp@baylibre.com>
To:     Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>,
        Michal Kubiak <michal.kubiak@intel.com>,
        Vivek Yadav <vivek.2311@samsung.com>,
        linux-can@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Simon Horman <simon.horman@corigine.com>,
        Markus Schneider-Pargmann <msp@baylibre.com>
Subject: [PATCH v3 0/6] can: tcan4x5x: Introduce tcan4552/4553
Date:   Fri, 21 Jul 2023 15:50:03 +0200
Message-Id: <20230721135009.1120562-1-msp@baylibre.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi everyone,

This series introduces two new chips tcan-4552 and tcan-4553. The
generic driver works in general but needs a few small changes. These are
caused by the removal of wake and state pins.

v3 removes the check of the devicetree compatible and completely relies
on the ID2 register.

Based on v6.5-rc1.

Best,
Markus

Changes in v3:
- Rebased to v6.5-rc1
- Removed devicetree compatible check in tcan driver. The device version
  is now unconditionally detected using the ID2 register

Changes in v2:
- Update the binding documentation to specify tcan4552 and tcan4553 with
  the tcan4x5x as fallback
- Update the driver to use auto detection as well. If compatible differs
  from the ID2 register, use the ID2 register and print a warning.
- Small style changes

Previous versions:
v2 - https://lore.kernel.org/lkml/20230621093103.3134655-1-msp@baylibre.com/
v1 - https://lore.kernel.org/lkml/20230314151201.2317134-1-msp@baylibre.com

Markus Schneider-Pargmann (6):
  dt-bindings: can: tcan4x5x: Add tcan4552 and tcan4553 variants
  can: tcan4x5x: Remove reserved register 0x814 from writable table
  can: tcan4x5x: Check size of mram configuration
  can: tcan4x5x: Rename ID registers to match datasheet
  can: tcan4x5x: Add support for tcan4552/4553
  can: tcan4x5x: Add error messages in probe

 .../devicetree/bindings/net/can/tcan4x5x.txt  |  11 +-
 drivers/net/can/m_can/m_can.c                 |  16 ++
 drivers/net/can/m_can/m_can.h                 |   1 +
 drivers/net/can/m_can/tcan4x5x-core.c         | 139 +++++++++++++++---
 drivers/net/can/m_can/tcan4x5x-regmap.c       |   1 -
 5 files changed, 142 insertions(+), 26 deletions(-)


base-commit: 06c2afb862f9da8dc5efa4b6076a0e48c3fbaaa5
-- 
2.40.1

