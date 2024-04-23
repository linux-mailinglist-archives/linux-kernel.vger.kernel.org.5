Return-Path: <linux-kernel+bounces-154389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A7F8ADB81
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:24:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6340CB22C50
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A32A107A9;
	Tue, 23 Apr 2024 01:24:05 +0000 (UTC)
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1BBA12B8B;
	Tue, 23 Apr 2024 01:24:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713835445; cv=none; b=l3Q4Orc/U0HX0io+sOkeVoAizlnA9TqljDfS9qrCr24jbEsM2E5E6xUwMivQfvnXr4TtPnMzQjLNm1p12R5qUZlN3H90DdJ4elqTeAl74PfkaOj3z/XGrV97jJMWdmcY/shLsHZ7LrcW/7k16Xoub913CpBdBIrgblZ7QtkEq6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713835445; c=relaxed/simple;
	bh=SPalivOhnSghODFVv8OeqM4DNIShihOmZ+eu8XacD5U=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OsEFkh5AZRMnwPr2sCLhIAe4ThogWIEGq3KETBMHDwoyaMEsl1jW7DLvqZOaGIL7XXkrjzWFrKDNqPWOjRdR0O//T1qOKusWuG1StNkYrPglN6WDZx0+OkLNkut1lxLKQR0l6pf+a3jmIC/6UV8js7ZBC8y1eXIuHDJVnlYrQCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4VNkpx2JrMzNsDf;
	Tue, 23 Apr 2024 09:21:29 +0800 (CST)
Received: from kwepemi500025.china.huawei.com (unknown [7.221.188.170])
	by mail.maildlp.com (Postfix) with ESMTPS id 3373F1800C4;
	Tue, 23 Apr 2024 09:23:59 +0800 (CST)
Received: from localhost.localdomain (10.67.165.2) by
 kwepemi500025.china.huawei.com (7.221.188.170) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 23 Apr 2024 09:23:58 +0800
From: Chenghai Huang <huangchenghai2@huawei.com>
To: <herbert@gondor.apana.org.au>, <davem@davemloft.net>
CC: <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
	<fanghao11@huawei.com>, <liulongfang@huawei.com>, <shenyang39@huawei.com>,
	<songzhiqi1@huawei.com>, <qianweili@huawei.com>, <liushangbin@hisilicon.com>,
	<linwenkai6@hisilicon.com>, <taoqi10@huawei.com>, <wangzhou1@hisilicon.com>,
	<huangchenghai2@huawei.com>
Subject: [PATCH 2/2] crypto: hisilicon/sec2 - fix for register offset
Date: Tue, 23 Apr 2024 09:19:22 +0800
Message-ID: <20240423011922.770693-3-huangchenghai2@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20240423011922.770693-1-huangchenghai2@huawei.com>
References: <20240423011922.770693-1-huangchenghai2@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemi500025.china.huawei.com (7.221.188.170)

From: Wenkai Lin <linwenkai6@hisilicon.com>

The offset of SEC_CORE_ENABLE_BITMAP should be 0 instead of 32,
it cause a kasan shift-out-bounds warning, fix it.

Signed-off-by: Wenkai Lin <linwenkai6@hisilicon.com>
---
 drivers/crypto/hisilicon/sec2/sec_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/crypto/hisilicon/sec2/sec_main.c b/drivers/crypto/hisilicon/sec2/sec_main.c
index 6eba1f22720f..75aad04ffe5e 100644
--- a/drivers/crypto/hisilicon/sec2/sec_main.c
+++ b/drivers/crypto/hisilicon/sec2/sec_main.c
@@ -152,7 +152,7 @@ static const struct hisi_qm_cap_info sec_basic_info[] = {
 	{SEC_CORE_TYPE_NUM_CAP, 0x313c, 16, GENMASK(3, 0), 0x1, 0x1, 0x1},
 	{SEC_CORE_NUM_CAP, 0x313c, 8, GENMASK(7, 0), 0x4, 0x4, 0x4},
 	{SEC_CORES_PER_CLUSTER_NUM_CAP, 0x313c, 0, GENMASK(7, 0), 0x4, 0x4, 0x4},
-	{SEC_CORE_ENABLE_BITMAP, 0x3140, 32, GENMASK(31, 0), 0x17F, 0x17F, 0xF},
+	{SEC_CORE_ENABLE_BITMAP, 0x3140, 0, GENMASK(31, 0), 0x17F, 0x17F, 0xF},
 	{SEC_DRV_ALG_BITMAP_LOW, 0x3144, 0, GENMASK(31, 0), 0x18050CB, 0x18050CB, 0x18670CF},
 	{SEC_DRV_ALG_BITMAP_HIGH, 0x3148, 0, GENMASK(31, 0), 0x395C, 0x395C, 0x395C},
 	{SEC_DEV_ALG_BITMAP_LOW, 0x314c, 0, GENMASK(31, 0), 0xFFFFFFFF, 0xFFFFFFFF, 0xFFFFFFFF},
-- 
2.30.0


