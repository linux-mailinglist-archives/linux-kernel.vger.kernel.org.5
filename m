Return-Path: <linux-kernel+bounces-36646-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ACB0083A453
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:40:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D1892887AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 409D11798E;
	Wed, 24 Jan 2024 08:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="ZtkUA70i"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2079.outbound.protection.outlook.com [40.107.21.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D6E417980
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:40:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.79
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706085614; cv=fail; b=PX6p4h7VtNh3IDhyg9zGA3yQWO4NvifJ1rhViPNZK3uKn2LhVDL0lja+QPz2zdRCMA0FHC2Hy7tsPLQ2DFncxwzFRQysO68JDHcIYelb1SglnI19gpFWinK0MHKNfFsyuvOw/SIvyWFLu2Ooq6if4QcodQBc72/tZh2W6EqIjko=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706085614; c=relaxed/simple;
	bh=r4qMzkoZRSE6PLOeCrYzIvc+jTvcHs9ZNV2b9BqTHcU=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=EfZsIyhW5GsrVzw+l7nvSatZ1yLfPvcVriZsxxOzbr8ImgL8erPr8uPjIeK1o+3Y+6BI4NaAgRn9Rnor5OoLf2yEezOpLLjMpK7AAb1lteLLAD4rkYuFdQk5yx73YAGmPw8p4KaiZlGQ13jV/edTzoXW7Up7FxhfOrPGPPwLpmw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=ZtkUA70i; arc=fail smtp.client-ip=40.107.21.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Dl4xv6EHVIK5FilBFCbNVv4wndCbe4DhDIK2W9qvTOdaKTNpihxUtSZR/0PNScmCVXKZKJHjoDEzAGeD8pvv9UmFDrYOLXda9sdAE7EiBb323ZiQSy4s4/9VVSHZjPdh75Ot+msGIdqAYLav12kiOnawU6z2cgsiWbrJ5Sgj2NXK8DPyz37jvV5le0MjKGbgQu9vaI2VJaNTu0e1VPij+5cY6zwyXjf3tP8LkCUS3r8GeZHvuM4hRRuXgGsqFtbkgOQFuL4VygiAkMlV+RTVKdQjdTWHF6voMkvWKFLcZ1INloupwDN59fXYbvzdSp2JxDJXM8QIRr3b27pld3V0zw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VYJn+eCOQ4JTTRQzwK/YWaYeGQZCUL4YpQsCf1W1SIo=;
 b=BdMG5hdj1td1ID4q3w2RkLmAB7b49k250YvbMFBRPyiQAwf6viHTi9lXLTxA9hMpJvoxbTaFOTSEaOh/Un5S4aGHqY9YPzTbI8pm0feS871Cr+b2j8aBk1/4vXv41v6Yrake9U8ycGZwfrmRsKICgfJah2/49i2KADHxzbtE0IGzkFNFvbJtd/9ijx8bNZ+O/jB0fxnO2IGBpzO+26gjuaJPZr98kxRIPPTM8E1o3AH9EXfFFiHvpzj/xfeyiQR+zSs2a1gcbl1qLnaoeCMpjZYXI6GvMVaszPyE4d70KsuqBtNU2DttwqlX+N4v51zeCFRfH2s7IoxujIaJAwMzPw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VYJn+eCOQ4JTTRQzwK/YWaYeGQZCUL4YpQsCf1W1SIo=;
 b=ZtkUA70ih/husquPis2/GrSFhibMxHGAk5kHpjiMlzOS8gq2qY08/ISNHn90zII4mtuL419d1uU3U/1oO8m0lSS34vQ991oOM31jsb5VJlFUKAJ6L5bFgqhNcOrXAn0iBM+7yBs9nKJ1BmxOtedVn7LTVm/DJbqjBixtSHHKJNw=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com (2603:10a6:10:2e1::11)
 by GV1PR04MB9104.eurprd04.prod.outlook.com (2603:10a6:150:23::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.22; Wed, 24 Jan
 2024 08:40:08 +0000
Received: from DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0]) by DU2PR04MB8822.eurprd04.prod.outlook.com
 ([fe80::d45f:4483:c11:68b0%6]) with mapi id 15.20.7202.035; Wed, 24 Jan 2024
 08:40:08 +0000
