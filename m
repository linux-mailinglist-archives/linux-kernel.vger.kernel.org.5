Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9638A7819EF
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:15:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231128AbjHSOPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233236AbjHSOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:14:59 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CAF9EF7
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:49 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76d83954c43so126372485a.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692454368; x=1693059168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Crn5/+8WdRhCgV6i5ssfAVZRKeJzdqL7IL6ctYKnl6U=;
        b=U7AgRT8Ejxxl/VEdRwqDG1ENqN4QGxU6q+qxz0PKZpU9PSYvv4hGm/LQQLGxOrW1gJ
         CWLHmh7bBtOZQEIirnGLdBTRwYf5ThOF0JN0i91aMcJOkDKLZxhdvJ3WZr20h2BmTR/b
         icRcsHm5yrdnjCN64NRgjkhAgWD8MzAJiawtCyEU8rZpGuPTFn7dVM43FYHmSDsEpWgH
         WeYgmoVQ6tUx1hhTGyjdZmYTtK6mjtcolc7TSb9NigZLMaPqqeQrDZdjkyl/ECDxq5VC
         CZEAbglb9Y0vPOZDMQZOKdkUtKdyAS3YZNc/qBVNVgenMfI4FRZzgHQ1iiynIlneqMrG
         HyuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454368; x=1693059168;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Crn5/+8WdRhCgV6i5ssfAVZRKeJzdqL7IL6ctYKnl6U=;
        b=YfJ4XkCd0ppkGgVjUFuBoVHJNF6Xml5rRjNf2ykfkNMzb49B3HpgpGsSi+MMjv5Yus
         9uK/r/TgfjKhrsO26+rOJl12jr/VJtTTDCY9ZnDZCny4QIWsla8kr4wY11E2rTJ+f9Aa
         BWRA1XTWouN964bY96dT0cZGzqbrXrWiIU8bjk8dbZWueTjAdgaJNILRQ2VimQmmPxZY
         Hg0VVp8bn2AYhMaeGO4sAUSnGri859KeNPgkS0aGWYtKdE/8CqSQdjmcPULq9EXK6wDO
         Ldb6N+qgxdaINy46+iuaLnweeidKhWWiOkNxqi9zlpzT3/lnqRD7InXi841DYcihpHLR
         cLzg==
X-Gm-Message-State: AOJu0YyN/UnNyNwWi3D92zD5lgJ59MZeaB/C46A50ZcYAgI3Z4a0rU72
        FckZ/jYgfk0wLzPIpSe9nLbl0dRlCWM=
X-Google-Smtp-Source: AGHT+IETTvZTEFyiJf8ZsCBw1Z942T/yFUfrCc+lCrhAif1gu2FCfd/M7wsnPaQD+/POCrDPVTsgpw==
X-Received: by 2002:a05:620a:2987:b0:76c:e764:5081 with SMTP id r7-20020a05620a298700b0076ce7645081mr2825410qkp.37.1692454367995;
        Sat, 19 Aug 2023 07:12:47 -0700 (PDT)
Received: from localhost ([32.218.242.113])
        by smtp.gmail.com with ESMTPSA id 22-20020a05620a079600b0076ce061f44dsm1204827qka.25.2023.08.19.07.12.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 07:12:47 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shiju.jose@huawei.com, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH v2 5/6] sched: handle NUMA_NO_NODE in sched_numa_find_nth_cpu()
Date:   Sat, 19 Aug 2023 07:12:37 -0700
Message-Id: <20230819141239.287290-6-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230819141239.287290-1-yury.norov@gmail.com>
References: <20230819141239.287290-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sched_numa_find_nth_cpu() doesn't handle NUMA_NO_NODE properly, and
may crash kernel if passed with it. On the other hand, the only user
of sched_numa_find_nth_cpu() has to check NUMA_NO_NODE case explicitly.

It would be easier for users if this logic will get moved into
sched_numa_find_nth_cpu().

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 3 +++
 lib/cpumask.c           | 4 +---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index c6e89afa0d65..bc6802700103 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2117,6 +2117,9 @@ int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 	struct cpumask ***hop_masks;
 	int hop, ret = nr_cpu_ids;
 
+	if (node == NUMA_NO_NODE)
+		return cpumask_nth_and(cpu, cpus, cpu_online_mask);
+
 	rcu_read_lock();
 
 	/* CPU-less node entries are uninitialized in sched_domains_numa_masks */
diff --git a/lib/cpumask.c b/lib/cpumask.c
index 19277c6d551f..e77ee9d46f71 100644
--- a/lib/cpumask.c
+++ b/lib/cpumask.c
@@ -147,9 +147,7 @@ unsigned int cpumask_local_spread(unsigned int i, int node)
 	/* Wrap: we always want a cpu. */
 	i %= num_online_cpus();
 
-	cpu = (node == NUMA_NO_NODE) ?
-		cpumask_nth(i, cpu_online_mask) :
-		sched_numa_find_nth_cpu(cpu_online_mask, i, node);
+	cpu = sched_numa_find_nth_cpu(cpu_online_mask, i, node);
 
 	WARN_ON(cpu >= nr_cpu_ids);
 	return cpu;
-- 
2.39.2

