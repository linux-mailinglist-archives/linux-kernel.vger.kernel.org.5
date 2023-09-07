Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD233796EED
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 04:29:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245064AbjIGC34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 22:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243488AbjIGC3q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 22:29:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7474F19A8
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 19:29:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E90E7C433D9;
        Thu,  7 Sep 2023 02:29:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694053783;
        bh=ey6ldgAd6VTxnRDoPtCtQlr0A3IAnRC6k78ku2lztFc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=o5w62vS3iAkNVuzYgY9bfNL4wHOb5z8v2SB71t6EVqtoa8SA11fQws6liGofafFMo
         p8YQONgSgi2PrcMcx4kRPKTnnkIXVq+T1F6uLipVw79Q83LbAwU6y0a0xAjmmGBI3a
         Qy/07A+eOLSlFgEP0sKXQqwPmigbHXrm0JGjzBbAuJbX2SriKrQ8PW+HGJDuIDIalY
         G+kkyD7yTeSglfm6B5Wt3S064RhYrOztpWqbp1us/4OowA0TWkqW/8E63Ooa6Hxefr
         66k8OkJbNqIzn+YiAzcNVQcfgU1rLO034hJIKGrtYOYB0QvlE4wLe6a4gGRCytSnCj
         Mhm23vrRe1GgQ==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: [PATCH 08/11] mm/damon/core: fix a comment about damon_set_attrs() call timings
Date:   Thu,  7 Sep 2023 02:29:26 +0000
Message-Id: <20230907022929.91361-9-sj@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230907022929.91361-1-sj@kernel.org>
References: <20230907022929.91361-1-sj@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The comment on damon_set_attrs() says it should not be called while the
kdamond is running, but now some DAMON modules like sysfs interface and
DAMON_RECLAIM call it from after_aggregation() and/or
after_wmarks_check() callbacks for online tuning.  Update the comment.

Signed-off-by: SeongJae Park <sj@kernel.org>
---
 mm/damon/core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/mm/damon/core.c b/mm/damon/core.c
index 28c7c49882d3..1ce483a3c2b5 100644
--- a/mm/damon/core.c
+++ b/mm/damon/core.c
@@ -570,7 +570,11 @@ static void damon_update_monitoring_results(struct damon_ctx *ctx,
  * @ctx:		monitoring context
  * @attrs:		monitoring attributes
  *
- * This function should not be called while the kdamond is running.
+ * This function should be called while the kdamond is not running, or an
+ * access check results aggregation is not ongoing (e.g., from
+ * &struct damon_callback->after_aggregation or
+ * &struct damon_callback->after_wmarks_check callbacks).
+ *
  * Every time interval is in micro-seconds.
  *
  * Return: 0 on success, negative error code otherwise.
-- 
2.25.1

