Return-Path: <linux-kernel+bounces-129331-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 622918968A4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:30:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94A731C222C1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEED871B49;
	Wed,  3 Apr 2024 08:27:10 +0000 (UTC)
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3548C6CDC2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132830; cv=none; b=EIEI4ElgnPzzOVBhRHIzWfDT/1o9nHExe2I4M4nAXxXDB+rF3apSaVTu9kjTwQqDpYIpiwTJjc3U10qrMOHuLz0vHwpcx3u3z13X3aHlGfkHVsXlCDORQzp6vbEE61NLLBDq8gzgS7xHAAhCjNL3xZ3VX/vvT/ESrun/Vry3JBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132830; c=relaxed/simple;
	bh=5Zgoa/lTop3pWi0GPKnDlpM7KZeP+t9NWazbbQD3v/k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BsCu8mI07c7xPQSiS6zSL9hYAZri+oRyV1KM/Qj1/FcteVrqELdgS/nOJc1U9+EytSEmaLaCBp9j4yTqx3hEw/KydbceaEZIWAM7Nnjdk1pwHn2rpsAXu73mOGe74a50aQbZ0f5tjcpjZ2jJiwsa9If+aV/Wv7tysbFCIQZG1co=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4V8d7y2YQxz1R8dx;
	Wed,  3 Apr 2024 16:24:14 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 52D0918001A;
	Wed,  3 Apr 2024 16:27:00 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 16:26:59 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 1/2] soc: hisilicon: kunpeng_hccs: Add the check for obtaining complete port attribute
Date: Wed, 3 Apr 2024 16:19:34 +0800
Message-ID: <20240403081935.24308-2-lihuisong@huawei.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20240403081935.24308-1-lihuisong@huawei.com>
References: <20240403081935.24308-1-lihuisong@huawei.com>
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
index 9ff70b38e5e9..bb69a95b5f2d 100644
--- a/drivers/soc/hisilicon/kunpeng_hccs.c
+++ b/drivers/soc/hisilicon/kunpeng_hccs.c
@@ -556,6 +556,12 @@ static int hccs_get_all_port_attr(struct hccs_dev *hdev,
 		start_id = rsp_head.next_id;
 	}
 
+	if (left_buf_len != 0) {
+		dev_err(hdev->dev, "do not get the expected port number(%u) attribute.\n",
+			size);
+		return -EINVAL;
+	}
+
 	return 0;
 }
 
-- 
2.22.0


