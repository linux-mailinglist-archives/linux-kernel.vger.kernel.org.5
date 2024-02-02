Return-Path: <linux-kernel+bounces-49232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CEBFF84677B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:19:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 449D01F26B4D
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:19:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77FB317596;
	Fri,  2 Feb 2024 05:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="UyuNC/yT"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC0221754C;
	Fri,  2 Feb 2024 05:18:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706851134; cv=fail; b=E05qFK9X9ci/JQ0kZa2PcgPDNsLS3+mZWZ6ZsTo/RZyJyyaouj6y7eN7TqetYDiqMc9dY92Etn0iBtB7fMCeYXjfsNS5sNgGOv50rsGan/wTBvJMtuqNjJSKZTugGWGycUkwLXA54PjkOl9AuQs/PsLWmZ4t3TY2Flpdhr2Rhog=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706851134; c=relaxed/simple;
	bh=lsk/iVFsP9nlmr7jHiv2i49qnNPXmbJmJhEOzGjLckY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=awzj9WAdhtEjqpOrEAkvGhmmoGqwpPeLXHNQThBRf64L1vNFBHoDCDgY1mvZIj3sAA0cSGn2s/NG0rWoBzhvD5g1IMLfbczN6TO8vesO/9SEJw9N8dkT5IZ2C6l8pFItDRRXgHlY3uHd9slH1ymxWfPF+Y8KjBGmqnjiPvREewg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=UyuNC/yT; arc=fail smtp.client-ip=40.107.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gR4SED6hXIAyh6+f0FuF1UkiiCzEGlEhUq/+pNt1ZgOdLE/uhHj3KHtbm/9o/es5zaw1yyqQJ3HHypDn+lkmpBRCcCfj5FeWgGaW0stOCLngE0CE7W6Gdijljn2ce2vP5+CsmW3nlcNpcq1uD+51PiqU3+YwBWdzJ+gv+d+x0Rc9nKdBgBrRhHULtvxHcGAQA0jkqK7f24UVJhcnPkzVBGyqln58R2l2Z4C15ieSfHzjcfUo50JjGIzg1mk/PImWIED6uEOZ9AHFI9ODQNxefImLb0VoCPaiNF5jUpWcV1nFb9UyavGRSj9D9Vh7kCvfNtoYki8ZQFBaJr2GUvYTKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3NJIn2VbuszeDtrqGFo1tgAtJhNFZHjI0jcBiXg0rYY=;
 b=FkUdcX4RpixmycmqJQ9DjNT4TYoI/Zx2WVD6c0/t9v+eg68EcU0stmZoFysx0w/U4xCFZs7oiu4IV58gtFdGRpBa0ZCNEEdZtkJfEZugRKPuilAq+nYK4wK05OkaduIXQiyZ7AYwq4BYhf5iPgBZEod94M+WQJ11jHppmchnS9GwR5do4KpNLhMxaBJgrWEnb2H5nfn1p0XgXoigAELcpioSj0CTgjgHI3TVxzEtcEaJj6/4p45by9F9eUP6Y23XVpD1Eu7j3TDv3qHTgorQFLwKAocRASAT9b15WehseqwOR+mvpZoRtNOR7cSywpExc6vmEu/mAlW+xu3uVxFGZw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3NJIn2VbuszeDtrqGFo1tgAtJhNFZHjI0jcBiXg0rYY=;
 b=UyuNC/yTNrHkOmS9bDPAuvl0gtNsoH776ndk6q9vu1YMOXecpOryYB1AlgQoS3oEvwHAFHkBNVn/f/g+UWI4zy986ESIsfjIuKcLIT9qTYIwMgt8Zjlc2Z85KWJkGz5flDxFxBd+qLTFsT7ETmqxUR5rYTZlrl3pgpwtRmDgAy0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9996.eurprd04.prod.outlook.com (2603:10a6:150:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 05:18:49 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 05:18:49 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 2/2] usb: cdns3: fix memory double free when handle zero package
Date: Fri,  2 Feb 2024 00:18:29 -0500
Message-Id: <20240202051829.623273-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240202051829.623273-1-Frank.Li@nxp.com>
References: <20240202051829.623273-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR01CA0014.prod.exchangelabs.com (2603:10b6:a02:80::27)
 To PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|GVXPR04MB9996:EE_
