Return-Path: <linux-kernel+bounces-53862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E52FC84A762
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:30:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C4181F2A4A5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:30:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588817FBAD;
	Mon,  5 Feb 2024 19:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="eol1OS8R"
Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11022010.outbound.protection.outlook.com [52.101.56.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4CB761683
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.10
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162443; cv=fail; b=UCeKmo6BtPyzORHm0SbZmNcxrAljYTNxRj3DM2MuKRZqlToDWjmre0WTtyERxSyl8cOuiTmyVHvCyU8he43M6caGZagKmGaBccqjk10l9GjtNOp8GWD+Pz94VprZY0arTF2O8yQ2/iPCk3IJhf3bdR0Tne0zIJEavTkwF46RtAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162443; c=relaxed/simple;
	bh=QA6vWnsGNLKbEmtoQv9Sh4IL7WEneiqBNc+1/2QFBgg=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=Exk36NlpB88sHdVegp8ri4xfV9OQWW7znro8VVC36MWq4YkINOSBhtAbHrQ6+rIVkVK+rwQfivxcRBTkccRWO+sO4ZNtgMC69zXi9DIyUO0XwzULtxkk90moWfTdoK2y+8BAC6BOTQpIaOqEsRmzJ3TaeVJ+aKAHPD9tD8faP9Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=eol1OS8R; arc=fail smtp.client-ip=52.101.56.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j9V1BtI1L14TxW0iGwkvwP/PCO7f0hbGgl7zK1Xb9rEKXWqlK0+iYgpAujuLx9g5cw8oK1EIS7uHfX7AhuhTPYdyhU8M7nM+B/wi4+QfNBEaud09Zr1TkkpPIYiF0kPhzOC46QC56bujV3Ey8r6PiZrwCKwuyoPWHpGRvwks3X4gWaRPJ0U+AI+gPX23mA9Rdx8OfFB9SkCj0fYw0eGs+7b3EgR0y4xbRI/X3VkvgpuQK2NjCdclrzriuGtkGSG+m4ODYzbhNalCsg2t5717YCncq+kdXaTqQkXF+RntM3SdEzs7VSOznz56b7aaP2ssJjJrk6GpkFH9On4QgW0X6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tDG3VsODBDoudct+TNRUtkrBKkKrFJnJUyr7ImlKMcI=;
 b=FnDan5fjZs7mD8h/GN6FU3Jqz+O8374DkaaZvkG85JhmpwB3Qka53LgDL8qvdbM9Fr5+iNXKfF24D5J5AaPb42L5l6yC/koPzOugO4mtN8eGoq4yLFEU1xzJHi+8AXnU0pDV5391rR58CEVGpzw7hEjX0HqO6ToLcoXLLboevc4F41OlFtcxjXG90YsykwD9cVx+FbYkXtI0AGkPFn9801tazQUj/zt9joH9moCaOnsAcF7+3BJHtHOoujZjfnf4RN4qKV5CGj3zYk9w17a2sx4AuVZYsOMUlxPbqkOMmZHx/N+7jcaru8Tkqu9swqDepSD6uJz2GQNx/GE+F8JuFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tDG3VsODBDoudct+TNRUtkrBKkKrFJnJUyr7ImlKMcI=;
 b=eol1OS8RiKht9nxroLSsG1D62BUVhG/23aEY7B/79xZvwHMet9vbrW5mds9GdHDlhGn2S6lvxAJsdfmzM7e/ldkYws55nxif+lBzIuFqevsBKytBPOceDm5ZfMSDn7mffkM6/fW/JORagr9qnCCqJ65Eg/iVjQrnyUCRKDlMNtA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from PH0PR01MB8166.prod.exchangelabs.com (2603:10b6:510:293::17) by
 CO1PR01MB6696.prod.exchangelabs.com (2603:10b6:303:d7::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7249.36; Mon, 5 Feb 2024 19:47:18 +0000
Received: from PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf]) by PH0PR01MB8166.prod.exchangelabs.com
 ([fe80::67b9:4671:4fdb:2dbf%5]) with mapi id 15.20.7249.035; Mon, 5 Feb 2024
 19:47:18 +0000
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Ilkka Koskinen <ilkka@os.amperecomputing.com>
Subject: [PATCH] perf/arm-cmn: Workaround AmpereOneX errata AC04_MESH_1 (incorrect child count)
Date: Mon,  5 Feb 2024 11:46:55 -0800
Message-Id: <20240205194655.1567434-1-ilkka@os.amperecomputing.com>
X-Mailer: git-send-email 2.40.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: CH5P221CA0017.NAMP221.PROD.OUTLOOK.COM
 (2603:10b6:610:1f2::17) To PH0PR01MB8166.prod.exchangelabs.com
 (2603:10b6:510:293::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH0PR01MB8166:EE_|CO1PR01MB6696:EE_
X-MS-Office365-Filtering-Correlation-Id: f88ca737-3e30-47fd-91a0-08dc268342c4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	OV1n/Zjg+i4xzlrNHiiVursUqZsBkynXSyqtpyG3P1fWdBI3Pkb6VVBbY3uo76OiW3fqkLpCqLpOlz/te4pbFj/aE3G9E7Ma+6ypfdgLUg5Nvjg/ptIy3Na8YuuiJKZiFbd8N2ixDKKg2W6/B5SZMMdi8tWvY8saYYlkyq74Sj67l96gwpjAMv0hJaP0JXty2Okq93xmXYh9AZyejH9DbbvRpuNmYEZiC+hLcVc4EAkvGOUv7+Hy8Fbmjx6ySgOkqTG1USrAYl7/wAbyHgaPhqgvKzJh/yZRiXXVOpHMkm+7whwZQitSWtVYhyazL63Fr1wFkVCuwiEFpIj9MC+mYXKbSqxA5thsGg2e9TvN7nRgfZnMYs+W2FYPkgaC6Wm72AfhEe5rItfTLFePsdXrRCf8xQS6I+5DmE4Vi6D8/RER6g8cJGP2taQXIKXhWZHf8G0X1kMsjsxJhvlPYeqCAG/IHMscvLd3EKQWo/ZhIcYf5YLAoq1OL9ANmBwU5B9HmU8ZH6qp4EoPcT0XLWs1kmok6VrRYVR9DJ1/qOXjErERtKCNdcbKrR/U20+CpjKDy++Fl+MaSntoUxI/pcS8gNz84OfWLQvCqM4HWyvrkGYaYx/RsQdRkWkAU3Edkzms
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR01MB8166.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39850400004)(396003)(136003)(346002)(366004)(230922051799003)(230273577357003)(1800799012)(64100799003)(186009)(451199024)(38100700002)(52116002)(6506007)(6666004)(83380400001)(316002)(86362001)(26005)(1076003)(41300700001)(2616005)(107886003)(4326008)(8676002)(8936002)(6512007)(2906002)(478600001)(6486002)(5660300002)(38350700005)(66476007)(66946007)(66556008)(110136005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?okzNUD0mPUDIbPPP2dQJJmLhuzkCB7pHpHXpuwr0ZGzZW1SkBoQhS4EUk7/N?=
 =?us-ascii?Q?N8XaSVb+KpNZ1Pazq48X7uMGtnruxe7ydwhCFnGRuoEiHU7egFr5qwCqILYj?=
 =?us-ascii?Q?0LHvaLNy4lid5i8xRUumqOHcAQBGsz7aBZ5M9wPZX7rY+8qv7kGrSye8G3X9?=
 =?us-ascii?Q?ag9u0eUp7W+zLJGAm0HT6Js6qMJRlYo1VUheInHeSJBJXZ1EzWeYakpjWMxv?=
 =?us-ascii?Q?ABQr7JNETXLHBowaT06GZ3IFX4AOrHytYMBINfooACZT7jWS/XzMHF7d2Wdn?=
 =?us-ascii?Q?8WXK7wkOZf3SrqNXKMLwHZvfc6EUgpX/erFj6kzpReWZRHllrmH1G9OdtcFI?=
 =?us-ascii?Q?W7/oLWW/GsvOhkWfjW4Lv+yHXQ/L5WQzoMFADZWcBlaluWzPMlyTeqcBXLJg?=
 =?us-ascii?Q?+XFfvT6Jt8Ryg7hR/2FVqNkMC7/nQOqozn9BpOy6AorBjtu4VzbDZggMqurn?=
 =?us-ascii?Q?rbuJ2bUUwIieVpgtPxauTDy5fJAzvcOIF4BZe1jqdL4R637IhYjKLAm8vyrk?=
 =?us-ascii?Q?hB7OH5Sefunju0+v2JOSxic0anJk2aXECIjLNTYdWPQQlMWrhvtAhHLUogNL?=
 =?us-ascii?Q?1zK6RVdXZNgJ/MnmPdSSByLgbccYA2IT/Ug3HNJXLJzayac70AwTFO0/0V0u?=
 =?us-ascii?Q?TaprGmUqduMwNv6SC5F2NUJ6CHPfsoGFatMo/1z+TZqMQ4eJtTIr46WVZ3Hr?=
 =?us-ascii?Q?cfRj8vbN5wEZ8WWmUB+zhsEUUzHYwAqvVPFHzExG3GPELsPIrvIo/ZQcgcSH?=
 =?us-ascii?Q?fZJbXiCRJSTYxlVJhxyI+xKKbwK0xrNHqhZ57kmTuhtl56uBAa2NQ0HWQmxd?=
 =?us-ascii?Q?W4Zb4C5dK+MQFecPBBtzNXiVNRu9U+ZeFf3GbdPETi/fT/AWiSCTPCK16dBp?=
 =?us-ascii?Q?gwzR+zu4z2Ev0r/UYgxi5a6rhk+54mZw5k+ULVzecLBYRJXD4KeiTQ9myee4?=
 =?us-ascii?Q?pApJ2X3gyB1LlTF76velHvQFwpIkoW3afN+1cfvzqOjfVdd1hTsGjEnw+qKX?=
 =?us-ascii?Q?rdx3jYlk9r7V4Ds5y5weeUC2X8jLyqPBUUfaqeLt7bhLTmfTnD6OeB2NfW1F?=
 =?us-ascii?Q?5BVwIipE7AqFcQ1WN/yaq8lCOsmhrcW5KqCchtwK+Dw8pKHz/4myzMAVwm0I?=
 =?us-ascii?Q?koYX/DuzIUBHD55bJWLRZXN7tSEecwXIpqpYkMKOKoar9p8SvRnNYUS9Izbt?=
 =?us-ascii?Q?sl7HEKQ7EOMBw/dQd2tS+TVhK8Vs+Qcxn8usGz3uSwCvNW4cvnroSRny7MCz?=
 =?us-ascii?Q?K4HWAHFjdKZisNijJdNzNVlJfa//cdFrVymD7LYjCgMvHoZQzQQ5moKlwTYu?=
 =?us-ascii?Q?wcZxXbL0GrtF2+n0o+BuSFGQvlX1LqNTpquSSHHLt6naprZWbihwK5MZrkSX?=
 =?us-ascii?Q?ls1DwZIFYpEeS5haSi4oEB5HPcyUGPGxgDHwQuHP4ZBDIDhczVS9laLtxxcZ?=
 =?us-ascii?Q?uWO0byhAse3hiGZInyYK6T0xt5ZujUqFhD0ye1St2JnaMIt4LYuRMEKkk7BC?=
 =?us-ascii?Q?jnA1sufy6iH2QgrZAKW7pnIko2Hxt332YHGdJg4+bY/sLOsBKar1X/q9jD6O?=
 =?us-ascii?Q?qbzCeBSWeRqxunJvGnykmyIp4uxuNOdyo3qr/oAMOiDDCk1g++yFR94oY56L?=
 =?us-ascii?Q?7srRpuDfl8zqtJXkhvGO7ws=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f88ca737-3e30-47fd-91a0-08dc268342c4
X-MS-Exchange-CrossTenant-AuthSource: PH0PR01MB8166.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Feb 2024 19:47:18.3798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RbsPPKVG0b8UuVd/1usqZ1vpJDBHY+scA5HPPwEXNsY02bbWClvXYNHHuiye1GTdfgJgVXqrrPW5LlEI3VKk7vAMu6Ftb+fBm7EeXxX5hf2HD5hltMGAWvFCho5sxF0I
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6696

AmpereOneX mesh implementation has a bug in HN-P nodes that makes them
report incorrect child count. The failing crosspoints report 8 children
while they only have two.

When the driver tries to access the inexistent child nodes, it believes it
has reached an invalid node type and probing fails. The workaround is to
ignore those incorrect child nodes and continue normally.

Signed-off-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
---
 drivers/perf/arm-cmn.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/perf/arm-cmn.c b/drivers/perf/arm-cmn.c
index c584165b13ba..97fed8ec3693 100644
--- a/drivers/perf/arm-cmn.c
+++ b/drivers/perf/arm-cmn.c
@@ -2168,6 +2168,23 @@ static enum cmn_node_type arm_cmn_subtype(enum cmn_node_type type)
 	}
 }
 
