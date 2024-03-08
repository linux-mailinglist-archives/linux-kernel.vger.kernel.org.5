Return-Path: <linux-kernel+bounces-96468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCF36875C96
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 04:11:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92051282240
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 03:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03EB628E2B;
	Fri,  8 Mar 2024 03:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b="NdNBfIoG"
Received: from APC01-TYZ-obe.outbound.protection.outlook.com (mail-tyzapc01on2120.outbound.protection.outlook.com [40.107.117.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B9D2C191
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 03:11:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.117.120
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709867506; cv=fail; b=IYhYj9N96ZOaaRjclfD36l+S1gjXNYmFI95qF1PoiNpsOV3tGWh9QtFEfkJKxHvNpbGyUHYn3p1w7ptLKZOT9MRqCvsR4Or7FY77QgECqvgXiTDscGBW6zsBn6WlIjrNg7WP47Wc1RUfjpu0U/wUm95BRmWY56mk0jzzvLeWWio=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709867506; c=relaxed/simple;
	bh=jK8XCUAJ2fG0bXTL6PdWAf8xAUeitwWXuJyqPc9Bv8o=;
	h=From:To:Cc:Subject:Date:Message-Id:Content-Type:MIME-Version; b=qQt6d3Asz71xozI5j6GsXDgf0qjsCyMCwuoozOCdmgncYEd/ieHVaCBpWMvhqWlKPZ+KLeiUKCj7fYISOpYXCl37X5jMe1P2OGEhDL5XnCr/seJIA8gUqvTUMeqNh+DP+1a3lT7n2qtm78pHa6q8tZIBA8ZHOQRNzUcwYR/K3D4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com; spf=pass smtp.mailfrom=oppo.com; dkim=pass (1024-bit key) header.d=oppo.com header.i=@oppo.com header.b=NdNBfIoG; arc=fail smtp.client-ip=40.107.117.120
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=oppo.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oppo.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Mmiqh9g9hMC/zinjsjVvjmg3oMLpaUKHtiAi5M8ctQO+nH81d0VVNVaM8tofnTyblP7Kx5NwsmAwiq8lnMWAdPbXD2xVZAI85KI4tOUXsV13rEJWFbnAMSGFllHqQNZs3Gu5lFl+97yxh+m2bpon8aHT+u3vDi/2lU3PtqfF+xO+CR/WqfZBPUZN3mJuOBzs/IV3AFfM09gLngEM1ZCFr2utdn3b1Vuz+Wyji3n06a8f1EJ2eTU+XwGybwoUvMQeOjxF5lrRc2ogZfrC5ikyL1JTmYaIFOScRijAPHCrftzbrZgft/25Jk7NeENWfZemN9b3rIuiCKK4S1xmRfjsSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=V294uW1/6G7dfsCoyKZHi6U5asc8iRhQw7sDVAtY8xc=;
 b=i5GdVCOrmFVuA4uY7We1J1gtpZya9/xumB7NdVFt8gA46Yj8jTrHwK24agACucngXA+tbzGE7ax5t/j4AtNhhOCJnGPheFf0W38uXQbsWLiQA11hMkz+dWdNH+nHu87O0A8J4C53YPCnqodheAetA8TPpH4UuXGRm8E/RaTr/bMu30M/FvJamT687rN2IH5rafqd9MbPp4HsNZ797LsW63podKRjLa/6QlUNlgHovS0XQoA39H/3yCHccRG1RzT4ZdSlG791uF2J8vqN+1V4sYcGq34dUDeoBMcAtnAmRnPUJenv+IvOmpbj4hXFriO5GpUjOSe2nO9/C37kQV5pVA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=V294uW1/6G7dfsCoyKZHi6U5asc8iRhQw7sDVAtY8xc=;
 b=NdNBfIoGtEAgLmIznxCOWWPR9/UloD7z3vKTQNQIIVOmT9Vd/igflLLD9Q11lGpoJMP3sGKitZJxr1eojJu2sY027HuC5nW1ENuoPj8PjjZm+7ptJTe40FnaCULqGRj/yWngvnkmzetnqIzX0jS3t60FQICPNe/+NQUW3F585yE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com (2603:1096:400:1c5::12)
 by SI2PR02MB5539.apcprd02.prod.outlook.com (2603:1096:4:1a6::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 03:11:40 +0000
Received: from TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133]) by TYZPR02MB5595.apcprd02.prod.outlook.com
 ([fe80::60d1:4349:510c:8133%4]) with mapi id 15.20.7339.031; Fri, 8 Mar 2024
 03:11:39 +0000
From: lipeifeng@oppo.com
To: lipeifeng@oppo.com,
	21cnbao@gmail.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	osalvador@suse.de,
	willy@infradead.org
Cc: linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] reclaim contended folios asynchronously instead of promoting them
Date: Fri,  8 Mar 2024 11:11:24 +0800
Message-Id: <20240308031126.750-1-lipeifeng@oppo.com>
X-Mailer: git-send-email 2.34.1
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SG2PR02CA0033.apcprd02.prod.outlook.com
 (2603:1096:3:18::21) To TYZPR02MB5595.apcprd02.prod.outlook.com
 (2603:1096:400:1c5::12)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYZPR02MB5595:EE_|SI2PR02MB5539:EE_
