Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A247819E9
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Aug 2023 16:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbjHSONu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Aug 2023 10:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbjHSONs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Aug 2023 10:13:48 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 834585599
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:43 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76da0ed3b7aso2399585a.1
        for <linux-kernel@vger.kernel.org>; Sat, 19 Aug 2023 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692454362; x=1693059162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mPWQ2vK2kX3O9yTdZhAmhC3dcu3HKICeyyzpQ4tve9E=;
        b=rGcvNDopABgqPZqzeB5UOOz1sJPaZCNTiHfrhi2hwICq2ybn9eyfwJZ2+e7JV2RniR
         FaHluQWFGFF+qkWWA/vq5AVV/Z/ccWhz1iADgKBTNVMhMwIHmBXt+jiZ6yuQd8pIpG9I
         fX94ANcpMt3v3nrffMSEZoxpWhQPEj88vSQNzeygksYnY8OQJOjxTYwMg1H60wRpGwXz
         1JcpeQKO9EhnMQ7QhUMNyCruX2mwK4oMyCX5WGfS0HTbIsTZhIK0E5Bn83NKyAL39aGr
         hAbeewy0hnhp2Cslhp7ebtyuiJNC/E364c5IwFfp1uZgZKukCyuralnsj1M/L8OjiNEC
         z1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692454362; x=1693059162;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mPWQ2vK2kX3O9yTdZhAmhC3dcu3HKICeyyzpQ4tve9E=;
        b=GYgplzIt0zuYGN4WRt3hwN6Lt2PShOfsv12PLEIoZsYZlfzQ2Mruw4tNzL8tbwN+dt
         AHrFKoHtJ3UJtYpkjiR+nBCmBnKW3+joJcTm09ZbgG6ymMb78Si6ruWWUXy9K6zHC5NF
         f+HsEnyIMHb82sT02vpYUm8BlTpJsHaFczT/Nj0i3gFYk4Q63CuLGYG012o519ks4Aum
         g2VqowYPO5Rray5XJwaJM4lgty9hza86F/GR9UkDMZ2GKQ4Lpvo59GTDFUNp262I0wMD
         K1v0QnfmdqMM0D2XXuRQeCkf+H8LlotYuPhXFrfKJx8c34HtfgsfeAndfcVEIvyfPR30
         vL1Q==
X-Gm-Message-State: AOJu0Ywsmh6Po7qFPyqGs8Wp+uxr3NjmVlhLV51mvcxAEH2D9jx+FVmG
        UZYbvX+rENsobr6dvU/wBDMHu1gbv+s=
X-Google-Smtp-Source: AGHT+IH2tWAivh4wKIlaP0hQ4fQ+ByGgdqB8HmuIiGxaZp0EvuT2z1rF/Ga9MIo2J+Rpp7cMeYVqWQ==
X-Received: by 2002:a05:620a:e90:b0:76d:9c84:9ea7 with SMTP id w16-20020a05620a0e9000b0076d9c849ea7mr1247630qkm.22.1692454362173;
        Sat, 19 Aug 2023 07:12:42 -0700 (PDT)
Received: from localhost ([32.218.242.113])
        by smtp.gmail.com with ESMTPSA id oo23-20020a05620a531700b0076c98dad91dsm1201945qkn.120.2023.08.19.07.12.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Aug 2023 07:12:41 -0700 (PDT)
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
Subject: [PATCH v2 0/6] sched fixes
Date:   Sat, 19 Aug 2023 07:12:32 -0700
Message-Id: <20230819141239.287290-1-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
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

Fixes for recently introduced sched_numa_find_nth_cpu(), and minor
improvements in sched/fair.

v1: https://lore.kernel.org/lkml/20230810162442.9863-1-yury.norov@gmail.com/T/
v2:
 - fix wording in commit messages;
 - move nearest node search inside rcu lock section in
   sched_numa_find_nth_cpu();
 - move NUMA_NO_NODE handling inside sched_numa_find_nth_cpu();
 - rewrite comment for sched_numa_find_nth_cpu().
 - add review tag from Yicong Yang.

Yury Norov (6):
  numa: generalize numa_map_to_online_node()
  sched/fair: fix opencoded numa_nearest_node()
  sched: fix sched_numa_find_nth_cpu() in CPU-less case
  sched: fix sched_numa_find_nth_cpu() in non-NUMA case
  sched: handle NUMA_NO_NODE in sched_numa_find_nth_cpu()
  sched: fix sched_numa_find_nth_cpu() comment

 include/linux/numa.h     |  7 +++++--
 include/linux/topology.h |  2 +-
 kernel/sched/fair.c      | 14 +-------------
 kernel/sched/topology.c  | 25 +++++++++++++++++--------
 lib/cpumask.c            |  4 +---
 mm/mempolicy.c           | 18 +++++++++++-------
 6 files changed, 36 insertions(+), 34 deletions(-)

-- 
2.39.2

