Return-Path: <linux-kernel+bounces-60026-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3721984FECD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 22:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 573D41C21966
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Feb 2024 21:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6435218053;
	Fri,  9 Feb 2024 21:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GPMX2NSS"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD40A63A7;
	Fri,  9 Feb 2024 21:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=192.55.52.88
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707514008; cv=fail; b=g0dkVWfOB4QyDR+jECycs6d+W2gNqUENGdxkgLzC4BVmtXn8sJvH2XgWdAcY7tO4YLxjfyveTA7cCXJB7p4dOrO2jQ81yBR88fDBUt8xYmXomXxW8FQe5U1ythDjyQwAdNUpaW7aiU1CD8RYiobb8f/E7oYL7weUQ521rxIwdsY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707514008; c=relaxed/simple;
	bh=aGXqdpDLCS5OUbbCObGGVpvGGaBjHTxZ3E8qzyYz+y0=;
	h=Message-ID:Date:Subject:To:CC:References:From:In-Reply-To:
	 Content-Type:MIME-Version; b=ozZoPnBFmrut3KKL0nUdVPa1bap/r+k+ihrmPmY7bSBwY+1P2PRr2nmbE/IcBKnhnPO+iBpRIKuY/as4jIawrkX7OycrENmuDYcMy0FHlSTfm03PeQWNt2pXWY8p4CgIxeeXOtJfE4xaCxo3ZRyu/kGA5Ol42S8HYXD4H+pSiug=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GPMX2NSS; arc=fail smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707514006; x=1739050006;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=aGXqdpDLCS5OUbbCObGGVpvGGaBjHTxZ3E8qzyYz+y0=;
  b=GPMX2NSS9J7mhjg+5MobaHX50/v0lfOeCpZW3WtmETIB+TWx8dsMyBs8
   iigdwhqmlq2vTZuFQR+DSYhgKYjaSw3nL7+XH0CGrAnAld/6NUJSMf6Q1
   EfjBgIbbOC99EG2Fwb0UIGGiO424Vly598WUOw8iutW03LDA0573Ff4ww
   y1opMDlyqgZErtTeLpoGYOEEcVB/9Dsb+8efpiAL2yeifm1kL60rYsVZW
   5y0fWuToSj3miEl2dMi8odN8PqorlkNDMcDIQZZC6+xbUbiLG/pw/ELtA
   0aSVyP+qZEDcXPnX6noQIw4xkq+XqeoexqB0GxtUyG+wkAqaTUkMGeSIk
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10979"; a="436643671"
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="436643671"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Feb 2024 13:26:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,257,1701158400"; 
   d="scan'208";a="33121147"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmviesa001.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 09 Feb 2024 13:26:46 -0800
Received: from fmsmsx602.amr.corp.intel.com (10.18.126.82) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Fri, 9 Feb 2024 13:26:45 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Fri, 9 Feb 2024 13:26:45 -0800
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.168)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Feb 2024 13:26:45 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Fc3s/ZBnEtcsmQFyOLhelnl2D0Nt4TbIrM3z8URZjXQnAGVLbLNj5uWtKYUn/00dExIB3HovkztqW7ljmZAdiC5bTC2hNJcMveGDqi3Fbijd0orAlHX23X7epyn3qr7hIjaBffE7gvAuLCGBEGMyebtu7SxEvDN6Bxs/3oPhkQvvYFpk0ox+m0Ga7kqslKnGplINQzMsPEgWhjtFf8MvebqPHkxKmdJoVNZE7u6lEJEkFOhL+lhndt76vKVDZMa3Pj7j0ZxqI0tNP+cL3MMUR4h16fxc56RcsSd5sO7BRBBrQ5TVk58UHXDjX0thMmPEjqPCVLPSw3b0wZQP5lbqIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aZYh18sxFEgCPdpsHugHQXb0ujYME8SYMimtRf4MfWY=;
 b=f2HM6zTiY8I56B0f5HW1qvZFEMU/jqZWfE/nM/6qu9yndaFUjf7wBb8epx4unpkHMRLGhS9jffU0BfVv8ybIUjeldEycB6L8IRXysyAXXQJjVyqu0JTrHOsEAcgOKaQKjFKWhowG8QqGTJiyWHvHkzQoUsri8mCH3/aM6ECsl0cKB4rf+v1ZDTbsITDDhN7wymE0+6k2szXv3oWaRH1/KhDL0lJ/AjL64ewCf/yrWJT7dnPoG6EE/5bAMDP/amjKKMqHPopgtJ87xbR0XCLYgRNXA/ZY/Ljbszq80ppZZm+QZDJK72BOnQx5hrdOXso1jkLE+O2X8yypmQhLOvZEKQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by MW4PR11MB6738.namprd11.prod.outlook.com (2603:10b6:303:20c::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7270.27; Fri, 9 Feb
 2024 21:26:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::c903:6ee5:ed69:f4fa%7]) with mapi id 15.20.7249.035; Fri, 9 Feb 2024
 21:26:43 +0000
