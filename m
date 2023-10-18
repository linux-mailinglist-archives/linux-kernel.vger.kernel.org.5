Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549017CDB79
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 14:22:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230050AbjJRMW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 08:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjJRMWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 08:22:25 -0400
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB5198;
        Wed, 18 Oct 2023 05:22:23 -0700 (PDT)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 56BE467373; Wed, 18 Oct 2023 14:22:20 +0200 (CEST)
Date:   Wed, 18 Oct 2023 14:22:20 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Jan Stancek <jstancek@redhat.com>
Cc:     djwong@kernel.org, willy@infradead.org, hch@lst.de,
        linux-xfs@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk
Subject: Re: [PATCH] iomap: fix short copy in iomap_write_iter()
Message-ID: <20231018122220.GB10751@lst.de>
References: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8762e91a210f4cc5713fce05fe5906c18513bd0a.1697617238.git.jstancek@redhat.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 18, 2023 at 10:24:20AM +0200, Jan Stancek wrote:
> Make next iteration retry with amount of bytes we managed to copy.

The observation and logic fix look good.  But I wonder if simply
using a goto instead of the extra variable would be a tad cleaner?
Something like this?

---
diff --git a/fs/iomap/buffered-io.c b/fs/iomap/buffered-io.c
index 061f3d14c12001..2d491590795aa4 100644
--- a/fs/iomap/buffered-io.c
+++ b/fs/iomap/buffered-io.c
@@ -881,8 +881,10 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 		size_t bytes;		/* Bytes to write to folio */
 		size_t copied;		/* Bytes copied from user */
 
+		bytes = iov_iter_count(i);
+retry:
 		offset = pos & (chunk - 1);
-		bytes = min(chunk - offset, iov_iter_count(i));
+		bytes = min(chunk - offset, bytes);
 		status = balance_dirty_pages_ratelimited_flags(mapping,
 							       bdp_flags);
 		if (unlikely(status))
@@ -933,10 +935,12 @@ static loff_t iomap_write_iter(struct iomap_iter *iter, struct iov_iter *i)
 			 * halfway through, might be a race with munmap,
 			 * might be severe memory pressure.
 			 */
-			if (copied)
-				bytes = copied;
 			if (chunk > PAGE_SIZE)
 				chunk /= 2;
+			if (copied) {
+				bytes = copied;
+				goto retry;
+			}
 		} else {
 			pos += status;
 			written += status;
