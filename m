Return-Path: <linux-kernel+bounces-144570-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C9CF8A47DC
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 08:13:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1381D1F228DD
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 06:13:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37C561DDF6;
	Mon, 15 Apr 2024 06:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Qp7ojtge"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2045.outbound.protection.outlook.com [40.107.7.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A720B0E;
	Mon, 15 Apr 2024 06:13:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713161598; cv=fail; b=HLHBi2KucMG7cKzVANG9r6u/96ESi9KzZmsMhPU+8e7Jrpf+3tDckFrV4gX9ZtnXlVoAQ0fSPtW4AmWYPAlz+9QA7yhPaTiRVNDrlNz3fkWNUL+tJjjVVoPeY43xc8ceV9bz/bsf3JfD57fPjOFvB5nG1PvjeXKOxvj6vDRe3aE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713161598; c=relaxed/simple;
	bh=BBBAYGsFJWYHqbyiAaJF2GSpT62jJMxn2co+nRI+HpQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=BLxUk2hHCnSpNXofet8DmU+oMLeMnyaZzLW0q+LoE0bTbDebsOV+9CVStxS5sCAOCSC3R6WwetOHrfJPvujp/FutbkH9JwnrweZFaOIfVvT7PAgQAoclfi8TfJ77A8bNvw5d9RNeUu5/Uecp9gQG4PLAzXxZzOU+nqTwqspQ/XI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Qp7ojtge; arc=fail smtp.client-ip=40.107.7.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FZOFLaIaf6Q2PvFuzI+1DLRe4xJCHt8GphHV0Up4m/HXHFJIBTHhOlNDexclfgzTw1fGu+cBe1jzTFjZViWBHuRv9wmJNSx/XkVnLdfFc48nsSLDbC0ufIEr3ZhAfXX/X5G0Jr7eBJSFLEh78+K5QttEKEL8pLiYBOWxBT2/yd1FE/tbeUw1EuBdleP5yUjxowCiDi1LHW7DUO61MBzS/r5wtbmwRbgPr6gwGxhuHkJm/sYTHmgmVkY5n062WGGipGVGlMnvCxaYmehm7rX11nCJCD03K5D35uvpIuTN4hwvQ1khJtmWqiZpjXIuso/C9JA09jSDUxrOvGaSIU0JCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jf9LqYACnhBC27tNhtlzyMC4brhwEzNKeAmPlcHa2t0=;
 b=R+b/YGR9P43Sor2ltP6yEUC4AsZ6c649lC4l54SxeeKdceFUfILLI47qSdldBkrjcZkMiqjGrXmzop7YR8p2Cxe0vSvRA96TETL5yRvKmQeZLl8bdslqbgrqmrSLae/yC6wQgZoQS5uTr/lnpXnXAk3VcQttKB6D3zzavC2ydhgP2RYchrOkCJAb4r/3hpGJB0GZLYyH7LhSU/9Y8wUIwoanfh5zYIZJQcEfQ/029ZYdmHh8JoVEiEwoFHg1P1xdpRzLZuoxbt+n4nQ3QeqMKA3eL10xioYyAo1gSHVnBkzb1l6xRCRig/mvmSZlExEwrWp2t7YrTRDj9gjgFDcwJA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jf9LqYACnhBC27tNhtlzyMC4brhwEzNKeAmPlcHa2t0=;
 b=Qp7ojtgeX/Zxg2d1n/65tc0xmiYoDNBrTP9sAE8xrcsgTHOk/ayxM+ViV7+8BldM1gpR0UCh3RTGQLJNdUCAFCdFlSAUVpqRJxV+qnnr/z92VRmLUJRXa9dXpD954DFeI0xdnijjPvH/kHQVPlo6rTEtMdiBJY9sBLbx+WYJnKk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by PA1PR04MB10117.eurprd04.prod.outlook.com (2603:10a6:102:454::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.43; Mon, 15 Apr
 2024 06:13:14 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::8d2f:ac7e:966a:2f5f%6]) with mapi id 15.20.7452.046; Mon, 15 Apr 2024
 06:13:14 +0000
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
Subject: [PATCH v10 5/8] perf: imx_perf: fix counter start and config sequence
Date: Mon, 15 Apr 2024 14:13:17 +0800
Message-Id: <20240415061320.3948707-5-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240415061320.3948707-1-xu.yang_2@nxp.com>
References: <20240415061320.3948707-1-xu.yang_2@nxp.com>
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
X-MS-Office365-Filtering-Correlation-Id: b0bc4ca4-5bc6-41f9-7ce2-08dc5d1321fd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	YXXrMacHjHiRfNLUaS/rX6tLyH0EE+pzCyM3SI2dRJFF+qbZ25nCu+7R1hLGaFEynDT0AWvOvbFz9ONvwz6a/Xw3wS1ZMUmuockbODFbmHvbDc22vEU2Ykl2b5Cvg0aCmNsDKmbn8kDwz71DGaZOSe/UBpLkZdp+Tr9yeVWrrDpkT2b4urYjfHPbAWfnQ2HtCi311/F5kxRXKSgHrYAJXUL9pmfQSVii82vW+iIxbEmXo7Zedhtfdtv7k30k1QdThKWRenW1fwMN6hApRYWosB4aFSA/1WdjVEVgPNyRYqRfx4QKAcbe1/RwjER0mCQesyciBxsdWxGAmQsbbiXFAK/3l9Yoe0nMjABZeRutm92nQbOBvz/D7PSTKxLQ035gR5iJeBL4IUQ8p/kQseL1UrMpRFjveTAKrsUe/0xg83W2WhzFuxC03X3CIsh6XcecPclEsEkMdq3TLDJC+TcH3x/+nt5BchekErrX355OkLYDUUib0VLQ2Lu1yfdHhB6zrHDk452GX8ewCj/rYfeplOTypkudUwNaWzEd16m2rjYbjCBmM82KaKlCBmq5UPxWjpdo82AZo7H5n5pOCH24UR3NM/h/RhPP6S52RHND+/57r519xuIYKmzO6Q0xaN2PBcO72Oua8XkNiu0MuCcBxIxcft9dvlXLuMAGem8vTPpXsugOsK7pHjzA1a9IhzaaBbggPZ2d+cEdAf/kjYCwcg4Nn8Q6tTXH9pw2XTZA0CQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(376005)(7416005)(1800799015)(366007)(38350700005)(921011);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?+PIOVpIH8BPpl82MPlHR23qY26nglsO3/xz28XvBJcLrDVrI4xuINw7vEmX2?=
 =?us-ascii?Q?Jyu6qWgq3LeL1f1aNV1rHxz9Av4/MK9xZC3A+2ToiaoJgY5xFkyCaySDFQ2r?=
 =?us-ascii?Q?r0vF4SmrGV3drkGAY0OpBQmV+pGJRIS+nWU1uinHPmNTJG30gO0+m+KD1JWn?=
 =?us-ascii?Q?OhH1VxjIRG6BNkanPAPwJPosanN8wWr5v22oPXesLoA8ABGDmkWWeV74vpLQ?=
 =?us-ascii?Q?ctUwnKLzwLiXHkhhpxZOmsfxEf10qZ/OcugSjLod+eV4UknzGgwNYMSXEzT4?=
 =?us-ascii?Q?rEcJ/el9xwTzY0VCpoHpwJdV5qLbJ7POFhD1KDgBzPsgwuImLTjttFn7cnt4?=
 =?us-ascii?Q?7ctwqDD8AZvY+iU9v/oBCYIc0HWOwcjHYy/iVmLsGjDOHO/yfVMyWwYFJKI7?=
 =?us-ascii?Q?KzcHjJg3PYGjBMIRVzD5wWxbzrcpuxEtTBeNj4OpSOZ7wXcq3fQiPIFC+14E?=
 =?us-ascii?Q?dCyeeyVl1YY4kym9D2GzZyvY0OIrcuvA/pxdJWUruin95d/eMfY8qT8HiBPm?=
 =?us-ascii?Q?r1Nu+e0SZBlAm6JB/2Kd1oOvatreTtiX42dCmWESUjC7EQoOuwkQGcbhsFTI?=
 =?us-ascii?Q?/Vs2OQy5E/fr2pwwpWUoK6/u04fDhylUmWfime0c/AxmTySmq0bnVRXwoPYQ?=
 =?us-ascii?Q?0obVbOP4fbwuYEC2MD405uPyZZG44ncRWWsa/Z0kVySwIHBXCnscmT97M53N?=
 =?us-ascii?Q?Xpgu69btzu/cEhyDARTTj5e4bDXmRQ/Bz3Kwt8/T1h/fch+/5KpReIdTBJ/f?=
 =?us-ascii?Q?O4olPiFv3dl7SrzOCPtBFPIRU9bYEILHnglwvYOPkLH3oWri57k/3CA1jbYh?=
 =?us-ascii?Q?zYvcpSVuMEHUMWUf6Dd99gTqpYlnGCBAnNONfnm+iwz2gUMU61Pv+aNf/Cee?=
 =?us-ascii?Q?mM5nRc6MFOr/FG3/NKYVQy+PtyXTR7Vp8xW6dJZgH7cIjz/520UwshQe6OH9?=
 =?us-ascii?Q?EVNEdQAUlZKOoKMmSg7xudYa+MkyRdV3+39VizqdS93aXtgpNzp1LTVV01Oy?=
 =?us-ascii?Q?U2B9qpChKZyLjo+6O0kaEI2HTknmn8BzA2nj6e+g8gcFglavSVfIvuY6QneX?=
 =?us-ascii?Q?bHY8HTjHj8bTYC5BY25DqvtxVC/hxPxeil/ifa8pi1rLYWf8jduuHFGZcCOU?=
 =?us-ascii?Q?pF54JayOXyyoXG/AHFnZ/bWfNj6vD2i3uzClUFveXhPVTiVF4tSO1aqmcrMy?=
 =?us-ascii?Q?bKsB1VzRJlseTAjF4bZ0ux56vTUJrgJUJ86ay5f5iBEcZryWatg5N7v/2V5J?=
 =?us-ascii?Q?xFSdXg+VEh0Z283zvQEAHWja29OUx7EjtUZIBZ7ZAMMI0MuVE5+l7RlfVn8X?=
 =?us-ascii?Q?+j+EVeGmexUyqQEc6iO6ZM00tBOLqx1BTnSddUKNZc+KNCMXWzKxZKjsaUn8?=
 =?us-ascii?Q?ZEKgtrqtr0Taq6yeoSHuXsbnMiOvesleg3DE0t6jkV5R3LiGv4qYcHu+IY8p?=
 =?us-ascii?Q?gopjzL9HNkiXuCOzLeashjby7AekLPf/RpPg//8Ovc27V2EPfpyX8NS35/vM?=
 =?us-ascii?Q?vvKvftWnULfIfJvn6WNaa1sRWa7JD+AzKOCT2xY4UIzvGIGDtEObPjeuXddg?=
 =?us-ascii?Q?drCeSe/9X5lpTZsPwJ9dxJw5bMJZN+M8lX/EP++G?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b0bc4ca4-5bc6-41f9-7ce2-08dc5d1321fd
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Apr 2024 06:13:14.1051
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Pzxq7IRI/wiFEqFqn9RMj1JIt7LFFbozl+jc5d1j5BZoDFXbwPlsWLRf2tk/zrUNJ8eKSpEzxMb6VJOrTsgeSw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR04MB10117

