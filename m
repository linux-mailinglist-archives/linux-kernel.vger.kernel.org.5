Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C332A7916BE
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:02:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348151AbjIDMCh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:02:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234458AbjIDMCf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:02:35 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4C50197;
        Mon,  4 Sep 2023 05:02:32 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C55A1805CA;
        Mon,  4 Sep 2023 14:02:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693828951;
        bh=McKsijySuQgvHOvSD/v6d1lo6B89Lk0uzVHTLTbqVHA=;
        h=From:To:Cc:Subject:Date:From;
        b=zN+ntPOvUswPmefl0Jnn084OdxkLljnqaaLaXPaiFsPahGKeoVSG8TwaWeTfYLdwA
         9Lmo3B/6nyISFMDFwO91bGAroNX5G6vXS6QIIhE2fOjEO4n4zoOw0r6JRYPXKiY3en
         eb9thOJm0Ou221GTraHqg1KjWlKjLwoaIqrLDoGQLvYumIUSDy0JkMgIyVUjGWP0Vh
         /5CHUV0QOEv11SsOheVB8HpnBnN8cZ/LikNIeyRao31bfwNEUg/kQTSAS/0ryCfjRR
         uXiyShv3vR/M2Tqy2+t3GwnQsSopRiWQmO3J1OnPlF+JIx6NtZKR4xMJcUSpTRDtde
         STCGLrm+ovB9w==
From:   Lukasz Majewski <lukma@denx.de>
To:     Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
        davem@davemloft.net, Paolo Abeni <pabeni@redhat.com>,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Tristram.Ha@microchip.com, Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>, UNGLinuxDriver@microchip.com,
        George McCollister <george.mccollister@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v3 RFC 0/4] net: dsa: hsr: Enable HSR HW offloading for KSZ9477
Date:   Mon,  4 Sep 2023 14:02:05 +0200
Message-Id: <20230904120209.741207-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Test HW:
Two KSZ9477-EVB boards with HSR ports set to "Port1" and "Port2".

Performance SW used:
nuttcp -S --nofork
nuttcp -vv -T 60 -r 192.168.0.2
nuttcp -vv -T 60 -t 192.168.0.2

Code: v6.5-rc7 Linux repository
Tested HSR v0 and v1
Results:
With KSZ9477 offloading support added: RX: 100 Mbps TX: 98 Mbps
With no offloading 		       RX: 63 Mbps  TX: 63 Mbps


Lukasz Majewski (4):
  net: dsa: Extend the ksz_device structure to hold info about HSR ports
  net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
  net: dsa: hsr: Enable in KSZ9477 switch HW HSR offloading
  net: dsa: hsr: Provide generic HSR ksz_hsr_{join|leave} functions

 drivers/net/dsa/microchip/ksz9477.c    | 103 +++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |   4 +
 drivers/net/dsa/microchip/ksz_common.c |  81 +++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |   3 +
 include/linux/dsa/ksz_common.h         |   1 +
 net/dsa/tag_ksz.c                      |   5 ++
 6 files changed, 197 insertions(+)

-- 
2.20.1

