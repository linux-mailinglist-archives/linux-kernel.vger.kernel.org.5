Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA728802A2F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:13:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234338AbjLDCMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:12:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjLDCMD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:12:03 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86A70A6;
        Sun,  3 Dec 2023 18:12:04 -0800 (PST)
X-UUID: 817d2c30924a11eea33bb35ae8d461a2-20231204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4GRydfxG3cefQIfwSut+tvgAh8wbIDFhzsR+NOMlM48=;
        b=C5pJ1K3eVv9DxF9Ppq/23/NyKDmVmIEqLwOdwyBxW7KUK0XIvGzBANJkT8Do6RRdOjwQJASNmXE+M6sICkhYQyPHYm+bE5J4XvyyeZiS09dbBASXUJfAFMSw3smfhZZH9LLrNGl9CLbS3UUXJ0PrRmPxROOQXZ+thl8YN10X8Qc=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.34,REQID:23bfd3b7-834c-41c6-8803-6080a06398df,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:abefa75,CLOUDID:b681c560-c89d-4129-91cb-8ebfae4653fc,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:NO,
        DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULS
X-UUID: 817d2c30924a11eea33bb35ae8d461a2-20231204
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <chris.feng@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1845323155; Mon, 04 Dec 2023 10:11:59 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 4 Dec 2023 10:11:58 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 4 Dec 2023 10:11:57 +0800
From:   Chris Feng <chris.feng@mediatek.com>
To:     <rafael@kernel.org>, <pavel@ucw.cz>, <len.brown@intel.com>
CC:     <linux-pm@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <stable@kernel.org>, <hua.yang@mediatek.com>,
        <ting.wang@mediatek.com>, <liang.lu@mediatek.com>,
        <chetan.kumar@mediatek.com>, Chris Feng <chris.feng@mediatek.com>
Subject: [PATCH RESEND v3] PM: hibernate: Avoid missing wakeup events during hibernation
Date:   Mon, 4 Dec 2023 10:11:55 +0800
Message-ID: <20231204021155.10434-1-chris.feng@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wakeup events that occur in the hibernation process's
hibernation_platform_enter() cannot wake up the system. Although the
current hibernation framework will execute part of the recovery process
after a wakeup event occurs, it ultimately performs a shutdown operation
because the system does not check the return value of
hibernation_platform_enter(). In short, if a wakeup event occurs before
putting the system into the final low-power state, it will be missed.

To solve this problem, check the return value of
hibernation_platform_enter(). When it returns -EAGAIN or -EBUSY (indicate
the occurrence of a wakeup event), execute the hibernation recovery
process, discard the previously saved image, and ultimately return to the
working state.

Signed-off-by: Chris Feng <chris.feng@mediatek.com>
---
[PATCH v2]:
 - Optimize the "if" condition logic.
 - Link to v1: https://lore.kernel.org/all/20231024091447.108072-1-chris.feng@mediatek.com
[PATCH v3]:
 - Use pr_info instead of pr_err.
 - Fix undeclared function 'swsusp_unmark' build error.
 - Refine commit and printing message.
 - Change the subject.
 - Link to v2: https://lore.kernel.org/all/20231120081516.55172-1-chris.feng@mediatek.com
---
 kernel/power/hibernate.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/kernel/power/hibernate.c b/kernel/power/hibernate.c
index 8d35b9f9aaa3..fb3b63e178b0 100644
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
@@ -667,7 +667,15 @@ static void power_down(void)
 		kernel_restart(NULL);
 		break;
 	case HIBERNATION_PLATFORM:
-		hibernation_platform_enter();
+		error = hibernation_platform_enter();
+		if (error == -EAGAIN || error == -EBUSY) {
+#ifdef CONFIG_SUSPEND
+			swsusp_unmark();
+#endif
+			events_check_enabled = false;
+			pr_info("Hibernation process aborted due to detected wakeup event.\n");
+			return;
+		}
 		fallthrough;
 	case HIBERNATION_SHUTDOWN:
 		if (kernel_can_power_off())
-- 
2.17.0

