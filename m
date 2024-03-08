Return-Path: <linux-kernel+bounces-97211-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 73065876702
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 16:06:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 19032285D58
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 15:06:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08D2D1DA2E;
	Fri,  8 Mar 2024 15:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b="YDI1LQXZ"
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04on2113.outbound.protection.outlook.com [40.107.101.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 305DC539C;
	Fri,  8 Mar 2024 15:06:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.101.113
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709910406; cv=fail; b=PuIGOIhnyagIbCNQQAb4hyCLbj7qe4VqXn5KlkGRSp720NpDiz/2ZwonktbTZ1W//kawM6mB9Q8tc7zGKIKLNEiQ0vvGgx24uz4gAYAKwV84vC3207ynRUB8gNwM3NFz0YQi2Anpoy7qbxpwlLrukwulA9ri6jHiSOUinuNWi0I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709910406; c=relaxed/simple;
	bh=QxCihCFl+RnYjyOeoR5jkWm/iKv4gGK3noz4U+CV4r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=Qr/4Ds9DNnN0OAsJgv0QXcKcYjXr2uuv1rJLg5kpbzyGLd245fMlcliuyCL9djC3jFMsoRxle2RDV5fTbKlQo2UIRhBgTdk0DzM+iPatIsmprZRtkNbJwhv9glKJDG8IhxORBaA88NyU4puW0QkCGH7cYCGlXHPAxyK04FN0pmo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com; spf=pass smtp.mailfrom=corigine.com; dkim=pass (1024-bit key) header.d=corigine.onmicrosoft.com header.i=@corigine.onmicrosoft.com header.b=YDI1LQXZ; arc=fail smtp.client-ip=40.107.101.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=corigine.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=corigine.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nlqGzQxthCA7qrEGmJ62pQ1HkaV0VOCuzcaddnek1cHnSGlXT4jwUgzXOUDycpMY8NL4D1CpwKNlX1GSYuIYgFWIteauQKmOOu5QEHJ5hRd1R8hNY7nqFJQTmX+IqX5yqAQL0k7exarp5WKlJdd/fZlDXqRExwTVvkKvIhKofjCzEFD228wmMNsTZFu+XPAiw0yhc8WdAcwtN5YoIFSallTc127XB/jgJtQpbJrGAI20/DV8Qj9FONUnP8ncNrckBP/2VARvL2brM0zWphZ3H3NN3zPrsaG2xkQdxEp4myPlcVWq0h+SJlaRR6khBRHYbjl/zDOoNuZYpifDU9BGkg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Xn4sKJDtiqju1+xjuEqHzlgET0YL5cIaMeynC0seCKU=;
 b=Px7C0REu7We82BYazdJ238z8MuVxmrVuNocy8L2uFsTaf/M318ZTdJp4iBHV3E0g4go+Lt965IjICe6qjgnjSpFLCJoY7DLbNAVIJwKx6jqgfyqH/8uS8V50Gzzl4UOJ7Kdn+bmJnr3kp8O4jOFF7T53oNbHXoMMQE+MNwQDFrAMTWpERQA/Rl+fvbVRci47oT4cMEYx74vDtvQZKhMR6cjohVeXPriNSpGl3o8jgHu7YDtdt5jb/7sblv4I121trPEc4CNXMPefS1lEH8H9E3HnxU+0aD84LTnSqWQ0+Kg5jusSkxX3MYCSxUKJmTXo+IbhRKRrG9ZvgkfXO/EzrA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=corigine.com; dmarc=pass action=none header.from=corigine.com;
 dkim=pass header.d=corigine.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=corigine.onmicrosoft.com; s=selector2-corigine-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Xn4sKJDtiqju1+xjuEqHzlgET0YL5cIaMeynC0seCKU=;
 b=YDI1LQXZzSZt1taRGgoTNkRuazTVI3j944+C+yBYYmh7B5WmVeIOT1PuThridFjThhKBFIFAw3nCVIHjkKkNIrbnOsrvdHJ7RoIbz1ttQSUG9xuIbgdPRY1MwNRxrleus7a3RD2LZLdHKPl1KOpHNxt7g6SkHdVFnBSHbt8yO/E=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=corigine.com;
Received: from BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
 by CH2PR13MB3815.namprd13.prod.outlook.com (2603:10b6:610:91::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7362.31; Fri, 8 Mar
 2024 15:06:40 +0000
Received: from BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb]) by BL0PR13MB4403.namprd13.prod.outlook.com
 ([fe80::c57e:f9a:48ad:4ceb%7]) with mapi id 15.20.7362.024; Fri, 8 Mar 2024
 15:06:39 +0000
Date: Fri, 8 Mar 2024 17:06:00 +0200
From: Louis Peens <louis.peens@corigine.com>
To: Duoming Zhou <duoming@zju.edu.cn>
Cc: linux-kernel@vger.kernel.org, yinjun.zhang@corigine.com,
	netdev@vger.kernel.org, oss-drivers@corigine.com,
	christophe.jaillet@wanadoo.fr, horms@kernel.org, pabeni@redhat.com,
	edumazet@google.com, davem@davemloft.net, kuba@kernel.org,
	arefev@swemel.ru
