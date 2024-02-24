Return-Path: <linux-kernel+bounces-79808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD55686270F
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 20:43:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1C2C1C21178
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 19:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85CD44C637;
	Sat, 24 Feb 2024 19:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="P1/Cz5I6"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7570114264;
	Sat, 24 Feb 2024 19:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708803791; cv=fail; b=r2PgDJJidg2oidr5t5cQ06OVf4rpcZTS52WK4yOyL1MjTMqS7Brkilz55u4wqIH3keosCWzTRnk31ACsFBacWPeMSYqlnjEj/ddMdRGBQEBQAlEq6n0m/EMZmmiNuaP3sUyF9XB3Tei4zmHe9BSrPtuQ7qdvdwW/YNL/zblugQA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708803791; c=relaxed/simple;
	bh=r6J8VvP5sZu3QfnY4xLIcDYJhDHkp7mKCtQnavhhvVg=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=CRnwyzP/r6Eeue1VA/1kdhS+9hLMGAgEG/eiMeH8q40qNYLvsPJwl2ZEcph9RjI4QaSeah4JhsAAJxwRW46abS3eyHQzYy7CeQ4WDCgLzmLMLrAZGzpPGbn56L8XJbBOeRTZLtBw9sN0efF9YPV6mSx765e7OJGmqO0RbxMNeKo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=P1/Cz5I6; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708803790; x=1740339790;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=r6J8VvP5sZu3QfnY4xLIcDYJhDHkp7mKCtQnavhhvVg=;
  b=P1/Cz5I6sIXAfqKRd1/7veRwJqEHfiFJ18eJLmn/cu4RC+/mAhDP5Yy4
   1Nt/w5d95zSepBvn6hyXckZ2nBRzrjUb/QQWdhEAqki8Q2jGDHHf4GXDr
   IQ4DWO+QGkY/FmnsoWKLyuiLI2YPIUwBK8LRy/TcTR0Gx8DBowJzxlqYZ
   fVcG91sKwt7RMQM9fF6Ug8qDj1GosatI39N2Jhzigih49kmruLXGJJSTF
   cPjTcEVO/wyzVTNowqhBEl5/C5u2tn7RB8+/a2zUVfJdJQY9D3D94lIQi
   9dzsPfsvjxCgbYyz7NKyzNONXQcc6gvKfeV90oL2e6M5nwc6nOw5MR5wZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10994"; a="3039657"
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="3039657"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Feb 2024 11:43:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,182,1705392000"; 
   d="scan'208";a="6129749"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 24 Feb 2024 11:43:08 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 11:43:07 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sat, 24 Feb 2024 11:43:07 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Sat, 24 Feb 2024 11:43:07 -0800
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.101)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 24 Feb 2024 11:43:06 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kpFKamgAZjMjQhooIPrkhzIUJ5R4tPEzOzFNIbaUuFcDsfvwIyWLYbb3J51Vq0AUPZOeC4A5KXIdx+kOlbeElWdq0d1xbi5UpfKM7kMQp+7qyX8DwFrqyfl0xFbUDqAIZvRhnBh65ygt3+jZ12jc6PNaqPUsVc7umIyVgKCm2MmvY2FuGM+YFq2z/goV3AGungABwVXFfcFbgH47nXUfveizUJ/ADmyqEM67SAInP1zyLaRH7ixZgaJybu4okK0Robu2t297oZ9vUA1vvSeiRGZkFPeROCj8u+qPUheb20vOHNwfzcxbBRJ8mYrkkGoX9/bV7AH9zjvYObKGYC5cfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u+yVWk/zq6G75dqr7fs0UYKuve+yq/CnaMfgSTn2mEo=;
 b=R1x3DNzQGJodsS5aSHqmG980Y0QHSIZHC/agya1yBWNr0PcHeie0bMJ5XniTw9zWxAiTJPqHZePkCnvgf2GOVUcy0W9bfFC5WMdAMjREEUThdAkO19+iyHCQ5HJyEFl0yPyoCZsWmE+zS2wbAyw4u2fTcX0GxnACJWckQVfnoA+7WTyWBM8n8W3QiV8DSerITQorF9XstwIJA/CCTVNwCqV6vAC2Xi0MtzbTut4a1+fwuAHj2/GIqljaDcdil6HtCNuJbQSn2tgCk1aHAhUJxSOxgYITu+8VoF98fXhigAt7n6m6o1sgxm5IGbH70r/fJO5hCWhu1NrrmyJkCbL4lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ2PR11MB8299.namprd11.prod.outlook.com (2603:10b6:a03:53f::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7292.39; Sat, 24 Feb
 2024 19:40:24 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::82fd:75df:40d7:ed71%4]) with mapi id 15.20.7339.019; Sat, 24 Feb 2024
 19:40:24 +0000
