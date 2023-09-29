Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 854D67B2C39
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 08:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232683AbjI2GPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 02:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjI2GPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 02:15:04 -0400
Received: from mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0700098
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 23:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1695968086; bh=sUtnhl+BN0pAXgvT1VA9dfcxtXJrnbj9wF0wciOqpdA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:MIME-Version:
         Content-Type;
        b=BT5FFlQpPpYYiLWCg0obrQwHB6L2jyl1IDQj4NY5PfCuvzM71FERDYaVd2NdJ48Pq
         Cchkcw4ji4i6zgQbnC7a3yMpUUgBsHN/bIIiBwonfYk/btOo0uizwSWjwhn7wzkPOl
         G7fnpFFwQLvucAEwRU5T1RZn/pRHsU9gHvLyAhiw=
Received: by b221-3.in.mailobj.net [192.168.90.23] with ESMTP
        via ip-20.mailobj.net [213.182.54.20]
        Fri, 29 Sep 2023 08:14:46 +0200 (CEST)
X-EA-Auth: mJrxcB5o/rp3CdNHoV+lGMylfQKBbaAvaC4JHT2Uwm3geFEykZ96si8l7FTXLh3ZxpTAt34dRlCrz8K4QFKtJ4AC9NHhu1Tb
Date:   Fri, 29 Sep 2023 11:44:40 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Bob Peterson <rpeterso@redhat.com>,
        Andreas Gruenbacher <agruenba@redhat.com>,
        gfs2@lists.linux.dev, linux-kernel@vger.kernel.org
Cc:     linux-kernel-mentees@lists.linuxfoundation.org,
        Dan Carpenter <error27@gmail.com>,
        Deepak R Varma <drv@mailo.com>
Subject: [PATCH] gfs2: Set error on error path
Message-ID: <ZRZrUMzweaJeEJuD@runicha.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Set the error variable inside the error path on failure. Saves
unnecessary variable assignment during normal execution.

Signed-off-by: Deepak R Varma <drv@mailo.com>
---
 fs/gfs2/bmap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/gfs2/bmap.c b/fs/gfs2/bmap.c
index ef7017fb6951..93bd8ea34444 100644
--- a/fs/gfs2/bmap.c
+++ b/fs/gfs2/bmap.c
@@ -162,9 +162,10 @@ int gfs2_unstuff_dinode(struct gfs2_inode *ip)
 
 	down_write(&ip->i_rw_mutex);
 	page = grab_cache_page(inode->i_mapping, 0);
-	error = -ENOMEM;
-	if (!page)
+	if (!page) {
+		error = -ENOMEM;
 		goto out;
+	}
 	error = __gfs2_unstuff_inode(ip, page);
 	unlock_page(page);
 	put_page(page);
-- 
2.39.2



