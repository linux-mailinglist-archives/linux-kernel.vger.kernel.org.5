Return-Path: <linux-kernel+bounces-41012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3083E99D
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 03:15:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94C9A1C24320
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Jan 2024 02:15:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DE81DA34;
	Sat, 27 Jan 2024 02:08:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vPx2lXWr"
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AF4B14274
	for <linux-kernel@vger.kernel.org>; Sat, 27 Jan 2024 02:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706321327; cv=none; b=d8OdhFmZRnGkDVuo/l88NgOGJnb9qM9pyxuhKaMo/nBLtJEmV13Na4+PCt4MTjSOm9JXnmUAjdqglZyuKKyGCLflwrMorWXq2yNLso6I5q8rmjB8puH8ESlYMsXr6Sl0py1bbxHvJDtNF5z1KwZdPPmBwPLQ7D89URUpzHLElZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706321327; c=relaxed/simple;
	bh=pn08eJXs7OnPxSN3c37dEpPPa01CX6MaTgxVEqfxj/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIOkSiLQ8hWuenpWvG3ziEkrnQSl40wndbhOBlIT8K1Hc/iFN6WscgDJjJG9E31o1+TzvWA7lD+OgDU3QrJ42+54OLiR6DDcWiZJUPbK+flbnm0F6i+WSyZdNwUWmQNHA2ow4hrNfBIZadYdrNXwcqMi50epDprgfsXan0+Ep3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vPx2lXWr; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1706321323;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n3Eqaf0JpcfE9VphQ2k45PLVkc2qGy56bLUTBAo+DzE=;
	b=vPx2lXWr9tcHGNC+54266m4I5ZFB0bMBCYBcm95hK18A/i6lbfbV2osBlEQRdcUNMpVu20
	6Ssh5ZGyhngGcYn72bo2I8oqgsP7m6dfu5Q4oHlUu7g87bYiWSLBO4/21mPcbIrciEuI6e
	dpK5TGsVN1S6s2l5Jb0EARayllJw9LY=
From: Kent Overstreet <kent.overstreet@linux.dev>
To: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-fsdevel@vger.kernel.org
Cc: Kent Overstreet <kent.overstreet@linux.dev>,
	peterz@infradead.org,
	boqun.feng@gmail.com
Subject: [PATCH 3/4] net: Convert sk->sk_peer_lock to lock_set_cmp_fn_ptr_order()
Date: Fri, 26 Jan 2024 21:08:30 -0500
Message-ID: <20240127020833.487907-4-kent.overstreet@linux.dev>
In-Reply-To: <20240127020833.487907-1-kent.overstreet@linux.dev>
References: <20240127020833.487907-1-kent.overstreet@linux.dev>
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