Subject: Re: [PATCH v2] nfp: flower: handle acti_netdevs allocation failure
Message-ID: <ZespWEukbuJZcdI8@LouisNoVo>
References: <20240308142540.9674-1-duoming@zju.edu.cn>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240308142540.9674-1-duoming@zju.edu.cn>
X-ClientProxiedBy: JNAP275CA0029.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::22)
 To BL0PR13MB4403.namprd13.prod.outlook.com (2603:10b6:208:1c4::8)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL0PR13MB4403:EE_|CH2PR13MB3815:EE_
X-MS-Office365-Filtering-Correlation-Id: 31653fcd-5dbb-4f50-548c-08dc3f815b47
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	1c+S32dAlcWxIxHcV6VgNg+KUTmGSaCjrNtmiT4HTwe0tf2OW2Rd22dSw8MdqkrGdMkg1ptlEpGVivCWuj3d+1q4O3UrXwmJQhZjsCf1WkqN6KcfrV/KuyajaxA8KrUWCFeRGJQ155IUs02PxAzxmzttiioAXFMtNixlb7q58uu6MQZhbAoiu3sFvY+rybUhkrFh86+/yViV6nh+ly333r340NB6JZ5nZ6V0ET22ujYzq1Vce2rnmp9+19lW34vCwovirCj1StNTprhxT8yEjVEngTHZ5Nd5IKpu0aNxhUHl3Opq6x16yzzMAVTeHg2DpBgCPL8gXar3wfCjEGWh4QL4TWTNVmQnbMJY0kVMKQhBpAevyp5n/e35qWZ2SUp7St8bNiSHP2YgTDa+Y15iPsr6DE6RXWitzESJUTr0ofGh62OZdihNeMljWC6IAmVyWlaBm6ktfD3ixzAzo84hGMXHi9fJs0BQjSNc5n+SKhCjQ0EItk+6YUX8ciKSibfG4kHvGvybSolj3O3x7TYihPlK2ZN5Im1RbYnL3Cc2KHMucM9OvS5KTfgpe6aIxurfQ+WvGKBjZzDRs0LUcslEqnUU62XvzA6hUq+1nVUX5MmYF+YBmqfquMgiK0GSWdZU/jQiqyLg3aCXtE5vtsy+j2AGQz7LyBXgjpg9fk5/OkQ=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR13MB4403.namprd13.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376005)(7416005)(1800799015);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?jS7YS1eLRk9dQXN7PqltOucUzlTdJShLQm3Q50j46LrDagomS0VoVSD/B/e0?=
 =?us-ascii?Q?qOxOXUIl1wFLuqrWnvDlvlyANsmrBcc30tj1UFW4UqdAp0zjwD8iZFd7TWIm?=
 =?us-ascii?Q?x/9cIGBuPp7RJ9hbL8No3luc/4m7JZLdksL7Nu1nuNPo/C+d6jcg1wYIfoPG?=
 =?us-ascii?Q?14o/sWOthHc4rEz62v9OCJJB6JoPrqMIWIALcvawLTd3Tz8PsYvF/wmBGItF?=
 =?us-ascii?Q?VkgQDoMp0VHoyuUyRDYmtQ8zHJGIVFMfrdyu9c+aPrs2BPIawasXT0YPBLqf?=
 =?us-ascii?Q?dFi+byLzYsNiyOYew7M6ryWXZgbdIzbEohbesHB+u03VO1/iLD3386ZexqV0?=
 =?us-ascii?Q?5GQ/BOeHYmC0Wl7Tj4oAXMGgDRWePV0hgJ84GH0ttO1LZ6KQf23JTi7SBxrD?=
 =?us-ascii?Q?htIngSnP8VDnDaHdvVKtp/CGOg6S0KXBwM99maBeFf8rFKci4ciDt7uWb+sh?=
 =?us-ascii?Q?pZ5/a3CCeWwbAbZaLi8qz7hWaB0BAYGZojslOQiDPuw6aISGKCe9966Qmwb8?=
 =?us-ascii?Q?B5hS1q6H9ecfNAWSWUllakBbIMG6SPlP8VlZd8D+LvkqNw36o+Z46+p2cKBl?=
 =?us-ascii?Q?jNZ9MqNtX76fkC2uWz0nxeOtdF3DjJFCYM2NpZMjPFlvsQ09nfeIcnircU6O?=
 =?us-ascii?Q?GSqoY9OvefbgjINMHefzTWyRCVDgRsETj5eEaVqBKXj1UV7sXGE/LGH830B5?=
 =?us-ascii?Q?f6Fb0ikmsXUleFKeAAvafYEYsJmUlr93BRO+JbsYi4Pzkv9Cb7mmIEQdXKiN?=
 =?us-ascii?Q?tCm7wpp7cn5oFT2BqeVwMEQST3ICw7WGXTsbb64Et1tDHyi4oVWf9OGZI/f9?=
 =?us-ascii?Q?QT7i/V2TjwEVky7SqzEu+EriioUaTdXPDyD+ZoM8WJoWToJd4SDbFoaMDVNv?=
 =?us-ascii?Q?OwNwMqSYNgB4ke7tUn67vboQHUWZxocHKmUl5PPqthoRXk9Kq90sIN/PitcK?=
 =?us-ascii?Q?UXviEM6QLj5JT600yZ6QtFrds4BsHqIO2sz5mlV6UBmDV3bRmYyLh12Uq8CB?=
 =?us-ascii?Q?6vdeot+Nu+qROE4N2Wi1Y3B+7RQaeTHOROau6Gve2ymu2+IMBuAXePmqQgCT?=
 =?us-ascii?Q?hEHK6vHl1PRkjLHWt9SNTHjUYfP87z6fP0Yobuyq8u0CDfxgyIlx/ceeqHTS?=
 =?us-ascii?Q?UX+0PhJUf8UEsVzUmIqHB0uQt3onOfnlZQtGOkWjK0v4BVvhJuZ8ocQ4cSq2?=
 =?us-ascii?Q?OwTQoFc70V4SxTOPRFQnlu7Mc1/Ufc/VHKPA5XwkSyeXDsuLR63z5X/ofbp4?=
 =?us-ascii?Q?KFHsNcVOOBwxI9zxES4tFI/7ztGRq8CTuq45tiXLK8OM6fBz1XubRmqJLmLY?=
 =?us-ascii?Q?Lscahpg/C3Bh7JqqaFDg0p3OtPckhgAiyVtgPg+VV49FIV24U38Cy5sqlxrh?=
 =?us-ascii?Q?D2wuLVNHXSxm5HL4Sr/uH9Z5j1P7K7qEKI4hhSP0BEwD9Z7oeE0brXnNm9c9?=
 =?us-ascii?Q?RO23zA+47Y09oNPRQLdfnpgi99ckxz/sQgZF9Y6CjhuVr57geB/+/YdfkCkR?=
 =?us-ascii?Q?4Kd5PkkdACv/NSGGSs2uBOTyPw1bLtKbfSq3gddjuSMGtj2jj2WMZMueHx6K?=
 =?us-ascii?Q?D8tiT9z0lyISOM/QtwChvngacX8I2K0dKm3/D4xmuO8wbwhh+aH2Q26cOwUg?=
 =?us-ascii?Q?qQ=3D=3D?=
