Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F99879D969
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 21:16:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237460AbjILTQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 15:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229946AbjILTQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 15:16:05 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7B618D;
        Tue, 12 Sep 2023 12:16:01 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 363EDC433CA;
        Tue, 12 Sep 2023 19:16:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694546161;
        bh=P8ml4WIbf3VrqNEVQ7he6hkC9dekC4bJOyuRtdzlkzY=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=p8c7CI+hstgKYo8sDJ+cZg1RRxPjCX2SKnKFymZ2BT0hiu2DhnUQ6dJTIFJsALuK/
         daykwt6rIfS0MsQP+JQL8Ej/bYXt9UkBixIyKojBsdQ+ifoZYxT0ueWOS90oRKvRs9
         HJIjJrz9hqXUuwD/j25Ca2ng47kiF86eRzMYGA9V5+qkVxyVTp4vnc0TQjASRvnGUA
         OX+pM5GGuC6Bsk/f93zM1yMOCW1tIEildmF1l4881JEKMNNrSOkGq7NCShW8xI75tP
         IEsIMTAiv9ZxIyP12RAvw4ZtwKOWZKcoZsNrPjNf8Ub9zwtXQerwMSr2tckqKMl+um
         fXnvT2F6MZ2nQ==
From:   Nathan Chancellor <nathan@kernel.org>
Date:   Tue, 12 Sep 2023 12:15:38 -0700
Subject: [PATCH 1/7] bcachefs: Fix -Wformat in
 bch2_set_bucket_needs_journal_commit()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230912-bcachefs-warning-fixes-v1-1-a1cc83a38836@kernel.org>
References: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
In-Reply-To: <20230912-bcachefs-warning-fixes-v1-0-a1cc83a38836@kernel.org>
To:     kent.overstreet@linux.dev
Cc:     bfoster@redhat.com, linux-bcachefs@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        patches@lists.linux.dev, Nathan Chancellor <nathan@kernel.org>
X-Mailer: b4 0.13-dev
X-Developer-Signature: v=1; a=openpgp-sha256; l=2919; i=nathan@kernel.org;
 h=from:subject:message-id; bh=P8ml4WIbf3VrqNEVQ7he6hkC9dekC4bJOyuRtdzlkzY=;
 b=owGbwMvMwCEmm602sfCA1DTG02pJDKkMO947FFZ9uuwex1Bq1P1+3xE/haqPdjr/znP8/vGq1
 kboTLtmRykLgxgHg6yYIkv1Y9XjhoZzzjLeODUJZg4rE8gQBi5OAZjIofkM/9QvzLzxQluzLfGR
 vtDH83cil+8uCEielXruiw3rdZZJoW6MDO/OMP51XrD32s+e3g8ODCUTHF6sYRY8k3zD/++MvZZ
 OnWwA
X-Developer-Key: i=nathan@kernel.org; a=openpgp;
 fpr=2437CB76E544CB6AB3D9DFD399739260CB6CB716
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building bcachefs for 32-bit ARM, there is a compiler warning in
bch2_set_bucket_needs_journal_commit() due to a debug print using the
wrong specifier:

  fs/bcachefs/buckets_waiting_for_journal.c:137:30: error: format specifies type 'size_t' (aka 'unsigned int') but the argument has type 'unsigned long' [-Werror,-Wformat]
    136 |         pr_debug("took %zu rehashes, table at %zu/%zu elements",
        |                                                   ~~~
        |                                                   %lu
    137 |                  nr_rehashes, nr_elements, 1UL << b->t->bits);
        |                                            ^~~~~~~~~~~~~~~~~
  include/linux/printk.h:579:26: note: expanded from macro 'pr_debug'
    579 |         dynamic_pr_debug(fmt, ##__VA_ARGS__)
        |                          ~~~    ^~~~~~~~~~~
  include/linux/dynamic_debug.h:270:22: note: expanded from macro 'dynamic_pr_debug'
    270 |                            pr_fmt(fmt), ##__VA_ARGS__)
        |                                   ~~~     ^~~~~~~~~~~
  include/linux/dynamic_debug.h:250:59: note: expanded from macro '_dynamic_func_call'
    250 |         _dynamic_func_call_cls(_DPRINTK_CLASS_DFLT, fmt, func, ##__VA_ARGS__)
        |                                                                  ^~~~~~~~~~~
  include/linux/dynamic_debug.h:248:65: note: expanded from macro '_dynamic_func_call_cls'
    248 |         __dynamic_func_call_cls(__UNIQUE_ID(ddebug), cls, fmt, func, ##__VA_ARGS__)
        |                                                                        ^~~~~~~~~~~
  include/linux/dynamic_debug.h:224:15: note: expanded from macro '__dynamic_func_call_cls'
    224 |                 func(&id, ##__VA_ARGS__);                       \
        |                             ^~~~~~~~~~~
  1 error generated.

On 64-bit architectures, size_t is 'unsigned long', so there is no
warning when using %zu but on 32-bit architectures, size_t is
'unsigned int'. Use the correct specifier to resolve the warning.

Fixes: 7a82e75ddaef ("bcachefs: New data structure for buckets waiting on journal commit")
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
---
 fs/bcachefs/buckets_waiting_for_journal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/bcachefs/buckets_waiting_for_journal.c b/fs/bcachefs/buckets_waiting_for_journal.c
index 81ab685cdef9..ec1b636ef78d 100644
--- a/fs/bcachefs/buckets_waiting_for_journal.c
+++ b/fs/bcachefs/buckets_waiting_for_journal.c
@@ -133,7 +133,7 @@ int bch2_set_bucket_needs_journal_commit(struct buckets_waiting_for_journal *b,
 	b->t = n;
 	kvfree(t);
 
-	pr_debug("took %zu rehashes, table at %zu/%zu elements",
+	pr_debug("took %zu rehashes, table at %zu/%lu elements",
 		 nr_rehashes, nr_elements, 1UL << b->t->bits);
 out:
 	mutex_unlock(&b->lock);

-- 
2.42.0

