Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0620F7E1F63
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 12:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230509AbjKFLGw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 06:06:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbjKFLGt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 06:06:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC1C4136
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 03:06:46 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35D51C433CB;
        Mon,  6 Nov 2023 11:06:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699268806;
        bh=g3eDON8La9LZBGvGeH9tuvtlZ9gkW8hDKV2CMMchUE4=;
        h=From:To:Cc:Subject:Date:From;
        b=fBa/EuyJu1KjyLtU6I9czSHVWMGMexRmURy8to5xILif8oO7Yo0mGuoaqCYhuOgee
         ZiVGPee5/nkIaGBoUCvutRflUr4V2xi0k2wm539RlYLIYb2jdXMhCAERHajB3he6z4
         JHRlIgbWM1H08AI3XpOsKrrnLBm7EV8x1nvF6SZ61EVh53N/ftYP3s9BbPc4Ht4kxj
         5Bzc5dCtPcNFLIlhiCw7A6+SS/h+ivRDIIAXhbwMWyobSaI4RQtMMwGiPP0SIJnqc9
         1o3MaBYLxTHEH4E77PTsbpzxZ022lJkuSjy0Yl0ciajvIL7RpwKAsrTpuF/CWTaDYV
         8jKGgZ4L4lNrg==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan+linaro@kernel.org>)
        id 1qzxS7-00085p-1j;
        Mon, 06 Nov 2023 12:07:31 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Stanley Chang <stanley_chang@realtek.com>,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-usb@vger.kernel.org, Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] Revert "usb: phy: add usb phy notify port status API"
Date:   Mon,  6 Nov 2023 12:06:51 +0100
Message-ID: <20231106110654.31090-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The recently added Realtek PHY drivers depend on the new port status
notification mechanism which was built on the deprecated USB PHY
implementation and devicetree binding.

Specifically, using these PHYs would require describing the very same
PHY using both the generic "phy" property and the deprecated "usb-phy"
property which is clearly wrong.

We should not be building new functionality on top of the legacy USB PHY
implementation even if it is currently stuck in some kind of
transitional limbo.

Revert the new Realtek PHY drivers for now so that the port status
notification interface can be reverted and replaced before we dig
ourselves into an even deeper hole with this PHY mess.

Note that there are no upstream users of these PHYs and the drivers were
only included in 6.6 so there should still be time to undo this.

Preferably these should go in through Greg's tree for 6.7-rc1.

Johan


Johan Hovold (3):
  Revert "phy: realtek: usb: Add driver for the Realtek SoC USB 3.0 PHY"
  Revert "phy: realtek: usb: Add driver for the Realtek SoC USB 2.0 PHY"
  Revert "usb: phy: add usb phy notify port status API"

 drivers/phy/Kconfig                |    1 -
 drivers/phy/Makefile               |    1 -
 drivers/phy/realtek/Kconfig        |   32 -
 drivers/phy/realtek/Makefile       |    3 -
 drivers/phy/realtek/phy-rtk-usb2.c | 1325 ----------------------------
 drivers/phy/realtek/phy-rtk-usb3.c |  761 ----------------
 drivers/usb/core/hub.c             |   23 -
 include/linux/usb/phy.h            |   13 -
 8 files changed, 2159 deletions(-)
 delete mode 100644 drivers/phy/realtek/Kconfig
 delete mode 100644 drivers/phy/realtek/Makefile
 delete mode 100644 drivers/phy/realtek/phy-rtk-usb2.c
 delete mode 100644 drivers/phy/realtek/phy-rtk-usb3.c

-- 
2.41.0

