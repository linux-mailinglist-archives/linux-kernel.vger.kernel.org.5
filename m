Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527057BA5C3
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243045AbjJEQTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236317AbjJEQP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 12:15:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1F132810E;
        Thu,  5 Oct 2023 06:44:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696513495; x=1728049495;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=PuoBVebtZ0RpRUR6veOPjM5lECPf/CNZaBquttIZT/Y=;
  b=gRSWAaeT/2Pf+yKZ208FIPXWU7iKXiDe95Mn3fp6Q+us5TmBMIglvHn1
   MrT917I3aVD3Yh5Oz5+FRlRkTKBQQTPTMft1Wmz1Uhdd1dqWkxJ5RuvsC
   xeQb7Dxc+pBrH1AGwIMikyRii6DDXp7YWmEoHE6MQ2q+9FBWrheiYA8ng
   im5G3hoxsFSNbnElZcQelL4QehYnIM5S2+qj5BJLTdjgpQ89hAfhCHiLR
   eX6kmExoUwvotZlwgQSxC/qiaH2eziFbT9dICVuyUAhqII2wO0EGFBqyF
   RN5fZ+GvA4wYw0Yr9BaeOn5zBCvsd8tbsUzUcY4MILIuNX21hk3Ju4QlH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="447619627"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="447619627"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 01:10:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10853"; a="998880321"
X-IronPort-AV: E=Sophos;i="6.03,202,1694761200"; 
   d="scan'208";a="998880321"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga006.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 01:10:07 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 01:10:07 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 01:10:06 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 01:10:06 -0700
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (104.47.74.40) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 01:10:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hgX07xh7G2hIqxQ5n1mfS6DQ3htHwLzshrJ0Egmb2ADCepM717ZBb/VPUnrPh674W19rjdqQYsF04jXZ+YKQhnne8hT7lVvGZ2KwYiQEyT2sIjMfM3Q27GsEaDXeTk5bN2gqDxRfcBpn8cGdre3qYdnU6rTBTGVDrAyIvL3cc44C2Hamce/Vq+zoagLoERk80ZEXpY7KltuO7MGGMOOfU5+RtURp0xbIT369mT772TRMlcLhW8JjVB650sv9ZyrdWeAiOotmoXLEOVvOYyB4SPXIrg3aIAUz08MN5Zspppr1Zb7B3N0dkxs7ndbrzq9FUpfDqs32+QXv+q35ldQEHQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NbvtGyXMJpfBq6eixPHDhZecuwjzthtRC3qhF/ObnXE=;
 b=IC3E9rg9eWjMCaPOzsHIPNeupwncEfszCQZms9XyBxIzww/CLVXJ9mzVyaFJ+xp3+5YHu9gTMjrwxqhGikzyZrpSnW7Fw1ynzw8d2OKj5zUCoi0Wj2HA/SchYdk5gqbr6f0pcEnIto8K8+jJCc0EUz/qPrcPIvTOqFhpZ6ubIyJazcAJx5AUZMUplH/Ha3nOMmq0OFPzR+yBvLzyC39hjv6a+hTt74irRNSilXB0uNmBwGH6pzqEh84q5LhTwDrSsbp9rvjg0V6L6UGex4B8uPFZRDSZC4MtDQwFnV85hGyArZ4NC2FnBjcZY13EK5DgTid/1ZfcWBVpJJnj0BrXYQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by IA0PR11MB7187.namprd11.prod.outlook.com (2603:10b6:208:441::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.31; Thu, 5 Oct
 2023 08:10:04 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 08:10:03 +0000
Message-ID: <f8b9cfb4-aa0f-44c0-84fe-613f005a2baf@intel.com>
Date:   Thu, 5 Oct 2023 10:09:55 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] ACPI: bus: Make notify wrappers more generic
Content-Language: en-US
To:     "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rafael.j.wysocki@intel.com>,
        <andriy.shevchenko@intel.com>, <lenb@kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <rui.zhang@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-2-michal.wilczynski@intel.com>
 <CAJZ5v0jyjH48XZ6vytncodYhsS6ODYg2yaZBPfRWb_qm99FMuA@mail.gmail.com>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <CAJZ5v0jyjH48XZ6vytncodYhsS6ODYg2yaZBPfRWb_qm99FMuA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR4P281CA0128.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:b9::17) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|IA0PR11MB7187:EE_
