Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37A707E3ED0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235379AbjKGMmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:42:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235361AbjKGMmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:42:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8C52D601;
        Tue,  7 Nov 2023 04:30:00 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78F4DC433C7;
        Tue,  7 Nov 2023 12:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360199;
        bh=pHapdtVG+ezAv00hB4D4TAQkE8/KzHg9zmzvqtBd/m4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hZqP0MjUxGJ+6f80RpLmwt+41qq5nIxudsCVHTQoeuoUFFcXp4vcaU3cFExdNIode
         L7+BtzNSTgwbocJyUkDsLGTuxFWyU8HxEw/6mOyfOhFNCnu9kh4LaeZUPiGmmExiVt
         3kqk6X/neLEBDZJRwR7dXxk5xL/X3QddLy7gRQu+TwUdLYURf9Tp3xWHF8l7YNqirA
         nyhylZn0SMBZr7Cs88U3LGJJM2fFGxHA9scipnSb02wBiBejjsWumS2YO2h9kqpxOs
         5R05551FQ6aow678goNDx7dgn8zx2h5hh38RDKhy7Oj6ecCTXyiozDs/oNjNUT1avV
         ya4pSmmpl16CQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Zack Rusin <zackr@vmware.com>, Sasha Levin <sashal@kernel.org>,
        brauner@kernel.org, ddiss@suse.de, code@siddh.me,
        dhowells@redhat.com, nick.alcock@oracle.com
Subject: [PATCH AUTOSEL 5.15 06/20] kernel: watch_queue: copy user-array safely
Date:   Tue,  7 Nov 2023 07:29:00 -0500
Message-ID: <20231107122940.3762228-6-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122940.3762228-1-sashal@kernel.org>
References: <20231107122940.3762228-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Philipp Stanner <pstanner@redhat.com>

[ Upstream commit ca0776571d3163bd03b3e8c9e3da936abfaecbf6 ]

Currently, there is no overflow-check with memdup_user().

Use the new function memdup_array_user() instead of memdup_user() for
duplicating the user-space array safely.

Suggested-by: David Airlie <airlied@redhat.com>
Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Zack Rusin <zackr@vmware.com>
Signed-off-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230920123612.16914-5-pstanner@redhat.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/watch_queue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/watch_queue.c b/kernel/watch_queue.c
index 54cbaa9711398..ae31bf8d2feb1 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -338,7 +338,7 @@ long watch_queue_set_filter(struct pipe_inode_info *pipe,
 	    filter.__reserved != 0)
 		return -EINVAL;
 
-	tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
+	tf = memdup_array_user(_filter->filters, filter.nr_filters, sizeof(*tf));
 	if (IS_ERR(tf))
 		return PTR_ERR(tf);
 
-- 
2.42.0

