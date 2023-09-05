Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F2BE7925C5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:24:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347528AbjIEQR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244933AbjIEBhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 21:37:13 -0400
Received: from hust.edu.cn (unknown [202.114.0.240])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2210ACC6;
        Mon,  4 Sep 2023 18:37:08 -0700 (PDT)
Received: from localhost.localdomain ([172.16.0.254])
        (user=dzm91@hust.edu.cn mech=LOGIN bits=0)
        by mx1.hust.edu.cn  with ESMTP id 3851Zw19019535-3851Zw1A019535
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Tue, 5 Sep 2023 09:36:08 +0800
From:   Dongliang Mu <dzm91@hust.edu.cn>
To:     =?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
        Kalle Valo <kvalo@kernel.org>
Cc:     hust-os-kernel-patches@googlegroups.com,
        Dongliang Mu <dzm91@hust.edu.cn>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ath9k: clean up function ath9k_hif_usb_resume
Date:   Tue,  5 Sep 2023 09:35:56 +0800
Message-Id: <20230905013556.2595854-1-dzm91@hust.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-FEAS-AUTH-USER: dzm91@hust.edu.cn
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In ath9k_hif_usb_resume, the error handling code calls
ath9k_hif_usb_dealloc_urbs twice in different paths.

To unify the error handling code, we move the else branch before
the if branch and drop one level of indentation of the if branch.

In addition, move the ret variable at the end of variable declarations
to be reverse x-mas tree order.

Note that this patch does not incur any functionability change.

Signed-off-by: Dongliang Mu <dzm91@hust.edu.cn>
---
 drivers/net/wireless/ath/ath9k/hif_usb.c | 34 ++++++++++++------------
 1 file changed, 17 insertions(+), 17 deletions(-)

v1->v2: move the else branch on top of if branch;
        move ret variable at the end of variable declarations;

diff --git a/drivers/net/wireless/ath/ath9k/hif_usb.c b/drivers/net/wireless/ath/ath9k/hif_usb.c
index e5414435b141..90cfe39aa433 100644
--- a/drivers/net/wireless/ath/ath9k/hif_usb.c
+++ b/drivers/net/wireless/ath/ath9k/hif_usb.c
@@ -1481,31 +1481,31 @@ static int ath9k_hif_usb_resume(struct usb_interface *interface)
 {
 	struct hif_device_usb *hif_dev = usb_get_intfdata(interface);
 	struct htc_target *htc_handle = hif_dev->htc_handle;
-	int ret;
 	const struct firmware *fw;
+	int ret;
 
 	ret = ath9k_hif_usb_alloc_urbs(hif_dev);
 	if (ret)
 		return ret;
 
-	if (hif_dev->flags & HIF_USB_READY) {
-		/* request cached firmware during suspend/resume cycle */
-		ret = request_firmware(&fw, hif_dev->fw_name,
-				       &hif_dev->udev->dev);
-		if (ret)
-			goto fail_resume;
-
-		hif_dev->fw_data = fw->data;
-		hif_dev->fw_size = fw->size;
-		ret = ath9k_hif_usb_download_fw(hif_dev);
-		release_firmware(fw);
-		if (ret)
-			goto fail_resume;
-	} else {
-		ath9k_hif_usb_dealloc_urbs(hif_dev);
-		return -EIO;
+	if (!(hif_dev->flags & HIF_USB_READY)) {
+		ret = -EIO;
+		goto fail_resume;
 	}
 
+	/* request cached firmware during suspend/resume cycle */
+	ret = request_firmware(&fw, hif_dev->fw_name,
+			       &hif_dev->udev->dev);
+	if (ret)
+		goto fail_resume;
+
+	hif_dev->fw_data = fw->data;
+	hif_dev->fw_size = fw->size;
+	ret = ath9k_hif_usb_download_fw(hif_dev);
+	release_firmware(fw);
+	if (ret)
+		goto fail_resume;
+
 	mdelay(100);
 
 	ret = ath9k_htc_resume(htc_handle);
-- 
2.25.1

