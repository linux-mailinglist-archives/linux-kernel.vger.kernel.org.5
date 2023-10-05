Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59CE37BA90A
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjJES1R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbjJES1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:27:15 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84A6E90;
        Thu,  5 Oct 2023 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696530433; x=1728066433;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=43wPMzDOpv1tweF4egkNqQWFpQWoCT0pc3vyrvr4MZQ=;
  b=SajfBoKou33yl1Aso2aXxbmkvziklRMSVi7gK+XuiP7rvKuOIEF/CIu2
   JSnPL3w+t8++1gIET37QsZtZYCpll6brnw+anLYTDSeelvFHXzGgkZ8CK
   +cUhaqrjGE3DphNxNsNR5chBhk2Ad4ahOpJyykSRm/stZCXBeKrtHGETa
   LoKh6UZ7WG+vuiX/mKou4CBrPAl/O/BEltGzjJ7BUImv34FXNggvFcuoN
   Pdhhz+PqWMuY3xZhzuRW62BQXvnsl4YuwFjWS3AVLAAOIag+x+lrzvmno
   kGDU9+5s5QunK+PYrMf7ewfGjSR2+YmsbKl79QjlGz1UYJCJ7HqXt42N9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="368658040"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="368658040"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:27:12 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="755560936"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="755560936"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 11:27:12 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:27:11 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:27:11 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 11:27:11 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.175)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 11:27:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fcavDyOSGFZiMx1AYlRSx9JzKcV3fkeY6naF0HPljGeYzmzL3con4gAlVV0dxWsbzR6V0uAsia0AjOUL7Hm1/JlO7x4spYXvmgHe6q4BIEbHz3+Z9NKGJyftd9XRO7wesY0Rd2IS7wybaFiB0DT4P31/DMbS84ldbBQ3xntesTQ+G3TyOhheD+ikVNv3UYCaUl8P0dwwT29xq1oJH0WjhdawIxhP2ghjh2kPE3jK5dKljZdHXeCI00QWq6DimlH29kyMkivZV8trrNzXGJAKEIQeohJXMOWm5LygUejr6XbG4SuiRZ/SpGVo8l2fv2Lbpb/F6sOhSMOohn4NqrNJiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MbztuCDA98nvtJDos5BBXEkQOFFH4WdNkU77ZdkyPII=;
 b=b2wxLqJxq/dcgyQJc18HUOBKP/3ec4Q8yaHnJTRIiaAqSitUuTzKiJFAYQeUUrEHUoSxdREWF+GivPwxNDcMXvoaNV/bm4QF2D/IYhtDbxqiCbmfTNn3AzT4y42v21ngn5lzwhiEfrfYDclRV4E5mzPFk8zSkJor3jzWh5nn9A63+RCtl7DLRW1Sz8w/lR8XoIH8L0kr+/GLy75EOBL39CxOoeXR5qOxmCqTWME1oN03/8iyRXkzQ89vzrfcbxBSuBL9z2qWH0ZLbMO95nB2yF43YsblfAX6E1tMX7KbsHC9ohgIIosuoGBbCMN6/kAYerX3cxxIcLf51y3T7S88Xw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by SA0PR11MB4591.namprd11.prod.outlook.com (2603:10b6:806:9c::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.34; Thu, 5 Oct
 2023 18:27:08 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:27:08 +0000
Message-ID: <f1901763-d63d-4372-8f6f-5322eb8dd76d@intel.com>
Date:   Thu, 5 Oct 2023 20:27:00 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/9] ACPI: bus: Make notify wrappers more generic
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        "Rafael J. Wysocki" <rafael@kernel.org>
CC:     <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>, <rafael.j.wysocki@intel.com>,
        <andriy.shevchenko@intel.com>, <lenb@kernel.org>,
        <dan.j.williams@intel.com>, <vishal.l.verma@intel.com>,
        <ira.weiny@intel.com>, <rui.zhang@intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <86a68f57-0e5e-4a92-8cfe-93249ba78a72@intel.com>
 <CAJZ5v0jSa7FpJKsDRAhVMGy=pTi-aD5JPU4K3Rb-G3igrd6WRQ@mail.gmail.com>
 <12310703.O9o76ZdvQC@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <12310703.O9o76ZdvQC@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|SA0PR11MB4591:EE_
