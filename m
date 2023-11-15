Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F0F67EBC19
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 04:37:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234369AbjKODhU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 22:37:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234283AbjKODhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 22:37:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9832E4
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:14 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-1cc316ccc38so50096305ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 19:37:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700019434; x=1700624234; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k1w3MQA5hdsK9l0KyxSKj5sO0FY/dE+JlgnB21F6L3s=;
        b=QjFEzJ1CXP09G0m+QTi8HN2flj6uohQa84r9+HpXXIigwiBKC06ZZwiynHr2n6HFES
         z7Thmej+kV3jBcuDfPd0mhzK2nS8WpliRzSt0r2HXJ/Q1+PSMQD+1i45t1K4Yy5kfkyM
         HATr3+pAcSQvxYYSKJRtj9NEeJXYuM7IjbjAxP4EqeIh9pFtRFTc9sdEenX7rs3WVcS/
         z5F+DblA+BsZxxipr7hUnxVcRBxPd5qvvA0eWk3HOOSWaaqjcxOfYgFqdjk+YsoMPdlr
         3PK1EQUin7iQLmS//CCZiSjhj8CxjMe9FyBdViaKbh2dxZkvR+mt38D+dDOZp5Xs3PMx
         8kvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700019434; x=1700624234;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k1w3MQA5hdsK9l0KyxSKj5sO0FY/dE+JlgnB21F6L3s=;
        b=IXDFLb4lK2M4E9gXl3LR69kVNfINlI81Xz0Ehy7X3CD3KioLDaQakerxjD2bhEcXB8
         BCbGz1QOtkll1uCtxU/XzRHANLAJTmXFw/W5tNeTnUMxvDsGth42J73XVRoQ72epuqUv
         5aWHkihHwwQwa2u/rL4ZbsObAtLJUYK+V0EpP4mTYTmE13lfGO4HtlUw/6SYLanPeVLc
         Y2Ykj99uUQWtb8dxP3nsKskjHLtsuBGbHWqkupdWT96QrCg3WDj+JbkJcagI9PqfN90q
         noEwfkvtBxyC1U3/7UDxFrSyH1hkEkTDBVcH3d2sHIuW1v3i8Aa161xy86J2i4yr0JVr
         6PTg==
X-Gm-Message-State: AOJu0YyH0uZAnwTla9bi2eBC0uiGw+DN//QBLFHZTO5btEMSglrzUURb
        qEfBkj1jeBPZV2gvHgD5gQHBSw==
X-Google-Smtp-Source: AGHT+IE0sVP6TLd2E2skJbwoe50KPiWhKHScdSQEsVDNrHL7Z7t6OnzvRE/RMrmNh2PqUAKO536Huw==
X-Received: by 2002:a17:902:b407:b0:1cc:665d:f818 with SMTP id x7-20020a170902b40700b001cc665df818mr3302275plr.68.1700019434150;
        Tue, 14 Nov 2023 19:37:14 -0800 (PST)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.251])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902d35300b001b9da42cd7dsm6419529plk.279.2023.11.14.19.37.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 19:37:13 -0800 (PST)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>
Cc:     Barry Song <21cnbao@gmail.com>,
        Benjamin Segall <bsegall@google.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Mike Galbraith <efault@gmx.de>,
        Qais Yousef <qyousef@layalina.io>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Youssef Esmat <youssefesmat@chromium.org>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH v2 0/4] sched/eevdf: Optimize reweight and pick
Date:   Wed, 15 Nov 2023 11:36:43 +0800
Message-Id: <20231115033647.80785-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1 -> v2:
  - Removed unrelated hunks in 2nd patch.

---------

This patchset makes these contributions:

  [1/4] Fixes the problem that vruntime doesn't get adjusted
        when reweight at !0-lag point.

  [2/4] Optimize out the fallback search on @best_left which
        doubles the cost in worst case.

  [3/4] Enable O(1) fastpath picking based on deadline-sorted
        leftmost-cached rbtree.

  [4/4] Statistics for patch 3, not intended to upstream.

All the benchmarks are done inside a normal cpu cgroup in a clean
environment with cpu turbo disabled, on a Dual-CPU Intel Xeon(R)
Platinum 8260 with 2 NUMA nodes each of which has 24C/48T.

	p0: baseline, tip/master 1187c0b3a6c2
	p1: p0 + patch(1)
	p3: p0 + patch(1~3)

hackbench
=========
case            load    	  p0% (std%)	   p1% ( std%)	   p3% ( std%)
process-pipe    group-1 	 1.00 (  2.49)	 -1.73 (  2.64)	 -3.77 (  0.91)
process-pipe    group-2 	 1.00 (  5.23)	 +5.51 (  2.32)	 -3.41 (  4.28)
process-pipe    group-4 	 1.00 (  5.30)	 +3.53 (  5.46)	 +6.51 (  1.44)
process-pipe    group-8 	 1.00 (  1.36)	 -1.85 (  2.22)	 -3.57 (  1.06)
process-sockets group-1 	 1.00 (  2.29)	 -2.39 (  2.66)	 -2.39 (  1.86)
process-sockets group-2 	 1.00 (  3.46)	 +0.46 (  1.85)	 +1.19 (  2.08)
process-sockets group-4 	 1.00 (  1.43)	 -1.98 (  2.78)	 +4.52 (  8.68)
process-sockets group-8 	 1.00 (  0.95)	 -1.60 (  0.94)	 +2.78 (  2.14)
threads-pipe    group-1 	 1.00 (  1.92)	 +5.33 (  1.54)	 +3.47 (  1.09)
threads-pipe    group-2 	 1.00 (  0.64)	 +0.51 (  2.31)	 +2.91 (  0.43)
threads-pipe    group-4 	 1.00 (  3.03)	 -2.91 (  2.31)	 +1.83 (  1.65)
threads-pipe    group-8 	 1.00 (  2.55)	 +1.89 (  3.04)	 -1.29 (  2.32)
threads-sockets group-1 	 1.00 (  0.71)	 +0.83 (  0.52)	 -0.42 (  0.52)
threads-sockets group-2 	 1.00 (  2.48)	 -2.52 (  1.20)	 -3.27 (  0.59)
threads-sockets group-4 	 1.00 (  1.96)	 +2.67 (  2.34)	 +3.74 (  1.18)
threads-sockets group-8 	 1.00 (  1.09)	 -2.30 (  0.51)	 +3.07 (  0.62)

