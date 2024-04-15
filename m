Return-Path: <linux-kernel+bounces-144566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F31F58A47D4
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3DC9FB214B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:12:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 007E1E541;
	Mon, 15 Apr 2024 06:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Pogd6jBD"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2047.outbound.protection.outlook.com [40.107.15.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F64DD2FA;
	Mon, 15 Apr 2024 06:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161570; cv=fail; b=YYQQccq0N2VC2+Xl65DSEq5sOYUlfQV7gQFimi8j56uQFy21BnTrhLg/+rz0gO2/GbrB5SsGcIUIoOkKVLJw2bLwZOPdxAUOijT+0txF332IO2r2IbBgmaLmTAlkSZypUBc8lerhGF2X/ypTDsjuCGq01iyDJ+txQQuq74eZDR4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161570; c=relaxed/simple;
	bh=FjDHMwAEwMqytUk4+7m93rMUHIEnC4B+M1oNf/r6cTI=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=URdL3wwHzYX3nBWFhkewvFAnnQTRmxMEy/u9TsDX4ktYVVwHlhBpJ418MeVQxpRZkPkZ46mHd+EMd8qUjPHQ21y4AJWGPGeRA5WTkAK34gF7YWimZ7ZNYcWvzq8bHSxXdA12EjkWhcjzCqI/6r/iU9QmMyKOFy5CdPrZ7lulHlU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Pogd6jBD; arc=fail smtp.client-ip=40.107.15.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IKhWsFZse1Nw7Q0rZrOJz1loTd0VubuIAYgRLtdQmIOq+4D9ybyTYUgVqZtXLga5Nn6w2sc38a2EMfMevn0umnySorwlErh/lordlxGp+cOyWd5POYCVPKylPYAozEaEEYBm+sQOPhkD9uIOu3+zehCwbbpWYpFqCqyyBp9DVbShV8FY0c4Hq77LKsjWe6rrEKKuwvb1upmrd0cv+iCHme2cjbqIIXw4FQjUs76uRl54I/pKA2aYOyKAYRef1lS7g+v0zX7dqfs8k4bp0gXU2mtGDcplzbf7vshEYUr3ngL7F9bjat9+0Z5ZIhfbGBfr2BZdn4IOEweQfkAUq13xcA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=U4zqsUVbNUyuD1Uu/jGRWGhWbFLjo/W3QFC3VUWV5AQ=;
 b=D8po42r5QqKcI80StuQjaNGTEDuFmnFUfBZ19xoY1k6+RLtWraznjTfJ4kKIsCn4ZlrpLuB4Y3Cw3A7q0rvqeEFfO2hhMYoBVMoGbY7NDrU99c/PpmNafTksMsnN6Cib2FZ1Vsha3AV/mksLG6+KecrXHHH7VeiJrLcgzkeLCIVWku6aPDUbztS2VdhwNli+MLaQ1LrP8qP2pIFlHIuuyt8GZmRkj6L3J0n7OhFAqluTmyfKFu8DgbvrtwGzVVgZ+k+HFcFxz7LfI93LkDSOBYtpNfLA2c8r2jfGcYwXkc/9d7jIkk1Fzwh25BLDQezbuj5RNww0lgn0OqxePOL6wg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=U4zqsUVbNUyuD1Uu/jGRWGhWbFLjo/W3QFC3VUWV5AQ=;
 b=Pogd6jBDsqcV5F7a6kSdbPcznORyz1EDAsMHZ1RWMv9eXnI3PvQQE3OtC/IlLtUiiZ94muv+XTvDHWIQyo34iLobs52Xj3gbteC66GiZZd7ChHd97OJIG1F//T5QvxPLYfG8HiITWI20REur8pJ8BrO6uZ20Y/HfT8nZbd55VTE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 06:12:45 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 06:12:45 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: frank.li@nxp.com,
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
Subject: [PATCH v10 1/8] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Mon, 15 Apr 2024 14:13:13 +0800
Message-Id: <20240415061320.3948707-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0034.apcprd02.prod.outlook.com
 (2603:1096:3:18::22) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|PA1PR04MB10117:EE_
