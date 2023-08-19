Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154987819ED
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233284AbjHSOPA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233218AbjHSOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:14:58 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06AF19ECB
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:47 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a7d4030621so1171270b6e.3
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692454366; x=1693059166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=igV7SREietQ24odTG+SOK9M1ry44nQsh1uk2kgh31uI=;
        b=YHzUfnhp2ULvFItZJ3o9nXuTnirno2N6SDjG259/ov8RQGn1YKf8iAafsV/TZmzM9G
         +JnpUr2gmWptKe9x+JSvawiBnbrHhC0ttUD2okQ/G1fkWvTO+q+8WWnRri6umDq+AeyL
         uI0r086HHFLAzxmjNMoczkq3+6neOsKWrv7/U+R0BktdT2UnHnqO2MbZ02/Sv0a3y64w
         uVF4L/O5aitTTPQbj/ImVhoNslyY90UeKiLJpC1hbba+hqARYZbe+jJxR1t91g/UGIRk
         cj0t8on3AEkxlEMjodaPmpu584rPPq3QYwFMKZXzjDyKDOj1sI+dorfQbPfPplhlCTXI
         V2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454366; x=1693059166;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=igV7SREietQ24odTG+SOK9M1ry44nQsh1uk2kgh31uI=;
        b=R3I6FrJoOiR1df06L/eq+2jpjyvA1NOfjqaIh5poa07OXgmZy9MGqTSjlCyCxd1rJ8
         hp2RgYT7MOJfFxmV5ztutwQ0I8O0MnS6T5YkdIzGT4C56b21BKEz+AF8e0e9bjiba/jr
         Ks7uRfEodk+1XE1CafpaE11+i8tR8X+S1jkl7dwDY6ZLb8VRyrm7sFZrU/R7U7+E5ses
         4vbvv5y0J4ghYoGe/BSLN/rlqfhI1D77abKXRdGjqPH7d9n1Xa2ToJ3wbii2Sn0rpnW2
         TCDtxO14Dj90bkzlQrbKwiJmkX//xdsLE4d4AHN8Bilc+xI5YuWMm6YkMMr8ZF+F2SD0
         t8mQ==
X-Gm-Message-State: AOJu0YzMIpNV55dV29m4DHXZMtVJVbnU58W8xGqgRFpXwOdhz8hnsHcC
        PDjbTfB50fDegVmlBFZdpgEgIuuLH4o=
X-Google-Smtp-Source: AGHT+IHSqqEDImaL7LnYyBklQgJU18/Wzpv/z+7QriCsXPpQMlpRzLKW65D8myoE3i10msbA9KqjvA==
X-Received: by 2002:a05:6358:e486:b0:135:499b:a68c with SMTP id by6-20020a056358e48600b00135499ba68cmr488750rwb.8.1692454365835;
        Sat, 19 Aug 2023 07:12:45 -0700 (PDT)
Received: from localhost ([32.218.242.113])
        by smtp.gmail.com with ESMTPSA id r11-20020a0ccc0b000000b00631fea4d5bcsm1466439qvk.95.2023.08.19.07.12.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 07:12:45 -0700 (PDT)
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH v2 3/6] sched: fix sched_numa_find_nth_cpu() in CPU-less case
Date:   Sat, 19 Aug 2023 07:12:35 -0700
Message-Id: <20230819141239.287290-4-yury.norov@gmail.com>
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
Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>
---
 kernel/sched/topology.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d3a3b2646ec4..c6e89afa0d65 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2113,12 +2113,16 @@ static int hop_cmp(const void *a, const void *b)
  */
 int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
-	struct __cmp_key k = { .cpus = cpus, .node = node, .cpu = cpu };
+	struct __cmp_key k = { .cpus = cpus, .cpu = cpu };
 	struct cpumask ***hop_masks;
 	int hop, ret = nr_cpu_ids;
 
 	rcu_read_lock();
 
+	/* CPU-less node entries are uninitialized in sched_domains_numa_masks */
+	node = numa_nearest_node(node, N_CPU);
+	k.node = node;
+
 	k.masks = rcu_dereference(sched_domains_numa_masks);
 	if (!k.masks)
 		goto unlock;
-- 
2.39.2