From: Xu Yang <xu.yang_2@nxp.com>
To: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	saravanak@google.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] driver core: improve cycle detection on fwnode graph
Date: Wed, 24 Jan 2024 16:46:36 +0800
Message-Id: <20240124084636.1415652-1-xu.yang_2@nxp.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR01CA0125.apcprd01.prod.exchangelabs.com
 (2603:1096:4:40::29) To DU2PR04MB8822.eurprd04.prod.outlook.com
 (2603:10a6:10:2e1::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU2PR04MB8822:EE_|GV1PR04MB9104:EE_
X-MS-Office365-Filtering-Correlation-Id: 8f5e99b1-bdd7-47d5-fec8-08dc1cb81224
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	VN9XTgvwo+Vqof3kVG8frxhul4qmDpWqTki4ceIcZoTl2vjmyVR9TL2A7UUL2rqrwNFAtVU2ONxIJ3ZvesJdZC8eG13ucULGSRRoq0+Hp4sy10CgGVzXgTcqku95g3AZUwfFvIo4tTD/rxThoYh4x0TvSsma/Jb1VaXL6xS5A5RHvyoB3B0in00xFkiwsLEYOtp/O54eMyEcDsg5t6ktLAR9L7Ei2PHseZjeXtI82Mxf9BKHttloUqQemri0nXg8KcPawKXJDeYj962RRrINjjZPjLxZRnSyEdJsLQGRS+Uxz6E8KFjBoTxlWQ1ENr/YP3kJ6H+vqzfFr/Ks2m/TMBekEa3ZSgRblxMko+QV5NyNxVOOEpLFLIyWoSwwtH56/vjh6AQzd801r/2xnse2e8GxJFkEhWV8/MuO6pawvFNHCw/b6Lc3ETbMQWAHkSgn8rBNhqj7GyKOaNwO/ZzxcQcPqwRiWQbsjJC4lEHvMY0oJbzs3psO4NyddLIFmAvypU0v0PVQKQjcTSR95LZJZJ1LykZT4HrCrNFdGqitVFwfafwBLN0K72QxsQfkLi4vL4lZlqoqDx+tEUrBG0aGEnBnYuVPo4MzWAGI0ZcPjxqPvsmZl/FdWnmLcSDrTdu1
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU2PR04MB8822.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(376002)(366004)(396003)(39860400002)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799012)(41300700001)(83380400001)(36756003)(86362001)(38350700005)(38100700002)(1076003)(2616005)(26005)(6512007)(6486002)(2906002)(6506007)(478600001)(66946007)(316002)(52116002)(66556008)(66476007)(6666004)(4326008)(8676002)(8936002)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?dsmodTnWvxPkrYbgKYrbP3rJKAVD/B52sATdhPO9F0SkPEgy0nfl5fNlEFtR?=
 =?us-ascii?Q?CJE5UUxJFY9i9nEfObr3wXRBxELhMNW3B0H51jBlBZj1XQQXTU6xaJlIbiTF?=
 =?us-ascii?Q?+M7RKIggz7rqASEnSWLxMVz9phKXquAoIs6Fwxsc68Cx2+sgRNhbzK8dooeK?=
 =?us-ascii?Q?/pHGWcCMwQK9wIEsOeDHIeehiTRxNp0s02R0u0rJJkA0Vimu14Xfl+6y6GJU?=
 =?us-ascii?Q?oL7tUfZbb5I0uCEV9CbxxclVVwD2cQnWnLppudZv5ReOSXblX62Y6R96XqD8?=
 =?us-ascii?Q?Kry1Ssm1CdcMKri1Apci83ljHgY84b7NpduCrc5gub5cAEUkGL6MTxq/yKPW?=
 =?us-ascii?Q?DS/5VEqxlSPRuxOkXwtcbHTpIPRqPFnpRYXcKzWrFDExIRu785KAV4fPtyNz?=
 =?us-ascii?Q?CBeOt9Frjp5dA8uu0dEgnRxd4WwjP1AfDazfNg6kMaRjaiujAz9SnW8Dd/NK?=
 =?us-ascii?Q?kfiGuukaVxNvaSuDHd6xC3Rf5lGvCC3F3FNbfRdc/TecvoDIrBVhKXaEwHBZ?=
 =?us-ascii?Q?gU8Z01zAGxyCvOqrEgWiXji25f3ia33t9C7NmTQEx7RjI3v3pX+VvidGm4MG?=
 =?us-ascii?Q?dwpQbuCv1s18Ord/2prXZx5p6yAY55uTS+J3Id366K8dc5fE8sh/9ygWoOep?=
 =?us-ascii?Q?l4AtQowi/EEp9Az+gISCEvNI3bFWsd4gB0uNs/MJd/tEQf5wjdKcsv3nLf6A?=
 =?us-ascii?Q?KnI8cCdVawizkX+IdXr8Jtl7NbiQQYtK1fFuQNnlMCr+M1i2ANU/JVbNQ3dp?=
 =?us-ascii?Q?edGAiW08KuT26rLQFMS7eUzW5rzI2z5WTusipfgT84ZfFqHRmta6+ehIxXRz?=
 =?us-ascii?Q?uidrPYn4EPk28FPgqzO+1xJhBB8ms1x4M01f1b0cYlQimfYohFlrUSRjLkzo?=
 =?us-ascii?Q?7Y+6XkmeTRzx+Aqx7ECsSZo70ne0n8F9EAonaZzZSZn/YMI9rh4Ms7a9xScr?=
 =?us-ascii?Q?wLFcMLrv8mJz3bHmyF4HwQCAzLLA+9L9EX4uwynA2E92Imea2+8pGU7xW2hP?=
 =?us-ascii?Q?2vateFm8fd+oLGD7U4QuG4KiVmWEbcdd/LWtX642fffTO4M5/+uW4RmBxSjV?=
 =?us-ascii?Q?Up8hHp9TtIULu6FhqdIPu8pVicoASEr5pTamcpLTnIgfpK2HpQZJ1EmQPm37?=
 =?us-ascii?Q?/MJTuBigmLqqndMZ1MelUza1eYoZlr8yW85n5wiMgLeB2CUXropF//4uOR6j?=
 =?us-ascii?Q?vk/vGVa56CqPXDiGHIs6HyxKis9coSx1Y7PColjOx40w8H1HCBpXo8uabpg3?=
 =?us-ascii?Q?HsS2/OlJYvOEShF2sCbkSu0ToHznrSBVmO8FUgK/oh9e2C+O3IdtQMxruvW0?=
 =?us-ascii?Q?P4Y3/P3PknKFYSjjbBeH5X6bpeYa2dpQA5yOTXpZ0CsSQ0yXsvzJRjnA3Vjn?=
 =?us-ascii?Q?xL1QKG2lx8fKFwRM9ivAvpfb6krzHf96s8MCxjHpPpwGq/WcqdR6MBUKRzhB?=
 =?us-ascii?Q?NxYFW53jIuYM2KkliBSQBfpl6TMQRZDFPPB3CNS7MTLvjxRVhxS8GnvSAPv2?=
 =?us-ascii?Q?LcW5wZGelxDFmVMVvjnAFO8MGa/if1/H/W8mUnOF6zHEf7LjsV5lIqqboVza?=
 =?us-ascii?Q?LZWAVg8aMXPIMr3zF3gWiTPcKdg/ESyhAvmMThoW?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f5e99b1-bdd7-47d5-fec8-08dc1cb81224
