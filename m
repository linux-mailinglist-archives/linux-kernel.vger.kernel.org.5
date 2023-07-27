Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7F77657DC
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:40:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233095AbjG0PkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbjG0PkE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:40:04 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133052122;
        Thu, 27 Jul 2023 08:40:03 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 17BB7186AAC1;
        Thu, 27 Jul 2023 18:39:30 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Z4YePX_NlhbN; Thu, 27 Jul 2023 18:39:29 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id B7655186AAA0;
        Thu, 27 Jul 2023 18:39:29 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id lEd70ON9ivQv; Thu, 27 Jul 2023 18:39:29 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.132])
        by mail.astralinux.ru (Postfix) with ESMTPSA id DFA7E186AA6C;
        Thu, 27 Jul 2023 18:39:28 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Subject: [PATCH] 53c700: add 'slot' check to NULL
Date:   Thu, 27 Jul 2023 18:39:25 +0300
Message-Id: <20230727153925.15297-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The 'slot' variable allows a NULL value.
It is necessary to add a check for a null
value to avoid dereferencing the null pointer.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Signed-off-by: Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
 drivers/scsi/53c700.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index e1e4f9d10887..8e5468d1733d 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1598,6 +1598,8 @@ NCR_700_intr(int irq, void *dev_id)
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, ret=
urn %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, =
temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset =3D hostdata->pScript + Ent_SendMessagePhaseMismatch;
+			} else if (!slot) {
+				printk(KERN_ERR "53c700: SCSI DONE HAS NULL SCp\n");
 			} else if(dsp >=3D to32bit(&slot->pSG[0].ins) &&
 				  dsp <=3D to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer =3D NCR_700_readl(host, DBC_REG) & 0xffffff;
--=20
2.30.2

