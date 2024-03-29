Return-Path: <linux-kernel+bounces-124198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF74A8913C2
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 07:31:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3061B1C24222
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 06:31:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B55A1E4AE;
	Fri, 29 Mar 2024 06:31:31 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5481EA5F;
	Fri, 29 Mar 2024 06:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711693890; cv=none; b=sM4X0LAEseYbnfXzLdc3x3mryD3KugpZYIO+bsyEfCc0qvIA0Gy1FtD5hjnelySanY5Qe2BslOpbMD/nbq+YXaVaFJLadMLoTmW0sYhLorQNT+hJif8skyRjLeSTMmLfswKmAhLUoJzDaflkaeY21syZ0umMRs/nhtqdjjXjIPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711693890; c=relaxed/simple;
	bh=uHozoKnGp0hXOQqs0eIHvbbie1iy4qHVQYwmZblr1NE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=LdCeMZ0ThPqu8k/t+b5VnuAPIbOcLPHCZJDgFUttJVlQOhSYYHhdWfH50VEgm+wBUicDy0vcj4AM4JfunPpSRH932ADS252KQ1dw4eT7FUqympQK6jeFrNlrPyxh/7rEzD1DywBqD8SBxXnR5npR4oy4oa8mi2r7+KyqS9gCiHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4V5Vpq4DP7zwQZL;
	Fri, 29 Mar 2024 14:28:35 +0800 (CST)
Received: from dggpemd200003.china.huawei.com (unknown [7.185.36.122])
	by mail.maildlp.com (Postfix) with ESMTPS id D109A140158;
	Fri, 29 Mar 2024 14:31:17 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 dggpemd200003.china.huawei.com (7.185.36.122) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Fri, 29 Mar 2024 14:31:17 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <gregkh@linuxfoundation.org>, <zhangfei.gao@linaro.org>,
	<wangzhou1@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <shenyang39@huawei.com>, <liulongfang@huawei.com>,
	<qianweili@huawei.com>
Subject: [PATCH] misc: uacce - add the null check for the input pointer and its pointer members
Date: Fri, 29 Mar 2024 14:26:55 +0800
Message-ID: <20240329062655.3055646-1-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemd200003.china.huawei.com (7.185.36.122)

The uacce_alloc() is the member of the EXPORT_SYMBOL_GPL. Therefore, null
pointer verification is added on the pointer type input parameter and its
pointer members.

Signed-off-by: Chenghai Huang <huangchenghai2@huawei.com>
---
 drivers/misc/uacce/uacce.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/misc/uacce/uacce.c b/drivers/misc/uacce/uacce.c
index bdc2e6fda782..964f1a6a16e0 100644
--- a/drivers/misc/uacce/uacce.c
+++ b/drivers/misc/uacce/uacce.c
@@ -514,6 +514,9 @@ struct uacce_device *uacce_alloc(struct device *parent,
 	struct uacce_device *uacce;
 	int ret;
 
+	if (!parent || !interface || !interface->ops)
+		return ERR_PTR(-EINVAL);
+
 	uacce = kzalloc(sizeof(struct uacce_device), GFP_KERNEL);
 	if (!uacce)
 		return ERR_PTR(-ENOMEM);
-- 
2.30.0


