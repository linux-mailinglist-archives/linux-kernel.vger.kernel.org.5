Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 183027E5A17
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 16:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjKHPej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 10:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233115AbjKHPeg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 10:34:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68DED1BE6
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 07:34:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 678F0C433C9;
        Wed,  8 Nov 2023 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699457674;
        bh=Ou7t4lvswhjUNZZwdkd4kF/0Xw+ejygmyUW1LnOTGQw=;
        h=From:To:Cc:Subject:Date:From;
        b=E/f+JtFB3olupuoN9TGVTWDRFuWEVyl3gbLs7WmFyJBpylxVv1/pI9Pj/dCT0E4Be
         peA0WwVmI68mM1qcPLAdJz8ApbEf2dFCOP6oXz96J5fwl/0zf3R+Z1Xccj2jsh0/28
         +IqBPV71v3ud0LWL0Pl9Pv96x1bl8nSHEbooskYAJyCZxqMmEz7hkTEm7J1t3IY4jV
         XTb5U6VkALLFg5kU2x08cEuqoe8MUw+HAzWvJH317uZji8+79szusbWwXm44cYvYkc
         U4jN7zmoj2TdXFhxbDHRUrrco/40hzH/Rifb/2PEDgXNMS77SlKQf/SnOG1zeMLKDg
         YCYLtlYmjqwQA==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Ayush Singh <ayushdevel1325@gmail.com>,
        greybus-dev@lists.linaro.org, linux-kernel@vger.kernel.org
Subject: [PATCH] greybus: beagleplay: select CONFIG_CRC_CCITT
Date:   Wed,  8 Nov 2023 16:34:24 +0100
Message-Id: <20231108153429.1072732-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

Without the CRC_CCITT code, the new greybus driver fails to link:

aarch64-linux-ld: drivers/greybus/gb-beagleplay.o: in function `hdlc_append_tx_u8':
gb-beagleplay.c:(.text+0x158): undefined reference to `crc_ccitt'
aarch64-linux-ld: drivers/greybus/gb-beagleplay.o: in function `gb_tty_receive':
gb-beagleplay.c:(.text+0x5c4): undefined reference to `crc_ccitt'

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/greybus/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
index 033d31dbf3b8..ab81ceceb337 100644
--- a/drivers/greybus/Kconfig
+++ b/drivers/greybus/Kconfig
@@ -20,6 +20,7 @@ if GREYBUS
 config GREYBUS_BEAGLEPLAY
 	tristate "Greybus BeaglePlay driver"
 	depends on SERIAL_DEV_BUS
+	select CRC_CCITT
 	help
 	  Select this option if you have a BeaglePlay where CC1352
 	  co-processor acts as Greybus SVC.
-- 
2.39.2

