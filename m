Return-Path: <linux-kernel+bounces-43133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E7EC1840BF2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:43:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59E101F245A1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DFF0156980;
	Mon, 29 Jan 2024 16:43:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="MloSh6nH"
Received: from EUR02-AM0-obe.outbound.protection.outlook.com (mail-am0eur02on2040.outbound.protection.outlook.com [40.107.247.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A837715696E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.247.40
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706546600; cv=fail; b=Z7AK7IvSRgrlNOD+K9AbUJIh3tstE5l6M2DKu11tKVGkkvS9OF9Cqo4HhYnlEX+hUvA5jUPKTvYk/xpnhWpl+EaGQc2cgCwib1r9G4hcmcuC/dIzdrzipXrbpHGCwiwxtiJYwdkUO0CIoAnRKV07Y2EDupWk5Wr+8eyNjQuZPDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706546600; c=relaxed/simple;
	bh=dfO9x7HjRcoCexUmQTo6QfAHq3TbYjd4vEZp3I8mlLA=;
	h=From:To:Subject:Date:Message-Id:Content-Type:MIME-Version; b=WaXq1lTFmXfab8PoEUqDH8rxZ42/Uf5GqHRaqsLj22LdYoO2H4AjRsuMTpGO4m7Js84P6OVXmM7qRtaU92TjpXrvoFw85h+I9fdovvZozFcLMkAMXM3EIcaR/vrDHYG7vo2sP8G9UHwbdTQgxD0Apl5Pzi+zdhU03tNmyjMP19M=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=MloSh6nH; arc=fail smtp.client-ip=40.107.247.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XcsvDCwKJyrAwBgSXYqGKnt+1yI+MwLUy34dh7UlgAg0GjuaOk4O7DGFdTNYlQ3zJv+hXXhKaM8p2Gvn7Vu4syvgfNv1GOTwg3owI8eyysU08isWDddstq39Wl0o5B4fqNhRzNQupW3ENCWe+QoHyC3YkMWI9BLcPAILbEUEn1Lbt63YQRqDcKsMNHLA3s6Ph+mEtWlJpTZIU2rR5sQi6h7UBk3+mdHvxtIaQ6B56AAYCkvTimvDSjDY1Vkb4oSFVmzhaCZbckMCGbV5TzdJlkujIaCY//1y2TnWZytyqYyx+vMZ+qh2eops4lqaLNwjeIMUFIF/YTnVFrddtyoQJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=l8Pmnh6ljAenpNpQJUacdgaNEBqTpmwj9v1N0Y5NdcA=;
 b=NuRG/4ommA9hEvAtijF0K3QfGvYlb7HAwNa4ToO4ILNg2NbidfE1UuYe0Ox9p1e5a/lDg/GhWI9aznZY3BxW5uwF7t06yoL+mJpVbSJNIB2mwdNbbw3woLEATalBO19BAu/UQtNz1GI82JsX7XyVCTv/dG63K8Qj4/+xVa3kglrGIohDsJIuXnw9kHjBNYp3/tbQTX/C8UBfysVTV9RRVa+V7QkvDNIw3Q30KEyuxKRE0XfEoU+aIsvtml4FuqdlA3mdArYtAVAMJpok9I4ZD0Olec+MyCbXeu0sDGWHe+/KF5TH21NQ/W7sZQPdFZ1MjOt09a7jRE3NwqFTCCl27A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=l8Pmnh6ljAenpNpQJUacdgaNEBqTpmwj9v1N0Y5NdcA=;
 b=MloSh6nHqQ8w8BZ7pZwIOef7UXkDKBzb+sag5dawXZ1fTZcE6b1DWqB5hwwCgCTyh8RzHjV5szo4AwWYHHwTSyXNWv1RCWF1mkUAJE7fq90VjIcEMoPPaa4VI2CrvPxHVJpJp9RUFjgtpzcyDHxpX6+2Yn4+wDBepZUJK9i+mTU=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by VI1PR04MB7088.eurprd04.prod.outlook.com (2603:10a6:800:11d::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.32; Mon, 29 Jan
 2024 16:43:15 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 16:43:15 +0000
From: Frank Li <Frank.Li@nxp.com>
To: imx@lists.linux.dev,
	well@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 1/1] MAINTAINERS: add mail list for freescale imx ddr pmu driver
Date: Mon, 29 Jan 2024 11:42:57 -0500
Message-Id: <20240129164257.193176-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0004.namprd06.prod.outlook.com
 (2603:10b6:a03:d4::17) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|VI1PR04MB7088:EE_
X-MS-Office365-Filtering-Correlation-Id: fa5f2f72-9c5e-47e0-d8b3-08dc20e9636f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8O/qO4H1mwj7lTl3zr1cW1TYx+LUHlJaHZsvFo77Rguyi4u3QXamMQkuMGbwVk90XXkGWDD0yFE919GpMiKm+NICs1yzb9Ia/eULHhvIaaIKeEHeLe3nCHcyIJNSWignCIpZY9rfARHCcmbx3leMbjZHQIHUPOApfg8XLRT75nLBtvccbW+KYlJEM7tezfFRsi5yitKQFWixtNt/uqV3idlkwKkBHYF86UtCHlyZG+fV12l0Z4ouONf7eEUgxDX2Cwdohl+qzYRB+wq97XZbU+P4cU9ztdIdfQKQDaNjW2ltSrEGnTKC501y2F9ocXoP5HpCzuNWSGuysRSmpqBxLSv0qAzopt82xzn4mfw9KvtbkDunpPT3J7phvYOkeS0tKXW4OlZmeTWzjo4mouDsu6uA3c/vhW3H0G8mmJ/4+h3yFZQ2U7KIWtWTwWUTQusiIQ+UvcrVFng1+Enf3yZax5wfFkmoRw2Zxd4VuWgXKUUQJvNIU+9UyFGqQvBOMS/T+nowGvdGyVL8eDIYvQ9493x7OCUxBBqCZi5a7sQZxuNGI8gQA1VDP51opo910iLL3gcawQNqlxxNb87xnH4zKkwwMFxKp3xrWdxu5MgUOSxaSBjDIAgTSHdq5ZdRgdim
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(396003)(39860400002)(346002)(136003)(230922051799003)(186009)(451199024)(109986022)(1800799012)(64100799003)(83380400001)(6486002)(478600001)(52116002)(86362001)(6666004)(38100700002)(5660300002)(6506007)(6512007)(2616005)(8676002)(36756003)(2906002)(4744005)(316002)(8936002)(38350700005)(66476007)(66556008)(66946007)(26005)(1076003)(41300700001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?Q+vtAmsoWlHW3uK7JzW111xNntLEpdU4iSv6Rr+UjvU6885uowMynx5t9119?=
 =?us-ascii?Q?4qox2CFpi0oQScitNqJkn8eB+5fRk19YwpUSTC7s0QaRaaBCmj1o0ftKnHEW?=
 =?us-ascii?Q?rhAIzvxF275awHhE43u7PDrKkC6h65Q7teaZfl1DB0gUiryTrHRErdtc6zxM?=
 =?us-ascii?Q?M01mERFTNK6ZF8TJggCRz3yig1TvxGsGxxDBPE5AWWpExCFvKhtwXbDYd1fb?=
 =?us-ascii?Q?8oQoPVO7wnTzEnxm7CKHHqJcRfe5rB7XTxCPHsoJKon4bRtFAABSJOSZbksw?=
 =?us-ascii?Q?Wlnv//sAXqDnqETKckjU9om8MaFtksIZbjNdyhbNjGuCGkddu0696a5kK2w1?=
 =?us-ascii?Q?QdhF3ETtgDx9mv3lvOyqqdQ+DpWps5k4r917NKEWhxDx5lvMhUN3i2DM5TUa?=
 =?us-ascii?Q?0uZjx3fyxWB58kUTau079OXiuoAeTZVIhVuTvIM2J8EVGaMo1GQ/fcRfrsb+?=
 =?us-ascii?Q?PA45arMdZv26RUR55zxBlL6lQvqJyf4kd4iVtTS5lpU7KH5rHz7S3U8jUc5T?=
 =?us-ascii?Q?p11C7KNdaox4x+LLxUQ7FeKIOU1NG4aNNeCOJEFDP59r2pzH8JEdv8ItZZNB?=
 =?us-ascii?Q?JqywnsRpeJ9jq17hp6UZ/jDvkaGHE9qxtZwanTm77E815U5c1juPbAu4+fM+?=
 =?us-ascii?Q?8lkmtKWNRp21IyWrqvnzh80TZK5RYTdn4LaY/bg5TmYC2XQPJpajU6svmmYl?=
 =?us-ascii?Q?Y87z60paoOg5ismiwbsp8Y4PQP6olDLDM/szK1xwJOLWGtwLINW/C+pS5ppO?=
 =?us-ascii?Q?oYIAupDs6+elkPveyuDGBsPy7zntlEoYv0BpDIegwHOPCLYta7butfVNdXV0?=
 =?us-ascii?Q?g/3XesE227xqKVqrOBF3BdBPq6sB1CU0Gisc7K4PCFhrZYNZbhetbk8zB9o0?=
 =?us-ascii?Q?AVU8+K5c2WHJevhPBBYjMz7YpFiZv/XHuuGq/1n2RcZ9VuLVQW8gmmWU8iH3?=
 =?us-ascii?Q?d+8kmXxXR8rrLLISUbIG3GrCzSPPY8UFB2+1P0LwIBwIP3Tu7wFP1PW+ZGKk?=
 =?us-ascii?Q?ZwfAESsgaRVKLo7RCZ1tNdoZnln1qoFNqQ4mQmo5WH9YZZCQaw/kiwkIbZfh?=
 =?us-ascii?Q?XSnbzzvSuVeXTmUFGP8TxFTrr7rhxOWTV45nug2JrwloHzwFoV8a4hv+2Oa2?=
 =?us-ascii?Q?O+E5XkYyKoeLydiCQsJoZlH6UFIcaRFCReZV2m9vsUSubOqfxcod4ToltJII?=
 =?us-ascii?Q?5cJ8vY5JUtO1kpY0Q3E6ppS3dHzAePdbMaIMt2QoLUNhWO7nDTaZZg+W1H9y?=
 =?us-ascii?Q?cFqeuZWKmAsH7G7XInfRrkedTsQCwC0APjtHJ7K4vkswXgQm0mypLvKeBmVa?=
 =?us-ascii?Q?BawtarhWblOZDEjq6LkJho+a4loGtnDvE/wy1w1vW1553UWzys+cbqzm7IDt?=
 =?us-ascii?Q?HzA8F4+vaw113aR5g2gNKy9+AoL+6lQQqSciht3z9PVLuQriUipQb6LMRcUX?=
 =?us-ascii?Q?8/C3j2ydsXzgI9bMnoGFNN5/3Xm/3USMsLdUrfORWuRCL9K7XNzFhOmMH/Pd?=
 =?us-ascii?Q?0hJqBgq5/nugCG6G2+g2KxxzN/40/H1i4+Raep7R2919HoLVxpN7T/9AJfWB?=
 =?us-ascii?Q?kL07yuqkjRByyVs6zKUC11hrqwxl0pBawiiLb/FS?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa5f2f72-9c5e-47e0-d8b3-08dc20e9636f
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 16:43:15.3812
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Zt72b18uJxt4JqObvuGnNpQ+zjac72MVtoLV0VpWG7tgDmfmcH3tHcShmI5l9aeA8AePKoY8go0RrjsX50tEcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB7088

add mail list for freescale imx ddr pmu driver.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 72d27e3ad8bca..21894f83a501b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -8508,6 +8508,7 @@ F:	drivers/video/fbdev/imxfb.c
 FREESCALE IMX DDR PMU DRIVER
 M:	Frank Li <Frank.li@nxp.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
+L:	imx@lists.linux.dev
 S:	Maintained
 F:	Documentation/admin-guide/perf/imx-ddr.rst
 F:	Documentation/devicetree/bindings/perf/fsl-imx-ddr.yaml
-- 
2.34.1


