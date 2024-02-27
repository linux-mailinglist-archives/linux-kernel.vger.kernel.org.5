Return-Path: <linux-kernel+bounces-82723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F8E8688B5
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FB991F233A7
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 05:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23A8C52F8D;
	Tue, 27 Feb 2024 05:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b="m4S6ACSp"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2130.outbound.protection.outlook.com [40.107.237.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C8C052F6E
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 05:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.237.130
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709012230; cv=fail; b=fLHvPlRMAILhaJvaJ3zk3xbLV9Zgx0kLSIQkcVJ3aC6SmMsusJVVkbCuV7g6EVLYM4uNNX7+SQmonsnbopH8s3Dr2zBVTyDqxFZfIewfj4I3MHsqWE6LQCiwOA0fDRDArrNRZhYgiZJPnP9Iknvvs7mLje5+TG2INBOisdFZBlc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709012230; c=relaxed/simple;
	bh=ibfMh7zBo0oKmEXdX93rFm+fMJTpxICb3GQdhAoVd70=;
	h=Date:From:To:Cc:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=sQPx0tqgSbk7lYScpG35lflji3ezwBvDOp39FtmYzsrXqUwsTI3xAq3UjUf8Zb77drcKmoSeQ4iCqW6gpCQGywxOpuWzy1aq2N5DPqYi9qFKHf5H7QHfYnMp2AH62mzYcsGG5H7ZYCml0fUXVc52shpZNzrUpOZtRU4r14YtKEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com; spf=pass smtp.mailfrom=memverge.com; dkim=pass (1024-bit key) header.d=memverge.com header.i=@memverge.com header.b=m4S6ACSp; arc=fail smtp.client-ip=40.107.237.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=memverge.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=memverge.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HWDHXiA4iYQrC+3r9G4o9Hd5o5ZciXPR8SEj3Pj9sgPJ2KuJed7YNuyLF0mFjfikk/qv/0H2WePvm/0IeLqWOV7EADt+uvgBYBtEdEoXrk3EIdU9nBPS3+BTQ1yR+j1SfWjJB3VeuW2yKtGKe73H9EJUN75UnOeUzZMViTouzPXaygvUMH98vHgddz4kGvzb4mD3qELEmF727TxJYgGDkCMixUwlDsJ3X24PEwH1W8o6R+evKM7Zn2Ekg7eQ7RbdkGEe4UGDpfM0S5mPNRR2EEGA+GKEgSpMl5T+X7j2KHjKl8sz8GJWscLJYAUn4zmF/+Y5u6BMaYPb9yb50VgpWg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/qE60SzATNzrZTf1m9fTXW0UQ/W8AAH7T290WFRrv2I=;
 b=NkdwHy4FaDoQQfibewrc1hNtMA8NRasTogdj6/RlPHo1A2KloTl09jWmBzErdhiOTWw4MyZyc6kttXtDEEJvfBNaQQlFMZ+1EDBcHdC+zQbe3BA3FzydLdtS4sC8xhL3Lzl6pu8+BR7wDJ3hzcKNp9aiymCxoGfB+Laya6T5n90CALGT8KQMTPO86dbSpLxxwBRw0MAqIgCS486p521AcFH15svaMfDltFrzJtOX5O/45JVwxp7B+rgKarwe23ZdI0jf9JBZUYxaUorMSHSxVe+NvUUjps1BSOjHQkUJkED+0g0PVnJ5lZl0S/0+0j47Si8ldqx3M/WZbX76ffnxLg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=memverge.com; dmarc=pass action=none header.from=memverge.com;
 dkim=pass header.d=memverge.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=memverge.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/qE60SzATNzrZTf1m9fTXW0UQ/W8AAH7T290WFRrv2I=;
 b=m4S6ACSp1swWB6M+VJAAQQ4JADlKMcREV3ECtIC2sUeYfnzwOoIpG2JOjLcOw2W91tLj0bJrakNHxV8fYXmaiK2dzzMSZAHo6qccr9yH+PMfS8FEXtzKR5LrKmm+Vx/7FF1evu0qWr/zgp/IVrGGWYyu/YVfaQwQoM5sslOH5W4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=memverge.com;
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com (2603:10b6:a03:394::19)
 by PH0PR17MB5183.namprd17.prod.outlook.com (2603:10b6:510:ac::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7316.34; Tue, 27 Feb
 2024 05:37:04 +0000
Received: from SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468]) by SJ0PR17MB5512.namprd17.prod.outlook.com
 ([fe80::6903:7860:581e:4468%6]) with mapi id 15.20.7316.023; Tue, 27 Feb 2024
 05:37:04 +0000
Date: Tue, 27 Feb 2024 00:36:56 -0500
From: Gregory Price <gregory.price@memverge.com>
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, hannes@cmpxchg.org,
	dan.j.williams@intel.com, dave.jiang@intel.com
