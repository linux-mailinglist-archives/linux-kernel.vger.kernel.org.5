Return-Path: <linux-kernel+bounces-147966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 084738A7BEE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 07:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B29E91F22034
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 05:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CC0252F80;
	Wed, 17 Apr 2024 05:40:11 +0000 (UTC)
Received: from mail-m6032.netease.com (mail-m6032.netease.com [210.79.60.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90803374D1;
	Wed, 17 Apr 2024 05:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713332410; cv=none; b=VBmu9zkwFkpyhm5B1XBj44SEHnkMgZEfqEufNd4wJr+g8qWqKvoaJe7Bq1FW0PxRKo7TuI0k5IYBVKbNbb0ZFDK59urzCeU18y9x7RzY0CnmM12u+c0gm2ihaJsA0qg0/OM4TDeWXtUWMilhEcK5Ka4V1b+AisVWHdyAJVTC62Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713332410; c=relaxed/simple;
	bh=Ltslny75LkzlJPbQlvxP8LqFwrA/4+HYUrJy8OCDhcM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=q1cFk9pH2v6q8GC5HZgvYMTw4F6xrs8AKGUOJ3z66kldJE0Ew/BECXJ0Ja9X+bRSidS+EW0SJnv4pcw2ooaK4+Ycfgo+3MLHDJyl/Sv0ILZmcTh9oBYJGmOrMzGI/z7XswAs1yMi6CtUTH1lR0qXK4eaSKdTgTqal0M5tDpMvc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=210.79.60.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 79C865601D6;
	Wed, 17 Apr 2024 12:20:48 +0800 (CST)
From: "jun.gu" <jun.gu@easystack.cn>
To: echaudro@redhat.com
Cc: dev@openvswitch.org,
	jun.gu@easystack.cn,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3] net: openvswitch: Check vport net device name
Date: Wed, 17 Apr 2024 12:20:31 +0800
Message-Id: <20240417042031.157008-1-jun.gu@easystack.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <27644212-924C-4AB2-88F6-D209E2586E82@redhat.com>
References: <27644212-924C-4AB2-88F6-D209E2586E82@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0IZVk0aSkNPQk8dTxlJTlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8eea493018023dkunm79c865601d6
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PyI6Iyo5FTcrQiEWDxcqDwIV
	FFYKCQFVSlVKTEpISElMTU9CSkpPVTMWGhIXVREOFVUcDjseGggCCA8aGBBVGBVFWVdZEgtZQVlK
	SktVSkNOVUpMS1VJSUxZV1kIAVlBSkNDQjcG

Check vport net device name to ensure the provided name is not one of
its aliases. This can avoid that ovs userspace create and destroy vport
repeatedly.

Signed-off-by: Jun Gu <jun.gu@easystack.cn>
---
 net/openvswitch/vport-netdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 903537a5da22..7003e76b8172 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -78,7 +78,10 @@ struct vport *ovs_netdev_link(struct vport *vport, const char *name)
 	int err;
 
 	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
-	if (!vport->dev) {
+	/* Ensure that the device exists and that the provided
+	 * name is not one of its aliases.
+	 */
+	if ((!vport->dev) || strcmp(name, ovs_vport_name(vport))) {
 		err = -ENODEV;
 		goto error_free_vport;
 	}
-- 
2.25.1


