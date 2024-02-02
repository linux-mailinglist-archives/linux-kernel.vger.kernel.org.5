Return-Path: <linux-kernel+bounces-49231-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73734846779
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 06:19:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 984D51C2485A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 05:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2CD17556;
	Fri,  2 Feb 2024 05:18:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="Cn+WwtLU"
Received: from EUR04-DB3-obe.outbound.protection.outlook.com (mail-db3eur04on2046.outbound.protection.outlook.com [40.107.6.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC2817545;
	Fri,  2 Feb 2024 05:18:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.6.46
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706851132; cv=fail; b=IoVHQnJUbi179qci2zGbAkfKaqoE603pbPEdaqrpP1I89uotApcn+cSW5bt+KiSVPNZ/J0armfoSA9J9didsMp8w88qDZraWrBN2F4VxFm/Tt2BELqI2AGaCx9qCBcU1ZrI6DqjrCIe2uAIsgoeW7N7iqaptlH4e2KC7Yg7Tgms=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706851132; c=relaxed/simple;
	bh=sjGEkJhHnXgrHk3IBqgyTJ4WadrJYhFXprieOqhc8tM=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=ebZhGpmMDXUKi6I977aIRihVYKqmGBJYMRrJ5h0tlGT0DbNXBgVr7QbT4mE35d2HTsRKwI2UujeysUk8F8wnQJpCkTYkEjOI+a1MzTiECb62chxytba1bMMAXzeKvTy0yvqMKtAg2VosAa4ogCXc45L/FDUTlMftQq671mCFMfA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=Cn+WwtLU; arc=fail smtp.client-ip=40.107.6.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UHHL5ifzNQI7K2UDOB1ywJ65gSY14dPiMSCU4c482U7/k9SeHDvQtpzFbgQVdwd46aYzt3IdEjeSbZCC556lONMC6n2f8BRMh/cUQfMRW7o183owhV4A7mtUFxiM1dbmVAWwu1wjP6UMjSdUixPj6DaSO2huU5MZIlYhehkEEeUWwoePZJKobrwTWPaXQe+GvU9ajQ+CbBBtbTEhKyN9g5botoYawpbsAaIV+Qatfe9zV2itWNn8Gxqp5BZ1PeRb8Ei+P4uW8yefu6e9t6y4p0KSq+xXdWqL1oWO5ft3c4QRGGNMUKZTj1RCBH2HI+swog6kPPBlboGBlq3oUkKYzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1M/l/fgmun9nudPOUbQiJbznRCe1rmKWD/tCAu+ncNQ=;
 b=Y12i6vv5Vc/5omJ8k2L158ijQwhX8/bxhUKGHlKWUJLFfkDdtFDvn1Dae6GtezcoEEbhuEoOXZjhSKdkGd0AEEVIcgipnM03ZfN4EzSrDp/jcCLu1XRo3ixa1Pl2YunjA2rTN+deytSvM7dQuMhAHRilr+jtTIOtVU4cJO9GQ7B/HS7CKqie155DCevaRp80ACWoPDpIDAt2nOj92gcECqjynidTjN/b32lrhMtDfBta6rWXWtWZ0oUKRdV6PY0Imqbq7FqVKri00tp4E8W4oRMRWGN5nVQEHWSihryXbxnNwewb/PzwdWcR8fwiB8DZpQHxQW1zJD4NwTKmNgHEzw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1M/l/fgmun9nudPOUbQiJbznRCe1rmKWD/tCAu+ncNQ=;
 b=Cn+WwtLUeRIIelPNc0U8lShmKWN5EMu6MBvGl0waNjMWlInL+4Aq+OoryytuvlIPLwpDQSvpoqsAv7R9CfiswVeMTK8jZzNkRur68SQRWtlA00qqPzVpN+Yum5dFdLWrA8EWPr1aZYQjdkRhvsN5QyKZdf78ps4ugq+CFrJzv1E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by GVXPR04MB9996.eurprd04.prod.outlook.com (2603:10a6:150:117::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Fri, 2 Feb
 2024 05:18:47 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::c8b4:5648:8948:e85c%3]) with mapi id 15.20.7249.027; Fri, 2 Feb 2024
 05:18:47 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Peter Chen <peter.chen@kernel.org>,
	Pawel Laszczak <pawell@cadence.com>,
	Roger Quadros <rogerq@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Felipe Balbi <felipe.balbi@linux.intel.com>,
	linux-usb@vger.kernel.org (open list:CADENCE USB3 DRD IP DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 1/2] usb: cdns3: fixed memory use after free at cdns3_gadget_ep_disable()
Date: Fri,  2 Feb 2024 00:18:28 -0500
Message-Id: <20240202051829.623273-1-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
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
X-MS-Office365-Filtering-Correlation-Id: 69c35422-9454-4245-962a-08dc23ae6ed2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	tIu8BsNwDkKIIY95JubNiwFYV8WBr81zEdbCjOYUyTF82k+51us/JRbnEj2wvfiwMQqlyMEwzhBWDPN83lOGxs7+OzQGUJEpD4XztWxNjotm5u01Dr1hXTT6wpIW+3Cz0nx1W8UCzJVUK2MsVbmM+gxMzmJEY3O4af1pLvnqTwleVdwyP8TT1FhMusF5/h9luQhMrGCcFRw5rNPolLwWVnFiAfY/34m4KvUBrqoPOxrgMO+8+UEVNoE5P9PtI3LSNAamPKZCNl8ldbtAoafKl0+fE842zJPSL8dtFvCZIABVdwYVfoLGdPTOwGxC/OJJoWk+vSdBCfzwq9DEzxnLKmeVrO7gL8lD04WKcFJ8idsgN6f5hSyMWI4qt0Z8hNgSmBvh17eh812TjBeGvpuK5lQIMM4Do1k/kT6pLan3dUeKuJwpCu7vcksEUpnWLdj9aNoxcz1Ki6xwxNVVOtXJUKB5IXer+mcj2BbDiJcKdino0irHiythizQ8YDMgFn2vtXHZEECUjPBhzQ+S9OOo7sY7NuO6Ja8tS6U1IpCvgSdUM/CfuUhSS3G48RfsJZ133qc/WrKZeJMtD7sW9Z6xy6d3boa4JwI31AyrQaAcTpaQLpbqCE5WbHg2gkZD8778
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(230922051799003)(451199024)(1800799012)(64100799003)(186009)(66556008)(2906002)(5660300002)(86362001)(38100700002)(6486002)(478600001)(36756003)(2616005)(83380400001)(52116002)(1076003)(6506007)(6512007)(38350700005)(26005)(41300700001)(6666004)(316002)(8936002)(8676002)(4326008)(66946007)(110136005)(66476007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?86K7WEAw2MR2gBLJhrENjoO/DyscrO7Z+VH0tMoRYeWc68GoGkcUsVibBFdi?=
 =?us-ascii?Q?EfM+8iy6kW6lsfdxodlg0Px6x+xdFT9TBYo+5BWqE+w/j9kYpsFcuPsmhKjg?=
 =?us-ascii?Q?k/nLFxYg1iwMaGG3wvNDyHRC5SKYSJEPX8lE8AUNqj/LxJmeoXFRK8vXJVga?=
 =?us-ascii?Q?3X+34xaGNq8QVforxZI1URSAsbkg+puPh7qVM21phr5Is8YkBymv5su+cN/Q?=
 =?us-ascii?Q?5AakXqCvWxfRl82O4XN1m5nUqHhFrD1onsCPDtIRc0rL13IvgpqVKLdc5k4S?=
 =?us-ascii?Q?IrjWnJ9bPtRAtl1diS4RKUlauM72c1ZmYXTWw4na8TAHl+osF8m6jkjTYFss?=
 =?us-ascii?Q?GzkaIYSk1BmzTDo/3Nf+/OyMPZqyJl2N5qulK+yHB4du5OMTKmGpiASPUOsh?=
 =?us-ascii?Q?FiBwO7L8jPC6EJTquIuHV+px4xOOUohRaP47xDQfHI4Ua1E1upxAn0Sz+nec?=
 =?us-ascii?Q?GULuOnyASo8/kRHeQGMW8ckMwSiF5o+bOlU+D+gn/SxJTQhiHQmUsomNEpYE?=
 =?us-ascii?Q?UuAXW8pd6EWmnYwSrJ1Fl4Og/JUJg1P47husJYDSm1MVnSfpAaYHe/9DT1jK?=
 =?us-ascii?Q?sNw6/ynZAVKPkCCf+P/dznFO9xZQIyvU+5uc+JhkJo/jGzv9DsvmizjCehrA?=
 =?us-ascii?Q?sAcAtyoXEtgl6Ms/SJA4H2bF4z0N9lBX1Swdx6BMqam1/PhKoBRIm0CnQQII?=
 =?us-ascii?Q?QRHpPkq7f75vXrIGumWHh9TiouWxZaolWYNNd316sK+HJ9sDJNwl1xWqWE7V?=
 =?us-ascii?Q?6ShwzgXPXAqlLy5UCYbHs99tUyNLaTqCenJr9fyBieo8NglpodDF4wLMIsyQ?=
 =?us-ascii?Q?U6znuPykaoryWEG3pzKXMg3nS/QRVqfUNs7hGD00hxsw1L6+qZ2t7/IjsAbE?=
 =?us-ascii?Q?sQfGBS+GSWxpBb4DXeKM6RxOHGFz0HAudsmFOQro+CYRne2I8eCCDbL5/Stf?=
 =?us-ascii?Q?2Z/ipXBrlF5x9U9WSRzTtBq8qxPIJ07UZ75symABpflbEv0qUBZ4jbL/uB5g?=
 =?us-ascii?Q?53dGnkpRXeB1KqiJUG7iZpTrYLVqalVmYZ57BSKYvm5+DxT5bWazy6Ny4aSD?=
 =?us-ascii?Q?MeJhkcso2FLeBejJI0eg6tJnSJa6Nb/4gDghyDle9fYnL1OfnIWIZx1eSDGV?=
 =?us-ascii?Q?lexliLEkj7JcUitgIxV5UQiT48x5l2hyl6lr9P3Yghwq9R4l4q1F8x9TMvAw?=
 =?us-ascii?Q?ePXMhRmHeEUkAeheY+MkZ7PB40ZcVJu160NhfI/WDUUKU56VBzOHZM+OTUWB?=
 =?us-ascii?Q?EZ29EQwm2O9xJzXa/z90ONoKQGzbj7VKosQpIU+QB5V2RKZgjQYGyaL1X+iY?=
 =?us-ascii?Q?SZI9sfqRWxGPfRIMWXgN3Xk6QgkyAm/ojXEysNO325XS+YucG0pAZk04ZNJ+?=
 =?us-ascii?Q?quduVFNxOyEX/RYHqp5HtGY8w+V1dEKZY2/Ca5dVZ4M2eEZYTK479zEcOaFG?=
 =?us-ascii?Q?yPhqwD0Z7AhCPFMH/Tgk6T7T7kLajzSr4dovikfrwQM41J4Bfngir2hMAbmH?=
 =?us-ascii?Q?XoeL3QlIdcui+lMrjfvWShspzpyaobDPOgqEM+8ytt2IUxJPm/BkrwdHd59k?=
 =?us-ascii?Q?DHvBudt0XKwpl9s40nwLiwuqZV+/+HesOlrU+ArE?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 69c35422-9454-4245-962a-08dc23ae6ed2
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Feb 2024 05:18:47.1657
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3NHgR78uPQuPN+1nsOwEQUgvhWoYLA+EkNSvzc2UJheg/8XiMy9KCuvBQSH030tPoozE+VcJ7AvlSqFdD6y41A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR04MB9996

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


