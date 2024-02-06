Return-Path: <linux-kernel+bounces-54203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F47E84AC2A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 03:25:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8AB9B22B66
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 02:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4F657308;
	Tue,  6 Feb 2024 02:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iZPqDp7G"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8556D57300
	for <linux-kernel@vger.kernel.org>; Tue,  6 Feb 2024 02:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=198.175.65.21
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707186294; cv=fail; b=JDyPoiiAwNPKQ18ybyhIR5mfovfo2qbJwLqycQ8oEeECinNlyjM03pHhu2ffQ+C1xjZOKpQ+p/J7BH4GHGfLVGJa4uMqeZsB9ulo0KX5y1uevEMV2hiym+25xPE23xwFGHFOo+Q3SdDslumd8uJzXCZQqVWzAvmAcxqLE5HRM7U=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707186294; c=relaxed/simple;
	bh=Ec2bgXs56Gwkqcm0cHYqmRya3GpVDbV1Jaojd6Q4qng=;
	h=Date:From:To:CC:Subject:Message-ID:References:Content-Type:
	 Content-Disposition:In-Reply-To:MIME-Version; b=RwQRY9H8eLc31nNSfde82GNsMNX2YzST/QV0h5bsdb5LpF22Q5zqbI7ZRJrB7lf0++IaYLmLlY3zhFHmMkk2ebkNejXdTr/7qt57HCM0MqAg8qhV41x3AyGt+LBbuK7w/fZdKWHOVjUiaXuacYMDXz7kGGRLLTGGiBMKYCUT1ow=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iZPqDp7G; arc=fail smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707186293; x=1738722293;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ec2bgXs56Gwkqcm0cHYqmRya3GpVDbV1Jaojd6Q4qng=;
  b=iZPqDp7GG0tPBFSCJXWXz4TczvmTkjEyJlt7pSzRtNt/gYVL9ZpGo7vR
   alCm+Vmg/1RV+ernqMgW5wT5GYU95Mej05hWqi+SqsZNj6rL0dnkoEIyb
   XA/8DKNns+iNwALVrDKKvBKm/CVsMEC+zcsAorBzza+zrV3xxBNBzsRRU
   UUtA2ywuBIts8nCBMJFU5Pr4gIHfpjBpNoNz1v3KLTDs7tW9GZIuVnGlF
   xJKe2Z112S3Ot3WD00VuPPaxopyT+8E0tfDL501XDrlOIE8oWxC5n5NC8
   3S+GCijYFWYjxCoIt90z7FYdbKL4QDUCayN4y8wfVh6vr/OaXOVAt86Y9
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="556930"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="556930"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 18:24:52 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10975"; a="824030678"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="824030678"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Feb 2024 18:24:51 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 18:24:50 -0800
Received: from fmsmsx601.amr.corp.intel.com (10.18.126.81) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 5 Feb 2024 18:24:50 -0800
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Mon, 5 Feb 2024 18:24:50 -0800
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.41) by
 edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 Feb 2024 18:24:50 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Iog01Ne5q8gXk1lDuoq2oWip62iBr9aOWLF6NLCyB3SVqYNeUPmPXIFJfPbcBMh1b1jUP29xaYDHv/fVakMYOrJ6E/VrEf/tvwauZLCXI7nsmv052qnaS6yhGujKpFp9nd4lG9WJfRe9Cvu9Q7X/muV+XhZPgWyISMOOmbheP/+ZAg5Opa0iLSnPc2w0GT0qJ2R0O23RuxvK6yx8ibhm2hPmfO7xk83f/ZjxnC7ITD9XZpxT4iipVIgJBlFWPCbSdz9ZBVURLoPimB29IdQAQzieV9Kxvhd8Y1RDnLerTNHZS3IaZNhjLofwVBya3xpN34r7ZZs8NJzAl85p7/pWfA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Ec2bgXs56Gwkqcm0cHYqmRya3GpVDbV1Jaojd6Q4qng=;
 b=c/OS2g88YVLF9nuffT0hXr+9NKLabIR2S7oGnrxATbPzM7Z3njjU2plPQvBhltK4olcyAUnbWtdgFAxHTdnZnUOeKYALvxcFbiBpgyTM/sQ51FDqPfcwjBEPVnVxzannPWhASt33pUnk9vR6/QJp+SdxWfpzZGBRjDIOmpfj1kx45Mef6UqYGRuWAiTrKlR7ZDbjScddDNUrNGaOetH+0+lyjI3tIjT6dkSid5TbqK7ez3qIjbiIA1OTnMhgeDB7G04nrkDmhPmMp0R9Lg4yNAcqWgE16j8N4/yKsGSOEq9ZnhMpTP5phk4LDHebeobOL+RXnjKtz4Xtmeg/OMnPtg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH8PR11MB8107.namprd11.prod.outlook.com (2603:10b6:510:256::6)
 by CY5PR11MB6392.namprd11.prod.outlook.com (2603:10b6:930:37::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7249.36; Tue, 6 Feb
 2024 02:24:43 +0000
Received: from PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2]) by PH8PR11MB8107.namprd11.prod.outlook.com
 ([fe80::6257:f90:c7dd:f0b2%4]) with mapi id 15.20.7249.035; Tue, 6 Feb 2024
 02:24:07 +0000
