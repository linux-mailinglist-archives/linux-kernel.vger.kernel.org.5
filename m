Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28F87F7113
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 11:16:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345465AbjKXKQN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 05:16:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345564AbjKXKQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 05:16:00 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0933810F2;
        Fri, 24 Nov 2023 02:16:07 -0800 (PST)
Date:   Fri, 24 Nov 2023 10:16:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1700820965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7aU0X/sqpgYUwPx+c8pZR8R1BH27ZWy+KyLcXN294M=;
        b=ODfqP21FCJ75BJfo2CCuiEk2W4AsW1oux3GfYfEF7atGab1B99ONoW/YyTU4ZH+STegTzs
        k1TIpPO0ykX884zdwHFbHwBvyuJ2ZIqOBNlX8VzPuZGZkPgZC3Ssrt6pFG3LF5xt1PYH/x
        Ozg38cWP6Lle2Ncsv6oWFBf/MSiaz+tmbY+Rk/9Er/tSOUIWvun+s79DT81yqUxikkh780
        RCndUSqcdXHcaiDvnVRQ6B+6JPaPjZ22rk6+RjJ2rd8BHScBoDpBZq/YzHfM/TAoTVEKZu
        XdbwikS9wUHdmP/jgMD+2AiRQl0eT9jB/eru/abYm7W6g/CuyytuUGy/mPqtXA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1700820965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=u7aU0X/sqpgYUwPx+c8pZR8R1BH27ZWy+KyLcXN294M=;
        b=we9vcT+0pRShDzUC5kMESoq761AX60N3OQojJGXMqzMkM3HG0Po5IUa1nDiyYsdfnAmLWl
        U0OOd6MXfv4t4ACQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] lockdep: Fix block chain corruption
Cc:     Kent Overstreet <kent.overstreet@linux.dev>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231121114126.GH8262@noisy.programming.kicks-ass.net>
References: <20231121114126.GH8262@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <170082096447.398.12922994682541625976.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     bca4104b00fec60be330cd32818dd5c70db3d469
Gitweb:        https://git.kernel.org/tip/bca4104b00fec60be330cd32818dd5c70db3d469
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Nov 2023 12:41:26 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 24 Nov 2023 11:04:54 +01:00

lockdep: Fix block chain corruption

Kent reported an occasional KASAN splat in lockdep. Mark then noted:

> I suspect the dodgy access is to chain_block_buckets[-1], which hits the last 4
> bytes of the redzone and gets (incorrectly/misleadingly) attributed to
> nr_large_chain_blocks.

That would mean @size == 0, at which point size_to_bucket() returns -1
and the above happens.

alloc_chain_hlocks() has 'size - req', for the first with the
precondition 'size >= rq', which allows the 0.

This code is trying to split a block, del_chain_block() takes what we
need, and add_chain_block() puts back the remainder, except in the
above case the remainder is 0 sized and things go sideways.

Fixes: 810507fe6fd5 ("locking/lockdep: Reuse freed chain_hlocks entries")
Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kent Overstreet <kent.overstreet@linux.dev>
Link: https://lkml.kernel.org/r/20231121114126.GH8262@noisy.programming.kicks-ass.net
---
 kernel/locking/lockdep.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index e85b5ad..151bd3d 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -3497,7 +3497,8 @@ static int alloc_chain_hlocks(int req)
 		size = chain_block_size(curr);
 		if (likely(size >= req)) {
 			del_chain_block(0, size, chain_block_next(curr));
-			add_chain_block(curr + req, size - req);
+			if (size > req)
+				add_chain_block(curr + req, size - req);
 			return curr;
 		}
 	}
