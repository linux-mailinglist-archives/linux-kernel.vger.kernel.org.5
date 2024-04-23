Return-Path: <linux-kernel+bounces-155091-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E49F8AE532
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:00:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E954B284D34
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C1B1350FE;
	Tue, 23 Apr 2024 11:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="tVeeeaDy"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2089.outbound.protection.outlook.com [40.107.117.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C04134CF7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 11:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.89
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713872675; cv=fail; b=VZ39YPlgwjEiMAaTxGdHjg12uw1Lhx5vzW7lekj+gFurp44wzcjoSeDu1JkafSMaQkKgHIWQWR/0l5ATPT894CRbnf9563FxvR+Y78D29PvlIk/6B8Z6wtVsjgn1/9HSW/vJOz4bmDB1JY2K9Nfew8HebXSy64Cm0dwIHLoVibY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713872675; c=relaxed/simple;
	bh=+PJ73CGrUg7zSsBwgP47mEApAm4vav4tEf0E66uZt0Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=XJwgko2aAAIp+1dcIPuj4bZE6UihaYcSLrIftgrDEMFWlhqCjBIi6cRKNiZMuFszwUY8q0mhJ0Jvonp+VhvH2fa0L5/RD+fCPk7DK7yAA0KBX7xVadpn9L3HSu1bFESoRXmC+zHuK6KKMffzJ819AKX3LsNar2pbFk0F3KNJquw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=tVeeeaDy; arc=fail smtp.client-ip=40.107.117.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AVIDxGMLj+c4S83wxEqjWN1qiCfXr4IFCsDRU3rTvv6yTbJfI4Yz03TVpLTqGBYuuHX9JPqHO+21jglOvRaN1AwVZn5aqPRIoUiSBSmZ/J+CK4HBzOE3Eexa4jwbkCBxk0sEiw5Pj+QBMjM/bebIE/wYKjzwePlt2pIoNMy5G4Tr0BFoTHY4GjkpijpkA0zQvL3mEj/FCS0UKh2Y/5BHBMPJw+DKMu9lRAelH3v8kZI7tD7wKdM2GG0plh7tFTDeBazMdRc/IeiZ0avk3elfQgLl6++jDpueQ/UxZYN/ipv74iBeFgOrA2ok/fcb7K8m5vUj2behlv+EvJCKOvjlyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=npEKPgJnuiYSO3Tjv5Q7AZRg1LXdHRx0GqiUP1Iezog=;
 b=gorOpw9DmqXEP/z45GmUPpkBAyDFTa5WZpRjSS2HdoBwoRqGV/z9eBW43hFrBjzrzlSwmNXQblwhXD8Or50m8poqy8g2+n6LgIaEPgz72flg/7kDNse4ff3WEbv6dbIPZ2pwXJbTN7o9OW4h3/hOtVv49QKHmE+KDRW41eb1YlxLQuYe7DOxPVlb8SWhPEcoRdeeXw1CpF+d9wG3HqbwsPqHh5lQjkL1U4OJGeRa2T4+qi0uNHzHsF+x4O4tmdmb1ZhxXCP4suZR1G6q0+rt89vVRZONnWpxpP83U4lhz1536LEDl5KHAWO2lSbJrtx3n3vCMfd9un/j8oo9Ale+rg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 58.252.5.68) smtp.rcpttodomain=infradead.org smtp.mailfrom=oppo.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=oppo.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=npEKPgJnuiYSO3Tjv5Q7AZRg1LXdHRx0GqiUP1Iezog=;
 b=tVeeeaDyRLpN/VIG6mAN3WEAk3RKpwNcEsig2r5RMiwePzLMhF4CFGIbpffYmCAQlZzxpN6Ktxd365zJLEfdgUKEupfhkKGBpgsA9ECYTP1QzDO3wUUNbjIWLPvbuQC9umrqd/KKZATgHHjdg12KYa2bvhYG0XJcnbgJTNjeRpw=
Received: from SG2PR02CA0008.apcprd02.prod.outlook.com (2603:1096:3:17::20) by
 SI2PR02MB5705.apcprd02.prod.outlook.com (2603:1096:4:1ac::8) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 11:44:30 +0000
