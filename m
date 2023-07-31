Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9E81768EF7
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 09:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbjGaHgz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 03:36:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231165AbjGaHgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 03:36:44 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E164125;
        Mon, 31 Jul 2023 00:36:43 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe1c285690so5479764e87.3;
        Mon, 31 Jul 2023 00:36:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690789001; x=1691393801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Hzdhk0ebkmUYoCBKRbfkR1Q6pt7LGGJe4r7tXcUet/c=;
        b=iJ0JqDQ2ZTYnDGgCpqod//O7osZfnEJjrci3V2uPBJtWfFZPKvuqjiC91NbBXJyMVl
         q/tfgo0fxfA/G5Rdj1xuT5MaPIXBYLR/WIuYLQQlQN3Jz4WOagSn/vWncm6jOsge6fVc
         php93bVT/QUqXoFGMRePafILv6slXWUVnEztCdx+HBm709w8+Fq9IzrCUun7/N2JFnZQ
         wo6yXZhAJxRzfAGma2wpk3NMq0GES8wj7u6zXfaau3fi3V0/Fz4+oRQVVr/lIJIAUXX/
         G7Dh6V+EncRp+g10/GVbWCBkA+m3XhVME5KGKW06+2GTdk+VMxrY9iIdf60ZzKySauJw
         8m6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690789001; x=1691393801;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Hzdhk0ebkmUYoCBKRbfkR1Q6pt7LGGJe4r7tXcUet/c=;
        b=ZRiM0/bA4dxnqei0tIN1UXpVBkpruPOZKebjMpPTZG+8ozjHuigY7b0FiDQ3l8EsIk
         esoCykZexMdJnKjIefImEL+hkUhhNEuIjRmleGFH6wtEXh+LuiZsGCjAX8ru/wB+2HCv
         j7xvJDjzxi7BHJlyPyHFfU7GcHDQV5AU523+2CQT0ksvKqSknq5ZoYRF7X4z8h9D1S9p
         rbfoyqfwtjubz+AfMqgakf14Dnool38g7da5waAwP5JNm8+Fw1HlhFLvdQlFqhtjQg6d
         wNFAhLiXTbSMqP5W3jKcPgD5F5im+65rtT4Xt54g9krP45XA8IgtLLyojRInsprXBF8N
         H3Yw==
X-Gm-Message-State: ABy/qLZ0YVC3M4J33MDAItMV7NSfzy2fcKDjtfuxjs7+lxAd2ACBBtCg
        m8Cy4AUR+qYQCprTmpcbano=
X-Google-Smtp-Source: APBJJlFY4kV6I1U+VYb6F6yeQbs+NqG/JlgJR0lPQ2BxzdrB+XmwhyTU9KMCEq1jauG5DKPopxvjFw==
X-Received: by 2002:a05:6512:3b13:b0:4fb:cab9:ddf with SMTP id f19-20020a0565123b1300b004fbcab90ddfmr7209989lfv.57.1690789001106;
        Mon, 31 Jul 2023 00:36:41 -0700 (PDT)
Received: from xeon.. ([188.163.112.48])
        by smtp.gmail.com with ESMTPSA id m14-20020a056512014e00b004fe3229e584sm586898lfo.270.2023.07.31.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 00:36:40 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Iskren Chernev <me@iskren.info>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Matheus Castello <matheus@castello.eng.br>,
        Sebastian Reichel <sre@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Claudiu Beznea <claudiu.beznea@microchip.com>,
        Stefan Hansson <newbie13xd@gmail.com>
Cc:     linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Subject: [PATCH v3 0/4] Add optional properties to MAX17040
Date:   Mon, 31 Jul 2023 10:36:09 +0300
Message-Id: <20230731073613.10394-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extend properties supported by max17040 fuel gauge if it is accompanied
by different devices.

If max17040 is coupled with a charger, pass charger status since it should
match and max17040 has no dedicated status detection ability.

max17040_get_online can be reused for PRESENT property since if it is
online it must be present.

Finally, max17040 may be coupled with a dedicated thermal sensor which
monitors battery temperature so lets add support for iio channel to match
hw setup. With that said, the driver got dependency on CONFIG_IIO which
was added to Kconfig. All defconfigs apart s5pv210_defconfig have IIO
already enabled so only s5pv210_defconfig needed adjustment.

---
Changes from v2:
- documentation: fixed typo i2c0 > i2c
- added dependency on CONFIG_IIO
- enabled CONFIG_IIO for s5pv210_defconfig to avoid regressions (all other
  defconfigs which include max17040 already have IIO enabled)

Changes from v1:
- documentation: dropped monitored-battery and power-supplies (inherited
  from inclusion)
- dropped passing charger health as battery health
- dropped patch for simple battery cell support
- switched iio_read_channel_raw to iio_read_channel_processed_scale
- switched iio_channel_get to devm_iio_channel_get
- re-organized implementation of temp channel (implemented in way 
  *_get_optional functions usually act)
---

Svyatoslav Ryhel (4):
  dt-bindings: power: supply: maxim,max17040: update properties
  power: max17040: pass status property from supplier
  power: max17040: get thermal data from adc if available
  ARM: configs: s5pv210_defconfig: enable IIO required by MAX17040

 .../bindings/power/supply/maxim,max17040.yaml | 31 +++++++++++++++++++
 arch/arm/configs/s5pv210_defconfig            |  1 +
 drivers/power/supply/Kconfig                  |  2 +-
 drivers/power/supply/max17040_battery.c       | 27 ++++++++++++++++
 4 files changed, 60 insertions(+), 1 deletion(-)

-- 
2.39.2