+static inline bool arm_cmn_is_ampereonex_bug(const struct arm_cmn *cmn,
+					     struct arm_cmn_node *dn,
+					     u16 child_count, int child)
+{
+	/*
+	 * The bug occurs only when a crosspoint reports 8 children
+	 * while it only has two HN-P child nodes.
+	 */
+	dn -= 2;
+
+	if (arm_cmn_model(cmn) == CMN650 && child_count == 8 &&
+	    child == 2 && dn->type == CMN_TYPE_HNP)
+		return true;
+
+	return false;
+}
+
 static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 {
 	void __iomem *cfg_region;
@@ -2292,6 +2309,14 @@ static int arm_cmn_discover(struct arm_cmn *cmn, unsigned int rgn_offset)
 
 		for (j = 0; j < child_count; j++) {
 			reg = readq_relaxed(xp_region + child_poff + j * 8);
+			if (reg == 0)
+				if (arm_cmn_is_ampereonex_bug(cmn, dn, child_count, j))
+					/*
+					 * We know there are only two real children and the rest 6
+					 * are inexistent. Thus, we can skip the rest of the loop
+					 */
+					break;
+
 			/*
 			 * Don't even try to touch anything external, since in general
 			 * we haven't a clue how to power up arbitrary CHI requesters.
-- 
2.40.1


