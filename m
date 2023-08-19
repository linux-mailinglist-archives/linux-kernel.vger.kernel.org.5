Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 767A37819EE
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:15:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233294AbjHSOPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233224AbjHSOO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:14:58 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B5489ED9
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:48 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id 6a1803df08f44-64cca551ae2so3733466d6.0
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692454367; x=1693059167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SmmjHmVn6ls0sfUQEL2MtTTuL3JIkk0EADWsp1ssJ1I=;
        b=DG6joiC2Lh32MiV3Hhqxx3JWfQDfDz/+8b0EdnMI1S+h3jh7LlNSk0ZQqNJgRg62Z7
         3rlaxuUKCDxday8et0CVelK2WFG3zjQNY2LFZOzuTLwxfBhJqvEfVigb/4QPBMbQcxjU
         qjqzPnj0LYYPPADAvFTkSkVDZfLtCn1hLjx1jfvoUGGiDN9oLQeTTHtTTmJTcCitifem
         CKA0GfI3ugT45tKAdlgqZEDA18Rftgam1AdPVf8K6HYQufQ6i7Il64g3uPRSBc+0rc0k
         wfwnK3RBh06a2KwGVvE7GvgcZQYFOyPzUvnjFYV6Kv+K90LdXhq+3wO3Px4qqG69USp8
         cr3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454367; x=1693059167;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SmmjHmVn6ls0sfUQEL2MtTTuL3JIkk0EADWsp1ssJ1I=;
        b=l4LyclCCgJkt4inB2ma7FG5D0sIR/tZEqO5L7XmabR4v9JWvNNSmrn2j1cnm7T14ZJ
         avRLZXxxdp9N2WpTCgQe+Sj23pbCoAWoIPpYNNfRllYHDviu5SJvBdoE/LFGpG3HkaPm
         WSN8K/U8N1IPphy0rhhsLwSx/+79ShkOP8jHX835iF4I4uw5rly4HrobkQJj4t0GQ/+Q
         qIKaam4MUBihQP2R28STOukhPd/4FEMPoqlv4KBamPfX4Cyf4xlb1dra5L/Fh7TB4dXf
         kNUCKoIbec1l2pDbBDdGUiJv0EETlrNZvsiaaT5u6bwijkJHrWIIPXadEHJF3BQnCUWP
         7LAg==
X-Gm-Message-State: AOJu0YxEqfPHBePHlEYktLVkGMd9gfzmdvMAL5K98DgXIU1BSdyNVKph
        j3csWtPAhXUME2JF0zkCU7yrOIaoJa0=
X-Google-Smtp-Source: AGHT+IEfRsyy5LserSpARnbs4AMrhHIcl356NFzEZZyieATaLVkGrmSM4un/e4KNH9OAVV4li0xoAg==
X-Received: by 2002:a0c:e413:0:b0:64b:997f:5a7e with SMTP id o19-20020a0ce413000000b0064b997f5a7emr2602799qvl.8.1692454366974;
        Sat, 19 Aug 2023 07:12:46 -0700 (PDT)
Received: from localhost ([32.218.242.113])
        by smtp.gmail.com with ESMTPSA id g22-20020a0caad6000000b006262de12a8csm1464891qvb.65.2023.08.19.07.12.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 07:12:46 -0700 (PDT)
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
Subject: [PATCH v2 4/6] sched: fix sched_numa_find_nth_cpu() in non-NUMA case
Date:   Sat, 19 Aug 2023 07:12:36 -0700
Message-Id: <20230819141239.287290-5-yury.norov@gmail.com>
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

