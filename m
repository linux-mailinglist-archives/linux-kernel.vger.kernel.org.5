Return-Path: <linux-kernel+bounces-155161-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F02A58AE609
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27E5BB215FA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE918529E;
	Tue, 23 Apr 2024 12:27:47 +0000 (UTC)
Received: from mail-m1041.netease.com (mail-m1041.netease.com [154.81.10.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 526D478285;
	Tue, 23 Apr 2024 12:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=154.81.10.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875267; cv=none; b=uKFpIrXQzrhD9+hDndjjCi0csH0S1N1O19NAO+3NXS9nxk8kb88Efdu6dhxLDsv5AxxvUgs14CgkF+L0OaNcY2T5td3KZpj/AB8GTKE3judowVzw2dc0AKkzPgEYpyH4nrEFtlZQ+nnD1Qu4+G8leOOx9gGo6NKeRjA9tUNmYQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875267; c=relaxed/simple;
	bh=u6/C1yJRd8MJjmVCXRoTO9Hy08s48e5CyIph8InaR2Q=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=U0/Eey4z97hvOOxZEiyWbRm/O+Nj48q6iGmeDpso9aZ9AGcXNzVKx+Gd6pRBRz/orgr8TyggxMl0szKZWIr7JP4cVgI9uabZVV5Gl1rb10PkY+NH40XzmZGIfngO9pntJw+/YG7I33g8S0Z6ztPe2nzJNng3I8naFwGrBL7eOiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=154.81.10.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id B1CFD560145;
	Tue, 23 Apr 2024 15:37:54 +0800 (CST)
From: Jun Gu <jun.gu@easystack.cn>
To: pshelar@ovn.org
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Jun Gu <jun.gu@easystack.cn>
Subject: [PATCH net-next] net: openvswitch: Release reference to netdev
Date: Tue, 23 Apr 2024 15:37:51 +0800
Message-Id: <20240423073751.52706-1-jun.gu@easystack.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaGkJOVh0eGUhMGENOGUhOS1UZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8f09e3cb78023dkunmb1cfd560145
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PzI6MAw4OTcrMxJNFhQ5Pxgj
	GTAaC1FVSlVKTEpIQ05MQ0xOSkxOVTMWGhIXVREOFVUcDjseGggCCA8aGBBVGBVFWVdZEgtZQVlK
	SktVSkNOVUpMS1VJSUxZV1kIAVlBSkJISjcG

dev_get_by_name will provide a reference on the netdev. So ensure that
the reference of netdev is released after completed.

Fixes: 2540088b836f ("net: openvswitch: Check vport netdev name")
Signed-off-by: Jun Gu <jun.gu@easystack.cn>
---
 net/openvswitch/vport-netdev.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 618edc346c0f..91a11067e458 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -78,12 +78,16 @@ struct vport *ovs_netdev_link(struct vport *vport, const char *name)
 	int err;
 
 	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
+	if (!vport->dev) {
+		err = -ENODEV;
+		goto error_free_vport;
+	}
 	/* Ensure that the device exists and that the provided
 	 * name is not one of its aliases.
 	 */
-	if (!vport->dev || strcmp(name, ovs_vport_name(vport))) {
+	if (strcmp(name, ovs_vport_name(vport))) {
 		err = -ENODEV;
-		goto error_free_vport;
+		goto error_put;
 	}
 	netdev_tracker_alloc(vport->dev, &vport->dev_tracker, GFP_KERNEL);
 	if (vport->dev->flags & IFF_LOOPBACK ||
-- 
2.25.1


