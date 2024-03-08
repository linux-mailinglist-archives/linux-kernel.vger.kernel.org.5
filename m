Return-Path: <linux-kernel+bounces-97111-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 517D08765A5
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 14:52:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27312B2383A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:52:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8749B3FBAD;
	Fri,  8 Mar 2024 13:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="bhALFUkR"
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2064.outbound.protection.outlook.com [40.107.243.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 460243FB99
	for <linux-kernel@vger.kernel.org>; Fri,  8 Mar 2024 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.243.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709905904; cv=fail; b=FRo0WJ7LOqDatH0JlfXM2B/p8a7me9AEmT+1FBEYfbrEG1KlhJ+yPgloZzZQIxOIO3yc4vLnkXnem7rRW3kTbSpIP/oYRZ6LlIWkddplxgMp7sgDeHUrgY4gB6+0iV197Vprc0VBfuid5Xc0PGAQFmGAJMU7TG/AKzH0JAuwxV0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709905904; c=relaxed/simple;
	bh=XELIqPEqQLLoDgzfOAcqKWUJWx8luuok9JzD+AMl2r8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Ov+v4osire26UQQBECY1dLSgLqxZvbWAxdOShekRUsUngLzOV4L099BapI7GWO09YCUDfLixuaksmA/5h10E5iTmESbrEY9JLoRa2puI83/QnxSTlYvVba7SNDtZjcLvaILk9IhnUTNtFOyVHJ/spizCYquv+a7WB0Kz1V4i8K0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=bhALFUkR; arc=fail smtp.client-ip=40.107.243.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IPdbcNMnDKUUQzp3q0N/wsMK5H2kdIkNFPMGjP7GB/H+D3qsyITJ0DL/1ZqnmkiMpdgWCaYmhf0cA9kcmv5UwZuVQ8olgItrzs91EFCfQduN0eJVTq+AcZyN+OuVV/yY5nBNThu6kOg1b2rLqKvqox8F3z9185aVg3RPFtX72KMFNb4oTUFG3jGYZgJcF00PtNZ3iwu0Iex2qOYQAKwnkdcUecas26VQn3RtWqfQzUsWDorqNiT2A15vrkZnO45hu1M0xQH5s/1pJVljOExlv4onRpJqxxCzVTnYutWa539YLzN27VvJ7SdYtcWA3xmfO8KiWBZtWVc/J7qQjs/sXw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tOQ7xTbBeFgrzILkCjzBpaqvYmNKHb8t3Z9mYWWYTTI=;
 b=Lq0wvinVKVKWUj2BwA5RC9NAEC4/TBfMWV8l3Yoa3375q3kQ2cfYvQsq/gHkk0hhtaSDOyUL6u6vTIQrZ8wjwpy5PyKAcynhB+OEMqFH16kSDX3jZpnurBT3UK54JnOdJGo4e0rYPUBMY8oNs1tElJ81W1ONI8m8wkfgknlGLgMcWBw43ycDkPE1LNzgM/SgDDmUDNpri9sAk5kvPeLbtZHceftf8WpMuK6zS3BHUT5u7YGSLjw5Cl3mHSQgocBiPY8fV2ucGvunbUeZRZRBJBQqvwMbN3RY9gt13//Vr8C8oEWtY2VIO3z2SqqyVT167AHOHxc2jZ3L6O22yvWxwA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tOQ7xTbBeFgrzILkCjzBpaqvYmNKHb8t3Z9mYWWYTTI=;
 b=bhALFUkRGGefDQ00J2mQ/YQvz+OgLtsbZ2Za1isqwulkDPyhjykGZtRAFs7YB3IQnXPUq8yyZFRnwUSDIIFh6c6rZ2DE0oCvl5740nuH86FesNoMbsl2CQmc2fBO3WME2b4dOAjGTaRXWA3oKiq4h5boyLUq8alz0ZLxcacnmJoqv3RHQADUBWm5bX12RyYmMU7Cq9CFW0PZccm1N2SOXZl3Pzql+xZR5J0VMJW5HcVkjLxQGra4Dqn4/yyEEGE5JD1STTCHyZbAskFzhpQGpZGKDWRw2nWL1DNbDqXlnX5NVcsJQbrfw/5Vf0UFLl46rSSg+E2gKlkT0E/0phQx8w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DM6PR12MB3849.namprd12.prod.outlook.com (2603:10b6:5:1c7::26)
 by DM6PR12MB4282.namprd12.prod.outlook.com (2603:10b6:5:223::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.27; Fri, 8 Mar
 2024 13:51:40 +0000
Received: from DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222]) by DM6PR12MB3849.namprd12.prod.outlook.com
 ([fe80::6aec:dbca:a593:a222%5]) with mapi id 15.20.7362.019; Fri, 8 Mar 2024
 13:51:40 +0000