X-MS-Office365-Filtering-Correlation-Id: 9c14fadf-08a0-44b1-8b16-08dbc5d0aea4
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZ36CRQyuma5vRLidX840xhJeXDH1zVqWywjWXGRjMnA7uamR/kkXmpTaLcAwg0nxFAfiYAHKbbN5a275XN7ga4LO+dbQxF9wm2gX3a0PXaSHozgObCI9OG91+iZewWSSd097BeHNvFHkRP/A2xO1UGHmj2krC1Ujgh6jUe/i00bdA5AFKzfPHV2STA7bL5M543En7yWJK1u4pEl0l/MfXcDC/1AMAnQHRHYYZYMgixYwwGSR774gOT7ds2s8JQma5pk0GlIYXKMIkf7HFzdCBB7gvbM3NrEDKWoB7EwFt255XA5UniljWCJlGQCTfFJBczZohnfvqtdoWRBkN22wNprfVc+fuAsIXGlCitjSsEPTobaPYVqJIWwfcyI1kEP4epgQOQeCcHWNA+a4W2uKZTL/33iGWqGk1L6//VpD0nq8AEiYBqjLDOCiihBm2q2C/CGnK45PF4I6zybg7MKnI3OndyX7C03bbsMoCdIj1dCEUy6DXw2q8BVGOHCNZLFpTs0XbwmGJcfN+oASFgc1xjxCYcJWH55aLsiP5adKraK1EW4MvMLxZcGh6GpNkofd3EWv5gccN9LwjUeogMFYTyp9m4ZTxds62B8xo8zOQdairS9KUaaET4wuqipzMLjheyQRJnZbKgZYu+qsXhA9BJl8GNgdudL61+EBikKAGYTpOLNQ49q+z4AtlWluY03d8XpM0L3H+97TOT/MagUww==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(346002)(376002)(230922051799003)(64100799003)(186009)(451199024)(1800799009)(66476007)(478600001)(966005)(6512007)(6486002)(6666004)(53546011)(6506007)(83380400001)(26005)(2616005)(2906002)(30864003)(4326008)(110136005)(8936002)(66556008)(66946007)(8676002)(5660300002)(316002)(41300700001)(36756003)(86362001)(38100700002)(31696002)(82960400001)(66899024)(84970400001)(31686004)(41533002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?aEJhWFQxck9LRXJuenFzdWkyaElvdERPUHFhS0dTMTBXbTFJQ3JySDlCSkZa?=
 =?utf-8?B?OTdJSlh3UVNEMGhSZE91Z0VZNDQrdmVHeVlQaGhmSHJqeVdDNnNXWVZTTTQy?=
 =?utf-8?B?VnN3S0JheE9XWlliZHpJR1R4amJpbXRtRFU0R2FlRXJ4RnQrb1hKQTBCRjhS?=
 =?utf-8?B?OWZLaTVWUFdEWjUvOEZ3cEdld3BDL3ZVTlVhcWtkMXRXbnp5ZHNmWjRIeEZH?=
 =?utf-8?B?QWZVT3A3bDdVVmR3dWQrQ0N0Sm5JSThNdzN6akZES3hGTGgxZmpDRWErbzA4?=
 =?utf-8?B?NmhpRXBzcjJhSjVnWlcxUEdLenhCczF1Q3VTQnRpY09pWlRYWVgxV3g5ZHFT?=
 =?utf-8?B?Y3JIVTlwVjhheHJpd01wcXhhQWo5UE1oSW9pNjMxVWVOSEQzWUs5NG5LTzJo?=
 =?utf-8?B?SFM5RFcyUEJlTHRUNjlDK0R6eWNKZTZYa3N3NXR4cnRkQThEVXRiamNnSE93?=
 =?utf-8?B?bXhUQ1ZQWWNjckN4RktLWEFkelo4ckJORDgvQzlWVDlYSWdzOXhYK2hlbkRU?=
 =?utf-8?B?TTFjZEo2TmFJQjZucm5HN0Y4UENLNk02aUl2ckdpOWNsR0RkM1VZZjBFM1JP?=
 =?utf-8?B?Nzc0OXFnMXp4OS9ZaHdIWS9WS0dmUGNJYzNTV2F2aHROc1hrS0ZTMzN6Ui9k?=
 =?utf-8?B?RVg0RDNaY2dXTHI5aXEwWXpGS3BxREd0QjJaZVp5RnF6bVAvaTV0THRjdUR3?=
 =?utf-8?B?QTlQSHYyRmI5dE5jM0lEbXlSR3ZrUlhkMXoxVlJzVDBOQXhYY2lpVURlRFQ0?=
 =?utf-8?B?VVhUd3J6bktTcW9vZDdCcmdUUnh4aWIzMXdkSkJ1dnFrUUhnOW1xWDYvSG13?=
 =?utf-8?B?ZVB6NDdlNnJQUnVORG81bnAvQ0FITW1mTm03ZlZqWDV4dktmd2o0aTBwMVV2?=
 =?utf-8?B?MzdNNjRaS05xNEJDVHlJYTdjVkszWE1kQXc3NzZTUVg3dmlGQkVZdU9qRWF2?=
 =?utf-8?B?VTFQaFYxdk1yd1QyeStRTnlmbUNSeklSVzhFOFN6QjlwUWFiLzVrMlRMbGFL?=
 =?utf-8?B?cU1Zd1A1cVFNVEN3bGxKaktKQjR2RUJ3dTNvdXUrU2JNeE5jVUxwL1B5Q2g0?=
 =?utf-8?B?U2hPQUtIbUlKdzVyNkE3bnFCK2M1NVQydXc3ZkpEMk9KcGg5aFZKMS9FTnd4?=
 =?utf-8?B?YkE1Z0J2TTRmREtSdWJacHBpbUsxNlM5NTNvaDlGZCtOTHl4NDZZQld6b3RE?=
 =?utf-8?B?dTlXelRIMmF4ZnMvZGQzaW5VSG5iejdqVE90WWVodWRrWlBxS3NnZWZtd0ZD?=
 =?utf-8?B?Q2o1NGVqUjl5WUZ2dCtBMHNpUzB2eUZPZHN5dThwdHpQVUcyQVA0YUwraElK?=
 =?utf-8?B?T0wrc0swTlJJdTNreUVPdTlocEUwYnJIbmxtSzQ0akZ6UTYvUzM5YlF1N0JK?=
 =?utf-8?B?OVV2NUNGc2U3RFpXWUg5d3RxQ0YybUc1cnp3Skk2UmJJMGdVNmVoS0dqTmdP?=
 =?utf-8?B?cjRWZElsQTRZK1U2UXRCYUVZcW5uNG00M1NDV3pzUlQvYWVBY0NoQ3g3VFV0?=
 =?utf-8?B?NTRheU5QNEQyQ09uTGE3T09MSVBWMk1sK2cyaTgyU2txYXYxd2x3d1NUYUZ1?=
 =?utf-8?B?VzhJSTEvdzEwcTBmaytnUjJZZVBtUExCRkd4T2ZVcHNCaktQRUdGTnJ4aGdD?=
 =?utf-8?B?K0R4eUwzbkYvOXY0c09aT0xEVGdsOG9SMk1pdytwVmo5eEQ4aXlScmpSU0VC?=
 =?utf-8?B?dG1SQnFtVmI4aW42OStnZTJkZFdCaXBTZEhXNU43cDBCR2JlS3VOejRRaXJJ?=
 =?utf-8?B?RllFM2NDcHdFUHRVMUsrOWl1SWM5bnNrdjhjWFpFOWkwd2NUMlRwdmN2dkVZ?=
 =?utf-8?B?cGJvV0ErNmlZbDU4eWdCb3Q5T3M4RkMydVNNZE5tNVB4UkpmSE81KzZtNFRB?=
 =?utf-8?B?eUx2UW1RYklvaTZiT3Qwak5YRlFBUXdhR3crYXQ1NWRRS3FNRm9TWnJPYTVM?=
 =?utf-8?B?ZjdCMHJhbXRuRzVjVlNuVzdXVEdSVVoxejJwcXRCZVlQNkttMXQ3RURIakdl?=
 =?utf-8?B?ckhDdUhVTjllNnd6M1VnUFlBTWhhc2MyM2FCV0pOR3A1a1BQNWxiUVlFSmNO?=
 =?utf-8?B?aGlHVFlUS0FlQ3BBeVhOT2NhaEZTc3A0K1YybkhaV1Vsa0ViUDhRcitJQXpn?=
 =?utf-8?B?S0hSM1ZtQ2JjVFB0bnZ1cTNIUlNwc0tpNWtHN2ovaGlqK1JJR3Z6aDJlalhl?=
 =?utf-8?B?VVE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9c14fadf-08a0-44b1-8b16-08dbc5d0aea4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:27:07.9864
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: sWjapKZM9/P3L7bVH0e42/rGVKpjdJN+V7bTKWMsW3D87mhsA4EjbfAckCw/KDYIACyAiX0GVRudh3CGjuEmE1bwDazdJdugg3wus8lTFn0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR11MB4591
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 7:03 PM, Rafael J. Wysocki wrote:
> On Thursday, October 5, 2023 5:30:59 PM CEST Rafael J. Wysocki wrote:
>> On Thu, Oct 5, 2023 at 2:05 PM Wilczynski, Michal
>> <michal.wilczynski@intel.com> wrote:
>>> On 10/5/2023 12:57 PM, Rafael J. Wysocki wrote:
>>>> On Thu, Oct 5, 2023 at 10:10 AM Wilczynski, Michal
>>>> <michal.wilczynski@intel.com> wrote:
>> [cut]
>>
>>>>>> That said, why exactly is it better to use acpi_handle instead of a
>>>>>> struct acpi_device pointer?
>>>>> I wanted to make the wrapper as close as possible to the wrapped function.
>>>>> This way it would be easier to remove it in the future i.e if we ever deem
>>>>> extra synchronization not worth it etc. What the ACPICA function need to
>>>>> install a wrapper is a handle not a pointer to a device.
>>>>> So there is no need for a middle man.
>>>> Taking a struct acpi_device pointer as the first argument is part of
>>>> duplication reduction, however, because in the most common case it
>>>> saves the users of it the need to dereference the struct acpi_device
>>>> they get from ACPI_COMPANION() in order to obtain the handle.
>>> User don't even have to use acpi device anywhere, as he can choose
>>> to use ACPI_HANDLE() instead on 'struct device*' and never interact
>>> with acpi device directly.
>> Have you actually looked at this macro?  It is a wrapper around
>> ACPI_COMPANION().
>>
>> So they may think that they don't use struct acpi_device pointers, but
>> in fact they do.
>>
>>>> Arguably, acpi_handle is an ACPICA concept and it is better to reduce
>>>> its usage outside ACPICA.
>>> Use of acpi_handle is deeply entrenched in the kernel. There is even
>>> a macro ACPI_HANDLE() that returns acpi_handle. I would say it's
>>> way too late to limit it to ACPICA internal code.
>> So there is a difference between "limiting to ACPICA" and "reducing".
>> It cannot be limited to ACPICA, because the code outside ACPICA needs
>> to evaluate ACPI objects sometimes and ACPI handles are needed for
>> that.
>>
>> And this observation doesn't invalidate the point.
>>
>>>>>> Realistically, in a platform driver you'll need the latter to obtain
>>>>>> the former anyway.
>>>>> I don't want to introduce arbitrary limitations where they are not necessary.
>>>> I'm not sure what you mean.  This patch is changing existing functions.
>>> That's true, but those functions aren't yet deeply entrenched in the
>>> kernel yet, so in my view how they should look like should still be
>>> a subject for discussion, as for now they're only used locally in
>>> drivers/acpi, and my next patchset, that would remove .notify in
>>> platform directory would spread them more, and would
>>> make them harder to change. For now we can change how they
>>> work pretty painlessly.
>> I see no particular reason to do that, though.
>>
>> What specifically is a problem with passing struct acpi_device
>> pointers to the wrappers?  I don't see any TBH.
>>
>>>>> It is often the case that driver allocates it's own private struct using kmalloc
>>>>> family of functions, and that structure already contains everything that is
>>>>> needed to remove the handler, so why force ? There are already examples
>>>>> in the drivers that do that i.e in acpi_video the function
>>>>> acpi_video_dev_add_notify_handler() uses raw ACPICA handler to install
>>>>> a notify handler and it passes private structure there.
>>>>> So there is value in leaving the choice of an actual type to the user of the
>>>>> API.
>>>> No, if the user has a pointer to struct acpi_device already, there is
>>>> no difference between passing this and passing the acpi_handle from it
>>>> except for the extra dereference in the latter case.
>>> Dereference would happen anyway in the wrapper, and it doesn't cause
>>> any harm anyway for readability in my opinion. And of course you don't
>>> have to use acpi device at all, you can use ACPI_HANDLE() macro.
>> So one can use ACPI_COMPANION() just as well and it is slightly less overhead.
>>
>>>> If the user doesn't have a struct acpi_device pointer, let them use
>>>> the raw ACPICA handler directly and worry about the synchronization
>>>> themselves.
>>> As mentioned acpi_device pointer is not really required to use the wrapper.
>>> Instead we can use ACPI_HANDLE() macro directly. Look at the usage of
>>> the wrapper in the AC driver [1].
>> You don't really have to repeat the same argument  several times and I
>> know how ACPI_HANDLE() works.  Also I don't like some of the things
>> done by this patch.
>>
>> Whoever uses ACPI_HANDLE(), they also use ACPI_COMPANION() which is
>> hidden in the former.
>>
>> If they don't need to store either the acpi_handle or the struct
>> acpi_device pointer, there is no reason at all to use the former
>> instead of the latter.
>>
>> If they get an acpi_handle from somewhere else than ACPI_HANDLE(),
>> then yes, they would need to get the ACPI devices from there (which is
>> possible still), but they may be better off by using the raw ACPICA
>> interface for events in that case.
>>
>>> -static void acpi_ac_remove(struct acpi_device *device)
>>> +static void acpi_ac_remove(struct platform_device *pdev)
>>>  {
>>> -       struct acpi_ac *ac = acpi_driver_data(device);
>>> +      struct acpi_ac *ac = platform_get_drvdata(pdev);
>>>
>>> -       acpi_dev_remove_notify_handler(device->handle, ACPI_ALL_NOTIFY,
>>> +       acpi_dev_remove_notify_handler(ACPI_HANDLE(ac->dev),
>>> +                                                                     ACPI_ALL_NOTIFY,
>>>                                                                        acpi_ac_notify);
>>>
>>>
>>>
>>> [1] - https://lore.kernel.org/all/20230925144842.586829-1-michal.wilczynski@intel.com/T/#mff1e8ce1e548b3252d896b56d3be0b1028b7402e
>>>
>>>> The wrappers are there to cover the most common case, not to cover all cases.
>>> In general all drivers that I'm modifying would benefit from not using direct ACPICA
>>> installers/removers by saving that extra synchronization code that would need to be
>>> provided otherwise, and not having to deal with acpi_status codes.
>> Yes, that's the common case.
>>
>>>>> To summarize:
>>>>> I would say the wrappers are mostly unnecessary, but they actually save
>>>>> some duplicate code in the drivers, so I decided to leave them, as I don't
>>>>> want to introduce duplicate code if I can avoid that.
>>>> What duplicate code do you mean, exactly?
>>> I would need to declare extra acpi_status variable and use ACPI_FAILURE macro
>>> in each usage of the direct ACPICA installer. Also I would need to call
>>> acpi_os_wait_events_complete() after calling each direct remove.
>> I thought you meant some code duplication related to passing struct
>> acpi_device pointers to the wrappers, but we agree that the wrappers
>> are generally useful.
>>
>>>> IMV you haven't really explained why this particular patch is
>>>> necessary or even useful.
>>> Maybe using an example would better illustrate my point.
>>> Consider using NFIT driver modification later in this series as an example:
>>>
>>> 1) With old wrapper it would look:
>>>
>>>  static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>>> {
>>>     struct acpi_device *adev = data;
>>>     /* Now we need to figure how to get a 'struct device*' from an acpi_device.
>>>          Mind this we can't just do &adev->dev, as we're not using that device anymore.
>>>          We need to get a struct device that's embedded in the platform_device that the
>>>          driver was instantiated with.
>>>          Not sure how it would look like, but it would require are least one extra line here.
>>>      */
>>>     device_lock(dev);
>>>     __acpi_nfit_notify(dev, handle, event);
>>>     device_unlock(dev);
>>> }
>>>
>>> 2) With new wrapper:
>>>
>>> static void acpi_nfit_notify(acpi_handle handle, u32 event, void *data)
>>> {
>>>     struct device *dev = data;
>>>
>>>     device_lock(dev);
>>>     __acpi_nfit_notify(dev, handle, event);
>>>     device_unlock(dev);
>>> }
>>>
>>>
>>> So essentially arbitrarily forcing user to use wrapper that takes acpi device
>>> as an argument may unnecessarily increase drivers complexity, and if we
>>> can help with then we should. That's why this commit exists.
>> Well, I know what's going on now.
>>
>> You really want to add a context argument to
>> acpi_dev_install_notify_handler(), which is quite reasonable, but then
>> you don't have to change the first argument of it.
>>
>> I'll send you my version of this patch later today and we'll see.
> See below.
>
> It just adds a context argument to acpi_dev_install_notify_handler() without
> making the other changes made by the original patch that are rather pointless
> IMO.

