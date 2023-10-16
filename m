Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E9E77CA95D
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbjJPN3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbjJPN3P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:29:15 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2FD7E6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:28:54 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9e072472bso25722375ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:28:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697462934; x=1698067734; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W5edFP5IbqRycra4JwAwr7sw7tdQ8rYxAUGEg4gbH5I=;
        b=dstMeNX/S/U6Zd5Z5IPb0P7sTdufE7lqsNm4s0QGvorWjKRX+UM52EXsnpN2UGO/b3
         LlSHHASLlXtv8pxbvajKcPypiKB6305coJDK69Ijde8n4H8TpM+Dx5SY7J3MHCWtZeeP
         40y4+KDWwCQ/+5TMdHkGjAc6BBWjKnKT7MnGU9GLBvLtFjJP453yt8iNF9VgJiJGdTUR
         IrLc1ACoH8gvqsUID+DU9u1ZY73dUmSwPA+qf1mThnFJTdRwI68wn/7hUJiBaGpEOLQm
         wuBqSYziHI6U/cn6sXobsz/ktXu29X8MviMMhN2VzDflqFmLF+0M6d4NgFPdl52R6dw+
         i3KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462934; x=1698067734;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W5edFP5IbqRycra4JwAwr7sw7tdQ8rYxAUGEg4gbH5I=;
        b=LtWKyKjfk1IrG7WiSkAhMomr1CwKUKmJpLlMoD1M/8LauBmf5/zj0/JIhoXsm7PFqd
         4Y2TSREwbhS40mJuEInvjHPrDLw5vw5Crs7E12kIV3Na8Ml2IkcKKsrl3Rt0RJgV6HKH
         bDjwfSNNg9hkQ14OMfO7YiriYblt1oeiYq3WSP6Y7nZYTUNDn3jKjHJpYCsa8HHPFc4i
         k1v5WOY7wsltle0VFvlFzjCUY9OzgAgJJfkb/u3E9rr7DYsmiQzzojITHjvv/EfeqK7W
         oeb2Dcfr6MFXkh5sTUonmSTDwhHSnLiuv1YYxO2GoZeIO0YgJVnJDnAb8qwx5QGpqK8+
         89DA==
X-Gm-Message-State: AOJu0YwPT6ZVHN1QfMkem0lJZbn4D46m+C9r/d49ID9hIUf+brhCN8D0
        KMiABUG8Ov13a14T8Qodvw4rJ/sd3PGlcUO+JXs=
X-Google-Smtp-Source: AGHT+IH0QjFU/M3nL9sQ7GpGqT0tk+CeTm1zv1UcyqYWSvsDzutF7dTumssneT1g+Jcbaao72hKBCQ==
X-Received: by 2002:a17:902:c94f:b0:1c3:8464:cabd with SMTP id i15-20020a170902c94f00b001c38464cabdmr36959730pla.12.1697462934153;
        Mon, 16 Oct 2023 06:28:54 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001c737950e4dsm8476287plk.2.2023.10.16.06.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:28:53 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net-next v2 3/3] sock: Fix improper heuristic on raising memory
Date:   Mon, 16 Oct 2023 21:28:12 +0800
Message-Id: <20231016132812.63703-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231016132812.63703-1-wuyun.abel@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Before sockets became aware of net-memcg's memory pressure since
commit e1aab161e013 ("socket: initial cgroup code."), the memory
usage would be granted to raise if below average even when under
protocol's pressure. This provides fairness among the sockets of
same protocol.

That commit changes this because the heuristic will also be
effective when only memcg is under pressure which makes no sense.
Fix this by reverting to the behavior before that commit.

After this fix, __sk_mem_raise_allocated() no longer considers
memcg's pressure. As memcgs are isolated from each other w.r.t.
memory accounting, consuming one's budget won't affect others.
So except the places where buffer sizes are needed to be tuned,
allow workloads to use the memory they are provisioned.

Fixes: e1aab161e013 ("socket: initial cgroup code.")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
v2:
  - Ignore memcg pressure when raising memory allocated.
---
 net/core/sock.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 9f969e3c2ddf..1d28e3e87970 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3035,7 +3035,13 @@ EXPORT_SYMBOL(sk_wait_data);
  *	@amt: pages to allocate
  *	@kind: allocation type
  *
- *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc
+ *	Similar to __sk_mem_schedule(), but does not update sk_forward_alloc.
+ *
+ *	Unlike the globally shared limits among the sockets under same protocol,
+ *	consuming the budget of a memcg won't have direct effect on other ones.
+ *	So be optimistic about memcg's tolerance, and leave the callers to decide
+ *	whether or not to raise allocated through sk_under_memory_pressure() or
+ *	its variants.
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
@@ -3093,7 +3099,11 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (sk_has_memory_pressure(sk)) {
 		u64 alloc;
 
-		if (!sk_under_memory_pressure(sk))
+		/* The following 'average' heuristic is within the
+		 * scope of global accounting, so it only makes
+		 * sense for global memory pressure.
+		 */
+		if (!sk_under_global_memory_pressure(sk))
 			return 1;
 
 		/* Try to be fair among all the sockets under global
-- 
2.37.3

