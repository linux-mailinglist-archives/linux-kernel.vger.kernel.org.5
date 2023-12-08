Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA25780AA0B
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 18:08:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbjLHRIC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 12:08:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233735AbjLHRIA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 12:08:00 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E2D710F8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 09:08:06 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DF3C433C8;
        Fri,  8 Dec 2023 17:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702055286;
        bh=L5ejtIWY2RbVcSXfTpmFdQcek5I6KvvEbrzWnLb3alk=;
        h=From:To:Cc:Subject:Date:From;
        b=Hd2pQG/brFeY0MUHlYGM1FA/ACwdZ/PKIvT+WUz0y/GwxcHFCcBSdORH7AFMk4J4Y
         8gya+/+u5Xo3nvNnn40z6avHkPojQ6P0N2bwg5UqUqlyhykXWG7kw6fkgkWzsvMjtb
         HCXsf8smx6RKwc62OCVNPWS7S9SeXA2gxjc9GriczeGD3ApV+r1mROSUxhbJt7lDjE
         Kxg9m5qgMeNAJnynzyeJFbHatdQwwUdnLatPsUNQB9jpBbAHRcmxg0GcMInl8vmweo
         BOu70JcQxbs3gMJWAD2Y7iS2DHrMFdH4rvNuYdOtRGWrgQfEHBV3H6HwkEAvM5BJ1R
         2T+4NSBIxfQTA==
From:   Conor Dooley <conor@kernel.org>
To:     linux-riscv@lists.infradead.org
Cc:     conor@kernel.org, Conor Dooley <conor.dooley@microchip.com>,
        Daire McNamara <daire.mcnamara@microchip.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-can@vger.kernel.org,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Subject: [PATCH v1 0/7] MPFS clock fixes required for correct CAN clock modeling
Date:   Fri,  8 Dec 2023 17:07:39 +0000
Message-Id: <20231208-sizably-repressed-16651a4b70e7@spud>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2342; i=conor.dooley@microchip.com; h=from:subject:message-id; bh=g/+RSOF+MCs/BzYXcY1ALY/xOCAYFuZb4uSD23xQNkE=; b=owGbwMvMwCFWscWwfUFT0iXG02pJDKnFvtHrtsdemV8uxdOg7zQ1vf/tqs9cd2MF91un6K8We Kz61nhLRykLgxgHg6yYIkvi7b4WqfV/XHY497yFmcPKBDKEgYtTACaSas3IcLoxYObBk32GPQkX fRf1bqjc/mTNh5AFCWt4FrC9XK3TupiRocPw1fWLF80f/Vpa0K1X9CUxMMnvBcdM2aTLj+WDD2m u5AYA
X-Developer-Key: i=conor.dooley@microchip.com; a=openpgp; fpr=F9ECA03CF54F12CD01F1655722E2C55B37CF380C
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Conor Dooley <conor.dooley@microchip.com>

While reviewing a CAN clock driver internally for MPFS [1], I realised
that the modeling of the MSSPLL such that one one of its outputs could
be used was not correct. The CAN controllers on MPFS take 2 input
clocks - one that is the bus clock, acquired from the main MSSPLL and
a second clock for the AHB interface to the result of the SoC.
Currently the binding for the CAN controllers and the represetnation
of the MSSPLL only allows for one of these clocks.
Modify the binding and devicetree to expect two clocks and rework the
main clock controller driver for MPFS such that it is capable of
providing multiple outputs from the MSSPLL.

Cheers,
Conor.

1 - Hopefully that'll show up on the lists soon, once we are happy with
  it ourselves.

CC: Conor Dooley <conor.dooley@microchip.com>
CC: Daire McNamara <daire.mcnamara@microchip.com>
CC: Wolfgang Grandegger <wg@grandegger.com>
CC: Marc Kleine-Budde <mkl@pengutronix.de>
CC: "David S. Miller" <davem@davemloft.net>
CC: Eric Dumazet <edumazet@google.com>
CC: Jakub Kicinski <kuba@kernel.org>
CC: Paolo Abeni <pabeni@redhat.com>
CC: Rob Herring <robh+dt@kernel.org>
CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC: Paul Walmsley <paul.walmsley@sifive.com>
CC: Palmer Dabbelt <palmer@dabbelt.com>
CC: Albert Ou <aou@eecs.berkeley.edu>
CC: Michael Turquette <mturquette@baylibre.com>
CC: Stephen Boyd <sboyd@kernel.org>
CC: linux-riscv@lists.infradead.org
CC: linux-can@vger.kernel.org
CC: netdev@vger.kernel.org
CC: devicetree@vger.kernel.org
CC: linux-kernel@vger.kernel.org
CC: linux-clk@vger.kernel.org

Conor Dooley (7):
  dt-bindings: clock: mpfs: add more MSSPLL output definitions
  dt-bindings: can: mpfs: add missing required clock
  clk: microchip: mpfs: split MSSPLL in two
  clk: microchip: mpfs: setup for using other mss pll outputs
  clk: microchip: mpfs: add missing MSSPLL outputs
  clk: microchip: mpfs: convert MSSPLL outputs to clk_divider
  riscv: dts: microchip: add missing CAN bus clocks

 .../bindings/net/can/microchip,mpfs-can.yaml  |   7 +-
 arch/riscv/boot/dts/microchip/mpfs.dtsi       |   4 +-
 drivers/clk/microchip/clk-mpfs.c              | 154 ++++++++++--------
 .../dt-bindings/clock/microchip,mpfs-clock.h  |   5 +
 4 files changed, 99 insertions(+), 71 deletions(-)

-- 
2.39.2

