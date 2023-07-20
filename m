Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4E6F75B70E
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 20:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbjGTSs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 14:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjGTSs1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 14:48:27 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AD02713
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:48:24 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fd190065a8so9910745e9.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jul 2023 11:48:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tessares.net; s=google; t=1689878902; x=1690483702;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kKsiVKdQ2WJeyWvQ7qAYJqbk101bKwTzA58W17c2UeY=;
        b=iA2lNsRwmoihhOFOzi75p6I6b5mvZkFFzmamGVTmHXdIMCb350KZQN/6gjCgSgw2UC
         oxwkjkfe44/LqTj6HHAYRkVrQjH0m1szyVYq5YjMeSp9wUIgt7Lez4VfPC4tTZxl1GOT
         r49hmBs/J/G/E2UyWZmr48GUYER29j76kIkkJUP9Ksicyu+HEElr6w3cOtTp8tPI+H5u
         7T4qmGjrtiY7cbK9qU04M3OiTcFGc+JX2EV8blza+Nv9C2A24GtdaHW2lrxJBHfpJG0i
         CQ1/Hs8g6SH2tDQLALi/srctlhNTVFGEdrGnV+tdjK3IiJ3xah1WakZkmYQ+63p3s7YH
         gbIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689878902; x=1690483702;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kKsiVKdQ2WJeyWvQ7qAYJqbk101bKwTzA58W17c2UeY=;
        b=L9fDnc9grMRKwHw6FaBsrYPXiF2aZgCf48jMkGBEPHpnvuu/+3iRi+RHgmhDAA0mkZ
         SjbTRUDLpJ0XtdPTaK0YJtRNiycsvD0gL5dtL1QMx/JFw8iCeHIyb2jEfa6U9NFjl37y
         qJLQYJ9r+/UJ1oq4SsxpAHwBJQZDGHzcvSNEC8wP6L+kEoWwr6rNErIlBAfxGP+cKARZ
         XE9rlBM6hY5q9TJYOXYPn+eiBwAy91vmpMwrgObrOfeMpaSO7YZ/VkfHp/qnlCEyOx3d
         SXDLRM3w/hlsZfkx3X8uWGXzDNt7+fQ1gfgpnO91MPiT9vv7b6Su+7Ms9W7F+PDMGfjG
         pKhg==
X-Gm-Message-State: ABy/qLZ0Rb6W+ejQpgcpUtxWHJxLqmKq/DoucHUoORSHSWbzZ5YbBbkv
        VlwAwFH18sOxr8YkN90u2pgauVbE79RnonE0kbfJuw==
X-Google-Smtp-Source: APBJJlGwTkH/COFi6GARl8hdELCy27/fM7zj6fZftifCkVBIc5bk2OF7JmU+npeYoxCEghXCQVrviQ==
X-Received: by 2002:a05:600c:2342:b0:3f6:1474:905 with SMTP id 2-20020a05600c234200b003f614740905mr8238744wmq.29.1689878902148;
        Thu, 20 Jul 2023 11:48:22 -0700 (PDT)
Received: from vdi08.nix.tessares.net (static.219.156.76.144.clients.your-server.de. [144.76.156.219])
        by smtp.gmail.com with ESMTPSA id s10-20020a1cf20a000000b003fbca942499sm4565068wmc.14.2023.07.20.11.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jul 2023 11:48:21 -0700 (PDT)
From:   Matthieu Baerts <matthieu.baerts@tessares.net>
Date:   Thu, 20 Jul 2023 20:47:50 +0200
Subject: [PATCH net-next] mptcp: fix rcv buffer auto-tuning
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-v1-1-175ef12b8380@tessares.net>
X-B4-Tracking: v=1; b=H4sIAFWBuWQC/z2NSwrDMAxErxK0rsBOP6G9SunCduRUizhGlkMg5
 O41hXYxi8cM83YoJEwFHt0OQisXXlIDe+ogvF2aCHlsDL3pz2boDdZcVMjNmEhbNsV/NWcNGSN
 vKGFFX2MkQVd1Qa2J04TeD9f7eHE3ay00QxZq66/9Cb8/eB3HB0Jg51uXAAAA
