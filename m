Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4BCD7D1687
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 21:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230037AbjJTTun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 15:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjJTTul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 15:50:41 -0400
Received: from bedivere.hansenpartnership.com (bedivere.hansenpartnership.com [IPv6:2607:fcd0:100:8a00::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4041D63;
        Fri, 20 Oct 2023 12:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697831439;
        bh=dfBUDh2+NLuZET4aeDkcgmhLoPDIT0AK75Zd69ihX9A=;
        h=Message-ID:Subject:From:To:Date:From;
        b=RvR53+UVIQnZnBlSViZ91wypAhERtgDaRA0wbwIYm6A9fQF1oMX2YfISgpMhXbELT
         wqE70CIICWMOwRmBHOJJf1He04IHMEC1UwA6d47seyZYxDtriGKmCgJ5Jr3ctj0A5l
         wZ+AGXcTMHcUzEVfywjds+WoB9SIjQ/Sty41n7pU=
Received: from localhost (localhost [127.0.0.1])
        by bedivere.hansenpartnership.com (Postfix) with ESMTP id 560E71287297;
        Fri, 20 Oct 2023 15:50:39 -0400 (EDT)
Received: from bedivere.hansenpartnership.com ([127.0.0.1])
 by localhost (bedivere.hansenpartnership.com [127.0.0.1]) (amavis, port 10024)
 with ESMTP id g51m-Gd8AxHp; Fri, 20 Oct 2023 15:50:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
        d=hansenpartnership.com; s=20151216; t=1697831439;
        bh=dfBUDh2+NLuZET4aeDkcgmhLoPDIT0AK75Zd69ihX9A=;
        h=Message-ID:Subject:From:To:Date:From;
        b=RvR53+UVIQnZnBlSViZ91wypAhERtgDaRA0wbwIYm6A9fQF1oMX2YfISgpMhXbELT
         wqE70CIICWMOwRmBHOJJf1He04IHMEC1UwA6d47seyZYxDtriGKmCgJ5Jr3ctj0A5l
         wZ+AGXcTMHcUzEVfywjds+WoB9SIjQ/Sty41n7pU=
Received: from lingrow.int.hansenpartnership.com (unknown [IPv6:2601:5c4:4302:c21::a774])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (Client did not present a certificate)
        by bedivere.hansenpartnership.com (Postfix) with ESMTPSA id 918901287296;
        Fri, 20 Oct 2023 15:50:38 -0400 (EDT)
Message-ID: <6aaeacbf526de186b21b2061fcf3a4d777e8563f.camel@HansenPartnership.com>
Subject: [GIT PULL] SCSI fixes for 6.6-rc6
From:   James Bottomley <James.Bottomley@HansenPartnership.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-scsi <linux-scsi@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Date:   Fri, 20 Oct 2023 15:50:37 -0400
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

Two small fixes, both in drivers.  The mptsas one is really fixing an
error path issue where it can leave the misc driver loaded even though
the sas driver fails to initialize.

The patch is available here:

git://git.kernel.org/pub/scm/linux/kernel/git/jejb/scsi.git scsi-fixes

Quinn Tran (1):
      scsi: qla2xxx: Fix double free of dsd_list during driver load

Tomas Henzl (1):
      scsi: mpt3sas: Fix in error path

And the diffstat:

 drivers/scsi/mpt3sas/mpt3sas_scsih.c | 4 +++-
 drivers/scsi/qla2xxx/qla_os.c        | 2 +-
 2 files changed, 4 insertions(+), 2 deletions(-)

With full diff below

James

---

diff --git a/drivers/scsi/mpt3sas/mpt3sas_scsih.c b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
index c3c1f466fe01..605013d3ee83 100644
--- a/drivers/scsi/mpt3sas/mpt3sas_scsih.c
+++ b/drivers/scsi/mpt3sas/mpt3sas_scsih.c
@@ -12913,8 +12913,10 @@ _mpt3sas_init(void)
 	mpt3sas_ctl_init(hbas_to_enumerate);
 
 	error = pci_register_driver(&mpt3sas_driver);
-	if (error)
+	if (error) {
+		mpt3sas_ctl_exit(hbas_to_enumerate);
 		scsih_exit();
+	}
 
 	return error;
 }
diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 50db08265c51..dcae09a37d49 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4953,7 +4953,7 @@ qla2x00_mem_free(struct qla_hw_data *ha)
 	ha->gid_list = NULL;
 	ha->gid_list_dma = 0;
 
-	if (!list_empty(&ha->base_qpair->dsd_list)) {
+	if (ha->base_qpair && !list_empty(&ha->base_qpair->dsd_list)) {
 		struct dsd_dma *dsd_ptr, *tdsd_ptr;
 
 		/* clean up allocated prev pool */

