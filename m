Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BDD7774BB
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 11:36:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234028AbjHJJgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 05:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbjHJJgS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 05:36:18 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::226])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FE8310C0;
        Thu, 10 Aug 2023 02:36:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 85B9AC000A;
        Thu, 10 Aug 2023 09:36:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1691660175;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=dUOleZ4yr6r5dpHN6bzOw+rCblyTqbHA/Av6yYGJkVY=;
        b=QRCU64JmqKWfAUWcga66yFtYSJdz/0Jk2UXWfES5F7LsPmt97gQgWETUs+hYmOuyOR4sWy
        oNtXdiDt9I/2Mwv/gamFjBNJAL0fx0kxTTuG4Occ6wBNO40WYkyRHPYIaSeihYxUAcofXH
        Vbn4RRtVas+xFNN24mjUW/CkDMPX4/clHhAAvGS9FwCjmKjfcSD7Q94LthZOZ6iGV0Sg9N
        2Fzum8NTeRYS0eE4C5lXfU+cdKeZYs++Ad2QUHemBAuD8liCF6T+22rnJWU5VJjslHRF0N
        MmcdviED77jReOHpNc2UJl0YhEWW3bLkZxhYfwQID1G2oO44maRe6SdsBTI4fQ==
From:   alexis.lothore@bootlin.com
To:     =?UTF-8?q?Cl=C3=A9ment=20Leger?= <clement@clement-leger.fr>,
        Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     linux-renesas-soc@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Milan Stevanovic <milan.stevanovic@se.com>,
        Jimmy Lalande <jimmy.lalande@se.com>,
        Pascal Eberhard <pascal.eberhard@se.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH net-next v5 0/3] net: dsa: rzn1-a5psw: add support for vlan and .port_bridge_flags
Date:   Thu, 10 Aug 2023 11:36:48 +0200
Message-ID: <20230810093651.102509-1-alexis.lothore@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexis Lothoré <alexis.lothore@bootlin.com>

Hello,
this series enables vlan support in Renesas RZN1 internal ethernet switch,
and is a follow up to the work initiated by Clement Leger a few months ago,
who handed me over the topic.
This new revision aims to iron the last few points raised by Vladimir to
ensure that the driver is in line with switch drivers expectations, and is
based on the lengthy discussion in [1] (thanks Vladimir for the valuable
explanations)

[1] https://lore.kernel.org/netdev/20230314163651.242259-1-clement.leger@bootlin.com/

----
V5:
 - ensure that flooding can be enabled only if port belongs to a bridge
 - enable learning in a5psw_port_stp_state_set() only if port has learning
   enabled
 - toggle vlan tagging on vlan filtering in
 - removed reviewed-by on second patch since its modified

RESEND V4:
 - Resent due to net-next being closed

V4:
 - Fix missing CPU port bit in a5psw->bridged_ports
 - Use unsigned int for vlan_res_id parameters
 - Rename a5psw_get_vlan_res_entry() to a5psw_new_vlan_res_entry()
 - In a5psw_port_vlan_add(), return -ENOSPC when no VLAN entry is found
 - In a5psw_port_vlan_filtering(), compute "val" from "mask"

V3:
 - Target net-next tree and correct version...

V2:
 - Fixed a few formatting errors
 - Add .port_bridge_flags implementation

Clément Léger (3):
  net: dsa: rzn1-a5psw: use a5psw_reg_rmw() to modify flooding
    resolution
  net: dsa: rzn1-a5psw: add support for .port_bridge_flags
  net: dsa: rzn1-a5psw: add vlan support

 drivers/net/dsa/rzn1_a5psw.c | 240 +++++++++++++++++++++++++++++++++--
 drivers/net/dsa/rzn1_a5psw.h |   8 +-
 2 files changed, 237 insertions(+), 11 deletions(-)

-- 
2.41.0

