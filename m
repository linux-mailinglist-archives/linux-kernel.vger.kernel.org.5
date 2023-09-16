Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B0357A2F5B
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239145AbjIPKy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239105AbjIPKyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:54:05 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DAB4CF6
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:53:58 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-501bd6f7d11so4851080e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:53:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694861636; x=1695466436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvXzRr88SnSDxxsAv4ZSTVo/5hnYCAUN9lBO/XCA5NQ=;
        b=3mj1dia69biC8hCu6gCSNb53w7F3pc3kCQsrgESRohZ53KDudZPCrx4PfA9z2VMlv3
         e2A7cQVZhd0O0CIn3zqo4mG/4+VTIB3g9bP53TpSdmQM5IOba58Ls44657BglGhzVApn
         3e6mKzHbcY82Pezz4R+4Uao+7P7yk6RIzEcfiHPpdYRzeWiwZM7yiurBVva+8DEdhhLs
         rVZL+nDtWRhIupBcC6YGKWdaDLqi3+G2utxRAz/bwOVByDN2lRlHJ+G+cIKkKv9ezlCv
         0Na2iBjYqcNr4fQlfDikYMZPoRlnw3DBlT5OlO3gZxRKOwP5MvFBdm3Gltvq+e4BC2mX
         4GUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694861636; x=1695466436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UvXzRr88SnSDxxsAv4ZSTVo/5hnYCAUN9lBO/XCA5NQ=;
        b=qrB0LD/lIuS67VZrZN/U8oA8kiaF4MvoCrG4oMOA24VeauVSTJZnXURLBS+/EUqRa1
         BSzdinM8j4GExulpzLt7tALHqMejMsvyzHRIxLZ7K9NFJ70LKZumPl/RtODII5D2L72W
         nPfYeELw0VIxz2BELM2H24Ct4kEUx33lG4etWCyk6H/Kr4sZOAVvjcLfxV7iMH5fJ6UI
         XJguHoxAPQHrFQxk4tEPwVNeegWHASg+BULqt7bLZRSUk09sugEbN9S9mSkVyKXaj7Lq
         6/id01+JdpK+aNxWimvGEYQggafOCYMin5Xn+RStDPu/dq4fRCtl2a2NbcYN1gHkjfMo
         cbGg==
X-Gm-Message-State: AOJu0Yy51IzRm/m/wFs9gSO4sC7uR+yoGN27XNp1BTVknzgqAhMs0cBC
        JljuAqGdk/q3awmKqxrydQIw8kLqnX+piuLQimzmNni/
X-Google-Smtp-Source: AGHT+IHtX5K9ta5qbhSPuwwilwWoJTuhSxV4JuGUo8+ZCkJwFKR7S7akQYR8J9f36ryoXsEa9vW34Q==
X-Received: by 2002:a19:6715:0:b0:502:e2be:54b5 with SMTP id b21-20020a196715000000b00502e2be54b5mr3268108lfc.17.1694861636296;
        Sat, 16 Sep 2023 03:53:56 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003feae747ff2sm9900743wmk.35.2023.09.16.03.53.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 03:53:55 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 16 Sep 2023 12:52:46 +0200