Subject: Re: [RFC 1/1] mm/mempolicy: introduce system default interleave
 weights
Message-ID: <Zd10+G4XIrPoojJE@memverge.com>
References: <20240220202529.2365-1-gregory.price@memverge.com>
 <20240220202529.2365-2-gregory.price@memverge.com>
 <87wmqxht4c.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZdgxaLSBznupVmJK@memverge.com>
 <87sf1jh7es.fsf@yhuang6-desk2.ccr.corp.intel.com>
 <ZdygZ8ZidfaORg8F@memverge.com>
 <87edcyeo78.fsf@yhuang6-desk2.ccr.corp.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87edcyeo78.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-ClientProxiedBy: SJ0PR05CA0181.namprd05.prod.outlook.com
 (2603:10b6:a03:330::6) To SJ0PR17MB5512.namprd17.prod.outlook.com
 (2603:10b6:a03:394::19)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ0PR17MB5512:EE_|PH0PR17MB5183:EE_
X-MS-Office365-Filtering-Correlation-Id: e58cdd02-1c2f-4889-7f56-08dc37562108
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	mJpDUPBIBvurpcdCbcoFi8/WsQv0Rtdpqsj96n91r0grLWT9XXVfnK2aOWIJRJVG6rax/kmCwDvdFXTIByVf7Ech9R73bHrYbf7Fofj2UWMO23hvfPRFtp2HVTPvjZmwMHDs682c/7tHQ958+ZGjsut82dcBuvtYjL5wLsnbOnPJYIcdIIldoYWQpbHtJH/AhWtYsXmMS32d3glhRvbVn1Ns+oNgE9WFSbA+hzAO3UvSNNotxj6nFPnYSWB3zxyb20iSovsEEjcuQStsbs2NAJov3Tfm81stdBo0X+iOZKHGJ/dBK7N+5CzWIavNwz+u9bQbdtLW5EaR+qJDRp8kIDPQ0K3n5VKw8EcJhpP0oNTD93qdXs7QiNF5Ropq0KstwimOqIb3YvK/pvR6kCEBth+s97DL/EFL0YJzg4zVlSZdc2W/T9nbEt49uw8SFOz0crDdty9bylOOLy/2Y4heDCFAHKDKzVxH8NKzUvpuUKU81KjirFdSx4jul3tlhnWSzfJ9VATvISu+ntQGbOIHSpz58eJ3MakkE+gBOGuVqHuM9PdDVDsM8PCpl13lHsI7zMc3vxLgrOnhPxJSJBTutSwhjf1mhGzdSTBthlgMaPlO5UpjvmEiaJkCoZEp8jgMAmMjEU+pxizXs34PCHSRcQ==
X-Forefront-Antispam-Report:
	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR17MB5512.namprd17.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	=?us-ascii?Q?wcflbr0mrgJ8UcSFqL4RYiIis3sxQhAX6miXRbbjsiW6tdxZuOq6VPvW+R7V?=
 =?us-ascii?Q?Se1xk6u0+ugGY9P/nrmcNEFuAOudlVZqJh5J5lTH0vsCs88816fFddxpCT/N?=
 =?us-ascii?Q?w9Dlj1yA+SCCSgEu1f9yNase8wY+FIY5dksJf6ikuIpnmuzQqB3yTd9Xn5JL?=
 =?us-ascii?Q?qeoourg+MOo70tVCppwana33qzlUDrfaZqzSrsBF2BU9Yn4JMgXuRfNpnGm3?=
 =?us-ascii?Q?n4Jy4tPqTsKFyMuv+ax2JKVNP3k5LfGWgJzSb0I3R5kJy4DshDCDmjz62gEC?=
 =?us-ascii?Q?rG1wlED7CZQeUX3G74igcyAp4wGY4cPrxm9pUuMgIcpLEfFrTVkWunCIPgTQ?=
 =?us-ascii?Q?nkko6aTIvJP2bmhWnCL/rhacZARf1nilODeR7+4I9OACvWf7We0d35Rd/TKh?=
 =?us-ascii?Q?RYzJ8iNmZvRXimGPMi01mjpXg8+A1eA6f7narSXOW5AN3fAFLGxXSrIHDPm4?=
 =?us-ascii?Q?9vNJn3xYG23UePEVm4GVoP1nElqqIdXKVOwg0XQVmQwPuL7Abp51p4jw9WDa?=
 =?us-ascii?Q?LL0YIg7oqIM+yjkWC2oFB6gaxocty7PZ+QwCYolmhL+lMYTb3CRDwVO+wX4I?=
 =?us-ascii?Q?6dB09OAoj5NHcSQnadxfnIi6Sy0EeisDAgaZ5Y4gizw739MJkrW1lGZwMTf/?=
 =?us-ascii?Q?aEebTZ88Om6yTUvlmlwZh1BbTmldAAkP/W5rqcPP1HOVVPGiu+9jDaPmuWlZ?=
 =?us-ascii?Q?7aVBYDZ67+y6TBpDROhD0ICSULnpAtCLT/9qtT76p2ECgTXBwvreBui9ggMc?=
 =?us-ascii?Q?jrPEoD46B55acB2vdSTA55JA54t3SAB6AuGqqmhWSLcTErq2Qy+e6XRleivJ?=
 =?us-ascii?Q?pOt/yvahkdl9dMhfHB7Wecv9EMWDf0KG46sFahJhVR8o8e1FNrRrP6ygASKh?=
 =?us-ascii?Q?aGAAFLbBLFkpF5wlZzWXCoXfOIxusj6aRKl50PGqQw0FhCF3jASg0PsUBZNj?=
 =?us-ascii?Q?lOPH5WdShNzC8hyi0+SRxxqTv6+6SR/z0So4L2BxFnodF0Pv39316yRbUFIp?=
 =?us-ascii?Q?38JCN8P80HnhPM/o+PUjE3bMAgrMwQ7orZHTQWYvKbLh2ilf9cGCsSCRB+8Z?=
 =?us-ascii?Q?LnH7GD8ONX62AanEYHeQvnmMrgOkQhQ2Un05LaL0EY5KNzx5CM9wtL8RFeNr?=
 =?us-ascii?Q?cNB0s7vuckTed3NkDMM0d2f/+2jWtLzyvALcfywW1D5Jt+b5nkTU9aw9rWdC?=
 =?us-ascii?Q?WQZrkMjdLGS6dNMamHNtAsEDF1icmhMbtWuTnW6ZZhU/fLVR23sPbt6wU+vd?=
 =?us-ascii?Q?PiSMcf7uYEFDLeBSYjVWxHg1b/NSHP3UuYi1xZu3EKV6hC6wEOAvP2kDA4of?=
 =?us-ascii?Q?k7fw5Dz3A8K1QkLNNvwZUb46DTnPS85WunOVTOwE6VIcWoMyIIAeZfyPqe2G?=
 =?us-ascii?Q?OiE69afJ2GPgsQHmFJMES3acBCcFTxB76hguBjeBgekODkvZ+hneXRFMihbm?=
 =?us-ascii?Q?eku4IIep/F2ZhUWLYVHhH/S6rVBGFNv6upFCch8+VDSfjXAPMPONOgyO7WPl?=
 =?us-ascii?Q?L4f1U0AOaXJm//2qwjEaQEdy9Cjp9vOxSY/ZZdAN62DH8FC8Rzq+fFw+pCwp?=
 =?us-ascii?Q?C2rGPN93tWbyxGsG/20zS+bz+fhZ6d2++rlyE2SLwH+AVq5EpMnZnVDcY4T3?=
 =?us-ascii?Q?XQ=3D=3D?=