To:     mptcp@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Mat Martineau <martineau@kernel.org>,
        Soheil Hassas Yeganeh <soheil@google.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthieu Baerts <matthieu.baerts@tessares.net>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=6565;
 i=matthieu.baerts@tessares.net; h=from:subject:message-id;
 bh=ncjsZoWoi6M3nrWIFlU5cH+KQzDb9+7q7B0CssmdtN0=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBkuYF0JjkkGxokg7H+uhPv/4xlOB+DfTtCaBPUb
 2J/OK4XwuiJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZLmBdAAKCRD2t4JPQmmg
 cw0IEADU4QQ8URvSIanWpxgjE18H/wO2HMqbCksC+dYfu6i9KtJC+1eJiJs93XJMWOdr8kOBZha
 rPzy7rxQ09DLOnOxg/jKl6Vyv2VoCst7oxrVcoy7zpRaZT9nyv7kk5pCnKiZe4RpFAda/9XTi3T
 TEywzuAc0Q7jqH/uXRom/PM+9k8hC2O9njGH3uqh+iSGribZCPhUYZ+T0X0s9o1m2B+ppZHQ5cg
 S66DPTWIqU2T8Zdgt+rIxRdl6r8UIprfo4EV5vEVIFHx1AK70DVw4IDVXRrxMoFcSNv2q3XMjFb
 GmnBj16PhBms78YIcfoJLc3AjRleVhybfeXIq8a2oARd6TdTOy04AdziqSyRkexf3KmCRnuQ21n
 u7Zq7xL1Pjc4Htb2sIn5k0Mk1vTPwr0EbWc/5gmSIBxjXM/PKq7ZvP4WvJvtdzoqxJVJxjBnhZu
 p56sUUPYcBUqtV7Gcg67QmH9zY/JUmm4Yp3oZNDSaH2ORGesF7L9/X20WeRgUKLCeGuIqN9kaKO
 Uf9P1jAldKGigpNHKKTh796XaG647M0r9eUsBb9GWpBOULhlFm8ELOruAq7Kwe5CKCUYdcosI0D
 hd9bVb7muUcC1SWnQ1NsOA4tadRcrpQnxhuWtY8xiPpdTrgyibt57aVHzwIm5jdi8M0J8TPVbIX
 c9JS13em+AtQXOw==
X-Developer-Key: i=matthieu.baerts@tessares.net; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Paolo Abeni <pabeni@redhat.com>

The MPTCP code uses the assumption that the tcp_win_from_space() helper
does not use any TCP-specific field, and thus works correctly operating
on an MPTCP socket.

The commit dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
broke such assumption, and as a consequence most MPTCP connections stall
on zero-window event due to auto-tuning changing the rcv buffer size
quite randomly.

Address the issue syncing again the MPTCP auto-tuning code with the TCP
one. To achieve that, factor out the windows size logic in socket
independent helpers, and reuse them in mptcp_rcv_space_adjust(). The
MPTCP level scaling_ratio is selected as the minimum one from the all
the subflows, as a worst-case estimate.

Fixes: dfa2f0483360 ("tcp: get rid of sysctl_tcp_adv_win_scale")
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Co-developed-by: Matthieu Baerts <matthieu.baerts@tessares.net>
Signed-off-by: Matthieu Baerts <matthieu.baerts@tessares.net>
---
 include/net/tcp.h    | 20 +++++++++++++++-----
 net/mptcp/protocol.c | 15 +++++++--------
 net/mptcp/protocol.h |  8 +++++++-
 net/mptcp/subflow.c  |  2 +-
 4 files changed, 30 insertions(+), 15 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index c5fb90079920..794642fbd724 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1430,22 +1430,32 @@ void tcp_select_initial_window(const struct sock *sk, int __space,
 			       __u32 *window_clamp, int wscale_ok,
 			       __u8 *rcv_wscale, __u32 init_rcv_wnd);
 
-static inline int tcp_win_from_space(const struct sock *sk, int space)
+static inline int __tcp_win_from_space(u8 scaling_ratio, int space)
 {
-	s64 scaled_space = (s64)space * tcp_sk(sk)->scaling_ratio;
+	s64 scaled_space = (s64)space * scaling_ratio;
 
 	return scaled_space >> TCP_RMEM_TO_WIN_SCALE;
 }
 
-/* inverse of tcp_win_from_space() */
-static inline int tcp_space_from_win(const struct sock *sk, int win)
+static inline int tcp_win_from_space(const struct sock *sk, int space)
+{
+	return __tcp_win_from_space(tcp_sk(sk)->scaling_ratio, space);
+}
+
+/* inverse of __tcp_win_from_space() */
+static inline int __tcp_space_from_win(u8 scaling_ratio, int win)
 {
 	u64 val = (u64)win << TCP_RMEM_TO_WIN_SCALE;
 
-	do_div(val, tcp_sk(sk)->scaling_ratio);
+	do_div(val, scaling_ratio);
 	return val;
 }
 
