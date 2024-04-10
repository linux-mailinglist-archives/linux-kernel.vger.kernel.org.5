Return-Path: <linux-kernel+bounces-138341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA3389EFF5
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D68471F230F4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 10:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96A79159218;
	Wed, 10 Apr 2024 10:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b="V1si9NZT"
Received: from EUR04-VI1-obe.outbound.protection.outlook.com (mail-vi1eur04on2044.outbound.protection.outlook.com [40.107.8.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C64212AE75;
	Wed, 10 Apr 2024 10:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.8.44
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712745448; cv=fail; b=iZYtyTLu0qNd4HNnS3CFg+Hy6MkISUg6dnAcJUMshp+ef2K0KtdAuhJlxoNXGdp9TNFezMie3VmCxUvn635+8xygaN1wgr2wMKZOPueQqStnsglZmTs2toUXKVDqdyPgomYN/xpMKou+xh3tiUV+9Iii3LYGYA5Mji9pXXpFIIY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712745448; c=relaxed/simple;
	bh=U+J6y+7jl6TlckUmz5u5h9laca3pWwmI9CqGvncdL88=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RgZLMpVQ3ftyTCldCLYKEirw9L0cIfrMR7kHO3KAhpg03ZBYzw4m58BsHhESvBTjWkYm5GfcSB+vt0fRsA+IXXKUWgnLXD6nuvobSIfhZqfqQLRfU6DdK4+i8rYpeKROi5g/i8vCKWlIKcJqf9wnikez+OEHpTwvNLZJwbbwCII=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com; spf=fail smtp.mailfrom=leica-geosystems.com; dkim=pass (1024-bit key) header.d=leica-geosystems.com header.i=@leica-geosystems.com header.b=V1si9NZT; arc=fail smtp.client-ip=40.107.8.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=leica-geosystems.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=leica-geosystems.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iG/PnCm3X+84yczPQOraZz4m1ja6XXXlk6EG90BIsv89t75fTEf52DAmnfxkZiB8xGsITbmAeMsGMhjbKpMdRO3yc/toIcesk3De29a0VQxSn9z28sHHVlYKszX8pL6DEHjQQik3XbYS2lFeFFBUaItZSrzaqb6ZJCm0czzYe8fIvzPDP59dLKit7MOLlURsVRIRhu2Oy1JWIUH4dT25RYDmIvsHPI67Nq/TYKx3RAQzbgIZN+BmEsAgS1vRo3bamoww3VIWbgZQ8LN23kVU7URQJq2TebvZW3RoOYUKY6ylHGF1PbLpboFe6tMDIy60o5bN9C0Kjv1zqH3wyy6NNA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=xP6ADPSU3O+zHwfdZg4R+PXEk/FHqyuYmvRjtxC2TRw=;
 b=C8DWkq7zTt6gkXpMbuLeopb7Ivtk2PtMxE0CBa3f8IMHe0YS6NCaPPS7pGUuq5zmVCoLqV1gOUBMVfdi0rAYSMDbRcLDcM9TG14/CGlkiwevypd5AUifh28A/0YQ3GQh7CoOREFOp1W4ULOXRSsW454J1WHxhDyVje8LC1XV08JKGn9O9cxu4RdaREZdAyixPhGzjQhxQibtRIrLNEZBgSfoEXTAI5+NKXQnsJzgcgBDjViyETYRWIa0hnjhla99q2cbY+w7DnvANvXDYcG/KuXv1x64JLAddxPIga/yqolsUY+G78meCr9Q8sgqO/wr2Fmp3PL/ubxLPmPvx1BRug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 193.8.40.94) smtp.rcpttodomain=vger.kernel.org
 smtp.mailfrom=leica-geosystems.com; dmarc=pass (p=reject sp=reject pct=100)
 action=none header.from=leica-geosystems.com; dkim=none (message not signed);
 arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=leica-geosystems.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xP6ADPSU3O+zHwfdZg4R+PXEk/FHqyuYmvRjtxC2TRw=;
 b=V1si9NZTNYwLz7aVyTkRp7jMqtz8pyerpXOqs/9p6Ei1aseY7eKAe9G/a7s1TG4YS+kPWUtBbZla+KAFH/8F2EzLz3iPfxI+HsakNKg8VyixOI47CEFe+VfkmLWlwuUxNMHGIOKMlFDVJr81U07dgWM9yb7S3Qdutb8aspNWcJg=
Received: from AM6P192CA0062.EURP192.PROD.OUTLOOK.COM (2603:10a6:209:82::39)
 by PAXPR06MB8392.eurprd06.prod.outlook.com (2603:10a6:102:22a::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.10; Wed, 10 Apr
 2024 10:37:24 +0000
Received: from AMS0EPF00000191.eurprd05.prod.outlook.com
 (2603:10a6:209:82:cafe::8c) by AM6P192CA0062.outlook.office365.com
 (2603:10a6:209:82::39) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.19 via Frontend
 Transport; Wed, 10 Apr 2024 10:37:24 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 193.8.40.94)
 smtp.mailfrom=leica-geosystems.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=leica-geosystems.com;
Received-SPF: Pass (protection.outlook.com: domain of leica-geosystems.com
 designates 193.8.40.94 as permitted sender) receiver=protection.outlook.com;
 client-ip=193.8.40.94; helo=hexagon.com; pr=C
Received: from hexagon.com (193.8.40.94) by
 AMS0EPF00000191.mail.protection.outlook.com (10.167.16.216) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7452.22 via Frontend Transport; Wed, 10 Apr 2024 10:37:23 +0000
Received: from aherlnxbspsrv01.lgs-net.com ([10.60.34.116]) by hexagon.com with Microsoft SMTPSVC(10.0.17763.1697);
	 Wed, 10 Apr 2024 12:37:23 +0200
From: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
To: joel@jms.id.au
Cc: bsp-development.geo@leica-geosystems.com,
	Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>,
	Eddie James <eajames@linux.ibm.com>,
	Jonathan Cameron <jic23@kernel.org>,
	Lars-Peter Clausen <lars@metafoo.de>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/4] iio: pressure: dps310: support negative temperature values
