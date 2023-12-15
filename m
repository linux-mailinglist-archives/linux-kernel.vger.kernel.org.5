Return-Path: <linux-kernel+bounces-942-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CE91814851
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 13:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 932441F23D5A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:43:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B5392C6A1;
	Fri, 15 Dec 2023 12:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=axis.com header.i=@axis.com header.b="Mn+vXCRi"
X-Original-To: linux-kernel@vger.kernel.org
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2041.outbound.protection.outlook.com [40.107.22.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F7A42D78D;
	Fri, 15 Dec 2023 12:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=axis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=axis.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=G+HwuC2WpPt/S1kV/5DHIHd6qPJPtqlvZWeiyg5Z4khStY2r8VRAnvK+DAeEw8EN5f/J1wphuLl/e98kl/L2JuXCRp+D1OdanwzAeG3qVHDVv9tHC2AE1QWvEC6kjopVup2Gc+qSbyeKhzn3WD8QduG5FBMlSnsLlxbeBhRAW/5bmoBV4QtzQKR7wWxJ5B6Upio/RRKVkL4at5A4PXuFuUtIbhqyFE1TfKCxgeVa1Kfdv6oJp4UuDDtrE8EzwIo/u81l5LhBz2JkeBFUEm8WKkIKDJzkFShoBc+iv4UgeBff3ZG/0ow29z3E6uPT3m1TPvfj3J+dWJ8+rWc5Yu9fDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gVlbeHodaBkyuhB5Z61CiMDCxmOr9AuX3+iIVFnYsh0=;
 b=agmmpmegXNw3VwBW0alhbJ/w4Zj4GwJSkU+6LPcCtfmkiyrgN/mkZvwBafpOvU7lBrfBiEYxjooGw94Oob9eQBJpWYaeaD2Z4zffLYLoXJmj6P4IgHhqgmuTEeqFZ2vz6ZRwsOnidm+sH679u+ZwHPiiwkQYbYmUy2RnoXThFdyF+UgXf4Z1MO+TMCymwwRKENx9UYJx+ixL2BIQTvDQ9rDkUaBWi9ZIdV8eGvgbpMNq0dm3o6l01+DVMOYncfEnb/kE32ol2roAen37aUQIXkWcSW+7D1BltjYEri/YL5Xrk10yog/+REpX7zvvSzaSjtoURIdQfuBZXZYp/E4IEg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 195.60.68.100) smtp.rcpttodomain=kernel.org smtp.mailfrom=axis.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=axis.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gVlbeHodaBkyuhB5Z61CiMDCxmOr9AuX3+iIVFnYsh0=;
 b=Mn+vXCRi+uRrkcEp1SsLgpoT9FML4X9sQqWYcAPXzgII/7hqnAEqsAzxdnwVOZuQy33YTa6lswcLPgBX9oap1vdVVd/MgJQL4TS1sLSj7eHpvbvQYL7Qwt/tCz5EgV2wNxNZvVO9FBB4kXW16QY/Fx5UVcqXVdAVp1zRYzd8oQ4=
