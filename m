Return-Path: <linux-kernel+bounces-154606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95588ADE3F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71F4A2831B6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 07:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 456D447A74;
	Tue, 23 Apr 2024 07:29:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b="gF00/ia5"
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2098.outbound.protection.outlook.com [40.107.92.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A10B47A6C
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 07:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.92.98
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713857358; cv=fail; b=qrRMTg/D9zc88EGP4n0xh68rZ5gciGlmaTPXv0uUspEjXMvXNZZrJn+WWREeGzl8m4RsHS3rbYde0YY6+EBwMwxqyS8AxrRDGWBkFDupne3OURBYCv0dv08XghYr4pL/MBzqBc7LuYY2BjTkGLTJiBO0oIR6tkIo+D17IKZ93QM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713857358; c=relaxed/simple;
	bh=BEODc4rGFc4h3/5V7QzRMr0ULtc2SSpbTUywrz/ZRWI=;
	h=Date:From:To:cc:Subject:In-Reply-To:Message-ID:References:
	 Content-Type:MIME-Version; b=R6sxBBJu9VrV8sLVGo9tCLS6vD1Kjcx+Wfip6Oyv4WCho2jJ8TNCffDmxJnMg29JnwefNq2ZbZIVV+HRUYxkoIyWitf1SqZD7e3bpSi0Mwj0xkhocc/KA9QsfHftAqUYq3MDyYWgRvWweCkvvqiQ9GJY5lOkBuTr5NYxQoRxnsM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com; spf=pass smtp.mailfrom=os.amperecomputing.com; dkim=pass (1024-bit key) header.d=os.amperecomputing.com header.i=@os.amperecomputing.com header.b=gF00/ia5; arc=fail smtp.client-ip=40.107.92.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=os.amperecomputing.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=os.amperecomputing.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=J+JQUppJFlkKxrPf0OcFTavAqk9zTbaRQC2tv3K2nnUnXJVV1SZ6K/FUz20XC2ou5NDXDAFDmPXgN7GHSzsXsLL0Shd+tiI5uvG1agebVgFJQDlnjTsWExGl2OVXZylczObrJTzT4tFOcJOmpEDil4sPqv2PDPXIfkOVS0vU++eEF539wrHR8sZf7uv7/sKXd7n8SCd7hwUtJ836uMAoBVAjQ3IP/8hKnJ5c/YlAT7B1htu86+Sp/sBiBwPrktqwMe7v6kqCoZSx5lhjWZh19fdrTwY0CKTfAHSAnNpujUeO9QnLUN4s0yCKy9eHUgo6sikhuYkxO6QVB3V0FnQfaw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=gOPdQV8vK19AFd8sNnahvMPmP+YuvbhOUdxjzj6qKQg=;
 b=OwAn56Z3Z3vsZ07xWLQvdYtRBqTZ+rGnT1Uc0HeUt5zBE6x2+syOELppbruIOteLvt/39O4jKZ5Y1IH9G/mrtsF/wyrDZXweFngRZLnAx7cjSNX1ucLl39drBhnbCXl6RvLMZ5EtlkMM/5L9sxK3TOPEEXI97QfMC4hxQ88HUzbIuG5K6pVdshUfnaqC0N8Z29fler7eXOgC5o6qilNOj/74id1i0ZsmR+u1kpRy186qLrFQQPJIpj6Ma4LtBckrKikVT1tSOdtpnTZurzE5/TsqExr84ezfVXsKsHhR7Zv4WulruvzxhGZw+iYsOtDw0Lbxydq1nDky8bnuw+Xm3g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=gOPdQV8vK19AFd8sNnahvMPmP+YuvbhOUdxjzj6qKQg=;
 b=gF00/ia5ZnwNIFrOZ9tC4YTrSkopvF7Wso6oVRgrbKmkkm2wzTYmxzV3yQk/rRGsZDJieBegNULAPbDWynTWWmxONIWHzu0lDx7F7tChXliOR9HsHjaRQN+YE14AX1D/TMAYOlw7m2KvthR94ppAacDzl0qP10cCnvuDy/9jvIg=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from SN6PR01MB5022.prod.exchangelabs.com (2603:10b6:805:c3::28) by
 CO1PR01MB6614.prod.exchangelabs.com (2603:10b6:303:d9::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.7472.44; Tue, 23 Apr 2024 07:29:13 +0000
Received: from SN6PR01MB5022.prod.exchangelabs.com
 ([fe80::972d:5c3e:74f3:f348]) by SN6PR01MB5022.prod.exchangelabs.com
 ([fe80::972d:5c3e:74f3:f348%6]) with mapi id 15.20.7472.044; Tue, 23 Apr 2024
 07:29:13 +0000
Date: Tue, 23 Apr 2024 00:29:00 -0700 (PDT)
From: Ilkka Koskinen <ilkka@os.amperecomputing.com>
To: Robin Murphy <robin.murphy@arm.com>
cc: Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>, 
    Jing Zhang <renyu.zj@linux.alibaba.com>, 
    Ilkka Koskinen <ilkka@os.amperecomputing.com>, 
    linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/2] Mesh PMU: Add tertiary match group support
In-Reply-To: <20240329013215.169345-1-ilkka@os.amperecomputing.com>
Message-ID: <6d2ed039-2c6a-c75b-3e6-6dac205fbc@os.amperecomputing.com>
References: <20240329013215.169345-1-ilkka@os.amperecomputing.com>
Content-Type: text/plain; format=flowed; charset=US-ASCII
X-ClientProxiedBy: CH3P220CA0019.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:1e8::18) To SN6PR01MB5022.prod.exchangelabs.com
 (2603:10b6:805:c3::28)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN6PR01MB5022:EE_|CO1PR01MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: afa7e7c6-25dd-4843-05f4-08dc6367126f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	=?us-ascii?Q?fUOhxnxupaByee26Aeqy0XeBhJzsZvMNcdJ6qN8KepLjwwCJ8W/AynCEuL2r?=
 =?us-ascii?Q?V5sps/LFvARwyDsbXgGtfPYRn5WfFxbNfIwJItbtDmDLKntM8aJvU21e7bZX?=
 =?us-ascii?Q?ITV8EG0/ajKRtDLDDzJ6QuU3ALAYxfYmDuGqS6t3bGAZt8yfyBiAekumBjHH?=
 =?us-ascii?Q?ANLTlZ6NUGli45tk3ujxck41LJKj81ejvZurXZi4SLh7Qpmc0ZFhVkgpipyv?=
 =?us-ascii?Q?cI2WlSLUvCT6sfvgJ5dbnR6x5XR2dUiCqdmysRdbzAyyiSXueiAIRh1XKdGh?=
 =?us-ascii?Q?zZ7bYERuhdjwoUUMwrLYxjUvAjiouwNdwxWZqhadKb+M9V/z4K0QjxiQWdx6?=
 =?us-ascii?Q?Iu2LVxlbgaSpMZqQO8rDr3a/0j5Q+g4/1BrJK4MmkNh7FePrVurWJb8m816R?=
 =?us-ascii?Q?0WPOztxLV3vGTjVa1lG4UgmXgvVq3+jFhjhYqVg51wzxYCpptUNZSc60BaL/?=
 =?us-ascii?Q?HT6CTtYz5YPbf0I6C/0CrIYRF0d/iz+Rv8xejST33olmCl6SIEeHcpLx/+sL?=
 =?us-ascii?Q?oJAcKT9Zpog4y5JLzg/YiZ4tbkPgi81k4BxIt8vAjx6e74Ucw4GbA3auLgg2?=
 =?us-ascii?Q?JjmNQGY0yQrU1X60vV3jYyULXanm1qncH01CdBay/xwMBYVZDj+UlPBdiz1P?=
 =?us-ascii?Q?34DWV4TXFlIcDObA+m+8vU5GLmXr550ujoU7PuCVVV3uB/jAg/t344R7EwJt?=
 =?us-ascii?Q?4TdvoqKWMQzNB7h/4tATuWPDOtwSjUPs0JeRCStSbWmXAxm/VBh1xA+ixaZV?=
 =?us-ascii?Q?+aDdYI9ea5NukJ2So7T4Gr2eiYED/pVmcErOcliqAeHxUx8hUBmV1C5APKe1?=
 =?us-ascii?Q?1OJ8VCxNrhOiiqYobZjLFAhuX0LJoIrWeOxxOU5/jc+f3RHbovVXLobtGot0?=
 =?us-ascii?Q?+jV/LE65GTjk4H+EObrdI55z5Ie8wCIKx46BzRj0nbydu+hwZIWnqCUmvVyz?=
 =?us-ascii?Q?uYiiEPrRd007C7lPLXt9m1sqQkCo9TrU70fzC7YZR+/v2H+gDTdQve3iCx4f?=
 =?us-ascii?Q?sXjKa+oKj72e1/qTrDW7r3xbwwlG6UwpS710tSBbJdCn3aUTK9/+OPC+79lL?=
 =?us-ascii?Q?qmloM1+qTU/EVu+gnneIOAAKWwVC9h5IjhoakARolWqG+sL+Zi4TrPzA3yQh?=
 =?us-ascii?Q?Y9W4e8OAOcRfuFjOP/2MroNGWZu/8AAvTZSabCKgDIGIphB744co0S/vo1Jq?=
 =?us-ascii?Q?mmYf3YRRfveokB6FgRt6+R3R+4euu8pxWmiLLD46UqWGjH02tvj5ecgniCuT?=
 =?us-ascii?Q?q1wP33glKA69RY39TBO90NPpBP34OmO3PZH4/9Vq99fQAXu2zEiPCcl9I1ce?=
 =?us-ascii?Q?LB4PSbyrpcGkVIOwIfAyKu6JHkg/YGR5zXN5a/U/KQk71w=3D=3D?=
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR01MB5022.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(52116005)(376005)(1800799015)(38350700005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?XJWD0loE7YN616aV9LLpUbQ21G8z/Iqz/iUO4uAyrmnRvaCGzM8dhGex961j?=
 =?us-ascii?Q?eleq/e8Sl9m3UVn5f33Qot+IAknFXORlqzsgmUmZDHZ6h7lbvSOJMZYHBctU?=
 =?us-ascii?Q?HrzkWQFzWqv091P3OU4d+G1rVaTLMFRkU3Y5Kn6bCvHU3pk/s1h26Xo1VBT6?=
 =?us-ascii?Q?6VgY+6MNm32jKyZo+felKMfksHjFhEXHZ2wzebAwLuVlOmlSajjTLssF6LiM?=
 =?us-ascii?Q?spJDcss9l86yJnCm6INz7Lb6QCUvyYV7TJv6JaQ0KQlqAltFOV7z0zp2oYTB?=
 =?us-ascii?Q?9IttVzwqOdM+20AQ7d14A3ccMvtcvTffSbVr8idh/KfLYOttYYo+PAYR3Y2Q?=
 =?us-ascii?Q?18Ma8ejYS29ynCbPWscy9RvsM2ErQdYoDk59RF0u91MciMrMJYaBn9FxoP5w?=
 =?us-ascii?Q?kMLvGBSWx279xq6Ez8gMBetDLXTKZrgCDL9FeBB7T8ZIZFoNDj+CfZ+k3Lab?=
 =?us-ascii?Q?UnoUIN01iEIZLmH/G4rD07i9nIhKqe29JnAnGQY6OJ+pqrj8kiJKoxtdyQ+l?=
 =?us-ascii?Q?wzDRufyGW/0U54Icxu5aILxDkcN/Uj3/8tL0vP0F8U3dDAyA7QySqcisIi2V?=
 =?us-ascii?Q?G+RIN5L8U1fbUngwshAUonNUYsIojaJFCjK/t3BXR4KPMhn3fwG90ZFJI8P7?=
 =?us-ascii?Q?B6AhQqKSHr3l63OZQ9qOMNUetIK+H4isufdRZqg8+HVzRj+wMKfme1vIPRXq?=
 =?us-ascii?Q?URZAH7nEBu7oRbficS8sVjyCWykFQu+daQ8bqKZz8Y4Dtv9xr265Xm9d9H48?=
 =?us-ascii?Q?Q6hQKPnYIcwojF6J3QCkdLZvVWy8PbJG6dAnEVMxaeLlQ51XxfaN6Om8ETx7?=
 =?us-ascii?Q?Fz30N6sGsVXu42nerQWua/1Rd7KfBld7jXiZ/lGq+e5+4HK591k6L6AjSIrW?=
 =?us-ascii?Q?+CL1Qhopa7vNI9rcpktEVe3lwJedIjPNaGk4qQX3SZBvG5UDDNIvtoO0oab2?=
 =?us-ascii?Q?Js9x0zMt8NXlQi7OFwnfMOQCR8ZaZChVG5D0cjSn3AbuYQoX+NOPn52K4Rro?=
 =?us-ascii?Q?bBHleTo/swBhQfLmbJ/HGJwDPFIz/AqULWYci9C2Myb346vvAKlAy5eMuQiM?=
 =?us-ascii?Q?TEvOSFpWchBba8ilSgwBGDmvOay88S21prOU+ybrqM4Elu1foY0T6lRZ+BZh?=
 =?us-ascii?Q?sfL3HOB93Voq6HKJt/keY+DSxHRj6yepm0VM9zIxlt/vRnYIQwXMrN34tX0A?=
 =?us-ascii?Q?hYs4NsBDbT7yfmDWV9YPmek4hujRJ0jOjymERkyC8y5YbSv4r7gTnE2aeqNV?=
 =?us-ascii?Q?/3nV434OM2Cr0Ps+RgMRRDn6v3/zwePH5GvLcY2iz4vKI5AebrsdsOc/OjxJ?=
 =?us-ascii?Q?PFh7xNyAq3F40ZVysrlrry33gnjLqdW/bySEm7zz6DEirgc7dHV91qekGBGe?=
 =?us-ascii?Q?U8gfgEIjbPthxPreTLMZdcN0eJhqf32Uic0tC9qSCM7GGj6aQBypE0Xk6hGj?=
 =?us-ascii?Q?ki4nOCZClzxrJV+KuLgcVJ0TMo03KqCdsILIMSL6mzJOS7dr/3dIQ5muuRTc?=
 =?us-ascii?Q?fEvKVBAYpjE+gV7MkPXL86iLvkTUh55iypKHuty72w5neDHy/6kIucrKkdvN?=
 =?us-ascii?Q?6XO5B4iOEI4tvqN7/f0YZD2sjwD2xT0+UgTPAPH9OQUZ+xBXDFmqkVCuUNCP?=
 =?us-ascii?Q?kK5VL+ZZG2TWbYxlt6xdG28=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: afa7e7c6-25dd-4843-05f4-08dc6367126f
X-MS-Exchange-CrossTenant-AuthSource: SN6PR01MB5022.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Apr 2024 07:29:13.1938
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: rdY4e8Ri0GWX7LUWgE1op1syr8Ktk5yftwHGlwdCHNuRwzRHq6ccnlrhCymnrqw2seJ5pWwMvdfMIbwNvRTEIgtvseR26zG18OXOyzt51itmq73ov5KnwKKgGixK2BYH
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR01MB6614


Hi Robin,

Would you have time to review v3 at some point? Hopefully, it's a little 
bit closer to what you were thinking about... :)

