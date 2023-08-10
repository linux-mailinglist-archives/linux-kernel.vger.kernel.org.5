Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4EC777D12
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:01:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbjHJQAw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:00:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234714AbjHJQAo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:00:44 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF2CE53;
        Thu, 10 Aug 2023 09:00:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 63D92622F56E;
        Thu, 10 Aug 2023 18:00:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id HGDQ1P6SpJc5; Thu, 10 Aug 2023 18:00:42 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EC415622F592;
        Thu, 10 Aug 2023 18:00:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5wGKZt-JMm6Y; Thu, 10 Aug 2023 18:00:41 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 9000E622F56E;
        Thu, 10 Aug 2023 18:00:41 +0200 (CEST)
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
Subject: [PATCH 3/7] scsi: dc395x: Switch to kmap_sg
Date:   Thu, 10 Aug 2023 18:00:14 +0200
Message-Id: <20230810160019.16977-4-richard@nod.at>
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
Maybe local_irq_save() can be dropped, but I don't know this driver
well enough.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/scsi/dc395x.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/scsi/dc395x.c b/drivers/scsi/dc395x.c
index c8e86f8a631eb..4a4e7a35328b9 100644
--- a/drivers/scsi/dc395x.c
+++ b/drivers/scsi/dc395x.c
@@ -2122,7 +2122,7 @@ static void data_in_phase0(struct AdapterCtlBlk *ac=
b, struct ScsiReqBlk *srb,
 				local_irq_save(flags);
 				/* Assumption: it's inside one page as it's at most 4 bytes and
 				   I just assume it's on a 4-byte boundary */
-				base =3D scsi_kmap_atomic_sg(scsi_sglist(srb->cmd),
+				base =3D kmap_sg(scsi_sglist(srb->cmd),
 							   srb->sg_count, &offset, &len);
 				virt =3D base + offset;
=20
@@ -2165,7 +2165,7 @@ static void data_in_phase0(struct AdapterCtlBlk *ac=
b, struct ScsiReqBlk *srb,
 					DC395x_write8(acb, TRM_S1040_SCSI_CONFIG2, 0);
 				}
=20
-				scsi_kunmap_atomic_sg(base);
+				kunmap_sg(base);
 				local_irq_restore(flags);
 			}
 			/*printk(" %08x", *(u32*)(bus_to_virt (addr))); */
@@ -2339,7 +2339,7 @@ static void data_io_transfer(struct AdapterCtlBlk *=
acb,
=20
 				local_irq_save(flags);
 				/* Again, max 4 bytes */
-				base =3D scsi_kmap_atomic_sg(scsi_sglist(srb->cmd),
+				base =3D kmap_sg(scsi_sglist(srb->cmd),
 							   srb->sg_count, &offset, &len);
 				virt =3D base + offset;
=20
@@ -2354,7 +2354,7 @@ static void data_io_transfer(struct AdapterCtlBlk *=
acb,
 					sg_subtract_one(srb);
 				}
=20
-				scsi_kunmap_atomic_sg(base);
+				kunmap_sg(base);
 				local_irq_restore(flags);
 			}
 			if (srb->dcb->sync_period & WIDE_SYNC) {
@@ -3290,7 +3290,7 @@ static void srb_done(struct AdapterCtlBlk *acb, str=
uct DeviceCtlBlk *dcb,
 		size_t offset =3D 0, len =3D sizeof(struct ScsiInqData);
=20
 		local_irq_save(flags);
-		base =3D scsi_kmap_atomic_sg(sg, scsi_sg_count(cmd), &offset, &len);
+		base =3D kmap_sg(sg, scsi_sg_count(cmd), &offset, &len);
 		ptr =3D (struct ScsiInqData *)(base + offset);
=20
 		if (!ckc_only && get_host_byte(cmd) =3D=3D DID_OK
@@ -3308,7 +3308,7 @@ static void srb_done(struct AdapterCtlBlk *acb, str=
uct DeviceCtlBlk *dcb,
 			}
 		}
=20
-		scsi_kunmap_atomic_sg(base);
+		kunmap_sg(base);
 		local_irq_restore(flags);
 	}
=20
--=20
2.35.3