X-MS-Office365-Filtering-Correlation-Id: 30585782-5ccd-4ae1-fe1e-08dc3f1d78c6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	3UjvtHsT8S+GYRzPS11G9kiaCT9nj5comT1MkyscogsGM7N7mcXFCZygvIgpQjakbsH7lwjAy8jNwVi6U/ls4IC7d/zn1YosXAhEQRLnvHM6gYYvOBYsnua8zb1qbkbreUWTzfUBtTCmWh9W2vwzmG7NYQ0x9D53WZZaJLOJtObjVuBij1G4BrYhaCwm9KlPs5/wwZy6MO79hr2WotcA63HiQthe0p6uqq+9MKpStfuRPF7Pt6bXy7jWOVqTaCzwb6rvbP++8swDKNIM9k3isfdAfNtio7aIkNt2bSipGm+AxBgW24p8Ks4WZ/0MxMrtMLm5FnZWRNJGhLdolUB0qmGyU+GE7EELg8czl7XKFyEHQBzLMVTrsIa1ZxtaQrGx4ON3LFb6BmADjBJQeoG4Zl5sBmzGZQeGPbFI6daszQLjAlNw2WOwR9VigrD9AlRU+/hqpzrJPQGnqtldpClt1WHaq/Igsq6vrtpYO+Mh/KEF9O96ogNWAmop4XctPe/qjMmiZo27t6fYnvovcBmrxuYC7OvlVo198MUGGiNXrWWlIaEUfmywg/Ts38xaUKnW0GJPkxgkaYh0NaUexB8x/raJQFjCTHGQwh6JuN24GvpVRgjTF4suuPbVyogj/l6H/3ok16dn7uKvuxUsd9MSzhgOGSbqmaJiFFmUe9H0N8I=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYZPR02MB5595.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(52116005)(1800799015)(376005)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?AH6xDrpjglh28BZWi+6maovjJ/rcVefmjpyhip0f848At64wczbZh1mk+JyO?=
 =?us-ascii?Q?z61cm81APJHAX55cbbSfUq2+f43Iy+kEYOTeF8fSqsxZ4R5bDiSryJzwjEO8?=
 =?us-ascii?Q?GbJpbNDj/8gVLm5LCgo1tPcaHphTayXdzvOv4IfN8OCUQ2DKhVPVKErxOT23?=
 =?us-ascii?Q?nXR/Tqk+Dxe+y9OawDC1q2KwnB2hrC8sfO7q9TNKB1m2n94s4RoakHYtcxju?=
 =?us-ascii?Q?2Lph7+Y9HKyYm5Wmh9tYb0aSlzWnM4LKfjyh53WV/aIZ9VJ5L4JVlwClrT24?=
 =?us-ascii?Q?4Ix7S2WdUd4+znWPSxhc8ohDr9XTuruG+sl/6Wg5JSK5L1+lq/jj9cU1mtdn?=
 =?us-ascii?Q?yjj0yyRT/Kfx55D9P4fHv65/9NM50WkSJdHWeNZpCZV6sfrJEXFSMiOZsiYy?=
 =?us-ascii?Q?POL2psDO0oy1io94gyHmEnB9PXlze2XCz05gX357yjIkQdUIn1Y19HlzCcUM?=
 =?us-ascii?Q?GjgEJhM0OUeL82toOaTsr2juI300xsdZkfoGiJlablQiJHADgIt8JEiKrKGH?=
 =?us-ascii?Q?DTkHk6yKkYGkLaQFyltt+mADEvT3d3N4GZG8fcAONHKVZdbBdmImhn3HUVc+?=
 =?us-ascii?Q?G5ZaNhItABqKVYtbN4Gj4AoFpbBmh6mFCAr4n054luTxPAeISbNoNc13RxLY?=
 =?us-ascii?Q?bwKdUzmlb1eVC3L+BWRLhGkPsC55i2Lm8YuUdeYhmrrzMnQaylCoQwSV/HRb?=
 =?us-ascii?Q?SF4fxT3jfb8wdxNx/QZ2cdg15LN3i5i4RY78fVRpMKeId9Gr/6lBv9nl2oZ4?=
 =?us-ascii?Q?04p8uEG4KeLnhAJp3lyXYbkSH2ViwJQz7IsGknC0CwINDanR3S0nFFTmYIzB?=
 =?us-ascii?Q?mlI4RzIXNjNKQzQrNiXbSm+yLcg1SPaYR6tePabpemggXY3wJXpUZwFX9Hjv?=
 =?us-ascii?Q?cvP0aw14rvXaovRQJTCMFyTRMIylLvbkOc43J72kg+kF0WmFXvqq2KfPwt67?=
 =?us-ascii?Q?0oju/wrWb61uPDa0LuzvfvPjRWWlpNF8/IQixhR7Nu3HZKdGTN0uZ7pPQR6W?=
 =?us-ascii?Q?LUd1oY0TIwHl5yPPpk0Nzis5Qtd7CVi/KdmXZmBuJLIzy19Acc71yvRxxwH2?=
 =?us-ascii?Q?kPnOhzWHgEMZnbmA3ICv3pXC2PP3cUHDmhPLLEqRiozsZ2Ppb4PmQ+BDUdgk?=
 =?us-ascii?Q?VvELoTP3Diu2u/L1qc3nGDqCeAXQb2VVSducfb7oZ00D8LPYBn2/y1e10/K5?=
 =?us-ascii?Q?/nY0FyoRJ6PYNr5WGC3j7mfGUGORs6PF7m+GkiRo75auJgeXk/GU2yAkHI7o?=
 =?us-ascii?Q?tDH/PxCUGLVh7CToxcbwcF8X7/rJjdImxG144GZMV3YtWM8FVKWypfTUWlY1?=
 =?us-ascii?Q?gk+at+gHfPQURIc4fTqw6JjBwpiYN2j1KhSxJqYffUoyX/WVuWBIQI1Fvs8g?=
 =?us-ascii?Q?/4rNIZTVMcIlWA7vl9A1v3VrwWbsWSLcitLMhgO5b1TRTCvYGHEDFo8qJzCA?=
 =?us-ascii?Q?fJRIa3qb5hEJPk0H4vBPkhax0ny2mf6doKBRhsABU3MpGea162h9shEtHPYs?=
 =?us-ascii?Q?RKq/id1ZUuO9FbtxLncfccfnzjiKjCPv3TrTrCAn5k5FxsVGQn7SGx2+tTsh?=
 =?us-ascii?Q?xaCrQoCIIS4ZsoNN3VC6bDeNYFTxqgsWEY1rodaR?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 30585782-5ccd-4ae1-fe1e-08dc3f1d78c6
