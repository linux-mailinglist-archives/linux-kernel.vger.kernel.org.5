Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D1CF7A2D54
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 04:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238350AbjIPCKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 22:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235779AbjIPCKD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 22:10:03 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9889B173C
        for <linux-kernel@vger.kernel.org>; Fri, 15 Sep 2023 19:09:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0623C433C8;
        Sat, 16 Sep 2023 02:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694830198;
        bh=DNLoykVfcLunzlqLq92ppaTwpNSuqGnLy/p/x4HnboY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VOW72m4+tcRyIHubvfGta2PK60I+MtD4+v+Xr+eH0EemTaxQPuTpCGCkUMLnjCAa+
         o/2hmGpyllSeicIhd3FysLe0WsJ8ETtGUxFa7DFAmLgljTuv8bSbEQX785z8vISz2W
         ULi87aU+zbisxJZKBJ7bMQ5GwcLGJYKr1vBzMsiUzRCaqaatj7WjHpB7n5/570XMYj
         QjUNjvbxGcwD9TPVr7FBbPoMwNYPLh3eRe/8kKkE8me85m9jNJL4GfTQoKudWnzImQ
         vsDZ2/2R8LpB8aAXw+R0ARwhL5AEaBGZAzoS/PYxAr/WWECQg4TsDtiObwoyz/ZEpc
         mD1gZAGqr5wfQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/9] mm/damon/sysfs-schemes: use nr_accesses_bp as the source of tried_regions/<N>/nr_accesses
Date:   Sat, 16 Sep 2023 02:09:38 +0000
Message-Id: <20230916020945.47296-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230916020945.47296-1-sj@kernel.org>
References: <20230916020945.47296-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON sysfs interface exposes access rate of each region via DAMOS tried
regions directory.  For this, the nr_accesses field of the region is
used.  DAMOS was actually using nr_accesses in the past, but it uses
nr_accesses_bp now.  Use the value that it is really using as the
source.

Note that this doesn't expose nr_accesses_bp as is (in basis point), but
after converting it to the natural number by dividing the value by
10,000.  Hence there is no behavioral change from users' perspective.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 527e7d17eb3b..093700f50b18 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -31,7 +31,7 @@ static struct damon_sysfs_scheme_region *damon_sysfs_scheme_region_alloc(
 		return NULL;
 	sysfs_region->kobj = (struct kobject){};
 	sysfs_region->ar = region->ar;
-	sysfs_region->nr_accesses = region->nr_accesses;
+	sysfs_region->nr_accesses = region->nr_accesses_bp / 10000;
 	sysfs_region->age = region->age;
 	INIT_LIST_HEAD(&sysfs_region->list);
 	return sysfs_region;
-- 
2.25.1

