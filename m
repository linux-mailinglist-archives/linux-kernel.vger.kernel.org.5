Return-Path: <linux-kernel+bounces-134486-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF6889B213
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 15:38:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F18A1C20DF4
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE12A137C22;
	Sun,  7 Apr 2024 13:14:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XNg7RdFM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09AC7137930;
	Sun,  7 Apr 2024 13:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712495649; cv=none; b=rPydtcRCjC3uG9icxVDSFWKK+aErZPKMj6OIVRb8pp/traO8cY4pkCUmYRc7AyRnUfFWVeUUVNPnH+q7alr39i7VovqC+YXM9WaHvJoBaHRGcE5KlM4W6aauquggdK9CGWqHuTCDpzKThr+RkOlN8YhonGLE5xTqr2v33d1ieHY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712495649; c=relaxed/simple;
	bh=UYyMCdPvWTUdw/iYG3YvOxQUkQC5QMU51kyPqJnQYSs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RjEeFTkX/QM5Ac+syyY+gg43YZqcajDkrxKaKpTaGpREyiE2zwY7eeavCSp7ElflY3HQ9TgIvIWC2WYGkEH7CPBbAbCYs1iywAMroqnVkTyKoaPFupzUcCHdl1dk+SwZs1KBLu4BdLlbrPev0CmWPJgxsiOcDsFbBmtNPUXAYOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XNg7RdFM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20590C43390;
	Sun,  7 Apr 2024 13:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712495648;
	bh=UYyMCdPvWTUdw/iYG3YvOxQUkQC5QMU51kyPqJnQYSs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XNg7RdFMUW/lXOnYUNeURLdMKpT/ky9OoHbrUVvcLk+9GLuqFWDk8cWY60zYq5O53
	 WZtw2I29gw309U3W1WeInUoPp6Wxldivyey6BKhA7lWUHNat8BUkeY67svfqY9niBt
	 AvmxYen4cMvaUuwfJ0nFIRLGjj0LhAhietHC38LDH1SwMXA0ScRp2dc2d2ObUmB0zq
	 XcrW+24INmsWEYWkJV5SpTEvJi+lTWjH/J0xW2aSEaNmF8h3xOZfBOhSGVeeW/l7dE
	 rZg7ibjkg7/0mkLn7m9884fiLpTP+81SPh/daHTPU/2517I3AUu2dHzANQKUIHiHXv
	 50cqTgEzevoqw==
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
	wuyun.abel@bytedance.com,
	leitao@debian.org,
	alexander@mihalicyn.com,
	dhowells@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 5/7] net: mark racy access on sk->sk_rcvbuf
Date: Sun,  7 Apr 2024 09:13:56 -0400
Message-ID: <20240407131400.1053377-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240407131400.1053377-1-sashal@kernel.org>
References: <20240407131400.1053377-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.214
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
index 016c0b9e01b70..b4ecd0071e220 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -440,7 +440,7 @@ int __sock_queue_rcv_skb(struct sock *sk, struct sk_buff *skb)
 	unsigned long flags;
 	struct sk_buff_head *list = &sk->sk_receive_queue;
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf) {
+	if (atomic_read(&sk->sk_rmem_alloc) >= READ_ONCE(sk->sk_rcvbuf)) {
 		atomic_inc(&sk->sk_drops);
 		trace_sock_rcvqueue_full(sk, skb);
 		return -ENOMEM;
@@ -492,7 +492,7 @@ int __sk_receive_skb(struct sock *sk, struct sk_buff *skb,
 
 	skb->dev = NULL;
 
-	if (sk_rcvqueues_full(sk, sk->sk_rcvbuf)) {
+	if (sk_rcvqueues_full(sk, READ_ONCE(sk->sk_rcvbuf))) {
 		atomic_inc(&sk->sk_drops);
 		goto discard_and_relse;
 	}
-- 
2.43.0


