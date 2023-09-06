Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70FAD794060
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:28:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242613AbjIFP2c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231278AbjIFP2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:28:25 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626DE1717;
        Wed,  6 Sep 2023 08:28:21 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id C94C6866A0;
        Wed,  6 Sep 2023 17:28:18 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694014099;
        bh=juvUfxNm6RLKydd0BNfwpDvpkl5RSgEH+Mo6sHbohMY=;
        h=From:To:Cc:Subject:Date:From;
        b=Gk71eKVTgnNTXmwch5G7r67L1fo3ra2Xw7nbPZOGOlOQl4RXAva9eIKBPSeshkaPR
         LATyWw254O7Y6pk7RhjVU+3bC++gqO29NFKcv/0uSGD2qBlxZGkGEoT4OeIHplLUvL
         DbMwhVoS5Iu9nq1Q/26aRM5MtOsh7A65bN2J+sZEvFer6X04FogRqC29Bu5QQ+2xi2
         V0OUoNLp1IIjQR+kPYV96zFowGnTGjQxHvpwnJnVXdo6ImmQRiSD0EgyJtjC8T3JrM
         BVFp8f76L7F1MTMJdcqjZoGXrwKS1FlUGhFMscwNSctZWAYdxbhiQldcj/Kwkmuojn
         mpbCt1MuOlfkQ==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        Andrew Lunn <andrew@lunn.ch>, davem@davemloft.net,
        Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        Oleksij Rempel <linux@rempel-privat.de>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [[RFC PATCH v4 net-next] 0/2] net: dsa: hsr: Enable HSR HW offloading for KSZ9477
Date:   Wed,  6 Sep 2023 17:27:59 +0200
Message-Id: <20230906152801.921664-1-lukma@denx.de>
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

It is also possible to create another HSR interface, but it will
only support HSR is software - e.g.
ip link add name hsr1 type hsr slave1 lan3 slave2 lan4 supervision 45 version 1

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


Lukasz Majewski (2):
  net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
  net: dsa: hsr: Enable in KSZ9477 switch HW HSR offloading

 drivers/net/dsa/microchip/ksz9477.c    | 81 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |  2 +
 drivers/net/dsa/microchip/ksz_common.c | 76 ++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  3 +
 net/dsa/tag_ksz.c                      |  8 +++
 5 files changed, 170 insertions(+)

-- 
2.20.1

