Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2A5A783FB6
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:39:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235299AbjHVLi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:38:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235243AbjHVLiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:38:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D42C5CEE;
        Tue, 22 Aug 2023 04:38:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 011E165278;
        Tue, 22 Aug 2023 11:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51A95C433CA;
        Tue, 22 Aug 2023 11:31:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692703906;
        bh=SiKCfSBdSn0F4olYLmX4Ou6EXrCr7uZp9QM14TXQc6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ctbKqG0icGU9xFrQFiIWNKsGlr9AkRLT3MF2sc8h3H8dswrAqv4kN0sTZQY2d4aSS
         svnKGP2PNxCyLIPJ8Ctd2Rl7x7xjCwjqD+PeZNsedSlgS32Pu6MWD0talWmBFw5FtS
         lUGzcWfW0yPzWTTNPk/ARjZyxrq4By1Gwm4wtaZxEFUzw6pJuKtMB4AadadsfB0dz7
         pXVGjkbA0MIRqfQ8xWR1FP/+6LGcEJRCmF0M/NFqo3Dr1UKv7G/OSnCj18+XyGReY7
         sx8RnVD6i6nKBU+Wn6Vcx82una1qb+03H2XLIdyc3Zsv6OMIGOVu8r9HIFuLZtHN99
         wFEKd/+3P0Cmg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Eric Dumazet <edumazet@google.com>,
        "David S . Miller" <davem@davemloft.net>,
        Sasha Levin <sashal@kernel.org>, kuba@kernel.org,
        pabeni@redhat.com, jhs@mojatatu.com, xiyou.wangcong@gmail.com,
        jiri@resnulli.us, kuniyu@amazon.com, martin.lau@kernel.org,
        leitao@debian.org, alexander@mihalicyn.com, dhowells@redhat.com,
        kernelxing@tencent.com, netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 6/9] net: annotate data-races around sk->sk_{rcv|snd}timeo
Date:   Tue, 22 Aug 2023 07:31:27 -0400
Message-Id: <20230822113130.3550050-6-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230822113130.3550050-1-sashal@kernel.org>
References: <20230822113130.3550050-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.46
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Eric Dumazet <edumazet@google.com>

[ Upstream commit 285975dd674258ccb33e77a1803e8f2015e67105 ]

sk_getsockopt() runs without locks, we must add annotations
to sk->sk_rcvtimeo and sk->sk_sndtimeo.

In the future we might allow fetching these fields before
we lock the socket in TCP fast path.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c     | 24 ++++++++++++++----------
 net/sched/em_meta.c |  4 ++--
 2 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 3b5304f084ef3..a0d3313883c8f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -425,6 +425,7 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 {
 	struct __kernel_sock_timeval tv;
 	int err = sock_copy_user_timeval(&tv, optval, optlen, old_timeval);
+	long val;
 
 	if (err)
 		return err;
@@ -435,7 +436,7 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 	if (tv.tv_sec < 0) {
 		static int warned __read_mostly;
 
-		*timeo_p = 0;
+		WRITE_ONCE(*timeo_p, 0);
 		if (warned < 10 && net_ratelimit()) {
 			warned++;
 			pr_info("%s: `%s' (pid %d) tries to set negative timeout\n",
@@ -443,11 +444,12 @@ static int sock_set_timeout(long *timeo_p, sockptr_t optval, int optlen,
 		}
 		return 0;
 	}
-	*timeo_p = MAX_SCHEDULE_TIMEOUT;
-	if (tv.tv_sec == 0 && tv.tv_usec == 0)
-		return 0;
-	if (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1))
-		*timeo_p = tv.tv_sec * HZ + DIV_ROUND_UP((unsigned long)tv.tv_usec, USEC_PER_SEC / HZ);
+	val = MAX_SCHEDULE_TIMEOUT;
+	if ((tv.tv_sec || tv.tv_usec) &&
+	    (tv.tv_sec < (MAX_SCHEDULE_TIMEOUT / HZ - 1)))
+		val = tv.tv_sec * HZ + DIV_ROUND_UP((unsigned long)tv.tv_usec,
+						    USEC_PER_SEC / HZ);
+	WRITE_ONCE(*timeo_p, val);
 	return 0;
 }
 
@@ -809,9 +811,9 @@ void sock_set_sndtimeo(struct sock *sk, s64 secs)
 {
 	lock_sock(sk);
 	if (secs && secs < MAX_SCHEDULE_TIMEOUT / HZ - 1)
-		sk->sk_sndtimeo = secs * HZ;
+		WRITE_ONCE(sk->sk_sndtimeo, secs * HZ);
 	else
-		sk->sk_sndtimeo = MAX_SCHEDULE_TIMEOUT;
+		WRITE_ONCE(sk->sk_sndtimeo, MAX_SCHEDULE_TIMEOUT);
 	release_sock(sk);
 }
 EXPORT_SYMBOL(sock_set_sndtimeo);
@@ -1708,12 +1710,14 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 
 	case SO_RCVTIMEO_OLD:
 	case SO_RCVTIMEO_NEW:
-		lv = sock_get_timeout(sk->sk_rcvtimeo, &v, SO_RCVTIMEO_OLD == optname);
+		lv = sock_get_timeout(READ_ONCE(sk->sk_rcvtimeo), &v,
+				      SO_RCVTIMEO_OLD == optname);
 		break;
 
 	case SO_SNDTIMEO_OLD:
 	case SO_SNDTIMEO_NEW:
-		lv = sock_get_timeout(sk->sk_sndtimeo, &v, SO_SNDTIMEO_OLD == optname);
+		lv = sock_get_timeout(READ_ONCE(sk->sk_sndtimeo), &v,
+				      SO_SNDTIMEO_OLD == optname);
 		break;
 
 	case SO_RCVLOWAT:
diff --git a/net/sched/em_meta.c b/net/sched/em_meta.c
index 49bae3d5006b0..b1f1b49d35edf 100644
--- a/net/sched/em_meta.c
+++ b/net/sched/em_meta.c
@@ -568,7 +568,7 @@ META_COLLECTOR(int_sk_rcvtimeo)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_rcvtimeo / HZ;
+	dst->value = READ_ONCE(sk->sk_rcvtimeo) / HZ;
 }
 
 META_COLLECTOR(int_sk_sndtimeo)
@@ -579,7 +579,7 @@ META_COLLECTOR(int_sk_sndtimeo)
 		*err = -1;
 		return;
 	}
-	dst->value = sk->sk_sndtimeo / HZ;
+	dst->value = READ_ONCE(sk->sk_sndtimeo) / HZ;
 }
 
 META_COLLECTOR(int_sk_sendmsg_off)
-- 
2.40.1

