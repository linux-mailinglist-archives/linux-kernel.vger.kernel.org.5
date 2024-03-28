Return-Path: <linux-kernel+bounces-117820-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67BC488AFF1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BD0E34770B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 251BB1946C;
	Mon, 25 Mar 2024 19:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoXr3+BZ"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0A2C1BC58
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711394917; cv=none; b=AKOu7aDQQQK3e+PhtpcCrZOKrYin4CCZ0j2TgWwPoot1g6KtKUrXV9g7paCWOXU/Zns24KP804uRHa62QBpenWgSP8E6XC9SI9G4KUZNXeXqRx5E8pX4faghuw9o/qhu6Kcxb+JiyfaO+ROzlvGrTnmek6ejJ20mGn5C1FBckNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711394917; c=relaxed/simple;
	bh=2JxaC6RwBryt90TB5PeLn8qJyJO3eJH5YIfzOv+mKA8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=XhckLgaRypoGe5St4Sth1GDCn5gzY2VNYOlfKnRUdqftcIL4d1DP3J7Lru0SJTi4u/Qll+PTXEEVcrO5ZYivDbLhNmtlXpd34KyBrq36wcdhHTkdib7TsrFRTFa80SgRTWYqBwJKSLQrqAHRIXk6F8NHsBLA1u+7Y5qv1rvMfTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoXr3+BZ; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2d52e65d4a8so63066471fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 12:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711394914; x=1711999714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=w7aTodhdriXbDi7LQdkq7kUMr0P0enB9WHhuMdueQ/E=;
        b=SoXr3+BZFixEnP4S9Aqyb7WxjJO4X/G/JlMSWotdl1Xd8gOEXqZJTVqR+4joX9M9le
         YkRFTSrnW2b/+78lCZHysT26HA9iF/C4wBNHCSRSEUz7/o5gYZ0dj6Y0mOA5WcOnHuRw
         o7XACEhljYU5X8E2MQk1JgHk1MUvQT5LUn3n+KAiQRAUjzs9XgWXT65KzCNwEQFBVF3u
         +F9F3lFZ1UvdP+U/Ngr0Iv4uMR8HeCSiW3zHhM6Klq+drLLK3abNMc5FSbwNowpNPfEg
         ugqAjxRnQ/TpUuJSHf/eG4TfGnKlZFJUNkE3EHi5/iIk35JRalW8khzS/SNEsOqCeUy2
         zFcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711394914; x=1711999714;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=w7aTodhdriXbDi7LQdkq7kUMr0P0enB9WHhuMdueQ/E=;
        b=FAlBcWc0X6z0oekGf4qPXbtEdVJZOhWSl4rde8DiPKrd6LFo2PTS4Ud3/x1tq54P2A
         CVWfGsc/zO+kT7uDiE6bm8r901lSEMk9jW190JIjQMX71/YFIGDrw6KM9VGsCXWp6Hzq
         GClkASDgXQW6F2Uh30maEM8mOTkjwLx5QZcqnXTaMmQeqP2Ukq/uUYi/d/bUivhlXvzF
         Ci5Us8UD0k5ySfAzbg+wCbCSWPQL43NWSWh9SG+QPe8IHcqYe84psMKOKmQzl9gGQV36
         zLfQ7A9R4peJZ8Cv08VCrc548l4exq0W5/LXdj55vy5V2Num0oO82eDOezjuJhmFcG6U
         IUdA==
X-Forwarded-Encrypted: i=1; AJvYcCV6n3GK4bg7MaINI+7PIwOERi//+D407QVRhjUWa70kgXVP8b6+30FGyG+q42uZh1sSc8ypfHDLLm9ZIAGG91+F2bn9QmLU7U7yiR3e
X-Gm-Message-State: AOJu0YwIMZPf8yxSHchIGsxnUsnKbAWw4dk0IFxhapeGQvU46sZrtv8k
	jaIxzQz2n2OCJO7FfWiUrfJtSdaJgeoPzdw2LXtN0CUsasxNzPwd
