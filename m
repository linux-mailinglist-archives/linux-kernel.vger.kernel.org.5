Return-Path: <linux-kernel+bounces-66123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1393855756
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 00:35:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BF881F2A322
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:35:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD4331420B4;
	Wed, 14 Feb 2024 23:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ns/bVCIX"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE351420A5;
	Wed, 14 Feb 2024 23:35:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707953717; cv=fail; b=INLmlgBSnyeAIGAcy42nwxhzSSUoF7qdDrFbRfsGJjcBTj5DSLW5E2c+rnXnY1XAdJRTGhpgzTn+o/7mTWssQV2wZOrrnPJk7Cs8q7QhhqPNsJKZW829q6W+EjGisSqjt9ddFykdtz1mirk5TdeceGr6Q3uFgTXr/3sfWyB5XoQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707953717; c=relaxed/simple;
	bh=DO/aZe4RtziPUOheC68kxL94rT1FWEqDoAuJQKG251Y=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=X9bZefFLwFBTeQJlIqjJIQMOspABz3GHFfjlnMGfI2kgLfUoJbgA2sy1GeTmWLJM/qkVmMMrvbt2KqbJifZArNTTJAYbxtES9h12brWbySyK5fy4RfEYsS9FIoVxPi1BKHffztnMSXo+iAaddIOJTt7YphxdsH3N6M1ezX64D0Y=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ns/bVCIX; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707953715; x=1739489715;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=DO/aZe4RtziPUOheC68kxL94rT1FWEqDoAuJQKG251Y=;
  b=Ns/bVCIXFirLqNsG7UgBYQ3Ql8syEvmNGdeu9HAARrbgjBaD5aW98V/f
   6sGvIKMNifujrj23+K2e0ysgDT92SCvjHCEuX7Yl7q8G9zpp5+mHDP9KL
   4UmpNIks5sKX2jVl7pQgIr3DFds7Oh9sAVEXSTrz6jiXreUeQJ8SamPCr
   M4Zu/5Oe48uwGiVCKP3EDfu0x7afCEr8Vk/OI7+5Sn4T+gpKeZMiBCLbd
   wR5IXPy/n8Wy3YUfbzVfTJt0zHSQ9z7lQHkyNDZrGTrh6C93sO5anfIYH
   GM7gYlZGha4Xu0NtEBmuP03MahORN7GZAgZhCHclA80QdEsOwo1k1qNy3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19542828"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19542828"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 15:35:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="7955309"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmviesa005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 15:35:12 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 15:35:11 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 15:35:10 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 15:35:10 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 15:35:09 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=del9Jr3aIJRPr443J5Yq1sWufJscbB8WIo6rbAOC0HgVY8ygz1GzPh7Y6WZ+nupq7cvM2EaMZ7+9L5Ebx2tlf5zeh4I0AUVBduB7ES5q7GxSm1kTAVWdTaid1YNkKAuE4VVoS4eM1tXiR9BLOP44jOKcrh/bn80Xf8WnrJSrgofmBIIix6SESZXGDM8cbh30kUebvNyXFosRZ4alVauyFLinHFJh2w4lrjn5rqIQnMqUMCRUh4tPLIQbhOPuRdIRxTo+6CyyIduOwy6a4NaOlns4DSuSXS7m76TQ7bl3RhyCgBjOq6dpZ74TSpi79MldrhqVGdDmZYP+PYI7pQ9hJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZTXASZJ+JHXcedqfQmYW7rXw5znEhKICV3VmTONY0QI=;
 b=W4eI6ta39DoDddOuBd78B3Cu70X/wDHZed0QXj7PurHlsZ7RnOoHj9UqDCJA3C2JAXBVhpmM0i5E0i/glIO1oMo2uJwiQbqRm7mA13QBDGFcUkVk5PikWdrt6h2JNDcPaHuXuSemEcUhNzETeiu4xtdRYzQduuyOrXU2F1tOoHIoIXaIvwj+0t1MOkgw52lX9skcYCgVWwlv/fITp/EBBhqrl3ML0RrgMOpGDV9AIZAUvBrik6XewQ7MW7f2VP2x3+yauOHv74jh5CQmvVSsSxw5Vmjn3bens/oedYz6BPLOh3nmw/wOMlm/zwJh7EonRqClETg84SSo1l4jBYupng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DM4PR11MB5534.namprd11.prod.outlook.com (2603:10b6:5:391::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 23:35:01 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 23:35:01 +0000
Date: Wed, 14 Feb 2024 15:34:55 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Jonathan Cameron
	<Jonathan.Cameron@huawei.com>, Steven Rostedt <rostedt@goodmis.org>
CC: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65cd4e1f69205_d5b4829463@iweiny-mobl.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <20240214121153.00005c97@huawei.com>
 <20240214102310.7ba53f3a@gandalf.local.home>
 <20240214181200.0000500b@Huawei.com>
 <65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
X-ClientProxiedBy: SJ0PR03CA0022.namprd03.prod.outlook.com
 (2603:10b6:a03:33a::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DM4PR11MB5534:EE_
X-MS-Office365-Filtering-Correlation-Id: 1636b561-da0e-4ac7-acf3-08dc2db59015
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: nfnGGhXhM0d6nCOqO/p0vlJ9Fb2HfFbS6EEsJdVyM0T0bAuA2R9OKTboh2IHBbzGu1+EwWRUasgKVL3iYlpiYxekrwz2w5Gk0c1Csmmd7lQFOBWOmNmVQ6E7IvAvGg6P7z7vHNQCle10kLgptmkhDFk2C/4uzKKbSUUzcLcmxpg6oCq5P2vnwtRuQFtXG+tAFRVdhwP0rVPTuLjL7agwgswnnyQZGfq+bbLBnC8cFCV9MN1V5o2tx93FOFCiLkLO3EsTajl45PSUPkMVFZ2qGjBsFgL2unwVqyogcpf4Ji40Ba7OKC2Ol5X4cN4ezUTgHE/7Bymaw5W67d2JQi7te4crDdmu+nJ1QEBKmA+LN2vplmHYha0giRH510R7AULDYA/U8rbjIYG9qLnJ36sGxEkzZucF8J+IrXSFtiKBzQ9LS+RqQJQfei+wQuR+ayOamx+bD8pqN84U4l12ayYpMaZMvnMqSM0JOn3WL0T1ycY4OaEv96nc5isQd12eao/VhIuaIsmou2xJneQ9sZRw4xANaYQukM23iGVWZZBubV0vLrlPQ6WbG48eJsX6xEGk
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(376002)(136003)(346002)(366004)(396003)(230922051799003)(1800799012)(186009)(64100799003)(451199024)(66476007)(4326008)(478600001)(41300700001)(83380400001)(26005)(5660300002)(66946007)(9686003)(66556008)(8936002)(8676002)(54906003)(316002)(110136005)(86362001)(6666004)(6512007)(6486002)(82960400001)(38100700002)(6506007)(44832011)(2906002)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?yCQB7bTKbxC1NXpUg6eqH3OozGIg18dsZMmgD+R2m3jHl9Y/eAnpuJhtoyvh?=
 =?us-ascii?Q?bCKNTaGO+M2mz0FzU64zSsUsCsxFEdIRvaY4ueLpyLhxqgLe13NU1yBfziib?=
 =?us-ascii?Q?3Lx4tPEvczAMxLOb7GtamLDKaVpcKw3oJOdcxBXiQRCi/1fNLdNKMhvaUIhB?=
 =?us-ascii?Q?vKW4bRQEyyXKC2EkxWz2oQ8BUbYLfZf4HSvkK+BjqDDPpNSsrGWlm+xwpQMK?=
 =?us-ascii?Q?HOhW0dQvWDqkuNUFYYRACTtza8+YgvB9eHs0V5kor/fgmtqbrOqKYBMmBZjY?=
 =?us-ascii?Q?QYDNEbtpwNwCx9dg+csG6T/2sJFTYYBgj7UyAKJEAF1DEJj7SRKiNMvgVkCf?=
 =?us-ascii?Q?YGS0lYbqxXdHFX6V2MQxzrs5guXinAjoqjTDqEHPt4nSO3ud7++DX9oiFRIh?=
 =?us-ascii?Q?GKIWiRYrIioEkhoa5G8RiqetBlSo28qR9dY7RnYE82GrTau7pm9mq4eN5okf?=
 =?us-ascii?Q?uha5YZXde3GB3Wk8mc8ZkQkebzmmpGbB97S7ahxGXvulbqXaM3kF6UjytLjV?=
 =?us-ascii?Q?8+I/eElsIf3L89cVsBZZC0j2z90WTWf8rhyrhfIAR3IPeFyUJI/XahOPjfzn?=
 =?us-ascii?Q?XHYqXKB3CUdkbHSc6/na12H3Yz/VH4NZtG6oaHvqskLoJaShV6jm6dQdFnX1?=
 =?us-ascii?Q?3r/cyLh+e4bNgRGHpGH9mW3xSgC27f1hpSwvRVmFmQcAT/+hL22QyO+4+ikv?=
 =?us-ascii?Q?P/+pKQPBEPye5EXz9RTF+J+OonrV5ubtRTmx4WzdOBT+k9jmMYS2zpduWYu5?=
 =?us-ascii?Q?h4WHNdR/GDZFsczY2zNxCGOpimJYTY2JaFX/IaW8YRdzuUJdRPjQF1gR7k35?=
 =?us-ascii?Q?wvchTU3W0ndK41guUkBdJUTueuVsxSii0Th8OZLAkh+/wH+d9gBiGdYuc0UC?=
 =?us-ascii?Q?Q9Jn1/nYJgfh3dmBRr4//J44axqOUDGP+zqH3vPDgCRs2mG69f1mc/2GpLxz?=
 =?us-ascii?Q?qFnNcx/djg7Li0JbyFJizE6c0FQLLcx8euw6zOaJyuD0mZ1aQ6jCB3htjBeM?=
 =?us-ascii?Q?NfruaDFLQz4QpKg2Mkl+ecRVkjnyDgF+ROTPRGtZ3u3kE4eiJHREj0AMqpQy?=
 =?us-ascii?Q?uhV1fVFa8BDnY5BEyoOCofX1BfxiMb0OJQ9COW+Je7FBsH/VVdiHcoAjdxsi?=
 =?us-ascii?Q?VC3dcx+T4pqPTvxhu9dQK1E190u7GzA9Mf8G+k49+zKPLiIjnJl774KZN6Iu?=
 =?us-ascii?Q?OhgcFEgP1luSb0LvR1P8uTgdnszP2RhQna/vGTskcuY7ffjxURNoYhvGRo6z?=
 =?us-ascii?Q?EtXrXbcJdIhC5yHNmcFqasn+jULqggNPJTkAZ+83B2JfsC/6UIqxW3C2/Ssz?=
 =?us-ascii?Q?ar42xDqnlk+clwmmKRUTGPUUn8Y7E+ZhbML+vFi6dDPbbr+JgJGkgwO4zESk?=
 =?us-ascii?Q?eEV76sVsxFj+DCAuPQ5iHw1A9iZwTqWUTKiE2BsqDu0bZchmmWeHl52W+qSK?=
 =?us-ascii?Q?PHkaOrjDhrhDGxEQb7NH1GJIR9HaWadsa857IIGp8vZ7iOcyBxT++/0AnWGz?=
 =?us-ascii?Q?++4sBWri96VTicXSStS8mZ1TWiP4e1UBNGZzKR/Z1rk5mpBXRlGhaGmwY+RK?=
 =?us-ascii?Q?y+eAMvlkbcfSxg0rSQGFSyYYW3MVUfA9ajPCeyIr?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1636b561-da0e-4ac7-acf3-08dc2db59015
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 23:35:01.1689
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AeXYNTDf5uCYaBpi1x8UPZU6xy4WiWXTOpyM5mc/KyzN8O/oLXNVy4UpXuWAk42deOHNiPvaL+Ocpeh1SBdM7Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5534
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Jonathan Cameron wrote:
> > On Wed, 14 Feb 2024 10:23:10 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > On Wed, 14 Feb 2024 12:11:53 +0000
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > 
> > > > So I'm thinking this is a won't fix - wait for the printk rework to land and
> > > > assume this will be resolved as well?  
> > > 
> > > That pretty much sums up what I was about to say ;-)
> > > 
> > > tp_printk is more of a hack and not to be used sparingly. With the right
> > > trace events it can hang the machine.
> > > 
> > > So, you can use your internal patch locally, but I would recommend waiting
> > > for the new printk changes to land.
> 
> Steven, Do you think that will land in 6.9?
> 
> > >
> > > I'm really hoping that will be soon!
> > > 
> > > -- Steve
> > 
> > Thanks Steve,
> > 
> > Ira's fix is needed for other valid locking reasons - this was 'just another'
> > lock debugging report that came up whilst testing it.
> > 
> > For this patch (not a potential additional one that we aren't going to do ;)
> > 
> > Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> > Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> 
> Jonathan,
> 
> Again thanks for the testing!  However, Dan and I just discussed this and
> he has an uneasy feeling about going forward with this for 6.8 final.
> 
> If we revert the following patch I can squash this fix and wait for the
> tp_printk() fix to land in 6.9 and resubmit.
> 
> Dan here is the patch which backs out the actual bug:
> 
> 	Fixes: 671a794c33c6 ("acpi/ghes: Process CXL Component Events") 

Unfortunately this is not the only patch.

We need to revert this too:

Fixes: dc97f6344f20 ("cxl/pci: Register for and process CPER events") 

And then revert ...
	Fixes: 671a794c33c6 ("acpi/ghes: Process CXL Component Events") 

.. but there is a conflict.

Dan, below is the correct revert patch.  Let me know if you need more.

Ira

commit 807fbe9cac9b190dab83e3ff377a30d18859c8ab
Author: Ira Weiny <ira.weiny@intel.com>
Date:   Wed Feb 14 15:25:24 2024 -0800

    Revert "acpi/ghes: Process CXL Component Events"
    
    This reverts commit 671a794c33c6e048ca5cedd5ad6af44d52d5d7e5.

diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
index fe825a432c5b..ab2a82cb1b0b 100644
--- a/drivers/acpi/apei/ghes.c
+++ b/drivers/acpi/apei/ghes.c
@@ -26,7 +26,6 @@
 #include <linux/interrupt.h>
 #include <linux/timer.h>
 #include <linux/cper.h>
-#include <linux/cxl-event.h>
 #include <linux/platform_device.h>
 #include <linux/mutex.h>
 #include <linux/ratelimit.h>
@@ -674,52 +673,6 @@ static void ghes_defer_non_standard_event(struct acpi_hest_generic_data *gdata,
 	schedule_work(&entry->work);
 }
 
-/*
- * Only a single callback can be registered for CXL CPER events.
- */
-static DECLARE_RWSEM(cxl_cper_rw_sem);
-static cxl_cper_callback cper_callback;
-
-static void cxl_cper_post_event(enum cxl_event_type event_type,
-				struct cxl_cper_event_rec *rec)
-{
-	if (rec->hdr.length <= sizeof(rec->hdr) ||
-	    rec->hdr.length > sizeof(*rec)) {
-		pr_err(FW_WARN "CXL CPER Invalid section length (%u)\n",
-		       rec->hdr.length);
-		return;
-	}
-
-	if (!(rec->hdr.validation_bits & CPER_CXL_COMP_EVENT_LOG_VALID)) {
-		pr_err(FW_WARN "CXL CPER invalid event\n");
-		return;
-	}
-
-	guard(rwsem_read)(&cxl_cper_rw_sem);
-	if (cper_callback)
-		cper_callback(event_type, rec);
-}
-
-int cxl_cper_register_callback(cxl_cper_callback callback)
-{
-	guard(rwsem_write)(&cxl_cper_rw_sem);
-	if (cper_callback)
-		return -EINVAL;
-	cper_callback = callback;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_register_callback, CXL);
-
-int cxl_cper_unregister_callback(cxl_cper_callback callback)
-{
-	guard(rwsem_write)(&cxl_cper_rw_sem);
-	if (callback != cper_callback)
-		return -EINVAL;
-	cper_callback = NULL;
-	return 0;
-}
-EXPORT_SYMBOL_NS_GPL(cxl_cper_unregister_callback, CXL);
-
 static bool ghes_do_proc(struct ghes *ghes,
 			 const struct acpi_hest_generic_status *estatus)
 {
@@ -754,22 +707,6 @@ static bool ghes_do_proc(struct ghes *ghes,
 		}
 		else if (guid_equal(sec_type, &CPER_SEC_PROC_ARM)) {
 			queued = ghes_handle_arm_hw_error(gdata, sev, sync);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_GEN_MEDIA_GUID)) {
-			struct cxl_cper_event_rec *rec =
-				acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_GEN_MEDIA, rec);
-		} else if (guid_equal(sec_type, &CPER_SEC_CXL_DRAM_GUID)) {
-			struct cxl_cper_event_rec *rec =
-				acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_DRAM, rec);
-		} else if (guid_equal(sec_type,
-				      &CPER_SEC_CXL_MEM_MODULE_GUID)) {
-			struct cxl_cper_event_rec *rec =
-				acpi_hest_get_payload(gdata);
-
-			cxl_cper_post_event(CXL_CPER_EVENT_MEM_MODULE, rec);
 		} else {
 			void *err = acpi_hest_get_payload(gdata);
 
diff --git a/include/linux/cxl-event.h b/include/linux/cxl-event.h
index 95841750a383..4d6c05f535f8 100644
--- a/include/linux/cxl-event.h
+++ b/include/linux/cxl-event.h
@@ -107,54 +107,4 @@ struct cxl_event_record_raw {
 	union cxl_event event;
 } __packed;
 
-enum cxl_event_type {
-	CXL_CPER_EVENT_GEN_MEDIA,
-	CXL_CPER_EVENT_DRAM,
-	CXL_CPER_EVENT_MEM_MODULE,
-};
-
-#define CPER_CXL_DEVICE_ID_VALID		BIT(0)
-#define CPER_CXL_DEVICE_SN_VALID		BIT(1)
-#define CPER_CXL_COMP_EVENT_LOG_VALID		BIT(2)
-struct cxl_cper_event_rec {
-	struct {
-		u32 length;
-		u64 validation_bits;
-		struct cper_cxl_event_devid {
-			u16 vendor_id;
-			u16 device_id;
-			u8 func_num;
-			u8 device_num;
-			u8 bus_num;
-			u16 segment_num;
-			u16 slot_num; /* bits 2:0 reserved */
-			u8 reserved;
-		} __packed device_id;
-		struct cper_cxl_event_sn {
-			u32 lower_dw;
-			u32 upper_dw;
-		} __packed dev_serial_num;
-	} __packed hdr;
-
-	union cxl_event event;
-} __packed;
-
-typedef void (*cxl_cper_callback)(enum cxl_event_type type,
-				  struct cxl_cper_event_rec *rec);
-
-#ifdef CONFIG_ACPI_APEI_GHES
-int cxl_cper_register_callback(cxl_cper_callback callback);
-int cxl_cper_unregister_callback(cxl_cper_callback callback);
-#else
-static inline int cxl_cper_register_callback(cxl_cper_callback callback)
-{
-	return 0;
-}
-
-static inline int cxl_cper_unregister_callback(cxl_cper_callback callback)
-{
-	return 0;
-}
-#endif
-
 #endif /* _LINUX_CXL_EVENT_H */

