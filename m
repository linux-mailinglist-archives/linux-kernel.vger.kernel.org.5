Return-Path: <linux-kernel+bounces-24592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DFC5C82BE98
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 11:27:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DA2428A828
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 10:27:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BAC860B8B;
	Fri, 12 Jan 2024 10:26:35 +0000 (UTC)
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93EE55EE81;
	Fri, 12 Jan 2024 10:26:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4TBHjz0hqSzsVqh;
	Fri, 12 Jan 2024 18:25:43 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id 36D6A14011A;
	Fri, 12 Jan 2024 18:26:30 +0800 (CST)
Received: from localhost.localdomain (10.69.192.56) by
 kwepemm600009.china.huawei.com (7.193.23.164) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 12 Jan 2024 18:26:29 +0800
From: Weili Qian <qianweili@huawei.com>
To: <herbert@gondor.apana.org.au>
CC: <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<liulongfang@huawei.com>, Weili Qian <qianweili@huawei.com>
Subject: [PATCH 2/2] crypto: hisilicon/qm - dump important registers values before resetting
Date: Fri, 12 Jan 2024 18:25:46 +0800
Message-ID: <20240112102546.2213-3-qianweili@huawei.com>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20240112102546.2213-1-qianweili@huawei.com>
References: <20240112102546.2213-1-qianweili@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600009.china.huawei.com (7.193.23.164)

Read the values of some device registers before the device
is reset, these values help analyze the cause of the device exception.

Signed-off-by: Weili Qian <qianweili@huawei.com>
---
 drivers/crypto/hisilicon/debugfs.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/crypto/hisilicon/debugfs.c b/drivers/crypto/hisilicon/debugfs.c
index 615c8e18d8b0..06e67eda409f 100644
--- a/drivers/crypto/hisilicon/debugfs.c
+++ b/drivers/crypto/hisilicon/debugfs.c
@@ -83,6 +83,30 @@ static const struct debugfs_reg32 qm_dfx_regs[] = {
 	{"QM_DFX_FF_ST5                 ",  0x1040dc},
 	{"QM_DFX_FF_ST6                 ",  0x1040e0},
 	{"QM_IN_IDLE_ST                 ",  0x1040e4},
+	{"QM_CACHE_CTL                  ",  0x100050},
+	{"QM_TIMEOUT_CFG                ",  0x100070},
+	{"QM_DB_TIMEOUT_CFG             ",  0x100074},
+	{"QM_FLR_PENDING_TIME_CFG       ",  0x100078},
+	{"QM_ARUSR_MCFG1                ",  0x100088},
+	{"QM_AWUSR_MCFG1                ",  0x100098},
+	{"QM_AXI_M_CFG_ENABLE           ",  0x1000B0},
+	{"QM_RAS_CE_THRESHOLD           ",  0x1000F8},
+	{"QM_AXI_TIMEOUT_CTRL           ",  0x100120},
+	{"QM_AXI_TIMEOUT_STATUS         ",  0x100124},
+	{"QM_CQE_AGGR_TIMEOUT_CTRL      ",  0x100144},
+	{"ACC_RAS_MSI_INT_SEL           ",  0x1040fc},
+	{"QM_CQE_OUT                    ",  0x104100},
+	{"QM_EQE_OUT                    ",  0x104104},
+	{"QM_AEQE_OUT                   ",  0x104108},
+	{"QM_DB_INFO0                   ",  0x104180},
+	{"QM_DB_INFO1                   ",  0x104184},
+	{"QM_AM_CTRL_GLOBAL             ",  0x300000},
+	{"QM_AM_CURR_PORT_STS           ",  0x300100},
+	{"QM_AM_CURR_TRANS_RETURN       ",  0x300150},
+	{"QM_AM_CURR_RD_MAX_TXID        ",  0x300154},
+	{"QM_AM_CURR_WR_MAX_TXID        ",  0x300158},
+	{"QM_AM_ALARM_RRESP             ",  0x300180},
+	{"QM_AM_ALARM_BRESP             ",  0x300184},
 };
 
 static const struct debugfs_reg32 qm_vf_dfx_regs[] = {
-- 
2.33.0