X-Google-Smtp-Source: AGHT+IHt5+6peMesSf12fd09riP7XfwXjG54Q2smtgr3Q3DQrZkKuivTZXZJK2VGaAFvfP2RzPiZRg==
X-Received: by 2002:a19:ae14:0:b0:513:97e2:43e6 with SMTP id f20-20020a19ae14000000b0051397e243e6mr4895610lfc.10.1711394913199;
        Mon, 25 Mar 2024 12:28:33 -0700 (PDT)
Received: from localhost.localdomain (109-252-14-191.nat.spd-mgts.ru. [109.252.14.191])
        by smtp.gmail.com with ESMTPSA id h26-20020a19ca5a000000b005159626af49sm1203164lfj.244.2024.03.25.12.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Mar 2024 12:28:32 -0700 (PDT)
From: Maxim Moskalets <maximmosk4@gmail.com>
X-Google-Original-From: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
To: bristot@redhat.com,
	bsegall@google.com,
	dietmar.eggemann@arm.com,
	juri.lelli@redhat.com,
	linux-kernel@vger.kernel.org,
	mgorman@suse.de,
	mingo@redhat.com,
	peterz@infradead.org,
	rostedt@goodmis.org,
	vincent.guittot@linaro.org,
	vschneid@redhat.com
Cc: maximmosk4@gmail.com,
	Maxim.Moskalets@kaspersky.com
Subject: [PATCH RESEND] kernel: replace seq_puts by seq_putc
Date: Mon, 25 Mar 2024 22:28:29 +0300
Message-Id: <20240325192829.6710-1-Maxim.Moskalets@kaspersky.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Using seq_putc for single characters is faster and more appropriate
than seq_puts, since only one character is passed and there is no need
to use a more powerful and less fast function.

Signed-off-by: Maxim Moskalets <Maxim.Moskalets@kaspersky.com>
---
 kernel/bpf/arraymap.c            |  6 +++---
 kernel/bpf/bpf_struct_ops.c      |  2 +-
 kernel/bpf/hashtab.c             |  4 ++--
 kernel/bpf/local_storage.c       |  4 ++--
 kernel/cgroup/cgroup.c           |  2 +-
 kernel/cgroup/debug.c            |  6 +++---
 kernel/latencytop.c              |  2 +-
 kernel/locking/lockdep_proc.c    | 24 ++++++++++++------------
 kernel/module/procfs.c           |  4 ++--
 kernel/module/tracking.c         |  2 +-
 kernel/sched/cpuacct.c           |  4 ++--
 kernel/sched/debug.c             | 14 +++++++-------
 kernel/time/test_udelay.c        |  2 +-
 kernel/trace/trace_events_hist.c | 26 +++++++++++++-------------
 kernel/trace/trace_events_user.c |  8 ++++----
 kernel/trace/trace_hwlat.c       |  4 ++--
 16 files changed, 57 insertions(+), 57 deletions(-)

diff --git a/kernel/bpf/arraymap.c b/kernel/bpf/arraymap.c
index 13358675f..d45bffe49 100644
--- a/kernel/bpf/arraymap.c
+++ b/kernel/bpf/arraymap.c
@@ -457,7 +457,7 @@ static void array_map_seq_show_elem(struct bpf_map *map, void *key,
 	if (map->btf_key_type_id)
 		seq_printf(m, "%u: ", *(u32 *)key);
 	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	rcu_read_unlock();
 }
