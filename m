Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA10D769090
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 10:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231803AbjGaIoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjGaIoV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 04:44:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9156D44B9
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 01:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690792840;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=tptzp+ajAKS5fHUGnepcgiEVA2vq/obigXOKUmVfnkc=;
        b=HobiapIgyV0IVRd5+A27IGBN6wbiZVPnlVxlrvlRgBiAvnIdw29StdfOFT987IAnCR6Tai
        skWS2tSjw7NPQ39FMxOmDzxtwK3/CoL2L2k5apcWhL1dZW69UgidTGLvLn6aSmd6UtliyQ
        NhvDfFE2anydr1/GiMdbq7ZxTCQi6BU=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-160-Mxl4Fo_aN3aEdc8V_46zjg-1; Mon, 31 Jul 2023 04:40:36 -0400
X-MC-Unique: Mxl4Fo_aN3aEdc8V_46zjg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1C2A51C2C5A6;
        Mon, 31 Jul 2023 08:40:36 +0000 (UTC)
Received: from localhost (unknown [10.45.224.115])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BB01A2166B25;
        Mon, 31 Jul 2023 08:40:35 +0000 (UTC)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Saurav Kashyap <skashyap@marvell.com>,
        Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
        David Laight <David.Laight@ACULAB.COM>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Rob Evers <revers@redhat.com>
Subject: [PATCH v2 0/3] scsi: qedf: sanitise uaccess
Date:   Mon, 31 Jul 2023 10:40:31 +0200
Message-ID: <20230731084034.37021-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.6
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

qedf driver, debugfs part of it specifically, touches __user pointers
directly for printing out info to userspace via sprintf(), which may
cause crash like this:

BUG: unable to handle kernel paging request at 00007ffd1d6b43a0
IP: [<ffffffffaa7a882a>] string.isra.7+0x6a/0xf0
Oops: 0003 [#1] SMP
Call Trace:
 [<ffffffffaa7a9f31>] vsnprintf+0x201/0x6a0
 [<ffffffffaa7aa556>] sprintf+0x56/0x80
 [<ffffffffc04227ed>] qedf_dbg_stop_io_on_error_cmd_read+0x6d/0x90 [qedf]
 [<ffffffffaa65bb2f>] vfs_read+0x9f/0x170
 [<ffffffffaa65cb82>] SyS_pread64+0x92/0xc0

Avoid this by preparing the info in a kernel buffer first, either
allocated on stack for small printouts, or via vmalloc() for big ones,
and then copying it to the userspace properly.

Changes since v1 [1]:

  * use scnprintf() for on-stack buffers too
  * adjust an on-stack buffer size in qedf_dbg_debug_cmd_read() to be a
    multiple of 8, and also size it properly
  * accumulate acks and reviews

[1] https://lore.kernel.org/lkml/20230728065819.139694-1-oleksandr@redhat.com/

Oleksandr Natalenko (3):
  scsi: qedf: do not touch __user pointer in
    qedf_dbg_stop_io_on_error_cmd_read() directly
  scsi: qedf: do not touch __user pointer in qedf_dbg_debug_cmd_read()
    directly
  scsi: qedf: do not touch __user pointer in qedf_dbg_fp_int_cmd_read()
    directly

 drivers/scsi/qedf/qedf_dbg.h     |  2 ++
 drivers/scsi/qedf/qedf_debugfs.c | 35 +++++++++++++++++++-------------
 2 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.41.0

