Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8162C7A8355
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Sep 2023 15:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234869AbjITN1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 09:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235161AbjITN1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 09:27:10 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA1FAE9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:26:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-690d9cda925so805848b3a.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Sep 2023 06:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1695216403; x=1695821203; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Veqgzooa62QmybSGRdTR/S+eXJyNjQh+8DoJnl67H20=;
        b=ipHZ8Z3WL9/25ZW0+MNk9TeR9jY9PL5OAp4V84XHg4ATa/Gnoosw/GPBme6c9Fqo6D
         G0PSRfiSLTg/Xy4sIcmPRj1nbyGi0eR+8SzcbCDnniJHSrOUcBVl3D4prO8p7mORpbUz
         zckcZk3rK1O3fM2OSEMWBwlXQSReckOBeVlChQwcKK9kR8QT1dQj8oLtUMzbcXH2aCzk
         VgnUQjWzJXASaof5gx+RPnydnXM1Gouyg6aXlDizPajes6XEv/hWVaWAvteJbqhalt9I
         7PTHFTe05h8Ko9V2SnyVujMFeZUb1isv1jV2CCNfLuqdAD49vKc9QL2sVX9eHpIT7UH6
         Baeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695216403; x=1695821203;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Veqgzooa62QmybSGRdTR/S+eXJyNjQh+8DoJnl67H20=;
        b=XQE7kmpBTSitd7SNAQ06686xDhpe7dqtst6rrMU0azITBwX8HjuPV81RtsBhFpttrA
         3zvbqLnP054eEQH4P4z4A/vmP2ZCulsoYlIWcRU0jcM4Omx4X5Aggg3IDWI4IiqPpdZr
         YUbWb653klQz9FgNAdoeKZW+41sVJRSIxW+CldiCSr2E9sEpePBd/ccydpihNbyi7D0d
         luOvMFCaKa7bhGmVDkcvDnshdLBNYmM3HL7t6Wx7W9e2/Q4dpr1kV7iQVywQEvrIVbUs
         olGyLl7Mh1RkrGoheUcbhU5wB9PMeM5V7Tucm7w0+yX67EsTIjuc+59tmAdbN9weSQO1
         8rhA==
X-Gm-Message-State: AOJu0YwqcJFB4jczj+L3PaaZaukIVoGAqF+L/BUQJyPYybYk3B/1CQFa
        k8MXay0THM8/s4beb0AJojFlvA==
X-Google-Smtp-Source: AGHT+IGrw8icTYycFan9t9bmh6BiO9zJv2UR1X/P4OTgg4bKeBs1V+XJvf2VfoYF1DZv3yuXFEJ+qA==
X-Received: by 2002:a17:90b:f8b:b0:274:6ab9:9d38 with SMTP id ft11-20020a17090b0f8b00b002746ab99d38mr2489052pjb.36.1695216403079;
        Wed, 20 Sep 2023 06:26:43 -0700 (PDT)
Received: from C02DV8HUMD6R.bytedance.net ([139.177.225.242])
        by smtp.gmail.com with ESMTPSA id cl21-20020a17090af69500b002682392506bsm1333485pjb.50.2023.09.20.06.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Sep 2023 06:26:42 -0700 (PDT)
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
        Jason Xing <kernelxing@tencent.com>,
        Xin Long <lucien.xin@gmail.com>,
        Glauber Costa <glommer@parallels.com>,
        KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujtsu.com>
Cc:     netdev@vger.kernel.org (open list:NETWORKING [GENERAL]),
        linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next 2/2] sock: Fix improper heuristic on raising memory
Date:   Wed, 20 Sep 2023 21:25:41 +0800
Message-Id: <20230920132545.56834-2-wuyun.abel@bytedance.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20230920132545.56834-1-wuyun.abel@bytedance.com>
References: <20230920132545.56834-1-wuyun.abel@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Fix this by skipping this heuristic when under memcg pressure.

Fixes: e1aab161e013 ("socket: initial cgroup code.")
Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
---
 net/core/sock.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 379eb8b65562..ef5cf6250f17 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3093,8 +3093,16 @@ int __sk_mem_raise_allocated(struct sock *sk, int size, int amt, int kind)
 	if (sk_has_memory_pressure(sk)) {
 		u64 alloc;
 
-		if (!sk_under_memory_pressure(sk))
+		if (memcg && mem_cgroup_under_socket_pressure(memcg))
+			goto suppress_allocation;
+
+		if (!sk_under_global_memory_pressure(sk))
 			return 1;
+
+		/* Trying to be fair among all the sockets under the
+		 * protocol's memory pressure, by allowing the ones
+		 * that below average usage to raise.
+		 */
 		alloc = sk_sockets_allocated_read_positive(sk);
 		if (sk_prot_mem_limits(sk, 2) > alloc *
 		    sk_mem_pages(sk->sk_wmem_queued +
-- 
2.37.3

