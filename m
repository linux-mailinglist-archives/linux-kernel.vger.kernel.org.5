Return-Path: <linux-kernel+bounces-70048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC45859247
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 21:07:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 357541F225D3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 20:07:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 057C67E59A;
	Sat, 17 Feb 2024 20:07:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jV5B4/wq"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FA2320E;
	Sat, 17 Feb 2024 20:07:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.16
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708200435; cv=fail; b=lxGODBCxQGFc+vGDb2aib4XwAOXXrRIRDrYibrAGcXGDDQfPtlg1qvrZ6YAaA1SXs3aqMIJ2ceKGXgR93m1BlTaDEbJ77k6g5m2mqIhWJSEZ9WijnH6V5YNQ7LRE2z/TriIc9qgkygrqqs44jKjv7coM5pFJ9Rc+uOVq/iWAe1U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708200435; c=relaxed/simple;
	bh=LxlyLm1nZ3OObtRmTARka1XnoTJhYT/jasDJc11gYrU=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=B74vwDcBYIsGNQZg+8p+xGee8DrrkAfNgo2fuMpkoh84lUFumhGv93by53Q5+RHLPnpG1/EQpu41O7VlRiNsCpEdfwIQAlOCA0DeMFjjLMrtC3GfRnOsQH1UBeVEiOng1dmDJ6T2YemPbmEbl8x1sgHcnnMeunyItyOeYQKK8aE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jV5B4/wq; arc=fail smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708200433; x=1739736433;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=LxlyLm1nZ3OObtRmTARka1XnoTJhYT/jasDJc11gYrU=;
  b=jV5B4/wqhTsqLWY7oTPyHCjeoWq2FyrL33IgsmuJ7SIbVTGOrXKn8OxN
   aoEHU1zBzDJl3Loz4BwffZupmY0ut+vafbfuwDDLsaHC/pbphhO/r//BE
   4FYJtI7TZ9e8r6TDVVgZ5tEt5/m2oOEdFyEO/npnXuG6/BdDEPK2NIP42
   28LYd0S1y3qvToxZHSeBRRutTlyERSihkFHN4O6TaLILwR4XBMTu10wXd
   7kMDF3Q4HFJ81Rir3cduTP4H7LIAN985BcnI/hpl1pF8mRTt2fa8PTyAZ
   3nC4bzZ4ZicbhCjH9Zl/agadM9oiYmwhK9Xd1SHoT7XCBgoPQD6NbKj9z
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10987"; a="2732237"
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="2732237"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2024 12:07:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,167,1705392000"; 
   d="scan'208";a="4035520"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 17 Feb 2024 12:07:12 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 17 Feb 2024 12:07:11 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 17 Feb 2024 12:07:11 -0800
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (104.47.73.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 17 Feb 2024 12:07:11 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R4ULmqMNYcKjNqPZYrHy2AnaEPwi3HseqOJtzaHWxvjzvj/8zPGz85piFGEQ4zopbSylA46IcdFFLjPn/eIj1doPrtJwSlOCrY7zM/IWzt5GZNNCU6WstcLdAk62RNYCBPXlyKSsBrEalKfrfuSuSTquq0NtNvXUDOOjGfOUArWQaPpkQw2QkIhGGWN5zO0w5PDmbYLJtIlq0t4kQS3ll/a4cRzwVfWZt71bNkOilpMI+xKukRXWDzcP6oZOUVCT/VBj2KUv/uHBMKa24lnLZVIIOLQ8jyd+9Q7axGPTp6l6Jw1LtSb/5+XVEwUC3PuFzPyCwtQHYbbY5jDVvSrugQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=FpyAluNF+97rw6ycnTdy16+TIKERdPsBpv7Fmtg5knU=;
 b=IdBmErfn6wu/AIO2h8D6osWikOwzFcf8742Y7EgHNAezJGtn5KY62EIISZoqRXV9ARcNSfmtCz/ejQ7swgjoTREboLynTNXzM2/AQqOneKTIYsVQWNaUTmMsveVF0fp6Q+8Ev9Gld9EjI8y0he2D2/ln9Tp4YXeTMU61uGGz+K88h+z/dTgK+bGRVlxQJau0GxZQGfKin/ivnEEILnfA0y+/Cwd7dVRSHY8UOfNA8pYxvOMPMSBML+56OH0mohqtaiIhtmKNbaDAJ1FmhFUZx2kDb5iiM+hIq+6ojjIFqsy5rMuCqWnyqBqwz/6d7xcrSAOApgE8W9ytSn0wFa3tzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SA1PR11MB5899.namprd11.prod.outlook.com (2603:10b6:806:22a::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.34; Sat, 17 Feb
 2024 20:07:09 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7292.029; Sat, 17 Feb 2024
 20:07:09 +0000
Date: Sat, 17 Feb 2024 12:07:07 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Jonathan Cameron
	<jonathan.cameron@huawei.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>
CC: <linux-acpi@vger.kernel.org>, <linux-cxl@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Dan Carpenter <dan.carpenter@linaro.org>,
	"Ira Weiny" <ira.weiny@intel.com>
Subject: RE: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65d111eb87115_6c745294ac@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
X-ClientProxiedBy: MW4PR03CA0170.namprd03.prod.outlook.com
 (2603:10b6:303:8d::25) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SA1PR11MB5899:EE_
X-MS-Office365-Filtering-Correlation-Id: 36498544-3339-4f38-184f-08dc2ff405bd
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uJO+KqrEHDoycPREhyzXNNd+eHM0ZA3ZPBZi0GAia8GocirvnogVl1fvDdG+zvcJsGUu6rMvvH+3GfV66n43TaJWn0lVl+yWEPsaKMNnMMn7bG+9op6mmnwhBE8U5kN+4EKes0NuJH1BDymgs3Zp9jNC6Mmnoh4PXpVUcc6O7fbFbPgftjU39zOmYYFtmpWl1XyIUMIOnH69WBckPO9vL9vjaPyctmrAWgF4/iWJUlbSBwiZe4/+oNOKTDMQcWJZ2FhTAqjhkxkTlUcl9OBv2uArkGtF01SI8g6M6ah2Hn4fmNXLT4eR7T7DdXJzsp/Md4pQ0wJjBP247ED8+Zat0x2sPWOt9wjTKpYp1tKcThO+4KumcfyvZQWHg08WKTlL9xwBUoRkzU3GNyjZ5U8VToMHJydgrOfYw3p0G2YLTZtpo8QGauwkS7zMpPFky7r05TWugl8hOi/KkuMBd/MKuVScpQ0CCJxqxTu+FjvWhduXZaAUpf9QvPofNYg866vf/AcThHuTHyAIZbBpSIv4ZgdF4ZSLphUlmRH+D7aOyFE=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(376002)(346002)(39860400002)(136003)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(5660300002)(2906002)(107886003)(26005)(478600001)(9686003)(6512007)(6506007)(6486002)(966005)(38100700002)(82960400001)(83380400001)(86362001)(66946007)(8936002)(4326008)(8676002)(66476007)(66556008)(41300700001)(110136005)(54906003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?NEhJPphCG6aKOJ/GSdRtU99HrHMFH9+ecHfI1wlF4ra3ECVsF+hD9akdTeO7?=
 =?us-ascii?Q?A9GGq5KQEtbvdm4mXr4EeqOf0Uivj5Hxvqu0RHE/QVNBtHjFeOtZ9IzS/JA2?=
 =?us-ascii?Q?89PZQq+Gj3xorqVunMZYCuc7VRwHuU9+pCNk9TDJiSBtGryepafMv/cdiuAz?=
 =?us-ascii?Q?ZHpiPHJX2eXzvgoUIXuEHSWj4cyl0PjhkFltu38apZUAuIFzGIOeEoCOX3oa?=
 =?us-ascii?Q?P1TrhXLP5Vt2fUAnrJ+aDh5w5IS6Mq7r3h4pTTqEAsHLfIbrG05hmtsuQEuu?=
 =?us-ascii?Q?fRsN9pgtYl3p0Li3+YgvOtKWVFiCKOhXuOA3MoV+SygOLRoM03SdwM0BI6k9?=
 =?us-ascii?Q?/lmHcsxRjNQMcedre2vAYbntF9O4GwQKfOVGNxaReqBhdFkfCNSEL/g56Fm8?=
 =?us-ascii?Q?jqtFp7ICMxmypTTcIlrqrGphn0FYk5LFURMeeV6Te2rqAVhOYwciFqAaovUQ?=
 =?us-ascii?Q?bzdGHUZeuwmaQc+6onV1NFq2y03KggX4kL6prqKTkfLF0s6478LZZVd6DBdZ?=
 =?us-ascii?Q?UXURAY0wbxGUnQ38VDzeCsZaEPs+TiWxYDz2dcBM3bGXVhCFzkL2Kkns4zP2?=
 =?us-ascii?Q?dwE1e9LQ7dPxynz2Iapx2vY8gS3v6t01+hEaULWQLsLW6QMAv9vMEmFVz2Up?=
 =?us-ascii?Q?6GUyNxLK+1n27pLtFaZEkRjhxQ6Fwyjq0/yLbzeQ2/neqRM6ZzKS5d9/mm2s?=
 =?us-ascii?Q?z6Kjl0chAmGzjFxmEtUg/oPkwL4lZIafrM/zdQ17Ytn6FQK1sVxZF9ROLx3I?=
 =?us-ascii?Q?kqQspIlR2o1DciwKxg+mkrZt/QSnYPgRnzgkFoeFRRZyaWF8QsaJ/rkINFe/?=
 =?us-ascii?Q?OHY6MJAhnybUMziLEnJUwsVg/ktRvxk1STeFbyzNoE6QPQ4fEi+tJlXdyziY?=
 =?us-ascii?Q?fru2VJOeIuG1UOLGTkfLckl+ro8gQQ5QjLrz8RInkxdQg4xxDK3XQP9K5Ftt?=
 =?us-ascii?Q?RPADgDLBUglMdMr6uGLEZN+1BXL+oZ6o3JHmYatlQdQxZhE7LStnWDf1FiDB?=
 =?us-ascii?Q?GBva9nfIdcjqDDhyp6vfGhTCZPYBIKElahCnie02klYB8jn5ce+Yy6JR06tt?=
 =?us-ascii?Q?B+DJRQCzSewMWWOv7ec9tWjCudhXHK3j+iDzmlORTOiMLcSuESO9YnEsoXkD?=
 =?us-ascii?Q?ydFrgHdvY9Dbs/SvTkB/Hb4b3j0gxlIs4EjDpScIwi0OOGSvpW5W7MYKfWQ1?=
 =?us-ascii?Q?6Xr1SCcWZwxBnN66Vc2edjef0hn1a2uZRx3qvV9iLB1XNFl7p1a2jYrP6V/h?=
 =?us-ascii?Q?5MZW8wvx9PSwxTMl+neIg9fNzTR9J9bKVOQSilI6S+fv4AHyocv9xfqAuwUd?=
 =?us-ascii?Q?7GpTC5UBTnnEQBa1559QQTPpYujrcEVZa5uW7TNJhnJ7nTHHDlaJmQnUndCk?=
 =?us-ascii?Q?gd7h9DBUn661h5FeqTRxLZ1ws3oCcpK/s4k6bGRkV+0VGUuj8vgbRuUvl5Hp?=
 =?us-ascii?Q?Ryn8ZWr+i8UMQ2X0MqKPG8luGqw283Evo8cZKNbCCS/68u+ApjsQD8XdJTEu?=
 =?us-ascii?Q?CVXzFQrflnrXBRYNbvRJByyYk8YbpSkvMeCRSeRClTofJqHqX/sMdLT6X97+?=
 =?us-ascii?Q?PwZDTTaqR7j2UaQAYdaocGWW7rXGfvftQfWV+bZVpq0Mkox49KnZDeRjth/u?=
 =?us-ascii?Q?4A=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 36498544-3339-4f38-184f-08dc2ff405bd
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2024 20:07:09.6078
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: XPoDKkMFLaZPfppM7kCwxS35nn4N//4A2q9rr6Kk9aRxrum8bC3KSzRjbv7ef2BTKqJd5F4A5WdBAB4eYpGZstO1wekWkdCAja69HWnpkcA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB5899
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Smatch caught that cxl_cper_post_event() is called with a spinlock held
> or preemption disabled.[1]  The callback takes the device lock to
> perform address translation and therefore might sleep.  The record data
> is released back to BIOS in ghes_clear_estatus() which requires it to be
> copied for use in the workqueue.
> 
> Copy the record to a lockless list and schedule a work item to process
> the record outside of atomic context.
> 
> [1] https://lore.kernel.org/all/b963c490-2c13-4b79-bbe7-34c6568423c7@moroto.mountain/
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> ---
> Changes in v2:
> - djbw: device_lock() sleeps so we need to call the callback in process context
> - iweiny: create work queue to handle processing the callback
> - Link to v1: https://lore.kernel.org/r/20240202-cxl-cper-smatch-v1-1-7a4103c7f5a0@intel.com
> ---
>  drivers/acpi/apei/ghes.c | 44 +++++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 41 insertions(+), 3 deletions(-)
> 
[..]
> +static DECLARE_WORK(cxl_cper_work, cxl_cper_work_fn);
> +
>  static void cxl_cper_post_event(enum cxl_event_type event_type,
>  				struct cxl_cper_event_rec *rec)
>  {
> +	struct cxl_cper_work_item *wi;
> +
>  	if (rec->hdr.length <= sizeof(rec->hdr) ||
>  	    rec->hdr.length > sizeof(*rec)) {
>  		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
> @@ -721,9 +752,16 @@ static void cxl_cper_post_event(enum cxl_event_type event_type,
>  		return;
>  	}
>  
> -	guard(rwsem_read)(&cxl_cper_rw_sem);
> -	if (cper_callback)
> -		cper_callback(event_type, rec);

Given a work function can be set atomically there is no need to create /
manage a registration lock. Set a 'struct work' instance to a CXL
provided routine on cxl_pci module load and restore it to a nop function
+ cancel_work_sync() on cxl_pci module exit.

> +	wi = kmalloc(sizeof(*wi), GFP_ATOMIC);

The system is already under distress trying to report an error it should
not dip into emergency memory reserves to report errors. Use a kfifo()
similar to how memory_failure_queue() avoids memory allocation in the
error reporting path.