X-MS-Exchange-CrossTenant-AuthSource: DU2PR04MB8822.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jan 2024 08:40:08.6781
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zAHzsXie6l3j2C+64MjmTeZwjoaedr6VyBN1nJ3h7uuidM2dK3RHZ4whjLmi7JU8P8cG/j5gqKRVyvYOIT57hg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR04MB9104

Currently, cycle detection on fwnode graph is still defective.
Such as fwnode link A.EP->B is not marked as cycle in below case:

                 +-----+
                 |     |
 +-----+         |  +--|
 |     |<-----------|EP|
 |--+  |         |  +--|
 |EP|----------->|     |
 |--+  |         |  B  |
 |     |         +-----+
 |  A  |            ^
 +-----+   +-----+  |
    |      |     |  |
    +----->|  C  |--+
           |     |
           +-----+

1. Node C is populated as device C. But nodes A and B are still not
   populated. When do cycle detection with device C, no cycle is found.
2. Node B is populated as device B. When do cycle detection with device
   B, it found a link cycle B.EP->A->C->B. Then, fwnode link B.EP->A,
   A->C and C->B are marked as cycle. The fwnode link C->B is converted
   to device link too.
3. Node A is populated as device A. When do cycle detection with device
   A, it find A->C is marked as cycle and convert it to device link. It
   also find B.EP->A is marked as cycle but will not convert it to device
   link since node B.EP is not a device.

Finally, fwnode link C->B and A->C is removed, B.EP->A is only marked as
cycle and A.EP->B is neither been marked as cycle nor removed.

For fwnode graph, the endpoint node can only be a supplier of other node
and the endpoint node will never be populated as device. Therefore, when
creating device link to supplier for fwnode graph, we need to relax cycle
with the real node rather endpoint node.

Signed-off-by: Xu Yang <xu.yang_2@nxp.com>
---
 drivers/base/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/base/core.c b/drivers/base/core.c
index 14d46af40f9a..278ded6cd3ce 100644
--- a/drivers/base/core.c
+++ b/drivers/base/core.c
@@ -2217,6 +2217,9 @@ static void __fw_devlink_link_to_suppliers(struct device *dev,
 		int ret;
 		struct fwnode_handle *sup = link->supplier;
 
+		if (fwnode_graph_is_endpoint(sup))
+			sup = fwnode_graph_get_port_parent(sup);
+
 		ret = fw_devlink_create_devlink(dev, sup, link);
 		if (!own_link || ret == -EAGAIN)
 			continue;
-- 
2.34.1


