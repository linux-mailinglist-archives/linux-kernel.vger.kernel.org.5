Return-Path: <linux-kernel+bounces-156798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0FD48B0850
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 13:30:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 36CF71F2340D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 11:30:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1DE815AAAA;
	Wed, 24 Apr 2024 11:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="ZypzHpKD"
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2041.outbound.protection.outlook.com [40.107.94.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D705159914;
	Wed, 24 Apr 2024 11:29:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.94.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713958196; cv=fail; b=f//4XGqtc08zxENcw9Vv6L2+V5RiQN0k6Vqxd2oEzXM3MCUyNpU8le8cLcp+x/emUCkKKBOse+LRfQ4ybuFveMs3+o95y+PvjdPmFBHNYORB9h9NciSegHjflwkThNrc9HaA9hgeDn+1bHP6sU9pDVRLRC3SZMl2t64XrVE1DDk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713958196; c=relaxed/simple;
	bh=JCVXeURDnntSs2OqsTREsNScZ1OuIu5QGJhR/5fgFr4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KShDCQGAgK0RzsnfBIluR/gepC5rPULR2EMGv/bOwwCZmeSYAXoiusz+2vbln2o++ZAGBm2Nxns6bgReK6Wu5CJO+mLEjaC4SQYy9SV6UGAdEbyOrg58PB5j42xw/ykCg6uo6U4bIqFZNAOLLcfiJQamlwGkOY7/VJWQEIpz4SA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=ZypzHpKD; arc=fail smtp.client-ip=40.107.94.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HhziOywqlzwTg3LxUQOA/77mfTvonNu1F906kZPSutNftWnQuAK5GyEOkQNSzXPzF6kzvXnfrXot4jUT5Gt4onC60pS/YqDAwv3xN7XpPLCVYbiHAxuRcn0GRaTmP8c8NbH4k6R5aIKOP37/cKxE3R/fxo2GgSMdkJbanEjzDFIyzATCi6I7YgM47L/Bq/T8kO1MVDzwNumMwgwIwmfir2itsjo1x7Jc5ZQdQixt3uu/OFZBJIN2pgzPVzABguU8cFVD0omRv8h+TSlejFkGl30L8UiL2TviXglo/9jtVwjJn9hvTz6ZhqZPvrQW4XTm2VppAvCpXZeesg7B6IDYnQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SGU6cRRPtQ5MQmeNtpRTpQD1WatfujfgSh+grfQ6S8Q=;
 b=DXNoOs+sqLTntk7Hx3L86ZBE+vMV9QumPbTKbOmF+e3G+7JJGTOjT7Y3Dn3RsaUyMQBIt/CuA+CPKIo7bbEq1Ar8jRFAGb3ahO0gAtSzlhyPqrmSQ4Dn0oMOqxWr9UySY6RDJ30UL0RNjDHCQmSWM73oIEEe97iP3RbpDg45f/XesuYYLStdRsYIqG0P7sWNHf/Z5G7Hvd1BgRDHDPxXYnYuzi8b2YrzTcexUWHOuUQNR+rieDzcTiKUb/6z4OEPMZ75aT4R4v6zWeHbr/OXGrB3+4PLy3i1yTtI8NiDz4TD3611VVPpaQlZ0qacjWOT9RFHKoLqCE/oO4PVMc+XXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.infradead.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SGU6cRRPtQ5MQmeNtpRTpQD1WatfujfgSh+grfQ6S8Q=;
 b=ZypzHpKDEeOqoFCTSnzk5sJ6fLCiXG09w33T1VH2Be2B5zdXNK82J1NRnBHr/M/DIWXyjAt5/NaEd20MOrBv/gT8wQiUbBtHVLgVh5eJ0XDZ7YHKRLbbkGe+mtrjr38zhfcVYfAf8Q8V1/WPKpLcKez4nYaFVFlzLnVV1ckJwNQ=
Received: from BLAPR03CA0064.namprd03.prod.outlook.com (2603:10b6:208:329::9)
 by LV8PR12MB9264.namprd12.prod.outlook.com (2603:10b6:408:1e8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.23; Wed, 24 Apr
 2024 11:29:52 +0000
Received: from BN2PEPF000044AC.namprd04.prod.outlook.com
 (2603:10b6:208:329:cafe::4a) by BLAPR03CA0064.outlook.office365.com
 (2603:10b6:208:329::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.36 via Frontend
 Transport; Wed, 24 Apr 2024 11:29:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 BN2PEPF000044AC.mail.protection.outlook.com (10.167.243.107) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Wed, 24 Apr 2024 11:29:51 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Apr
 2024 06:29:51 -0500
Received: from xhdsneeli40.xilinx.com (10.180.168.240) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.35 via Frontend
 Transport; Wed, 24 Apr 2024 06:29:45 -0500
From: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
To: <git@amd.com>, <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>,
	<robh@kernel.org>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
	<michal.simek@amd.com>, <p.zabel@pengutronix.de>,
	<laurent.pinchart@ideasonboard.com>, <radhey.shyam.pandey@amd.com>,
	<parth.gajjar@amd.com>, <u.kleine-koenig@pengutronix.de>,
	<tglx@linutronix.de>, <julien.malik@unseenlabs.fr>, <ruanjinjie@huawei.com>,
	<linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <srinivas.goud@amd.com>, <shubhrajyoti.datta@amd.com>,
	<manion05gk@gmail.com>, Manikanta Guntupalli <manikanta.guntupalli@amd.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V2 1/3] dt-bindings: serial: cdsn,uart: Add optional reset property
Date: Wed, 24 Apr 2024 16:59:31 +0530
Message-ID: <20240424112933.3528590-2-manikanta.guntupalli@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240424112933.3528590-1-manikanta.guntupalli@amd.com>
References: <20240424112933.3528590-1-manikanta.guntupalli@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Received-SPF: None (SATLEXMB04.amd.com: manikanta.guntupalli@amd.com does not
 designate permitted sender hosts)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF000044AC:EE_|LV8PR12MB9264:EE_
X-MS-Office365-Filtering-Correlation-Id: eabbba89-f9d0-41a9-514b-08dc6451db9e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|1800799015|36860700004|7416005|82310400014|921011;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?m3K6uzs5Mtn3cf/zbGmblBKFB/9AB3tbZnE8jOjeA8R2sI2mFDF6onzx3J/v?=
 =?us-ascii?Q?dl4BaaNqe+7TnvnTRc9j3e4La1DlasNEvNh+4VAx5+WtSrH6tBjQFYBVaSDx?=
 =?us-ascii?Q?kdsXbvjKenXYYn/aRb5ffQ4fFpcAjTjcIfRKCclQ/C/4juFrgFCrGeL6shIj?=
 =?us-ascii?Q?r2HwZmNXO09NaPiPGwA2GSOfEjFtS/Rj8Cv8DlKQUadM0ChQ7YRQ1xiPIwKL?=
 =?us-ascii?Q?69HVhE7t6Iojo3auU9ecG8CPBTIbwJlu/pE6W0aZUnJi5pQ8Rz8fIm7Asiwj?=
 =?us-ascii?Q?VbukIrgOgbt0BePxTUbCBtTvpQHNbQvSvKlmNE/oKygvB8jpqWVK2gjPd/qs?=
 =?us-ascii?Q?T9zR0+KVz9v7YD9zX0hN+TVBjY8z+YS2KfIXGU3yDOO7Kcclo7uG1UPgG2CQ?=
 =?us-ascii?Q?T+8MyiOfRGHQIuFo0ZWdCv0QuRHld94GFVdXNqR58zIy0qGXhWck4ddFWKcp?=
 =?us-ascii?Q?7LQwff4MVgfmDKYqo7ofWv9I47/3OKFg3X3SPVaagtF8ofEniVrwlR0lHrIX?=
 =?us-ascii?Q?QIX5dSpwNX+SNbpLPUX/pHp+a/PGof+dYwSFUG6Ei5v9BSu2CW5UgM/FyTTf?=
 =?us-ascii?Q?W5NEjc+LhgMRk7t7wraWtCVupHh5cB0lv5WbkFqzYJ4r/jrFapPH7dhteLX0?=
 =?us-ascii?Q?Cl5GOvGrP0N7qCchAUxxyqLB3NHELE2XAeX251uqVgUDFEkrWPhUUiJPHNg4?=
 =?us-ascii?Q?XoAi+E+3WhEax7IufcGmE/koyAAxYp1ZmvyDk7iy/RyIvu80wDLPz8d+YsW7?=
 =?us-ascii?Q?ISa1YEA+el5rLmCS37kB0WvFnsxfSqyYN92uqX2gvh0a4LJJaWqlmESd4zUu?=
 =?us-ascii?Q?JcjBTPhbkOgcnO1flMC0Rw8EoXWq0j4YCVQUXVZ+cPIu4wKCGlGL/5leN6+C?=
 =?us-ascii?Q?+owwpQfaQjU3DH0j5OoSwr9QwCgebU8lw3KWatYpV50mKoKTAG40vbidPYUZ?=
 =?us-ascii?Q?oeeZQEvXHbC6p0pSsOWtdE2Nk3rgEev4vViUXAfUXFAiNd0+rzfeNndUYz7o?=
 =?us-ascii?Q?pf62sCY6VAgPr9kTBIkDDi9R6FrsV1siWo3GZuSao1Ct1VnL2HBxHZgadBNw?=
 =?us-ascii?Q?Vw9r1CEvH1D+E8IgN8W3XkF1S6Ea11y9jdHs6gqCsBx/i9DsAVjXTjhmkBBb?=
 =?us-ascii?Q?6SMS+puS6HiLFWv3hp1jXFWdrDTDvm3Smf90uhWckaPhs1CNJzDkQ3Ogn53Z?=
 =?us-ascii?Q?StM65XZIb098vN1UqVD1z01BK25uM78mSI0RZoE/PqFq/Zr91EqzwHgqnLfm?=
 =?us-ascii?Q?L+ue2TBCqf0YemB5jWjyYsTGsGir4LhjB64DBWkSSpnKr1jreVH1UxOB9fIX?=
 =?us-ascii?Q?dpbCXs9/YIQvFeqS4kxGKVeJu0vmvufr6knxTdIdzrL1TQFA/EtUgI6a9JBU?=
 =?us-ascii?Q?uKIPMN4vg1GFMQSu+Be+lI6AzF5k?=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(376005)(1800799015)(36860700004)(7416005)(82310400014)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 11:29:51.9013
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: eabbba89-f9d0-41a9-514b-08dc6451db9e
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF000044AC.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR12MB9264

Add optional reset device-tree property to the uartps controller.

Signed-off-by: Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
Changes for V2:
Added ack signature.
---
 Documentation/devicetree/bindings/serial/cdns,uart.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/serial/cdns,uart.yaml b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
index 2129247d7c81..d7f047b0bf24 100644
--- a/Documentation/devicetree/bindings/serial/cdns,uart.yaml
+++ b/Documentation/devicetree/bindings/serial/cdns,uart.yaml
@@ -46,6 +46,9 @@ properties:
   power-domains:
     maxItems: 1
 
+  resets:
+    maxItems: 1
+
 required:
   - compatible
   - reg
-- 
2.25.1


