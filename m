Return-Path: <linux-kernel+bounces-91305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF64B870CEA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 22:29:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9B04E28A7A9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 21:29:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAE27A706;
	Mon,  4 Mar 2024 21:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gACpX3zU"
Received: from mail-pg1-f175.google.com (mail-pg1-f175.google.com [209.85.215.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84286482DA
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 21:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709587776; cv=none; b=MaqUyvaDZP/mncLb2MPLEazEFuxrbC64gP1CZ1LHDCsMd/y/D9b8jpAW/qy8s2k3EyJ9YxGC1N6ZLYHP9foPxantS0tggMOyJB1mVlCLE+fwFoGyJ3NLszHw7XIBOQFz4LatkwJj6YszXQ4SMU8OkQEI5AZL7h1XoejqT7nJzPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709587776; c=relaxed/simple;
	bh=rNbVohFr1lX5bqscK9PE0eqcrmu5KWoLl5ZCdmYHEKc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cnnoivapu4OJ4AQ2gZfgtT1F5Lb5ZI6buS3c9HnIYhbw6HAww9AX6lmOSsUo4ShmLkgq275Q0eQux+ViXzzup2X45fPdchLZux6rICSV6bIiwx7iNNxU3oRkIuoj69TqNivCSX8GSZb/gSTcgys0LHHPNjVF0WP3Rt20G8G89RU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gACpX3zU; arc=none smtp.client-ip=209.85.215.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f175.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1834a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 13:29:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1709587775; x=1710192575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NqP29r2eazzveHXly0NG7eBRSXtQow90bgEnhzwvqjk=;
        b=gACpX3zUP4l6vhdrrqlfqMJ1OlGKwNF+MDclwQ/YZTq6tFagrF9MPUTMfS2Xk0RuqU
         +PCcrhO7WCPkI/v49m/RPQoCxXI2HbM6pR1PYucFL2PLZoDeRCoR27JeiLBxdfZvht4S
         hVNaUycxK7aV9vBpCFBzrhwk5jOOak4ju6wAI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709587775; x=1710192575;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NqP29r2eazzveHXly0NG7eBRSXtQow90bgEnhzwvqjk=;
        b=O7mvapdgd02s4fwKqkssboJ8cD5uG1jJ+PPXEMrxTKb6HSYtpKZEivd8kyQ/dY57mF
         RsXdtVU5DwmlAK2o++ZWFibyf+pgzudrpqZk4cxZpFkSzewFvlhXCIKpfuY2z6M1sqDX
         zFzNx8Xh+zFjTpTwgzEkyj0TbPoS48AW4pjLblEkIR3TCpxAhtCRuq5gzyk4Hr5ZenDb
         14riXSFKsmOXAt/Gc68uIP1cUdobJV1M59Thlp2Vx3L+ODQ5BuBODZtxYIRxsHECmXRR
         +bhleK20kC9NbdsfGzZOQ6cDs4OnEZ9V22WnxWWNA0yw/2Cb4G2AZbyTTn0Ai2Sw3ab6
         3nZQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3OhIwQkBdCSLE6V/+LBnqwUvrFzTdWqZ80J6LHSFPUCNYEQrFQXivgBNZ/oE4F0cvNJ27um0VTIt5aZlrv1/0t3MqReLPFWvbzOL+
X-Gm-Message-State: AOJu0YyLPTSmZvzmooTOaOf+gA6mPqFoodTDetfIrLKlvFvT3dYE0+Fn
	RGcmM9eaY8X5AdBsx/oJw6WesR28a+9VEVAsS9WAONlM7Lp4+56psXh1uUokdw==
X-Google-Smtp-Source: AGHT+IGU8j4KvUz1DwEvLk09jvZcoIyKd2+u1vN7u+r7I94kyQI8R7YbQP3ZcJO4Su8cxFfFi8huzQ==
X-Received: by 2002:a05:6a20:1609:b0:19e:3173:4bdd with SMTP id l9-20020a056a20160900b0019e31734bddmr2543274pzj.2.1709587774753;
        Mon, 04 Mar 2024 13:29:34 -0800 (PST)
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id b76-20020a63344f000000b005dc4829d0e1sm7871696pga.85.2024.03.04.13.29.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 13:29:33 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Kees Cook <keescook@chromium.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Abel Wu <wuyun.abel@bytedance.com>,
	Breno Leitao <leitao@debian.org>,
	Alexander Mikhalitsyn <alexander@mihalicyn.com>,
	David Howells <dhowells@redhat.com>,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Subject: [PATCH v3] sock: Use unsafe_memcpy() for sock_copy()
Date: Mon,  4 Mar 2024 13:29:31 -0800
Message-Id: <20240304212928.make.772-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2952; i=keescook@chromium.org;
 h=from:subject:message-id; bh=rNbVohFr1lX5bqscK9PE0eqcrmu5KWoLl5ZCdmYHEKc=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBl5j07GdCOGFZU/xyLkr9A/AuF584WDoUWMKmnm
 rO64d+93gyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZeY9OwAKCRCJcvTf3G3A
 JnnqEACD182Vp6ijr9bKxzF77cbxV5/bfYctEwChHnWMPKpfSkhfPu4gBkvIYpFMZ7rwLhSHou+
 UhddgLEJsmZk5GWJZmgO6WfcSETPxq8mGCjVOgcSD0JkCyUxzc6lEzMPKYtKlCXqS6KZRa/DWXm
 eZmxtRNj+owwM1gAIazXxZhNqfTRd/4qGJN9q0GsaqEOciPLcc5U7N8dirO7fS+47iwyQqSq1u4
 q560sRl2J3w0/9NvPHzFvWcnanuhRaQVX1ah6YTo3B3+hcsp4W/888bEKzm+garbBxj/aewNybG
 7oRd4NzY+JSeToqBH9dZCtkWkfzgGBO9laipqd/m+xieLa7Fj8e8zVThKsxx0cg/iMyGqf4fFwg
 aJtWPInCnSo7qKbKaue34lFeuiPCErczwwOjf/54eTgr/hW8urm1Orj41vZiQMt9Ew6FaK5Jn3V
 hCQneYBBizCkp2UhCujKFP3AOoqBbdKCODlR4ZOGgWUO6T2cehI38cG4tDRQtTXhHp6qYYqQg7k
 04q+BqYrGiNbMiBD839UYDgoMvbG/z8T/GMI6F2yBAJPnsPsJ3JArQECblvstN64t4bzxLn/wvD
 LyewMsxgh4mJ1iZgb+qPnk+kRbI51vVW1H6RjEYlZnG9ayHsZSRCB86TYQ4m7XXkdUZc5J5O8lG
 l1nwepV cfDK8Ucw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit

While testing for places where zero-sized destinations were still showing
up in the kernel, sock_copy() and inet_reqsk_clone() were found, which
are using very specific memcpy() offsets for both avoiding a portion of
struct sock, and copying beyond the end of it (since struct sock is really
just a common header before the protocol-specific allocation). Instead
of trying to unravel this historical lack of container_of(), just switch
to unsafe_memcpy(), since that's effectively what was happening already
(memcpy() wasn't checking 0-sized destinations while the code base was
being converted away from fake flexible arrays).

Avoid the following false positive warning with future changes to
CONFIG_FORTIFY_SOURCE:

  memcpy: detected field-spanning write (size 3068) of destination "&nsk->__sk_common.skc_dontcopy_end" at net/core/sock.c:2057 (size 0)

Signed-off-by: Kees Cook <keescook@chromium.org>
---
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org
 v3: fix inet_reqsk_clone() comment
 v2: https://lore.kernel.org/lkml/20240216232220.it.450-kees@kernel.org
 v1: https://lore.kernel.org/lkml/20240216204423.work.066-kees@kernel.org
---
 net/core/sock.c                 | 5 +++--
 net/ipv4/inet_connection_sock.c | 5 +++--
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/core/sock.c b/net/core/sock.c
index 0a7f46c37f0c..b7ea358eb18f 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -2053,8 +2053,9 @@ static void sock_copy(struct sock *nsk, const struct sock *osk)
 
 	memcpy(nsk, osk, offsetof(struct sock, sk_dontcopy_begin));
 
-	memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
-	       prot->obj_size - offsetof(struct sock, sk_dontcopy_end));
+	unsafe_memcpy(&nsk->sk_dontcopy_end, &osk->sk_dontcopy_end,
+		      prot->obj_size - offsetof(struct sock, sk_dontcopy_end),
+		      /* alloc is larger than struct, see sk_prot_alloc() */);
 
 #ifdef CONFIG_SECURITY_NETWORK
 	nsk->sk_security = sptr;
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 459af1f89739..6a14a44aa161 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -906,8 +906,9 @@ static struct request_sock *inet_reqsk_clone(struct request_sock *req,
 
 	memcpy(nreq_sk, req_sk,
 	       offsetof(struct sock, sk_dontcopy_begin));
-	memcpy(&nreq_sk->sk_dontcopy_end, &req_sk->sk_dontcopy_end,
-	       req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end));
+	unsafe_memcpy(&nreq_sk->sk_dontcopy_end, &req_sk->sk_dontcopy_end,
+		      req->rsk_ops->obj_size - offsetof(struct sock, sk_dontcopy_end),
+		      /* alloc is larger than struct, see above */);
 
 	sk_node_init(&nreq_sk->sk_node);
 	nreq_sk->sk_tx_queue_mapping = req_sk->sk_tx_queue_mapping;
-- 
2.34.1


