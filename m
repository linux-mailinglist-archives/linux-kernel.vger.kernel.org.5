Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 381CA7F2008
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:17:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjKTWPU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:15:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjKTWPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:15:18 -0500
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E00AC95
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:15:13 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1700518511;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=eAV0U0mLkg/3ylSYaE6a69rqhR2UGGa2kQaKBkZ2jZw=;
        b=EVUmn3+MsuT4bi/Wnd+U6PyJ/buLTs5xg27GpRI8RlF4u0lOjFHvYFFgroHRxc0r3Qvt8W
        niMi6XLGqm13R3htx0KcdBz7hI0yDDqvtwP0zarbV6ChcOfCmbCPVi2puncsOLJ7natqDA
        uMQPuUX54rTQgKxu9oeU/1UwaA38u9w=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        Nicholas Piggin <npiggin@gmail.com>,
        Mike Christie <michael.christie@oracle.com>,
        Zqiang <qiang1.zhang@intel.com>, Petr Mladek <pmladek@suse.com>
Subject: [PATCH] kthread: kthread_should_stop() checks if we're a kthread
Date:   Mon, 20 Nov 2023 17:15:03 -0500
Message-ID: <20231120221503.3378095-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

bcachefs has a fair amount of code that may or may not be running from a
kthread (it may instead be called by a userspace ioctl); having
kthread_should_stop() check if we're a kthread enables a fair bit of
cleanup and makes it safer to use.

Cc: Nicholas Piggin <npiggin@gmail.com>
Cc: Mike Christie <michael.christie@oracle.com>
Cc: Zqiang <qiang1.zhang@intel.com>
Cc: Petr Mladek <pmladek@suse.com>
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 kernel/kthread.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 1eea53050bab..fe6090ddf414 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -155,7 +155,8 @@ void free_kthread_struct(struct task_struct *k)
  */
 bool kthread_should_stop(void)
 {
-	return test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
+	return (current->flags & PF_KTHREAD) &&
+		test_bit(KTHREAD_SHOULD_STOP, &to_kthread(current)->flags);
 }
 EXPORT_SYMBOL(kthread_should_stop);
 
-- 
2.42.0

