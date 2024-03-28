Return-Path: <linux-kernel+bounces-123311-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E6A6890665
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2698829B07F
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6122E55E40;
	Thu, 28 Mar 2024 16:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="k8VGRsL3"
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05on2134.outbound.protection.outlook.com [40.107.20.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9412A40842;
	Thu, 28 Mar 2024 16:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.20.134
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711644974; cv=fail; b=uCAoyf4Su/B+lGyDa8KeFnuhRDb/Ebmn9ZP2eEh/C7tn+gud+xeMGn0ZYNN824vtZLPNZGcrQKwkInUs5X8oxvpOoqJ2Q1emTf3iyeSpew/PrJrqPA6bF+0kPjxEYo/p8VDm9AwJP94kqNb6uEXr1UnMxYYTPKc8N91lR023g3s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711644974; c=relaxed/simple;
	bh=EP/47rbtwXoLrEu+2KhY1GcZMkqPqw0L8TmuyFVtP1k=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=Z8BeFZRPJbjw6PPQfKjDrGlWanX8Ncp++A6QoX7VD8Gb5a6pTuDOHY/F/Prd894rSk5YhmcavHLm4bStw6bBI2tqfkDhdj8dn5Uyxw0XCba8NTjgmrTXHdCcXusN3vjVJyW9XRKHv4fH2ssrXCF6TND+AgGSTZtPEXyA9OiYbbw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=k8VGRsL3; arc=fail smtp.client-ip=40.107.20.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c8Wn1NC0x+f2muNdoeleCejMXeO4AZixcpYXAu1s0zNC2olx8zGLRoYMc63Ztb8cmFtGJGpRKfpfhgPGMZ0RZomnWyaH+yNf6aGLP2V+/3QiQUZzxsHVXE6kJY6o9Rt/bAEL/35IVqgMzhtC8xdZGglv1uRPBFw1vTSN75LuwviP0FFNmaLKc2Il6S36Ps664Z6t+kXn27/m+NvJU6v0mNzNHgWE6c6/Hcnh/ABwPtWJEGsG6SxLAi8NDWaMuyTtsHhSeQ5UxG/BsadYSN5uVSRQNsDGAw88zS+zQDpepXdCu2XfL0IHEh7y3RWlUNYn4gFf+mAaJlUIQeQgFvuCIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BQkZk6sE6iUSJbrS/5nH9d92T33fcpDM7u/sEGH9Af0=;
 b=WYusvR6LpDpkbVHYXvQQK/evohshiJ0EsDI72r0XdFTsvzLAvmklpUlGn8rEqgzSKo+iG3sBF3kp8Kj9AX38une/B/cSi6ya4QNzD/mKaKtqcWLBscEAeWj005Nx6gRKSYDChkWvcYmFPt8O9hEr8v0WpBjQVnolzTd4ID7cq874G91vaZKmX/fPhNwN30kvu78lGf3m5U/UffZNA/k5qnbAk4Jze8fj4h91C0EaTt6bu1aUCfwUC2D82FL/2GTPpLCDhqfW7CVJa9K8V6OVhMRP+AbvwHIVM6SGKmM7bs5CGUvCXvD0cdOfMY49dpp08OyXuS7WQu0EYYqpYTko5Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BQkZk6sE6iUSJbrS/5nH9d92T33fcpDM7u/sEGH9Af0=;
 b=k8VGRsL3KReBrG1Eg8MPJ0oILh60Zls6YAH7xfuAWjMyv42xD+FhCp8oPArLWYZV5VVrfrDxTs1lrtndMZFUaPE0Krhi3aqAcTtkXK2/YwkgAmYhUDX9bbHrz45Rzo1Wm8EhC67+VDdWbHVxzIDnjUlxjlaF07x5KcclOpdntpk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by VI1PR08MB10147.eurprd08.prod.outlook.com (2603:10a6:800:1ce::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Thu, 28 Mar
 2024 16:56:04 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.031; Thu, 28 Mar 2024
 16:56:04 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Thu, 28 Mar 2024 17:55:52 +0100
Subject: [PATCH RESEND 2/2] usb: typec: tipd: fix event checking for
 tps6598x
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240328-tps6598x_fix_event_handling-v1-2-502721ff705b@wolfvision.net>
References: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
In-Reply-To: <20240328-tps6598x_fix_event_handling-v1-0-502721ff705b@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711644963; l=3256;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=EP/47rbtwXoLrEu+2KhY1GcZMkqPqw0L8TmuyFVtP1k=;
 b=8lqg4QI0D+qgSGB7iKPFemwfcPJahXRzr+h/P4sIfh9OYf1XOdPNBB9KOcVZk0B9Ll3cLR7RH
 S1X42L35aT+BhOPhSwGNZJaYMekCcbLoOdfn1/Rufu7KeZ7boAPYJhq
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VI1PR07CA0136.eurprd07.prod.outlook.com
 (2603:10a6:802:16::23) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|VI1PR08MB10147:EE_
X-MS-Office365-Filtering-Correlation-Id: 4d23f9f2-2756-4542-5e9e-08dc4f47f472
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	GaUu8npF+VXeGU4TsVqiQUI2GvGj3w7Y3ImgsvgoLaFOYz5uSb3I8WGeoaXKtRwdWzGrzon9CswIM6iDhIff81+//ZQHxtjNXdVXBHq6wtyWu3TDsyNoABYPDKBy4cmTI/++N3pq6b6JJCrNtT+gnwNm2UJszcyoPzd8pQgI0oQA86pFcvbkUa+uUBsJ8LWFd5anbLT1s5rL7zy69iz/WXi5SDIvmDW7MUdjvXMJIbl3bmplEhn6YrjB1jsQ3GDgqn4lZphwXkHtLoh2j3itVXVCL0zWCUGFxQR5J28MGWMCxqgListt1ITUBEZur/xhJ0SmXv+KXBkRf0iCQRzQy7ThAiXa670QuzO4Ff7TpSdAsSnXnlBH+SC9sFKvU3BFjmt0JbwvV1SMO6w72O9wEKETYbmCQVLeGux20Xf5zcsf42eH1gqzORuylXBDuhaWuNE7ob4lIInvpogl2N5CyWAFXLNPT/bNXzFyE0l2yiIo/QCC+CcR3EzfMoMrKuuIicKoeiJmcFJhhGyKbc1vNzvM/7PQk49e58GiHaJw6JrDK5pVLoIWP/hXT7SVkjDV2Sb/NPwSZDKH3e03JPAi99r2wkjwaQakkY0vVISEy8dFM6N4eqiOjiWHLQd8JoTquR0BDmUBILfgzpWYtIk2vumo66PoPuBceWooRFt43ajuBZPgVVy/raEEqORqqu/omFj8crCLD8PK8aVTmMy7+w==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015)(52116005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?akFyMTFvcGNTcFRsVXZNSG1FRUxEUWtPYmNhZk5PY2hyaElObmlmOUlOUHF1?=
 =?utf-8?B?aVU5bG5EbVhTamJDTTJMenZVSTIxWFN3UTZpWmVnRHBBUnUwSDhtK09ZaFZs?=
 =?utf-8?B?a0RXWW5IVFpwMWFYYTViUzNzMEMveTNTRmFEdThka3Vpci9TQWdhTlJHTC9Z?=
 =?utf-8?B?VDNteGhJVzhZUXRFblZrL1daK09jYUFkNnViMEF4Y2tJdjJSUnF6YUFaWm5s?=
 =?utf-8?B?Rkk4UkgyaENsS2svL0Fkd3dmUThOSEdaejRldGZuV3pQSUM3OU0zRDY2cVRx?=
 =?utf-8?B?QUN4ZUR0TzMxcUE0K3pNWlBpbEI4L1UydmEzZGFrMXNiOHVPVnFWMW9vRnUx?=
 =?utf-8?B?VFM4SzB1MGllN084SGpXWXZUYU4vWkF6SmJKd0NlZEo0WjE2L3RxTjQwaitk?=
 =?utf-8?B?cjhNWWYzWGxoQlkxeFFyU3NHZGVZTzRQRlJZWnRYU1Nkdm8xTE1aL1pEN2I3?=
 =?utf-8?B?RXh2N2hoODAyZkVaM0FtM3VRcStyMEY4alovMForZitOVzMwUHhCa2ptbmdU?=
 =?utf-8?B?eXV2WEVKTmM3YXBmNlR1RVlGU3VzV1pENlF1TS9jM3lpZnB0a2prZ2dmOXFk?=
 =?utf-8?B?TytnSmhJRlIrdktHdUErL2RodFpiclRoUE5YMGJDVEFBR2x2VFZpMEpRMzI1?=
 =?utf-8?B?Mnp6U3AvL3JCRUJQUHVPVmR5bGdUMzl3L3dXMkdzWmg3SXV1Z2JHOXZoYzdF?=
 =?utf-8?B?dG5icWRueC9iTGRmMUhxZkVwUitKRTZPWHk1ajh4YjFLMkhUZnNMTHpPdEVo?=
 =?utf-8?B?UlNqWTd4N0M1TjZGZ1F2cDJuTEdnUnFJSE50TUNBOU4xcHVuZnd5WW5FN0hM?=
 =?utf-8?B?NW5ldXhtTWJxOXQxbUJzUEpTbXF3UFpNY0VhZUhHV3NkYzAvTldaTDZzayth?=
 =?utf-8?B?WllrSTljMkFxVkIrUUJhcW1zaFBxMENNdzNpQUNOTnp0WnBQaWN3eWpRUWxz?=
 =?utf-8?B?eVpiWTZmUm5lSlZoSnVBUVBrN3JhYmtXQmY2SDlrbEh4SFVHbmY4cFZBcGtI?=
 =?utf-8?B?Ym5lMmxPOFJ5U2x4VFAvUGFpNHp4ZGNLU1ZDQzQvMlhVcW4wYWZHaDBxay9s?=
 =?utf-8?B?RDFTK0RHbnBlUktaR3d2NDhBK1RKYnNyNUVTc0s2WVZJL05hc2hVSXNScmVN?=
 =?utf-8?B?TVNZYUk0R0Ywajh3dHJDNnZHdXVpYlE2L3lhaTRxMG5WeTVHYlJXWVc3Qm9C?=
 =?utf-8?B?c0FrSmxYUTMxTUNLYTRsTmFGblRFZElDV0pZSnQyeUxqRW04dk9Ma3VsNk5s?=
 =?utf-8?B?eXRRMG42Q2ltQUlKOWJaWlB4VmxETUM4WWNnSDA4aDgwS0daMUNjcWloNkYv?=
 =?utf-8?B?QTNFRXc3Rmhqclk3bkhXWHNSRmhHZmhZZ3MrZUVxS21HY1h4aTJtNi9tUUty?=
 =?utf-8?B?MkZMRTFJd01aVXFyTFhWbFF2ZHFZcmNKQW9VUmQwY0JoRGR1YlNOZmFDTG5I?=
 =?utf-8?B?enJFRFhVTzBrUGlvWHk1L2ppU3lwcGtYNzVVRlh1WHVOSWJrdlA1VEtDOXVE?=
 =?utf-8?B?eFlibmh6K1ZaYWF1bGsra2xpbSt5V1JzWUlFSDdYOTB4My9Ea3VCVkZ6d1Mw?=
 =?utf-8?B?NkZFeUhNRVBaaXVYOGdkMng5UGVlZ1ZKMlMza1VLbW1NUU91UmRBTVVtc1lO?=
 =?utf-8?B?Q3VKQ053NzE1TXBjVTMvUk5UMFJYVzhkQkJrVDRHQnpFRW1XU1d3cVFPNmRk?=
 =?utf-8?B?S1RKY0Y4U3Brbjdqc1pHeWRrRjdsVlF5QWhiV21kUGFVNCtXaFlJMUgxYUpR?=
 =?utf-8?B?SGUzU1RiSVR3ajZTTFFuZlRXcDF4MWlsa21IUFovQjllUGZrcnVjcTArWkV5?=
 =?utf-8?B?U1VBRWJtWGRXNENEa0RpZHVRQXduZFJwZGZoNGJ0QVA5cjNrQWo5OVluWEFv?=
 =?utf-8?B?aFZLRHYra3F4MVk0Z2FsRHluR1lMLytNdlk3WStOQjRub2xYeEtOMmlKRFZJ?=
 =?utf-8?B?a21mUU1VYUhrZllqZFZwa3RQcXlwNjF4WHlHWUw1ZHp2ZTh3ekhWNlJvdzB2?=
 =?utf-8?B?VnQyczJwcU4rckJzU0p6ZFRVaVhHeUZWYWlOcWFSSXRvSkVvdy8vTS95UFdr?=
 =?utf-8?B?bDFjVmhxeTZVUTRqcjMzQjlydCtTUTRSdXA1eEduOXRQU3NKNmFqREEwbkh3?=
 =?utf-8?B?NVkrMTZvQjRIZ0ROc0VOeFNSNFRicW5UeGlVUVYxZ3ZkYi9ndCtpTUJGcFV6?=
 =?utf-8?Q?/11EJgkxL3mcCvsITHtSq+A=3D?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 4d23f9f2-2756-4542-5e9e-08dc4f47f472
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Mar 2024 16:56:04.3799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: dhdyC7EGQRT4K9hEG6cRHNymtW5NRlDkROSGmiM1vehvLXJTl70rTNQTw9/JYZbumO+R4M7VBmh/1EdTxsRofmtkrZmhrgLW9w33nKsIkKo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR08MB10147

The current interrupt service routine of the tps6598x only reads the
first 64 bits of the INT_EVENT1 and INT_EVENT2 registers, which means
that any event above that range will be ignored, leaving interrupts
unattended. Moreover, those events will not be cleared, and the device
will keep the interrupt enabled.

This issue has been observed while attempting to load patches, and the
'ReadyForPatch' field (bit 81) of INT_EVENT1 was set.

Read the complete INT_EVENT registers to handle all interrupts generated
by the device in a similar fashion to what is already done for the
tps25750.

Fixes: 0a4c005bd171 ("usb: typec: driver for TI TPS6598x USB Power Delivery controllers")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 31 ++++++++++++++++++-------------
 1 file changed, 18 insertions(+), 13 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 7c2f01344860..308748d6cae6 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -637,48 +637,53 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 static irqreturn_t tps6598x_interrupt(int irq, void *data)
 {
 	struct tps6598x *tps = data;
-	u64 event1 = 0;
-	u64 event2 = 0;
+	u64 event1[2] = { };
+	u64 event2[2] = { };
 	u32 status;
 	int ret;
 
 	mutex_lock(&tps->lock);
 
-	ret = tps6598x_read64(tps, TPS_REG_INT_EVENT1, &event1);
-	ret |= tps6598x_read64(tps, TPS_REG_INT_EVENT2, &event2);
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT1, event1, 11);
 	if (ret) {
-		dev_err(tps->dev, "%s: failed to read events\n", __func__);
+		dev_err(tps->dev, "%s: failed to read event1\n", __func__);
 		goto err_unlock;
 	}
-	trace_tps6598x_irq(event1, event2);
+	ret = tps6598x_block_read(tps, TPS_REG_INT_EVENT2, event2, 11);
+	if (ret) {
+		dev_err(tps->dev, "%s: failed to read event2\n", __func__);
+		goto err_unlock;
+	}
+	trace_tps6598x_irq(event1[0], event2[0]);
 
-	if (!(event1 | event2))
+	if (!(event1[0] | event1[1] | event2[0] | event2[1]))
 		goto err_unlock;
 
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event1 | event2) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
 	/* Handle plug insert or removal */
-	if ((event1 | event2) & TPS_REG_INT_PLUG_EVENT)
+	if ((event1[0] | event2[0]) & TPS_REG_INT_PLUG_EVENT)
 		tps6598x_handle_plug_event(tps, status);
 
 err_clear_ints:
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR1, event1);
-	tps6598x_write64(tps, TPS_REG_INT_CLEAR2, event2);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR1, event1, 11);
+	tps6598x_block_write(tps, TPS_REG_INT_CLEAR2, event2, 11);
 
 err_unlock:
 	mutex_unlock(&tps->lock);
 
-	if (event1 | event2)
+	if (event1[0] | event1[1] | event2[0] | event2[1])
 		return IRQ_HANDLED;
+
 	return IRQ_NONE;
 }
 

-- 
2.40.1


