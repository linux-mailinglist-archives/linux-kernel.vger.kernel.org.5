Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C13766465
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 08:45:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232868AbjG1Gph (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 02:45:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjG1Gpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 02:45:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F4093584
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 23:44:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1690526687;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=yJG1UPV+W/0UsK41TGpTUiZabcu5LPZJZEcbS3oTozs=;
        b=f7y7QBChxzHwZ8FoyFfg07D965W9R2qwlc4Do/xD1UqUZDBO4b2dE2rD2h95FI64QTtS6g
        Rxu0wg102e6eDF2MqXrGwGAGX71dYApBnrYMbPi7C9VX9Yt5hKkHBS/91jD/gnG9kS2iL9
        YX+g335zsHbb/Uvlim10uqvH4Vcbmwk=
Received: from mimecast-mx02.redhat.com (66.187.233.73 [66.187.233.73]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-djpkjzf0OwygasUunYp_lw-1; Fri, 28 Jul 2023 02:44:41 -0400
X-MC-Unique: djpkjzf0OwygasUunYp_lw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E74E129AA3A5;
        Fri, 28 Jul 2023 06:44:39 +0000 (UTC)
Received: from fedora.redhat.com (unknown [10.45.224.157])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 75530F6CDE;
        Fri, 28 Jul 2023 06:44:37 +0000 (UTC)
From:   tglozar@redhat.com
To:     linux-kernel@vger.kernel.org
Cc:     john.fastabend@gmail.com, jakub@cloudflare.com,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, netdev@vger.kernel.org, bpf@vger.kernel.org,
        Tomas Glozar <tglozar@redhat.com>
Subject: [PATCH net] bpf: sockmap: Remove preempt_disable in sock_map_sk_acquire
Date:   Fri, 28 Jul 2023 08:44:11 +0200
Message-ID: <20230728064411.305576-1-tglozar@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tomas Glozar <tglozar@redhat.com>

Disabling preemption in sock_map_sk_acquire conflicts with GFP_ATOMIC
allocation later in sk_psock_init_link on PREEMPT_RT kernels, since
GFP_ATOMIC might sleep on RT (see bpf: Make BPF and PREEMPT_RT co-exist
patchset notes for details).

This causes calling bpf_map_update_elem on BPF_MAP_TYPE_SOCKMAP maps to
BUG (sleeping function called from invalid context) on RT kernels.

preempt_disable was introduced together with lock_sk and rcu_read_lock
in commit 99ba2b5aba24e ("bpf: sockhash, disallow bpf_tcp_close and update
in parallel"), probably to match disabled migration of BPF programs, and
is no longer necessary.

Remove preempt_disable to fix BUG in sock_map_update_common on RT.

Signed-off-by: Tomas Glozar <tglozar@redhat.com>
---
 net/core/sock_map.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/core/sock_map.c b/net/core/sock_map.c
index 19538d628714..08ab108206bf 100644
--- a/net/core/sock_map.c
+++ b/net/core/sock_map.c
@@ -115,7 +115,6 @@ static void sock_map_sk_acquire(struct sock *sk)
 	__acquires(&sk->sk_lock.slock)
 {
 	lock_sock(sk);
-	preempt_disable();
 	rcu_read_lock();
 }
 
@@ -123,7 +122,6 @@ static void sock_map_sk_release(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
 {
 	rcu_read_unlock();
-	preempt_enable();
 	release_sock(sk);
 }
 
-- 
2.39.3

