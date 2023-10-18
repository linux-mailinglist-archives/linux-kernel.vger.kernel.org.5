Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6A827CD675
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 10:29:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344665AbjJRI3z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 04:29:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234509AbjJRI3y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 04:29:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1532F9
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 01:29:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697617747;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=0DfgOBCrFQtwfTW6PR7xvg55Um2Cc2iR1Zh8/bhBhXA=;
        b=bApkCpDujvHlpXGS20AHfi/GTUXCdWxa8ksCsfGaghjffM5kg+jowcl0Fniqnsmg9sQGxz
        gu9yU6D7M3YHu6QRRKs4U1B/+5v5lv6P1KKbXqv6k9+VwhQcwCSeG9ta3zu2cpFe9ETn9v
        M0hftl9tzYQEguCq0vQhqYOEdWrVlpM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-d0Nfuki2P72YRLHMxY3LOw-1; Wed, 18 Oct 2023 04:29:00 -0400
X-MC-Unique: d0Nfuki2P72YRLHMxY3LOw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2C054857D0C;
        Wed, 18 Oct 2023 08:29:00 +0000 (UTC)
Received: from t14s.redhat.com (unknown [10.45.225.167])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B10331C060AE;
        Wed, 18 Oct 2023 08:28:58 +0000 (UTC)
From:   Jan Stancek <jstancek@redhat.com>
To:     djwong@kernel.org, willy@infradead.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk,
        jstancek@redhat.com
Subject: [PATCH] iomap: fix short copy in iomap_write_iter()
Date:   Wed, 18 Oct 2023 10:24:20 +0200
Message-Id: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Starting with commit 5d8edfb900d5 ("iomap: Copy larger chunks from
userspace"), iomap_write_iter() can get into endless loop. This can
be reproduced with LTP writev07 which uses partially valid iovecs:
        struct iovec wr_iovec[] = {
                { buffer, 64 },
                { bad_addr, 64 },
                { buffer + 64, 64 },
                { buffer + 64 * 2, 64 },
        };

commit bc1bb416bbb9 ("generic_perform_write()/iomap_write_actor():
saner logics for short copy") previously introduced the logic, which
made short copy retry in next iteration with amount of "bytes" it
managed to copy:

                if (unlikely(status == 0)) {
                        /*
                         * A short copy made iomap_write_end() reject the
                         * thing entirely.  Might be memory poisoning
                         * halfway through, might be a race with munmap,
                         * might be severe memory pressure.
                         */
                        if (copied)
                                bytes = copied;

However, since 5d8edfb900d5 "bytes" is no longer carried into next
iteration, because it is now always initialized at the beginning of
the loop. And for iov_iter_count < PAGE_SIZE, "bytes" ends up with
same value as previous iteration, making the loop retry same copy
over and over, which leads to writev07 testcase hanging.

Make next iteration retry with amount of bytes we managed to copy.

Fixes: 5d8edfb900d5 ("iomap: Copy larger chunks from userspace")
Signed-off-by: Jan Stancek <jstancek@redhat.com>
---
 fs/iomap/buffered-io.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 5db54ca29a35..3f32df4ca9e3 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -869,6 +869,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 {
 	loff_t length = iomap_length(iter);
 	size_t chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
+	size_t retry_bytes = 0;
 	loff_t pos = iter->pos;
 	ssize_t written = 0;
 	long status = 0;
@@ -883,6 +884,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 
 		offset = pos & (chunk - 1);
 		bytes = min(chunk - offset, iov_iter_count(i));
+		if (retry_bytes) {
+			bytes = min(bytes, retry_bytes);
+			retry_bytes = 0;
+		}
 		status = balance_dirty_pages_ratelimited_flags(mapping,
 							       bdp_flags);
 		if (unlikely(status))
@@ -934,7 +939,7 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			 * might be severe memory pressure.
 			 */
 			if (copied)
-				bytes = copied;
+				retry_bytes = copied;
 			if (chunk > PAGE_SIZE)
 				chunk /= 2;
 		} else {
-- 
2.31.1

