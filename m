Return-Path: <linux-kernel+bounces-116730-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AEB0A88A2EA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 14:49:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 654DF2E1077
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 13:49:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 418C95490D;
	Mon, 25 Mar 2024 10:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b="iDHuYvqD"
Received: from EUR04-HE1-obe.outbound.protection.outlook.com (mail-he1eur04on2110.outbound.protection.outlook.com [40.107.7.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 240D1158D64;
	Mon, 25 Mar 2024 09:02:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.7.110
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711357355; cv=fail; b=LEN6y4JM1hTa/L784FKO6gOoiPbAXmilX6c5MGebVbkrdhYEp7EvBPQx/zAgjeOgJSRj5LH12vUswdS/32w2nUhhhlSmHeUzCVfhZ9cUUazsQz8dFedUG71XQkMpwJNX7RPSCZerIhFosEuhhDQsv2nuc052ctI64NHO0ulU28I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711357355; c=relaxed/simple;
	bh=osEPO1tew+CMOpuv5J9rsKi+wmwKhDnB1kdG/lLAHPc=;
	h=From:Date:Subject:Content-Type:Message-Id:References:In-Reply-To:
	 To:Cc:MIME-Version; b=i0a1pyXExNj2kbP43QNZntflS84CzKr0ojaTeLhyNpr3rBjxVaTYS3eJLwU+PkZAepiyn5ENc5BEYtUdc2TDelDO8piZzUhwbfdlMc5ixsVR7mbuKwjXd6nPVHlzcRqKgXwmH7j+c0u94umoQK8n/HqAxOP8txT4PBNCoGMis9w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net; spf=pass smtp.mailfrom=wolfvision.net; dkim=pass (1024-bit key) header.d=wolfvision.net header.i=@wolfvision.net header.b=iDHuYvqD; arc=fail smtp.client-ip=40.107.7.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wolfvision.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wolfvision.net
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dTOEoFZmS3I9EHV9ZnMCt/iNM+Rf6/7+GVzlR76f1xeom38RXlTIu+MpwYlM4eL+GKcsmUUIiq6+jGfy2oZeu8bvXz0J34Q+3oWfDFhbYBLTSZTMSfi8aQHkoj3scI8HHrcE+25na42meeobXtpG/zAFVEDs/G5MQ2OnQSRpGD9KbopIGuYC0I5h3aW1/OBZFrynCvieWb9bmUWadAPWROXoaZvSoIYDOkr+Bf2zNB/MYbh39ZQcQ8sXIYo9tK7yZlbYhh5KjGgTnV+SRiEEwuc4suKn7CphMw673lj+HabEd0Bf9Yr28MrCX+Uh2xYKiYcfmfzNYYV+R0nG5lyohw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rXaF0eUZPso8n7boIJy4yTZBwSmWexgEDBQC14JUkQg=;
 b=ahTfcKJ4YMAMjUlF6APvJ8QVZFOpr+00EAbT0AgmGnRrrL/8f1DVcLAhfgqAWsURDtI2UkXoPSBxEzvganXbENk8I68npywB+gG2Tq5uGKSfuAanW4K2MppDU9PlDRCc+QWxVzMJLW17YJ1VgXkHy1bznJbhMNDLbhAfEf/v6nyetVENViZx9cDC+mbmbAoeUfStC0lvrxQhZR2JFZ/+e8rB/ImVkRcV0ghWGrz8SVqYUpxpXR8KNvBVwkt0xXzh5mVfdclNTGh+tOuCZQFRvpSKLwAJsqgpoeChvN5jNdMrO5wXlkRxzvYDONi1dLu5Dq7WK2G/Vc8yHBmNWUCJtQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wolfvision.net; dmarc=pass action=none
 header.from=wolfvision.net; dkim=pass header.d=wolfvision.net; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wolfvision.net;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rXaF0eUZPso8n7boIJy4yTZBwSmWexgEDBQC14JUkQg=;
 b=iDHuYvqDdhjeYvoGbGXsWH2FQAYg+Ln6A3pVpe6/GDT+VCuR+VGfY8jPBWddb4dFgDk9+mFWDSzsyNJGXsMgqLKlB/r0J9GTcxQ6bR3EpOuJdyKdxQ66yLpNPUFsKroerIm5PTWKJIt0KFYCkzEijROqyemNJbqUvMoyVfQIEQY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wolfvision.net;
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com (2603:10a6:803:111::15)
 by GVXPR08MB7848.eurprd08.prod.outlook.com (2603:10a6:150:16::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7409.31; Mon, 25 Mar
 2024 09:02:28 +0000
Received: from VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f]) by VE1PR08MB4974.eurprd08.prod.outlook.com
 ([fe80::9e35:6de9:e4fc:843f%7]) with mapi id 15.20.7409.028; Mon, 25 Mar 2024
 09:02:28 +0000
From: Javier Carrasco <javier.carrasco@wolfvision.net>
Date: Mon, 25 Mar 2024 10:02:21 +0100
Subject: [PATCH 1/2] usb: typec: tipd: fix event checking for tps25750
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240325-tps6598x_fix_event_handling-v1-1-633fe0c87cc8@wolfvision.net>
References: <20240325-tps6598x_fix_event_handling-v1-0-633fe0c87cc8@wolfvision.net>
In-Reply-To: <20240325-tps6598x_fix_event_handling-v1-0-633fe0c87cc8@wolfvision.net>
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Abdel Alkuor <abdelalkuor@geotab.com>
Cc: linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco@wolfvision.net>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1711357347; l=1932;
 i=javier.carrasco@wolfvision.net; s=20240320; h=from:subject:message-id;
 bh=osEPO1tew+CMOpuv5J9rsKi+wmwKhDnB1kdG/lLAHPc=;
 b=wyNDQwbKxSYKnhEHo3V2rt3IwM2gKQHi4mptHJ6dR/dXIwN8dx7DE/KAvD+1H+UDSwKgfrr6J
 cxgTxaDd6tcCj1KZSgFXpHp6igQh0AcnLNteyvIl/LVhFYXRE7D5xkj
X-Developer-Key: i=javier.carrasco@wolfvision.net; a=ed25519;
 pk=Vxk2/0sGIxM8rsKnceszFuSuHVfQwa1Yo8+is7BX2nY=
X-ClientProxiedBy: VE1PR08CA0022.eurprd08.prod.outlook.com
 (2603:10a6:803:104::35) To VE1PR08MB4974.eurprd08.prod.outlook.com
 (2603:10a6:803:111::15)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: VE1PR08MB4974:EE_|GVXPR08MB7848:EE_
X-MS-Office365-Filtering-Correlation-Id: 44de53cc-33e8-4929-9968-08dc4caa4ba1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	a2RKhLXQxKNyqdAmIrnZuAPzocFm/N+QuZnW1df460YlJmCidMKDO5pbA8iU/DvKzW3DXWC27A1Ct2mn+7Qrfn0mTE1M6sbuSCQoPnuYcw6rFb+NVyRx4GA3jijtFUKp5iPPnb8pjNLlljWXG/GOTyNtnlfCp4/DyXs5uVedtVT6XkGe94DZWolOiAo4GkSdO4Q/LK1D2C1irovwfe3UBVPZ8UTJacXnoI1S5wX9MV4UFV8gYQSC5s+yTb0q1fnYqfQCuvUcjrECD0SMIcG6c6578pByV+NdRgpFw2nlq2bszrwCd3CbE75CPgyIXmbIF57ecPZOTbp2uM1ioXUX5XS8qn/Tqu4mQh03gZAeHIYlSHNXWgub9ihzG7jq2FYNJ6wz8P2lkQo1a2qZqiccaW4skHQ5v+PT3BERRFi7oCO7atB6ihY5IzC2lJBQ10cRoTniLA2KSXmMuit4I/P0jPDj7uslgv1YnRDc2T6fGq3d0dhPNcrnWNet+/+T17oK/NUgrnA3vW/o+YJl9W4+Eww6a2q+aVSX6E2J5uIPdClsNUCNa9ZA39G6jPpeHYh6hByz008it1eV5FGxw97ECZ9qZnu9YNtRWmasFfNJ4Yc/3vj2OybL5S69N8tIVAdpLM32LF2Xt9zm80COtQxaIg9Nuz+CuPpVMexC+AxDzSdCnVwBUqn83G90TmRcJWD44eMNDe26886zQXlt6xJkCzjiLeSLlmn9RIRC7Kd2UdE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:VE1PR08MB4974.eurprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(52116005)(1800799015)(366007)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?utf-8?B?MjVwd0VldW1DSEFVVDhvU0QyenRIb1JJWHQrb0tVQUI4YWplYlZqcWwvOWxK?=
 =?utf-8?B?K0wzM3VkdkR4RlAwZ3NjK29uZjZRU0xQWnExMVNoVlRSVFNrbVZ0WGpzejZ1?=
 =?utf-8?B?VXRiRzYvY0xBdXNNaTk3R0NsbE10Y0djMG5MMXlsb0hLL3VORk92SE1IRzZs?=
 =?utf-8?B?MERSbnY4eGdFNnovVThGTGQrc1RsRlNFUkZmclR4YlNpYmJEZjBkU2FFSmRT?=
 =?utf-8?B?YVRJZVpIMEt0NUhZaHUzeVIwbDRhek5tZWRLUUJGd2Nzbk1XeVpBTGdSOEs0?=
 =?utf-8?B?SkVWT1FrdUhiWlpJQUs0YXBuRytQSlcxd09BRDhraG5iL21FS1ZyOTRRa1do?=
 =?utf-8?B?enhlYmhKWlZDSU1DbFc3cFFnZXNVemhMVXc1UHorbUZxNU5XYXFCai9oWUhl?=
 =?utf-8?B?d1hpSFFBQ1lETkpmZTBNdkMxd3FSL1ZrR1hFak9oZHhPc2tXbUsvWmZ5eTNU?=
 =?utf-8?B?TmJEVi8vK0xOb29JbGxhWlRlWmFjR29ub1EyK2lzUlRYb3VidC9OeStIYlA2?=
 =?utf-8?B?bVJEV0FwV0RtM284MVQxRE5Nc1hvUHYrWG8yYU1nZ2NnWjB0bGJRcFFwSFFy?=
 =?utf-8?B?SnhqdzNFUU9HODZmU1UvNk9sMUgxK3hBcTVUa2doSS82RWJVdy9XMWNIWHYr?=
 =?utf-8?B?MTUvbWhHWWgwVU9YVHo5YWlmY2RqNnBycGxzc24ydHFULzVRVzBuNkdxbGlS?=
 =?utf-8?B?WEsxY3JhZDlmVm81ZWFTRGo1ZXhsbEZ5bkxxVjYyRExMemgxZW8yRndyWC9z?=
 =?utf-8?B?OGt5TWxJbUduUDNHbnlLNlJJYlBIZzA3TGczbmV6Qkc0ZUt0L3JGOFNpUFN0?=
 =?utf-8?B?L0FqMGkzRzNkU0NxSWNnVXRGWkdPVjdOM2tWZ0xGdHlzWkliRkRFQmtHcUxr?=
 =?utf-8?B?UWRhcEJXeG1xK25kbVZ2bmRnK3hZWSsrMFF5SmtlKzlocUpYTGVGN2kzZFky?=
 =?utf-8?B?TysvRENWWnJpYW9tVVh6SURGWlEvSUx5eTFRTFNNYzZoU01ESFNYN0c5Y0ov?=
 =?utf-8?B?RnBTcjNRWlNpSElyRWcvbDNqZTNJd1VMQmI3WVFZcFdwUnVyWkcvWEJhZGRn?=
 =?utf-8?B?NmpnUkFoZVJzTVlPSk8yU3pPQXMySXhKSTNBYm1XS25pWXNycDR2ZzNMODl2?=
 =?utf-8?B?MmZId1BGT0hLNUZUa3hyVWlDYzNkMFlXcXpXeUt1RVAvektXRlVRRmlGNGRT?=
 =?utf-8?B?SzRMZ0xjWWZWTUJjWmJZMGxoZGRWRGwrK3J1UVZiOGJZcVkxL1J1M2xGN1I3?=
 =?utf-8?B?eXl4ZFFvSFlDYnl4VmdUcE5CQncvc2ZFNWtNMnhaSUFsSGhWWkk1SnZtKzhv?=
 =?utf-8?B?VzM4clEwL2RMMkVZdVFpeVM3WVY2ZUYvbGpYTDFPOHBORzVhNk9vTEh3Ymk2?=
 =?utf-8?B?VGQ1ejVqODdRWFZOYUZMSDlqQUdDSE5FcEJsOGc4V1c1NjJhUnNpTG5YZC96?=
 =?utf-8?B?elNEUDZGRHJXNm9PdEJ3SlJhaTR3TGNPbDQ3MVdud2orZXc1T1NscFpWeDZ5?=
 =?utf-8?B?ZStNYm1QZEdVRzh3b2FlSWJveXg3UVY5T0dKVEN0UnAzMHZORVIvK3NlT090?=
 =?utf-8?B?MnRCR3lyUWJxbEZJRmVkY1NEbWVLaGRKNGtxZDhsVnFob0drellTS2tTYkFP?=
 =?utf-8?B?dm9QVllmS3MzN1YyUUE5Sm1EZHhqdnlBaGNZbGlSd1JSREpiNlhCZTRlMmo2?=
 =?utf-8?B?ME1qRnNybzN5aFY0d3NSYWtrNTJKYzZXSHpNb2c3SGdicWJzUGd1d2Q5NjlZ?=
 =?utf-8?B?dThsa09RMERxb1plQURLU3FNU0ROOVpad3JBTEtxS1prVVk1OWt2eVVUalBW?=
 =?utf-8?B?UVVHVDJxUWlNejRIZzBNMk8zNW1HeldscHhNMDNoMEo5YVFYTDdhTE5wM0Nh?=
 =?utf-8?B?UlMyV2RTWWVxc0wvMldSV1JCTCtIb0cxcTBLdGkvanhKZ2R5bjFmVnRobGxX?=
 =?utf-8?B?VGpaNXBiaU8zUHBNbmRNdjJ0dGxTN1FwVHNBODFaNVlYWXJaNEcxeFhVWkE3?=
 =?utf-8?B?a2xsVEFXei8rRThWNklML3d6Q0tSNDJOUXprUkVpM1doTWZ0a25ic1lZbmNY?=
 =?utf-8?B?dVRraWJqWnptVFhrZzZ6RHZmeCtzYVdrSXhvVGhOSUNzaWxuZU5aQkpoSHBs?=
 =?utf-8?B?aVlKZDlaN29vaCtBUjJGSTBOc2E0NFdvY0lGVHJoWHNlbUN0b3d3WVN4S3Fy?=
 =?utf-8?B?V0E9PQ==?=
X-OriginatorOrg: wolfvision.net
X-MS-Exchange-CrossTenant-Network-Message-Id: 44de53cc-33e8-4929-9968-08dc4caa4ba1
X-MS-Exchange-CrossTenant-AuthSource: VE1PR08MB4974.eurprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Mar 2024 09:02:27.7992
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: e94ec9da-9183-471e-83b3-51baa8eb804f
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SdvjR2pdPzB8noVKc5Fb9IfV4w1hijhCZ8oPDViIFz65cfmUXSFi3SYUbWZ5AeYFyinAxt8OBOitXOW8jez6cJDyHEE1mckro6LzBxJ9pes=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR08MB7848

In its current form, the interrupt service routine of the tps25750
checks the event flags in the lowest 64 bits of the interrupt event
register (event[0]), but also in the upper part (event[1]).

Given that all flags are defined as BIT() or BIT_ULL(), they are
restricted to the first 64 bits of the INT_EVENT1 register. Including
the upper part of the register can lead to false positives e.g. if the
event 64 bits above the one being checked is set, but the one being
checked is not.

Restrict the flag checking to the first 64 bits of the INT_EVENT1
register.

Fixes: 7e7a3c815d22 ("USB: typec: tps6598x: Add TPS25750 support")
Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
---
 drivers/usb/typec/tipd/core.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 0717cfcd9f8c..7c2f01344860 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -604,11 +604,11 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	if (!tps6598x_read_status(tps, &status))
 		goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_POWER_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_POWER_STATUS_UPDATE)
 		if (!tps6598x_read_power_status(tps))
 			goto err_clear_ints;
 
-	if ((event[0] | event[1]) & TPS_REG_INT_DATA_STATUS_UPDATE)
+	if (event[0] & TPS_REG_INT_DATA_STATUS_UPDATE)
 		if (!tps6598x_read_data_status(tps))
 			goto err_clear_ints;
 
@@ -617,7 +617,7 @@ static irqreturn_t tps25750_interrupt(int irq, void *data)
 	 * a plug event. Therefore, we need to check
 	 * for pr/dr status change to set TypeC dr/pr accordingly.
 	 */
-	if ((event[0] | event[1]) & TPS_REG_INT_PLUG_EVENT ||
+	if (event[0] & TPS_REG_INT_PLUG_EVENT ||
 	    tps6598x_has_role_changed(tps, status))
 		tps6598x_handle_plug_event(tps, status);
 

-- 
2.40.1


