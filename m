Return-Path: <linux-kernel+bounces-144144-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 857A58A425F
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 14:59:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 20EC12816F0
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 12:59:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A5B44DA18;
	Sun, 14 Apr 2024 12:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b="mVFNBqPS"
Received: from EUR02-DB5-obe.outbound.protection.outlook.com (mail-db5eur02on2132.outbound.protection.outlook.com [40.107.249.132])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2AC4446AC;
	Sun, 14 Apr 2024 12:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.249.132
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713099525; cv=fail; b=jlKDAecrsm0PQoHr3v9BTbB7rslxZDMAD9hRWO99R95WQ/MInfNyqTdaWWwWadju8mO99mcpz884KQN+NKO4aW0OHM9FDxaBTe8BiEd7/smYfWSxAqb3yxNomNziYiS3fp9w2T5IeOviFYYqfiuC9Am2EmEk6fu1ZNfoBfIdbWA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713099525; c=relaxed/simple;
	bh=GFluvfhj5Ax+bv/A4jA3zMj5cQ3eofnG25LGT1f7e3U=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=tHufZWI/nIyC9IwjiNbPl6JFII0deSaN07DXmfaLMzXOhW0Swt/XLAQr5i6AjW6QxfO186kCyaYSTvd/n8iv1k2CVHiUuXQqv/q5E4TPCIw3UaBCmuGO4hDc1AIppgWQeugtapxoN86RyYhwszyTm/RVfLFCNLoRON3AsHf9M2E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com; spf=pass smtp.mailfrom=solid-run.com; dkim=pass (1024-bit key) header.d=solidrn.onmicrosoft.com header.i=@solidrn.onmicrosoft.com header.b=mVFNBqPS; arc=fail smtp.client-ip=40.107.249.132
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=solid-run.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=solid-run.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UyZf/XVk9A3dNBzjclKT3b0RoiGI8F1ZoDGHaQZ61m/0FdzVZ6yzt/bGPVBnSkx2oucOwOI+/v8Xw+ASkHmO2oB5XSXFFiQMbwJVPST/tjO2jB2D0saU1XMEQRov+QfVVPwcTofiut0x+z3NzgHQq/L5hg2GJ5FMCzL9NHtV+nQogcwLCV/nBPPDLTTJddO6/KJ2e7x7Im0aocOWVaUevEIuKGnCk8XaaQdlIEdAdu2hNu1kEAyhLIYtQtvcoskVeDR6Yqq5H/jK4ve57AYbFMpSk3fD5lkhdJCkle3FblEPVgkdaHdmvwgoV4yTk1AFFG/o7rgqzyAzkWSGkly8uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1/o6Db+4qari/2w8dwB2BV7Lr+ariF41jilDFIiuuTo=;
 b=ktj0zBRli+bHh7fDQxkMLzLbMydVPM56gXi2DboVArjq851wXOojAV8flXx564155gDgqnjrGt4xhCsOC0DJXmyLVTihr9ylWAU29Cs0Ntf30Dno6HW5q4mu7MWgSRj/k4PZE6VvuZWUAV9UJG+DZBg4WM3Y5tRnj47C2j+SI37n4oHtDaWIW2BMUS7fTKX69FhRsAFuLDV3Vh6p72ajbivSnUieV3OtAJyc/r+e/XR6C2ejBcmM271X5UfMeeGtH/qLIbDtStqxMA3Rm0c6roODG71v+wz6jx9KQEoAJKmqRd9GYiYhaE/BDrTzDtszMCUo5j60URybhaC+AE1YBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=solid-run.com; dmarc=pass action=none
 header.from=solid-run.com; dkim=pass header.d=solid-run.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=solidrn.onmicrosoft.com; s=selector1-solidrn-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1/o6Db+4qari/2w8dwB2BV7Lr+ariF41jilDFIiuuTo=;
 b=mVFNBqPS1h0OyLsRbG5sAFf6d43MSOo4odo3yd76UbAIKBwKf4+5M4Bs6pRva9xOcQfOM77wObPxRr/+I9zILFAPIGpYcvUnoc2eWBK2ZScVoOhTI+Tj+NIRbCDtP8rLvyPtd2RpLrIaTulbRSFIL5LQGxQRqtAMzEWCaO36cHs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=solid-run.com;
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com (2603:10a6:20b:2d5::17)
 by DU2PR04MB8645.eurprd04.prod.outlook.com (2603:10a6:10:2dc::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7452.50; Sun, 14 Apr
 2024 12:58:38 +0000
Received: from AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529]) by AM9PR04MB7586.eurprd04.prod.outlook.com
 ([fe80::c04e:8a97:516c:5529%7]) with mapi id 15.20.7452.046; Sun, 14 Apr 2024
 12:58:38 +0000
