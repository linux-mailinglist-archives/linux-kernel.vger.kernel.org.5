Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86D87907AE
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Sep 2023 13:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352096AbjIBLv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Sep 2023 07:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352080AbjIBLvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Sep 2023 07:51:14 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D476E6A
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 04:51:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 8ABF9CE25C8
        for <linux-kernel@vger.kernel.org>; Sat,  2 Sep 2023 11:51:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9893C433B9;
        Sat,  2 Sep 2023 11:51:07 +0000 (UTC)
Received: from rostedt by gandalf with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1qcP9r-000JzW-2m;
        Sat, 02 Sep 2023 07:51:19 -0400
Message-ID: <20230902115119.676231106@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 02 Sep 2023 07:50:43 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
Subject: [for-linus][PATCH 08/11] tracing/filters: Fix error-handling of cpulist parsing buffer
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

From: Valentin Schneider <vschneid@redhat.com>

parse_pred() allocates a string buffer to parse the user-provided cpulist,
but doesn't check the allocation result nor does it free the buffer once it
is no longer needed.

Add an allocation check, and free the buffer as soon as it is no longer
needed.

Link: https://lkml.kernel.org/r/20230901151039.125186-2-vschneid@redhat.com

Cc: Masami Hiramatsu <mhiramat@kernel.org>
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Reported-by: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Valentin Schneider <vschneid@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_filter.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 3a529214a21b..c06e1d596f4b 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -1744,17 +1744,23 @@ static int parse_pred(const char *str, void *data,
 
 		/* Copy the cpulist between { and } */
 		tmp = kmalloc((i - maskstart) + 1, GFP_KERNEL);
-		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
+		if (!tmp)
+			goto err_mem;
 
+		strscpy(tmp, str + maskstart, (i - maskstart) + 1);
 		pred->mask = kzalloc(cpumask_size(), GFP_KERNEL);
-		if (!pred->mask)
+		if (!pred->mask) {
+			kfree(tmp);
 			goto err_mem;
+		}
 
 		/* Now parse it */
 		if (cpulist_parse(tmp, pred->mask)) {
+			kfree(tmp);
 			parse_error(pe, FILT_ERR_INVALID_CPULIST, pos + i);
 			goto err_free;
 		}
+		kfree(tmp);
 
 		/* Move along */
 		i++;
-- 
2.40.1
