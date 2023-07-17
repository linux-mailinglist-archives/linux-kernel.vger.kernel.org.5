Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CB03755AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 07:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231225AbjGQFjq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 01:39:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229579AbjGQFjo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 01:39:44 -0400
Received: from mx1.sberdevices.ru (mx2.sberdevices.ru [45.89.224.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD0E79;
        Sun, 16 Jul 2023 22:39:41 -0700 (PDT)
Received: from p-infra-ksmg-sc-msk02 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id DA32312000D;
        Mon, 17 Jul 2023 08:39:37 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru DA32312000D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1689572377;
        bh=Z8/Dn1ZkY27EKr5TCwnYUezGgwbXebtLvOyJ3K4NFsg=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=ByQY3Zq4kSThKfJSlHVlkV6hnt0FIap3hmsNHvPsHN/PIkzDVJDb3JbQJiv6MRDhY
         eOPMct2DQHLc/lyAyE85SsSjYdwZGpa78bOcuEJeKoNt1fKEmdF0NN8ZPty/rDRClV
         OvPNEcRfCHlnym128grKl6hSzdVUjn/JSRm5FJr9QosulSZKQNxTsymGz8zxDSG3Eg
         qtkjVInfslY0zmW3avmJPa/3Nwi/XBWKykebsBuYnGDdrbfMHKbNZwmfEjp/r0v3jF
         X0cipj9/aUTvCEctvRYShTFsveFpDMR2DbL8/AsnGI0kOtYwo9KdveUsVk2IT7W5yQ
         LTPOydw3a6aTg==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Mon, 17 Jul 2023 08:39:37 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.30; Mon, 17 Jul 2023 08:38:43 +0300
From:   Arseniy Krasnov <AVKrasnov@sberdevices.ru>
To:     Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
CC:     <oxffffaa@gmail.com>, <kernel@sberdevices.ru>,
        Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
        <linux-mtd@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 0/2] support 512B ECC step size for Meson NAND
Date:   Mon, 17 Jul 2023 08:33:59 +0300
Message-ID: <20230717053402.1203724-1-AVKrasnov@sberdevices.ru>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 178635 [Jul 15 2023]
X-KSMG-AntiSpam-Version: 5.9.59.0
X-KSMG-AntiSpam-Envelope-From: AVKrasnov@sberdevices.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 523 523 523027ce26ed1d9067f7a52a4756a876e54db27c, {Tracking_uf_ne_domains}, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;p-i-exch-sc-m01.sberdevices.ru:5.0.1,7.1.1;lore.kernel.org:7.1.1, FromAlignment: s, {Tracking_white_helo}, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2023/07/17 03:36:00
X-KSMG-LinksScanning: Clean, bases: 2023/07/17 03:36:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/07/17 00:56:00 #21624503
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this patchset adds support for 512B ECC step size for Meson NAND. Current
implementation only supports 1024B. There are three patches:

1) Update for device tree bindings to replace 'const' type of field
   'nand-ecc-step-size' with 'enum' which contains 512 and 1024.


   ^^^ this is already merged to nand-next in v3 and removed from v4


2) Update for device tree bindings to add dependency between properties
   'nand-ecc-strength' and 'nand-ecc-step-size'.

3) Update for Meson driver - new enum value for 512B ECC and reworked
   ECC capabilities structure to support both 512B and 1024B ECC. By
   default this driver uses 1024B ECC, 512B could be enabled in device
   tree.

Changelog:
v1 -> v2:
 * Add default value of 1024 to the bindings patch (0001).
 * Remove "Acked-by: Rob Herring <robh@kernel.org>" from the bindings
   patch (0001) due to added default value.
 * Remove invalid calculation of OOB bytes, available for ECC engine
   from patch 0002. This logic is incorrect from the origins, so I don't
   touch it in this patchset. It will be fixed by another patch, as in
   fact, it doesn't affect this patchset.

v2 -> v3:
 * Add new patch which adds dependency between 'nand-ecc-strength' and
   'nand-ecc-step-size' (0002).
 * Return "Acked-by: Rob Herring <robh@kernel.org>" to 0001.
 * Remove "default" value from 0001, due to dependency patch.
 * Remove example value from 0001, due to dependency patch.

v3 -> v4:
 * 0001 is removed from patchset because it was merged to nand-next.
 * 0002 is rebased on the latest nand-next.
 * RFC tag is removed.

Links:
v1:
https://lore.kernel.org/linux-mtd/20230628092937.538683-1-AVKrasnov@sberdevices.ru/
v2:
https://lore.kernel.org/linux-mtd/20230705065434.297040-1-AVKrasnov@sberdevices.ru/
v3:
https://lore.kernel.org/linux-mtd/20230711122129.2635558-1-AVKrasnov@sberdevices.ru/

Arseniy Krasnov (2):
  dt-bindings: nand: meson: make ECC properties dependent
  mtd: rawnand: meson: support for 512B ECC step size

 .../bindings/mtd/amlogic,meson-nand.yaml      |  4 ++
 drivers/mtd/nand/raw/meson_nand.c             | 45 ++++++++++++++-----
 2 files changed, 38 insertions(+), 11 deletions(-)

-- 
2.35.0

