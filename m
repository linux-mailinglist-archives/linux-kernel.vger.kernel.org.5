Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0F379BB79
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:13:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348256AbjIKVZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236295AbjIKKLs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:11:48 -0400
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91669E68;
        Mon, 11 Sep 2023 03:11:42 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 3E3D4100004;
        Mon, 11 Sep 2023 13:11:38 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 3E3D4100004
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1694427098;
        bh=CUCA25pe+EJ7rjxGI1Dne/+MwMfzDg+e7/fpUBa8JFE=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=bgwj6E3VB+Nmeo/oywFsvAj9hVK0PiszDXwQ8xCHld0b03OWEVfXy9rZR3uzEn1sO
         vZol+Ujk9Tb5/HY9s1dOHaAKLo2+Eje6K/fg7PtOq3jOr8sOdfO1B5M0Br0OseBb/y
         P5ndPouLdIe2mBiPCoYuQ069zec02AjvVe2jYMoOXQLhw2uSy+3MWtFa+omzUwe5Te
         czqTssX/yWWLnCbhJVB8w37ZCxJs/gwlSlVfrKggRXJbYr75ZrwWHeDToKrpE4Gq0U
         fEHN+3OtblOE8MLD40f3m+4I/L1GnTYWNqY9WbeEZLJGWXPt5w1z5Y118qLE22fS3s
         YCDTd1cBVpn8g==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 11 Sep 2023 13:11:37 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 11 Sep 2023 13:11:36 +0300
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
Subject: [PATCH v3 0/3]  Meson S4 HW RNG Support
Date:   Mon, 11 Sep 2023 13:11:26 +0300
Message-ID: <20230911101129.10604-1-avromanov@salutedevices.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 179765 [Sep 11 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: avromanov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 530 530 ecb1547b3f72d1df4c71c0b60e67ba6b4aea5432, {Tracking_from_domain_doesnt_match_to}, 127.0.0.199:7.1.2;p-i-exch-sc-m01.sberdevices.ru:7.1.1,5.0.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;salutedevices.com:7.1.1;100.64.160.123:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/09/11 06:02:00 #21866861
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

