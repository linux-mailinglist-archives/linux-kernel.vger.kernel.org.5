Return-Path: <linux-kernel+bounces-138342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E1E89EFF9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:37:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43E301C212CF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 179CC159597;
	Wed, 10 Apr 2024 10:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="g3aAVYgy"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2041.outbound.protection.outlook.com [40.107.13.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E0BA15956A;
	Wed, 10 Apr 2024 10:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745453; cv=fail; b=GFpUn12CYWvtk6V3QSk9Sv8ui/9if5DY8aCv/23ZNRiUhBmbENLDF/amvUJ2VBwWsHwlUjTzh5vjyvlX7F0uB7jr5i/msHHcoj1z4ja5IllRvZS8IYWjGkVz0Fh4Fs1LTrQ1zNUu9ftLeqFhZ3s1rH0u+4JdkgIy06Y4Fo3V/Fc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745453; c=relaxed/simple;
	bh=dyO7Q1cK6nJXCooKw9U5LxnkIs9UCn/gZarxxtYita0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hxnoPdCVbWYaVCFfQ16+hiMNbHJHHFX1/We3u30bHrHAErnx0TBAwVB7WP53/eX4qvX6s1ISzS/v7h1zfXzdakXt9q06bTaK0r1f5zC5Pb2cYBqen2ERp6twmYGzvcgeqNN639e6PCf0U2tn6tO4lq4z7goxutpxntY5hc1PS04=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=g3aAVYgy; arc=fail smtp.client-ip=40.107.13.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IhqU9Re03vTM/9YuwbBNGun6qZJI3EPaDeGN/62jauJryeILR9OlFp2QJNW2iOT0YpuNBiaVzlNtDV/3Fqg6RPMoURPfjVA5WNg8Sd93kFo0OV0Hz3n/g2s6xFjUvprtxs/Pn2LlfkG8spTedMFwsSf2KSbL9w9jI8yiRu2uPG5Wo2pNovKmHaNs+DX2WgyGj93xFocv660ww3ZtR8h1ITpoO4enSBlc0o5lm6m0sLZBQwigzHlBvbedzeZ89L4xRP7FjjHYp2nHr8whPE4cWbWzJGELk/YnRbfwL241JGzx8RKBXpjlhAEEe3HucNhrpDiG/VIUvlFFSi9oHneLKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Nt4dhMihHQdOE6b+saNtIadmPGDVucg0iJGhNOcCKYc=;
 b=fXQPT9tV48LsMVsy7raBk3IT0v3ITf0GLyZJjWxgwH789Jov78MnnLCbW1Cly7yRGZSMKjHZFl/a3Vw4jLBlSrcCw4UuDhbVc9bmqvVZcsjEhkDj+Xv8C4Mhbt1DOC4xbaYyENlvXN4apwNKan+ulZDTMnAXCur53IjkL/7EhwhYxOUMs+g6v+d6YoTkDkAT7RClRHErE96W/7f1D6v/NZHdOc2zpNXZGxtJsvAEZEj96ykNcB4g9aayUMw0QqhSm/JrA9RHudDqIbxN6iEfJ1RVFmi4zFiYfwmceq400rM21IhaHY6Il776mE842R/8UvTYAQclClYVaF6OEYpoeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Nt4dhMihHQdOE6b+saNtIadmPGDVucg0iJGhNOcCKYc=;
 b=g3aAVYgyL5Mlsmfehy3nHz+UdOBSFcdorHxza/0duvbep16LKu3Kcmml8kewstbH5oRi99Go5WKg2/gjbo6/L6wrtNzKKYGCS0g0nQgKOQVZFP8o8wgRfrELS8VTu80ElkVPoOaZEXLCj2QzOK1RivcSPKqrLmYzsQ4Yi6zJr84=
Received: from AS4P191CA0046.EURP191.PROD.OUTLOOK.COM (2603:10a6:20b:657::6)
 by DBAPR06MB6742.eurprd06.prod.outlook.com (2603:10a6:10:186::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.26; Wed, 10 Apr
 2024 10:37:27 +0000
Received: from AMS0EPF00000194.eurprd05.prod.outlook.com
 (2603:10a6:20b:657:cafe::da) by AS4P191CA0046.outlook.office365.com
 (2603:10a6:20b:657::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.33 via Frontend
 Transport; Wed, 10 Apr 2024 10:37:27 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF00000194.mail.protection.outlook.com (10.167.16.214) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 10:37:27 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 10 Apr 2024 12:37:26 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: joel@jms.id.au
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/4] iio: pressure: dps310: consistently check return value of `regmap_read`
Date: Wed, 10 Apr 2024 12:36:03 +0200
Message-Id: <20240410103604.992989-4-thomas.haemmerle@leica-geosystems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240410103604.992989-1-thomas.haemmerle@leica-geosystems.com>
References: <20240327084937.3801125-1-thomas.haemmerle@leica-geosystems.com>
 <20240410103604.992989-1-thomas.haemmerle@leica-geosystems.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 10 Apr 2024 10:37:26.0947 (UTC) FILETIME=[14CDB730:01DA8B33]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000194:EE_|DBAPR06MB6742:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: 21157d67-108e-46c1-ed17-08dc594a3775
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	hsPFTA3+ClKL9pmlDpk8NSj8tFbeWZV1jzDuiXh9eUC2cY0fA+ax6y+wHUvdJwh3M5ZZ3zvM9KNc94nMC4Tea2cq12p2g3aNidLg2GKe5PIofczNHRQLO4E2OoluBhLvzZFuzxvASJiRP5f1/L4T7EEKhIg8sSFkC28vHQnzNjcqmI9OdESBqjOSvYpMHCQ4MSz4Vz+DWtFtKgLsALY/nKxctMUZ6HRruIZV7+VNs9FG6zqp7DgP8SNc5D/usd9rz/1MIxOUR7fwRaauFs8R3N4z4CKtboNpppzMNmkLGqdiJwRhyuBoItoqVNOVA3Khw5ZA3ctwzXFGgpZaQ4+6HLsSdeNoYirCDoMq5SevBAr3GBn/fn7L0FGoCvCFCHcX2wZdAWRQegWvyxF0yZ5sbdCNWXNJlitj4Ls0AcE30yVmVqj1XvJ0e6n07VOBeB3e+tMn/4xl4ZHwucwCZWkVT2UX1u7YsEz0S7DnzM7n+S8NsJDGaaXHw1l++Ch0oTUtEBTsd70xa9TNQumy5W7uEMqN1UE3weD2y8pJlC8NoWCf6KxepdtplwV0EOFyUzSwKjSiRcMdtgkTlx0rYQ7TfPbp7b4EGaA7OmFeFOED1wi3VE7o1HoWbAVO/Dlz1mfQHoIqY1x1DRRBLO+CpzgoqDt75ScFLdfBa34qAO4r/lWX9oFRpmulpTFP9iatTV/yVNeYUhVFQFg3vcaNQlGSsOwXJ0OLWWRttcIdw4C5f7hwZBBo8yaaxB+x+a1nf7dP
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(376005)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:37:27.1757
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 21157d67-108e-46c1-ed17-08dc594a3775
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000194.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR06MB6742

Align the check of return values `regmap_read` so that it's consistent
across this driver code.

Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
---
 drivers/iio/pressure/dps310.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index a48e8adf63ae..4abce7e40715 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -171,7 +171,7 @@ static int dps310_temp_workaround(struct dps310_data *data)
 	int reg;
 
 	rc = regmap_read(data->regmap, 0x32, &reg);
-	if (rc)
+	if (rc < 0)
 		return rc;
 
 	/*
-- 
2.34.1