Date: Sat, 24 Feb 2024 11:40:19 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: Borislav Petkov <bp@alien8.de>, Shuai Xue <xueshuai@linux.alibaba.com>
CC: <rafael@kernel.org>, <wangkefeng.wang@huawei.com>,
	<tanxiaofei@huawei.com>, <mawupeng1@huawei.com>, <tony.luck@intel.com>,
	<linmiaohe@huawei.com>, <naoya.horiguchi@nec.com>, <james.morse@arm.com>,
	<gregkh@linuxfoundation.org>, <will@kernel.org>, <jarkko@kernel.org>,
	<linux-acpi@vger.kernel.org>, <linux-mm@kvack.org>,
	<linux-kernel@vger.kernel.org>, <akpm@linux-foundation.org>,
	<linux-edac@vger.kernel.org>, <x86@kernel.org>, <justin.he@arm.com>,
	<ardb@kernel.org>, <ying.huang@intel.com>, <ashish.kalra@amd.com>,
	<baolin.wang@linux.alibaba.com>, <tglx@linutronix.de>, <mingo@redhat.com>,
	<dave.hansen@linux.intel.com>, <lenb@kernel.org>, <hpa@zytor.com>,
	<robert.moore@intel.com>, <lvying6@huawei.com>, <xiexiuqi@huawei.com>,
	<zhuo.song@linux.alibaba.com>, Ira Weiny <ira.weiny@intel.com>, "Jonathan
 Cameron" <Jonathan.Cameron@huawei.com>, Dan Williams
	<dan.j.williams@intel.com>
Subject: Re: [PATCH v11 1/3] ACPI: APEI: send SIGBUS to current task if
 synchronous memory error not recovered
Message-ID: <65da4623b6287_2bce9294be@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20221027042445.60108-1-xueshuai@linux.alibaba.com>
 <20240204080144.7977-2-xueshuai@linux.alibaba.com>
 <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240219092528.GTZdMeiDWIDz613VeT@fat_crate.local>
X-ClientProxiedBy: MW4PR03CA0055.namprd03.prod.outlook.com
 (2603:10b6:303:8e::30) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ2PR11MB8299:EE_
