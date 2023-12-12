Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58F5980F6B4
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 20:31:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjLLTax (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 14:30:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232488AbjLLTau (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 14:30:50 -0500
Received: from smtpout.efficios.com (unknown [IPv6:2607:5300:203:b2ee::31e5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365509B;
        Tue, 12 Dec 2023 11:30:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=efficios.com;
        s=smtpout1; t=1702409453;
        bh=JC9adTWZwBSZVelSEFs2mzk1j8rxdsp3rdKp4J6yU38=;
        h=From:To:Cc:Subject:Date:From;
        b=ZWoJVipTq1MIF0HapIaNLUU7o2LalgeTONDkP3Ud7TG+/QLgmYQTHuWwA/2ih/ixi
         35ap4wQyoXdBSuyHfPstlXeD83mhuZatwL0bhGi1Sq7bEbbKSC3GGFGFjtqrJ+LF1z
         +tQ98gDpW7DZmiSGr5BX9G175h7r/6H6/SYUCi3Xdp2QYoAd32dV7g33Pyu2M0FEWs
         aCMOOPjpI0od3vTKk01tVvLdCqMDXKAs2hIwBtV64zBNN4OYIQnobYvrT1hISDlcvN
         0Z3whjVSOjf0fXFenZHxFPoQvR/Za4jy7vECXByW/KDhvp9QdVbG0exzUwaRt3J6A1
         faWFbhokkwZiQ==
Received: from thinkos.internal.efficios.com (192-222-143-198.qc.cable.ebox.net [192.222.143.198])
        by smtpout.efficios.com (Postfix) with ESMTPSA id 4SqTHJ6x6LzGKJ;
        Tue, 12 Dec 2023 14:30:52 -0500 (EST)
From:   Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-trace-kernel@vger.kernel.org
Subject: [PATCH] ring-buffer: Fix 32-bit rb_time_read() race with rb_time_cmpxchg()
Date:   Tue, 12 Dec 2023 14:30:49 -0500
Message-Id: <20231212193049.680122-1-mathieu.desnoyers@efficios.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following race can cause rb_time_read() to observe a corrupted time
stamp:

rb_time_cmpxchg()
[...]
        if (!rb_time_read_cmpxchg(&t->msb, msb, msb2))
                return false;
        if (!rb_time_read_cmpxchg(&t->top, top, top2))
                return false;
<interrupted before updating bottom>
__rb_time_read()
[...]
        do {
                c = local_read(&t->cnt);
                top = local_read(&t->top);
                bottom = local_read(&t->bottom);
                msb = local_read(&t->msb);
        } while (c != local_read(&t->cnt));

        *cnt = rb_time_cnt(top);

        /* If top and msb counts don't match, this interrupted a write */
        if (*cnt != rb_time_cnt(msb))
                return false;
          ^ this check fails to catch that "bottom" is still not updated.

So the old "bottom" value is returned, which is wrong.

Fix this by checking that all three of msb, top, and bottom 2-bit cnt
values match.

The reason to favor checking all three fields over requiring a specific
update order for both rb_time_set() and rb_time_cmpxchg() is because
checking all three fields is more robust to handle partial failures of
rb_time_cmpxchg() when interrupted by nested rb_time_set().

Link: https://lore.kernel.org/lkml/20231211201324.652870-1-mathieu.desnoyers@efficios.com/
Fixes: f458a1453424e ("ring-buffer: Test last update in 32bit version of __rb_time_read()")
Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: linux-trace-kernel@vger.kernel.org
---
 kernel/trace/ring_buffer.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 8d2a4f00eca9..71c225ca2a2b 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -644,8 +644,8 @@ static inline bool __rb_time_read(rb_time_t *t, u64 *ret, unsigned long *cnt)
 
 	*cnt = rb_time_cnt(top);
 
-	/* If top and msb counts don't match, this interrupted a write */
-	if (*cnt != rb_time_cnt(msb))
+	/* If top, msb or bottom counts don't match, this interrupted a write */
+	if (*cnt != rb_time_cnt(msb) || *cnt != rb_time_cnt(bottom))
 		return false;
 
 	/* The shift to msb will lose its cnt bits */
-- 
2.39.2

