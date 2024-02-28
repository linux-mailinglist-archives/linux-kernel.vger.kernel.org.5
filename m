Return-Path: <linux-kernel+bounces-84920-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4254A86ADB9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 12:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 64E991C21B6B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 11:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E393A73510;
	Wed, 28 Feb 2024 11:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="sBO1d+lf"
Received: from EUR01-VE1-obe.outbound.protection.outlook.com (mail-ve1eur01on2084.outbound.protection.outlook.com [40.107.14.84])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5608214DFC4;
	Wed, 28 Feb 2024 11:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.14.84
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709119858; cv=fail; b=J4hVcBy7HU1+vrAGqJGyKdXuV4qCRrsCKdpK2TE2kN4JtTzmVTlRcmGOi/ud5fGO0vtK1rHENhxzqjOyIldx5zC+6n3GNsA05uOoEJ+6mvIm23bekHw6EZogRARFmMZ/uzAnfJh58ovVPFFLyckp9oVKrgEAVMJtLFES2Uo+STQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709119858; c=relaxed/simple;
	bh=xz0QeLukqPxV9VaxA+8Ag7ERmr6QmP673v2QKtUUya8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=jRiC9nFrnHqjM/fv+Xq1RhBptysxZyCEzsLw9lCAmOEULks4nnH6vKVtVRdGalVCdAuBdJAmBel0ZORqrvxgbDJ2DTm8pEb6nS5DkwfajuNJq/X8reEf2dAnZXKeQXl1mvkwKu3YHIgpeXC1iYCPbO233Pn3cshDQV1IvQzJ/4I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=sBO1d+lf; arc=fail smtp.client-ip=40.107.14.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fBCRdzCkWIsfnKz7Xgb8vdaqI3e581VBvxQxF01wnchs9e9hlf9I6J5GZIZ40uZmKPMpEk9MMDx9ymOyKn65GWmigrt+Ws4gNfT1lgZdGsjgXPm61RPYbhSiypLDT47FbYUcwSxELrItxjBcluBKW/QOACZjFfcqdlbYUed6rIYn4EJVEGRqVJGXR22GhGiik/2KLdhm5qhlqMQN5hBeKG14Cqku+d09vqDzn8hKmCNVP4Y0m+IVtLrG2Cwl6aZHk79lIMhZihNKLHQ5XFhkdowBRBVfeLPbSqgbKC+bbQbrx/0bToRDXbBpy1Mzang1+D0/ZnS7J+5QRhMFl4Bb4A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3sJlXZFlXP0lpDz4W//B4WqqI3SBrfXwgyudr8p17Oc=;
 b=ECJQK4l+cxTwT+r7ZAyxsNH93DML/667Dz6lZy4RVdbn+NzB7qo+50keIiRLFXRKTbYIjV/+dX2M1cPZSCc9k+ogM9+BNbrgWYaPWusfzjGn/yodcdqwGNMWIGU/UnVEhRe6/12jA9NuWvvfb2I7SJZY4kqY14MlvWJE4oSOLZ7CpYmbAaZv4EmwqB5pSFxV1hxYLWYLdlBJezjsF0zdhs03PS45b+hXrnDfrJBmg9R9/tnRj1zbWHldL/bfQTYSHWkqOdLfmY3BkOpheH3qY3ni4I/pKZeHhl4i56L/GwsOHl/vn6ecJW0rMEwiKG10UPg2MLaYSUjLCBAteWtj1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3sJlXZFlXP0lpDz4W//B4WqqI3SBrfXwgyudr8p17Oc=;
 b=sBO1d+lfTzg3L0wp1rWzP0XkTyZc2d92Zln3Pm//uqwPWGPALbwMNZtIA8BTxtHfgOhNnNyoFaxTL3IhiVenz8LuZWd4oWz4jOgRsv6XFKg88j4gmedogO6qtUQzpoFm0936jIimfUmlKA17cYdRUop1el/aEtffy6rWpfNTiDw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by AS8PR04MB8466.eurprd04.prod.outlook.com (2603:10a6:20b:349::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.39; Wed, 28 Feb
 2024 11:30:53 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%7]) with mapi id 15.20.7316.034; Wed, 28 Feb 2024
 11:30:53 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	shawnguo@kernel.org,
	conor+dt@kernel.org
Cc: s.hauer@pengutronix.de,
	kernel@pengutronix.de,
	festevam@gmail.com,
	linux-imx@nxp.com,
	peter.chen@kernel.org,
	xu.yang_2@nxp.com,
	jun.li@nxp.com,
	linux-usb@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 11/11] usb: chipidea: ci_hdrc_imx: align usb wakeup clock name with dt-bindings
