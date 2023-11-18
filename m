Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A72157EFF90
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 13:33:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjKRMdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 07:33:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbjKRMdA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 07:33:00 -0500
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC7A4D61;
        Sat, 18 Nov 2023 04:32:56 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D73B7E0002;
        Sat, 18 Nov 2023 12:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arinc9.com; s=gm1;
        t=1700310775;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=N9SnKBhRbqMMe69FRrrc0XQvADn9TWKV4HfE5CZaJv8=;
        b=ADIhRVuCtojr4MU4BCbgFoLcpOPsIIaqb20ar7ExCA4jhWVPamIORfy2L1zxem9FbywtlJ
        bEqEiqre949ZvSFkK6S5/YBeky5/MiMx3Uk/caW87xYJnfhAGshXnCm5r7klJsn9BcO+7+
        kDM3scZBplSsOfh1n8DpF93rWAvi2z3wEcNgFfi1iDBc6nrNjmOGS/FAMwlfuFJK0kF0+n
        C3ImHe82Tt33MDwRWSBkFQsgsVv8ICY4BYj+yA4nmyNDZsVNSahlDrARFf9Uu5sGTCa0BH
        NHeenjzyfVEdMdUByx4taLvR1MJ/2hDf7KIniDa0WqnV13DxYB8eSxuNS44QyA==
From:   =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>
To:     =?UTF-8?q?Ar=C4=B1n=C3=A7=20=C3=9CNAL?= <arinc.unal@arinc9.com>,
        Daniel Golle <daniel@makrotopia.org>,
        Landen Chao <Landen.Chao@mediatek.com>,
        DENG Qingfang <dqfext@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Frank Wunderlich <frank-w@public-files.de>,
        Bartel Eerdekens <bartel.eerdekens@constell8.be>,
        mithat.guner@xeront.com, erkin.bozoglu@xeront.com
Subject: [PATCH net-next 00/15] MT7530 DSA subdriver improvements
Date:   Sat, 18 Nov 2023 15:31:50 +0300
Message-Id: <20231118123205.266819-1-arinc.unal@arinc9.com>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: arinc.unal@arinc9.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patch series simplifies the MT7530 DSA subdriver and improves the
logic of the support for MT7530, MT7531, and the switch on the MT7988 SoC.

I have done a simple ping test to confirm basic communication on all switch
ports on the MCM and standalone MT7530 and MT7531 switch with this patch
series applied.

MT7621 Unielec, MCM MT7530:

rgmii-only-gmac0-mt7621-unielec-u7621-06-16m.dtb
gmac0-and-gmac1-mt7621-unielec-u7621-06-16m.dtb

tftpboot 0x80008000 mips-uzImage.bin; tftpboot 0x83000000 mips-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootm 0x80008000 0x83000000 0x83f00000

MT7622 Bananapi, MT7531:

gmac0-and-gmac1-mt7622-bananapi-bpi-r64.dtb

tftpboot 0x40000000 arm64-Image; tftpboot 0x45000000 arm64-rootfs.cpio.uboot; tftpboot 0x4a000000 $dtb; booti 0x40000000 0x45000000 0x4a000000

MT7623 Bananapi, standalone MT7530:

rgmii-only-gmac0-mt7623n-bananapi-bpi-r2.dtb
gmac0-and-gmac1-mt7623n-bananapi-bpi-r2.dtb

tftpboot 0x80008000 arm-zImage; tftpboot 0x83000000 arm-rootfs.cpio.uboot; tftpboot 0x83f00000 $dtb; bootz 0x80008000 0x83000000 0x83f00000

This patch series is the continuation of the one linked below.

https://lore.kernel.org/netdev/20230522121532.86610-1-arinc.unal@arinc9.com/

Arınç

Arınç ÜNAL (15):
  net: dsa: mt7530: always trap frames to active CPU port on MT7530
  net: dsa: mt7530: use p5_interface_select as data type for p5_intf_sel
  net: dsa: mt7530: store port 5 SGMII capability of MT7531
  net: dsa: mt7530: improve comments regarding port 5 and 6
  net: dsa: mt7530: improve code path for setting up port 5
  net: dsa: mt7530: do not set priv->p5_interface on mt7530_setup_port5()
  net: dsa: mt7530: do not run mt7530_setup_port5() if port 5 is disabled
  net: dsa: mt7530: empty default case on mt7530_setup_port5()
  net: dsa: mt7530: call port 6 setup from mt7530_mac_config()
  net: dsa: mt7530: remove pad_setup function pointer
  net: dsa: mt7530: move XTAL check to mt7530_setup()
  net: dsa: mt7530: move enabling port 6 to mt7530_setup_port6()
  net: dsa: mt7530: simplify mt7530_setup_port6() and change to void
  net: dsa: mt7530: correct port capabilities of MT7988
  net: dsa: mt7530: do not clear config->supported_interfaces

 drivers/net/dsa/mt7530-mdio.c |   7 +-
 drivers/net/dsa/mt7530.c      | 283 ++++++++++++++++---------------------
 drivers/net/dsa/mt7530.h      |  19 +--
 3 files changed, 137 insertions(+), 172 deletions(-)


