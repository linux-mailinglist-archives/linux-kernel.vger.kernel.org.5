Return-Path: <linux-kernel+bounces-55225-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D053084B954
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 16:24:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 45C891F23665
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EFDB1350D3;
	Tue,  6 Feb 2024 15:17:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="MVbMTaWL"
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2083.outbound.protection.outlook.com [40.107.95.83])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0B111AB7EF;
	Tue,  6 Feb 2024 15:17:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.95.83
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707232656; cv=fail; b=Ig3n+JR5NClAGpFjvnTqn3dhjnNJh8f7EVdq/aZWIZfkt7XINul92iw5gNAlKN5JpIwunYrxmgpHvyck/qZeEnTgysIzBBigdMtBu4bJSeIX8FC6ZKPGI6k9SS6F8mtpFpQwem3llL9pAALDW9AxP6uCi1F+6t/p7Rky2AqFHRw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707232656; c=relaxed/simple;
	bh=GnEQuzDgSmtEk8KNLHxmTDqcr7+f/R695itF1anjyJI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=hsUY5pIhFKy5cFwxzESyEloEh198uSqcT6JWF68ORTldRd/+XDHelHUIhACoixCqknrSxQA7IXSCN6ed3MthN749Ggf5K+8U/3f4IBEnrF/ojt2Rela79Q0dVUuEtKqqwTnplGV4+yYyMz255LwTK+WE5IqlDlostD9B/ImRwPU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=MVbMTaWL; arc=fail smtp.client-ip=40.107.95.83
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KP7pKyiumvz5FO8wsfD1cI6/a0cUMXlTBpj8g/02q3BcsHuhcVaOvvafxbl+ftq+0WlLPK8dOYuCHiyc1usZUDF09G3FM0Wotkj24WUlXl6E00zqV7CZHSSjGPmdnGhVl4YHG+CzQVkCcB8HkKLOWl68tBnNN9SMw0VUhL3uRC4f9+pGjHnTwEVHMZZ01j7YFnwQTPdyXhMBe1B9KN1/TJagrDusE81opmTXcSzSUHwRUgdTwCDoeOfSxPk27ix/jwjMws7M6CfB8//RPS2wfVTm33wbff5qLsrcEmb8WvdS1oqhwzfbK6fLFqbaTdoJU0vg17qsGDievVRNxhRF5w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SXbXZVDmDu/bjy4FCrHG3Bajt/S80IfEN+7S8BVj/RQ=;
 b=QOD1e4PNYTfPnKRNgAQP3n3dXqpKDa1EJAb1UGlcte9uwtBvK27sceUtg+Z7YTmRvEh4O1nsRF9fKZi28IXZAr+EYIPKY+aS+RmMLztUiLmFdcgLdWk1QPQ2dH7QABKYsqnWOtEys48O2OUUkzz2XVlXKezfGxQKEu/EvOT49Sl5un0S9PLkz838vBhwrBi2gVyJUaeBg/4ANDXY5ZkgldtrmrQih9uKE8ev8fHY0pjS4e+YXhNB7fGstdeIsocEH8DsSk7K8Ea1JaqqD0N8FVwCVoUZWiAXOJzkqvlA4s7doeJzc7DUFSbm8p3QP5ZkoVRQ3QAQfnjUlp6Tr2wQuQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SXbXZVDmDu/bjy4FCrHG3Bajt/S80IfEN+7S8BVj/RQ=;
 b=MVbMTaWLxIY43mc+TtkCU++zETW9nyf8A1A65dI2vFk7eSrI8eQWHYS8XUCD0wtheEQLX+M8MaMZuOzTLB/6iXVjS5xdLf7/CMGX85K4JJrvIuoEF5SVv2rx/EfApRYZ84VHVC0U5U9b0DnMacRk36Lhwfsn1em0RmzH76XhTE+OyPUXYU4nnNKSq10U32iSbLuBLyv9CQAcqO00wDD0C39+27E9AtgljRH4OQ2PjWahXnHCFYGCIMFQ7iieDcIonwgLr0x4SHNKBo+Xr37kT/g575J/fc5WoRkklssBxUig+dD51ZOyYSTJwE7FkmNdmEUApcALo2IxlCZbE/V8GA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from LV2PR12MB5869.namprd12.prod.outlook.com (2603:10b6:408:176::16)
 by IA1PR12MB8539.namprd12.prod.outlook.com (2603:10b6:208:446::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.17; Tue, 6 Feb
 2024 15:17:32 +0000
Received: from LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873]) by LV2PR12MB5869.namprd12.prod.outlook.com
 ([fe80::96dd:1160:6472:9873%6]) with mapi id 15.20.7270.012; Tue, 6 Feb 2024
 15:17:32 +0000
