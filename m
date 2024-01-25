Return-Path: <linux-kernel+bounces-38690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FBA83C424
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 14:55:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31C3F28B6A4
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 13:55:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B635F55D;
	Thu, 25 Jan 2024 13:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="Apag7J/g"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2087.outbound.protection.outlook.com [40.107.93.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A34D5EE60
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 13:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.87
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706190943; cv=fail; b=X1vKL4i/r2mpb68nc5/OApvwpR3keJyGaOQLhcEuJtzKEhzsOtW4kaA2QcuqiTt9hLmvajf4vWjFoM9MOK94qaa4WjpNMenJJJFWkHqPixc7OrXHywrS/Ysp1+tI4iWE5cNDZ9XsxPYV9HJX1zQHJKvjrrjlSLb+qc8EEkX1qd0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706190943; c=relaxed/simple;
	bh=LqMRCwmMLktFa9Q7FAUSlNbD1/Alredtyj5xfmdmYVo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=W5jfgODXialbGAEVHkFFjkj8QmPpIUP4pLdXrm5w+bZmxIUZ9TMwD3D8gsFABKDER70VZ86zCFlWeQ0x98WyjvMmsIsxdMELXSelfyRUV4kvy8Tb+Nviz5i7q+uvnPD9NOJ+5HbdiX2L/tKQtCadHlgGElpfywn9d2KlVKXGmto=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=Apag7J/g; arc=fail smtp.client-ip=40.107.93.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MBqc8Wl4IaRhit9lwvJUz+R9YEjjamcFWdQ/2exdGSVFDpx1b3ELcPRjtwjZWVAFz3Bg3De1c8+DJ40sx/1AecqkQSmR8r1msDbNkwW3RGOsRg1B577muBwD6YB3UL9Ybp0duxRDYWYNfHGTrDA/QuZGzA3q43F4RY55eZchM1PhS3plWppMCt00tf8FBAjmhJI7WWp7fM72gn6K+FbUBm3Be76MFPRMuuOQZhOMqBnyD99zbkUtBj5dOHCwh5blgyRjMeb+KUl+v47S1huu9zMuyxxAOk8NLkThoa+yb9PQzjnWEY5KyxIm4qqlP8slY2PUIYghF/R/kB3B2MpMLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fcDCRqLHKOrPStiDGCEHqL7SY8aD89XUFtj1DPZ4BHM=;
 b=g3aGs8epXuCLRneSHI7x1ZOlBRU03CZ+97gVdS9bnoeJJOl3ze5QwFkOY++Vgdl9HhIcGDGY0C+iliUw9uTZ4VgmfBAXG9Yf6FqslUpQ9UiTVXKa+JcxqYtX0UMRCB4JcX9/E530EkmTThsngFC6ssnxzYwClqibYpRedhmphjF4FPIWUUyl2Q4K5Uk73Yh8yhIyAQu/yKEqyXNMLzPcaGt+MrWzz5xbzjl0rW49he1a07qFT2nMtJp+OiGJ+Cl3p4pTvy2b5BBh6G/pCDHwbeHMJM2i5+qNvbQjuahVvk+WzUgYn85QbhTBumnY5xd+fmSdbttXxCdEpEBbGXpOiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fcDCRqLHKOrPStiDGCEHqL7SY8aD89XUFtj1DPZ4BHM=;
 b=Apag7J/gx8JWFTlFiMM6WIuSSyAiOFtHwY7p4UTlFe6GRlft2UWrP048JcxDIx3sS/BvSDP7P5EY48kLSFNw7KSWJApJlDRcGtx9rj4MguGLWG54pYlP7IatIBWK+xfcr8pJe4pKAWxlCE1Kt1U/Zb7cQtlyW/UlTXuGLsxjlljYXoksg32erfvSkG2HuDn2gAclbXv2cA/7gDr0QTLD53XPo6VZydAN5cuHLkwgRttPgQbnOiqHva5iHGp6vWQmRtf+pxaCHY2umAgXYf9jdpZt6g9BH3smZKHGWrC7tgp9lteZK2tHUB7+cOtdyK+U5y7CS2gh3JovX4u3u1q5DA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA0PR12MB8085.namprd12.prod.outlook.com (2603:10b6:208:400::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.26; Thu, 25 Jan
 2024 13:55:38 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7228.022; Thu, 25 Jan 2024
 13:55:38 +0000
Date: Thu, 25 Jan 2024 09:55:37 -0400
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
Message-ID: <20240125135537.GP1455070@nvidia.com>
References: <f468b461-b203-5179-eb6d-9432b9911329@arm.com>
 <ZOTlcFs2NG6nJEPN@Asurada-Nvidia>
 <61f9b371-7c45-26b1-ec0f-600765280c89@arm.com>
 <ZO5R5i4n2WI2GnKQ@Asurada-Nvidia>
 <d234fa8d-d945-3f7f-1110-fe55bea88587@arm.com>
 <ZawmMd6BVqQpfbB5@Asurada-Nvidia>
 <20240122130152.GP734935@nvidia.com>
 <Za6kuE4KUPuwk7+j@Asurada-Nvidia>
 <20240122175700.GB1455070@nvidia.com>
 <Za63HOMZE2fuJKQ4@Asurada-Nvidia>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Za63HOMZE2fuJKQ4@Asurada-Nvidia>
X-ClientProxiedBy: BLAPR03CA0112.namprd03.prod.outlook.com
 (2603:10b6:208:32a::27) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA0PR12MB8085:EE_
X-MS-Office365-Filtering-Correlation-Id: a7ea80bd-19d2-45bb-6f04-08dc1dad4f87
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	yQiiZIMF0cGiuMg4Lj/bhRsa/iEeHuXQtZ/O+T8Jhbb1V62wcYeRGj8ENXkGhU4lPWfy0wEoS8b87fvg9VMxhAam87mBeDk0N+SyF0UBa2aCCwYWJ0SHhl7BvUMWc6E9K5S9GSVs4vIcoCJQesVMqaSpBprT4OdVoGzoxcYntgage2c7NpM0vLiXMTJoMHlCAYIdXl5yxSsDlVgG9vztA0QWOFLFLZRazi40+EsKddwsaKg7YBari0KMosI6H/s4xXwWMbNvVNea2gN3Hkywc+M7sA/YWHXOMs7Z7QkY724i2L/7SsIG0ybJd+xyosIro9EAAqqdZeQjUcRDg9JucfvYk1PxaXmiRMk+IKtCcpLNWmLsTThy/3lVdwUkfP3DaIEmseuQrx58KqQDX2Q8v6WlFT6mpG9pSCM9jqPQltqPvdb38FZ3QzdZLBozSEOxDZ46sa5Zumxz7V4KrcDwAA8aw0fQ31+0Eq0vKG0HP/CMBCM5H8fouyMV2P2L8/yu4IP/gAqGdLZiR6AcSwKY2Q/CihVlnPJboApfiXKlRJE2wuOW3wF2PtfAqPuFx1yq
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(376002)(346002)(136003)(39860400002)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(41300700001)(26005)(2616005)(1076003)(316002)(6486002)(6636002)(37006003)(36756003)(54906003)(478600001)(6506007)(6512007)(83380400001)(38100700002)(66476007)(5660300002)(2906002)(33656002)(66556008)(66946007)(86362001)(4326008)(6862004)(8676002)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?KrjPJnvyAFvGoBxEyXIemvQJ5hGVecH2JaJWFflX5KMkCapxFm0bR61eRwpj?=
 =?us-ascii?Q?gsoBxfTPmIadu0LysZYg6XyKYGVK7J2wMlu8Mi6XVcKg/6w7wj7TYI9gSv68?=
 =?us-ascii?Q?ynbulqEMsEuL9k64wWZe+RQdkvBUcTpwMj07M150d2TMfqFRk99ANl4UnA7I?=
 =?us-ascii?Q?UNdgRF5L6pS0aDaXLx+Zk4/wtO15sLqxlJJ8sHfWtEL4g0z6UbawRqChyH3m?=
 =?us-ascii?Q?qd6ycUOsfWZZJm5FytiuwhXlNGjmZ5lkbWTticqGrVu1mYUyJevDmV9LwC0P?=
 =?us-ascii?Q?/sNUs7o2oIEg+O883aUWi1j/Lk3IFsB0BnEV8DJ9oAZyjfronCYsWaCZnqsL?=
 =?us-ascii?Q?BNiO0VDFAaK8oo3bdI33huzcXLmYEA+n6JLOwDdpKBu/SQzf26kMefgom+UC?=
 =?us-ascii?Q?oH+4j5yYHv1oNoinlNyMdjxUiS+0FVEEqQfsUWes43rQKxtfOkDeo2VE1ZTE?=
 =?us-ascii?Q?dP3tYU5iZVUwQkaNlbm9pVROjvqpXBvyh0DzkY5YjQwssbEgT2CaFeLieN7L?=
 =?us-ascii?Q?JulKYBuZvEfuhVFzTXYEGayxov6+DwwtGydqUg5VcawibicyQhG+K/aFTFwY?=
 =?us-ascii?Q?GbcVasVVMi/WPAp74NacB3b6sOVSmVFxCmw+8dvBCcnSaJIXOgjKXYx/P/JE?=
 =?us-ascii?Q?KmopHU5BR3KVKWjTneFcsAU8Y/kzxD9ioPbOU5PdezhKiSj4eo+38XDcNeEB?=
 =?us-ascii?Q?nH2G04tcU45nSsarRkgqbA0O4EWubKKMp+vUV78dUna00YD4ZN0wSQ5OGhJ2?=
 =?us-ascii?Q?Gkq9bJW5qqDoOXBy9WmYap6VbAbXH4xRRZF9V1mb1UqsetO46R0SannWx06k?=
 =?us-ascii?Q?HLOVbG7cRM4IwGIxPc4bF7uoC5/LpHmQrvBWxR+1Bl0NrNcdi7OHUMqU7jk3?=
 =?us-ascii?Q?cEWtx8hal8QOBS12Nr+A8U0NIWCW6dkzIgA+nCEv4mUir7Q36S7fy17ybzRA?=
 =?us-ascii?Q?l2+lAOzG2JGR3anHawHH8CbCadNNicsdwJhRjlX9pA2RFDLdgQIak49YbMya?=
 =?us-ascii?Q?QcfIrg9KPE41z2Tacv49lzRcg7WIxFu9jLIO7fuRciwcU2xCwM4S6qshzdPZ?=
 =?us-ascii?Q?oZoMnlxOuIT/gq73QrKkmL8G3YZryBuDsHbMiAdbY1IC2o4qA2ylqO8kFX58?=
 =?us-ascii?Q?vcIjNrDAiaePoQqOAJpIA7SBHclUxue705Ey8iccn+Thq9xG26+njaLLDL+R?=
 =?us-ascii?Q?FDXU1YQd0Zv6u56ZOBGmqiO2H/+7k4UJXalgAulju3prt9IbYOovp+5uEamI?=
 =?us-ascii?Q?lws6xMk+5N23MrH8lvDHcZI58gegWcVZNgOpq6IC/0ldWpa3gEeEBQcGukHa?=
 =?us-ascii?Q?3y1AVz8+GXTyApvmfAt7ifPVDIOaIhvglERX+jhk/APgd7TotpK8aIsOrOG2?=
 =?us-ascii?Q?bgFgTwvA4wk1Z2jz1b5auy4pgVr/jxkkpQADeS6a3sng8WOiE/BQo2to8Qxx?=
 =?us-ascii?Q?wgC391Kb5TAw6jURsR+FbvIyzT1BNpYe77RM7yRUE9AMZlyN42YtMSiOF7Y1?=
 =?us-ascii?Q?ro2sgCYe8/UhEbQtgL/EI6idZv/rtwA10+PbKF/FYXhjpSmWcNP4bGzVLLbo?=
 =?us-ascii?Q?WA++TJMwTBv3DdEasyUKAtbniqCBnzzGGhNAFM+V?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a7ea80bd-19d2-45bb-6f04-08dc1dad4f87
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2024 13:55:38.1760
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: QWaymZCoRuMY9cqpXzW3AAzpL2RF/EF/R9MioZCw1XPeXW8+dwtD1cUQ/6jD2M36
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB8085

On Tue, Jan 23, 2024 at 04:11:09PM -0800, Nicolin Chen wrote:
> > prevented strongly. Broadly speaking if SVA is pushing too high an
> > invalidation workload then we need to agressively trim it, and do so
> > dynamically. Certainly we should not have a tunable that has to be set
> > right to avoid soft lockup.
> > 
> > A tunable to improve performance, perhaps, but not to achieve basic
> > correctness.
> 
> So, should we make an optional tunable only for those who care
> about performance? Though I think having a tunable would just
> fix both issues.

When the soft lockup issue is solved you can consider if a tunable is
still interesting..
 
> > Maybe it is really just a simple thing - compute how many invalidation
> > commands are needed, if they don't all fit in the current queue space,
> > then do an invalidate all instead?
> 
> The queue could actually have a large space. But one large-size
> invalidation would be divided into batches that have to execute
> back-to-back. And the batch size is 64 commands in 64-bit case,
> which might be too small as a cap.

Yes, some notable code reorganizing would be needed to implement
something like this

Broadly I'd sketch sort of:

 - Figure out how fast the HW can execute a lot of commands
 - The above should drive some XX maximum number of commands, maybe we
   need to measure at boot, IDK
 - Strongly time bound SVA invalidation:
   * No more than XX commands, if more needed then push invalidate
     all
   * All commands must fit in the available queue space, if more
     needed then push invalidate all
 - The total queue depth must not be larger than YY based on the
   retire rate so that even a full queue will complete invalidation
   below the target time.

A tunable indicating what the SVA time bound target should be might be
appropriate..

Jason

