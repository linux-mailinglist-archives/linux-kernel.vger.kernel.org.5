Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A3C7819F0
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233315AbjHSOPG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:15:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233237AbjHSOO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:14:59 -0400
Received: from mail-qv1-xf35.google.com (mail-qv1-xf35.google.com [IPv6:2607:f8b0:4864:20::f35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69D71A265
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:50 -0700 (PDT)
Received: by mail-qv1-xf35.google.com with SMTP id 6a1803df08f44-649a653479bso10152236d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692454369; x=1693059169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kSjHpIarSFWJNPdWsAvPv/NwMFUjoCdaJnar30zRHJU=;
        b=YPTYau8iMQLnPV+8MSH/8fja/dsf3ZcEtp5kyGNDrnFQqPSXA5t6VdW4PpzV8wj9De
         9w4eBuHp337uqHsSO8utHM8/RVexJMd4Nq1n4C8TDizf3M2jE01bhejhVqpv67N90w3m
         /8hJWdkhJO1gY/EjNZkWkBPTBTnXoF4wuIv9yOUkUWDdwRQyE9douqL/HsdzxxILocF1
         iOyufwrqJiVlOWBYHXCP40osxOUD/3qinlpd6jk6RJgTZk4jgn6odD4ol+tnkFtuw5k6
         LxPvVHNtQxQz8fCwlXbUSbbzBIOIa6DuKbo9gMZIF6Uov1UISZHXIyeaEbDQRmznnsAk
         dP0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454369; x=1693059169;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kSjHpIarSFWJNPdWsAvPv/NwMFUjoCdaJnar30zRHJU=;
        b=HCKKg5tAm8OSJ8XKQBxteYqTKLRTgOQ3Jy/ps5T9hmXi8sZJTMi6thxV5NfBMTvf19
         LHbpGLoKbkIY49No5frIbzHCBOJP6g48nLdiwHHppST2LTq0XVSoa5PSZS0T2ho3W3VJ
         F3D91tl1AmrEDfB53ux4aZSetftJuB0mXb1MujtkpNsroCzZCqdf5tu/7GKp3Py5Ts9G
         J5rDrB5su2W80LwaekfIF8YGfatj8kVyGhMwO7xW7aV4rHVGEkWl51OG+uLL7qz5upW3
         C4og1cBZG0nFRS5y7W1mdvBjzTpDbTGaZU27ZMyJ5LkofAF03sOWCta3UEfNfGv9TVic
         epLA==
X-Gm-Message-State: AOJu0YxbPEUmm+EBCDn8D4AKGMKMJkWMfrQmvD1CfOeZVAufwq7HmZvC
        LYFQBhjqQCbNdRxhvYpuuKSHYcpxx9Q=
X-Google-Smtp-Source: AGHT+IFlP2jDt8uZ7TktMhzGEL+WSo8Hr7UkTWitsqazph963ocRgXITG4K/KKqigpjjb7d7gIYaJQ==
X-Received: by 2002:a0c:f34d:0:b0:647:1764:7e1a with SMTP id e13-20020a0cf34d000000b0064717647e1amr1891960qvm.27.1692454369104;
        Sat, 19 Aug 2023 07:12:49 -0700 (PDT)
Received: from localhost ([32.218.242.113])
        by smtp.gmail.com with ESMTPSA id x8-20020a0ce0c8000000b0062def68f75csm68439qvk.124.2023.08.19.07.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 07:12:48 -0700 (PDT)
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
Subject: [PATCH v2 6/6] sched: fix sched_numa_find_nth_cpu() comment
Date:   Sat, 19 Aug 2023 07:12:38 -0700
Message-Id: <20230819141239.287290-7-yury.norov@gmail.com>
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

Reword sched_numa_find_nth_cpu() comment and make it kernel-doc compatible.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/topology.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index bc6802700103..789b281d2380 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2103,13 +2103,15 @@ static int hop_cmp(const void *a, const void *b)
 	return -1;
 }
 
-/*
- * sched_numa_find_nth_cpu() - given the NUMA topology, find the Nth next cpu
- *                             closest to @cpu from @cpumask.
- * cpumask: cpumask to find a cpu from
- * cpu: Nth cpu to find
- *
- * returns: cpu, or nr_cpu_ids when nothing found.
+/**
+ * sched_numa_find_nth_cpu() - given the NUMA topology, find the Nth closest CPU
+ *                             from @cpus to @cpu, taking into account distance
+ *                             from a given @node.
+ * @cpus: cpumask to find a cpu from
+ * @cpu: CPU to start searching
+ * @node: NUMA node to order CPUs by distance
+ *
+ * Return: cpu, or nr_cpu_ids when nothing found.
  */
 int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
-- 
2.39.2

