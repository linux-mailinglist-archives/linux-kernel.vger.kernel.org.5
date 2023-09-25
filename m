Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60EBF7AE2B2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 02:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229891AbjIZAAD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 20:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjIZAAB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 20:00:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBF67109;
        Mon, 25 Sep 2023 16:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695686394; x=1727222394;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=rOLtsU6KVUVjpQbDl9GUEJ39A/ChdP10afJbu0AOx4o=;
  b=OQNiNXCabhM6JP71INIEtmS2WNgoRnv6lRri1CLdje/9shxu+RIOw8Fs
   br4UrZmEJnh3jRCjXaxLhfMFcurKSLuuLtu2bRr0i7UM98SEU82p7lih/
   QG+r6x4PeJdDtC5e0Pa0ly3sOa52yGgJwXe6yTLDIvT3u7y0blAXqnFBq
   3owALYEf13eVRNRRxCg7rLRvROmvyqnz/ovsMqUitHcfazSSHMvEYwtEo
   zqlCfqfl4XvTY08bak6Mg0ndI8WmP+wUVfeiuASyZ6MxFy9goHja7DMTF
   Q5f9yLy/XlNnReOaUZcAD2zdlW/TJtDmSbIbhm2Of3802tvM2c6VnhhdY
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="412359251"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="412359251"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 16:59:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="698252738"
X-IronPort-AV: E=Sophos;i="6.03,176,1694761200"; 
   d="scan'208";a="698252738"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga003.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Sep 2023 16:59:52 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:59:52 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Mon, 25 Sep 2023 16:59:51 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Mon, 25 Sep 2023 16:59:51 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.174)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Mon, 25 Sep 2023 16:59:51 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfjAmFDB3L0HhhESS3UADIoe/4k2f1nPq3i/fMFy3T8Tp0Tc9znzQHecavCdXE5qfUNZzJVkp/3VUxp99wAV+V6Q2AKPnFCTDRY1mEvIsSt/mxJqWxc4SRHWzDLEzJvyxE8nSutyoBJTYrUjDy9qDrYpI92uKRghags//UPx+8+FREIAEFBUHZdD2F3osDAVyOsw8ErmhxEKiEKo9cDIN+6p6aR01+4ayJLxZgDyUaGq0xVw9m2MKnNUR8K9TqgtlVb2QgfihRtfuLih19F3ScaTiab5rP+IDOUdPvu9dKpQYrl5INh3f4yofnDxHWKaDPMidDJhBq9eEBqmggvqAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8vtXlJh22KnpygVQfsrfa6YTyyxXBXXRZyL2oIyuVHw=;
 b=l4BH7SLqPSoLXSQcP48E/Azizs6dRUzm3y0SSimCN6Lp4dlxWdbpoI7//2XKniWZqaGky5nCtiIipRUPIuvOehAkQup46E1uJFta4J87SAGzTlcxNCV+FW0s/BCRYKDTTzoR5U7/NN4Mr/G4qb7D8dbifHrsWzjbnkgHzmyLBijsJwCXw/MAyMG1Wsp7pK7fvNVbqhLx4EG8iiTGZKB8gOcB0GZ7kMV/eqbPKoCDd4TNO9EGHZUeXW1j/EeyJ0r0fFG8YwDN8fXMtwJ61vAOHPq/hGK9vGCLLlo3InqsRhEUvyTu+fxV7awkxlg/ZKNdS3yrRD8BKDLvlWXxO/YZOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BL3PR11MB6435.namprd11.prod.outlook.com (2603:10b6:208:3bb::9)
 by PH0PR11MB4824.namprd11.prod.outlook.com (2603:10b6:510:38::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6813.21; Mon, 25 Sep
 2023 23:59:47 +0000
Received: from BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf]) by BL3PR11MB6435.namprd11.prod.outlook.com
 ([fe80::ed7a:2765:f0ce:35cf%5]) with mapi id 15.20.6813.017; Mon, 25 Sep 2023
 23:59:46 +0000