X-MS-Office365-Filtering-Correlation-Id: 376e8b67-5392-4962-7604-08dc23ae706a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	La23VpTt84hSfsl2fkZ0LrxP2Y2PpjFVFi8MdU0aTAILtxige3PcU/E5OZ/P0VkzM+dtpwF0jztXsIXL1ux5LC8XEpO5kqp+S8DwHOTE3ojLzjSVFfHDs8ud/LlJ/xqeGztp9qB81TigFm9iV6Hb8ysStC+YQf+cdE2qODA0XXJffPgTsRX2tUHxSbG1sedtcejMc4WgajwDlTzZgvk3K3FAmbBJvmKkD3R6WaRbPPn1JF1d+iDKPDma64zAcPPbAw/BYxFf4FrfWBJECtbgzQU/EFn10OILpwUm0dzt3aun17LJu+AlvHtL02vU5XxXr3UUswBGuGgJpe/6NrwM26ai9AcYGf/fh11FCa2nXRg7e/USQNX4J4UszTUVp2od2HX1tsctNNfYTdRljnjVxixek0IyIaQVkSoIPLzCNFRxJYMjiatNEL03YKtk0wqFGIsKTKTEGQ5cupAshBWniLWKG0mMfNFNTZURcWtyrO+gbzXWakfootDne1ahVnrQ8tIDbEXPXLuaoNBoEuFtJw0QIf41Mzmh+pNu6fS90rs57iyREqrPrUnLW0Ud5L9vGPbLT3zmsdr3C5ixboyh3nEB+FV56s/oMSEGyfRnlKOtXcE5pCNFbU1zBxDlg5Py
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66556008)(2906002)(5660300002)(86362001)(38100700002)(6486002)(478600001)(36756003)(2616005)(83380400001)(52116002)(1076003)(6506007)(6512007)(38350700005)(26005)(41300700001)(6666004)(316002)(8936002)(8676002)(4326008)(66946007)(110136005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?46CsLKynPyvzVsCuK6wglCArFbeXaUIQwiZXdo6oGrDF07SvGdLUmweWt120?=
 =?us-ascii?Q?aIAbavVawYuUQmJo2JM2vggVwTTq38wBY8JiB//hvxX84Kvk4YCqMu7tdzJb?=
 =?us-ascii?Q?LQT8aO89RCx/D2SwtMp2SjRk43VL6HFFffeLFhE4a7RrFzSEuxVAi30AEx5m?=
 =?us-ascii?Q?LWXjGzBdUV4E8jUOcdA2MRINAA6cgGRXtogwPidUAp/BCIA2DfXthArhrktP?=
 =?us-ascii?Q?qqGbsYsqmQ6yrJtqsBvwfENHWaxomow2d0mH736rNceROKaPkqNMk+Dc9lkW?=
 =?us-ascii?Q?x6Y5CzBadyImduN/3EP7rJ9nO8TfwFUU5RldYD1j4qKcNx4EdXCcSUapHxya?=
 =?us-ascii?Q?FWNycQ+UN2C1wv6bs3AZoGUrJX7Q2rG/p2HGwDbSk2mP//ydk6DWdabp3LOu?=
 =?us-ascii?Q?tm0K+WjCUmhvwwJ6k2yAxfpkq123OsLUW8EsQupooT4n7+LEPyaREMdi65vu?=
 =?us-ascii?Q?aF8eSFwX0h9Q70xEsaWL3SUmHjrzNUgj1spNf6rJVLTpFlTrsgE93QNdiOr6?=
 =?us-ascii?Q?E4rcdPfhBzJSKDyfiax9o4JcTpNruJK+f1jfNLsozddRpFe7xAKqn9WDNotZ?=
 =?us-ascii?Q?cLj/8QqzB7V5MYVnmHR7vftn/x9+EvJmD5EZtFFknsTuy0hvHFJ/eIJe1mdJ?=
 =?us-ascii?Q?fgM1vaR+geKEKEc7nBskq61O07PQKyUP4pgpbnJRyCwgylmo1UlHnoZLQcEF?=
 =?us-ascii?Q?Ph0iWLB4swwgqgblY23cxQ5y1/B+8VZqU+XN1YWqP8wZj0kK3Mfth3o9UidN?=
 =?us-ascii?Q?pcHuOLyRwTCtG9h1jDi9bql33BzDNQjxcDiT1UKBMPv8ojPDyfpeH3fz5JTf?=
 =?us-ascii?Q?HLgy9Tpb0zhsv2k0wDYFFGh5WuIA9Ephv4Upu5qJNBG3TInnX6TSWPNod4+f?=
 =?us-ascii?Q?hN9aGb62I8Mkx6SIjycx3vpxCk720axVR3rtOG0YoNe4PtK4bNt5VFRuJ9rM?=
 =?us-ascii?Q?nydPc9wG9r7vsErnSn4n/EkPMXFRBR+v9FGW3dLHrrEVUp6sPdUmaw0ftox9?=
 =?us-ascii?Q?hb/myYWbO6px9VMQDy7jzTVtpZJBu6WxYS4e5xrn1MdVE3QrWLelOO8ViFF/?=
 =?us-ascii?Q?JgRdPpmOYMYasoAah23wbpAI5Oh+9a2ynOR6wUEMA5MphGgBVGnzkVFMHve2?=
 =?us-ascii?Q?0c0W5Yg6jlYKRPs5dMsST83neF+SuC4CMtYqFAw0n87Y2AEC2bhKzqcxfZLf?=
 =?us-ascii?Q?Vjlyo+8pJGcm+j11NpjYpLKTPqx4uHbXtoSDTOvs6Rzwf2a9+OMkPJmWMgv0?=
 =?us-ascii?Q?DQvKG+43nwdgoZI/NYaXYk+VTlwzjqPurdSV9Mf+Gh/dWvXJmAMzhDU+BBk+?=
 =?us-ascii?Q?QNe6TbBJeWQJaNJULgyDh46X/MQyHqjkuRpobuoCEid8/inZv30O8YdlwNGl?=
 =?us-ascii?Q?WGwIGSjCAci6u6rCPDpIQLWFXLouVcl2SOoeq/5svv5j/oYD9vnt/QOMnyLU?=
 =?us-ascii?Q?eOti49zyucbEcnRQB1Zy351x22l8kE8N24rcIZPGOQdg9RfgPpDxtDIyM/gU?=
 =?us-ascii?Q?hiH6iUmoMc17cyrOFItPiy3+mURzn+uQ0hP6o7UHni02yeGgTICbzWea5nc5?=
 =?us-ascii?Q?UQuHwDVReLmD4ivILCIILjHIjsAsCuUbEQSsLR9I?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 376e8b67-5392-4962-7604-08dc23ae706a
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 05:18:49.8477
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: o3sCC72JGThI4zKWyZjHZu/M1ibEXV7c0VUSOjEqW5KatfbxBeGPdqy48Moa3Y65j5dmGgfK1JEOz/R40xtXOA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9996

829  if (request->complete) {
830          spin_unlock(&priv_dev->lock);
831          usb_gadget_giveback_request(&priv_ep->endpoint,
832                                    request);
833          spin_lock(&priv_dev->lock);
834  }
835
836  if (request->buf == priv_dev->zlp_buf)
837      cdns3_gadget_ep_free_request(&priv_ep->endpoint, request);

Driver append an additional zero package request when queue a package,
which length mod max package size is 0. When transfer complete, run to
line 831, usb_gadget_giveback_request() will free this requestion. 836
condition is true, so cdns3_gadget_ep_free_request() free this request
again.

Log:

[ 1920.140696][  T150] BUG: KFENCE: use-after-free read in cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
[ 1920.140696][  T150]
[ 1920.151837][  T150] Use-after-free read at 0x000000003d1cd10b (in kfence-#36):
[ 1920.159082][  T150]  cdns3_gadget_giveback+0x134/0x2c0 [cdns3]
[ 1920.164988][  T150]  cdns3_transfer_completed+0x438/0x5f8 [cdns3]

Add check at line 829, skip call usb_gadget_giveback_request() if it is
additional zero length package request. Needn't call
usb_gadget_giveback_request() because it is allocated in this driver.

Cc: <stable@vger.kernel.org>
Fixes: 7733f6c32e36 ("usb: cdns3: Add Cadence USB3 DRD Driver")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/usb/cdns3/cdns3-gadget.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index d6723d31fc6e2..fd1beb10bba72 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -828,7 +828,11 @@ void cdns3_gadget_giveback(struct cdns3_endpoint *priv_ep,
 			return;
 	}
 
-	if (request->complete) {
+	/*
+	 * zlp request is appended by driver, needn't call usb_gadget_giveback_request() to notify
+	 * gadget composite driver.
+	 */
+	if (request->complete && request->buf != priv_dev->zlp_buf) {
 		spin_unlock(&priv_dev->lock);
 		usb_gadget_giveback_request(&priv_ep->endpoint,
 					    request);
-- 
2.34.1


