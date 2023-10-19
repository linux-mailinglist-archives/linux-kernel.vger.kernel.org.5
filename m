Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426357CF7DA
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345508AbjJSMBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjJSMBL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:01:11 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F274312D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:00:46 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1c5c91bec75so55633935ad.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697716846; x=1698321646; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=j1m9BRSdkNRQ5Yt+ICOw8D17wxDsW5CRYVDGGwLbORQ=;
        b=bbQ5RrbxNDWIPvEhnImaGP7g1m1qLa4QiJU8cEt5/7mEvKzmiHZbKbZkh1haueDNRj
         XDjxfHZZbNZkoZhT1RBlP63eexVbqlzYMXkcI86yiNtovwx1uNgDZ34eL9fJWTv00YK1
         vJwuBiXoYA2a4AUz9LrvAWHfZRe81cu9ZLdud7Cfl0P+QhT6eDAcsUT6rdXAuU9IRd6i
         o95s5mLYVidS0A67ITr1VM9tHxI601kzx5uRDwHKoyh+zLpbIl2WDaNjtTmJ0XKQ2GgN
         Pj+0XPZkuprOq7Lwx6IDLTkOjnji48C2qHkyXWkPgbsx13SZOMy9rhVSM9QoWlvvO6D7
         U9oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697716846; x=1698321646;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j1m9BRSdkNRQ5Yt+ICOw8D17wxDsW5CRYVDGGwLbORQ=;
        b=gryLgI89q2+XmMXQPf6YLQnMQOmEmnoMYpeqFMfWbTbQ5rJsaG52yOo9DOsmQPU6kZ
         loCD/1rxsh+YwRlVQ+5aQJ2256VBXzBCNha+FwGNAgE4hPrLo/UQ7+EmxQQyZYShkSJl
         OwP2QlJNRmw14auYUOkczbEoHOEpRpcy8fE9oQjjCF8hAx51QT5CqwGDge4KQrEaemlQ
         tDmChN0J2e2P+gowNoBUFdnxDMYw58JbTolxyKBuCPQomiXMasCADNvy35FYliy6Q3bG
         YzE2arqz13eLgXpca9TxRusTeQjjPHi7bHepc0VBG6UQ/jnM2crIdXfPf0u4Rq6viM68
         1D1Q==
X-Gm-Message-State: AOJu0Yw+Dguw2QDi+7JPQzg1u4f4+tJ1wy5HXw5L0G+UF6jp1bUtMETB
        2flusH1XTsMdl/fTt6mOK2zyWg==
X-Google-Smtp-Source: AGHT+IFCZDxTxqQcz7j1OJ6WLgnP+lN3GXgA5ClkO+DuonBeR+up4aYygLHSL+ZPHEE08hN4lR/9Dw==
X-Received: by 2002:a17:902:fa45:b0:1ca:3c63:d5cc with SMTP id lb5-20020a170902fa4500b001ca3c63d5ccmr1833983plb.49.1697716846435;
        Thu, 19 Oct 2023 05:00:46 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jg9-20020a17090326c900b001c727d3ea6bsm1785646plb.74.2023.10.19.05.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:00:46 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net v3 1/3] sock: Code cleanup on __sk_mem_raise_allocated()
Date:   Thu, 19 Oct 2023 20:00:24 +0800
Message-Id: <20231019120026.42215-1-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
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
index 16584e2dd648..4412c47466a7 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3041,17 +3041,19 @@ EXPORT_SYMBOL(sk_wait_data);
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
@@ -3106,8 +3108,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
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
@@ -3119,8 +3121,8 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 	sk_memory_allocated_sub(sk, amt);
 
-	if (memcg_charge && charged)
-		mem_cgroup_uncharge_skmem(sk->sk_memcg, amt);
+	if (charged)
+		mem_cgroup_uncharge_skmem(memcg, amt);
 
 	return 0;
 }
-- 
2.37.3

