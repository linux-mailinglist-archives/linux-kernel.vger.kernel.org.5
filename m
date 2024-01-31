Return-Path: <linux-kernel+bounces-45510-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6AC838431A6
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 01:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F1CC1C224C4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 00:04:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A43CF28EF;
	Wed, 31 Jan 2024 00:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Yat1z3uc"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BCA91C32
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:04:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706659480; cv=fail; b=Et5EMbjSAw2ZZ8ocXSANovRAcNSpq1jU0p+g1pqhGfPL46LABTVpDIdTbdK+F/pZowLb2TPIAutwSznF/zBJyZgedPAP9R0yzGIAlAmWwu8uBnMOv5O2m8seGrUXna7Nza+sHAEwbrU9MQhpMpGnyR7gMVcQAY08oRElrVMBwWw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706659480; c=relaxed/simple;
	bh=Wrr4BS/8MdWVg8o4H0yHat0U6Ian5NHQC0sScOhUpLA=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=XHdQYiUxSe1RuAMaXfPJrUEcssjPCMoLZKp/Wbn7ZhZm6jrX/0zjJEb6g4/JZxBzvMG4HFT2Q52PDWowf+6UYn7xJyUzdwSJLg5MPbVPUSK+52UDQUq3iP6Ta3anNpCYu8dAio/XQ2Iw+7hBFvWyeFjFWuetqF5FGGSSIXTousM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Yat1z3uc; arc=fail smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706659479; x=1738195479;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Wrr4BS/8MdWVg8o4H0yHat0U6Ian5NHQC0sScOhUpLA=;
  b=Yat1z3ucqwNoavv5PGmYfh5KLE+4kJ3/d95BmsQrqIOV/M6F7N5X/pvU
   Heesjnh62UfkLRJPh4dV+8xzjbV8tiNk440P4HDlVn3971WHr3xfYWA9V
   YVn1YY+Smyzo3KjGpda8jeas1eY3m2VCMNzHgYUA//jbf19MwJLo4eVbR
   2I1jiisYmTFNwoOziGaf/iARWvnhKidh004cN8qv6kXsCeE02qeW7LNoR
   asHSSxZlW6/DFEqR6DwEmMAr7h1N/n76/7aD0ySSpG+LH6H/Rcpxhz865
   4VRiBs3mLMU7fE1eUaBqCxmRI1HxwBzpdsOY4DKB25JAXgpLPKpDYu88i
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="3294729"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="3294729"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jan 2024 16:04:38 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="907673013"
X-IronPort-AV: E=Sophos;i="6.05,230,1701158400"; 
   d="scan'208";a="907673013"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 30 Jan 2024 16:04:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 30 Jan 2024 16:04:35 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Tue, 30 Jan 2024 16:04:35 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jan 2024 16:04:34 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gEsLOMyiEXYhZhoUP3PsRc5ba/V8PNXPxcA0JkIofBLIJJp1xY+6MjYTnfVWAiNm9JGm/hgt9S0DB0Ti0zqK2WlDbtFXgyx2baSDRLZJxOxfPbuZHxmbfHHaL0HIjECVqvCjeLML7nRUsL6UVC2YFomKyBQ1x2kY00ifsdpYEYBryguij5gdRqzDt1G8cB9iaoFQfyqE/eM6m4wRCKEeypCSt+eRjyBGEKMlYlm1TRXw619flGtIeZIki1GTIaDMai3CC0+ZkdSN5CeWT8oAu4+n0I3rIO+INqZzAASWl+7uoTkEcYInhvJPcpkweeMw9P1GQ6XpZWaPMlpJid+bSg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=p+/0tr+CF3AVj+53XQLjoyiiYMpPjX5TaRdxAYKEbMg=;
 b=ODUFWbE8OJKdeHPL8qVeHJGAUubVF2QduG6I8TphkVCW7v8ig2kdkPYoDgZkCgxeqR2Z12qeXVIMpSl3gWDBED2scBJpwPu1XKd3YlwjdZLLwper3eZFhc2jRpcZ33p6GnjiyIPnXc8qEAyvLzsajE1TL0jL1qo8CyyMZHZXgIBvzDDlm/DG97VpgquVVJJeVDFss1dCn6KRF7yk3Tli1Qc2lC9bODSQsMD+yrJ6vcxBwzieRy29bHc7pIPABloc2EKUWwtcWjaD4hz3alC0DzCiCFZmw4tloevxExjBhDbFBq4K4hvEuNPbpf+w5QsfJkCDAHX3xJETJwOhTuQvMg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA1PR11MB6614.namprd11.prod.outlook.com (2603:10b6:806:255::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.31; Wed, 31 Jan
 2024 00:04:33 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7228.035; Wed, 31 Jan 2024
 00:04:33 +0000
Date: Tue, 30 Jan 2024 16:04:29 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Dan Williams <dan.j.williams@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	"Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>,
	<linux-kernel@vger.kernel.org>
CC: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, Dan Williams <dan.j.williams@intel.com>,
	"Ira Weiny" <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v2] cleanup: Add cond_guard() to conditional guards
