Return-Path: <linux-kernel+bounces-57247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9365C84D5A1
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43E122888B4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:15:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7277D69316;
	Wed,  7 Feb 2024 22:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="rGLguKMl"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2041.outbound.protection.outlook.com [40.107.7.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FB4F535BB;
	Wed,  7 Feb 2024 22:00:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.41
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707343255; cv=fail; b=J9aENt+KpYo6CdjX2/CAYQejlmH3go41h+6O1KQgl/7Y8zIhQpgmmt+5splkk5YW5ElqYG1JnyF9vDjCXrNhb8Q5kvAn2pR0rua7xwvLa7FBFHHIzZeFjCO8VvHxywMgTHuSBMMRIZSM1Pl5do0ffkluWP0xhosZ8L3NpUHwfYw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707343255; c=relaxed/simple;
	bh=q3kBIvqlLNLx9k8njpsd5vd+axiZwyxUW7mUgD6I5qg=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=fQsBs3PvmsgGE8Zsnurct1aZzkSzh83nVhGtJCfnPgOb3wq/pB2VkouVgB6KjOLLfmM4SfEqwa2VcCX9CQvsftMXexoJ+fiKkRZ8M+qAxP9xOH9TkbiAyheytk843eQOe8hiI6hAEaGjLikXlyXumnpSrQI43G19GU5bS1B5kz8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=rGLguKMl; arc=fail smtp.client-ip=40.107.7.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QPfKVsJ8gM6zLigJhSA+hlh5ynHsMXmuCNNTCG4UI8mtW+TxxMA/iNpmGiqfkKCSsGQEuzMYCa52wAK8nekaS8eLQxqXD7ivufvpmQaA5CViFAasTpKSTRT1yCkE3c4/L04EFl/dijYplW3HhnnTjPlVkVmvtr9/jtmYQ3R79Cl6SENa7aGIfJBQaGtZtB6hpO+MQuSkp7j5hpAWqrju5fYWMFqoE2fvI2U+/VjhcCiPaf7/PCCr3SYicsawOASaP9A0BHtKTdMvz43Xm1BeKY4MGw1+MX7cboSnSLMV0+YeoW8K/Q4iL+sfbi5xz58sDLOSSMGZTkTQZAWtMECjiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=47PDPRsNGsJa5a+l/UT+FpQe4puJ2NEHOpTZ3lhuWQw=;
 b=hqitYKxrDEpjrpq1aUnQv9FRZ7b5u5lq5OHHMO76M6QDmZHbnMmMvCYScCOLxSe5g/BaxwM0lzyX7qN08iQ2phRNC2I/rhu49PUDabl68wtQwjRMy93pKLkodMLunXVgQcRLDbHMavmqcYInf4LHy5C2fHy4Mcca7as6l/aujjxAKOQq+44gNiXGhZAfJh9Pc9UchtfshSc3yc84AREQqxxWapfwqC8gxDJE2x1OYS9nl6VqjYQKnsml4zsvNP40GOSjrSSoYhEKyw3k87zEJYLCl99Apq6tLGkiJK14JfiDYaBzNVM8rQb1XgIIE626Tqr1UEmLExC8L9m4Wz072w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=47PDPRsNGsJa5a+l/UT+FpQe4puJ2NEHOpTZ3lhuWQw=;
 b=rGLguKMlGeXHPSycHG9abrCggHp4NbKW2yqH0yNuLae2OAmC/oP/KjaiJKdr0ld9Klg0tCqE5elolBgvg7cWwPfUiyxkcy3tdd8/caj7EUvnjrKkNuzpUcP1SBdwdyvNEgTIKBU8zQKz44oobOxGTz8ZtmsJGR0kefwkXlTKgGw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by PA4PR04MB7789.eurprd04.prod.outlook.com (2603:10a6:102:c3::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.37; Wed, 7 Feb
 2024 22:00:51 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.035; Wed, 7 Feb 2024
 22:00:51 +0000
From: Frank Li <Frank.Li@nxp.com>
Date: Wed, 07 Feb 2024 17:00:19 -0500
Subject: [PATCH 2/2] usb: dwc3: drop 'quirk' suffix at
 snps,host-vbus-glitches-quirk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240207-vbus-glitch-v1-2-7be87099461d@nxp.com>
References: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
In-Reply-To: <20240207-vbus-glitch-v1-0-7be87099461d@nxp.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Felipe Balbi <balbi@kernel.org>, 
 Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Cc: linux-usb@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, imx@lists.linux.dev, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.13-dev-c87ef
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707343242; l=880;
 i=Frank.Li@nxp.com; s=20240130; h=from:subject:message-id;
 bh=q3kBIvqlLNLx9k8njpsd5vd+axiZwyxUW7mUgD6I5qg=;
 b=MtKLtoUe3mwjkktJg1/uxeQq3wvHNjBEPN+yoWPGPZrkiOSxvj9N3vlly1aMDKUoac+V6OmUH
 Rf+4/UpnsY3C8Pbj+xzg29YU6ExWMUbc28tRF2PL//26DigroykmITE
X-Developer-Key: i=Frank.Li@nxp.com; a=ed25519;
 pk=I0L1sDUfPxpAkRvPKy7MdauTuSENRq+DnA+G4qcS94Q=
X-ClientProxiedBy: BYAPR02CA0001.namprd02.prod.outlook.com
 (2603:10b6:a02:ee::14) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|PA4PR04MB7789:EE_
X-MS-Office365-Filtering-Correlation-Id: 396928f5-7222-4024-44d6-08dc28283f8c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	0SdUAl6AJbdBwkrBNd9TZG3VSWxRoFcTlf5ys4k0xY2kXYsUFGLcqMg0VesSEF9zvuqMZudJEQjfHStm5+4UejUuFt2WV2ADDdKRxGKZOnWC1BCE7W/bHIGKGtVmH8w8KBQhwapNz6hTc4fwoHNP0nOqe/SpN3hrPozg8EeJzSp4zm5KAu26dvDETUqQEriL04hSkCrUr7XRsTuD0EBDgbku+c3qi3ZekvmuMbZxVT5Aztz1bNzCqZpEMJDxVcLesr+6Jj3hP8c1RBJmWjnucY2wcE5AVFro0quj7qvgjonQovxXWW7/8EFq/5XoU5NwHe/Rn4PtTESztIW7lrSA29wIh/QUw3cNZWdCiJg+b7PEjhso6auGUKlk/t3xcgn4dqBG8FAEpgJChEZ0ZhGA13N5/v7O5g0vxYDUQqNaWkqgPat6w/1FwFLF2IliVSRGvB9twHrgHwMz9oj5bYlpnbWTLqKYSbxt3WDi5G8nTAZVe0Q8IH4C1OUzARy/5QDrm/Xd7UOUiy9K+hFfKTvYBhsoQCPzGkJozzVgL5zEm7my8AWyXsATn4YqYZB2PIM1G8ARCfURPRCtALR3OvMsVU+gKIXZ7EoytUz1TIMXGjcWo5mh4W/GuAQIg96zi3F4
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(39860400002)(136003)(366004)(396003)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(52116002)(6506007)(6666004)(38100700002)(83380400001)(86362001)(26005)(41300700001)(2616005)(8936002)(4326008)(8676002)(6512007)(36756003)(6486002)(2906002)(4744005)(478600001)(7416002)(5660300002)(66556008)(66476007)(66946007)(316002)(38350700005)(110136005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SFVheTF0WTI2T0FUWlFSNEUrSVlQeHFTU2s5eW9BZFZjckNFUWdEelFMTFZG?=
 =?utf-8?B?MkZCUTFCa2d3Nmx0OFFBdGJtZ3lNaEt2blBaUEVRTGEzRjM2Rm83V2JreVlx?=
 =?utf-8?B?NzlRcjV2aWFodnhNYm52ZzJJNmtoZnNIVHNrY012K1hpL2JJc1llZ1RzZmQ3?=
 =?utf-8?B?clM2UU5rM2ZhUldoZU9RZzlmaElQZ2VEdHQ0VElDRjZ5TllkVUNHU2VYeXpz?=
 =?utf-8?B?S3RMUWhJMWpNRHpnMC9ZMGljNnNwcmJMcTVHcll6Y0puWTRteVlnLzZpelI1?=
 =?utf-8?B?QmFNN0paVS9Jd0FlbnkrWlg0QitNN3NDd2g3ZDhadjQwdzNPTExKRmRhYmhz?=
 =?utf-8?B?cW9MMU9xRjlJMmp2WG1VRllyN21SbkJGTVJyNFU5WWNHVXE2U1BIS2d1SnNn?=
 =?utf-8?B?TmxJNjY4WTdtYmpuRlpTbnNROUtpbDJsOWtjOTRFU21LbTlnVlZXMHQ3OTdO?=
 =?utf-8?B?eTVZcEM4TEw0TjVaeDdXZEV0QTljaFNHZk9MWXg5Rnk3b25lOTA0Q21ocWh0?=
 =?utf-8?B?eWcrUlc5L3Jqd0NuY0dmQzhJdmNvK0pnc1dqU0N2dFhNZmJ6MmJLL2FCUUoz?=
 =?utf-8?B?OEo5RXJ1VnRKNXd5ekFud2JTMGVUbm5sd0V5M2ZvSjdyUHZzRk5sZVViRWho?=
 =?utf-8?B?WG15NmpvckdsQWk0M1JUR1hJMzlWazRqNmlIQ3RVVzZwMXc4TFk1UHFEV3R1?=
 =?utf-8?B?R05SOU9NY0tsbUdPUDVBeU9sbm8rbVZSNHh5eUI1L0k0MEJRSnFJQVB6SGhI?=
 =?utf-8?B?SThZeDFKWThOTEpNMzlEdFA3T01YTlpydTZJSFF0dUt4OEVMYVRvOHcrbHlE?=
 =?utf-8?B?ZXByNDY3L0hoZTFrTGI0NE82d0Q1VmFtR29ZbUh4MGV1ek9wZ0tET29kM3Ny?=
 =?utf-8?B?ajN2ZzJHQUN6aHc1S0psVkYxVlNQQ1ZDOXUydnVmd2ZGTEQ3VWZOVVlpRnJY?=
 =?utf-8?B?dTBSQkFIQjRxUE9qWC85UlN5aHFrQ3o4L25NZjdNOC9lQU9vUmcvbFJLbU52?=
 =?utf-8?B?QkZweHFxVmRwSDdOTFJsNW4rL0gzTTN3RDBtSTg5RXZiME1ycTVhZUhxcEZp?=
 =?utf-8?B?U0M2am1GdW1pU3FFT3daNlgrLzQvS0U4bFdiRUtIL0k1S1ljUHB1ZGdQT3Ey?=
 =?utf-8?B?QjB1ejJrNzF5ZmNDMDNtOE4rUyt0OFFYd2NwMDhiV0Q2ZnFoT3JHQ1FrVmpE?=
 =?utf-8?B?ZVVBQTIrTkdnMHNyUVBobmdTWXM1QWc0cElLSHdpSWxnNDN3L2R2cHdweVVp?=
 =?utf-8?B?OTlpSXNQZXNTT1dWKytWY3NLNzF2ZkFXbFhobHp3WVVlWUg3dW9MekJCbVo4?=
 =?utf-8?B?RHJ2UVQvUCtVc29INUdVbTc3MjFxbDBRUTBadmxrQkhtZHYzanl4aC9iNEtz?=
 =?utf-8?B?RGVOa1kvLyt1YkJ3aHlRU0p5TDZOS2QxeTJXd0dnU2lBSFVKNEVHb042bEVW?=
 =?utf-8?B?LzgwYWVyTmQ2ZkltNWFoN0h4L1lyMmZRTFpuSnhWNzJJVElrYXU2UENzeFkv?=
 =?utf-8?B?SW1idThTZW5keDIxa0c4UE9qM2dJT2F4VURMclMyaGlpd2JHUEpid1l5S1ov?=
 =?utf-8?B?cEpsYStSd0FPcHhmZGhzUTQ4ZTF2UUdNYWt5RWNjVFV2WVB2eGJuYUsveUIv?=
 =?utf-8?B?T1BOMmpYRXJCcWwxWWVkWnk1enc3emUvaEpmRERMV3NpbVl2Z2hEY3ZVNTlY?=
 =?utf-8?B?RmtITzNnMjRpUytiaVRZdjZadld3eUk3c1RMc1dPdFFTQ0wxTElIdDZjanQ5?=
 =?utf-8?B?WkhsNEYvSjJXRmZkWFFZRWtIZ2FWUzh0dDA1bDF6TGl1YVV2V1lvTnVaSERU?=
 =?utf-8?B?SWFyYWFSYUVYdUs3aTdIQUxYS0ozR2o1T08vd21QdHhHZ2hzZFNrU0lUNWdq?=
 =?utf-8?B?TjkxS1UrU0xHenkrS0ZvYlRpWVE5clJlVkdSOElTcVZXN3EybGRtVlhXTlpH?=
 =?utf-8?B?MGl1T0ZlcXpEcldEWlhuSGY3TmNPL3g1NnlSY1JzY1grZzBNVkN1WXM3eHFr?=
 =?utf-8?B?MGZITHcwRmhtNHBFaEdLdnRUTmZCR1kyL1B0SmZEZERsTTQydU04UGl3WlNS?=
 =?utf-8?B?YUVQNTBxRlNUTVd2cEViQjNMYVFvR1VLMHpBM0NVUy95YXpRbWlKVWlRZUZr?=
 =?utf-8?Q?WbQ0=3D?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 396928f5-7222-4024-44d6-08dc28283f8c
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2024 22:00:51.0499
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KtcAVxe+Ut0D5Hh/T7eHEbdlxYjUH2nFOVw1i/tTGfXGr5hs1Ukm3cwAp4/kf/HSfDtl05xFCW12zHkJluzSVg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR04MB7789

Rename 'snps,host-vbus-glitches-quirk' to 'snps,host-vbus-glitches'.
Just describe the problem in the binding. So needn't 'quirk'. Software
implement is workaround, so keep variable name as
'host_vbus_glitches_quirk'.

Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/dwc3/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 3b68e8e45b8b9..2536b567efd56 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -1627,7 +1627,7 @@ static void dwc3_get_properties(struct dwc3 *dwc)
 				"snps,dis-split-quirk");
 
 	dwc->host_vbus_glitches_quirk = device_property_read_bool(dev,
-				"snps,host-vbus-glitches-quirk");
+				"snps,host-vbus-glitches");
 
 	dwc->lpm_nyet_threshold = lpm_nyet_threshold;
 	dwc->tx_de_emphasis = tx_de_emphasis;

-- 
2.34.1


