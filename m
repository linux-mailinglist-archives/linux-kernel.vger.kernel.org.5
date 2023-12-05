Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07394805BE6
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344974AbjLEQRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231888AbjLEQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:17:50 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 259C71AA;
        Tue,  5 Dec 2023 08:17:56 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6D79A21B25;
        Tue,  5 Dec 2023 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701793074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bzMPx/vx+LfGT3C3JBxD8o5P2SQj+m7J4b2hCBf5H8s=;
        b=Y6ermWcx0tMCXO7ALmDhAb+viewxNhgoxWCrn7x5ogf5AU+Nc/q3jBhrKOSdgftr2hKSYe
        ycRQjquO8yFIrQgwASRUr6pQ3+3u1XbCQ9SiSqCWPvwBnilXH+gdBxC8avuDjo7xPVsrqG
        KdQLmcqoeu+q+2LjiMhrba3YNInsBIQ=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 37D51136CF;
        Tue,  5 Dec 2023 16:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id 2E03DDJNb2WtdwAAD6G6ig
        (envelope-from <petr.pavlu@suse.com>); Tue, 05 Dec 2023 16:17:54 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 2/3] tracing: Fix a warning when allocating buffered events fails
Date:   Tue,  5 Dec 2023 17:17:35 +0100
Message-Id: <20231205161736.19663-3-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231205161736.19663-1-petr.pavlu@suse.com>
References: <20231205161736.19663-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [4.70 / 50.00];
         ARC_NA(0.00)[];
         RCVD_VIA_SMTP_AUTH(0.00)[];
         FROM_HAS_DN(0.00)[];
         TO_DN_SOME(0.00)[];
         R_MISSING_CHARSET(2.50)[];
         TO_MATCH_ENVRCPT_ALL(0.00)[];
         MIME_GOOD(-0.10)[text/plain];
         BROKEN_CONTENT_TYPE(1.50)[];
         RCVD_COUNT_THREE(0.00)[3];
         DKIM_SIGNED(0.00)[suse.com:s=susede1];
         NEURAL_HAM_SHORT(-0.20)[-0.997];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[]
Authentication-Results: smtp-out1.suse.de;
        none
X-Spam-Score: 4.70
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function trace_buffered_event_disable() produces an unexpected warning
when the previous call to trace_buffered_event_enable() fails to
allocate pages for buffered events.

The situation can occur as follows:
* The counter trace_buffered_event_ref is at 0.
* The soft mode gets enabled for some event and
  trace_buffered_event_enable() is called. The function increments
  trace_buffered_event_ref to 1 and starts allocating event pages.
* The allocation fails for some page and trace_buffered_event_disable()
  is called for cleanup.
* Function trace_buffered_event_disable() decrements
  trace_buffered_event_ref back to 0, recognizes that it was the last
  use of buffered events and frees all allocated pages.
* The control goes back to trace_buffered_event_enable() which returns.
  The caller of trace_buffered_event_enable() has no information that
  the function actually failed.
* Some time later, the soft mode is disabled for the same event.
  Function trace_buffered_event_disable() is called. It warns on
  "WARN_ON_ONCE(!trace_buffered_event_ref)" and returns.

Buffered events are just an optimization and can handle failures. Make
trace_buffered_event_enable() exit on the first failure and left any
cleanup later to when trace_buffered_event_disable() is called.

Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 6f22a2a31589..dd45020fcdde 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2770,8 +2770,11 @@ void trace_buffered_event_enable(void)
 	for_each_tracing_cpu(cpu) {
 		page = alloc_pages_node(cpu_to_node(cpu),
 					GFP_KERNEL | __GFP_NORETRY, 0);
-		if (!page)
-			goto failed;
+		/* This is just an optimization and can handle failures */
+		if (!page) {
+			pr_err("Failed to allocate event buffer\n");
+			break;
+		}
 
 		event = page_address(page);
 		memset(event, 0, sizeof(*event));
@@ -2785,10 +2788,6 @@ void trace_buffered_event_enable(void)
 			WARN_ON_ONCE(1);
 		preempt_enable();
 	}
-
-	return;
- failed:
-	trace_buffered_event_disable();
 }
 
 static void enable_trace_buffered_event(void *data)
-- 
2.35.3

