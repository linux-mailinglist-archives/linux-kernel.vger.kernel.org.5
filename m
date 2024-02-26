Return-Path: <linux-kernel+bounces-81864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF96A867B20
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 17:06:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F28D28F431
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 16:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FE7F12C7F2;
	Mon, 26 Feb 2024 16:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b="jmor3uu5"
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2100.outbound.protection.outlook.com [40.107.236.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C41C312BE9F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 16:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.236.100
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708963572; cv=fail; b=dD3jsBWRgFvZEscaHWjqyiBxZDQ/eDpOvcpmQyoi6b3r1Pae6YJoLQZteeJyxnxjVGlT0AvHCC4KRrSqSp8zwrDGKJWuk4jkyWu+kdchNQifvWfzls4/QLRiRjnRCq9xmVgIeAKS/vHGEKdrzpkXP80jvkuWyrn0qwTSs3Yk7T8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708963572; c=relaxed/simple;
	bh=g0NCw/32uMB8aoyV4XBxH+Kl4Iqr4KifE74Ec0BBJUY=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=fy1hwqvM22i5BSdVqTMycMX8bEAkH3JUqNUnRI5YWYhG7oeunSV1QU2qKdZU1p6DjwXcjF/QK+IUZAujI+twdgCgPV6dgnsdIaaSI15fz5in2nb+a22DXaFW2sJGGULy1gLAvH4ByXgrSLbhlzYSOJaZ3k60wyW0EQJhuZgEjVw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com; spf=pass smtp.mailfrom=inmusicbrands.com; dkim=pass (1024-bit key) header.d=inmusicbrands.com header.i=@inmusicbrands.com header.b=jmor3uu5; arc=fail smtp.client-ip=40.107.236.100
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=inmusicbrands.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=inmusicbrands.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mqs9k8lbBaUAUn781TOsVq6NOyUYMz714jAMTJzJa4iap/Moku1ehea9/qVsiyy+juorCGs2ls1UTVXUDZddi2C64WtoAyIfCb0HvQjJpWJXMi3b+3WZLVVuBVi8ET95Vs5guacdM6YIpOrJJZzoK+HpkUgiu7l3WFup6jMcdke8Ybhpphwhr8Zsma4FRI7yBEm8RNynS0s/13ebaQnQwVrebexiURF41CDpdV87AndRk2o0NJZ6fWFnhDoXuqjNjuoPx1cCIE7WqTzp7e1qSFqQUe0Z5uEhOH/A44QJwoOsM651h8f+xqavhvQyaqFMeV1ZygE1dQc6q3H0S7iQ3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sxTCPjzQIV+DgcWXPvJFg+mCWPvLazk+pZqNzNJaook=;
 b=DWzSjs+iL2vwmX0anAk+vP0euMRZVjp69vKH3MZdjGFKsEzQNR71bMH1dMm08lclFB4I58ofaG7FH4MIntOkew7JmP+yt6DQGjn9iik+KkPAylsCPQeGfcRfEAvuv58S0wuqKJQ/ELa0fm8XOJcqzrcWrdtTBAAySJwszHm8ab+MXUqxTkZWRN4845bhBwTapgEqRDca2495phN6ujkozhLmUXCy4JNWSIENOoo5UySZ6bvyBfiwVsgKopGr9KHHTJP0U6xgDPUFv/2MxkQzKwixFcMU2W0hwCq4uEKGR4tI5LCGGU+i2qXzDjP7vkv+OiOkV+etyPse0jkGAMcrrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=inmusicbrands.com; dmarc=pass action=none
 header.from=inmusicbrands.com; dkim=pass header.d=inmusicbrands.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=inmusicbrands.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sxTCPjzQIV+DgcWXPvJFg+mCWPvLazk+pZqNzNJaook=;
 b=jmor3uu5SvplpDonjVzGwUINlb1vThJ61BfaVApPrgeMKPXToAIeuGf8LeP8529y5pQoABlftjqjVQKrXunTJYY6jxxgKug8bhRyJfdycPYB3WiIlIeH6HlPCVgDWTW3fK49ivqCNRApLEZHmaBgHqIwqTh98IyKNqcx4WhIheA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=inmusicbrands.com;
Received: from MW4PR08MB8282.namprd08.prod.outlook.com (2603:10b6:303:1bd::18)
 by BN8PR08MB6305.namprd08.prod.outlook.com (2603:10b6:408:7d::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.35; Mon, 26 Feb
 2024 16:06:07 +0000
Received: from MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::54fc:dd86:458c:c4b3]) by MW4PR08MB8282.namprd08.prod.outlook.com
 ([fe80::54fc:dd86:458c:c4b3%5]) with mapi id 15.20.7316.034; Mon, 26 Feb 2024
 16:06:06 +0000
