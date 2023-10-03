Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E4097B642F
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 10:31:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230507AbjJCIbk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 04:31:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239188AbjJCIbg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 04:31:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0384A3;
        Tue,  3 Oct 2023 01:31:17 -0700 (PDT)
Date:   Tue, 03 Oct 2023 08:31:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1696321876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuTf4zBzupu3tS5EJOcDKJ82yoQ1Iej1IAmwDpUABmg=;
        b=wrwrzpsZKEqYpRdzSVhQidSUl3Jetb3IEbEMYmxzYeFRhJQFBd2gyHsoxrZg7cmLAWJ4PT
        ScsZzByrWBkOVD/CPx8c74ip0WGhyQoZUdx+T6vJzVkpQy5dRO7f8FkwiOHmm8Ka7Al2yF
        hgHqAqbC9IYH9izDhYiCh1UZlJyK8Oo68ouKLG39tEMO7BFps5f33igKO2Kl0NdOVj7tl7
        UpxVZC4L0/D+5kcsNm3oOsD7PHNxCG8I7R85FaSv/nmIVFCfldBFhlk9t1gwI2lQk6tNK+
        AjW84G2/bzoUA6CNsCc6En9k3sYa8MkpHEFdv0quDQEvb/ocKTVDi9oyZZvJ3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1696321876;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DuTf4zBzupu3tS5EJOcDKJ82yoQ1Iej1IAmwDpUABmg=;
        b=jjalq+DWKAVGnFvffD8pGgDRGJQOQKpkj4LifgvVKSVn3t9j2b0Z5ZDgr7G0ciXNHR4EyJ
        GuejQ9T93BG4pVBA==
From:   "tip-bot2 for Atul Kumar Pant" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/debug: Fix debugfs API return value
 checks to use IS_ERR()
Cc:     Atul Kumar Pant <atulpant.linux@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Waiman Long <longman@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807121834.7438-1-atulpant.linux@gmail.com>
References: <20230807121834.7438-1-atulpant.linux@gmail.com>
MIME-Version: 1.0
Message-ID: <169632187534.3135.6452660777810427626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     8788c6c2feb3600ba1a2f84ac5d258af4a284cea
Gitweb:        https://git.kernel.org/tip/8788c6c2feb3600ba1a2f84ac5d258af4a284cea
Author:        Atul Kumar Pant <atulpant.linux@gmail.com>
AuthorDate:    Mon, 07 Aug 2023 17:48:34 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 03 Oct 2023 10:11:25 +02:00

locking/debug: Fix debugfs API return value checks to use IS_ERR()

Update the checking of return values from debugfs_create_file()
and debugfs_create_dir() to use IS_ERR().

Signed-off-by: Atul Kumar Pant <atulpant.linux@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Waiman Long <longman@redhat.com>
Link: https://lore.kernel.org/r/20230807121834.7438-1-atulpant.linux@gmail.com
---
 kernel/locking/lock_events.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/lock_events.c b/kernel/locking/lock_events.c
index fa2c2f9..e68d820 100644
--- a/kernel/locking/lock_events.c
+++ b/kernel/locking/lock_events.c
@@ -146,7 +146,7 @@ static int __init init_lockevent_counts(void)
 	struct dentry *d_counts = debugfs_create_dir(LOCK_EVENTS_DIR, NULL);
 	int i;
 
-	if (!d_counts)
+	if (IS_ERR(d_counts))
 		goto out;
 
 	/*
@@ -159,14 +159,14 @@ static int __init init_lockevent_counts(void)
 	for (i = 0; i < lockevent_num; i++) {
 		if (skip_lockevent(lockevent_names[i]))
 			continue;
-		if (!debugfs_create_file(lockevent_names[i], 0400, d_counts,
-					 (void *)(long)i, &fops_lockevent))
+		if (IS_ERR(debugfs_create_file(lockevent_names[i], 0400, d_counts,
+					 (void *)(long)i, &fops_lockevent)))
 			goto fail_undo;
 	}
 
-	if (!debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
+	if (IS_ERR(debugfs_create_file(lockevent_names[LOCKEVENT_reset_cnts], 0200,
 				 d_counts, (void *)(long)LOCKEVENT_reset_cnts,
-				 &fops_lockevent))
+				 &fops_lockevent)))
 		goto fail_undo;
 
 	return 0;
