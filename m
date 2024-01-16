Return-Path: <linux-kernel+bounces-26789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B018582E638
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 02:08:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F3A861F230FE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:08:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7BCA5EE63;
	Tue, 16 Jan 2024 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AIb8tav7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B355DF29;
	Tue, 16 Jan 2024 00:28:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DD83C43390;
	Tue, 16 Jan 2024 00:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364879;
	bh=g3bcivAKn0friZOA2I1L1tS15KZXFwC188tBDc9nBdE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AIb8tav7IHQ8hvb4a2D+CATajSJKX/ZzFGdcPuBHMwycelSmxaRwcYUFVOGIaDJwP
	 Arruc2qJ5ig18aKbUQ4Fl4pNM/UMzPKRE6BVpmKvvP8Q4snNzlBSftK+NLkIssT0Cz
	 8hp8SnNQtr0/dzCoF96XG5IZiMCtCYtlfMEPTK1gKGr722p2n7Ml/2GF0Z/c/CtyKi
	 PuyMQmMjCHzQVFkbX2MQa/DFJcGbfWMb1ESu4qApfTmyk2Ra/ul+djRt8NW9FhGPrT
	 KLal4VNWvfwDX6LeUZFrKez54pwAUajoVhKGi80LyKxfiROLAlHoY5y/QohVQn84Ac
	 0EdwbqaheHivw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Oleg Nesterov <oleg@redhat.com>,
	David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	linux-afs@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH AUTOSEL 5.4 09/12] afs: fix the usage of read_seqbegin_or_lock() in afs_find_server*()
Date: Mon, 15 Jan 2024 19:27:15 -0500
Message-ID: <20240116002731.216549-9-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002731.216549-1-sashal@kernel.org>
References: <20240116002731.216549-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.267
Content-Transfer-Encoding: 8bit

From: Oleg Nesterov <oleg@redhat.com>

[ Upstream commit 1702e0654ca9a7bcd7c7619c8a5004db58945b71 ]

David Howells says:

 (5) afs_find_server().

     There could be a lot of servers in the list and each server can have
     multiple addresses, so I think this would be better with an exclusive
     second pass.

     The server list isn't likely to change all that often, but when it does
     change, there's a good chance several servers are going to be
     added/removed one after the other.  Further, this is only going to be
     used for incoming cache management/callback requests from the server,
     which hopefully aren't going to happen too often - but it is remotely
     drivable.

 (6) afs_find_server_by_uuid().

     Similarly to (5), there could be a lot of servers to search through, but
     they are in a tree not a flat list, so it should be faster to process.
     Again, it's not likely to change that often and, again, when it does
     change it's likely to involve multiple changes.  This can be driven
     remotely by an incoming cache management request but is mostly going to
     be driven by setting up or reconfiguring a volume's server list -
     something that also isn't likely to happen often.

Make the "seq" counter odd on the 2nd pass, otherwise read_seqbegin_or_lock()
never takes the lock.

Signed-off-by: Oleg Nesterov <oleg@redhat.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/20231130115614.GA21581@redhat.com/
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/afs/server.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/afs/server.c b/fs/afs/server.c
index d3a9288f7556..44985ca6602e 100644
--- a/fs/afs/server.c
+++ b/fs/afs/server.c
@@ -35,7 +35,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 	const struct afs_addr_list *alist;
 	struct afs_server *server = NULL;
 	unsigned int i;
-	int seq = 0, diff;
+	int seq = 1, diff;
 
 	rcu_read_lock();
 
@@ -43,6 +43,7 @@ struct afs_server *afs_find_server(struct afs_net *net,
 		if (server)
 			afs_put_server(net, server, afs_server_trace_put_find_rsq);
 		server = NULL;
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_addr_lock, &seq);
 
 		if (srx->transport.family == AF_INET6) {
@@ -98,7 +99,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 {
 	struct afs_server *server = NULL;
 	struct rb_node *p;
-	int diff, seq = 0;
+	int diff, seq = 1;
 
 	_enter("%pU", uuid);
 
@@ -110,7 +111,7 @@ struct afs_server *afs_find_server_by_uuid(struct afs_net *net, const uuid_t *uu
 		if (server)
 			afs_put_server(net, server, afs_server_trace_put_uuid_rsq);
 		server = NULL;
-
+		seq++; /* 2 on the 1st/lockless path, otherwise odd */
 		read_seqbegin_or_lock(&net->fs_lock, &seq);
 
 		p = net->fs_servers.rb_node;
-- 
2.43.0


