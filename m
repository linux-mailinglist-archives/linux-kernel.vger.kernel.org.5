Return-Path: <linux-kernel+bounces-10000-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 12E8981CE7F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 19:32:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7D9CF1F23304
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 18:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B7C2EAE1;
	Fri, 22 Dec 2023 18:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ncNz7KwY"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB5892E845;
	Fri, 22 Dec 2023 18:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1703269893; x=1734805893;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=Gg3vvLyblVZA4PTddfFXDUvS5D4wk/EVm3Nue/7qn6U=;
  b=ncNz7KwY9Ec8fnS/dOSTS75PXG+AJ1SvbDRGU9TplTS6RS0tuFhzK8cx
   8Dq4cy03/DT+fkb2gDsfP0SP+5+GWT8UGnxiP+vqu0taROzh6WUuAPxjJ
   h7S63mSQW80A6JUyDDAAGAvs+qvduEXVahaed8gQ8QKAMhdIzNjCeDdN+
   D4nsBX0p4Zhn9hlWg0sZdeZ6xwCICvt4uiLI7LynhjrJE0OCS4tCXlaB5
   NJCneQZNht6uxOU6WxVs34lOPJiMBrd5YKzQc3KMBfoM1JoNxdDAk7Nmj
   boLAoIAbmRDXQVG/Lfrw8Ev44ZcpbD6r/M4AcZr2cdCTbbZ8/i3LHkveS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="399968829"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="399968829"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Dec 2023 10:31:33 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10932"; a="726843007"
X-IronPort-AV: E=Sophos;i="6.04,297,1695711600"; 
   d="scan'208";a="726843007"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 22 Dec 2023 10:31:32 -0800
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 22 Dec 2023 10:31:32 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 22 Dec 2023 10:31:32 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Dec 2023 10:31:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cCfza24FR7ndwGsiJtjGkwk+a6hpD6RaGOofgNSfVNnEm5IVQFvGp2/tBk2TYLuvaIIjPUdVWp9rN/etgy3gYoxMnOHUEXbwTqg86cs4Q0Nbq8tWIrW2dhW2NIHnJYFjhX8zYzzft/vkxDfgb5UJTWecxJswd+zCciofA8fedKfTl6YRzZh/dnOyhKcDO5j8r6JTe5N257A4arlRRIldOQMJysWBNbAnLLnCMwBRcBA1VugxUoTDqtLEchhaFtHVgOLWsA3xsXfx3FrPyxhZTCGYVl5TIxSZTk4SXpwCAawL5fpK5ICvJVDAc+xUrj8It54KISBuoILxVirPLJQoAA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J/tIomK5XUqgpLNFkIwlax/0EnuWTBShDjZ9HeRnY6s=;
 b=jX7XqmAMRyuGqX4DECWlFx+qaoeJ5tsho7eFSCfOmBo5ii4eApBonJtvIK/EHmi8yuNiX6Xn+g8yxbG8RKDKgofy+qIByMcY+cXLUtcg2TbaqWSl9kot8Tab4mSkfvqVNqfNPpCs16Zq9072xhNLSORShUkaFgd3GLo640o3UvlhcJoNaWFgjQHVk9O1x9zd28Eq+H4775wPxUXWsnFEL502/GOWBGqaDr8KwN1PFmaHCfeJohcGH3lemx5wuLPms0tW6PEQDoAJinP+aiePjpIeFch180XCYQ7aBoM4yoerc7BGv7JxHUwP6LzOmhduXmkICj2rO9mh1KpT6evUvQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by DS0PR11MB7579.namprd11.prod.outlook.com (2603:10b6:8:14d::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Fri, 22 Dec
 2023 18:31:30 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::da91:dbe5:857c:fa9c%4]) with mapi id 15.20.7113.016; Fri, 22 Dec 2023
 18:31:30 +0000
Date: Fri, 22 Dec 2023 10:31:25 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Coly Li <colyli@suse.de>
CC: Dan Williams <dan.j.williams@intel.com>, Jens Axboe <axboe@kernel.dk>,
	Xiao Ni <xni@redhat.com>, Geliang Tang <geliang.tang@suse.com>, "Hannes
 Reinecke" <hare@suse.de>, NeilBrown <neilb@suse.de>, Vishal L Verma
	<vishal.l.verma@intel.com>, <linux-block@vger.kernel.org>,
	<nvdimm@lists.linux.dev>, <linux-kernel@vger.kernel.org>
