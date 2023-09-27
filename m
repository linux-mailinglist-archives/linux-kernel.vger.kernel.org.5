Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D654E7B0489
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbjI0Mmx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:42:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbjI0Mmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:42:43 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88E001B2;
        Wed, 27 Sep 2023 05:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1695818558;
        bh=SHMG6lgDFraU+H51dhM9rfzW2m2leq9l5xsXhHTv1F4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=I29TFPrR/nk4TktrlrpVUwJADXhRUkwI3Sh2QToQZbd2rL/2yxRrWxqfOqPk80rG6
         8LWgmw+iCd+7PoRyUOFc0/Yqj6/4+L3oP3bdC62TVDjAQvB3JtaEmcPxs88iM0As9m
         tqAzvecqxaWWNogg5z/Q3N6w4jC13yHeJGe64Mro=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 2320A1285D49;
        Wed, 27 Sep 2023 08:42:38 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id FF1qiZE4vKWb; Wed, 27 Sep 2023 08:42:38 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1695818557;
        bh=SHMG6lgDFraU+H51dhM9rfzW2m2leq9l5xsXhHTv1F4=;
        h=Message-ID:Subject:From:To:Date:From;
        b=oHyhQAEhZZD6vj1svziS3T7KDe1b9KAx4HJUjn0d0NIWb/6kbSnxt9EWQtfrWsPoC
         nGUGB5liSgtPm+R1bcPR1d67/1RdmsWYS/koTFOK2uAtJ1xgbplAy/DG9PPeOBuNKC
         q0xrBjFgdFjVshLRzGvinbIDP/nvxes99jK0a2hE=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::c14])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 6D91A128138F;
        Wed, 27 Sep 2023 08:42:37 -0400 (EDT)
Message-ID: <003149d84048d4fbf26eac75237bc67e188c5f84.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.6-rc3
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Sep 2023 08:42:35 -0400
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Single fix for libata: older devices don't support command duration
limits (CDL) and some don't support report opcodes, meaning there's no
way to tell if they support the command or not. Reduce the problems of
incorrectly using CDL commands on older devices by checking SCSI spec
compliance at SPC-5 (the spec which introduced the command) before
turning on CDL.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

The short changelog is:

Damien Le Moal (1):
      scsi: core: ata: Do no try to probe for CDL on old drives

And the diffstat:

 drivers/ata/libata-scsi.c |  3 +++
 drivers/scsi/scsi.c       | 11 +++++++++++
 drivers/scsi/scsi_scan.c  |  2 +-
 include/scsi/scsi.h       |  3 +++
 4 files changed, 18 insertions(+), 1 deletion(-)

With full diff below.

James

---

diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index d3f28b82c97b..0e96ed408c71 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -1835,6 +1835,9 @@ static unsigned int ata_scsiop_inq_std(struct ata_scsi_args *args, u8 *rbuf)
 		hdr[2] = 0x7; /* claim SPC-5 version compatibility */
 	}
 
+	if (args->dev->flags & ATA_DFLAG_CDL)
+		hdr[2] = 0xd; /* claim SPC-6 version compatibility */
+
 	memcpy(rbuf, hdr, sizeof(hdr));
 	memcpy(&rbuf[8], "ATA     ", 8);
 	ata_id_string(args->id, &rbuf[16], ATA_ID_PROD, 16);
diff --git a/drivers/scsi/scsi.c b/drivers/scsi/scsi.c
index d0911bc28663..89367c4bf0ef 100644
--- a/drivers/scsi/scsi.c
+++ b/drivers/scsi/scsi.c
@@ -613,6 +613,17 @@ void scsi_cdl_check(struct scsi_device *sdev)
 	bool cdl_supported;
 	unsigned char *buf;
 
+	/*
+	 * Support for CDL was defined in SPC-5. Ignore devices reporting an
+	 * lower SPC version. This also avoids problems with old drives choking
+	 * on MAINTENANCE_IN / MI_REPORT_SUPPORTED_OPERATION_CODES with a
+	 * service action specified, as done in scsi_cdl_check_cmd().
+	 */
+	if (sdev->scsi_level < SCSI_SPC_5) {
+		sdev->cdl_supported = 0;
+		return;
+	}
+
 	buf = kmalloc(SCSI_CDL_CHECK_BUF_LEN, GFP_KERNEL);
 	if (!buf) {
 		sdev->cdl_supported = 0;
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 52014b2d39e1..eaa972bee6c0 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -822,7 +822,7 @@ static int scsi_probe_lun(struct scsi_device *sdev, unsigned char *inq_result,
 	 * device is attached at LUN 0 (SCSI_SCAN_TARGET_PRESENT) so
 	 * non-zero LUNs can be scanned.
 	 */
-	sdev->scsi_level = inq_result[2] & 0x07;
+	sdev->scsi_level = inq_result[2] & 0x0f;
 	if (sdev->scsi_level >= 2 ||
 	    (sdev->scsi_level == 1 && (inq_result[3] & 0x0f) == 1))
 		sdev->scsi_level++;
diff --git a/include/scsi/scsi.h b/include/scsi/scsi.h
index ec093594ba53..4498f845b112 100644
--- a/include/scsi/scsi.h
+++ b/include/scsi/scsi.h
@@ -157,6 +157,9 @@ enum scsi_disposition {
 #define SCSI_3          4        /* SPC */
 #define SCSI_SPC_2      5
 #define SCSI_SPC_3      6
+#define SCSI_SPC_4	7
+#define SCSI_SPC_5	8
+#define SCSI_SPC_6	14
 
 /*
  * INQ PERIPHERAL QUALIFIERS


