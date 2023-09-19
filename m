Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472FE7A6F69
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 01:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233237AbjISX3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 19:29:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjISX3B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 19:29:01 -0400
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D28BC0;
        Tue, 19 Sep 2023 16:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1695166137; x=1726702137;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N1uB7lsYbgFhpbI/u6XcPrZ41m9s6L1lr4JQrgc4zA4=;
  b=IttGPMuYk0rA0dCEAvBfWZJjObh74xuKSiARo+CKwP4bHlZzI6qlQExf
   754vfwhkAsHQRLvki2qSk+z4lJOdjzy9H3t+gNm8ha3Kt0ohZoBeE4I9n
   haxYTfSEn0qGpL1IoWNNsJS98rf4JYsofukAoGpB42iJyuNcbcbAf9ULu
   I=;
X-IronPort-AV: E=Sophos;i="6.02,160,1688428800"; 
   d="scan'208";a="239725023"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Sep 2023 23:28:57 +0000
Received: from EX19MTAUWB002.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2a-m6i4x-1197e3af.us-west-2.amazon.com (Postfix) with ESMTPS id 874D7100F14;
        Tue, 19 Sep 2023 23:28:55 +0000 (UTC)
Received: from EX19D030UWB002.ant.amazon.com (10.13.139.182) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 19 Sep 2023 23:28:49 +0000
Received: from u1e958862c3245e.ant.amazon.com (10.88.167.207) by
 EX19D030UWB002.ant.amazon.com (10.13.139.182) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.37; Tue, 19 Sep 2023 23:28:49 +0000
From:   Suraj Jitindar Singh <surajjs@amazon.com>
To:     <stable@vger.kernel.org>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kent.overstreet@gmail.com>, <axboe@kernel.dk>,
        <sjitindarsingh@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Suraj Jitindar Singh <surajjs@amazon.com>
Subject: [PATCH stable 5.10.y] mm/filemap: fix infinite loop in generic_file_buffered_read()
Date:   Tue, 19 Sep 2023 16:28:15 -0700
Message-ID: <20230919232815.166772-1-surajjs@amazon.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.88.167.207]
X-ClientProxiedBy: EX19D039UWA002.ant.amazon.com (10.13.139.32) To
 EX19D030UWB002.ant.amazon.com (10.13.139.182)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Kent Overstreet <kent.overstreet@gmail.com>

commit 3644e2d2dda78e21edd8f5415b6d7ab03f5f54f3 upstream.

If iter->count is 0 and iocb->ki_pos is page aligned, this causes
nr_pages to be 0.

Then in generic_file_buffered_read_get_pages() find_get_pages_contig()
returns 0 - because we asked for 0 pages, so we call
generic_file_buffered_read_no_cached_page() which attempts to add a page
to the page cache, which fails with -EEXIST, and then we loop. Oops...

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Reported-by: Jens Axboe <axboe@kernel.dk>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Suraj Jitindar Singh <surajjs@amazon.com>
---
 mm/filemap.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/mm/filemap.c b/mm/filemap.c
index 3a983bc1a71c..3b0d8c6dd587 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2203,6 +2203,9 @@ ssize_t generic_file_buffered_read(struct kiocb *iocb,
 
 	if (unlikely(*ppos >= inode->i_sb->s_maxbytes))
 		return 0;
+	if (unlikely(!iov_iter_count(iter)))
+		return 0;
+
 	iov_iter_truncate(iter, inode->i_sb->s_maxbytes);
 
 	index = *ppos >> PAGE_SHIFT;
-- 
2.34.1