From: John Keeping <jkeeping@inmusicbrands.com>
To: linux-kernel@vger.kernel.org
Cc: John Keeping <jkeeping@inmusicbrands.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Zev Weiss <zev@bewilderbeest.net>
Subject: [PATCH] regulator: userspace-consumer: add module device table
Date: Mon, 26 Feb 2024 16:05:53 +0000
Message-ID: <20240226160554.1453283-1-jkeeping@inmusicbrands.com>
X-Mailer: git-send-email 2.44.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0090.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::23) To MW4PR08MB8282.namprd08.prod.outlook.com
 (2603:10b6:303:1bd::18)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW4PR08MB8282:EE_|BN8PR08MB6305:EE_
X-MS-Office365-Filtering-Correlation-Id: f1214b3b-9d5b-4987-ae07-08dc36e4d6d5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3Rer07jw5exyOn+Q0jm9jD69tjRSqrxqVxt7g8zeKThNSeuBWotCj679FbrVzGAhg0Z6MaXDN7TawndW7xY3PTKUxG2N4OoVNB2TEDymvKC3e7BApt1lJhwsRjKkLhdaRm3sJmwhRWFn/qrKikzmhbc8wU2eBmNo3ygkPwYqrtzBaaQcuz16dXlhsrGv4Q9Whfxnyc2J53NoQKq8S6Kh/IW6O+r8gMEDsRAod+Xehsz/WF1ZtV1ADhDLd1FiZv/ICDT0OVydcuEhRwrs9Q2HSDGIV3QBz1BHhNLpj3dP2vEmdqSg7JOqxfa84JXbyDHj2T8wl56cTRmOalRbafqNHgTrbK13rGakdpW/6TAT4Y6ZlcxftTb0G5TnPKDFUNK8JPVqanuJvrrT6BFzdpMIuWBtDAe9jyYFRDjUNLSJKPUCSphqXiXWgtjlJCjZ4o2BqHpnjbAZuN8VFUGz1I5q/a27cEy4a7WSJMF2hmUW7MQMs9GT3o2SJ9Poyli1BmuXPws7Mr61INqWKy+T6LjT3qDCVHXSsz07PTZcIQ3Ys0zpOVuzudlf1lGvle6Fj2vUVImxi6YAcbX5hw3M1qRRbb3TRANTyQsdkF+BK6GBmnViWaywkyM9NMXUbo18WnIzaGUVTIBICsaTiH9owXtE6PVy/oY/hIAYHo3g3OMw4v7YILmtsdjLcMikA6WKH7YL3NYRFU+Ywgocz5Tq6quuQh2LysgDScOGUpI8c9KbjwA=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW4PR08MB8282.namprd08.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?te1zeo/p9Mh2jux1Amy3YT/B8tDhRBGtKiXCzPvGz+upzE/7RAbATUgan1xJ?=
 =?us-ascii?Q?v3WniWuuLFrrcICfFUxySMe5FJqrdNYL40ZthaUajFhqa3NOvE/Z2R1V/myV?=
 =?us-ascii?Q?Z+AcVK/WHYIIMpgyOnXjJ/ftMx9Q6fDJFIDJgQGPzPVkZn4AT90bNMSLPi4g?=
 =?us-ascii?Q?LlHrdhY8NrWCl7zCHP+mcZk8McRIgjv/HXDjtpAui9L0Kyx6OkQ4SjmL5dus?=
 =?us-ascii?Q?0JqczCtpKtrW3AIGD/c5hiTktCa2kNQJcn6y3G+Vk0IT2Lpz7e5OzWgxHlrk?=
 =?us-ascii?Q?OgKCjee9vEBj4N6r+iTm4KvNSfN1Jiakcmno1OQAeDPUE6lcu0hk1DDc2pES?=
 =?us-ascii?Q?jT0lzMXvOGaWSJzLHrA9cRLopTfKXzHjnzsL41210Y/KI42ObYNgnZc+DC1X?=
 =?us-ascii?Q?pQmOUWq0AXe0cV3MCkdmqV7UQQaC5cifep1f2EdMO/hgaPSuwYHCMku9tiIA?=
 =?us-ascii?Q?OLTLGlMy0hbDyFbFNLfIYOF/Kx+bcAP2l5xu7aVWvi6AjvEY4rDdbB3+JWFF?=
 =?us-ascii?Q?3HH02htUUfkpJpCGohOy/olBZStBljlIaHCWgMxJmZjSHmUkEylMzKUP/vMT?=
 =?us-ascii?Q?QR2qvpYqOySKzpiFPfDjATb50q0iV8wFlmh+OmtiXXgb2oH4zCu/2snHl0jR?=
 =?us-ascii?Q?zxbLBSccddhHvQtLQu2DIo6yrHjp1z9+9bT95YE6kcfqmm+sd14haCCTj4T3?=
 =?us-ascii?Q?J0yMQuAAmNZyHOfgS3joXSO/fPENQIqcpGxvtgjNDpejWbndLtut8fWdLlas?=
 =?us-ascii?Q?56PSTdxmcZ0PVUzepnqDA93exnMoHUuUzF/7ERzAHSLbIDwlhv4Jh/gfM/kX?=
 =?us-ascii?Q?zOgK/I8YqlruVYOGuo2d39YgFCuGlv7Dz8Tm9CT0PWnR87r4DwUPHZrk9y4G?=
 =?us-ascii?Q?x4EwHtQlhjxLPBAN4wGsSnHXPf6846k7aUHgcO9TYNWvDsuLeqmSclS8nRCP?=
 =?us-ascii?Q?faQ8BBx4Fs407EK/eqs0ywwc2H4esv0UxQosbFDgPD+ycDVMUnbnUJpHtcd3?=
 =?us-ascii?Q?JI54q4yu+/QQmfuJs47gGh5KCs52p8puKE5n//3Ms47HZu5utZ74Fnwl5mvi?=
 =?us-ascii?Q?crtRooqVod0CbHzsGuRVhEVFsCnHk0r2Enhtg6iZ3eZ2oVpauKceD6GEe3Tb?=
 =?us-ascii?Q?lxmKUdGdqdXXxIFwFt19f/ffMQU/gb4F0M7UNABJvYQvYy/0yk5zU0OZmwwI?=
 =?us-ascii?Q?muyZCzZAKsvNhvN7S1XvEBJYxcJl7asxlCo7cP/POgsDAcnR5Jv+OU00+I7I?=
 =?us-ascii?Q?JFi1fxuoiFupMNOP+jgAyA5DNDbdfxW2JMpsMZQe3zrrxtJbj84A+I98J/DA?=
 =?us-ascii?Q?SMkw1VesWAAN2ZwVuPsdiz8MUd25GNFf31uP7NRKU4bIYdEqhfZAl2YbtSsf?=
 =?us-ascii?Q?p8JS/anJJB6IKd/aFPwoMjVH+rSKthRztlJq/zKw9MGtfg6sVTzggWxPho0n?=
 =?us-ascii?Q?8RHNgmDvXd/PRnHQd8PUiJHMzr0RQYOacTjTXAO3v0+ajJd6es774OQU7oTT?=
 =?us-ascii?Q?/vNfe0sfG1lZulnAIZM+HDVAOEsmNQ7Ew1HI+6dLBxva9RIzGgylvspeg9mH?=
 =?us-ascii?Q?EFdmHIhA5iE1xheBPuLr6UpuZIAhwesT/sxvtFZnlNOSs1kntbyP9zQ9e7cY?=
 =?us-ascii?Q?9g=3D=3D?=
