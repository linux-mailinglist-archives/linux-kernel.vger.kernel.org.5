Return-Path: <linux-kernel+bounces-47485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBF4844E82
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:14:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01CC21F2C66C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:14:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF47FEAF4;
	Thu,  1 Feb 2024 01:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fCa1kPim"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2A03B191;
	Thu,  1 Feb 2024 01:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706749940; cv=fail; b=mnu/nuo+jm3Nlfb+3MtISpfa6ik9K2WYSProEwDrpJpDCDlK6wCmUwuCwBT7gkRoGwVmC4ifYsMy8OVlnIUqNQcmk+XmHJWDXoEW5XmJCy3AHfEp01Pq0DbEJnf/IH/FcpBJNmnM/ZXj4P8V/2UK8ZpX2rw1bTkQveay0tg68xQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706749940; c=relaxed/simple;
	bh=AiPR4kyVVnsYPtVNEwrX2vTbuIbc237GnnZ8yAFJrTo=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=COv5RPU0Hx0MsQLvJHMvkSiU53esaYp51UehMQBLYaYvqFoDnE3oNoyc0jZB3VX9spASgN+nOUBPZzEqCletsH847igLj+UB7Gc9ZIIam2ZRZjL/PSzNCUzKwoe/TYH0XON7mu0r1o90nTjjaAp3lgFj7/G8auK18cFJ7FMd3N4=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fCa1kPim; arc=fail smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1706749939; x=1738285939;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=AiPR4kyVVnsYPtVNEwrX2vTbuIbc237GnnZ8yAFJrTo=;
  b=fCa1kPimFCtIZwXUDg+m6NSFUQ+62VeOCGIv2UtZgoIZtuYtmoLazR7+
   /z1rwu6uOb6nura9+W8EsNlwxfRPxObt0A6IkpBJZrTQ8rVdlVxcXSnnw
   snKGSGYOJkqqExGPhLSU07lpT6xRz/tHpQfD9NqDdSsTJEezP0Jmr603N
   RLdkOcBKjUJVza5JPuewejUXdq4q3oqxmC2gTFRT8fxjLe8MXkR7KKXyr
   08gHGvfzDsanOH6JGECW4mSTqeTs52qQJoKvB0+Fkk9O9/FoAk5E9/A5g
   UWq3syNR6tdLy5wNshtvuQnfMBR0pJXeA5OBKXZ5h4kyBPmWYxBJy7DKH
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10969"; a="11146750"
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="11146750"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2024 17:12:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,233,1701158400"; 
   d="scan'208";a="37058842"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 31 Jan 2024 17:12:18 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 17:12:17 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 31 Jan 2024 17:12:16 -0800
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 31 Jan 2024 17:12:16 -0800
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.57.40) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 31 Jan 2024 17:12:16 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PMgesgo2C67aJ28j7Se+knynBrsCNVa+KWxpq5f3vF33VTILUvkJh/NHy8ffBj4ZPxy4Pwco2Yb2qZU9hcXuXkp1PmoFfdjY12QEtc2J5PRAqraxbsX9ydVKt+sjxpNfp+AYkHOzc4MOKzRbl5a/wvVbSJ2dDlDvsIWk1MP2q/lvP1QJvbwX1UU69KjKXCL+uQaEWZCKK8RW/v1CBxlpJoregbRRItx4U1uR+PmDG5usGwZq/yehLZjOFqVcRixcVfkOT0BHtabX1yz3F/ekr8jhgFd4ZTUfVcRJR2j82ZmFcnexvRycwwJcWGw4troOX1XcprGI1SNza6f+gMnLFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ROHisXIJOFSbGJ/PNHLqUmbrI3A4moS7CWnDhY6j98c=;
 b=gYU5JbGHaa/AqdwzXObzDPAkwiwNUkfh75pVNuTSRWluBfQJBNRCQrR6RHTSkSc0/tKENEQxo1SRZrZ4vOEf7aiVAWTIwamHHXFUegnt+UwmXoRPgi4QT0DYe1RtBKuivwbkxHkuHsIKYMbd13PCXp4w45jDoV37Ii3XfVNJJfQSY1YulowJqR4w3YuFy+BH3yIXgruQGyT6U08J4jnxHkB5uvs+LxpDnLzhPYsVxV2jUx0muKy7UOj3eXflOmVVulp7m0wOkbEg7zTg0OFSmofLXaUrdtWoa3If1DLT0hSzgZE4fdxiU5Gsp8DBdhAPdFj3HI2l45HO2qUnmK9F1g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by SN7PR11MB7667.namprd11.prod.outlook.com (2603:10b6:806:32a::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7228.36; Thu, 1 Feb
 2024 01:12:14 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7228.029; Thu, 1 Feb 2024
 01:12:14 +0000
Date: Wed, 31 Jan 2024 17:12:12 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>, "Peter
 Zijlstra" <peterz@infradead.org>, <dan.j.williams@intel.com>
CC: <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@kernel.org>,
	<linux-cxl@vger.kernel.org>, Ira Weiny <ira.weiny@intel.com>
Subject: Re: [RFC PATCH v3] cleanup: Add cond_guard() to conditional guards
Message-ID: <65baefec49c1a_4e7f52946b@dwillia2-xfh.jf.intel.com.notmuch>
References: <20240131134108.423258-1-fabio.maria.de.francesco@linux.intel.com>
 <6168759.DvuYhMxLoT@fdefranc-mobl3>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6168759.DvuYhMxLoT@fdefranc-mobl3>
X-ClientProxiedBy: MW4PR04CA0123.namprd04.prod.outlook.com
 (2603:10b6:303:84::8) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|SN7PR11MB7667:EE_
X-MS-Office365-Filtering-Correlation-Id: 1a02c0cf-7204-48ea-ef03-08dc22c2d348
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: QVbXBJD7TS8Ijf4fZGPLYN0W9VfLe4GDlEy9KV1J7GN8BNhYop7acJM9OwLS1x/pf9+fk8IEtm7mQ+Be2LChb3n86qfdNRdyYQ1XUQKHp8UYHAY4bjZcxtuQACQmg6XtWKDn+JYeM55RR/nN1QVf7agxQcTwpYSZGmhN256F0y1SHwwgIWG67u9epmFRrOO1V6Vf5nI5H9m6wF8grxQFLqIyTz2G24ndKYe/UKJ5isrC9fpOzLkV7jI4mmup/g4bcarMbaJifQ/GyreF7L/YsXO0d4ybWG8gTml/7Zr9S7MDkHLNW9L57PXy1tnSYFoDt4YdX1rjM/0g64w/3391uGNj+r7nj7lAkQBsqyNho/wt3qaplJR60yN6qhE5rHzNCm0JjEnO8o9Ad/TVS82JQohOMhHeJIXfvaocS/eUBCdtUo3s+Fzrhs9o+wf3B4ZPCUaEDcqBGyQ0bVIjPtsEczUR7+nhywtp6/PsunoSXtqL6Rsgvt9+/DAKYuGFD6oRX2qiBaPss9mBq+3QF1xONRGwUKa5Et8y0XY6N0qOfvpm7UEGvP+BI0t2VMqQew97
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(376002)(39860400002)(396003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(26005)(41300700001)(6512007)(316002)(83380400001)(9686003)(478600001)(6506007)(6486002)(38100700002)(82960400001)(54906003)(86362001)(5660300002)(4744005)(66946007)(66476007)(66556008)(110136005)(2906002)(8936002)(8676002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?G2eOMNQsyf1BSyN03o5OdjlqXjjlaDSMekkOfzUdBKy1VVEtYYTK2Z6uwB/3?=
 =?us-ascii?Q?wj7Ds9otddVAuxUTY8ZRwYMr55euB23sj9/2dHQxIcPPpk/I/1LyHepXMzGO?=
 =?us-ascii?Q?q8J59GtSoiiHgnI3Op7V3vdvT6V/oZnjBmmFmnXrCtfHDX3SbFaPwZtTyV5r?=
 =?us-ascii?Q?dggPoC+QA7/Z006YE4f2hz8uNL0n/xqT7aRsl59cBbHnJo8rp8ESpjpEwOlW?=
 =?us-ascii?Q?u40QdYLKXDy//aCajrvD9htwaHK0Ink2lpe0LBuZXBFkS/L42Gxl3os9xksD?=
 =?us-ascii?Q?spo2LjTYXXN4WzMYAt08MgzeutOyuakl0yle+QglEl1c/EAxLKLYeuE+mS6w?=
 =?us-ascii?Q?IgqumGdtTg0DhVQT3dnuYECfcAs8p+C9KrRVLP7yGPvadCUzjFjcCGs0KQzm?=
 =?us-ascii?Q?gBJ22lVVFNPqG0k1ucd39xO3+SO2WXaBNU/a3Daz6Qub+bR8bFyyAb2Msr50?=
 =?us-ascii?Q?NmyJTMbueTRPYiDqIl5cCgF2eqAWPN0P0SfNf36BhBvV/Vkcx+FaBAz63vSX?=
 =?us-ascii?Q?BA3irfvTBnGNhsGe+Qj7UN8xgDaIir/IJ+7fwOT38T6QXU6h6uizXnuiNBEn?=
 =?us-ascii?Q?E/LxJNHNGKGKX6tmzghupDULn0adYQIN3lK0tfnmtI7pF9SQVacV0IgCjUGm?=
 =?us-ascii?Q?4TczoAlvsi8jRAAsMdH5U9Si5FjZuJuAgJVABcbErdQ39X1bn2SL/cvUa3m2?=
 =?us-ascii?Q?xLXv1044TGAUNqbaPMgTnZkTz2T8Bsax4dq87t97aJYAkobX5Jf66AcnTZOg?=
 =?us-ascii?Q?eZzfy+ptOKV5Fy/zJXBlk5Ta7JnZ9XHNSqKVGHJ3gmLOrpsit5mphJm2xYkP?=
 =?us-ascii?Q?AjRwR1cl0URp591HlWXINKEzLmd03hodMdOCeoggtRovpHC7FWzaDiQzYFbj?=
 =?us-ascii?Q?Ehy7TORDsWsmzEDh3jz1tHCOmNw15saM4HXEgcDhkz87CF9+qNufbXpcLGeW?=
 =?us-ascii?Q?H+jvIuvuA9Wj2cTUYq3I3PTo4Zzb7wtyf2rdvY9210G+DRfNqIweGZ14Z9h7?=
 =?us-ascii?Q?3ceRef35IP3FY6QejshXtBecsfB8VSpah/ErwTdrJIjxmlFxMir61Q8BHp+K?=
 =?us-ascii?Q?Td9haslH0a0ICXVHOsNJxpc9hcNKQj8lp8LL4bmXL+yB3Kem0W652b8b1fVk?=
 =?us-ascii?Q?RaUu+4Ek8LiGGfef/WkccIyjWI2Wix+oZAkclk6K9xjRscEvwM0nr2YEVOI5?=
 =?us-ascii?Q?4+h5Ll4IshC+ujPLWqFVXJlNTknlqjYLjkKI+qjUuQi057DfkbkVbqGpAfkE?=
 =?us-ascii?Q?z4lSpWW6Bq9qIZkI4CLDcxDS90FS36qas67DmYD9/mRpINa+j6Ubp0BEyUfH?=
 =?us-ascii?Q?zk+k/uN5PIHlea5h1ImW7KFcwcwVtrge2VKPZ4XU/A/GCh3CqsTo+0/mk7pu?=
 =?us-ascii?Q?Snb9FJSVmquMTTmQoFos856TDwTUfDiXMzzeRSIuZejbDBc7XMNJMehWkrdN?=
 =?us-ascii?Q?GS/1jeP9nXn2PkPJSbw5hUM51gGtqWgdCIWflYAQsmShVWS2K1grhL6SN8/7?=
 =?us-ascii?Q?jpp5q6FB9NQI/sBsTwHUAnh4blRncLDsDSKoWoFshLk9KCgUILYvnk0aBqtz?=
 =?us-ascii?Q?1lQwx8AwU0js3Y99EZfExGEv5lyOYTQ7Su9PMcAKNLpy+mb6cO2Nf6eTb7OU?=
 =?us-ascii?Q?RA=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 1a02c0cf-7204-48ea-ef03-08dc22c2d348
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Feb 2024 01:12:14.4501
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JQqdGhR2ZXPgi1ZETPcfut0PuD29eYWB+nWm6o6aK4R678ESWAbnlVx5UQz+lFwV+vsYvgFk5U3YLoOOYl/hZzUqgIhA12jyOsUD53UJ74M=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB7667
X-OriginatorOrg: intel.com

Fabio M. De Francesco wrote:
> I just noticed that this is not the final version. It misses a semicolon. 
> Please discard this v3. I'm sending v4.

Ok, but do please copy the aspect of scoped_conf_guard() to take a
"_fail" statement argument. Passing a return code collector variable by
reference just feels a bit too magical. I like the explicitness of
passing the statement directly.

