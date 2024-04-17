Return-Path: <linux-kernel+bounces-148279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21CBA8A802F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:55:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D6C41C21696
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 09:55:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6533413AA2E;
	Wed, 17 Apr 2024 09:55:46 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39EAB13848B
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 09:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713347746; cv=none; b=foVVM3NFxibi74T9/Ij2MuX3o7hxC4q1nZ4xioH68dxbUdXllLzKqazVZh7qrJFwqE84eWm4WMNg2U0MvraftH2DKfYADSMpVl1kbpkSCQVYeYZ46whRRN3gd1gXOCVyY+Y3KFvO98CtfU3B+T5UWGpo32vlpH/TUBiqbm6fI+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713347746; c=relaxed/simple;
	bh=kugs8ESmC1pdY+BI2C3ANeHjBPI72ZntlRu16FxY+qk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J/rJIhNeCJRIOcxBWd5+NykjNKaIhOqTOXe7jsZJ7qwJ5eyM/MTWbDwlYPFb0dlJ6i8+5Eyv60myJiQoZRyukrM0WnTHTlajq7bt583isb7NAGmWyz4WdOvZghIz9pJDjaWyvEKYpkDsYJDsXD8C9LqHnh3jr7gIgJZgx0Ogymw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VKGSF5T5nzNp2s;
	Wed, 17 Apr 2024 17:53:17 +0800 (CST)
Received: from kwepemm600004.china.huawei.com (unknown [7.193.23.242])
	by mail.maildlp.com (Postfix) with ESMTPS id 74D391403D3;
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
Subject: [PATCH v2 2/2] soc: hisilicon: kunpeng_hccs: replace MAILBOX dependency with PCC
Date: Wed, 17 Apr 2024 17:48:01 +0800
Message-ID: <20240417094801.25393-3-lihuisong@huawei.com>
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


