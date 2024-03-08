Return-Path: <linux-kernel+bounces-97108-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 836D687659D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:49:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 18723288B00
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12AC53FBA7;
	Fri,  8 Mar 2024 13:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="G+VsO23I"
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (mail-bn1nam02on2050.outbound.protection.outlook.com [40.107.212.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913491DA5F
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.212.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905749; cv=fail; b=R9wewOmkemhhIBO1o+FguQ+pOP4RpPx6SBlKd4iy6wkBMjBste686+raqydQCTEYVqKok5kW3gU8oRv5TYc1JDMIIgVzommHNxJTaoOdGrVHzqI29ZnE5Q5DO/B5ukQWLdujEBzybM5RPlVIAFukFFmdnXRB7Uiz6h7xtLhK3xI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905749; c=relaxed/simple;
	bh=CQso5UPv9hsuFhUkynFHinzkzd9owjWkneXDx3r7IBg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=iXUhKn75xLWFLtiwJrWxBeMyMFcAhhwRVZa3ib+G2D4JDdsP+N2FNyOh05ZVMC4rIT5FoLmcAeX1ozdnvlrYwslz0bItda6c8zME9uuEkEPDjLqs3xHwCy6veyZqxNuuj5v7ca/HKQq274JgV8I415xkfVSkS6dENWCb2xrzJv0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=G+VsO23I; arc=fail smtp.client-ip=40.107.212.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g44BbU7M8MYbGRh1c5vIJDc3QEv1KvHKljV2SZCvrVhXhC2tEGgR9WPvYS0QoKB++dAC3xOVEZFgw9bV9TY9hZLuBIp0r+X3UptdTyQSOhPvOsXMAZF8319irYHtTaYyalN99cPhZ9jf9u6FAvWTI7ZuXnPK+OtNu2AtaE/SYETKHEm26Zpj3upKHfGn/8JpC3D6+fHN3OGuvscV7QapNTauqcOY3Faddr7xiZjqssXY/sbTEPmLhU8Zxob7OWRto8Oc4vMlNDrCE6zmZd4tgO6SEbaJCFyKO/HflMwOhvLfa7setCBnICoXflEW6BZoEfuWMTUIzMNOqpb7qc1LQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=QNDYF+WS7stqij01bGZcYQvfiCeYI7ke+63nUTPHPgI=;
 b=VSEL5It+3T1Bq7xNNNhRuyGA3rga2SlidOydjHGrQNygCOcVQ+GnDmHyexznd6PoaoDjcteRNSRtGRJpjkeT51nJKGkKbvWJOUgkvHIEmsfWwecWatniDyt6fNkJ39v8tUb0U0klgGqxvVaHhpN0xSoErMpLakAxXAGp01cEidA2JdS6iP//ol5nfAo6LdSDNnUmJ+Gzvern5Mns4xHuqjCS/OqXdIddA2O2shxmDd+rzPPbLMA6wSn0far01IT6jBIrRXEoiabfWYNHNFKsCXEUgNoL2qtnEt6xsvYhssLu4N+cgwY21lZbVE/BiahTCR0efKEoil+254opzD660g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=QNDYF+WS7stqij01bGZcYQvfiCeYI7ke+63nUTPHPgI=;
 b=G+VsO23IJo+7atKWhWz8vUr0+cKxxQ6ywUhkOpuodHRhh9Zh1+GH92CatvZ+7ixwlAC4TzFc9l2LRePFJ89D8d3mpea8Xh+BZ982wfqkTeEIr9qppeDQRac0lObrlB2qqszN1ao0m2QQpqxHlgageJcyQPMKbU3z9GYzfvdCyEYZ/8SSNNHx9nJHd2Iw6FlE86ihs26J0wj5rr8Ne1LTJdLH4bSiPcwyritPzhObCDUZG3BWA2ddhfsNTarOXXAklPlUa1wWZML23rugaMRRF09UGvqqjOb45Ugjm9j+d47TMt+XUKwDpz9tQbNdLJR+BRgK3qPyJ0JkhifbRP2ACg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 13:49:04 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 13:48:58 +0000
Date: Fri, 8 Mar 2024 09:48:56 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
	loganodell@google.com
Subject: Re: [RFCv2 PATCH 1/7] iommu/amd: Introduce struct gcr3_tbl_info.giov
Message-ID: <20240308134856.GI9179@nvidia.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-2-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112000646.98001-2-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SN4PR0501CA0011.namprd05.prod.outlook.com
 (2603:10b6:803:40::24) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: 67282cab-89f9-49d5-a25c-08dc3f768130
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	+CCgUpKl3orKVTjKVMKK0tbRf9S7bVTStUBvurB9Oulxg2zeh7U7x6xfKdAxVVxa0NJ9RU8kDyBUKJCi8/2d2XZYPUl8f6FxEWtpUeRX1nRcoYvRW8hIR2PKXZe5RC8TrynE+xUJnmgbl99VXGY3uuyrVWEQ/wss9oOJOnQEr9ZkL1YmVOGbh7UiQCTvfmrgGCi3fVl2lr6lewAGxSxOP2zyWbJlmhJPlDRDtR/T1GxcViaWjUvz2uuZ/kHBpivEdtxOTWrda2e8DjRBS5PFCw/CEx8Dd3LljB7Oa89dVYLXlTPIkA9WOnYQ1rGT/kx1iyQvpGBIkr+I0E+3+1xzyIDdMmTaf+GvkLXF7tTLZanVMrcFNwD5p9MVfBtuSLJj1/BD8llNdaaI24l6OohU+3s+EVIPZIxNsMT1ypaBqrn6xsh+iHUi4iwm/Vr4vp13X9puCUAWpHAqajHnsHmtNq+bgpdBNtDG30z/7ZFNGdh2bh2yA9o+6EfJ8JXVR1xmthpNqGoBoPNIJzNlcGFoCAprHV1bzGmuOskZio4KG+XhRWAaCmRACiJn/gI5khApo8JyszhDgZ7bCp/9afkSZzm8tHol/ZPrBIza1vAuxHAZ5IaxG7EPm2WxNWyyqXKAdq2UFquRXkaGwDyq6pP/dQioB+iAlQ0XBT0JzceWRTo=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?2PPhY5S1SdKoAKkJG7RFNXHg1S4Csdn/4LhG37bcT3uWUpkEWgv6BAprEfIJ?=
 =?us-ascii?Q?CRV98MFRuteuhwsgYpZridLwwcx2N6lKu+2hFL53BNYqhTqYBcN6P3EAz5yA?=
 =?us-ascii?Q?XuHAg4DoBWMl6L+kzfVJ5RwilUEg8aUbUvuEnoSQc9klhPQ/1MeQ/k0KcdLn?=
 =?us-ascii?Q?BebPOAMKBW9Ws+5/rIkjFb1OSPJTGAr1kWNHE7AmJRMN7xiV09DPBbEJUw19?=
 =?us-ascii?Q?1nzipKPhtUAq8aZxgKPhiPmhEhOT8bw/dUj4BBvEIhsaZfxIHBoYzVa+kStL?=
 =?us-ascii?Q?2M5VkKdsQKv2Vijc7oJJCLY00Nk71VKpYBxKPT/N/gLEOPAclPI9PoIlNw2U?=
 =?us-ascii?Q?viE+fR3MBUMmrHMH7wg4oNeTeq82+7/HzS8PCge8MSofMerA6/PFviq31veI?=
 =?us-ascii?Q?qXnILRQbjPWbHRHe69S5RUvRXqHXLw1IPk/OPd2iTS2Sf6//3YbCUoKrCx7V?=
 =?us-ascii?Q?tCnR0rLpSFDbq0nIn1WIImB1PSjr+Cf0OpnRhcSFag+zYO9WXFubLQKVhMLR?=
 =?us-ascii?Q?RbDTPCb/8LjvitPtoENqNgOtWzw32PdK3dPydCvcH0U5ORkrDvFqaq1tu2u2?=
 =?us-ascii?Q?YzC4nDB/l0P05gZtOw0WjSc/Jf1AaVw/D36bwGWWCHnqxMoOhwoKm1cZkHsq?=
 =?us-ascii?Q?+pTun1MomL+N67sCinAf/rmqoTu6DOepgYHNcw31SFh2/WUl8IsnsGMVmV2D?=
 =?us-ascii?Q?Wfd8um/rVHE2+WSdRy3qdxikmP1o5XOKolCRsaPkbE90YAkZPi4e/Q081jC1?=
 =?us-ascii?Q?3lOzWy++9VMXqT4ow9JwO50kRLHdO8zh4Uyp89AXW/v9DEg85nQQOT7yURON?=
 =?us-ascii?Q?qG087V9MqbsZsaJGnNr3guYKoQXJeJHkFacviwSAv8DAEha0ADLSURPsq0sf?=
 =?us-ascii?Q?Lz0IUjC+D+OWX9NbsDPdvdoKq2qcPmamboQvH0we8BB0J6WuQt3CekkLVHHV?=
 =?us-ascii?Q?ULMiCJ8MBTPo2aTW5jcW9NJeQRClGs0sVylDiQFgGSJIGw1oOIjj5h/aE/t9?=
 =?us-ascii?Q?vxBgj1Aqj0rdrXm6qLpyOuBIAti0B2SVaftiR0WMe6zaT/l0tH1b2dUune4V?=
 =?us-ascii?Q?2Wm3ftXrH3X93nV4qCr2jA+emM7SULrM3n+O0H9FP0z6INtpgjzXn5oit6oX?=
 =?us-ascii?Q?IeULBlqaYurvwovoFhaCLFw19wHibEt7SOgMtcXbsi3ud4IYaMfd+XH50kNO?=
 =?us-ascii?Q?RhPR3kGruEqon4WJ3C4/Do1CrlftWltSqMrO5pHU8ZC6ht2rhDby54WfYKvI?=
 =?us-ascii?Q?eIg2rQ1cnlo3XFXYJGV3DUp5v7H1UAnTEFdvG1XYXVGAo6ojpO94yKArRnRE?=
 =?us-ascii?Q?spPYWGBubrABk/d6n0uR5YvKB0hyYPKRJJCJAkGOUK6P0tRV8OSGanZb3ao1?=
 =?us-ascii?Q?PyW2cxtbk+haSzZBnhbiq8dJ0YrPn3QBJ2ACNXNPOWb0UNbY5QtoWlyOEzb7?=
 =?us-ascii?Q?9DtaKZiDlf4zgOa2Y2vXoHk7RO5eiks4gTmHDVz4sYenHnwjdM51X3vimVcU?=
 =?us-ascii?Q?ebSRroJF8QaqiJOynIpJz4trM9PYrLRPH5AYNt/MxC6hEyS259rBtY8iATKB?=
 =?us-ascii?Q?mDSjMJY6Fnj4W3KuLPE=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 67282cab-89f9-49d5-a25c-08dc3f768130
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:48:58.8693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D0qAlBbJtnWM3yEZezQcZIln5TbR2OhjCw2h0NNeSvFZjmDWr5kle94rm2jpaszI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

On Thu, Jan 11, 2024 at 06:06:40PM -0600, Suravee Suthikulpanit wrote:
> To track DTE[GIOV] programming during IOMMU domain attach, also add logic
> to determine if the GIOV is required, and set the variable accordinglly.
> 
> This is also a preparation for adding nested domain support, where the GIOV
> setting is determined by the child domain.
> 
> Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
> ---
>  drivers/iommu/amd/amd_iommu_types.h |  1 +
>  drivers/iommu/amd/iommu.c           | 11 +++++++++--
>  2 files changed, 10 insertions(+), 2 deletions(-)

I really think the DTE handling needs to be cleaned up before nesting
will be easy.

Various bits of the DTE should just flow directly through from the
VM's version of the DTE, it is going to be a mess to do that in this
manner

> @@ -2067,6 +2066,14 @@ static int do_attach(struct iommu_dev_data *dev_data,
>  			free_gcr3_table(dev_data);
>  			return ret;
>  		}
> +
> +		/*
> +		 * GIOV is required for PD_MODE_V2 because we need
> +		 * to support the case where the end-point device
> +		 * does not have PASID in the TLP prefix when setting
> +		 * up to use the v2 table.
> +		 */
> +		dev_data->gcr3_info.giov = true;

Ie who clears this once you set it ? :(

Jason

