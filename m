Return-Path: <linux-kernel+bounces-11458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 18CCB81E6A4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 10:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C382C1F2282B
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 09:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F7C44FF74;
	Tue, 26 Dec 2023 09:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="m1VmFSIP"
X-Original-To: linux-kernel@vger.kernel.org
Received: from out-185.mta1.migadu.com (out-185.mta1.migadu.com [95.215.58.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C10E4F8B7
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 09:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1703583840;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0IDZtbG4v2D/3gzZBAnMhXPdGFBE/PiGd8NWFLJcQ2o=;
	b=m1VmFSIPCMZXkXzuvhyam10aXz9xdCdqT28CAdMEESVSM+XFsNpmxgeCXNrxPkzkyuBbQo
	nWKrmaQnlFJfCg2iWHt7daKDptR0HMNrlMfK241CVmYB3imjIbigjfFYL4f4mdiQx71CRk
	DIzApJcx+sOKDWeBa9ja4bJu69/7S+I=
From: George Guo <dongtai.guo@linux.dev>
To: horms@kernel.org,
	pablo@netfilter.org,
	kadlec@netfilter.org,
	fw@strlen.de,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netfilter-devel@vger.kernel.org,
	coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	George Guo <guodongtai@kylinos.cn>
Subject: [PATCH 09/14] netfilter: cleanup struct nft_expr_ops
Date: Tue, 26 Dec 2023 17:42:50 +0800
Message-Id: <20231226094255.77911-9-dongtai.guo@linux.dev>
In-Reply-To: <20231226094255.77911-1-dongtai.guo@linux.dev>
References: <20231226094255.77911-1-dongtai.guo@linux.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: George Guo <guodongtai@kylinos.cn>

Add comments for clone, destroy_clone, reduce, gc, offload,
offload_action, offload_stats in struct nft_expr_ops.

Signed-off-by: George Guo <guodongtai@kylinos.cn>
---
 include/net/netfilter/nf_tables.h | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/include/net/netfilter/nf_tables.h b/include/net/netfilter/nf_tables.h
index 65c41dcdd4be..208cfedb083c 100644
--- a/include/net/netfilter/nf_tables.h
+++ b/include/net/netfilter/nf_tables.h
@@ -892,14 +892,22 @@ struct nft_offload_ctx;
  *	struct nft_expr_ops - nf_tables expression operations
  *
  *	@eval: Expression evaluation function
+ *	@clone: Expression clone function
  *	@size: full expression size, including private data size
  *	@init: initialization function
  *	@activate: activate expression in the next generation
  *	@deactivate: deactivate expression in next generation
  *	@destroy: destruction function, called after synchronize_rcu
+ *	@destroy_clone: destruction clone function
  *	@dump: function to dump parameters
- *	@type: expression type
  *	@validate: validate expression, called during loop detection
+ *	@reduce: reduce expression
+ *	@gc: garbage collection expression
+ *	@offload: hardware offload expression
+ *	@offload_action: function to report true/false to allocate one slot or not in the flow
+ *			 offload array
+ *	@offload_stats: function to synchronize hardware stats via updating the counter expression
+ *	@type: expression type
  *	@data: extra data to attach to this expression operation
  */
 struct nft_expr_ops {
-- 
2.39.2


