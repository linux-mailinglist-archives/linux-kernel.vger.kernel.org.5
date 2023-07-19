Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1520759FD3
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 22:32:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbjGSUb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 16:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230500AbjGSUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 16:31:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26F531FFE;
        Wed, 19 Jul 2023 13:31:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 414716182C;
        Wed, 19 Jul 2023 20:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29EE3C433C9;
        Wed, 19 Jul 2023 20:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689798614;
        bh=Na90jgwrhK74RAguQcWtc6XkFOL8jLuOvNfJ2Q5L1OY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=pOpuhOAIG0e+iG62LTVp/tOhm8LzD0rRM3ibmk6yVo2hwFY4DhRRdPheSDbNtDfLM
         Bujg66J+7JICkSoBp8HPkMxK8Oz9qAIFFYgSA48TfTO622vnYlLwyj94nmtCQjaERL
         Ki6o1XPdvRhWJuJQU8gNFU0gqxGmVDi3SzDaz3L/MQaIMtVkdSZEDayVa9x6f6OI5P
         F42+Gsb7vi1AnoIObXd2JQ3OR/PYcLPk+k8Tza/Q2VAXpxFNEYZWUwKP32kqJJrqe/
         BygHJnfOXWU0sQOHnWoByHfFO0TcbocwzUBIZVgP0CDKQ+1Eu7ro2EbL12/yP7SYXU
         QLyVqMMsrD/tw==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>
Subject: [PATCH 5/6] perf trace: Free thread_trace->files table
Date:   Wed, 19 Jul 2023 17:29:50 -0300
Message-ID: <20230719202951.534582-6-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230719202951.534582-1-acme@kernel.org>
References: <20230719202951.534582-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

The fd->pathname table that is kept in 'struct thread_trace' and thus in
thread->priv must be freed when a thread is deleted.

This was also detected using -fsanitize=address.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 56651d666480cc16..7ece2521efb69182 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1296,6 +1296,8 @@ static struct thread_trace *thread_trace__new(void)
 	return ttrace;
 }
 
+static void thread_trace__free_files(struct thread_trace *ttrace);
+
 static void thread_trace__delete(void *pttrace)
 {
 	struct thread_trace *ttrace = pttrace;
@@ -1305,6 +1307,7 @@ static void thread_trace__delete(void *pttrace)
 
 	intlist__delete(ttrace->syscall_stats);
 	ttrace->syscall_stats = NULL;
+	thread_trace__free_files(ttrace);
 	zfree(&ttrace->entry_str);
 	free(ttrace);
 }
@@ -1346,6 +1349,17 @@ void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
 
 static const size_t trace__entry_str_size = 2048;
 
+static void thread_trace__free_files(struct thread_trace *ttrace)
+{
+	for (int i = 0; i < ttrace->files.max; ++i) {
+		struct file *file = ttrace->files.table + i;
+		zfree(&file->pathname);
+	}
+
+	zfree(&ttrace->files.table);
+	ttrace->files.max  = -1;
+}
+
 static struct file *thread_trace__files_entry(struct thread_trace *ttrace, int fd)
 {
 	if (fd < 0)
-- 
2.41.0

