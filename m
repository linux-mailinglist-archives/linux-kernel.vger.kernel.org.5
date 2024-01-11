Return-Path: <linux-kernel+bounces-23682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC8782AFFD
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0390128CEC9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 13:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C8493A8E0;
	Thu, 11 Jan 2024 13:54:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=digi.com header.i=@digi.com header.b="gWIJvFaW"
Received: from outbound-ip8b.ess.barracuda.com (outbound-ip8b.ess.barracuda.com [209.222.82.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C288632C8E;
	Thu, 11 Jan 2024 13:54:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=digi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=digi.com
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02lp2041.outbound.protection.outlook.com [104.47.51.41]) by mx-outbound19-164.us-east-2b.ess.aws.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO); Thu, 11 Jan 2024 13:54:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=acgzGNmoHGwznGVpfoRFfIec8tskCj+rLXsFwvMGSrGo4cfrMPzkghfw1Uwm/soj7oBEjebxUsAP+jaX2qvoOzrhGOUoFuTEB6d22Xv1D5nl/8lw9wqOI7xzpIgRn+q2xG57hHIpnsHY9ICbuAejmBfxNUAwr459v7dEgrzv36yx0Ga2w7p66ANKY291HOva3WZ7jSofP7frVichq49Y7kwknyZFFgUldEWrKavYQg9BJjGfL2iMoCgVsejGAG8/MVN1gPciCxqNpTNPnfc3au5tuz+f8XNP2gqBClH4DbvkGiOhedwdoO5LHQXuLC9dOY7+qDV8hAfmc/uJRyQAZw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ytXwdq6j34zH6QBk3UXziaEa1jT5YDWCzXUzfWgX/7I=;
 b=b8k9CNUd4L9oF6grdHDjJKk9OpHuxMxn+c7FGpjSWBQANPvukA6uhmdsIduooQUTulDmveS9kBeAgFV2afV9ljNnKLDer/tQDPmk4lpV+u9pVqATUVbYgjMmD/GXla2ug3v1OJ2mUbXu/FPe94IPieC8K+DrGJ1yFzNWclUPZ1QHcIPhAt4WDNpTN6jfoiQAY3idSd0j++r29YFG74n8YsKTKCTrLkpZJ4C8TOWxMXseKYwsKqOCsog1UMOwbcvCbcuh6gO69M31hl455XCoTLDVwmg+xnZecxlk6Vy6XY9tscZMp6wKfOd1EKWbUr04HBDT0J3UIdhMF13Gfae+AQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=digi.com; dmarc=pass action=none header.from=digi.com;
 dkim=pass header.d=digi.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=digi.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ytXwdq6j34zH6QBk3UXziaEa1jT5YDWCzXUzfWgX/7I=;
 b=gWIJvFaWthru9mMr/8E9vM8h7lXIc0gbyGtqAEtdFC0t+XazqCnAcGHuZdyY3x7CeaiET2Ktn/8yk1RFccQAG4uNTYFUmPYe9RalfzDywAT0Lh27oUclXXZBztX5Dh9W+Yv106kTJRR1YFQ0+3Ch4LlbBubRqyyhzfEZAQESthwP7XDoBpcT2jSNd31voRevmrd/ftOdqXr6XYA2BQtzjlEzZzhPdGNmMFQjtHCyXojWqzrjumcqN8JFcXNYTV4dQmmRd2qlmxMX5e9eR/rU9r7TASERtQuwMsjCupd132r8DUnWnKMThoBRLAevoqST/gE9ClN0BqU6YX0GK3+M0w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=digi.com;
Received: from BY5PR10MB4370.namprd10.prod.outlook.com (2603:10b6:a03:20b::19)
 by CH0PR10MB5355.namprd10.prod.outlook.com (2603:10b6:610:c8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.19; Thu, 11 Jan
 2024 13:19:40 +0000
Received: from BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7]) by BY5PR10MB4370.namprd10.prod.outlook.com
 ([fe80::283b:b934:7a82:c8c7%7]) with mapi id 15.20.7181.020; Thu, 11 Jan 2024
 13:19:40 +0000
From: Hector Palacios <hector.palacios@digi.com>
To: bartosz.golaszewski@linaro.org,
	linus.walleij@linaro.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	haibo.chen@nxp.com,
	peng.fan@nxp.com,
	hector.palacios@digi.com
