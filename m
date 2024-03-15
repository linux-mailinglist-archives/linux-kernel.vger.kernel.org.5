Return-Path: <linux-kernel+bounces-104754-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E2BF87D31E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 18:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 123461F2459D
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 17:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC3D4CB38;
	Fri, 15 Mar 2024 17:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="enQBXi1/"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1AB4D9F5;
	Fri, 15 Mar 2024 17:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.14
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710525214; cv=fail; b=ukAd9a7E8TRJ46Bu/MMmkeURMXee4Nmy3nSGvFkLmaMH/XEyIDj+XIygf9n4DmpMETNvBjngsis4ugJsxcwfR6vkjrheO93SfjOIW6koZwBT3WcCevxq/l1tuTfC48Pqz6aH4t79/0rIaCJNff6/1unre2w8jOb6X/NS5OiWhdw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710525214; c=relaxed/simple;
	bh=sG7v8Tvc3L8f7AkBp2U1BOfrcpNLhbSo71waDW6TdgQ=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=ix7aWu65wd+9n/0tLUyAScLVROIm9pB0JZ/Xg0rJVuQBnrvdkp1PYGkzFdlQGXZAmP0kMsb1bwFLZvgLWr5xPxTsbO8JtWXIHEPTKaVuS7NpX4PV2/bcjih8TCK+mKw/KQ5Xyabo0bQAJrOYl3t9DlC1E17WUPiIAjgBtQKnpYU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=enQBXi1/; arc=fail smtp.client-ip=192.198.163.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710525212; x=1742061212;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=sG7v8Tvc3L8f7AkBp2U1BOfrcpNLhbSo71waDW6TdgQ=;
  b=enQBXi1/p19xRrdEGMhMs/TIBBQFP8JCxc+mGqv4TxIWkCPKTeQp9AXH
   35lAReFTKh090yMn7uH9AcqfdZP8zRGrKNguh8g9vvaClni6gkUVa+lEE
   mfO1EBSKNkR8HwwYEYNP/lDvKiKuBryT3hbQG3M5nFBrA/zI+XQIQDVx1
   OdHGo65PhoaCiYweeAGNshRNMgUQPE1Ca8ojAN3chw4+Nd3QGcFagN/OE
   AvDbpI8yF3qrcwQa7YgN9kMbPFFibG390tdU7XHhWnFha5z61D4itJQ7t
   hxJUoU8z+N2HhewYCGZEdgEZUHWAW/isQtEyk+A3/hY7ZMP57sTjxXgXq
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,11014"; a="5616603"
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="5616603"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Mar 2024 10:53:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,129,1708416000"; 
   d="scan'208";a="13376178"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Mar 2024 10:53:30 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 10:53:29 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 15 Mar 2024 10:53:28 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 15 Mar 2024 10:53:28 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 15 Mar 2024 10:53:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=K7QVymP7O3jSoQAVQY30jBAGJ2HSBDHmD75KEXg52F3tYSj1qOt9HfcewDzOSzo8FDXyWfA/n1oZCh3wgQsPJrTdS15rA/lB/4Xq3ShgiY/8d6N4va/+VX+dILDAeCZLzpRzqBRxSmrLpi1g3CyR5GJiLF2G7Mu+XClIGFlIiqjFG1jzAatdT66LLc13Bz8cklTrTzcvcwMwtktElfMarUqfwSAtcNK+IaGMH2/7/kbAceQS6J/2GWcf/1oWjY06JZeiGBeFM+/pUDfIny2j0wPFY+2tXSFB9XzZ0OmzXxX6JoEzH/0duGMvdBj+5ZOX9l2U76dFVvBGHfbq0ljFpQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nn5qRWNbijO8F0rAen9hH89RXuk1Wr0mbtf9aqXXzjg=;
 b=U50dS4zaEOa80fNqXnQABJzPpAibBh3g+/hlJasYPKE8qAhiTblPR9P7RjYEaOE260XdEtdmXNNb+8VC6qJWjaRQcrId9qcOA7Fega8jPp+WDTnka9T4LGob3c1LknNDf0SZJEGd7DbSiXwYSbwDsu4Z/ZJ/t/nIfZSss4CBmfeYnImXJwwaJeVbFxe10twbmEuYgKK35KNBeDHOsFpZ8NVDssVTAQeYrOnYcazlG4G8b5046zUp/+4K7GT38CyvRuR2OIIdDFVcof6naDVdcvNyB+MVXT8DBOauYwRJ22MkOwLOCC7YPHNQL7AvAFV1dnqjsHi/ZX8vyIZZSuTqjQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB4816.namprd11.prod.outlook.com (2603:10b6:a03:2ad::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7386.17; Fri, 15 Mar
 2024 17:53:25 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7386.015; Fri, 15 Mar 2024
 17:53:25 +0000
Date: Fri, 15 Mar 2024 10:53:22 -0700
From: Dan Williams <dan.j.williams@intel.com>
To: Yuquan Wang <wangyuquan1236@phytium.com.cn>, <ira.weiny@intel.com>,
	<jonathan.cameron@huawei.com>, <dan.j.williams@intel.com>
CC: <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<qemu-devel@nongnu.org>, <chenbaozi@phytium.com.cn>, Yuquan Wang
	<wangyuquan1236@phytium.com.cn>
Subject: Re: [PATCH 1/1] cxl/mem: Fix for the index of Clear Event Record
 Handle
Message-ID: <65f48b12b5b2f_aa2229419@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240315105336.464156-1-wangyuquan1236@phytium.com.cn>
 <20240315105336.464156-2-wangyuquan1236@phytium.com.cn>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240315105336.464156-2-wangyuquan1236@phytium.com.cn>
X-ClientProxiedBy: MW4PR03CA0136.namprd03.prod.outlook.com
 (2603:10b6:303:8c::21) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB4816:EE_
X-MS-Office365-Filtering-Correlation-Id: bec1713c-6193-4b40-d624-08dc4518cfe8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: j9eythMStI5klL3Prdu0SkE8KV26WGpCc9aXf/uQSAJF2gQwTm61/vCaW9JBvdvODpTFl5hv838MlVAffZVbhzgZ9zXqFb4s9hgIeZ9cB2fGxh2hh+S+Jd6xNkFZQUSVnJ9LF6RPluVyMHFaOHZ2VuJiDoZuxSGa1NcxudFwtCJUE3JubLvIe0KE82WDkKy+2y17JNywoozZH6IqafujzQ1MJQIPMayS9SmJkSOkXKp29VEPSkYuirwUb7ihisNAL+LEhOKZ4daJfpLhdo0eH7oMVdPZ7eCzK5QAmPm+U8ZLLi3pKvDV4xYuuZ9JbphqWglw78UtmIZvByQlY9LVwwxYgG7REnLJZMErDBNUMuVOUitJeFsrTtLllVaIO/JyYD1DeqQ41e7NMHKlL4vrjOvaAUG7eQSvjtKumCuWzKxwsj8KNPqzINV/fBnzxAO+KKx96V2hYyBCNmhgDZ0b7rA2xPErKaAE0g+6+/ZlaI6yDyh5n+wi+tXRzuv7c/5MjsRLQvzlumtDI9GlnaUbmHbLPwD9DGFtpeT9fxHMZOklz6DCk+9G/EIo8TbIV74BrNKc6oXEw4cBJibwXfm6UWdoGKXEgDSTqoqtt6M6EdhwZEXIBKgzQXwleLwnwUD3Xo5q+qwjxohZi0tw9uLyg11KRQEVvmqVRIkteeeCDok=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366007)(376005)(1800799015);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?dOrxr9kRwtl0DuDwt/q+BvmfwJyfiM4LqghaBv2AvAMqRkPXUlWyC6tHiZbW?=
 =?us-ascii?Q?Bb01orSRvI7ZFvR+ecoqZWxa3pnM3/62PR+UXzHIyWj/uRv5qmHBHK8GoYJo?=
 =?us-ascii?Q?J/MjQREy/LA/pqg93vBw6wVOuBTNAdddSUCHn4tY+dRekxXhVOHwwE35tNuA?=
 =?us-ascii?Q?L4VAdDngQBgzFRDnyCjyQ4wC9d7U9v6Gxs6CT0ocTlr8HXDd5QI4N8yNue7K?=
 =?us-ascii?Q?vFz+Ruaa1viLOWTuOdsbCe2Ch1RR6XRg8AAKsB0o+7QqndOMVzCVJjJCHOL9?=
 =?us-ascii?Q?OldK+B40vbfE/7os0kziI8gwcEyt3ZHKldjHmfh8Q9Oq7PTdGHX7ebgrW6mq?=
 =?us-ascii?Q?UnK+OLTmIN4CkG9LZraWAV3aHHKHvgRi3DVWFc3TmWEZO93jN5sW6heWrAu3?=
 =?us-ascii?Q?MRfScowyc2Db6SRjxg+17t4rsPKDNCCSCf86wuh0tU94xeWkPRkp6vIcQnsU?=
 =?us-ascii?Q?JGjWmVa6wnPdcJ2IBJTi70/bYz2jBAMRu+R+4/Pkf/9c0l8kBSHtnTL+RLla?=
 =?us-ascii?Q?I51OJ7eBPaBiC0dCdD73VhucyGwd79DbdRbh4s/M+gkWQOm4H7O9Jq0VkaCE?=
 =?us-ascii?Q?iJlToXU7nwYwSlT4P9M/lEN+eU2n1YLQJZrjU+TuJWW0eVKLOJfbDzWr733i?=
 =?us-ascii?Q?qien0/8rUw8YZpo1oLEIH+pD63nK1ZYshMx5X9WGLaczHdErW9CvWdchul2B?=
 =?us-ascii?Q?+t2XmQ3dScrnYb85bKBMKd9pycV6Dat94Otbgdwzo8UHRQ+3UVP4ne5dGPQA?=
 =?us-ascii?Q?FR/hYDpeWOBC0mLJg9ZYQ4yu+Iw0vc+ab6NEi71qkng7DMiIGpeFdPY0+Vtp?=
 =?us-ascii?Q?AZc+KcioXuHxBIuR9p3KEg6ZjN1O4+zlJBSrdJMHwqeJ5wruA1lB47lGZFgz?=
 =?us-ascii?Q?WRQpxuHZCAqdOsE95SJBu/Kn+JxDbOtBEIjU7ShYNf8VroonXAOh9FzdO+FC?=
 =?us-ascii?Q?b1sOiMdaXEF9MzFbySlkDMuWT/3AmgqnWV7b5AIMHnI7pf8qfXyWCuxPumik?=
 =?us-ascii?Q?ncPqV3xeSAddJbUG/o28X3HznmY1V3UQeyjH5N9Ze9CFROtaAYsX7kclRaPn?=
 =?us-ascii?Q?q0XFVF/iphSa4xDAkPb6jHrXQ2sSu+NBdY9yLVFtuKH3mZGtVDdSR3FCzTlX?=
 =?us-ascii?Q?1cKAwhJ8Qfcl4NVCm7oWi0Y77tBcY5fxg+kVYuLD01QbymeCOKR/Y5jFeVFn?=
 =?us-ascii?Q?BHNhJgzumsjelifCkzSwdeV01TFt9TAoXW0uWsM151PZaFZ+wm1W3CmxKlQq?=
 =?us-ascii?Q?aMF3M2o0G9qPnxoB8oAPEEj8CqhFgxGa/ZPWWprSwsIfTDWCxF3bdNSjVxPZ?=
 =?us-ascii?Q?8Ig1+O7lX2MRY1wQUDXO2bF7+uYDlxg5n3FGRFeag0Krng3hwUm3qdsaKsAl?=
 =?us-ascii?Q?TRu8xRk/tzXPJ9Ir0Acvv3Vp+6DwTYCZV/zM4MyJdM39f5l3kZay+NiWxUss?=
 =?us-ascii?Q?sLbMSF8E6G3ZkdWEb5ppvI+fiyPn1OOuzMa8A34FH/07bYW8UaWyCGpNCiPg?=
 =?us-ascii?Q?KTt4NSkAMbf5pSSq64hGSAOqHtQg4j/162ygDFFfVXbuZ28LGTKLtT4/jSD9?=
 =?us-ascii?Q?WCm3ZNnzJ2W2iTqDBwfE7E/x/p8hXxMtcChZZgd+RJhSIL60WsdoRUWOB7Hx?=
 =?us-ascii?Q?zQ=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: bec1713c-6193-4b40-d624-08dc4518cfe8
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Mar 2024 17:53:25.1011
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: fmKbfjNK9Jc15AXQ8k2aWZ+TmXasYZ964BgaTcC2G1xfVPBgUPlx3SusmAVdNwG0sD639VtbGzSLAvcB8tgb4OLrSRtrbd9QmX1JGxmty8s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB4816
X-OriginatorOrg: intel.com

