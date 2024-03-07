Return-Path: <linux-kernel+bounces-95279-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D1C874BAB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 11:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6DA721C21C8F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 10:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2E221292DC;
	Thu,  7 Mar 2024 09:57:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UYI5qVUB"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2077.outbound.protection.outlook.com [40.107.6.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10AC384FD3;
	Thu,  7 Mar 2024 09:57:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709805448; cv=fail; b=Mym6BHCiYKakB6osKEJrBL/MwhyCRZ3rSpEEisTbPIsei+GoYiUutRZVxaMdgZGSHmJQDFmdJ1A/P35jlQg5KKtG5XITn1NOhJRIFgGqRiuEqpOYEadk6+iH/31TM4OUGtxx58kT4CpDxdHeiuuhqjgEVf/37ZUy53tWu+XZwy4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709805448; c=relaxed/simple;
	bh=/W87hgfBmepeJpvzH4bTILFbDkTTMJF8sCBd2yJ4bgQ=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=S5IpJDfVoBPOcuirKG8DJWMcU51+k2h++9xBPighK13PwciviVNcT2xGXtKwZAEEVk5kydBinLdqbxPT5DKXNg1G9NacGkE6/yvgZSBY9bBC7QSODG/ynL8ByDnij2hjb13JHwm5WT71B9EePFdK+cma4jXnk3tcnFA3qK4AcXE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UYI5qVUB; arc=fail smtp.client-ip=40.107.6.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lozqq6Saz/gxnEWwIIO2f0T+IGbXjj6gNcoFHTb9m3TsTfFoeUjcXDssJXf1UPfaXU0c1wmjJ3Tqqc4Wr6+BF0uTrmljJFbyoshd6R2oSsfXpqns1Y3RGLaxRdfcVIBzJvfWUYDJUZMuHAMXRBdgIP8Y3P7rJKkjyhbUz/EecotI2EpAtgdmpWmA2DumsnD5he8JflxEgslNr2v3vVVRMryfAdqpMV2KXVpsuKAiDngQQdyAA+ApX1gGaHc5wJWBAk83MiVhHmvGwEx49I8odaGu4//zmS9VO2PAHNKa0rMGPkueauvmbkknQmm48WngK+ZWwBt9BNWE537INj4NDw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mkHod9uTc567uZyWPz64+1YFQBNwCsdTDer53U35t/I=;
 b=d8RsIBu5cbB408+hVHHVy01BUi1zRYF8M67dU339LGiWZI8AcOmiPHBYdUJSC1Lk5qZNbQBqjDWMb5NeVODABuc1LFsKHRw4BvLhOkvYUKBzrQxmliZ/6lBUEly3KtBElzOkjYVSWcBxY+7DX3v8doWU7lu3jVMNc3RKk0isako5dg7i/En7GPR/txuh74TtMnN+F5GorgQfMAPPJS8s0mdG1kgauSa1k56QyAk4oOcXb0MtYnRAK3pgyvY457iMhTZBswGjW0NupU8KgbHh0vVcE0q3QPIP81suNiMQhCCBLAPlVEeXd3FHlYflIHpvqCsZ0anWMUPA4O+ovdolXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mkHod9uTc567uZyWPz64+1YFQBNwCsdTDer53U35t/I=;
 b=UYI5qVUBZgdHvezYCEgCU7RCO+dBb1yNhBaSUIoH3u3wDUxD/spdH8fCenlwJq5wbrZ+A3ZyY+aD1H0ixGSYbFJ+LFnl7gT5ztn9jFwuzmdTEhOe8UpX7SFJAqtesZqI64sDWefemYVSduxnVsh2laN+RJBatCJb1DzvN0QssX8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8504.eurprd04.prod.outlook.com (2603:10a6:10:2d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7339.38; Thu, 7 Mar
 2024 09:57:24 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7339.035; Thu, 7 Mar 2024
 09:57:24 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: Frank.li@nxp.com,
	will@kernel.org,
	mark.rutland@arm.com,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org,
	shawnguo@kernel.org,
	s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	john.g.garry@oracle.com,
	jolsa@kernel.org,
	namhyung@kernel.org,
	irogers@google.com
Cc: mike.leach@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v6 1/7] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Thu,  7 Mar 2024 17:57:24 +0800
Message-Id: <20240307095730.3792680-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0212.apcprd06.prod.outlook.com
 (2603:1096:4:68::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8504:EE_
X-MS-Office365-Filtering-Correlation-Id: be32b33e-affb-4ede-8de9-08dc3e8cfcec
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	IexKGYrthrQGO45E+VAqxnxzQfaPxb2BOVSAMrTR7st0vUeaTcCFnEVbzJ1nDczVfzu2BudOVniMss9l38JmsBSUsqlr4GmC+03lrAjDsJHkKTyaOizLli0KnIG8wNKke8X8iidizfJI+vVoWs+RYI2BPA+QCGKExV2jAfZk2JyoWMU7nogQtkGQigUlAjWiArzaiBBmcxLc5TyyZWQl4oDL1AQh3p7hG4rjKxQiOXdgOGN4AKoZGW/emW/1vjtMdpf85VhBpfyReHlfMim1XUMYxdn8syBjK55fRWW6VLymTkPv/E2sF4ogIi7p+FsKoDJ1rfXGWoLRqgMhE1yUlY61ujsm2x56BmjmiqA5hC/BQ6Ot8k+tVRSjWxR5WdKYTAjg9aSVTAKzlK3PYLt1iRBl+rcN3gUx7E9ZAj7YjE4rQ62zOThpgBIpicGJ53QoAe23beMY0Cdg02Jw08kK3gTclFODtOMvkDDfaNdTwjVzqTM7+EB+TL3ypRBZqvzb8BDSogSKiAX1H6h47Ys7mIs2URKhY3HHDXew4Ng9W0AGdSNbWZddj5vQN+mJNTz5aU15LNbe1f3uXXudkno76qtryNC+wnlvVsxiZzf7kC6byCCqA3AZeDwjMgBQKrFXT2+WvR/vNxvq1LmPnlfjVxOKRJdlgw830UHBCYTHmrlwA5+sBspHY8N+NRMAAFFDBqbDTnPs9GAkvAEdyZFFYHRdHP27pQ8e11WdQlLcujQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AKGEAW8QBKaJxId81ELJbeWPZZQU58oPOyThcNFvQKouNIzVJbREGhHf7VTs?=
 =?us-ascii?Q?EYd51ZCdvf4bHY3BHUVAlSCT3tQ4ccEQjSjUS18wFwFiVBD/urUms6Kf1UZn?=
 =?us-ascii?Q?TLFi92E1ZUlJhKTBPB27n7nlQo9FbDxRuD2SpyfO0zKeplA+ss28OoUr9unf?=
 =?us-ascii?Q?KkUH97FFedMLSz7XaRtqJ+p7gT5GzMGaMpxJ0PlkF68TQeD7cwiw5PNu/WGZ?=
 =?us-ascii?Q?40Wm+7Wk3esKhDGflV0/bzTZB+jE0OX/2BsdeyPiP0EDBbhRA3xV1xh6vXT5?=
 =?us-ascii?Q?IvPd6r3+50I/CvJ/NFLtb/NDhTayWfsq4nqGEM1sGYiaUrUDYKPU4bq00YMb?=
 =?us-ascii?Q?k6pkf5sea00JosNrc7ydhn8EK0i6JP05YX0mBSkC7CAxhYObSCuZ2WPLnJ02?=
 =?us-ascii?Q?JZ3ewIpGyhzhkVgClK45k1cWWwL32eRI0e/OzOBcyR6G9g1gENT+olzd89LZ?=
 =?us-ascii?Q?tDOVMbeRtviWCwoQe6fIfqniKKrTsG+G4qGKXcFQ11z0sSH1336wvHSsowrK?=
 =?us-ascii?Q?aNTrb8SV6ukqIItuJrG2mJnYSA3ehiDyiipMfirq3HQEZ/w0HITpcYDxJuAn?=
 =?us-ascii?Q?i0k6y3NrzkhIbc8MS6xovUabp+Cx6Jzl964QkTrexV/ElOK9nG2B2+Y44Cb9?=
 =?us-ascii?Q?tUaB9C6l78mP96J+lyFlpgxsQsL+oWrJkNQY894GBrBc0EXLV0XU9+nTdqrX?=
 =?us-ascii?Q?oad5enzaEWJZtmsHjQaWxqyEwlD8g4OG2xVw3CD2hvXQp3Gxg1UdXGlULzHr?=
 =?us-ascii?Q?ISQFugayU0HjAGN+w6ziHDkkANpUFfQ/z+BdXl5Y5Poo/H1yQZFgAn9sI/cx?=
 =?us-ascii?Q?3HxIHpNuecbY2a3zCVsUsgJq6ld31e1d1lVFRiT6Cup2OMcK8NaVwl7BJwRA?=
 =?us-ascii?Q?DP9OorbuB6G3JlN5434GFDTAGtLDUVyhvekhPfJfy8T5b0qCtWIH2zhnWAyK?=
 =?us-ascii?Q?wzJ8dA6O1p2Ok3GeWm/M8V38g6G1v+28QTDK+N/KKWAP8nQQgzfXH22zGZbT?=
 =?us-ascii?Q?9RpVe1zhuazPBWEZm2Dp3UO+VsBwvEjsw7gOG1G6A01yFrtogXJlPEGD8Jaf?=
 =?us-ascii?Q?eGZXSCR/vXuCyPV5kSOleL0IA/Bzk3ZPqo2e28qgEP/zcV3/h1YIo+ulZ0Py?=
 =?us-ascii?Q?ZWRN5QGsqxv038Vyqq9wGr94wgDhOBEaDQhS6a/UIr3jRcN8u5e3yZ5RD7Jo?=
 =?us-ascii?Q?Rw5MW2BlCMCJ0uSRnd7FCFSCzV7Jp20R9Hky3Uo93IN8NDC54RFrvOqERPRO?=
 =?us-ascii?Q?j2xhAXVFp+7TOTwlCl40yVGJslYUC7/IuECxoYiajHTNh1TczluiSujwPmH/?=
 =?us-ascii?Q?fsYupYkBFymtSr4Qo6xHC5t7zMJMDuBxpIDX1L5NDZgbeHdFbu5FkYgvESQ9?=
 =?us-ascii?Q?EmFVau8cYd16/alEN+1jvjpbTzr6yh9cWBWPdBrmtTvSWW3NH17RJ9d1F+eB?=
 =?us-ascii?Q?5nV5ekc/1Nqa+el1r3V1JOc2OdOvzN0SLx8bZ5vRi9inBnSW2iZ9fLfjtpzG?=
 =?us-ascii?Q?ydX3ar7n4TfWesvCP+nwcASGvvtX4ijkww7j67EmOZPth5Wf+/fMXO7LUTQ9?=
 =?us-ascii?Q?i1Lm6+sgpUwRZZmGY8BavKlAByoW8FQm1og5JgP2?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be32b33e-affb-4ede-8de9-08dc3e8cfcec
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Mar 2024 09:57:24.2788
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GS52US/D9emZu6ZjpmAuLRQYKQKs55u+an4ehDkoLLwcEKxTDbwPlJ7IHYrDVW7Vqh7l7OdDEfc7kjwRN8Z7GQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8504

i.MX95 has a DDR pmu. This will add a compatible for it.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v2:
 - no changes
Changes in v3:
 - let imx95 compatilbe with imx93
Changes in v4:
 - add Acked-by tag
Changes in v5:
 - no changes
Changes in v6:
 - no changes
---
 Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
index 6c96a4204e5d..37e8b98f2cdc 100644
--- a/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
+++ b/Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
@@ -30,6 +30,9 @@ properties:
       - items:
           - const: fsl,imx8dxl-ddr-pmu
           - const: fsl,imx8-ddr-pmu
+      - items:
+          - const: fsl,imx95-ddr-pmu
+          - const: fsl,imx93-ddr-pmu
 
   reg:
     maxItems: 1
-- 
2.34.1


