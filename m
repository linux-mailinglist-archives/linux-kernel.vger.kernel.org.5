Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C43F578F884
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242999AbjIAGYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348378AbjIAGY3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:24:29 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C61EB10DE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:24:25 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a76d882080so1054621b6e.2
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693549465; x=1694154265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0JmFLfbSmI2emm6GyT4GHqCHxeUZuXTxsBg8j/3SD1Q=;
        b=M+JzKAxoPzaHoS87WH5g/IlymD9kDxDx6KCWiAHQZzHwp3O+oN4LY2naV7+aEm0/NJ
         K0Ajoq0vtWTaefi1Ac9EGiPVRzmRcT6LS37bl3piwSzT5t9yHa6tMUY4ZIQ0K3NA7+oA
         0jqAh3ZPgpN3ilEEZENP5uw8eAG3xJKiaYG2nBdhQwU3ojp1vyvll/Dta1JsTp3CCqau
         oIantc7EhD/pDg+UlXD9qHSMLj3ICsihdvfEZxLSM1HtTFcnBZ0mEMfysc0z5juIe22P
         5GpmdcvWEzQSWJoSz0Z9sUQh1EgfyZmpUISm3mkBMUXhlKQ3y5B1xnbUeXPp+Ae+6tHf
         Y/eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693549465; x=1694154265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0JmFLfbSmI2emm6GyT4GHqCHxeUZuXTxsBg8j/3SD1Q=;
        b=eKgTAcDI74EKNk0OBMmX6DPqsyIzqbLaIodYu/T7ShNzUtEDIb5q2U9a7APxfqeVa8
         PRUSpJbpwzeTqGrmOnDy0E7csSfHmaqVF30l96EXgJzzPWTzyFaW6iTX3hGiXRTLlcc4
         HJmUY945xKCj3W/ScxrSnqaZ/2MWQwohE3bGuJac6JdzP1+Ey+MQEYY3devcYgoIJdwv
         pimDQt1LlzLCuRWiQDpsm48/mdz99gmk8FTFYiMAqMta+wilNOJ0xM/FCFeEDJND/c76
         J7tN1cT0fveXjqBWgzGhYZG72wxNThdf0Npz3dlLjZhk7lRfHe8b3UGCaxZCuxU1kwOf
         j6bw==
X-Gm-Message-State: AOJu0YxYZj4fTSl/jPE5Zq+FUHxGOOqh9ByXYa0oTN/jQk5zmiJDUc7K
        bQEQdwOmMVQ5H8EAfrERmSDxHzKkrpYim6uPv84=
X-Google-Smtp-Source: AGHT+IFA+ZQPRlE/tLVc4UK8tlm+PIJyTz7163uxOg1QtvjOk/HKCDfhxw5xWkpOivUFycx5AMQukQ==
X-Received: by 2002:aca:2b16:0:b0:3a3:eab8:8c40 with SMTP id i22-20020aca2b16000000b003a3eab88c40mr1685121oik.54.1693549465089;
        Thu, 31 Aug 2023 23:24:25 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fm19-20020a056a002f9300b0068c1ac1784csm2223265pfb.59.2023.08.31.23.24.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 23:24:24 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Yosry Ahmed <yosryahmed@google.com>,
        Yu Zhao <yuzhao@google.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [RFC PATCH net-next 3/3] sock: Throttle pressure-aware sockets under pressure
Date:   Fri,  1 Sep 2023 14:21:28 +0800
Message-Id: <20230901062141.51972-4-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230901062141.51972-1-wuyun.abel@bytedance.com>
References: <20230901062141.51972-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A socket is pressure-aware when its protocol has pressure defined, that
is sk_has_memory_pressure(sk) != NULL, e.g. TCP. These protocols might
want to limit the usage of socket memory depending on both the state of
global & memcg pressure through sk_under_memory_pressure(sk).

While for allocation, memcg pressure will be simply ignored when usage
is under global limit (sysctl_mem[0]). This behavior has different impacts
on different cgroup modes. In cgroupv2 socket and other purposes share a
same memory limit, thus allowing sockmem to burst under memcg reclaiming
pressure could lead to longer stall, sometimes even OOM. While cgroupv1
has no such worries.

As a cloud service provider, we encountered a problem in our production
environment during the transition from cgroup v1 to v2 (partly due to the
heavy taxes of accounting socket memory in v1). Say one workload behaves
fine in cgroupv1 with memcg limit configured to 10GB memory and another
1GB tcpmem, but will suck (or even be OOM-killed) in v2 with 11GB memory
due to burst memory usage on socket, since there is no specific limit for
socket memory in cgroupv2 and relies largely on workloads doing traffic
control themselves.

It's rational for the workloads to build some traffic control to better
utilize the resources they bought, but from kernel's point of view it's
also reasonable to suppress the allocation of socket memory once there is
a shortage of free memory, given that performance degradation is better
than failure.

As per the above, this patch aims to be more conservative on allocation
for the pressure-aware sockets under global and/or memcg pressure. While
OTOH throttling on incoming traffic could hurt latency badly possibly
due to SACKed segs get dropped from the OFO queue. See a related commit
720ca52bcef22 ("net-memcg: avoid stalls when under memory pressure").
This patch preserves this decision by throttling RX allocation only at
critical pressure level when it hardly makes sense to continue receive
data.

No functional change intended for pressure-unaware protocols.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 29 +++++++++++++++++++++++++++--
 1 file changed, 27 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index af778fc60a4d..6c1d13547f1b 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3041,6 +3041,7 @@ EXPORT_SYMBOL(sk_wait_data);
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
 	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
+	bool under_memcg_pressure = false;
 	struct proto *prot = sk->sk_prot;
 	bool charged = false;
 	long allocated;
@@ -3051,13 +3052,25 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (memcg) {
 		if (!mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge()))
 			goto suppress_allocation;
+
+		/* Get pressure info from net-memcg. But consider the memcg
+		 * to be under pressure for incoming traffic iff at 'critical'
+		 * level, see commit 720ca52bcef22 ("net-memcg: avoid stalls
+		 * when under memory pressure").
+		 */
+		if (sk_has_memory_pressure(sk) &&
+		    mem_cgroup_under_socket_pressure(memcg, &under_memcg_pressure) &&
+		    !in_softirq())
+			under_memcg_pressure = true;
+
 		charged = true;
 	}
 
 	/* Under limit. */
 	if (allocated <= sk_prot_mem_limits(sk, 0)) {
 		sk_leave_memory_pressure(sk);
-		return 1;
+		if (!under_memcg_pressure)
+			return 1;
 	}
 
 	/* Under pressure. */
@@ -3087,8 +3100,20 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (sk_has_memory_pressure(sk)) {
 		u64 alloc;
 
-		if (!sk_under_memory_pressure(sk))
+		/* Be more conservative if the socket's memcg (or its
+		 * parents) is under reclaim pressure, try to possibly
+		 * avoid further memstall.
+		 */
+		if (under_memcg_pressure)
+			goto suppress_allocation;
+
+		if (!sk_under_global_memory_pressure(sk))
 			return 1;
+
+		/* Trying to be fair among all the sockets of same
+		 * protocal under global memory pressure, by allowing
+		 * the ones that under average usage to raise.
+		 */
 		alloc = sk_sockets_allocated_read_positive(sk);
 		if (sk_prot_mem_limits(sk, 2) > alloc *
 		    sk_mem_pages(sk->sk_wmem_queued +
-- 
2.37.3

