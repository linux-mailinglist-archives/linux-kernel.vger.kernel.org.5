Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099477E3EB1
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 13:40:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235269AbjKGMkp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 07:40:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343950AbjKGMjc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 07:39:32 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 359FBA5DA;
        Tue,  7 Nov 2023 04:28:27 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B356DC433CA;
        Tue,  7 Nov 2023 12:28:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699360106;
        bh=JaPKyLMlKFE8bXbGcIjUV2W9JJtH/TbKT8Wg2KfWTzw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PUFDePUKUAK5ef8W+QQJcULvA94vrruY1f6xj7dwQviKhxHVLWsHIT5qnB75jptK2
         +TYSV7g1ztLRpm5aO5UfLMvRyyKbvek6AG4dqc3l7ROGg8OWRD7UkIZlsqaTwJFZbX
         gK/uydRGr83Ge0DaqU/QfiTTbZtkGbUQmTfOdIH7LIZ3UvWkQJcxW40EZ+SgX+VfP3
         1gV5fMV07/K2mpC8leUPo+BaZbC0674+J8ZqJp+w+9GJvzk/d8+LYvDEH3/kTvFCH5
         88dnIrFlx+0GBvpODQg24zDv47e49C9Sct7jI9Ae8f+7492PD36prmAS7Lbtm9Ael6
         XpNN09s3IpMag==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Philipp Stanner <pstanner@redhat.com>,
        David Airlie <airlied@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Zack Rusin <zackr@vmware.com>, Sasha Levin <sashal@kernel.org>,
        brauner@kernel.org, nick.alcock@oracle.com, ddiss@suse.de,
        code@siddh.me
Subject: [PATCH AUTOSEL 6.1 09/25] kernel: watch_queue: copy user-array safely
Date:   Tue,  7 Nov 2023 07:26:48 -0500
Message-ID: <20231107122745.3761613-9-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107122745.3761613-1-sashal@kernel.org>
References: <20231107122745.3761613-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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
index 28ed71d277bd7..442bb92212f2a 100644
--- a/kernel/watch_queue.c
+++ b/kernel/watch_queue.c
@@ -332,7 +332,7 @@ long watch_queue_set_filter(struct pipe_inode_info *pipe,
 	    filter.__reserved != 0)
 		return -EINVAL;
 
-	tf = memdup_user(_filter->filters, filter.nr_filters * sizeof(*tf));
+	tf = memdup_array_user(_filter->filters, filter.nr_filters, sizeof(*tf));
 	if (IS_ERR(tf))
 		return PTR_ERR(tf);
 
-- 
2.42.0