@@ -478,7 +478,7 @@ static void percpu_array_map_seq_show_elem(struct bpf_map *map, void *key,
 		seq_printf(m, "\tcpu%d: ", cpu);
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
 				  per_cpu_ptr(pptr, cpu), m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	seq_puts(m, "}\n");
 
@@ -955,7 +955,7 @@ static void prog_array_map_seq_show_elem(struct bpf_map *map, void *key,
 			prog_id = prog_fd_array_sys_lookup_elem(ptr);
 			btf_type_seq_show(map->btf, map->btf_value_type_id,
 					  &prog_id, m);
-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 	}
 
diff --git a/kernel/bpf/bpf_struct_ops.c b/kernel/bpf/bpf_struct_ops.c
index 43356faaa..bf94043f0 100644
--- a/kernel/bpf/bpf_struct_ops.c
+++ b/kernel/bpf/bpf_struct_ops.c
@@ -833,7 +833,7 @@ static void bpf_struct_ops_map_seq_show_elem(struct bpf_map *map, void *key,
 		btf_type_seq_show(st_map->btf,
 				  map->btf_vmlinux_value_type_id,
 				  value, m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 
 	kfree(value);
diff --git a/kernel/bpf/hashtab.c b/kernel/bpf/hashtab.c
index 3a088a534..db5105275 100644
--- a/kernel/bpf/hashtab.c
+++ b/kernel/bpf/hashtab.c
@@ -1577,7 +1577,7 @@ static void htab_map_seq_show_elem(struct bpf_map *map, void *key,
 	btf_type_seq_show(map->btf, map->btf_key_type_id, key, m);
 	seq_puts(m, ": ");
 	btf_type_seq_show(map->btf, map->btf_value_type_id, value, m);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	rcu_read_unlock();
 }
@@ -2421,7 +2421,7 @@ static void htab_percpu_map_seq_show_elem(struct bpf_map *map, void *key,
 		seq_printf(m, "\tcpu%d: ", cpu);
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
 				  per_cpu_ptr(pptr, cpu), m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	seq_puts(m, "}\n");
 
diff --git a/kernel/bpf/local_storage.c b/kernel/bpf/local_storage.c
index a04f505ae..3969eb038 100644
--- a/kernel/bpf/local_storage.c
+++ b/kernel/bpf/local_storage.c
@@ -431,7 +431,7 @@ static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *key,
 		seq_puts(m, ": ");
 		btf_type_seq_show(map->btf, map->btf_value_type_id,
 				  &READ_ONCE(storage->buf)->data[0], m);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	} else {
 		seq_puts(m, ": {\n");
 		for_each_possible_cpu(cpu) {
@@ -439,7 +439,7 @@ static void cgroup_storage_seq_show_elem(struct bpf_map *map, void *key,
 			btf_type_seq_show(map->btf, map->btf_value_type_id,
 					  per_cpu_ptr(storage->percpu_buf, cpu),
 					  m);
-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 		seq_puts(m, "}\n");
 	}
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index a66c088c8..011db8474 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -6300,7 +6300,7 @@ int proc_cgroup_show(struct seq_file *m, struct pid_namespace *ns,
 
 			seq_puts(m, buf);
 		} else {
-			seq_puts(m, "/");
+			seq_putc(m, '/');
 		}
 
 		if (cgroup_on_dfl(cgrp) && cgroup_is_dead(cgrp))
diff --git a/kernel/cgroup/debug.c b/kernel/cgroup/debug.c
index 80aa3f027..d18f7dcb4 100644
--- a/kernel/cgroup/debug.c
+++ b/kernel/cgroup/debug.c
@@ -55,7 +55,7 @@ static int current_css_set_read(struct seq_file *seq, void *v)
 	seq_printf(seq, "css_set %pK %d", cset, refcnt);
 	if (refcnt > cset->nr_tasks)
 		seq_printf(seq, " +%d", refcnt - cset->nr_tasks);
-	seq_puts(seq, "\n");
+	seq_putc(seq, '\n');
 
 	/*
 	 * Print the css'es stored in the current css_set.
@@ -159,7 +159,7 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 				extra_refs += extra;
 			}
 		}
-		seq_puts(seq, "\n");
+		seq_putc(seq, '\n');
 
 		list_for_each_entry(task, &cset->tasks, cg_list) {
 			if (count++ <= MAX_TASKS_SHOWN_PER_CSS)
@@ -189,7 +189,7 @@ static int cgroup_css_links_read(struct seq_file *seq, void *v)
 	if (!dead_cnt && !extra_refs && !threaded_csets)
 		return 0;
 
-	seq_puts(seq, "\n");
+	seq_putc(seq, '\n');
 	if (threaded_csets)
 		seq_printf(seq, "threaded css_sets = %d\n", threaded_csets);
 	if (extra_refs)
diff --git a/kernel/latencytop.c b/kernel/latencytop.c
index 781249098..08fe9ce35 100644
--- a/kernel/latencytop.c
+++ b/kernel/latencytop.c
@@ -261,7 +261,7 @@ static int lstats_show(struct seq_file *m, void *v)
 
 				seq_printf(m, " %ps", (void *)bt);
 			}
-			seq_puts(m, "\n");
+			seq_putc(m, '\n');
 		}
 	}
 	return 0;
diff --git a/kernel/locking/lockdep_proc.c b/kernel/locking/lockdep_proc.c
index e2bfb1db5..4612d1c4f 100644
--- a/kernel/locking/lockdep_proc.c
+++ b/kernel/locking/lockdep_proc.c
@@ -101,17 +101,17 @@ static int l_show(struct seq_file *m, void *v)
 
 	seq_printf(m, ": ");
 	print_name(m, class);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	if (IS_ENABLED(CONFIG_PROVE_LOCKING)) {
 		list_for_each_entry(entry, &class->locks_after, entry) {
 			if (entry->distance == 1) {
 				seq_printf(m, " -> [%p] ", entry->class->key);
 				print_name(m, entry->class);
-				seq_puts(m, "\n");
+				seq_putc(m, '\n');
 			}
 		}
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 
 	return 0;
@@ -175,9 +175,9 @@ static int lc_show(struct seq_file *m, void *v)
 
 		seq_printf(m, "[%p] ", class->key);
 		print_name(m, class);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
@@ -379,7 +379,7 @@ static int lockdep_stats_show(struct seq_file *m, void *v)
 	/*
 	 * Zapped classes and lockdep data buffers reuse statistics.
 	 */
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	seq_printf(m, " zapped classes:                %11lu\n",
 			nr_zapped_classes);
 #ifdef CONFIG_PROVE_LOCKING
@@ -422,10 +422,10 @@ static void seq_line(struct seq_file *m, char c, int offset, int length)
 	int i;
 
 	for (i = 0; i < offset; i++)
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	for (i = 0; i < length; i++)
 		seq_printf(m, "%c", c);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 }
 
 static void snprint_time(char *buf, size_t bufsiz, s64 nr)
@@ -512,7 +512,7 @@ static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 		seq_lock_time(m, &stats->write_waittime);
 		seq_printf(m, " %14lu ", stats->bounces[bounce_acquired_write]);
 		seq_lock_time(m, &stats->write_holdtime);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 
 	if (stats->read_holdtime.nr) {
@@ -521,7 +521,7 @@ static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 		seq_lock_time(m, &stats->read_waittime);
 		seq_printf(m, " %14lu ", stats->bounces[bounce_acquired_read]);
 		seq_lock_time(m, &stats->read_holdtime);
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 
 	if (stats->read_waittime.nr + stats->write_waittime.nr == 0)
@@ -561,9 +561,9 @@ static void seq_stats(struct seq_file *m, struct lock_stat_data *data)
 			   ip, (void *)class->contending_point[i]);
 	}
 	if (i) {
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 		seq_line(m, '.', 0, 40 + 1 + 12 * (14 + 1));
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 }
 
diff --git a/kernel/module/procfs.c b/kernel/module/procfs.c
index 0a4841e88..dc91d3dba 100644
--- a/kernel/module/procfs.c
+++ b/kernel/module/procfs.c
@@ -35,7 +35,7 @@ static inline void print_unload_info(struct seq_file *m, struct module *mod)
 	}
 
 	if (!printed_something)
-		seq_puts(m, "-");
+		seq_putc(m, '-');
 }
 #else /* !CONFIG_MODULE_UNLOAD */
 static inline void print_unload_info(struct seq_file *m, struct module *mod)
@@ -99,7 +99,7 @@ static int m_show(struct seq_file *m, void *p)
 	if (mod->taints)
 		seq_printf(m, " %s", module_flags(mod, buf, true));
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
diff --git a/kernel/module/tracking.c b/kernel/module/tracking.c
index 16742d1c6..dcc4dc4c7 100644
--- a/kernel/module/tracking.c
+++ b/kernel/module/tracking.c
@@ -95,7 +95,7 @@ static int unloaded_tainted_modules_seq_show(struct seq_file *m, void *p)
 	buf[l++] = '\0';
 
 	seq_printf(m, "%s (%s) %llu", mod_taint->name, buf, mod_taint->count);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
diff --git a/kernel/sched/cpuacct.c b/kernel/sched/cpuacct.c
index 0de9dda09..0c1ce2e1c 100644
--- a/kernel/sched/cpuacct.c
+++ b/kernel/sched/cpuacct.c
@@ -245,14 +245,14 @@ static int cpuacct_all_seq_show(struct seq_file *m, void *V)
 	seq_puts(m, "cpu");
 	for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
 		seq_printf(m, " %s", cpuacct_stat_desc[index]);
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	for_each_possible_cpu(cpu) {
 		seq_printf(m, "%d", cpu);
 		for (index = 0; index < CPUACCT_STAT_NSTATS; index++)
 			seq_printf(m, " %llu",
 				   cpuacct_cpuusage_read(ca, cpu, index));
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 	}
 	return 0;
 }
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 8d5d98a58..03d78cff6 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -62,7 +62,7 @@ static int sched_feat_show(struct seq_file *m, void *v)
 			seq_puts(m, "NO_");
 		seq_printf(m, "%s ", sched_feat_names[i]);
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
@@ -251,15 +251,15 @@ static int sched_dynamic_show(struct seq_file *m, void *v)
 
 	for (i = 0; i < ARRAY_SIZE(preempt_modes); i++) {
 		if (preempt_dynamic_mode == i)
-			seq_puts(m, "(");
+			seq_putc(m, '(');
 		seq_puts(m, preempt_modes[i]);
 		if (preempt_dynamic_mode == i)
-			seq_puts(m, ")");
+			seq_putc(m, ')');
 
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	return 0;
 }
 