Subject: [PATCH net 2/5] mptcp: move __mptcp_error_report in protocol.c
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-2-05d1a8b851a8@tessares.net>
References: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
In-Reply-To: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-0-05d1a8b851a8@tessares.net>
To:     mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Davide Caratti <dcaratti@redhat.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>,
        stable@vger.kernel.org
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3409;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=UCzONQs8IbPl41AgIyasVUSFyocd6ByoszHVHBiWnr4=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlBYlAE4rFvQULAtV4XxAqAqenuymInl5nYoNWA
 +2Zl3C/OP2JAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZQWJQAAKCRD2t4JPQmmg
 cwpoEADUHOOGVVygnOP/3dSVU8OHtSYLaNemMIDJhsqCUCurZS9AorYWIdENIP0Y5LKJX3y4hbF
 QagnCCUz49DbXHtDlc1KqwHFI0Sy64GUurBXyqnv6LuPsPGISXBDEq1ykawed40/t6OrSEZau/I
 5t5i032ECrUeiooVypidj7HWkukdn8XaSDYSLTV8LUNtoXgzk/NjBSC5ft7EM8FQXaVVr1jFJ1D
 nI7VIN/fsIodx45oPKBBrQV4m6gSWQ6Z4i7AUNkjgtPPvhYQbM+7lZsa44pAm+MGB2UxAN2r7nY
 3VR1KzI+DQwzDcbXzfHVfFvps+UrHgfQT3OQLHCEXRMOBqHiXaeZg3pLFIltNcYjrkNYdZoO+ME
 dhTuQF2nWh5t4FFmKnkc7mMT521SPtFiaZ7mxUimM2T5cOl1FoOsq70wpyAqLoZ7QByGwMu0vi/
 DIn8LNX4X+ZTYKoNfNAtWc7lHJ6YuQWkiu6ddwO4vkvk9NkurKA9cPE0s+WGIEiLMEHCIRwisbg
 czehBHr3Uy/DGoatW8/umqh+q+BGv6zEsxnlGOGA579UQh2Y3XM5OrQIsaYefV7L4feOgaqlPmC
 zUmv91Mr7naOXvfv+wvCobZmTKwFEVpHlPH1GcAeZxYDrS2gN/fkCdF5yib5cp+sG2ta9t3JX3w
 hHL4mOoUD7/Lvsg==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

This will simplify the next patch ("mptcp: process pending subflow error
on close").

No functional change intended.

Cc: stable@vger.kernel.org # v5.12+
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 36 ++++++++++++++++++++++++++++++++++++
 net/mptcp/subflow.c  | 36 ------------------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index a7fc16f5175d..915860027b1a 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -770,6 +770,42 @@ static bool __mptcp_ofo_queue(struct mptcp_sock *msk)
 	return moved;
 }
 
+void __mptcp_error_report(struct sock *sk)
+{
+	struct mptcp_subflow_context *subflow;
+	struct mptcp_sock *msk = mptcp_sk(sk);
+
+	mptcp_for_each_subflow(msk, subflow) {
+		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
+		int err = sock_error(ssk);
+		int ssk_state;
+
+		if (!err)
+			continue;
+
+		/* only propagate errors on fallen-back sockets or
+		 * on MPC connect
+		 */
+		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
+			continue;
+
+		/* We need to propagate only transition to CLOSE state.
+		 * Orphaned socket will see such state change via
+		 * subflow_sched_work_if_closed() and that path will properly
+		 * destroy the msk as needed.
+		 */
+		ssk_state = inet_sk_state_load(ssk);
+		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
+			inet_sk_state_store(sk, ssk_state);
+		WRITE_ONCE(sk->sk_err, -err);
+
+		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
+		smp_wmb();
+		sk_error_report(sk);
+		break;
+	}
+}
+
 /* In most cases we will be able to lock the mptcp socket.  If its already
  * owned, we need to defer to the work queue to avoid ABBA deadlock.
  */
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9bf3c7bc1762..2f40c23fdb0d 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1362,42 +1362,6 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
 	*full_space = mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
-void __mptcp_error_report(struct sock *sk)
-{
-	struct mptcp_subflow_context *subflow;
-	struct mptcp_sock *msk = mptcp_sk(sk);
-
-	mptcp_for_each_subflow(msk, subflow) {
-		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
-		int err = sock_error(ssk);
-		int ssk_state;
-
-		if (!err)
-			continue;
-
-		/* only propagate errors on fallen-back sockets or
-		 * on MPC connect
-		 */
-		if (sk->sk_state != TCP_SYN_SENT && !__mptcp_check_fallback(msk))
-			continue;
-
-		/* We need to propagate only transition to CLOSE state.
-		 * Orphaned socket will see such state change via
-		 * subflow_sched_work_if_closed() and that path will properly
-		 * destroy the msk as needed.
-		 */
-		ssk_state = inet_sk_state_load(ssk);
-		if (ssk_state == TCP_CLOSE && !sock_flag(sk, SOCK_DEAD))
-			inet_sk_state_store(sk, ssk_state);
-		WRITE_ONCE(sk->sk_err, -err);
-
-		/* This barrier is coupled with smp_rmb() in mptcp_poll() */
-		smp_wmb();
-		sk_error_report(sk);
-		break;
-	}
-}
-
 static void subflow_error_report(struct sock *ssk)
 {
 	struct sock *sk = mptcp_subflow_ctx(ssk)->conn;

-- 
2.40.1