In current driver, the counter will start firstly and then be configured.
This sequence is not correct for AXI filter events since the correct
AXI_MASK and AXI_ID are not set yet. Then the results may be inaccurate.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Fixes: 55691f99d417 ("drivers/perf: imx_ddr: Add support for NXP i.MX9 SoC DDRC PMU driver")
cc: <stable@vger.kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - no changes
Changes in v7:
 - no changes
Changes in v8:
 - add fix tag
Changes in v9:
 - add Rb tag
Changes in v10:
 - no changes
---
 drivers/perf/fsl_imx9_ddr_perf.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/perf/fsl_imx9_ddr_perf.c b/drivers/perf/fsl_imx9_ddr_perf.c
index dffe7c1e4809..53cb2842956d 100644
--- a/drivers/perf/fsl_imx9_ddr_perf.c
+++ b/drivers/perf/fsl_imx9_ddr_perf.c
@@ -541,12 +541,12 @@ static int ddr_perf_event_add(struct perf_event *event, int flags)
 	hwc->idx = counter;
 	hwc->state |= PERF_HES_STOPPED;
 
-	if (flags & PERF_EF_START)
-		ddr_perf_event_start(event, flags);
-
 	/* read trans, write trans, read beat */
 	imx93_ddr_perf_monitor_config(pmu, event_id, counter, cfg1, cfg2);
 
+	if (flags & PERF_EF_START)
+		ddr_perf_event_start(event, flags);
+
 	return 0;
 }
 
-- 
2.34.1


