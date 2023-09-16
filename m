Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44D067A2F5E
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Sep 2023 12:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239191AbjIPKyc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Sep 2023 06:54:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbjIPKyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Sep 2023 06:54:10 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C6FBE47
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:54:02 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-403004a96a4so33305985e9.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Sep 2023 03:54:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1694861640; x=1695466440; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lCbf536zbhXraTTMRG0Aq2yDYiugFXjkPg6qBoYZo3I=;
        b=FqgTBhz8OJ/tp7vcVOYbgKct6dM+P2IoB5ctxPeM/sRcaPeJxTC4cbqmdNflifyQ97
         PJrk9z7e8gOph/FwWF05D2FcQ2eaihVMF1YHJAC/mGf/LYD4RFu+xJaf0jNskg7zMAW+
         hSGN17jt24ebL18Rb9QTeYystt2AqhlQrvXMZCXxTkpvwD/YsNuLAzohrgv46q9Hs4vC
         DIF41QhpRSUZww14TvW//4X2QdbgBGoYDQ6VD9zGK53WofxbbGzEThKerfkMoWzuBPXx
         3rHKZelggVoRUIbI3A1t3jTTwCcjZoN4sJ3N2NtOhKvpiZCJ97vPZSSThr6ZTVcu8p5l
         EQDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694861640; x=1695466440;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lCbf536zbhXraTTMRG0Aq2yDYiugFXjkPg6qBoYZo3I=;
        b=eAC9dKHtIpzrpgC1F+CTXO0qZTzNnStKOOw2ENoeQPYQwBil2ed6aatsNRNu3GDvCb
         Ntkn8ss5glKL9KndbR4vFTcI+XYntZ7J9XRmZsZ6cdglQTHFHakbIARTKfmw02CTiqGS
         xUGsuztd8aFXj9eA/IIMPxT7HeZ64Uxb7eCQZI4sKahocaXleIUmlfrweJ8S7o3jW7NG
         ifBH2E6pRWZAloeo53P7Ht0SvPiDHvoSeG22Q8n8uKZ+WBAvkH6Z2Lp1IAz2StG2hrU8
         wrYk3zbSpes94AQZKTDkYt3/K/7i3rBEiEFaoiKE25yBNgYRQlasuynBzD/w/v0Om9f5
         WyYw==
X-Gm-Message-State: AOJu0Yx+hA5EV9Q6iw3hTSS+grvXGFjri75X+6DSVkL7bcX090jWKiGa
        uVIawsm0aIBrwDS0IWXp3WSN5A==
X-Google-Smtp-Source: AGHT+IGUTrKAka4tl1eWfpxA9TITdlfY1qyKAyrGvk0igXz74UEt5ZAimIS0fhef8jAcKTmsHSUfdg==
X-Received: by 2002:a7b:cc9a:0:b0:404:2dbb:8943 with SMTP id p26-20020a7bcc9a000000b004042dbb8943mr3802431wma.2.1694861640245;
        Sat, 16 Sep 2023 03:54:00 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id z20-20020a7bc7d4000000b003feae747ff2sm9900743wmk.35.2023.09.16.03.53.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Sep 2023 03:53:59 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Sat, 16 Sep 2023 12:52:49 +0200
