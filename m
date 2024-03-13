Return-Path: <linux-kernel+bounces-101201-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F099E87A3EF
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A76161F223CB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 08:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB36418EB2;
	Wed, 13 Mar 2024 08:10:44 +0000 (UTC)
Received: from smtpbgeu1.qq.com (smtpbgeu1.qq.com [52.59.177.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52BE91B267;
	Wed, 13 Mar 2024 08:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.59.177.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710317444; cv=none; b=JMYeT8HUgeOEWLDYmvk+UMc3VEC9xLM+LqxTeORSh+hIRJ8k4ZXI33LaVKEym7oiFrN338KkJsveJg8rG69JE+u4N66Ur/94XgkX0WSVUS37karsBGQgpJNMRlmaO/8Eu28Gb1PaT1Td6tMvYrVX1WWv3cDo+lLd8fwgtPKcqQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710317444; c=relaxed/simple;
	bh=AO4gYrFR5YhIPMlUJJE2gkuMghCgvYBgRr0xsk9NSfM=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DCdMpJ5EyTu0PaHzn6UD9m9Jzogql+N2d6MXKl2wMxxhpppIEQRNNytEFlabBhE4m/serg4YhI9ShrMMXISLKCpcoAIV56Jd53VVz95rSKMYPz216dB0ze2HVawO2lR45p8bMLaeJGMT08ZX4BnwvVdFYayFL+H5zy4jN4w+bAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com; spf=pass smtp.mailfrom=net-swift.com; arc=none smtp.client-ip=52.59.177.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=net-swift.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=net-swift.com
X-QQ-mid: bizesmtp87t1710317259tiv652if
X-QQ-Originating-IP: 1vHP8eRVGrZlnDR2BorgL9IqCfsKxq2xqsWDaBZnZoQ=
Received: from localhost.trustnetic.com ( [122.235.139.233])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 13 Mar 2024 16:07:37 +0800 (CST)
X-QQ-SSF: 01400000000000E0E000000A0000000
X-QQ-FEAT: CR3LFp2JE4n6i6hfLWy6jeqm55CI8Fwsjw6qaB7dOywOkPOXEED3zxN2HVRfE
	o5+YAj2XeQeJB3qeFidSUuBpseJKGz/yuMT2BazJ7/H8mCXXVEecLqx7WSYo1B5DaQj/5tJ
	O78cnoNSjZ3CHWvqNdILrVYkhAPhure7+uS45RHlVImfr46PUQrOBJA0+efeStWzyx8bSgg
	5aQ/0v4KKTGTTbxiGvnYuzfp2nsAUTfnJXmxlVox9le5ZPFzfHWRJhkGzzfuoTDJb6xex15
	4fr6bwsi0FUgE8ttBEIIPRIL9rrrF8lKbsdzZWDVLPXsw2iNJdG7SI6d1Tiw/2SmnFYuqpp
	AEHHgkiGFjI2JFiUbea3325N2/IXNw1PvU5B0PBGdGPNEwEOKD0MO6lV5kvv3waBAqA4Xtp
	WaLRXaPZwbgCx/U7zD+ssA==
X-QQ-GoodBg: 2
X-BIZMAIL-ID: 17129813797246797824
From: Duanqiang Wen <duanqiangwen@net-swift.com>
To: netdev@vger.kernel.org,
	mengyuanlou@net-swift.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	maciej.fijalkowski@intel.com,
	andrew@lunn.ch,
	wangxiongfeng2@huawei.com,
	linux-kernel@vger.kernel.org
Cc: Duanqiang Wen <duanqiangwen@net-swift.com>
Subject: [PATCH] net: txgbe: fix clk_name exceed MAX_DEV_ID limits
Date: Wed, 13 Mar 2024 16:06:34 +0800
Message-Id: <20240313080634.459523-1-duanqiangwen@net-swift.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:net-swift.com:qybglogicsvrsz:qybglogicsvrsz3a-1

txgbe register clk which name is i2c_designware.pci_dev_id(),
clk_name will be stored in clk_lookup_alloc. If PCIe bus number
is larger than 0x39, clk_name size will be larger than 20 bytes.
It exceeds clk_lookup_alloc MAX_DEV_ID limits. So the driver
shortened clk_name.

Fixes: b63f20485e43 ("net: txgbe: Register fixed rate clock")
Signed-off-by: Duanqiang Wen <duanqiangwen@net-swift.com>
---
 drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
index 93295916b1d2..5b5d5e4310d1 100644
--- a/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
+++ b/drivers/net/ethernet/wangxun/txgbe/txgbe_phy.c
@@ -571,7 +571,7 @@ static int txgbe_clock_register(struct txgbe *txgbe)
 	char clk_name[32];
 	struct clk *clk;
 
-	snprintf(clk_name, sizeof(clk_name), "i2c_designware.%d",
+	snprintf(clk_name, sizeof(clk_name), "i2c_dw.%d",
 		 pci_dev_id(pdev));
 
 	clk = clk_register_fixed_rate(NULL, clk_name, NULL, 0, 156250000);
-- 
2.27.0