Yuquan Wang wrote:
> The dev_dbg info for Clear Event Records mailbox command would report
> the handle of the next record to clear not the current one.
> 
> This was because the index 'i' had incremented before printing the
> current handle value.
> 
> This fix also adjusts the index variable name from 'i' to 'clear_cnt'
> which can be easier for developers to distinguish and understand.
> 
> Signed-off-by: Yuquan Wang <wangyuquan1236@phytium.com.cn>
> ---
>  drivers/cxl/core/mbox.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index 9adda4795eb7..3ca2845ae6aa 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -881,7 +881,7 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	struct cxl_mbox_cmd mbox_cmd;
>  	u16 cnt;
>  	int rc = 0;
> -	int i;
> +	int clear_cnt;
>  
>  	/* Payload size may limit the max handles */
>  	if (pl_size > mds->payload_size) {
> @@ -908,28 +908,29 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>  	 * Clear Event Records uses u8 for the handle cnt while Get Event
>  	 * Record can return up to 0xffff records.
>  	 */
> -	i = 0;
> +	clear_cnt = 0;
>  	for (cnt = 0; cnt < total; cnt++) {
>  		struct cxl_event_record_raw *raw = &get_pl->records[cnt];
>  		struct cxl_event_generic *gen = &raw->event.generic;
>  
> -		payload->handles[i++] = gen->hdr.handle;
> +		payload->handles[clear_cnt] = gen->hdr.handle;
>  		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
> -			le16_to_cpu(payload->handles[i]));

Couldn't this patch be much smaller by just changing this to "i - 1",
because from the description the only problem is the dev_dbg()
statement, so just fix that.

