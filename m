Return-Path: <linux-kernel+bounces-88852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9D086E788
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 18:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B61402871F7
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 17:44:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B0F425610;
	Fri,  1 Mar 2024 17:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AJHcs2kG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C59B1B7FD;
	Fri,  1 Mar 2024 17:44:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709315050; cv=none; b=RmA0M6ttFBUbm1PbD7uB+HmBOjBcFv+ciDg0lm2xoRb6EyR6XKeWgRH1QgXUnnl1/oDZDMFtUowtkiMFA4IJ6sVU90lnTADutgvA+57H+q1faMGjdxxxmBLRPklnCDWt6q+KSEeHTteals/+Bs2RBvvnh8CFMW2hy/vfonB/CLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709315050; c=relaxed/simple;
	bh=qWKkPNajfUVsea21RCifCjJMui1+CQjLYDkjVsEM5Tw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=npIUcyeO5Mqu/FyOa5NUATEfw3VxTcodro9hUGOeM3TWtn+wGzSx7uawEODSi6sSHbJVHSZg7dQB4wcBfCF7IAPc04N6P7r5Fv/StKkI6GyXLtDPro7NfQ4QziScf/jm6PYW/h8ChFbwyF4PHsoLG2Xi9a7onIbmaAg/WyqmmGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AJHcs2kG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C8B3C43601;
	Fri,  1 Mar 2024 17:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709315050;
	bh=qWKkPNajfUVsea21RCifCjJMui1+CQjLYDkjVsEM5Tw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=AJHcs2kGBucd9FOxyzi6CAEHp5/R8Qxhdp5GWFeo2fushkL8CTNe/7FTyCB6zXgNX
	 jJU87Ge1bkClZRbvqde8IA0iW7WvM6XeVd+TBwK98lwMGIgkTR9ytfyFmexhuvVF9x
	 XQr0DJBKmRIgy48txqvNZlKtmX8KgDsmRGGFPybPgnd4/L9LcRTJ/hR/wZQ/Rn8ftv
	 PUWJPAy2uyw3I3EHzHSxbcjfmcmtTLD/vWYk4M1dcQ8FgfvJ0G/EbEE8r37FpbctOP
	 2vPKFP7nE8sh8JYOJ8k0yaEs/sTIOOea/uRpGb9XtdcWHmR+qapLEVjmqnlr8QWEur
	 L5SGiGv4geMcQ==
From: "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
Date: Fri, 01 Mar 2024 18:43:44 +0100
Subject: [PATCH net-next 1/4] mptcp: cleanup writer wake-up
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-1-415f0e8ed0e1@kernel.org>
References: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
To: mptcp@lists.linux.dev, Mat Martineau <martineau@kernel.org>, 
 Geliang Tang <geliang@kernel.org>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 "Matthieu Baerts (NGI0)" <matttbe@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3037; i=matttbe@kernel.org;
 h=from:subject:message-id; bh=QqGEqOJP/LnJu/Zld7Jkp0utf6EsUkW4CSldq5xKHBk=;
 b=owEBbQKS/ZANAwAIAfa3gk9CaaBzAcsmYgBl4hPlDtIoxjQZIKgof6OZ1T4DqpNhnK6w+HQHC
 f4aEcIGgbaJAjMEAAEIAB0WIQToy4X3aHcFem4n93r2t4JPQmmgcwUCZeIT5QAKCRD2t4JPQmmg
 c51EEADPqtNb0PTe6S2cEYvynnC0p5AHi5D6EBeQIqgMkaInJyEvhSof7Spdqzhv4vJlgw+M/P5
 OLZTgZ4G9WOprnKT3h/bwEXkfx9l0s/HcLond6cLdHdhnWRAnCvUZocYT1yNFbxXF2dDVWrAqRE
 lK/UmIsU1PO9fg3xf59vyKa+Uwn/prbO7QpBnFYpO0D+hduXP+U78+r8jTxKHHoUjZf1G04Hd9b
 wZMyx6jLIX45gH9I4Gvq0nln8OMGIfIhuQGBHDNB7+uYQ1FPdb4Qc7LK6A35fb5h2DzgrZnYESx
 eULfofIQ3mlYVVNbcqkDgcTNojGhfJmdPH9GWPQgOXOALuH+Ei8v3ga0TSA/IlQl3/IJk0WavOI
 XvsYp+bjjgtIe4Fza4trZM8GCQK8ecuAEY964dZTuNjCBOaUuXxCEWYDXEWkGUdQ0+nfvwbxDOC
 oq/CNSUwO6+7bPjLzN3S1z+YRWP1PMEICvoTpM/gPqyp9HXuwQmvrqyEISden6VhWgZJA8m8tjo
 ybDdgxrxtREzVpmWQ2qCQbCPBQmRf0uUsgs0HKSA+RmaEpu33ox3W1N6vsy4QBcZCUvr1/HC448
 uiWu2cN+21A2hsByxz/6w7LX8BcgrDDeW+lGtL9QweadNUU6HeZSH90xhBYGdueksDnIrhLyqnL
 v0PRx8oXNjhrr6g==
