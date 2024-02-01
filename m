Return-Path: <linux-kernel+bounces-48142-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8434D8457EA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDB7E1F23942
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29ACB86631;
	Thu,  1 Feb 2024 12:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b="F2qNj7Lz"
Received: from EUR03-DBA-obe.outbound.protection.outlook.com (mail-dbaeur03on2048.outbound.protection.outlook.com [40.107.104.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FA486629
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:37:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.104.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706791024; cv=fail; b=mbzxp3Ej0mykDl1FsqTDoy40y0A9Jf3iTVOlKFq72WsNaf0zpRSPzU6aCMe6KcRau4VQzPMk2MoR8Yzj6sL6sbE+Q59iWZC1ck6qxsidAvyRFK/ZKGO6ZxKvWqFwFCeg9iXQPj1YULIrQJp4C5244i5Ry/qD/F0pskt0Wv/6Akg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706791024; c=relaxed/simple;
	bh=xYW8A0o/vVYNFQr1InCF/cuhfEWISaV0vQFj8aDgPUc=;
	h=From:To:Cc:Subject:Date:Message-ID:Content-Type:MIME-Version; b=L04JXipmbu3m37SAxwnBkUnSJKdKDhNJ0JKonlnwtYUjB48SNITZAVP+6qGIM0zb1pJkWE76lUc73+IWE5GnBuzgr26n27yrXPF59+J/2RAg2SLURvmY4HqHdq1zjwfR0ZCBfRjm4H9D7c3PnqC8XUX/4ZOoH1eNZg4ANgGwd1g=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com; spf=fail smtp.mailfrom=nokia.com; dkim=pass (2048-bit key) header.d=nokia.com header.i=@nokia.com header.b=F2qNj7Lz; arc=fail smtp.client-ip=40.107.104.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nokia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nokia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mCMjnNAnMq7hYni6R89U+jKDbpDizR1hWTRxVRyXZPf1Fq2HEcWst4Aw8B3hO1YXELCYNGoiTvQO/2LXUbz8Debs6DvctJPjXvWiZRocjW2of1qlAgQZ3xMDjGQjYblSWvUWrgzdDwfDU3lJz2lvniyDGMHUfy1NfiY8pr2SuILl5ch35wnHUm6+GLSuUIXZ8XtZzSG4sxWMS2ZK+59BEIuj21099PlEltc6utCySvH8tUwewCwLKo59ifk9ftS0cNf7chTbQkGRyVRL/XE81wuEKEK4Q0CdD1m4pLkvHdm0Rnp6ji+4fH+NfViEUi5ntKYc9Zn/IdHwAD+drEnDDg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LTYjn6ZRFWRT2GcMarkHWIalYyRKHt9eVBV0oXaBeF8=;
 b=cQKo4arOnXFNHaSyyYchVJYSEqpgxHnxUypBK+4I7aE7tlloeAJMjqxQ4Y22Lse3LlJEt+x4jVr4hxsPw3HWkBoPaQQr5WyJW6y4jjfqVOQ7HR/MvJUg4YQwi6qs2hyHjIgYgMmUR60wXsmSJEud8X6sAk8jQ+/put81TioqpAapVvF5Ip/nPvOjwn2F+Lg0SO7qx77WZVvkQDqhvxUUeKlq+6TaWRvdQJ3RwU5t17AIjZ2yq46E0UEzZnC4U9TkdJ8Oarv65KkKJ+lSknylhe3E/BNLZpGUOlnEYI56OFIpbX3yyVWFgrM/jbp0q1KrsxSIvCfoNM0SIOrQeMcj2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nokia.com; dmarc=pass action=none header.from=nokia.com;
 dkim=pass header.d=nokia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nokia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LTYjn6ZRFWRT2GcMarkHWIalYyRKHt9eVBV0oXaBeF8=;
 b=F2qNj7LzB4kmfs5TwO78SdsPOFm00jQaSrV/o3RIOtCyeR+XQxcU9eiBsQpPqTTxOEEEGU/J+d1XWWBwXPSGBvHo2LMaoBpTunmn8K6ZXev45YqBtTaZJP8TgXcIub/ZsBsiGMznvWMWAIxFBJJv+rvxiMYx1bTJLvFOr3bjOAt/mdm2zPTkXIDFHaJ8XdKQ6MGEX+5Lty3qZhka4hK/gXqkLMJAtyLYKRSvjxiMqdZnLPr+sYwQp+0iqXoHEwDADpfeMiA8G/dgund66bCx7+9ik9Bl9XmCcJ6uY1CcFtUP5CtqH3ceLzsGjtgEI/q1cqArFAm+3rX3NWSk5FnTMg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nokia.com;
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com (2603:10a6:102:383::17)
 by DBAPR07MB6694.eurprd07.prod.outlook.com (2603:10a6:10:184::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.23; Thu, 1 Feb
 2024 12:36:59 +0000
Received: from PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f]) by PAWPR07MB9688.eurprd07.prod.outlook.com
 ([fe80::22a6:5b92:a2d3:860f%3]) with mapi id 15.20.7249.023; Thu, 1 Feb 2024
 12:36:59 +0000
From: Stefan Wiehler <stefan.wiehler@nokia.com>
To: Russell King <linux@armlinux.org.uk>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Stefan Wiehler <stefan.wiehler@nokia.com>
Subject: [PATCH RESEND] arm: topology: Fix missing clock-frequency property warning
Date: Thu,  1 Feb 2024 13:36:06 +0100
Message-ID: <20240201123605.3037829-2-stefan.wiehler@nokia.com>
X-Mailer: git-send-email 2.42.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: FR3P281CA0018.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::11) To PAWPR07MB9688.eurprd07.prod.outlook.com
 (2603:10a6:102:383::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PAWPR07MB9688:EE_|DBAPR07MB6694:EE_
X-MS-Office365-Filtering-Correlation-Id: 02824d18-236d-4f11-8dd6-08dc23227bc4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	sszqyLBgRESUlHqk1zzYx61bYsM0DDUVOHAEc0sPfvEP6eoDJhw9L1IG2/x1cOqBTDRc+JHs969JzhYHmrMxkHOYOexqo3p2eNWI2fzERBExqwD2F65Pe+moWVhdR8V+GYL3LNxo/KLfdNmfbQ3UX2BHkLasyGHVXIODBY2MZDZdvRGXx9H7PezUygyrHagnVroU4Yx5+CUmUB2ESmg99kgNj4kP8FljPq1JfUrpNXg/GHKlzwGKX4wvzwVESosTeKorY1eVygLA5idLVYk6EdO3LIqI6TQ/EpyIEFFQXDJfIOZkdZtjErlDg+cPhBkACGSpBSUpqgfV+1AibdtzpQzwV1g5etH9+IoOLlViKyzbZ9EgWxTkfb7OBdVdUyibliATNR+FqjNgUIkc/lbjouSAtawIjyYuZ4r0c6/1BmuiAUB8fgGWaJOXaJR3recXV/Iyv2qx8bv17aRGtYmZShPa/KBqpWoAlwGvzcDnSTjzCNN++iu63UccF7HzL2ppuHm1uiVkEl2ryBiISZ7KB5fAVlfaaLmeDOpHtN0BI7LJ2hE650imybNkm1LvwMnZCns4lCU6EkRbRiPMfAcg8Cn77wE3SVJeXdiNPiDXEkylQ4Q6vhW65oSrDCyqHEB+fXkyYHTvZufMjOPf7plimEMCT6joJpImU69DqBzFkTE=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR07MB9688.eurprd07.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(366004)(376002)(39860400002)(230922051799003)(230173577357003)(230273577357003)(186009)(1800799012)(64100799003)(451199024)(2616005)(107886003)(26005)(1076003)(41300700001)(52116002)(36756003)(6666004)(6486002)(38350700005)(6916009)(66556008)(66476007)(316002)(478600001)(6506007)(38100700002)(82960400001)(6512007)(66946007)(86362001)(83380400001)(2906002)(44832011)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?M5yE5GRioq03tPzu+n6LghJFQuVMW9Z1jApzmgYBJ+9iVgiqPE3I+c7q9gJy?=
 =?us-ascii?Q?LvtpL/Ep2OvaOCGP3HZVJlNkWX0sD6PRDdW8QSkioB2PEQVBv6t8yGikBm7E?=
 =?us-ascii?Q?uFUaq3BtgzqCKZulDVdVtC4P9MBXadKfLeYrgv5Zn+pqGCKVn1XFNdl6VIU3?=
 =?us-ascii?Q?6eHHhG00RMTewa0DFD9eP8OAYscbX6P47VfdbtwTHLrAV0a4mKvCN/kOd2Zr?=
 =?us-ascii?Q?UAJUdJLkFYW4oYb+esRaeOFgIHB7GAMPB3NFAUSbNnCReSO4Ivf75/y2WOgY?=
 =?us-ascii?Q?B64S4DsNucHqYiewPCX9Pl2kzxan83/6lzJMXm51I3Soq6ns1inQIxH77Nam?=
 =?us-ascii?Q?bnmQvLbfKneEz8pY2ttHBZyRBfzgwESM7eTdCfE4Bk4MOBtC3BCtMOWN4C5G?=
 =?us-ascii?Q?swELTeQjFD2IHGUMaWM71bp+o6X5cScOxUOU77DPHKzumuTo1SRiT+tNNfcv?=
 =?us-ascii?Q?tgv1t6q4tCNXoARYTVkvjMNADKQbS/zlYhoicX8TpUG/owoz/nfRGwInhSOB?=
 =?us-ascii?Q?w8nTlMza8T4TPLbXMQkRPEUW0gbhHxP3ZAFqbkDtWt7dK8uScFLkIpr81DXN?=
 =?us-ascii?Q?MBq93EHcl3FCFb7H35W9lFix0m2OefBSOnUY593xF3DYoUj+tSngwnyAd9GR?=
 =?us-ascii?Q?TCdTb0Hp4fy7A8lTdMhaoWqM34O5u8OX9dZdiPnQsT72IaBhifxsfSaR4au2?=
 =?us-ascii?Q?4Pfn+pIYijetIWovKX1oMvUYh3WfSoRAog2uPD91jpXpwoVCh6O8PESmTwRD?=
 =?us-ascii?Q?3dDB5vi/8G9E/94hPoEAWyBY2tL+aF8vC/34e8WIs/TvVviZsu4DWARLCb36?=
 =?us-ascii?Q?J8cSKqVJaBlj9psUkBNcn+ERZTQCCokp5SvCYSVdKr0nJkcBIURqq/bu0Pmd?=
 =?us-ascii?Q?0a+x4xi8MkXZNz/pE8IwqP2SEnHZKqwJYQypWor2TWrgQnrIYJrn1qJ8HyhS?=
 =?us-ascii?Q?UML8/X5S63Lwrzy5whzou9RLQB+u8vpPqbyIibC5bJ1v8YaoR26RTmYGBpED?=
 =?us-ascii?Q?I5bME51w0tJ0QsW00Y5drXRiLRbxGRnAc8kjU3Ht64vKQDHVdSWPRr54HAVZ?=
 =?us-ascii?Q?9C9yyqYbe1Q2hrGWpAGky7fIlZJfwMZqNInc/uTf4th3s2bHmyccKArfvcbc?=
 =?us-ascii?Q?oEe2Rv6Ew9084ub795LT5wlmD9LmflLOxNrTcaX7i6RWX2hSEusWoLvVyafb?=
 =?us-ascii?Q?+iBQXn+NpOeiIRXzNDYoriMWWUDM+NEXei8Z0fH4/+5VVtuHOEB9+gpCHHe7?=
 =?us-ascii?Q?QT4+dIXUqCDmrkcuRdUp3bauPjSMtCwyCjGNdYUQbW1adf+jHa3zSnaiuViR?=
 =?us-ascii?Q?K/wML2riKEKGV41EPaniPsj8A/T5OpiaMLwVSImyWnQx9RyHr5CcnGN8gG8h?=
 =?us-ascii?Q?HyGoXJDHEiygXHCKgfBsTtWn35N1AifcdFbR4k2I3gmeMKmOeqpBYzXcoj3+?=
 =?us-ascii?Q?Os15OxXmILNkXtL8xqlwl2PMIWXtB+bpcmKG4szrWdHZRYjsZgERsTtV7MJv?=
 =?us-ascii?Q?TpkM8rgXYrETRxRTXkw1AqUE48XHO6r2RwXwQgEx1uSguO13J46GRt3kaDgr?=
 =?us-ascii?Q?XGIrDRDy5fg2nZasOkHhmGYoY4GMCRHMHpPJmCiXoy//YT8eCvyJO13JRcsp?=
 =?us-ascii?Q?TA=3D=3D?=
X-OriginatorOrg: nokia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 02824d18-236d-4f11-8dd6-08dc23227bc4
X-MS-Exchange-CrossTenant-AuthSource: PAWPR07MB9688.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 12:36:59.3113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5d471751-9675-428d-917b-70f44f9630b0
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: jvcqXyKJS/rXDWNZebNpGxU5hFvAOhG3HtzKYvsJBwcY8+tNOlietosqVe7I5jSwT8Id7da4jHru3iVBdG82LZcOb+wRQQtVWvwa42mdtxA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DBAPR07MB6694

If the clock-frequency property is not set in the cpu node but in the
parent /cpus node, the following warning is emitted:

  /cpus/cpu@X missing clock-frequency property

The devicetree specification in section 3.8 however specifies that
"properties that have identical values across cpu nodes may be placed in
the /cpus node instead.  A client program must first examine a specific cpu
node, but if an expected property is not found then it should look at the
parent /cpus node."

Signed-off-by: Stefan Wiehler <stefan.wiehler@nokia.com>
---
 arch/arm/kernel/topology.c | 21 ++++++++++++++++++---
 1 file changed, 18 insertions(+), 3 deletions(-)

diff --git a/arch/arm/kernel/topology.c b/arch/arm/kernel/topology.c
index ef0058de432b..32fc1c8d9d11 100644
--- a/arch/arm/kernel/topology.c
+++ b/arch/arm/kernel/topology.c
@@ -85,15 +85,24 @@ static bool cap_from_dt = true;
 static void __init parse_dt_topology(void)
 {
 	const struct cpu_efficiency *cpu_eff;
-	struct device_node *cn = NULL;
+	struct device_node *pcn = NULL, *cn = NULL;
 	unsigned long min_capacity = ULONG_MAX;
 	unsigned long max_capacity = 0;
 	unsigned long capacity = 0;
 	int cpu = 0;
+	const __be32 *common_rate;
+	int common_rate_len;
 
 	__cpu_capacity = kcalloc(nr_cpu_ids, sizeof(*__cpu_capacity),
 				 GFP_NOWAIT);
 
+	pcn = of_find_node_by_path("/cpus");
+	if (!pcn) {
+		pr_err("missing CPU root device node\n");
+		return;
+	}
+	common_rate = of_get_property(pcn, "clock-frequency", &common_rate_len);
+
 	for_each_possible_cpu(cpu) {
 		const __be32 *rate;
 		int len;
@@ -121,8 +130,12 @@ static void __init parse_dt_topology(void)
 
 		rate = of_get_property(cn, "clock-frequency", &len);
 		if (!rate || len != 4) {
-			pr_err("%pOF missing clock-frequency property\n", cn);
-			continue;
+			if (common_rate && common_rate_len == 4) {
+				rate = common_rate;
+			} else {
+				pr_err("%pOF missing clock-frequency property\n", cn);
+				continue;
+			}
 		}
 
 		capacity = ((be32_to_cpup(rate)) >> 20) * cpu_eff->efficiency;
@@ -154,6 +167,8 @@ static void __init parse_dt_topology(void)
 
 	if (cap_from_dt)
 		topology_normalize_cpu_scale();
+
+	of_node_put(pcn);
 }
 
 /*
-- 
2.42.0


