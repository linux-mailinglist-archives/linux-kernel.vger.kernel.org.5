Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33C557CA954
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 15:28:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233440AbjJPN2s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 09:28:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjJPN2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 09:28:47 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBB7BE6
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:28:45 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-5ac88d2cfaaso2108838a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 06:28:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697462925; x=1698067725; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6A4z/4U2K3WzAUzov3bGTmc+BOc6s6K9VnCG1bksGeE=;
        b=iU5vgA0OVfkZ/OHqpoVagiatPtAjNQ5vgTJNVH5VFLIFbndvQMMIWLwMqpiVr+a4yT
         9LeZ+bLuGpHyenxEgmuNOH3f6o9wCT+fNQenj3E0niFsM9yRo63eNMococ44zktbmyOM
         kC6ofiNp2X59kQL9ltJ7IL/t3y0EpDBUUkAUuOV7iZ/yAOAG5SpyLSkUgD6b2qglA8RT
         PU2SguQu+pBw/3B5QaYNolWF0hfLXhsR+TWLl8uCtmd1Zg10JfmryeRMUOlIWP4tOKg+
         HlXNxQVw+rgUBmdwhQgsQ3dioLPxEU8K6HgO+hVEnd1fQFTb4K5r+wPtmhoSYmLqZaUO
         EfnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697462925; x=1698067725;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6A4z/4U2K3WzAUzov3bGTmc+BOc6s6K9VnCG1bksGeE=;
        b=qegpjOunvbVwzA75HOsSK72RY3pRSu6k9hEzif0lVfiCE319pVVnsTWGBxVD7Fkmgq
         PczEVykapEDHW+Bw4XkkBsswYa4JfXSkLcogI8yndATMm75CDsQiJ+sy5ULikeP+At7N
         jAFliB6fwCGzzXb9ASVbXEJiYSOkQOhobuqezcI4/8V4nzyi45pq/6iBgp5o27aWc9hj
         SJTvJPNEXOCBb2olRQghp+F7jLoiLGJsjOq09Qh495eHVZtUUXDE1bWCQS8SVthH4Bwj
         UK8qP4H8DrJt3JVulbArfTM5RdNE6PmYnThurJr6b5DgknS6rp3KQdWw/+W8dVEt15A8
         hGtg==
X-Gm-Message-State: AOJu0Yzipe0KuX0AFaP06ttC4jgelr5eSyYjf312DyTDpsh8FJVRjrnq
        62cTpPL8yjsMKst6lX6zLIIJJQ==
X-Google-Smtp-Source: AGHT+IG/aNFD8yOcB2CiaA9N6pA4YrFoO3SZXheTzPSixLt3q6ZWlan2LBv2aK3gxkV6vP0lWDraQg==
X-Received: by 2002:a05:6a20:3d1b:b0:12e:4d86:c017 with SMTP id y27-20020a056a203d1b00b0012e4d86c017mr41504115pzi.10.1697462925400;
        Mon, 16 Oct 2023 06:28:45 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id l21-20020a170902d35500b001c737950e4dsm8476287plk.2.2023.10.16.06.28.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Oct 2023 06:28:45 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net-next v2 2/3] sock: Doc behaviors for pressure heurisitics
Date:   Mon, 16 Oct 2023 21:28:11 +0800
Message-Id: <20231016132812.63703-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231016132812.63703-1-wuyun.abel@bytedance.com>
References: <20231016132812.63703-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There are now two accounting infrastructures for skmem, while the
heuristics in __sk_mem_raise_allocated() were actually introduced
before memcg was born.

Add some comments to clarify whether they can be applied to both
infrastructures or not.

Suggested-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 43842520db86..9f969e3c2ddf 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3067,7 +3067,14 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (allocated > sk_prot_mem_limits(sk, 2))
 		goto suppress_allocation;
 
-	/* guarantee minimum buffer size under pressure */
+	/* Guarantee minimum buffer size under pressure (either global
+	 * or memcg) to make sure features described in RFC 7323 (TCP
+	 * Extensions for High Performance) work properly.
+	 *
+	 * This rule does NOT stand when exceeds global or memcg's hard
+	 * limit, or else a DoS attack can be taken place by spawning
+	 * lots of sockets whose usage are under minimum buffer size.
+	 */
 	if (kind == SK_MEM_RECV) {
 		if (atomic_read(&sk->sk_rmem_alloc) < sk_get_rmem0(sk, prot))
 			return 1;
@@ -3088,6 +3095,11 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 
 		if (!sk_under_memory_pressure(sk))
 			return 1;
+
+		/* Try to be fair among all the sockets under global
+		 * pressure by allowing the ones that below average
+		 * usage to raise.
+		 */
 		alloc = sk_sockets_allocated_read_positive(sk);
 		if (sk_prot_mem_limits(sk, 2) > alloc *
 		    sk_mem_pages(sk->sk_wmem_queued +
-- 
2.37.3

