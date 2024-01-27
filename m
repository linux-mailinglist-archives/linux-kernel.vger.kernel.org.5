Return-Path: <linux-kernel+bounces-40977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A7E483E92E
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:01:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7866228C75C
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFD9A11716;
	Sat, 27 Jan 2024 02:01:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="F4KkgIgm"
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98EBEB66C
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 02:01:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706320886; cv=none; b=Hdx0T3LsdcngWewZSCtr1etObgJKJFD8jvB36ReiuEtgDHFknVVnOjV6Y/oMhAookpCcRysGJU4XrAYkVuqcXGjZ4yhCTuvgw29zYhc8djyn6Gb4PpjXpaBFYvgdogNsP3LXs9U6kx+55PzNVdOISFxG2L+Srl48QFmL89JtD8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706320886; c=relaxed/simple;
	bh=pn08eJXs7OnPxSN3c37dEpPPa01CX6MaTgxVEqfxj/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kPol6E0KcYMMqSExB+AlN3Fh+rFj+yThAOWKHz7iMyKizYrGi9+o2dsZLt1e7oceWuET/LZAmqWSTf/RIuXRKxGkwkkHeQD2zt5VSbPQ6o1u6xexGH9+ZmDZqH2X5V2myhYDf632z5HX4U+FKUBzphnWoXoXAIleGlW08lQfXCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=F4KkgIgm; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706320882;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3Eqaf0JpcfE9VphQ2k45PLVkc2qGy56bLUTBAo+DzE=;
	b=F4KkgIgmy9OcwE8R7133eu10UjSiwQ1vtF3lEAuLstprPg8mmQNw459i07XrtJKuoEInSd
	KGODWGEyybcTIMH1FA+OsjO/ieWDxnXaJhcyoe+XjVAVJ0I3CNUQzvkdYv50vlcGnx4t4B
	m87eQSBMwzmxcmk73I7VnSpOFATmdnc=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vgerkernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	peterz@infradead.org,
	boqun.feng@gmail.com
Subject: [PATCH 3/4] net: Convert sk->sk_peer_lock to lock_set_cmp_fn_ptr_order()
Date: Fri, 26 Jan 2024 21:01:07 -0500
Message-ID: <20240127020111.487218-4-kent.overstreet@linux.dev>
In-Reply-To: <20240127020111.487218-1-kent.overstreet@linux.dev>
References: <20240127020111.487218-1-kent.overstreet@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Cc: netdev@vger.kernel.org
Signed-off-by: Kent Overstreet <kent.overstreet@linux.dev>
---
 net/core/sock.c    | 1 +
 net/unix/af_unix.c | 4 ++--
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 158dbdebce6a..da7360c0f454 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -3474,6 +3474,7 @@ void sock_init_data_uid(struct socket *sock, struct sock *sk, kuid_t uid)
 	sk->sk_peer_pid 	=	NULL;
 	sk->sk_peer_cred	=	NULL;
 	spin_lock_init(&sk->sk_peer_lock);
+	lock_set_cmp_fn_ptr_order(&sk->sk_peer_lock);
 
 	sk->sk_write_pending	=	0;
 	sk->sk_rcvlowat		=	1;
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index ac1f2bc18fc9..d013de3c5490 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -706,10 +706,10 @@ static void copy_peercred(struct sock *sk, struct sock *peersk)
 
 	if (sk < peersk) {
 		spin_lock(&sk->sk_peer_lock);
-		spin_lock_nested(&peersk->sk_peer_lock, SINGLE_DEPTH_NESTING);
+		spin_lock(&peersk->sk_peer_lock);
 	} else {
 		spin_lock(&peersk->sk_peer_lock);
-		spin_lock_nested(&sk->sk_peer_lock, SINGLE_DEPTH_NESTING);
+		spin_lock(&sk->sk_peer_lock);
 	}
 	old_pid = sk->sk_peer_pid;
 	old_cred = sk->sk_peer_cred;
-- 
2.43.0


