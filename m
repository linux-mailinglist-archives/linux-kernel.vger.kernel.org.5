Return-Path: <linux-kernel+bounces-143839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFAFB8A3E15
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 20:18:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7FB91C208E5
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:18:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9738852F92;
	Sat, 13 Apr 2024 18:17:52 +0000 (UTC)
Received: from mail-m17246.xmail.ntesmail.com (mail-m17246.xmail.ntesmail.com [45.195.17.246])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1089C405F7;
	Sat, 13 Apr 2024 18:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.246
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713032272; cv=none; b=b9IYhTwpGqs3iAdZ48h9adFWi6Z7h7lCo2zNqU9a9/x7FxgrZOeHk4R7+xPDsTNZD6byxBlMNj3UM1p35Gy+r6xrK7Du+UB0MnoblUDqAGl02+KtIcaZgyMYC0CigYe7yT5SmBB/r7ToWVVtsUT0aPh7kNPg6Q0l8a2YQOynSW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713032272; c=relaxed/simple;
	bh=Mw0Udc146w+DJVcHuKpu3Yw25YQxQGimARuVph8en5M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hLkHble++1EhLYGajoNjLf/m3lC7f98k2/wIDhhq3N45/0QNA48bwR4CQz5ssThM/IQjzD38NHmDgyiBHu4JxKu1DmbGHFtLIn7gR3iibcE2d1/nxCETSrWdf8mWKkTwv10I42JrdqnLbbsVvIAhfCzLSU4xhM3Iy8JRT5cb/h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.17.246
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [IPV6:2409:8a62:79b:ed10:24be:fa63:4b9b:ba6e])
	by smtp.qiye.163.com (Hmail) with ESMTPA id 34398560169;
	Sat, 13 Apr 2024 16:48:54 +0800 (CST)
From: "jun.gu" <jun.gu@easystack.cn>
To: pshelar@ovn.org
Cc: netdev@vger.kernel.org,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	"jun.gu" <jun.gu@easystack.cn>
Subject: [PATCH] net: openvswitch: Check vport name
Date: Sat, 13 Apr 2024 16:48:26 +0800
Message-Id: <20240413084826.52417-1-jun.gu@easystack.cn>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVkaTUNMVk9OGh1MH0gZHUxLTFUZERMWGhIXJBQOD1
	lXWRgSC1lBWUlPS0JBQxpNSUFMQhlBHh9KS0FJTxkeQR0aTUhBTxlCGUEZGk0eWVdZFhoPEhUdFF
	lBWU9LSFVKTU9JTE5VSktLVUpCS0tZBg++
X-HM-Tid: 0a8ed6a53217023dkunm34398560169
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6Py46Cxw6NzcwGS4NK0pONhUM
	NBkKCgJVSlVKTEpJQkJDSkhPTkNOVTMWGhIXVREOFVUcDjseGggCCA8aGBBVGBVFWVdZEgtZQVlJ
	T0tCQUMaTUlBTEIZQR4fSktBSU8ZHkEdGk1IQU8ZQhlBGRpNHllXWQgBWUFKT0JPNwY+

Check vport name from dev_get_by_name, this can avoid to add and remove
NIC repeatedly when NIC rename failed at system startup.

Signed-off-by: Jun Gu <jun.gu@easystack.cn>
---
 net/openvswitch/vport-netdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/openvswitch/vport-netdev.c b/net/openvswitch/vport-netdev.c
index 903537a5da22..de8977d7f329 100644
--- a/net/openvswitch/vport-netdev.c
+++ b/net/openvswitch/vport-netdev.c
@@ -78,7 +78,7 @@ struct vport *ovs_netdev_link(struct vport *vport, const char *name)
 	int err;
 
 	vport->dev = dev_get_by_name(ovs_dp_get_net(vport->dp), name);
-	if (!vport->dev) {
+	if (!vport->dev) || strcmp(name, ovs_vport_name(vport)) {
 		err = -ENODEV;
 		goto error_free_vport;
 	}
-- 
2.25.1


