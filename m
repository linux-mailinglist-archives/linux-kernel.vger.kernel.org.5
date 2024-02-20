Return-Path: <linux-kernel+bounces-72709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B52E85B7BE
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 21AB6283844
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 09:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BE1160DF5;
	Tue, 20 Feb 2024 09:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="aRJgwo/r"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2128.outbound.protection.outlook.com [40.107.21.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2CD60264;
	Tue, 20 Feb 2024 09:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.128
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708422003; cv=fail; b=Stmoof0afquX+jFzdZcJ/r1K4CZ5ydsdhrAbzJ0ZO88/8n8Um8nghNKPIULmO1uq2HD5OBsAZkp8WsdJXcfWYh8LRerGBinOPi+Yq52pi3JbHhpA5QHatVpHGSQAaNDncoS8tPyG1cfXmrWYMqdHeMP6Hcqwo/vZjtbRVxSBwtg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708422003; c=relaxed/simple;
	bh=nB3d9Wukx0QT9PG4kX8prjqM/bzHZfdj1+aQXraSAJ8=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=sOkzmQbl01TQhnKsBoGZWDw6pJUwtxVLfU0K5Qy0sn7VvCqRgTy7uG8v3HTgxWqSdoJMjRzkGa6StabGLv/uCg6/OpdcH7XTk0ceBqtiJm3c2/I5PxIdMbqU9g4wecaQc0bp4plj7+SFE8CbQB9/xmJ8745T3HPn1SFeW0UJnkk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=aRJgwo/r; arc=fail smtp.client-ip=40.107.21.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KfAu055tAsp8sfxI4kcrem5FW6+/IGwdEf+929ltcw63ihUjYgluJ42nS0+Kxt9eP+eCTwY6r9um/V3E9ZI1n9qN8yej3l/GTNjGAyKVRMYZi1Z6FLSD9Yw0I3496e6npDQtQWHv+IZqEIMO7Lm853DX0jXG0/useeyuNOJBkP/o4vNwDllx7B5xVvl167pCIKThwG8CtQQ7p1hsvcur98IQezrgplH/Tr9sF9BQDHFVDmVnlOZ8AJqZkyGM4rFS54PhfUV4CAX7qmc2fArZHiQ6zarg6qZiG20CQUr4V4oNSKxgmTLKi7X/P7HZLpjLyAEA56dos7EVAZs0xD+H/g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AOSCNarQTpOdBKiNefCuvX+0wyQgOdzu7JqDndPX6r4=;
 b=dCc0RJgPx6jpZFbKl9dE0Tf4UKN0hQckekSxma564tdKQXiGnzZpOH6rCTDIeNULobRx9NHLZi7l+aplJcgbLsH9b3dpJbVGjOVPY+OkQydj3GGExoMVEsZkiQ1gl3GhEL31T9fUddswB858uWGqY6+SV7e0t3buM9+jFDMyTFOsgI6IWjzHzXoWhV2Z6QylfnA7rPVBHlVVHhSmp22h7XcvQhU8JvxMnPfUHd5S4F3/BPZVpux50wYD6S/QiP1HgGkgPsTOM3M6Jw5Hly912Oi8zcqYzQb89vx2e9Ysfy4DMDwy0nW1vMmAmDAsM5bQbA+EuKKUg3dQibLEB+sJvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AOSCNarQTpOdBKiNefCuvX+0wyQgOdzu7JqDndPX6r4=;
 b=aRJgwo/r875Lkb/ZmCJErYvl8sfel+8TKB2jg8J68TbuUAZy3AY3rqdqsdIXM6DyQJF1A60LuwglF9vxMG9q8OxVTBDcn/RcVb35wBZ/HTW8/bOfVLmb0tE98LFAxJy3n0rYbFeyQ7H5e0Rnxt93bZlWuSme5Z0nalx6dnktR8w=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com (2603:10a6:10:416::5)
 by DB9PR08MB6763.eurprd08.prod.outlook.com (2603:10a6:10:2af::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Tue, 20 Feb
 2024 09:39:58 +0000
Received: from DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4]) by DU0PR08MB9155.eurprd08.prod.outlook.com
 ([fe80::7409:db60:8209:c9f4%6]) with mapi id 15.20.7270.043; Tue, 20 Feb 2024
 09:39:58 +0000
