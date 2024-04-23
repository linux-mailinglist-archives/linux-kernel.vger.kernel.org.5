Return-Path: <linux-kernel+bounces-154424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA858ADBEF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 04:28:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1271B2836C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 02:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64B9B17C67;
	Tue, 23 Apr 2024 02:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="JdGfldmu"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2076.outbound.protection.outlook.com [40.107.22.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5155B19BBA;
	Tue, 23 Apr 2024 02:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713839331; cv=fail; b=Cangy0/8pjCVDL2LfhZGS8lo4s2MycVLvrMJt+gDwhRGdnUQziOcY1eFUrLVUxAh4GRMr74knkkwJim7svsyL7ljW+RzXlKyFwL9eOb2RQMbbrkQGuXoec1u7xrqspODGoH796yrqSy7ntQTo5RuA2Jj0zQxCUUo8kyXybbPonI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713839331; c=relaxed/simple;
	bh=Hs8rcJ+RVxpO4U60LR+iDWU/HUMzZI1cTzadNgJQlDg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=OFVnlbXIwQ3vwGxyvq4b8ztbUqpUM8y5dDdmEQrsTM4VYjWAMi+zAQ1Db57Toq7N/spQJahtf07zp/ZGi8jBDHBxrhWaNTWYtkAhj8aZKt2Mr+nQnO2hTSsVDVzE4WXHYP5gbpLCqD08wjdNCcIk6yh8NOA0Nf5a4d/HFqGrxdM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=JdGfldmu; arc=fail smtp.client-ip=40.107.22.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IOULnQh0d6OD9cX56w0IutulFwNGLMBHPMaJcgguNixHuKNCz6f6H6gbi6mcXcCLIXOjlGokNvGLPodHVl/eH7RW6rmKP2+mAggzyhvnyGp+RBRng3jNzhGGmGG8c4jqXlySZ6j9eFO04hbe2xqBAEJNqyXd4MjJfLdp9mZr80OSFgsEtmrxvr3/NpcNZWQjDHKn1ItQHJoiR39L+cvIAK0p4IDmL/oSTCDi9/CSNwiLtOBcJQKu6rGVYEuXT1+EKCp2jBr29c6/TR0+Zk5qJuCf+ey4Wz95SWHCJJTGZ1v4IGqIgCTugsrflbdQG9cYOA+1b0+4ax5lFNw0erFTiQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7aekq6Fd/o1H+XWrNY8CCjy8BzXAlXKb5LxMGVq1fWo=;
 b=kTFcSMTms/1jw3nxILYMgpvT+SXSXeRZX5QEibLODcSY7oz/EYtnxT/0NdwuiH2rNAYe0Mc3m00nRXnPVPdKzqTsnsXqHl+mHX6hhvliwHrPvf6fFQgmLpGzBrVOCegBFrNkxbX/ReBGE+l0X+ZKUTbf/AUJpQq9Apg0FMY2fesGi8xtGobKvRPM4T/u8W2GJyVECGxfx/DZZoEKkzvq0cqc+6DTV2a+Otzd3ZLXAHL4jcazpKjSbxQ17k8NItQitIaQEt06f+SppOyPrsNITI6iW/W3d8BU6mj9JTa6JeXjr5lo58hs4NbnUYkFjcOTcw7cG2mDmn+k2HjeZTBqZg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=7aekq6Fd/o1H+XWrNY8CCjy8BzXAlXKb5LxMGVq1fWo=;
 b=JdGfldmuL+iaKgdgbGyiPEQSljQFuPa3cWY3KwgloTI/w6ZxV+xCVRSgsZkeRVxIkSw7wTTY5WoI165iW7bO3HIfOAtlZ/NldtE+OTLFs3YIjFYAP7Uaudtr9VavV6K2emK/ur5EAPkRuEnUEeXj4/VRDn1ehGMDWAlMXYKJLVo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com (2603:10a6:10:32d::19)
 by DB8PR04MB7098.eurprd04.prod.outlook.com (2603:10a6:10:fd::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7472.44; Tue, 23 Apr
 2024 02:28:46 +0000
Received: from DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::8271:6309:7e7c:1895]) by DU0PR04MB9496.eurprd04.prod.outlook.com
 ([fe80::8271:6309:7e7c:1895%4]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 02:28:46 +0000
From: haibo.chen@nxp.com
To: linus.walleij@linaro.org,
	brgl@bgdev.pl
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	haibo.chen@nxp.com
Subject: [PATCH] gpio: vf610: always set GPIO to input mode when used as interrupt source
Date: Tue, 23 Apr 2024 10:28:14 +0800
Message-Id: <20240423022814.3951048-1-haibo.chen@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SI1PR02CA0043.apcprd02.prod.outlook.com
 (2603:1096:4:1f6::19) To DU0PR04MB9496.eurprd04.prod.outlook.com
 (2603:10a6:10:32d::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9496:EE_|DB8PR04MB7098:EE_
X-MS-Office365-Filtering-Correlation-Id: f3abecc4-9490-49cb-7a60-08dc633d19f8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?bmpXf1c1TcWTIcJcXGWN+O6IvBCqgcG7mFzAKtG2Ozxy71qpkUZAFr/tAPzl?=
 =?us-ascii?Q?GqJqp0QwKUs26AdXfU+cqTFzGIAJAVzLTJwvB0fn83jqAkVMkcgDfUNiD81+?=
 =?us-ascii?Q?/Nxu8KUcQXnP9Br/TCWUeD7n2DM+bU7VsAH9IsjSWYzUN1ODZ841pF1rkaye?=
 =?us-ascii?Q?VRBaxsldE7Z4DhO0KjEitRl6nJBC4NIFonKJ4bD6Otz5bdHnYU1X1M07IE/4?=
 =?us-ascii?Q?98n7Hp8KQLB7O/cSggR0SuYTE5RM1fOxe7ZBhvaWPa1EcCdStzlT+MzkTdpH?=
 =?us-ascii?Q?OLQP/wBOPTLXC+QfFP4ALBt8mjPDaXFwR5Tj82kaQ06NXcOUQm0pLWxkO702?=
 =?us-ascii?Q?eYpQ3LnqQKDY0agPN2H75cBZ9CJ5v2UPAPSEKxfXdTATjygagql01r87//kp?=
 =?us-ascii?Q?IIA8WEWH8bk3vJhj+bYqVIpgJnUdDkI8oQWSclXuQIECUmVFYNj4ZWGouRTN?=
 =?us-ascii?Q?hZTHPPenGHfoGwWyeB9hkPpebvAxm1+XmrIUdS9d3dbZWFeUrEvioZRi4AKr?=
 =?us-ascii?Q?SnncSh/NAnuH/mTr8IPvD3UJoGNihJCg2UF3N9/YRoCTKXkWHVzHgiZZtc4U?=
 =?us-ascii?Q?ik6wNaEEMMKZLx68w+01Wzh9dYj/sob3ibw2RVQXRv65hHNVEJg4N0xtkKxI?=
 =?us-ascii?Q?OTHELvdO+1lk6fBg+g9wrEiJ90arqwztcTFDC8++6P2TaKC1euhEditJMHHE?=
 =?us-ascii?Q?qQTTAnXiwxqnvfDWzgiWb0sZyTseEdqHfenKIolsM3vM4DCKCuzv8Q3NzhTa?=
 =?us-ascii?Q?aOfkuamn++GByTxXZywuySmu8NYBmpvRg6JOdFjwH83coEf+N5zLP0gkaJIL?=
 =?us-ascii?Q?AuyKVwytN1hRMMPDP5tPok0stRZUvtvDet4giBlA8qUD3Agh/22Cdaf21tFm?=
 =?us-ascii?Q?OuLltTMjVRAEbSbEBDJM6Zrs5DFwaPKfBanpi/+ucDnH9SWqwWWxoEdHKeBH?=
 =?us-ascii?Q?ZFI0ZK4RIhVSQQMDU5TJxrLL6g9M8i0XdTznXR14pezyOYykXmv9VQF2YgEz?=
 =?us-ascii?Q?C86HAJnxzIdHFKtf9oV2uEQaa8v/3rjZiIO3IOINV/d1qUWN7WiykDXANwxb?=
 =?us-ascii?Q?taPrKILXTQRABDFgwzeiIGAcfV6L7O+y2BCsdZRzlgU5mOYaGi6JvAG3oAph?=
 =?us-ascii?Q?OZ1em0Zc2ywIjnyNcZDjKFHI7lTljgMAE0FfI6KPII882Mkc8+6WUmAaLkHj?=
 =?us-ascii?Q?KlZYgtWAschODPK0bac9IuBeXkGeAwU3Y9wKGwZYw5TkFBMJxaD5hmnJYMeb?=
 =?us-ascii?Q?GOFp2bVbbpfG8dt/GJ9aAsVWtCa8Zwqz9ztopWHZANogWNEO3kO+j4jvd68L?=
 =?us-ascii?Q?lKGzZoHUjJurZs8W1d0cYqE95RQDaA+GJ/Jip6Ny1wpxfQ=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9496.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(366007)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?3ZeFVq+5ikG6UbLoUyW+Ef0Vo3dho8DtUkkMeN9f/CwcMowKD0q/cyvIKHLq?=
 =?us-ascii?Q?dAxESchQX5KSmuKL6560YCNoZ5Hk/w2pzl6dPoD4pJBxisDj/WqAeEM0XLIr?=
 =?us-ascii?Q?fJXCa5ub51UsBnvfj6ZM9SFcPrRBytKiXz5CtAfQ+gda5MtpCZtoXIVL5FbA?=
 =?us-ascii?Q?MSzbfTse9QXyXNviF549Te5KmuQfkHlTYN0jcqiA9qxD5+SVbFnolQraFghj?=
 =?us-ascii?Q?mzqMYgddiwknRaM3TwORrCMwr41stG9Uk2y73hUA9UBdc8tD/4QutNGSO6Rg?=
 =?us-ascii?Q?dNBkIe/vxhlGlWDtyI1HDW0gCHUnXVY6IA5H7r2C/SqysBLwKO+zL+Jq8/G0?=
 =?us-ascii?Q?23yijpPZynsjhyCG8lzHhdHIGZIf698sVFT5qfP5vJWE1p7LRblWLQfEaMcw?=
 =?us-ascii?Q?hmxUdsCVLJ51JhI8T+1GcLlokDIL80ZeUlRfxA3Bw2Ul03gGTk8BurIOWIlR?=
 =?us-ascii?Q?89PI5PPh449efy9VFcbDauicTanw1//psxiFh/eRpjJalFavkyyxENnFQncA?=
 =?us-ascii?Q?CiKTXBiEMHf9bW24EVeopWTGyVug6Inw7PPmHglGPkEZKUZM0bpJvbVxIRtn?=
 =?us-ascii?Q?nhVMIehIAOO4YWV2NePajFtC/ljpdKsuAo1LlRIrDkPVEKkQqTwvREeuWXP8?=
 =?us-ascii?Q?ldxYU5yo8DahwytsMptW2nl94O4EeBUrYP4376GPuuGF+4O5DjM6ciEz/By2?=
 =?us-ascii?Q?ewAxykSukP25LdHO+f3HKwnlc5XL5JbY7ynlyojN5jV4OOyyFJEwofKdOoCn?=
 =?us-ascii?Q?vwujeL+i4QHdNQ38lR1GVK6hZ5C0c9QHLGSB6bR3Q3U0zzPnNOJTcvW4aw5m?=
 =?us-ascii?Q?4eUK+rTONPmQgMpQ7eNfmcZ2kpehQcVpVTcRYkbTTSKvclslozDXHtuHZv2u?=
 =?us-ascii?Q?CkEFqaoox/k8MiycBau3qm7TC05CUnVM299golRUDrYIeK4ssfusrtKKphBt?=
 =?us-ascii?Q?TB9ESSG0gvQBd6Z+wKSd5awccSh3u/uVIX74OL70+BmsH/QEPBOMl8oxB/dP?=
 =?us-ascii?Q?qjD9glIapD/PU4B2tl09ePvr4b+Nvk9rMnz6MR3iI+yKlo16LwAMwizzAfNW?=
 =?us-ascii?Q?qfhA8znt8F/YR6x1F/tC/T++BsBi63Fo/GTBYBbpppg1D/CHPzF3i0foYAuS?=
 =?us-ascii?Q?fjBK1nbUsGNwIYAFk634H1xRwvrrdcuf5ruMbKv5m4z/3IJxaGkpc1RxpbtV?=
 =?us-ascii?Q?FI6Ec1nG/JCL2OU7lk3SzsmmVbtSdyqr1b6GwtmucWz863Zk5wK9hSKdY/Lh?=
 =?us-ascii?Q?DS6CtxwcQW4LoFbSjl3sjZ9EEArmIRnI0uZ/URTwdqW4dUrEyqAwMnpMtCuC?=
 =?us-ascii?Q?R2Z0Hh81fSxEdZV6GmpRhGMVl/IuOIXBgrzG2UdMQ7fBCkaTI6rDBDxlImY6?=
 =?us-ascii?Q?egp6Yr60yq+HAw5LGUrLHSv1a/RwIFNTuVsfxeEp/GDHaZLC+RDu0qAKxeaZ?=
 =?us-ascii?Q?GcgW5YuK/cPXbAZ/pqDFSepBFNjZPEboHUUKjbbXwNhWaQpL5GZFO0TdIia8?=
 =?us-ascii?Q?jeUS8EfCJNluclSfsxkhexJde6BnvhcKDXLxdn+JSE6HFcoghWmPHNQMbs1l?=
 =?us-ascii?Q?qUsJ6SdFjvh0h9ekLl2f47P9UHTpI8NivHEZxyBI?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f3abecc4-9490-49cb-7a60-08dc633d19f8
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9496.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 02:28:46.3119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hOmJbWxz50VVh1fAUbEAB6io9QnSfDph4kEjO3LAGgUP7vk/jz/NozfbXGKust17qyHXeksdaAz2h633N49dTw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7098

From: Haibo Chen <haibo.chen@nxp.com>

Though the default pin configuration is INPUT, but if the prior stage does
configure the pins as OUTPUT, then Linux will not reconfigure the pin as
INPUT.

e.g. When use one pin as interrupt source, and set as low level trigger,
if prior stage already set this pin as OUTPUT low, then will meet interrupt
storm.

So always set GPIO to input mode when used as interrupt source to fix above
case.

Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
---
 drivers/gpio/gpio-vf610.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
index 07e5e6323e86..305b0bcdee6f 100644
--- a/drivers/gpio/gpio-vf610.c
+++ b/drivers/gpio/gpio-vf610.c
@@ -214,7 +214,7 @@ static int vf610_gpio_irq_set_type(struct irq_data *d, u32 type)
 	else
 		irq_set_handler_locked(d, handle_edge_irq);
 
-	return 0;
+	return port->gc.direction_input(&port->gc, d->hwirq);
 }
 
 static void vf610_gpio_irq_mask(struct irq_data *d)
-- 
2.34.1


