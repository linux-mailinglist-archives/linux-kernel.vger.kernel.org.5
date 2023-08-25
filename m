Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8014788F06
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 20:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjHYS6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 14:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjHYS6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 14:58:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC2B92126
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 11:58:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692989896; x=1724525896;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Tp7lschhbDp4XgAdEeRerBKQmdpJfQcDDac9QMA3izM=;
  b=AJkUF+/iVkJ5GYqxw+ayDAtjvrQcYxkmai320BfcBdADzQcE7vSDzvqT
   34ZYi/IzbfWiAYn+iyNRw70WnZKvuMEVws1SsT0gc4KB35Il9OTz9EW7M
   rhdispnDs/faUlECbdisO+DhBeS/PsZs130OJtRBAE80bVW2L1WdOtfsf
   CV9+4IRVm2paf7WD7XoVINbJi/Q5s1XfGWxIjSlKDoSERnf/XiqpkakW4
   IONsKc6XGK7X/fPiVAH+DAsko0HGfpbeO5lRMC7zoWS73Cqxfi54cfSIl
   xYJtluVUM6xKKk8h0lTy/SnAcDvKtu83P67nmV1kLYGwmXqCoQb8PoiuK
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="359777883"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="359777883"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 11:58:15 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="740711060"
X-IronPort-AV: E=Sophos;i="6.02,201,1688454000"; 
   d="scan'208";a="740711060"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 25 Aug 2023 11:58:14 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 11:58:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 25 Aug 2023 11:58:13 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 25 Aug 2023 11:58:13 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 25 Aug 2023 11:58:13 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ho2998hyykZnL2AvrzjlNz3xru2vb2r7JXC76/sLFPd+pW0JcXuL/iM4dQ1fGEBkJyV1CvkV17RtiEvAvQ0ltQHBVPtJGFce/c7gtgjjydDEzaRQvoHF4+dX5rSOj6M9WioL9koEgIO9w7JXEuU1lrOt6KYXQ7Od6UFpbj/jdlR0Yfsox0kqjkAa8ooKfXOTNvWT7yF8Gtoxba6Os1R5DyfE/fAUiEqZQNM+omk2sR5MLakzUGhiQ3ub1D+uoR3XdUNZh+oYGazuwY001sw57x8sOlpWdzVJdKswOn8SgVzHsoznol5R5dTY7wNDfKF9/M/nrcMo0qNz2vu9tFAupA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dTLp0tqfN3c6qpyNRRZBWhoGukLGH2Hg7ZImMRT/8jc=;
 b=nkS6lzjmJ+wCLOWmn/I05qwytBFt2jLyJs+RcTWmy09xfeuh/tdrJUCG5N+Isus6IpROaVG7D3o2AkCB8AnmsaFsNlm8zocOpVdKgugjkN8NUaqggUBdq7H6xEu1GIMhqhuGO8yDcTzYoyzdx7c99mzLjjF98Zh4O/msgpnWVr0DLBxvE47C+WtAG3krHgp0G/iaslJdCXsakh5Fz3chJwJFUrTGhpqulPnIzm2VoFfxcVO68AeTqzUOsxwBv/YoEESZRLEKiHYwQA5945UJrC4Lw/IeXHiXobvzWbOy2pEXo7l4itP0UF1SF5XjAeKiLkCplMHVHwKRu4oYvIB92Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8471.namprd11.prod.outlook.com (2603:10b6:a03:578::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.27; Fri, 25 Aug
 2023 18:58:11 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6699.027; Fri, 25 Aug 2023
 18:58:11 +0000
Message-ID: <dc4cd365-2a02-32a3-da78-7ba745877e97@intel.com>
Date:   Fri, 25 Aug 2023 11:58:08 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: resctrl2 - status
Content-Language: en-US
To:     "Luck, Tony" <tony.luck@intel.com>,
        Amit Singh Tomar <amitsinght@marvell.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>,
        "james.morse@arm.com" <james.morse@arm.com>,
        George Cherian <gcherian@marvell.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "peternewman@google.com" <peternewman@google.com>,
        Drew Fustini <dfustini@baylibre.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <DS7PR11MB6077FE180B11A9138D8E7ED7FC1DA@DS7PR11MB6077.namprd11.prod.outlook.com>
 <35f05064-a412-ad29-5352-277fb147bbc4@intel.com>
 <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <SJ1PR11MB6083BC6B330FA7B7DFD3E76AFCE3A@SJ1PR11MB6083.namprd11.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0186.namprd03.prod.outlook.com
 (2603:10b6:303:b8::11) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8471:EE_
X-MS-Office365-Filtering-Correlation-Id: fb514fab-d7a2-4f0b-9935-08dba59d3a4e
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0s4K698AHg8dK8MPZKgSF/mdgmZsLHiso/lagILoYhcr5OdEPwzKQtru0696o4+DCu4gS4tXgelAmHXQRfJ7tougZw4yTnd8cDpebqo2RdpqCWVFIMMZ1jujR5+UKfFrtFFd5tMYNvYx5T3+Bhk1BudctPgnM3X5Yo+C1rX39XKYGOotMUTF/n9Vyq8iFikGF5IDz2gBmpmpJnWh0krBzcYECKubpr4KoDOXGQDOqVaG1bDgKSqcxqKHysVp9+me+9dHBoubiXyYk7D1V5C3fomrK7x0nG9QL5pAaL6SLCkF1oyYegy0m89dvK6QRntSoagr8Lt1fYfLrBOPuFh8Ef/9PYsqt1adA42yQkRwAFslckvnvbl9WcAMwMi6WGQBf6D87LljK8KHQVySaFwDIL0uPNvCzZ2+78KAidYhXvDMREP/r6P/yYz/CQLMqnxcbl7j5LIM7ROJ8NiwLJyDvM8ojXMKp+jF70OIxZj09NiZpkNGAs8Lgmc25MwkoL75TI91M8BQ3a9CQZQVx+46V4lt+7sY0rXb+S7phkujrQUrFaANoowNIMeu4FoEIP9flVms9e6aoxSyAMOQRl0RgRFMhn+fCqhBH+DuGwFbUXt98Qvu0mWcBzqQWzQMRWOYflDYdV64yqRc/EYznm1Li1rRoRZPPH4CGKpXI+k3hlQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(366004)(136003)(396003)(39850400004)(376002)(186009)(451199024)(1800799009)(54906003)(66476007)(66946007)(66556008)(316002)(82960400001)(478600001)(110136005)(26005)(6666004)(921005)(38100700002)(41300700001)(31696002)(86362001)(6486002)(6506007)(6512007)(53546011)(2906002)(31686004)(4326008)(8676002)(8936002)(83380400001)(2616005)(5660300002)(44832011)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VkdpQjNBZTVSeHM4emQxaVo3eUVDYlZEY1JoL0xsSDF4WE44akF4ZGZ4ZEwv?=
 =?utf-8?B?dkNxKzNnRVAySkY5YjlWTW1VWWlWMHRLeHhlOE94TFhxd2xodnRDTGtpYldo?=
 =?utf-8?B?NWRNemxuKzlHOWtoT0pwUlE0bXZNaVd1Y3NaN0lZM3h2dGNnK3FEYkZaQ1pB?=
 =?utf-8?B?TkdCbEZKenYzTS9aOTB3Ymk4WXlsS2RkcWR2T1FucVBkNGNqNjVxbTNsYkp5?=
 =?utf-8?B?MXZCeHhMRUlWQ2NNUDF1MUxsWGxneXAwdlNiQ2l0YWo0cE4rN3AwenhSVGpZ?=
 =?utf-8?B?MkU1QXd2cTJieW45aWpKSGN2ay9pcnZyU0FyZmpsVWRsSXNQY1JDZGtaTml4?=
 =?utf-8?B?YnJHNmNOM0IzQUlzcDdKbDVLekF0dXFXanh6NWJUWGlRUFNITzlWMlpvQVdq?=
 =?utf-8?B?bUtWSUE4VkpNblZrVkFOWW1wTEg4aDRaSDd2eDJZSWFaWVBhbWUxUmRsalh0?=
 =?utf-8?B?eHJMQVB5R212L0l6emZNaGF6d0tEZWs1ZDNCZVFIQ2V5NHZ3cnFFbzF2ck1j?=
 =?utf-8?B?UWprR1hXZDRIQWlIUmVYTjhzdU5sQmZ6dEhKYVh5T3huVFVteWZGcUZQM1JT?=
 =?utf-8?B?R0xkaEpHcm83OTM2S3lmcXhwNHhaWUZQNFlPTzBmUDlDQkZ4QnNjWGM4cHY0?=
 =?utf-8?B?VytKeDZzcll6NWFxU1p6RVl1N0o3NkoxTGpoQ0pGMDhnaE9MYldsY0dKWmxr?=
 =?utf-8?B?ZHpabjhJWHlIUURlZHpkSFBIRzdHNzlZdmZTZW9rZ0lXN3crMUhQanR1QnA5?=
 =?utf-8?B?NmFJNCtQdVJpazcyc3pnNmVsSmJuVWpFd3ROK1RUYnNYenNxai8xKzZRdXJq?=
 =?utf-8?B?eTBMWXJoaUQ3U2lBaE5Kc0ovOExiVWE5Z2xXdUl4MlBuS3JNeExhSHY2MG5S?=
 =?utf-8?B?MVdTQ0pjYU9ySmRSZnk0UHh3MUdvc3FLUVFITkpMQ3dENFN2YmJBQXU5bklq?=
 =?utf-8?B?c3dld3hOdkd5dnNKUVh4akl0VGdyMVFRT0Q3N205a3Z0RUs0LzloRVFNUC80?=
 =?utf-8?B?QTlvWm15ajZWbVl0S3JJSTA4d25TSGNjN2U4YXQ0QWhnZC82ejdNejdibUdR?=
 =?utf-8?B?UENvNWZ5SmltZFZ2b1JqTWtQOEZOTGVQS2c4SHA3K0tGQnZ2VHZhSUlUVEJF?=
 =?utf-8?B?TFlKVkhJSHlnSCtkMzhJRkd6a2I4dEM5eTg3NU9KMmxXMlZVTm03Lzlub1Ix?=
 =?utf-8?B?Z2YwRktiNkV2V3FweHN0aWo0eEV6anRmalN3ZTU4Y0RaQmd3S1M5K2daN0dm?=
 =?utf-8?B?VVJncDR1c2JuWFNuaVRSdzZoOFBMeHNWZVZ2RG1nakVIT3R6KzNrdGJkeGNY?=
 =?utf-8?B?SlJ3bnZqcjJrRHNDcUltaWJoeHM2bnhJSHdQQTg4aHRraFY2WFJOS09nYndO?=
 =?utf-8?B?WTBsV3U3MStoS1FLVFR6RXpBenZmbEpYcDIzYlRNYXMrcytpZ2lWTFFyYWoy?=
 =?utf-8?B?eVNYTGg5b3dXeXV0eFNVdjNZWEpKeW9CSDVRbHZ5aFhrWlBYbjllTXFIVzF0?=
 =?utf-8?B?REovaTduRkxxZUl2T2NPUVN0U1hUUHBua3lORmtiQW91KzRkMzcvTWtLSVBD?=
 =?utf-8?B?RVZnN1BLcVM0MHZpdWhWRmRwTFdyM0hFWkZ0SzR0bGNiM2EvUklmcTEwRnJ3?=
 =?utf-8?B?N2l2Z05MWlVzNCszYmloRForellYTzhNSHd0Znh4MlVQb1A3VjNuUWtUVTE5?=
 =?utf-8?B?TTF0c0JRaHdQWFA1QzRTRE5FdkNCeVBXa3NRZDJhNE5rd2lXSGpCbm03MWVO?=
 =?utf-8?B?Tk5DWmtkeUx3dEd4bEtmeEZyaXhmM1dGRW1vczRQeFovZmRreVNQTmtyUXgr?=
 =?utf-8?B?VktIZk1QQk5PWWRNTWN5VmhCT3lPTkxmVzk0Z3A4UUdhUGxVcmVFcmxvcHRG?=
 =?utf-8?B?UXZsYjlTRktnZzc5eS9kbTc0eXlPWkxkUlFtUElleFEveGVIaUlBeWlTeDlv?=
 =?utf-8?B?Yy9PcTdqTW85dDFrY0FnYy9PTjJtTnRWeHVXd1pWcFJiUU5uVDZnZUpZMjRs?=
 =?utf-8?B?RUVDdmxYSWZ4Zm03NVRVQ0lNUE81R1M5TFZ6c3JQUGk4RFJYWnhTSGwzMHJU?=
 =?utf-8?B?OVdDM0gvN1JwZW1TSVNrN3FzSFBjUFJrQ0RSL3YrcnlDbTcwN3QvYXI0WXlC?=
 =?utf-8?B?RmJ2Z0NHRTNoTnppV09aditzbkxrR1RIeFVIdHhRVVZYcmQ0RmowUHM5K2t3?=
 =?utf-8?B?bVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: fb514fab-d7a2-4f0b-9935-08dba59d3a4e
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Aug 2023 18:58:11.1878
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6ulp21BABYt6Ab1Z5n63nwBdKQyl6JTdD9gJD9Q3KDIXy18YvxcwYuw+bPSu0WGJJqclYrxT3NNZd7RetTSnM5BPWSzT3+s0L21elodp5Oo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8471
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 8/25/2023 11:09 AM, Luck, Tony wrote:
>> Alternatively, can user space just take a "load all resctrl modules
>> and see what sticks" (even modules of different architectures since
>> a user space may want to be generic) approach? 
> 
> This mostly works. Except for the cases where different modules access
> the same underlying hardware, so can't be loaded together.
> 
> Examples:
> 
> rdt_l3_cat vs. rdt_l3_cdp - user needs to decide whether they want CDP or not.
> But this is already true ... they have to decide whether to pass the "-o cdp" option
> to mount.
> 
> rdt_l3_mba vs. rdt_l3_mba_MBps - does the user want to control memory bandwidth
> with percentages, or with MB/sec values. Again the user already has to make this
> decision when choosing mount options.
> 
> 
> Maybe the "What resctrl options does this machine support?" question would be
> best answered with a small utility?

A user space utility or a kernel provided utility? If it is a user space utility
I think it would end up needing to duplicate what the kernel is required to do
to know if a particular feature is supported. It seems appropriate that this
could be a kernel utility that can share this existing information with user
space. resctrl already supports the interface for this via /sys/fs/resctrl/info.

fyi ... as with previous attempts to discuss this work I find it difficult
to discuss this work when you are selective about what you want to discuss/answer
and just wipe the rest. Through this I understand that I am not your target
audience.

Reinette
