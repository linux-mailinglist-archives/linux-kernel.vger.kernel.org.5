Return-Path: <linux-kernel+bounces-10006-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC4C81CE99
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:58:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0E511C2285C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E24F12E403;
	Fri, 22 Dec 2023 18:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ml39nlY6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1F932C1B0;
	Fri, 22 Dec 2023 18:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703271481; x=1734807481;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=4vY2d7xdb6V8d+bNi1pVFs3ro87ywl+FtKrcz8XajgU=;
  b=Ml39nlY6TBaehFNd0iZ/FXXTesPz3QTnEWK45MKK2+qrA3zl4kTlqkST
   2off7uZafX4DE0KBvjSiBomn+R/waus/fW+mpymWrMEr4rQVDQ89bu8R2
   VwZKDF8uDh5nSAdNJuPX6EEHIvXfgLrwm19bm13HjHx+vsHWw4tSKF+hs
   MbfocMCtD602gfqa5VVgYNwHtCk+DjVIAcq9t7eXaqJZ+QRX1jPyjzyeo
   K0b1sqgN4IQOoO16MGcqfgt/+mp5+zXkmC3jLZYEFfNxLfU1cgG+50rxu
   sX72jMAVc/8uKe/QxZy+agFH67N8nXP1L9VIr/C4jSYmoAfV/oSM0rkaz
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="376289795"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="376289795"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 10:58:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="811385992"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="811385992"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 10:58:00 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 10:57:59 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 10:57:59 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 10:57:59 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B5B+XlE8/7FnZnWLjay6ht8l53bLMnwk21AnSmoQKLsZejQzx/puMuA4SuA6MHVhkGj92FiZhlHaE6sHoJMFEv6kvr4GyZT6K5ZGM1u04JE5CnLLI/Xa062qLh4EPHObfiuJBybpVyH3MnWqHyWLEO4SiUPlWbpjwgupeNQTkeQP/Bnn0GMcUWfO+678EizcIdet/8cucBMawB1EYrSOBMhjgi/3RYd7bVfrkQOU4xfngO1yonQ21JDlwAiYW7u5ZOsY7j4pLRV1P/N/0akjnLI73VjduNyB31hRIweHe8TfyE6f/u6YoXvuaSi3OASIqVS3B7xBogUEXuhhnTOEnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMFYLgr9FA9hmCXahwUfjRTM+OYedj/jFrRxayLkW0U=;
 b=iZZBzwFW/XJhJXbZqgU7A54MK9gREIkSgSFFBTRp5m1UyTvZUBAgQeZtO8ydhAcf63HN/yItFyCIplAvpWVzcmOBgf0YbkR6whcskBmB3BR4ktpiMDKOqlgOkV/arfWjBzCi9GCWFVzeaXtkWO7uqKVcxWIZbsfDQD6+hifmImApB3CFslKBGdM3wV2YVN1tRj5hqC04GpVReHfrsiz0AX8oCmUhpMVJoF+wfTql/wO8zDU8NKxW+WCf4r7w5Ue67hXxBZjx8Pkwvp/K/hLItz6eugyiIlUFb7LXAsAzSWJtJHNeeUumEEEIW9+LHlVdYSR5XBLpKfQMDAV94Sv1zQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB7085.namprd11.prod.outlook.com (2603:10b6:806:2ba::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 18:57:57 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Fri, 22 Dec 2023
 18:57:57 +0000
Date: Fri, 22 Dec 2023 10:57:54 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Ira Weiny <ira.weiny@intel.com>, Coly Li <colyli@suse.de>
CC: Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Xiao Ni <xni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, "Hannes
 Reinecke" <hare@suse.de>, NeilBrown <neilb@suse.de>, Vishal L Verma
	<vishal.l.verma@intel.com>, <linux-block@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Re: Bug in commit aa511ff8218b ("badblocks: switch to the improved
 badblock handling
Message-ID: <6585dc32bebce_ab80829462@iweiny-mobl.notmuch>
References: <6585d5fda5183_9f731294b9@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6585d5fda5183_9f731294b9@iweiny-mobl.notmuch>
X-ClientProxiedBy: BYAPR01CA0016.prod.exchangelabs.com (2603:10b6:a02:80::29)
 To SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB7085:EE_
X-MS-Office365-Filtering-Correlation-Id: 0e020394-f713-4333-dfba-08dc031fe966
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RM0gRmdqAMEZV/DkbXOwBX0ynP/y4qpx9oDgQyjaPn3eXYS95nkThzsohtzlyp4Qw1ztThyA+08vY17qgbkA7Fhgy11k713vFAzeeyGCKTjLIvTI5+qoOZiZtftIE6ZZ/H5NYT6lDSVazTiKGfS8/e7vReplhH7zBsCqjFHCgJtRnu4Xtbapo1TdofQaC5bEnp896iqNC2egR4eeTWOfY9vyghqJHXpOn4NmOAkzQebdSfrIcLiL68jW89x2xQDrKJxKxhgOfGbymAxNgb91ec56pyPTCSB/yg0uWFhFTIg9UCX3h8c/cMQ7cOiIGmh2lJWlpTrCvunQaYPkvoigW9opBWbhnfCTfKS8M1B8k4DeEcZo20KFqMMVHyG+SlLe6RZtWTfjtlGgzPshTovUb4rkt8kg/ATZsHfV/S4zfxhZG0fBXce5oGFeWZ1YbOYs2xiMtyt9HW4QswC3d57hWVPfhsilX47aU9vqgaOo2XT5nG4kAUe1aJGk/G53gAXkXPRkvbeks4fgkFSe+WaygxoSNYiaLlelYQKOPU1EJj3CjdwFFI8toxjzHeJ68KwoDjRnLHllWzjmf7Fu+mo4hg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(346002)(366004)(396003)(136003)(376002)(230922051799003)(1800799012)(186009)(451199024)(64100799003)(6512007)(26005)(8676002)(6506007)(478600001)(8936002)(966005)(66556008)(9686003)(54906003)(316002)(66476007)(66946007)(4326008)(110136005)(6666004)(2906002)(38100700002)(41300700001)(6486002)(44832011)(82960400001)(86362001)(83380400001)(5660300002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cAH18dXARZ+fGkdQITwBNInJPOUMJ4hoqWpn8JB6eT9ihquQLkWhkC55eWrB?=
 =?us-ascii?Q?uSMjGMy9fs1SlxhsEXxp90EcqTNP1FLl/RRePnrvxJKf4zMAG4Ue5jkn1zFR?=
 =?us-ascii?Q?GbxPuDfLW+tPdSZRRdR/ZS8B4TXrFKaOCc4AKYQNmS0PHabPKw3qjFVRmrAf?=
 =?us-ascii?Q?rYuWCPy6XNNc1XjoHxZcT+9V2tAx2K6uVaLTmm4FYEEfIZ7ffPlrUUvun71J?=
 =?us-ascii?Q?1OegnpKCXe9Blj4Qibn1C3p8WE43Wtj7bwBL3eKEz36wpGLra90n/3Pjm4FR?=
 =?us-ascii?Q?OM7rWJzj/b0oAoH878bHsOcDSBcWMU9RIHomxYQq4ohZn4lvbPZzlQoJItKW?=
 =?us-ascii?Q?PB/UgYdT7R/RQw6IYT6lbgrJL0eD63cjf1NKnHYgMpx3cyA171FUUeRvlf14?=
 =?us-ascii?Q?c7D/jWgtnA+I8h51SCsLLLq4AFEp7vBHMOsaV9Vhtu3fnUchpwGMtRM/Q2HR?=
 =?us-ascii?Q?GTXKgEVkcj5MH8ESu4QBDPreuRMx2fQqdOkY9EGvySQdtlpXzCKqloLwhL4S?=
 =?us-ascii?Q?BAbzBE7+5eaZxLpdYP10oCKUc7Vgh/mkOx+NRnb2LftNGVhkHmBN7TQ0IVjn?=
 =?us-ascii?Q?GfGfBVdM+6hEQhixKBA5tTdik6JmzDgRFxJs22O4rn6VA5bTCjbssUruvFJl?=
 =?us-ascii?Q?X/DgKkmMBZOzVm5x7GGhXhbpow80qHo8ipynxk+w9mO2pdHaIY481zUh8pQm?=
 =?us-ascii?Q?W2BBo+JWS4Y1WinKkVB0AbUUwDSyBLEDGPp1mZQIaAM6ZNzyV0CxzAEqIhCv?=
 =?us-ascii?Q?7yb8w4dv0/NFoY/tfw3RtX+K3xG7xh8nITcrWOH2ipicFIrbZUFL1lfQXP02?=
 =?us-ascii?Q?vMbz2EEWgmDgwi3l1GTBmUwMPAyNP8LDIxE24+5IAiFgOQpjGfwQB6p50g0y?=
 =?us-ascii?Q?sr3sVEotboweWvhrqYhu76aPXNlp8qtIZJ0Tc0Eszeq7yzQYj+Pny4wjYQlx?=
 =?us-ascii?Q?pAZUi8Hv+NHviHyEVW2bwux31ITDmQDhn3IAVo8KFKEXFHvEtYbMSuh6l+gw?=
 =?us-ascii?Q?2Od5AZWEiYItDG9NFbrkzOKjhEvm+3aVz1rvjQ31Pzl27jxmJ9PCIaj2wr/m?=
 =?us-ascii?Q?Np+RGASgOgCCj6nPlhZAOpAAKVOyJTJaWd4dpNuwaJU7BvVVmtB1drZ0ISO/?=
 =?us-ascii?Q?6aDLMyQacYKb0Wo39+FOLgNqZB4ellaDjTAL6IOYdIEO6kT5HR8iFE49JkOm?=
 =?us-ascii?Q?Y4luArzY6ROIvNm/hWmkOfET4/ujRoHboUATLyNBJqKu5RMOVstvvWuPB58l?=
 =?us-ascii?Q?yjjXS+jwFOh5qUqDn8XhW3a9vLXwBOOWYkLxBqvAGoMr1R+I6LIDVtSLJNfJ?=
 =?us-ascii?Q?lB8O1ak+krRigBw7h/R4M0TnDlQEhfjxzjF+LZt0X+JBhsxBVkyHqQ0qeW9w?=
 =?us-ascii?Q?+AyPXCRhqVnX9hWk4hMO8AVTktADKXnRaLqAGJ7zKGrVuFP70TQIpvbcYAFZ?=
 =?us-ascii?Q?2cQzFlC/4oVdS81LcQPuZyjM2dodeJhpLvjmm+dyp8aPwh2hdnGh6RQvxUak?=
 =?us-ascii?Q?eEKhFPelvuZPq6ENpS8MoMp99tfPZvxupK5ctkEO0KdnzeCvifBDXa4+wstp?=
 =?us-ascii?Q?appi1C3Ij0Jh0P1K+EwgwrWG2QldYotBLlgDzJqw?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e020394-f713-4333-dfba-08dc031fe966
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 18:57:57.7300
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vrwrQq6YxHQfkJAWjjbBppdyQRjCMh8ycqGuzfEt9KKsPAhBJ6wv/VtCY2a4XnR/l+rIoWr8IyEV70uax5FSlg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB7085
X-OriginatorOrg: intel.com

Ira Weiny wrote:
> Coly,
> 
> Yesterday I noticed that a few of our nvdimm tests were failing.  I bisected
> the problem to the following commit.
> 
> aa511ff8218b ("badblocks: switch to the improved badblock handling code") 
> 
> Reverting this patch fixed our tests.
> 
> I've also dug into the code a bit and I believe the algorithm for
> badblocks_check() is broken (not yet sure about the other calls).  At the
> very least I see the bb->p pointer being indexed with '-1'.  :-(
> 
> I did notice that this work was due to a bug report in badblock_set().
> Therefore, I'm not sure of that severity of that fix is vs a revert.  But
> at this point I'm not seeing an easy fix so I'm in favor of a revert.
> 

Dan and I were discussing this and it occurs to us that it may be easy for
you to stand up the test environment I'm using.

For CXL we have a run_qemu.sh project[1] which stands up a qemu
environment with the ndctl[2] tests in them.  Clone ndctl to ~/git/ndctl
so run_qemu.sh can find it.  Then start run_qemu.sh in a kernel tree like
this:

$ <path_to_run_qemu>/run_qemu.sh --cxl --nfit-test --nfit-debug [-r img]

[-r img] is optional but useful if you have changed the ndctl tests.

Once booted you can run the test suite with meson:

$ cd ndctl && meson test -C build

I've been running just our clear.sh test which shows the error.

$ cd ndctl/build && meson test clear.sh

Hope this helps,
Ira

[1] https://github.com/pmem/run_qemu
[2] https://github.com/pmem/ndctl

