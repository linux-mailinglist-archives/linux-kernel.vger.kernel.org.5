Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F14DA799C71
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Sep 2023 05:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345110AbjIJDlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Sep 2023 23:41:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237566AbjIJDk5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Sep 2023 23:40:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552391BF
        for <linux-kernel@vger.kernel.org>; Sat,  9 Sep 2023 20:40:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 606FBC433C9;
        Sun, 10 Sep 2023 03:40:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694317252;
        bh=P7zQCwnjvNM/0KUc4+YEr5PqkR+all9uO1LM0PE/RX4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LrXyTnttdpLzVeZIEYQ1KlPf1eGSXzz5UV1gKdhzO3/x5aa0WKFyKpbq5vjX+2YPa
         k1Gdsop+MdQM08S0rG5L+8BsW1Pl12AMmtn0AU7TlzZBlbItisrpjdTgcYeBdIE7H2
         8UpeGBcJO685O3hytod/LaJ+8cyLzSi7hJiW0WJsCjt5e9C3PV77c/bVTk8jtsn/zP
         8AMzsjEInb8mB/y5NWGGMGe6Bf0+IRcXNYw873mvEdT4tZ40aBQ6Yc4MWa4npct0Oc
         TgvrV+xEAsxQJR7081G3Y3uW2HmYFPbRPRSitFZnTa/nS8H+fVV2natp1V34kA95J2
         5TBv/I1QLkwJQ==
From:   SeongJae Park <sj@kernel.org>
Cc:     SeongJae Park <sj@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        damon@lists.linux.dev, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: [RFC 2/8] mm/damon/sysfs-schemes: expose nr_accesses_bp via tried_regions/<N>/nr_accesses
Date:   Sun, 10 Sep 2023 03:40:42 +0000
Message-Id: <20230910034048.59191-3-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230910034048.59191-1-sj@kernel.org>
References: <20230910034048.59191-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON sysfs interface exposes access rate of each region via DAMOS tried
regions directory.  For this, the nr_accesses field of the region is
being used.  DAMOS was using nr_accesses in the past, but it uses
nr_accesses_bp now.  Expose the value that it is really using.  Note
that it doesn't expose nr_accesses_bp as is (in basis point), but after
converting it to the natural number by dividing the value by 10,000.
That's for not making unnecessary confusion to the old users.

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