X-Developer-Key: i=matttbe@kernel.org; a=openpgp;
 fpr=E8CB85F76877057A6E27F77AF6B7824F4269A073

From: Paolo Abeni <pabeni@redhat.com>

After commit 5cf92bbadc58 ("mptcp: re-enable sndbuf autotune"), the
MPTCP_NOSPACE bit is redundant: it is always set and cleared together with
SOCK_NOSPACE.

Let's drop the first and always relay on the latter, dropping a bunch
of useless code.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Reviewed-by: Mat Martineau <martineau@kernel.org>
Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
---
 net/mptcp/protocol.c | 15 +++------------
 net/mptcp/protocol.h | 16 ++++++----------
 2 files changed, 9 insertions(+), 22 deletions(-)

diff --git a/net/mptcp/protocol.c b/net/mptcp/protocol.c
index 76c8861a852b..a3d79e9d0694 100644
--- a/net/mptcp/protocol.c
+++ b/net/mptcp/protocol.c
@@ -1692,15 +1692,6 @@ static void __mptcp_subflow_push_pending(struct sock *sk, struct sock *ssk, bool
 	}
 }
 
-static void mptcp_set_nospace(struct sock *sk)
-{
-	/* enable autotune */
-	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
-
-	/* will be cleared on avail space */
-	set_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags);
-}
-
 static int mptcp_disconnect(struct sock *sk, int flags);
 
 static int mptcp_sendmsg_fastopen(struct sock *sk, struct msghdr *msg,
@@ -1874,7 +1865,7 @@ static int mptcp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		continue;
 
 wait_for_memory:
-		mptcp_set_nospace(sk);
+		set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
 		__mptcp_push_pending(sk, msg->msg_flags);
 		ret = sk_stream_wait_memory(sk, &timeo);
 		if (ret)
@@ -3945,8 +3936,8 @@ static __poll_t mptcp_check_writeable(struct mptcp_sock *msk)
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 
-	mptcp_set_nospace(sk);
-	smp_mb__after_atomic(); /* msk->flags is changed by write_space cb */
+	set_bit(SOCK_NOSPACE, &sk->sk_socket->flags);
+	smp_mb__after_atomic(); /* NOSPACE is changed by mptcp_write_space() */
 	if (sk_stream_is_writeable(sk))
 		return EPOLLOUT | EPOLLWRNORM;
 
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index d0a7955b96c4..f0c634e843e6 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -113,10 +113,9 @@
 #define MPTCP_RST_TRANSIENT	BIT(0)
 
 /* MPTCP socket atomic flags */
-#define MPTCP_NOSPACE		1
-#define MPTCP_WORK_RTX		2
-#define MPTCP_FALLBACK_DONE	4
-#define MPTCP_WORK_CLOSE_SUBFLOW 5
+#define MPTCP_WORK_RTX		1
+#define MPTCP_FALLBACK_DONE	2
+#define MPTCP_WORK_CLOSE_SUBFLOW 3
 
 /* MPTCP socket release cb flags */
 #define MPTCP_PUSH_PENDING	1
@@ -810,12 +809,9 @@ static inline bool mptcp_data_fin_enabled(const struct mptcp_sock *msk)
 
 static inline void mptcp_write_space(struct sock *sk)
 {
-	if (sk_stream_is_writeable(sk)) {
-		/* pairs with memory barrier in mptcp_poll */
-		smp_mb();
-		if (test_and_clear_bit(MPTCP_NOSPACE, &mptcp_sk(sk)->flags))
-			sk_stream_write_space(sk);
-	}
+	/* pairs with memory barrier in mptcp_poll */
+	smp_mb();
+	sk_stream_write_space(sk);
 }
 
 static inline void __mptcp_sync_sndbuf(struct sock *sk)

-- 
2.43.0


