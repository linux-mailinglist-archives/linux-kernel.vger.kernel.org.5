Return-Path: <linux-kernel+bounces-161825-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D2028B51C2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 08:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A82AEB20CEE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 06:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7968811713;
	Mon, 29 Apr 2024 06:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="UXJYC0wf"
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2118.outbound.protection.outlook.com [40.107.93.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD4CFD530
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 06:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.93.118
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714373401; cv=fail; b=B96KvQf1U4O+/UUPPQ5lklvZ14yg+5QfBYmKRMZTtYah+3svu11wW5kRZS8J0U4qx0vdRtDSxJAsjDg5SJZNjsqWagcND/TCgglYgMx8vzeVrXE+HRD0L0iyMF0QGfk/QlNypMIS4vQQ+28kSNJU69wpWBTIoGkGYLALV/p6oHM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714373401; c=relaxed/simple;
	bh=Os8FBi7+sVYil2cvJMzRtMvR3/bkMjOXfl/t2/G5OZI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=dQGWdAvTvuBQ6vkyCGOCQnI3oRZ11NUNl0llp1QgUFieUqhh32Ihu39dp7H4aROPC3XPSeMcE3XXyM0GSc1kzixpuI3bqEYMM1H+cztojzycGwMEv6yhzXL0hM0y40srDL/+uazauTkHfuVxiLVWePhjT8myMhvzIs1wT5FMSbU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=UXJYC0wf; arc=fail smtp.client-ip=40.107.93.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=CA4nALVfWczC1yDi/G1hUOaumgQynvur3eSY+cw42ef8nLw/WTIts/rCBePIBYcWmlKQPBLeYLrpAtBQpR2boSHNxIJCLWGxVij7PYD3+jQWZqEhq2hB+Zv+LvcuAn9ocoSJZS+BGxo/7Beqla9nNGdgAXsjbQn1xNXcVkurc5x8QXsLZdzON3UerktAcMSlIf7bBs6TNDtJ0qLA9sCzOR6Nokona5CJse3lJNPF9U6lRkf6A1l1Z/MFeutETcs/K8jRGJuFL2fjU8T8B/+G8+6G728Fr4+Y3cP9k/IyBmBBzJxC41Wpo0Z/w7DvflAsqgbGDFlZRz3dCrlAegB7jA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SAR/5xggiCXpWrM4wuUPD0XKVW4URR277H9AzEy9jro=;
 b=QUUGCwO9cXS95gSdtnpl35s4iVIbkbP0KvCGnLmKeVdyi1r1E39s8Eg5poqZsjm9gpMSH8+9lFv6vcQ68qptfGMZJDBdqfWflW/CM6YYrITeCGcQjoGrR7wQ9NDh9Lqh/QZ2RN0+c2pUDz6hl1n6UNtKupHX5VVRS1RNawB1iM+UfmkU9zti6H3NqDU9b/MfWmvEHiXfmArkfGLEPkI6HVHzoydG+s7vOWXnjtIgJevGk1jj7+lCEX9hlT9ICjFGHW9kp71QYxvS6heo6c+FVLNGcPNwku1J9/tMgImWSPwFl1sLYv+6bhRXyT/S1qBs+9XCNotBbIhBqTNwfhomdQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SAR/5xggiCXpWrM4wuUPD0XKVW4URR277H9AzEy9jro=;
 b=UXJYC0wfC6IjiVvmpwuiz04JEbF3fiMweJx/fjEZF5xBx8djGZmu3ig322ODCLVCGqTMim1rt7fvrzlKrQ2cnPlje28UCDSFU6QPla8hqlXr/6qRhrhS+Nv+u3MxOSaVWeJDjbMIM0oaH4biAjhc5BUIE+jCwbEb50Oh7IKyQl0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN6PR01MB5022.prod.exchangelabs.com (2603:10b6:805:c3::28) by
 BL3PR01MB7178.prod.exchangelabs.com (2603:10b6:208:345::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7519.34; Mon, 29 Apr 2024 06:49:56 +0000
Received: from SN6PR01MB5022.prod.exchangelabs.com
 ([fe80::972d:5c3e:74f3:f348]) by SN6PR01MB5022.prod.exchangelabs.com
 ([fe80::972d:5c3e:74f3:f348%7]) with mapi id 15.20.7519.031; Mon, 29 Apr 2024
 06:49:55 +0000
Date: Sun, 28 Apr 2024 23:49:39 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: will@kernel.org, mark.rutland@arm.com, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
    jialong.yang@shingroup.cn, Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    Jing Zhang <renyu.zj@linux.alibaba.com>
Subject: Re: [PATCH 3/3] MAINTAINERS: List Arm interconnect PMUs as
 supported
In-Reply-To: <a2484b4fe02e38d86f99f234c94c5497feadfb5b.1713972897.git.robin.murphy@arm.com>
Message-ID: <948e58-c888-a6d9-3cb5-52f7a226a14@os.amperecomputing.com>
References: <cover.1713972897.git.robin.murphy@arm.com> <a2484b4fe02e38d86f99f234c94c5497feadfb5b.1713972897.git.robin.murphy@arm.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH0PR08CA0001.namprd08.prod.outlook.com
 (2603:10b6:610:33::6) To SN6PR01MB5022.prod.exchangelabs.com
 (2603:10b6:805:c3::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5022:EE_|BL3PR01MB7178:EE_
X-MS-Office365-Filtering-Correlation-Id: 6ef30cc3-5373-4204-8c43-08dc68189459
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230031|376005|366007|52116005|1800799015|38350700005;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?e2Y59mokk5QrLL63KQ/YNcGq15bWvT+nPZKh0XVqTPO4BzUYRxkillrZ7LDZ?=
 =?us-ascii?Q?1pGoCC1yC8T+U4GlvEf48WtlQOeuN4ORML4+u/q/MpPq1a8lcCj0IRLie7tz?=
 =?us-ascii?Q?9uXchihkMjDlf52IqnN4McfIxBbT9Bvr2dl6vm4b3KE0uyHMVrmQM12mu4ia?=
 =?us-ascii?Q?T1OyG3NoLgJSlnF/tkKkz8BLKONj5mJ+GB6FnM6m8DjccM34/22DEobi3j8N?=
 =?us-ascii?Q?ulwq3x1a31oblvWX7qw1LGtJDub/NM1paZ21hIyhaTgsVHUBwVahz9oZtULR?=
 =?us-ascii?Q?1PL4T6zWcwcdnYCewX+tIBOMlEBDz3u4lH0bl0pyhXwUwpjxXNdGIm2bVlQD?=
 =?us-ascii?Q?deD4Pgsi5dSIYIgqmZisnlujgQ8FKgeY1MDonVhL8eupjOYG7IgSsC/Bc5LS?=
 =?us-ascii?Q?i8mbdGEXsY3SrtCwfhRDdIF7m/AbKktVHrYZ5aGrBaqV+fqe4kci9LoZbgk6?=
 =?us-ascii?Q?jIJTEcMlhtmroM21idu/RXpZjq3G3l5Bx0lf2u60iyrkH8VhTUIZ8M2psN41?=
 =?us-ascii?Q?6xWGAhTTov6ASgmihl05buk00vmjQymV8AZUwWiJGYXAreOVIon8NaaKKP8b?=
 =?us-ascii?Q?119aP2aqWNE555g+Ozf4rQGOxlXCM3ZxMvWwgfrcD6xE8j/GujGgw34nrwsc?=
 =?us-ascii?Q?fTIWzP2dc/k3Jr9UQJ6C43cu1TQ/mYQZTa6JqWr0ah95WhvKzp5PlFWxKKnC?=
 =?us-ascii?Q?MxC5r/EFYEVqejNtRVhtO3T/5R5ZG+b3Jhs3oUgysaLyvRt+h5fwjdj2z0UZ?=
 =?us-ascii?Q?Yk0dvp4YYXM+A/QHVdVc2lWpMpBfMLXEsBNRNJtaSnVwYQT+Lvnc2gOG1rH0?=
 =?us-ascii?Q?lqa1oAAWBWv6rHwoumsrWQXt2SMI95JuZqoyTUjnqJ0swS/fGfVirCt9dq0n?=
 =?us-ascii?Q?W3ZfELgLqxXOyWYwLFZ1BEtgvLWmx7ozZKtiP8yRTp08cbDWZmDO/wdB9/We?=
 =?us-ascii?Q?pIAy8QUwtqR3Qpj3YU8d45eFQl9O4/IUYD+/y+5JPbikKIwg3C2TLP0cpenN?=
 =?us-ascii?Q?9KtSKewj+RjDQI+FCytrQC7ClMySdka5HVwMPZfvCnCMZoXnelCrB87Tt5as?=
 =?us-ascii?Q?petRMm1kcA8JjxBYu5R2DGl1IG8WI8eY6bGh6dob/e59NMbf5FIaE2NdG2Ek?=
 =?us-ascii?Q?BPX6zWm6f1qsopCIHY64nZMV7JbLLycXjUoCPtEQbSd5LWeQTHBqY5k3cG2D?=
 =?us-ascii?Q?dhISGy4pZ7Ys/5cQMJhiwmLYVTA9z2IXFVo8SNPHXZPinTMUm2gpEoXd3AYN?=
 =?us-ascii?Q?5vlC+mFIPYzpGNzZlk8/UKATVAYVHNP8eSPdmDj9+KjGgnWJUCn733cm0NsV?=
 =?us-ascii?Q?KW82vx2A8zVC1e3acGEO88Zezmk2hCWD9IU+xmpXpuJxQg=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5022.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(366007)(52116005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?P5VN7swBLBeTjwL2OEa0gx7E3HkdkI2kA9La6TMMdyj005SDS+I8tj4whHjj?=
 =?us-ascii?Q?On276Z22Q6mFltjWX9Qruc5VuLsIxtgzhKnMEgcJ2Doo47/Ee42WijvQZgZA?=
 =?us-ascii?Q?xTB+N64r+9/tChp3rs46kAtx6MitlfIzLa7x9Ie8bDIp+6eU7LStEiibv727?=
 =?us-ascii?Q?89VUCEONMd/+MRrf7FcovAUocxxgFGaZ4eMgsrpxg6LHsFH650V24Zcz3Ua1?=
 =?us-ascii?Q?o5uPsk3sNzzKr8KQk5zC9gA5+vu4nUtWRLxQ3iwEpndiTVXt3NwuSDnb/7pJ?=
 =?us-ascii?Q?+GvVUYcH1qvi4QxIaeBadipmrprU8iUj02cMmh7sqbQ3u/sAGiPO+zOyP+gw?=
 =?us-ascii?Q?tNC7Iw9+cSbnjd4qLbuK+3Ej/0xzyf8bVkE70Zr8WBOZfQoSlq3TRYlXbeWN?=
 =?us-ascii?Q?nHO8nGyUEJpwvk5C2NbQQhkqU9s9+0o+tj9aw6wR2g4qw98ovvX8P2GTfn7l?=
 =?us-ascii?Q?PNgZMES9wI6loG9sMLQipjNpRyF7zi+gat8ip57HNOvz3msfTfmKAeQZy4vn?=
 =?us-ascii?Q?hYr78SlRnGTDgJPmSIk2peU/O+RQs3NB+2G7f/MSeb73j7gHSuG9L0zGqMtO?=
 =?us-ascii?Q?urSBhELbFVoWmUI5zlxCtB5SjLruB4Z9k6V8SmZZTLCcy7s9hrSUbOVZlFVi?=
 =?us-ascii?Q?c1kbaesWPtrtxT6E4eKjHbHWRJypqJq7y0ZOGaxszhq/M6nQVMA7Bxbhv3qH?=
 =?us-ascii?Q?rmrQM93o6o+InVNerHG5Eo/pHJjFrkG6NHISr4Ynml66ATw7V5peAi4msgk8?=
 =?us-ascii?Q?SWJZwUxZUz/JNJvVntuhiVKy2Zi6RQy4kR7QfGHOpX+I4RvIHLflokrXupoz?=
 =?us-ascii?Q?JbuOqCrtzksy45HQKu6OTLsEov1D4oRsD+jt2d4gnfli8dK0YhXXxE/8HV0p?=
 =?us-ascii?Q?QiFy6AttjtYhtVaYEiL5XRTT4Tef52VP2K0v6q+ibCqBh/RcTz/PaUZH0+cU?=
 =?us-ascii?Q?lnJNmRIDHLfA+8lwqzRR72n5TFiija1ThefX3E5UYKn1zzCrw8ioznd//5Zn?=
 =?us-ascii?Q?2kTI9OketfQiciUZP59EdYSKUtvxJlZ/AxOzBe4wjJ9JTUZWYEDRhovpZU7L?=
 =?us-ascii?Q?Ceq8lxOWB+f5pyv0NJAbgVG3vBUyRlwKsJ0mzB/M2nhp1En2pvhbO3VhFhEz?=
 =?us-ascii?Q?j5pEmNLuU4q4DZGcV/BF8+nbNAcmWy/SeNM01aBoTTVS5B6cu5TdHCMl95O2?=
 =?us-ascii?Q?vXsqCL4vomP4ws/wAKlgf1YJwj1lg+ElJQUsz6Gc9qNjbpzID4R5tIhDtJpX?=
 =?us-ascii?Q?zYdrfuCXnjOygKd72zIevZDWp5xOzFhXvH2pdUr72M+VarmNlPjFaAP9TgmE?=
 =?us-ascii?Q?Ap9HKwcHxsynZLK29qyI/MYFhWBhfo/WE76PQMK3hWZPzvXI0bGICmxcJQew?=
 =?us-ascii?Q?KJVPKs6mEhzRBFxxFVuiziaBvHFDXa1b+ZLOD57ay11BfSkAhmFbsYwQ29JU?=
 =?us-ascii?Q?65IRYdSQJznVOib2MpCIUMgHgtWCwvqsGA/9lx7lmqES6NbL61R8870LUaon?=
 =?us-ascii?Q?581UyBjFfGGYwXv2KczUVFDM/bqlpgxKSq/i1vLSX1x53dX+wPFgo92savdZ?=
 =?us-ascii?Q?5VQkyIlkyQ9qDPATE2meqdZFo8U3XqiH8ezoH3VACL5zMjpjdsct0nvoVxEA?=
 =?us-ascii?Q?kxsvX8DVRtOcv56vjUtaUOI=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6ef30cc3-5373-4204-8c43-08dc68189459
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5022.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2024 06:49:55.8484
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1v1kby9W8BzoDs6k+G/X6Z6CoKcfBZVg4II5wGAQKgtJjgHmbgYPr7mBcWP7l8duICrN221QEKdNhFwf4dExRnlKVeJHdOs8mgw7cP0BvM6wHjB9TD8FCEQS8qwv0XUZ
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL3PR01MB7178


On Thu, 25 Apr 2024, Robin Murphy wrote:
> Whatever I may or may not have hoped for, looking after these drivers
> seems to have firmly stuck as one of the responsibilities of the job Arm
> pays me for, and I would still like to be aware of any other patches, so
> make it official.

Thanks! I completely forgot to suggest this after I realized 
get_maintainer script didn't return your name for arm-cmn patches.

Cheers, Ilkka

>
> CC: Ilkka Koskinen <ilkka@os.amperecomputing.com>
> CC: Jing Zhang <renyu.zj@linux.alibaba.com>
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
> MAINTAINERS | 10 ++++++++++
> 1 file changed, 10 insertions(+)
>
> diff --git a/MAINTAINERS b/MAINTAINERS
> index aea47e04c3a5..541448195df3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -1668,6 +1668,16 @@ F:	drivers/mtd/maps/physmap-versatile.*
> F:	drivers/power/reset/arm-versatile-reboot.c
> F:	drivers/soc/versatile/
>
> +ARM INTERCONNECT PMU DRIVERS
> +M:	Robin Murphy <robin.murphy@arm.com>
> +S:	Supported
> +F:	Documentation/admin-guide/perf/arm-cmn.rst
> +F:	Documentation/devicetree/bindings/perf/arm,cmn.yaml
> +F:	Documentation/devicetree/bindings/perf/arm,ni.yaml
> +F:	drivers/perf/arm-cmn.c
> +F:	drivers/perf/arm-ni.c
> +F:	tools/perf/pmu-events/arch/arm64/arm/cmn/
> +
> ARM KOMEDA DRM-KMS DRIVER
> M:	Liviu Dudau <liviu.dudau@arm.com>
> S:	Supported
> -- 
> 2.39.2.101.g768bb238c484.dirty
>
>

