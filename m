Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1417EA183
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 17:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230139AbjKMQur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 11:50:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjKMQuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 11:50:46 -0500
X-Greylist: delayed 191 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 13 Nov 2023 08:50:43 PST
Received: from relay.smtp-ext.broadcom.com (saphodev.broadcom.com [192.19.144.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25AA3D53
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 08:50:42 -0800 (PST)
Received: from mail-lvn-it-01.lvn.broadcom.net (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
        by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id E20D5C0000F8;
        Mon, 13 Nov 2023 08:50:41 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com E20D5C0000F8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
        s=dkimrelay; t=1699894241;
        bh=9tYcZbeteCSzUeb5BAfg8kvTY0sU1YEKvYdln3CCNik=;
        h=From:To:Cc:Subject:Date:From;
        b=tbZSuFmytvRL6cUeBvX0cXJNotWkz40/rESxo0FWqj9EUBDiEM2lFh2GulcVak1tJ
         RGqKRJexXnPVvp0GsVV6SbAnelsfRJGAHpe4b0TaV6GBWYlz8sSo+LrgtxOLY5XeCG
         u4tUECbOFHwaBQHMtRDlozFAYBOLljjmNikPev9o=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail-lvn-it-01.lvn.broadcom.net (Postfix) with ESMTPSA id 8836A18041CAC4;
        Mon, 13 Nov 2023 08:50:40 -0800 (PST)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     netdev@vger.kernel.org
Cc:     Florian Fainelli <florian.fainelli@broadcom.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: dsa: tag_rtl4_a: Use existing ETH_P_REALTEK constant
Date:   Mon, 13 Nov 2023 08:50:30 -0800
Message-Id: <20231113165030.2440083-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

No functional change, uses the existing ETH_P_REALTEK constant already
defined in if_ether.h.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 net/dsa/tag_rtl4_a.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/dsa/tag_rtl4_a.c b/net/dsa/tag_rtl4_a.c
index 4da5bad1a7aa..a019226ec6d2 100644
--- a/net/dsa/tag_rtl4_a.c
+++ b/net/dsa/tag_rtl4_a.c
@@ -23,7 +23,6 @@
 #define RTL4_A_NAME		"rtl4a"
 
 #define RTL4_A_HDR_LEN		4
-#define RTL4_A_ETHERTYPE	0x8899
 #define RTL4_A_PROTOCOL_SHIFT	12
 /*
  * 0x1 = Realtek Remote Control protocol (RRCP)
@@ -54,7 +53,7 @@ static struct sk_buff *rtl4a_tag_xmit(struct sk_buff *skb,
 
 	/* Set Ethertype */
 	p = (__be16 *)tag;
-	*p = htons(RTL4_A_ETHERTYPE);
+	*p = htons(ETH_P_REALTEK);
 
 	out = (RTL4_A_PROTOCOL_RTL8366RB << RTL4_A_PROTOCOL_SHIFT);
 	/* The lower bits indicate the port number */
@@ -82,7 +81,7 @@ static struct sk_buff *rtl4a_tag_rcv(struct sk_buff *skb,
 	tag = dsa_etype_header_pos_rx(skb);
 	p = (__be16 *)tag;
 	etype = ntohs(*p);
-	if (etype != RTL4_A_ETHERTYPE) {
+	if (etype != ETH_P_REALTEK) {
 		/* Not custom, just pass through */
 		netdev_dbg(dev, "non-realtek ethertype 0x%04x\n", etype);
 		return skb;
-- 
2.34.1

