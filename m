Return-Path: <linux-kernel+bounces-146550-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC418A6704
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 11:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C791C21AFD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 09:21:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70DC084DE4;
	Tue, 16 Apr 2024 09:21:24 +0000 (UTC)
Received: from mail-m17218.xmail.ntesmail.com (mail-m17218.xmail.ntesmail.com [45.195.17.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C1DEEB7;
	Tue, 16 Apr 2024 09:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.195.17.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713259284; cv=none; b=KpY2LafUJF0ZhA6apQ2nkvhnKj8t6YnLIYKdvrML7w6iZNLs81MKsvAdFX6a5nLRUOT05pIcNyDH2udiLPHmX94USlUvJJbsxQajet5dRpM7wAeH3yn6UsjoTYrjcoWX0XbEKYZKavqDleixLSzsNzKkjgwh9Pve5Z/cTEyZx5o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713259284; c=relaxed/simple;
	bh=ZrWqunt2M13HDfUp3oWrpInp1x6kLgr26fgi2oG168U=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OU6069qgnE8sPrzIy8snYe22oqItsqzOEqn3rapXLjEXW7/g2ng6bCl2eORCX+ukr/TmXHfUl/yfccXBX6g1F2/om8eKrxEazGLc8J+yN71CICEm51nMS56jCoCLxSUUTK0NL9eIA/sL1J2gcy7BM40N/93pOP9bFJFuDafIyDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn; spf=pass smtp.mailfrom=easystack.cn; arc=none smtp.client-ip=45.195.17.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=easystack.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=easystack.cn
Received: from localhost.localdomain (unknown [110.185.170.227])
	by smtp.qiye.163.com (Hmail) with ESMTPA id C2FB3560340;
	Tue, 16 Apr 2024 17:20:37 +0800 (CST)
From: "jun.gu" <jun.gu@easystack.cn>
To: echaudro@redhat.com
Cc: dev@openvswitch.org,
	jun.gu@easystack.cn,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	pshelar@ovn.org
Subject: [PATCH v2] net: openvswitch: Check vport net device name
Date: Tue, 16 Apr 2024 17:20:22 +0800
Message-Id: <20240416092022.35887-1-jun.gu@easystack.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <084E7217-6290-46D2-A47A-14ACB60EBBCA@redhat.com>
References: <084E7217-6290-46D2-A47A-14ACB60EBBCA@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFJQjdXWS1ZQUlXWQ8JGhUIEh9ZQVlCQhkdVkwZHhpDTkxIGBlDGlUZERMWGhIXJBQOD1
	lXWRgSC1lBWUpKS1VKQ05VSkxLVUlJTFlXWRYaDxIVHRRZQVlPS0hVSk1PSUxOVUpLS1VKQktLWQ
	Y+
X-HM-Tid: 0a8ee6355216023dkunmc2fb3560340
X-HM-MType: 1
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6ORg6ERw6KDcyPyIzNjcUSS0s
	Q0oKFCNVSlVKTEpISU5CSUhDSUlLVTMWGhIXVREOFVUcDjseGggCCA8aGBBVGBVFWVdZEgtZQVlK
	SktVSkNOVUpMS1VJSUxZV1kIAVlBSU5ISjcG

Check vport net device name to avoid the name that be used to query is
inconsistent the retured name.

Consider net device supports alias, the alias can be set to interface
table in ovs userspace. Consider the following process:
- set a net device alias to interface table.
- ovs userspace run OVS_VPORT_CMD_NEW cmd to kernel, kernel will use net
device alias to query net device by dev_get_by_name, but the net device
name that return is inconsistent the name used to query.
- the returned net device name is saved a hash table.
- ovs userspace found that the name saved to interface table is
inconsistent the name saved kernel hash table, it will run
OVS_VPORT_CMD_DEL cmd to kernel and remove vport.

ovs userspace will run OVS_VPORT_CMD_NEW and OVS_VPORT_CMD_DEL cmd
repeatedly. So the patch will check vport net device name from
dev_get_by_name to avoid the above issue.

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