+static inline int tcp_space_from_win(const struct sock *sk, int win)
+{
+	return __tcp_space_from_win(tcp_sk(sk)->scaling_ratio, win);
+}
+
 static inline void tcp_scaling_ratio_init(struct sock *sk)
 {
 	/* Assume a conservative default of 1200 bytes of payload per 4K page.
diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 3613489eb6e3..553828ef62df 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -90,6 +90,7 @@ static int __mptcp_socket_create(struct mptcp_sock *msk)
 	if (err)
 		return err;
 
+	msk->scaling_ratio = tcp_sk(ssock->sk)->scaling_ratio;
 	WRITE_ONCE(msk->first, ssock->sk);
 	WRITE_ONCE(msk->subflow, ssock);
 	subflow = mptcp_subflow_ctx(ssock->sk);
@@ -1881,6 +1882,7 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 {
 	struct mptcp_subflow_context *subflow;
 	struct sock *sk = (struct sock *)msk;
+	u8 scaling_ratio = U8_MAX;
 	u32 time, advmss = 1;
 	u64 rtt_us, mstamp;
 
@@ -1911,9 +1913,11 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 		rtt_us = max(sf_rtt_us, rtt_us);
 		advmss = max(sf_advmss, advmss);
+		scaling_ratio = min(tp->scaling_ratio, scaling_ratio);
 	}
 
 	msk->rcvq_space.rtt_us = rtt_us;
+	msk->scaling_ratio = scaling_ratio;
 	if (time < (rtt_us >> 3) || rtt_us == 0)
 		return;
 
@@ -1922,8 +1926,8 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 
 	if (READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_moderate_rcvbuf) &&
 	    !(sk->sk_userlocks & SOCK_RCVBUF_LOCK)) {
-		int rcvmem, rcvbuf;
 		u64 rcvwin, grow;
+		int rcvbuf;
 
 		rcvwin = ((u64)msk->rcvq_space.copied << 1) + 16 * advmss;
 
@@ -1932,18 +1936,13 @@ static void mptcp_rcv_space_adjust(struct mptcp_sock *msk, int copied)
 		do_div(grow, msk->rcvq_space.space);
 		rcvwin += (grow << 1);
 
-		rcvmem = SKB_TRUESIZE(advmss + MAX_TCP_HEADER);
-		while (tcp_win_from_space(sk, rcvmem) < advmss)
-			rcvmem += 128;
-
-		do_div(rcvwin, advmss);
-		rcvbuf = min_t(u64, rcvwin * rcvmem,
+		rcvbuf = min_t(u64, __tcp_space_from_win(scaling_ratio, rcvwin),
 			       READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_rmem[2]));
 
 		if (rcvbuf > sk->sk_rcvbuf) {
 			u32 window_clamp;
 
-			window_clamp = tcp_win_from_space(sk, rcvbuf);
+			window_clamp = __tcp_win_from_space(scaling_ratio, rcvbuf);
 			WRITE_ONCE(sk->sk_rcvbuf, rcvbuf);
 
 			/* Make subflows follow along.  If we do not do this, we
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 37fbe22e2433..795f422e8597 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -321,6 +321,7 @@ struct mptcp_sock {
 		u64	time;	/* start time of measurement window */
 		u64	rtt_us; /* last maximum rtt of subflows */
 	} rcvq_space;
+	u8		scaling_ratio;
 
 	u32		subflow_id;
 	u32		setsockopt_seq;
@@ -351,9 +352,14 @@ static inline int __mptcp_rmem(const struct sock *sk)
 	return atomic_read(&sk->sk_rmem_alloc) - READ_ONCE(mptcp_sk(sk)->rmem_released);
 }
 
+static inline int mptcp_win_from_space(const struct sock *sk, int space)
+{
+	return __tcp_win_from_space(mptcp_sk(sk)->scaling_ratio, space);
+}
+
 static inline int __mptcp_space(const struct sock *sk)
 {
-	return tcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
+	return mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf) - __mptcp_rmem(sk));
 }
 
 static inline struct mptcp_data_frag *mptcp_send_head(const struct sock *sk)
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index 9ee3b7abbaf6..ad7080fabb2f 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -1359,7 +1359,7 @@ void mptcp_space(const struct sock *ssk, int *space, int *full_space)
 	const struct sock *sk = subflow->conn;
 
 	*space = __mptcp_space(sk);
-	*full_space = tcp_full_space(sk);
+	*full_space = mptcp_win_from_space(sk, READ_ONCE(sk->sk_rcvbuf));
 }
 
 void __mptcp_error_report(struct sock *sk)

---
base-commit: b44693495af8f309b8ddec4b30833085d1c2d0c4
change-id: 20230720-upstream-net-next-20230720-mptcp-fix-rcv-buffer-auto-tuning-bb759d4a6111

Best regards,
-- 
Matthieu Baerts <matthieu.baerts@tessares.net>

