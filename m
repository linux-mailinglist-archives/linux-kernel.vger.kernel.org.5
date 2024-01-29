Return-Path: <linux-kernel+bounces-43566-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFAC84158F
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 23:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 622C71C24095
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 22:23:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B68F159576;
	Mon, 29 Jan 2024 22:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GDJA2K1a"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A810615956E
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 22:23:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.9
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706567005; cv=fail; b=fdrvv0yPxLDAppqEZOuohlTt3TVpcOtT0oe/BWP+N0338VEPKUuoEufk0qQRTlYUWMoazP2todKQ1zlyemYvtMENIj43NXQnalN2mwfetXPvdQPdQ1R1q2T125qTk+LXpJMqM6yxTeZSHwfoTV1Wdbh3Y+qaOy0O+1oS0XQY8Og=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706567005; c=relaxed/simple;
	bh=5gR0I0XmvdP3HjAgH1qy5cRSIqzjqwBmB1oYO+/HZj0=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=o44e1bTiZJLzsGM3jb58/uBjAM/enjJzAguEiZ4OvqOLLv1C5gZjEc+HQsDhL6RrbQ4eKK5SueeoND5UWupCXftBYGscCGxTzT6HalS5Kv4maHwgEOsmZkhv4VJSkqMEsK66Ld1gbxY8sfJmc00jwiT6a2eYfik0572wuFrdRx4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GDJA2K1a; arc=fail smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706567003; x=1738103003;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5gR0I0XmvdP3HjAgH1qy5cRSIqzjqwBmB1oYO+/HZj0=;
  b=GDJA2K1a8jQ6llgJSQji8bpHxe8Z9GhtgvB49pKhQl9Al94wCD9btzhV
   M4kOe0m9+QroKjbpUk+ysUfzhQjn+Z7azjkeWBxKqSRHZDzUDUHpbWYOv
   3QAKJP9khFtTAv1zYJdpQnyBbvTsmSpZ0/LCB7bhjzOa6Y6fI1UFF5dLs
   49/af9sSHoHjE/PMqfsXsNBJlTwReLATnAV7NCS/FRSbEGIHgua18zawP
   VV43hEPN5Cfz8VDXCoewA8k2O/FHB6P4YGxz2IOdacILPCwmNAZc6QXig
   6D/W6OF59AGLMwEeUmhmVxTsf20pVaoCHMoDhtfug/0l9RgbAJTx+bk4I
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="21623564"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="21623564"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jan 2024 14:23:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10968"; a="787980011"
X-IronPort-AV: E=Sophos;i="6.05,227,1701158400"; 
   d="scan'208";a="787980011"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Jan 2024 14:23:22 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 29 Jan 2024 14:23:22 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 29 Jan 2024 14:23:22 -0800
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 29 Jan 2024 14:23:22 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WtK/mfDDwrL4wFN6vvXgBC2nxnoEWvmnC13uCYnrQ4NyJVXL4u/twmyTUhRtSSIRZolkAWsJPKXTLy/Fb42A4Q7/pD+QoZCiQ2FvqomL7VhPRl0hzkkfpybm0rH4uEZPmV0j0IlqailJHnwe9EhsEdrizXrf4t2VtQ4MIoXJ0qAJ2avSxV4bexB3/rCA9D8mZlmwK+5oZ5VFIEYMA+TubwnUn0pfKXKoizzNpCVEE2xJABbat1qaPIBtFsh7fUSeE2lFDAtu3cqoSzThYru86Nsv8siy+pzeJ0tumnFAMJQttJC1tmsYlLDQz+QJFE6Z9Wx91Eel+pqowhJeMs2yQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ao8RdQ0pS6n7z3OXkp22835YHv+f/BrDURx3Tvy/uGY=;
 b=IWClSV1398EOFgXWSl+/djY6N69w4TxUfY5+JPZrx2qc20bzbtZ0Eoe+mhtIDU3rOIPbWasZZqEXTjHcEPkW8iGFj6xLxm/1mGuYtDdD76NC+264DRq/Fcsl0GWp70fdtdOfdUP8F/vWuS3nc84hTWrbF/xRdJBBtagEq5zC6Jw6+j//7Mq/wyW50Ek/NmA3QUC4ytGCtjHVgWT0l8BJmTx1yVwIicS39Bq7K6UDrVhzuGwCXtaOTMNcGG0bAHLxTep5Cxb20mIk/ZIt9nRxawez2CCU+IDu6p9wHqMZUc+ikXy8UgO7gvaa6O8dOE+GjAG5RGnS649smaVuUQ2HxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SJ0PR11MB6576.namprd11.prod.outlook.com (2603:10b6:a03:478::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7202.30; Mon, 29 Jan
 2024 22:23:19 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Mon, 29 Jan 2024
 22:23:19 +0000