X-OriginatorOrg: memverge.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e58cdd02-1c2f-4889-7f56-08dc37562108
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR17MB5512.namprd17.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Feb 2024 05:37:04.3699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 5c90cb59-37e7-4c81-9c07-00473d5fb682
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6pcQVdkb7kpxrFwGo/EPLWqz5gfdVsRog8t4UK9qOvzaEimXrbHjiJsKVlthcgbnTecpqKKMYhsB3Sk5+Zrof6i6kryH5vLC6LmVUWeGflg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR17MB5183

On Tue, Feb 27, 2024 at 08:38:19AM +0800, Huang, Ying wrote:
> Gregory Price <gregory.price@memverge.com> writes:
> > Where are the 100 nodes coming from?
> 
> If you have a real large machine with more than 100 nodes, and some of
> them are CXL memory nodes, then it's possible that most nodes will have
> interleave weight "1" because the sum of all interleave weights is
> "100".  Then, even if you use only one socket, the interleave weight of
> DRAM and CXL MEM could be all "1", lead to useless default value.  So, I
> suggest don't cap the sum of interleave weights.

I have to press this issue: Is this an actual, practical, concern?

It seems to me in this type of scenario, there are larger, more complex
numa topology issues that make the use of the general, global weighted
mempolicy system entirely impractical.  This is a bit outside the scope

> > So, long winded winded way of saying:
> > - Could we use a larger default number? Yes.
> > - Does that actually help us? Not really, we want smaller numbers.
> 
> The larger number will be reduced after GCD.
>

I suppose another strategy is to calculate the interleave weights
un-bounded from the raw bandwidth - but continuously force reductions
(through some yet-undefined algorithm) until at least one node reaches a
weight of `1`.  This suffers from the opposite problem: what if the top
node has a value greater than 255? Do we just cap it at 255? That seems
the opposite form of problematic.

(Large numbers are quite pointless, as it is essentially the antithesis
of interleave)

> > I think I'll draft up an LSF/MM chat to see if we can garner more input.
> > If large-numa systems are a real issue, then yes we need to address it.
> 
> Sounds good to me!

Working on it.

~Gregory