Subject: [PATCH net 5/5] mptcp: fix dangling connection hang-up
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230916-upstream-net-20230915-mptcp-hanging-conn-v1-5-05d1a8b851a8@tessares.net>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9415;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=E7vx99VIWDYqjArZZSSAkYFEkBABTWvaLv0OIesC/i8=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBlBYlAHAltOFy03zfkdc5Yp3CQxbAuxeO+Wm9JA
 ppRlr46JLGJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZQWJQAAKCRD2t4JPQmmg
 c2b4EACCkyw2WDKuFmlxYmFLsN6pozBnNtxGH/H2HbL4C7C4+Hzw7KuFZg1v8EiajBLv3hpWlVx
 c9qcEsaqp6FVSQXeuKU3G56Bf09Gs2iT7IpEbPXQpuE6hM13+d+D62n+OoU47/O3BSA/KrkXeiy
 5fOFQOMus4/YtfsYO4y9oIwNpw6YjQC+jr2VJC7BOXyv8bYE2JBt2XdjSnIFRExXOZwRw6n7xOR
 KDgN3BqO/K4a74nXLxsb2uNkRDuackHOFMDJzXzce2H0Xb4bMoB4X3r+JU9Hlzx2EFLRLYi5FW8
 kAdR2ECpb93GbVRoFgbHZknDB2F8ZE+lWvtRc0iiwYkFkcR/dgsXxBTaa2ud9gfCGaHoLyuIz1U
 8LRDasIF4ylVEAXvLxq7RJn5PMvbqJBqM7oB/rPSGHYRjJhruobdS93M6lGoJsj5hcLw8qaC4/z
 YLZ779pu7UWx8NIzxHSIGo0c319hqEVuqPMRoEYN666L9gW+mxivkVihalod9Jk3pAcHy0kdD5I
 JsFsvd6PWDbBOCk7igWF7rZlA78+lVZh7xRQZ/rXcFUBhOTNxUH3JY+NkWQ9aWyxqMg4L82zkJU
 G0k1sDHliluffEsbKzZelZ4OLtBCvYVB01RZ3/Um7CCw9zG1AZVEvaqfrVo4GGzZPJrj322ekq6
 fdoJaP4wwCHMMyg==
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

According to RFC 8684 section 3.3:

  A connection is not closed unless [...] or an implementation-specific
  connection-level send timeout.

Currently the MPTCP protocol does not implement such timeout, and
connection timing-out at the TCP-level never move to close state.

Introduces a catch-up condition at subflow close time to move the
MPTCP socket to close, too.

That additionally allows removing similar existing inside the worker.

Finally, allow some additional timeout for plain ESTABLISHED mptcp
sockets, as the protocol allows creating new subflows even at that
point and making the connection functional again.

This issue is actually present since the beginning, but it is basically
impossible to solve without a long chain of functional pre-requisites
topped by commit bbd49d114d57 ("mptcp: consolidate transition to
TCP_CLOSE in mptcp_do_fastclose()"). When backporting this current
patch, please also backport this other commit as well.

Closes: https://github.com/multipath-tcp/mptcp_net-next/issues/430
Fixes: e16163b6e2b7 ("mptcp: refactor shutdown and close")
Cc: stable@vger.kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 net/mptcp/protocol.c | 86 +++++++++++++++++++++++++---------------------------
 net/mptcp/protocol.h | 22 ++++++++++++++
 net/mptcp/subflow.c  |  1 +
 3 files changed, 65 insertions(+), 44 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index c8f38f303a90..e252539b1e19 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -892,6 +892,7 @@ static bool __mptcp_finish_join(struct mptcp_sock *msk, struct sock *ssk)
 	mptcp_subflow_ctx(ssk)->subflow_id = msk->subflow_id++;
 	mptcp_sockopt_sync_locked(msk, ssk);
 	mptcp_subflow_joined(msk, ssk);
+	mptcp_stop_tout_timer(sk);
 	return true;
 }
 
@@ -2369,18 +2370,14 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 	bool dispose_it, need_push = false;
 
 	/* If the first subflow moved to a close state before accept, e.g. due
-	 * to an incoming reset, mptcp either:
-	 * - if either the subflow or the msk are dead, destroy the context
-	 *   (the subflow socket is deleted by inet_child_forget) and the msk
-	 * - otherwise do nothing at the moment and take action at accept and/or
-	 *   listener shutdown - user-space must be able to accept() the closed
-	 *   socket.
+	 * to an incoming reset or listener shutdown, the subflow socket is
+	 * already deleted by inet_child_forget() and the mptcp socket can't
+	 * survive too.
 	 */
