Return-Path: <linux-kernel+bounces-136518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F689D513
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 11:07:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72F401C2149C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:07:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BA107EF06;
	Tue,  9 Apr 2024 09:07:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b="NQPtyfNm"
Received: from mx1.t-argos.ru (mx1.t-argos.ru [109.73.34.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B7A5339A;
	Tue,  9 Apr 2024 09:07:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=109.73.34.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712653641; cv=none; b=LHy8ka/U3rQaY1zK0SlgQR5Sn7FqItS7IbTFL64Nox0StcJPLAQQaWViXfOKykEOhKCMIlFuINupepbgGOxRDz1jU1gK88GzU5OQ58IzSuQGVT2dw5ZZOQXbJFjvetm7cHmYhgcReMhOP51TgE+GJnUtDnvVr/lrZueXFm/AQVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712653641; c=relaxed/simple;
	bh=nsVDit+POVQZ2H6w/6IpwlVYrA58ci/3Jlcy44bs/kE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=HpZ/cnKDpxP1oOdiPRqfWmtrVqIaoB2u9uhxf/l5eV1R7OYwLx8JNjLwkzXTwMlJfzY1hGHBor8fWep8pEz2Gkn3W6hYaBjgGhCnqNDM2jrD9FuiolBjajB8Ij6NC+QgrPEVv2hYkTlW+6xXCvhiRGX0pZzMil5JNV9cSa6ZwkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru; spf=pass smtp.mailfrom=t-argos.ru; dkim=pass (2048-bit key) header.d=t-argos.ru header.i=@t-argos.ru header.b=NQPtyfNm; arc=none smtp.client-ip=109.73.34.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=t-argos.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=t-argos.ru
Received: from mx1.t-argos.ru (localhost [127.0.0.1])
	by mx1.t-argos.ru (Postfix) with ESMTP id 6D9A7100003;
	Tue,  9 Apr 2024 12:06:52 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=t-argos.ru; s=mail;
	t=1712653612; bh=6MJ6fVJnN7Gpxxf8TraZt1FowXJlJ9GCYXfReimphcE=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
	b=NQPtyfNmcjh89rBodlhXy1EsylX+VHfcn9U02hLYvaH6up/r/D9hxcvuoMxhm0EPU
	 DxbSf6L+M9GBDmrafkeANR6UVwvvPOW435hfGXCYaw9Pcot438f5neUbAEJtVr3FPz
	 AVjIKRwNMopl1uKScEndfTPW6rdTEgeVxOjIL4FtlUR5yBJpfqKNr2l/9NLePjtqF5
	 mjeCVtyAEZ4/GAva59U8lvd3yDAR3xi86i6GhuE9aryNO6ULiT2uMMwkRPCkIK1LkP
	 AFvh7mhVGE+aXag/ssPp+hfYRVtesELjE24VrIpDcI65To5tUSOo0Ok7AHqy+49Toi
	 S7du+yl8W3RoQ==
Received: from mx1.t-argos.ru.ru (ta-mail-02.ta.t-argos.ru [172.17.13.212])
	by mx1.t-argos.ru (Postfix) with ESMTP;
	Tue,  9 Apr 2024 12:05:45 +0300 (MSK)
Received: from localhost.localdomain (172.17.215.6) by ta-mail-02
 (172.17.13.212) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 9 Apr 2024
 12:05:15 +0300
From: Aleksandr Mishin <amishin@t-argos.ru>
To: Atul Gupta <atul.gupta@chelsio.com>
CC: Aleksandr Mishin <amishin@t-argos.ru>, Ayush Sawal
	<ayush.sawal@chelsio.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>, Michael Werner
	<werner@chelsio.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH net] crypto: chtls: Fix possible null pointer dereferences
Date: Tue, 9 Apr 2024 12:05:07 +0300
Message-ID: <20240409090507.21441-1-amishin@t-argos.ru>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ta-mail-02.ta.t-argos.ru (172.17.13.212) To ta-mail-02
 (172.17.13.212)
X-KSMG-Rule-ID: 1
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 184636 [Apr 09 2024]
X-KSMG-AntiSpam-Version: 6.1.0.4
X-KSMG-AntiSpam-Envelope-From: amishin@t-argos.ru
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 15 0.3.15 adb41f89e2951eb37b279104a7abb8e79494a5e7, {Tracking_from_domain_doesnt_match_to}, mx1.t-argos.ru.ru:7.1.1;127.0.0.199:7.1.2;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;t-argos.ru:7.1.1, FromAlignment: s
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean, bases: 2024/04/09 08:22:00
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2024/04/09 07:19:00 #24714583
X-KSMG-AntiVirus-Status: Clean, skipped

In chtls_pass_accept_rpl() and chtls_select_mss() __sk_dst_get() may
return NULL which is later dereferenced. Fix this bug by adding NULL check.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: cc35c88ae4db ("crypto : chtls - CPL handler definition")
Signed-off-by: Aleksandr Mishin <amishin@t-argos.ru>
---
 .../chelsio/inline_crypto/chtls/chtls_cm.c    | 24 +++++++++++++------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 6f6525983130..6d88cbc9fbb0 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -939,15 +939,15 @@ static void chtls_accept_rpl_arp_failure(void *handle,
 	sock_put(sk);
 }
 
-static unsigned int chtls_select_mss(const struct chtls_sock *csk,
+static bool chtls_select_mss(const struct chtls_sock *csk,
 				     unsigned int pmtu,
-				     struct cpl_pass_accept_req *req)
+				     struct cpl_pass_accept_req *req,
+					 unsigned int *mtu_idx)
 {
 	struct chtls_dev *cdev;
 	struct dst_entry *dst;
 	unsigned int tcpoptsz;
 	unsigned int iphdrsz;
-	unsigned int mtu_idx;
 	struct tcp_sock *tp;
 	unsigned int mss;
 	struct sock *sk;
@@ -955,6 +955,9 @@ static unsigned int chtls_select_mss(const struct chtls_sock *csk,
 	mss = ntohs(req->tcpopt.mss);
 	sk = csk->sk;
 	dst = __sk_dst_get(sk);
+	if (!dst)
+		return false;
+
 	cdev = csk->cdev;
 	tp = tcp_sk(sk);
 	tcpoptsz = 0;
@@ -979,11 +982,11 @@ static unsigned int chtls_select_mss(const struct chtls_sock *csk,
 	tp->advmss = cxgb4_best_aligned_mtu(cdev->lldi->mtus,
 					    iphdrsz + tcpoptsz,
 					    tp->advmss - tcpoptsz,
-					    8, &mtu_idx);
+					    8, mtu_idx);
 	tp->advmss -= iphdrsz;
 
 	inet_csk(sk)->icsk_pmtu_cookie = pmtu;
-	return mtu_idx;
+	return true;
 }
 
 static unsigned int select_rcv_wscale(int space, int wscale_ok, int win_clamp)
@@ -1016,8 +1019,13 @@ static void chtls_pass_accept_rpl(struct sk_buff *skb,
 	struct sock *sk;
 	u32 opt2, hlen;
 	u64 opt0;
+	struct dst_entry *dst;
 
 	sk = skb->sk;
+	dst = __sk_dst_get(sk);
+	if (!dst)
+		return;
+
 	tp = tcp_sk(sk);
 	csk = sk->sk_user_data;
 	csk->tid = tid;
@@ -1029,8 +1037,10 @@ static void chtls_pass_accept_rpl(struct sk_buff *skb,
 
 	OPCODE_TID(rpl5) = cpu_to_be32(MK_OPCODE_TID(CPL_PASS_ACCEPT_RPL,
 						     csk->tid));
-	csk->mtu_idx = chtls_select_mss(csk, dst_mtu(__sk_dst_get(sk)),
-					req);
+	if (!chtls_select_mss(csk, dst_mtu(dst),
+					req, &csk->mtu_idx))
+		return;
+
 	opt0 = TCAM_BYPASS_F |
 	       WND_SCALE_V(RCV_WSCALE(tp)) |
 	       MSS_IDX_V(csk->mtu_idx) |
-- 
2.30.2


