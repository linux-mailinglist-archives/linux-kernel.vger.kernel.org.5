Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1759880F9B9
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 22:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377559AbjLLVsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 16:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235165AbjLLVsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 16:48:18 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2F8BAB
        for <linux-kernel@vger.kernel.org>; Tue, 12 Dec 2023 13:48:25 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D95D0C433C8;
        Tue, 12 Dec 2023 21:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702417705;
        bh=wVW4B4dpDL0SVJV6h8hwO86hfQnu7Dv3P3WCPwRyals=;
        h=From:To:Cc:Subject:Date:From;
        b=dHuBGdEkvGgWZiAVBXqaCQtFzOWV7PsCszdXbNCNkEUvgKH8OVVjrYnWfaVAxhVXH
         nxl1ZdNew2m2TsOP5tA7cLqvsJ5J8dqSUyUKPJm8wn4d7tjLbXT3iC+93GoFvOYsyY
         HJUiu8QPgOeXlFOZluNyO0Sf5PpyVqldWe2Bci+UwgkJRzQAjtJzLJVfEf3gQKymX0
         kYk4qwKeKsaTyCueQKXHGgDIiL6Son3oeM/n7Mc8fVqBnx9ejiWwALrrNbGPW3i9Wj
         yAnerwoiQCcNHhiwIjqpbJkxkPeafpbWQeDnFr/LfKLIDTNOVUYelIzMFhUHPYgcRh
         5dq9/NoIxKdIg==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Miklos Szeredi <mszeredi@redhat.com>,
        Ian Kent <raven@themaw.net>,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] statmount: reduce runtime stack usage
Date:   Tue, 12 Dec 2023 22:48:13 +0100
Message-Id: <20231212214819.247611-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.2
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

From: Arnd Bergmann <arnd@arndb.de>

prepare_kstatmount() constructs a copy of 'struct kstatmount' on the stack
and copies it into the local variable on the stack of its caller. Because
of the size of this structure, this ends up overflowing the limit for
a single function's stack frame when prepare_kstatmount() gets inlined
and both copies are on the same frame without the compiler being able
to collapse them into one:

fs/namespace.c:4995:1: error: stack frame size (1536) exceeds limit (1024) in '__se_sys_statmount' [-Werror,-Wframe-larger-than]
 4995 | SYSCALL_DEFINE4(statmount, const struct mnt_id_req __user *, req,

Mark the inner function as noinline_for_stack so the second copy is
freed before calling do_statmount() enters filesystem specific code.
The extra copy of the structure is a bit inefficient, but this
system call should not be performance critical.

Fixes: 49889374ab92 ("statmount: simplify string option retrieval")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/namespace.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d036196f949c..e22fb5c4a9bb 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4950,7 +4950,8 @@ static inline bool retry_statmount(const long ret, size_t *seq_size)
 	return true;
 }
 
-static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
+static int noinline_for_stack
+prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 			      struct statmount __user *buf, size_t bufsize,
 			      size_t seq_size)
 {
-- 
2.39.2