Date: Tue, 6 Feb 2024 11:17:30 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Doug Ledford <dledford@redhat.com>,
	Mustafa Ismail <mustafa.ismail@intel.com>,
	Shiraz Saleem <shiraz.saleem@intel.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the rdma-fixes tree
Message-ID: <20240206151730.GD10476@nvidia.com>
References: <20240206090345.210c2760@canb.auug.org.au>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206090345.210c2760@canb.auug.org.au>
X-ClientProxiedBy: MN2PR06CA0016.namprd06.prod.outlook.com
 (2603:10b6:208:23d::21) To LV2PR12MB5869.namprd12.prod.outlook.com
 (2603:10b6:408:176::16)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: LV2PR12MB5869:EE_|IA1PR12MB8539:EE_
X-MS-Office365-Filtering-Correlation-Id: 4b731213-f164-45c0-10c3-08dc2726bd67
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	rvGvMasX3uNbEzPVmUjE9qj4R1X+0tZu3L3i0I6E4tlxDybwlmzdd/ZxTEtgR7qX+4ODkc1xqWrIBwqAMp9eROyS977FijPnfE8XDitx83wkt/Vk08sJ6MMAogWLZuq/2wuBOOlnBjoHj6oHS6xYwZmnF3HGZJ7gNlO2n628nGxS9uC6rOqL04VOA4mVhwMllXyGd95LGbqwH/d2oDut022ICWGidY+jq75zTzNlGH2Qq9YucyDJ8R/xCUWjyVBNE/FRdhYtQjtMssSGsyFPC+iPshgY5gDVGm/1HxCncO/dKYUeDsfPGkMgo7fL9FWQZuc3OAvvHBIuyNBgc8rlhrvP8XUnb9xAB9HIounRvPqyDEEh3AElvv1HhWee7y8jcXfw5CtfMnLEp9Q+OyyAViPH0I+WGO0iAgwyYySocXxVpee1iZNWg4hzhr6HAm79qlUSHXF/z8V/+YmTIPp3HfuyUF+bN4WMYkAk0UxxhUpMhfP0pBu/8tGrIxnBnTh/C/n8zLzqCnceWvUjU+s/dWfKefnxa0gAHFMCH/marcdqCm5mGKYwGrVQACK7eskU
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:LV2PR12MB5869.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(136003)(396003)(376002)(39860400002)(366004)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(41300700001)(86362001)(66476007)(6486002)(66946007)(54906003)(66556008)(6506007)(38100700002)(316002)(6916009)(478600001)(1076003)(6512007)(2906002)(8676002)(36756003)(558084003)(5660300002)(33656002)(8936002)(26005)(4326008)(2616005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?klYfqiBytaeCatqdVz2HeUOM6MGp6UuuiRR3j2tODS0sE1wMJ3rXuCXW17FA?=
 =?us-ascii?Q?GcC3bPx4SsNyO0RBo4cI4lOBH+o3B3OUBOFTEGIurWMJxWN0el8SmlspXrW2?=
 =?us-ascii?Q?NdLF81t9FwO5sdmA3pMWi+0rRbsCjSjtiPRWjyHfVGDDkk6NmPPJl0tvUKw0?=
 =?us-ascii?Q?zroOiQlAIlw2ZCs/xPrErhEvIWlmUFMMCRUCGpY8gYhLwiuSHXyDNFnTYX0m?=
 =?us-ascii?Q?IHps01JwIWmvnQ/bG8/DVN8wHS+60wUroz5P1bNdfoViSFX9Zo7Sf9YrLoIy?=
 =?us-ascii?Q?/Mw44KUP0dDDAvbQDkfbpJzH63BDpvP3/ioiB0zv7D2m6NHrBiMsw9NVHhuu?=
 =?us-ascii?Q?UgKYaGedSnCrdV+Is/MdYXwPlAsqly0pED7dplFcAqU/7hRBwkLleK0L74Tg?=
 =?us-ascii?Q?KZ/yi5dnlZCoEoCOyW4NkG9exLai9PQ4CkYixaEXTmpRri9+0lLixkno5NtK?=
 =?us-ascii?Q?evCaPhBDd6zGoU6wtXy8aVYG+GBVrluALx0stIRlH/E1bKFbkgV7O5+SiAZV?=
 =?us-ascii?Q?BxN1KZKvoXZC/UeNorUgMBgLGJdS9dQoet3jXLl5kh00EsMUvyVUrihUzf50?=
 =?us-ascii?Q?kHXCMUvVspAaZLq3NaUIbp3ZJN99UDZkvkI5B8bbH9Gt0fLmVLnBY0IXWIIh?=
 =?us-ascii?Q?FKyb4oGSHqwjLbJsoj41Pddc4l7wyyMQEcTpZ8ohbRwfXe1TGgwrO5NC4YI4?=
 =?us-ascii?Q?CfBnqH9PVuMPYU2YqVkaOdPwa4R8B4RM6lZBwqQ5T8XORJeVRCFj81wCXN9T?=
 =?us-ascii?Q?TnDq+AjESySUnXaB6aIwFpNSKoCYsrcD2z5BX70B7mW56s4B5CCpKlVAu907?=
 =?us-ascii?Q?aaZOYnjbk2QO38VUQuQDgBNSpWbVfU1EAsj/x0uPbTc/5IGpUAV7BSenPHPo?=
 =?us-ascii?Q?3Is3q+UWp0F2AyN1a1HwQXU8CBLnl4SGwydSqYcDwEnK3/kkfTFbm9se8nLG?=
 =?us-ascii?Q?NcUoTbxfllJc66mSiuoiQnXQUBUd5QcjGjMZ7cs+tUtpvO46U6E2YB+o57Kx?=
 =?us-ascii?Q?sjSH9OOEBbaDB+B+XPGG21fWYCVllA12AgmgfDN9/mD01mtxVgnsaS0CiT4Q?=
 =?us-ascii?Q?pxoftjyJNnLgH0xATgYoxJ/ytNZZejnuLBLobjR8sNkpV7FzsvfznKMX2BvU?=
 =?us-ascii?Q?47qsjEyn7Lby1V5E6YfE74wkep6ySNZDPyvkyp7aoKtBeHIqj4JDf1ogFlXC?=
 =?us-ascii?Q?v51jIFEckmlcAiN3UXbnmz/2fHPlK/lpe0xFQcNJqzBKK5rK0oeJ1bxE9h3s?=
 =?us-ascii?Q?swQTwYswtYmBN7S+TpmleuW2Z90U0EnLc+VVYMFLAZx6frNMvupwbIDbW8qF?=
 =?us-ascii?Q?hm5YDCf3uiwfCAFe4Pfb0WxXgfNNpYU79nCduxcehd4v6wfbTwlt4pl3C4fG?=
 =?us-ascii?Q?Q51eBU/XlEMdSRwxrix+x0UhkOTDqfAuyCSVPZMpTijvw6bAiZrVSkiPa039?=
 =?us-ascii?Q?L0E1gAyuHpxvGoA4ObEYc8UOBTQCedBRXAGsGyGlYSieJ9L8YrfZZk93NG6N?=
 =?us-ascii?Q?iCngw2+rwaMdk1Gb4A3RloKFPWP8iVHEfqBW+ERM+dl3jdJv6Ds8wAtGBx0J?=
 =?us-ascii?Q?7OjV1h+MnIZ6c93UZLubok85pSAR7skVI+YPwZ11?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b731213-f164-45c0-10c3-08dc2726bd67
X-MS-Exchange-CrossTenant-AuthSource: LV2PR12MB5869.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 15:17:32.0517
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: spTDWwkZH3s2LyShQuy/cEjA4Z5uoQsWIr97u/WZRfXvKqRmku7vPsxl8B2m/Qgv
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB8539

On Tue, Feb 06, 2024 at 09:03:45AM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   772e5fb38843 ("RDMA/irdma: Add AE for too many RNRS")
> 
> Fixes tag
> 
>   Fixes: b48c24c ("RDMA/irdma: Implement device supported verb APIs")

I fixed it thanks

Jason