netperf
=======
case            load    	  p0% (std%)	   p1% ( std%)	   p3% ( std%)
TCP_RR          thread-24	 1.00 (  2.48)	 -2.15 (  2.38)	 +0.17 (  1.95)
TCP_RR          thread-48	 1.00 (  0.73)	 -1.59 (  0.51)	 +0.47 (  0.93)
TCP_RR          thread-72	 1.00 (  1.04)	 -1.26 (  1.03)	 -0.09 (  1.13)
TCP_RR          thread-96	 1.00 ( 29.36)	+70.41 ( 14.86)	+17.88 ( 37.24)
TCP_RR          thread-192	 1.00 ( 28.29)	 -1.30 ( 34.03)	 -2.00 ( 30.63)
TCP_STREAM      thread-24	 1.00 (  1.57)	 +0.38 (  1.90)	 +0.20 (  1.72)
TCP_STREAM      thread-48	 1.00 (  0.08)	 -0.29 (  0.07)	 +0.15 (  0.12)
TCP_STREAM      thread-72	 1.00 (  0.01)	 -0.00 (  0.00)	 +0.00 (  0.00)
TCP_STREAM      thread-96	 1.00 (  0.76)	 +0.16 (  0.65)	 +0.30 (  0.47)
TCP_STREAM      thread-192	 1.00 (  0.65)	 +0.23 (  0.46)	 +0.25 (  0.49)
UDP_RR          thread-24	 1.00 (  1.74)	 -1.26 (  2.41)	 +0.81 (  3.02)
UDP_RR          thread-48	 1.00 (  0.56)	 -0.40 ( 16.72)	 -0.98 (  0.36)
UDP_RR          thread-72	 1.00 (  0.84)	 -0.70 (  0.66)	 -0.27 (  0.88)
UDP_RR          thread-96	 1.00 (  1.24)	 -0.44 (  1.01)	 -0.99 (  8.99)
UDP_RR          thread-192	 1.00 ( 28.02)	 -0.42 ( 31.59)	 -1.80 ( 26.23)
UDP_STREAM      thread-24	 1.00 (100.05)	 +0.31 (100.04)	 +0.32 (100.06)
UDP_STREAM      thread-48	 1.00 (104.35)	 +1.22 (105.14)	 +1.65 (104.10)
UDP_STREAM      thread-72	 1.00 (100.69)	 +1.28 (100.63)	 -0.17 (100.49)
UDP_STREAM      thread-96	 1.00 ( 99.63)	 +0.33 ( 99.51)	 -0.25 ( 99.53)
UDP_STREAM      thread-192	 1.00 (100.57)	 +2.00 (107.01)	 -1.21 ( 99.51)

tbench
======
case            load    	  p0% (std%)	   p1% ( std%)	   p3% ( std%)
loopback        thread-24	 1.00 (  0.49)	 -1.47 (  0.94)	 +0.08 (  0.75)
loopback        thread-48	 1.00 (  0.42)	 -0.04 (  0.53)	 -0.06 (  0.34)
loopback        thread-72	 1.00 (  7.10)	 -3.33 (  2.98)	 -5.06 (  0.31)
loopback        thread-96	 1.00 (  0.80)	 +2.65 (  0.80)	 -0.68 (  1.30)
loopback        thread-192	 1.00 (  1.24)	 +1.21 (  0.73)	 -1.78 (  0.22)

schbench
========
case            load    	  p0% (std%)	   p1% ( std%)	   p3% ( std%)
normal          mthread-1	 1.00 (  5.83)	 -2.83 (  1.46)	 +1.24 (  2.51)
normal          mthread-2	 1.00 (  4.45)	 +8.94 (  7.81)	+14.24 (  7.44)
normal          mthread-4	 1.00 (  2.73)	 +2.53 (  4.31)	+12.44 (  5.99)
normal          mthread-8	 1.00 (  0.15)	 +0.21 (  0.13)	 -0.34 (  0.11)

Seems no obvious complain from these benchmarks.
Comments are appreciated! Thanks!

Abel Wu (4):
  sched/eevdf: Fix vruntime adjustment on reweight
  sched/eevdf: Sort the rbtree by virtual deadline
  sched/eevdf: O(1) fastpath for task selection
  sched/stats: Add statistics for pick_eevdf()

 include/linux/sched.h |   2 +-
 kernel/sched/debug.c  |  11 +-
 kernel/sched/fair.c   | 341 ++++++++++++++++++++++++++----------------
 kernel/sched/sched.h  |   6 +
 kernel/sched/stats.c  |   6 +-
 5 files changed, 233 insertions(+), 133 deletions(-)

-- 
2.37.3

