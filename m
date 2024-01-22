Return-Path: <linux-kernel+bounces-32264-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93C82835935
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 03:02:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B87081C21689
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 02:02:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF703A38;
	Mon, 22 Jan 2024 02:02:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b="c+mp/odY"
Received: from EUR05-VI1-obe.outbound.protection.outlook.com (mail-vi1eur05on2060.outbound.protection.outlook.com [40.107.21.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C3E36F;
	Mon, 22 Jan 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.21.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705888927; cv=fail; b=fygB2Q/ZGtLNYRLvyVn9iLy/Z9IOdc3+VkBZtupu5r7h/iCiiioNuiY73jBkPFypPY5uYAyBr5rZSEQ9NGuan3ISXhaiGrFyl5sDXx5gHYYlJUIxZkwARY9FjHYVn8PFWk8t7wGIbJqOgesqMj2FbFumUhvVeL9hHB2hcvAe3ts=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705888927; c=relaxed/simple;
	bh=wAbWUko+T4fpyOr7LfyQDoGjwOhLgdEtehgEachjx8s=;
	h=From:Subject:Date:Message-Id:Content-Type:To:Cc:MIME-Version; b=ICGjMAUh6FIFtT5sFah08QcaAbujOWcpOsDJMU5MMGkV5gKRJXIdXP3fBmW36rtexln6obIV6gToIwz91+eKkF1nmDb2A4Irm6fF+DFqQvlV4ZTsxa7xb4lZkYaoasc923JDPWpqoy+foaRh9R4sdW2smie+zw0zE2z1hTt1IsU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com; spf=pass smtp.mailfrom=oss.nxp.com; dkim=pass (1024-bit key) header.d=NXP1.onmicrosoft.com header.i=@NXP1.onmicrosoft.com header.b=c+mp/odY; arc=fail smtp.client-ip=40.107.21.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oss.nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oss.nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DoYCqs3kjxzTQjdPHhpTl3ymMRODnpp7iVn0DuJ8alfC4hcPgMblBbW6FPZervLpHREdGQOnZ5EENyUXMQuIAl/An3jbUsdg+A3+L04KIfXKExAB3rbrzZM9a6m24y92u7nR3w0j0hSnnPvzHQcmzyRrn/3ojT5ifeCoeWmzUWNJKYSyMUL4ACNVI7qgSlr61qo/saYulRk1HYUDis8Wq7NsRqfsAZKIGO0WaWfL2YxrbYfsnj3599Ao8XRWpxWDUS0k33AuPkS53qafhlhcr+ZZlTH3+745qB1DWarofSW95+k4dsuOhbIsUPswemOea/FT5D8GxxgKmzF7puiTbQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+bK2svVJ+KRz2ggApRsTeOHdAoqG0NMCOsiuDzkk92s=;
 b=Xh9LNS27WvDRCqttvuJ6qnyi6E/wm0o0EsCBLz3zeby5C/bjFd1SaLj0eKyRs/dS76WFucGEC6dL0sXbyAChyhe2R4BF0AIXb/F3GioYfqASkIa3MkWEj0vrPTNH+9H623qSO/zVSlgpG5aPnEFu6YVWLB5TO1DMevRbQbr0OKT87kGpehHYC/BXNN+ctwWxHap3R64u6JrccqMtrc0q1AkaCKuTd4mWtXfG6Bs3BnLWlZyaagBBIlzNeMNO9RlGbMaq4YTCdBu+Xx7X0CIQHQxesuW7sKflInUr49UGtuGgCm68A+l+Vk+FRMVezNjo4LRULOCJg/uosBo6D6dAKg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oss.nxp.com; dmarc=pass action=none header.from=oss.nxp.com;
 dkim=pass header.d=oss.nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=NXP1.onmicrosoft.com;
 s=selector2-NXP1-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+bK2svVJ+KRz2ggApRsTeOHdAoqG0NMCOsiuDzkk92s=;
 b=c+mp/odY11iRnBpijk1npAN2lSMWDrSUc/USc7v5kIo3JfTq8FYUQTpnqk5YjS9gRbmr6sT+5v+CDOBx4ahrGkQUXKayMxQ7XIYSdsdERLfaHvLC/yINMz8JC7chrGqm9fSpvQRMQCLjr1WrpLOBt7EwiEEhzE/mJ1MT539XDqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oss.nxp.com;
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
 by DB9PR04MB8153.eurprd04.prod.outlook.com (2603:10a6:10:245::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Mon, 22 Jan
 2024 02:02:02 +0000
Received: from DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6]) by DU0PR04MB9417.eurprd04.prod.outlook.com
 ([fe80::c499:8cef:9bb1:ced6%3]) with mapi id 15.20.7202.031; Mon, 22 Jan 2024
 02:02:01 +0000
From: "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Subject: [PATCH 0/3] mailbox: imx: support i.MX95 ELE/V2X MU
Date: Mon, 22 Jan 2024 10:06:23 +0800
Message-Id: <20240122-imx-mailbox-v1-0-81413f655210@nxp.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ/NrWUC/x3MMQqAMAxA0auUzAbStJNXEYeqUQPaSgtSEO9uc
 XzD/w8UySoFevNAlluLpthgOwPzHuImqEszMLEny4x6VjyDHlOqyN4R28UyOYJWXFlWrf9tGN/
 3Ax/9AUZdAAAA
To: Jassi Brar <jassisinghbrar@gmail.com>, Rob Herring <robh+dt@kernel.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Dong Aisheng <aisheng.dong@nxp.com>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Peng Fan <peng.fan@nxp.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1705889191; l=899;
 i=peng.fan@nxp.com; s=20230812; h=from:subject:message-id;
 bh=wAbWUko+T4fpyOr7LfyQDoGjwOhLgdEtehgEachjx8s=;
 b=974gYbXlRzYItSgNehC+/rQurD/zZDeOn4QJCqe3zBxrjFS0PpOuht33Gz5vuj7OAArMMv/P4
 qjW8qKz/caGA1DW2JadIAC2v3wGMHbyH2SdILZtBu+sMbR4ag0TNN4Y
X-Developer-Key: i=peng.fan@nxp.com; a=ed25519;
 pk=I4sJg7atIT1g63H7bb5lDRGR2gJW14RKDD0wFL8TT1g=
X-ClientProxiedBy: SGXP274CA0019.SGPP274.PROD.OUTLOOK.COM (2603:1096:4:b8::31)
 To DU0PR04MB9417.eurprd04.prod.outlook.com (2603:10a6:10:358::11)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DU0PR04MB9417:EE_|DB9PR04MB8153:EE_
X-MS-Office365-Filtering-Correlation-Id: 8ce57839-f488-46de-cb97-08dc1aee1fbd
X-MS-Exchange-SharedMailbox-RoutingAgent-Processed: True
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mNQ/lVsdTobilSjGY6iypAzvsZZ8w6wNXktOBNw6FWK97huouVoDcT+nXM0ciEvtgSOS805de0htjeahs4qo9InS7ogl0fwUgNdiYJkx60aGUC34zZppqPvojP4HvFePbZePuGYOw/oDEcF3qeb+aJ1uUj5eMWAJtp7hikcBrmQ4T1JmxQ4XSUNYg4GSiMqcT+3o05rXJDVQFBCZhQCy0uhjNT8dFf1jKSBstZvqOAIHqBXn9MStN4xtepaPFer4xLFF/B929G3kksYTp+0NLIFkke9TOpEKvSIJ+GhjLcvBwtn+Nzoa9WMa40ravXu1Zehe1PiaTqyuRC+AeEyBW0sYR0+3cmZ0XjxZQtrPIa4ugPQTOqZsBkaK6z8m0eIgExiH4xq/1/x2Ms/DeHetv6/uhVkty/KMAGi5J5lohs24WmEDZ4iHlDhEV20dlgnm/AZAOs5maH4OYQbZLsQOj8nezTrfBzqoTn0Equ4IyBbw2UXJ86nbdriJJHJ5ZgzKc14Z+RjlcuCNe2q+wCxr0NDZXOCPA7prHYdbYGx5KH7h0vEb/zeRqDe7YChM6/5BHVKQD6HqV8I0cNxC7AtSq0b2MIyVMLmNwGy/JE4YN4Ub3V/ALPjgLXvi1861mW2m8PurdFa03eFNqSO8eSNEaQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DU0PR04MB9417.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(396003)(366004)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(26005)(6506007)(6666004)(6512007)(9686003)(52116002)(83380400001)(478600001)(5660300002)(7416002)(15650500001)(4744005)(2906002)(41300700001)(6486002)(110136005)(8936002)(4326008)(66556008)(66476007)(316002)(66946007)(8676002)(921011)(36756003)(38100700002)(86362001)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?SGV0VUxtN1NTQmVIZzZYeTdyUi8zQk1rWW1FOE9abktNdkEyZTVpamcraXVj?=
 =?utf-8?B?cUN4ZnYxZTdWTWxvZTBwbE40Y3QyVC82V2xLam5GZEowVFIrcU5ZTll6eFd0?=
 =?utf-8?B?NUlITmJMdjZ3L2xYTi9DNzRLWnE3VWYrOFg3S2U3NHJxSk1lWWZTV21iYktG?=
 =?utf-8?B?cjZOaG1VeTdjcXRyZnNvcmRGRTlFMnprWHoxNGZLR2dBS2p4Y20zQTQrS1NB?=
 =?utf-8?B?cHorUlQvaEFOcVJZZEZLQXF5OEk1eVVuMzNWaW9VamZGOExLdGQyRUEzeDIr?=
 =?utf-8?B?UHlqNGlELzB1OSs4Z0lQeFJ5MGEvbEpkOWhINnl0UzVycFNCaUoxR0NUZHFn?=
 =?utf-8?B?dmJpZUR4OTdmZ0NtVzErNTE4d2VrK01vRFl4L2FUZ2FNSy8rV0dCdk1CNGg5?=
 =?utf-8?B?Y1FaSmYyTU5WNUJRemxkVW9UMHhkRVZ1RUxjS21CTmEzUjkwVHhERmlTNFBp?=
 =?utf-8?B?emxjeW1KeGFoOFZZeXpYYWlaNnIyNHVhZStnRmFrOTFBN05qRVNoZXJKMlpq?=
 =?utf-8?B?WkFDZDNzdjVPQlR6N2N5d09lTUVvNE1WdG9sd2U4MHdlcEVDYkJpd2xoaVoy?=
 =?utf-8?B?QVFrVVpRcys1aGNab1ZyaFJUOG9ZL2NlV3d2S2VvNXhhZW9HQlVJUVFpR0dR?=
 =?utf-8?B?VkJSWFZpTk9PNVowOEw0MW13OEpiUk0vM2VmcmladlR4cmMwOVFRWnZGTThM?=
 =?utf-8?B?ekxTM2tFdytEaTBIazRGRWxzdWo3ZGZMQ3BVeWNqNGlWU2J4ZTZLWHhjVmVn?=
 =?utf-8?B?RE41eXZsa2F6bGNxVksvUnlhNTErL0FNYjhWUUtnR09sNXpMdTBoRHQya0Nt?=
 =?utf-8?B?bVNpQUcxQmdiUXJ3MTVTUjdIUmdRNXk3d0t3Vk1id0tLcEdwdkdhMkFIZXdu?=
 =?utf-8?B?NnlmYkZyakx5TVlDVHdhekN6RmNkUTQyWGRremVya296RUtqSElPTVdpTHJj?=
 =?utf-8?B?Wk5vWXAwbHhZNEJSdzBVb2xVYmF0RlFYMDFkVFJPMHprZFlkK1UvWWZaaFZs?=
 =?utf-8?B?N0ROb1JDS05tcTdMM0lhV2xyOFRkd2ZmTU14OUwzcW5zRU1VeUhuOFFoWDhp?=
 =?utf-8?B?V1h0dExybGFlY3NPWWNpY2wyQm85SFZoY1ZGOC9BMWRSL0xjM0tsUmVNdExC?=
 =?utf-8?B?cUZ0bHA5QjVVOFVJU1VyQ3ZQOTMvRWxTcXVwTjFna2tNejZIM0U3YkVnQlpu?=
 =?utf-8?B?SWZvSkpBMjZHanlGQnZRWEJCaUlGNWR2NHBrUWVlU1FpU0VKcVh0ekpiZzEr?=
 =?utf-8?B?ZGgyWm90U2hGQThKRkZaL0RwamNFQVh6c3RMZFhsSm56NlJTM1BnTXN3RmJK?=
 =?utf-8?B?QjRnS1ltVEtPVVJjelRLTHpHUmNTUEE3c2dNMzZOQUJQUVRQSnpqYXBid2tG?=
 =?utf-8?B?a1p6RmFOOWlHZVdkdnB1dDNyM1ZEWmdTV0gzOTZSUC9YYU55cVN0bk14cTZH?=
 =?utf-8?B?TjR4ZmY5dmtwOTlLbElVNW5EU2ZtR1M5emFaRExaWXg0L1ZhdWwySFB2ZVdH?=
 =?utf-8?B?VlFLKzBncDBiK0VDdnBZWkcxeFh5VmM5NFI3a3VCVW1oSVlCZlZ1WGFUSVkv?=
 =?utf-8?B?cFJHUUFiRVlvMmlvM3c0aVl1cFo4YmlPZ21YandVRVVSenhlWCszTm43Z0dU?=
 =?utf-8?B?ZUxrSUkwZjdnRFZGaGxiRlFJTVNpNFZRMUEyalBneGwwemJLY2xFcXAvQUZ3?=
 =?utf-8?B?T1VZTWFzSmJlOTQxdDBoN2doOVhiRk0raXF1SmtXbHVNNm4reGtMb0pkQ3dt?=
 =?utf-8?B?aWwrRDg2MGZQNjVHNE93dno1Q1lCVDgwbW83MnpkbkpMMFpTVUkzZ1o4UXJL?=
 =?utf-8?B?Ty9USEk1S0dWdzM0SHpIR3h6QVhLM2VwSk9aTk5EVVdmY3UxV2NKdUpVRXJC?=
 =?utf-8?B?aFdQZEd0M01IT3ZYWDlKbjJjZzc1emxyNkRwbVZtMUhYNDZEM3YzQ1VlUzlZ?=
 =?utf-8?B?QUNsUEg2MUZsY0dnckQ0cVdhU213RnNBZzBrZWpuM25OWHU0YUlVZGtDb0tP?=
 =?utf-8?B?bndFSzNna0tpRDlpVjdtcU84c1ZBNStWQmtLUCtjY1dSRmd6c2dqNEQxaXB6?=
 =?utf-8?B?aUdVS0p1Y3c1VHhnYlEvUkVNekNQOSs3SXppWlR5S3pEUi9uQklEd2RGbk8z?=
 =?utf-8?Q?uDdd1M+N1ZMJScZB6R+4LuKD9?=
X-OriginatorOrg: oss.nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8ce57839-f488-46de-cb97-08dc1aee1fbd
X-MS-Exchange-CrossTenant-AuthSource: DU0PR04MB9417.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jan 2024 02:02:01.8564
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UkTH+Ma+Iojz2sfZ+ltDeKtb034P3tvZNlKDZNiguR2cjo5k2+ZPCeoJGqM9RekuePqcuT+JExodWd0iBtNsag==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR04MB8153

- Add dt-bindings
- i.MX95 ELE/V2X use same register layout as i.MX8ULP S4 MU, but
  the TR/RR num is different. To make code reusable and not add too much
  macros, add runtime detect number of TR and RR by reading PAR_OFF
  registers.
- Add i.MX95 ELE/V2X MU entry in driver

Signed-off-by: Peng Fan <peng.fan@nxp.com>
---
Peng Fan (3):
      dt-bindings: mailbox: fsl,mu: add i.MX95 Generic/ELE/V2X MU compatible
      mailbox: imx: get RR/TR registers num from Parameter register
      mailbox: imx: support i.MX95 ELE/V2X MU

 .../devicetree/bindings/mailbox/fsl,mu.yaml        |  8 +++-
 drivers/mailbox/imx-mailbox.c                      | 48 +++++++++++++++++-----
 2 files changed, 43 insertions(+), 13 deletions(-)
---
base-commit: ad5c60d66016e544c51ed98635a74073f761f45d
change-id: 20240122-imx-mailbox-243021d12030

Best regards,
-- 
Peng Fan <peng.fan@nxp.com>


