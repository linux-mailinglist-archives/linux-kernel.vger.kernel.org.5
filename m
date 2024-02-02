Return-Path: <linux-kernel+bounces-50041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A86BD84738F
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 16:43:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD20C1C23AF1
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 15:42:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882561474B7;
	Fri,  2 Feb 2024 15:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="HP6SsjWa"
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2047.outbound.protection.outlook.com [40.107.13.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12FA1468F9;
	Fri,  2 Feb 2024 15:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.13.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706888562; cv=fail; b=rP7KIRCccKTD1nxzk3wKGhY5t25N11yWL6U1Qpo+7fwL38TRVLVqEmuSow21ov71XOWVo9Kgbnm3DEmzrpCiPWFdPJQ63AXkMWGvehOXEvaNDZVFzKww0BRhfC4BbfqlIPquWaqeZoA+vREZrDXy0f9m1CR18FDd20Fs/FFaxx8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706888562; c=relaxed/simple;
	bh=0Gnm79Y5y/ZgtdMkZrkSs78F/+iANLNaJtyM8bEIzjM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ouW6s4Hj3E9OUkesDaFZi3nbdh2xTsfbGMtbfXu9msCNaMhlwC3HEnvOmAUddLhhZjhpGJ4ThNWBv3ZqQHrX6AX3U9O+AkrDayyOo8h7JA58hXuGFC0RIy+/cNb3lp7BTgydwmucRx2Fl7Q0hw7GKd1Sqb+T4So98pZ5f+JDQ2k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=HP6SsjWa; arc=fail smtp.client-ip=40.107.13.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M2jrD+eN/gq0HL81j0FKQo19dRxHkcxBHpeXCMEW3EtmEYx4QoXodhFCOYv/E3XpBJz2BkldAlZ0auTzcfC6RI4137tP1FhNt0xA5ShKUgbXmxEmEqkEZceDDsl8xlDRzrpqH2ukapNPU3Ohc+NlOGW2he6hGeEYEdJwXvzvvht0HfTpbSJVHLNPUU4/LL0kYEhcUWNzXqcN6DrX/jNgpROzEVSlU/DMFQb3TWmFSILz6SVI6pMR5HJ+oTfAohMmViXn3uylE5egPVdu3OtwOrSN9gA/d2D242EyMb/8cA3pkaqcj4dO703FHDWOo9FysOMYbWo6lYbDHjAFbdbd0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HkYv4xu25IP9RUEGBzlsy0h7FYv3OvD0/xtAdObJPcQ=;
 b=Rb0gqYspVoil1aDuae5CtSzpVF5qh4dsT2nvaCqlAwVfsxYLeWRj/Q2bspC3OMcqok4gpeyh8x7mY+n5nxysP+zTYTEp5JoMw/NcMYweeKo/T385v8PfrOXvIHU0vkHSF9kPuYni7pbLUxBe7LkH4WFXbiJqUEnBHVlZQp5Qz7vcV2j3798eyP/u0xrxlU4EMNRErwvRyBaPgTMhw4nCOmXELVLU/8gjbnElOt3xUAm5iwA84NyyPhIKOztvTUN/M98vnPGps5yj003XuX4MlnCmnevADRtbTyx/2zHBudTZoJyi1DtzHtCZKaABGFOAd/upuPOYr2BTWf7sx6RHkQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HkYv4xu25IP9RUEGBzlsy0h7FYv3OvD0/xtAdObJPcQ=;
 b=HP6SsjWat7ORx2SMXOPcikgC6z97nZx6Yl697CrchTDrDYfMNKhtT6DKzxzOoSLeg4c1XF9DX3/BolY1WK8QauxyOYuofI1cg/Ne8DhpWgLJS8PrFZJf4ayM1y80n4DYQCY2Vzp3g3wo8DqK8QfZ/YU+6MjSrckZdPCff3hAYgo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by DU2PR04MB8502.eurprd04.prod.outlook.com (2603:10a6:10:2d1::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.30; Fri, 2 Feb
 2024 15:42:37 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 15:42:37 +0000
From: Frank Li <Frank.Li@nxp.com>
To: rogerq@kernel.org
Cc: Frank.Li@nxp.com,
	felipe.balbi@linux.intel.com,
	gregkh@linuxfoundation.org,
	imx@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	pawell@cadence.com,
	peter.chen@kernel.org
Subject: [PATCH v2 1/2] usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
Date: Fri,  2 Feb 2024 10:42:16 -0500
Message-Id: <20240202154217.661867-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SJ0PR03CA0114.namprd03.prod.outlook.com
 (2603:10b6:a03:333::29) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|DU2PR04MB8502:EE_
X-MS-Office365-Filtering-Correlation-Id: 1ab15353-dff4-43e3-4aa6-08dc240594f1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sKdHNVIKEqPJGLXJqMR5pB4OAZ0xClesHd1tOCJvyTCRs+YiFRydZGBrE6YX8sdWZWTaWfWmnnsKourChFbtUB69TMCBQ3cs7eTw/10nDkjB9Xo/a57GbWTF5EAssIQb23R6LfStjub1tkSL99YDC626aJZaSyvm7xk3ccZb3nqDR3HKlmmzA7Y/A+i4Ny9cEmHCx0YlT8G1LNaNoSOkZNeYabz0eFrEhg3Qxt7GZNPTrquCEWWn8WNimXWNMCU+sn2QDgCxtdk8fhA0hk3l1gzc39yOc7l+puC4AHM6WTrCJ84v0FKRsoXEOl8HXQkXQbOLpMdV8IiPdoGb51UmOxpjar1YnkhM7yn1D+EOvhhwGEDPe9g9LZlKpOYkAq9Werv1FRy/1vL3ZehI/O0dD6fZ5VMK7YOSEn+vbuljqk8PCs9ShaxMS1QfgyiJzW5h4acDKh7dcJw3xPGBlvgRXMSa5R3wa5HRf5f5xqqZ4lKZn3C4KFkufpunjFwCi7OuYXFHZcjlhREVW2NTKYdBAkRIBGkcU0gv5UMhgf73JwWesLIv7QDRuKsQxAvdJcdBdsiz5FDAjovI4IXR79HvBTDrvxnTbKL7lu/2opxi9LQgPUm8fsOA3IsCuS3zQ7wx
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(346002)(366004)(376002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(38100700002)(52116002)(6506007)(83380400001)(2616005)(6512007)(5660300002)(86362001)(2906002)(38350700005)(8676002)(6916009)(36756003)(316002)(8936002)(4326008)(6666004)(66476007)(66556008)(66946007)(1076003)(41300700001)(6486002)(26005)(478600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?BgYNxMumC3thFlnLjZiA2vbhC82KTtwmADix47vlaS54q5y9gA9LxzZs9jYF?=
 =?us-ascii?Q?bK8yShIOM2MiHElHN9p82SQjz24e9zxGoqfmZ4YcR6cZ0QqzGKSdk+fxKP9F?=
 =?us-ascii?Q?CoJNXahHLcHFfC2RXGPVvj3anT/6Hmn9QcA43YJ2ledi4Aa6emTpObiVFQ9i?=
 =?us-ascii?Q?MvfYeaafSHeJeKtmdfZbU1lIhxkPqpZqhcoTDki4duw53xMTzcPn0X4/phuO?=
 =?us-ascii?Q?qAaQCnZCO5PAFScoY/EeVJAXwpAJC2yJYhngw5Qtl396Fa2PBkRMYCaNJdcn?=
 =?us-ascii?Q?+Fcv8uZn1dPR+91BnnBdBnCL8g/DjdgwMbUL+xEdRyZcWe/FU2vvEwPcSsdt?=
 =?us-ascii?Q?V2ylKlhk5QXbULIkzjJwJK5qNXvwm9LW18PVdera24f+f6Dmul39i9h07zfQ?=
 =?us-ascii?Q?dfgfiRcQ6OUCdaO7bAdzdUG/xDRT8X6zwt0sGG07olypjqA+URfqtf2rBNG7?=
 =?us-ascii?Q?nLVThKC0DYG29+f3UAncU+r6GEVCIWesGwxcO0ENkITx79K3TyiWBVAmbBs4?=
 =?us-ascii?Q?7ezOXNzrS5hi1/wVPt1QDJfBc6xsusP8aGAE/R/wH77czAlndh9UeuqFXXMM?=
 =?us-ascii?Q?hthP7DqznPTgV2+A2ibQrBUQyp0ObhQCqGQteu8lOFoBsqVrtHnhzZ/UgClX?=
 =?us-ascii?Q?7ix4QfYFZ8BUBCy65d4n6tWvGQ50FbNhSzz1zlfT4FadOjfvgt6PASKNLSRF?=
 =?us-ascii?Q?rZ1/4j8d4r00meBYX6xBnKzgWeSTEmy1kaDqZPqAAVo8AFMJoKrSxQgCfR5l?=
 =?us-ascii?Q?wuHBrHE9uWoLiOKw8oP2JqqeUWLCy9WgaqVKRheNF1Lza/924/+Ydfgl2HtP?=
 =?us-ascii?Q?bL1bXsnqDbEmes/8LUN8aNyeSLxu4H0Wk8k+KQnImQJ0FL+OXe6tgkSjypyX?=
 =?us-ascii?Q?vTQky9NiahX0LzwWegzJhBLaOQvqvd8A67h0wXR0rgyebQLxD3xwx5bCZk9y?=
 =?us-ascii?Q?+dADbBUXnAvF7WN0KSrr/XT3RmLZi2gUg1FXH8WxuxDLbwL3ow3itZEyWWwK?=
 =?us-ascii?Q?aLwXswpxMxomX+DpyfBpCHusrvDHilgAMK0QRaJYKJgf4+LPgG1N8J+Cc2EX?=
 =?us-ascii?Q?BVK6pVxYXX1F54bl6OqYunqTq60qBb0mHXSkvH/DTManHew04HpJLK/T06RD?=
 =?us-ascii?Q?KNR/fHwfZd6csMrRV4TyWtmm7O7dPgwVnK+9mpqiTaAFGhzZ7oAujc4kEXkd?=
 =?us-ascii?Q?mwnXfZxG7fuKiPgIorT4kb2lFyzUzXleiWwmY60PKC8oCAV0pMivVqg+sHjp?=
 =?us-ascii?Q?oU4TQy3rtifOeeVc6g0BlSAbT3NJpeUE/lvSzcNuL9uyKPYToreohapx4UEg?=
 =?us-ascii?Q?JQQSkDssVFj2+QtwAEjKSMoB50Fu2fPPUQNUmgCZjoA/B7eIqsnzBbYIvvxB?=
 =?us-ascii?Q?K+P2W379aFLMoBhntW1N9LaiW/KCWQ1iefKBdfvbRKyd9/kTc7CfFNafu8e3?=
 =?us-ascii?Q?6XjiDOOBEchXvy+iXvN8eYV1Qh/9MrvjzKebKrrq2JvMfFTiIPQ2MwDDXQUl?=
 =?us-ascii?Q?VhZnJs3IDbE1kJBzSR0hH9WhAaLSDLH9zXA+oM+ZBg0l+MSgazcwDeyXu0bb?=
 =?us-ascii?Q?+KCLT7L/TUiQlqUE+HB1OCimLOr1g08J4vTap35o?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1ab15353-dff4-43e3-4aa6-08dc240594f1
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 15:42:37.3280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 91+ayK2r+fbGc5ZeX1oHrfy5T03jdx8isNrfyzPVhhd73ZjwwZNd2/2TgdTCo9RRa/PYhuhIvO6U+9q5rT4XUw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU2PR04MB8502

  ...
  cdns3_gadget_ep_free_request(&priv_ep->endpoint, &priv_req->request);
  list_del_init(&priv_req->list);
  ...

'priv_req' actually free at cdns3_gadget_ep_free_request(). But
list_del_init() use priv_req->list after it.

[ 1542.642868][  T534] BUG: KFENCE: use-after-free read in __list_del_entry_valid+0x10/0xd4
[ 1542.642868][  T534]
[ 1542.653162][  T534] Use-after-free read at 0x000000009ed0ba99 (in kfence-#3):
[ 1542.660311][  T534]  __list_del_entry_valid+0x10/0xd4
[ 1542.665375][  T534]  cdns3_gadget_ep_disable+0x1f8/0x388 [cdns3]
[ 1542.671571][  T534]  usb_ep_disable+0x44/0xe4
[ 1542.675948][  T534]  ffs_func_eps_disable+0x64/0xc8
[ 1542.680839][  T534]  ffs_func_set_alt+0x74/0x368
[ 1542.685478][  T534]  ffs_func_disable+0x18/0x28

Move list_del_init() before cdns3_gadget_ep_free_request() to resolve this
problem.

Cc: <stable@vger.kernel.org>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
Reviewed-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/usb/cdns3/cdns3-gadget.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index aeca902ab6cc4..d6723d31fc6e2 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -2540,11 +2540,11 @@ static int cdns3_gadget_ep_disable(struct usb_ep *ep)
 
 	while (!list_empty(&priv_ep->wa2_descmiss_req_list)) {
 		priv_req = cdns3_next_priv_request(&priv_ep->wa2_descmiss_req_list);
+		list_del_init(&priv_req->list);
 
 		kfree(priv_req->request.buf);
 		cdns3_gadget_ep_free_request(&priv_ep->endpoint,
 					     &priv_req->request);
-		list_del_init(&priv_req->list);
 		--priv_ep->wa2_counter;
 	}
 
-- 
2.34.1


