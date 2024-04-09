Return-Path: <linux-kernel+bounces-136840-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B80789D8DB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 14:06:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE1971C215C7
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 12:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B025F12DD97;
	Tue,  9 Apr 2024 12:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b="aeV9EwvV"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2103.outbound.protection.outlook.com [40.107.6.103])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9741412BEBE
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 12:06:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.103
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712664388; cv=fail; b=Qpzy+puQOID+DSEzXAGVi9m3MLqGVUbGPt3175WCw+F+S3FfKOLnnXSapY+CqiLy0jVz++f9u7XpYXyWM/kvuX8Kt5DmMo4QqmlLFzwwJu4Zhq2HWjYIzLTdIkiC/ThWe+oAxTvLZ/kqFgn0nZm28sNdqsjxkQv8HBWZYWe7Wso=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712664388; c=relaxed/simple;
	bh=h8gcV/p/aqOmdw/KcW17TmReXdCBgxLYAAOVYRWVZvQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SlGO5NCD5+1GI3yKos5y0+yqXH9GAGZkVhl1ONutiEcmjbFFk7bCd+LcgfP+G0vqcOvG1kSwqsqusXGVdMy4v8H46M3Yfp1IlMSEqyPnQ3u/TWlm0YPIiQLqTpXnfBDWUzRJ3sZ3A/UazsXsWuseEyHY7KUq7DN8MZS7OeSQwEk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info; spf=pass smtp.mailfrom=bachmann.info; dkim=pass (1024-bit key) header.d=bachmann.info header.i=@bachmann.info header.b=aeV9EwvV; arc=fail smtp.client-ip=40.107.6.103
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bachmann.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bachmann.info
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=irxXPvwvAPxEaquIz0y4bj98WPFA3cR7r6TD9qwoZaYIK/68OnVMDN2D22F4qXb+EBIbyqAnb94HTW77TJ+hvbhR0a7fuMKFS0Cn+0vXUkEgf1P5NjVHWoseUB7HFDeGukCE4RTXNt5aCFd0iw/UcGEnpcJYgXlMGxjKjcIuSnbh5iROwcreTOVyAQdLPmt3HWcySHiHej/0czKpTCOGZbECoYm3yi6g9CX8XuE+fjR5jlnH5Gisd5b5h8yfeyD+g2H486c9WkLQokD9PSZ7DMsJtCfgLcUaMgwBdsekQbW+5siLfrxztFaqaADHp1sC3pWV+goafmezY+oO5hTVLw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sbRWLz7Bb5sO3Y4RuHdIktFrBAjI7D16udTJMmrnh60=;
 b=A+dxiLma6v67zNGYBAaH650r64W49IbKKiDjmeKM25qOUosdqkFebaIBXX1JmUOuslVPIsEI/YshrJG54gMlVS9LbxOUM6I0E8x/kzjecwcHLNKHmskEGvY4O5JRJpsA4y8iycZr7gWKhoxgDNJOtg89r0dsX0JW2V7WAuDdOjkXU3u/SvGV3JyjjmhItAe6eI1j6rPZRZGUfCrHbutx1CV3pK40n5f2T+BVzpHejXQO3er2FFmT+CwIfbswF4oI0/gc/usIre4L2zGZ5me0/Hd+JusohfykHI/zDLPs+YHHg2ChRtGIa0LEmfx/rglxRTHoL1fNSTJcVXpqX/DEBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 185.67.228.71) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=bachmann.info; dmarc=fail (p=quarantine sp=quarantine pct=100)
 action=quarantine header.from=bachmann.info; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bachmann.info;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sbRWLz7Bb5sO3Y4RuHdIktFrBAjI7D16udTJMmrnh60=;
 b=aeV9EwvVtxdNDBQgk3L7W2fddwcJ7PU586LnjwsTeWwzrKf3ipvrahDLEUmVNA4l9jFVW6PXwxBaUbbcKbt8GvoOX5HzOwbqPynvveWQItP+DKLfIOXNloW+VmTldW3YED9uzPotVcPRZOuUp4Y8O6NjpRcQTu3Zfo90YnY1bQ4=
Received: from AM6P195CA0026.EURP195.PROD.OUTLOOK.COM (2603:10a6:209:81::39)
 by AM8PR05MB7314.eurprd05.prod.outlook.com (2603:10a6:20b:1d6::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.55; Tue, 9 Apr
 2024 12:06:22 +0000
Received: from AMS0EPF0000019D.eurprd05.prod.outlook.com
 (2603:10a6:209:81:cafe::53) by AM6P195CA0026.outlook.office365.com
 (2603:10a6:209:81::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.36 via Frontend
 Transport; Tue, 9 Apr 2024 12:06:21 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 185.67.228.71) smtp.mailfrom=bachmann.info; dkim=none (message not signed)
 header.d=none;dmarc=fail action=quarantine header.from=bachmann.info;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 bachmann.info discourages use of 185.67.228.71 as permitted sender)