Message-ID: <65e1d936-0e1d-4d6c-81de-0b2b1d3256fd@intel.com>
Date: Fri, 9 Feb 2024 13:26:41 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v15-RFC 0/8] Add support for Sub-NUMA cluster (SNC)
 systems
Content-Language: en-US
To: <babu.moger@amd.com>, Tony Luck <tony.luck@intel.com>
CC: Fenghua Yu <fenghua.yu@intel.com>, Peter Newman <peternewman@google.com>,
	Jonathan Corbet <corbet@lwn.net>, Shuah Khan <skhan@linuxfoundation.org>,
	<x86@kernel.org>, Shaopeng Tan <tan.shaopeng@fujitsu.com>, James Morse
	<james.morse@arm.com>, Jamie Iles <quic_jiles@quicinc.com>, Randy Dunlap
	<rdunlap@infradead.org>, Drew Fustini <dfustini@baylibre.com>,
	<linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
	<patches@lists.linux.dev>
References: <20240126223837.21835-1-tony.luck@intel.com>
 <20240130222034.37181-1-tony.luck@intel.com>
 <91bd281e-e21f-4b60-9e73-2f14fcbec316@amd.com>
 <ZcZvguSNel-z3Xe5@agluck-desk3>
 <f4d4ff97-7d40-4915-943a-a7371e24dae5@amd.com>
From: Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f4d4ff97-7d40-4915-943a-a7371e24dae5@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0169.namprd04.prod.outlook.com
 (2603:10b6:303:85::24) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|MW4PR11MB6738:EE_
