Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394C07A72C9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 08:30:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233141AbjITGad (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 02:30:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230447AbjITGab (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 02:30:31 -0400
Received: from out28-77.mail.aliyun.com (out28-77.mail.aliyun.com [115.124.28.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958CA9F;
        Tue, 19 Sep 2023 23:30:24 -0700 (PDT)
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.2589378|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.00268874-0.000101508-0.99721;FP=0|0|0|0|0|-1|-1|-1;HT=ay29a033018047208;MF=michael@allwinnertech.com;NM=1;PH=DS;RN=5;RT=5;SR=0;TI=SMTPD_---.Ujk16e._1695191419;
Received: from SunxiBot.allwinnertech.com(mailfrom:michael@allwinnertech.com fp:SMTPD_---.Ujk16e._1695191419)
          by smtp.aliyun-inc.com;
          Wed, 20 Sep 2023 14:30:20 +0800
From:   Michael Wu <michael@allwinnertech.com>
To:     linux@roeck-us.net, heikki.krogerus@linux.intel.com,
        gregkh@linuxfoundation.org
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [RESEND v2] usb:typec:tcpm:support double Rp to Vbus cable as sink
Date:   Wed, 20 Sep 2023 14:30:30 +0800
Message-Id: <20230920063030.66312-1-michael@allwinnertech.com>
X-Mailer: git-send-email 2.29.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The USB Type-C Cable and Connector Specification defines the wire
connections for the USB Type-C to USB 2.0 Standard-A cable assembly
(Release 2.2, Chapter 3.5.2).
The Notes says that Pin A5 (CC) of the USB Type-C plug shall be connected
to Vbus through a resister Rp.
However, there is a large amount of such double Rp connected to Vbus
non-standard cables which produced by UGREEN circulating on the market, and
it can affects the normal operations of the state machine easily,
especially to CC1 and CC2 be pulled up at the same time.
In fact, we can regard those cables as sink to avoid abnormal state.

Message as follow:
[   58.900212] VBUS on
[   59.265433] CC1: 0 -> 3, CC2: 0 -> 3 [state TOGGLING, polarity 0, connected]
[   62.623308] CC1: 3 -> 0, CC2: 3 -> 0 [state TOGGLING, polarity 0, disconnected]
[   62.625006] VBUS off
[   62.625012] VBUS VSAFE0V

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
v1 -> v2: Simplify expression and add a comment to the code.

 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Signed-off-by: Michael Wu <michael@allwinnertech.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index d962f67c95ae6..6e843c511b856 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -517,9 +517,9 @@ static const char * const pd_rev[] = {
 	((cc) == TYPEC_CC_RP_DEF || (cc) == TYPEC_CC_RP_1_5 || \
 	 (cc) == TYPEC_CC_RP_3_0)
 
+/* As long as cc is pulled up, we can consider it as sink. */
 #define tcpm_port_is_sink(port) \
-	((tcpm_cc_is_sink((port)->cc1) && !tcpm_cc_is_sink((port)->cc2)) || \
-	 (tcpm_cc_is_sink((port)->cc2) && !tcpm_cc_is_sink((port)->cc1)))
+	(tcpm_cc_is_sink((port)->cc1) || tcpm_cc_is_sink((port)->cc2))
 
 #define tcpm_cc_is_source(cc) ((cc) == TYPEC_CC_RD)
 #define tcpm_cc_is_audio(cc) ((cc) == TYPEC_CC_RA)
-- 
2.29.0