X-MS-Office365-Filtering-Correlation-Id: 6408d659-000b-4033-17b9-08dbc57a7a33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U8S4JAAjF+sMeLlSFOjqAN4CjJAVn1oRPD0p106GGv7v1HNVlMfDE5INDgxmELkoeGBfEleaRJS/Qvtf++PZ1cw8pB/pp3UVpPbfXALF1xpsKNEQGJlSUCHMHOeo8Ic3blX2Zf7vZixv0rKIb1VaYZlJxvbyjaO+iUTAeJF1Lkc73T8N/MAUY9mbYhstyuhHJ1lcOnXfJVA1eTYuTXQeRam3wKh7VFdnTTLf0ngk0+CH8XZToMQaYSAzoGx95rn+bKfDacF3h1Qoh6ekP4rDptAleL4yiI4sWNkyHlCM/YNNyr2Taj39efmEMRCWp7MJdnck2pixTd6eoUyo7KRKgEMrjbhXQeuoUTOY+7T/+LsNf2zwiX0gaQpI/1+5Y7AKJK41puhTEVnNTNdm+dNRYf760F3WA8S7QBQBLk+DKCliTqiVey/dyQpuDmJJosBnYtHmVO60UEs8/+acbYygV7Lqt+kuhOczJKrg/z2/pHXCzwpzTlAloaTrT2YJT8K3DDCth7eAuG1gD1eFRTsTzn/wSBAFZLNFYpcLi0gwBUHw+3/rGtvApdu8zZdv559h6v9LvkYdsh3l886/bueMRo/C3dB/261m5IpTJnNJssfE6I1D/RNACJ+kNrnq3GW6zZgK2IthonLkiX0d25Pi49AAOE18NvKpomYDMFN36Vg=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(396003)(346002)(366004)(39860400002)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(26005)(53546011)(6512007)(6486002)(6506007)(83380400001)(2616005)(6666004)(5660300002)(4326008)(2906002)(66556008)(8676002)(6916009)(316002)(41300700001)(8936002)(66476007)(66946007)(478600001)(31696002)(86362001)(82960400001)(36756003)(38100700002)(31686004)(41533002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aFZydnRJRnovZjdRbHp2aXhWYzBnVHdHa3lQeGY1eXpBVExDbVpoRmZqS1Bz?=
 =?utf-8?B?ekpVYUhibjRUUzViV21lUFdqSjd5K2hHYUtpcmV5RUh3WTB1bDVTeTNybXI3?=
 =?utf-8?B?MVpyVCs0R0RFZDBuQkxaQnozRGcxekM3YTc0WS9jdEJuN0tlRm9FVmlUTENY?=
 =?utf-8?B?eC9Sb1FTUUtrVVhtakRnOW5DVmxTUXJ0bkY1a1dCNkM4RG9Bb2J6aGFFUFps?=
 =?utf-8?B?YXAzTmNlZG9UM0xNOGMzSEZJZCtKMGd0NXRxaGI1RDdBdVRjRDBRU2JTRzJ3?=
 =?utf-8?B?VXhMUmEzRFRTTUhqNWJsd3pTMmQzOS9jWFEvamk3cU5yeHc2b2lKK0cxbFFC?=
 =?utf-8?B?OW9aS0hVU0xNUkVsbENVQmRMTXJ1ZHJhMzA2MUxjMzJPSlRMazlLcGdxOWxr?=
 =?utf-8?B?UUNLQkt0Y29pMndvbVk5TVV0RytJd0gzcERSd3E3SzdKcjJDb29wSW9nMWFU?=
 =?utf-8?B?aFlNYzBRMjNVTUIvUjFOckUxaWt1dDAyZCtydGZPQitFVDVDclJRSHRTckVN?=
 =?utf-8?B?ei9uZ09YTzZtZEJkU1pCaHVtampKY01FRTd6cjlZZGx6d0lJOXpOSlVJbTFB?=
 =?utf-8?B?bnNNeURHbUcwRWs2S2E0MUhudDZ5YVhLcWk3MWxVQVNCcTlIQktSa1hINUVq?=
 =?utf-8?B?T0s2aTF5dzBXMnJ3VHdTTFAxQkFGbGJ5cW1vRTA4Ky84VGpNdm9JSEhsOXhR?=
 =?utf-8?B?dGpwc2xaY3RDaFFVeXlKM0FyclRmVHQ0VnZWTUZpL1dMMy9Cdm5BOFFreS9k?=
 =?utf-8?B?Vy9YVDFjN21IM0xaalp4Qmo1MjIxbmh2elQrajEyUTN0TmRYWGtoVkxkL1dL?=
 =?utf-8?B?UnRUVGIvMCtIclloZFRnSThLYkJYN3VyMXRpdVBFbzFHdC9GbVJucGlmRlNz?=
 =?utf-8?B?cEVjTEVIR2JvNGNvVVhiZUFXSmhoQXV5NVc4bU4wMDRzNGpYOWFJUUVBNHZq?=
 =?utf-8?B?ZTM2N0RYUHFQUnBmbzd5OXhCa3czNDd1VEIwQU1YMUxMTmlPTzlTeWU5Yjht?=
 =?utf-8?B?bFBxbSt5ZjRIbWVoaWRrTTdxS241TkhZTjRjejh6dVB5bkpXQWhKMTF0T05L?=
 =?utf-8?B?N3pveXBKYW9qOXNlSllnOGhham5VMXhGcEthZ3NwRG5uVE9DN1psTTFWZjhS?=
 =?utf-8?B?bG1zdEdXY2VzbXlMN2dCd3c1ZzRVTTlSc1h0OStCekZFVk40RGZ6QlVWSkRn?=
 =?utf-8?B?TmMxTEpXSzMvU2Y4MVNldHVtK3crVWdMR2hLMjZpRWJpSjQ3VFd4NnZIVWJt?=
 =?utf-8?B?MGVXSUw1QnJpNGxWd2Y3OTBuQlRSblErbE44eWhrUFNWQTcxYmNpN0Q3Z251?=
 =?utf-8?B?VXFpL2VwcncvWldsalpjdnhMdW5HWGRKV1BnY1NYQkkrdllpdTEyRTN4VnJY?=
 =?utf-8?B?ckxKVzRYQVFhZEZ1eFpxblVzMmlGMVNESG1PdkVvdmxjMUFCL3dqbFcyL1pp?=
 =?utf-8?B?dEVCSHo5WkVJeEpEd0JKcGM3RjVpam0yeVdjcGpaem9US250U1pIN1BGcFRS?=
 =?utf-8?B?eVBTYWdybnNZUG1yRjFVNHliOUtIbWoxUkV4cHYvZ3N0ZDR5NkFuMVVNL1pU?=
 =?utf-8?B?SjdBbUMyRER6N3pHTS9nYlhXVE1xKysyTWY1VzV0Z000VkVZYTVTM3BLNmsz?=
 =?utf-8?B?bHdXV1ZHbmNQMHh0UHl3UjlmZTA0eC9RUDBQdkZMRXZSQ1hTNEY3cUEvWThG?=
 =?utf-8?B?c1A4Tyt2bmMwWVhnSXV2cS9FTkFKU0I3Y0ZUa29DWHVENkhlZDJhdjZ3S0Vz?=
 =?utf-8?B?WFFoaDJma2dKUlN2eDZhV09BVTBZVlphV0w4YzUyam5zTnIzT2YzTWZKcjhH?=
 =?utf-8?B?eStRUG90aE5aUkczdFUyMS94dllxTTVnYVBzb0FFRFFEZ0RHY3d5WGJ2UGY0?=
 =?utf-8?B?aVNOVUpVQ0NGNUVvZVE3R2xtZHFGTDF2c0drR0FSbGFkMVRzV01YOUt1N3hS?=
 =?utf-8?B?YWdpSWtTQURPS2FPQ0FIU0MydUIraVZFSDcrS1FxNnJpLzJQUUJkWEhlb29W?=
 =?utf-8?B?Ym8vL2RPeVVDbjF5UlE5VjZOd3hzZjhhMTU4WUcwTEt6VmxVYld3bDNQd0JI?=
 =?utf-8?B?cURoY2wzMDhkaHB0L2tqUHIxRjlYQ3M5a0JEaWRFNElTOU8zSitoZDRmS3N5?=
 =?utf-8?B?R3FPZDhEdWJCVE00VnVCUTBIUTI5V2tjZUhGMmhURGpPR2p0ZEd0Y0lKOUR4?=
 =?utf-8?B?ZEE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 6408d659-000b-4033-17b9-08dbc57a7a33
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 08:10:03.2542
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tsQ90eNFb840qHp+hOzS9RFAStHnbDqeyz2/KR1I1iA329MfO7n2TRYCWQd/QiovFurBxWcrMS101ssFLtFOb767R0pNq8xEZllhf3RYswE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR11MB7187
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for your review !

On 10/4/2023 9:09 PM, Rafael J. Wysocki wrote:
> On Mon, Sep 25, 2023 at 6:31 PM Michal Wilczynski
> <michal.wilczynski@intel.com> wrote:
>> acpi_dev_install_notify_handler() and acpi_dev_remove_notify_handler()
>> are wrappers around ACPICA installers. They are meant to save some
>> duplicated code from drivers. However as we're moving towards drivers
>> operating on platform_device they become a bit inconvenient to use as
>> inside the driver code we mostly want to use driver data of platform
>> device instead of ACPI device.
> That's fair enough, but ->
>
>> Make notify handlers installer wrappers more generic, while still
>> saving some code that would be duplicated otherwise.
>>
>> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>
>> Notes:
>>     So one solution could be to just replace acpi_device with
>>     platform_device as an argument in those functions. However I don't
>>     believe this is a correct solution, as it is very often the case that
>>     drivers declare their own private structures which gets allocated during
>>     the .probe() callback, and become the heart of the driver. When drivers
>>     do that it makes much more sense to just pass the private structure
>>     to the notify handler instead of forcing user to dance with the
>>     platform_device or acpi_device.
>>
>>  drivers/acpi/ac.c         |  6 +++---
>>  drivers/acpi/acpi_video.c |  6 +++---
>>  drivers/acpi/battery.c    |  6 +++---
>>  drivers/acpi/bus.c        | 14 ++++++--------
>>  drivers/acpi/hed.c        |  6 +++---
>>  drivers/acpi/nfit/core.c  |  6 +++---
>>  drivers/acpi/thermal.c    |  6 +++---
>>  include/acpi/acpi_bus.h   |  9 ++++-----
>>  8 files changed, 28 insertions(+), 31 deletions(-)
>>
>> diff --git a/drivers/acpi/ac.c b/drivers/acpi/ac.c
>> index 225dc6818751..0b245f9f7ec8 100644
>> --- a/drivers/acpi/ac.c
>> +++ b/drivers/acpi/ac.c
>> @@ -256,8 +256,8 @@ static int acpi_ac_add(struct acpi_device *device)
>>         ac->battery_nb.notifier_call = acpi_ac_battery_notify;
>>         register_acpi_notifier(&ac->battery_nb);
>>
>> -       result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
>> -                                                acpi_ac_notify);
>> +       result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>> +                                                acpi_ac_notify, device);
>>         if (result)
>>                 goto err_unregister;
>>
>> @@ -306,7 +306,7 @@ static void acpi_ac_remove(struct acpi_device *device)
>>
>>         ac = acpi_driver_data(device);
>>
>> -       acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
>> +       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>>                                        acpi_ac_notify);
>>         power_supply_unregister(ac->charger);
>>         unregister_acpi_notifier(&ac->battery_nb);
>> diff --git a/drivers/acpi/acpi_video.c b/drivers/acpi/acpi_video.c
>> index 948e31f7ce6e..025c17890127 100644
>> --- a/drivers/acpi/acpi_video.c
>> +++ b/drivers/acpi/acpi_video.c
>> @@ -2059,8 +2059,8 @@ static int acpi_video_bus_add(struct acpi_device *device)
>>
>>         acpi_video_bus_add_notify_handler(video);
>>
>> -       error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
>> -                                               acpi_video_bus_notify);
>> +       error = acpi_dev_install_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
>> +                                               acpi_video_bus_notify, device);
>>         if (error)
>>                 goto err_remove;
>>
>> @@ -2092,7 +2092,7 @@ static void acpi_video_bus_remove(struct acpi_device *device)
>>
>>         video = acpi_driver_data(device);
>>
>> -       acpi_dev_remove_notify_handler(device, ACPI_DEVICE_NOTIFY,
>> +       acpi_dev_remove_notify_handler(device->handle, ACPI_DEVICE_NOTIFY,
>>                                        acpi_video_bus_notify);
>>
>>         mutex_lock(&video_list_lock);
>> diff --git a/drivers/acpi/battery.c b/drivers/acpi/battery.c
>> index 969bf81e8d54..45dae32a8646 100644
>> --- a/drivers/acpi/battery.c
>> +++ b/drivers/acpi/battery.c
>> @@ -1213,8 +1213,8 @@ static int acpi_battery_add(struct acpi_device *device)
>>
>>         device_init_wakeup(&device->dev, 1);
>>
>> -       result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
>> -                                                acpi_battery_notify);
>> +       result = acpi_dev_install_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>> +                                                acpi_battery_notify, device);
>>         if (result)
>>                 goto fail_pm;
>>
>> @@ -1241,7 +1241,7 @@ static void acpi_battery_remove(struct acpi_device *device)
>>
>>         battery = acpi_driver_data(device);
>>
>> -       acpi_dev_remove_notify_handler(device, ACPI_ALL_NOTIFY,
>> +       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>>                                        acpi_battery_notify);
>>
>>         device_init_wakeup(&device->dev, 0);
>> diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
>> index f41dda2d3493..479fe888d629 100644
>> --- a/drivers/acpi/bus.c
>> +++ b/drivers/acpi/bus.c
>> @@ -554,14 +554,13 @@ static void acpi_device_remove_notify_handler(struct acpi_device *device,
>>         acpi_os_wait_events_complete();
>>  }
>>
>> -int acpi_dev_install_notify_handler(struct acpi_device *adev,
>> -                                   u32 handler_type,
>> -                                   acpi_notify_handler handler)
>> +int acpi_dev_install_notify_handler(acpi_handle handle, u32 handler_type,
>> +                                   acpi_notify_handler handler, void *context)
>>  {
>>         acpi_status status;
>>
>> -       status = acpi_install_notify_handler(adev->handle, handler_type,
>> -                                            handler, adev);
>> +       status = acpi_install_notify_handler(handle, handler_type,
>> +                                            handler, context);
> The wrapper now takes exactly the same arguments as the wrapped
> function, so what exactly is the point of having it?  The return value
> type?

I considered removing the wrapper altogether, but decided not to do so.
One trivial advantage of leaving this wrapper is the return value type as
you noticed, another is that the removal wrapper actually does something
extra and removing it would result in duplicate code among the drivers.
So I didn't really want to remove the 'install' wrapper but leave the
'remove' wrapper, as I think this might be confusing for the future reader.
In my mind if something is removed by the wrapper it should also be
installed by the wrapper.

>
>>         if (ACPI_FAILURE(status))
>>                 return -ENODEV;
>>
>> @@ -569,11 +568,10 @@ int acpi_dev_install_notify_handler(struct acpi_device *adev,
>>  }
>>  EXPORT_SYMBOL_GPL(acpi_dev_install_notify_handler);
>>
>> -void acpi_dev_remove_notify_handler(struct acpi_device *adev,
>> -                                   u32 handler_type,
>> +void acpi_dev_remove_notify_handler(acpi_handle handle, u32 handler_type,
>>                                     acpi_notify_handler handler)
>>  {
>> -       acpi_remove_notify_handler(adev->handle, handler_type, handler);
>> +       acpi_remove_notify_handler(handle, handler_type, handler);
>>         acpi_os_wait_events_complete();
> Here at least there is the extra workqueues synchronization point.
>
> That said, why exactly is it better to use acpi_handle instead of a
> struct acpi_device pointer?

I wanted to make the wrapper as close as possible to the wrapped function.
This way it would be easier to remove it in the future i.e if we ever deem
extra synchronization not worth it etc. What the ACPICA function need to
install a wrapper is a handle not a pointer to a device.
So there is no need for a middle man.

>
> Realistically, in a platform driver you'll need the latter to obtain
> the former anyway.

I don't want to introduce arbitrary limitations where they are not necessary.
It is often the case that driver allocates it's own private struct using kmalloc
family of functions, and that structure already contains everything that is
needed to remove the handler, so why force ? There are already examples
in the drivers that do that i.e in acpi_video the function
acpi_video_dev_add_notify_handler() uses raw ACPICA handler to install
a notify handler and it passes private structure there.
So there is value in leaving the choice of an actual type to the user of the
API.

To summarize:
I would say the wrappers are mostly unnecessary, but they actually save
some duplicate code in the drivers, so I decided to leave them, as I don't
want to introduce duplicate code if I can avoid that.

Thanks !
Michał


