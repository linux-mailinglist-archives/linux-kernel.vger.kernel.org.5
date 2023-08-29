Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1E6378CD9A
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 22:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239134AbjH2Uic (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 16:38:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238922AbjH2UiQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 16:38:16 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CF41BC;
        Tue, 29 Aug 2023 13:38:12 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-986d8332f50so629312066b.0;
        Tue, 29 Aug 2023 13:38:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693341490; x=1693946290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oVkOEcU4wbyK+9rXUwhm3LMU7ZPhuze+DSTWENcgNPo=;
        b=eXiLIeHHCa1e2s+JnIV9LAZxuGz1PPiNKxLyBDwK8kjxR6R3TPvraVB96lexb+fHWK
         /9jMLt/gBENmEXxlxK6VBL5QS2C9kHbH/qdvLRRcvdat7KaOFIRFOxJa/6BQzEEz1A9j
         3d2z3jD8agdRT+wIYx0q4MTw8zo6+74DZw09yXp89wgmKTLnbEWneYofJRwr3C3o44go
         RgMHXvy3zzVlKvpIpOx9Bc2ERjcq7nSLrT6NkVi3DQGS0ozIMlvCt6063ZT6r9gskwQ5
         bBLiQbTH/OGKFgZPNVwPA5mEiQAFOx4IFLd6J4MnDkks03TPYsPcyGO7MedzuhaGHm4r
         T13g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693341490; x=1693946290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oVkOEcU4wbyK+9rXUwhm3LMU7ZPhuze+DSTWENcgNPo=;
        b=h38f1CYGToRN/vpX4ZzIWo9H2ot+1gc1boZt+jheEMVWJJojAbFOjoDGZYqkgE5lLB
         5sUKLy7i0q9RLKv/misDQMAmo7737fGt+zjKk76Sq5AGG1AJ2V3GgsWDD9dx+uKn0X+I
         dYbJhMvVw9ufDii4ZMetA4SojhVTc1fX8MobrZaxVsnfUQMRiGl8K0A6/+n/d/xTvlR1
         AyPX720UZsu38Flk/OWqcj7/zbNVEf0icvUbJZmdJUhCiORnOCxVoev0OtRshmy8T+HV
         76JW7y3Ryon0kpCdlto0yFrK1wI/jQeaAD5guOMhUpZd8T23zrHxSDU+cNruZTsY/EcP
         X0uQ==
X-Gm-Message-State: AOJu0YyAAnHqhMrHpIvljvmqKJvNUFZG1jqoryPcMA24CxZguol9iHm+
        o2neqTMDeBsOlkHXGrbsyI2EcTqwrg==
X-Google-Smtp-Source: AGHT+IFO8hRNcI4fJYBv18ZFabbI1YyvvyoSX9D8CPWeMLUDsb9S8/5U6mBuEQTCuTC1nQOeKO72hw==
X-Received: by 2002:a17:906:31c6:b0:9a1:f81f:d0d5 with SMTP id f6-20020a17090631c600b009a1f81fd0d5mr90992ejf.54.1693341490456;
        Tue, 29 Aug 2023 13:38:10 -0700 (PDT)
Received: from U4.lan ([2001:9e8:b958:3410:8e0c:ed68:cd6c:7cb8])
        by smtp.gmail.com with ESMTPSA id f18-20020a170906825200b0099364d9f0e9sm6301908ejx.102.2023.08.29.13.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Aug 2023 13:38:10 -0700 (PDT)
From:   Alex Bee <knaerzche@gmail.com>
To:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Johan Jonker <jbx6244@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        Alex Bee <knaerzche@gmail.com>
Subject: [PATCH v2 0/6] Device tree fixes for RK3128
Date:   Tue, 29 Aug 2023 22:37:19 +0200
Message-ID: <20230829203721.281455-4-knaerzche@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series contains several device tree fixes which currently prevent
the hardware from actually working.
Please see commit messages of the individual patches for details.

These patches have been part of the pretty huge RK3128 fix-up series [0]
which I've splitted up now, as suggested.

[0] https://lore.kernel.org/linux-rockchip/20230829171647.187787-1-knaerzche@gmail.com

Alex Bee (5):
  ARM: dts: rockchip: Fix i2c0 register address for RK3128
  ARM: dts: rockchip: Add missing arm timer interrupt for RK3128
  ARM: dts: rockchip: Add missing quirk for RK3128's dma engine
  ARM: dts: rockchip: Fix timer clocks for RK3128
  ARM: dts: rockchip: Disable non-required timers for RK3128

 arch/arm/boot/dts/rockchip/rk3128.dtsi | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)


base-commit: 2dde18cd1d8fac735875f2e4987f11817cc0bc2c
-- 
2.42.0

