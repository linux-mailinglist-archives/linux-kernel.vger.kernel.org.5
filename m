Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5465807814
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 19:50:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379174AbjLFStx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 13:49:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379104AbjLFSts (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 13:49:48 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E18331720;
        Wed,  6 Dec 2023 10:49:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701888562; x=1733424562;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=iCc/edTT0uRdhcbkba3Y/kLi4+67bLK0oifOeTFYjRA=;
  b=TQxZNS2Hu9xNc9FhFJC4jzFiBpM7bp2cr7se8D/aw/PmbN66dIzZShfl
   0qHPf1pg14JpjEYVb7/OZIevwtHWhbCfQVj98rKCeb1EjlGLXcOz1XJ5O
   fI/co4pnjZaI1mxSi/5zx36TubIn0cFUbLQeP16Jp9htFkBhE6uD+h+hj
   pQu/yi6Z/nVqpdt+EfwcdIkVSyqGPrnO+8RFF3tgB/gfiyPSo+ayy4BF1
   T5Cd2YEK1o2WrHchBUnWTDFYWqu03qnPjTd3v6/uj5+3Cf0vffuwQaw0/
   F4dIdecKxST/mJ4dGjVHrX0YSe8j3nKVxWv8s92aRstwahS435d5WFMOl
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="393837925"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="393837925"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2023 10:49:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10916"; a="1018661788"
X-IronPort-AV: E=Sophos;i="6.04,256,1695711600"; 
   d="scan'208";a="1018661788"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Dec 2023 10:49:21 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:49:20 -0800
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Wed, 6 Dec 2023 10:49:20 -0800
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35 via Frontend Transport; Wed, 6 Dec 2023 10:49:19 -0800
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.41) by
 edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 6 Dec 2023 10:49:19 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JzkTqudAEND6fBk8HxV8szGqWwb+sOkQ9iSz4ChZwy5uNMxS/Ht5FiDmN6tueAp92TPD56WrECQpupfEXdNSbMEoiVKJBYz7bJ1RH/fjVtvc6EftwFa5d7vLgcH/UT5KB75YOuEM0ZOfaqBhQmx/AWIUZwVyGpA8F/CDU+UBDea+As+pLIclv5837a4lYxY4FMlJY6pYibHbP0blrAAPeFPda5IkRey+YkL2MCfi8Mp7inAwM9fTrZsv0YvDfl2szo7Vkn4BdD96cnJrm7E/Qb0klj5cSTLtH+3TirJI2mDBQvLxTyF6YnXaqKYjkc9Kwhg/UcGHBHQJfcc8EB0dVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Q3gAVQW8w5MB0obudUTJI+uHr659na9Q6+i6K0by8BY=;
 b=Eza80SD9MmyK+EQq5SyXQsXRCy6A13aU8b+D7LWrEReI1d242//cMlKUZLixUjGHKo5DspAe/65F/+XkxlOYJPbMgCA0fyAzc8klnvUOTuVfSxxmDu3Py58N0OqFLTiuxxbm6HWxkXMyfFM+uc6p2tBhiaZqtPHWwFyj7I6O8MDl/6psgTjNL0QWjKtvKMB8cwJ4XyvpTccIkUANTAcUrchhop07s83ILnDd6IKLNQww0FQ9KNxxaZQQCZFd+gQzC+uTgrd3Wl9DFCW1WNrzgMjaZzQ3J3paXhU6rMyorVDUumHJTtZiDAEpq+KqRF1eQ20I1XsbrjkkbcK4gInm2Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by CH3PR11MB7841.namprd11.prod.outlook.com (2603:10b6:610:121::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7068.25; Wed, 6 Dec
 2023 18:49:16 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7068.025; Wed, 6 Dec 2023
 18:49:16 +0000
Message-ID: <e36699cf-c73e-401b-b770-63eba708df38@intel.com>
Date:   Wed, 6 Dec 2023 10:49:13 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] x86/resctrl : Support AMD QoS RMID Pinning feature
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <fenghua.yu@intel.com>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, James Morse <james.morse@arm.com>
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
 <d97cbeba-af6d-4b64-b5c8-32dc437a67b6@intel.com>
 <71e85bf3-a451-4adf-ad5e-d39f7935efa0@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <71e85bf3-a451-4adf-ad5e-d39f7935efa0@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0208.namprd03.prod.outlook.com
 (2603:10b6:303:b8::33) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|CH3PR11MB7841:EE_