X-MS-Office365-Filtering-Correlation-Id: 2fa398bf-b8da-4497-2aef-08dc29b5cfda
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 4MhZl8HWYQ+wmAKPQLmdX/2n85AliQthsf50CDcAzeHvnVtIMWaCcUB3Z1GSfjRKWXaQ3LNLYQMmZM76nQrZb3k0Or2TscFXKh1/tX+oGzsaIAhMKxXR4DH6fwky92SvxaYTZw5UB90F3h3Hx3T2nSBH4LgqgkTf90vQSjb/A7PS+RyE8odKSbC7HVdS+YrFYE3twOQI1IdSSWjEu38WllWehI7GEvQyLGTD/VjIeda8tmB4UK71T3Sew6MqThyjZ/cSH0IQh3mvAKjwmG0PB9SDI41+AsJp5n53r6QjOzHumB9unkH9Wl+FAijVlxg45xzeXmc/vgAAYMEacaR+ONhANckLP83GsbkqCMd4Hy8WeoFXvUyakei+ELVoFx5O8skkjeEptsu7rXN/Q+3xoP9A1F5/haIrOMpHMHgo91rODIllxFDibXqFw/NSH3aKgPx/uct5fhVC7dfvh8o+7GSZlltH4Ai7YYsmuOxE0SQdpAAhiKKoCnipphGYDS7N+NPK57evA+6J25ckHlGoDnaHV62pXTp5lNT+n7s5k9FECPeBbJqjazlGr/DmwhXP
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(39860400002)(366004)(376002)(136003)(346002)(230922051799003)(64100799003)(451199024)(186009)(1800799012)(31686004)(6486002)(478600001)(36756003)(41300700001)(86362001)(4744005)(31696002)(7416002)(82960400001)(2906002)(44832011)(5660300002)(38100700002)(316002)(8936002)(2616005)(66556008)(66476007)(6862004)(4326008)(8676002)(66946007)(54906003)(6636002)(37006003)(53546011)(26005)(6512007)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NzNpMTRIV1FzdE5ueEdlWlJ1WGx5VFQ4WVRyQkZHOTlPT3IxNGtGVjc3eXd6?=
 =?utf-8?B?ZytEb1pyMjlPeXlZWkZoWWY1bkU3M3NoSXMvdjZpcEJVMmorOEtmQVFLSHpI?=
 =?utf-8?B?VHZlUzdibVVyUXZUaFRXYjVndGZFcVlxTGRIQTYzSlQvaWdrVVBBbkZaK3ky?=
 =?utf-8?B?RnJCQ0pMeFFYZDdmNDNVOFpTblJ0d3NjNzRjc0I5ZXFTZnRGNkkrd2hkMzJI?=
 =?utf-8?B?aGhYTDV4UGNHWnVObE56UDd3RHBvblVDVjVhSVFsY0h2Qk50MnpqRDNEY0Rv?=
 =?utf-8?B?RzR2YWdUbFNFbHVnSXQ4QWFkaElmZUp6T1pZdlBhRjBGek0vMW12RlVpVEN2?=
 =?utf-8?B?QnNNNDBieDVleUhtdFNmY1c4enc3c2pZVllMUHJlYkFYNExQeFJ5K1NKNTlO?=
 =?utf-8?B?R1FWcm9KZkpEcDNxZ29EYzJoVUtHamIrL2t6Sm9vb001WURIajkwYWNITWU4?=
 =?utf-8?B?T25pN2hIZ25RaXZta1VBcWR2SUVibHpmRktySnZmR3RjYXVObkxGZmIvNVIw?=
 =?utf-8?B?WDMwSnpSM1pkRmU1cXZpVHRTQjVYMUVZZm1saHFhWU5panozV1Vmc2tPTU1J?=
 =?utf-8?B?ZGRsUmYyY1RVeDdyYWJCNkJoQkYzWEpBT2toaXRuejJKUWlqcGd6d0dJRysv?=
 =?utf-8?B?MVNWTlZZUExqREttbUF5ZU9FR1VDY3dwa1R0dnFYRzFsb3lXRzMvdjR5K3RY?=
 =?utf-8?B?T3ZYK0pRNjhNckVZQ0EyTnpmYnNkT1JxdmZhb2xEVDF6Q0NZUmg1NkExVEgz?=
 =?utf-8?B?MmVzVHJqbVJVSUJxU05lamQ1Tlo1Sy9QdXpyY1hTUVg3VHRaZk05TWdWNkhL?=
 =?utf-8?B?WlY4QkdkTlNiUTEvN1BuT2pGcmdJK0ZlQ3FvblNVTlAvZWpTU3VKVE5Od0Vy?=
 =?utf-8?B?K1lJTy9OM3dGK3F6UURMRDYyUDZ6YUJVMDlxejY0bHlPY2kzalFWZElDYzN6?=
 =?utf-8?B?dDNCc2paVmN3T25TZ1RHeEYxSFJDckpCdGxTdjR4bWNlNUlSN3ROTGNPZ01v?=
 =?utf-8?B?NzFUM1EyeFY4dzl6RFdCMFFrU20zNnY5dnNDNjhlNHNjZE1lQjR3aDFXR2FZ?=
 =?utf-8?B?YzZzMjFIV2V2cmhuUHVqVXNGYjhCK2dlR2daUkxYQ05yTUhjQld6NWJSdlQ3?=
 =?utf-8?B?dEtBNlZHS29PRjg2OUhTL1ZBcGJhcDh0S0ZnUzVUa1BhMEZUaDlUb1UrNzcz?=
 =?utf-8?B?bm1KdlE0WEFKaE01K1pxV3lZZ3h6cGVicGpUK1JDSFZKSnhDck9Va3BYKzJj?=
 =?utf-8?B?NStraE1mZmZuSXFaYlZIZUZReHNHMHhUV2xkSDBYeEtwNEdBV3ovZ3hlemVr?=
 =?utf-8?B?ZG9sZCtkTDhGc2l2NlBMSGNaNHJmWStMdzVtZ1VJaFpIcExTSGV5aFc1ZHAv?=
 =?utf-8?B?SE9jeW13SjRIUkVFcENMQkVzMzl0YXMyM3ppVzRvM2s3bVgzMit4STIySFRW?=
 =?utf-8?B?VXI5bVA2SllUckRxVko1eGFDQjNSNmVka3oxYTdKcWxpSVNCUmJHdjZsMmlR?=
 =?utf-8?B?WFRCdXhnSVBMcy9KUDkrNHBtTUwybnRXZkhmVHVOUDJlL2dYeDU0VVdBNXRO?=
 =?utf-8?B?SXJLUWcxSjN3dTlBS2lHTWkwWU5uODRvdkZSenJFVG9WemEwZHJOdmpkbFRE?=
 =?utf-8?B?Z2lnZkZYWnBVaitZVXkvSEc3SGcxWmhLZDNJdlJmUDRDSEFOQURCbzNlajdV?=
 =?utf-8?B?eU5nbmZZOUg3UXduSHBudEdwQlZtK3owR1NxejFMMW5LbzIxak05dG8vdkhT?=
 =?utf-8?B?L2xzVmcwbEcvTDd6ZUtHcVpmakxhS1kxTnBhTkNsejdZVjdKcTZnemRHTGJW?=
 =?utf-8?B?Yk93MTVCMEkrU2NEUFpjN1owT2ZjUFlJYjFKazF3YTJQM3JCOCsrd0JKOTBX?=
 =?utf-8?B?dHIrL3lGWmhBVklVc01SeGdKWjFxS0FGdGhFZldzMGUybUtkZW0yM1V3Tnpp?=
 =?utf-8?B?UEk2ZzBSNC9weEEyMkhUa2FnZkU1aDIwT3NkUlY1ajk3dGNtUU80RUNqN21Q?=
 =?utf-8?B?L09xaldTbTBRbFU5aHFuQU0yckZ6NGF2TEV5VU9MVjlUb0swa0IxYW9rVVk1?=
 =?utf-8?B?TXZacEFBVGtFL3hPZ2hydThEYWI3Yi8wQmhuaDhYQnNPRXhBNWlwNHhTOEE1?=
 =?utf-8?B?a1pCR2xRR290OHJlNUw3MTJGeWphRFlnL0haS1NiS3JjMjczU3RvMDZXWVN6?=
 =?utf-8?B?c3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 2fa398bf-b8da-4497-2aef-08dc29b5cfda
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2024 21:26:43.4678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5v+MSWzwVsWStsvAkmPu3Z0MT+tMWdshpvj3XRuD5URp4+xXA5Wp9xy8fcUf6PeJugX4zVD9JEZs5v7yLrsZ7Y/G46SXaBZjZdX1VOlviSI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6738
X-OriginatorOrg: intel.com



On 2/9/2024 11:38 AM, Moger, Babu wrote:
> On 2/9/24 12:31, Tony Luck wrote:
>> On Fri, Feb 09, 2024 at 09:27:56AM -0600, Moger, Babu wrote:
>>> On 1/30/24 16:20, Tony Luck wrote:
> 
> Reinette seem to have some concerns about this series. But, I am fine with
> both these approaches. I feel this is more clean approach.

I questioned the motivation but never received a response. 

Reinette

