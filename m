Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB5DD77FE59
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 21:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354064AbjHQTMP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 15:12:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354195AbjHQTLy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 15:11:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C0062D70
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 12:11:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692299513; x=1723835513;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=73fG61FJ2YydaLWS5Ilrouu8R6fByaALYgEkV8O5S3c=;
  b=gJO5/N65u1dgGnerS+hRAlWHAVhVIVR0RG6nKfZHKwe9s5oBllail9zK
   3SjeahSvcWBj7u0evd+dgkw3xxDOmbCCPXnD8z35IK0cWo2iL6e8dBEV5
   vlhDw1zRA5cLQLLAJ84vET6w53TQl05akbbURGB/ubBbze1X57VI1KqBl
   pQqsONWlPxfOatNMDc6f2Qyl2vgDKQxWKhNwv570n9grhe8OEBQZF+35S
   p7Q/BQPclqT1zA4ex64ECFDvW5Y8+QKH3BQ4wkVT/BUtIilM23HxlFCik
   6svu1rCHxRVb3LGSA75H3ZSigqAGLEJkX88DKAbHVWZKBNuGLMvvs1/+1
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="363063463"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="363063463"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 12:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="981320019"
X-IronPort-AV: E=Sophos;i="6.01,180,1684825200"; 
   d="scan'208";a="981320019"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by fmsmga006.fm.intel.com with ESMTP; 17 Aug 2023 12:11:29 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 12:11:28 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Thu, 17 Aug 2023 12:11:28 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Thu, 17 Aug 2023 12:11:28 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Thu, 17 Aug 2023 12:11:14 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H4O+jSk9yXaLlDsKO8Av4wGkVVPMUSo2m9SnH49S4Rr6NZ3DnQVnRo1RvTVwZTrmsBqneYlemh9gKC+g47PCfx0QrNCvnQpAVl7LaFRMfsRfVPcf2xN3j2cO74MQh4JcyNIWTmkfbHE4L2N8tk/zBesgGnsyhAFLdTylXdOrqPYczrpqQV84Wlay6ScmxO8LbcAwmbC/EJ1iHeicbrQ1uhsJNCromqAPAdIn+MPJ3kjp6hISGFbQYKcrLLoylw0kMsUu9V4srMCWVsjSXCJl9TnF8pf+cPHCrrA58SYNSGlkyxXW0/KDwzLPnbrzzrdHsuse0ulWlY4oqIqCqcDhng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zeq0fPCfaadyZ3523KTYBdtbe3bbLqs3dQYt50sa8Ic=;
 b=JdiMOJKeDnBb60ntKNY/oMOOX2A6hUnOEB8aH3jSnRbuDIb5vd7oFR2NAQ4+C9Oaj4PIJohohPR+cbYbnpX9/PYckmdxU1M3nQwBVSDJb60sqcCoYQOe5xo1gd4Gm1gE8m/Mal3Ejd4ryTVQf3P2GvTu0OeOQN9BiF+tnz46RtWcwyUr5Es8seGkA1vqgmGj1gz/X52DQ/+cIUjUIDOHBG+I1EtYIXswoyrP7cFvO+tsgNpb0BVNGdMZoqVEnA6Dr06nuZIf6NOsqB7uajLzvSWOiKxmF0jir93wHqe38nEME7YJ0qei6galnnwskecynEqKnPn4o3YUjd+DKTa8jg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB5213.namprd11.prod.outlook.com (2603:10b6:a03:2da::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6678.31; Thu, 17 Aug
 2023 19:11:13 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::47e:3e1f:bef4:20e0%3]) with mapi id 15.20.6678.031; Thu, 17 Aug 2023
 19:11:12 +0000
Message-ID: <f0e10f31-8571-baf6-6665-b077af067777@intel.com>
Date:   Thu, 17 Aug 2023 12:11:09 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.14.0
Subject: Re: [RFC 00/12] ARM: MPAM: add support for priority partitioning
 control
Content-Language: en-US
To:     Amit Singh Tomar <amitsinght@marvell.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
CC:     <fenghua.yu@intel.com>, <james.morse@arm.com>,
        <gcherian@marvell.com>, <robh@kernel.org>,
        <peternewman@google.com>, "Luck, Tony" <tony.luck@intel.com>
References: <20230815152712.1760046-1-amitsinght@marvell.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230815152712.1760046-1-amitsinght@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0255.namprd04.prod.outlook.com
 (2603:10b6:303:88::20) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB5213:EE_