Subject: [PATCH 1/2] gpio: vf610: add support to DT 'ngpios' property
Date: Thu, 11 Jan 2024 14:19:03 +0100
Message-Id: <20240111131904.1491496-2-hector.palacios@digi.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240111131904.1491496-1-hector.palacios@digi.com>
References: <20240111131904.1491496-1-hector.palacios@digi.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: VI1PR07CA0231.eurprd07.prod.outlook.com
 (2603:10a6:802:58::34) To BY5PR10MB4370.namprd10.prod.outlook.com
 (2603:10b6:a03:20b::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY5PR10MB4370:EE_|CH0PR10MB5355:EE_
X-MS-Office365-Filtering-Correlation-Id: 4510830b-d942-4439-ce54-08dc12a7f77f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	N5WIUhFg7EFK/LQoSkNEoQ7VKYVKkevLkCehc3Mn9BU8pgDWN6RHoAH8M0Y9SXnVAbP7drl/WQNNX1Gc0Kg/n+ab/84gc19lhCQt/4F60/BGLK3BQZQ13rNBoLORDh1NpwvKjUstkN/TuQYCD2AXFf0mSNMJWElhuT03TrkL71Ib7nscZQUqkPN2FFxRiL1rp755ytyE9KYHSTOAiswYGaYaTGDNZZ+YYglUVWCIhSD8eAmr788hw8V7cNkVMl/sviBf0qglZDFQMUJV8i397b+q8Vbmui+qDr/Esr43M1DIpOHOa4Z3weBDVTT//r/+T5OFus7zVoWfTbi3mTtfDiaedcOsTL+A3dfFecFHb+WRTeIWtsRgwgQrTzXFzI3BEikHrv2aNKCfVrMGGaMr6ziFjn9MYzhZkbxXDJg1QcsdA7H5dWaFk4/PYO4wxbEPMKSO825Godx3MhCjcrTTfx7rmZm12dIuUyop7gL6grOtaw6xt83bMdAm6TEdCVWtk37udCQPbSxerJtLlGd1+Uto01MaV8DbKEGc24S/YfUsyKCKMhFEfDINYD2s/3txZx9O8XKvnEyF8RVfrXb6gyuiDU5LodJ3VEemsS+LDEEvGDy0kn8O+tW56hpQyu5N
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR10MB4370.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39850400004)(136003)(396003)(346002)(366004)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(4326008)(8676002)(38100700002)(316002)(52116002)(5660300002)(6506007)(6512007)(2906002)(6666004)(8936002)(66556008)(66476007)(66946007)(107886003)(26005)(44832011)(478600001)(6486002)(1076003)(2616005)(83380400001)(41300700001)(36756003)(86362001)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?DkZAal0oln8TaJRlfYB7gxSiFNsa49cqgHg3S8mJHOrBtUVvAqmqj848eNkO?=
 =?us-ascii?Q?trUxwyA1XXpIQvAEIt8aGl2d/OsnqoO9LXAyEfHKCsFZiNXiuy/Z9yVuvqD+?=
 =?us-ascii?Q?u9IiWNHPQcUc/WLDtQRjUl3QN462pa8viGvvoGvpD8xBlQiefemBCxiOjkcm?=
 =?us-ascii?Q?uuznrL4WGU7o/l/tUPhpOlJHoF5pki7KEuxcvSbuCidT8hBvZP1z/h0OsAAz?=
 =?us-ascii?Q?VhGDpLaLMxi/0emM0TPjlRFD4eNB2NuY6LuC2R0SrTlyjyVjxogzENMzi4tv?=
 =?us-ascii?Q?CsE8VieEjDqJ3xGywl/jiruSzRJ0QwFbYuHS2yegpSaiP3La8xhMJSuUOJaQ?=
 =?us-ascii?Q?rvS03Bz79hnqxr8LlsrblF1w52QnbL/XR3urWWwaFsGALXRotILcFLN5q1Hd?=
 =?us-ascii?Q?JTaJpiDh7PY8pQ1ikdFj/Y0aDgnw1Ob5yU2GqQjz/RLBEE4pVlFIXg/2fiBx?=
 =?us-ascii?Q?mXoHVZaEfXqa+LKzExBI+kcthdlPodcMyAuf8TvJPJczrSgeBrF8IV+Sw1qV?=
 =?us-ascii?Q?2n/ulrsVSKLKcAiXTKlwxiwjW8AY4CQOgc/p7fWZKjpwtumS6MMnOYa1Afid?=
 =?us-ascii?Q?eIuRsDRR22UlERTfXRvoc/QmWQZckXrDsegfUVpg/panFnL/P4SI7L6h/Uwb?=
 =?us-ascii?Q?NqDxizQY/21bVXBWda75B3UjPGHw3eyjAQAW/FUTXJBxNDVAeemWu4qYNf5X?=
 =?us-ascii?Q?xRzAFgGHiCB2GRMnA5tQKoQ6jNYyLkjPFajAbEXA8XOzvf+KshdvwVFnk0WB?=
 =?us-ascii?Q?7mmLz4d51u0kGMcgBZtUsYGN7+YD/VGUFVSmoD2bQ7i10U7HrosPmAkZWRIX?=
 =?us-ascii?Q?pLYCToHXzvWNG2Gw+gfGJtRq3MHd07Sv8svedVrCfGV1iCSNcZpHu6SO4FqO?=
 =?us-ascii?Q?AMDUbGsYrMQA1xohpiprN1qj/OWoR4l90MO3WUwhsRJteHH8nIxUOxo5OvOf?=
 =?us-ascii?Q?yJT6eqQq10B1srtx2wHiESY2y5UdZevCR6WLx274wK2E2pX6mGZ4yJIhA+TD?=
 =?us-ascii?Q?0lVjUjnelYzU1SxdkDFK2kjRDFcZ24Emkwp6oyiWiQwKYyfKcP/mnfV13aTD?=
 =?us-ascii?Q?SFsr9FsJV6kuloOgpuRnoccEqlH8Obslgbtwk07+Ggv2ov6FCFzDaqFhHk8r?=
 =?us-ascii?Q?moNcn+hpojleLDGHjV/e1GI+ethiwxI10N/3YusPQ2wlu7MUC8ac30UrYENB?=
 =?us-ascii?Q?q/ZsbIGKpNn7bcu2PCjeobU7TJqf5Kqe5RvOPdyT6xfk2rM8qSknNTgCXq/8?=
 =?us-ascii?Q?GAELpvW2AX2cWOFEDwt9CA8TL5AjdVBwNohaqXoXOkkYQhq/xEDmsITD/e8/?=
 =?us-ascii?Q?mGoE5mjjrvA+aMDjEFOngoTA8ZkMCUvB7K8421sd0qxk2dLyE5/XZXK57ayA?=
 =?us-ascii?Q?6T8k7/66AI4BaBaN9RTzhGUeVAiQUxNXgi2ZlSudSt73wyKY+PBeAFMR4+kX?=
 =?us-ascii?Q?+DbObHH69xEbUuQlTh0o9e4zz0WaR2kw1oz+KMRAKg8kzV0jeWPqag/46i2E?=
 =?us-ascii?Q?MaXOfDI73ZI1oC3X6Tg6T7vCMyPppWBuTJ9IB5ErAuU8w4XM2ltq/Kfbqsw0?=
 =?us-ascii?Q?30Gh7e6ZMz0VsSxwTyr2rZKfRc3ddyQ3V9fkDXo+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4510830b-d942-4439-ce54-08dc12a7f77f
