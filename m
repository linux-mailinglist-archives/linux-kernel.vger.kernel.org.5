Return-Path: <linux-kernel+bounces-159848-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2599E8B351B
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 12:16:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B4232B2332D
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 10:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0014E145B1F;
	Fri, 26 Apr 2024 10:15:35 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CE3614533C;
	Fri, 26 Apr 2024 10:15:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714126535; cv=none; b=jHl0ncW3OYfK/8K9iHUOdNpAYBCWQXFWf7PakXfu2PrDq4Sf4rOgCn1ICM7ocTfoEF1CDMAQS+NKCTpev4xIwtJlSv4h0//Iv77yQtpXAXw5zHqCxD0PpLisg3Lio4S5i9xqTXHVUD5qMD0lUwKXlE5MocPTmcDeE/PrpYtc4Gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714126535; c=relaxed/simple;
	bh=2fCUerJP7jfaJaj+usa/YK7IUw4+3HWZsB+B05Psgcs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p8wJ3OK7Pc8NFMdChGqZEtpr2bti8tIAtZHKhfGDw9GBT994SJJd76WVeUQLfWeKXEBv2AFAxntYb2wMJYs8UwUuiIa7MAxBxICbW83MXeLuICERjFrPKhP3qGLLjjoTE/0XTe3wlcPZpcNvosRu+V7tKvdpLbMSi1198UTs3jg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4VQpS60rmFzvPw9;
	Fri, 26 Apr 2024 18:12:22 +0800 (CST)
Received: from kwepemm600007.china.huawei.com (unknown [7.193.23.208])
	by mail.maildlp.com (Postfix) with ESMTPS id 62C381800C4;
	Fri, 26 Apr 2024 18:15:26 +0800 (CST)
Received: from localhost.localdomain (10.50.165.33) by
 kwepemm600007.china.huawei.com (7.193.23.208) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 18:15:19 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <jiri@resnulli.us>
CC: <shenjian15@huawei.com>, <wangjie125@huawei.com>,
	<liuyonglong@huawei.com>, <shaojijie@huawei.com>, <chenhao418@huawei.com>,
	<netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 net 1/7] net: hns3: direct return when receive a unknown mailbox message
Date: Fri, 26 Apr 2024 18:00:39 +0800
Message-ID: <20240426100045.1631295-2-shaojijie@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240426100045.1631295-1-shaojijie@huawei.com>
References: <20240426100045.1631295-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600007.china.huawei.com (7.193.23.208)

From: Jian Shen <shenjian15@huawei.com>

Currently, the driver didn't return when receive a unknown
mailbox message, and continue checking whether need to
generate a response. It's unnecessary and may be incorrect.

Fixes: bb5790b71bad ("net: hns3: refactor mailbox response scheme between PF and VF")
Signed-off-by: Jian Shen <shenjian15@huawei.com>
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
index d4a0e0be7a72..59c863306657 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3pf/hclge_mbx.c
@@ -1077,12 +1077,13 @@ static void hclge_mbx_request_handling(struct hclge_mbx_ops_param *param)
 
 	hdev = param->vport->back;
 	cmd_func = hclge_mbx_ops_list[param->req->msg.code];
-	if (cmd_func)
-		ret = cmd_func(param);
-	else
+	if (!cmd_func) {
 		dev_err(&hdev->pdev->dev,
 			"un-supported mailbox message, code = %u\n",
 			param->req->msg.code);
+		return;
+	}
+	ret = cmd_func(param);
 
 	/* PF driver should not reply IMP */
 	if (hnae3_get_bit(param->req->mbx_need_resp, HCLGE_MBX_NEED_RESP_B) &&
-- 
2.30.0