Received: from webmail.bachmann.info (185.67.228.71) by
 AMS0EPF0000019D.mail.protection.outlook.com (10.167.16.249) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Tue, 9 Apr 2024 12:06:20 +0000
Received: from ATFKPCLXPAFO.bachmann.at (10.204.124.241) by
 atfkex03.bachmann.at (10.10.10.31) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Tue, 9 Apr 2024 14:06:19 +0200
From: Pascal FONTAIN <Pascal.FONTAIN@bachmann.info>
To: <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, "Greg
 Kroah-Hartman" <gregkh@linuxfoundation.org>
CC: <afd@ti.com>, Pascal Fontain <pascal.fontain@bachmann.info>
Subject: [PATCH v3 1/2] misc: sram: Move probe of sram subsystem
Date: Tue, 9 Apr 2024 14:06:04 +0200
Message-ID: <20240409120605.4138472-2-Pascal.FONTAIN@bachmann.info>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409120605.4138472-1-Pascal.FONTAIN@bachmann.info>
References: <20240409120605.4138472-1-Pascal.FONTAIN@bachmann.info>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: atfkex03.bachmann.at (10.10.10.31) To atfkex03.bachmann.at
 (10.10.10.31)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000019D:EE_|AM8PR05MB7314:EE_
X-MS-Office365-Filtering-Correlation-Id: 1b639799-9506-4930-15ae-08dc588d780b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Pi9nP01jXltjWLPh/hDeAh1gUWSGRX/KnjmymOlXbiGGCgkcCUtMYMSnknRMKN7UPhReL61TccxYy2mIl5a/mPTr0rAILIkZdKakEhg/1pWdVHcoKB6KToEyoceWe/Qjy6HxT+BD/50Q6Nmm7I2gwd+kBnB9k4KmcCOsYH+gpP9bdLulYHstf4dpliefP0gW3H57sVAKuypKLPsQcL1O0JhZYGuetPDHWXY/6xS0m6X/g/HFKJpc/JcpfI7M6idQVDro2qdkdDrRBnrPLc2RE4lhOD4avgQxPubZCC+wO06a3/jUBRyIazTZMxNxflwgADtoMRL8dwiPGioPea28PrP8xd8mIzMWdItO3OqG4AuVN+qaE9G9+XieTF0PbIl1glJU+5tN3BaiBDIEFeRL6pVLIdG5t8owLbSUraltzdnZA+dhSJgo1+OgOpWc7zoRKQgq7YclFuxLBlzCpYPC5+WEVl4gSJzjEfa6cLkiEadYcuVVUGtg19oQVYuYMhE64NmtEqu4GzxDXRqYkhERWhaV5vqTHYW+AoY6l764VsrcneabqCKdojBxato8Vz0d58wU8d9MY7rxvq7eL+GG8yEEzwwejc+7NrD084K1D1IRFsI+K8xtkS0mShteN1JvZxc3LSdp7Pi5psFwoTBi/MF23vkoYCVOFQ4F0DrpWASx8V3OL+10wHgzdkVFJyq5OK7ViUMpjgzqy8QufXuuqpmPLOkYU39yMBQ0F1iL+QWNlTMS3N8bxT8k1H2BZA4o
X-Forefront-Antispam-Report:
	CIP:185.67.228.71;CTRY:AT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:webmail.bachmann.info;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(1800799015)(36860700004)(82310400014)(376005);DIR:OUT;SFP:1102;
X-OriginatorOrg: bachmann.info
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Apr 2024 12:06:20.6611
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1b639799-9506-4930-15ae-08dc588d780b
X-MS-Exchange-CrossTenant-Id: e3bace4d-d2e7-4d8f-afb8-152509ee3f1a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=e3bace4d-d2e7-4d8f-afb8-152509ee3f1a;Ip=[185.67.228.71];Helo=[webmail.bachmann.info]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000019D.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR05MB7314

From: Pascal Fontain <pascal.fontain@bachmann.info>

The sram subsystem might use the dma-buf subsystem which only gets
initialized in subsys_initcall phase. Because of this we move the sram
initcall into the device phase.

Signed-off-by: Pascal Fontain <pascal.fontain@bachmann.info>
---
 drivers/misc/sram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
index e248c0a8882f..632f90d9bcea 100644
--- a/drivers/misc/sram.c
+++ b/drivers/misc/sram.c
@@ -461,4 +461,4 @@ static int __init sram_init(void)
 	return platform_driver_register(&sram_driver);
 }
 
-postcore_initcall(sram_init);
+device_initcall(sram_init);
-- 
2.39.2