Date: Mon, 5 Feb 2024 18:24:01 -0800
From: Dan Williams <dan.j.williams@intel.com>
To: John Groves <John@groves.net>, Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>, <linux-kernel@vger.kernel.org>,
	<linux-mm@vger.kernel.org>
CC: Jerome Glisse <jglisse@google.com>, Christoph Hellwig <hch@infradead.org>,
	John Groves <John@groves.net>, John Groves <jgroves@micron.com>, John Groves
	<John@jagalactic.com>
Subject: Re: [PATCH 1/1] memremap.h: correct an error in a comment
Message-ID: <65c1984161c44_d4122947c@dwillia2-mobl3.amr.corp.intel.com.notmuch>
References: <cover.1707179960.git.john@groves.net>
 <dba0f5f01162d6fa16e4da2a9fede7f97080e92d.1707179960.git.john@groves.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dba0f5f01162d6fa16e4da2a9fede7f97080e92d.1707179960.git.john@groves.net>
X-ClientProxiedBy: MW4PR04CA0339.namprd04.prod.outlook.com
 (2603:10b6:303:8a::14) To PH8PR11MB8107.namprd11.prod.outlook.com
 (2603:10b6:510:256::6)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH8PR11MB8107:EE_|CY5PR11MB6392:EE_
X-MS-Office365-Filtering-Correlation-Id: 5258f847-161d-4df8-6d82-08dc26bab057
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FcNIrRGrD83E+JA0CH32N3MI5sp3693FVVWQEUPxADrgptuFfqosRMV1WPDBxA5rE6udOmGUiIedgE7peHv0wvtxL/4Xc6EhENY2iOA8lmkak4eZPSW2cVAAqXYassav7WwoXGtHCtXgbQpVDa7KDHo7wy8VAYWzGRmkzWbafML594tTlC4EdZfOqUFOYDO8IthQFBhjIEkgknTwqs01Y5b4/My7qcBxLPQPkE1zn9eA7cptXVftK2H27tFfW0PcfdjIaATKnfgsRjIsLgPeWFB6evzGbdgiC+AbPe1Yae9s19ZEmILHPm61tXtROZx4cyUhMZNRhQzhJ4BCRhZwHVg/eqp7ahZIoa3FNnJnx3rMrez9PV6yzegnwNdmbaY2EnRzHVfl7pevzMDInqrwguTzI63wMSq9FAXYbgEHti2DYMdxDDfNYSiY5NXscGvwzHYsEgcBFinKS5XgzU5q7ROyKamH9+kgDTI2FGv58ehwhJNku/P5pCEuR2CkTLA+awTbCxCLxo2c/65TqE/RcHKTnKo+8olwQlUWVNesLECfrIozHn16j2ig+FH6oHfi
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH8PR11MB8107.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(39860400002)(136003)(376002)(346002)(396003)(230922051799003)(64100799003)(1800799012)(451199024)(186009)(26005)(86362001)(41300700001)(6486002)(5660300002)(2906002)(478600001)(110136005)(66556008)(54906003)(66476007)(66946007)(316002)(8676002)(8936002)(4326008)(6512007)(558084003)(9686003)(6506007)(6666004)(82960400001)(38100700002)(83380400001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+xaqFh7T6REDtC314/VDL10Kev2aiVxw2bYzvTc/yP59yE1k8ZdhC+lnxKPq?=
 =?us-ascii?Q?oo/EMh1WF2Ffo2ECUC++Fyr+9DSuc+52cUAngWSvl+p9MOhv5p3H8DHtvkVM?=
 =?us-ascii?Q?e1AnwgB7zJ5xgSXj1py9HiRuqmzs9FLCMzv/bEpg3L506kjcRFtaQqqzIfHC?=
 =?us-ascii?Q?hdOOBrTb22izzJpq4EP5u5kT376ZatgPTmobHPCDuzc0hKdN1BYae5Kudjen?=
 =?us-ascii?Q?s3L72nCEnFiW8LOTpiUM6xKXULN++Ay3f19JysPwK1L5NCa7z+8vRMj7bK5u?=
 =?us-ascii?Q?NAMRxkfIv2e80uBU+C+TUv7fMZt/cSzauXon48ZiN+hQEqhZ1aMGDYAwTkow?=
 =?us-ascii?Q?CgRkwHU4H2IAYQBWnFwbAZnk0VPUvcu4te1yFugaIxzV73Mqp7hZ+ceaTaS2?=
 =?us-ascii?Q?l7iAzJ3qMNXQjICZt7tg0LRw6rLIpy2E0+nbNplMF7Sa4GFvqUC8rf8rMlWp?=
 =?us-ascii?Q?2lTQ5PtSxTiWK+XIgLPfjGIztK9MvYfUYAKCyz/cR4FLxiRs10L3rpM0shGV?=
 =?us-ascii?Q?eZe9HjLXS7OKc7jPpM89QDsO1ZvDAGXJauBqbN5LyLFQ6EgTwY9kEHzBjfsx?=
 =?us-ascii?Q?2/WIGQlJCPD9DGXH6t7BwDurlKZok3FV7KVbIs/z7Mz2flNOr4+BPTOP2MXk?=
 =?us-ascii?Q?rSsh4ZsmqMEiBMpCtcZ/HTpg9Wgn1woh275D89jB6vh2fibgapWQet7R6lvJ?=
 =?us-ascii?Q?WXujUPn8JjfJtf33UwF4miEg4SrFxDvD9SRDgU2jxMe7KHyAHHhc+reJja4P?=
 =?us-ascii?Q?z/DgS9W4Z6+VgVlJMDbTGdq5FbEsOSskl/lBM2dHQ3HxcpiQ+fqGAp7YM7tN?=
 =?us-ascii?Q?bSqMMiKz/4RKbTRQ/LRHNBObbthE/Su0P0P8+ADJyMMypAyVA2wUCaCnv2Ek?=
 =?us-ascii?Q?mVb7Nuc3U1xU86V1YMg5p8crwx5KIoDA3eTLBpswuakRtpojeHWszkwGF1nK?=
 =?us-ascii?Q?u09PtSFHR4O5/6D3O+lG4zsYalns3lT8oorJLzntNCM3+Hu3O0XRsx1JDeAI?=
 =?us-ascii?Q?vx7NsMrKdVmOwF9G6xe8pKqYCi50+ZrTLkgrqKJS471nnggiUJZTVgm6/eDb?=
 =?us-ascii?Q?6AOzXmWSkPR16omfIvGJGG7XgqXZbL59ZjH663DMYjNaYgFtVMtPOHLt4/Zk?=
 =?us-ascii?Q?jw5HRJ1Ln8kC9aAlkW4jEx2pckFSB5izHYnZrkp3KlvBSdXm8pFoBaiL3/fP?=
 =?us-ascii?Q?ebhwwvqrHapeld8uzkmf9tQxiCfiImFDgkSmAxM5tBgHBwEprtBVhBi3hhO8?=
 =?us-ascii?Q?R+3ojGwfmJ05M8/zWv5IJhmOfZPQScvPN82NmDTcGt4v5QuRTzC4RIPj3uZg?=
 =?us-ascii?Q?3UKl1SbX+vZleMOJBQEO5EiT/kgtWZ8FkwvaIWtFF17hIYM+SE6Wz3DsxPHg?=
 =?us-ascii?Q?iIPkEXJ/KV857tHLXsfOTDZnJbXlD0BcmsBOMxYnxeF3QQvVlLtCuPklZSWL?=
 =?us-ascii?Q?SCMuFn+IdWM0ssdmlGEvRLi4LIwW8DsIkkZBUnY1snkW4RTHzlCZNPi4DKje?=
 =?us-ascii?Q?XIvyfXtv8M4aUlALJRkl25T0Oj1tqd8gJXGFMXL4MWupKZf1542iQtYJPumI?=
 =?us-ascii?Q?b65Q1iXJFG5CD7blYp251O63Vm3KSzjZ8bI+Cta79xuO9OEFJTBjtw7b2t9v?=
 =?us-ascii?Q?/Q=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 5258f847-161d-4df8-6d82-08dc26bab057
X-MS-Exchange-CrossTenant-AuthSource: PH8PR11MB8107.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Feb 2024 02:24:05.9249
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: TzP82am7z4uq6bCpXzv5p4NOmsoY5fiKqWr11MNweOt5/rFIehWXlHvpveho1LHAQLRiOCdfP03XhQmMtH42mSSCBtUobZg0gi9Pb0ZSC18=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY5PR11MB6392
X-OriginatorOrg: intel.com

John Groves wrote:
> It tried to send me off to memory_hotplug.h for an enum that is a few
> lines above...

You have passed the first of many trials.

Reviewed-by: Dan Williams <dan.j.williams@intel.com>

