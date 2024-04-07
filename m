Return-Path: <linux-kernel+bounces-134425-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2742A89B157
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58A871C2039B
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:20:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C2865198;
	Sun,  7 Apr 2024 13:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PA9GMbGZ"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E2B64CEC;
	Sun,  7 Apr 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495516; cv=none; b=o3i7Q8YQbt2CCrUHRGBZjffMiLEIYPFqjjcTnGwssOjyXOfxTFpGxxXFgECYkF7gB94nx2ul2eQ5M2EoDOMWI0JCZF21oMA8TNCKvo0Oc4crETiYtxUgCD9zuDcZg+kS6YcsBlnle74rKU19Yklb7I9/HRV5zcT5Ud08FCE8y5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495516; c=relaxed/simple;
	bh=oGw3+1NhemNxQTQJ86gcbglxDHjdwp2xlXcfrBMW3yA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WFaUw/M0u4fKfTfPj+7XWSQToVWEsAQMBAxZ6tS7oeLZUK2ELWHwsGIaLIRhQE61vOOyIIY8m6bZWTMovm9JQ8JPbuNpbJtsJcJGMBPJG/p7VWJcVUCUacfQM2qtlhwcGe6TpLfmqqNkUPZINMte7t958RHN0k42iPF4PnF9QV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PA9GMbGZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D276BC433F1;
	Sun,  7 Apr 2024 13:11:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495516;
	bh=oGw3+1NhemNxQTQJ86gcbglxDHjdwp2xlXcfrBMW3yA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=PA9GMbGZxEMNife9xXVs6OS3kKbwWnxx15CpiTRCErCTIX8DNv7JVXhh0ad2uioqa
	 LvrEBikI+Bh8pz5bSnx2n4siKtlKbagdeFvqlMYJLvPK6X3Npll9G2nSOS8uODyXGM
	 BZS+lotSo2Thk9VA9I8uwwQ8yK+dByt9IeVFVpT/meR4FBtVRQq3BVi4c+mj6vANkJ
	 OYnwolyQOxb75tPP5eNWHD2gUnPPlnKh5SWprG2vxJ7PHGeC00OV6EPExJaWd7XtZm
	 IMTZkEDVP70h6gpeiHUIemJGiiaZisSgjIz4Ae2fDxkGdjMByoLMrayf/IvT/K7nsh
	 DWwIisxlKnZTQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: linke li <lilinke99@qq.com>,
	Eric Dumazet <edumazet@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Sasha Levin <sashal@kernel.org>,
	kuba@kernel.org,
	pabeni@redhat.com,
	kuniyu@amazon.com,
	willemb@google.com,
	wuyun.abel@bytedance.com,
	leitao@debian.org,
	alexander@mihalicyn.com,
	dhowells@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.8 15/25] net: mark racy access on sk->sk_rcvbuf
Date: Sun,  7 Apr 2024 09:11:03 -0400
Message-ID: <20240407131130.1050321-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131130.1050321-1-sashal@kernel.org>
References: <20240407131130.1050321-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.4
Content-Transfer-Encoding: 8bit

From: linke li <lilinke99@qq.com>

[ Upstream commit c2deb2e971f5d9aca941ef13ee05566979e337a4 ]

sk->sk_rcvbuf in __sock_queue_rcv_skb() and __sk_receive_skb() can be
changed by other threads. Mark this as benign using READ_ONCE().

This patch is aimed at reducing the number of benign races reported by
KCSAN in order to focus future debugging effort on harmful races.

Signed-off-by: linke li <lilinke99@qq.com>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/core/sock.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 5e78798456fd8..61c14623a2185 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -481,7 +481,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -551,7 +551,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
-- 
2.43.0


