Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F3580147B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:31:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379629AbjLAUa5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:30:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379603AbjLAUay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:30:54 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0594E10F4
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:31:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC08EC433CC;
        Fri,  1 Dec 2023 20:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701462660;
        bh=+mj0dcN7GlPP3mSnBDcO9llFhhVlvh7EarboXmVwsd4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ly7tgk2aHQCuPkEy3d0psO0fSlUxGiuY/19+2l3JKYAzw2+dgsX70kVlPH6a30e/1
         vy04Wvgg19peOLQMUhsmQYSVibsgt7pntzMX+FnYiRJRBzpIITky3qe44wzcyvQTJN
         CZwTwfluwXcs/fi1E/YTcXO2EfxTrQfGrOFwwsIBFXt8HAr+2a1rpRZR8Y7SSUwtcv
         IwyzFJFKlxQ3s2mtbDD1oOP6YcLW+dyscEqSIDOVpw/I7cLBQXm5r6VYtWOp+/uy6H
         9XmU2EtZZBpphq9sIVY4TxkWrUmLYirCv8UTSj4gJfkpLmjFFvifqBNqseggX/ZI9X
         tELCENgp9/mrQ==
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Clark Williams <williams@redhat.com>,
        Kate Carcia <kcarcia@redhat.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        David Laight <David.Laight@ACULAB.COM>
Subject: [PATCH 2/2] perf env: Cache the arch specific strerrno function in perf_env__arch_strerrno()
Date:   Fri,  1 Dec 2023 17:30:46 -0300
Message-ID: <20231201203046.486596-3-acme@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231201203046.486596-1-acme@kernel.org>
References: <20231201203046.486596-1-acme@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnaldo Carvalho de Melo <acme@redhat.com>

So that we don't have to go thru the series of strcmp(arch) calls for
each id -> string translation.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: David Laight <David.Laight@ACULAB.COM>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/trace/beauty/arch_errno_names.sh | 6 +++---
 tools/perf/trace/beauty/beauty.h            | 2 --
 tools/perf/util/env.c                       | 6 ++++--
 tools/perf/util/env.h                       | 5 +++++
 4 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/tools/perf/trace/beauty/arch_errno_names.sh b/tools/perf/trace/beauty/arch_errno_names.sh
index b6e0767b4b34e46a..7df4bf5b55a3cc2a 100755
--- a/tools/perf/trace/beauty/arch_errno_names.sh
+++ b/tools/perf/trace/beauty/arch_errno_names.sh
@@ -57,13 +57,13 @@ create_arch_errno_table_func()
 	archlist="$1"
 	default="$2"
 
-	printf 'const char *arch_syscalls__strerrno(const char *arch, int err)\n'
+	printf 'arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch)\n'
 	printf '{\n'
 	for arch in $archlist; do
 		printf '\tif (!strcmp(arch, "%s"))\n' $(arch_string "$arch")
-		printf '\t\treturn errno_to_name__%s(err);\n' $(arch_string "$arch")
+		printf '\t\treturn errno_to_name__%s;\n' $(arch_string "$arch")
 	done
-	printf '\treturn errno_to_name__%s(err);\n' $(arch_string "$default")
+	printf '\treturn errno_to_name__%s;\n' $(arch_string "$default")
 	printf '}\n'
 }
 
diff --git a/tools/perf/trace/beauty/beauty.h b/tools/perf/trace/beauty/beauty.h
index 788e8f6bd90eb753..9feb794f5c6e15f4 100644
--- a/tools/perf/trace/beauty/beauty.h
+++ b/tools/perf/trace/beauty/beauty.h
@@ -251,6 +251,4 @@ size_t open__scnprintf_flags(unsigned long flags, char *bf, size_t size, bool sh
 void syscall_arg__set_ret_scnprintf(struct syscall_arg *arg,
 				    size_t (*ret_scnprintf)(char *bf, size_t size, struct syscall_arg *arg));
 
-const char *arch_syscalls__strerrno(const char *arch, int err);
-
 #endif /* _PERF_TRACE_BEAUTY_H */
diff --git a/tools/perf/util/env.c b/tools/perf/util/env.c
index fdd62ea00173ccf5..2845b9f4694591be 100644
--- a/tools/perf/util/env.c
+++ b/tools/perf/util/env.c
@@ -456,8 +456,10 @@ const char *perf_env__arch(struct perf_env *env)
 
 const char *perf_env__arch_strerrno(struct perf_env *env, int err)
 {
-	const char *arch_name = perf_env__arch(env);
-	return arch_syscalls__strerrno(arch_name, err);
+	if (env->arch_strerrno == NULL)
+		env->arch_strerrno = arch_syscalls__strerrno_function(perf_env__arch(env));
+
+	return env->arch_strerrno ? env->arch_strerrno(err) : "no arch specific strerrno function";
 }
 
 const char *perf_env__cpuid(struct perf_env *env)
diff --git a/tools/perf/util/env.h b/tools/perf/util/env.h
index 79f371879f45bafc..bf7e3c4c211f971e 100644
--- a/tools/perf/util/env.h
+++ b/tools/perf/util/env.h
@@ -53,6 +53,10 @@ struct pmu_caps {
 	char            *pmu_name;
 };
 
+typedef const char *(arch_syscalls__strerrno_t)(int err);
+
+arch_syscalls__strerrno_t *arch_syscalls__strerrno_function(const char *arch);
+
 struct perf_env {
 	char			*hostname;
 	char			*os_release;
@@ -135,6 +139,7 @@ struct perf_env {
 		 */
 		bool	enabled;
 	} clock;
+	arch_syscalls__strerrno_t *arch_strerrno;
 };
 
 enum perf_compress_type {
-- 
2.41.0