@@ -389,9 +389,9 @@ static int sd_flags_show(struct seq_file *m, void *v)
 
 	for_each_set_bit(idx, &flags, __SD_FLAG_CNT) {
 		seq_puts(m, sd_flag_debug[idx].name);
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 	}
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
diff --git a/kernel/time/test_udelay.c b/kernel/time/test_udelay.c
index 20d5df631..82fe239c3 100644
--- a/kernel/time/test_udelay.c
+++ b/kernel/time/test_udelay.c
@@ -59,7 +59,7 @@ static int udelay_test_single(struct seq_file *s, int usecs, uint32_t iters)
 			(usecs * 1000) - allowed_error_ns, min, avg, max);
 	if (fail_count)
 		seq_printf(s, " FAIL=%d", fail_count);
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');
 
 	return 0;
 }
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 6ece1308d..5992278cb 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4898,14 +4898,14 @@ static void print_action_spec(struct seq_file *m,
 		for (i = 0; i < hist_data->n_save_vars; i++) {
 			seq_printf(m, "%s", hist_data->save_vars[i]->var->var.name);
 			if (i < hist_data->n_save_vars - 1)
-				seq_puts(m, ",");
+				seq_putc(m, ',');
 		}
 	} else if (data->action == ACTION_TRACE) {
 		if (data->use_trace_keyword)
 			seq_printf(m, "%s", data->synth_event_name);
 		for (i = 0; i < data->n_params; i++) {
 			if (i || data->use_trace_keyword)
-				seq_puts(m, ",");
+				seq_putc(m, ',');
 			seq_printf(m, "%s", data->params[i]);
 		}
 	}
