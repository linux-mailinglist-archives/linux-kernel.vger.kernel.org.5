Return-Path: <linux-kernel+bounces-157573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C8D28B1315
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 21:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7330FB24527
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 19:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0492262B;
	Wed, 24 Apr 2024 19:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b="o9QhJ/CN"
Received: from EUR05-AM6-obe.outbound.protection.outlook.com (mail-am6eur05on2077.outbound.protection.outlook.com [40.107.22.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 263941DA21
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 19:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.22.77
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713985261; cv=fail; b=Jhh719j9Cdy+AB4j50NZh3ZG4Z5Arnc4gqH99hzuVeVRuZth5GNH6GIOch2HxHTNqqzg5UdsSY6DjDSDyLC844ArS8EmcaUCQYmFylFG8wJXsNQczNYigjFPLSk5yvfNeoJMbWxKxkAbWd1DgnXd1Ao1w6CL/pXvjrQKBH8Ufjs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713985261; c=relaxed/simple;
	bh=usakbb/pkUG0ZSqJWoqs/JiAcze9ChoErdSOazsomeg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 Content-Type:MIME-Version; b=kEWElM7U7Fp/uPuK2ZbuGErAdi4rX5OeaeYS6BU6oKStHrmccoPl/fcKV/SGLE2N2eQCKTgRIx9Vslb44tfg7Dv890yKjaH+O15QemMhPX5r34KwE8JlM8XrqHYiyUCd/KjLsxWyYuULPAOJDS3gmID7MDpXqG8iPUJr3QKMWpQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com; spf=pass smtp.mailfrom=nxp.com; dkim=pass (1024-bit key) header.d=nxp.com header.i=@nxp.com header.b=o9QhJ/CN; arc=fail smtp.client-ip=40.107.22.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nxp.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nxp.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DOKhUAEryr3WWjI1nFGScBDHrSTvwC/vkwdwI14fsSWed0R7nGVKhJWdf4D+jiD+zZbg8haTAjIguYCTIUNn86Lk0Y2iWidhT/uhpx3WUq9SJqSc8kBgh4lqi/5IMuQDZsPSAh8rs5WHP2jXde0Fl/HXcCPYPJ6MzddaOQ38RcLFqmajQz6g4OBRASLlr1npVOMeaQsrD0Vp02Q97s1WMfqZ7FDDs41V29CX75IlAxvBCq62+W3B/474MpwBCQbiABeiUJaLr895+RgBw+USkEjE2plY/cpsGCnVFJLZS85RU50zVPk7BAx13QxncEiiMz50poPg/XRH3jZgHAiT7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=z+YBcMUL5XXP6oscrSbOAbS1OdWMpYOXFiXqijM3Ltc=;
 b=CDJXGeS1AwmzYsASOHG3Exs37mF89kiennaBtmEMLUnrAUu4DPG4Xt6a/tcRenupjO29JwkyTvtoQiRS2GfD0cGk5xQ5p21MNNRkX4wgINWupwR0upurPL4AI41hd0M1F0kCcQCK+kiFQSEt8XHcI/aalo9Cx+EaekkUV3l75rmMpJ5tZHu/09myEbJiHIyg6A70NI3hGr0OugU8hbmvwQ+tQPU5BMOnaoiLCEJsSSgDYMLIdmAouAdIklfJEZTfh+HnQRNHzLS9x5uX9Y27byZ/hTi7APGQY5IKLJH/t5okrfP37PFm6anxc3p265PCBK9bZQjvY1nxTDwQUfLYog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=z+YBcMUL5XXP6oscrSbOAbS1OdWMpYOXFiXqijM3Ltc=;
 b=o9QhJ/CNDxm7YI4FCBXeriQjzV0loa0VSFLxgDbyxn7NTZIddKkDE8Z5iWwhaA50ZwkXPuXp7K85H8FdiYnHbbR9hZ9zPrdjQPjoJb1q3+lT88yNYN9xFXmnQMK1eNEd93kl880ous5lovzNk6Ruyx64c6uq8pQZjggQPqttby8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nxp.com;
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com (2603:10a6:102:240::14)
 by AM9PR04MB8617.eurprd04.prod.outlook.com (2603:10a6:20b:438::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.22; Wed, 24 Apr
 2024 19:00:50 +0000
Received: from PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58]) by PAXPR04MB9642.eurprd04.prod.outlook.com
 ([fe80::1e67:dfc9:d0c1:fe58%7]) with mapi id 15.20.7472.044; Wed, 24 Apr 2024
 19:00:50 +0000
From: Frank Li <Frank.Li@nxp.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Culhane <conor.culhane@silvaco.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	linux-i3c@lists.infradead.org (moderated list:SILVACO I3C DUAL-ROLE MASTER),
	linux-kernel@vger.kernel.org (open list)
Cc: imx@lists.linux.dev
Subject: [PATCH 2/2] i3c: master: svc: fix invalidate IBI type and miss call client IBI handler
Date: Wed, 24 Apr 2024 15:00:30 -0400
Message-Id: <20240424190030.857632-2-Frank.Li@nxp.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240424190030.857632-1-Frank.Li@nxp.com>
References: <20240424190030.857632-1-Frank.Li@nxp.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BY3PR04CA0002.namprd04.prod.outlook.com
 (2603:10b6:a03:217::7) To PAXPR04MB9642.eurprd04.prod.outlook.com
 (2603:10a6:102:240::14)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAXPR04MB9642:EE_|AM9PR04MB8617:EE_
X-MS-Office365-Filtering-Correlation-Id: 7aa66eca-0268-4396-1d20-08dc6490dbe3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|1800799015|376005|366007|52116005|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?kni+LZfycHMpYCCcxIiSJJmABD73mL6KoJVKl86R7z+0qVq18Z/EU+mQraG4?=
 =?us-ascii?Q?GU9Y3i1W44IlzQoV1xegKtLdRojoMfx7MdlIA0csQJXW8lmPffqtpGCb/94l?=
 =?us-ascii?Q?HyhvqbMlPeoTyr6HdMZ1BvPUH7c0BXv9WS1nUWhbact/vsdMSGToh4igLYn3?=
 =?us-ascii?Q?nUFDkejuBqWLey0vrXC0yvtfWS1m/SdTZJ+A9JzEvIm3qY2F6gcCQ7hVs+Bx?=
 =?us-ascii?Q?HT+oPwL4LcKEivXKTXTxK7bX+PEdq9DSnx5ujv8ySfBJUAsGyTJkPAFL2oT9?=
 =?us-ascii?Q?tA1tlMd6iUqCLF6vWtTCljqfmcnOipQmOZSdC+jLC3d5rWoCVkqG1zXpFlG6?=
 =?us-ascii?Q?YiG1f+EHU6w/siOXC3Rzn7x4RIBbQl9+q1tZ2qT7nTpNxoWMPZ72UF/d1cdT?=
 =?us-ascii?Q?G82at2kuKd5CBioqke40D18qqe+bL7q8DYnDGyT/o2wAPsRgwuzcDyD7wn2l?=
 =?us-ascii?Q?KpIOEkldun5tB83SwMe/nHVKU7KqHwZYopt5U3Rdl4F8ktP3qnFR/XunB6wK?=
 =?us-ascii?Q?A5LauCBcy2/6FS079KY516ZMy0OAzEtBq19WFb03MwcbhZFaHogkhrV1IYER?=
 =?us-ascii?Q?roDV0zQRrnvfOI3lW0PHOkPqXjQKCdQWYUaDYtPoylKpuJatba9eExYGX+OL?=
 =?us-ascii?Q?KOVtCTm8+WeBCqawLSQwnm23pgAggFSL7F/viTc4vN7i/olt9qe3eD4ylbKJ?=
 =?us-ascii?Q?WLHv/PMK8KjzLlzf+ZryMZuYoJVf0PMJrCkI9K13lYgefanPkCUd3tIxe/F4?=
 =?us-ascii?Q?omrmzpK3NkQoBwEiHqeUei9ACXucDdmNHF+clebfN//zjtslQQ6gGXXfe/jb?=
 =?us-ascii?Q?nmadhxnmY5Igy27MpDeUk2lnPGamRnH1tPJQF4X1IImHx41V9KXTlU78eMp8?=
 =?us-ascii?Q?qFl+zfPAYZUF7UGyCb5yL3qroF02xY4wMTxX1hD0S0IbVU6yhx7FNDTb3122?=
 =?us-ascii?Q?r+lfyWn/bGcuhLpMtF+Y/qXWT+C+Js3x8j9FhLfezR4HPNvA7jtSKJvqUh7m?=
 =?us-ascii?Q?9KK0sEmaXHQO/59+XziPnnBCDaS06ZrZZyaR9IYNawkIoN2IanVf7QQlMo82?=
 =?us-ascii?Q?iw6+NmyPXherUBazAhCwyMjqqfaBnxCIgTF7nfpwgRPXG1P2vYBqeOc84wlN?=
 =?us-ascii?Q?Gg3g3+KoRhpEKq7Vo0yVVTGyU7C2VmV3NAE7LLiKeOZgKGtYvlJO9SchTeJc?=
 =?us-ascii?Q?cH1HCuWP2YV3mhe9c1wQfkHjC8UZDKPnbAq1i8GqsBuQQgWbpEK77qn47NtF?=
 =?us-ascii?Q?PXAui63ocnKozcpBqiOLNy9rAHTaRX48Hj/LDaSye9utGY0Scd09iX+U9cVD?=
 =?us-ascii?Q?jbOwOfxNeWpAg2IvJQchQLQQ8pFrPnbp/JFQq9GP4L6ZXg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAXPR04MB9642.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(1800799015)(376005)(366007)(52116005)(38350700005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?urObOgaEvln+zQBbL4o5nAN9AIX5w71JRptYX2YEPJQES7dz3TxnxGak35X6?=
 =?us-ascii?Q?lUVAS7A4fRbwauVCxkZSrCptDDwxauWCEbEd4Z0e0/IOTuSER0oo4cbK3tHP?=
 =?us-ascii?Q?7CJk6Q/pL4fk5GDRqRa8jgY4IeD6+UjlkWBwK6YJHkV0/3ydpDb7+ydLMOyk?=
 =?us-ascii?Q?n+tho+azbAyFEPUlg0c3XFdbPJhzbPYTpKkvV8R7feQAFeMEu0x2GjwbvL6+?=
 =?us-ascii?Q?yDxI1Fs+4ANYeylInXX1EWq0nk6S4mDWV48cZlbfqh/VP4HinAWAfuNcyrhx?=
 =?us-ascii?Q?1inakhw6Mvj7Rw1ldbpHfYOnBMNqLGKsZGa4Q55Wsac4WiL1BloFU5S4yC6V?=
 =?us-ascii?Q?CS/AHUShjIBIZSUKl1UrLZfHpEUlel0euJjwrd3J9TrqMQRwNnfmY6wzqNk5?=
 =?us-ascii?Q?HrMeun3vtF8Ay2a/K2PaQB+qeLxv2DcQz2q616LjzlWq8Y9jWC3pMBaWLZH2?=
 =?us-ascii?Q?l8MvGO6c+eKm89DkDb++2RWOBc5HHtQj5i4VhugO41SOegPj6RToECRZD86Q?=
 =?us-ascii?Q?v8dQV3X7cpwM8upHOEH6UG9Md42M6O3w83fk2ZHixpwra9NXs36/5kNDYS/8?=
 =?us-ascii?Q?75cx0ndNiJ2snHPgs7b3ixIU+xddQpCgmqIN52p+kGnbpEXj5fTy8P+uvdKd?=
 =?us-ascii?Q?QYXEfpB7GZ0HjtuIUMpAeQQzGBRfHnQE/bQkO09HvluTeYJea1/XcE3QN0T0?=
 =?us-ascii?Q?Cb1ynE0/JZj3W9VZdd3FDiV6+8jxqFP8ndqbgYhz8OhpHsISkwiiZJKhAFBP?=
 =?us-ascii?Q?7S7oP1Qj9FWznBr0dIcH145CbrD6ZdgkDOIZz8jlCKWfTWA5z/XOMXMfR9pR?=
 =?us-ascii?Q?zuW1bMv/HmOipKQrwtVe/hdZkBFULoWvKt9S1GsfyCJl0CQ1312tyeysIuRR?=
 =?us-ascii?Q?RK3GnHcD5SUa6U8DTDdF9kDnfTvLENVa3I4i51dVwZkacUXsYNPp+qZYWRp0?=
 =?us-ascii?Q?QAOWfhWTGqkOI9HQpP9CorvaO1jrurhuzMwWAtdsiDCAld/5l8soBNb6WSPE?=
 =?us-ascii?Q?dfn4SScyDkl4M1JKaUtA5B/9K9tiOa9j75XmXLbyn3b96layAFPdpWxz/nXq?=
 =?us-ascii?Q?6vK9a8PQcqcK9sP0ijsk7VDGe6eP5GPwSf+WgYWyZ+Gg1+ClDd8dyvuoz23c?=
 =?us-ascii?Q?mnsUfCqIowh5+5f0Za4Tkv+fPzdBS+ocTJkIvGeY0O4vdi9lsbranHXMXKZ5?=
 =?us-ascii?Q?sKAy8cOeRJd8m7AcMDoCjlXGVnID9TUZ/ZOInzGyaTf9pnFefuwRbPNVE6GP?=
 =?us-ascii?Q?q7uKm+xBQVt59tHrmHbdDx5+TWp8bOExanGtFny4sRbylQMN06e7D7XpoV8b?=
 =?us-ascii?Q?Hhw2gT4BxlJGGIZv4qstR/WgEHNN8rNa4eaYgbXCWT2Xuuc0vwgnZr65z3Xl?=
 =?us-ascii?Q?T7zpGr2oMye7+PTvUnSWWkaaDPmPy0CHrtP+f5hozmFAhGmtQu2feQ2KY3lR?=
 =?us-ascii?Q?juG5hJTzFhzPdP4cYxNt5zODG7gIGyE/Tn8IeVqdPd9bB030g1Gq5/nijJAX?=
 =?us-ascii?Q?s2va/EW+BM4IwizwXQdTJCVDiNzFt9SUhaPeq7ytT8FKiDgM76yOwKs/yQ2y?=
 =?us-ascii?Q?CutHDZvldriKobVvEEG7fcXq8Zum6ziMJI5Km3Rd?=
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7aa66eca-0268-4396-1d20-08dc6490dbe3
X-MS-Exchange-CrossTenant-AuthSource: PAXPR04MB9642.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Apr 2024 19:00:50.8295
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RzihTBMi/xtlsytgkymG2jUSvnjp0IMwPnMUL5ksucqsJG3ln79kI4M6ICZHSUKbfOkH9/5YZbgw3OgF3Bygyg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR04MB8617

In an In-Band Interrupt (IBI) handle, the code logic is as follows:

1: writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI | SVC_I3C_MCTRL_IBIRESP_AUTO,
	  master->regs + SVC_I3C_MCTRL);

2: ret = readl_relaxed_poll_timeout(master->regs + SVC_I3C_MSTATUS, val,
                                    SVC_I3C_MSTATUS_IBIWON(val), 0, 1000);
	...
3: ibitype = SVC_I3C_MSTATUS_IBITYPE(status);
   ibiaddr = SVC_I3C_MSTATUS_IBIADDR(status);

SVC_I3C_MSTATUS_IBIWON may be set before step 1. Thus, step 2 will return
immediately, and the I3C controller has not sent out the 9th SCL yet.
Consequently, ibitype and ibiaddr are 0, resulting in an unknown IBI type
occurrence and missing call I3C client driver's IBI handler.

A typical case is that SVC_I3C_MSTATUS_IBIWON is set when an IBI occurs
during the controller send start frame in svc_i3c_master_xfer().

Clear SVC_I3C_MSTATUS_IBIWON before issue SVC_I3C_MCTRL_REQUEST_AUTO_IBI
to fix this issue.

Cc: stable@vger.kernel.org
Fixes: 5e5e3c92e748 ("i3c: master: svc: fix wrong data return when IBI happen during start frame")
Signed-off-by: Frank Li <Frank.Li@nxp.com>
---
 drivers/i3c/master/svc-i3c-master.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/i3c/master/svc-i3c-master.c b/drivers/i3c/master/svc-i3c-master.c
index a2298ab460a37..3bfe8e694f840 100644
--- a/drivers/i3c/master/svc-i3c-master.c
+++ b/drivers/i3c/master/svc-i3c-master.c
@@ -415,6 +415,9 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 	int ret;
 
 	mutex_lock(&master->lock);
+	/* Clear the interrupt status */
+	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
+
 	/* Acknowledge the incoming interrupt with the AUTOIBI mechanism */
 	writel(SVC_I3C_MCTRL_REQUEST_AUTO_IBI |
 	       SVC_I3C_MCTRL_IBIRESP_AUTO,
@@ -429,9 +432,6 @@ static void svc_i3c_master_ibi_work(struct work_struct *work)
 		goto reenable_ibis;
 	}
 
-	/* Clear the interrupt status */
-	writel(SVC_I3C_MINT_IBIWON, master->regs + SVC_I3C_MSTATUS);
-
 	status = readl(master->regs + SVC_I3C_MSTATUS);
 	ibitype = SVC_I3C_MSTATUS_IBITYPE(status);
 	ibiaddr = SVC_I3C_MSTATUS_IBIADDR(status);
-- 
2.34.1