X-OriginatorOrg: inmusicbrands.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f1214b3b-9d5b-4987-ae07-08dc36e4d6d5
X-MS-Exchange-CrossTenant-AuthSource: MW4PR08MB8282.namprd08.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Feb 2024 16:06:06.7341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 24507e43-fb7c-4b60-ab03-f78fafaf0a65
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pLPU428TIO0LS9Kc8F6OiPYA9z3UG/wi2HxW4GgR6RayncUAGCntLqdu6YrRphKgO54c6Na4TynPSDDD/KoH2Yne9nhvh1wNVM9yDcp3UgE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR08MB6305

The userspace consumer can be built as a module but it cannot be
automatically probed as there is no device table to match it up with
device tree nodes.

Add the missing macro so that the module can load automatically.

Fixes: 5c51d4afcf3fd ("regulator: userspace-consumer: Handle regulator-output DT nodes")
Signed-off-by: John Keeping <jkeeping@inmusicbrands.com>
---
 drivers/regulator/userspace-consumer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/regulator/userspace-consumer.c b/drivers/regulator/userspace-consumer.c
index 53d1b9d6f69c5..86a626a4f610a 100644
--- a/drivers/regulator/userspace-consumer.c
+++ b/drivers/regulator/userspace-consumer.c
@@ -208,6 +208,7 @@ static const struct of_device_id regulator_userspace_consumer_of_match[] = {
 	{ .compatible = "regulator-output", },
 	{},
 };
+MODULE_DEVICE_TABLE(of, regulator_userspace_consumer_of_match);
 
 static struct platform_driver regulator_userspace_consumer_driver = {
 	.probe		= regulator_userspace_consumer_probe,
-- 
2.44.0