Message-ID: <9e1b824f-04d3-4acb-66d3-a5f90afbad0e@intel.com>
Date:   Mon, 25 Sep 2023 16:59:41 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] i40e: fix the wrong PTP frequency calculation
Content-Language: en-US
To:     Yajun Deng <yajun.deng@linux.dev>,
        Jacob Keller <jacob.e.keller@intel.com>,
        <jesse.brandeburg@intel.com>, <davem@davemloft.net>,
        <edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
        <richardcochran@gmail.com>
CC:     <intel-wired-lan@lists.osuosl.org>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
References: <20230627022658.1876747-1-yajun.deng@linux.dev>
 <10269e86-ed8a-0b09-a39a-a5239a1ba744@intel.com>
 <72bfc00f-7c60-f027-61cb-03084021c218@linux.dev>
From:   Tony Nguyen <anthony.l.nguyen@intel.com>
In-Reply-To: <72bfc00f-7c60-f027-61cb-03084021c218@linux.dev>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0204.namprd03.prod.outlook.com
 (2603:10b6:303:b8::29) To BL3PR11MB6435.namprd11.prod.outlook.com
 (2603:10b6:208:3bb::9)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL3PR11MB6435:EE_|PH0PR11MB4824:EE_
X-MS-Office365-Filtering-Correlation-Id: 98567351-23f4-49aa-3e99-08dbbe237ef5
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: /ua/C4Huna6DX8Z1nRJlj8+nAYOR1YFtpeZgsURn0NmvwZOVm6gJNnlBhN2s1ekknY/yeOhKqGIVRx0pkpE2DTlqRsgyEFjAij50SdrFkpwtASJVDTefr+kQFYNlj87DXjNYBWNEDkst7tLAGUF5zziSMJ4WEqR+tcWkRPFiGyCTGRfHhmyycPY3Aze/Q8HQX9KIS//RBAjchoY3W0W/LF5elyJGaCxjlAndmPiLY2faSpGezTfwdDCxVIQLgr6dvQtyJAq9eA9MfiCaSn0WmKdtwIDRsaFK77OE+PP37F91p0gzKI1/Uxgw9Q2MJqbv0x8NV/tRZYrcvJPCLZAuk3Ie2rDvKYBa61EFNMWyOewvbD2MNi29DIXO1i+xssLO9N1jBKivnJCJ0MJmPJGjHkQ0GKLeiR/HomSW2U6xyY/z+DTKy5S0xiKpT0tSEpFG2pmbXgj31s4Oo5TooPOclepaZaX5qk4vmSpnCLQ8SlFTZgs+ydgLODNehDtb3Pq5I2FCU6U8/hV20ClJjJm4rsYp2cZYiowth0ZwIifJ1iEgrDupvShETL8Fi6KS9lyHMWeWrFQGTHD5TN07a51tAbQKzrbXx3iNTxI+1XE4FZaxJ+lTpNriPw59hV0L/Q3GqJVtJqM/nGt9IMhq3RNt2g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL3PR11MB6435.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(346002)(376002)(39860400002)(136003)(230922051799003)(1800799009)(186009)(451199024)(36756003)(6506007)(6512007)(6486002)(53546011)(82960400001)(2616005)(26005)(110136005)(66556008)(66946007)(478600001)(6666004)(41300700001)(66476007)(38100700002)(966005)(316002)(5660300002)(31686004)(7416002)(31696002)(86362001)(8676002)(4326008)(8936002)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dlF3UHpZOWdDcEJMTytyWVgvdjU5V2VkeldQeTJqMTVTbHdQRmhkTml1L0lX?=
 =?utf-8?B?MWkreUxqSzdCZG5VNEE3QjJONXlZQnlrQ2hGNEoyenNNWGNUVnpGSXp0cDV2?=
 =?utf-8?B?Nmo3UEU0OGZvZ0ZhV3pSTTQzV01jaWxYbXl0QU5ob1Z0M1ZiRDZRODB5M1ZT?=
 =?utf-8?B?eWhkQy82UWdiUGRSTFZlYy9WNnVNY0FhdzhaZGltREdZeHVTMmJmSVBodFZm?=
 =?utf-8?B?NmtqVXBwcWxCeXlwQmhOWGJEK1VSOTZRd3hoZE5tWGg1ZDFPdjdPTHRCbEdn?=
 =?utf-8?B?blBua3I3c0E0aXR0YkhmbFBGWFhwVllLazFYdElIUVJoSjkyUStJMFJReGNt?=
 =?utf-8?B?U2w0eEFTSlp4Q29UM2orYzZFVmZuZzNLcHZUSkl6V25VR0ZuNlRrVENTallC?=
 =?utf-8?B?aVRicCtxQW04V1oybS90Um0rL1Vwc2JBR2dxdDQzQkhhcEs2SjE3VmtZZ0sw?=
 =?utf-8?B?ZHhLRERIVm1NZDVKS0hRTmxSeUNYdlQ4aHVkQzJ3MERFTjF1RGJ5eVhCODVk?=
 =?utf-8?B?NTBYcURleHBFUXN4aFJySHhsTVYxdGNHWm00cnJ4VTZmZDhneXdsaFdSdE12?=
 =?utf-8?B?ZnZua1ZsQ2REeExWbGYyNzFnQ3hBNHRpb1ZObEFuUXIreDFhU3AvclBPQ3BR?=
 =?utf-8?B?RnZTMjJRNDBxUDhreWxxNWJqYmtpbThaSmRua2dSS3VFWEtQT1R4TUdwNmdm?=
 =?utf-8?B?U3huNzNYazFpN3VZT1c2c05Db2tMQzF3OFpkc2lCWm14b2F5cmExWlJ1NU1h?=
 =?utf-8?B?WlkvdnRJalB5dkJLelJJaWNhOVFFQUltWklYRnNhM2ZmODRLYlVXZWFMWHdy?=
 =?utf-8?B?NXBzWkIxR3pRVWpKMkZsWHZPRzlnUGZwVG9LYWxsU3ZielB4cW5IcEFXRmVY?=
 =?utf-8?B?NEFMaTRjZzBVc003S2hVUy9JS3N4QXd3bjZtaE9WcHlteUR0T2kvWFdEU3NH?=
 =?utf-8?B?UGMzWnE0dUhPcTJxaGdkREVSdkZJa05JZ1ZuTzBmVndWZVpXNkk5Wnlvekx2?=
 =?utf-8?B?L1NMcWhKUmNDZ0Evb2JXaGNjdE5QUy9QYzY0UXM5aE1xRUxUZW5mYzBROTNv?=
 =?utf-8?B?dGtFTFdTL3pBU3pIVVRSOVpiaUhwUFQ3aGIwa2FMazNUNUhTK2xwWWt2ODZh?=
 =?utf-8?B?S0tHNjZaT0JSS2lHZmh4ODR3WENydW1yRklwMFVib3VFTkVYdGt4K0F2ZFFj?=
 =?utf-8?B?bHJGYVJrSUtMNHZnbkhNSE9Yc2ErbjBtVklXUTR5UWNnNWt1bkFIazJHcVRW?=
 =?utf-8?B?VTV0anBDWHVNb1ZFR1czcGlqcG9mSzZqcUFXbkJFNXhPNWFMbUZmQ0NlUTFD?=
 =?utf-8?B?T3FCNWVIbi8zQXA4ZnpBYUoyRDEyU0Y4RXVjanY1MVBIU0R2ejJDa3RQbHBm?=
 =?utf-8?B?c3BWcmZGNFIyR3BleDUyU010NVdta2hEYXlLeGZIU3ZGcmk1QXRDMkxXTTdy?=
 =?utf-8?B?Qi9IS2hHNUdwSkdTTlZ2VXlCZXhxVjVvSFFOYTlFZWliMno0ZWRQYnZvNm9I?=
 =?utf-8?B?bElTdUtDT0ExemtkMVhSdzRpMnIrTmtUbzUzQlRNN2FpU0hybzNRYzEwK25m?=
 =?utf-8?B?eG9XL1Nvc1Blb20vVHZaSVFmWUdsWDErY2Q0aWhpd0lnU3ZRTHUyeGFDNllK?=
 =?utf-8?B?QWFJRXR5ODRpTFpGR0owYmJqQVpLSHNXcFY0RGJMTnpiWkUvOVJYc3dMMjhR?=
 =?utf-8?B?bUd6WlpsSlo0WC9OQ1lYY0huUW9pOFBKL3luRTNmNHhKUExRU1ZxeWVMM1lr?=
 =?utf-8?B?WWlUSnR2TFpzaVMzL2VuMXc3WkFwT0RhQjF4SXQzM2FvcEV4Y1RSVlBkNzhu?=
 =?utf-8?B?cHhYa210Tm5KOGJISko4WUpxazNOdzVaSjlqSzExMmdrRU8zSWMyeW5uVHF0?=
 =?utf-8?B?NzhzdDB4VUlNNWozaUpKR3hHZjllWDRUV0F4bDF5VUw2WWlCVWpubnF3b3JD?=
 =?utf-8?B?YjdSOTdZcVpJd3k3dVlmYXZ5M0FZNmlxY0VmaE1pV1owSVl1aS8zZ3VTN1Fw?=
 =?utf-8?B?d0V6UVdkeUYrOEF3aEpRay8wZ2pDdkw4bDY0cFlQNHhhRHR6d1NzbFhjL2I4?=
 =?utf-8?B?bXRTNm1xSURVbEtkNmE2Ym15Z3dONXRuV01IN0FKa2pHVzIvdGt5VGxudDcx?=
 =?utf-8?B?MTBzUHpSS1RaRXEzYVRJdTlqSkhSUFJNa3R1TkcyTHJvYjZUME9DT3VYQkU0?=
 =?utf-8?B?MVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 98567351-23f4-49aa-3e99-08dbbe237ef5