X-MS-Exchange-CrossTenant-AuthSource: BY5PR10MB4370.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Jan 2024 13:19:40.4329
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: abb4cdb7-1b7e-483e-a143-7ebfd1184b9e
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: um9Bhtgixe06x+NL2K7iVAA4u0/M8lZt/kD+TMzO1h/BUcsMfaFLvRmdVC7B+prYmQM+d/eSE5WUo+J7muv2xg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5355
X-OriginatorOrg: digi.com
X-BESS-ID: 1704981240-105028-12495-8663-1
X-BESS-VER: 2019.1_20240103.1634
X-BESS-Apparent-Source-IP: 104.47.51.41
X-BESS-Parts: H4sIAAAAAAACA4uuVkqtKFGyUioBkjpK+cVKVoYGFmZAVgZQMM3YODk1NcnYwM
	wiNSUp1TTN0jjRzDg5JSnZ0jLJMsVEqTYWALr1oFBBAAAA
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.253449 [from 
	cloudscan11-235.us-east-2a.ess.aws.cudaops.com]
	Rule breakdown below
	 pts rule name              description
	---- ---------------------- --------------------------------
	0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS112744 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status:1

Default to hardcoded VF610_GPIO_PER_PORT (32 pins) but allow optional
generic 'ngpios' property to be specified from the device tree.

Signed-off-by: Hector Palacios <hector.palacios@digi.com>
---
 drivers/gpio/gpio-vf610.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 07e5e6323e86..4abdf75e9a0a 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -276,6 +276,7 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	struct vf610_gpio_port *port;
 	struct gpio_chip *gc;
 	struct gpio_irq_chip *girq;
+	u32 ngpios;
 	int i;
 	int ret;
 	bool dual_base;
@@ -353,7 +354,11 @@ static int vf610_gpio_probe(struct platform_device *pdev)
 	gc = &port->gc;
 	gc->parent = dev;
 	gc->label = dev_name(dev);
-	gc->ngpio = VF610_GPIO_PER_PORT;
+	ret = device_property_read_u32(dev, "ngpios", &ngpios);
+	if (ret || ngpios > VF610_GPIO_PER_PORT)
+		gc->ngpio = VF610_GPIO_PER_PORT;
+	else
+		gc->ngpio = (u16)ngpios;
 	gc->base = -1;
 
 	gc->request = gpiochip_generic_request;

