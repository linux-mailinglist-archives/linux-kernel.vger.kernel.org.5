Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F421F770F21
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 11:52:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjHEJwL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 05:52:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjHEJwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 05:52:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A56C13A9B;
        Sat,  5 Aug 2023 02:52:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E37C60B2C;
        Sat,  5 Aug 2023 09:52:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871EEC433C7;
        Sat,  5 Aug 2023 09:52:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691229123;
        bh=k1H8U6RI1llKdbpE02HLjjQniXPJI9WecDX0w+udZxg=;
        h=From:To:Cc:Subject:Date:From;
        b=iOy65PHDHA9Jq5LZS5cEJm54DND1H3goCPAPegqGgwjkecwpBBgT4HGFsJxMqneJl
         Bay944svlGQ3twdgUbs7nH1EdOLJvL97Uq9DRDK5bKFOen03SYiAHyzA9w9xDGp6zL
         f4K3ss+T77+WaCFWERfCteUAhVEZY2A9F/T3IpLRpBdwNF7iwScNdITpZfAo0Ymbu7
         jaUQAFM0Pp8ziVCRJuOsJbErJmb1Od/zgljbzc/o6YVEK2D5SrlPQVIV/Z4olbJfFE
         PWY+GWRGLNyBOLYCoRhFADk7S2vSsOt38iQZEsJ7GSnFBbkJxOIHBhMDBvNuwchQGu
         SrU+Xkaxq+nkw==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rajat Khandelwal <rajat.khandelwal@linux.intel.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] usb: typec: intel_pmc_mux: select CONFIG_USB_COMMON
Date:   Sat,  5 Aug 2023 11:51:53 +0200
Message-Id: <20230805095157.3459892-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

It is possible to configure the typec drivers to be built-in while the
actual USB host and device support is in loadable modules, but that now
causes a link failure because the usb debugfs support is then not
available to built-in code.

x86_64-linux-ld: drivers/usb/typec/mux/intel_pmc_mux.o: in function `pmc_usb_init':
intel_pmc_mux.c:(.init.text+0x3): undefined reference to `usb_debug_root'

Select CONFIG_USB_COMMON to get it to build again, as we do for
other drivers that require the core usb functionality.

Fixes: 0a453dc9f2602 ("usb: typec: intel_pmc_mux: Expose IOM port status to debugfs")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/usb/typec/mux/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/typec/mux/Kconfig b/drivers/usb/typec/mux/Kconfig
index 784b9d8107e9b..65da61150ba78 100644
--- a/drivers/usb/typec/mux/Kconfig
+++ b/drivers/usb/typec/mux/Kconfig
@@ -29,6 +29,7 @@ config TYPEC_MUX_INTEL_PMC
 	tristate "Intel PMC mux control"
 	depends on ACPI
 	depends on INTEL_SCU_IPC
+	select USB_COMMON
 	select USB_ROLE_SWITCH
 	help
 	  Driver for USB muxes controlled by Intel PMC FW. Intel PMC FW can
-- 
2.39.2