From: Josua Mayer <josua@solid-run.com>
Date: Sun, 14 Apr 2024 14:58:33 +0200
Subject: [PATCH v3 2/4] dt-bindings: arm64: marvell: add solidrun cn9132
 CEX-7 evaluation board
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240414-cn9130-som-v3-2-350a67d44e0a@solid-run.com>
References: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
In-Reply-To: <20240414-cn9130-som-v3-0-350a67d44e0a@solid-run.com>
To: Andrew Lunn <andrew@lunn.ch>, 
 Gregory Clement <gregory.clement@bootlin.com>, 
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: Yazan Shhady <yazan.shhady@solid-run.com>, 
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Josua Mayer <josua@solid-run.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-ClientProxiedBy: FR5P281CA0005.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:f2::18) To AM9PR04MB7586.eurprd04.prod.outlook.com
 (2603:10a6:20b:2d5::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM9PR04MB7586:EE_|DU2PR04MB8645:EE_
X-MS-Office365-Filtering-Correlation-Id: 9d9ec758-c70b-435a-59e6-08dc5c829a23
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	Tj+Gzbfo9wqNBAb3qBQDdchn83NVsFCGBo/vPUYofaFCe8F4RoTCW82JT2TDIwf3T4ujMmKixrP+Zwy+gh0iVN/RrkI7nIsLBnOmZyU+L6OHu7hSwTBSLQtDfS6j3fdg1jFkDjpwMk3V9ZT1Bci0th3RuI/HgMbPLYoynI+QZ1BekJ2F/QvCEb7L+DpmlRE8detHl6Hf85kWAn+TU8eruxNToS8gJC6bAcXec7al9fJN6vQ5OXITP3hjnufus0Tj7NC+GJRqLU2pB91kDY174AhIt8zWDCVUt2ktyYXg3r2OgOzPbsI2MPbHhxqmKf8a6TGzPmhpbZKtkSObwzuNco59waFXoI+HVrfMi7OE7BJ4oAPtTj3G9bqL/exody1wJ+8P84R4/iwktETFilTpI8jkqv4yj29V971aoHWOc1orakjJgzUkr7sjaEGh4+AVmplw8eJNgnqOJIpPcAATcG5zcTlgN4wyGe1gElFj86Lh7WTfYTRHOCtJs6PVstYKXdtzmqGQpOBM9KSaNH0XjPReX/S7SO3CXbdTU4AOvMcgcbnX/CPhIY0F0xJwn6K70449LV9wzpm4xQNPwDCLwnDgHhUKMIldY9jVVpjdHYQfW1GPHIIeKLLwrsQ4zDw8lLFlv73vPRrQx5g2Qbe1waG67l3UG0teO9z/jwZiVu/dyVp8fwT1UUYw4dqoY/jF0zUPzOoDVrDYcLwzLzxLDggVrc2+O+Jbe9vRZZUaPWA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AM9PR04MB7586.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(52116005)(7416005)(376005)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?M2FJZ3lpUEVteFdpRnNYNU5ua2E2ek1yOFFGZkhCa1BXT09TWGt4ZHJReE9X?=
 =?utf-8?B?dVZRZzZJSmJMRDFtbG5LR1FOb3lNWG9vZjgvNytBbGwxZU9rUG1RcGFhMFBq?=
 =?utf-8?B?YkNCc0VmMUozV1BXOXgrT3pmdXNwM1hFYis3WkRkY1RCM1RhM0U0NU1MaVVJ?=
 =?utf-8?B?WFdHMTU1VmN0V2N6MCtTZS9hMkZQSDlRUk9Kb3FzTjVBcGVKNHZ0c3ZsVmgx?=
 =?utf-8?B?WFJzRXViemNjSXlwZnhzbHNvSkFvdGU3VmFvQ0VFRzVaQWxQYkJEUVYzMjE0?=
 =?utf-8?B?b2toZDZtYUdaV0VLYU05UzdhWHFKODZ1S3pYbWpkOEI0RlVJL2JQN3Zzd0RN?=
 =?utf-8?B?d0lEUi9hMHpqRThiTWFWRkhQc3Z1RlVJc3RKdUVENWlEeEgxdHczUUNxZ0VQ?=
 =?utf-8?B?bE1WVU9tYnRRMnBTMGdNZjczTk9VNmdMbkFXY21MTS80SGkyMjJ3T2pRNG01?=
 =?utf-8?B?WHhLMmlGcDBlbXpiZE16ZlR2b3V4aEp2R3lYY2Rldy9iS2tDanV1NG03eUdi?=
 =?utf-8?B?eW95Zml2Wm9CRVpCTkZZcDhKYXU3MXlwcVY4V1pJRWFDNTB6blhDT0x4NzQ3?=
 =?utf-8?B?YXNjN2FGWUdveGpEM3RiL21MVzc0bkpCQTlzWm0wWFJNcTJQZ1daWmNoVVpu?=
 =?utf-8?B?RzY5VTNncUdnWU5SNlV0TlhCOXJCaU5pWDF0c3E3aGF0SXVqUGJxbmp5VDBF?=
 =?utf-8?B?QVltS2hFdnhHVTNZRE9WcCtPd3V1YmdVbjI4NzhSMld2azRzQjgwajFVUjMr?=
 =?utf-8?B?RWlxSkN2ZUtIeDRSNmxMMzlRTWgraVN2eHN2bGZsY2tFejc1MzBmbUMyelVK?=
 =?utf-8?B?a3RMTmFna1FRejRmSXRCTkRnOEt5bmg5SFZlR2VWQUpYczg5Z2tCZzlKb3B0?=
 =?utf-8?B?VDFGUVYzTmoxbmovT1V2dU0zQXJsMmdQMmdhYXVFblpDN29oajhwSzN1ZUFD?=
 =?utf-8?B?VlJWVktYZlNvYXJjOU1UY016dHpkaWpMWGVIMGx0WE1XNExiVEQrZnZzQ2NW?=
 =?utf-8?B?dTk1RDVEY3RFbzVvT0NCWnR5RTZlQUFpRnRqRURNMnBzNVZVREhtTDIzcElH?=
 =?utf-8?B?VGQrcDZEeWpzSGJmdjR0QytiYmhSS3UxN2ZsNlNHMkIzMkV1c21wdUQrcDYw?=
 =?utf-8?B?VU5SMng5blJvWFRtNkJyMEtHc2lkM2pJZ1Fkd2U3S0NtYmFMbzRNUjZONk1p?=
 =?utf-8?B?NkcwTWxrNkx0aTdmT2VUTUxvcHFoMkg0NHg5WkxVUHRvdU02eEdYWWNxSURu?=
 =?utf-8?B?N0dnc1VVd2xxL2QyQ2RjcGwva25LNkRoOEgzTDA2MGFPd3dtR2NISDNXQThz?=
 =?utf-8?B?VW1ZcEp4U3EvNDNsNXRmSTFIaWMyeFpHWGdGckI2SWtMdzNvVTE2R1hVOGR2?=
 =?utf-8?B?N2pUcGNUdjZ6UUMwSnV4VjhKRmxmUWNiMzlzTDU0ZmxUUm9oTHpOcy9YTHkx?=
 =?utf-8?B?SW9RVnQ1WWhVbk1jV04vL1h4dGNLMFI3ZmNxVnVENE1SMDNIUCt1b2l6MUxW?=
 =?utf-8?B?QWo3QktmUnZzdzhjM2NIU05jS3U4ZnFuQ1pXM3V5QkVCLzFYMUVkbHgxWWVp?=
 =?utf-8?B?ZlI0VFpaQ2o3M2k0OVFUWGloRFowZ1Jjd0xtTndQUHUwTklrck5YNFYwazc4?=
 =?utf-8?B?Wng1WG9BVzdmOW0wT0xweDZIa041c3BKcGRHWUFiWm1SWERSektWdG1heWtv?=
 =?utf-8?B?d3h1MG5WU0h6SUJlanEzdUd6ZTh6aUxvcmlFU2FLWDdqN1NvZ2NsYWpjVTRS?=
 =?utf-8?B?ZWJtNjVsd1hzRmdHbDE0RUtSVnJLSHpqdjlVVE9GRFk4dGl3bTZVU3g5QTNq?=
 =?utf-8?B?N3lSakhJT0dRMzRiRGxKVkNrSVJoMS9oSTdVY2RxR1FRcEppc1Vib29MWGJv?=
 =?utf-8?B?VlJaNEd6QjgySmNlanNyVEkzTG13Ykw5N1dhL0ExMTIxU09hYStqUWhBaWFv?=
 =?utf-8?B?Nnp3QkxlN3c0dzdLdEYxM29jbGhIYjU4S2FPUW1wcVNDWXowNTZmelJJOHVn?=
 =?utf-8?B?TE1iR0lKc2lJM3VxWjhiVkRyakNHNTRxU1RPcUI4V2NDd21yaFczbU9GUmRZ?=
 =?utf-8?B?YjZGbkxtNm5mYi9seGVvWTB6alVydjNPR1UvNi9nai9ldGJ1WUVCV2ZFdEtY?=
 =?utf-8?Q?+4+axxwKMwjMX+EGmThfWuNSa?=
X-OriginatorOrg: solid-run.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9d9ec758-c70b-435a-59e6-08dc5c829a23
X-MS-Exchange-CrossTenant-AuthSource: AM9PR04MB7586.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Apr 2024 12:58:38.1911
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: a4a8aaf3-fd27-4e27-add2-604707ce5b82
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uGDQzirOXQThi7b/etiqIRWHFTVJeF3TczyJrYgoJXDZZEn9HlEoEwvDL/8Is9ZwHktz+FqCeYwlEoOWzL/pTQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8645

Add bindings for the SolidRun CN9132 COM-Express Type 7 evaluation board.
The CEX is based on CN9130 SoC and includes two southbridges.

Because CN9132 and 9131 are just names for different designs around the
same SoC, no soc compatibles beside marvell,cn9130 are needed.

Signed-off-by: Josua Mayer <josua@solid-run.com>
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
index 74d935ea279c..538d91be8857 100644
--- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
+++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
@@ -92,4 +92,12 @@ properties:
           - const: solidrun,cn9130-sr-som
           - const: marvell,cn9130
 
+      - description:
+          SolidRun CN9132 COM-Express Type 7 based single-board computers
+        items:
+          - enum:
+              - solidrun,cn9132-clearfog
+          - const: solidrun,cn9132-sr-cex7
+          - const: marvell,cn9130
+
 additionalProperties: true

-- 
2.35.3


