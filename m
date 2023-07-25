Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61574761D99
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 17:46:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231898AbjGYPqs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 11:46:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbjGYPqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 11:46:46 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4DFB1FFE
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jul 2023 08:46:45 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:2d50:2ea4:d4e1:2af3])
        by albert.telenet-ops.be with bizsmtp
        id RTmj2A0022TBYXr06TmjAN; Tue, 25 Jul 2023 17:46:43 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qOKF3-002Vht-Ta;
        Tue, 25 Jul 2023 17:46:43 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qOKFH-009cV7-16;
        Tue, 25 Jul 2023 17:46:43 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Justin Chen <justin.chen@broadcom.com>,
        Simon Horman <simon.horman@corigine.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH net] bcmasp: BCMASP should depend on ARCH_BRCMSTB
Date:   Tue, 25 Jul 2023 17:46:37 +0200
Message-Id: <1e8b998aa8dcc6e38323e295ee2430b48245cc79.1690299794.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The Broadcom ASP 2.0 Ethernet controller is only present on Broadcom STB
SoCs.  Hence add a dependency on ARCH_BRCMSTB, to prevent asking the
user about this driver when configuring a kernel without Broadcom
ARM-based set-top box chipset support.

Fixes: 490cb412007de593 ("net: bcmasp: Add support for ASP2.0 Ethernet controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 drivers/net/ethernet/broadcom/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/broadcom/Kconfig b/drivers/net/ethernet/broadcom/Kconfig
index d4166141145d631c..75ca3ddda1f5e09f 100644
--- a/drivers/net/ethernet/broadcom/Kconfig
+++ b/drivers/net/ethernet/broadcom/Kconfig
@@ -257,6 +257,7 @@ config BNXT_HWMON
 
 config BCMASP
 	tristate "Broadcom ASP 2.0 Ethernet support"
+	depends on ARCH_BRCMSTB || COMPILE_TEST
 	default ARCH_BRCMSTB
 	depends on OF
 	select MII
-- 
2.34.1

