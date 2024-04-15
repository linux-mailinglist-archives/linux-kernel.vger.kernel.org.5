Return-Path: <linux-kernel+bounces-144948-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 112378A4D06
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:54:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF23428175A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:54:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 986ED5EE73;
	Mon, 15 Apr 2024 10:54:13 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D7E5FB85;
	Mon, 15 Apr 2024 10:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713178453; cv=none; b=tZdsZ25HY8zosQqaqD1VGLaMfH62h6z/ehULadv5N8FE4wxFPk2RMy3reG3hASygC9fHpzsJTHnHGuzIwzYZbQXCBJlRN5WIm61wqYIegNGfKmB6zo2MZBW9EfkA0QMZ+6QzqqSnFk0UDammVs6BtjX1Y83Lc1pS4zQJ9ORWpOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713178453; c=relaxed/simple;
	bh=u+i3N7jlLOD5vzYSaTLemnLG3D1CGWWLFttmuOAvoi0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ROuIshM/yP/g1x5kiWNsOXbqC5L38d2bjoFPFQuxeNYnJd6lYzhGEhRTnUOwVoqg5Lh/NUdsktRcInX+Lyfy5ZRqZkqO7Cqglts19S+erl1DXmPnQoDarmLB1VaaqcRfTm0JJPz3HV+mswFw+ku896PUfGqrHfg5QOEvoQAwWhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VJ3qv4VK0zwSHQ;
	Mon, 15 Apr 2024 18:51:07 +0800 (CST)
Received: from kwepemi500024.china.huawei.com (unknown [7.221.188.100])
	by mail.maildlp.com (Postfix) with ESMTPS id 8BC9E1402DE;
	Mon, 15 Apr 2024 18:54:08 +0800 (CST)
Received: from huawei.com (10.175.103.91) by kwepemi500024.china.huawei.com
 (7.221.188.100) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 15 Apr
 2024 18:54:07 +0800
From: Zeng Heng <zengheng4@huawei.com>
To: <linus.walleij@linaro.org>
CC: <linux-kernel@vger.kernel.org>, <xiexiuqi@huawei.com>,
	<linux-gpio@vger.kernel.org>, <weiyongjun1@huawei.com>,
	<dan.carpenter@linaro.org>, <liwei391@huawei.com>
Subject: [PATCH] pinctrl: devicetree: fix refcount leak in pinctrl_dt_to_map()
Date: Mon, 15 Apr 2024 18:53:28 +0800
Message-ID: <20240415105328.3651441-1-zengheng4@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemi500024.china.huawei.com (7.221.188.100)

If we fail to allocate propname buffer, we need to drop the reference
count we just took. Because the pinctrl_dt_free_maps() includes the
droping operation, here we call it directly.

Fixes: 91d5c5060ee2 ("pinctrl: devicetree: fix null pointer dereferencing in pinctrl_dt_to_map")
Suggested-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Zeng Heng <zengheng4@huawei.com>
---
 drivers/pinctrl/devicetree.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/pinctrl/devicetree.c b/drivers/pinctrl/devicetree.c
index df1efc2e5202..6a94ecd6a8de 100644
--- a/drivers/pinctrl/devicetree.c
+++ b/drivers/pinctrl/devicetree.c
@@ -220,14 +220,16 @@ int pinctrl_dt_to_map(struct pinctrl *p, struct pinctrl_dev *pctldev)
 	for (state = 0; ; state++) {
 		/* Retrieve the pinctrl-* property */
 		propname = kasprintf(GFP_KERNEL, "pinctrl-%d", state);
-		if (!propname)
-			return -ENOMEM;
+		if (!propname) {
+			ret = -ENOMEM;
+			goto err;
+		}
 		prop = of_find_property(np, propname, &size);
 		kfree(propname);
 		if (!prop) {
 			if (state == 0) {
-				of_node_put(np);
-				return -ENODEV;
+				ret = -ENODEV;
+				goto err;
 			}
 			break;
 		}
-- 
2.25.1


