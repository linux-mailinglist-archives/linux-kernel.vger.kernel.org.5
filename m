Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F09917A41CC
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 09:10:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240130AbjIRHJw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 03:09:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240065AbjIRHJL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 03:09:11 -0400
Received: from core.lopingdog.com (core.lopingdog.com [162.55.228.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84871F3;
        Mon, 18 Sep 2023 00:08:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=lopingdog.com;
        s=mail; t=1695020329;
        bh=jeWrBC92z//V5paBXAzhpWHpsdsNIxZ42afnWQdTjhU=;
        h=Date:From:To:Subject:From;
        b=YoMqkn8oubSVPlfpVsecdU2nK7A8TQotBlwDqUmrumLrrKo2wR9rCGOa1QZjqvqPG
         BqD09i15Iu6BR5ju5nq9Pz6QFe6d18j0pIayC9nvoWFUGZjpB/UVUyY+rzBVysdwqJ
         fH/w0D1Ng4J7T0J8JgLi1HjUFA2qCf2AXZLhVEZ2ubpkQtZ2U3oypfghL1aH0OaX/4
         UfRkeC6cOBwM6chS+WRfv/Hybknrd+HI1I+0hY+S53xUvOolRtWXjqaL/cT/Khjo7N
         8YFDprVfWfPrZHN5pVZ2ax0MiwEawmwNduRCRO1DLxKLbJhsjBKAMjZU5cgZRU5jVq
         tEDhc8mKm5gmA==
Received: from authenticated-user (core.lopingdog.com [162.55.228.84])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by core.lopingdog.com (Postfix) with ESMTPSA id AD4E14402DB;
        Mon, 18 Sep 2023 01:58:47 -0500 (CDT)
Date:   Mon, 18 Sep 2023 01:58:46 -0500
From:   Jay Monkman <jtm@lopingdog.com>
To:     devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Piergiorgio Beruto <piergiorgio.beruto@gmail.com>,
        Arndt Schuebel <Arndt.Schuebel@onsemi.com>
Subject: [PATCH 0/4] net: Add NCN26010 driver
Message-ID: <ZQf1JnM34pR9oimS@lopingdog.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for onsemi's NCN26010 10BASE-T1S Ethernet controller. This is
a combined MAC/PHY that uses SPI to interface to a microcontroller.

The patches include devicetree bindings for the NCN26000 PHY and the
NCN26010, required changes to the NCN26000 PHY driver and the NCN26010
driver itself.


Jay Monkman (4):
  dt-bindings: net: Add bindings for onsemi NCN26000 PHY
  dt-bindings: net: Add onsemi NCN26010 ethernet controller
  net: phy: Add GPIO and DT support to NCN26000
  net/onsemi: Add NCN26010 driver

 .../devicetree/bindings/net/onnn,macphy.yaml  |   94 +
 .../bindings/net/onnn,ncn26000.yaml           |  177 ++
 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/onsemi/Kconfig           |   27 +
 drivers/net/ethernet/onsemi/Makefile          |    9 +
 drivers/net/ethernet/onsemi/onsemi_macphy.h   |  298 +++
 .../net/ethernet/onsemi/onsemi_macphy_core.c  | 2149 +++++++++++++++++
 .../ethernet/onsemi/onsemi_macphy_ethtool.c   |  179 ++
 drivers/net/phy/ncn26000.c                    |  467 +++-
 10 files changed, 3394 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/onnn,macphy.yaml
 create mode 100644 Documentation/devicetree/bindings/net/onnn,ncn26000.yaml
 create mode 100644 drivers/net/ethernet/onsemi/Kconfig
 create mode 100644 drivers/net/ethernet/onsemi/Makefile
 create mode 100644 drivers/net/ethernet/onsemi/onsemi_macphy.h
 create mode 100644 drivers/net/ethernet/onsemi/onsemi_macphy_core.c
 create mode 100644 drivers/net/ethernet/onsemi/onsemi_macphy_ethtool.c

-- 
2.40.1

