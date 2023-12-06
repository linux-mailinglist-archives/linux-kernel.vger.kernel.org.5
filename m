Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41654807799
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:32:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378821AbjLFScX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:32:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378819AbjLFScS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:32:18 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E4AF122;
        Wed,  6 Dec 2023 10:32:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701887544; x=1733423544;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=t8UTzvL3Z6vNhoDTrVV/fGfJRDD5W9B9OxsWU79Syno=;
  b=drjDWDuwJYalqyuSjA6s4JEaHMkCjRrbvQ8fpkGgIjv5Xi9VWaaEjBL+
   FLacndx5ZS/Kwc1Q9oU/6h3WGBslDov1tWAEon7dIXs6tKye59FbO/ugb
   c43i1k1/sW/i99GgeWhNnz0DjcsNKxJDc3jg62Kb4P7KlJz74/ReCVBXl
   Gk2Nm617wGfeVYJMYea8JPny6ao0ecvIOaSKXPEe4EBbds9T/sOV5ct+D
   7vPE0ZTvi3ym3ApAGw9Dojw0d9ACfeazRWOT3oSy601d3ylOE/fdHMw29
   6GoS36vjZsBbftXW1HGg7L9AkpGzrmsOu23zr1b8Ubj+oF/c5lEgTLGqJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="391274867"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="391274867"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 10:32:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="19407279"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 10:32:16 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:32:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:32:14 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 10:32:14 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 10:32:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZHA5gO+70fktmmuefmtjQF/kvgBxqDsta1JPURB0FXYTXh05OqNdy8sRShkg42AceMoG67UlPTQlinpWZpNE1WCLr/EbP8UFCJClIHykcFf36FyNwvEWbD0/xyQfpFxAL4KNZ9ZOQ9dr3Y49sGBc4fOYWQ+02sqkTOv/qlAhnxqKwdOopQm3X0I0o1+gcQu5/LSWTYBG9oHNOMuD4UfDrLFCtUuUR47Jq5RUM+CgjjAON/Njp9JnnPTeQjLZAuw+Xcpc+rGqjK6YxAu2teAIXi0W1UsCd3eE9VGXrtbxX199CSvzXTxkYOgUqmSRTKUw/k6yR0r+1SU0n/d7AGAKjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ngG0O1/Y/2AQ1tUj99j0UZFW6uJaW7GVI5LPEg/K9m4=;
 b=ZRR6885WT6VxvfIp+ypBoKEDDbf8DwgoIoKKiPDVxFjGcLPD2UG8v4bLUGUWwk7twIYEA5lP2vgVbLWKrmPlwFZ1kxURSGjM6+T6H4sCgRLweuuwDmqxaTIsryWMw+G0F+sJuBqLYmPIbw5jL5j/9QsWWanysnk1lMu14UBD+AA4/X42KKlY71+2mx4lDGKu2BlENzSNb9Ei5mT/EFh7q1LeTVA7K9gdCUlR1HGcS899Gme1cl35L2vCXexb+B4ayI5VlSUn1QZoTeFtVR0nzTA0NOAPkontnbGf/LpXRtxhJ2o6WVNBxSDTQIN4EWwJKbrZq6kYcRZKLF/W6BTBEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by PH7PR11MB7717.namprd11.prod.outlook.com (2603:10b6:510:2b8::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 18:32:10 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 18:32:10 +0000
Message-ID: <19e3fd3d-a2ec-4c8e-aa47-44f8f41b569b@intel.com>
Date:   Wed, 6 Dec 2023 10:32:03 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/15] x86/resctrl: Remove hard-coded memory bandwidth
 event configuration
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>
CC:     <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <rdunlap@infradead.org>, <tj@kernel.org>, <peterz@infradead.org>,
        <seanjc@google.com>, <kim.phillips@amd.com>, <jmattson@google.com>,
        <ilpo.jarvinen@linux.intel.com>, <jithu.joseph@intel.com>,
        <kan.liang@linux.intel.com>, <nikunj@amd.com>,
        <daniel.sneddon@linux.intel.com>, <pbonzini@redhat.com>,
        <rick.p.edgecombe@intel.com>, <rppt@kernel.org>,
        <maciej.wieczor-retman@intel.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <eranian@google.com>,
        <peternewman@google.com>, <dhagiani@amd.com>
