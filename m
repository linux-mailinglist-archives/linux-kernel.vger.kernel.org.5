Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E64D8766D52
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 14:35:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236250AbjG1Mfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 08:35:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232155AbjG1Mfj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 08:35:39 -0400
Received: from mail.astralinux.ru (mail.astralinux.ru [217.74.38.119])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EBF319A7;
        Fri, 28 Jul 2023 05:35:37 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id E9F3B18679AA;
        Fri, 28 Jul 2023 15:35:33 +0300 (MSK)
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 6ve81zsREcdP; Fri, 28 Jul 2023 15:35:33 +0300 (MSK)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.astralinux.ru (Postfix) with ESMTP id 96FB31867928;
        Fri, 28 Jul 2023 15:35:33 +0300 (MSK)
X-Virus-Scanned: amavisd-new at astralinux.ru
Received: from mail.astralinux.ru ([127.0.0.1])
        by localhost (rbta-msk-vsrv-mail01.astralinux.ru [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 5TaoK-WC4Lub; Fri, 28 Jul 2023 15:35:33 +0300 (MSK)
Received: from rbta-msk-lt-302690.astralinux.ru (unknown [10.177.233.185])
        by mail.astralinux.ru (Postfix) with ESMTPSA id B67FC18655F1;
        Fri, 28 Jul 2023 15:35:32 +0300 (MSK)
From:   Alexandra Diupina <adiupina@astralinux.ru>
To:     "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc:     Alexandra Diupina <adiupina@astralinux.ru>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lvc-project@linuxtesting.org,
        Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Subject: [PATCH v2] 53c700: add 'slot' check to NULL
Date:   Fri, 28 Jul 2023 15:35:21 +0300
Message-Id: <20230728123521.18293-1-adiupina@astralinux.ru>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <7e4c7af1adbfa91d05259ae65cade66521c3b182.camel@HansenPartnership.com>
References: 
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a 'slot' check for a null value to avoid
dereferencing the null pointer

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Co-developed-by: Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Signed-off-by: Vladimir Telezhnikov <vtelezhnikov@astralinux.ru>
Signed-off-by: Alexandra Diupina <adiupina@astralinux.ru>
---
v2: Move the 'slot' variable check to an existing if-else expression
as James E.J. Bottomley <James.Bottomley@HansenPartnership.com> suggested
 drivers/scsi/53c700.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/53c700.c b/drivers/scsi/53c700.c
index e1e4f9d10887..857be0f3ae5b 100644
--- a/drivers/scsi/53c700.c
+++ b/drivers/scsi/53c700.c
@@ -1598,7 +1598,7 @@ NCR_700_intr(int irq, void *dev_id)
 				printk("scsi%d (%d:%d) PHASE MISMATCH IN SEND MESSAGE %d remain, ret=
urn %p[%04x], phase %s\n", host->host_no, pun, lun, count, (void *)temp, =
temp - hostdata->pScript, sbcl_to_string(NCR_700_readb(host, SBCL_REG)));
 #endif
 				resume_offset =3D hostdata->pScript + Ent_SendMessagePhaseMismatch;
-			} else if(dsp >=3D to32bit(&slot->pSG[0].ins) &&
+			} else if (slot && dsp >=3D to32bit(&slot->pSG[0].ins) &&
 				  dsp <=3D to32bit(&slot->pSG[NCR_700_SG_SEGMENTS].ins)) {
 				int data_transfer =3D NCR_700_readl(host, DBC_REG) & 0xffffff;
 				int SGcount =3D (dsp - to32bit(&slot->pSG[0].ins))/sizeof(struct NCR=
_700_SG_List);
--=20
2.30.2

