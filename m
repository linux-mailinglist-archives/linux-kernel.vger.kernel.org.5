Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E68657FAF36
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 01:46:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234088AbjK1AqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 19:46:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjK1AqE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 19:46:04 -0500
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2577E1B1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 16:46:06 -0800 (PST)
Received: from local
        by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
         (Exim 4.96.2)
        (envelope-from <daniel@makrotopia.org>)
        id 1r7mEg-0001sM-2y;
        Tue, 28 Nov 2023 00:46:00 +0000
Date:   Tue, 28 Nov 2023 00:45:54 +0000
From:   Daniel Golle <daniel@makrotopia.org>
To:     Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] ubi: don't decrease ubi->ref_count on detach error
Message-ID: <8d48839a1bf928886e86de8fdc09dc0676fc187f.1701132215.git.daniel@makrotopia.org>
References: <771902199.32600.1701116758852.JavaMail.zimbra@nod.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <771902199.32600.1701116758852.JavaMail.zimbra@nod.at>
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
despite the error. Rework detach function to only decrease the reference
counter once all conditions for detachment are met.

Fixes: cdfa788acd13 ("UBI: prepare attach and detach functions")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
v2: also catch negative ref_count and add ubi_assert as suggested

 drivers/mtd/ubi/build.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
index 7d4ff1193db6f..2316f6014c7f5 100644
--- a/drivers/mtd/ubi/build.c
+++ b/drivers/mtd/ubi/build.c
@@ -1099,16 +1099,17 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
 
 	spin_lock(&ubi_devices_lock);
 	put_device(&ubi->dev);
-	ubi->ref_count -= 1;
-	if (ubi->ref_count) {
+	if (ubi->ref_count != 1) {
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
+	ubi_assert(ubi->ref_count == 0);
 	ubi_devices[ubi_num] = NULL;
 	spin_unlock(&ubi_devices_lock);
 
-- 
2.43.0