Date: Mon, 29 Jan 2024 14:23:17 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	"Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [RFC PATCH] cleanup: Add cond_guard() to conditional guards
Message-ID: <65b82555aaf86_5902829447@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <20240129190100.329791-1-fabio.maria.de.francesco@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240129190100.329791-1-fabio.maria.de.francesco@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0238.namprd03.prod.outlook.com
 (2603:10b6:303:b9::33) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SJ0PR11MB6576:EE_
X-MS-Office365-Filtering-Correlation-Id: 732a9a9f-a6c5-413b-8af4-08dc2118e59e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: YOpejPWVDngErL/rjN2oiVP/MCV1HbgrP6cG8iKlGMEwgTEv+h8pAtgdjig8fvp7otrGei0CdbhVkPLDXyKjYf5L8+1+eRzbeYkbmVyBQwro+A5EaYTE0xNc2MBiQBDsAGAIRFSx106WrQ4NMXhzGZ/M3v4Lq5gyonyRvS9d7VKSxBznlTXSzlZ6HjBR/VL9eaxorn4bSrhkeTAzJXnXS1PNZHj33zIowblXSIeCTSpNI8yqL3IRs7a0kb0gTgHtnl7/jb6SPDb7/jc2rLXvjD35IdCPIPF0rZbQgBthF/r38ASPbixfVtbEMbxpUh9YGCJO9Rzfq4aq6qMJwFQ50DF5C0UuuwOYxSW8/lSdvwYQxxKF7fwFuw6pEf4cvjxyDNk1C3UpR8s47kBZfV7IeK6ezVX0i1SSr96U+BHAXB2eRDSKxN7mN0rVurqwemKUx1ibV5sGkxFap73uGFCouLTDqdqw7v82fdA66w5UH9Coea+FWCbVXkyKpbtU/Z2RD7YYQV6l1dO0w9suUVjV0zEzuFZnTCn/OqCUEV0CEA95fdTBvEftgP5YIhIEul+4
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(136003)(39860400002)(376002)(230922051799003)(64100799003)(451199024)(1800799012)(186009)(26005)(82960400001)(86362001)(41300700001)(83380400001)(38100700002)(478600001)(4326008)(8676002)(6486002)(66476007)(316002)(66946007)(54906003)(2906002)(6512007)(9686003)(6506007)(5660300002)(8936002)(66556008);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3exZEsUqxhUa2EmOXN46MsEOmaYC4zJYCZe1QQH2ra0khL4Hy+ZS2qEWYjfg?=
 =?us-ascii?Q?7r7WoWBuTMEXQXr0btwppLzhto+Yo5zJVs4J41YgGpeZ8jcooLuLxbZVV8tO?=
 =?us-ascii?Q?zctC4A0XvbcDXuPSnKnwn+DA4CwiqqA39Gbfbt4vYZesw9rtp5hKOjliFKtY?=
 =?us-ascii?Q?ipMlI8VV7s3phV/lqnvZMMPsTC6TaPn/gBOZmuCftczMhiT5O86mUDfy7D02?=
 =?us-ascii?Q?ErSbkbqubaCAdmSbl3NZ0fd8bAaeb5hBuLgwKWQjOSESHS1k+0xQb0qYipzO?=
 =?us-ascii?Q?cu0sDv4dRLVRNMgCbc8fgR8rRLAeJjsqZOFVu6NW4d+Bc2sJdc0jqneBPWeh?=
 =?us-ascii?Q?t8ZlBjf6uLigVIBX8hs98+xNadWEv9RtDQCyZiFj52SFSbifne/bT0emjCzw?=
 =?us-ascii?Q?49Mn4nAmcjoHeMj2Ht1HyncxD+RkDQ4FZZCZYo3QEmnQ+T8S9yYmSDbmwVsS?=
 =?us-ascii?Q?Pg9vJbRQIwR4EtFr3GxPZYVwUvLAbPjXi8l8fHKP6Fza99fuFy8N7OfxdUyb?=
 =?us-ascii?Q?8QzitmAg3pyuugoCgc5BfF5HejDzKTb/pG167F6tLv9j+qXWmQky+xNI2Tm/?=
 =?us-ascii?Q?RI29JiVCKD1fvHFCoJt4ArL7951FqMku3WOsqh7KU+m0tZX9xGGO5Fu3Rjsk?=
 =?us-ascii?Q?ZPsOsOf4Si8Hlo9OnuWUo8fRECKRw4R6Mjm1+P2gWPZNDd6Ch5BDNC4ia3Qp?=
 =?us-ascii?Q?J2M/BpfinywtzFedHRsk2nShDfI7BekO7yBiFStFh/wTOyNqtHPVB9WY7KnK?=
 =?us-ascii?Q?tXeYcx7jSV5g0vxeidfNFVk9a+5XkWzwWZL8xYkqx/Mn6703qS9x6oqaBeRX?=
 =?us-ascii?Q?jCmvDO4s96JgEe2mgG4kXZkvmGp2VtPV0oSQcw7oV+QZlEPOZbSEhUl2EHCv?=
 =?us-ascii?Q?uMdrX/lB1xEYhbBabmGoKtQwDFosCzQ6f9TfIC3A7G+biBqe2pjS9qF4UzqD?=
 =?us-ascii?Q?V9ud1N/yNsR+FnD78SSRZB79V3ygkrS9iK4W7bcDEI/PrEDNk5WB8IjrVjgh?=
 =?us-ascii?Q?N4Daoh2ZMno6FUHx8wKnm5w5rrfzt4Mmo9yHj7DxVOXSv1J3/QsUS3g+NXUr?=
 =?us-ascii?Q?LIN+3hZYbVIAZcp96wntfkOGbw9MDTPvmgRaxPx9PKMOH/1csLJyKZOmn6YE?=
 =?us-ascii?Q?1Snp+iWygoUd/S5FN4peT5IUAIsiyHrtgpLAR8EOwgEnQtCQ7fM12PaAX2o7?=
 =?us-ascii?Q?mAUmQmXhjkrCwcCfFv/BWv8E58OVH6Rnayb7C8Qnt5+zvpBQN9YJpPsqbdX4?=
 =?us-ascii?Q?nhTqfTXGt2tNhKiwJh7PRra5z6zayw+2CcNYxpk1L7Na7Fc/VSyvd659gnXx?=
 =?us-ascii?Q?vlJQaXPc4ERki0SG0wKXqIL96O+H8H77ifAidCMqkL7P/UG7JMxu8lG88sed?=
 =?us-ascii?Q?S/FnyP5378FojzQkYcAlsojxD91vEhV9tMIGw9JM3dKKHHywe5UO8wkuh5/v?=
 =?us-ascii?Q?8cgk7vmRdxHDjwQQ1Q5Wh0+XaXzimowA/z2A8sbrBFpdvTEPV9y+YleTRmcc?=
 =?us-ascii?Q?/ZW8acaRDibqyRg15Kd3x9IcIfYPWctF6bRkFdQM+evtSSsy8E599KSIunuU?=
 =?us-ascii?Q?Nw1e9jcnRPBwBBpaZd/1WI8ot8fG5GD8Ew6VYEREoaAiOsCALDt4OPkQbJeG?=
 =?us-ascii?Q?CA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 732a9a9f-a6c5-413b-8af4-08dc2118e59e
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Jan 2024 22:23:19.6036
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhlQIEIeMgkMWW1BmS0vR0pBuDyp3PUCby80t1B/bUR4HCpMIJP3ia95ukDdTgQguGEWmMdDmsv9nP9PhzSOoDFSgk3CoQbMq0kknb4hm6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6576
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> Add cond_guard() to conditional guards.
> 
> cond_guard() stores the return value from _interruptible(), _killable(),
> and _try versions of locks to a variable whose address is passed as the
> second parameter, so that the value can later be checked and an action
> be taken accordingly (e.g., calling printk() in case of failure).

