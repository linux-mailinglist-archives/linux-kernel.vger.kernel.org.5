Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4DCB75F599
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbjGXMDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjGXMDa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6BC1A1
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690200166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=0cvYxFz9mjJySSTDejKAHRAi+MgA/colULiqidjHAEA=;
        b=H16el6YC2XqGawI14ZK3EAIlivs/N38JQX3VotUJ1xS3hE2cFtiBVFkQQS3CrX+VB0BBnO
        KRvtYmtkiBF7/iAar0oTveTduS5VCGqFs4yEPm6BUQesmojOOKKL7yiEccjMcjuFm+TVyQ
        +Giv3o0VA6XrfuBEflx5Q7AuiujLm9w=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-H6QFWb5UMv-cTsPAhWVuzg-1; Mon, 24 Jul 2023 08:02:42 -0400
X-MC-Unique: H6QFWb5UMv-cTsPAhWVuzg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 20BED1C172A5;
        Mon, 24 Jul 2023 12:02:42 +0000 (UTC)
Received: from localhost (dhcp-10-40-5-80.brq.redhat.com [10.40.5.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C5325201EE6E;
        Mon, 24 Jul 2023 12:02:41 +0000 (UTC)
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-scsi@vger.kernel.org, Saurav Kashyap <skashyap@marvell.com>,
        Javed Hasan <jhasan@marvell.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Jozef Bacik <jobacik@redhat.com>,
        Laurence Oberman <loberman@redhat.com>,
        Rob Evers <revers@redhat.com>
Subject: [RFC PATCH 0/3] scsi: qedf: sanitise uaccess
Date:   Mon, 24 Jul 2023 14:02:38 +0200
Message-ID: <20230724120241.40495-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
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

I'm not sure how big the vmalloc()'ed buffer should be, and also whether
vmalloc()'ing it directly in the _read() function is a good idea, hence
RFC prefix.

The qedf_dbg_stop_io_on_error_cmd_read()-related patch is actually tested,
the rest is compile-tested only.

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