X-MS-Exchange-CrossTenant-AuthSource: TYZPR02MB5595.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 03:11:39.4010
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1cxq0PQHA03oViqAFajp4Wmw6fAk/pVf+Pn6OqaVHpLFo2A3YJjHunke/Dzli54F77I35Wbr1FBGl8B7Ym1yDw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SI2PR02MB5539

From: Peifeng Li <lipeifeng@oppo.com>

Commit 6d4675e60135 ("mm: don't be stuck to rmap lock on reclaim path")
prevents the reclaim path from becoming stuck on the rmap lock. However,
it reinserts those folios at the head of the LRU during shrink_folio_list,
even if those folios are very cold.

This can have a detrimental effect on performance by increasing refaults
and the likelihood of OOM (Out of Memory) killing.

This patchset introduces a new kthread:kshrinkd thread to asynchronously
reclaim contended folios rather than promoting them, thereby preventing
excessive violations of LRU rules. We observed a noticeable decrease in
refaults and OOM killing as a result.

-v2:
  * rewrite the commit messages;
  * rebase on top of mm-unstable
-v1:
  https://lore.kernel.org/linux-mm/20240219141703.3851-1-lipeifeng@oppo.com/

Peifeng Li (2):
  mm/rmap: provide folio_referenced with the options to try_lock or lock
  mm: vmscan: reclaim contended folios asynchronously instead of
    promoting them

 include/linux/mmzone.h        |   6 +
 include/linux/rmap.h          |   5 +-
 include/linux/swap.h          |   3 +
 include/linux/vm_event_item.h |   2 +
 mm/memory_hotplug.c           |   2 +
 mm/rmap.c                     |   5 +-
 mm/vmscan.c                   | 205 +++++++++++++++++++++++++++++++++-
 mm/vmstat.c                   |   2 +
 8 files changed, 221 insertions(+), 9 deletions(-)

-- 
2.34.1