References: <20231201005720.235639-1-babu.moger@amd.com>
 <20231201005720.235639-3-babu.moger@amd.com>
 <47f870e0-ad1a-4a4d-9d9e-4c05bf431858@intel.com>
 <22add4c6-332c-45e4-ae0c-f287d6bff341@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <22add4c6-332c-45e4-ae0c-f287d6bff341@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0016.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::21) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|PH7PR11MB7717:EE_
X-MS-Office365-Filtering-Correlation-Id: f6151a25-7d7d-496b-9815-08dbf689a870
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qnQyzUv5vm4k9yL17GpklDQI/bmUI5MHKn5UFHZv1cljQymbnYv6rqj47WH/mmAsJsyeIhbrl9s9XcPUMkBsfVpdNXV4i8AyEjDH0VDIloEc3S3VUzmrvrplq0784ekYtiQvYAmlBz7hYcuDBXAc7cX/qwnPAZ5UYcMcHzbGph2Rnu+3nVHwodnfnuD5xPp9f5vC3gJlN39To9rTJ/faZIbn583S2MUX+KkpuS+xMe8hAatbDv+BmuP3/B714GBKrvp+tCY3dh2AeNjfTsA27VhhuJSjkIJLjBI2fLy9SD1USBJPEVrq/DMtIr0K1jaDr/Wht0SXP8IvmOvdKZk7soPRjaJPmGtA4aEe9HpOFwCYCgZKryDQHbvhoDRofFNBTJqNhWWiZgN3Cl+ptax4Zl1rm6NC877f7mTvaIi8MjTpxP+fHSfURAWjKxEbBEEOLyMbKm88hkzG8Om0/cCYgT997cuTjI5w3VkP8xfR524cCrvMSHI2SolxMx7vYc8gFYUXhd6ew1W14ngPiQ84f7CtblZWqZUpfXYD+SYtfQNzYZVKy+sOI5rW3ZyQE6eF+5NeI5IQgLwU3Pn78RkNThhTf7IiB9vQtWHOqoAb70zgCdG9KuWaJXBCBs55j7V0+WEgMgPFFVgnl66nzM6g4A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(396003)(39860400002)(346002)(376002)(230922051799003)(64100799003)(1800799012)(186009)(451199024)(2906002)(26005)(31686004)(31696002)(86362001)(38100700002)(82960400001)(7416002)(5660300002)(44832011)(53546011)(6506007)(36756003)(2616005)(6666004)(8676002)(8936002)(6512007)(4326008)(41300700001)(66476007)(66556008)(316002)(66946007)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U1F5a3kwV0RCNVo3ZFYwZ0x0bitqaUIwekFLQ3AwVnYyZ3hONjJJSzRNYS9D?=
 =?utf-8?B?THlVbngxVnphZk9wOWxiNE51b1pjSDFXVzFHV1hEWVBHL2c3RWNlUzB1VVJP?=
 =?utf-8?B?TDFIdkU2YnpreURZQ01pQlJxb1JZenNpYTNhNHBET0tJYS9FUWJmSSt4SnRB?=
 =?utf-8?B?Vkl4QUcrd2pYK3ZOd2pvVkVqWWZISTQ3ekIwUGF4eXY2MDAxakdVMTgxUEli?=
 =?utf-8?B?aXhtR094TUxnQlJsR2JScVlLUEU5Nkk0NkVSRm9acDNRdWwzR2ttblNwb2NF?=
 =?utf-8?B?Zm1hMWFtRExvUnR1cXY4OU00bi80UXppYmJoNy9qWHlpaGcwbDBCSmZJUVYy?=
 =?utf-8?B?ckVVaWhHWmdxVk5ydXJHM3RnTGQvS3pUeFBPeTJnQi9UaWZGbDdTZnVnWmRV?=
 =?utf-8?B?bXF2Y1lLQmdVd3EzRUpuQjhyTk5RUkxucDZiK1FlOEovZmZCMFRrdHp2RmdO?=
 =?utf-8?B?ZWFXYWxLUGhCZTdIbzVKR2o4MVJKeXdndHRReGd6QmpNWHZHeWpYVHJXVWNE?=
 =?utf-8?B?bWtzb0h5Q3dXaEs1SEROZUNqazMzVmc2MXh4T3AzZ0hjWGR6ZnFkaEo2RENj?=
 =?utf-8?B?Tm0vcWlDVFJRa3Z1WEpBRE9FNTlyMnNhUmx5ZkFPZUI5MnNTaUl6eDBjOUd0?=
 =?utf-8?B?aG5kVFVDdnllNmYweDBKUTBtMFdQZFJqd0ttWXdyOW1LY0d3UTRxbWN1dHhN?=
 =?utf-8?B?NnBHMFo3Ri83Y2RrdVp5TnQwY0RObHNBK045RW1pRVlJdzdGcUVKd1MwSVZl?=
 =?utf-8?B?NW96dDZySXQwMUJUK2I3bmZraHdpV0g2MGNPQmRuMEJxT2M5a2J2eVVGOHcv?=
 =?utf-8?B?amEyZTJtcWhsc1ZTQU1FclZzQ1ZtNHh5eWVLS25FaDZhSkhtTkNDSHJYdWZL?=
 =?utf-8?B?a0hJWVphcUpqM1pDS3B6N1ZDZTE2cHpLWmdySkZOUnJ0OENaZ21xNlBNdlJN?=
 =?utf-8?B?bEszUS8zY1FvSzFCaGRBVzhuN0JjTzNjS3k1STdhakpqVmdUTkhRc3BTS3pK?=
 =?utf-8?B?bHRRN0cyV3BNVlNXT2JJTE9GS2txQk81MktudUlWQVh1YlNUWU1tRzRDU05F?=
 =?utf-8?B?NXU0N0c1akh6cVRFS2dkV0FxNE1mczNueElMOXhqbEZ5VGpTU3JjMGlMdWQ5?=
 =?utf-8?B?bG02cGpWVDVCWm9FZEVWdU1PVjdqTi9Xa2JQbjBmQTF1NllyYU1nTmI1MUtj?=
 =?utf-8?B?ZmR4WG1uNkNJQzQ4WFRnMnRKTDJQY3JVVk0wYmdET1EzdEJuTUFMMDBSb21F?=
 =?utf-8?B?OE1VNjlwTXdLcURIc0s3MGM0SGcxa3g1YUU0d05ETkVtMzhaRTl3YVgxT3NM?=
 =?utf-8?B?Vzk2YmFYZ3AvQmJGWXRUcmVFQlNmRWs0VjlYZFc0VmFicXlYcWZCNE5UTG9F?=
 =?utf-8?B?am1UME1jNE43ekRROGxCZWRBR2dhZXo2QW9heXI3SjVNSlc1S0xrcytlVzVr?=
 =?utf-8?B?TnhVKzNtVUJNcEFPK0NWZEdPMUZJTmF5V3Y1akVWS2lQTEdGcGpDeldjRHdB?=
 =?utf-8?B?WjVJejZkQldoR3Jua1hlU0h2REMzNVgyemVzZFlXWDZKcnIwOTY1ZjQxclR0?=
 =?utf-8?B?TkVqYytPcmZSZFprSUZxalhkZFVLcldoZS8xSWtXeGV0emdrMjFsRjJncE9t?=
 =?utf-8?B?dGd3MEFwaWRQWnJPM3hkaTBGcDFmTlpBK3ZEeUdnekZFekgrbDN4b09ScEwr?=
 =?utf-8?B?VHdwUld4Qmc4SC9SczYvY3dBWnNlN2xSQ0VnS2xWMFNsS2E0UHR0b3FvMjdo?=
 =?utf-8?B?ZkJPYlJmRFMxeFE5T1pHWlVGWC9nZmJuaGZPMVhPYms2VDcwR1pCaG1KZHpp?=
 =?utf-8?B?SiszUXZCVEJJVFNBWTl6cG5YMnRqRFVvTmRGNnBrekVKUEorcGFqcmIvYlZj?=
 =?utf-8?B?WTBDSUNlSVVpTHpKS1ZvVmx2NTFPbDVzY2FPSGh0WDlZekd2TlNVMmJHb2RZ?=
 =?utf-8?B?bkNVOCsxcThkTDFjMWVyK2RzSWFpSmMrRzdKcXZnYmY3ZjlEVmRqSmZId2ox?=
 =?utf-8?B?eXloVnhudVY3TjRhc2llbTFDTWFORk9sUDVhcVZRUVV2SjBwMWMwYmZpelh5?=
 =?utf-8?B?a3V4MUJ5UGp3anNDcDU1WkMrRlF0ZTkrdEZlRWtZOG9xcjZGejNPUGN6dUpY?=
 =?utf-8?B?S2hlSk1QODJjTXhCRGhNZmQvRzZlZEtEOGdWci9SdGxLOGNCZXNvYmRhalJC?=
 =?utf-8?B?UlE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f6151a25-7d7d-496b-9815-08dbf689a870
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:32:10.2163
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: RAFd1z9LGUr0uMfKsWEiDHxjWWzq+M3Vb93rZakZMtjoPQ7NtmbqvpPqbBLRXJmnvkH1IGA/YZBFFzSkH+YHH1Adjd1fOgQd2F1ZTway6zI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB7717
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 12/6/2023 9:17 AM, Moger, Babu wrote:
> On 12/5/23 17:21, Reinette Chatre wrote:
>> On 11/30/2023 4:57 PM, Babu Moger wrote:

