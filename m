Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0EA7E2D84
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Nov 2023 21:03:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232940AbjKFUDi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 15:03:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231777AbjKFUDf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 15:03:35 -0500
Received: from out-183.mta1.migadu.com (out-183.mta1.migadu.com [IPv6:2001:41d0:203:375::b7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BBBD45
        for <linux-kernel@vger.kernel.org>; Mon,  6 Nov 2023 12:03:32 -0800 (PST)
Message-ID: <d10cdf1d-4a67-48df-b389-3a51f60e9431@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1699300471;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=vU+9mLKaBt/9PJ4s/VTap23H3EjIRGGrzaVjKta+G/s=;
        b=xpCJ1ElKH72f9/zGJuXVlwvCzM3N90Yye4IigCBUUFw0Glb8AM0AmVBD5Y/9aGSVXPOGdG
        haJI+msf6/4p9LW156nfi/eW4Yg8aUOo7H6BvjnykClnGgXvbGsme+B79lfQU05+IpEk31
        onMDf3PLaoP5YdCGA9mwkmkRTQsuMI4=
Date:   Mon, 6 Nov 2023 22:54:28 +0300
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Vasily Averin <vasily.averin@linux.dev>
Subject: [PATCH] zram: unsafe zram_get_element call in zram_read_page()
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

Taken lock is required to access the content of zram entry.

Fixes: 8e19d540d107 ("zram: extend zero pages to same element pages")
Signed-off-by: Vasily Averin <vasily.averin@linux.dev>
---
 drivers/block/zram/zram_drv.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index d77d3664ca08..9ac3d4e51d26 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1362,14 +1362,14 @@ static int zram_read_page(struct zram *zram, struct page *page, u32 index,
 		ret = zram_read_from_zspool(zram, page, index);
 		zram_slot_unlock(zram, index);
 	} else {
+		unsigned long entry = zram_get_element(zram, index);
 		/*
 		 * The slot should be unlocked before reading from the backing
 		 * device.
 		 */
 		zram_slot_unlock(zram, index);
 
-		ret = read_from_bdev(zram, page, zram_get_element(zram, index),
-				     parent);
+		ret = read_from_bdev(zram, page, entry, parent);
 	}
 
 	/* Should NEVER happen. Return bio error if it does. */
-- 
2.34.1