X-OriginatorOrg: corigine.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 31653fcd-5dbb-4f50-548c-08dc3f815b47
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4403.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Mar 2024 15:06:39.8387
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: fe128f2c-073b-4c20-818e-7246a585940c
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W7vfzQfoV2N2bSpa18gF1NnulFgHL6mhOd50LAYVbybpYIqxFT+39OeZrcrJ7MNNps0cAoi0aYotwLNSvHCVgVunJ26aXqn590bljljBoMc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR13MB3815

On Fri, Mar 08, 2024 at 10:25:40PM +0800, Duoming Zhou wrote:
> [Some people who received this message don't often get email from duoming@zju.edu.cn. Learn why this is important at https://aka.ms/LearnAboutSenderIdentification ]
> 
> The kmalloc_array() in nfp_fl_lag_do_work() will return null, if
> the physical memory has run out. As a result, if we dereference
> the acti_netdevs, the null pointer dereference bugs will happen.
> 
> This patch adds a check to judge whether allocation failure occurs.
> If it happens, the delayed work will be rescheduled and try again.
> 
> Fixes: bb9a8d031140 ("nfp: flower: monitor and offload LAG groups")
> Signed-off-by: Duoming Zhou <duoming@zju.edu.cn>
> ---
> Changes in v2:
>   - Remove print warnings on allocation failures.
Thanks Duoming. Just a reminder for next time, it is recommended to add
the tree name to the patch summary ([PATCH net] or [PATCH net-next])
when submitting to netdev. Since this contains a "Fixes" tag it should
probably have been aimed at 'net'.

Reviewed-by: Louis Peens <louis.peens@corigine.com>
> 
>  drivers/net/ethernet/netronome/nfp/flower/lag_conf.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
> index 361d7c495e2..2c7bd6e80d9 100644
> --- a/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
> +++ b/drivers/net/ethernet/netronome/nfp/flower/lag_conf.c
> @@ -337,6 +337,11 @@ static void nfp_fl_lag_do_work(struct work_struct *work)
> 
>                 acti_netdevs = kmalloc_array(entry->slave_cnt,
>                                              sizeof(*acti_netdevs), GFP_KERNEL);
> +               if (!acti_netdevs) {
> +                       schedule_delayed_work(&lag->work,
> +                                             NFP_FL_LAG_DELAY);
> +                       continue;
> +               }
> 
>                 /* Include sanity check in the loop. It may be that a bond has
>                  * changed between processing the last notification and the
> --
> 2.17.1
> 

