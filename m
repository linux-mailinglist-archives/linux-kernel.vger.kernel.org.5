Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 187B97916BF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 14:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352889AbjIDMCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236312AbjIDMCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 08:02:36 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8748E1B8;
        Mon,  4 Sep 2023 05:02:33 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 82CEA863A8;
        Mon,  4 Sep 2023 14:02:31 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693828952;
        bh=iKsz3lXVX1mLkg6/Pm1nXTQDpxA82A/MCK7KumwAcc4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lM3iLUvMB0LL+EzPaFrZsQocW7uhF5+V9DYP1giThZsaYQWLsQd9xHyoNEB4yJ4n+
         TZg0LbNeoQqQ1gAxIn5QEDxSOsm/9uSEWxXyn/TiQGgENeX02D8VQXXYEemlrBxi4S
         /G1l5yTTSvHv7im0h0tfwwjdSaZOcK1JOnCCjjlbxjVmecCqBwp8JR+oyU8If2i0Qo
         GLSALHmYKlQDafe9WQIzmgf1d5JdKgfoPyMEYPfnC2CbljgNYzXCSceXSdrW7YYbrL
         1z2EpGlo8Hq0cReY9zMJwggpx/yHY5QivZ8u90ruP7zTGRmc9eJvY84OT7lGW3yMy9
         muF2geObJbzag==
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
Subject: [PATCH v3 RFC 1/4] net: dsa: Extend the ksz_device structure to hold info about HSR ports
Date:   Mon,  4 Sep 2023 14:02:06 +0200
Message-Id: <20230904120209.741207-2-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230904120209.741207-1-lukma@denx.de>
References: <20230904120209.741207-1-lukma@denx.de>
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

Information about HSR aware ports in a DSA switch can be helpful when
one needs tags to be adjusted before the HSR frame is sent.

For example - with ksz9477 switch - the TAG needs to be adjusted to have
both HSR ports marked in tag to allow execution of HW based frame
duplication.

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Use struct ksz_device to store hsr_ports variable

Changes for v3:
- None
---
 drivers/net/dsa/microchip/ksz_common.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/net/dsa/microchip/ksz_common.h b/drivers/net/dsa/microchip/ksz_common.h
index a4de58847dea..9fcafff0c01d 100644
--- a/drivers/net/dsa/microchip/ksz_common.h
+++ b/drivers/net/dsa/microchip/ksz_common.h
@@ -158,6 +158,9 @@ struct ksz_device {
 	bool synclko_125;
 	bool synclko_disable;
 
+	/* Bitmask indicating ports supporting HSR */
+	u16 hsr_ports;
+
 	struct vlan_table *vlan_cache;
 
 	struct ksz_port *ports;
-- 
2.20.1