-	if (msk->in_accept_queue && msk->first == ssk) {
-		if (!sock_flag(sk, SOCK_DEAD) && !sock_flag(ssk, SOCK_DEAD))
-			return;
-
+	if (msk->in_accept_queue && msk->first == ssk &&
+	    (sock_flag(sk, SOCK_DEAD) || sock_flag(ssk, SOCK_DEAD))) {
 		/* ensure later check in mptcp_worker() will dispose the msk */
+		mptcp_set_close_tout(sk, tcp_jiffies32 - (TCP_TIMEWAIT_LEN + 1));
 		sock_set_flag(sk, SOCK_DEAD);
 		lock_sock_nested(ssk, SINGLE_DEPTH_NESTING);
 		mptcp_subflow_drop_ctx(ssk);
@@ -2443,6 +2440,22 @@ static void __mptcp_close_ssk(struct sock *sk, struct sock *ssk,
 out:
 	if (need_push)
 		__mptcp_push_pending(sk, 0);
+
+	/* Catch every 'all subflows closed' scenario, including peers silently
+	 * closing them, e.g. due to timeout.
+	 * For established sockets, allow an additional timeout before closing,
+	 * as the protocol can still create more subflows.
+	 */
+	if (list_is_singular(&msk->conn_list) && msk->first &&
+	    inet_sk_state_load(msk->first) == TCP_CLOSE) {
+		if (sk->sk_state != TCP_ESTABLISHED ||
+		    msk->in_accept_queue || sock_flag(sk, SOCK_DEAD)) {
+			inet_sk_state_store(sk, TCP_CLOSE);
+			mptcp_close_wake_up(sk);
+		} else {
+			mptcp_start_tout_timer(sk);
+		}
+	}
 }
 
 void mptcp_close_ssk(struct sock *sk, struct sock *ssk,
@@ -2486,23 +2499,14 @@ static void __mptcp_close_subflow(struct sock *sk)
 
 }
 
-static bool mptcp_should_close(const struct sock *sk)
+static bool mptcp_close_tout_expired(const struct sock *sk)
 {
-	s32 delta = tcp_jiffies32 - inet_csk(sk)->icsk_mtup.probe_timestamp;
-	struct mptcp_subflow_context *subflow;
+	if (!inet_csk(sk)->icsk_mtup.probe_timestamp ||
+	    sk->sk_state == TCP_CLOSE)
+		return false;
 
-	if (delta >= TCP_TIMEWAIT_LEN || mptcp_sk(sk)->in_accept_queue)
-		return true;
-
-	/* if all subflows are in closed status don't bother with additional
-	 * timeout
-	 */
-	mptcp_for_each_subflow(mptcp_sk(sk), subflow) {
-		if (inet_sk_state_load(mptcp_subflow_tcp_sock(subflow)) !=
-		    TCP_CLOSE)
-			return false;
-	}
-	return true;
+	return time_after32(tcp_jiffies32,
+		  inet_csk(sk)->icsk_mtup.probe_timestamp + TCP_TIMEWAIT_LEN);
 }
 
 static void mptcp_check_fastclose(struct mptcp_sock *msk)
@@ -2641,15 +2645,16 @@ void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout)
 	struct sock *sk = (struct sock *)msk;
 	unsigned long timeout, close_timeout;
 
-	if (!fail_tout && !sock_flag(sk, SOCK_DEAD))
+	if (!fail_tout && !inet_csk(sk)->icsk_mtup.probe_timestamp)
 		return;
 
-	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies + TCP_TIMEWAIT_LEN;
+	close_timeout = inet_csk(sk)->icsk_mtup.probe_timestamp - tcp_jiffies32 + jiffies +
+			TCP_TIMEWAIT_LEN;
 
 	/* the close timeout takes precedence on the fail one, and here at least one of
 	 * them is active
 	 */
-	timeout = sock_flag(sk, SOCK_DEAD) ? close_timeout : fail_tout;
+	timeout = inet_csk(sk)->icsk_mtup.probe_timestamp ? close_timeout : fail_tout;
 
 	sk_reset_timer(sk, &sk->sk_timer, timeout);
 }
@@ -2668,8 +2673,6 @@ static void mptcp_mp_fail_no_response(struct mptcp_sock *msk)
 	mptcp_subflow_reset(ssk);
 	WRITE_ONCE(mptcp_subflow_ctx(ssk)->fail_tout, 0);
 	unlock_sock_fast(ssk, slow);
-
-	mptcp_reset_tout_timer(msk, 0);
 }
 
 static void mptcp_do_fastclose(struct sock *sk)
@@ -2706,18 +2709,14 @@ static void mptcp_worker(struct work_struct *work)
 	if (test_and_clear_bit(MPTCP_WORK_CLOSE_SUBFLOW, &msk->flags))
 		__mptcp_close_subflow(sk);
 
