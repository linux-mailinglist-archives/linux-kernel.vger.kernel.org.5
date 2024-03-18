Return-Path: <linux-kernel+bounces-106370-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 553C687ED41
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 17:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF979B21058
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB899535D3;
	Mon, 18 Mar 2024 16:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b="Z7FUS8pb"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2109.outbound.protection.outlook.com [40.107.212.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2870A5337C;
	Mon, 18 Mar 2024 16:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.109
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710778650; cv=fail; b=rOOEBE0Vn+5hAr2VjcG/66yTUOzmryCvgUCvtzwqnT2z9+JqaTM7NPr3JhtaY55e7iHggbKHM9kpsJGPADK7+2lLcAK6t0cVzFKFTn0BXlP6LguX0ozM6LF2g8pe9U9extHAf4Wk373HowH2n7Wn5xa10a29lY6ZBNo6LGBjex0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710778650; c=relaxed/simple;
	bh=DULHNI04SJhwVQKUZhfx3FebQmgfl3IOc8AuU9lBkAc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=cSbUZKbwy9ztlnCE8CFB0lWuMg8+SAKHj7V5pmDfLz8WERL7+U0a3o21HevlJmKMsv8YSQEVjFgZIPSZY6PE75JdrLjbENcOHijikKj7CTZlFRNYtzlUz0JYlyuYrZs+P/V8u1K1H+q+H3usmFC1sTItXxz4sFcFNp8Ss5FuJOs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com; spf=pass smtp.mailfrom=phytec.com; dkim=pass (1024-bit key) header.d=phytec.com header.i=@phytec.com header.b=Z7FUS8pb; arc=fail smtp.client-ip=40.107.212.109
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=phytec.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=phytec.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EBblPC3Lrrps4HHxXG3olPF/jmBuuo9hO4TAc1XTaMefz8s/VU3S8VcyyBmWfGN0ZcSCZ6gOCfPF24KimSCCJrBi7wD2EOjQPzEl4i2mdRfMnqpF8Og6AZLimcRtHG5GUtRmhUStKRwLu1k8Mn/9SZo0nNEN5kSi38oKz3A/aKde4KwuYgfLpj2nZoaY5ufSJj67jBDgdOEAUrkdjaX8PHNM/YwQJWuHDsqP8XHOBq/xdnArplRsvzNY7czu329pkSqNb/vIta0pbosrLkh7lxMuzYerKVHkwQPj2HAlzBaT6zoTvJXk6No52BqCgUdYPVZ570e7e8JA8O3yYiKYBw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=GzhK0qnD3B5Pun4lOJC7rJFkUbceTgytlef1+yOP/T0=;
 b=dnSY7mJ0L3KzzhkW7ynIj/LrA6wTWG3FuZB6s4aJnucM3uG+Lv8N/FT9EN9giUPlg+hzoSMTMZc5ymPr0owvMhPAaV2u46vi3Kagi/xEAAoZBO65jjN5Ui7o+JYxSK3IKojzOoA2udUc1YX+VjaP9ye0g2fh5sP9FH3LGh87Qf9ZS8AkD9Hiyo+l5YGsXjIzkMud/oapxcO08a4PB9H3rZ4cRANAjrZ7nm15/GrRhzyYZa7FPBkcrv4UBldGuCH+ibJjpDSj8Wc4LTBSYlKmT/FB44jkGxfxZcNqT+3Cczc3vKXRzpYPN8vXHEyzk5JkxePzAoPVpXro1NnTpf2tyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=phytec.com; dmarc=pass action=none header.from=phytec.com;
 dkim=pass header.d=phytec.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=phytec.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=GzhK0qnD3B5Pun4lOJC7rJFkUbceTgytlef1+yOP/T0=;
 b=Z7FUS8pbklmIyQ2iun/weXfEJSWcsdYbsjIniHQDfRzsJ8spI+MlnG6OR1aqXPpZkmM7s/PUiz6jlYVJ3NAeYqFs0Ndp1lfwrNAzdqoZtF1BIXWzsJW8tV4wtKpsXxJ5xI1ZFh91EvG6DqrrqeYNlMSKO2ik3xRXgF4eyniJdes=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=phytec.com;
Received: from SA1PR22MB5636.namprd22.prod.outlook.com (2603:10b6:806:3e2::15)
 by MW4PR22MB3715.namprd22.prod.outlook.com (2603:10b6:303:1be::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.27; Mon, 18 Mar
 2024 16:17:24 +0000
Received: from SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f]) by SA1PR22MB5636.namprd22.prod.outlook.com
 ([fe80::e6c9:dbd4:f002:212f%7]) with mapi id 15.20.7386.025; Mon, 18 Mar 2024
 16:17:24 +0000