Received: from AM6PR0502CA0053.eurprd05.prod.outlook.com
 (2603:10a6:20b:56::30) by GV1PR02MB8404.eurprd02.prod.outlook.com
 (2603:10a6:150:5b::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.28; Fri, 15 Dec
 2023 12:43:18 +0000
Received: from AMS0EPF000001A4.eurprd05.prod.outlook.com
 (2603:10a6:20b:56:cafe::f7) by AM6PR0502CA0053.outlook.office365.com
 (2603:10a6:20b:56::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7091.26 via Frontend
 Transport; Fri, 15 Dec 2023 12:43:18 +0000
X-MS-Exchange-Authentication-Results: spf=fail (sender IP is 195.60.68.100)
 smtp.mailfrom=axis.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=axis.com;
Received-SPF: Fail (protection.outlook.com: domain of axis.com does not
 designate 195.60.68.100 as permitted sender) receiver=protection.outlook.com;
 client-ip=195.60.68.100; helo=mail.axis.com;
Received: from mail.axis.com (195.60.68.100) by
 AMS0EPF000001A4.mail.protection.outlook.com (10.167.16.229) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Fri, 15 Dec 2023 12:43:18 +0000
Received: from se-mail01w.axis.com (10.20.40.7) by se-mail02w.axis.com
 (10.20.40.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 15 Dec
 2023 13:43:17 +0100
Received: from se-intmail01x.se.axis.com (10.0.5.60) by se-mail01w.axis.com
 (10.20.40.7) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Fri, 15 Dec 2023 13:43:17 +0100
Received: from pc42775-2107.se.axis.com (pc42775-2107.se.axis.com [10.94.129.29])
	by se-intmail01x.se.axis.com (Postfix) with ESMTP id 38A681002F;
	Fri, 15 Dec 2023 13:43:17 +0100 (CET)
Received: by pc42775-2107.se.axis.com (Postfix, from userid 21033)
	id 3164F2FEDDC; Fri, 15 Dec 2023 13:43:17 +0100 (CET)
From: =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
Date: Fri, 15 Dec 2023 13:43:04 +0100
Subject: [PATCH 1/2] iio: core: Introduce resolution standard attribute
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-ID: <20231212-vcnl4000-ps-hd-v1-1-1c62a95828c0@axis.com>
References: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
In-Reply-To: <20231212-vcnl4000-ps-hd-v1-0-1c62a95828c0@axis.com>
To: Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>
CC: <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, =?utf-8?q?M=C3=A5rten_Lindahl?= <marten.lindahl@axis.com>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1702644197; l=1316;
 i=marten.lindahl@axis.com; s=20230329; h=from:subject:message-id;
 bh=g78eLtKzeNWvee2JE6hc8/3fxzoe/g0pF2pOlQRG5Ms=;
 b=FmTbhaJ1pgQvYSUi3Q2drgMCYi9CXjVTDGLaMMjDVj2nrMgcFg7pBBCdDCjNRpOd8XkgxpLUo
 1hj1GPmI2o5Cj2NntxrpkXPFbdEKaWinHsL+pi4khf4rbOpuY5faaI0
X-Developer-Key: i=marten.lindahl@axis.com; a=ed25519;
 pk=JfbjqFPJnIDIQOkJBeatC8+S3Ax3N0RIdmN+fL3wXgw=
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF000001A4:EE_|GV1PR02MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a12726a-b255-4e3d-3bef-08dbfd6b69d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VH2uQg+Fs98kqjHXa5QV6sO/C/QC+axOJopxp2akJ/slPIR+bCUPPNQwhNE/L33CyRjkAjW8Ra+v2epIdE4404J00Qev1QC5lhj8jDSrdG+nxfxltZCMjAZ0lhpm2ZDIHNB1XdmSTGSCUk/EHU4iqVYDi6hhIjy2vOJ/yStj79JDTHcAawxOboJFUgWxyzXowXbw8s+4ZoeB6RTgVT3RqjepEHYYHuQPqycaL12P52m5rCNTfD6Y64E1CwftcSb5R3m8a+MAbI4dYjHlrfBnrpxcKxjbDCNIA+o7kCygP+d/jIgwH5jnBdBTfZpQNJzEKBTcpS9qNN5P4lBHjAtoAYkRhIf2RUdtgvmQfC+rYhYwoX/9bgKnyJoYNV1Lf6243Jd8FcPCpcTy3c20OGzQIhcBhcC9TurPA6U2vHcrsINavopVh+4HZTqZ2DHOc2gxqc0HC6uKDGSz26oI//lJ617KtwjZuSmJlF7F6gMTvoXMh/9X+kJ1IlA/FNvM8FrJYK4h8NCUTDdRzK2LH2UyPR89yHYhgw4GC/xyR6olt2lpk5Uj/HMc9uQ2oYn3RZCZ+2QeWSCfILiKHhqOvtGny8TOOJvqDSRew5JU8OtK6544I6Y7FM3MoP0GD2uw8OuxqtCktzGbxSYioyyIPMQOmK5dyCZLPcxCxp4DkgYMMG+LeOKVdtVyPEvF1Pc/O39Oux2oO0S2wuTLMIrDrAnGsIzKe/vkO12ElZGf0Yjlm0XqbKF4IaE4g3xGgKqtTGsstG2oRKzIHMtcwK6vC5RdKw==
X-Forefront-Antispam-Report:
	CIP:195.60.68.100;CTRY:SE;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.axis.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(346002)(396003)(230922051799003)(1800799012)(451199024)(64100799003)(82310400011)(186009)(36840700001)(46966006)(40470700004)(86362001)(36756003)(40480700001)(356005)(81166007)(40460700003)(82740400003)(478600001)(6666004)(70586007)(54906003)(70206006)(336012)(26005)(6266002)(107886003)(41300700001)(2616005)(47076005)(2906002)(316002)(110136005)(42186006)(5660300002)(36860700001)(426003)(4326008)(8676002)(8936002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Dec 2023 12:43:18.1654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a12726a-b255-4e3d-3bef-08dbfd6b69d5
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=78703d3c-b907-432f-b066-88f7af9ca3af;Ip=[195.60.68.100];Helo=[mail.axis.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF000001A4.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR02MB8404

Introduce a new IIO standard attribute to set bit resolution of the
data *_raw readings dynamically using sysfs.

Needed to set 16 bit data width (high definition) with the VCNL4040
driver.

Signed-off-by: Mårten Lindahl <marten.lindahl@axis.com>
---
 drivers/iio/industrialio-core.c | 1 +
 include/linux/iio/types.h       | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/iio/industrialio-core.c b/drivers/iio/industrialio-core.c
index c77745b594bd..4316e0290404 100644
--- a/drivers/iio/industrialio-core.c
+++ b/drivers/iio/industrialio-core.c
@@ -182,6 +182,7 @@ static const char * const iio_chan_info_postfix[] = {
 	[IIO_CHAN_INFO_THERMOCOUPLE_TYPE] = "thermocouple_type",
 	[IIO_CHAN_INFO_CALIBAMBIENT] = "calibambient",
 	[IIO_CHAN_INFO_ZEROPOINT] = "zeropoint",
+	[IIO_CHAN_INFO_RESOLUTION] = "resolution",
 };
 /**
  * iio_device_id() - query the unique ID for the device
diff --git a/include/linux/iio/types.h b/include/linux/iio/types.h
index 117bde7d6ad7..7de4d83ca105 100644
--- a/include/linux/iio/types.h
+++ b/include/linux/iio/types.h
@@ -68,6 +68,7 @@ enum iio_chan_info_enum {
 	IIO_CHAN_INFO_THERMOCOUPLE_TYPE,
 	IIO_CHAN_INFO_CALIBAMBIENT,
 	IIO_CHAN_INFO_ZEROPOINT,
+	IIO_CHAN_INFO_RESOLUTION,
 };
 
 #endif /* _IIO_TYPES_H_ */

-- 
2.30.2


