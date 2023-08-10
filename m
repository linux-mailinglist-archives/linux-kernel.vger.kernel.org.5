Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE949777D18
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:01:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236329AbjHJQAy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236204AbjHJQAp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:00:45 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56197211B;
        Thu, 10 Aug 2023 09:00:45 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1FC74635D2A1;
        Thu, 10 Aug 2023 18:00:44 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IScXaYrAKO0A; Thu, 10 Aug 2023 18:00:43 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id C9DCB635D29F;
        Thu, 10 Aug 2023 18:00:43 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id Xcer7PJILGKE; Thu, 10 Aug 2023 18:00:43 +0200 (CEST)
Received: from foxxylove.corp.sigma-star.at (unknown [82.150.214.1])
        by lithops.sigma-star.at (Postfix) with ESMTPSA id 6F83C635D296;
        Thu, 10 Aug 2023 18:00:43 +0200 (CEST)
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
Subject: [PATCH 4/7] scsi: esp_scsi: Switch to kmap_sg
Date:   Thu, 10 Aug 2023 18:00:15 +0200
Message-Id: <20230810160019.16977-5-richard@nod.at>
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
 drivers/scsi/esp_scsi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/esp_scsi.c b/drivers/scsi/esp_scsi.c
index 97816a0e6240a..10d2fcf65f28a 100644
--- a/drivers/scsi/esp_scsi.c
+++ b/drivers/scsi/esp_scsi.c
@@ -1355,11 +1355,11 @@ static int esp_data_bytes_sent(struct esp *esp, s=
truct esp_cmd_entry *ent,
 			struct esp_cmd_priv *p =3D ESP_CMD_PRIV(cmd);
 			u8 *ptr;
=20
-			ptr =3D scsi_kmap_atomic_sg(p->cur_sg, p->num_sg,
+			ptr =3D kmap_sg(p->cur_sg, p->num_sg,
 						  &offset, &count);
 			if (likely(ptr)) {
 				*(ptr + offset) =3D bval;
-				scsi_kunmap_atomic_sg(ptr);
+				kunmap_sg(ptr);
 			}
 		}
 		bytes_sent +=3D fifo_cnt;
--=20
2.35.3

