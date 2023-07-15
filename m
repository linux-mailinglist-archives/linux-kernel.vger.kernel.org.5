Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECEC754A29
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 18:42:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229981AbjGOQmJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 12:42:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGOQmI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 12:42:08 -0400
Received: from unicorn.mansr.com (unicorn.mansr.com [81.2.72.234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDFA62121;
        Sat, 15 Jul 2023 09:42:05 -0700 (PDT)
Received: from raven.mansr.com (raven.mansr.com [81.2.72.235])
        by unicorn.mansr.com (Postfix) with ESMTPS id 31D3015360;
        Sat, 15 Jul 2023 17:42:01 +0100 (BST)
Received: by raven.mansr.com (Postfix, from userid 51770)
        id D6EA3220D45; Sat, 15 Jul 2023 17:42:00 +0100 (BST)
From:   Mans Rullgard <mans@mansr.com>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc:     linux-bluetooth@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] Bluetooth: btbcm: add default address for BCM43430A1
Date:   Sat, 15 Jul 2023 17:41:59 +0100
Message-ID: <20230715164159.16368-1-mans@mansr.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM43430A1 has a default MAC address of AA:AA:AA:AA:AA:AA.
Although, unlike some other entries, this does not include the
chip name, it is clearly not a real address. This was found in
AzureWave AW-NB197SM and AW-NM372SM modules.

Signed-off-by: Mans Rullgard <mans@mansr.com>
---
 drivers/bluetooth/btbcm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/bluetooth/btbcm.c b/drivers/bluetooth/btbcm.c
index de2ea589aa49..0a5445ac5e1b 100644
--- a/drivers/bluetooth/btbcm.c
+++ b/drivers/bluetooth/btbcm.c
@@ -24,6 +24,7 @@
 #define BDADDR_BCM20702A1 (&(bdaddr_t) {{0x00, 0x00, 0xa0, 0x02, 0x70, 0x20}})
 #define BDADDR_BCM2076B1 (&(bdaddr_t) {{0x79, 0x56, 0x00, 0xa0, 0x76, 0x20}})
 #define BDADDR_BCM43430A0 (&(bdaddr_t) {{0xac, 0x1f, 0x12, 0xa0, 0x43, 0x43}})
+#define BDADDR_BCM43430A1 (&(bdaddr_t) {{0xaa, 0xaa, 0xaa, 0xaa, 0xaa, 0xaa}})
 #define BDADDR_BCM4324B3 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb3, 0x24, 0x43}})
 #define BDADDR_BCM4330B1 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb1, 0x30, 0x43}})
 #define BDADDR_BCM4334B0 (&(bdaddr_t) {{0x00, 0x00, 0x00, 0xb0, 0x34, 0x43}})
@@ -115,6 +116,9 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	 *
 	 * The address 43:43:A0:12:1F:AC indicates a BCM43430A0 controller
 	 * with no configured address.
+	 *
+	 * The address AA:AA:AA:AA:AA:AA indicates a BCM43430A1 controller
+	 * with no configured address.
 	 */
 	if (!bacmp(&bda->bdaddr, BDADDR_BCM20702A0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM20702A1) ||
@@ -124,6 +128,7 @@ int btbcm_check_bdaddr(struct hci_dev *hdev)
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4334B0) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM4345C5) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A0) ||
+	    !bacmp(&bda->bdaddr, BDADDR_BCM43430A1) ||
 	    !bacmp(&bda->bdaddr, BDADDR_BCM43341B)) {
 		/* Try falling back to BDADDR EFI variable */
 		if (btbcm_set_bdaddr_from_efi(hdev) != 0) {
-- 
2.41.0

