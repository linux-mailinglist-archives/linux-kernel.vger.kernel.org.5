Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E27B7A8350
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235445AbjITN0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234828AbjITN0c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:26:32 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 250F1C9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:26:26 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-274b45fa7a2so2728785a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695216385; x=1695821185; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=K7fATTHDXaSbrRIpLorovNCmSIYGeGmL1yYhxtiI0B0=;
        b=MSpk4amk80rD0H6FEEHwV4QPMuPeOBPlkYea6I3fwe10AW0UiEPWNXTkZxfon31eKj
         OlJtk8iPTmI+T8V9kUpURZ5lk1g9/kOTdomH1evIlcDRGqlljLBwZ05yrJQ8QYF8EHo3
         ogruTI+jw8/AuNQPSG3K57+FIiefCgvoRYijnwxL5btcp8ZYTtToTY2N9w6oxqIo7dyA
         TOr0Bq2/BiGQKlIEAzr3GtOTjYRdu+lAPSh3Y8Ew7XBsg8rf1lbcuX0lwkhKAzI63OPi
         IrqSfTXKSaEZOKYDqAD/pmFxFXPMPcSHG5cIVeJFHbHy/EEo8EKmwM2IsLGVTMo4rnFf
         fqlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216385; x=1695821185;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=K7fATTHDXaSbrRIpLorovNCmSIYGeGmL1yYhxtiI0B0=;
        b=vvby7P3jbjDsFfbKUGIxKuyRPLsoUy8MBJ1O2lmZ4JCuGEZGsH/zYkJGJVnrgiIXOJ
         QNm/eonL13g+GEHTfVcNh6I3ayKqqDG2PM+n5sSPSB105isuPAusCNtez/5XvtUJ1mdc
         ZmXFY0RYB8tM0VTi2owi0YNCIKmEi/dRLlhNFs2mlYSoa7NJxQJphbG5fJ/Djczryo5q
         d459OpL0097tOrQXzq81cKcr5bTbtX/iGDQ/s/9/pkK9xRz3B4xiAXAakRULjHyVBOJq
         kRJO7cNMi/3bJhQnO1gxEfTewp498IDFNMQL1laPTrNzXyovZC3x3dG+2H1IN8iXQA+F
         tWBw==
X-Gm-Message-State: AOJu0YxflC4rwFLbJUfoo3J12VrLXVD1sb9YTiF4m6djUPNs6BH/2KYQ
        jfCoLxlSfm3LB9zmOIL9cP/gYw==
X-Google-Smtp-Source: AGHT+IH7v4KQGYSssF5a4RuDaZXId9Eq3e5lpP2ba8bd//NMDSQFiu87b6arf46Rb3ZtsqzcjruT2A==
X-Received: by 2002:a17:90a:fa08:b0:273:e64c:f22e with SMTP id cm8-20020a17090afa0800b00273e64cf22emr2329685pjb.29.1695216385452;
        Wed, 20 Sep 2023 06:26:25 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id cl21-20020a17090af69500b002682392506bsm1333485pjb.50.2023.09.20.06.26.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:26:25 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     Shakeel Butt <shakeelb@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Kuniyuki Iwashima <kuniyu@amazon.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Breno Leitao <leitao@debian.org>,
        Alexander Mikhalitsyn <alexander@mihalicyn.com>,
        David Howells <dhowells@redhat.com>,
        Jason Xing <kernelxing@tencent.com>
Cc:     Glauber Costa <glommer@parallels.com>,
        Xin Long <lucien.xin@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 1/2] sock: Code cleanup on __sk_mem_raise_allocated()
Date:   Wed, 20 Sep 2023 21:25:40 +0800
Message-Id: <20230920132545.56834-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
index a5995750c5c5..379eb8b65562 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3046,17 +3046,19 @@ EXPORT_SYMBOL(sk_wait_data);
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
@@ -3111,8 +3113,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
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
@@ -3124,8 +3126,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg_charge && charged)
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
+	if (charged)
+		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
 }
-- 
2.37.3