...

>> Comparing with supported bits would be an additional check, but what does
>> that imply? Would it be possible for hardware to have a bit set that is
>> not supported? Would that mean it is actually supported or a hardware bug?
> 
> No. Hardware supports all the bits reported here. Like i said before
> wanted to remove the hard-coded value.

The size of the field in the register is different information from what
the value of that field may be.


> 
>>
>>>  }
>>>  
>>>  static void mondata_config_read(struct rdt_domain *d, struct mon_config_info *mon_info)
>>> @@ -1621,7 +1621,7 @@ static int mbm_config_write_domain(struct rdt_resource *r,
>>>  	int ret = 0;
>>>  
>>>  	/* mon_config cannot be more than the supported set of events */
>>> -	if (val > MAX_EVT_CONFIG_BITS) {
>>> +	if (val > resctrl_max_evt_bitmask) {
>>>  		rdt_last_cmd_puts("Invalid event configuration\n");
>>>  		return -EINVAL;
>>>  	}
>>
>> This does not look right. resctrl_max_evt_bitmask contains the supported
>> types. A user may set a value that is less than resctrl_max_evt_bitmask but
>> yet have an unsupported bit set, no?
> 
> I think I have to make this clear in the patch. There is no difference in
> the definition. Hardware supports all the events reported by the cpuid.

I'll try to elaborate using an example. Let's say AMD decides to make
hardware with hypothetical support mask of:
	resctrl_max_evt_bitmask = 0x4F (no support for Slow Mem).

What if user attempts to set config that enables monitoring of Slow Mem:
	val = 0x30

In the above example, val is not larger than resctrl_max_evt_bitmask 
but it is an invalid config, no?

Reinette