Thank you !
I think it's fine will include this in next revision.

Michał

>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v1 1/9] ACPI: bus: Add context argument to acpi_dev_install_notify_handler()
>
> Add void *context arrgument to the list of arguments of
> acpi_dev_install_notify_handler() and modify it to pass that argument
> as context to acpi_install_notify_handler() instead of its first
> argument which is problematic in general (for example, if platform
> drivers used it, they would rather get struct platform_device pointers
> or pointers to their private data from the context arguments of their
> notify handlers).
>
> Make all of the current callers of acpi_dev_install_notify_handler()
> take this change into account so as to avoid altering the general
> functionality.
>
> Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  drivers/acpi/ac.c         |    2 +-
>  drivers/acpi/acpi_video.c |    2 +-
>  drivers/acpi/battery.c    |    2 +-
>  drivers/acpi/bus.c        |    4 ++--
>  drivers/acpi/hed.c        |    2 +-
>  drivers/acpi/nfit/core.c  |    2 +-
>  drivers/acpi/thermal.c    |    2 +-
>  include/acpi/acpi_bus.h   |    2 +-
>  8 files changed, 9 insertions(+), 9 deletions(-)
>
> Index: linux-pm/drivers/acpi/ac.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/ac.c
> +++ linux-pm/drivers/acpi/ac.c
> @@ -257,7 +257,7 @@ static int acpi_ac_add(struct acpi_devic
>  	register_acpi_notifier(&ac->battery_nb);
>  
>  	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
> -						 acpi_ac_notify);
> +						 acpi_ac_notify, device);
>  	if (result)
>  		goto err_unregister;
>  
> Index: linux-pm/drivers/acpi/acpi_video.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/acpi_video.c
> +++ linux-pm/drivers/acpi/acpi_video.c
> @@ -2062,7 +2062,7 @@ static int acpi_video_bus_add(struct acp
>  		goto err_del;
>  
>  	error = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> -						acpi_video_bus_notify);
> +						acpi_video_bus_notify, device);
>  	if (error)
>  		goto err_remove;
>  
> Index: linux-pm/drivers/acpi/battery.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/battery.c
> +++ linux-pm/drivers/acpi/battery.c
> @@ -1214,7 +1214,7 @@ static int acpi_battery_add(struct acpi_
>  	device_init_wakeup(&device->dev, 1);
>  
>  	result = acpi_dev_install_notify_handler(device, ACPI_ALL_NOTIFY,
> -						 acpi_battery_notify);
> +						 acpi_battery_notify, device);
>  	if (result)
>  		goto fail_pm;
>  
> Index: linux-pm/drivers/acpi/bus.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/bus.c
> +++ linux-pm/drivers/acpi/bus.c
> @@ -556,12 +556,12 @@ static void acpi_device_remove_notify_ha
>  
>  int acpi_dev_install_notify_handler(struct acpi_device *adev,
>  				    u32 handler_type,
> -				    acpi_notify_handler handler)
> +				    acpi_notify_handler handler, void *context)
>  {
>  	acpi_status status;
>  
>  	status = acpi_install_notify_handler(adev->handle, handler_type,
> -					     handler, adev);
> +					     handler, context);
>  	if (ACPI_FAILURE(status))
>  		return -ENODEV;
>  
> Index: linux-pm/drivers/acpi/hed.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/hed.c
> +++ linux-pm/drivers/acpi/hed.c
> @@ -57,7 +57,7 @@ static int acpi_hed_add(struct acpi_devi
>  	hed_handle = device->handle;
>  
>  	err = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> -					      acpi_hed_notify);
> +					      acpi_hed_notify, device);
>  	if (err)
>  		hed_handle = NULL;
>  
> Index: linux-pm/drivers/acpi/nfit/core.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/nfit/core.c
> +++ linux-pm/drivers/acpi/nfit/core.c
> @@ -3391,7 +3391,7 @@ static int acpi_nfit_add(struct acpi_dev
>  		return rc;
>  
>  	rc = acpi_dev_install_notify_handler(adev, ACPI_DEVICE_NOTIFY,
> -					     acpi_nfit_notify);
> +					     acpi_nfit_notify, adev);
>  	if (rc)
>  		return rc;
>  
> Index: linux-pm/drivers/acpi/thermal.c
> ===================================================================
> --- linux-pm.orig/drivers/acpi/thermal.c
> +++ linux-pm/drivers/acpi/thermal.c
> @@ -936,7 +936,7 @@ static int acpi_thermal_add(struct acpi_
>  		acpi_device_bid(device), deci_kelvin_to_celsius(tz->temp_dk));
>  
>  	result = acpi_dev_install_notify_handler(device, ACPI_DEVICE_NOTIFY,
> -						 acpi_thermal_notify);
> +						 acpi_thermal_notify, device);
>  	if (result)
>  		goto flush_wq;
>  
> Index: linux-pm/include/acpi/acpi_bus.h
> ===================================================================
> --- linux-pm.orig/include/acpi/acpi_bus.h
> +++ linux-pm/include/acpi/acpi_bus.h
> @@ -601,7 +601,7 @@ int acpi_bus_attach_private_data(acpi_ha
>  void acpi_bus_detach_private_data(acpi_handle);
>  int acpi_dev_install_notify_handler(struct acpi_device *adev,
>  				    u32 handler_type,
> -				    acpi_notify_handler handler);
> +				    acpi_notify_handler handler, void *context);
>  void acpi_dev_remove_notify_handler(struct acpi_device *adev,
>  				    u32 handler_type,
>  				    acpi_notify_handler handler);
>
>
>