From: Michael Riesch <michael.riesch@wolfvision.net>
Date: Tue, 20 Feb 2024 10:39:11 +0100
Subject: [PATCH 01/14] media: dt-bindings: media: video-interfaces: add
 defines for sampling modes
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240220-v6-8-topic-rk3568-vicap-v1-1-2680a1fa640b@wolfvision.net>
References: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
In-Reply-To: <20240220-v6-8-topic-rk3568-vicap-v1-0-2680a1fa640b@wolfvision.net>
To: Mehdi Djait <mehdi.djait.k@gmail.com>, 
 =?utf-8?q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Mauro Carvalho Chehab <mchehab@kernel.org>, 
 Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Sakari Ailus <sakari.ailus@linux.intel.com>
Cc: linux-media@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Michael Riesch <michael.riesch@wolfvision.net>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708421995; l=886;
 i=michael.riesch@wolfvision.net; s=20230803; h=from:subject:message-id;
 bh=nB3d9Wukx0QT9PG4kX8prjqM/bzHZfdj1+aQXraSAJ8=;
 b=0X0GGjrZHjccolAvDaoMWfrKn676ioVpkeFb68k1ItAKvQoI4tfJHkWcDM/xlszwus+g4/SNx
 YK7Z565wy+SBf/c1lPh0NYNoyZdp+NWMU3oqC8ag3cQAmpf68AHX2Jr
X-Developer-Key: i=michael.riesch@wolfvision.net; a=ed25519;
 pk=9ral3sulLe95bLcbaiNXTgUTRiBayRBEFZ5OVIEHp+0=
X-ClientProxiedBy: VI1PR04CA0128.eurprd04.prod.outlook.com
 (2603:10a6:803:f0::26) To DU0PR08MB9155.eurprd08.prod.outlook.com
 (2603:10a6:10:416::5)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR08MB9155:EE_|DB9PR08MB6763:EE_