This does not look like it returns the result from the conditional
locking function, it looks like it returns whether the boolean of
whether the CLASS() constructor succeeded or failed:

 "*_ret = (!__guard_ptr(_name)(&scope)"

Even if it can't return the result from the lock call itself directly,
it would still be nice to be able to write something like:

    rc = cond_guard(rwsem_read_intr, -EINTR, &rwsem);
    if (rc)
        return rc;

..and know that the lock is taken of -EINTR is returned.

That would also mean being able to write "if (cond_guard())", which I
don't think would work with the current proposal.

> As the other guards, it avoids to open code the release of the lock
> after a goto to an 'out' label.
> 
> This is an RFC at least for two reasons...
> 
> 1) I'm not sure that this guard is needed unless we want to avoid the
> use of scoped_cond_guard() with its necessary indentation of the code
> in the successful path and/or we want to check the return value of the
> conditional lock.

Taking this argument to its logical conclusion would mean removing plain
guard() as well. There is definitely a code readability benefit for
having the option of guard() vs scoped_guard(), so it would be nice to
have similar flexibility in the conditional case.

> 2) By using cond_guard() it is not possible to release the lock before
> calling other functions from the current one. The lock is held until the
> current function exits. This is not always desirable.

No, that's not correct, the lock is only held until the exit from the
current scope, and if you call functions from within that scope the lock
remains held. So:

    func1()
    {
        guard(...)(lock1);
        if (condition) {
            guard(...)(lock2);
            func2();
        }
        func3();
    }

func2() is called with lock1 and lock2 held, func3() is only called with
lock1() held.

