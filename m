Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 013717F7874
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 17:02:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345926AbjKXQCA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 11:02:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230354AbjKXQB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 11:01:58 -0500
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6588319A2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 08:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=qlLZRfRX0Q+01FG3L88wQD/YsWqULUTai5ZfTYrNj0w=; b=dOHb1B6cY+Gt59IvJMyz4owAQp
        InFsYe0Gxr9NMllL4LHecGdkXMskISw5oNrmrmt/BlFbsiiMhya0hehRogl0NgDlcVM00oSmVpEVF
        ypbJXKAH/tj+L6oGFQXp+aPB2ez/dho6/XLxpKoDkXRemC9DFaTMVZYE6higE0n4OSWf+wMKASDHr
        /KtUDkHDPfDWzC6E2/OUnb4Y2H6yiu3c6t5L9+26EmK2CZ/xqRiBwBI5GdYqR8tOt/uhNAQf2f12B
        lHXo0WEQqANjqgLMgSiu+o0XO26yDGFM95NlRTXSVjneAa+TLOHOPaYfkMufqrSTk3aTPmx1L2vPO
        ZiyIDatw==;
Received: from [192.168.1.4] (port=8294 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1r6Ycv-0004bX-1m;
        Fri, 24 Nov 2023 17:01:57 +0100
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 24 Nov 2023 17:01:56 +0100
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v5 0/2] net: dsa: microchip: enable setting rmii reference
Date:   Fri, 24 Nov 2023 17:01:46 +0100
Message-ID: <cover.1700841353.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KSZ88X3 devices can select between internal and external RMII reference clock.
This patch series introduces new device tree property for setting reference
clock to internal.

---
V5:
  - move rmii-clk-internal to be a port device tree property.
V4:
  - remove rmii_clk_internal from ksz_device, as its not needed any more
  - move rmii clk config as well as ksz8795_cpu_interface_select to 
    ksz8_config_cpu_port
V3: 
  - move ksz_cfg from global switch config to port config as suggested by Vladimir
    Oltean
  - reverse patch order as suggested by Vladimir Oltean
  - adapt dt schema as suggested by Conor Dooley
V2: 
  - don't rely on default register settings - enforce set/clear property as
    suggested by Andrew Lunn
  - enforce dt schema as suggested by Conor Dooley

Ante Knezic (2):
  dt-bindings: net: microchip,ksz: document microchip,rmii-clk-internal
  net: dsa: microchip: add property to select internal RMII reference
    clock

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 38 ++++++++++++++-
 drivers/net/dsa/microchip/ksz8795.c                | 56 +++++++++++++++++++---
 drivers/net/dsa/microchip/ksz8795_reg.h            |  3 ++
 3 files changed, 90 insertions(+), 7 deletions(-)

-- 
2.11.0