X-MS-Office365-Filtering-Correlation-Id: 4e7cd779-5900-4e2a-37e5-08dbf68c0bf1
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: SuSvAt9ojvTKMhOXkyUoHb6VcDpd3X9cgIVEGK/9NWgFZVCR2DAwkKbCF75oba+9NGa8ey5Dix2PzBD8MgSLAYOZy5ljA6ouM7FDEOf2sqC0B0USOzODCCaSDZIww0LKCFY+9wNfzQ7/jmN1GbsmVLy3G6wO2lTPcYtVw2uotybCj7qA8qM20bHrcLYNSCuvMUrIBVY89f3ecBCQPq+FJvKnPM+T4i7Dh8ENOnunayiHTwqdWHKrwcq7ThyqmEmrbpdq228Q2JggFA0kOTi3Asgv1PfwFxvzOE8Wc2qmmJ3xX0oSNHNuLwaNRdBzkJF0yiUnHMs9NhZadNMDzwuOSiJrQtupXTXZEAIFukybFksbvjAjhTi/eyAE0wqw/V1MjfmH/b9hcMAC/uppDx6RUtNRlrdhh/333xoCx565jqZG6h4G15p9CYrPzUQVAhnR94EpwiCgSOiV6aPEl8RngnQFt8xPAsIGrp7V2CLXz1LC1Lygh17WOznK+EQsvBy2Pms085X4DjTs4qGTSwDw7TDwYu2Mnkbf47oSHDVWlDx2N0tBE4bgviZ0bo/MQte33yRL6QzHfOW/+uiD+mDa86m+xen/8lWLS8fmvVVD1QFJqyUadQdI+N/B+OdcsMr+DQpyn7CGkCwm1oOjjHyKcw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39860400002)(230922051799003)(451199024)(64100799003)(186009)(1800799012)(83380400001)(6666004)(66899024)(6512007)(2616005)(6506007)(53546011)(26005)(316002)(66946007)(66556008)(66476007)(6916009)(5660300002)(2906002)(7416002)(4326008)(31686004)(86362001)(8676002)(8936002)(36756003)(44832011)(41300700001)(38100700002)(31696002)(82960400001)(6486002)(478600001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?cVpWUlZHaGhlWjNrZ0VuWStiNjg5WGVmb2ZoRTBSRDJob2lNQ3gwUG9yWGlo?=
 =?utf-8?B?NTJCaEp5OFhPL05SMStteEJldTNveHgxWTd6N0tJU3NTdmEwTEhmQ1U3enJW?=
 =?utf-8?B?MUMzaVdxa0VnYktNR3ZpY3JuSkdteHl1QmdwVUNHakZ2bEFOU2Y1N1RnVWdD?=
 =?utf-8?B?QnVNM0JZMkw0aVEyRVRFdUl3WXpvc2xUVEZEa05scFRQWGNSd0xobG95RXZY?=
 =?utf-8?B?WHpKOGViODczbVE2cEsydGpTTDVJdkpNUFRBKzY2UWVsUUJMbVRVaUs5cUND?=
 =?utf-8?B?UndpYy9Qd1lMbzVpZllWRWNiMGowbnY1VngyWHVxd3A1UVFOV2pHQlIyd0gw?=
 =?utf-8?B?SXgvd2Q2R2xjdTFNNFdTOTJQYWRET0lydXFtbWdOc09sTEZ4NW9PTGV1aHU0?=
 =?utf-8?B?M0ovQnNnVFg1bWN3TUNXWWZOdk5BK1kvMUpYOWFBT2VrYXJ0ZXNMN0doMC9V?=
 =?utf-8?B?VVl2bzFFVllRWVBMQmlRLzFtRW9ITFlwOG5mSlgyUCt0S1BMZVYvSm1mUkI5?=
 =?utf-8?B?ajl5VUd2V1diTDFIc1ZITTErVEF5cC9oZlFOZytGUXJqYUNhNGtkMi92bXpr?=
 =?utf-8?B?MjA1bW15UDVqM0U4U3ltV3Bkb1ZGN1pWdVlEamgxc2pZN1BtNmc5d2tUc2Fu?=
 =?utf-8?B?TE0zWVk0ZHJPek9NK0hrVmM5cTczVFVieUtMdi9ibXlqWW1ISVN6Qk92RVRR?=
 =?utf-8?B?MHN6aVZFVG9XSXA1TVZMMTB0ZWo3bHF5MG9hSFl4RkFrZnJhQjZjaWt6LzJa?=
 =?utf-8?B?bFdZbXhLN3pRUStyTlQvWEY4UzZBenRyN2RKWCtWbU81WHZNTTNDc2VMVHRW?=
 =?utf-8?B?YWN5bXRiYmwrRWNYeE80emNJRkZPaVYyVTd6UXpVRFNYT2NxdlJSVGo4VmQz?=
 =?utf-8?B?MnN0WGYwN2VXdnZmQS9lcjJiL2dSR2dMMzV2akROMDZKVWJTVGVUU3RENm9Y?=
 =?utf-8?B?OGkvR0dhUFc0bUVDeDBmSnZ6WjJ5TnR3YW5SUGxvcitVVmZpMVZIbmRFcHhU?=
 =?utf-8?B?dU5iR2crRG5yYVdQYUhpeks4Z0M2OTJVbERJcDUzTHp1MFBjSnM1ckd5bDRX?=
 =?utf-8?B?NkM0bFVablhKbHY5Y0xaZE9FRytwZ0ZmMmdFL3RUOS90akQxeUc5SldkeE9I?=
 =?utf-8?B?ZDNXZnFrdUNVaWVVTEpaSnE0WTYvRFZkQ1o3MzZDOFh0Z2IyenpHMmZManVO?=
 =?utf-8?B?bjBwQkdGYWhQdlNmVk9wVFFoWVBxMTNGRVpuTk1DVjJSQndxaWEyNUJRS3hP?=
 =?utf-8?B?VFlOa05oREp6MzF5dkxwQWpJV1A2ZkNjSUkxS3Vmd2Zhcld5Rld4bjU0WnVz?=
 =?utf-8?B?bEhjOGhZNElIK25KOTgyelErVWxKWGZwMmQ3Nlc2eGR2dmpmbDNtbWNSczl1?=
 =?utf-8?B?RUFNejN6UXNZWUZFMnNUUFVoMG1QVXRUdko5RXFjL2RUSy92T01jQjc0Z0Vn?=
 =?utf-8?B?c2V0TU1EY1cvL0dpSnY5RjA4U25SQ2NCU1l0UVBwR0p4SEZUdlY4ZE14L3FD?=
 =?utf-8?B?TGtLbGc0L3RrbEQvYmk3YUVKS2taZ2c1bWVpbjUwTGFoL1JVSUJnckVIKytl?=
 =?utf-8?B?REVNcXprbE5iUEFsRFZ1QmtVeTFHYzQvZXVETVFDYVlTemw0Q3ZaeHF0NHNk?=
 =?utf-8?B?eDVpSndxald1aHQvMnc0ZFJZdmxvNDUrRFM1RmQ5RE5ZNUFDOFRnNG5jTGsw?=
 =?utf-8?B?WkJZcVY0SVpRQ0NZalVBbngrM2IxWXVTTzhvdmNmbFY0U3VLd3BrREREamF6?=
 =?utf-8?B?SkMxUkFoMnplYkVaT3JwMlYyRUZHNEJuN1M0TGdmQjRwY1M0Z2dBRDBVZHRU?=
 =?utf-8?B?YkZMMC9FTXIyaXRiRmpOM2wxSkh1ZjZRU0E3SCtXeFRKVGdSVnlnV2JPSExD?=
 =?utf-8?B?UzBTMlI4NHhiMlJNTUJBdGFzeEpLY2s2b2VJQ0JPczMrS3NkK0JlTVQ5a2tJ?=
 =?utf-8?B?N01rdlZPQjhXZzBqNnU1UW1SQmlNdFhISTBFOGpxWjRVUUdNbWJidDdxL3ky?=
 =?utf-8?B?QkJwN1A1U1RidFJXUzJsSTJ3OGtVQ0IyazRyaVJYdndlTUNoaTFSV0dUamJ0?=
 =?utf-8?B?LzdPL1ZEUGRpOEZNMndzM3Fkd28vRmFkdHhpbzFtUVVadzc5TmpyTnhZazBu?=
 =?utf-8?B?M3ZlTU42dGlCeTlaY1Y3T3U5R3ZpOGYzc0hlTmJqVEJYUkoycWtxL1ZOR0Zw?=
 =?utf-8?B?aXc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 4e7cd779-5900-4e2a-37e5-08dbf68c0bf1
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Dec 2023 18:49:16.2179
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6oTp0JETj89i9wlUMnZz1giwThQ306cWO1NhsWweVDrtaT4cHFbKkO/nM1RuU0YkaBzdZh8NdIexLUxAOkOul4wsJ/XBLL+toA+59Fr/9UY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB7841
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

On 12/6/2023 7:40 AM, Moger, Babu wrote:
> Hi Reinette,
> 
> On 12/5/23 17:17, Reinette Chatre wrote:
>> (+James)
>>
>> Hi Babu,
>>
>> On 11/30/2023 4:57 PM, Babu Moger wrote:
>>> These series adds the support for AMD QoS RMID Pinning feature. It is also
>>
>> "These series" - is this series part of a bigger work?
> 
> No.
> There are some some plans to optimize rmid_reads. Peter is planning to
> work on that. But both are independent of each other.

I would propose that you use "This series" instead to avoid creating
wrong impression.

>>> a. Check if ABMC support is available
>>> 	#mount -t resctrl resctrl /sys/fs/resctrl/
>>> 	#cat /sys/fs/resctrl/info/L3_MON/mon_features 
>>> 	llc_occupancy
>>> 	mbm_total_bytes
>>> 	mbm_total_bytes_config
>>> 	mbm_local_bytes
>>> 	mbm_local_bytes_config
>>> 	abmc_capable ←  Linux kernel detected ABMC feature.
>>
>> (Please start thinking about a new name that is not the AMD feature
>> name. This is added to resctrl filesystem that is the generic interface
>> used to work with different architectures. This thus needs to be generalized
>> to what user requires and how it can be accommodated by the hardware ...
>> this is already expected to be needed by MPAM and having a AMD feature
>> name could cause confusion.)
> 
> Yes. Agree.
> 
> How about "assign_capable"?

Let's wait to learn more about other use case.

> 
>>
>>>
>>> b. Mount with ABMC support
>>> 	#umount /sys/fs/resctrl/
>>> 	#mount  -o abmc -t resctrl resctrl /sys/fs/resctrl/
>>> 	
>>
>> hmmm ... so this requires the user to mount resctrl, determine if the
>> feature is supported, unmount resctrl, remount resctrl with feature enabled.
>> Could you please elaborate what prevents this feature from being enabled
>> without needing to remount resctrl?
> 
> Spec says
> "Enabling ABMC: ABMC is enabled by setting L3_QOS_EXT_CFG.ABMC_En=1 (see
> Figure 19-7). When the state of ABMC_En is changed, it must be changed to
> the updated value on all logical processors in the QOS Domain.
> Upon transitions of the ABMC_En the following actions take place:
> All ABMC assignable bandwidth counters are reset to 0.
> The L3 default mode bandwidth counters are reset to 0.
> The L3_QOS_ABMC_CFG MSR is reset to 0."
> 
> So, all the monitoring group counters will be reset.
> 
> It is technically possible to enable without remount. But ABMC mode
> requires few new files(in each group) which I added when mounted with "-o
> abmc". Thought it is a better option.
> 
> Otherwise we need to add these files when ABMC is supported(not when
> enabled). Need to add another file in /sys/fs/resctrl/info/L3_MON to
> enable the feature on the fly.
> 
> Both are acceptable options. Any thoughts?

