Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7EB37E317F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:34:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233470AbjKFXeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjKFXeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:34:16 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C6983;
        Mon,  6 Nov 2023 15:34:14 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F12C433CA;
        Mon,  6 Nov 2023 23:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699313653;
        bh=19smz8vjkknnlftKxQDFJP/XhxeknF20W/DyGkIS8Os=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=D1wTspPUeGLo6x8Q/O1NGf9r8R7Y77Rea13Em+t/uPG+M8MB1RkYbqzvbkzEFu/2o
         +EbJZr5EpmuJNr37DT7pK4w7FQz0S3gGCgTdLEjwu0j0llYH7NAk8oU5KIZyMrGTDa
         xU8ou+PE7Hw8IjLv9dyB+hxXwQngY+1i+Ioz1CMmAr4QR9KqCjMOtErZW426EoDG0n
         ZWwH3Jx6nAAnd11/pOFJY9vSHUNoDTRFu1AngsTYsvE2korQlJDZmaQT6CsbPoIwr5
         yzi1Mp+MivvdfbKoUGQsKHXEJT583q7JL2Znk9lwUlXiHrruB3lltIK3NLWFk4pDhE
         SzPy2Mk286CAw==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 3/3] mm/damon/sysfs-schemes: handle tried region directory allocation failure
Date:   Mon,  6 Nov 2023 23:34:08 +0000
Message-Id: <20231106233408.51159-4-sj@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231106233408.51159-1-sj@kernel.org>
References: <20231106233408.51159-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DAMON sysfs interface's before_damos_apply callback
(damon_sysfs_before_damos_apply()), which creates the DAMOS tried
regions for each DAMOS action applied region, is not handling the
allocation failure for the sysfs directory data.  As a result, NULL
pointer derefeence is possible.  Fix it by handling the case.

Fixes: f1d13cacabe1 ("mm/damon/sysfs: implement DAMOS tried regions update command")
Cc: <stable@vger.kernel.org> # 6.2.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/sysfs-schemes.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/mm/damon/sysfs-schemes.c b/mm/damon/sysfs-schemes.c
index 7413cb35c5a9..be667236b8e6 100644
--- a/mm/damon/sysfs-schemes.c
+++ b/mm/damon/sysfs-schemes.c
@@ -1826,6 +1826,8 @@ static int damon_sysfs_before_damos_apply(struct damon_ctx *ctx,
 		return 0;
 
 	region = damon_sysfs_scheme_region_alloc(r);
+	if (!region)
+		return 0;
 	list_add_tail(&region->list, &sysfs_regions->regions_list);
 	sysfs_regions->nr_regions++;
 	if (kobject_init_and_add(&region->kobj,
-- 
2.34.1