From: Nathan Morrisson <nmorrisson@phytec.com>
To: neil.armstrong@linaro.org,
	quic_jesszhan@quicinc.com,
	sam@ravnborg.org,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	daniel@ffwll.ch,
	robh@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	thierry.reding@gmail.com
Cc: w.egorov@phytec.de,
	dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	upstream@lists.phytec.de
Subject: [PATCH 1/2] dt-bindings: display: simple: Add POWERTIP PH128800T-006-ZHC01 panel
Date: Mon, 18 Mar 2024 09:17:07 -0700
Message-Id: <20240318161708.1415484-2-nmorrisson@phytec.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240318161708.1415484-1-nmorrisson@phytec.com>
References: <20240318161708.1415484-1-nmorrisson@phytec.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH0PR03CA0279.namprd03.prod.outlook.com
 (2603:10b6:610:e6::14) To SA1PR22MB5636.namprd22.prod.outlook.com
 (2603:10b6:806:3e2::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR22MB5636:EE_|MW4PR22MB3715:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ae7f441-b027-41cd-3c27-08dc4766e5c7
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	13xPiiaaTyyaDImy+RwSUYKzLSkGmY5aJIJalvn6n63zWN/atVYQF1z7bcrpCshhIyi33bV/On9tX2SZQGlWLg/OgBizLMCrGRBZw4BIFqoKGeSVT6MZWAzVh9UDPqFHB1/3v3imd7rHY7VOlz6Y7Qvep8LETDhxH0YErd6IxyjMQTg7jY41ao5uPVXPYD6ocImoKcaFyiMOET877YgyQ82YugJK3S4tDU7qcFFdL5rcsrM3WChLXIV0FNmz2UYmyBwNMB2pKGFRJI7XQMeHbZiFRIDZrLoITR38JHiNPNYg7RId5659VzlUNfqINiX8X1VuuKGIAzlsTCxjgRFBf5KA7ICMAdYH0q3y4FvQvObM/pDcF27f9xmoDcMEKC4B4njshXp2jEv3LKZLCTLo87zD2ybSqD5S2taLbD/L/MitvBGM3oeZNCdvq5YF9QzLYjRrIIp9ASo/9bdq0aKsB1epk1n+uqtOLUvhKLvKZn13ZhTQJpaIiG7yP9g6S0kUL5vRSb6FyAHHIj0dPOxGPMY1yqrhmmcgLryPNqrLfni+E8DtqCQkWqP//h5VCVY8Q4sAw9/x1H1WoK6Hp3sbt621pqgTjkxxQ43p6Wc1ySyq7L1R6GQZ+76aII5IQs4DWJjQgv68swid8LJKpcOcj14L8IGEQxVZYoZysB65UCghoMUywbW22r+sO4kuKCAm9IMRVw99yBJdrTlmZlSqItyT7zjBIl46YHayzNSKw94=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR22MB5636.namprd22.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(7416005)(52116005)(1800799015)(38350700005)(921011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?1x7JfZJRDbDlisFD6wvtHyP7pwZnO2hZqUMybhQNAA2pPfS0QGCBtmh/q3Ln?=
 =?us-ascii?Q?rxGR3hdTrA4kkODSSMVDB+iwlZoeWRRD0MDb1Yp9Ofwx+zox6REhezBBkSo6?=
 =?us-ascii?Q?64oW1KXmP+tSSXtwJbz2SVXwQqLHr8Cd5I9nvNAn3+JqA8bcfUMnSYIji6Aa?=
 =?us-ascii?Q?1tOqctocVmU5hBj4SDrUlpsvN3qdlIRtMcr/bQ4U+WtRearo/dN4P7fWL+UE?=
 =?us-ascii?Q?auaOgToPkPSCu+ZKqSot1Va66pdsqF5BDISspoyBUVQcutYwEWbGgWPCSV8L?=
 =?us-ascii?Q?J/G4AzPaawj3ESU7RPtq72XMqaSPEkksy0aPME08DuJYz1WLtPeY2Dn50NXf?=
 =?us-ascii?Q?KIxAJA5uFavBAV2m27DOwf1zpJif8TuY6uDVH/Zsd3hw/BuXCPSpKakvWkst?=
 =?us-ascii?Q?RAg2OziRq/tatC8m8kNBCu5Gy0EIqcjTk9VqltVc79YQ2/lT9iekIVaSU/gg?=
 =?us-ascii?Q?uyMhyw4KEMjLjkOFWzTljA/7MXM3ebo50aDlHeKmXkWMjbtLfCbxuxRNbnHI?=
 =?us-ascii?Q?EIy+Tb9oCBdIihBUjvXMfr4AsUW0laiczzw4T4g4mZ22i8kCStJQDC/BPs5u?=
 =?us-ascii?Q?k8zgAdJrFeAuV6fC0Vmmh+2badpQVp9cps0ioW+KImRZzacqs7ijTDgk++Ua?=
 =?us-ascii?Q?KAjK0VSBUK6ONFi0fKA0PgHHLWbP4J8beXAINRYW+yUq/dQGWPrmhQJ1OUiq?=
 =?us-ascii?Q?wDX0wwJpyifHudQe5SpkXgGQczbMXbnBhy7MfmKNq6aIl0x5hDSsPZKxGKUj?=
 =?us-ascii?Q?hx/iwHdQMONilwMsb2joJBqa9E7ZULCo+pV2Ci8N+MO0cw+fEd94MBP3bgRZ?=
 =?us-ascii?Q?K7EIEABCX1QUmvu7uvmwDfHvuCbhZ8X1QKSmA0akIelr1t6uulz8Bp4uA364?=
 =?us-ascii?Q?uSkVvqb+WDIDXQX5+j1tTfqSta4G6/FA7T8MWX3ddxjUZ0wDkMWJyD1EOdDQ?=
 =?us-ascii?Q?27y8QalQ8AmYB+hTaac/jgerpz4s0bt1iu552IHTY8E+lsZpm8Hbd+haBvU6?=
 =?us-ascii?Q?zH2SYPthQDJzlC3nCADSAozVushOYqb8mm+TSFldW9mnJKo9ojxB3aXRKAJh?=
 =?us-ascii?Q?1wZTQJoWAuym08da0+A+VaW9K2YY6AAoJNZs9EH6zjkLn8rGqIFdBH+lidBx?=
 =?us-ascii?Q?DvbK6/bVqxzX6BucF291L+/GFZ0T/cCHyL+VjJqsb/ydYLQJ6+v4e0yIZyZp?=
 =?us-ascii?Q?uwvzf0Ua0DgoNlCU5SoJW7QB1NYjt2D4cTYsmkmWmq3n0FyE7vEfiOJOX2KS?=
 =?us-ascii?Q?jSQNx1RAeoFlZW9LFhGQ1K00xjZhV+Wiwj5LU+78cnGeL7oI2XwIhdYLJfIZ?=
 =?us-ascii?Q?Vkgzd+zod2t1M/mLygHVZ8J2hM4crSu5lcaK1+NAnSbQ4KPoxkYeTu5qLRVn?=
 =?us-ascii?Q?wmL+gzYShtW8dpUD8jesjRin0cQv54rAkvvVuOmbtPwuBq9640yRcveeBOSj?=
 =?us-ascii?Q?rutE6A7LnrcZMpUWJXbH5cpc50BQv1E2EtZ+tum9vjKnJC8FWoveNtyaYpB/?=
 =?us-ascii?Q?jM5wPJ3r3ZxbNo/OvJMK0RN83YGgaViPZN7jP/FzLw1cAvfMmKZ2FsA92QGX?=
 =?us-ascii?Q?1YJkpZI7j4rAnVuHhtR/x0FJdbLDyWkGlxQtmBTf?=
X-OriginatorOrg: phytec.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ae7f441-b027-41cd-3c27-08dc4766e5c7
X-MS-Exchange-CrossTenant-AuthSource: SA1PR22MB5636.namprd22.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Mar 2024 16:17:24.8584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 67bcab1a-5db0-4ee8-86f4-1533d0b4b5c7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PDsfWkkFwy7xpIrtZatwtkAOhLuYZt9DwrkDHMXffTkkBps97WOvJ3oh6HO3jJ+9a79s/ECkSkyyP59CkLnbig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR22MB3715

Add POWERTIP PH128800T-006-ZHC01 10.1" LCD-TFT LVDS panel compatible
string.

Signed-off-by: Nathan Morrisson <nmorrisson@phytec.com>
---
 .../devicetree/bindings/display/panel/panel-simple.yaml         | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
index a95445f40870..312e760d7225 100644
--- a/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
+++ b/Documentation/devicetree/bindings/display/panel/panel-simple.yaml
@@ -272,6 +272,8 @@ properties:
       - osddisplays,osd070t1718-19ts
         # One Stop Displays OSD101T2045-53TS 10.1" 1920x1200 panel
       - osddisplays,osd101t2045-53ts
+        # POWERTIP PH128800T006-ZHC01 10.1" WXGA TFT LCD panel
+      - powertip,ph128800t006-zhc01
         # POWERTIP PH800480T013-IDF2 7.0" WVGA TFT LCD panel
       - powertip,ph800480t013-idf02
         # QiaoDian XianShi Corporation 4"3 TFT LCD panel
-- 
2.25.1


