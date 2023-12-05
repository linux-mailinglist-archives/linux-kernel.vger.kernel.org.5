Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75422805BB9
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:49:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345189AbjLEQSA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 11:18:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjLEQRu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 11:17:50 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E8259E;
        Tue,  5 Dec 2023 08:17:56 -0800 (PST)
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id B11791FBA0;
        Tue,  5 Dec 2023 16:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1701793074; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F+X1FS4EJPHW99NAS/crIp5NK2rxn9bC7c581YFf5qc=;
        b=JTML6eEuiOLFbHESKHelXK2gVBkmcgWwzc7eOHh4LQ2sDNYnwdCBe+G83PvTpjtMbt4uKX
        pzPD4aDol8SfVY+a1tDv8igXizUzzxCN+LQRZK7uo+f11b9rifUuJ55lURztvIFiGZ0Cct
        /8DIAQ1crkrb73A9dLGqncctsmJpFI8=
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 7649E13AFD;
        Tue,  5 Dec 2023 16:17:54 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
        by imap1.dmz-prg2.suse.org with ESMTPSA
        id sJ+FGzJNb2WtdwAAD6G6ig
        (envelope-from <petr.pavlu@suse.com>); Tue, 05 Dec 2023 16:17:54 +0000
From:   Petr Pavlu <petr.pavlu@suse.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org,
        mathieu.desnoyers@efficios.com
Cc:     zhengyejian1@huawei.com, linux-trace-kernel@vger.kernel.org,
        linux-kernel@vger.kernel.org, Petr Pavlu <petr.pavlu@suse.com>
Subject: [PATCH v2 3/3] tracing: Fix a possible race when disabling buffered events
Date:   Tue,  5 Dec 2023 17:17:36 +0100
Message-Id: <20231205161736.19663-4-petr.pavlu@suse.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20231205161736.19663-1-petr.pavlu@suse.com>
References: <20231205161736.19663-1-petr.pavlu@suse.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp-out2.suse.de;
        none
X-Spam-Score: 1.71
X-Spamd-Result: default: False [1.71 / 50.00];
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
         NEURAL_HAM_SHORT(-0.19)[-0.933];
         RCPT_COUNT_SEVEN(0.00)[7];
         MID_CONTAINS_FROM(1.00)[];
         DBL_BLOCKED_OPENRESOLVER(0.00)[suse.com:email];
         FUZZY_BLOCKED(0.00)[rspamd.com];
         FROM_EQ_ENVFROM(0.00)[];
         MIME_TRACE(0.00)[0:+];
         RCVD_TLS_ALL(0.00)[];
         BAYES_HAM(-3.00)[100.00%]
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Function trace_buffered_event_disable() is responsible for freeing pages
backing buffered events and this process can run concurrently with
trace_event_buffer_lock_reserve().

The following race is currently possible:
* Function trace_buffered_event_disable() is called on CPU 0. It
  increments trace_buffered_event_cnt on each CPU and waits via
  synchronize_rcu() for each user of trace_buffered_event to complete.
* After synchronize_rcu() is finished, function
  trace_buffered_event_disable() has the exclusive access to
  trace_buffered_event. All counters trace_buffered_event_cnt are at 1
  and all pointers trace_buffered_event are still valid.
* At this point, on a different CPU 1, the execution reaches
  trace_event_buffer_lock_reserve(). The function calls
  preempt_disable_notrace() and only now enters an RCU read-side
  critical section. The function proceeds and reads a still valid
  pointer from trace_buffered_event[CPU1] into the local variable
  "entry". However, it doesn't yet read trace_buffered_event_cnt[CPU1]
  which happens later.
* Function trace_buffered_event_disable() continues. It frees
  trace_buffered_event[CPU1] and decrements
  trace_buffered_event_cnt[CPU1] back to 0.
* Function trace_event_buffer_lock_reserve() continues. It reads and
  increments trace_buffered_event_cnt[CPU1] from 0 to 1. This makes it
  believe that it can use the "entry" that it already obtained but the
  pointer is now invalid and any access results in a use-after-free.

Fix the problem by making a second synchronize_rcu() call after all
trace_buffered_event values are set to NULL. This waits on all potential
users in trace_event_buffer_lock_reserve() that still read a previous
pointer from trace_buffered_event.

Fixes: 0fc1b09ff1ff ("tracing: Use temp buffer when filtering events")
Signed-off-by: Petr Pavlu <petr.pavlu@suse.com>
---
 kernel/trace/trace.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index dd45020fcdde..dc234b5dde47 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -2833,13 +2833,17 @@ void trace_buffered_event_disable(void)
 		free_page((unsigned long)per_cpu(trace_buffered_event, cpu));
 		per_cpu(trace_buffered_event, cpu) = NULL;
 	}
+
 	/*
-	 * Make sure trace_buffered_event is NULL before clearing
-	 * trace_buffered_event_cnt.
+	 * Wait for all CPUs that potentially started checking if they can use
+	 * their event buffer only after the previous synchronize_rcu() call and
+	 * they still read a valid pointer from trace_buffered_event. It must be
+	 * ensured they don't see cleared trace_buffered_event_cnt else they
+	 * could wrongly decide to use the pointed-to buffer which is now freed.
 	 */
-	smp_wmb();
+	synchronize_rcu();
 
-	/* Do the work on each cpu */
+	/* For each CPU, relinquish the buffer */
 	on_each_cpu_mask(tracing_buffer_mask, enable_trace_buffered_event, NULL,
 			 true);
 }
-- 
2.35.3