-	/* There is no point in keeping around an orphaned sk timedout or
-	 * closed, but we need the msk around to reply to incoming DATA_FIN,
-	 * even if it is orphaned and in FIN_WAIT2 state
-	 */
-	if (sock_flag(sk, SOCK_DEAD)) {
-		if (mptcp_should_close(sk))
-			mptcp_do_fastclose(sk);
+	if (mptcp_close_tout_expired(sk)) {
+		mptcp_do_fastclose(sk);
+		mptcp_close_wake_up(sk);
+	}
 
-		if (sk->sk_state == TCP_CLOSE) {
-			__mptcp_destroy_sock(sk);
-			goto unlock;
-		}
+	if (sock_flag(sk, SOCK_DEAD) && sk->sk_state == TCP_CLOSE) {
+		__mptcp_destroy_sock(sk);
+		goto unlock;
 	}
 
 	if (test_and_clear_bit(MPTCP_WORK_RTX, &msk->flags))
@@ -3016,7 +3015,6 @@ bool __mptcp_close(struct sock *sk, long timeout)
 
 cleanup:
 	/* orphan all the subflows */
-	inet_csk(sk)->icsk_mtup.probe_timestamp = tcp_jiffies32;
 	mptcp_for_each_subflow(msk, subflow) {
 		struct sock *ssk = mptcp_subflow_tcp_sock(subflow);
 		bool slow = lock_sock_fast_nested(ssk);
@@ -3053,7 +3051,7 @@ bool __mptcp_close(struct sock *sk, long timeout)
 		__mptcp_destroy_sock(sk);
 		do_cancel_work = true;
 	} else {
-		mptcp_reset_tout_timer(msk, 0);
+		mptcp_start_tout_timer(sk);
 	}
 
 	return do_cancel_work;
@@ -3117,7 +3115,7 @@ static int mptcp_disconnect(struct sock *sk, int flags)
 	inet_sk_state_store(sk, TCP_CLOSE);
 
 	mptcp_stop_rtx_timer(sk);
-	sk_stop_timer(sk, &sk->sk_timer);
+	mptcp_stop_tout_timer(sk);
 
 	if (msk->token)
 		mptcp_event(MPTCP_EVENT_CLOSED, msk, NULL, GFP_KERNEL);
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 5e2026815c8e..ed61d6850cce 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -719,6 +719,28 @@ void mptcp_get_options(const struct sk_buff *skb,
 void mptcp_finish_connect(struct sock *sk);
 void __mptcp_set_connected(struct sock *sk);
 void mptcp_reset_tout_timer(struct mptcp_sock *msk, unsigned long fail_tout);
+
+static inline void mptcp_stop_tout_timer(struct sock *sk)
+{
+	if (!inet_csk(sk)->icsk_mtup.probe_timestamp)
+		return;
+
+	sk_stop_timer(sk, &sk->sk_timer);
+	inet_csk(sk)->icsk_mtup.probe_timestamp = 0;
+}
+
+static inline void mptcp_set_close_tout(struct sock *sk, unsigned long tout)
+{
+	/* avoid 0 timestamp, as that means no close timeout */
+	inet_csk(sk)->icsk_mtup.probe_timestamp = tout ? : 1;
+}
+
+static inline void mptcp_start_tout_timer(struct sock *sk)
+{
+	mptcp_set_close_tout(sk, tcp_jiffies32);
+	mptcp_reset_tout_timer(mptcp_sk(sk), 0);
+}
+
 static inline bool mptcp_is_fully_established(struct sock *sk)
 {
 	return inet_sk_state_load(sk) == TCP_ESTABLISHED &&
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 433f290984c8..918c1a235790 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1552,6 +1552,7 @@ int __mptcp_subflow_connect(struct sock *sk, const struct mptcp_addr_info *loc,
 	mptcp_sock_graft(ssk, sk->sk_socket);
 	iput(SOCK_INODE(sf));
 	WRITE_ONCE(msk->allow_infinite_fallback, false);
+	mptcp_stop_tout_timer(sk);
 	return 0;
 
 failed_unlink:

-- 
2.40.1

