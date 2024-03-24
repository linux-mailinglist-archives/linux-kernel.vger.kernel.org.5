Return-Path: <linux-kernel+bounces-114982-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A3B6888C5A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:17:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 34DE3299073
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6D832E261D;
	Mon, 25 Mar 2024 00:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WYZ7k6Jp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2361F17B4E5;
	Sun, 24 Mar 2024 23:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323717; cv=none; b=PACK4sBvJ2zFzF0Va37Vhqa9HvNSYVQTEXX81sLDWO0bCqVY2RCwf1QoXPbIYTmAyuB3r28TTSNIEJ0WuTzbf9CE6X0CxTW0W84GpIb2gB2piO9L0UwUDx+Dams0n47OV4JPXZARbPtGRptWG/UEln3BlZz2KIeeLm6dkJwZIgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323717; c=relaxed/simple;
	bh=K+Xpuwf56IPWk0Z3Cq3W5AKOV0k9jOIqiiMEoMpAU3I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RSymJLZGgg4qhnRZ3C0r6QaBXANlGnLByR1Sdn5HnFt8ownwb9Q0Zha0wlSV8kgIUEMKT8K9xwVWVeJa1eiMsF627/0L9OUNJyY5O5Vp3qFCdarDof1tO+HY3EvMOwN8PdaGbgbODW2UIh2zFEdhRSxlHRZc4nmlyYPbkLOyLxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WYZ7k6Jp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 410F2C433C7;
	Sun, 24 Mar 2024 23:41:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323716;
	bh=K+Xpuwf56IPWk0Z3Cq3W5AKOV0k9jOIqiiMEoMpAU3I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WYZ7k6JpzAM9bpwyEJZmwVkxtdtwBw+pBjLiZYTP5MmXiqwBdIuoznzX5dZR6y7Xi
	 Q/44Hlpn+fLii6kp7WnFJ0qRn2J4rtjcwSXiAEj+jDK+IJVlX08ozHvG6dgvgHt35T
	 QPCfGJc3h9700so6hiUqoQ9hUIoAT/bwccWTsb1dlvEK6Ks3a1bEnEgEvzYV4JT42r
	 K/AYlABMMdmiMnvOTqUx2gVxCcX/06+CcGOT4B2WZMPhRTkDyXlpVyy/p37KZ5umNp
	 fWet+QXJx0pN3PmH85TldqNe4dWjyIkjJp898699YoPNRD60nXSu2bK+EdWrzlZZmk
	 PxbkxuQE3HoBA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Roman Gushchin <guro@fb.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Song Liu <songliubraving@fb.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 089/238] bpf: Eliminate rlimit-based memory accounting for devmap maps
Date: Sun, 24 Mar 2024 19:37:57 -0400
Message-ID: <20240324234027.1354210-90-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Roman Gushchin <guro@fb.com>

[ Upstream commit 844f157f6c0a905d039d2e20212ab3231f2e5eaf ]

Do not use rlimit-based memory accounting for devmap maps.
It has been replaced with the memcg-based memory accounting.

Signed-off-by: Roman Gushchin <guro@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Acked-by: Song Liu <songliubraving@fb.com>
Link: https://lore.kernel.org/bpf/20201201215900.3569844-23-guro@fb.com
Stable-dep-of: 281d464a34f5 ("bpf: Fix DEVMAP_HASH overflow check on 32-bit arches")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/bpf/devmap.c | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/kernel/bpf/devmap.c b/kernel/bpf/devmap.c
index 01149821ded91..ca2cade2871b8 100644
--- a/kernel/bpf/devmap.c
+++ b/kernel/bpf/devmap.c
@@ -109,8 +109,6 @@ static inline struct hlist_head *dev_map_index_hash(struct bpf_dtab *dtab,
 static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 {
 	u32 valsize = attr->value_size;
-	u64 cost = 0;
-	int err;
 
 	/* check sanity of attributes. 2 value sizes supported:
 	 * 4 bytes: ifindex
@@ -135,21 +133,13 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 
 		if (!dtab->n_buckets) /* Overflow check */
 			return -EINVAL;
-		cost += (u64) sizeof(struct hlist_head) * dtab->n_buckets;
-	} else {
-		cost += (u64) dtab->map.max_entries * sizeof(struct bpf_dtab_netdev *);
 	}
 
-	/* if map size is larger than memlock limit, reject it */
-	err = bpf_map_charge_init(&dtab->map.memory, cost);
-	if (err)
-		return -EINVAL;
-
 	if (attr->map_type == BPF_MAP_TYPE_DEVMAP_HASH) {
 		dtab->dev_index_head = dev_map_create_hash(dtab->n_buckets,
 							   dtab->map.numa_node);
 		if (!dtab->dev_index_head)
-			goto free_charge;
+			return -ENOMEM;
 
 		spin_lock_init(&dtab->index_lock);
 	} else {
@@ -157,14 +147,10 @@ static int dev_map_init_map(struct bpf_dtab *dtab, union bpf_attr *attr)
 						      sizeof(struct bpf_dtab_netdev *),
 						      dtab->map.numa_node);
 		if (!dtab->netdev_map)
-			goto free_charge;
+			return -ENOMEM;
 	}
 
 	return 0;
-
-free_charge:
-	bpf_map_charge_finish(&dtab->map.memory);
-	return -ENOMEM;
 }
 
 static struct bpf_map *dev_map_alloc(union bpf_attr *attr)
-- 
2.43.0