X-MS-Office365-Filtering-Correlation-Id: 96901fea-36f8-4a94-6743-08db9f55b8c2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: EN1qsOwvD9GdNlsbLh3fLR6i98y9jc7e06N604mqX7UwsqiEadsVzk3Ex98m0CdzC9gHAwkKglWiDxNAQfd5KHKBdZZ1nZs+EJrZItHkrMGv/LcFsXzxyEPrL9joyBeSIUg/z4ubl7K7+uV7bd6pUrgOcTGuzc3bN1D9N6vzEktGKldt5uIOESobj8XJ/G45zcyYo/kb7pT4ZGmV7Az/37wfjDAHvLbaxKcAQI2TMzCsNhoEv70I8rBuBRpiabooG46bEa/mXvpuEKjA5VVYkGj1XH2tE7/RdYyItjoDzJzCwz6MJQ0/LBZYsjyTfAnqHqOCqUB4jku740r7J2M6tcyHPpnX52O49xR+ZHfK4+MzGOG1WRIzXkiXUXMdp0i2BJGJKeDyc8bRry3g+NQZfpJr3W/QPfxsYfJUbKEOiSrY8IGPy8dLJOdx0sfXYP1Gae78jiz6tygMf3LJFK9/Gn3phmELSpsl0GmgfQE5Aec+t7rJqiJfYN+2w5mbDKdYvTFG0XG2mK4OnOBy8umaNkyAmK1wTWRpStnL0D+iiKnYfAXlMGetCUO0FBFU0S5LFGGoyav7Ada5fvh8AJ5SAsC8F6eEjKBnnux9GKLKY8oCXnHXRNB/R2+TxWZbfZzXZ+QLRL7JtDtp9vBp85W0YQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(39860400002)(396003)(136003)(366004)(376002)(451199024)(1800799009)(186009)(31686004)(86362001)(31696002)(36756003)(82960400001)(38100700002)(107886003)(2616005)(5660300002)(44832011)(66556008)(478600001)(6506007)(66476007)(66946007)(53546011)(6666004)(316002)(6486002)(26005)(6512007)(4326008)(8676002)(41300700001)(8936002)(83380400001)(2906002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bG02QitwTVdYamJYQ1c3NVplSG9zUmZDQmZIbG5mdDRYeGJGMXFZN0dkNTlJ?=
 =?utf-8?B?VzIyWGpLdXJjTFZiWUUwTlBONEZYc1hMNGQ2QWR6TDZjcU1FbUU4SERsZ3Ey?=
 =?utf-8?B?V21SUDgwN2VDV3Vxa3o5WWpvdlNkNURMVU4rREttTUZDZ1VPb1EwQzNLRjc0?=
 =?utf-8?B?c0dKVGVpWlNHKytQV29hdlN6WlJ3TGNCM0ZGWDVyWENWdVFOeUc3UU5VY0pU?=
 =?utf-8?B?MjRoenlSZUJ3U1h0TUZRNXg2ZWtEaTJpdWFhM2hXaWpDWDVRNDR2Zmo4Vm9G?=
 =?utf-8?B?Wnl2QlFtbGdrL05rVU5GODAwYnpWNmYvWXUvZEVxZHVsb0lEZEFUM3JXRkNx?=
 =?utf-8?B?cXEvWGRKZzQ4LzhpNTZtNXk4d2FOWVRXSlFSdUdONnY1a0o1WCtMdXUvTXd4?=
 =?utf-8?B?V0xJK1Q4R3g4eUxOaXBoTllEZDREakh4R0N6M1dtNVV4QXVpbkJZYWN1aFpW?=
 =?utf-8?B?enpFcytSRXdBLzNvWGZhZzBiVkJqN2Nsbzc3eUMrMTNFR1VtckIxTW9Zb1RS?=
 =?utf-8?B?UlpuNHlWaXIrWEhhdjlxK0tLU1p2Wi9UQnBwZUZ6UlRldkdHbFNSOENWU0NX?=
 =?utf-8?B?ZnB2RkdZazhaSVZOTTVlL1dQSTRvaU1QTmdNemc5REEwd1ZSNEMyYWM1N09x?=
 =?utf-8?B?MktQSlZyQkUydXMyMXFQeUxweVhyVWh5WG0yMStjM1E5M0puTXd3eVA2MmlK?=
 =?utf-8?B?c1NZcDFBejFHN1lDNGMwdDNWM1hwQUEvK2xxeUJ0dnNyU2hsQ2lLWXpaV2M4?=
 =?utf-8?B?L3VyQjZ3MFc2cmF2K0xZeFJ1TEtPM2orWUpuc2ZvVXFjeENlYlg0ZStMZ2JN?=
 =?utf-8?B?Q2lLVTlHS0tDV1p1TC9xT09qV1NJU1FPMHVMZFRkRTMyRVRMejBUanRhdHN0?=
 =?utf-8?B?b0ZGZ2I1dmowYTIwVS9XMUd0cUlGeHkwNkV0UWhaYVBWYnJTTmczQjZtdGlG?=
 =?utf-8?B?dnJYRjRjMUNyOHk3THZOeTV5VGxvNjFVOEpOSlBlMkY4YXo1Z0NyMDlZeURL?=
 =?utf-8?B?cE1LZXBKK1UwUFg1L0IyTk9wNzd4dlJoaDdLQnc3bS84eW5KUTBhbHRveTRV?=
 =?utf-8?B?NGFyQUVvZDAzQ1oxbUdCeXp2NlZBalViVjdGVEZTT1ZpdGlaQnZGNzdoTytt?=
 =?utf-8?B?Z011c3VkSmpEK1V2Y3huRElWbzRxeFRtSi9XOWw4K2tUam9UdGh0OS9ZV3VS?=
 =?utf-8?B?TnJGTktBMHBGWlVlVkU1bmlHQ0lQKzZ5dS9Jc0tPenRQNnhXMDZYamJ6ekY1?=
 =?utf-8?B?akJ0dEJUdFB1a3U4M0phaitQTzJONk1FSTlMMTU3dml2S2tETElFcTVnNzhO?=
 =?utf-8?B?RXJYVTBpWjhpc2w5RzFxNVQwdmdoKzdNMU9raGozd1pjbTJGajdTa2wxZVZz?=
 =?utf-8?B?Y1dsOGNQWlVTbjl3U1lSYkt3ZnlkZFVMM1ltMnZGS1JXWUdraUNvU3M2L3Zq?=
 =?utf-8?B?L3h3a2JhMDJMRzhLcWlBU0Z4NnJ5R2hFbXo4M1ZmREZFano5d1RHRkg3TFBx?=
 =?utf-8?B?TDlrSnRNQndGSDFzaTAwM1ZmaVV1TjM2WUMwcUxybmsyNjl6V2Y1dks3WUNR?=
 =?utf-8?B?YldOWG40L3ZSeDBDR096RVFRR1R0OEE1VlNXSmx2ZVQ2Q3luVHQvWVMwRDBK?=
 =?utf-8?B?eWpDWEVPMjZXbFRKL0dDS29KRm40eXVMMmthS0VuTi9MUHpnN3ZTK3ExNDc0?=
 =?utf-8?B?SXB0ZTVaQUhwa0ZzeTcrRW5Edldac251SWJPc3RXa3U2bkU2MmcySEc4ZXdp?=
 =?utf-8?B?TFBSZnpsT2I0Tk1oRFBWTWZyL1lZcE8ydllrOXFsU3dveDYwRGFac1RKbmdQ?=
 =?utf-8?B?bmtJOStVMXQwT2VUL0drNXV3UFVnbG9XVThZMzhjR2d0TUhPYkQrWTZVRGxm?=
 =?utf-8?B?TTVwWUFRcUVJTlRXYUk1V0xHeTd6eE55aDAwK1JsVnl4aW1DbXhHNnpMdHY1?=
 =?utf-8?B?QlU2bWxycHZwRkUzY3U1amp4QXFZTVBxOVpFTmRvOTM3c0FuUWdSRHNzbTVj?=
 =?utf-8?B?Zjc0bG9rdzlrd1pXRGlrTmJ1cnBQSE1nTG9ockZKN1BiRlRhdFh1UHpqZldB?=
 =?utf-8?B?K1VRQnlnRGNkUVBnZGtpd2dJTy9oOElGeTZIVWRlT1hBWFFUVW8vLzJaY2ds?=
 =?utf-8?B?VDViZ1cxd1dtSlN0NHdFTm1lVGdpcVpITDgwc29oS0xWdzFrcEhaQnlxNTk2?=
 =?utf-8?B?dVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 96901fea-36f8-4a94-6743-08db9f55b8c2
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Aug 2023 19:11:12.6749
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Efmv6TCHC8SQqvadKlzThKG7WIXWiTqIMu3MU047O5C1Rx0p/hViK24o0eBx3//Vnd7B3a4Us+B1tlMwNOo0uK6ypaMXhoPEMMBo3xBcK8c=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5213
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(+Tony)

Hi Amit,

On 8/15/2023 8:27 AM, Amit Singh Tomar wrote:
> Arm Memory System Resource Partitioning and Monitoring (MPAM) supports
> different controls that can be applied to different resources in the system
> For instance, an optional priority partitioning control where priority
> value is generated from one MSC, propagates over interconnect to other MSC
> (known as downstream priority), or can be applied within an MSC for internal
> operations.
> 
> Marvell implementation of ARM MPAM supports priority partitioning control
> that allows LLC MSC to generate priority values that gets propagated (along with
> read/write request from upstream) to DDR Block. Within the DDR block the
> priority values is mapped to different traffic class under DDR QoS strategy.
> The link[1] gives some idea about DDR QoS strategy, and terms like LPR, VPR
> and HPR.
> 
> Setup priority partitioning control under Resource control
> ----------------------------------------------------------
> At present, resource control (resctrl) provides basic interface to configure/set-up
> CAT (Cache Allocation Technology) and MBA (Memory Bandwidth Allocation) capabilities.
> ARM MPAM uses it to support controls like Cache portion partition (CPOR), and 
> MPAM bandwidth partitioning.
> 
> As an example, "schemata" file under resource control group contains information about
> cache portion bitmaps, and memory bandwidth allocation, and these are used to configure
> Cache portion partition (CPOR), and MPAM bandwidth partitioning controls.
> 
> MB:0=0100
> L3:0=ffff
> 
> But resctrl doesn't provide a way to set-up other control that ARM MPAM provides
> (For instance, Priority partitioning control as mentioned above). To support this,
> James has suggested to use already existing schemata to be compatible with 
> portable software, and this is the main idea behind this RFC is to have some kind
> of discussion on how resctrl can be extended to support priority partitioning control.
> 
> To support Priority partitioning control, "schemata" file is updated to accommodate
> priority field (upon priority partitioning capability detection), separated from CPBM
> using delimiter ",".
> 
> L3:0=ffff,f where f indicates downstream priority max value.
> 
> These dspri value gets programmed per partition, that can be used to override 
> QoS value coming from upstream (CPU).
> 
> RFC patch-set[2] is based on James Morse's MPAM snapshot[3] for 6.2, and ACPI
> table is based on DEN0065A_MPAM_ACPI_2.0.
>

There are some aspects of this that I think we should be cautious about. First,
there may inevitably be more properties in the future that need to be associated with
a resource allocation, these may indeed be different between architectures
and individual platforms. Second, user space need a way to know which properties
are supported and what valid parameters may be. 

On a high level I thus understand the goal be to add support for assigning a
property to a resource allocation with "Priority partitioning control" being
the first property.

To that end, I have a few questions:
* How can this interface be expanded to support more properties with the
  expectation that a system/architecture may not support all resctrl supported
  properties?
* Is it possible for support for properties to vary between, for example, different
  MSCs in the system? From resctrl side it may mean that there would be a resource,
  for example "L3", with multiple instances, for example, cache with id #0, cache
  with id#1, etc. but the supported properties or valid values of properties
  may vary between the instances?
* How can user space know that a system supports "Priority partitioning control"?
  User space needs to know when/if it can attempt to write a priority to the
  schemata.
* How can user space know what priority values are valid for a particular system?

> Test set-up and results:
> ------------------------
> 
> The downstream priority value feeds into DRAM controller, and one of the important
> thing that it does with this value is to service the requests sooner (based on the 
> traffic class), hence reducing latency without affecting performance.

Could you please elaborate here? I expected reduced latency to have a big impact
on performance.

> 
> Within the DDR QoS traffic class.
> 
> 0--5 ----> Low priority value
> 6-10 ----> Medium priority value
> 11-15 ----> High priority value
> 
> Benchmark[4] used is multichase.
> 
> Two partition P1 and P2:
> 
> Partition P1:
> -------------
> Assigned core 0
> 100% BW assignment
> 
> Partition P2:
> -------------
> Assigned cores 1-79
> 100% BW assignment
> 
> Test Script:
> -----------
> mkdir p1
> cd p1
> echo 1 > cpus
> echo L3:1=8000,5 > schemata   ##### DSPRI set as 5 (lpr)
> echo "MB:0=100" > schemata
> 
> mkdir p2
> cd p2
> echo ffff,ffffffff,fffffffe > cpus
> echo L3:1=8000,0 > schemata
> echo "MB:0=100" > schemata
> 
> ### Loaded latency run, core 0 does chaseload (pointer chase) with low priority value 5, and cores 1-79 does memory bandwidth run ###

Could you please elaborate what is meant with a "memory bandwidth run"?

> ./multiload -v -n 10 -t 80 -m 1G -c chaseload  
> 
> cd /sys/fs/resctrl/p1
> 
> echo L3:1=8000,a > schemata  ##### DSPRI set as 0xa (vpr)
> 
> ### Loaded latency run, core 0 does chaseload (pointer chase) with medium priority value a, and cores 1-79 does memory bandwidth run ###
> ./multiload -v -n 10 -t 80 -m 1G -c chaseload
> 
> cd /sys/fs/resctrl/p1
> 
> echo L3:1=8000,f > schemata  ##### DSPRI set as 0xf (hpr)
> 
> ### Loaded latency run where core 0 does chaseload (pointer chase) with high priority value f, and cores 1-79 does memory bandwidth run ###
> ./multiload -v -n 10 -t 80 -m 1G -c chaseload
> 
> Results[5]:
> 
> LPR average latency is 204.862(ns) vs VPR average latency is 161.018(ns) vs HPR average latency is 134.210(ns).

Reinette
