Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4C3378F883
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 08:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240345AbjIAGYZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 02:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbjIAGYY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 02:24:24 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADD910DE
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:23:49 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-68bec3a1c0fso1365385b3a.1
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 23:23:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1693549429; x=1694154229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1QWm8cF6bkJper87bKNGM7pspfj+5pss/cTqDVG6VeI=;
        b=SOZP6WgZizKxmYJg0e9ezIKS43qkcAs9AhAdACPslq8Sm+S0pZBj7P43BuugesILLP
         8A+n7xL5kmTRh979Ao0yh+w0vAyhW3VbOUdDMxM63IwmctbCqUU3jp3gp0HIo+elmZUT
         e+9wHU6fo/PGXYqn6kkkpaqG6rm6yMm4JsvcYgc75z1h6b1uS5Q5LLKju/T8dpS8Y3Yj
         zYTDfrMrN+5xSTjv9bmvC4ri4OH5pDELD8u1jaJENurCarE57ZWbAFrRcbioOMZLzSOf
         hFVfY3lPHGcYTTqOyDO87+5w59ME7vyJT5o1mnEnyD1UX/2fvNOLpLuxgrKEkUuYcdX4
         AFSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693549429; x=1694154229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1QWm8cF6bkJper87bKNGM7pspfj+5pss/cTqDVG6VeI=;
        b=WA8KNfmYEjaPOUx3WfvtEMbUgE8iPcmbjr5FoNJy8X2VxaJcrOOPehMXILQOFeceJF
         BiDg3tqKm8CJTD6MvfLBISKkB3slaPPnI2/jJD6Ow69aZ6JzCNB3JVI5QnTrevlTqefi
         XpdDxx3l5DG59oPv1lD1zA2Twig+9FSbfg7T1SDi+xV8aEx6zsg3sAbNoHtLTAenjDFx
         sKj7mh+egOZC5HZhhKrn3knl9OeRc4KFw6dxAGGNH8KuCmsRQV862RCHQIqi8100CBom
         XOXh4In6YDlaGlx2K2Jhfgsl7kDY4yzWaU+IeF0fuAc4mHiESikYDcGP4GLCJueysUPi
         H85Q==
X-Gm-Message-State: AOJu0YxN5ITKbpeSjVXTTOygBEsO1Eq8GKMlxdlXnZtlFY+62qOWS3Ib
        fp31CB+TXrbet/Rv4rM90dHRyw==
X-Google-Smtp-Source: AGHT+IH317txsPuj8MBF7exknVZRvNNzVT02jeLJY4AHeJlruKWwnuwX34akxA/Zq54dUriHM27EIg==
X-Received: by 2002:a05:6a20:1019:b0:148:1e47:345e with SMTP id gs25-20020a056a20101900b001481e47345emr1722651pzc.49.1693549428921;
        Thu, 31 Aug 2023 23:23:48 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id fm19-20020a056a002f9300b0068c1ac1784csm2223265pfb.59.2023.08.31.23.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Aug 2023 23:23:48 -0700 (PDT)
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
        Abel Wu <wuyun.abel@bytedance.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Martin KaFai Lau <martin.lau@kernel.org>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>
Cc:     linux-kernel@vger.kernel.org (open list),
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-mm@kvack.org (open list:MEMORY MANAGEMENT)
Subject: [RFC PATCH net-next 1/3] sock: Code cleanup on __sk_mem_raise_allocated()
Date:   Fri,  1 Sep 2023 14:21:26 +0800
Message-Id: <20230901062141.51972-2-wuyun.abel@bytedance.com>
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

Code cleanup for both better simplicity and readability.
No functional change intended.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 666a17cab4f5..af778fc60a4d 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3040,17 +3040,19 @@ EXPORT_SYMBOL(sk_wait_data);
  */
 int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 {
-	bool memcg_charge = mem_cgroup_sockets_enabled && sk->sk_memcg;
+	struct mem_cgroup *memcg = mem_cgroup_sockets_enabled ? sk->sk_memcg : NULL;
 	struct proto *prot = sk->sk_prot;
-	bool charged = true;
+	bool charged = false;
 	long allocated;
 
 	sk_memory_allocated_add(sk, amt);
 	allocated = sk_memory_allocated(sk);
-	if (memcg_charge &&
-	    !(charged = mem_cgroup_charge_skmem(sk->sk_memcg, amt,
-						gfp_memcg_charge())))
-		goto suppress_allocation;
+
+	if (memcg) {
+		if (!mem_cgroup_charge_skmem(memcg, amt, gfp_memcg_charge()))
+			goto suppress_allocation;
+		charged = true;
+	}
 
 	/* Under limit. */
 	if (allocated <= sk_prot_mem_limits(sk, 0)) {
@@ -3105,8 +3107,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 		 */
 		if (sk->sk_wmem_queued + size >= sk->sk_sndbuf) {
 			/* Force charge with __GFP_NOFAIL */
-			if (memcg_charge && !charged) {
-				mem_cgroup_charge_skmem(sk->sk_memcg, amt,
+			if (memcg && !charged) {
+				mem_cgroup_charge_skmem(memcg, amt,
 					gfp_memcg_charge() | __GFP_NOFAIL);
 			}
 			return 1;
@@ -3118,8 +3120,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg_charge && charged)
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
+	if (charged)
+		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
 }
-- 
2.37.3

