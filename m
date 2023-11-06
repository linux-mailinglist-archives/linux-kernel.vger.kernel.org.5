Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB4F7E2D81
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:03:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjKFUDg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:03:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231483AbjKFUDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:03:35 -0500
X-Greylist: delayed 540 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 06 Nov 2023 12:03:32 PST
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 185A71BF
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:03:32 -0800 (PST)
Message-ID: <ec494d90-3f04-4ab4-870b-bb4f015eb0ed@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699300519;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=phlU4gV4Aft/tjiYrtjDOJr6Ls/Rl5IpOB+DSxP4KLc=;
        b=xZQwR1W75ReIaJ8QXWSP7HwDPs0OJKfjtfTYVK6q9TY2bH0x9z7cbpyRf35O3yseKlwgHX
        zoOd8CU1UJ+S9G37A3Xb4p+m05SrUJhAqvRc057IXSlxd0+ssH7UawYdv/BhUtikMNFBQv
        w0Z1hI0W4IEXmGMex3X8wOEc4KQOqus=
Date:   Mon, 6 Nov 2023 22:55:19 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: [PATCH] zram: extra zram_get_element call in zram_read_from_zspool()
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        zhouxianrong <zhouxianrong@huawei.com>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

'element' and 'handle' are union in struct zram_table_entry.

Fixes: 8e19d540d107 ("zram: extend zero pages to same element pages")
Signed-off-by: Vasily Averin <vasily.averin@linux.dev>
---
 drivers/block/zram/zram_drv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 9ac3d4e51d26..f4d342d11b81 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1318,12 +1318,10 @@ static int zram_read_from_zspool(struct zram *zram, struct page *page,
 
 	handle = zram_get_handle(zram, index);
 	if (!handle || zram_test_flag(zram, index, ZRAM_SAME)) {
-		unsigned long value;
 		void *mem;
 
-		value = handle ? zram_get_element(zram, index) : 0;
 		mem = kmap_atomic(page);
-		zram_fill_page(mem, PAGE_SIZE, value);
+		zram_fill_page(mem, PAGE_SIZE, handle);
 		kunmap_atomic(mem);
 		return 0;
 	}
-- 
2.34.1

