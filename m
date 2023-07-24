Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B74475F59D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 14:03:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjGXMDs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 08:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjGXMDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 08:03:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7778CE43
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 05:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690200169;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5cbGLzsOpszIW29iDt5MpDYjv/Oe38KhgfInWeAU+S0=;
        b=CkipfAxS6tqmQvYvu9JAO3h8GLUKqEHWTaI3AizbRbPQcIRnRbpmt2wsO/Uct3DxN+Vzce
        KGk259CUoNg1/2qI3TD8mMhOh35fTl/WzPDd99PbxDYXGUBBdOcZKAkDKGQb/CWoKp0DX9
        O7TowHs8zy6pb8/MKS5u/kD/FUboLAg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-513-oPGyuEgjOnOPAtmfaLM47g-1; Mon, 24 Jul 2023 08:02:44 -0400
X-MC-Unique: oPGyuEgjOnOPAtmfaLM47g-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 0DB3E809F8F;
        Mon, 24 Jul 2023 12:02:44 +0000 (UTC)
Received: from localhost (dhcp-10-40-5-80.brq.redhat.com [10.40.5.80])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C3337492C13;
        Mon, 24 Jul 2023 12:02:43 +0000 (UTC)
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
Subject: [RFC PATCH 2/3] scsi: qedf: do not touch __user pointer in qedf_dbg_debug_cmd_read() directly
Date:   Mon, 24 Jul 2023 14:02:40 +0200
Message-ID: <20230724120241.40495-3-oleksandr@redhat.com>
In-Reply-To: <20230724120241.40495-1-oleksandr@redhat.com>
References: <20230724120241.40495-1-oleksandr@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
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

The qedf_dbg_debug_cmd_read() function invokes sprintf()
directly on a __user pointer, which may crash the kernel.

Avoid doing that by using a small on-stack buffer for sprintf()
and then calling simple_read_from_buffer() which does a proper
copy_to_user() call.

Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
---
 drivers/scsi/qedf/qedf_debugfs.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/scsi/qedf/qedf_debugfs.c b/drivers/scsi/qedf/qedf_debugfs.c
index 4d1b99569d490..f910af0029a2c 100644
--- a/drivers/scsi/qedf/qedf_debugfs.c
+++ b/drivers/scsi/qedf/qedf_debugfs.c
@@ -138,15 +138,14 @@ qedf_dbg_debug_cmd_read(struct file *filp, char __user *buffer, size_t count,
 			loff_t *ppos)
 {
 	int cnt;
+	char cbuf[35];
 	struct qedf_dbg_ctx *qedf_dbg =
 				(struct qedf_dbg_ctx *)filp->private_data;
 
 	QEDF_INFO(qedf_dbg, QEDF_LOG_DEBUGFS, "debug mask=0x%x\n", qedf_debug);
-	cnt = sprintf(buffer, "debug mask = 0x%x\n", qedf_debug);
+	cnt = sprintf(cbuf, "debug mask = 0x%x\n", qedf_debug);
 
-	cnt = min_t(int, count, cnt - *ppos);
-	*ppos += cnt;
-	return cnt;
+	return simple_read_from_buffer(buffer, count, ppos, cbuf, cnt);
 }
 
 static ssize_t
-- 
2.41.0

