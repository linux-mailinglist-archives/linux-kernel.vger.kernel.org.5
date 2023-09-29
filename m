Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 835767B305F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:31:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233199AbjI2Kbe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:31:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233161AbjI2KbB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:31:01 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 713DB1988;
        Fri, 29 Sep 2023 03:29:53 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 6F78C12000E;
        Fri, 29 Sep 2023 13:29:50 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 6F78C12000E
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1695983390;
        bh=wo1Q9KwL7pQh2WKJhatHCUYgEAri4Op77oE/Q7OOAr4=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=nHq1YpiBFDQOEy65LzO2gQXyPbvjEolApe/nXTtokoyInkIg/vQKq1hX+isPpF5fr
         8MzZlnJZLQMWqmC/+a0yPfuMTJGpJLVz/6fNsfYi23UoOvFBmqH8kfdUURgRrDa7D1
         +dhSqn4Z7QO6ngT/JE3r/gU0uk7do87KX3IrdCsV3k9qx4XfkiXPbRwPDTSKUbFVHF
         tUPQUDE61853e98qovI7IyE0Tw3+nX3CmeBmjYUboKz+xaiJHVZoh9+gJvtkbYaYZh
         hp2E2slVHwCDcmB0UrKfw1Qa2Iof7Cm1XooNgznityfhNgqj2J1lQm/uIdzTtkxkBF
         QuoZF6VX4VFjA==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Fri, 29 Sep 2023 13:29:49 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Fri, 29 Sep 2023 13:29:49 +0300
From:   Alexey Romanov <avromanov@salutedevices.com>
To:     <narmstrong@baylibre.com>, <neil.armstrong@linaro.org>,
        <olivia@selenic.com>, <herbert@gondor.apana.org.au>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <conor@kernel.org>, <khilman@baylibre.com>,
        <jbrunet@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <f.fainelli@gmail.com>, <hkallweit1@gmail.com>, <lists@kaiser.cx>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-crypto@vger.kernel.org>, <kernel@sberdevices.ru>,
        Alexey Romanov <avromanov@salutedevices.com>
Subject: [PATCH v5 0/3] Meson S4 HW RNG Support
Date:   Fri, 29 Sep 2023 13:29:35 +0300
Message-ID: <20230929102942.67985-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 180231 [Sep 29 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 535 535 da804c0ea8918f802fc60e7a20ba49783d957ba2, {Tracking_from_domain_doesnt_match_to}, 100.64.160.123:7.1.2;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;salutedevices.com:7.1.1, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/09/29 07:52:00 #22006267
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch series adds hwrng support for Amlogic S4-series.
Now, S4 uses a new random number generation algorithm.
This changes implemnents new algo and also adds description
to meson-s4.dtsi.

V2:

- Use readl_relaxed_poll_timeout_atomic() function instead of loop.
- Use two different functions: meson_rng_read() and meson_s4_rng_read().
- Fix naming in DT schema (meson-s4-hwrng instead of meson-hwrng-s4).
- A little code style fixes.

V3:

- Fix commit message in patch with dt-bindings schema changes.

V4:

- Drop struct meson_rng_priv field from struct meson_rng_data.

V5:

- Rebased over v6.7/arm64-dt (Amlogic repo).

Alexey Romanov (3):
  drivers: rng: meson: add support for S4
  dt-bindings: rng: meson: add meson-rng-s4 compatible
  arch/arm64: dts: meson-s4: add hwrng node

 .../bindings/rng/amlogic,meson-rng.yaml       |  1 +
 arch/arm64/boot/dts/amlogic/meson-s4.dtsi     |  5 ++
 drivers/char/hw_random/meson-rng.c            | 80 ++++++++++++++++++-
 3 files changed, 83 insertions(+), 3 deletions(-)

-- 
2.25.1