X-MS-Office365-Filtering-Correlation-Id: 4fa4185a-90e6-4208-eaf0-08dc3570719b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s2DwWy2iEtJlr511PZX0ZXqXhrMG249OkIg9dM9PAuXgJVkkzH4Ofnymi5grLhha/ip+rdEbwbQivETNERyd31f/nJs484toBdmWieXQJ+KrTgy7ACi91FzAhx3ckujDjbcyXA8wmhtabA6QIH7k7KYEkSlnhOT9NOV9EUBiJXnOHmijxR7OypzaJ2t79e6oovMOr5nk+FIcmmqOeYl5VQWpbkifa5Gg1il4bPNTp70UisnGB9GL/LKGE/WfwoWA81cMylrlbeK7yV5b9/FXS+9qZG3h0WQBy3jWKYo9ygiBVhv9Z2EAuWdAuVg+f0k/V73sIwOhXzXWLWqyjYCaCyGBSx8czMM6Bh9yp0uAoEKtBb298OaO8oEwKSjqu00enTI55DlDUYqKvgEf3sqVc0tWI6spFO+SJSEqveEQPKHgjsJLkId5TqZP9MMYS/1g85UQcj0FxQUZN8KVH31HWvahS48cFAqKU7FHRTvrgAXiPJ1wYJW+iy9RQ/efaUdEnc49AhD4Btmfvdv1bS1J3BtVXtF2XObkIKhLJL9Ibcg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(230273577357003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ldhbrSMr01dkYqv9JykSuwPY3KXpcntJHBYQvor+1Sgxr/GtXG0npPNUlPr2?=
 =?us-ascii?Q?BpEs82E4086uKfmp+mbH7wWF52pPenLE7r73ta73W4i0ILO/uxM2OWJfrU4f?=
 =?us-ascii?Q?sXwjgY1LCvIUVEW9NU8pkDuQWOMEZdOskTIGKFSp9Gfq46fumT0NqdLGZB+c?=
 =?us-ascii?Q?IC9WxIzzhSwfnrzu7qM98Yy6aBTdPDiS/TRM1oHxfIc9GPgKVGzJWcNWv03T?=
 =?us-ascii?Q?CMhJkx1eVmGrpWZQK3lu3Yq9kPzelrdGh//MDzn9aUMi3EkzqTi+ToZJC23M?=
 =?us-ascii?Q?1jm0aTqBdhDWnliHq4rdg+TpH84m5qDpBMbIlZutlEkCBH91z4MykCUOpm5l?=
 =?us-ascii?Q?UBwo8K/S3s2jPtLN4A5ycYgKmcp+FYNqMmVpj8ht/SLwBTTuBUkoNrvfn1ri?=
 =?us-ascii?Q?ZtLa9xLU6ID4RBxA6df3MKr1HYNRMUFh7rp0DQrB37vgeQcAkdz1cbcaTTcF?=
 =?us-ascii?Q?eG6Yy4OWCXzlp1lz/z+wvv19x9HxiYH7lqTMxos3Yp3JrUyArMPPr3KaQqOd?=
 =?us-ascii?Q?pMYxT9tcddvPwLznL8g/CeIaW5bKugbEtGSUNQRd4k29TlI2lBGXU+VEMZdB?=
 =?us-ascii?Q?h6fm/CNKBXpt74rxVQH+JswekVWjWnSFMZeD36ibFZ9PohFVISArAAcCaA2a?=
 =?us-ascii?Q?Z1SgEq0fLMuF/Txb1gOxYQmPPOjaJ2SM3ZxyUvkybm6+bpUGbqQyjtBqs4ov?=
 =?us-ascii?Q?AyRJ8KmawKb0kPdEzwCFA2X5ipNF7NQOzfQ2s4c0fBHjv4RfPVDg4JyvKFzG?=
 =?us-ascii?Q?R1Z7cPVEcW7q1rumyKfPBMxbiVajrM+7caFKh/lYaiYug59nebeR0EAcYfhc?=
 =?us-ascii?Q?7WF0h0i9z6ZP0HESYVBFOTGpJXLEC4oksog0RGgzyLJt5c+K5PHtW32BDjBa?=
 =?us-ascii?Q?cQqblXyhpYAqCEM4wGoIfKKIkUYtRASNfySIZaCoXc9pMVPd4RokdN/08a15?=
 =?us-ascii?Q?bnUrQKP8ck7BijDAMIphInI1CbuXv69GGp80P1O7KUVC082QYuwwSsSnanS5?=
 =?us-ascii?Q?5mnbLJOJmESjtOKvEkvvO8hvixCw39DoSi/a0mkRBEaceYMlqvsJ1Sd6nU3Z?=
 =?us-ascii?Q?P7LAUGl3/M2kxPK2fqcdiv+Uez6xw2SMAkeCia6A+QGQ53vtjCInfKLeJhbS?=
 =?us-ascii?Q?+t0jaMDnEwgSSJNu+D3F46CiVw1odFsQNT1UPAHAIJ3veZ/B4RQYg4Qrs6cS?=
 =?us-ascii?Q?SdjouFdR1KD3w2AbYhsESfX5SPbdZ2gYhU8jxiGsm+zbb7sl+9GvnaeXzXWL?=
 =?us-ascii?Q?QCRq1FDwicdVKNhXNJanQbj3wTo0On4+qZMj8UiqP9G2SwtW5pZElp+eCw0E?=
 =?us-ascii?Q?AgQATVkkKRHOWLRk7c/NPeDQP4HdQSVwpJfmpFwcWBHDfKj4/1TDfF1uwec+?=
 =?us-ascii?Q?cn6UpAO9XuLnXiUI/pcRmkB0E09TYgyNkfa/zRztjGX4sP8fuer7eb7aOkix?=
 =?us-ascii?Q?wWAvbj50tyaA2IH7HrKSWwVj4EE+tzC1Q8E3gHZwbruve1ZooKyARqK0rOFx?=
 =?us-ascii?Q?adLYViHFkXeUM8UORe5Il6+aJkQlnpEqV9eFuI/zYvedxoHsq97v96YXacNR?=
 =?us-ascii?Q?ssM1Hk610Fw1JpGfLqM8rpn54DRyrbD9KzYyOue6oNUcfhhPJFVs83W2aIhQ?=
 =?us-ascii?Q?AA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4fa4185a-90e6-4208-eaf0-08dc3570719b
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Feb 2024 19:40:24.0866
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vT+SDa9EHCapEaODuV8Y96DDJ65wUe8uAioCc6etuRKAsYsl8gvC+7SQAsDITXrMnONew5Hfk1vYpV87z1//RGl4yyj+p7G306LA5uZVSQI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8299
X-OriginatorOrg: intel.com

Borislav Petkov wrote:
> On Sun, Feb 04, 2024 at 04:01:42PM +0800, Shuai Xue wrote:
> > Synchronous error was detected as a result of user-space process accessing
> > a 2-bit uncorrected error. The CPU will take a synchronous error exception
> > such as Synchronous External Abort (SEA) on Arm64. The kernel will queue a
> > memory_failure() work which poisons the related page, unmaps the page, and
> > then sends a SIGBUS to the process, so that a system wide panic can be
> > avoided.
> > 
> > However, no memory_failure() work will be queued when abnormal synchronous
> > errors occur. These errors can include situations such as invalid PA,
> > unexpected severity, no memory failure config support, invalid GUID
> > section, etc. In such case, the user-space process will trigger SEA again.
> > This loop can potentially exceed the platform firmware threshold or even
> > trigger a kernel hard lockup, leading to a system reboot.
> > 
> > Fix it by performing a force kill if no memory_failure() work is queued
> > for synchronous errors.
> > 
> > Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> > ---
> >  drivers/acpi/apei/ghes.c | 9 +++++++++
> >  1 file changed, 9 insertions(+)
> > 
> > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > index 7b7c605166e0..0892550732d4 100644
> > --- a/drivers/acpi/apei/ghes.c
> > +++ b/drivers/acpi/apei/ghes.c
> > @@ -806,6 +806,15 @@ static bool ghes_do_proc(struct ghes *ghes,
> >  		}
> >  	}
> >  
> > +	/*
> > +	 * If no memory failure work is queued for abnormal synchronous
> > +	 * errors, do a force kill.
> > +	 */
> > +	if (sync && !queued) {
> > +		pr_err("Sending SIGBUS to current task due to memory error not recovered");
> > +		force_sig(SIGBUS);
> > +	}
> 
> Except that there are a bunch of CXL GUIDs being handled there too and
> this will sigbus those processes now automatically.
> 
> Lemme add the whole bunch from
> 
>   671a794c33c6 ("acpi/ghes: Process CXL Component Events")
> 
> for comment to Cc.

BTW, I am about to revert all the CXL GUIDs for v6.8 to try again for
v6.9:

http://lore.kernel.org/r/170820177849.631006.8893584762602010898.stgit@dwillia2-xfh.jf.intel.com

