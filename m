Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EC487F0D43
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 09:15:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232132AbjKTIPm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 03:15:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231961AbjKTIPk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 03:15:40 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9DC8E3;
        Mon, 20 Nov 2023 00:15:36 -0800 (PST)
X-UUID: f57e8d96877c11ee8051498923ad61e6-20231120
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=gOyV7oyMcgtsdiiZoqdhbM1wgRqgyD1NDFS9BZZbeFU=;
        b=OF206enX58UNgDi8aKZAHOXlYyQLxHLH0xAkx+b89Ed2Q9vIIyqcQ8ZtqVCcWy0t39ZOPH2CrRSbGIcOCOhRG5QkbL0CMD57WZwFwzIF+BwKcw+E/dwWtrZ5f23S7GvdenfGfJbX/xvW+k7pMVej5ICrj2NwL3WjY9YjL4hd6TU=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:6e73a9c4-6e8b-4f8e-a22d-7db1bce44555,IP:0,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:-5
X-CID-META: VersionHash:364b77b,CLOUDID:30349795-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-UUID: f57e8d96877c11ee8051498923ad61e6-20231120
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <chris.feng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 291217344; Mon, 20 Nov 2023 16:15:25 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 20 Nov 2023 16:15:24 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 20 Nov 2023 16:15:23 +0800
From:   Chris Feng <chris.feng@mediatek.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@kernel.org>, <hua.yang@mediatek.com>,
        <ting.wang@mediatek.com>, <liang.lu@mediatek.com>,
        <chetan.kumar@mediatek.com>, Chris Feng <chris.feng@mediatek.com>
Subject: [PATCH v2] PM: hibernate: Fix the bug where wake events cannot wake system during hibernation
Date:   Mon, 20 Nov 2023 16:15:16 +0800
Message-ID: <20231120081516.55172-1-chris.feng@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wake-up events that occur in the hibernation process's
hibernation_platform_enter() cannot wake up the system. Although the
current hibernation framework will execute part of the recovery process
after a wake-up event occurs, it ultimately performs a shutdown operation
because the system does not check the return value of
hibernation_platform_enter(). Moreover, when restoring the device before
system shutdown, the device's I/O and DMA capabilities will be turned on,
which can lead to data loss.

To solve this problem, check the return value of
hibernation_platform_enter(). When it returns -EAGAIN or -EBUSY, execute
the hibernation recovery process, discard the previously saved image, and
ultimately return to the working state.

Signed-off-by: Chris Feng <chris.feng@mediatek.com>
---
[PATCH v2]:
 - Execute the hibernation recovery process and return to the working state
   when the return value of the function hibernation_platform_enter() is
   -EAGAIN or -EBUSY. Both of the two values may indicate the occurrence of
   a wake-up event.
---
 kernel/power/hibernate.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 8d35b9f9aaa3..7e39a9baca9e 100644
--- a/kernel/power/hibernate.c
+++ b/kernel/power/hibernate.c
@@ -642,9 +642,9 @@ int hibernation_platform_enter(void)
  */
 static void power_down(void)
 {
-#ifdef CONFIG_SUSPEND
 	int error;
 
+#ifdef CONFIG_SUSPEND
 	if (hibernation_mode == HIBERNATION_SUSPEND) {
 		error = suspend_devices_and_enter(mem_sleep_current);
 		if (error) {
@@ -667,7 +667,13 @@ static void power_down(void)
 		kernel_restart(NULL);
 		break;
 	case HIBERNATION_PLATFORM:
-		hibernation_platform_enter();
+		error = hibernation_platform_enter();
+		if (error == -EAGAIN || error == -EBUSY) {
+			swsusp_unmark();
+			events_check_enabled = false;
+			pr_err("Hibernation Abort.\n");
+			return;
+		}
 		fallthrough;
 	case HIBERNATION_SHUTDOWN:
 		if (kernel_can_power_off())
-- 
2.17.0

