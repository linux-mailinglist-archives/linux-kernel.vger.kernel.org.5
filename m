Return-Path: <linux-kernel+bounces-151148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 903A48AA9C2
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C177B1C2180F
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1CE84D9F7;
	Fri, 19 Apr 2024 08:07:41 +0000 (UTC)
Received: from mail-m17242.xmail.ntesmail.com (mail-m17242.xmail.ntesmail.com [45.195.17.242])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3099BA55
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.242
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713514061; cv=none; b=dQYiwie6ft/8GP124eVrSvV8SuO1EmxmKBR30jAa5BKrzZPgVByz0VPNaCJUolIhBgzeDtX+zlv826FpeKWGQfhMVpNkcpW5qLZFAU9BrwWmVcQRK7S6DbJ7ruDQgLTnephaeEHTHqeuaRxB9sNzjJ9k1f8t+GrMXuB3Hce3xk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713514061; c=relaxed/simple;
	bh=pzOxCylWvJGCwZv+rOPN3FLm28qjA4QGSVNGzit9gBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=lr4ohSyhZOi9ptSXmF10+hK3zRWk2UkOmsB1rCJ7QgLSReKtky7f/MI5fivOqjbh8tDxBfreOeeiWvLn4TEfMdnHNjUczm88cJkJb0VJyFTS2+bvocAcTmGAa38rr+1LC53KhWF9UC8BAnOTCyBCGECELIaos4TQb/tcJKoov9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn; spf=none smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.17.242
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id A43985601D7;
	Fri, 19 Apr 2024 12:31:56 +0800 (CST)
From: Jun Gu <jun.gu@easystack.cn>
To: kuba@kernel.org
Cc: dev@openvswitch.org,
	echaudro@redhat.com,
	jun.gu@easystack.cn,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v4] net: openvswitch: Check vport netdev name
Date: Fri, 19 Apr 2024 12:31:33 +0800
Message-Id: <20240419043133.117295-1-jun.gu@easystack.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240418023242.259542-1-jun.gu@easystack.cn>
References: <20240418023242.259542-1-jun.gu@easystack.cn>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0tMVh8fQ0weH08ZTR0fGVUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8ef4a01969023dkunma43985601d7
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Nj46Aio5KjcwAR9PFTNLFh0f
	LRIaCj9VSlVKTEpITktKSkpMS0JNVTMWGhIXVREOFVUcDjseGggCCA8aGBBVGBVFWVdZEgtZQVlK
	SktVSkNOVUpMS1VJSUxZV1kIAVlBSkJMSjcG

From: "jun.gu" <jun.gu@easystack.cn>

Ensure that the provided netdev name is not one of its aliases to
prevent unnecessary creation and destruction of the vport by
ovs-vswitchd.

Signed-off-by: jun.gu  <jun.gu@easystack.cn>
Acked-by: Eelco Chaudron <echaudro@redhat.com>
---
 net/openvswitch/vport-netdev.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 903537a5da22..618edc346c0f 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -78,7 +78,10 @@ struct vport *ovs_netdev_link(struct vport *vport, const char *name)
 	int err;
 
 	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
-	if (!vport->dev) {
+	/* Ensure that the device exists and that the provided
+	 * name is not one of its aliases.
+	 */
+	if (!vport->dev || strcmp(name, ovs_vport_name(vport))) {
 		err = -ENODEV;
 		goto error_free_vport;
 	}
-- 
2.25.1


