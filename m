Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21D6A75C7FE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjGUNj2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:39:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbjGUNjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:39:25 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62BC3E53;
        Fri, 21 Jul 2023 06:39:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1689946763;
  x=1721482763;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=Iw+bltGRYz/2l9De5LyQdFIZrY7VU+/N+bnY6dDOT/s=;
  b=f1bhUSPovjH16UheDK0t7gYO6ocNgpprMYAnpd5KbE/aQbYGcvLg8SP9
   SBBeVXtJtMSK5Ucb3t+DzM7Q2jmVdgAHBAs0vTP3dFLCOC30g3GRZ3xa3
   jQt/UR7Cq0j55/URN20m4YrvMwJiU+eUSWYtQUT8NERECMxgo+hg2LFtc
   Q/GC1cA2HdXrb+ZhVimI5wT+EmP1tXEPu/Q5JKv6LIPrZ5BYdI5+KPT1/
   ZZ4wmyvrunTN5jS8Q9avLY1lL08fMFvywkasrX54bn9fiE6/Zz68Rf1HO
   EZ2LxGfgDloJZ4g5fiLH6nsVGZnCkqmeVknNBH4yD25yA4TieYOULqpcJ
   w==;
From:   Vincent Whitchurch <vincent.whitchurch@axis.com>
Date:   Fri, 21 Jul 2023 15:39:20 +0200
Subject: [PATCH net] net: stmmac: Apply redundant write work around on 4.xx
 too
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20230721-stmmac-tx-workaround-v1-1-9411cbd5ee07@axis.com>
X-B4-Tracking: v=1; b=H4sIAIeKumQC/x3MQQqDMBBA0avIrB0wUQz0KuIixrEOxUQmaRVC7
 m7o8i3+zxBJmCK8mgxCP44cfIVqG3C79W9CXqtBd7rvjFYY03FYh+nGK8jHSvj6FbdFGTMo1+u
 RoKan0Mb3fzuBpwRzKQ+mHijHawAAAA==
To:     Giuseppe Cavallaro <peppe.cavallaro@st.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Jose Abreu <joabreu@synopsys.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        "Jakub Kicinski" <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>
CC:     <netdev@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@axis.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

commit a3a57bf07de23fe1ff779e0fdf710aa581c3ff73 ("net: stmmac: work
around sporadic tx issue on link-up") worked around a problem with TX
sometimes not working after a link-up by avoiding a redundant write to
MAC_CTRL_REG (aka GMAC_CONFIG), since the IP appeared to have problems
with handling multiple writes to that register in some cases.

That commit however only added the work around to dwmac_lib.c (apart
from the common code in stmmac_main.c), but my systems with version
4.21a of the IP exhibit the same problem, so add the work around to
dwmac4_lib.c too.

Fixes: a3a57bf07de2 ("net: stmmac: work around sporadic tx issue on link-up")
Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
index df41eac54058..03ceb6a94073 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac4_lib.c
@@ -240,13 +240,15 @@ void stmmac_dwmac4_set_mac_addr(void __iomem *ioaddr, const u8 addr[6],
 void stmmac_dwmac4_set_mac(void __iomem *ioaddr, bool enable)
 {
 	u32 value = readl(ioaddr + GMAC_CONFIG);
+	u32 old_val = value;
 
 	if (enable)
 		value |= GMAC_CONFIG_RE | GMAC_CONFIG_TE;
 	else
 		value &= ~(GMAC_CONFIG_TE | GMAC_CONFIG_RE);
 
-	writel(value, ioaddr + GMAC_CONFIG);
+	if (value != old_val)
+		writel(value, ioaddr + GMAC_CONFIG);
 }
 
 void stmmac_dwmac4_get_mac_addr(void __iomem *ioaddr, unsigned char *addr,

---
base-commit: fdf0eaf11452d72945af31804e2a1048ee1b574c
change-id: 20230721-stmmac-tx-workaround-fb17741c326e

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>

