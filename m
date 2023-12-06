Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48C1B806817
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 08:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377013AbjLFHRi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 02:17:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376923AbjLFHRg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 02:17:36 -0500
Received: from www530.your-server.de (www530.your-server.de [188.40.30.78])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC65F135;
        Tue,  5 Dec 2023 23:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=geanix.com;
        s=default2211; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:
        Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References;
        bh=+H62xYUVYv9m4br7cg0DgyNn6m4JbUs5+N/PVPX56JM=; b=orh0/fxnE4NeMLDDyd/Te3IbWW
        3OIDv19m9XNBLLmL0BneUzz1K1wcODjswD+O8g1TI5nfiL8G74Ecn0qqfJ1aAlb6CA9YsmdrocFF0
        SV2GiVg/oC5O5vpiNs2ySi8VsBrEcyCPbQ3OO75FMiCtek4cCNvPyyg5wo0uGtER7HKLoH1BjRL/H
        v5zul/3wD5U4Umggmj+8L7EugVxamtCHJyUdpKWu+SVBzEZieqhRr24jcB0eVq/6rfmjvn/bWWgbN
        IOYobp8jH3LXpOmqZJaAisFBLHExOV8LLv8Vf7lWKW3nX0rYk1P14FuoiQWbCOLxMtNc6CjuIpXw6
        LXdH5vGw==;
Received: from sslproxy05.your-server.de ([78.46.172.2])
        by www530.your-server.de with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <sean@geanix.com>)
        id 1rAmA7-0009kh-21; Wed, 06 Dec 2023 08:17:39 +0100
Received: from [185.17.218.86] (helo=zen..)
        by sslproxy05.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <sean@geanix.com>)
        id 1rAmA6-000Kzf-CG; Wed, 06 Dec 2023 08:17:38 +0100
From:   Sean Nyekjaer <sean@geanix.com>
To:     Woojung Huh <woojung.huh@microchip.com>,
        UNGLinuxDriver@microchip.com, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Arun Ramadoss <arun.ramadoss@microchip.com>,
        Christian Eggers <ceggers@arri.de>
Cc:     Sean Nyekjaer <sean@geanix.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 net] net: dsa: microchip: provide a list of valid protocols for xmit handler
Date:   Wed,  6 Dec 2023 08:16:54 +0100
Message-ID: <20231206071655.1626479-1-sean@geanix.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-Sender: sean@geanix.com
X-Virus-Scanned: Clear (ClamAV 0.103.10/27114/Tue Dec  5 09:39:00 2023)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide a list of valid protocols for which the driver will provide
it's deferred xmit handler.

When using DSA_TAG_PROTO_KSZ8795 protocol, it does not provide a
"connect" method, therefor ksz_connect() is not allocating ksz_tagger_data.

This avoids the following null pointer dereference:
 ksz_connect_tag_protocol from dsa_register_switch+0x9ac/0xee0
 dsa_register_switch from ksz_switch_register+0x65c/0x828
 ksz_switch_register from ksz_spi_probe+0x11c/0x168
 ksz_spi_probe from spi_probe+0x84/0xa8
 spi_probe from really_probe+0xc8/0x2d8

Fixes: ab32f56a4100 ("net: dsa: microchip: ptp: add packet transmission timestamping")
Signed-off-by: Sean Nyekjaer <sean@geanix.com>
---
https://lore.kernel.org/netdev/20231205124636.1345761-1-sean@geanix.com/#R
Changes since v1:
 - Provided a list of valid protocols

 drivers/net/dsa/microchip/ksz_common.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index 42db7679c360..286e20f340e5 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2624,10 +2624,18 @@ static int ksz_connect_tag_protocol(struct dsa_switch *ds,
 {
 	struct ksz_tagger_data *tagger_data;
 
-	tagger_data = ksz_tagger_data(ds);
-	tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
-
-	return 0;
+	switch (proto) {
+	case DSA_TAG_PROTO_KSZ8795:
+		return 0;
+	case DSA_TAG_PROTO_KSZ9893:
+	case DSA_TAG_PROTO_KSZ9477:
+	case DSA_TAG_PROTO_LAN937X:
+		tagger_data = ksz_tagger_data(ds);
+		tagger_data->xmit_work_fn = ksz_port_deferred_xmit;
+		return 0;
+	default:
+		return -EPROTONOSUPPORT;
+	}
 }
 
 static int ksz_port_vlan_filtering(struct dsa_switch *ds, int port,
-- 
2.42.0

