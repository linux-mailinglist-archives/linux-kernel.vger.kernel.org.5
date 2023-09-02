Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D24027907A7
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:51:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352090AbjIBLvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjIBLvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAF58E7E
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:51:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B4DA0B826E7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A80AC433AD;
        Sat,  2 Sep 2023 11:51:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qcP9r-000JyL-1R;
        Sat, 02 Sep 2023 07:51:19 -0400
Message-ID: <20230902115119.259781292@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 02 Sep 2023 07:50:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ruan Jinjie <ruanjinjie@huawei.com>
Subject: [for-linus][PATCH 06/11] ftrace: Use LIST_HEAD to initialize clear_hash
References: <20230902115035.786076237@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ruan Jinjie <ruanjinjie@huawei.com>

Use LIST_HEAD() to initialize clear_hash instead of open-coding it.

Link: https://lore.kernel.org/linux-trace-kernel/20230809071551.913041-1-ruanjinjie@huawei.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Ruan Jinjie <ruanjinjie@huawei.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index c46dd6d97afe..8de8bec5f366 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7140,9 +7140,7 @@ void ftrace_free_mem(struct module *mod, void *start_ptr, void *end_ptr)
 	struct dyn_ftrace key;
 	struct ftrace_mod_map *mod_map = NULL;
 	struct ftrace_init_func *func, *func_next;
-	struct list_head clear_hash;
-
-	INIT_LIST_HEAD(&clear_hash);
+	LIST_HEAD(clear_hash);
 
 	key.ip = start;
 	key.flags = end;	/* overload flags, as it is unsigned long */
-- 
2.40.1
