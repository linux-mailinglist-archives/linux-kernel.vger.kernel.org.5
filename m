Return-Path: <linux-kernel+bounces-158471-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 534918B2099
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 13:45:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BD9D31F22DF3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 11:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 330B012AAE8;
	Thu, 25 Apr 2024 11:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="qkOxP2Do"
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2048.outbound.protection.outlook.com [40.107.215.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D9F012AACE
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.215.48
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714045516; cv=fail; b=OiBLfia6Iy0jUUYxd5SXJT5eiXhS1c8OhpM3DVSLnE8V3gbbK91Gq56zbk2yTadNc+zQrPQeaH/YiWICkkyS2UIydkEHabkA1NAV0YcJ86IxjWsuxVeFRVodXMDncVBQ1BvopWB9Oppe4K5T94gOegckiAU8nJ2yCVBxkdLdVCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714045516; c=relaxed/simple;
	bh=PLLsyBJG9f/lWeWJEwc+1farwAAGQdKPzJj0sl7++HU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dBMF6c++284blxfKQLR+HqzXAmz1WzbGlNkikKsipEPXbnvjh+YzJ9t4o20dFdoThcNw+4KnQwqA9wLG0H4OTpgsOhpRCatIoXpgSnystlYH0Q5g0idj5s8CffdqRxVoXjKhtIVB+pLTchJMPB3m0ZK9AwBwSV0HLsD7k3Hamck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=qkOxP2Do; arc=fail smtp.client-ip=40.107.215.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EeUfWiwiNmlpbajtiX+kxk/m+zg7TjqbWSZFeTb0/Z/t533Bb1ry6Z4N7w8e1uvif330H5kE4mBgPpf8jQ8LQA17RrUa7U9BfSIu4Tb9/WRE7HtWZT+q8JC2IeH6lTc6IUyf0j2iqeZL8t1cP+9qtA1chuwwOYgJa6WtALfJ/m9jtAvm4C/6UPyND0KjzFtHxUIpKzxB9XNI83cpNYijMNdrG9bZrwcbgAbWnQwoQtECl5cl2f1MiyIpn9jWRn9dXMjErz/kLy3XF1WYK1W48zRjQIMxbGFFk5kkY3B6aIqRxIRyIMpvBvAlcKx13YTSo89/qzUnmxgdOOOrlD/asg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=kQrmkhkkPw+IJloRvG0lwFzwcv0zURqFoso9Ur+ok5g=;
 b=gGS32wU1PG02a54TkNO4LWH7KnlebxgmVRoma6T6bwn90uoVR/xkJcwBdgOogDMMlq51lO/Lyxox8RNyCAsF4mrLUa/WYd0QrRDYdmvxgLUN9JZdtxDveK9/6B4Aw7hPtIr9vDxhaqOjZX0lIRS0hl5vPrwfOOGE+GPw9LzVhKKl/TtWvPaqYoU63EiFtSoCmCWFpp3jnk8E1bbNE6cNjvKDF2OTI9ptdPgy/Hi/vzrKUgKbV5+l3ek5wZAunCueJbHDgcQ5BR2F5O4OsIGpmxpcLb5xm2GXaLx8gPv/5IhrqbwY13eIzAcUlf/hxicPPouN7Vo8vGZR11Z0rW6BOA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=infradead.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=kQrmkhkkPw+IJloRvG0lwFzwcv0zURqFoso9Ur+ok5g=;
 b=qkOxP2DoCKqNcgs3kXiBCDB8Qjvr07qGlK4aF09ZLag+a3FPvfX6oOE9xCACyQ3SCDLE6Q+MRqJdqz6hka+zUFjJ2oULJYBytykvkPA4YIhacQn/VN4tzdluzgbA6YfqHk3yMN8skDsvGUBB3dhFB4zIbsTcHyt2z+RRLIY3I64=
Received: from PU1PR06CA0002.apcprd06.prod.outlook.com (2603:1096:803:2a::14)
 by SEYPR02MB7439.apcprd02.prod.outlook.com (2603:1096:101:1df::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.24; Thu, 25 Apr
 2024 11:45:07 +0000
Received: from HK3PEPF0000021E.apcprd03.prod.outlook.com
 (2603:1096:803:2a:cafe::b9) by PU1PR06CA0002.outlook.office365.com
 (2603:1096:803:2a::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.25 via Frontend
 Transport; Thu, 25 Apr 2024 11:45:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 HK3PEPF0000021E.mail.protection.outlook.com (10.167.8.40) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Thu, 25 Apr 2024 11:45:05 +0000
Received: from HUC.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Thu, 25 Apr
 2024 19:45:04 +0800
From: <hupu@oppo.com>
To: <peterz@infradead.org>
CC: <mingo@redhat.com>, <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
	<dietmar.eggemann@arm.com>, <rostedt@goodmis.org>, <bsegall@google.com>,
	<mgorman@suse.de>, <bristot@redhat.com>, <vschneid@redhat.com>,
	<linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] sched/fair.c: Fix the calculation method of 'lag'
Date: Thu, 25 Apr 2024 19:44:59 +0800
Message-ID: <20240424085533.GS40213@noisy.programming.kicks-ass.net>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: mailappw30.adc.com (172.16.56.197) To mailappw30.adc.com
 (172.16.56.197)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: HK3PEPF0000021E:EE_|SEYPR02MB7439:EE_
X-MS-Office365-Filtering-Correlation-Id: fdde37df-8aa5-481e-3fc5-08dc651d268a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|7416005|82310400014|36860700004|1800799015|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?IkCDY9A3qvTuOV1beYEy8hWsufK9tz04b35Zt4GlKGv4VLgxu6WNFG3jtIlz?=
 =?us-ascii?Q?Q7RLBjqCm7h6CbQ31htWUj4gyxrEXPYTUWWrywXyyr2+fS5cYHpKs/cQ1bLu?=
 =?us-ascii?Q?ijPOal4OISD3D33bXlQjaS81nW36R9VNt9RmWrkqDubKVsOK+Ahgx2xMKz9f?=
 =?us-ascii?Q?yiHbyH015jdH1ZMkGzEA7D0saMcG3gHyZBNSVzPdqXTWL+lmsDoVBllr8GRF?=
 =?us-ascii?Q?LRMGCuPJKbZvTAj6Izc3KZaiBbZDsPGBgwn8vvgQwPyckFwS+8LxudFT7+U+?=
 =?us-ascii?Q?RIhsikYOfK+Jr7iCe3ZcHsHCHlb5rTW2v8OOjUw+2MxPYxdKUUGMbwjVAhaw?=
 =?us-ascii?Q?UhSZkL6ttZWAt1q2PMeh19oooehonTTcwW8/KXEiqRYuKN+rTmBTgCW90oef?=
 =?us-ascii?Q?rgAjJkylt0oOQ/F409qmODQ3WMcQjDz+ff0lKIDOvqApjSeXgKPeGekJQX8Q?=
 =?us-ascii?Q?khzk1ZF+m+s3Jq2zhNDniDbNgIzElhof0YIizQ+SWrjChlG/vimizyUMRMVN?=
 =?us-ascii?Q?Kn/7uxxYjiiZ+yLY1RR/MlOMZsU+pV+hBh0RAdwnguOV4Nr+jeE6S4qtSx2H?=
 =?us-ascii?Q?/kMinSzzZjtt47IEjiIKVzrTBHCPcf4CwD/nzzec5N8QidgbWQXsrsDj4KlF?=
 =?us-ascii?Q?0eYN304TLXctU6clKvb9YWtQ6/QCr1j9hIYJF6BUfSs/ehhsShVRSBepqRJu?=
 =?us-ascii?Q?OLeab24mNqBPBeaZlWiJVeb1gQUQEuJ9wXCXF/kUVozMRFviTBIwZO2ney+9?=
 =?us-ascii?Q?2CvqkOFFdUVaKjsVoXg58zxlctprm2uJ5NYa9SGhhCjhmGk12oqjdKD15anl?=
 =?us-ascii?Q?hr7hjVzXDUU2GoYWsgzuwF/v68DI1Q6Ivfc7y1k4fITb1mi4ibs4rTlDUcGn?=
 =?us-ascii?Q?HT4GEIunOstt8/qzSkpM8ugcxpi1BaL9iT90eXToyTsPSjaE1dCc+bnstTYM?=
 =?us-ascii?Q?GnWUcFNoBtx/OI5G4tM88c07znpaCzvAzwDGAhwuZk21p/MOi0Bjd3ijpgp/?=
 =?us-ascii?Q?KJ/Oa1wV9CppQxHJeFs76oO6GgT/vHfISbGPkmSAKUedNlOYrnx00zx5L4np?=
 =?us-ascii?Q?gcqdkerNO2UpaY6VBkPznPQ2C8jPo95fD9A9tpigoruaQLj82gaFh+DbTPH7?=
 =?us-ascii?Q?jZ7Ln50N9S/uhomYNRREfnjdolhO1iP5IiAwRW3VqWO+DIV5a2bLQqmGpsAw?=
 =?us-ascii?Q?3I0rdw0RY4Ex4ftgQgConbgQYCns4In22NWtzlyamrRXxqFEJHUOUW3KF6rS?=
 =?us-ascii?Q?9CM+szQyBwC3FQe0dAVckwYZWxp0/+W6hdTCTGTw1gCRpukAkz+m6T4R2UEv?=
 =?us-ascii?Q?MKmTA+F10jTWt+gdWdd+CCjxbVJ4A73D4E6InYxXQcjA5/uyRit8cGsbyVW/?=
 =?us-ascii?Q?ERHhrc8=3D?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(7416005)(82310400014)(36860700004)(1800799015)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Apr 2024 11:45:05.3100
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fdde37df-8aa5-481e-3fc5-08dc651d268a
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	HK3PEPF0000021E.apcprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SEYPR02MB7439

> > From: hupu <hupu@oppo.com>
> >
> > I think the 'lag' calculation here is inaccurate.
> >
> > Assume that delta needs to be subtracted from v_i to ensure that the
> > vlag of task i after placement is the same as before.
>
> Why ?!? v_i is the unkown, it makes no sense to complicate things by
> adding extra unknowns.
>
> > At this time, the
> > vlag of task i after placement should be:
> > vl'_i = V' - (v_i - delta)
>
> But but but, you can't have V' without knowing v_i.
>

Thank you for your patient guidance. I overlooked a important fact that
v_i is unknown in the process of proof. Below is the complete proof
process, and it turns out that you are correct.

(I put the formula in a comment block to prevent the email system from
removing the spaces in the formula. This preserves the formatting of the
formula and makes it look more readable.)

The following formula is valid BEFORE placing task i.

/*
 *      \Sum (w_j * v_j)
 * V = ------------------
 *          \Sum w_j
 *
 * 
 * W = \Sum w_j
 * 
 * 
 * vl_i = V - v_i
 */


The following formula is valid AFTER placing task i.
/* 
 *        \Sum (w_j * v_j) + (w_i * v_i')
 * V' =  --------------------------------
 *              \Sum w_j + w_i
 * 
 * 
 * W' = \Sum w_j + w_i
 * 
 * 
 * vl_i' = V' - v_i'
 */

We hope to preserve the vlag which was calculated during the last
dequeue operation. So the proof process should be as follows:

/*
 * vl_i = vl_i'
 * 
 * =>
 * vl_i = V' - v_i'
 * 
 * =>
 *          \Sum (w_j * v_j) + (w_i * v_i')
 * vl_i = -------------------------------- - v_i'
 *                \Sum w_j + w_i
 * 
 * 
 *      \Sum (w_j * v_j) + (w_i * v_i') - v_i' * (\Sum w_j + w_i)
 *  = -------------------------------------------------------------
 *                           \Sum w_j + w_i
 * 
 * 
 *      \Sum (w_j * v_j) + (w_i * v_i') - (v_i' * \Sum w_j) - (v_i' *
 *      w_i)
 *  =
 *  ---------------------------------------------------------------------
 *                            \Sum w_j + w_i
 * 
 * 
 *      \Sum (w_j * v_j) - v_i' * \Sum w_j
 *  = --------------------------------------
 *              \Sum w_j + w_i
 * 
 * 
 *       V * \Sum w_j - v_i' * \Sum w_j
 *  = ------------------------------------
 *              \Sum w_j + w_i
 * 
 * 
 * =>
 * vl_i * (\Sum w_j + w_i) = V * \Sum w_j - v_i' * \Sum w_j
 * 
 * =>
 *              vl_i * (\Sum w_j + w_i)
 * v_i' = V - ---------------------------
 *                   \Sum w_j
 * 
 * 
 *              W + w_i
 *      = V - ----------- * vl_i
 *                 W
 */
 
-- 
2.17.1


