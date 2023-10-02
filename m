Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2CF7B54BE
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:10:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237574AbjJBNx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 09:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237571AbjJBNxy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 09:53:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 798FDAD
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696254786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vpLoGghBwfAF/DR0ZHV2Bh2/WPx4zdRILR3KFZtAXWE=;
        b=Q2sVPwcXhGGCHl7ofFNf/p/AkY5nAA/RZoqA8pMj1aERHSjXVrats1fuxU9bERkkd3oVAH
        r3Hy95JGvkpEUO9DRp/AstnT7icwUjXE/sNbs/5OLn/ltpNlekThuBodvzm4GilJPaDE+c
        I31aLIPSmkClYqYa28fqjK+PHOmTigU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-p2jhS79bNEmnpPnmm7HB3g-1; Mon, 02 Oct 2023 09:52:48 -0400
X-MC-Unique: p2jhS79bNEmnpPnmm7HB3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1F52B3C176E8;
        Mon,  2 Oct 2023 13:52:47 +0000 (UTC)
Received: from alecto.usersys.redhat.com (unknown [10.43.17.26])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 494FB40C6EBF;
        Mon,  2 Oct 2023 13:52:45 +0000 (UTC)
From:   Artem Savkov <asavkov@redhat.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Andrii Nakryiko <andrii@kernel.org>, bpf@vger.kernel.org,
        netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        linux-rt-users@vger.kernel.org, Jiri Olsa <jolsa@kernel.org>,
        Artem Savkov <asavkov@redhat.com>
Subject: [RFC PATCH] tracing: change syscall number type in struct syscall_trace_*
Date:   Mon,  2 Oct 2023 15:52:42 +0200
Message-ID: <20231002135242.247536-1-asavkov@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
X-Spam-Status: No, score=1.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_NONE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

linux-rt-devel tree contains a patch that adds an extra member to struct
trace_entry. This causes the offset of args field in struct
trace_event_raw_sys_enter be different from the one in struct
syscall_trace_enter:

struct trace_event_raw_sys_enter {
        struct trace_entry         ent;                  /*     0    12 */

        /* XXX last struct has 3 bytes of padding */
        /* XXX 4 bytes hole, try to pack */

        long int                   id;                   /*    16     8 */
        long unsigned int          args[6];              /*    24    48 */
        /* --- cacheline 1 boundary (64 bytes) was 8 bytes ago --- */
        char                       __data[];             /*    72     0 */

        /* size: 72, cachelines: 2, members: 4 */
        /* sum members: 68, holes: 1, sum holes: 4 */
        /* paddings: 1, sum paddings: 3 */
        /* last cacheline: 8 bytes */
};

struct syscall_trace_enter {
        struct trace_entry         ent;                  /*     0    12 */

        /* XXX last struct has 3 bytes of padding */

        int                        nr;                   /*    12     4 */
        long unsigned int          args[];               /*    16     0 */

        /* size: 16, cachelines: 1, members: 3 */
        /* paddings: 1, sum paddings: 3 */
        /* last cacheline: 16 bytes */
};

This, in turn, causes perf_event_set_bpf_prog() fail while running bpf
test_profiler testcase because max_ctx_offset is calculated based on the
former struct, while off on the latter:

  10488         if (is_tracepoint || is_syscall_tp) {
  10489                 int off = trace_event_get_offsets(event->tp_event);
  10490
  10491                 if (prog->aux->max_ctx_offset > off)
  10492                         return -EACCES;
  10493         }

This patch changes the type of nr member in syscall_trace_* structs to
be long so that "args" offset is equal to that in struct
trace_event_raw_sys_enter.

Signed-off-by: Artem Savkov <asavkov@redhat.com>
---
 kernel/trace/trace.h          | 4 ++--
 kernel/trace/trace_syscalls.c | 7 ++++---
 2 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 77debe53f07cf..cd1d24df85364 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -135,13 +135,13 @@ enum trace_type {
  */
 struct syscall_trace_enter {
 	struct trace_entry	ent;
-	int			nr;
+	long			nr;
 	unsigned long		args[];
 };
 
 struct syscall_trace_exit {
 	struct trace_entry	ent;
-	int			nr;
+	long			nr;
 	long			ret;
 };
 
diff --git a/kernel/trace/trace_syscalls.c b/kernel/trace/trace_syscalls.c
index de753403cdafb..c26939119f2e4 100644
--- a/kernel/trace/trace_syscalls.c
+++ b/kernel/trace/trace_syscalls.c
@@ -101,7 +101,7 @@ find_syscall_meta(unsigned long syscall)
 	return NULL;
 }
 
-static struct syscall_metadata *syscall_nr_to_meta(int nr)
+static struct syscall_metadata *syscall_nr_to_meta(long nr)
 {
 	if (IS_ENABLED(CONFIG_HAVE_SPARSE_SYSCALL_NR))
 		return xa_load(&syscalls_metadata_sparse, (unsigned long)nr);
@@ -132,7 +132,8 @@ print_syscall_enter(struct trace_iterator *iter, int flags,
 	struct trace_entry *ent = iter->ent;
 	struct syscall_trace_enter *trace;
 	struct syscall_metadata *entry;
-	int i, syscall;
+	int i;
+	long syscall;
 
 	trace = (typeof(trace))ent;
 	syscall = trace->nr;
@@ -177,7 +178,7 @@ print_syscall_exit(struct trace_iterator *iter, int flags,
 	struct trace_seq *s = &iter->seq;
 	struct trace_entry *ent = iter->ent;
 	struct syscall_trace_exit *trace;
-	int syscall;
+	long syscall;
 	struct syscall_metadata *entry;
 
 	trace = (typeof(trace))ent;
-- 
2.41.0

