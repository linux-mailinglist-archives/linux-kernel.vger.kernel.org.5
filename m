Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0FF4777E28
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 18:25:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236768AbjHJQZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 12:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236731AbjHJQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 12:25:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37AF3271E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:25:01 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-55b0e7efb1cso748396a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 09:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691684700; x=1692289500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmmjHmVn6ls0sfUQEL2MtTTuL3JIkk0EADWsp1ssJ1I=;
        b=Bfx08UPqSGUA5kMzlG6c1gKFPujJymFxHHEcbncpgTNXWfilym9jS0kJbo5BDAWSAt
         D9mUQJQct3QouTQHkHkPrBDMCKnWAqpbreP6nPj61t/mOCWJMUiU9SBgEkrua+TY2WvN
         RQ5wEy+PuxBPt8ZoFj5D2HGw+0EHyLI1z4DoNLoS5QRQ61C+28JBYhQSRil/n4cmq226
         +7wHPiq3FSMBXOYZHozHHb530CuwJI/i1j1XgNJxE8OzuAkHE9j+84kXPMYw7IqXs9K/
         EXbvqacZmwYzBoSTAuKgMu8XWHjH7xGtl86RqyboalPaLOIF5AyV51Wm78Vn2A7DNWzT
         lIsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691684700; x=1692289500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmmjHmVn6ls0sfUQEL2MtTTuL3JIkk0EADWsp1ssJ1I=;
        b=N/W3aJ0xf21clczBs2B5V0PPmERg2NcMzvsqk0OX27k5ygRkqbCPjQKlBC+vEw/4wN
         21oZOEZhZWs4eQpw55ZyFiPrA2GX3dqUC9l5/eV1q73JnHbAAkopsyMLJ7YoW9KbkLQC
         rkzq3e8rj94BNuJV1duArmQ89pa1YszSgZUJGKEzZH6C332Zmnu/ykoY1/OjkqQuCDoa
         U2IU0FWjIPMX0MZpj8Sj3b/ds82VD2QFpqJ7OcCv/aaUclLcPZH1EVAvRxomJFvVYwDr
         is/fTNbPvDpX+chMVDr8q/Xdvh6wH4IJtTJfZWyPBBhlOrQ/s5o6m0Iq+iJU6U214QCC
         +R7Q==
X-Gm-Message-State: AOJu0YwRtw7ttvcZaTzfLvXeOhXkqtu1n66XL+MSjqh1LhAi7A7NkpoM
        KHSv1+SmcK3XDl2HoNL6GcdvOfs/l+M=
X-Google-Smtp-Source: AGHT+IH4taXK3kC2OJr25PCWrlpW+eWTUdvnoQR0cwNL04PBbBOADtjdA//KwLTk44jREORqIyxPQQ==
X-Received: by 2002:a17:90b:4f8a:b0:267:f8a2:300a with SMTP id qe10-20020a17090b4f8a00b00267f8a2300amr2362896pjb.7.1691684700106;
        Thu, 10 Aug 2023 09:25:00 -0700 (PDT)
Received: from localhost ([216.228.127.129])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a070900b00267b38f5e13sm1811075pjl.2.2023.08.10.09.24.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 09:24:59 -0700 (PDT)
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
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 4/4] sched: fix sched_numa_find_nth_cpu() in non-NUMA case
Date:   Thu, 10 Aug 2023 09:24:42 -0700
Message-Id: <20230810162442.9863-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810162442.9863-1-yury.norov@gmail.com>
References: <20230810162442.9863-1-yury.norov@gmail.com>
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

When CONFIG_NUMA is enabled, sched_numa_find_nth_cpu() searches for a
CPU in sched_domains_numa_masks. The masks includes only online CPUs,
so effectively offline CPUs are skipped.

When CONFIG_NUMA is disabled, the fallback function should be consistent.

Fixes: cd7f55359c90 ("sched: add sched_numa_find_nth_cpu()")
Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 include/linux/topology.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/topology.h b/include/linux/topology.h
index fea32377f7c7..52f5850730b3 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -251,7 +251,7 @@ extern const struct cpumask *sched_numa_hop_mask(unsigned int node, unsigned int
 #else
 static __always_inline int sched_numa_find_nth_cpu(const struct cpumask *cpus, int cpu, int node)
 {
-	return cpumask_nth(cpu, cpus);
+	return cpumask_nth_and(cpu, cpus, cpu_online_mask);
 }
 
 static inline const struct cpumask *
-- 
2.39.2