Date: Fri, 8 Mar 2024 09:51:38 -0400
From: Jason Gunthorpe <jgg@nvidia.com>
To: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Cc: linux-kernel@vger.kernel.org, iommu@lists.linux.dev, joro@8bytes.org,
	yi.l.liu@intel.com, kevin.tian@intel.com, nicolinc@nvidia.com,
	eric.auger@redhat.com, vasant.hegde@amd.com, jon.grimm@amd.com,
	santosh.shukla@amd.com, Dhaval.Giani@amd.com, pandoh@google.com,
	loganodell@google.com
Subject: Re: [RFCv2 PATCH 2/7] iommu/amd: Refactor set_dte_entry
Message-ID: <20240308135138.GJ9179@nvidia.com>
References: <20240112000646.98001-1-suravee.suthikulpanit@amd.com>
 <20240112000646.98001-3-suravee.suthikulpanit@amd.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112000646.98001-3-suravee.suthikulpanit@amd.com>
X-ClientProxiedBy: SA0PR11CA0192.namprd11.prod.outlook.com
 (2603:10b6:806:1bc::17) To DM6PR12MB3849.namprd12.prod.outlook.com
 (2603:10b6:5:1c7::26)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM6PR12MB3849:EE_|DM6PR12MB4282:EE_
X-MS-Office365-Filtering-Correlation-Id: b7f11d74-d32d-442c-c745-08dc3f76e18f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	uA0i8o1qJ6fjhllGt9Keg3bUGUuXB/ZqSs83iRKSJHhIYNRcOlugKr4f9Eccg9iEVCLH1rd2lM5wPDRM6CH+e+sHNV+hDvt91LUwYkONzb70kDZLVyXxNFtyy+YamUKCqT3rf2IO8NDkfZZSKHi8Ucz/dHoiIZ+7LzI3vogKOIG3N7ObI32GjcVraC6S+Z48FJUoGwVRbbA2n6IYgulk+F3YxhuwNn5D51Ly558867+ZsX7fxo2tPina+PVC4rd3D+uCBA1hIU13DNFD0Tn7GtbZUyEiTyrfHDfR2281NLsPrwShCs1m2zj3MnImLnwpwAKr5KiSfzi3LnogUp02tn0QA658cdxhguKUIZ1CL2xS3BLtWEQkYl8Yx7vj8qqcm2MBuopGP0fVtzRir6uMgzTViDGcaPZ1fQkcL3SvhI9TmeT1TrLYCcxpGjeXxlhpTSy6qy1uOFttXWQzNrBRAhIJYQz6NPTryYEvWgKpYD2VudSxpELKISApj2VudkRy9JZTiqKG4a1VDhiRun1QgHvWsp72qlYDJbjftvvBuPQVSTXgXmAdmCRiCkVFwKatY4mBgDIalOXV5YPJnFK3ywwYL7cd5wCY/q18ML76vETFdmRV4xZV44XS7FFGy8rBkocamIvwMBiRNRCDAFjxOeDAAFewfB6h20g9mJ+YKMg=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR12MB3849.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?JHzune3yagBphGx5OLj+/iAIf9ZcDCAUzfIosaUVcoOWEqQIAH74NO+xBukR?=
 =?us-ascii?Q?em12LOPfqWK+nylFDOp7poX6UFQI1PUL64j9X4TCvyBnWIGe2AsKEAvFlX3m?=
 =?us-ascii?Q?kg3O3ZLsMGZdwaLXREe+u8wTgRddBX9+XDySznDqhU8eN7FgPHxKl+tgRME6?=
 =?us-ascii?Q?UebJXYyzGWwch6zMlmDhwhTL8G9HAp2nHFVs32vbf1NQMYqN4sFAl2biZrMW?=
 =?us-ascii?Q?NqpqaRERPbvxYxL1NIktbbRLH56m42VMbBQ3f2GHsTNkma7/lHqLE0cq4xbP?=
 =?us-ascii?Q?BlY/kWEgZXMit9FFKSAWvAyeK7/An9kfshuH7Yyx3rJ4DzfwZAipPYIcS26F?=
 =?us-ascii?Q?SezwokX+OBa6PCVxjvmC4dYwZW8lLQylOeaFs7S39FsndQVUmS5iQNoyVdsv?=
 =?us-ascii?Q?vvtD1/tp8iEwMRjZQxULv4ArnWbAK+P1tRkeZKXbyAZxjt+bjuLA/1bKh887?=
 =?us-ascii?Q?sMgUrSnAcmcLoZT0suNsBS9u+f0BYS/oxv1k6WGakTW3LqqVkFFPXKAZUR6+?=
 =?us-ascii?Q?9TjYjtGHv0N7DPb2jqHSptuRpNMIWb+VQXaprtXkz8So6a7QLk7+fN8ymCgI?=
 =?us-ascii?Q?5CSE77ntgqJad9baJWifw0qgq4iuKCxfAW/3GT5wfj7U5y6Ofxz2jlTBVqiA?=
 =?us-ascii?Q?9iDGDmZXBrEa88tCJu9tOE4wSydlmBDiEyQk7RpU+4VPO5cyC6QR+zMaMMQ0?=
 =?us-ascii?Q?8W6NCPz38zRAFFkdaPJPZ2yvN60YpaeLlU7XbtRulClGxEE0wZ1T9dzYPLha?=
 =?us-ascii?Q?GPe8LJwro2CRFYjGfkObBtBz0mMvG+JkVY3tYghxWePLFQLVR34Jr3kCsHea?=
 =?us-ascii?Q?vH7mEAkCsgyMqh6tftfJIeh25hNDQhUQgboQtU/caBnVq7aYc5V4pasPREAL?=
 =?us-ascii?Q?liBLStkTRWBk4/rjqG2Rej76G7/r577FuqKk9+urfTQ4ydpEiJKhgQwrZeN9?=
 =?us-ascii?Q?djZMA5zSgKMQwuJf5hkDMMTONBYHIW7ieizE8MjzLYavQCe5Gc5jBv/RgKpn?=
 =?us-ascii?Q?Y1QbfDXNHnsp/m5CWPwjr0SRwTXLZ3AbHaD9MGZUwcmxHOmMbEH7QeHa6+TJ?=
 =?us-ascii?Q?jNzZnL2G8WrDtc0jaoxDeUVsUS4GJhtTOfpeUAfOYVVaif7hbYUflf8VuBrk?=
 =?us-ascii?Q?Dpg6FR5IBoT+BiWIbSAiOJzoeNFE0jIvZ4w0Gp08gslWM/vmTuCvyMas55Qm?=
 =?us-ascii?Q?RpAYEKG6ZSUQOOljfWCCsB8aQ+wAosScjk60Wwk+/AF38RI7zEyh2jgIAAe5?=
 =?us-ascii?Q?f4lS39DehZ1OSv35RTs7spFz+A/LPeYqZXgGfMXXNxdhZpW/K5IRqMLgo4Pp?=
 =?us-ascii?Q?GvMGQgePcl10fA0jcVDY0wMWn+06f2YznC7KpoiQi9gzxuvnVfrhnRC3o4m1?=
 =?us-ascii?Q?XygMguyp6MwcvrNOiLeZ4ulMo8fHk6VwTYM/RwvuqriZrNkomPRJIVJbe8gK?=
 =?us-ascii?Q?gvR2PcQfLXIQ0Oofh9GxS0b1iDKlBu+C2Uicg9p+ay/J7iwwqYyHgMYiLkcT?=
 =?us-ascii?Q?3uWiAV57no5BWzw1lZHWQ+EZiXunzOfYk0fZe4n+tcP6FlVjQTtk4xOKx+Sc?=
 =?us-ascii?Q?YRnLDRZ5x6jFBjNzFT4=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b7f11d74-d32d-442c-c745-08dc3f76e18f
X-MS-Exchange-CrossTenant-AuthSource: DM6PR12MB3849.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 13:51:40.3961
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uyUgbWE6fqsNqYxtJVrzLvXPHtOEC3jVVKnDmxexpw0puJJGbL+fkVv1CQ80w3Ab
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4282

On Thu, Jan 11, 2024 at 06:06:41PM -0600, Suravee Suthikulpanit wrote:

> -	old_domid = dev_table[devid].data[1] & DEV_DOMID_MASK;
> -	dev_table[devid].data[1]  = flags;
> -	dev_table[devid].data[0]  = pte_root;
> +	dev_table[devid].data[0] = target.data[0];
> +	dev_table[devid].data[1] = target.data[1];
> +	dev_table[devid].data[2] = target.data[2];

Maybe you could have convinced me this doesn't have bugs today with 2
qword updates, but no way this is OK.

The multi qword update needs to be sequenced correctly so the HW
doesn't have tearing. The manual talks about this and it talks about
128 bit updates too.

This needs to follow the design ARM has where it uses the special
update logic to reliably sequence the change. Since nesting is making
the update more complex it becomes important.

Jason

