Return-Path: <linux-kernel+bounces-45784-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92463843639
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 06:52:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A37928AE3B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 05:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25033DBA1;
	Wed, 31 Jan 2024 05:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="QpB6I2oy"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2063.outbound.protection.outlook.com [40.107.20.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDBD23D992;
	Wed, 31 Jan 2024 05:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.63
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706680310; cv=fail; b=dz6bX5745dGWCyv1XWR++Kma9w5oBZ0oegct7x1lYpJf/DdJAuPbJa8d6yA7kNTXTDfEXjsuODwHIzW2v/oOxkuZzzyz+Ofd82WcoS+HquEqIxhQCy23Oi2YBHhvUX6p3P/z+Ua16cTJxJfSfl+AYDeNtF4mhbx9O3jULTAlK5c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706680310; c=relaxed/simple;
	bh=cVde6WZZ8HsLk4X6eY3reZNfLaR+niSzWXpEPHurGp8=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=rsp8eDwGAHcLsK8bYL4KjaT+MSTNWg/P1sJrfbizd6U3NGjbve5jOUVCeWLR5/ZoTsOUr9wZchVQf4IqTobE+80EoHZxtAPHJ9w9hfxc8zRufD5PztRlgG3Rf/WGBa5KGLOag/r4AzwxpXP8cgPbpSuT6NZtAAwCZDqCIQsuMbk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=QpB6I2oy; arc=fail smtp.client-ip=40.107.20.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MasTtyNuOeKw+W+iLydfrl2yy+eiMTVqhtkdhWHpS0bIVgmL3xP1i/+Fki9LnRth6gFYvxpEjO51506fCB4wrOqZJE+T/hCT1rPLbSAJP+YIL6pTZdHUcuOtlwfebHwbcfHoZ+dJeKrr6mwN+TJNwENqSxLmsp9FLTOiDSAgVO6Vqcb4Gj8W0OBWA0hFA0JwG162go++fCnBFCjd+R2ji/iA5XeSLQ/plHWjFVVO8fIKLLH8O3c3uT6nbEeZ/T9faXiUDB1xoRcOwX67PTnSAjUabSjfnBIjFD8UnRG3xDY2uqRFrxDEWlQwdtPeB24UfouCXlk9bBrHl72uzN6Rug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6MQpKWNCIPIQeFKh55xXavHzqCezMgCyVlcBJTQ6oqs=;
 b=oP3I/b+CKR6+9kfrR7Gaua/va4sUeTfGV+avHiApSZQwdx4zOVU80QPraATdRC6+H2vkDSVrNtYXhnHS1UxuKCvYTV8V9VDl9BEF5QyiFUt4YdAxi0F5auCSVWI2gbML4cbQlTBRqTRVxrXHw0z1Pqs0AT/BR7U1Bt/z7N3NP+wy5EFiAejE6DxOi6rvEbtIQ4F3i4ZHRqCRpQPx+1c4YfXDD/rQ39vM6w3A0oc/DwzHWcqQRMNLqMLAqFr7Rmhw8WnBGwjg0bN5p4irDSA2Zg+ilFadhyWxWqvGHAyR+YWOsElfGO9/iSG1ZypCDhqpOc4hrI0j9OHJNJik2+KYPg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6MQpKWNCIPIQeFKh55xXavHzqCezMgCyVlcBJTQ6oqs=;
 b=QpB6I2oyVK2Qi/U2iDBnS26Szzj4eUJNmbN+ge3AFtdi3I6kXCDwC/Q6gPorDcWH8nh2rAQU2EE4bZNIOpdnEdEZcCqiNxeBBlMFRQGtJxxhj8P0szIUuKHHBssQmbevhokXRFZC10IhV5jzXvgVjP6TjRsQ/zF7lxGPzxSIyYE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by DU2PR04MB8917.eurprd04.prod.outlook.com (2603:10a6:10:2e0::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.24; Wed, 31 Jan
 2024 05:51:44 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7228.029; Wed, 31 Jan 2024
 05:51:44 +0000
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
Cc: linux-imx@nxp.com,
	mike.leach@linaro.org,
	leo.yan@linaro.org,
	peterz@infradead.org,
	mingo@redhat.com,
	acme@kernel.org,
	alexander.shishkin@linux.intel.com,
	adrian.hunter@intel.com,
	xu.yang_2@nxp.com,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	imx@lists.linux.dev
Subject: [PATCH v4 1/6] dt-bindings: perf: fsl-imx-ddr: Add i.MX95 compatible
Date: Wed, 31 Jan 2024 13:58:06 +0800
Message-Id: <20240131055811.3035741-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR02CA0041.apcprd02.prod.outlook.com
 (2603:1096:4:196::20) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|DU2PR04MB8917:EE_
X-MS-Office365-Filtering-Correlation-Id: 5660fbae-b455-46f8-8f8a-08dc2220b455
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	AP2FutxDVWCvW5zf9KoRUYeEb41kOdeXJsS8Jji4e8f5hTuKfcYFwDtgzoG/fO/RwEPiDVdO1CVjX6qxRRK3e7hyAnmQ+kQj4jRoJ5YJoHQNRTqJaThVGwxom3pdyk4S7ADxr6FTqneAbf7e0+1+bVI/oOXklR6OS/IZ4hxYp7bXGXhnl+OWcFu07+XL2B3I5JasGG3a/1SmuOvltnOoyS8gu5UvkZ5ZklT9h1XjGmH4Je3BumckOt3AwU7RPshOM17M/fW0xHvsaAkSKytWN4WF3GqEnB1BxUqRDhGpJFQohN5+9JQ7C3/DgbW36QcUg2HhamQSuGCYZ4Na/2V9z9P9PALujA47aXfnEAj+u4LyxyGiRBREBlL6MadoPTxlu1j89yJKM0k3pE4jXqXrIRjcq68e8tIoNJiMlVIiwh5yVkEOfd+4ozhbWQc7iTIj0XcXl0UId6aCsrWzXS76Fpl/fEXKRa8HsEUViIthdgI0MVOVz5pY+gytUCkVOsG4uJeM77vtZpmgmpno0kIQwHlF7e7dVtnqSUpkmifpjwiEuyUg01VsjLRfPOs9w71ZNa3n2EbGwaxL4gwcESuLGI8qA5gWaJZk3OtZrpYNLGN1Erwh/HV8MhskUOVvX0cXjQdsFVKrruO6kVOcMrWqqQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(376002)(396003)(366004)(346002)(230922051799003)(64100799003)(186009)(451199024)(1800799012)(38350700005)(4744005)(2906002)(36756003)(41300700001)(921011)(66946007)(66556008)(66476007)(316002)(86362001)(6666004)(2616005)(1076003)(6512007)(52116002)(6506007)(26005)(478600001)(6486002)(5660300002)(38100700002)(8936002)(8676002)(7416002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jE0yb2WGKtQYB+7gvOKfWe0WEb1f2YvtcbBOelACBvWbfjrYrbqHl3Wszln8?=
 =?us-ascii?Q?D/M19Upqi0tESLbkgIIl7fr3UpdwiSaujsrCcl+Q/fuMJsdoli0Y9b+XwhOB?=
 =?us-ascii?Q?7gBq+LyvLVDVYrN3Yx//FiUj/PdV+NdTynPHrEJSUv9rYQN7TxhDPfVvMLSi?=
 =?us-ascii?Q?hry9VEs23qL2BA1A0sIe47bmIshfmpEBjjP14LHy+mvbklR+uU9xBUPisan+?=
 =?us-ascii?Q?OvQ444sS3G/UjC7h5V3dBOi2HO8U8XRsKlt3NLE+aVL6rNb/kWjxANuiirIw?=
 =?us-ascii?Q?3WlOtVafO98cHFhC/5vLmyv6tdN2AGBtU+Zy/dWbRxfce2RANWVvE3N+nTYr?=
 =?us-ascii?Q?QPIgfQp4OEqLiFdsxIFiDTwOxFHNzQnlE+OdlhNmR8CMBYqMlScYurC/lqVP?=
 =?us-ascii?Q?GP+mDjIn51pAp/tAXGMEPBUwrB9CYHVD/pLIkBLZlqchar3feKx7jECoBcyq?=
 =?us-ascii?Q?bV2syg+KDwjwHJWb49loLfCNH/O+ycVRFAWWOeLlOun0hhktyTVVoQNXNX/u?=
 =?us-ascii?Q?McQ386f1YAv6N2tPaUYdKeHFezfInSwhRj5ePWGg6tZNOFQkLTT7kniwB97k?=
 =?us-ascii?Q?3Asv+08vuJEgDvvKXx6owd1qXQN3XO/j6XzbupNeJ28bZnTgQZ86XDgWrI83?=
 =?us-ascii?Q?JaAyPZUNYfWXRZnRnqfW8DD8v0RTc9Vuv+K8YC6m1KJ9WvI80H3Spikwbp7E?=
 =?us-ascii?Q?/soOWgA8YgRGa28TTzKAUY0ERHLMOr2QWbaaSUc+7E2RZWc0Ri3f8z9kY8Mi?=
 =?us-ascii?Q?b7KdVh83nnYOuFOYF2wCD7jaPW6F281lvL8zzFyFPHreWCoAgstICdMDV2DA?=
 =?us-ascii?Q?2WmZxjLMfRK6gPnD/A/eF9y6pFDlFHnGFXFeJVX5jhkP0J8zniKYYGBPOCfG?=
 =?us-ascii?Q?lyiE1x4qya4n6BeikboMK8qFPo0HjvDZ3RdTZHQuXP/37X34z/+YPq0XWYns?=
 =?us-ascii?Q?KibtrqoC/e++v1EXuy8FEzYIWBRqPIPZMtkObq8MxKYjo/Ucq3jKFVQZg3Z7?=
 =?us-ascii?Q?MpWUoNOk5vqXDjcNIorP5q/hqKSDxoeirmthDMywNP+QboXdv6nCbSctSP/F?=
 =?us-ascii?Q?T2ooZsvPwWR/+mhr6HcmXfjp/8LiAHJULnYU/vmEZqExS1gclKEpidjQN05j?=
 =?us-ascii?Q?IfK84/1ZcFvcaS5rq/Pn07ZIL+kZrMv7sYWhMgpjET2vQuR14x1suKv6MXkR?=
 =?us-ascii?Q?PVFcKjTz8LgYHrSr73N/TMVInE2cOiqRCgaJrfviPsVmZ9Or3UcSiWwMikqB?=
 =?us-ascii?Q?LVWmLYsZx6PcvcDfdWuCT7D1mLPVj3C2YQVUdxgm62as/vkDziwitaD95dLA?=
 =?us-ascii?Q?m393XCpKAAj+ia+D/rewyPS+20g8DE2jjdHhhz9OE9oGyBkYzHuv4RzTF33M?=
 =?us-ascii?Q?1dc9phggMvgYByEFTHmcGiplKhYsdCluTrjQE1EfjCyNT9i39wHpkw86QJaX?=
 =?us-ascii?Q?HziBnlWoHXv95ImV593U+hjfzAH6KSuq/B2jSwsh+uZ+SuDUdg4oRkfrPSaW?=
 =?us-ascii?Q?INFvWp99+89h9gmNUWW9vsQOFKMba/dSJbpGjsRzk2MA7wbcytrA0rGNEovz?=
 =?us-ascii?Q?kseGj/48K4Fo43xcgMIjU5OEnYWfuyEk7TuW3Wd+?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5660fbae-b455-46f8-8f8a-08dc2220b455
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 05:51:44.3016
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /8Mt7/Q0rNPdy1oPbiNLy7RoeP+/aqHP66WaiezrkREs/F3mMQI1s0kr3a27neRL1puOYbrEEw9rOzfJmdVZ+g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8917

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


