Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75E8D777D17
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236350AbjHJQBG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:01:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236310AbjHJQAt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:00:49 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42A172702;
        Thu, 10 Aug 2023 09:00:47 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0E84B635D29A;
        Thu, 10 Aug 2023 18:00:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id i2OBkMkvY2wu; Thu, 10 Aug 2023 18:00:45 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id B1424635D2A8;
        Thu, 10 Aug 2023 18:00:45 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id vNycAkqY1e7l; Thu, 10 Aug 2023 18:00:45 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 55000635D296;
        Thu, 10 Aug 2023 18:00:45 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     linux-mtd@lists.infradead.org
Cc:     Christoph Hellwig <hch@infradead.org>,
        Stephan Wurm <stephan.wurm@a-eberle.de>,
        Richard Weinberger <richard@nod.at>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: [PATCH 5/7] scsi: fdomain: Switch to kmap_sg
Date:   Thu, 10 Aug 2023 18:00:16 +0200
Message-Id: <20230810160019.16977-6-richard@nod.at>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230810160019.16977-1-richard@nod.at>
References: <20230810160019.16977-1-richard@nod.at>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Switch to our new helper from scatterlist lib.
No functional change, the mapped region is still used in atomic
context.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/scsi/fdomain.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/fdomain.c b/drivers/scsi/fdomain.c
index 504c4e0c5d17a..5d58a9ec1c66a 100644
--- a/drivers/scsi/fdomain.c
+++ b/drivers/scsi/fdomain.c
@@ -223,15 +223,14 @@ static void fdomain_read_data(struct scsi_cmnd *cmd=
)
=20
 	while ((len =3D inw(fd->base + REG_FIFO_COUNT)) > 0) {
 		offset =3D scsi_bufflen(cmd) - scsi_get_resid(cmd);
-		virt =3D scsi_kmap_atomic_sg(scsi_sglist(cmd), scsi_sg_count(cmd),
-					   &offset, &len);
+		virt =3D kmap_sg(scsi_sglist(cmd), scsi_sg_count(cmd), &offset, &len);
 		ptr =3D virt + offset;
 		if (len & 1)
 			*ptr++ =3D inb(fd->base + REG_FIFO);
 		if (len > 1)
 			insw(fd->base + REG_FIFO, ptr, len >> 1);
 		scsi_set_resid(cmd, scsi_get_resid(cmd) - len);
-		scsi_kunmap_atomic_sg(virt);
+		kunmap_sg(virt);
 	}
 }
=20
@@ -250,15 +249,14 @@ static void fdomain_write_data(struct scsi_cmnd *cm=
d)
 			if (len =3D=3D 0)
 				break;
 		}
-		virt =3D scsi_kmap_atomic_sg(scsi_sglist(cmd), scsi_sg_count(cmd),
-					   &offset, &len);
+		virt =3D kmap_sg(scsi_sglist(cmd), scsi_sg_count(cmd), &offset, &len);
 		ptr =3D virt + offset;
 		if (len & 1)
 			outb(*ptr++, fd->base + REG_FIFO);
 		if (len > 1)
 			outsw(fd->base + REG_FIFO, ptr, len >> 1);
 		scsi_set_resid(cmd, scsi_get_resid(cmd) - len);
-		scsi_kunmap_atomic_sg(virt);
+		kunmap_sg(virt);
 	}
 }
=20
--=20
2.35.3

