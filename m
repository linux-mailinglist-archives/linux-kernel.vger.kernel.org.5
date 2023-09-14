Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 836647A0442
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237117AbjINMrx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:47:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINMrw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:47:52 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF4B1FCC;
        Thu, 14 Sep 2023 05:47:48 -0700 (PDT)
Received: from localhost.localdomain (85-222-111-42.dynamic.chello.pl [85.222.111.42])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: lukma@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 717C386940;
        Thu, 14 Sep 2023 14:47:46 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1694695667;
        bh=E43S9VBhjuwYwLYR+zQD8HsSCmgwf9f6i9kez2c5CxY=;
        h=From:To:Cc:Subject:Date:From;
        b=ZY0QW8HaGSTPGuNgJzhWV4HYojM0LbS50NUK1MHm1asJfFKYyokbmPS0jeqSrtp99
         +17rxQPdxDLj6cQbbTF3IrX2ziNPg/+6BTWA2jIYKHQ5yt74aWnpnp+o0Sybx3L0ti
         9JtyA/LeGAwG9bOxPkMBS5jy3SJLpes0cUsOKGlfbko3GbzYXyagC6jBvlm2fN4O7n
         qF6iOJdVOrRIiFi9HQ9Oy6WPd/scWn3E82GarIsTnPD2gmfiX6lKk6isuelWiMH0PN
         Hqqqy5tKsnJPqMzju2LYK1vmhwaFeIH0NOJm5JQjcLyE4vFHftU5eP1im7iFoFeaot
         dQuJE0seO+dQw==
From:   Lukasz Majewski <lukma@denx.de>
To:     Tristram.Ha@microchip.com, Eric Dumazet <edumazet@google.com>,
        davem@davemloft.net
Cc:     Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Paolo Abeni <pabeni@redhat.com>,
        Kristian Overskeid <koverskeid@gmail.com>,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukasz Majewski <lukma@denx.de>
Subject: [PATCH v2 net-next] net: hsr: Provide fix for HSRv1 supervisor frames decoding
Date:   Thu, 14 Sep 2023 14:47:30 +0200
Message-Id: <20230914124731.1654059-1-lukma@denx.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Provide fix to decode correctly supervisory frames when HSRv1 version of
the HSR protocol is used.

Without this patch console is polluted with:
ksz-switch spi1.0 lan1: hsr_addr_subst_dest: Unknown node

as a result of destination node's A MAC address equals to:
00:00:00:00:00:00.

cat /sys/kernel/debug/hsr/hsr0/node_table
Node Table entries for (HSR) device
MAC-Address-A,    MAC-Address-B,    time_in[A], time_in[B], Address-B
00:00:00:00:00:00 00:10:a1:94:77:30      400bf,       399c,	        0

It was caused by wrong frames decoding in the hsr_handle_sup_frame().

As the supervisor frame is encapsulated in HSRv1 frame:

SKB_I100000000: 01 15 4e 00 01 2d 00 10 a1 94 77 30 89 2f 00 34
SKB_I100000010: 02 59 88 fb 00 01 84 15 17 06 00 10 a1 94 77 30
SKB_I100000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000030: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
SKB_I100000040: 00 00

The code had to be adjusted accordingly and the MAC-Address-A now
has the proper address (the MAC-Address-B now has all 0's).

Fixes: eafaa88b3eb7 ("net: hsr: Add support for redbox supervision frames")'

Signed-off-by: Lukasz Majewski <lukma@denx.de>
---
Changes for v2:
- Use the proper parsing code altered with eafaa88b3eb7f
---
 net/hsr/hsr_framereg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/hsr/hsr_framereg.c b/net/hsr/hsr_framereg.c
index b77f1189d19d..6d14d935ee82 100644
--- a/net/hsr/hsr_framereg.c
+++ b/net/hsr/hsr_framereg.c
@@ -288,13 +288,13 @@ void hsr_handle_sup_frame(struct hsr_frame_info *frame)
 
 	/* And leave the HSR tag. */
 	if (ethhdr->h_proto == htons(ETH_P_HSR)) {
-		pull_size = sizeof(struct ethhdr);
+		pull_size = sizeof(struct hsr_tag);
 		skb_pull(skb, pull_size);
 		total_pull_size += pull_size;
 	}
 
 	/* And leave the HSR sup tag. */
-	pull_size = sizeof(struct hsr_tag);
+	pull_size = sizeof(struct hsr_sup_tag);
 	skb_pull(skb, pull_size);
 	total_pull_size += pull_size;
 
-- 
2.20.1

