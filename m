Return-Path: <linux-kernel+bounces-47172-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEEB844A18
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 22:31:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05179284D6D
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 21:31:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97B1A39AED;
	Wed, 31 Jan 2024 21:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lL5GxUM8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8763A8CC;
	Wed, 31 Jan 2024 21:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706736604; cv=none; b=aQq/WWrNC+GGsvKChUIbV1w/F52URBQwKCJdEOJ3g7ESCzAFdV5u0RL4onqvNlFcrVLbF3/mDtQ+laSCSc3JyR2QdwW4lAvI0pxq9HPyefU6fzMBZ4gyEBasv6QeTII7ODZ9Bq5rKKZan1rTXaBeIQDaaAkYuvv3ZAVABzxPGjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706736604; c=relaxed/simple;
	bh=FN2JscihD3Za9BUNC92yN8oh07Kc0nONt2xuzIQoyLI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=jtDcaivAavqXkNbQfZ0aHHtnxziewvfycudYCK6+OvCb4sqIAhsR8IeSJMydIsQITwwjeMj4TLgfUBKJ04GlsTZumKAdOnWH7rc7G6DjmKLh1FN87LR8vlqyXQo3mKs0kP5CF8ZZSoyKGo99M9mAyML5EplJ7x4j6RoOLlgMyF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lL5GxUM8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19B5C433C7;
	Wed, 31 Jan 2024 21:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706736604;
	bh=FN2JscihD3Za9BUNC92yN8oh07Kc0nONt2xuzIQoyLI=;
	h=Date:From:To:Cc:Subject:From;
	b=lL5GxUM8vGEs2NHzXiYgPRr9XrRp/the9rww+dnHE/77OQd+8xkegs0xA7gmDeUWu
	 g1N73zju3baMpxXZOgRm9QOmTW0oeeUIjdNTIPg0LtXHjzsPRZOLRo6pC+GcbxrIR3
	 IwxXJt6MzVKDdjHTI65OjsUKYBYvJSYAit6PjiUyJfG540ZOvmO+av/igkYYG/Zt+s
	 dljcf1c36NWe0+etAIsfrnMEQGphm1jsYEFe8lAmcs40237P9/CU7P/L9ggVv05nlG
	 p7ZWylXbxVsHW2OdLuid3+X0NbUtee9OMp7D/jSrMvxZTJW8qvnA/5boALJlVortwK
	 RUQLpnjc1D8Xg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
	id 8EC5840441; Wed, 31 Jan 2024 18:30:01 -0300 (-03)
Date: Wed, 31 Jan 2024 18:30:01 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org
Subject: [PATCH 1/1] perf trace: Collect sys_nanosleep first argument
Message-ID: <Zbq72dJRpOlfRWnf@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

That is a 'struct timespec' passed from userspace to the kernel as we
can see with a system wide syscall tracing:

  root@number:~# perf trace -e nanosleep
       0.000 (10.102 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
      38.924 (10.077 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     100.177 (10.107 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     139.171 (10.063 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     200.603 (10.105 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     239.399 (10.064 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     300.994 (10.096 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     339.584 (10.067 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     401.335 (10.057 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     439.758 (10.166 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     501.814 (10.110 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     539.983 (10.227 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     602.284 (10.199 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     640.208 (10.105 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     702.662 (10.163 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     740.440 (10.107 ms): podman/2195174 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
     802.993 (10.159 ms): podman/9150 nanosleep(rqtp: { .tv_sec: 0, .tv_nsec: 10000000 })                   = 0
  ^Croot@number:~# strace -p 9150 -e nanosleep

If we then use the ptrace method to look at that podman process:

  root@number:~# strace -p 9150 -e nanosleep
  strace: Process 9150 attached
  nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
  nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
  nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
  nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
  nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
  nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
  nanosleep({tv_sec=0, tv_nsec=10000000}, NULL) = 0
  ^Cstrace: Process 9150 detached
  root@number:~#

With some changes we can get something closer to the strace output,
still in system wide mode:

  root@number:~# perf config trace.show_arg_names=false
  root@number:~# perf config trace.show_duration=false
  root@number:~# perf config trace.show_timestamp=false
  root@number:~# perf config trace.show_zeros=true
  root@number:~# perf config trace.args_alignment=0
  root@number:~# perf trace -e nanosleep --max-events=10
  podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  podman/2195174 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  podman/9150 nanosleep({ .tv_sec: 0, .tv_nsec: 10000000 }, NULL) = 0
  root@number:~#
  root@number:~# perf config
  trace.show_arg_names=false
  trace.show_duration=false
  trace.show_timestamp=false
  trace.show_zeros=true
  trace.args_alignment=0
  root@number:~# cat ~/.perfconfig
  # this file is auto-generated.
  [trace]
  	show_arg_names = false
  	show_duration = false
  	show_timestamp = false
  	show_zeros = true
  	args_alignment = 0
  root@number:~#

This will not get reused by any other syscall as nanosleep is the only
one to have as its first argument a 'struct timespec" pointer argument
passed from userspace to the kernel:

  root@number:~# grep timespec /sys/kernel/tracing/events/syscalls/sys_enter_*/format | grep offset:16
  /sys/kernel/tracing/events/syscalls/sys_enter_nanosleep/format:	field:struct __kernel_timespec * rqtp;	offset:16;	size:8;	signed:0;
  root@number:~#

BTF based pretty printing will simplify all this, but then lets just get
the low hanging fruits first.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lore.kernel.org/lkml/
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c                    |  2 ++
 .../bpf_skel/augmented_raw_syscalls.bpf.c     | 21 +++++++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 109b8e64fe69ae32..6abe280dc38f1921 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -1048,6 +1048,8 @@ static const struct syscall_fmt syscall_fmts[] = {
 	  .arg = { [3] = { .scnprintf = SCA_MREMAP_FLAGS, /* flags */ }, }, },
 	{ .name	    = "name_to_handle_at",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
+	{ .name	    = "nanosleep",
+	  .arg = { [0] = { .scnprintf = SCA_TIMESPEC,  /* req */ }, }, },
 	{ .name	    = "newfstatat",
 	  .arg = { [0] = { .scnprintf = SCA_FDAT, /* dfd */ }, }, },
 	{ .name	    = "open",
diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
index 52c270330ae0d2f3..baecffbece14fb68 100644
--- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
+++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
@@ -354,6 +354,27 @@ int sys_enter_clock_nanosleep(struct syscall_enter_args *args)
 	return 1; /* Failure: don't filter */
 }
 
+SEC("tp/syscalls/sys_enter_nanosleep")
+int sys_enter_nanosleep(struct syscall_enter_args *args)
+{
+	struct augmented_args_payload *augmented_args = augmented_args_payload();
+	const void *req_arg = (const void *)args->args[0];
+	unsigned int len = sizeof(augmented_args->args);
+	__u32 size = sizeof(struct timespec64);
+
+        if (augmented_args == NULL)
+		goto failure;
+
+	if (size > sizeof(augmented_args->__data))
+                goto failure;
+
+	bpf_probe_read_user(&augmented_args->__data, size, req_arg);
+
+	return augmented__output(args, augmented_args, len + size);
+failure:
+	return 1; /* Failure: don't filter */
+}
+
 static pid_t getpid(void)
 {
 	return bpf_get_current_pid_tgid();
-- 
2.43.0


