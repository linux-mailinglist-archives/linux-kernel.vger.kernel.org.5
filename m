Return-Path: <linux-kernel+bounces-151308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B18F8AACA9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:17:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F1121C2182E
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:17:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A702B7D07A;
	Fri, 19 Apr 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="Y/oX8hXO"
Received: from HK2PR02CU002.outbound.protection.outlook.com (mail-eastasiaazon11010001.outbound.protection.outlook.com [52.101.128.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D63E57C08B
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 10:17:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.128.1
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521825; cv=fail; b=mbbgcVeFIB+gHcqkIawSVCwK+T5Qo7Iv+O+jgPY3nwbnKxutb1xKkilHtbVJ/NjcmMv9Wt3P+rMVfoekKIO7Nh4WwhvThja5WB5U9e4A8d84w1xlxfgmbtZYLQFLyNNZVsDp3LTrlBT00AzbhK4bOOYeadKIQr5HTzcB2fYI8EE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521825; c=relaxed/simple;
	bh=KxmqCOET2WCfdL3ocea3pFjpQxhSJvqV82rPCcHuu+I=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Z2CuTIcPLMGOHRs7P0srkVEYC5j/iyMF0il6h61wGghzAKwHh9IZpGTBC270RSaSrwuSQpbycHvnvp6B29Wgi7VcWEsF2E7s4Pw/v4MLX/BdE1zoNF+OcT43DiVPotNLcsoiQZYDY17Zd10y3hvALGxk6tj7fBMT0/ttzg1EWNc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=Y/oX8hXO; arc=fail smtp.client-ip=52.101.128.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AOACkC3902hvNtW9/SGo1MRborF9fdZhpHWdaRirmi/liAcPr9xPd+OwEpUh6oj5jpxHJBwJ2W2Hrt2orwl5BnBprhazZd9f6aFnsd7DR77ukjm9QsbN9VS1xIa/WGftzKMPFEKpAyAmHS8POTCm9QZiTnFrXGcGPqBkP7pqWKk10awA2NPBXUf6BIbzJgKh9/N4G8lj3PKZgBkBptY050UI6Zpa/WKBXRxmt1F4qwGZhHxhkqaNcTFyvJ3y6DVwZJUpX8smTDCS4lrMEZWHuBBrnHpdeJ8+E1o8T0+Mjf0LXr7BCT6m+NCOOGy05a45NYBz5aFWtY0ETXy7CRVi6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D9UxydkTj6zi7CrpC/MsY1FMJqTiZr603AVf+x5Q29Q=;
 b=OWeFG3ombaKdGw+iOWv6KgjLo09DOsP6FTqufmGdMrxwGkV07zxsL2MV5SfEy7PiUnFBxlgnKAS36ARaoDNPNn6k1KxC65yfD2LQHpUnv6E6cAZlZuyWmujkDeneDZ2nXOgcW/sxilsO7rtXZHll1tu57sHsrOuM1WQhivBPfaBH6Zx6ZK2cMk/9QX/MyN1V1tTEm9Fj6MzUAbFNbPwt+msJcQbXgKiMr06E+TlpbKxkWo6VCyFzxpgUOO0qfx1bblvwto9KpXXDeY6hAMv1zwaXv3VWBVffeWwwy2FJ7hEzJUKIbZ1svql+jEFiSWapAhMmZ3dw2GAcKS1/G4yDoA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=linux-foundation.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D9UxydkTj6zi7CrpC/MsY1FMJqTiZr603AVf+x5Q29Q=;
 b=Y/oX8hXOUK1mnodRb94zGZt/V39s94LUd1YvsQ+7jkTgoaFo/kFDWJWHV0HFKnoXlvMUMfaEQfojxZTQS2XjzzhYrNs/ZRtqnxipP7gi3dNMmGyuwEZ9747C2zOkR55kfch3Sucy9YXmOA7/WRFQvcTW7lCCZdsktMyDq/LmNvE=
Received: from SGXP274CA0002.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::14) by
 TY0PR02MB5573.apcprd02.prod.outlook.com (2603:1096:400:1bb::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.39; Fri, 19 Apr
 2024 10:17:00 +0000
Received: from SG2PEPF000B66D0.apcprd03.prod.outlook.com
 (2603:1096:4:b8:cafe::a) by SGXP274CA0002.outlook.office365.com
 (2603:1096:4:b8::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.29 via Frontend
 Transport; Fri, 19 Apr 2024 10:16:59 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG2PEPF000B66D0.mail.protection.outlook.com (10.167.240.26) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7452.22 via Frontend Transport; Fri, 19 Apr 2024 10:16:59 +0000
Received: from PH80250894.adc.com (172.16.40.118) by mailappw31.adc.com
 (172.16.56.198) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 19 Apr
 2024 18:16:58 +0800
From: <hailong.liu@oppo.com>
To: <akpm@linux-foundation.org>
CC: <urezki@gmail.com>, <hch@infradead.org>, <lstoakes@gmail.com>,
	<21cnbao@gmail.com>, <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
	Hailong.Liu <hailong.liu@oppo.com>
Subject: [RFC PATCH v2] mm/vmalloc: fix return value of vb_alloc if size is 0.
Date: Fri, 19 Apr 2024 18:16:43 +0800
Message-ID: <20240419101643.11534-1-hailong.liu@oppo.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: mailappw31.adc.com (172.16.56.198) To mailappw31.adc.com
 (172.16.56.198)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SG2PEPF000B66D0:EE_|TY0PR02MB5573:EE_
X-MS-Office365-Filtering-Correlation-Id: 86e89d7d-bab6-4983-eca3-08dc6059d96e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	zEFA+XK84OHm0ksvS1Oa8/5b0xjGncVptXwhoGyHw7pMvrBooR+tJ9ghOB2rrbpadBOmRQOLZS/qtLAWQ0ea3BjmvetQwAzTTyacJic1cmvHMLRAWK5pnFaHFnEjPtjtz78H/d7VY0UYyj04h7WXPy65GYOh7UkiVBa/vEb1uern8u5QS0AhMlTtf8jnzi9jDd2vuZQdfhmbY+7++Z+AD8OEuu/PhPYE+YU7MaRcn/CoCCCzAYH1G0oslXU5YPmsrg+AGlgIzpPr8Q70/MSmnufVTrhwqxM7vjhqTJvgSPlnI5HPP4KLRQN5v3vt/17uWEkleSXoXqMuFdGTdsx7TwmIZwut5Pkc4/c1aJHEX792+0ZgdaDkjzFqCc1xtnszBLPnmea9R88TXeBtSJSoIKwoHi5whv42pZdk1I/7xNMtIFOE32PX1to5k5kcRhXJF10LrTfMB6X0bqrlNEbiB3HjY9E+JcSfvCmbE227I2rQduUksOpUNSP0dr2qjKKR25S2EzHzUI643ZLJYhNXT1oqpTRuZb+splqCf8qfrDBBU+hAsXRI0dBzd4gt5+zwXF1tFvLj6CmZBG8q2U/0nt8YN8cGqHsZRNBQCpZqo4BBd2UyTm4XUuhAfzTPK0G2j1sNYALbH/yRaNbZ0CuK9x0A6y8EG3rJrlpRdKfpAUk2Jxke1expeiskcQVMmfYiF9r+1IJ2FmuA307tJaLRRyOKMS7X+ufXdTSq88pwRSmW/wBqy77o4D7NW9gknESC
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(82310400014)(36860700004)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2024 10:16:59.4955
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 86e89d7d-bab6-4983-eca3-08dc6059d96e
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG2PEPF000B66D0.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TY0PR02MB5573

From: "Hailong.Liu" <hailong.liu@oppo.com>

vm_map_ram check return value of vb_alloc by IS_ERR. if
vm_map_ram(page, 0, 0) , vb_alloc(0, GFP_KERNEL) would return NULL
which cause kernel panic by vmap_pages_range_noflush。fix this by
return ERR_PTR(-EINVAL) if size is 0.

Signed-off-by: Hailong.Liu <hailong.liu@oppo.com>
---
Changes since v1 [1]:
- Return ERR_PTR(-EINVAL) or not check IS_ERR_OR_NULL

BTW,  Barry suggests me that if count is 0, return directly, in my
opinion, change return value is more resonable.

[1] https://lore.kernel.org/all/84d7cd03-1cf8-401a-8edf-2524db0bd6d5@oppo.com/

 mm/vmalloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index a3fedb3ee0db..c430a999805b 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -2173,7 +2173,7 @@ static void *vb_alloc(unsigned long size, gfp_t gfp_mask)
 		 * get_order(0) returns funny result. Just warn and terminate
 		 * early.
 		 */
-		return NULL;
+		return ERR_PTR(-EINVAL);
 	}
 	order = get_order(size);

--
2.34.1