X-MS-Office365-Filtering-Correlation-Id: 37fdaf6f-0206-466f-bc66-08dc5d1310ce
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	X1jTtVPTIm+Tk3izL1Rh9samVxstjC5x8BTIr0XQSeLd2m3zH0jvFZc7raMcOX52TVs3G03+jI2vDfpQqFUtEs/M6EYEgqGOAz+3PlXF9kfn6Hdu7tWJZ+FRnWHRSeUXoY7fomKPTVCPtMF08xuVCxt0J2RerrykViIMMY+0bnRPHwym3kyw5/JIZoT1HcMOpo/LeTUA+ywRzW8G1nlmvDZVpF4aRjDszZGn2gasUwdFM70whUKqhEs46mHe4abeRUDlLW+jK1tg+t+AsCzqwS30/KGhbN8ybHH9Mn/WbGxA0mLMMyXNFcoqO5Z9dZyYZ71ALYa11d3BYWASVuwvyoJ32ORKD0mli7tgNaab2MYVWgxXTsLis0yFbVQxYuqinYQzndp+hPuThw0g2HoG8d45BNg6hgk6DyyGCNkBiBFRpbudVyMKbVVlrU/6lrPBkEGTsny73He9Rr1e3bcwxvfHvwOpnwWLGLPCsYFZn7V4aIs4R2Km5llswFOxY/c2Lq7uV5fRzc8T50siL6THKgCVRX1xUMqjSKOegIPeUqwMP3kubhgT0HWYGXGHN/KnkePnFmZu/MbUJqnpeC6dkbRd6Z5lAF2HBFQPcU/FM2ubzWcs04kwrzQfDwwa5aW7I8KcsLsMrPbskU5QUYeXyxYPBW/+kqW0DTnNZcEgrOAXg6TehjGYOh9XrQmNPw155C5MrYoqubTF3wWIT44lZnJZnXJFrSO+lnlvg7D37kE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?A8UElxr1RznmLE2IyqqdOHv91P2kKFlUqVmV1RL6VfJEeVxgHas7CV39fCCS?=
 =?us-ascii?Q?iqmBBCdS72Yr1uM/nhAFA0ItgO36ItzBda6tFp7vPhTavlsEFnai8xfxx8Kk?=
 =?us-ascii?Q?9Ygy8aN3CprrSMwGALVc8qHFVhyIUet0HqZkkJ+0ygkQtA7JyDHR3nkJntjN?=
 =?us-ascii?Q?DO3nHnIKJoLKWiKgLXZ3dQUCqYd8A2VrpASh/T0HYevGdwuGDotzjOIDX3e9?=
 =?us-ascii?Q?YGscjhNmh/6J6IyhsPQ8S4HVp+ccF5oTWax3PXfOYVYCj8EjFgdPaKMlJr4T?=
 =?us-ascii?Q?iPpzsxxSoNGaUWYVsat8IaPpwhIplUagpDQKgfnfNvpt18ZyMIh7M/Lf8WO/?=
 =?us-ascii?Q?RHN6Ushai9vHDAEOYey/HJh8sj4hr3zzttV/LyLyKWBAhZaTiRZb4Wafh5qB?=
 =?us-ascii?Q?LMqkDLUvwW6lOVUZLXThnCH641RAQiiaNUA5cRWnr2IVOS9RS1RRw9/CG6vO?=
 =?us-ascii?Q?KEJwMCabQV8w0PE3aA+pJ2mUAw4Nj5k/dZSlcHzAfphmVAYHjhpa8UYXus7M?=
 =?us-ascii?Q?tdCqnzU+dQVgslb0qarX0DFT4yLNZWbmDwTBJP1D0creJmaWPAv8jEPEycQL?=
 =?us-ascii?Q?yPkn1XLSaeEOLQpKqx9Qoj3+TBhhIPPcAhUWVfwyrJYsAE/Zc3OIzVECKRyf?=
 =?us-ascii?Q?R0TN+ZAtQCnECtBA4TLzRjxF4TJmmD3mkJ2CnGeaVqYUf8l/pnFyJpwD45c8?=
 =?us-ascii?Q?9zKdApu7Mrx1JR8BMd0rbiL3gk8GrzC7iiTpImYdw4AIRciKvw1/1UKOeBdq?=
 =?us-ascii?Q?7CxYMJYBNEe3e/+mh4smWAq9YgVVRJ8BP8Egf9s613FP6XDprzw6MFVJtXYC?=
 =?us-ascii?Q?WRmS78VRuEy4ddhih5NN6JWFh2i9cRVylGbK/YgexLL47gcgoPxgrnuB28Ny?=
 =?us-ascii?Q?DR4E3oDpshkWm/qJ5pep9HesMmroRjM8GxjQFcCGa5VpU6Wzt3EdoUMhUjwG?=
 =?us-ascii?Q?vMEMpm/eWW5Su428k0OtUI+MuPNKoSa/dwvU7c/+jMpPiiPPbfyt8AEhs6UX?=
 =?us-ascii?Q?cqB8lvgrFN7TN1KVnQnaqMipZEvIbYgi6/x2RUENtwhDpj7ltk0sY1Xcge8S?=
 =?us-ascii?Q?hKv5uKJMXCKKT/eI20p0oP6Dw+8hDKydPO6BhJISRsvbX2JT99AxE0F5a358?=
 =?us-ascii?Q?ZAUdUKZXTiMJ+raJ1Nb/gXEzKEv8cUwI5MX41Z9/WmfSGjLPqU7hTZ18whmv?=
 =?us-ascii?Q?MXpLCaccVl8TnGHgUZ82eBy5q8b4iZ7iC4zZM4oF2yDcbqY/UEYrCd+w9DLW?=
 =?us-ascii?Q?ibMX1hnuZZLe2Hx1y4vDCb8D/ubA+EqJlILE64pLQnN3q9u3S7nlNhY1irDj?=
 =?us-ascii?Q?KdvZ+G5dsKiyPy7nS+mGVZ49XvYCO4A1kyyME8nFpm6xYPd+jI/+kK68dJ7u?=
 =?us-ascii?Q?hB+V830HUgfFig5pv0Wwoqp6nRPTfVyTY+Xy5NuZ4cW196+Q8WdjL1TG1Jw0?=
 =?us-ascii?Q?+B8D6oNc1nQL4Jm9FHqa3Egys8kfnu0Ez/X492nHlhKUqyEBE9czLR/X/VK9?=
 =?us-ascii?Q?JnOQLIJ4afeoKrsZRrdBRUyUxlYYgZ1d4XwMPs6JYfYEk3IBdlRE+RwtmeHZ?=
 =?us-ascii?Q?SstG+Yv0ldCCDrnXmX0u77gcKYV0nOfETJUjqssu?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 37fdaf6f-0206-466f-bc66-08dc5d1310ce
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:12:45.1026
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 25s+uzwmkENGdoIidTtkHK6I4kEz2OQZQThg+X292z9qHFyxU/WPPDgTU+emVnMuEQmiSVPAl+wQ8Z4TJyehEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117

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
Changes in v7:
 - no changes
Changes in v8:
 - no changes
Changes in v9:
 - no changes
Changes in v10:
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


