Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B262753F3B
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 17:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjGNPo5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 11:44:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236149AbjGNPot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 11:44:49 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E04F03A96;
        Fri, 14 Jul 2023 08:44:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-31434226a2eso2268641f8f.1;
        Fri, 14 Jul 2023 08:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689349476; x=1691941476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=GV+2SK5aU57u26u9J0nmyvxHzsx2/I/GmUB1udAeuJ4=;
        b=ndHi7Az/3l8XVm40BRy3hUhxAIvAY+91NNqTkd5oR4Wxj6F2G1OxN1x7UHArLf9sDO
         TXcVv5Z/i6aHN7+9Qnd8Wt+U/C2SEFac1KYOfp8QCeMSm5ACcIvmoD39uHny1Mkxqk/j
         1DKC8qv1PRWZRCS/jPR6Kw5oqjVzAuRACJT+optnqobzAg60CUh21PfHHwUhr/6GDNvN
         eMGlhggDjjZR9MM0GNnLtvVMzWNxeIEyweN4hRCDpQn0I1aGNyv7FXee3QzKagRQgwvL
         sKn7tU8V8Z1/bli6MDxJUZ2SHZRmP5r/RQPawBY8iJuVbBJIE8XReN0qY3RhycG3jWWn
         FcUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689349476; x=1691941476;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GV+2SK5aU57u26u9J0nmyvxHzsx2/I/GmUB1udAeuJ4=;
        b=Rg94lrAy40GPzGndCfk/9ZFp92qujIDH33yaGa/avjasoZ3RHJ/LtJHw8ad3e4zKPT
         5RCsysVmP7Yh0fMzSwIjWzWjkzzPcbNgqjnQgYmHuK0fmtujjzgBPO+zhibamucon+y0
         eVV3icp4BOPFkzderTJpXVFlceTEUboRCu2ffK4MORjumPDHIA4jdrSj46I/++/CzJr1
         OeyabPVr7dzR1q6ztJT9ifw89YWxDKLnc5UGPmvlh+1r+e0p7S90fJWhyrbB+TbcOfpj
         JPgc2oGS1GxfCxVHS4EFn6mGp7BMKXDBfdNs57ivNFVyZrt7ZEDFRXacSXXIuUftxmHF
         HiVg==
X-Gm-Message-State: ABy/qLbTNrlWj9LRe7giItFbkgcDz8tjZ4Q404pQvB3j6eHD/pDO2xMB
        YlVSPLjKrRP7IOWdAQsS3E7GeNIcC937XQ==
X-Google-Smtp-Source: APBJJlHxa4w6VPwTv7kHdzDZDmLUwnORKdkoLJy+1/6Nvuct0addla03/xWMGPNtngKL77tGJ83AnQ==
X-Received: by 2002:a05:6000:108b:b0:313:f6fc:1f48 with SMTP id y11-20020a056000108b00b00313f6fc1f48mr5142129wrw.14.1689349475721;
        Fri, 14 Jul 2023 08:44:35 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id q4-20020adfcd84000000b0031134bcdacdsm11258632wrj.42.2023.07.14.08.44.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jul 2023 08:44:35 -0700 (PDT)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     linux-trace-kernel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [PATCH v2] ring_buffer: Use try_cmpxchg instead of cmpxchg
Date:   Fri, 14 Jul 2023 17:43:34 +0200
Message-ID: <20230714154418.8884-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
ring_buffer.c. x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg (and related move
instruction in front of cmpxchg).

No functional change intended.

Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/trace/ring_buffer.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/kernel/trace/ring_buffer.c b/kernel/trace/ring_buffer.c
index 834b361a4a66..84e3235ae8c7 100644
--- a/kernel/trace/ring_buffer.c
+++ b/kernel/trace/ring_buffer.c
@@ -688,10 +688,7 @@ static void rb_time_set(rb_time_t *t, u64 val)
 static inline bool
 rb_time_read_cmpxchg(local_t *l, unsigned long expect, unsigned long set)
 {
-	unsigned long ret;
-
-	ret = local_cmpxchg(l, expect, set);
-	return ret == expect;
+	return local_try_cmpxchg(l, &expect, set);
 }
 
 static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
@@ -748,9 +745,7 @@ static void rb_time_set(rb_time_t *t, u64 val)
 
 static bool rb_time_cmpxchg(rb_time_t *t, u64 expect, u64 set)
 {
-	u64 val;
-	val = local64_cmpxchg(&t->time, expect, set);
-	return val == expect;
+	return local64_try_cmpxchg(&t->time, &expect, set);
 }
 #endif
 
@@ -1489,14 +1484,11 @@ static bool rb_head_page_replace(struct buffer_page *old,
 {
 	unsigned long *ptr = (unsigned long *)&old->list.prev->next;
 	unsigned long val;
-	unsigned long ret;
 
 	val = *ptr & ~RB_FLAG_MASK;
 	val |= RB_PAGE_HEAD;
 
-	ret = cmpxchg(ptr, val, (unsigned long)&new->list);
-
-	return ret == val;
+	return try_cmpxchg(ptr, &val, (unsigned long)&new->list);
 }
 
 /*
@@ -3000,7 +2992,6 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 {
 	unsigned long new_index, old_index;
 	struct buffer_page *bpage;
-	unsigned long index;
 	unsigned long addr;
 	u64 write_stamp;
 	u64 delta;
@@ -3057,8 +3048,9 @@ rb_try_to_discard(struct ring_buffer_per_cpu *cpu_buffer,
 		 */
 		old_index += write_mask;
 		new_index += write_mask;
-		index = local_cmpxchg(&bpage->write, old_index, new_index);
-		if (index == old_index) {
+
+		/* caution: old_index gets updated on cmpxchg failure */
+		if (local_try_cmpxchg(&bpage->write, &old_index, new_index)) {
 			/* update counters */
 			local_sub(event_length, &cpu_buffer->entries_bytes);
 			return true;
-- 
2.41.0

