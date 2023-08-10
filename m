Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87182777E27
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235092AbjHJQZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235458AbjHJQY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:24:58 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77D6426B9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:24:57 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bc73a2b0easo8793645ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684696; x=1692289496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQk4oJI+dzYiJ4RogHTgjWRfeAMe6bXV6Pd7fbAJYxU=;
        b=M6sZ2J4RqvlOD26FWyHUZkJEL4FbixgRpcY7K5Qx7CRSteyzAk5jEZZ3/nSPOURWur
         xcSHtBDVDtXtT9UMg52UVtPwO0QW8YKpfYXUalKV+OjXLuAXZDRiFksuPQTN9TUxg8+i
         acSXvrkexfeLi8DqZ7kHNO98YwAfh6HJSsX5un/0hBI/J1NfQ08+TGhJeXlRZKeSUtlJ
         ysKOCebZZJiOVVIulL83NG/0ZacXvYct0AyBjluLQVjG6Ny72+8lqqCgScSAnHTYF3/A
         pdJGSITa/qbFccDnMfseTM3MqRfO8Kq/mwaqrFxvSlmYyBl+Cmymt3+FrfbDP0NHrBZn
         H49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684696; x=1692289496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQk4oJI+dzYiJ4RogHTgjWRfeAMe6bXV6Pd7fbAJYxU=;
        b=O1TmntaEt6TY7RGjbuyluOHlH3fT+JVcaxx9cIG6/L5Saynofr/IHjyQx4zN/myQwS
         71nbyQHwDPvsvUlu2r4sd2Tf0wAT0rwuoNpn/mX/W0HhwTiFz1N6k2ZaIS5MT7MQsF1K
         l7GN8yKlI9GA8Wc+smLmnFgLlrYqT3Iin8LQz4mYJOG7yB8sQs/hZm2TYh8GOkkdoLfM
         Na21kP/+PKFSq1ba3bqPhQvvyYWxqNvLV/iQ3OKNxxSV7/wuFeIpFOzEPaRQ+/mBMI7r
         4+iz8NE5JHoPfGdut4EeCCR/u78PkJj44UljvLcFj64yp2bnIqdpftUKj6Bp7ZgBvO+j
         Z44A==
X-Gm-Message-State: AOJu0YwW70+Q2DZ8Ry4hHP+fvJahM27LA+xknIRok1yHOOYGfGpPg1Lk
        akhsRbV74I1Uu28dOBHYbhB1nXkxj2w=
X-Google-Smtp-Source: AGHT+IGpw06hn3MFB4Nmd0fxqwgYy6O+F1jeSuXuJNEsYw+C2EQLFpRj4Hz94ivhfKYOnMQUVqg2+Q==
X-Received: by 2002:a17:902:d483:b0:1b5:1787:d23f with SMTP id c3-20020a170902d48300b001b51787d23fmr2773609plg.5.1691684696416;
        Thu, 10 Aug 2023 09:24:56 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id r10-20020a170902be0a00b001bbab888ba0sm1967879pls.138.2023.08.10.09.24.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:24:56 -0700 (PDT)
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
        Peter Lafreniere <peter@n8pjl.ca>,
        Steven Rostedt <rostedt@goodmis.org>,
        Tariq Toukan <tariqt@nvidia.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        shiju.jose@huawei.com, jonathan.cameron@huawei.com,
        prime.zeng@huawei.com, linuxarm@huawei.com,
        yangyicong@hisilicon.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 3/4] sched: fix sched_numa_find_nth_cpu() in CPU-less case
Date:   Thu, 10 Aug 2023 09:24:41 -0700
Message-Id: <20230810162442.9863-4-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810162442.9863-1-yury.norov@gmail.com>
References: <20230810162442.9863-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the node provided by user is CPU-less, corresponding record in
sched_domains_numa_masks is not set. Trying to dereference it in the
following code leads to kernel crash.

To avoid it, start searching from the nearest node with CPUs.

Fixes: cd7f55359c90 ("sched: add sched_numa_find_nth_cpu()")
Reported-by: Yicong Yang <yangyicong@hisilicon.com>
Closes: https://lore.kernel.org/lkml/CAAH8bW8C5humYnfpW3y5ypwx0E-09A3QxFE1JFzR66v+mO4XfA@mail.gmail.com/T/
Reported-by: Guenter Roeck <linux@roeck-us.net>
Closes: https://lore.kernel.org/lkml/ZMHSNQfv39HN068m@yury-ThinkPad/T/#mf6431cb0b7f6f05193c41adeee444bc95bf2b1c4
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---

This has been discovered and fixed by Yicong Yang:

https://lore.kernel.org/lkml/CAAH8bW8C5humYnfpW3y5ypwx0E-09A3QxFE1JFzR66v+mO4XfA@mail.gmail.com/T/

When discovering Guenter's failure report for sparc64, I found it's due to
the same problem. And while fixing, I found an opportunity to generalize
nearest NUMA node search and avoid code duplication.

Yicong, if you like this approach, please feel free to add your co-developed-by
or any appropriate tags.

 kernel/sched/topology.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b2646ec4..66b387172b6f 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2113,10 +2113,14 @@ static int hop_cmp(const void *a, const void *b)
  */
 int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
-	struct __cmp_key k = { .cpus = cpus, .node = node, .cpu = cpu };
+	struct __cmp_key k = { .cpus = cpus, .cpu = cpu };
 	struct cpumask ***hop_masks;
 	int hop, ret = nr_cpu_ids;
 
+	/* CPU-less node entries are uninitialized in sched_domains_numa_masks */
+	node = numa_nearest_node(node, N_CPU);
+	k.node = node;
+
 	rcu_read_lock();
 
 	k.masks = rcu_dereference(sched_domains_numa_masks);
-- 
2.39.2

