Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F24D47D1F00
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 20:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231678AbjJUS65 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 14:58:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbjJUS6y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 14:58:54 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E36FA;
        Sat, 21 Oct 2023 11:58:52 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C271C6343CB4;
        Sat, 21 Oct 2023 20:58:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id P-b8PQmRRzfA; Sat, 21 Oct 2023 20:58:50 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5BA596343CB5;
        Sat, 21 Oct 2023 20:58:50 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id WHulukewPv4l; Sat, 21 Oct 2023 20:58:50 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 0B96B6343CB4;
        Sat, 21 Oct 2023 20:58:50 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, vigneshr@ti.com, richard@nod.at,
        miquel.raynal@bootlin.com, joern@lazybastard.org,
        Christoph Hellwig <hch@lst.de>, stable@vger.kernel.org
Subject: [PATCH] mtd: block2mtd: Add a valid holder to blkdev_put()
Date:   Sat, 21 Oct 2023 20:58:32 +0200
Message-Id: <20231021185832.25592-1-richard@nod.at>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit 2736e8eeb0ccd ("block: use the holder as indication for excl=
usive opens")
blkdev_put() requires a valid holder argument.
So, do so also in block2mtd to unbreak bdev->bd_holder refcounting.

Cc: Christoph Hellwig <hch@lst.de>
Cc: stable@vger.kernel.org
Fixes: 2736e8eeb0ccd ("block: use the holder as indication for exclusive =
opens")
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/devices/block2mtd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2=
mtd.c
index be106dc20ff3c..8c37650bbce45 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -209,7 +209,7 @@ static void block2mtd_free_device(struct block2mtd_de=
v *dev)
 	if (dev->blkdev) {
 		invalidate_mapping_pages(dev->blkdev->bd_inode->i_mapping,
 					0, -1);
-		blkdev_put(dev->blkdev, NULL);
+		blkdev_put(dev->blkdev, dev);
 	}
=20
 	kfree(dev);
--=20
2.35.3