Date: Wed, 28 Feb 2024 19:30:04 +0800
Message-Id: <20240228113004.918205-11-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240228113004.918205-1-xu.yang_2@nxp.com>
References: <20240228113004.918205-1-xu.yang_2@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR06CA0185.apcprd06.prod.outlook.com (2603:1096:4:1::17)
 To DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|AS8PR04MB8466:EE_
X-MS-Office365-Filtering-Correlation-Id: 749bd35c-5b48-4b2a-9003-08dc3850b92e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	9Yy4PQ8kcOUfnYtLn5D6xfZ5yKF94O8K4Aihou2cLFivlT3VUxXEIcvz23MkecSWTNzPpNBVtDNNjwKYUWTG9x/S/Oyxsjqar3VGalSV7DjVrsIXLBWhvbCnHx1tEdtdnT97/f5h7BvMF74/GD6VklG+FhMYwZTjegLpZSuLTTW8zKFox6+LvVCBo4a5z+U3Nx/QYAXeG1ET7+mqw5xNvZBn2BHJgKOr5BTmZwGMbeEXfaF6N+V96bjdOR/o2U5puR15vnD4XIJec2MaLcTXKwg2G9pLPmtAgfZqP4Hlq1eEJnEGlHcVtuNAVtx9pN4eObVgkdAx7kPlQ8jLihoa0+LNmnCjiD4i85W11fjwYV4bGPSDx3hGPrVbH6V9Da5dIlMSGpmCn17MdgHXHgW11LTnxxmEoVrX/RqvSSgY59hk41KJIuL5AzD68XldTDsSbiMq2mKtbOGd/UKpbH1TfpN2nUS33nYcMxHy5ovs14Lyv0RrDRKPleVm0n9rz4p4fPkQnpYgHhp/cv40BW1u/tC5oGfn/qYVVfpGBHFqB6qp77Ig5f34ZWs1DmF/O1fDhq3cutpawvoPzLRbD2MqEOX06YD5A7TD806dFGuHvxLRrNSYgZtrcPw3kGwKgI6dQypzLFDc4gngpgKFJgtWHPxYflY/iHpBK678WwsvwKLYqVaeIIeKPxHI7vaQ9hM2d6XnfklqHjkABIuJCBBvWbsKkp6F49JDoo/Lc1i6Zf0=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?0uAQe+hFy++KT0NG7tyJjCDcTxb44XHrq6BVq2eLcaOd8vnMDy8XlDYUHAjz?=
 =?us-ascii?Q?FKj6xQRKZ2nM1lvwzwaK9xFS+nOa9jfCDED7LETLdhgRRAKfJfZpIx5rqGwC?=
 =?us-ascii?Q?X54XuVZf2LgxCX3SRcJ9jHcgORgpWns/Hvopd5RKvSF0i2LQb4qDv+PKivE2?=
 =?us-ascii?Q?khclkJ6zvUT8enC/cmiDdzDCcqGGW8eIZ5B+rrrpFIDuqKRi5A30vd4N142L?=
 =?us-ascii?Q?uDaoooI3WonJ1lgFR+kZkuxjt9I74sa8/e+rbl+wZN479cdWqAOWOoU8Fz79?=
 =?us-ascii?Q?eflByndexHFzXpn04/Mo+jYGYaO76fSpJTVtrf76qxOFkQlRk3BElsn6u7Ah?=
 =?us-ascii?Q?StXkWuAJsu5c2iXNj5Q+rvlSuv1ZI3BH6Ja5P+RcI9qLfGv1gBI2/qSNA40o?=
 =?us-ascii?Q?FVLkAx61ubaYh2qlV5VfVdAWDvzBPULiKOKR3QCnFo223VDRjU96yMth3xTl?=
 =?us-ascii?Q?sdszjgw2g5YyATU2OcTUMpfZT0ERHuDbHQ+wEZm05URcqDzn8l+t8hiK2EDT?=
 =?us-ascii?Q?LY4anFfJodawrxqjRpbSqHuWVKYWfgHCLzurYC/Rmk2nqzGUwceOygzWvLSX?=
 =?us-ascii?Q?TNSZ7lPHpD3Qc1csHkp3T3Blhbnpy+6zhKbLz47L/CxwfUax3246b86eNGtJ?=
 =?us-ascii?Q?DUSHew9s+FHOfgpuxtEq+rnvGu7Fm3/UnL8fcnsQP5zoy1JOeQn0PEsbob+T?=
 =?us-ascii?Q?dab1NYEaoMWsPUCYSeEsWY+fWhHWCbQtuHidyBDYCCwjwbupS1sQN4vYirl8?=
 =?us-ascii?Q?7+NvDrt4yYYAVia7zGL8Fr7njo4/yx8C9ukfMBZWz4Pqc3YEpD2iI0dLx3EM?=
 =?us-ascii?Q?aEyoa0uOL1BxsUIDORRfWkq6zCMz7nnaycVKlBpbuAdo/BBVv2pJemxjCL00?=
 =?us-ascii?Q?swkcCUr3bcoY8XbYi9CgSOtfRF99r2w4S+NvLc8G5FiK2Kh5U03NRcmKPMH9?=
 =?us-ascii?Q?NpZ1v4NfLA2L7NhZ8K+jZg/BiCTXvtrcl/2vQN8SHUF9+gMB+tE/LuakMRoW?=
 =?us-ascii?Q?HP/5n77abKmXWdd7oPkfhQ/dUbJEiEjVCWLL83CFil2+JlkBp2mcCXZt/6Ak?=
 =?us-ascii?Q?mgyR7pxaM9rd5OZCn9YRXL8UJUKBefnOiyEUmZ3GGEUFA+fScQxBZpuB35+0?=
 =?us-ascii?Q?r/+hXg6v5X1wxmYkIUCyt5kWIGkt2ATGGqfEBWZudG845ie8yP4ksPzs+t89?=
 =?us-ascii?Q?l4V8D5dyhjEtfUsR1HANXm2Vr/mY2uEq2UMgZDyitjb8KeUTfNkpooXmkRiX?=
 =?us-ascii?Q?ZJ0AnjGGyaYgBKz5nLuGtcUO7JPJmIv7gQflp6PF3nknv6YhCpCSMe0S7JxR?=
 =?us-ascii?Q?fi/FuzIiMPQRNW1twktNc0mklW71f/ty8y50rgbck7hpn+AgcLDRdOAj1yvF?=
 =?us-ascii?Q?9avUckRjxi6GrIx76AkURK70edE28rCTyxap3VrjhV27AmmdayGFJo6fcf7r?=
 =?us-ascii?Q?K6zHVhF7TMp4IVGf7GPfgI9fCY/uxgjr0guLScGYlU2cQ/vL8J4WTWDhZ1yg?=
 =?us-ascii?Q?PSpb0/68l0vkV4QFQL7ss+bqFzWgfjbw3+Tg6UskCiRwbtcO9FQu1ePCqaHp?=
 =?us-ascii?Q?3cBhCmxMbNJvaB0bS+nLKobp+gxxLtk70LKE8Yvl?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 749bd35c-5b48-4b2a-9003-08dc3850b92e
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Feb 2024 11:30:53.8198
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2BpNHUS9eNxat69QlMssNBsfbmB+uee/ZL1zpUU2Fwd+U7f+TxDqprHvqbOjdNONcZnXKaPOddgD9xV4cVmXdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS8PR04MB8466

