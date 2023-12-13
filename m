Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB42A810CD9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbjLMJAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:00:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjLMJAP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:00:15 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D736AD
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:00:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71122C433C9;
        Wed, 13 Dec 2023 09:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702458021;
        bh=KYg70uTTMCVbbybOUe4N/VTYl2TBfccDvrHX9QOYSpI=;
        h=From:To:Cc:Subject:Date:From;
        b=QRMKY1CjqdvbZ0fbr2tBAwGIzwJ4uuPaNCuYkelu9eHILPcC0WvZTScIzOI0dNK6V
         p1zR4KyknBgnnd5nC0szCG01DrkV10nVXhXEHNpRgKjg6a7oiP96Z57Ac5xlStWol6
         NVYSF2Rjf0QHrI7WipJ/iT1qYwm5S7kVASmGKI9t0uZifTt31XCU1DFiWWkMMO6pBo
         un3hUZCgfnLgjKqP9Bhj6on6scYXyuwRyLSPZKGkH7na7rgPBgSx7s4aeZUv65A7kH
         eJgltZHbSlNr5p2rGIBgU9stsuQBnnQXq21MW1fKdlqy4KK3mgRuurRBFCKEoqMB66
         f/f8r09VGOqxQ==
From:   Arnd Bergmann <arnd@kernel.org>
To:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Christian Brauner <brauner@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>, Jan Kara <jack@suse.cz>,
        Ian Kent <raven@themaw.net>,
        Miklos Szeredi <mszeredi@redhat.com>,
        "Seth Forshee (DigitalOcean)" <sforshee@kernel.org>,
        Dave Chinner <dchinner@redhat.com>,
        Amir Goldstein <amir73il@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [v2] statmount: reduce runtime stack usage
Date:   Wed, 13 Dec 2023 10:00:03 +0100
Message-Id: <20231213090015.518044-1-arnd@kernel.org>
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

Replace the assignment with an in-place memset() plus assignment that
should always be more efficient for both stack usage and runtime cost.

Fixes: 49889374ab92 ("statmount: simplify string option retrieval")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/namespace.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/namespace.c b/fs/namespace.c
index d036196f949c..159f1df379fc 100644
--- a/fs/namespace.c
+++ b/fs/namespace.c
@@ -4957,15 +4957,12 @@ static int prepare_kstatmount(struct kstatmount *ks, struct mnt_id_req *kreq,
 	if (!access_ok(buf, bufsize))
 		return -EFAULT;
 
-	*ks = (struct kstatmount){
-		.mask		= kreq->param,
-		.buf		= buf,
-		.bufsize	= bufsize,
-		.seq = {
-			.size	= seq_size,
-			.buf	= kvmalloc(seq_size, GFP_KERNEL_ACCOUNT),
-		},
-	};
+	memset(ks, 0, sizeof(*ks));
+	ks->mask = kreq->param;
+	ks->buf = buf;
+	ks->bufsize = bufsize;
+	ks->seq.size = seq_size;
+	ks->seq.buf = kvmalloc(seq_size, GFP_KERNEL_ACCOUNT);
 	if (!ks->seq.buf)
 		return -ENOMEM;
 	return 0;
-- 
2.39.2

