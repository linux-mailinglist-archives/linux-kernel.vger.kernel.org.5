Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDA737819EC
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:15:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233270AbjHSOO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjHSOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:14:58 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F294693FD
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:45 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6432a429f61so10831726d6.2
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692454365; x=1693059165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QFVxXxStyebQd2+5mwYh1o0joRC2SclF2vbhFRruGlE=;
        b=ZfnvpAJgMbfQ3CZw7R7tBTIb0/CjcaNSgcbF2GnwC1IHBGukLBv2YpA5Xks+Msu2TA
         uMhZWngetDzl4ElT+MpmnGvhNpcECn0iQeDQaf7+z5ohObKr5KveEms6lREnz0pkluIU
         lbhrThEQrUqq6005xo225pWxTJLTL7a5laff9rT5866P9fbRYXvRztLy4FgY5FGg/NNs
         0+QPT5LsThOBOcRtvSSNj3gmKBcKzSr9A+7gOARHUk+/0caenQwXXwwIjYV4cA1ZWQsh
         TniAp6hta2j/wAcjBcjfdlP6BU1uXdT2cSDxOe10NQwQoEvi2oJ38UOEwKOB6im0XK+m
         //JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454365; x=1693059165;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QFVxXxStyebQd2+5mwYh1o0joRC2SclF2vbhFRruGlE=;
        b=B/8X/oartafkNc1/i1sJd2hSHGci3rW2irAC+uSuOo547A5XyW44XkqfSDcolGr1TU
         XmKGR1glbfyllj3Gd6RQV+Q5dGoXvH7nXFH7OKdAG0WO/Jhr1CkbGU6G77sjCeG48NBl
         b8yEnfHVbNjYt+TH/86Tbq027DiK0ICybg4JrwSQt341V2upv59GwWJBbAh5t8qQwPqa
         2GMAX+Zn649eH97Ia5s6qlqEGBu8bTz8dH9mO/Nol8L6ElJ7+E4KVxwC6sUKknJwrYsf
         ZUDnkEvRMZI1cnwdr7uWWd6OvlE9EuDyd6qJY+A2aqzA89E+WwzNQHPVb6FJ+LLGvhbT
         Exnw==
X-Gm-Message-State: AOJu0YyEy1fy+Oe8ok/VCq7TwEN7xj8g6keTHBgAD6D4zdGXo/NLBSyb
        EMu+0bsGkG2SerNTmg4lsFwLqU72huQ=
X-Google-Smtp-Source: AGHT+IFUX8eTyssulPQya93DY8TjvT45WssAgMpP4ifh6tDP9KAQSGhQl+ktG/q4W6s+7sBb8lbdUw==
X-Received: by 2002:a0c:8e83:0:b0:640:5beb:d89d with SMTP id x3-20020a0c8e83000000b006405bebd89dmr2415714qvb.40.1692454364731;
        Sat, 19 Aug 2023 07:12:44 -0700 (PDT)
Received: from localhost ([32.218.242.113])
        by smtp.gmail.com with ESMTPSA id h16-20020a0cab10000000b0064906cfe430sm1473236qvb.135.2023.08.19.07.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 07:12:44 -0700 (PDT)
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
Subject: [PATCH v2 2/6] sched/fair: fix opencoded numa_nearest_node()
Date:   Sat, 19 Aug 2023 07:12:34 -0700
Message-Id: <20230819141239.287290-3-yury.norov@gmail.com>
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

task_numa_placement() searches for a nearest node to migrate by calling
for_each_node_state(). Now that we have numa_nearest_node(), switch to
using it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 kernel/sched/fair.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3e25be58e2b..e7b7cf87937b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2645,19 +2645,7 @@ static void task_numa_placement(struct task_struct *p)
 	}
 
 	/* Cannot migrate task to CPU-less node */
-	if (max_nid != NUMA_NO_NODE && !node_state(max_nid, N_CPU)) {
-		int near_nid = max_nid;
-		int distance, near_distance = INT_MAX;
-
-		for_each_node_state(nid, N_CPU) {
-			distance = node_distance(max_nid, nid);
-			if (distance < near_distance) {
-				near_nid = nid;
-				near_distance = distance;
-			}
-		}
-		max_nid = near_nid;
-	}
+	max_nid = numa_nearest_node(max_nid, N_CPU);
 
 	if (ng) {
 		numa_group_count_active_nodes(ng);
-- 
2.39.2

