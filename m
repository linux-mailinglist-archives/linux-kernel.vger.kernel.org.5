Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9535180452B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 03:42:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344150AbjLECly (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 21:41:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbjLEClw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 21:41:52 -0500
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E65CBB6;
        Mon,  4 Dec 2023 18:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
        s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=qooKP
        2HsiHgDqnQG/MiDCCu3acZz5StldDyLPzc3OCc=; b=nao4iG20ZkrbuNumM+J9D
        hRHwv6o8vKXBdTSiEkzro1MhhzIj2p27RBzlQQ3WIDilWZetL3KxwLdNnfrUaajK
        UjuycmyTmWIn2NByA+w9VF0rv01cc4vrZkEDx2ks+uIcVBAJ17+H1BkAmH19N+0s
        A4ba74AIESm6SHTXzlY+Zc=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
        by zwqz-smtp-mta-g5-2 (Coremail) with SMTP id _____wD3PyHjjW5l7XOpEg--.22070S2;
        Tue, 05 Dec 2023 10:41:39 +0800 (CST)
From:   15013537245@163.com
To:     marcel@holtmann.org, johan.hedberg@gmail.com, luiz.dentz@gmail.com
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhongjun.yu@quectel.com, Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: hci_sync: fix BR/EDR wakeup bug
Date:   Tue,  5 Dec 2023 10:41:37 +0800
Message-Id: <20231205024137.601987-1-15013537245@163.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: _____wD3PyHjjW5l7XOpEg--.22070S2
X-Coremail-Antispam: 1Uf129KBjvJXoWrKFWrJFWfArW3Cry8WFW7urg_yoW8JrWxpF
        y2kFZ3trZ5JrWaka43A3W0gFyUAF9YgFs3CFWDt345X3yaqr48trWjkr17WF18CrZ2kF1f
        ZF4UtwsxW34kCa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jvYLkUUUUU=
X-Originating-IP: [223.76.229.213]
X-CM-SenderInfo: rprviiitvtljiuv6il2tof0z/xtbBEgc912VOAxACZAAAsh
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_BL,RCVD_IN_MSPIKE_L4,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Clancy Shang <clancy.shang@quectel.com>

when Bluetooth set the event mask and enter suspend, the controller
has hci mode change event comming,it cause controller can not enter
sleep mode. so it should to set the hci mode change event mask before
enter suspend

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 net/bluetooth/hci_sync.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index a15ab0b874a9..a26a58cb2c38 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3800,12 +3800,14 @@ static int hci_set_event_mask_sync(struct hci_dev *hdev)
 	if (lmp_bredr_capable(hdev)) {
 		events[4] |= 0x01; /* Flow Specification Complete */
 
-		/* Don't set Disconnect Complete when suspended as that
-		 * would wakeup the host when disconnecting due to
-		 * suspend.
+		/* Don't set Disconnect Complete and mode change when
+		 * suspended as that would wakeup the host when disconnecting
+		 * due to suspend.
 		 */
-		if (hdev->suspended)
+		if (hdev->suspended) {
 			events[0] &= 0xef;
+			events[2] &= 0xf7;
+		}
 	} else {
 		/* Use a different default for LE-only devices */
 		memset(events, 0, sizeof(events));
-- 
2.25.1

