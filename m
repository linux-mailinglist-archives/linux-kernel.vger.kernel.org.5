Return-Path: <linux-kernel+bounces-129329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 819158968A0
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 10:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 375181F2949D
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 08:30:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9488A6D1BA;
	Wed,  3 Apr 2024 08:27:06 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CD3F6CDC2
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 08:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712132826; cv=none; b=AFdhHAR26Y1g4XXXiW2PwMdedlIke86B7fkoWm1r8CbVCe9K3QHpufqt4kwOggecFHvyDNIRxt3RDnveaJQY9tkGnQmVG3KpNjo3j1HpKIcRzGviOSlnh3SGfaKAMPMj7dGEkLteKBbjDUCslSx2q2f+O2z/KcW9m/5DJ8+xrbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712132826; c=relaxed/simple;
	bh=kugs8ESmC1pdY+BI2C3ANeHjBPI72ZntlRu16FxY+qk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s4gXZ9LpVudKzvvQF0j2N+UafAU4iChuuoZ2Il/j1ToUSVHd/T8Bmu1KprC2kdzKkozFe/K1jcDJn4tOB3+Ydc4UGfY5HXmHHQOiZPa6VRm4Bp4jnZSTZCN9+yqU7/ce6ISPFNF7gbjJQG9cOLJ8pb1Gu4eRZFsGecU6tnLDVfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4V8d7z1mhcz1h5X0;
	Wed,  3 Apr 2024 16:24:15 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id AC148140133;
	Wed,  3 Apr 2024 16:27:00 +0800 (CST)
Received: from localhost.localdomain (10.28.79.22) by
 kwepemm600004.china.huawei.com (7.193.23.242) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 3 Apr 2024 16:27:00 +0800
From: Huisong Li <lihuisong@huawei.com>
To: <xuwei5@hisilicon.com>
CC: <linux-kernel@vger.kernel.org>, <soc@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <Jonathan.Cameron@Huawei.com>,
	<liuyonglong@huawei.com>, <lihuisong@huawei.com>
Subject: [PATCH 2/2] soc: hisilicon: kunpeng_hccs: replace MAILBOX dependency with PCC
Date: Wed, 3 Apr 2024 16:19:35 +0800
Message-ID: <20240403081935.24308-3-lihuisong@huawei.com>
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

The kunpeng_hccs driver depands on Platform Communication Channel Driver.
If PCC driver is not enabled, this driver fails to probe.
Seeing as how PCC driver depands on MAILBOX. so replace MAILBOX dependency
with PCC.

Signed-off-by: Huisong Li <lihuisong@huawei.com>
---
 drivers/soc/hisilicon/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/soc/hisilicon/Kconfig b/drivers/soc/hisilicon/Kconfig
index 0ab688af308f..4b0a099b28cc 100644
--- a/drivers/soc/hisilicon/Kconfig
+++ b/drivers/soc/hisilicon/Kconfig
@@ -6,7 +6,7 @@ menu "Hisilicon SoC drivers"
 config KUNPENG_HCCS
 	tristate "HCCS driver on Kunpeng SoC"
 	depends on ACPI
-	depends on MAILBOX
+	depends on PCC
 	depends on ARM64 || COMPILE_TEST
 	help
 	  The Huawei Cache Coherence System (HCCS) is a multi-chip
-- 
2.22.0


