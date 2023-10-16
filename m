Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9AB7CA957
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233530AbjJPN3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:29:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjJPN24 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:28:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DE9CAD
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:28:35 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1c9d7a98abbso28934425ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:28:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697462915; x=1698067715; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4aBj7JQ+keXNLTEJI81zHdQbbGhY/4fEWPU2oi6ixMU=;
        b=lXfrO1fsMGC5QLgGqwDORzAfq3rDCA3w7RGXyf2iWe3WmQWfS44Lf+j+p+44eXbyls
         o1R5kvy5gbTf20U9X1yBdcu1Bd8GOAVfAHvVWO9/R98BQRSyJDmED7IUFJnEc5DhvQjL
         nrOOOO+V3jXUJVWnfpMMLKnN/Wdbc+YxaUKl+aGBZfoTWZ61hNyHRoWvdrv63EakqxYC
         X9FZo5jchidkdqa8fl5bUixZE9gaY96K9J866QLg4u6Q0w6RgPmyF5RIyL9V4fhCwKwd
         Kcppcid4aFkRU0kITziw+Z05zPvg5BykAk8c5zwzuo2FQd6ZF18d2OJtQMIBy3kemfaq
         JDSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462915; x=1698067715;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4aBj7JQ+keXNLTEJI81zHdQbbGhY/4fEWPU2oi6ixMU=;
        b=CWxAffGn9HTc1Q8yK8zzL+RAIXDSEr6syOMrdIbhOFZvWgWPgRlZM4ggDwvP94GqDJ
         LxKIj5GuBSCxkfifNylOusG+5JpWV7ocI/Pyw6WvdrnVG2rVrKDap4xpPnumaLrRUBwl
         MEdOXb9xcrVJAAxu+cD3fnonb+6noYR42pWhKA2vKaOhRznmNs+I9+1sy9S/o/RO+qvL
         jRtKojQ8QQazmIC+FbmrANXKp+SCi4BGtV43F7KXBhKfzmb7UMKZS3yrqoHt/daB1II/
         0FHOhCbvVhk32emHYXcPfirRZgyLN/mOfAPfLaLaeA66xd/bybds04p+0jpFm+z8YO2Q
         oJZA==
X-Gm-Message-State: AOJu0Yywu0awrudwcoV5t1PdFiMdisUivGrXgpXE2nZNJXVu0A0P/jZL
        EAG2Kr/uDKx4CdaYGIr3g+2xxA==
X-Google-Smtp-Source: AGHT+IGJ3DtPhfQwjYL4m3gc8AKJVML01Aff6rf6yFGw99xFhjdJoNkI5UMftZbSgs4Sf+513AQsog==
X-Received: by 2002:a17:902:f907:b0:1c9:e6a0:edb6 with SMTP id kw7-20020a170902f90700b001c9e6a0edb6mr7341216plb.2.1697462914871;
        Mon, 16 Oct 2023 06:28:34 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001c737950e4dsm8476287plk.2.2023.10.16.06.28.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:28:34 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net-next v2 1/3] sock: Code cleanup on __sk_mem_raise_allocated()
Date:   Mon, 16 Oct 2023 21:28:10 +0800
Message-Id: <20231016132812.63703-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
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

Code cleanup for both better simplicity and readability.
No functional change intended.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
---
 net/core/sock.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 290165954379..43842520db86 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3039,17 +3039,19 @@ EXPORT_SYMBOL(sk_wait_data);
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
@@ -3104,8 +3106,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
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
@@ -3117,8 +3119,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg_charge && charged)
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
+	if (charged)
+		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
 }
-- 
2.37.3

