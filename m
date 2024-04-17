Return-Path: <linux-kernel+bounces-148280-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9918A8030
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:56:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8D4E21C21E4C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCC0813AD1D;
	Wed, 17 Apr 2024 09:55:46 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8CB1135A63
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347746; cv=none; b=WCZC0FjI4LgA+hL6OBmdTa+b0mAJIJ147JhFVzJGUEA5GB/ztzk8lfw0gN+IdKfsqsNgBsvAdX3Evm1K5KLPfmLVJlMpWblxmVBc6JKaqzTILi7fFFryDDbE5Us5YY53AQgD2Z66lcyLsQYroApDFNw6GXpnS5vPY1yATex82zU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347746; c=relaxed/simple;
	bh=/lXpYci1tMW5JPozoAh8F16UEmu1MI3zcs1be5M7z4s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AjcDMlJEUwffp8tv7ixDyot+f98xZLT6BAhF+rHgtwS5wki9RjftQ8OZhoFj6COQ6v9C7+LP4XPlkIEQrUr4o+hU0AY+nEbO9WWGEqgepAgB92ibC1qO7+7/6kIAez0ZLW777eG4BnVFzInKUX+dw5LMknVJwqscTrigdV/GoPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4VKGTz3GdHz1HCDN;
	Wed, 17 Apr 2024 17:54:47 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 21341180063;
	Wed, 17 Apr 2024 17:55:41 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 17:55:40 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH v2 1/2] soc: hisilicon: kunpeng_hccs: Add the check for obtaining complete port attribute
Date: Wed, 17 Apr 2024 17:48:00 +0800
Message-ID: <20240417094801.25393-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240417094801.25393-1-lihuisong@huawei.com>
References: <20240403081935.24308-1-lihuisong@huawei.com>
 <20240417094801.25393-1-lihuisong@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600004.china.huawei.com (7.193.23.242)

The hccs_get_all_port_attr() is used to obtained the attribute of all
ports on a specified DIE from firmware. However, this interface doesn't
ensure whether firmware reports the complete attribute of all ports or not.
So this patch adds the check for this.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/kunpeng_hccs.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/soc/hisilicon/kunpeng_hccs.c b/drivers/soc/hisilicon/kunpeng_hccs.c
index 9ff70b38e5e9..e882a61636ec 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -556,6 +556,12 @@ static int hccs_get_all_port_attr(struct hccs_dev *hdev,
 		start_id = rsp_head.next_id;
 	}
 
+	if (left_buf_len != 0) {
+		dev_err(hdev->dev, "failed to get the expected port number(%u) attribute.\n",
+			size);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.22.0


