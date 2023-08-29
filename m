Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4223578C3F5
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 14:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233819AbjH2MMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 08:12:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232411AbjH2MMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 08:12:18 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7717CFA;
        Tue, 29 Aug 2023 05:12:06 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 4EAB1803AB;
        Tue, 29 Aug 2023 14:11:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693311119;
        bh=/S2MVrHJ96elw+baGLSrrlAWfYyFodKVEtqPjPiH3ZY=;
        h=From:To:Cc:Subject:Date:From;
        b=Rq2cqAzeiBwyqcK2W11At9U3uNiBSbeVbNuK7RSR/W8pAkwBJ1chfcMMtd77KdyY0
         qaYzcOnuRGy+PZM8TZ7KhO6I8PK4leo8vYIeusINiNuJXSdSGda6bqVvMJqMcllueR
         mBEgfQbx14CxbcT+OtGuv8gcdctPh6Bx9vR5qiIyxiePxXxgFRLNidtNsInIDVMnsj
         lO3816CqF6iB49jYQK899fuoBiCYnPbduAt4krg53JQrhRYrscD1TzLPr7qLvt7LVu
         7wXJ6SKexuVyQYyNpixU/Kg6rk/rdqLuTcSqS22UbzM6H4wPROx2/e3S9T0oH820q0
         Qy6qDkguehGpg==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net, Woojung Huh <woojung.huh@microchip.com>,
        Vladimir Oltean <olteanv@gmail.com>
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, UNGLinuxDriver@microchip.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH 0/4] net: dsa: hsr: Enable HSR HW offloading for KSZ9477
Date:   Tue, 29 Aug 2023 14:11:28 +0200
Message-Id: <20230829121132.414335-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

Lukasz Majewski (4):
  net: dsa: Extend the dsa_switch structure to hold info about HSR ports
  net: dsa: Extend ksz9477 TAG setup to support HSR frames duplication
  net: dsa: hsr: Enable in KSZ9477 switch HW HSR offloading
  net: dsa: hsr: Provide generic HSR ksz_hsr_{join|leave} functions

 drivers/net/dsa/microchip/ksz9477.c    | 96 ++++++++++++++++++++++++++
 drivers/net/dsa/microchip/ksz9477.h    |  4 ++
 drivers/net/dsa/microchip/ksz_common.c | 69 ++++++++++++++++++
 include/net/dsa.h                      |  3 +
 net/dsa/tag_ksz.c                      |  5 ++
 5 files changed, 177 insertions(+)

-- 
2.20.1

