Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51717AB2C0
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 15:31:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234094AbjIVNbm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 09:31:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjIVNbi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 09:31:38 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 950F9199;
        Fri, 22 Sep 2023 06:31:30 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id F0C2086098;
        Fri, 22 Sep 2023 15:31:27 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1695389488;
        bh=CLJc5GlLdZlYRiKNqvkZL9EUFetRdo25E7/HWR0m+sY=;
        h=From:To:Cc:Subject:Date:From;
        b=w6ptt2wKUoRDIvpuSKwbBWkrLk1I142BkEdHfoO0l39Lk0gfSTJ6QKR1dX4ktvnc6
         uDn7vWYDzfpIifWf9q4TG2SrVjUUSJIxRpK0ekt94BLwimPa1uQypQ8+Qm7IIMA1FD
         0m5MQ33wwnEpujoI8cnxpOideeHTU5u1Mw5Rq+x8uEDUIEaeavpQIiTJFAa1DjXFtr
         XMtEvcl9ePuJEmLzxbrucbhiVghtV7FJkXLcJoWcLapMF1DjqcBKEW+xJIHMWyldl2
         bifMiUus0Vxrg7Gi99Z6xjpxegdp91y5rmWdFVJ0SxJb6Kj2dW4X0y24oDGdCr2KpR
         ZwYiL3DB0xOCQ==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v6 net-next 0/5] net: dsa: hsr: Enable HSR HW offloading for KSZ9477
Date:   Fri, 22 Sep 2023 15:31:03 +0200
Message-Id: <20230922133108.2090612-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series provides support for HSR HW offloading in KSZ9477
switch IC.

To test this feature:
ip link add name hsr0 type hsr slave1 lan1 slave2 lan2 supervision 45 version 1
ip link set dev lan1 up
ip link set dev lan2 up
ip a add 192.168.0.1/24 dev hsr0
ip link set dev hsr0 up

To remove HSR network device:
ip link del hsr0

To test if one can adjust MAC address:
ip link set lan2 address 00:01:02:AA:BB:CC

It is also possible to create another HSR interface, but it will
only support HSR is software - e.g.
ip link add name hsr1 type hsr slave1 lan3 slave2 lan4 supervision 45 version 1

Test HW:
Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".

Performance SW used:
nuttcp -S --nofork
nuttcp -vv -T 60 -r 192.168.0.2
nuttcp -vv -T 60 -t 192.168.0.2

Code: v6.6.0-rc2+ Linux net-next repository
SHA1: 5a1b322cb0b7d0d33a2d13462294dc0f46911172

Tested HSR v0 and v1
Results:
With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
With no offloading 		       RX: 63 Mbps  TX: 63 Mbps


Lukasz Majewski (2):
  net: dsa: tag_ksz: Extend ksz9477_xmit() for HSR frame duplication
  net: dsa: microchip: Enable HSR offloading for KSZ9477

Vladimir Oltean (3):
  net: dsa: propagate extack to ds->ops->port_hsr_join()
  net: dsa: notify drivers of MAC address changes on user ports
  net: dsa: microchip: move REG_SW_MAC_ADDR to dev->info->regs[]

 drivers/net/dsa/microchip/ksz8795_reg.h |   7 --
 drivers/net/dsa/microchip/ksz9477.c     |  77 ++++++++++++
 drivers/net/dsa/microchip/ksz9477.h     |   2 +
 drivers/net/dsa/microchip/ksz9477_reg.h |   7 --
 drivers/net/dsa/microchip/ksz_common.c  | 149 ++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h  |  10 ++
 drivers/net/dsa/xrs700x/xrs700x.c       |  18 ++-
 include/net/dsa.h                       |  13 ++-
 net/dsa/port.c                          |   5 +-
 net/dsa/port.h                          |   3 +-
 net/dsa/slave.c                         |   9 +-
 net/dsa/tag_ksz.c                       |   8 ++
 12 files changed, 283 insertions(+), 25 deletions(-)

-- 
2.20.1

