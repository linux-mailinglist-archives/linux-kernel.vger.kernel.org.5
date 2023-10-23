Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70B987D2C1D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 10:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbjJWICs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 04:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJWICr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 04:02:47 -0400
Received: from TWMBX02.aspeed.com (mail.aspeedtech.com [211.20.114.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BB4A6
        for <linux-kernel@vger.kernel.org>; Mon, 23 Oct 2023 01:02:43 -0700 (PDT)
Received: from TWMBX02.aspeed.com (192.168.0.24) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Mon, 23 Oct
 2023 16:02:38 +0800
Received: from twmbx02.aspeed.com (192.168.10.10) by TWMBX02.aspeed.com
 (192.168.0.24) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 23 Oct 2023 16:02:38 +0800
From:   Billy Tsai <billy_tsai@aspeedtech.com>
To:     <alexandre.belloni@bootlin.com>, <billy_tsai@aspeedtech.com>,
        <linux-i3c@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH v1] i3c/master/mipi-i3c-hci: Fix a kernel panic for accessing DAT_data.
Date:   Mon, 23 Oct 2023 16:02:37 +0800
Message-ID: <20231023080237.560936-1-billy_tsai@aspeedtech.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
Received-SPF: Fail (TWMBX02.aspeed.com: domain of billy_tsai@aspeedtech.com
 does not designate 192.168.10.10 as permitted sender)
 receiver=TWMBX02.aspeed.com; client-ip=192.168.10.10;
 helo=twmbx02.aspeed.com;
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_FAIL,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The `i3c_master_bus_init` function may attach the I2C devices before the
I3C bus initialization. In this flow, the DAT `alloc_entry`` will be used
before the DAT `init`. Additionally, if the `i3c_master_bus_init` fails,
the DAT `cleanup` will execute before the device is detached, which will
execue DAT `free_entry` function. The above scenario can cause the driver
to use DAT_data when it is NULL.

Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
---
 drivers/i3c/master/mipi-i3c-hci/dat_v1.c | 29 ++++++++++++++++--------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
index 97bb49ff5b53..47b9b4d4ed3f 100644
--- a/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
+++ b/drivers/i3c/master/mipi-i3c-hci/dat_v1.c
@@ -64,15 +64,17 @@ static int hci_dat_v1_init(struct i3c_hci *hci)
 		return -EOPNOTSUPP;
 	}
 
-	/* use a bitmap for faster free slot search */
-	hci->DAT_data = bitmap_zalloc(hci->DAT_entries, GFP_KERNEL);
-	if (!hci->DAT_data)
-		return -ENOMEM;
-
-	/* clear them */
-	for (dat_idx = 0; dat_idx < hci->DAT_entries; dat_idx++) {
-		dat_w0_write(dat_idx, 0);
-		dat_w1_write(dat_idx, 0);
+	if (!hci->DAT_data) {
+		/* use a bitmap for faster free slot search */
+		hci->DAT_data = bitmap_zalloc(hci->DAT_entries, GFP_KERNEL);
+		if (!hci->DAT_data)
+			return -ENOMEM;
+
+		/* clear them */
+		for (dat_idx = 0; dat_idx < hci->DAT_entries; dat_idx++) {
+			dat_w0_write(dat_idx, 0);
+			dat_w1_write(dat_idx, 0);
+		}
 	}
 
 	return 0;
@@ -87,7 +89,13 @@ static void hci_dat_v1_cleanup(struct i3c_hci *hci)
 static int hci_dat_v1_alloc_entry(struct i3c_hci *hci)
 {
 	unsigned int dat_idx;
+	int ret;
 
+	if (!hci->DAT_data) {
+		ret = hci_dat_v1_init(hci);
+		if (ret)
+			return ret;
+	}
 	dat_idx = find_first_zero_bit(hci->DAT_data, hci->DAT_entries);
 	if (dat_idx >= hci->DAT_entries)
 		return -ENOENT;
@@ -103,7 +111,8 @@ static void hci_dat_v1_free_entry(struct i3c_hci *hci, unsigned int dat_idx)
 {
 	dat_w0_write(dat_idx, 0);
 	dat_w1_write(dat_idx, 0);
-	__clear_bit(dat_idx, hci->DAT_data);
+	if (hci->DAT_data)
+		__clear_bit(dat_idx, hci->DAT_data);
 }
 
 static void hci_dat_v1_set_dynamic_addr(struct i3c_hci *hci,
-- 
2.25.1

