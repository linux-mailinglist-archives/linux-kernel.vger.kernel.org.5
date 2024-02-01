Return-Path: <linux-kernel+bounces-48218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D7418458B4
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:18:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B90D9291360
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99D05336E;
	Thu,  1 Feb 2024 13:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=asem.it header.i=@asem.it header.b="UXFXBfWv"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2101.outbound.protection.outlook.com [40.107.22.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 016105B68F
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 13:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.101
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706793526; cv=fail; b=sIaCZ4Ygsgzl3AcCBVJjZ6A6zr60IXJR0W7hg0FxdGPgh56MAvRlLeWNmuKP7lyD/HyaSj/FbARjzvD29BpFFhoaARmzEty70SzciNvxvQhgbDbL9WnjyQ/WPyDRrBSyXELvmoblCDE0ZW6az/gWAy/OoFUDS2j5gpxW3Cpn2YQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706793526; c=relaxed/simple;
	bh=B7RcvbnNf5GZ+FZLekSTBvetz0v/1b6qxp4sDie0PL0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TrXOt+4S7hHH/61C8hUWoTXAcjhT9fyr9kvC8qn7D7f1sqJqfLbL7V6rSb0Dz6UQDWe03cIGzChJaFQjnNiSUGVRkV90QqC0xglzeOtm6MYJHKlJLgxoXQi11rNyrrmpxVQq9TUdUQtrxCb6HW7HD7GIb+lc1fNgsnYpRizlHR4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it; spf=pass smtp.mailfrom=asem.it; dkim=pass (1024-bit key) header.d=asem.it header.i=@asem.it header.b=UXFXBfWv; arc=fail smtp.client-ip=40.107.22.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=asem.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=asem.it
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DVbf9z/5D/ZkOM78k6oh2GJEA357A+WqI5anEUJgqgo8iIslhOo5xdKbzWunjlp7J62RtsHQii4kT9bjhuY88EpUL2fs7W8wa8x537jdxLxHynduh7/5Yk1gd44ZZCHdzW6Kx2voWrFx/rSPJ8bzk6jzsmTmZpXh/zOwHXp/2MOLim+hgyff33EbaQ/YsTozM1bAXrV7eEe9cOpelNArp2EHO/hEiAZ5DSEGWIyoPIcI/bC52D71isUe/x+VJwoQ+Z2UKBdcjxixgGQafLijex6BgARXtO1yQvm0UUdRawjvommnn5Wj5n0yySgEdsuUCjqK46u9Hr7Q2qtg+udZWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gbk6GEaZFm2CqJE8OhLPw9fpnMMZjNb43lrAdGQwPeQ=;
 b=Up1IyOHvsmAfLXSlINW9biAcfVhVWQo0WC28psgH7lz7n+aUKJ7aUz8jBl6viqzzgq6n3Eu381hhaiFor/r2G9DJEr6tgRKt0XftpMI2Fx/GV5PjzKtmPajL727ehaXqB+GebXu73kemvjc6BQjNWpWPgS1FUc7B0ZXGcc/3VGwLPUpXbJFMZyxusLBsVEu/0E5WD15ssyszs8/Ul3PuF7TXxC2Z5MSfWzh4sYp3uMw26RbgpGI+yowmUxnE15yD0vf8iG5buvwJxrv5U6MLDyRNTuPmRxBqoZPlfHCKvfUkHKfQsLbaWMXcmIIJcNQiX16kbZswmQKD4ShKiowoJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=softfail (sender ip
 is 151.1.184.193) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=asem.it;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=asem.it;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=asem.it; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gbk6GEaZFm2CqJE8OhLPw9fpnMMZjNb43lrAdGQwPeQ=;
 b=UXFXBfWvUiAsJF6UNe3vTh4anvmav6O1VKdJu6KZ+dgYNdUczVTBaZoRAGUVo9Fi2jdaNyBWs2tj5IxdyKYpChtVRbiM3p3YTXJ1jOjwWcNjlAYBlIPqzulLTTobfkVg6N2osaz6RXIsaZwvbyAHHyUiMnlACOClQ8TutrE2XN0=
Received: from DUZPR01CA0243.eurprd01.prod.exchangelabs.com
 (2603:10a6:10:4b5::11) by AM8PR01MB7881.eurprd01.prod.exchangelabs.com
 (2603:10a6:20b:3d8::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Thu, 1 Feb
 2024 13:18:40 +0000
Received: from DB5PEPF00014B9E.eurprd02.prod.outlook.com
 (2603:10a6:10:4b5:cafe::bc) by DUZPR01CA0243.outlook.office365.com
 (2603:10a6:10:4b5::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.26 via Frontend
 Transport; Thu, 1 Feb 2024 13:18:40 +0000
X-MS-Exchange-Authentication-Results: spf=softfail (sender IP is
 151.1.184.193) smtp.mailfrom=asem.it; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=asem.it;
Received-SPF: SoftFail (protection.outlook.com: domain of transitioning
 asem.it discourages use of 151.1.184.193 as permitted sender)
Received: from asas054.asem.intra (151.1.184.193) by
 DB5PEPF00014B9E.mail.protection.outlook.com (10.167.8.171) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.19 via Frontend Transport; Thu, 1 Feb 2024 13:18:40 +0000
Received: from flavio-x.asem.intra ([172.16.18.47]) by asas054.asem.intra with Microsoft SMTPSVC(10.0.14393.4169);
	 Thu, 1 Feb 2024 14:18:38 +0100
From: Flavio Suligoi <f.suligoi@asem.it>
To: Tudor Ambarus <tudor.ambarus@linaro.org>,
	Pratyush Yadav <pratyush@kernel.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>
Cc: linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Flavio Suligoi <f.suligoi@asem.it>
Subject: [PATCH 1/1] mtd: spi-nor: everspin: add em004lxb entry
Date: Thu,  1 Feb 2024 14:17:10 +0100
Message-Id: <20240201131710.797505-2-f.suligoi@asem.it>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240201131710.797505-1-f.suligoi@asem.it>
References: <20240201131710.797505-1-f.suligoi@asem.it>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 01 Feb 2024 13:18:38.0651 (UTC) FILETIME=[2B15E0B0:01DA5511]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB5PEPF00014B9E:EE_|AM8PR01MB7881:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: a70de548-1ebb-4002-ffc2-08dc23284e95
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TJA/5jsn6LNlsArDxahb7MmQFfOCksqm9t5VUfya1XiJxGX6SiSAs/QhikbUDPOizBKVU+TlUc5pd5ksGsupC30oRo+Ni8M6V2CncKYGvaZ7JTRajBBbJ115omP0rbJWlRyi2bEVDsWUY2vsS6Lc9emArNX5iuVFopcHj8R7xP+Fc418A1Cf3IJQM5xbY+tRlBznCKhFJP1jcLVwDVrD91qZ/kkimxZTwNA4/RGC2IXRfFs9uZYmUSOKn88EXCYlHz87F9blyAv7heAYf2ZB9P5kGB555Mwkyr2s/wWdAV6E/e27Mqb1dk9a0o4e6SH5AsJCjhh1TQ7q00qz5CgE365Bn+lE/ILfKV/2QYugLRG7e90uhFGcWyM/Ak2SSVN+G1jyEn+hzhFgc6sW521gLh/b0+JVBnH/CWn81l2W8vodfzxphBKjt0ijAab0SINIho3hxv5GST3uxCvk/HtMiyE5ovafj9OG6E3WCyyWZBEhDigL9WQDtDrYm7PslxZ8NfZPZmg2i5A6hUjlh9lt3GRcdbPYpDMeKTQEYg8v7Zg7JxmD/mTb9WKc/OsiM7XJJH836V5xG6SFOH6aa5R5Lsq0kmB0MOGjQP14Qwno9SpMcHKWoW8eeuwLd0vByY8kD5ma/Bju+xYc5z6xcsCnj5nVdSyOOQDRKdtCfPjfPzaaYnvejcVwkQL3+2CZRxSIkqkVjmrhzU7cjvbLA9FSikuenEJ5/NdfJkVaAryGrek=
X-Forefront-Antispam-Report:
	CIP:151.1.184.193;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:asas054.asem.intra;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(39850400004)(136003)(346002)(376002)(396003)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(82310400011)(36840700001)(46966006)(36756003)(4744005)(2906002)(41300700001)(86362001)(316002)(70586007)(110136005)(70206006)(47076005)(336012)(6666004)(1076003)(107886003)(2616005)(26005)(478600001)(83380400001)(966005)(40480700001)(82740400003)(5660300002)(356005)(36860700001)(4326008)(81166007)(8936002)(8676002)(36900700001);DIR:OUT;SFP:1102;
X-OriginatorOrg: asem.it
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 13:18:40.2635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: a70de548-1ebb-4002-ffc2-08dc23284e95
X-MS-Exchange-CrossTenant-Id: d0a766c6-7992-4344-a4a2-a467a7bb1ed2
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=d0a766c6-7992-4344-a4a2-a467a7bb1ed2;Ip=[151.1.184.193];Helo=[asas054.asem.intra]
X-MS-Exchange-CrossTenant-AuthSource:
	DB5PEPF00014B9E.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR01MB7881

Add the Everspin EM0004LXB 4Mb (512KB) Industrial STT-MRAM Persistent
Memory.
This device is JEDEC compatible (JESD251 and JESD251-1), but it is not
able to provide SFDP information.

Link: https://www.everspin.com/file/158244/download

Signed-off-by: Flavio Suligoi <f.suligoi@asem.it>
---
 drivers/mtd/spi-nor/everspin.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/mtd/spi-nor/everspin.c b/drivers/mtd/spi-nor/everspin.c
index 5f321e24ae7d..4741930ce9a8 100644
--- a/drivers/mtd/spi-nor/everspin.c
+++ b/drivers/mtd/spi-nor/everspin.c
@@ -31,6 +31,14 @@ static const struct flash_info everspin_nor_parts[] = {
 		.size = SZ_512K,
 		.sector_size = SZ_512K,
 		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR,
+	}, {
+		.id = SNOR_ID(0x6b, 0xbb, 0x13),
+		.name = "em004lxb",
+		.size = SZ_512K,
+		.sector_size = SZ_512K,
+		.flags = SPI_NOR_NO_ERASE | SPI_NOR_NO_FR | SPI_NOR_HAS_LOCK |
+			 SPI_NOR_HAS_TB | SPI_NOR_4BIT_BP | SPI_NOR_BP3_SR_BIT6,
+		.no_sfdp_flags = SPI_NOR_SKIP_SFDP,
 	}
 };
 
-- 
2.34.1