Date: Wed, 10 Apr 2024 12:36:01 +0200
Message-Id: <20240410103604.992989-2-thomas.haemmerle@leica-geosystems.com>
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
X-OriginalArrivalTime: 10 Apr 2024 10:37:23.0572 (UTC) FILETIME=[12CABB40:01DA8B33]
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF00000191:EE_|PAXPR06MB8392:EE_
Content-Type: text/plain
X-MS-Office365-Filtering-Correlation-Id: c85dd139-b7f5-4ad8-18d7-08dc594a3569
X-SET-LOWER-SCL-SCANNER: YES
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	ftCzKrumD6+0rRqa8gnx2GsUK7/TONo2M8lAjQTAHOWYxUYrGNp5mela732+vNv6XaSrvgGOiMAJGPvxUgYBckhX5RHpro3Zexroa7tbK8PWjBr1BNFPuRfZag+6iXrSsw6pe1pm9F5bucUi4xFqiDlM9PicPh63yvwUHB6aY1K0ay5DuMhQawXpxuwS3yvdxgYdx9525V1Av2CF0h+5ByVrL4z0oodwuDrnrTbJZM96qX2f3IgLqc/Yq2A5rJWh+e4OjCtmJJd1+PSGgtap+r3P0fqhdr89cFwh1a+TfKWS96hTAeJ9QViXDSbX2XdSSwAblUjCAvnSAyw9vDPMb54Px+Xbko21Jg3+nOiPwrGq6RwRPp7KTvYZbLB11UhVhYnmu3tG4RBmJzDhpcawgIuPxU3OOsLZ+iZeMsYcKU0cfp/uGPw4OIirXg1JFyw8vyffYAOsFEOzGSrbxU7VzMX77lwraw0bl97IGLnrR/zYUEG5MARPda0iAbJLn2v/nOoqJQHe7KPe0Bq7VA+u0t2N/JUdnc1LTZa7TvCPDCzFBsd29ARsKMPpUHzZimEdPG7EuzlxR1yZAlmxmbnefiKWvpX+qiLvL0dI2MdNLifqiYClwyVN3lET31RihQsjurd9qKnONq/VvOLJd6r4TGJufE1frOb3V95SKCmuopjh8Lqy4GuAtAUzgWOIVquAx9c4ReV2WePSzGJOWyQeT1UPOo3uc0zOGU4zpSODuiO8o8WjlNgqbJPuaMlpVouG
X-Forefront-Antispam-Report:
	CIP:193.8.40.94;CTRY:CH;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:hexagon.com;PTR:ahersrvdom50.leica-geosystems.com;CAT:NONE;SFS:(13230031)(82310400014)(376005)(36860700004)(1800799015);DIR:OUT;SFP:1101;
X-OriginatorOrg: leica-geosystems.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Apr 2024 10:37:23.7362
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c85dd139-b7f5-4ad8-18d7-08dc594a3569
X-MS-Exchange-CrossTenant-Id: 1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=1b16ab3e-b8f6-4fe3-9f3e-2db7fe549f6a;Ip=[193.8.40.94];Helo=[hexagon.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF00000191.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PAXPR06MB8392

The current implementation interprets negative values returned from
`dps310_calculate_temp` as error codes.
This has a side effect that when negative temperature values are
calculated, they are interpreted as error.

Fix this by using the return value only for error handling and passing a
pointer for the value.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Signed-off-by: Thomas Haemmerle <thomas.haemmerle@leica-geosystems.com>
---
 drivers/iio/pressure/dps310.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 1ff091b2f764..d0a516d56da4 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -730,7 +730,7 @@ static int dps310_read_pressure(struct dps310_data *data, int *val, int *val2,
 	}
 }
 
-static int dps310_calculate_temp(struct dps310_data *data)
+static int dps310_calculate_temp(struct dps310_data *data, int *val)
 {
 	s64 c0;
 	s64 t;
@@ -746,7 +746,9 @@ static int dps310_calculate_temp(struct dps310_data *data)
 	t = c0 + ((s64)data->temp_raw * (s64)data->c1);
 
 	/* Convert to milliCelsius and scale the temperature */
-	return (int)div_s64(t * 1000LL, kt);
+	*val = (int)div_s64(t * 1000LL, kt);
+
+	return 0;
 }
 
 static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
@@ -768,11 +770,10 @@ static int dps310_read_temp(struct dps310_data *data, int *val, int *val2,
 		if (rc)
 			return rc;
 
-		rc = dps310_calculate_temp(data);
-		if (rc < 0)
+		rc = dps310_calculate_temp(data, val);
+		if (rc)
 			return rc;
 
-		*val = rc;
 		return IIO_VAL_INT;
 
 	case IIO_CHAN_INFO_OVERSAMPLING_RATIO:
-- 
2.34.1