@@ -4924,7 +4924,7 @@ static void print_track_data_spec(struct seq_file *m,
 
 	print_action_spec(m, hist_data, data);
 
-	seq_puts(m, ")");
+	seq_putc(m, ')');
 }
 
 static void print_onmatch_spec(struct seq_file *m,
@@ -4938,7 +4938,7 @@ static void print_onmatch_spec(struct seq_file *m,
 
 	print_action_spec(m, hist_data, data);
 
-	seq_puts(m, ")");
+	seq_putc(m, ')');
 }
 
 static bool actions_match(struct hist_trigger_data *hist_data,
@@ -5413,9 +5413,9 @@ static void hist_trigger_print_key(struct seq_file *m,
 	}
 
 	if (!multiline)
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 
-	seq_puts(m, "}");
+	seq_putc(m, '}');
 }
 
 /* Get the 100 times of the percentage of @val in @total */
@@ -5511,13 +5511,13 @@ static void hist_trigger_entry_print(struct seq_file *m,
 		if (flags & HIST_FIELD_FL_VAR || flags & HIST_FIELD_FL_EXPR)
 			continue;
 
-		seq_puts(m, " ");
+		seq_putc(m, ' ');
 		hist_trigger_print_val(m, i, field_name, flags, stats, elt);
 	}
 
 	print_actions(m, hist_data, elt);
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 }
 
 static int print_entries(struct seq_file *m,
@@ -5971,7 +5971,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 		field = hist_data->fields[i];
 
 		if (i > hist_data->n_vals)
-			seq_puts(m, ",");
+			seq_putc(m, ',');
 
 		if (field->flags & HIST_FIELD_FL_STACKTRACE) {
 			if (field->field)
@@ -5997,7 +5997,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 			seq_puts(m, "hitcount");
 		} else {
 			if (show_val)
-				seq_puts(m, ",");
+				seq_putc(m, ',');
 			hist_field_print(m, field);
 		}
 		show_val = true;
@@ -6006,14 +6006,14 @@ static int event_hist_trigger_print(struct seq_file *m,
 	if (have_var) {
 		unsigned int n = 0;
 
-		seq_puts(m, ":");
+		seq_putc(m, ':');
 
 		for_each_hist_val_field(i, hist_data) {
 			field = hist_data->fields[i];
 
 			if (field->flags & HIST_FIELD_FL_VAR) {
 				if (n++)
-					seq_puts(m, ",");
+					seq_putc(m, ',');
 				hist_field_print(m, field);
 			}
 		}
@@ -6035,7 +6035,7 @@ static int event_hist_trigger_print(struct seq_file *m,
 			return -EINVAL;
 
 		if (i > 0)
-			seq_puts(m, ",");
+			seq_putc(m, ',');
 
 		if (idx == HITCOUNT_IDX)
 			seq_puts(m, "hitcount");
diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index e76f5e1ef..169482864 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -1779,7 +1779,7 @@ static int user_event_show(struct seq_file *m, struct dyn_event *ev)
 
 	list_for_each_entry_reverse(field, head, link) {
 		if (depth == 0)
-			seq_puts(m, " ");
+			seq_putc(m, ' ');
 		else
 			seq_puts(m, "; ");
 
@@ -1791,7 +1791,7 @@ static int user_event_show(struct seq_file *m, struct dyn_event *ev)
 		depth++;
 	}
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 
 	return 0;
 }
@@ -2644,13 +2644,13 @@ static int user_seq_show(struct seq_file *m, void *p)
 			busy++;
 		}
 
-		seq_puts(m, "\n");
+		seq_putc(m, '\n');
 		active++;
 	}
 
 	mutex_unlock(&group->reg_mutex);
 
-	seq_puts(m, "\n");
+	seq_putc(m, '\n');
 	seq_printf(m, "Active: %d\n", active);
 	seq_printf(m, "Busy: %d\n", busy);
 
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index b791524a6..874a81cf9 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -636,14 +636,14 @@ static int s_mode_show(struct seq_file *s, void *v)
 		seq_printf(s, "%s", thread_mode_str[mode]);
 
 	if (mode < MODE_MAX - 1) /* if mode is any but last */
-		seq_puts(s, " ");
+		seq_putc(s, ' ');
 
 	return 0;
 }
 
 static void s_mode_stop(struct seq_file *s, void *v)
 {
-	seq_puts(s, "\n");
+	seq_putc(s, '\n');
 	mutex_unlock(&hwlat_data.lock);
 }
 
-- 
2.34.1


