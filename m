Return-Path: <linux-kernel+bounces-66034-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F254B8555A4
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 23:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 651D61F23F5D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 22:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 337EE1419A7;
	Wed, 14 Feb 2024 22:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="dAbUCx54"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786C913B7BB;
	Wed, 14 Feb 2024 22:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.198.163.8
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707949169; cv=fail; b=mq4mOknzSSWxOGz9zvOx3n1dEvXr5cA1xrfXY6sqLxoRc+81FaMnitRKc1f8WPbiS1lYeDtQz9hR+QfP/SYCzEE5tX+HBtB02GN8TG9jgWNyy1Ymqy/51/PDOgXuvK5Y/Gw8htqPZIhQnkUDKGP/mHTFDKE926xVGfTMJZSqzyQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707949169; c=relaxed/simple;
	bh=5/Zpypogn1QVqfSfuduY2EWQZaGnryLqL5DqX/C6wgM=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=F5TjkEWcLm0FrohBlukIZE+pLY+I9UJrHBVYIbLgug0FP6gJAMyFkELUPPbtfDB3XxaQBcV437rAbvqJQ/BEQ+HeMEgdgPesMCjRxslcdmA4moI6XX20wNmEIxmUsrLw6ymHNIKZqI9TLHhCHB/SziBGCwJYzkd2qDHYk2x57xk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=dAbUCx54; arc=fail smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707949167; x=1739485167;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=5/Zpypogn1QVqfSfuduY2EWQZaGnryLqL5DqX/C6wgM=;
  b=dAbUCx549BpSU8hH0AL1/HvUVgYBdZGUmmYCgqnx3pcakXdcnB02O9zz
   eoN5oqp9kHvVFrF+gWFYXec7I48cnEPrMckb+8pgYZiAzBTFWnm9p50dW
   1Ig6sXhB27OpBWvxQgj+a9VrCQlkr3gCac/rIYZjbr538AvQCWPkfi96a
   DRzYFWSaR8fTxg5iX0EQMv7AXu5SXNjRLvNPZBWHJ7EvLZvDCQU0sSjUj
   fiHd1K/gBdEJC29p66rrpF6bmguBBbi1KlV5TFiAxcb0YPokGmYfqEY55
   108JCDreKqazMhUCuroyRXjFQOug3Z1far7eBJSvdDu8dsgQEQHKPfm1b
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10984"; a="19535884"
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="19535884"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Feb 2024 14:19:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,160,1705392000"; 
   d="scan'208";a="3704598"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa008.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 14 Feb 2024 14:19:26 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 14 Feb 2024 14:19:25 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 14 Feb 2024 14:19:25 -0800
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 Feb 2024 14:19:24 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=X7TycAFC6FKfFAVu9VqRK0FHWO4HCWRGkw3/fFS1CKNKIhL47uT7qDMjtRck9xELsr6EtxCgm0/tUqTdWP1TqUbuArqxLqPIkVTSwA49HtD0oYqg5grBuF9mi/TsR9SUvsucet3OWH7pYl5soYBmaggounDK7wly+IJ91Ufe1Oe48xkehLtDrRz7BHZzoOgNF03heJ4HMXiWNmyFT7pikWhR2GC5i36BSKEvGTD5HNRPrperL+0npYnbyZNXP64gYX83ENfx4Z3X1QjjZkCNlnRRxefzROpCP9bp8wYplagzElbEKSFcvyKIwRlL1gxB/CdftoNR7VHfoU+kiwoMAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=N3ps54ZfmrQe92FLyKwqoYmoYI1TIZyL/o4jmOGrkls=;
 b=nxo1NljUr0fNfXdv5Pnv2dkIcSgd6v2pptLlvYRc70cXR8LtgYxhnClxbk80zXaNIM/e85hrxrUdHbNQNY9VNTEz27Ns0Zjd3Yw66ksZFPqXU1o2bbFzLSz2ThbhGRZA4sHTHFEjjX1MeOEU0UHddIU6bSENsAc/OsM0obwodUIrvqrToVEUXigNo7OJXk5nL/p8pC6I5Zw7jnEMlSOITIdiQ9uDx8gX47MdKhOKYEuJbvy0fkMIiyEOCE2k6pTelYDuowoc/qk90uW1LQTdfdgAkysyXJ/90+R103rjiQbEsiXEmzeK8vPW6McNgxj/zJ0OPcijM2YdoAStcCE85w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SA1PR11MB6733.namprd11.prod.outlook.com (2603:10b6:806:25c::17)
 by SA2PR11MB4921.namprd11.prod.outlook.com (2603:10b6:806:115::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.39; Wed, 14 Feb
 2024 22:19:22 +0000
Received: from SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59]) by SA1PR11MB6733.namprd11.prod.outlook.com
 ([fe80::9f17:e1f3:d6f0:3d59%4]) with mapi id 15.20.7270.036; Wed, 14 Feb 2024
 22:19:22 +0000
Date: Wed, 14 Feb 2024 14:19:19 -0800
From: Ira Weiny <ira.weiny@intel.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Steven Rostedt
	<rostedt@goodmis.org>
