Return-Path: <linux-kernel+bounces-164411-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0612A8B7D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 18:44:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B12DD283B85
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 16:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2607417BB18;
	Tue, 30 Apr 2024 16:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="ZDPASk7C"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2086.outbound.protection.outlook.com [40.107.243.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E43140E3D;
	Tue, 30 Apr 2024 16:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.86
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714495459; cv=fail; b=sCtIBUJlVOgqPLuzOTvJFLGhWO26wvk5rOsY3SXxZ8NRfqWxcC6oBF7OqdGsIxhFYp3oyr6DOuVi5CT/PBJ14VdrHNZHmXx0tZmELakAG0ylbMcsOPCKuZ+h4MjhgAOCAkLXVIVjWB9/n/xzKxZ2zYO+XYos+JWDkV1XOuhABqw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714495459; c=relaxed/simple;
	bh=1hfTo/POlTy/vOWOtidmllLDFI+paHf8mZ0LyUt3SYM=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bL4P1a98eVBMVC19tW0bxJyjuP70XlejrzbHOF/a6pPrNVkGRxGsR5tV03MrzRHHXXfRnOF4TLtH2VaP4e+z0uwlmd68dTJL9QNT3wOCW/CN12S0GcXJAMmsUUKFPNpz8l+AFd59Hf2JIZRIa/DQt9RHbUY+bYsNiquCK/SC7/U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=ZDPASk7C; arc=fail smtp.client-ip=40.107.243.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MZPY7FioHUukIFysCUvPK8j1I9iROs2oWQKtD1BycVKL/4XZ+0NdHN/cxuc0aDwUH7ASAOFuD5WB2TA19eklUqa4bxD2op38DCx8NJyt75Fj4A0yEHQMpXOrPJMPLLQZckc6U2VukHL4Y3j4SuUFEJY5m35HT9DPAaRSUc9lxLtcPXjB42uzmZEsg8QlaJx2e+snyIP8akepi3Z5wvOk3NiE4q1E9JbJAAnoNWaYCaOiEnZSY9SD+qY9ryxku7kkowEzhQs7TSKPO40TzgyBjGrmB07l2PzsJxkP0zSTV1M6WhMT+XgsokBgIAK/i/YWzwmksEMT9R4T7n+qESMoxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u3YXrDQOCH4untA517QDZTs87CnnpNvMEEv5nxi/pAs=;
 b=emAVdTNMLsMPu/PtVubd6leR32sW0rMIsgwX/WVsTx6ZbWPQ9aXbuUBeFCXYEx/MYrJetRLwL2urrdw15DM4OocCkrphrmi410F3kzCXkSX8kubPKWr5lQC2gUiSeCkp+rLaE/LMO9ytfT/qTP5Jb4RnXcCas/Sc9pwR+9HlVIDunq/F9zizCSiV6fQXeurux9WMeRGHIq9l0EWyrzzBcRoTgD5u6d1JnCzP0tUIbYD7JmRMG0EJq0+1b6dAMJ5rEqY04zWzvB/PqFZdjUQKlYciEIRGnfXBDjDFlbh8pMpnzWbxPRw757D5LIGDh5tzE7NhSeFRLHvYU/6Vy90x5A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u3YXrDQOCH4untA517QDZTs87CnnpNvMEEv5nxi/pAs=;
 b=ZDPASk7CBF9Ej0fuCUT4u98yhAj4iA5pp9Q1Y5/7MJPgly1YKDI2fcSOifHISHzuxRl3oMzQ3KNTI0JGm061RP5o6CPoYYz3nIvgdO7yTf77IgoLVEGjmEGh+O/twlaMWF+M8W/ZFHJqN4iAvZ4eWXnactmDRYKtjNRq64wa2QZwApftzltcxWv1rljv/nygCsp1uP9MCIIeahY0Phdo4e1csltBULB4sQVxvEOMyDN3uw/J2ZQsn0Kg0JaZiiwk+fuEEc23hJfrurutXh1wJkULoegwpEnADHJiywlNvUfc4rkq+aopG+NQ1hQGtd8eWlZFFoQrBZRYu0G+Bn0apA==
Received: from CH0PR03CA0003.namprd03.prod.outlook.com (2603:10b6:610:b0::8)
 by MN2PR12MB4270.namprd12.prod.outlook.com (2603:10b6:208:1d9::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.35; Tue, 30 Apr
 2024 16:44:08 +0000
Received: from CH2PEPF0000009E.namprd02.prod.outlook.com
 (2603:10b6:610:b0:cafe::5d) by CH0PR03CA0003.outlook.office365.com
 (2603:10b6:610:b0::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7519.34 via Frontend
 Transport; Tue, 30 Apr 2024 16:44:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF0000009E.mail.protection.outlook.com (10.167.244.27) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7544.18 via Frontend Transport; Tue, 30 Apr 2024 16:44:08 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 09:43:51 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4; Tue, 30 Apr
 2024 09:43:51 -0700
Received: from Asurada-Nvidia (10.127.8.12) by mail.nvidia.com (10.129.68.10)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.4 via Frontend
 Transport; Tue, 30 Apr 2024 09:43:50 -0700
Date: Tue, 30 Apr 2024 09:43:49 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: Jason Gunthorpe <jgg@nvidia.com>
CC: <will@kernel.org>, <robin.murphy@arm.com>, <joro@8bytes.org>,
	<thierry.reding@gmail.com>, <vdumpa@nvidia.com>, <jonathanh@nvidia.com>,
	<linux-kernel@vger.kernel.org>, <iommu@lists.linux.dev>,
	<linux-arm-kernel@lists.infradead.org>, <linux-tegra@vger.kernel.org>
Subject: Re: [PATCH v6 2/6] iommu/arm-smmu-v3: Add CS_NONE quirk
Message-ID: <ZjEfxcSd90ts4XmJ@Asurada-Nvidia>
References: <cover.1714451595.git.nicolinc@nvidia.com>
 <81d79f51c69604a38ea4f72c8ac2c573c52e8609.1714451595.git.nicolinc@nvidia.com>
 <20240430142201.GQ941030@nvidia.com>
 <ZjEcs4rY1HpPz4Oa@Asurada-Nvidia>
 <20240430163733.GT941030@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240430163733.GT941030@nvidia.com>
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF0000009E:EE_|MN2PR12MB4270:EE_
X-MS-Office365-Filtering-Correlation-Id: bb6a583d-c25c-4942-22f4-08dc6934c168
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|36860700004|1800799015|82310400014|376005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?BfHC//k6MzpqIuG6HCn+2DLIzzEB0QkrTWcR9c6mZwDeIUfXGjUz1fbNedZv?=
 =?us-ascii?Q?nWatc9JRRMfmpbDb0TVOU6+SHbBG9HvKVmSVo5CaCnkk9KncirWgDpr3EoTn?=
 =?us-ascii?Q?SDcFSzOHVUkmNalsbiDrJeuMvwWjLE0Wy9SaCV77I3YzsyWD3BPc2cc/qhak?=
 =?us-ascii?Q?q3e46wDfzxvFpKxgpvXLxxQIvg/vn3a9V+IrPqroQzuq5LBjnrjOMnlZRSDG?=
 =?us-ascii?Q?sq75BZhnDoaSfzaBfE1SZ06YOggtMrtswJxKNj7ptpS7Pd5imVxHL7a+e5ZC?=
 =?us-ascii?Q?ccUGCY4TL+z/4kXBtQdyArdDrfBHUMxrm2sxwarimyc2BGlmSiFhh/b5SbZW?=
 =?us-ascii?Q?qzGYdDQ6iBQbYepsPEGB03i7oA4KGzT379lEB1GlUE1LE+gnFIEFXA6mgq/M?=
 =?us-ascii?Q?wYGBndYzGsCU2HCias5KFJye2dTfIwAbKX2PvnjbxRNCeDMwxr2juJjdIyYB?=
 =?us-ascii?Q?7vtEgmA9oNzJjW8VsiA71mpUhL83VpXGudUD+oSYPaUaSOXjQ0x7nnbFRwIF?=
 =?us-ascii?Q?TZLv/w/NFjhHZ/PilezT1vLzTOPaoiaoF67790aoOMxr1JC1ADvRa4bzgKOT?=
 =?us-ascii?Q?KflM+wcHlmU9aqxSPkG4zZZAXsUDNuErim8erzhvqDFriNYlxeThy/vYkBGy?=
 =?us-ascii?Q?V9oWaVK3TSQMUy53/1qixxpaLvAMiSWMajQYPT6rEKiu+8nQe4TlqB+f5vXJ?=
 =?us-ascii?Q?L7AVckfzzDtA1ddwz21UmCZxHqIlioV0mTjns7veCTHGYLbeip7eoAYR4W1u?=
 =?us-ascii?Q?hCJg8lG37bC1m9/1WqTs9trBWHP2+Zm06RQ9yTKO+isXR//5UJRny1R+PcCJ?=
 =?us-ascii?Q?qhd9XRz808hBp4EYG+68RGe6/5ZP1Fu3/QIfa/295o1f3Lgg01Vu2xPx14gi?=
 =?us-ascii?Q?z5jek3rED0MpBlBPPW6TSDgkq1JabfYguuer02Vm7GuaZ6cv+7TFSYjfzDIf?=
 =?us-ascii?Q?KJV/aJuONYbCAtka+6b4IB3/DpEW+xXHK2/GEwptTbINj2qQ0a1f4+KRL31z?=
 =?us-ascii?Q?Su5BZ3iRflz8FI7Z6dMwa+jJDfZdhMnDOUiEim6P2w9NWpr71pCpJio0DTOf?=
 =?us-ascii?Q?/rm6i60LI4HC4tH6oL0yxGLKsnJBc/HujgIynQ5enSngHELUK8fZh3zvoXoQ?=
 =?us-ascii?Q?PvTwZ7scaKZ4u+s5B39KY05gGnBbuB8ZOoVZM13BG/NEWZRkJo2RnMu0CPKH?=
 =?us-ascii?Q?8mqrP0Mm1/fOGn5AgszABmNyBmj2VpbDu262TsAEIK2WvrYs4muG5H5W55lq?=
 =?us-ascii?Q?JsXhg9Cyipl+6mwf93xG36uxXqmvR/8bvt4nFkTXKKBDQaDCJrFrflMmPPyi?=
 =?us-ascii?Q?dFAAQm2oO2w+T7sLbZkn5RqpFvTMjP+ypggKEzJC5rVBRVir6J0sPsva0zR0?=
 =?us-ascii?Q?M+lelFzD+ZOtSRuOwk5Oi5wjADZp?=
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230031)(36860700004)(1800799015)(82310400014)(376005);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Apr 2024 16:44:08.2092
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb6a583d-c25c-4942-22f4-08dc6934c168
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF0000009E.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4270

On Tue, Apr 30, 2024 at 01:37:33PM -0300, Jason Gunthorpe wrote:
> On Tue, Apr 30, 2024 at 09:30:43AM -0700, Nicolin Chen wrote:
> > >  	queue_write(Q_ENT(q, cons), cmd, q->ent_dwords);
> > 
> > Here is the only caller for "msi=false". Maybe we could just do:
> > +	arm_smmu_cmdq_build_sync_cmd(cmd, smmu, q, cons);
> > 
> > So, no need of "bool msi"? It would slightly change the behavior
> > though, a SYNC for ARM_SMMU_OPT_MSIPOLL should be still a SYNC.
> 
> I don't know, I didn't try to figure out what to stick for prod in
> that case. It is probably OK to convert an error entry into a MSI
> sync if it works out?

Yea. I think it should be okay. I will try a hack with an illegal
command to test it out.

Nicolin