The dt-bindings is going to use "usb_wakeup" as wakup clock name. This will
align the change with dt-bindings.

Acked-by: Peter Chen <peter.chen@kernel.org>
Signed-off-by: Xu Yang <xu.yang_2@nxp.com>

---
Changes in v5:
 - new patch
Changes in v6:
 - add Acked-by tag
Changes in v7:
 - new patch
---
 drivers/usb/chipidea/ci_hdrc_imx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/chipidea/ci_hdrc_imx.c b/drivers/usb/chipidea/ci_hdrc_imx.c
index ae9a6a17ec6e..a17b6d619305 100644
--- a/drivers/usb/chipidea/ci_hdrc_imx.c
+++ b/drivers/usb/chipidea/ci_hdrc_imx.c
@@ -212,7 +212,7 @@ static int imx_get_clks(struct device *dev)
 		/* Get wakeup clock. Not all of the platforms need to
 		 * handle this clock. So make it optional.
 		 */
-		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup_clk");
+		data->clk_wakeup = devm_clk_get_optional(dev, "usb_wakeup");
 		if (IS_ERR(data->clk_wakeup))
 			ret = dev_err_probe(dev, PTR_ERR(data->clk_wakeup),
 					"Failed to get wakeup clk\n");
-- 
2.34.1


