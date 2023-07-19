Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7652759955
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 17:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjGSPRf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 11:17:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231351AbjGSPRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 11:17:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9833BBE;
        Wed, 19 Jul 2023 08:17:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 288A76173E;
        Wed, 19 Jul 2023 15:17:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DD4C433C8;
        Wed, 19 Jul 2023 15:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689779842;
        bh=cdptwf+tCAM2+aWoAXX9cPeXcqVcV7F8UHRwJ0Ju4kw=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=t/oe2DsB04e2eegO989Vv0cqI+6ZK/iNawU1RvdIfkuDSQ6pCeymBGqCjMhkAdNd8
         vUUNDzEGV6Pdt9GW6Os5Q0hNFGyaCDP3tJJ7EIqeHxQ1wclu0Sg9jWmW6Acqx7eKYe
         L+hVEr98EfnROW5I/GJBIp04UoymQZ6NKneQ4nlg+1SuoqTqo1URYaAoQb+g3z4/fq
         jnyy5aNv4G6uQC4ZLxd+OG2fawqUDtXAXAtYf33BQXZOaLsv/T+iGg/n5g8oQfPf9m
         TI3lBlDRwaubvCnZ0SwRGzImqW2wCh1WpRqoJJTv0IUVS0AqrSjjRfz4hA/k8HDCLy
         Q/a+AKWsCMQfw==
From:   Eric Van Hensbergen <ericvh@kernel.org>
Date:   Wed, 19 Jul 2023 15:17:06 +0000
Subject: [PATCH v3 2/4] fs/9p: fix typo in comparison logic for cache mode
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230716-fixes-overly-restrictive-mmap-v3-2-769791f474fd@kernel.org>
References: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
In-Reply-To: <20230716-fixes-overly-restrictive-mmap-v3-0-769791f474fd@kernel.org>
To:     Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Christian Schoenebeck <linux_oss@crudebyte.com>
Cc:     v9fs@lists.linux.dev, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de, stable@vger.kernel.org,
        Robert Schwebel <r.schwebel@pengutronix.de>,
        Eric Van Hensbergen <ericvh@kernel.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=1068; i=ericvh@kernel.org;
 h=from:subject:message-id; bh=cdptwf+tCAM2+aWoAXX9cPeXcqVcV7F8UHRwJ0Ju4kw=;
 b=owEBbQKS/ZANAwAKAYj/1ftKX/+YAcsmYgBkt/5/HnwbXRdNIzUha4P+gQM2t1MHNIResSrWm
 bTMBQOwTuqJAjMEAAEKAB0WIQSWlvDRlqWQmKTK0VGI/9X7Sl//mAUCZLf+fwAKCRCI/9X7Sl//
 mEshD/43bFiL1TWaXPJYjtdnXsN4qkzvuLpslJVZnNOdR0dfKG4KEKO3/TYZYGt+SFSjm/6oZeh
 /VNFGu98+1QS5WT8+b1ezHW/hiyi22DyLyD9ohYP1Aoor9MijoDgu5YNlz/UetUSIu2+G5FjRqp
 K1PMamBX72Rp16AOrafjmoZM+onrZSwtQVQhjgDrRwBcM3IYSVT8IdvwSwUNQiDwcySi+AngtGq
 gA+3+GXEnjr2kAnLNF5PYeFbaO1z+Qsm0YcvZYn7WQi4ipCIvy5H8SZgpivpqLRnZSlgP6aMUs4
 odkx+RibL0RhJ5IX+5wgby16UKrrwF/xONA9X/q6h2JGVEp9k5Rw+1mLjnxMfhpikCBV7uY8Ddd
 pmknhTFPko/zZHjbo21AdBBKrUewFvFV9VAReseKrmO1VlRvxvtifJ/EFKCU9gLz9wrIE4dQW6o
 rt6zVGgUj1vZNiJhhpBL2H7Ay+6P0c0N5smWYQFpBR8gkLxdcx098uOa7y6vsNjfKDVqmTUy77J
 tFgMwTSubsmTf1J1mPd43K7N0JnCabqjW0ZcXUwudu8bAPGlCi43qMw6frlFVOPjxqxCXJOC/JX
 IhNcXnrsc+2PgJgHVjjkkEKqk6WpzqziMHYNHJXAOgRY5vehDaIoDyQY3Dg9W7cRyvSxN1fFG/j
 FuashKVhN2c/19g==
X-Developer-Key: i=ericvh@kernel.org; a=openpgp;
 fpr=9696F0D196A59098A4CAD15188FFD5FB4A5FFF98
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There appears to be a typo in the comparison statement for the logic
which sets a file's cache mode based on mount flags.

Fixes: 1543b4c5071c ("fs/9p: remove writeback fid and fix per-file modes")
Link: https://lore.kernel.org/v9fs/ZK25XZ%2BGpR3KHIB%2F@pengutronix.de/
Reviewed-by: Christian Schoenebeck <linux_oss@crudebyte.com>
Reviewed-by: Dominique Martinet <asmadeus@codewreck.org>
Signed-off-by: Eric Van Hensbergen <ericvh@kernel.org>
---
 fs/9p/fid.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/9p/fid.h b/fs/9p/fid.h
index 0c51889a60b3..297c2c377e3d 100644
--- a/fs/9p/fid.h
+++ b/fs/9p/fid.h
@@ -57,7 +57,7 @@ static inline void v9fs_fid_add_modes(struct p9_fid *fid, int s_flags,
 	   (s_flags & V9FS_DIRECT_IO) || (f_flags & O_DIRECT)) {
 		fid->mode |= P9L_DIRECT; /* no read or write cache */
 	} else if ((!(s_cache & CACHE_WRITEBACK)) ||
-				(f_flags & O_DSYNC) | (s_flags & V9FS_SYNC)) {
+				(f_flags & O_DSYNC) || (s_flags & V9FS_SYNC)) {
 		fid->mode |= P9L_NOWRITECACHE;
 	}
 }

-- 
2.39.2