X-MS-Office365-Filtering-Correlation-Id: f80ab7ed-dc8b-4647-8697-08dc31f7e6ea
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OQoZujETFA0W8sMaQE7l7zrlz9bOOKTkOk/cV1SpUVJuFiruzljMbz8EzzKErxFWCGREdqhesJZq+SULVmyDzPjEKXq2c0tC6+TE0MEOqLTAMojqFSNC/7WjVQd834SM7eWw/decUgAWpgx8YoAw/YN5vtVcXQ88XYukF1ikK7Ahlag6ZeQ21bI8SNsReRNFmcfi/17Bw5Rt13pqKDuyuWu4OzM2ft5KT6L8rOlDBROaqhEkHmjxPWZXYTPRe3CqRxggRatWufakHh5alzD7K53wm7gIPQVqMNlM6Hke/emXkb5nHTcAo+J8QKGSiXptu3GxhwyDrhKXVA8aZD4g5q8II4WA8ar/xzERdu/vtGJcw6Wjo+TeqqDynWBTv/2ZIZH1qdb+56pvRFcKCnyIP/usS+oKr8MzuRit+cTxFNr3xJR1iyUNZ08kUNlbe/+Kz3dJaumMYtteWtGSPzNOeBYuzHcqcncGjjCneN7usVeGo+DUFOjaeuDQviBXUoDqTitN0NBuyWguub09i1SR4GLLxMuH84df41s4h8C/P5VB7TH14Pyaa8rfpaqnx6HW90t1I7A5jmq8HsOTsLvynt3GdJLUy2VvuZk6ITCIv7FjOycvYOX6mQQyndI7/uk8FQ8BZ1n8BioTr0N6Kj4ykg==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR08MB9155.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(921011)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?bVZSdll5SThSYS9wQVhUczFXcSt1Rk5GdnNGVk50bm1wV0lOWmUrQ0lOcGk0?=
 =?utf-8?B?NmY1RXpFbk16RVlXK1VkSXdVd1lHTzRIVVJhSU8zMU1Hck94WFlMYjk0LzZT?=
 =?utf-8?B?TDAyZ1JOQkZXRWp6TFhqSlRGRitkQ1IvWVBvVlBqMWl6UzZPNHgzT2JUK2tp?=
 =?utf-8?B?VkVLeEpjTWozbTJTMzdDR3NLY29FeFR0amdFNit1aFFVbzdjaXhjcUlQMFdY?=
 =?utf-8?B?UE1YUTY0WlpLWFVBK2pBaGJuYmkxQ0xpcXdjZmU1OFd1TGxXN2ZiVUpmMlN4?=
 =?utf-8?B?TE1zNjMvOWxQTUxyQlJrbDNxNjVFY2h6eDRWcHh6NDRPM05YUVhJdHpxaCs5?=
 =?utf-8?B?L1FtTGZQa2RYQnorWEZUQTBZNXRncm01bmZ2c2ExOHk5bXkyTFYzWkprMEdw?=
 =?utf-8?B?bWtsVllFMDd6ekN3U0lBNC8xelBSb2wvUVhlQWZ2K3V4Nk55NWlUeFV5U2NF?=
 =?utf-8?B?dTNNckszK1dLNG5QUFl5aXgvaVc2OXlNanlVRDA0QmlGYnNJNWc0WDhVS3VC?=
 =?utf-8?B?TjlFdTlVUVl4WHNObmtQYUhqWHlOZ0FHZGxnbDBDbW84cGhMUUwvZlZCN2tv?=
 =?utf-8?B?Z1FSWms2TzU3VS93S2hqSG5sQTE1cWplV0tVWG93NXh3eEk5MGphVUJsR2pE?=
 =?utf-8?B?TjRrYnNob0l2RzhBMHRuTnFoVlI5U05saEF4RHdIUEdsVmtTeWpVSUVheUor?=
 =?utf-8?B?VUg1OUtkVFdjS0hVZW9nRXl6SFVVRENFT2Z1QlIwYmkxYW9aZ1pEL1JUWU5a?=
 =?utf-8?B?T0VLd2RCYmt6TEVCOWFqTkllbDNjb3JHOU1aeE9valNtU1ZrSEtMdFcvUVI4?=
 =?utf-8?B?cW9UVE4vVDVyTnlTU0VyL0ZPWmJjZTBuWWdpWngydVpTMkduQ3FOdnJSN0pX?=
 =?utf-8?B?NTJhb3VyU0NkeFhwVVNCZ3Voby9aaU5oZTVueS9XQmFXMVFLZ3k3UHhuSSth?=
 =?utf-8?B?T2JpWWdsdVBaR2o2TlJEeU5pN3VsM2lzaVRtQUNvYTBBUWFYMTZqK1lTZHdQ?=
 =?utf-8?B?YW5pYnlzVEdDajVFRnFNZ3RBU24yRmFJNVlWMmxhS3RRek9XRkY3bFpZS0Ni?=
 =?utf-8?B?dHl2RXI4bkRMK29aSDZrSWNvZDFKSHdKb2Q5VXZlZ0xwNm10WktZZytpQWNj?=
 =?utf-8?B?SVVtSlBOVnU2M29NQVF6SnAwSldndDZYaG10bkw5NCt0VWdWZHNOT0hCengw?=
 =?utf-8?B?UTEveDBDN29VdE5Kb05yUFJDVFhBTzRqTzFKS1F0N2FFaGUxcCsxWkZQazk5?=
 =?utf-8?B?bEk4Z2FqR3lEbklrQUtLa2FZK3laZzBkU2g5VzkwY2VuVmdLUEVMMzg3SStm?=
 =?utf-8?B?ZWtVcWtLZWdRSldtc2ZMcTZGTy8xZUszbnpCZE5qRmVNSFN0SndmcDZ3bkRK?=
 =?utf-8?B?YzZ6VkRBVmNIQ1duUWg4QlF1SXExdkIxS0NMY2JaWTA5SFVGUVN0QWxNWHRC?=
 =?utf-8?B?dDM0Z2FpWDZDdVB5TGtid09yUTMvSnRTK1k2d2lCV1B1WGwwQmtyVG1wNUxN?=
 =?utf-8?B?L1pWMU1YOFNaUjIxVU5DK0o1aE1SdTRtQ0hJT0Jucm1SV0xDeVZrRkg0UUdu?=
 =?utf-8?B?cFNiWjlqNkhFcFUyNXNmNkdUN1U0ZDRKNE95T1JicTRhQWxRVzA0NGxPczFR?=
 =?utf-8?B?azhVSXJyWDBGUmFIQXYwcVNMYjhndldnakM5TmN6MkRFc0xIZkI2Vks3elpr?=
 =?utf-8?B?d0ZlU01CamNzQzRLdFVqUGNnaUlITFdUOTVkYXRUN01XcWh6Z004T1NKNUcv?=
 =?utf-8?B?d0JiZTRubGk0N2ZVRlBZY1FFejRxa3J0c3BIcUlNay9NY3h5OWxrc3lnQlkx?=
 =?utf-8?B?d3JmK1BWOG1objRDNVpPc0xTY2pUbCtGaVQ2Mk4vZ05yZGFFbDBueE5LZE8r?=
 =?utf-8?B?K1ZRZHptU25NNmo5YlNrU01TWlM3VzdVT1hXQkFuU3RJVTl5L05RMmRPUHRU?=
 =?utf-8?B?OXF2WkthK0FsdnhwSFR5QzF6QjAvb1R3VW50eFBlTmVWeE1yaDA3TTl6dUtx?=
 =?utf-8?B?ZzFyWTRiMDBwRDl4c2ZYcVd0Rmk3aklzenZPZ1ZhZFV1R3B4RmZveFljeXp1?=
 =?utf-8?B?N094clBkbk5INFV2YkxLbmtoRXlsVUNwTXJ1c2JkVGNiUUhnUWZ1eVcwSGRS?=
 =?utf-8?B?dmhLVDY1bXpFQ2N4UkVMRGNjVG5CVzRlcTZFNWM0QWVHLy9kUkNnRStyZEVx?=
 =?utf-8?B?OFE9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: f80ab7ed-dc8b-4647-8697-08dc31f7e6ea
