Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A336E76B8EC
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 17:45:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232905AbjHAPpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 11:45:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjHAPpT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 11:45:19 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7D7ADA
        for <linux-kernel@vger.kernel.org>; Tue,  1 Aug 2023 08:45:17 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qQrY8-0003zX-QC; Tue, 01 Aug 2023 17:44:40 +0200
Received: from [2a0a:edc0:0:1101:1d::39] (helo=dude03.red.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qQrY5-000Q2m-ON; Tue, 01 Aug 2023 17:44:37 +0200
Received: from localhost ([::1] helo=dude03.red.stw.pengutronix.de)
        by dude03.red.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <j.zink@pengutronix.de>)
        id 1qQrY4-00Bf3I-3L; Tue, 01 Aug 2023 17:44:36 +0200
From:   Johannes Zink <j.zink@pengutronix.de>
Subject: [PATCH v3 0/2] net: stmmac: correct MAC propagation delay
Date:   Tue, 01 Aug 2023 17:44:28 +0200
Message-Id: <20230719-stmmac_correct_mac_delay-v3-0-61e63427735e@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFwoyWQC/42NzQqDMBAGX0VybopJJJqe+h6lSH5WDWgiiYoiv
 nuj11687XywMzuKECxE9Mp2FGCx0XqXgD0ypDvpWsDWJEY0pywvicBxGgapa+1DAD3V522glxs
 uaFlpJYxQmqD0rmQErIJ0uksCN/d9GscAjV2v3uebuLNx8mG78gs51xulhWCCS15JWZhcMFa8R
 3DtPAXv7Po0gE7zQu/aaLIxxnnDKgAh+Z/tOI4ff9A1eSgBAAA=
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Russell King <linux@armlinux.org.uk>
Cc:     patchwork-jzi@pengutronix.de, netdev@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, Kurt Kanzenbach <kurt@linutronix.de>,
        kernel test robot <lkp@intel.com>,
        Johannes Zink <j.zink@pengutronix.de>
X-Mailer: b4 0.12.2
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


---
Changes in v3:
- work in Richard's review feedback. Thank you for reviewing my patch:
  - as some of the hardware may have no or invalid correction value
    registers: introduce feature switch which can be enabled in the glue
    code drivers depending on the actual hardware support
  - only enable the feature on the i.MX8MP for the time being, as the patch
    improves timing accuracy and is tested for this hardware
- Link to v2: https://lore.kernel.org/r/20230719-stmmac_correct_mac_delay-v2-1-3366f38ee9a6@pengutronix.de

Changes in v2:
- fix builds for 32bit, this was found by the kernel build bot
	Reported-by: kernel test robot <lkp@intel.com>
	Closes: https://lore.kernel.org/oe-kbuild-all/202307200225.B8rmKQPN-lkp@intel.com/
- while at it also fix an overflow by shifting a u32 constant from macro by 10bits
  by casting the constant to u64
- Link to v1: https://lore.kernel.org/r/20230719-stmmac_correct_mac_delay-v1-1-768aa4d09334@pengutronix.de

---
Johannes Zink (2):
      net: stmmac: correct MAC propagation delay
      net: stmmac: dwmac-imx: enable MAC propagation delay correction for i.MX8MP

 drivers/net/ethernet/stmicro/stmmac/dwmac-imx.c    |  5 +++
 drivers/net/ethernet/stmicro/stmmac/hwif.h         |  3 ++
 .../net/ethernet/stmicro/stmmac/stmmac_hwtstamp.c  | 43 ++++++++++++++++++++++
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c  |  6 +++
 drivers/net/ethernet/stmicro/stmmac/stmmac_ptp.h   |  6 +++
 include/linux/stmmac.h                             |  1 +
 6 files changed, 64 insertions(+)
---
base-commit: 01e6f8ad8d26ced14b0cf288c42e55d03a7c5070
change-id: 20230719-stmmac_correct_mac_delay-4278cb9d9bc1

Best regards,
-- 
Johannes Zink <j.zink@pengutronix.de>

