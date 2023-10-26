Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4AB7D7BFE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 07:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233132AbjJZFLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 01:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJZFLV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 01:11:21 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3A9093
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 22:11:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ore@pengutronix.de>)
        id 1qvsdx-0004Y7-VD; Thu, 26 Oct 2023 07:10:53 +0200
Received: from [2a0a:edc0:0:1101:1d::ac] (helo=dude04.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ore@pengutronix.de>)
        id 1qvsdw-004L1P-KV; Thu, 26 Oct 2023 07:10:52 +0200
Received: from ore by dude04.red.stw.pengutronix.de with local (Exim 4.96)
        (envelope-from <ore@pengutronix.de>)
        id 1qvsdw-009ikT-1p;
        Thu, 26 Oct 2023 07:10:52 +0200
From:   Oleksij Rempel <o.rempel@pengutronix.de>
To:     "David S. Miller" <davem@davemloft.net>,
        Andrew Lunn <andrew@lunn.ch>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Oleksij Rempel <o.rempel@pengutronix.de>, kernel@pengutronix.de,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        UNGLinuxDriver@microchip.com,
        "Russell King (Oracle)" <linux@armlinux.org.uk>,
        devicetree@vger.kernel.org
Subject: [PATCH net-next v8 0/5] net: dsa: microchip: provide Wake on LAN support (part 2)
Date:   Thu, 26 Oct 2023 07:10:46 +0200
Message-Id: <20231026051051.2316937-1-o.rempel@pengutronix.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ore@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series introduces extensive Wake on LAN (WoL) support for the
Microchip KSZ9477 family of switches, coupled with some code refactoring
and error handling enhancements. The principal aim is to enable and
manage Wake on Magic Packet and other PHY event triggers for waking up
the system, whilst ensuring that the switch isn't reset during a
shutdown if WoL is active.

The Wake on LAN functionality is optional and is particularly beneficial
if the PME pins are connected to the SoC as a wake source or to a PMIC
that can enable or wake the SoC.

changes v8:
- rebase on top of net-next and s/slave/user/

changes v7:
- move wakeup-source after reset-gpios
- update "Wake event on port.." debug message
- add and use ksz_is_port_mac_global_usable() instead of
  ksz_switch_macaddr_get/put.

changes v6:
- add variables magic_switched_off and magic_switched_on for readability
- EXPORT_SYMBOL(ksz_switch_shutdown); to fix build as module 

changes v5:
- rework Wake on Magic Packet support.
- Make sure we show more or less realistic information on get_wol by
  comparing refcounted mac address against the ports address
- fix mac address refcounting on set_wol()
- rework shutdown sequence by to handle PMIC related issues. Make sure
  PME pin is net frequently toggled.
- use wakeup_source variable instead of reading PME pin register.

changes v4:
- add ksz_switch_shutdown() and do not skip dsa_switch_shutdown() and
  etc.
- try to configure MAC address on WAKE_MAGIC. If not possible, prevent
  WAKE_MAGIC configuration
- use ksz_switch_macaddr_get() for WAKE_MAGIC.
- prevent ksz_port_set_mac_address if WAKE_MAGIC is active
- do some more refactoring and patch reordering

changes v3:
- use ethernet address of DSA master instead from devicetree
- use dev_ops->wol* instead of list of supported switch
- don't shutdown the switch if WoL is enabled
- rework on top of latest HSR changes

changes v2:
- rebase against latest next

Oleksij Rempel (5):
  net: dsa: microchip: ksz9477: Add Wake on Magic Packet support
  net: dsa: microchip: Refactor comment for ksz_switch_macaddr_get()
    function
  net: dsa: microchip: Add error handling for ksz_switch_macaddr_get()
  net: dsa: microchip: Refactor switch shutdown routine for WoL
    preparation
  net: dsa: microchip: Ensure Stable PME Pin State for Wake-on-LAN

 drivers/net/dsa/microchip/ksz9477.c     | 103 ++++++++++++++++++++++-
 drivers/net/dsa/microchip/ksz9477.h     |   1 +
 drivers/net/dsa/microchip/ksz9477_i2c.c |   5 +-
 drivers/net/dsa/microchip/ksz_common.c  | 104 +++++++++++++++++++++---
 drivers/net/dsa/microchip/ksz_common.h  |   6 ++
 drivers/net/dsa/microchip/ksz_spi.c     |   5 +-
 6 files changed, 200 insertions(+), 24 deletions(-)

-- 
2.39.2