Cheers, Ilkka


On Fri, 29 Mar 2024, Ilkka Koskinen wrote:
> Hopefully, I got it this time and the patchset starts to look better now...
>
>
> v3:
> 	* Replaced wp_cfg in arm_cmn_hw_event with wp_idx that keeps
> 	  track, whether the event uses 0 or 1 index for the given direction
> 	* Cleaned and simplified allocation/claiming of wp config
> 	* arm_cmn_val_add_event() can't and won't fail anymore
> 	* Separated wp_combine from wp[] in event validation phase
> 	* use memset()/sizeof() when clearing an event
> 	* Still kept wp config allocator in separate functions - at least
> 	  for now
>
> v2:
>        * Wp config registers are allocated on node basis, instead
> 	  of using the same one globally
> 	* Use bitmap in the event structure to keep track on the
> 	  wp config registers assigned to the specific event.
> 	* The bitmap tracks only either UP (wp conf 0&1) or DOWN
> 	  (wp conf 2&3) registers.
> 	* Dropped the second patch
> 	  ("The patch set v2 is now in the internal mailing list")
> 	  as perf/sysfs doesn't really support items with the same
> 	  name even if visibility would handle them.
>        * Addressed a bunch of other comments by the author
> 	* https://lore.kernel.org/all/20240307230929.6233-2-ilkka@os.amperecomputing.com/
>
> v1:
> 	* https://lore.kernel.org/all/20240126221215.1537377-1-ilkka@os.amperecomputing.com/
>
>
> Ilkka Koskinen (2):
>  perf/arm-cmn: Decouple wp_config registers from filter group number
>  perf/arm-cmn: Enable support for tertiary match group
>
> drivers/perf/arm-cmn.c | 116 +++++++++++++++++++++++++++++++++--------
> 1 file changed, 93 insertions(+), 23 deletions(-)
>
> -- 
> 2.43.0
>
>