X-MS-Exchange-CrossTenant-AuthSource: DU0PR08MB9155.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Feb 2024 09:39:58.1212
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UeTGeer2+0eyI0EzktxER089Q989OWb29OdR7foK4PZ4VNMZhSa24wI4ygR2I9joAQhM8ynx1HSti74ZntVVwCsyS0AVNLog/s1doGgRW4M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR08MB6763

Add defines for the pixel clock sampling modes (rising edge, falling edge,
dual edge) for parallel video interfaces.
This avoids hardcoded constants in device tree sources.

Signed-off-by: Michael Riesch <michael.riesch@wolfvision.net>
---
 include/dt-bindings/media/video-interfaces.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/dt-bindings/media/video-interfaces.h b/include/dt-bindings/media/video-interfaces.h
index 68ac4e05e37f..02d8239c2038 100644
--- a/include/dt-bindings/media/video-interfaces.h
+++ b/include/dt-bindings/media/video-interfaces.h
@@ -13,4 +13,8 @@
 #define MEDIA_BUS_TYPE_PARALLEL			5
 #define MEDIA_BUS_TYPE_BT656			6
 
+#define MEDIA_PCLK_SAMPLE_FALLING_EDGE		0
+#define MEDIA_PCLK_SAMPLE_RISING_EDGE		1
+#define MEDIA_PCLK_SAMPLE_DUAL_EDGE		2
+
 #endif /* __DT_BINDINGS_MEDIA_VIDEO_INTERFACES_H__ */

-- 
2.30.2