Subject: Bug in commit aa511ff8218b ("badblocks: switch to the improved
 badblock handling
Message-ID: <6585d5fda5183_9f731294b9@iweiny-mobl.notmuch>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
X-ClientProxiedBy: SJ0PR13CA0227.namprd13.prod.outlook.com
 (2603:10b6:a03:2c1::22) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|DS0PR11MB7579:EE_
X-MS-Office365-Filtering-Correlation-Id: 5d9cbcbe-6cce-41ab-2c3d-08dc031c36e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: UGZ+AdCAiKw57YeaY+eq+hRZxYu1siP4Vtm+6xRvXwFqdpiDXpUMbstd4boFRYKgg3P5EPAKtt91d7LOawzyQ/Gakoa8db7klvE0LC2/vySTIghUk+KOsmIIJIHe3v9lGh0aMOZ6Ux3NSz3bUV8RIEzQm22KmkhxTCM3ZPV0ITnQr8btPPoCIp69ApFDXSGqYJXUxNSQxMHFWhrf4F5VrxDeRUFbdWT3nAaAV+/vwhP68XvP8S2Odnk3Qfl5vzYYO23NnY7ik0gd+Mqjd399p67NzHyOwWo5BEuJxBSJeFJSnDDJElUTOoXTayG1Gz9/rjUEobdC5KJClzaiGsrRdukWME1UJqm0gtMpBuwsMJ4NwTNjW8/roCqTl4mGLeltVIorWN3EhH6TxMqf8Ng7zuJtPh6AfkuPd2f2ElZdKOLZm79nLWA0Lklad8zN0QoU++4M7pbDtSjI8RBDFaLft7u+525o2/68KnX0ysgu2HSUihZYFK5r8suWN5Ct8UqbfXQtb4vgwf3mB0USpvbWYQmdzgTTi9BHwe0bRqizLITGfjSP0Bd7jd8tNEpdudMC
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(4326008)(8936002)(8676002)(66476007)(6916009)(66946007)(66556008)(316002)(82960400001)(54906003)(4744005)(2906002)(41300700001)(86362001)(38100700002)(44832011)(5660300002)(478600001)(9686003)(6512007)(6506007)(6666004)(26005)(83380400001)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XJf4LWvmIM5QMbhqzzBSr8YV7A4+FJUv0emFExIKMoY9ESEo0M1nHjHT4Shu?=
 =?us-ascii?Q?FhnquygDTkbZwWTy/D4AqcGkUfoLjLi2g6J4CpKi/1CmcuOmuwTbpkWlSDRe?=
 =?us-ascii?Q?6S9NHi2TZHqr3+uSRtuUq1xjIOFgP0n7cwX4rZmiR60RjdRcdhszkZ2ldPGw?=
 =?us-ascii?Q?pcjzlz1NijjaG1ygIRVb2hVIxtFwhkk03oDzMOrDfVrXTamWuedX7Rhh6oGQ?=
 =?us-ascii?Q?l6SATA14T6U0MHzMqo9hdrMdCT54YjBkZrUsOpmUtcAPboyjdzWR00RPdEyo?=
 =?us-ascii?Q?Nxuyi+ArLK9jZE1c2bBOuGELlc2tdNg52T5qZRwPZEYXqjjzHNPWSTHEY9Mp?=
 =?us-ascii?Q?GYD5gbPnRnLxQlvA8FjgYmjUCaVfAyuvSKiL1byzbZQ8v7KdYXkgFxEXTtW0?=
 =?us-ascii?Q?3h3nCZVXKo4GzGUq76iid3iDFmPOuAB9AWs6EEdeL5+llwxHyu/l9f06KKJz?=
 =?us-ascii?Q?4jxgtvllf1uRdC6rKbJXV86gMeg/zEniD6+m9scuE8tkBDzcw1Hyw88+HbzQ?=
 =?us-ascii?Q?bzxws6lVvGepc5B7dDks8RkJGanPfqUomwhIKturL8gOmPOedqOi8x0O20hx?=
 =?us-ascii?Q?oUNIRVE11JnSRhxiwShorRcGz0//8UivLo8zm/Xwl6yM+0fuC04OcKDhR7Cf?=
 =?us-ascii?Q?/NYSE5z5pC/iqbLdlj8gVeCmHW/f4blUBEhvzrw2wSlMHRw43bjAdxS/HIFt?=
 =?us-ascii?Q?WggcfUCW/Zaaa+VrmjWSJKcOheLInYULFvAIu0aoYzcitkNTuz2jIWaFlf36?=
 =?us-ascii?Q?slA05Fn5C/eBg52e4XT0qzUsMc8D2Cesxu6ir9qgFDkxwSz8gOXrMawuF+Rc?=
 =?us-ascii?Q?2wjx9FK1WzSmaO581XV867tlQG0pdsIYQhMTU/WqdqJkF7AUyCaILEdJetpV?=
 =?us-ascii?Q?usZg0x8Wwig6BxGLhJ39EotRlkPAnjaZT+uov4ncSSg2J4MuEvYfPzdgr4Gu?=
 =?us-ascii?Q?WUTAxqbHygKpGLJa+nmJsoYrjCgtko4leDp0E4AwYGbPtBOk3NgkouPjkqhU?=
 =?us-ascii?Q?N4nmrvLf4O/u4Dl7lI7NxToFOr1JAGkQMN62HKJFlIUqx1MMarMD2u4OtjD2?=
 =?us-ascii?Q?j14O9gSXYSrDzJy/ZApTntMwmpVUxWbg7nwo/jm85/DLsbXlQLXJMkJlWRZH?=
 =?us-ascii?Q?xSrNDgcSemr/HWFqQwtUoxmCZ9Trc04oKkEZ0Og2wG6ZSZ8wHpuElByCt20b?=
 =?us-ascii?Q?Zep95Qr7OSBJiStUOduECWlXWvJEoSTgiXH9zdixqPvkq9SadXexmKgi+B1K?=
 =?us-ascii?Q?MSvfdYYqZLmXejrhNEi2r9KJBysenahYIc84AH8uCGf8WqmmG/VoVNeGEZWr?=
 =?us-ascii?Q?fbScJ+t3nMlcacAlC1H4p8N7P5QYVLWs/EInTuPA9WkRGug9lb365dcjyWjN?=
 =?us-ascii?Q?jRWE3VvW7nONPT++UQIOSeYHZinHncvJXGqlbtba/CtKGN8mNmfz/yBh7KQX?=
 =?us-ascii?Q?4vK00ssmLPJM6TkXOCOPn+Gxq9xfIGEDIvQOS52p2qEGfLi4KNSzs1+/b6+E?=
 =?us-ascii?Q?IG+SOHNiqAYKFqxzRgMT/HinuBSftdz/OnpphFdayRfnX6r7yNAyMAFNldqs?=
 =?us-ascii?Q?RzoMsCelMhPSCZpSH5Xbn/u/nQbckraHdxFC5vf6?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d9cbcbe-6cce-41ab-2c3d-08dc031c36e6
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2023 18:31:29.6898
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lza0kohzOc8LqN7Sat22as8eGRbmBS2QalDW31H1+9XLitTU3fmVbFwxFq908GzgPvtYEZQC3R12FOAx6nm1BQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7579
X-OriginatorOrg: intel.com

Coly,

Yesterday I noticed that a few of our nvdimm tests were failing.  I bisected
the problem to the following commit.

aa511ff8218b ("badblocks: switch to the improved badblock handling code") 

Reverting this patch fixed our tests.

I've also dug into the code a bit and I believe the algorithm for
badblocks_check() is broken (not yet sure about the other calls).  At the
very least I see the bb->p pointer being indexed with '-1'.  :-(

I did notice that this work was due to a bug report in badblock_set().
Therefore, I'm not sure of that severity of that fix is vs a revert.  But
at this point I'm not seeing an easy fix so I'm in favor of a revert.

Thanks,
Ira