X-MS-Exchange-CrossTenant-AuthSource: BL3PR11MB6435.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Sep 2023 23:59:46.8269
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JPjxyu57DSuMI5pg9NGy5finWcR4WwVs9A+T6ydtpbEO1PcyZzDA6I8VyCFRYd4pY9AkPJZTQJYTpnSIoganWjC9pJgJf54WLe3/ki1376Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4824
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/25/2023 12:55 AM, Yajun Deng wrote:
> 
> On 2023/6/28 04:20, Jacob Keller wrote:
>>
>> On 6/26/2023 7:26 PM, Yajun Deng wrote:
>>> The new adjustment should be based on the base frequency, not the
>>> I40E_PTP_40GB_INCVAL in i40e_ptp_adjfine().
>>>
>>> This issue was introduced in commit 3626a690b717 ("i40e: use
>>> mul_u64_u64_div_u64 for PTP frequency calculation"), and was fixed in
>>> commit 1060707e3809 ("ptp: introduce helpers to adjust by scaled
>>> parts per million"). However the latter is a new feature and hasn't been
>>> backported to the stable releases.
>>>
>>> This issue affects both v6.0 and v6.1 versions, and the v6.1 version is
>>> an LTS version.
>>>

...

>>
>> Thanks for finding and fixing this mistake. I think its the simplest fix
>> to get into the stable kernel that are broken, since taking the
>> adjust_by_scaled_ppm version would require additional patches.
>>
>> Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
>>
> Kindly ping...

As this patch looks to be for stable, you need to follow the process for 
that. I believe your situation would fall into option 3:
https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3

Thanks,
Tony
