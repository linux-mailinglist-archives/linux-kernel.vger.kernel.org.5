Return-Path: <linux-kernel+bounces-39053-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BD00F83CA49
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:47:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33C721F2241C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:47:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C861213172F;
	Thu, 25 Jan 2024 17:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="JGtW8UAh"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2050.outbound.protection.outlook.com [40.107.101.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAD8131E2B
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706204854; cv=fail; b=najxAQZ/bcBY+x5ZCAs5n2mtjjs6MIIH46+BFRvE0RJ0B4Q0OobNj4HoFYUF0XYfvTsXr3ycdij3v3FXAyOZ+wwvNTKRokVB9NNEAKBaTGvSfYoZGNuz7mDC3RthOpnMJlc4X81u83PHCRRt9/yhWry+73kzRUOgf9PeqqEDx60=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706204854; c=relaxed/simple;
	bh=WhiS8nkA/13kBCqUhE7R4xSHYn8wFboELu3JNnY464U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=lWy8ujjKAs3n7mLwKZWB6msRe80znqsheNO4uD+U9hbRVxtwGiOcK2WFySV8hNvJ3szAt0FyYNwOBO6RJAlIDsKPs6fNpa1MV4xXngTqiaLZqoFaJInArh40pzwvD4mUOwcAE5LDBgNsHvj3Cow1rHOKPyBEzdNLnLgEzd79Yco=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=JGtW8UAh; arc=fail smtp.client-ip=40.107.101.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=M6EbbaRXXAr2aRmIhqgYbbNY03Y6J9QVeSYYwz/L+LaK0ZA40RBJbpFm4UsGobIhCidfLh0Fct8Yx7p67woKh8YDhCKWPWxSMiEmiWtX6eYUhEayoGhxgg/MRBVi+o+tumOFZlo0rKH+CVjvcN9AS7OPJwL6M8rvwCbtF3oiKb4clsL/xzwys8uk3LkqxEJj94Ehmd+/oPdqVyVCOIdKVTn71NuSq+HHj6FhQa5D4vtbTxR1Kv3MliWeWacGXuqTqNJRU0CPNRyyjlqd/IMp71qliwJw9qpiVMKf4MugU+EsRBk9bfYmt+YJo2LmDKAyh7s1la7GzJyEBxYT0RpPZg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PdAGPjO2Ukc9uHhaC6W7AP6OBCk0cg0VxKoUH4ln5Bs=;
 b=ku0d2bdQz5BaJiYm8lxkT7gIPRlQF5Z5TBdqhVJ/HMx2wDqeCuo5ksSZBx9ee21dEoIAldbMhSs4OBNPrA8vy/r/z0W+96W8tcto96fNVo95dncq9R60gOlEeYFGb7uhlgdqAoFX074hWkCqW3ECDxPJdS2SFP8ZAvuD/a0WNTI3xRKFVv2eVgToUb2JmWSwRWokQJ0qP+yGZ47b34NDkazT10yHrJSH3RWSvfSfFEJyDFTqZtVHy/uaAnRmwl3scgTqb4kfMYZeCpUwSJhajE2h44t8PxahyKJhkY6HfxroWDaxZhQaHBr1vvw33YGzjefpdgBub0QS+q+L+CYrog==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=PdAGPjO2Ukc9uHhaC6W7AP6OBCk0cg0VxKoUH4ln5Bs=;
 b=JGtW8UAhXzgo9WDCtKUjSSxaBV9aXJ5bi07f02dJVrbnot4kelE5c8kD9tJP+KpClXVrqypMkQYOyeCvpMhjBuQI1haQWRRZK8zdcYUwOvenh9B9REorsFd25+KvDxSeMc0B16owqAm18a4R1a3rE7Qh19GzlcKHbXHvDhI3bp5gZzJwwzjBSLLSs512oPUFUTQTXuLc+lwD0s3As/fJjoMWbeP9988qQTX5njbZ6ZwpNmq7xbxryQ9eYD42cIG0tXQfVmGRKbjz/KXxaMyP7aT7ZUGh1Sm3HfX+HFhEMu+oEgALbKg2oygXiqV29WC0WyOtXNtlCMc1lGali5AypA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by SN7PR12MB8132.namprd12.prod.outlook.com (2603:10b6:806:321::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.32; Thu, 25 Jan
 2024 17:47:30 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 17:47:30 +0000
Date: Thu, 25 Jan 2024 13:47:28 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Nicolin Chen <nicolinc@nvidia.com>
Cc: "will@kernel.org" <will@kernel.org>,
	Robin Murphy <robin.murphy@arm.com>,
	"joro@8bytes.org" <joro@8bytes.org>,
	"jean-philippe@linaro.org" <jean-philippe@linaro.org>,
	Alistair Popple <apopple@nvidia.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
	"iommu@lists.linux.dev" <iommu@lists.linux.dev>
Subject: Re: [PATCH 1/3] iommu/io-pgtable-arm: Add nents_per_pgtable in
 struct io_pgtable_cfg
Message-ID: <20240125174728.GR1455070@nvidia.com>
References: <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
 <20240122130152.GP734935@nvidia.com>
 <Za6kuE4KUPuwk7+j@Asurada-Nvidia>
 <20240122175700.GB1455070@nvidia.com>
 <Za63HOMZE2fuJKQ4@Asurada-Nvidia>
 <20240125135537.GP1455070@nvidia.com>
 <ZbKY9BmXZiHPiEOk@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZbKY9BmXZiHPiEOk@Asurada-Nvidia>
X-ClientProxiedBy: DS7PR07CA0019.namprd07.prod.outlook.com
 (2603:10b6:5:3af::7) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|SN7PR12MB8132:EE_
X-MS-Office365-Filtering-Correlation-Id: 735c78b4-4914-4631-d6a2-08dc1dcdb402
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	KOiLm1H/oKcpFYVLSFBeQSBAkpD9zqw3M9IOsPT59wppvSfx1YzcuBv94RN08BM+KZW2NTGZDsBD97vSPdm7xrchBHpoSEV9smlBYiz3Sq2ZpC1ncB/FwwK2UpMwDis8m/4fnJ85QRDYo/HpiPCfz1aSP4px7EJb8+5LRZ5U6Q4je93Yn7IM4G4vgdWZaWnFY0H86a+uGzl2fOWk/N8jm95rM1DGg9mIYKxf1Zb8QMA4TLzBmiUTEn79mVqjWXmrKwvqyrdORlE7kqqAyjNp4XJkSda2gcT5pSNlTQnCDl+ZLUxifuHoTQfkLXycnyGkix4Wgwd/vnXIACnP7qDhE/UP7lW0QG0RjnEhNP7ETafv99qa8iGOh4FNKyw65K8YmMTKodewBEfjNhBXQIRhvu3yno2wWogWoFA+7m7Pd/2uMYD5aQ94pGMeP+S/cnmT0to6gM0HijId9WXhjLP02+znuHB8R4dfIwMpwwmvN7qd9oWF9zjYVbyzEOmbYDUFCuY5jNXnMXw2WJn1DFZEOdHGaePSftcLfZ7HvPCCgB8hTdssd8oP+v4D6YX4XtHU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(136003)(396003)(366004)(376002)(230922051799003)(186009)(451199024)(64100799003)(1800799012)(26005)(1076003)(478600001)(2616005)(83380400001)(6512007)(86362001)(38100700002)(66556008)(5660300002)(316002)(33656002)(8676002)(41300700001)(6486002)(66946007)(37006003)(8936002)(2906002)(6506007)(54906003)(36756003)(66476007)(6636002)(4326008)(6862004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?7MMPUIiA7mjh2rPTRFBqx+5qjVHHF/bn3ei8n+ZTaAum9y221s1NnCSK+ueQ?=
 =?us-ascii?Q?u7RBxBjGnJiA8FHZoCQAZ5BRQ99s9lZWInezn1x5mxGycps6slJtA/yH4aFo?=
 =?us-ascii?Q?2Q1Q3TKnN2uIafZbN16bTUNqWhFnriY857v/NNZ0GGhjEDb84kO253twSuky?=
 =?us-ascii?Q?/W+0v5Bo16gkUhdswAy9xAp433KWCMbVZ1itaU4MyRn8A5HshameXskwmdAe?=
 =?us-ascii?Q?m1QKTNj7lsW0w99xSGvwY+vTWzS+av7PgrhenMZphfztxiI8zo/tvBuVcX0g?=
 =?us-ascii?Q?870xN/2/snP1sjo6kW4q2XS4+0+YXkk1cHLEyiIIQDKa5BySQydkeHj3obem?=
 =?us-ascii?Q?alJCByljrtim5Yd+Y+lB+RvzqlBGi8erNyaWYEs7udrrl+TuiffanLayaVWG?=
 =?us-ascii?Q?HrqEmXD7nHI4MuTJkeVQysRkxukpuvQcT7hWSz63CVKFbFgEG3PUsJWTWlpW?=
 =?us-ascii?Q?5s/xZnmqLhD5NiX+ox+9kf8omiqiXi/qgUdpWMvnB9veCX5PTlDwtRwfsdSG?=
 =?us-ascii?Q?N5C+ttg4SMR/YPbe3+e+lJdAy4YJb+83+q+ZLbrv1mspQLN631nPEz19M2lo?=
 =?us-ascii?Q?Nus6bh/O/WIgqtMIU9DCSE3DfJS8Ge6XJ5QaR7zsEFvWqgwydSS26EP9czwV?=
 =?us-ascii?Q?W3DauLL1f1C19JSCgLivvNbwga2oWfMYAjQvfXqitiHDuKzkAuyTwE46Pmw/?=
 =?us-ascii?Q?P+qnbvlX6l60LCksG72VPagBWP1sg5+fYjnpRYm0O2K+tuwH/P5q0eVh+YzJ?=
 =?us-ascii?Q?1qePUJdZjYFSRW8Pd1Q6GJVWeDPfpMwGRt+ESxnuRlMsSi8qVAtkhxNfDHVi?=
 =?us-ascii?Q?AIK4cMvEkKL54XkTBSXDsgtndtPLtKjgxU1t9ffzTSHJA26ubT8TNzUH8Fur?=
 =?us-ascii?Q?TAjYa7PLl48l93IVrG4ywyc/zQQfW8RVcHD+C05i0pPHFe3Rk5Lk+QbPZyX1?=
 =?us-ascii?Q?TeMBG3z/f0014emFCoLb/BX1HsRmEC0I4v9gtB5BigVSH+aLwsPzqtuBegVn?=
 =?us-ascii?Q?vdrRBLlfKDjUXfZ3NBabX4YlQpL8SZz6KCwPBza0ZEzHPF//ZEWqqDafABkn?=
 =?us-ascii?Q?k17QydQytug78QqyA2cgKG+ppEK2WB2Od7NPVmaOBjK5lrjSSSP36t6rHPnS?=
 =?us-ascii?Q?ZmAtB10W+W2Ps1/IfpUA9yRsaL3oMPeRjB6gNTuKRKGM/On/Jk0QmIAnEe5m?=
 =?us-ascii?Q?1oXzzFSMWXuaG/1Q698969X+EtW2rU9rBb7n98X5y7agodjs7HYuVObZy4Hr?=
 =?us-ascii?Q?Ot7rxXHDuOMRjYtST/diciUAQGffqzDnj1f27O8TBNYtYUBSgJRAOWVfxCV3?=
 =?us-ascii?Q?ptmtIdtVKdBK4CFEunxc74hArM1lE2FvpM8ySeOMxsoZ/UPGbFosXsjDSIlC?=
 =?us-ascii?Q?Sc+sTS0gzmG2Iaxr5dnYIz9gfo6uVvpEqgVoDetyzS7Q8HMKdG7lD34hxDCe?=
 =?us-ascii?Q?On59xOvb0DnIQz/Gcqlqho3PnhF1OgD+3vyI/XSSy44ZW7DJ3bUkl4Ehh6qU?=
 =?us-ascii?Q?OswmtsMmdJjHYIt/QKoQ06nXXhTbJnY7LLLjzpvzTa3s9U9wnigAcWWbftSv?=
 =?us-ascii?Q?fau3sj07xNEH0MfJm6vD9nCY9HNSNCdQN0SDk+Zd?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 735c78b4-4914-4631-d6a2-08dc1dcdb402
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 17:47:30.6601
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: a4MEB4jMfa04Hs+4+BFaWFG7/gPyFxsHuHJNGQUqucgZgGJKNkF6WzHzQGHUZmGa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8132

On Thu, Jan 25, 2024 at 09:23:00AM -0800, Nicolin Chen wrote:
> > When the soft lockup issue is solved you can consider if a tunable is
> > still interesting..
> 
> Yea, it would be on top of the soft lockup fix. I assume we are
> still going with your change: arm_smmu_inv_range_too_big, though
> I wonder if we should apply before your rework series to make it
> a bug fix..

It depends what change you settle on..

> > > > Maybe it is really just a simple thing - compute how many invalidation
> > > > commands are needed, if they don't all fit in the current queue space,
> > > > then do an invalidate all instead?
> > > 
> > > The queue could actually have a large space. But one large-size
> > > invalidation would be divided into batches that have to execute
> > > back-to-back. And the batch size is 64 commands in 64-bit case,
> > > which might be too small as a cap.
> > 
> > Yes, some notable code reorganizing would be needed to implement
> > something like this
> > 
> > Broadly I'd sketch sort of:
> > 
> >  - Figure out how fast the HW can execute a lot of commands
> >  - The above should drive some XX maximum number of commands, maybe we
> >    need to measure at boot, IDK
> >  - Strongly time bound SVA invalidation:
> >    * No more than XX commands, if more needed then push invalidate
> >      all
> >    * All commands must fit in the available queue space, if more
> >      needed then push invalidate all
> >  - The total queue depth must not be larger than YY based on the
> >    retire rate so that even a full queue will complete invalidation
> >    below the target time.
> > 
> > A tunable indicating what the SVA time bound target should be might be
> > appropriate..
> 
> Thanks for listing it out. I will draft something with that, and
> should we just confine it to SVA or non DMA callers in general?

Also, how much of this SVA issue is multithreaded? Will multiple
command queues improve anything?

Jason

