Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C51F07BB66E
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 13:29:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbjJFL3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 07:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjJFL3u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 07:29:50 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86811CA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 04:29:48 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5e53:403c:300c:38ca])
        by albert.telenet-ops.be with bizsmtp
        id ubVm2A00C0nPCdM06bVmLu; Fri, 06 Oct 2023 13:29:46 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qoj1D-005Kwp-SZ;
        Fri, 06 Oct 2023 13:29:46 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qoj1e-006Fws-58;
        Fri, 06 Oct 2023 13:29:46 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-spi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH] spi: mpc52xx-psc: Make mpc52xx_psc_spi_transfer_one_message() static
Date:   Fri,  6 Oct 2023 13:29:45 +0200
Message-Id: <20231006112945.1491265-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

With W=1:

    drivers/spi/spi-mpc52xx-psc.c:178:5: warning: no previous prototype for ‘mpc52xx_psc_spi_transfer_one_message’ [-Wmissing-prototypes]
      178 | int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
	  |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

mpc52xx_psc_spi_transfer_one_message() is only used inside the file that
defines it.  Hence fix this by making it static.

Fixes: 145cfc3840e5931a ("spi: mpc52xx-psc: Switch to using core message queue")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310061815.7Rtyi4hs-lkp@intel.com/
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/spi/spi-mpc52xx-psc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/spi/spi-mpc52xx-psc.c b/drivers/spi/spi-mpc52xx-psc.c
index 78405cb45c961ff9..28f06122edac5632 100644
--- a/drivers/spi/spi-mpc52xx-psc.c
+++ b/drivers/spi/spi-mpc52xx-psc.c
@@ -175,8 +175,8 @@ static int mpc52xx_psc_spi_transfer_rxtx(struct spi_device *spi,
 	return 0;
 }
 
-int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
-					 struct spi_message *m)
+static int mpc52xx_psc_spi_transfer_one_message(struct spi_controller *ctlr,
+						struct spi_message *m)
 {
 	struct spi_device *spi;
 	struct spi_transfer *t = NULL;
-- 
2.34.1

