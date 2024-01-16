Return-Path: <linux-kernel+bounces-26779-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C5DD782E61B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:05:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FE4F1F2221B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 906DD59158;
	Tue, 16 Jan 2024 00:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d0KMvo0N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC39358ADF;
	Tue, 16 Jan 2024 00:27:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A7F8C43390;
	Tue, 16 Jan 2024 00:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364835;
	bh=3vm7+BXA7/EsjoqhM2jUEQT5M8MkBeXDfSp9rDZzgl0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=d0KMvo0NRHwuy7BS82EknXeEwevrHsXuQ5mPleozi8/pqOnmU/UOWgaqlGqn9rXfG
	 TEAnsOCXSrEto1KFfeNi+3vSpT6utox0h47yYRIN/rSSMMe2FX409gu0kh64Dn6EQO
	 g4IGDs405XvxGTidFx/HATHM2kljiHpDJlYxCPxzJ15RyIO1D1iHPjsFwE5egC79s5
	 R8hbjaj8G1IvweVyHwume/RhYRtylj0DcjNr6l+71y6NRxHsHL/Lfzvq9l3s8oB7yz
	 r1o7C8a77fR6Xdhzl0ydrX/Lwbjzk7V0AUWSoheu3866kS3tFLkMcGBBXlE/RkkGWa
	 zBwLCE6Qsh4Pw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 11/12] rxrpc_find_service_conn_rcu: fix the usage of read_seqbegin_or_lock()
Date: Mon, 15 Jan 2024 19:26:36 -0500
Message-ID: <20240116002649.216260-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002649.216260-1-sashal@kernel.org>
References: <20240116002649.216260-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.208
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit bad1a11c0f061aa073bab785389fe04f19ba02e1 ]

rxrpc_find_service_conn_rcu() should make the "seq" counter odd on the
second pass, otherwise read_seqbegin_or_lock() never takes the lock.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20231117164846.GA10410@redhat.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rxrpc/conn_service.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/rxrpc/conn_service.c b/net/rxrpc/conn_service.c
index 68508166bbc0..af0e95ef992d 100644
--- a/net/rxrpc/conn_service.c
+++ b/net/rxrpc/conn_service.c
@@ -31,7 +31,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 	struct rxrpc_conn_proto k;
 	struct rxrpc_skb_priv *sp = rxrpc_skb(skb);
 	struct rb_node *p;
-	unsigned int seq = 0;
+	unsigned int seq = 1;
 
 	k.epoch	= sp->hdr.epoch;
 	k.cid	= sp->hdr.cid & RXRPC_CIDMASK;
@@ -41,6 +41,7 @@ struct rxrpc_connection *rxrpc_find_service_conn_rcu(struct rxrpc_peer *peer,
 		 * under just the RCU read lock, so we have to check for
 		 * changes.
 		 */
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&peer->service_conn_lock, &seq);
 
 		p = rcu_dereference_raw(peer->service_conns.rb_node);
-- 
2.43.0


