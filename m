Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D4C3782B86
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 16:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235841AbjHUOUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 10:20:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235838AbjHUOUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 10:20:21 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030D610E;
        Mon, 21 Aug 2023 07:19:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9197A638F6;
        Mon, 21 Aug 2023 14:19:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1562C433C8;
        Mon, 21 Aug 2023 14:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692627562;
        bh=Fz2zNJZs6zxmxHTIVbpX9gP7hmT2Y52sUDbV7FlfsV4=;
        h=From:To:Cc:Subject:Date:From;
        b=ZRLXV4dY/WgmET63GM8sVQSyA+fWVzU8EoucHcBf1rpUAFQ3rmwEbpBm0usxxkFwl
         qPXMw6+Oznh8V8/8iFl5nFv/ozFoPR1mwGrVAdLS6LVRkdf+7M1sD135aNVKHR3M3l
         2f56A/l+tO7a0lrBDJjkL8nTAM0vpa+C/i32qV1AxbvUpsAAncNYDUVBJQ+PF/Regu
         9yl7VklnFWP4j+cyTZO7YaACnRbcNsC9LSdHEfyTvTOl06E9eXITrdz/THPawNJoam
         OkOb9YciJU8gSqk+3JiX7oDAn5NJ9t+YoWxufPc9Vv4AgL3ZBglpCOrZHceU+3MmNc
         2rCu/VLMq0mPw==
From:   "Masami Hiramatsu (Google)" <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org
Subject: [PATCH] tracing: Fix to avoid wakeup loop in splice read of per-cpu buffer
Date:   Mon, 21 Aug 2023 23:19:18 +0900
Message-Id: <169262755804.106231.8245792908363050528.stgit@devnote2>
X-Mailer: git-send-email 2.34.1
User-Agent: StGit/0.19
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Masami Hiramatsu (Google) <mhiramat@kernel.org>

ftrace user can set 0 or small number to the 'buffer_percent' for quick
response for the ring buffer. In that case wait_on_pipe() will return
before filling a page of the ring buffer. That is too soon for splice()
because ring_buffer_read_page() will fail again.
This leads unnecessary loop in tracing_buffers_splice_read().

Set a minimum percentage of the buffer which is enough to fill a page to
wait_on_pipe() to avoid this situation.

Fixes: 03329f993978 ("tracing: Add tracefs file buffer_percentage")
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
---
 kernel/trace/trace.c |   12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8870078ef58..88448e8d8214 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -8462,6 +8462,8 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 	/* did we read anything? */
 	if (!spd.nr_pages) {
 		long wait_index;
+		size_t nr_pages;
+		size_t full;
 
 		if (ret)
 			goto out;
@@ -8472,7 +8474,15 @@ tracing_buffers_splice_read(struct file *file, loff_t *ppos,
 
 		wait_index = READ_ONCE(iter->wait_index);
 
-		ret = wait_on_pipe(iter, iter->tr->buffer_percent);
+		/* For splice, we have to ensure at least 1 page is filled */
+		nr_pages = ring_buffer_nr_pages(iter->array_buffer->buffer, iter->cpu_file);
+		if (nr_pages * iter->tr->buffer_percent < 100) {
+			full = nr_pages + 99;
+			do_div(full, nr_pages);
+		} else
+			full = iter->tr->buffer_percent;
+
+		ret = wait_on_pipe(iter, full);
 		if (ret)
 			goto out;
 