Message-ID: <65b98e8d4f405_2f26102943c@iweiny-mobl.notmuch>
References: <20240130164059.25130-1-fabio.maria.de.francesco@linux.intel.com>
 <65b92b91a41a8_5cc6f29484@dwillia2-mobl3.amr.corp.intel.com.notmuch>
 <65b9434712b57_2d455e294a8@iweiny-mobl.notmuch>
 <65b948987e865_5cc6f294df@dwillia2-mobl3.amr.corp.intel.com.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <65b948987e865_5cc6f294df@dwillia2-mobl3.amr.corp.intel.com.notmuch>
X-ClientProxiedBy: BYAPR08CA0050.namprd08.prod.outlook.com
 (2603:10b6:a03:117::27) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA1PR11MB6614:EE_
X-MS-Office365-Filtering-Correlation-Id: 96329e5c-2fd4-4500-0b4b-08dc21f03422
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: y8jd9Gua56GPGU+wIuYNXAP+ow0REfpI654EJCeHqjoAXUIlsLgTx7X1d0vZgILLPYpjCls344scg/oBN2xfcu7wevGFpBQnZnOIgfD/AjPmBZCCmfY1yY7gysgI6q9Gb0pxWk9ubsEKiZoLVSAnjDWgjMT3qSaC/tqO3u1XChR5rSA4bUbDBdfF/kWE8zJoovrKu9jeFadHFp23VFdL4ox2BETumQok3CKJGZ86gqtlUzvrt1ZOm3QiKFdPGajSFnFUrf82XaJYziN5SuM619tcflu86aaWmeI7PyhuBAzyzgOiv5c6W/NnuYA3/hEexce+X07myZe2hdjmFQEIFtPMiqfM+Pg8jmbTNmWQGDbdQaSjw3tgl1n88xvs+lIYGg9Ftv47E1lKTxYqZ+mblIkY3xT0NpSvp6kgbsUZrz3U3hKQTqDqaZ59ClHnW7sg4QxiE4XEofevr+RLh03+cu2tGUYfKfVG7GwwlEzXRUT92oMC1VJ87vaVmTjIWW2SbGLGLRQTwxm9m5heDyMtyDdvCLhFBdQvruGFkrnTR3FlcpjN2GIr7/VUt6bM++MD
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(136003)(346002)(39860400002)(376002)(230922051799003)(64100799003)(186009)(1800799012)(451199024)(6506007)(6666004)(83380400001)(26005)(86362001)(82960400001)(9686003)(2906002)(44832011)(5660300002)(8676002)(6512007)(66476007)(38100700002)(8936002)(41300700001)(66946007)(110136005)(478600001)(4326008)(6486002)(54906003)(66556008)(316002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iweVt5j9RQ/0zkj9hICMAM+VK6WslYJcUwWCA4849nls7IdaZlqFTzaVNT4N?=
 =?us-ascii?Q?0Sk4HE8TJ1g3Cz1s3CWoNF9nlGvLuW7IRoMikw8f/+1tzx+nFhOV8L3SP+2t?=
 =?us-ascii?Q?Z8T1P3Iez9BaNg5tgc8kRbegqeAfDWVL9bpz7amtcS1zHPvNso7MYFU0qgb7?=
 =?us-ascii?Q?lpIjrnW33HQs7E4rmS243WqDCOPQr68/3WrU1qaYqlX0NF48MAlAVdjCjtyE?=
 =?us-ascii?Q?1NGliFqVwBOALqHys4Au8mNKPy0/0yHKtA6mXS36c1AHhdINFpAo1D0aeRbz?=
 =?us-ascii?Q?Pbrcvr5E/FMV+RzEuov4KLaVfpZd5Ug3K4IZLPN+0fbUsGqcBLfL7ze2RBjR?=
 =?us-ascii?Q?G5r2R9M5TLyu3DWWdClJMfPn1YVDq2J/8kxePNvrUABwIQo3yV+ykD4+KcuU?=
 =?us-ascii?Q?WuQFmvJJRtdO9u2SvrEvvL+JYzlGtBznvzUqLsRYBs04Tm3Kj3bD7RazY1Lv?=
 =?us-ascii?Q?365OxaBBKvvsd/4AIt9K2LWcVhCL0ffGD2r3ADgGxntH03yp5a+0VULAdXbj?=
 =?us-ascii?Q?ZR+EoQhiWpIk0THnFg/ue0kmbqT23PM1Eh4K4R8Gv38I0wez6HsE+AS+n4B3?=
 =?us-ascii?Q?vNvITbwPK5cZIORhA60/iGqrB2UdZkPAUARYLpHz14jjOKlJRF5dSsefUG2T?=
 =?us-ascii?Q?BlrYbctlQ3klc8B6kuOhqPSMWS/mlY+wewsvbqAfwNzMMXx6E1f4bl5pO6Ts?=
 =?us-ascii?Q?WVZZOVaxIHRBd4eBaJSFh33HTzDivyWTYnEHgtBj53MhSIBn1hG0ucahbxCK?=
 =?us-ascii?Q?gRgJSQeFwL7A6dT5IHU7B+ebz9RySkR7YTT5T8Wto2TblO7XxcyQHKQ9PqGs?=
 =?us-ascii?Q?iQv9ZThh2nYrPUBSWNt339QBNluXZlmI0ogK5H9Qz7AsOLHnkM/SCV/3D7MC?=
 =?us-ascii?Q?YbZUXcKWEpX+m3DFW5z8MJ+SGMt06L/b7u/6JDgRKnEJq63vgY14bz6NbMz1?=
 =?us-ascii?Q?3Rl0ztoK3zq0Isb0Qv8rQWgYNa7lIrH6sC2EqjJhfaxUlmFw7ooL3BPnv/ZC?=
 =?us-ascii?Q?bocoN65hz+OaIAtEAE9OdwbichhDkRDo2yDNc+y+dkGcOqAE/PHLQpgoGUZP?=
 =?us-ascii?Q?fd02AxVBYXM9oQaVQKqOjfgYtiaNNmwWfwO9fxQBd9KpQymVpq9C37pLt0SS?=
 =?us-ascii?Q?GKFb5pHoXG/Rc9rYll4aj+9SDPdswmjfr6KUmn1cBM5cshT2xnaQ0AVk2Oov?=
 =?us-ascii?Q?9D6FwKpd/dhFva38Xka8XYyOXkoeb6yhWEhwq6Cqqun/jQZRiaUTsvXeYkSN?=
 =?us-ascii?Q?x2Q8bBTAGh/3Fv4HmVs1lzDkTeic0RlgOSBghH0KL6WGxYJ9s5AnHKPxumY+?=
 =?us-ascii?Q?4CXWDe/05shf5b9z5JJp18TwcS1VLDq1rJH/XI+x8EV1j9NGXBG0pU+of7r+?=
 =?us-ascii?Q?Vpk5fsjRIkUBB2v/cE70xiJ0QiaHG+EWnqTU+RhRO3PVfgv2CaIivSRk3GcW?=
 =?us-ascii?Q?UY00YR3pQhdDLf/VUvGQG5PF3D2GJDwWf45SXzQxegTZZGG4cpU6rHeVzkBs?=
 =?us-ascii?Q?zxh5VMbT54jzQ+NbCOFodosVp8WnsuFNshB1J/VKsEabXCxxAoAH2mfUgE8H?=
 =?us-ascii?Q?BUWhUp8wyum8Ija2Z0C0PBG0iRwSfVNaR34mhOy6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96329e5c-2fd4-4500-0b4b-08dc21f03422
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2024 00:04:33.2184
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: OkSt/FD8dUsLOqRKyeYPKwXigmfxu8VULFySPe6HsC7WFVq/KzOz/9bBylBmQm5Fjp+SRTpgIhLkqTOik1HzQQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR11MB6614
X-OriginatorOrg: intel.com

Dan Williams wrote:
> Ira Weiny wrote:
> > Dan Williams wrote:
> > > Fabio M. De Francesco wrote:
> > > > Add cond_guard() to conditional guards.
> > > > 
> > > > cond_guard() is used for the _interruptible(), _killable(), and _try
> > > > versions of locks. It expects a block where the failure can be handled
> > > > (e.g., calling printk() and returning -EINTR in case of failure).
> > > > 
> > > > As the other guards, it avoids to open code the release of the lock
> > > > after a goto to an 'out' label.
> > > > 
> > > > This remains an RFC because Dan suggested a slightly different syntax:
> > > > 
> > > > 	if (cond_guard(...))
> > > > 		return -EINTR;
> > > > 
> > > > But the scoped_cond_guard() macro omits the if statement:
> > > > 
> > > >     	scoped_cond_guard (...) {
> > > >     	}
> > > > 
> > > > Thus define cond_guard() similarly to scoped_cond_guard() but with a block
> > > > to handle the failure case:
> > > > 
> > > > 	cond_guard(...)
> > > > 		return -EINTR;
> > > 
> > > That's too subtle for me, because of the mistakes that can be made with
> > > brackets how about a syntax like:
> > > 
> > >  	cond_guard(..., return -EINTR, ...)
> > > 
> > > ...to make it clear what happens if the lock acquisition fails without
> > > having to remember there is a hidden incomplete "if ()" statement in
> > > that macro? More below...
> > 
> > I sympathize with the hidden "if" being confusing but there is already
> > precedent in the current *_guard macros.  So I'd like to know if Peter has
> > an opinion.
> 
> What are you asking specifically? The current scoped_cond_guard()
> already properly encapsulates the "if ()" and takes an "_fail" so why
> wouldn't cond_guard() also safely encpsulate an "if ()" and take an
> "_fail" statement argument?

Maybe I misunderstood you.  I thought you were advocating that the 'if'
would not be encapsulated.  And I was wondering if Peter had an opinion.

But if you are agreeing with the direction of this patch regarding the if
then ignore me.

Ira

