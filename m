Return-Path: <linux-kernel+bounces-108539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DB8A6880BF9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 08:25:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9D56B2206F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 07:25:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9249420DE5;
	Wed, 20 Mar 2024 07:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="fEUfB3p0"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2078.outbound.protection.outlook.com [40.107.6.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1C1D1DA52;
	Wed, 20 Mar 2024 07:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.78
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919545; cv=fail; b=QkkPBmaILO9N7geUI6HtHaeLBCfhyAuTaW7+KVh6nyPNrmjceWg6ZPdM1/lL+CtCLE4Vg5pfM2RLILnaN9r5Fe/vNiYVk872qLfGd77v1ynmxk6Cw2oBML2HiGgtgaaQn9D3BPTuYIhvw/CW02xq9DF4Tri6BTw9Q+UvFkNPEtc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919545; c=relaxed/simple;
	bh=Um/r8MknPez7aM61iNWInogMj4nRNUtHBG8Bz5D+FIM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=kVWcKQLY2Jw6Q5OooRSeRtZvo6H5He9aTfHlbRuO02u2zDuMu/kD+LyY22yFm1rmWGkhdeN1ARN6oi6X1JqatH5wKs0fR9OzoQnd3Qkxu+BnEXdi5B99rRkdAbB+Zv7GflgHg43FAOMevLOnGKmIwJJiEg14Ti2wZdRpVhn2Q4w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=fEUfB3p0; arc=fail smtp.client-ip=40.107.6.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lpaDLVxmN1ZmZGOsZdO8FHijeBOYqwt0iovkBdMiFhbt8tTDESdG/DyxUTEWAk8MX5wXZf7Pcazkz+c+sqWQczJQZZ979sd4Se1LYPN/xWsstapcOrzTjI6XcLpP4NC85PLd0TTPviC6/Y9OYRVe014Pl3eu0lpmMsHIq+CFRsTNq6jQ63h92unPkrvrxw/eXpYEf8UjpBrqVoaVvznTkFgDDBC5LNwdIgbUh4HsD0ALeSoipeppj2/9Enzm0i3vwFymD+sYSak/bHkca8Aae9I3PIPxTuM7RCyFqoZKpGGhnyzDfeA5yiJu/rg2reCn5DBOL5hyifVSegph5ZBJ1Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bmi7PaoJXslA/Tr/W4aXut8MnEAB5rC7JmKve1KfteQ=;
 b=nMH7R4tyDyRmIR+hafRUOG6H/nOZhbv5t3ZYhYEIbeUOs4dWgSw3lq2/EUDcmhBCjFoFPyVz3TyF3EU8ezv9Byxw597vctAaWX5TYjs/qOCNIpKbJWy/jZVC7rzQs6EfE/vb6aqj9YzTFLlEq0N2Zue8xeUgnGaMbIfMC5gb3Euzt4KPMvRXoGDtev3XK90k+zw1HC2WcnU+w0iBH/wU/ErYbXyYJtwf3f3IuQQcPi1uLYU2JjrQFNqUATOKKpcNcjqBz53m7L7eYS0qEKhXA5ot41W1hmZfsS63CsW3LdnlO8ztkLFd/g346omurVsG9uUT1iC70TQuXEVTia6i+w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bmi7PaoJXslA/Tr/W4aXut8MnEAB5rC7JmKve1KfteQ=;
 b=fEUfB3p0XbTg1yQN20stDgawUT/i+yhH/jGEsM/Lo5frg2dXpyeKYLiAveH2iR25DqLHRTTXdu8jL9c9FQEBFHzN54hp5ULL+8xgwNvJ95ZWuiYHcLHSm42Hb4sDbLRjIG0CGGgfvVnq/NRcoM/VU0w1AH3iMlHetwP/W+1h2Mg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by PA2PR04MB10157.eurprd04.prod.outlook.com (2603:10a6:102:409::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.28; Wed, 20 Mar
 2024 07:25:40 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Wed, 20 Mar 2024
 07:25:40 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V2] gpiolib: use dev_err() when gpiod_configure_flags failed
Date: Wed, 20 Mar 2024 15:33:44 +0800
Message-Id: <20240320073344.1563102-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI2PR01CA0010.apcprd01.prod.exchangelabs.com
 (2603:1096:4:191::12) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|PA2PR04MB10157:EE_
X-MS-Office365-Filtering-Correlation-Id: 4a4c2a12-a10f-4549-cb4c-08dc48aef13f
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	8/KWr3YHereSTi/g62fptLOxI8mHHWiZ8kUgvLEvMXX62Y7BAnQHJ7ifrRgnrZRxUHUVQQNvB75BJTFlJBNhOxHc89WPyyoD5tcHPcMKNJs5vXvelSx/5nOcMuufZvQxLX2GJ7AfCaWF1dlPrSbGAE9NjSJ3SMMBTyjXCW2hUNqaE4u2fKmtDkplY1Bkwq92WNFu22q65Nko7faziCtHUJBt36F4bHU+PyWN8K/r/CURqnB3JN/DLCWeuLHL50/p2D0ow0fe3Ta0+ZRiwUeAbZrdLC/6dX9qnXorq8DjYitbdKQUDjLEGlh0vzt6ma44d7N9hVG4E4Rk9lN4+G+msnRBY1rpfnWgfouWifYHoTcNyFWd10TbieLdvCOLMX2ok6LJsHw3yI6QoLs9Ik7+N64/EQy3Zreoy3zEy8ecZlr1KlSUrliAGx1DFpEX5rnhmizpPuFSItdNQGvCg64yHFR7xF8eZYm7jAW0tklCIa7JYC0iUvztTkSj+4GEg4eVA7KOA+3eAJ6Emtu5po22LzVR+B2dQELIYMBkRx/CaWgJyFT2VRfdrcJMIFZ9bFWZhXu4lKhFdbgBba7sjyTz+bt+5JPUEdomE3oJ1mrNyAlcIQtRbYtxMs0hLEIvA4YzSlI2QRd3BTE1+FvZWW+WQqs0MvnXEPQBnWOYS4YEcaEXzBMGK9g45kSCbE/+tmHuElxTpcjKK4YwqgrEJMyFpO2/O7SRIMMwi7HlrabTK2k=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?bCG+ewoV4W7RwzHDwcGWgTkirK50ak0BcMJELJ+GXDnv5vcFZNV0QDtt3WiF?=
 =?us-ascii?Q?uKaKLy3avxd1lBvkEzCUYf8Y65PHrWYAHyzY99KFpDU2NG+LfZMmPbULeI6v?=
 =?us-ascii?Q?G0V34Tg7PPyp0p7gXjNsTgGjNWHXNBbSgbJt1Vto3Tf8KcPU0FOA5l5wOZ8h?=
 =?us-ascii?Q?7P2QYcfEV7P3+J7os7np1xXno89/tkc6rUu/HsUwWgTdaFbea9Yza4EFxE/8?=
 =?us-ascii?Q?ybXtVeotG/KIPNpTkY8E/bbQwZxsQE9E7GhsJP4h2OFoe+FwuDfGjHA0HYI3?=
 =?us-ascii?Q?tvdsY8HptxiVXoSs3wQnzgis/IX+U8yRJXCbEZbaus52NTJIxaIBmHlI+o/R?=
 =?us-ascii?Q?8t8BGBc4OVFJSLvOdwUwJ0FWWtmNLGo/ctsFxwrLIxRQIAUVx5zp20bfObbU?=
 =?us-ascii?Q?U6VMX/29kyYUdkfAW4rKrtkuOYc9ZdWMNEqKVzlJaEEFO9qYPStGRjBfugEp?=
 =?us-ascii?Q?dvUBGhx5FzhKUNNEqYIOwlDwT3g4ZLVk3v5HDPu8lSXOojtWPDBuLaBq2R6l?=
 =?us-ascii?Q?FVWfkz+yS//F6UZWDcsbh/RDO48bdNIGd/IVP6rv372vi71ryKEhDNFzYX/W?=
 =?us-ascii?Q?Nz+5T5I/O75r+nsS/tL7zoLKgpwUbCUyXfu62eHYF/ZEk5YwwQ51fbkhxkEL?=
 =?us-ascii?Q?DS9+dxrA71dTCykGJEgl1liHJLZa2ZRu9umgWOP3F6b1189JIShujcZRHANz?=
 =?us-ascii?Q?yVffH2TMS9OwEo5e6GgajQK50KsTAtG+mXBLGGz3PG06C8mdqlpBZ0KK9ALW?=
 =?us-ascii?Q?Qm94WeU/O8YskmKLLCOKOrE1CyJmar3PEoVWp9JdWfgSKkdWZVuJHRXZ9F3X?=
 =?us-ascii?Q?1BOVBmP1Pp4FylMSB9Zv19KdqPjdRiYJDbPXl2J7UA6c2RAxS9h/aalH0RL8?=
 =?us-ascii?Q?2NYwIAvjcqE4JbcIoJRYGVCdZIRm0bSijhZrM1PwqucrC+6IJo0kig2VPphX?=
 =?us-ascii?Q?JAmaw2MDLhaYsP1Npi/jnjxar/HbQRQZKj58cCOtqnQ7aZiPFnt8qVZg1ZjM?=
 =?us-ascii?Q?2P/sWYSnvJL44PqWUFxUDaZIWu+63op/5ziOazOJvTc/iwjyj7xnfPK/HTz7?=
 =?us-ascii?Q?pJPQjtHO/0RDuBySyqvnlybIs2cawiEVVLMEi4IRo7RF3tvigcokSEK2J1iY?=
 =?us-ascii?Q?4svvIz3zez627OX0jpN7sdcu5cfpBYlR9h9INzxSqEaG346PLaHNmxS1Pcnd?=
 =?us-ascii?Q?vning4vI4mwSK4GwriNT6guD90dHqR9v8+j9Ut1FNZOwWMk4OoiE1B/NEcrK?=
 =?us-ascii?Q?L3FnXioY8X7anemD709D2yTG2mrk0mN8LtfwT0ZwZRJ0XjtIJQFuFFLdSmQS?=
 =?us-ascii?Q?bNw57VXNPpp2Se2Pd9Gsno7sHGJ/7vifYWl50i0YMMl6KyeiWvh2lDulXG8Q?=
 =?us-ascii?Q?qbP1WqJfg0knypdQvJaRi1yCis8AXwZgHvSlp6NFcJqnnGZwbtDpAr8DF5ga?=
 =?us-ascii?Q?be2iwpGLwbZmiAYxC4zcRGKXad6Gce+sL5UkX02EkETK7TDymqsKg0tTe2J8?=
 =?us-ascii?Q?QIY8yoNAlO6pHefENUhICm9+zeFa4+gFS1nheo78H6Klz8xYxBHMXa4akLa+?=
 =?us-ascii?Q?jpF48avZQXihd6jOqgzI9SQUxqkg0parSuF4vJt0?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4a4c2a12-a10f-4549-cb4c-08dc48aef13f
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Mar 2024 07:25:40.6357
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: FOrC2gUb3BP+yk/6Rby/ejZ8zwb/jAXwlh61u1HFJ7sZLfdVho87LNP0N9eEbdxe3AzktAdAfGwGNxVJVGBvdg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA2PR04MB10157

From: Peng Fan <peng.fan@nxp.com>

When gpio-ranges property was missed to be added in the gpio node,
using dev_err() to show an error message will helping to locate issues
easier.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V2:
 Update commit log

 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ce94e37bcbee..37fe9db0bd74 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4233,7 +4233,7 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 
 	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
 	if (ret < 0) {
-		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
+		dev_err(consumer, "setup of GPIO %s failed: %d\n", con_id, ret);
 		gpiod_put(desc);
 		return ERR_PTR(ret);
 	}
-- 
2.37.1


