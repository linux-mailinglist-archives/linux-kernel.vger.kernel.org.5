Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E127907AC
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:51:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352114AbjIBLvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352079AbjIBLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:51:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED26710F6
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:51:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 25F8BCE25C7
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5F195C4339A;
        Sat,  2 Sep 2023 11:51:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qcP9r-000Jxm-0l;
        Sat, 02 Sep 2023 07:51:19 -0400
Message-ID: <20230902115119.048419430@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 02 Sep 2023 07:50:40 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Levi Yun <ppbuk5246@gmail.com>
Subject: [for-linus][PATCH 05/11] ftrace: Use within_module to check rec->ip within specified module.
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

From: Levi Yun <ppbuk5246@gmail.com>

within_module_core && within_module_init condition is same to
within module but it's more readable.

Use within_module instead of former condition to check rec->ip
within specified module area or not.

Link: https://lore.kernel.org/linux-trace-kernel/20230803205236.32201-1-ppbuk5246@gmail.com

Signed-off-by: Levi Yun <ppbuk5246@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 05c0024815bf..c46dd6d97afe 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -6779,8 +6779,7 @@ void ftrace_release_mod(struct module *mod)
 	last_pg = &ftrace_pages_start;
 	for (pg = ftrace_pages_start; pg; pg = *last_pg) {
 		rec = &pg->records[0];
-		if (within_module_core(rec->ip, mod) ||
-		    within_module_init(rec->ip, mod)) {
+		if (within_module(rec->ip, mod)) {
 			/*
 			 * As core pages are first, the first
 			 * page should never be a module page.
@@ -6852,8 +6851,7 @@ void ftrace_module_enable(struct module *mod)
 		 * not part of this module, then skip this pg,
 		 * which the "break" will do.
 		 */
-		if (!within_module_core(rec->ip, mod) &&
-		    !within_module_init(rec->ip, mod))
+		if (!within_module(rec->ip, mod))
 			break;
 
 		/* Weak functions should still be ignored */
-- 
2.40.1