CC: Ira Weiny <ira.weiny@intel.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>, Smita Koralahalli
	<Smita.KoralahalliChannabasappa@amd.com>, <linux-acpi@vger.kernel.org>,
	<linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>, Dan Carpenter
	<dan.carpenter@linaro.org>, Masami Hiramatsu <mhiramat@kernel.org>, "Mathieu
 Desnoyers" <mathieu.desnoyers@efficios.com>,
	<linux-trace-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] acpi/ghes: Prevent sleeping with spinlock held
Message-ID: <65cd3c671cf86_d552e294dd@iweiny-mobl.notmuch>
References: <20240206-cxl-cper-smatch-v2-1-84ed07563c31@intel.com>
 <20240214121153.00005c97@huawei.com>
 <20240214102310.7ba53f3a@gandalf.local.home>
 <20240214181200.0000500b@Huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20240214181200.0000500b@Huawei.com>
X-ClientProxiedBy: BYAPR21CA0013.namprd21.prod.outlook.com
 (2603:10b6:a03:114::23) To SA1PR11MB6733.namprd11.prod.outlook.com
 (2603:10b6:806:25c::17)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA1PR11MB6733:EE_|SA2PR11MB4921:EE_
X-MS-Office365-Filtering-Correlation-Id: 4810070c-7b8c-4861-938f-08dc2daafee1
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 5vnl6UjdO2lf7/NY4lieLLZkw+l5AWNxuyyl3z2jJD/bslE2sWrkmEvzrt3I8aR/kGl5wTlgCLjrkdbuyjoRovSoQAaN4OHs86N/VP/SnnwacQTEbEZhjvxUWVncfOVTMv5tpfdd6oj8JW/dTOtVHOEpYINgbjZgDQ+JHpsg3OvE9yMBEHUEr0yijZ9VbYpIl1+atFbIznKaTkCzYy9I/URTsThZD/Mu6WuWcrhhhDOHMhWHY1Os2+wmxJ4D5xArM9qmM/+qPjsqWi71o5Lgq+YT4jqIOaH3e66YDLGHvNOcEqfpwm7pVfVsWuJ3BOA9JlnprSR+rNYG23tOuL6XEp48SQl4YA3NnYh8o3ltxYpLOSZ2t/0ryxojESfHPSONz5Hy92TwFbSyc/xYzodkmEujfV5K/dLXhFPwNJ4esXJRSRUuIbVsoZTF3fTyoMzdNfhrYk09vOTLNnt0d0YN6WKBTbkdlT/Kg0GW26btVGFDhYhCtJ8NmLqVZ5ASWVVyqjB1m491g8N/8OJ9WIprv6kzfLOyiTvhgp30cyMpoCviHOsm28IotRxl3KLrEZ5D
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA1PR11MB6733.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(346002)(39860400002)(396003)(366004)(230922051799003)(1800799012)(64100799003)(186009)(451199024)(8676002)(8936002)(4326008)(44832011)(2906002)(66476007)(66946007)(38100700002)(5660300002)(66556008)(54906003)(26005)(83380400001)(9686003)(110136005)(6666004)(478600001)(6506007)(6486002)(316002)(6512007)(41300700001)(86362001)(82960400001)(7416002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0gcQRnnE9lL3yWwMH5MfwC3LniXA9vM5qtWY7lJxxmDiimFDuQi2bNVFw5L1?=
 =?us-ascii?Q?wr4BfhP8KZa+Ih9WKZFOUfcIucOlj6lxHyKFk8hNWw4JhQ6LTj6aLa+5ldU7?=
 =?us-ascii?Q?FuYR+RjRbzdqzXDzSg+ghOaDjzlFwkYY5xuVWQGhtwmGSivnxH6iAJmTu8Fl?=
 =?us-ascii?Q?C3HwQmI4WKGxmN7bmgj5XOOoDaIzMuIslAxVfTJ3y1WZn0ds7n39vxlYut+j?=
 =?us-ascii?Q?5pCp9WrM3J3A3DeGAfC/nKZC0QB4YsnUNFPRb7ZR6Nl2EJwnJ//dBfLhCy4c?=
 =?us-ascii?Q?VuEYmAzguMJXmLkb1YJwTBx4o/9uj1A/IM/6LkKI1MeKbzGZTrY0Ya53TlBg?=
 =?us-ascii?Q?7hnKlnlhbDdhHXQY5rBdXU4mEEbwOZgVCdU77WdxD4H1T3bGrOf404lj9gyh?=
 =?us-ascii?Q?zLadmc4MRxH7Pnq/rum9ACSwwOctNSdFQ8hMX8FwS0WEx0YN8nhC0FMCZom1?=
 =?us-ascii?Q?beYJbf9NDvzrGnQTK+48aAmvCQwWcXV7udymdM3Xp4hMttUmMRHnT27kruIU?=
 =?us-ascii?Q?+Dci9pdT0hfGsqSeIGI94DyyaR193du7hemDQLeA6LHO4RQri9UBB4ghFylj?=
 =?us-ascii?Q?/20z0OBMYr2sWW7rv1fMY6Hw+6cGFyfYZMMc6GvU9abV9LhjNZ8eZXumuQJ0?=
 =?us-ascii?Q?TaHkcji/7UFQGYlaaq5Y5GhdYHb0SKLsBQYmIiI/nNI1X7NSB1HrsBoQW9QS?=
 =?us-ascii?Q?OeZZ3ajGQ5Y419BOK3f1zkjUmf+vbkRWBJU1pSPnreV91FJXM6sJXc3BZ7bJ?=
 =?us-ascii?Q?9xwJYmWIJeQ+8zj+xkj7rsEHeqC8YTolWLDPS5xs76s0msZBoNAejmZfIwcE?=
 =?us-ascii?Q?yr2RR8hsl8jkcmKDha7PZfu9JUIUGzX/t43N7vN2X5sLxWYgcQl37NSz1Hnh?=
 =?us-ascii?Q?ZDwSGEnSQoolrHlr3n63PWf0UzKSLiJKEJ5aiCYqsRRmA5znoJZmSlGr/888?=
 =?us-ascii?Q?JUgsZTf7IaktcFGljrswnBj48duyQ5ubPKI/VyShdh1Xdqr3L0wc724Xnmnm?=
 =?us-ascii?Q?O1aLfdqbMklxcxUlRIAFH+/Lvu4xB1fGGJzYiZy++NS/kkVK5Oqrrh5vWZk6?=
 =?us-ascii?Q?ru+/rtnl1o8vD5QBxHliK0VpiZD/Ff6vKwD4XpVpAYOe+7rQePGxrhzCqLS9?=
 =?us-ascii?Q?jdPGL6TQabaJk0Rt9h3a3OfyUWCv/dAris0IUx38+XfrP3TeW4yOSOtgHwhl?=
 =?us-ascii?Q?jXWXhgIY86F6+rP1QtEF8I6b9IJlwyzYVfeXWaEMc4HIHxF0UQdyLrZeOo8/?=
 =?us-ascii?Q?dSMqVWwPJB6w/Z1aP4p5CIJAtoqmFnROQH6kLCfWCeuZ456yhu5FHCqFBDRQ?=
 =?us-ascii?Q?CYBzgidM0m/xqJhV1NY5J/++5AilA1yclT5DQidjQppdr5xbvuj8lnaR0ume?=
 =?us-ascii?Q?tfXi3LGEk2K1KdxuQp9JlHc5XCNmpsdG8XA4buNNHUpY4x2Mz9K+71qUlI4F?=
 =?us-ascii?Q?oL8oI8JcG72T7VcpzfYm2Ok3yZXMUBDHHJm7uJO+1CcS3ztnSIFPSBGvv4CB?=
 =?us-ascii?Q?P4R60zpEpIZ0Q789yuQ3xP1XheN4VQaVF3V61enVG02ItfUQ15vKUpRqEZ8p?=
 =?us-ascii?Q?iO5mdOkYN6nIBP8x6W4vaWFgTQf7v22pyq3qXT7C?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4810070c-7b8c-4861-938f-08dc2daafee1
X-MS-Exchange-CrossTenant-AuthSource: SA1PR11MB6733.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Feb 2024 22:19:22.6147
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3j/rPannRDQdXKk/6cUotM1fdj06fF1XNEMfrHT3MzjGYqFGAK7gTa+/MqcvpuuW/6F3znh2mR1cXvBpq6ldfA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA2PR11MB4921
X-OriginatorOrg: intel.com

Jonathan Cameron wrote:
> On Wed, 14 Feb 2024 10:23:10 -0500
> Steven Rostedt <rostedt@goodmis.org> wrote:
> 
> > On Wed, 14 Feb 2024 12:11:53 +0000
> > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > 
> > > So I'm thinking this is a won't fix - wait for the printk rework to land and
> > > assume this will be resolved as well?  
> > 
> > That pretty much sums up what I was about to say ;-)
> > 
> > tp_printk is more of a hack and not to be used sparingly. With the right
> > trace events it can hang the machine.
> > 
> > So, you can use your internal patch locally, but I would recommend waiting
> > for the new printk changes to land.

Steven, Do you think that will land in 6.9?

> >
> > I'm really hoping that will be soon!
> > 
> > -- Steve
> 
> Thanks Steve,
> 
> Ira's fix is needed for other valid locking reasons - this was 'just another'
> lock debugging report that came up whilst testing it.
> 
> For this patch (not a potential additional one that we aren't going to do ;)
> 
> Tested-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Jonathan,

Again thanks for the testing!  However, Dan and I just discussed this and
he has an uneasy feeling about going forward with this for 6.8 final.

If we revert the following patch I can squash this fix and wait for the
tp_printk() fix to land in 6.9 and resubmit.

Dan here is the patch which backs out the actual bug:

	Fixes: 671a794c33c6 ("acpi/ghes: Process CXL Component Events") 

Thanks everyone,
Ira

