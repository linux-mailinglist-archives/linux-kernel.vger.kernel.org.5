Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DB5781D6E
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Aug 2023 12:27:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230320AbjHTK1g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 06:27:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbjHTK1R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 06:27:17 -0400
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E150F1B7;
        Sun, 20 Aug 2023 03:23:53 -0700 (PDT)
Received: by mail-lj1-x22e.google.com with SMTP id 38308e7fff4ca-2bcb0b973a5so11382831fa.3;
        Sun, 20 Aug 2023 03:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692527032; x=1693131832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=vO5XHeXhzQE0Sh+zPC3nv+/IcKxXaRwyJd1RR4VSqDU=;
        b=HRg0mywW0Qr/yhqsEJKvsNa6aoZO3jkQhKxAKgnbEW4xaTaDVcgptEfzUM2I/IaAM4
         KMH8RQzwMv677NnzK0m8aOt+v3domrNSU9kYEiK5aSKHzOrpIJD0FnE75nFOJsEibVeb
         b+jXS7OIZxpPfsUyRii7TlDm1wVPl+bokwfSUw3wQM0rVWVzfscwDuAoFoCTBnGE8ttB
         tN/4LLHXK6/FknhzijNQWYYpvPed8UCnCGeIbuwxKdAwtWNYcownZyBFxF1A41oZP+ZN
         AaQ1MFtGU0yfJBoVgOzfSs/SSrGXgm4jg2yR4ny6t3mYmNXPmYUsc0DdV1jfibHvauBO
         OqTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692527032; x=1693131832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=vO5XHeXhzQE0Sh+zPC3nv+/IcKxXaRwyJd1RR4VSqDU=;
        b=LdFPVMgl8HYs4RN4Txkjsnl8lpv1b4RpB2QoFsw/DrE9Kk67sST7HHVUxY32gPSRpm
         DmNsp3Cmmo5eyG1KQ7dt/XhcMA7c1KSlUQcp0WM+ZSvKxRfmtSjyRdcGj1olqx4PdO87
         zvjkoGzRdys9B/JmWTp2t/gjazclwkQBAluhRU16iMoOPAobFo/+bp1/W1gZiuGL6wuv
         /ek0oX1TSWjtEEMbAshlKFR/N4WbRTCOn1tGsEf15XYHNHJtpxJFoeYCHFaev5UcmrdO
         BX7I1bBneerM2YCO39hsWFiMkYj0kbCaoqRLVCrUWjJYdInUr4EF+qk/Zcw3U+kQXNzW
         gjsA==
X-Gm-Message-State: AOJu0YzVoRd0Ulqm0/DpkPG292tIyX41tsK92ZLh3yhUMfsa31XoTKdS
        Gqo0Fb/FSn9c+KY5G8KITJKNXMEyWQ00Hmsh
X-Google-Smtp-Source: AGHT+IFWYttXw8KF81nqKwkZxTpjsEBW4VDFq2d+b8WY19pM1FYPn2MfKFP+I0ZEfvl3fx9Uc59Oig==
X-Received: by 2002:a05:6512:398e:b0:4fb:8bcd:acd4 with SMTP id j14-20020a056512398e00b004fb8bcdacd4mr2848357lfu.37.1692527031814;
        Sun, 20 Aug 2023 03:23:51 -0700 (PDT)
Received: from localhost.localdomain (83-233-6-197.cust.bredband2.com. [83.233.6.197])
        by smtp.gmail.com with ESMTPSA id x2-20020ac25dc2000000b004ff9d22e486sm1193787lfq.226.2023.08.20.03.23.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Aug 2023 03:23:50 -0700 (PDT)
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v7 0/6] Add support for the whole MCP39xx family
Date:   Sun, 20 Aug 2023 12:26:04 +0200
Message-ID: <20230820102610.755188-1-marcus.folkesson@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The main goal with this patchset is to add support for all similiar
MCP39xx ADC chips.
During all patch iterations we ended up with a few cleanup patches.

See version notes in each patch.

Marcus Folkesson (6):
  dt-bindings: iio: adc: mcp3911: add support for the whole MCP39xx
    family
  iio: adc: mcp3911: make use of dev_err_probe()
  iio: adc: mcp3911: simplify usage of spi->dev
  iio: adc: mcp3911: fix indentation
  iio: adc: mcp3911: avoid ambiguity parameters in macros
  iio: adc: mcp3911: add support for the whole MCP39xx family

 .../bindings/iio/adc/microchip,mcp3911.yaml   |   6 +
 drivers/iio/adc/Kconfig                       |   6 +-
 drivers/iio/adc/mcp3911.c                     | 564 ++++++++++++++----
 3 files changed, 464 insertions(+), 112 deletions(-)


base-commit: b320441c04c9bea76cbee1196ae55c20288fd7a6
-- 
2.41.0

