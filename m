Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781467FA79A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 18:09:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343495AbjK0RJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 12:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234700AbjK0RJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 12:09:26 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E981010F6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 09:09:31 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r7f6n-000892-22;
        Mon, 27 Nov 2023 17:09:22 +0000
Date:   Mon, 27 Nov 2023 17:09:14 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     John Crispin <john@phrozen.org>
Subject: [PATCH] ubi: don't decrease ubi->ref_count on detach error
Message-ID: <9857609999c5b7196417474938a7a09892cd1612.1701104870.git.daniel@makrotopia.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If attempting to detach a UBI device while it is still busy, detaching
is refused. However, the reference counter is still being decreased
despite the error. Rework detach function to only decrease the refcnt
once all conditions for detachment are met.

Fixes: cdfa788acd13 ("UBI: prepare attach and detach functions")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/mtd/ubi/build.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 7d4ff1193db6f..f47987ee9a31b 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1099,16 +1099,16 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 
 	spin_lock(&ubi_devices_lock);
 	put_device(&ubi->dev);
-	ubi->ref_count -= 1;
-	if (ubi->ref_count) {
+	if (ubi->ref_count > 1) {
 		if (!anyway) {
 			spin_unlock(&ubi_devices_lock);
 			return -EBUSY;
 		}
 		/* This may only happen if there is a bug */
 		ubi_err(ubi, "%s reference count %d, destroy anyway",
-			ubi->ubi_name, ubi->ref_count);
+			ubi->ubi_name, ubi->ref_count - 1);
 	}
+	ubi->ref_count -= 1;
 	ubi_devices[ubi_num] = NULL;
 	spin_unlock(&ubi_devices_lock);
 
-- 
2.43.0
