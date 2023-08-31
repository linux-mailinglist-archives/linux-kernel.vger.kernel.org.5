Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D44FC78EBD2
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 13:18:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343560AbjHaLS5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 07:18:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240805AbjHaLSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 07:18:55 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CE4CCE4;
        Thu, 31 Aug 2023 04:18:52 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id AC3AA86543;
        Thu, 31 Aug 2023 13:18:49 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693480730;
        bh=/BhRQsoKKcsBxIN891WmVmYVvmccoziVwKlYtaPCEsg=;
        h=From:To:Cc:Subject:Date:From;
        b=j38EttfrKVCwkrFm6s1KejyGiOuvodXcE1Az31JiC61FEGJxqOTLEPOp2ntcnV2YR
         lRcJTRVDJBumhxzTgPcyDodWr+pEyxFS2KDZDm5m/D1P81YXL3yiMjf5eTjeUGcHhK
         plNOktGjI/HJd+7JJgrhmvhNMoQvDxZQ/I7t74X6PiTrbzMPQDcwacT13LfOuDpW8l
         NW0PFSgAOANmdSLjNQYcdfVAwzopmE+KwuEKcHu+GYAxj2MnhpLEUyi4GqVLYz0yCC
         spq4GSBDt5+QfntdeD8koktXRWSF6AE2M4EmF8DLbPnMj7029lDRlND61rRMawKHR2
         UkxiIAfssLh6g==
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
Subject: [PATCH v2 0/4] net: dsa: hsr: Enable HSR HW offloading for KSZ9477
Date:   Thu, 31 Aug 2023 13:18:23 +0200
Message-Id: <20230831111827.548118-1-lukma@denx.de>
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
ifconfig lan1 up;ifconfig lan2 up
ifconfig hsr0 192.168.0.1 up

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

 drivers/net/dsa/microchip/ksz9477.c    | 96 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |  4 ++
 drivers/net/dsa/microchip/ksz_common.c | 81 ++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz_common.h |  3 +
 include/linux/dsa/ksz_common.h         |  1 +
 net/dsa/tag_ksz.c                      |  5 ++
 6 files changed, 190 insertions(+)

-- 
2.20.1