Received: from SG1PEPF000082E1.apcprd02.prod.outlook.com
 (2603:1096:3:17:cafe::d9) by SG2PR02CA0008.outlook.office365.com
 (2603:1096:3:17::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7495.34 via Frontend
 Transport; Tue, 23 Apr 2024 11:44:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 58.252.5.68)
 smtp.mailfrom=oppo.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=oppo.com;
Received-SPF: Pass (protection.outlook.com: domain of oppo.com designates
 58.252.5.68 as permitted sender) receiver=protection.outlook.com;
 client-ip=58.252.5.68; helo=mail.oppo.com; pr=C
Received: from mail.oppo.com (58.252.5.68) by
 SG1PEPF000082E1.mail.protection.outlook.com (10.167.240.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7519.19 via Frontend Transport; Tue, 23 Apr 2024 11:44:29 +0000
Received: from HUC.localdomain (172.16.40.118) by mailappw30.adc.com
 (172.16.56.197) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 23 Apr
 2024 19:44:29 +0800
From: <hupu@oppo.com>
To: <peterz@infradead.org>, <mingo@redhat.com>, <juri.lelli@redhat.com>,
	<vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
	<rostedt@goodmis.org>, <bsegall@google.com>, <mgorman@suse.de>,
	<bristot@redhat.com>, <vschneid@redhat.com>, <linux-kernel@vger.kernel.org>
CC: hupu <hupu@oppo.com>
Subject: [PATCH] sched/fair.c: Fix the calculation method of 'lag' to ensure  that the vlag of the task after placement is the same as before.
Date: Tue, 23 Apr 2024 19:44:16 +0800
Message-ID: <20240423114416.64308-1-hupu@oppo.com>
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
X-MS-TrafficTypeDiagnostic: SG1PEPF000082E1:EE_|SI2PR02MB5705:EE_
X-MS-Office365-Filtering-Correlation-Id: 250ead0f-9312-47e6-3e67-08dc638abc7d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?8VhqBp9OchweuWHFs1KEIfrH/EprGdtHcqPz98L5iH/rGGP6FL9SelGfjI71?=
 =?us-ascii?Q?en+zyMjfiSByVhGyDUrPAcG7o3U+j1nxNVYbn+QS2l4ou4z+q85CptWobBmQ?=
 =?us-ascii?Q?2tXhRE/lZJVb1Iu6MkQpKT5VTZh4BDvryOzb2MPZLUeKkoyQ+PvX7Y7Tp4QC?=
 =?us-ascii?Q?EpzXXuVD0xz6B3I1lpQHke+ONN0CeRRXkMfcr6zmY6oyvhu9vxLnGBdTq0uI?=
 =?us-ascii?Q?iRtMgQ1wFmroWciKavxyXyd37F0SbY9SjN/2RcgnruLC6iAB9oOUsLJZcPBM?=
 =?us-ascii?Q?+RovTjcJ/NkdWwfT2ks1S7ifoCElvSoLaqnFFP6/gSwL9VCKvbqcrwikRiiM?=
 =?us-ascii?Q?QLIhM/XBDIz46Xhl8RXeCBA87+yt2bDrP847MrIB5xhudvUVckQPD9AvCio8?=
 =?us-ascii?Q?aW3eH+zUtFI9Kz9ekfksMgOkh4A4epeD9+DlrFUC3MsXj8Cxs8XWVfm6d4wT?=
 =?us-ascii?Q?ONsMTqrOpllT20VC4iIZSsuXbVqSxWaoRFWgWS01+eGiX3a8XOve3t9ZdavE?=
 =?us-ascii?Q?p4iaNjTRH/jNbraYVO6ikJ1PsTKf9qcLTyJoaX7Q3PDSFfeOxD4UTfmv+oS0?=
 =?us-ascii?Q?XcpR8vNRphc5+IMyGbfXwt7t7QeM8OAPY/lfzhic55g3c55IrD73TNmhdI1G?=
 =?us-ascii?Q?KfzLJo4UpuPQkWjsW0higOlcKW84Vs67YKpGhLWQN4/sdKe+MgllC1FyyQsX?=
 =?us-ascii?Q?P0PXNc5eKBQG3FJ0+3THlPaur7JgKM+vyATPjsI113AK/OerIkWV8HoNi5YN?=
 =?us-ascii?Q?cVT5UY6WG7qSNZRw7NmBDMJEZUkz1LSb+GohyutkUJsuVWbyFQ/ukiTv8V5S?=
 =?us-ascii?Q?ac28O90MykDaOpvKwMRraxNhasOslbUQFdAdSZYWkYfFoYHnk7gr8fIIyA4V?=
 =?us-ascii?Q?rYstXmbWseEV7Io78K5PTU7ATbWFBeBsf5o253wFDI8zKAv0XoYRr9P5cOG1?=
 =?us-ascii?Q?Y5EKRVzoDCqDlMeIUK1cBqQX1kEORAyM5GK25uAvTI0Gd28iPc5i0aadfFBe?=
 =?us-ascii?Q?KssSAc78Sm6QOeey+XjG8c0ZYUowbRMP7fqJ30CHSr6C9u2GurAyjNKg8nQD?=
 =?us-ascii?Q?0BO2Vjgemxkv2hQTirFasUckzfYp8+zOMi5yRHOd6PcaClPsExgwBCmEgDy8?=
 =?us-ascii?Q?fuQ0jvI14Vam3kSt7N2idLUzNZc8Ejy5FMsV7lPyyRshDPwZOsEBCyMz1bGe?=
 =?us-ascii?Q?q+YqH6UaFY6/42uH7Wgwgzg+YZbhARoxn3xtpuzZ0j0T31J3KAxYjujA7vUO?=
 =?us-ascii?Q?Ev02PkejjpaCI/u1BlkYcRHrz99OhOa6RGNE0kXlegEhHC7MZzC+DMCiNBto?=
 =?us-ascii?Q?v9BuqM4k8EPteCurIW35m/9Efeyio5NOOVlAHUrMH/+yQsZz/GNi5vOZHhAk?=
 =?us-ascii?Q?XBMbJmUCU319B3OKPUaMZrisXRv8?=
X-Forefront-Antispam-Report:
	CIP:58.252.5.68;CTRY:CN;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.oppo.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(36860700004)(82310400014)(1800799015)(7416005)(376005)(921011);DIR:OUT;SFP:1101;
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 11:44:29.7635
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 250ead0f-9312-47e6-3e67-08dc638abc7d
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=f1905eb1-c353-41c5-9516-62b4a54b5ee6;Ip=[58.252.5.68];Helo=[mail.oppo.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SG1PEPF000082E1.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5705

From: hupu <hupu@oppo.com>

I think the 'lag' calculation here is inaccurate.

Assume that delta needs to be subtracted from v_i to ensure that the
vlag of task i after placement is the same as before. At this time, the
vlag of task i after placement should be:
vl'_i = V' - (v_i - delta)

From the above formula, we know that vl'_i should be:
vl'_i = (vl_i * W)/(W + w_i)

That is to say:
V' - (v_i - delta) = (vl_i * W)/(W + w_i)

For a newly added entity, generally set v_i to V', and the above formula
can be converted into:
V' - (V' - delta) = (vl_i * W)/(W + w_i)

Therefore the value of delta should be as follows, where delta is the
'lag' in the code.
delta = (vl_i * W)/(W + w_i)

Signed-off-by: hupu <hupu@oppo.com>
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 03be0d1330a6..c5f74f753be8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5239,9 +5239,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 		if (curr && curr->on_rq)
 			load += scale_load_down(curr->load.weight);
 
-		lag *= load + scale_load_down(se->load.weight);
+		lag *= load;
+
+		load += scale_load_down(se->load.weight);
 		if (WARN_ON_ONCE(!load))
 			load = 1;
+
 		lag = div_s64(lag, load);
 	}
 
-- 
2.17.1


