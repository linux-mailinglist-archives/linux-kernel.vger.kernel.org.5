Return-Path: <linux-kernel+bounces-111061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C353688677C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 08:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05297B21F35
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48C7012E4E;
	Fri, 22 Mar 2024 07:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="KkInC6hp"
Received: from EUR01-DB5-obe.outbound.protection.outlook.com (mail-db5eur01on2081.outbound.protection.outlook.com [40.107.15.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B4B11713;
	Fri, 22 Mar 2024 07:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.15.81
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092568; cv=fail; b=Fw7xttSzxjywVGi7OUAeNJ/ZIVBiIkba6hxOMmha10GYkIAxNjRrISFk3/yxCeYMcJePKhmHb0gx34pyxesyhjs2COZP3psG1n3cjbD8n2N4t4xWHPsjnwIB9JKgi6T1Nn2UmbeGsgIFw/mfNGIOV1ARVqbtkLVjInR1R5AjL30=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092568; c=relaxed/simple;
	bh=dr3b8KOISnBjDo6HqLKnR9G7ykutEfzyW7DRoWArnEM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EsitIOWiDCR/YreRTEoxIxURke3cz9lI27fwh63pwaVkukTObpBzrifKo0NncXfo6Dpx1XxUV/zkhTwHMSM6C4aDkCvWCspwmbmY51cGtTJaBLtxoO/+u5i931WMCRAvqHsVb2TxEI79aTc1MtRTyzYOv5s2ecsfhEUyGtTfPZg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=KkInC6hp; arc=fail smtp.client-ip=40.107.15.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RJduS55R7I8flgUUBedznrdb1JlRpZyWmVnePX8DshotjqhuieaTr1VrUsMow84IJVuxHLpyYKMsj75STO7KMoUeDImwJfz0rAhX9qLpwf0xntF3zlwCtIb+QT/GS5VWGQl1E35c+2VyCck/na7qJZFUVXvoloFSMvPaMwG32YVEGswlVVQipqLZtV2umZ7JY8nPwD9UNfVp4Xp3ueO8woGICH7JzLrKMO3rGh7GXGGGB1Gl7li+/Nyp/C5LlcDJJFZtRiFx4Ak/6ZLZpdwcWE+wMERbRuoehqfvSYGRPwWB8Fxtc+Z0hvrFwyUEXYeUStZQxDgzQcEeacWKQEQ5uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g2ixo8w5H+jqkP2coucRnrbk9AzruQDYdFLofF+XWGI=;
 b=bJDisG5ThLTll8t7uFKg+m07HU175jZSgPITYW3KhhYw7OS9SWQUqFzyanAro1543EVrLdNzk1gbJC7MVS6SoHdxIDNq8XEXdRb5YYNJoaFXkGTxFt7l938CUOsH9UTZnhQdxt5i2jHlgzUJOtO7wHqOJ/JrSInOoLwm+O0YdW01IK5evfjQwzQLysJq7tXtB8qyRapmdIn5N5Yh2ie4CqRIz4WRUcv0cgNbzMLSdjwz5qBlZD5v6S8zsMa6WQV9mbyW7SaghLMnHle43JQZnVbxKc2j3ZU4KGgdKKmxWssQVb5I/AfYUgbzoenJ7fvSapGVMAqHIN7SwThHKwcUCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g2ixo8w5H+jqkP2coucRnrbk9AzruQDYdFLofF+XWGI=;
 b=KkInC6hpUKLEhVBVdk9PT1fjaqFZV2LLCGPl6DogCTmstcMp1sQiY4KMsxBNtex7QHiaAYJOJfExp4WRQXVU+X+t9R2Wa2nynVyfoWtJShDbwMXf6JIY2rUqYrJ9mozJcARIa7kgpaa7uJD0d9zXb97oaBGINiPOw0CfTMSpUvM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by AM8PR04MB7443.eurprd04.prod.outlook.com (2603:10a6:20b:1d6::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.21; Fri, 22 Mar
 2024 07:29:23 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::d30b:44e7:e78e:662d%4]) with mapi id 15.20.7386.017; Fri, 22 Mar 2024
 07:29:23 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	andy@kernel.org
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Peng Fan <peng.fan@nxp.com>
Subject: [PATCH V3] gpiolib: use dev_err() when gpiod_configure_flags failed
Date: Fri, 22 Mar 2024 15:37:25 +0800
Message-Id: <20240322073725.3338266-1-peng.fan@oss.nxp.com>
X-Mailer: git-send-email 2.37.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR04CA0203.apcprd04.prod.outlook.com
 (2603:1096:4:187::22) To DU0PR04MB9417.eurprd04.prod.outlook.com
 (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|AM8PR04MB7443:EE_
X-MS-Office365-Filtering-Correlation-Id: fc62f867-91c0-4ee8-3ea4-08dc4a41cb41
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TjcaUMgD5Fq19I2p0b3VG2EL57QJKaH/7WhhKXCrRU7HRRaHol6LAOmUqmNi62Xqo/z0Wez2hj/jJ19id4r9t8fFL8ooB963W4by4hRFxPK403HargZD2hihE/S9thOEsYYDxD9Zka+HSp6e5dHc+0DizIBngzRQDLgR42fyKpoiIMexnp7appRySMpQCvSEnDHngp1lOFumC904wAWRsbnP0s5M9H9ozbeyjC237fG7HMsifTM5YplU1fQGhpnTSN+bl6o6PZEM/Yr7Ri3HaiwTTvNbrt/i17/NE/MADXBrqaBD4tUmRi2h7JCYmPQORgGK5EqtGFWUWaVXIwaS7koLsgs62lV8ZdDWlwi6cm7mbmI16vCrJGlCAV4FYUjYFXIuUjt1Qj9rQOSfjBpmqdtXkSPFdl3R0rEZ6epejZ9Xstc9rGUiEiP7qxrxiRFm3Aubz36TORyWf3RJc0I4SZKpMpF8bN/RBhuomzUUNPc6iGChVceVp4IqIXdoPXHSfoYpogF6WWWPHuUGj2Qx4Clc5D7200mUXixs40AKo3kHRGpM+iqcJ0FifA7eRvMua3jJCXUX32KRzG6WjLEz5V0RKp+mIEO/l7xUG+QNcoz4umXNPQ8VFjbDlr0j1WdEFufLkzlHxR8XHSlJui3b/Swim9n4jdQtvU5MbRTfjiGbI3kvTHgGZq2jEiVMXv9KI/guW/EkSFQeNxOvxvcuVA==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(52116005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?mQ2KiBeMk6gjurTITW5SVpY4hLzy123JOjJAG0xlsgoY4miypWWlwPbhgF8O?=
 =?us-ascii?Q?i8JKrNuTsuDb24J7b1BuuEYRBvz9+3YVyXrzkIZ3CtVQUEQVLHbtHHqyJpf0?=
 =?us-ascii?Q?qQgBHYCnCnwKWdZG0zWAOjyA4GZ6sYx+EuTc5szOtDUjB4J/2gDDIArTjSYD?=
 =?us-ascii?Q?BHaORk1zjNvcBeHXLi101PW4QXY3znLbn9mVrDhHzdXMIKkXgbVMj67C9JBM?=
 =?us-ascii?Q?01Noy1+JdrBOf6glE1dxLC0ISt5TWAeqQWas8KEc8JGf85cm1FBxSRcK0Yz0?=
 =?us-ascii?Q?3672Z/zssPiXCiY+L96YFrpDa618Lrf3ukZWQ8lw0oNCcxMtjim7Do6fayPS?=
 =?us-ascii?Q?eQbszaeRxrF8ytoLmRMtVFJYJMqfOmd/vsxC/n/p21bqosyNgTwHpL68yG2u?=
 =?us-ascii?Q?5wSilEDdwxluQmX4mxjwrrFtTAXI5Y+JB+bhs1LewieGJ997WXl2YYAIzrpk?=
 =?us-ascii?Q?xEe3Jjoa7OEkirZXlFRyQuhukzD69+BZ7RsZ4SJe2zEdPnL8RSiNHxo150+f?=
 =?us-ascii?Q?b2tYVz//Fy65ove8AGEkbHGoiPiExOR6Q1y4GmXAphF/ikSsw6c0b0kTGz8P?=
 =?us-ascii?Q?1XTbwNsJQd/ab5/qX5a40/E305mwUB43gHCokMz2VeeHtimy8Zpj3tpKoQr8?=
 =?us-ascii?Q?NljIpZ3wN81V2Jhwh1k8nBLiUJ/sTlKYuDbcuC9v3Z7k7zk0BFlybmcp301F?=
 =?us-ascii?Q?wVcrss2Q5/ow0FmD1xYgR1IvO2UIjo8aii5bHKOMtefxEIGS/M3N/tjddbjy?=
 =?us-ascii?Q?ZIqT+Sw+NDI4igojrgb5aFmo/DxAnVS0N+GrrgD55SGzuvFKDN+CUp2Se7tl?=
 =?us-ascii?Q?omXKJ7AKd2z0UY/ikjNZ4N4fuH7faRaP+XrQckGnqV9U6JLRVf4JZk8mhIpU?=
 =?us-ascii?Q?+XfYwhuaPWNlS1YF/S65CyhiCfpcdCB0hbfOgvyyjZC/S6kic/1fnV8614br?=
 =?us-ascii?Q?G65EudYUcj6gcXr3R79uLrS9FmoVvOSIk4u4mxmnh46SHc0wfNf/SRPgIGcs?=
 =?us-ascii?Q?h01u1nov/s+6v4ah56rvnaoeNehmod/+A+hGn5sS9FUI+FKRr2no62aHguCn?=
 =?us-ascii?Q?rRb2mX89bxl92Z7dluuY523hxC/R0+rkYNdPRP663YiWr56Bd7wrOTDG56mv?=
 =?us-ascii?Q?gr2eQcDNKn+nbWzH/EbvOOcqjTERepnEtJQReFtVd7cHbbmaOYHY5fXWZx7J?=
 =?us-ascii?Q?+vp6pEpBN4GQ+BEsWE9tAWB/9u6RNknxx3gRo6fuYLaIu3yH4WMaQb2keEb8?=
 =?us-ascii?Q?/LCRSc5TtPRy+XFP67986FhquUgLv7xzMnYFuE1he+I+oiXD72aQBfkjbLNT?=
 =?us-ascii?Q?L8DuCNEnI+bu97fg27KQ+MjtwXDFLRWLbp7ecmidqezjokeE/mF0Gc9IdPwb?=
 =?us-ascii?Q?C8NSeNEck1Q6xUt+v4+3pxw/fju99a3wTPz3HxYZysrrChRvwCK1dWHU7hwm?=
 =?us-ascii?Q?xwnlXtqCFsia0QOwhNiiWOdS0VP45f8+hKDPnsY2LLdgVxxA2d1tmH5e62gX?=
 =?us-ascii?Q?XzA+5r+r5ZAUC1/aYmBY4Pu/Kcf5KGJBCBJ0D6RGxqZv5gTyjlwRTbBWl2ZK?=
 =?us-ascii?Q?AMysiUap8ASQyFpa9tgE7A9DrcRqfDyl80CT6se5?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fc62f867-91c0-4ee8-3ea4-08dc4a41cb41
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Mar 2024 07:29:23.0703
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nDoGa/WFsGFU9UkU1EmaIyRgbz95Gz4iTWjEGuijPRLRVAsT/osWttsY1iHbcxJWGJ77x20P0Hk+SIEBQ9qwYA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM8PR04MB7443

From: Peng Fan <peng.fan@nxp.com>

When gpio-ranges property was missed to be added in the gpio node,
using dev_err() to show an error message will helping to locate issues
easier.

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---

V3:
 Move gpiod_put before dev_err per Andy Shevchenko
V2:
 Update commit log

 drivers/gpio/gpiolib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index ce94e37bcbee..b988704f5d63 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -4233,8 +4233,8 @@ struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 
 	ret = gpiod_configure_flags(desc, con_id, lookupflags, flags);
 	if (ret < 0) {
-		dev_dbg(consumer, "setup of GPIO %s failed\n", con_id);
 		gpiod_put(desc);
+		dev_err(consumer, "setup of GPIO %s failed: %d\n", con_id, ret);
 		return ERR_PTR(ret);
 	}
 
-- 
2.37.1


