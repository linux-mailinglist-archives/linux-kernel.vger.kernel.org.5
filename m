Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05275760BE5
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 09:34:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232548AbjGYHec (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 03:34:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231825AbjGYHd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 03:33:58 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 582BAE5;
        Tue, 25 Jul 2023 00:31:31 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 36P7V0No8028318, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 36P7V0No8028318
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Tue, 25 Jul 2023 15:31:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 25 Jul 2023 15:31:11 +0800
Received: from fc38.localdomain (172.22.228.98) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 25 Jul
 2023 15:31:10 +0800
From:   Hayes Wang <hayeswang@realtek.com>
To:     <kuba@kernel.org>, <davem@davemloft.net>
CC:     <netdev@vger.kernel.org>, <nic_swsd@realtek.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        Hayes Wang <hayeswang@realtek.com>
Subject: [PATCH net-next 1/2] r8152: adjust generic_ocp_write function
Date:   Tue, 25 Jul 2023 15:30:49 +0800
Message-ID: <20230725073051.5150-415-nic_swsd@realtek.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725073051.5150-414-nic_swsd@realtek.com>
References: <20230725073051.5150-414-nic_swsd@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.22.228.98]
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reduce the control transfer if all bytes of first or the last DWORD are
writed.

The original method is to split the control transfer into three parts
(the first DWORD, middle continuous data, and the last DWORD). However,
they could be combined if whole bytes of the first DWORD or last DWORD
are writed. That is, the first DWORD or the last DWORD could be combined
with the middle continuous data, if the byte_en is 0xff.

Signed-off-by: Hayes Wang <hayeswang@realtek.com>
---
 drivers/net/usb/r8152.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/usb/r8152.c b/drivers/net/usb/r8152.c
index 0738baa5b82e..f6578a99dbac 100644
--- a/drivers/net/usb/r8152.c
+++ b/drivers/net/usb/r8152.c
@@ -1314,16 +1314,24 @@ static int generic_ocp_write(struct r8152 *tp, u16 index, u16 byteen,
 	byteen_end = byteen & BYTE_EN_END_MASK;
 
 	byen = byteen_start | (byteen_start << 4);
-	ret = set_registers(tp, index, type | byen, 4, data);
-	if (ret < 0)
-		goto error1;
 
-	index += 4;
-	data += 4;
-	size -= 4;
+	/* Split the first DWORD if the byte_en is not 0xff */
+	if (byen != BYTE_EN_DWORD) {
+		ret = set_registers(tp, index, type | byen, 4, data);
+		if (ret < 0)
+			goto error1;
 
-	if (size) {
+		index += 4;
+		data += 4;
 		size -= 4;
+	}
+
+	if (size) {
+		byen = byteen_end | (byteen_end >> 4);
+
+		/* Split the last DWORD if the byte_en is not 0xff */
+		if (byen != BYTE_EN_DWORD)
+			size -= 4;
 
 		while (size) {
 			if (size > limit) {
@@ -1350,10 +1358,9 @@ static int generic_ocp_write(struct r8152 *tp, u16 index, u16 byteen,
 			}
 		}
 
-		byen = byteen_end | (byteen_end >> 4);
-		ret = set_registers(tp, index, type | byen, 4, data);
-		if (ret < 0)
-			goto error1;
+		/* Set the last DWORD */
+		if (byen != BYTE_EN_DWORD)
+			ret = set_registers(tp, index, type | byen, 4, data);
 	}
 
 error1:
-- 
2.41.0