The new resctrl files in info/ could always be present. For example,
user space may want to know how many counters are available before
enabling the feature.

It is not yet obvious to me that this feature requires new files
in monitor groups.

>>> c. Read the monitor states. There will be new file "monitor_state"
>>>    for each monitor group when ABMC feature is enabled. By default,
>>>    both total and local MBM events are in "unassign" state.
>>> 	
>>> 	#cat /sys/fs/resctrl/monitor_state 
>>> 	total=unassign;local=unassign
>>> 	
>>> d. Read the event mbm_total_bytes and mbm_local_bytes. Note that MBA
>>>    events are not available until the user assigns the events explicitly.
>>>    Users need to assign the counters to monitor the events in this mode.
>>> 	
>>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
>>> 	Unavailable
>>
>> How is the llc_occupancy event impacted when ABMC is enabled? Can all RMIDs
>> still be used to track cache occupancy?
> 
> llc_occupancy event is not impacted by ABMC mode. It can be still used to
> track cache occupancy.
> 
>>
>>> 	
>>> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
>>> 	Unavailable
>>
>> I believe that "Unavailable" already has an accepted meaning within current
>> interface and is associated with temporary failure. Even the AMD spec states "This
>> is generally a temporary condition and subsequent reads may succeed". In the
>> scenario above there is no chance that this counter would produce a value later.
>> I do not think it is ideal to overload existing interface with different meanings
>> associated with a new hardware specific feature ... something like "Disabled" seems
>> more appropriate.
> 
> Hardware still reports it as unavailable. Also, there are some error cases
> hardware can report unavailable. We may not be able to differentiate that.

This highlights that this resctrl feature is currently latched to AMD's 
ABMC. I do not think we should require that this resctrl feature is backed
by hardware that can support reads of counters that are disabled. A counter
read really only needs to be sent to hardware if it is enabled.

>> Considering this we may even consider using these files themselves as a
>> way to enable the counters if they are disabled. For example, just
>> "echo 1 > /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes" can be used
> 
> I am not sure about this. This is specific to domain 0. This group can
> have cpus from multiple domains. I think we should have the interface for
> all the domains(not for specific domain).

Are the ABMC registers not per CPU? This is unclear to me at this time
since changelog of patch #13 states it is per-CPU but yet the code
uses smp_call_function_any().

Even so, this needs to take other use cases into account. So far Peter
mentioned the scenario where enabling of one counter would do so for all
events associated with that counter and then there could also be a global
enable/disable.

> 
>> to enable this counter. No need for a new "monitor_state". Please note that this
>> is not an official proposal since there are two other use cases that still need to
>> be considered as we await James's feedback on how this may work for MPAM and
>> also how this may be useful on AMD hardware that does not support ABMC but
>> users may want to get similar benefits ([1])
> 
> Ok. Lets wait for James comments.

Reinette

