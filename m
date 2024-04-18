Return-Path: <linux-kernel+bounces-149909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3548E8A97C6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 12:50:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AD060B22426
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 10:50:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A0B315E208;
	Thu, 18 Apr 2024 10:50:10 +0000 (UTC)
Received: from mail-m6032.netease.com (mail-m6032.netease.com [210.79.60.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B48356464;
	Thu, 18 Apr 2024 10:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=210.79.60.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713437410; cv=none; b=EEP08Rfqffr1G8ba00a72pDaTWmbrA2q+xdgws6HQ+JCbU6ebtlSnhb6l49s79SbY9hw+8WvKJCRKoCgEMLaesn/gn3AgMtppoOtEDFQ4q3NvJpK0ynPv5FWOsemCdx/A9DURPmlSwzbvZULQwzPu6CvvErPebf6uoHNxrnjHqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713437410; c=relaxed/simple;
	bh=iiOufjOIkL3haOEHZ1PQmwIhrHyxYpHcfZJEjBfNLSk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=IP2GNsg+RZeiNzBVii8qOWgzzRdqfFEs1VraKGJgMPAF4XEtXTr5z699I8IMtHRjY707YUBU8Vb8ZTkWU/VaNOFpkYP/4mPCMvo5j19NmtUaibFbBMe2w9y+XJHBEYCpmk6CyQ7sSg6twnvs3CSbRvokomMMeD2qFJ7jeQbdwZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=210.79.60.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 6AE235601A7;
	Thu, 18 Apr 2024 10:32:44 +0800 (CST)
From: "jun.gu" <jun.gu@easystack.cn>
To: echaudro@redhat.com
Cc: dev@openvswitch.org,
	jun.gu@easystack.cn,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4] net: openvswitch: Check vport netdev name
Date: Thu, 18 Apr 2024 10:32:42 +0800
Message-Id: <20240418023242.259542-1-jun.gu@easystack.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <811765EC-AD27-4210-9AFC-034129F24BFA@redhat.com>
References: <811765EC-AD27-4210-9AFC-034129F24BFA@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlDSxhCVk9MTk1DT0pNSEkdSVUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8eef0c9ae6023dkunm6ae235601a7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6OC46HQw5Sjc4QhkLLBUhOUoc
	HUMwCS1VSlVKTEpIT0tMTk1PQ0pNVTMWGhIXVREOFVUcDjseGggCCA8aGBBVGBVFWVdZEgtZQVlK
	SktVSkNOVUpMS1VJSUxZV1kIAVlBSkJKTTcG

Ensure that the provided netdev name is not one of its aliases to
prevent unnecessary creation and destruction of the vport by
ovs-vswitchd.

Signed-off-by: Jun Gu <jun.gu@easystack.cn>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
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


