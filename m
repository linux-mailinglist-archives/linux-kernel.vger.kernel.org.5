Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C50C7CF7D6
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:01:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345479AbjJSMBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235309AbjJSMA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:00:57 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1F4A3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:00:54 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b709048d8eso4493637b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1697716854; x=1698321654; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rkvXWDkzUdqkRQ+D3sDYU4OvGGZLi1kyLlJlX/MPCKc=;
        b=ICciGBf5r9JZGnS2VRdr67YntpMrbbQZFCvDQFj++1wwui82x6N7cop+vhyKLrX3SS
         G8r+oGcoZGB6kkwMA76NnVTh3V47wgkROcLDOyojU9SbeTUNecRT8RdBxFzJW9o0DiSQ
         YcQcUnzfDPCIR2hTVSy7wb9sIT8th7aTOS62Cvm6IqbIdR49He9cOZpPA5xVbRbmgxId
         gE/d/k6KY1pGXdLbvregAbe6O4WqyebGQFjx/neRlhERcTujD1ipKMqd2UFyXX8dFYmW
         rFlrDQTtZ8GqLp70BdbBjiyxNPQ3Na1YGYacPFnb6qVFXen7AsRBzYbJGWR9CGf7qx4/
         o8SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697716854; x=1698321654;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rkvXWDkzUdqkRQ+D3sDYU4OvGGZLi1kyLlJlX/MPCKc=;
        b=lMKVUjFw2PxOUBo7kWKoKhtWNHSQgx6sclEPmZqLssNWiSMelHnN1o7By3KLkP6BFC
         sWGT+SMNKQvixrF9Ge9ID7TAdlp8zKc/agk/xj5SpjmMyyxbL57D3yyioDkOJMPJrF6E
         m9mLAZ1wX+NmDwFyPQlnLA50xrwZxLXbGncOM7p/Kw7ZcbX7fQ5kDrft1BGnpk0OY3hI
         6msMLb7Layb0i5G4SaCvxIFtNujsdrt2quSqjoUQcaanUa7Q7iZp2pL1Begq2Eu65pxy
         NFdUvu253rpmDU6fHfWNNqoWQaA8gB2v/kUisKz6gPKoXdCS0hO+pCNdPyZz0tATvPfJ
         twSQ==
X-Gm-Message-State: AOJu0Yyby95zUT0Hfqicnwmp6/ak6D7WyH2BbqNfnTkNWV90guo27/x3
        AGUe6bpp0x32RZSy9LDuce/lzw==
X-Google-Smtp-Source: AGHT+IHvyW0QSlMwAWAA0xidP7Zv3fC3Zs9hQWuI1QW0RwfCBEES+98tXPWRsWP1awV9zWwmh3MYTw==
X-Received: by 2002:a05:6a21:1509:b0:13d:1d14:6693 with SMTP id nq9-20020a056a21150900b0013d1d146693mr1867657pzb.45.1697716854436;
        Thu, 19 Oct 2023 05:00:54 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id jg9-20020a17090326c900b001c727d3ea6bsm1785646plb.74.2023.10.19.05.00.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Oct 2023 05:00:54 -0700 (PDT)
From:   Abel Wu <wuyun.abel@bytedance.com>
To:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Shakeel Butt <shakeelb@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Abel Wu <wuyun.abel@bytedance.com>
Subject: [PATCH net v3 3/3] sock: Ignore memcg pressure heuristics when raising allocated
Date:   Thu, 19 Oct 2023 20:00:26 +0800
Message-Id: <20231019120026.42215-3-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20231019120026.42215-1-wuyun.abel@bytedance.com>
References: <20231019120026.42215-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
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
So revert that behavior.

After reverting, __sk_mem_raise_allocated() no longer considers
memcg's pressure. As memcgs are isolated from each other w.r.t.
memory accounting, consuming one's budget won't affect others.
So except the places where buffer sizes are needed to be tuned,
allow workloads to use the memory they are provisioned.

Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
Acked-by: Shakeel Butt <shakeelb@google.com>
Acked-by: Paolo Abeni <pabeni@redhat.com>
---
 net/core/sock.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 45841a5689b6..0ec3f5d70715 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3037,7 +3037,13 @@ EXPORT_SYMBOL(sk_wait_data);
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
@@ -3095,7 +3101,11 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
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

