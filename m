Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A1B79D936
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 20:55:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232858AbjILSzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 14:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230154AbjILSzU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 14:55:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3EA5106
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 11:55:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9524C433C7;
        Tue, 12 Sep 2023 18:55:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694544916;
        bh=mxNkHEPFMagVcGX4A+M7gEivrs30QJDxDaYd9yCe8Ww=;
        h=From:To:Cc:Subject:Date:From;
        b=MJDri5+8BKWHQ8tBxmzLk3OyfkcLeokFmdy20kAWTLrPwMy0TQuNjipTPsgYV56jI
         ZmMjDWuAtSl9O7ZRJA+DAQd05HLxp03CfCd5VcJo5mGqa4NC04aeNQId4Iiaqt7xpy
         6CreB7V/TMNWZ5dY+1OiYgl7YFQpfzNwPG6+JVeL8xwbTWXEZHAkC4mKdrXKM5u9IK
         rA/dbty3Y1+sCVVz8QNd9F6ieqoXqskeNFwVcdtgpMImQXpmL0EqDKL2ngXVFIk1wF
         HTFjxS013oR2xvmlomSSw8WXhHzI/w7dzkL6fF+mQt0NQq9kmIlneeAqIuKpLM1FIC
         cQgbVL/dby9fQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Grygorii Strashko <grygorii.strashko@ti.com>,
        MD Danish Anwar <danishanwar@ti.com>,
        Roger Quadros <rogerq@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Simon Horman <horms@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ti: icssg-prueth: add PTP dependency
Date:   Tue, 12 Sep 2023 20:54:51 +0200
Message-Id: <20230912185509.2430563-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The driver can now use PTP if enabled but fails to link built-in
if PTP is a loadable module:

aarch64-linux-ld: drivers/net/ethernet/ti/icssg/icss_iep.o: in function `icss_iep_get_ptp_clock_idx':
icss_iep.c:(.text+0x200): undefined reference to `ptp_clock_index'

Add the usual dependency to avoid this.

Fixes: 186734c158865 ("net: ti: icssg-prueth: add packet timestamping and ptp support")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/ethernet/ti/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/ti/Kconfig b/drivers/net/ethernet/ti/Kconfig
index 7f3e2e96c6e20..26ddc26fc7b8d 100644
--- a/drivers/net/ethernet/ti/Kconfig
+++ b/drivers/net/ethernet/ti/Kconfig
@@ -201,6 +201,7 @@ config TI_ICSSG_PRUETH
 
 config TI_ICSS_IEP
 	tristate "TI PRU ICSS IEP driver"
+	depends on PTP_1588_CLOCK_OPTIONAL
 	depends on TI_PRUSS
 	default TI_PRUSS
 	help
-- 
2.39.2

