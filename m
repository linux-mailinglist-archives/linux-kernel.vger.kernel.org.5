Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD7C7D1189
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 16:25:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377567AbjJTOZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 10:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377541AbjJTOZp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 10:25:45 -0400
Received: from mail.helmholz.de (mail.helmholz.de [217.6.86.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F64ED46
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=helmholz.de
        ; s=dkim1; h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From:
        Sender:Reply-To:Content-Transfer-Encoding:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=nTOFZc7bq733wtuIoZXUDDS7Bub00zC+a3meUxD2d+g=; b=LcKfAfEIGJQN03zNzSTlt2QhXi
        eksZWe9n2oH8ug/xKPYE9zonOdUl06+MFCn/hBAOaA8UiZQnjUXUilileDodAHS4yUHibVhpwFcTE
        v6Ckh6mcvwhtSMq4Ojpku0bJBDNE6NGo8pOyyKhZRXmTbVr1Jr3y2wBqUi80kmSVpEGh86VE7B3X/
        2gv6Qc01QnfcHDJTzkAaWymWk+Jh7ku89mbIBn6SmriI73KaxUXJPQqViBK2TAQHjLlDA9DwvFkIP
        uBh9fCcaLqNtya5Rkp3tKjsdxO0PjHxyUdwUoR5N1ON3gMYJlak9OJNyG/WZ+Id3LA4ReFrJacdee
        nj/oKWiA==;
Received: from [192.168.1.4] (port=55465 helo=SH-EX2013.helmholz.local)
        by mail.helmholz.de with esmtps  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        (Exim 4.96)
        (envelope-from <Ante.Knezic@helmholz.de>)
        id 1qtqR3-000769-1u;
        Fri, 20 Oct 2023 16:25:09 +0200
Received: from linuxdev.helmholz.local (192.168.6.7) by
 SH-EX2013.helmholz.local (192.168.1.4) with Microsoft SMTP Server (TLS) id
 15.0.1497.48; Fri, 20 Oct 2023 16:25:08 +0200
From:   Ante Knezic <ante.knezic@helmholz.de>
To:     <netdev@vger.kernel.org>
CC:     <woojung.huh@microchip.com>, <andrew@lunn.ch>,
        <f.fainelli@gmail.com>, <olteanv@gmail.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <conor+dt@kernel.org>, <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <UNGLinuxDriver@microchip.com>, <o.rempel@pengutronix.de>,
        Ante Knezic <ante.knezic@helmholz.de>
Subject: [PATCH net-next v4 0/2] net: dsa: microchip: enable setting rmii reference
Date:   Fri, 20 Oct 2023 16:25:02 +0200
Message-ID: <cover.1697811160.git.ante.knezic@helmholz.de>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.6.7]
X-ClientProxiedBy: SH-EX2013.helmholz.local (192.168.1.4) To
 SH-EX2013.helmholz.local (192.168.1.4)
X-EXCLAIMER-MD-CONFIG: 2ae5875c-d7e5-4d7e-baa3-654d37918933
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

KSZ88X3 devices can select between internal and external RMII reference clock.
This patch series introduces new device tree property for setting reference
clock to internal.

---
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

 .../devicetree/bindings/net/dsa/microchip,ksz.yaml | 17 +++++++++++++
 drivers/net/dsa/microchip/ksz8795.c                | 28 +++++++++++++++++-----
 drivers/net/dsa/microchip/ksz8795_reg.h            |  3 +++
 3 files changed, 42 insertions(+), 6 deletions(-)

-- 
2.11.0

