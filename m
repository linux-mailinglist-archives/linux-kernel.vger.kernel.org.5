Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67AF7E317C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 00:34:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjKFXeP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Nov 2023 18:34:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233321AbjKFXeN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Nov 2023 18:34:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90F9883;
        Mon,  6 Nov 2023 15:34:11 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D15AEC433C8;
        Mon,  6 Nov 2023 23:34:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699313651;
        bh=MtIChiGlAMl9WTJvVSRQmuDT6RxSD+NBrsKsO1Hl6Io=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UyoPvSX0uc/PWJFKoa+VUDxKq/E/FXknGdVXc5LledMo3lXe9IT0oRt5RQemS8eDn
         ofZwHuP518ZGSpd/p2iBOmqYK51qD8Jfy+GUrzPHxN3Efbc12q8lf3CyJVlx5SCaeE
         yyTR10BkFHQeE4KhahwXsPuOaDPe+rBdNAWYOwCW6mxNfkOc3H8kz/nw9ziN3Td/B8
         ccVLiR9YzBxtkhVjVtOTIIqYPB4+2MiBrqNyFMGGVzs2/Q+OeJiPYZYodODtGKExOQ
         eRaMsQXN36VQLRMi6tPFYVJJYI+AA75HN3DJf9l/fg/xDKdWUtd7iRuYq0d/eUxfZz
         YOYXIHDrJhrhA==
From:   SeongJae Park <sj@kernel.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     SeongJae Park <sj@kernel.org>, damon@lists.linux.dev,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/3] mm/damon/sysfs: check error from damon_sysfs_update_target()
Date:   Mon,  6 Nov 2023 23:34:06 +0000
Message-Id: <20231106233408.51159-2-sj@kernel.org>
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

damon_sysfs_update_target() returns error code for failures, but its
caller, damon_sysfs_set_targets() is ignoring that.  The update function
seems making no critical change in case of such failures, but the
behavior will look like DAMON sysfs is silently ignoring or only
partially accepting the user input.  Fix it.

Fixes: 19467a950b49 ("mm/damon/sysfs: remove requested targets when online-commit inputs")
Cc: <stable@vger.kernel.org> # 5.19.x
Signed-off-by: SeongJae Park <sj@kernel.org>
---

Note that yet another fix[1] should be applied before this.

[1] https://lore.kernel.org/all/739e6aaf-a634-4e33-98a8-16546379ec9f@moroto.mountain/

 mm/damon/sysfs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/damon/sysfs.c b/mm/damon/sysfs.c
index 1dfa96d4de99..7472404456aa 100644
--- a/mm/damon/sysfs.c
+++ b/mm/damon/sysfs.c
@@ -1203,8 +1203,10 @@ static int damon_sysfs_set_targets(struct damon_ctx *ctx,
 
 	damon_for_each_target_safe(t, next, ctx) {
 		if (i < sysfs_targets->nr) {
-			damon_sysfs_update_target(t, ctx,
+			err = damon_sysfs_update_target(t, ctx,
 					sysfs_targets->targets_arr[i]);
+			if (err)
+				return err;
 		} else {
 			if (damon_target_has_pid(ctx))
 				put_pid(t->pid);
-- 
2.34.1

