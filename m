Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D884F7BA915
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 20:29:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231502AbjJES3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 14:29:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbjJES3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 14:29:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8420AB;
        Thu,  5 Oct 2023 11:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696530576; x=1728066576;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9eZSdSE31x2rEdZZeKEGMQM+sprTyeo8XcR6D1WYzgU=;
  b=IaJLJ6ckssJ3SY7QJsLWke7b493c4eyNhZ4ULchL53+K9jf5upcH4Mq3
   TTrGvCHhwyXUzVAFDmZfe37ocOB72hCz0BYky6skbUcJID1rg25Q94NFq
   x5jmd5Ij4NUIZPLtgLtmzMxLmU2m4Q8Tbg7/M64IQlX50lIn6roCzXMMV
   jkqS2LnFVUFJlfrNWZK9qJ+ulBsfxGo9SgxOqVRlT7qMAXyDt7zKxTMey
   7/96FzptodBMw0nZr2aQUo64aXKFeFl4a15d5CRkgisB5mO1Aw5b5uGXs
   DbRxLlxd3XoT4lR0nlIi08eCD1BFgoKApj59PSU4f+EJbh+Et4xcHF645
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="362939388"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="362939388"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Oct 2023 11:28:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="787072389"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="787072389"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 05 Oct 2023 11:28:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:28:40 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 5 Oct 2023 11:28:39 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 5 Oct 2023 11:28:39 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 5 Oct 2023 11:28:39 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kcP8U/+g6KsyaYmZfUmnIhX9sgLzt2azxEKAnbIM0dwDbKaLJg++UApmJMJf+WQSwtE8Pv/7DuB6uiFKVzVTiD3D9dgytACXgkYOYuFa16HT5LPZsTVhFec76Gs7c8KVpom1J+kx7HMo6vxeptpR41r6TIvPLd2AyPp/iosG10WObTDXJAHStsn2QlgMCltV8O6hr2RoMWwtcMukQKtyN2tItuIkZTENSD2tWsCjuhX6jaqnSVabJqsGEKRJonkSxduTgKzuT6JqRTESJWVuZA1L3kBvpWaRDAFwwRnBZ/TecqEatqyh5tu18hlrnc4fJ27H8jUd5rCbcpWyx80Odg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=649XCd92vOKzU31oyPmo7J128KTvsWxLVJnBnCGBVPc=;
 b=LiTRGlPsvn00QR+ybFtd5dFXZok0zGkWRfmrTT+03lbopK17cyJLNFR3948XArJFeU1DntVcEniPVj0HTtLOLRfS0CqosBuGaRXs9nm8yoY+nTLpPOELxoAP5Pnn+e19Ic5wU2fpcCcc0vXFZTk0mqcl8uMjqhaaXF+ACqpYcI+t3sH+1oPWZLBQTDVKEtDK0xzHT6OQCGNjaotIcgccMtaKF6t5Vkc9QfutQU7ah2Yg7Ch1PvOBfL7bJrzAWv+fdiiD/yVn20ABNcFV/9NfGNpzN3KC6cLnVv/LnMq04W3zJ0T7W83DZcdQTet8TGRUZ/Hp8CpmtyaG2K/viy399g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO6PR11MB5603.namprd11.prod.outlook.com (2603:10b6:5:35c::12)
 by PH7PR11MB5817.namprd11.prod.outlook.com (2603:10b6:510:13a::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.28; Thu, 5 Oct
 2023 18:28:38 +0000
Received: from CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510]) by CO6PR11MB5603.namprd11.prod.outlook.com
 ([fe80::dbe4:218c:1bdd:510%4]) with mapi id 15.20.6838.033; Thu, 5 Oct 2023
 18:28:37 +0000
Message-ID: <edb1d4bc-a484-42ea-9a5c-4c77a860645a@intel.com>
Date:   Thu, 5 Oct 2023 20:28:34 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/9] docs: firmware-guide: ACPI: Clarify ACPI bus
 concepts
Content-Language: en-US
To:     "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        <linux-acpi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <nvdimm@lists.linux.dev>
CC:     <rafael.j.wysocki@intel.com>, <andriy.shevchenko@intel.com>,
        <lenb@kernel.org>, <dan.j.williams@intel.com>,
        <vishal.l.verma@intel.com>, <ira.weiny@intel.com>,
        <rui.zhang@intel.com>, Elena Reshetova <elena.reshetova@intel.com>
References: <20230925144842.586829-1-michal.wilczynski@intel.com>
 <20230925144842.586829-3-michal.wilczynski@intel.com>
 <2725050.mvXUDI8C0e@kreacher>
From:   "Wilczynski, Michal" <michal.wilczynski@intel.com>
In-Reply-To: <2725050.mvXUDI8C0e@kreacher>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: FR3P281CA0195.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::7) To CO6PR11MB5603.namprd11.prod.outlook.com
 (2603:10b6:5:35c::12)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO6PR11MB5603:EE_|PH7PR11MB5817:EE_
X-MS-Office365-Filtering-Correlation-Id: ffcb74fc-6219-4fd1-93fd-08dbc5d0e444
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: IgFP7MJkxsWYD0HWeQHk5bKVbjzP6ndEY5VdMC/Ub/+O38PgllZV9GqAbfiHmU8fIwAKvMreZxOZrnw4I7JO4C93gi/yIRaFnBNlZDL/tvpBdLi9Y2dS3tkS/RSfuwkyWcGmvSmA6DaMetsX8SN4+mQyETm390q4Rj/EA4FKWHzRThNXbZTOAaCZHrbYiBShcwHMhelj1sjymGXlviWS4DpJ7QCbiK+pl2fZ5PtWsoJRi3xtnihwnPM0kIU+NgOgJxFBlV/KeBEEKNZZccs4aDdqsGVqUJT15Io17O3r2Ue8y7d7JYuzXtkoyXWaVZQeZRCIDymYiH0M3n6lYCRnqYHZijeqQGhbFowLo2tJlcah1OMM3FmraH19zdtRZzDh1vFSw04fxBnNGEnN+q59/pmgarpTBxdczz4BUNsc21rNgB4+nti+82QG7zZ622e1V/4pYGXh6eXFpTNFPHSRS2aOvKUDZlr5FIjX9SqD+6dYaO0mjA+yRRlaidbnRH5ew+AYJBIyWo2BLGuykZRr2SjCLa7jYVlZvm0cKimsVcswrPcOVaZIZSdjof5jbk6Imfb/TISG9amwh0CzSFv84TYISJsMIeN1ilz8D9APuuereLp63No59/VmodBbiexN9z3rXbIiWud5Dl3pC2DztQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR11MB5603.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(366004)(136003)(396003)(230922051799003)(451199024)(64100799003)(186009)(1800799009)(478600001)(31686004)(8936002)(8676002)(2906002)(84970400001)(5660300002)(66556008)(66476007)(4326008)(41300700001)(26005)(316002)(66946007)(53546011)(6486002)(6506007)(6666004)(6512007)(38100700002)(36756003)(107886003)(2616005)(83380400001)(86362001)(82960400001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NWhWT2FJNDdKV3Ayak93RHdUamxsTDVZalZDQVk2MWYxVXFGZi9mZ09xbG1Y?=
 =?utf-8?B?K0tyT2RrSFRpbzNrQXJyWEMzSlFsTW5XcmtQOWhPYlkweHpUeGxCc25ZQ1BW?=
 =?utf-8?B?UUV3QnJ2b3poM0hpOUVyWGFEZnF4d1JwN1VldkpDVStoSzcwSHh5emVSaXUx?=
 =?utf-8?B?cWJkcGVZMDN1eHBhZFA4UG4veUs3WWpmSTFnR3lHMk9lUi9ta2J3S3FmYml2?=
 =?utf-8?B?b25iQUx2dWE5MU0yWlk1SzNEV3NTTmhRdVRmNy9Qa2NkYXk3Y2RZK1RSU0ZD?=
 =?utf-8?B?K3lGalUzZkpmaFB1WWhlYnRZTjMrSjF6eDlJdW5aMEJva2VzZ1dXemVPZWo4?=
 =?utf-8?B?bm1YM1VJMGxhVUFGdU9FTFc3QU5xTys4Y0Z1OXRkbGZGSG9KaFdraElBZTEx?=
 =?utf-8?B?clJBZm5DRDAzakdDZVRNQ3h4Ym9RSGZTM3l0SHUzY3hXbEgreUlTakM2VFZy?=
 =?utf-8?B?RVpENjFjeklDMHdmZVUySTl0Qk5BYjZaKzdPQ1IxSjkrWGVLa2YyMTFrVWRE?=
 =?utf-8?B?akFGY1lQeVJ3TWhtUnR1anRpK29RMTRsdUhsNlJBNndyS1ljVVBtd3pIT3F6?=
 =?utf-8?B?TlJiQ1Q5UU9xRCszUEJ0NU9DVUVZUzhjSENGS1p1aURtU0RiMDUzbmJSTUJP?=
 =?utf-8?B?cWNpbHdjaGdNVWpIcWFFOEdJR2ljYytWdXRVeTBaODVtNTBsU1dtRWo1M292?=
 =?utf-8?B?R09Zdm1pamZXRVRuaCtxSDNOcVZzZjFvcFVBbWphZEcyQXF4aTFqWXc4VGVr?=
 =?utf-8?B?SDg5ZjNpY25DZHByaWxaNWdBclRtTWN6NWRtbkMrb3diMVd1QlA3bE95SkJI?=
 =?utf-8?B?bnFTRjU1a2JFaTBZbHJMdzNWYlI3Rm4zN1VpNUVnMXZQOEF2RVZOK0VJVjlz?=
 =?utf-8?B?SnhIQXAyNWtwSFBZZCttSTBBZUVSSVdmREp2R0Y1Y3VGeVFOM3lpcHRYcENV?=
 =?utf-8?B?NC9id0lmalo0d2ZFeDJwZ0RzbUVGQlZ0RkdDVGtZYWJ2ZWhXYS92SFk5Qml3?=
 =?utf-8?B?WFM3NE05dUViNEFQRzNsNS95T2tqWWU4aGtsakRMQlVuVWhUb1JqUHIwSDgr?=
 =?utf-8?B?eTBmTS8rTW1hSDkwQjkrREkzdml2d1REY2RDUXJHU05kSHBFU1I3RGowelF3?=
 =?utf-8?B?VlR0Nmgwek5GWkIrN1BJUGhQaUR3QmREOFhYSGRiNEJacUtvbUFwZ01rT1ZH?=
 =?utf-8?B?S2VkdGJsYlZRd3IrSFBJaG1zR0VCS0gwRThDaExYdnRNaHZaZzVHZEE0OFF2?=
 =?utf-8?B?TUxKbCt6aXZwRGtPZnFkL0UxNlFKeFdzWWY1aUx1dXROYW5lOEdHRWlyWUNS?=
 =?utf-8?B?T2ViRzVGK3dKRjdhaUNMUCtxL3Fzb2pWNnFnRnFIUGxaQlVYM0Zwam5VSkVz?=
 =?utf-8?B?a255Q3g1M2liZjByL3BhOGRPa3F3ckswSWUrTUJDazUra2toZ3ZKUzk1Ym9i?=
 =?utf-8?B?RWlGWnpjNFYrRVNDVmh5cTdIdllaR2trdjcvTVRENzFzbFc5Tkl1aHptYlBz?=
 =?utf-8?B?OXgxTkYyb2t0UjhyQVQzb0RVbkhVTzBBeTNVTHJZVm4ySmVQUFFZd0N4b1lm?=
 =?utf-8?B?SU50U1d1QmxPT1JZUEdmTUJmWU5kZ3pjMCs4YkZ3dFZlOHQ1MkgxdnNOOGxV?=
 =?utf-8?B?MU4rT2xGdW5qTXNuN2tycHRlRW05UnRHUXNRV3JUUHF3WDcwV1VVZmxFWTN4?=
 =?utf-8?B?M2lxbTVSdkJOR21hMm1zRVVpZ01kdDkvK21mUlFJVjZxcnNKcktVald3WDZH?=
 =?utf-8?B?U3p2R0g3dXJCMlpxWHpZOHBBaFdvandHSmxCVCtwNmtlVHdZWW1iaVE3aUg0?=
 =?utf-8?B?c0pTTC9EV0RERG9kNEhlUDhITlN6NVRyU3VjdjNneUsvVWJQZzFXT1dnT0hu?=
 =?utf-8?B?TitrNkx3bFVmdVV6WW12ZE02R0c1SmZBR2N6TTNGbERTNzMydHJSM2RpT09k?=
 =?utf-8?B?eFFCN3dRWit4bnE4YmFQQmxLVjhXa3g2QnBaNW5WcitjcXIrRWk2NnVwVHNh?=
 =?utf-8?B?NU5hNXYzWVQvS2xBNm1ES2o3a2cweWRqaDMxN3VYME9aMXNNWlIzRzU4TjUv?=
 =?utf-8?B?bEpsUktqS2NWa3lHRmp3SUxidEFNbGRaUk01MlRMNmJkRjFvSXptYUp2Vm0w?=
 =?utf-8?B?M3hvcm9jbG14aFg3UlZra0E4eUJnbWNvZlpjaGlVWUhyaVYzelo4SlYvOG84?=
 =?utf-8?B?UFE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ffcb74fc-6219-4fd1-93fd-08dbc5d0e444
X-MS-Exchange-CrossTenant-AuthSource: CO6PR11MB5603.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Oct 2023 18:28:37.8980
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: p37lYF8FHTsKxXv78CjP8zvP3OGz+lJXJIiyVwRvQtHNvZgEEhxzB8aMXKGUBCUW1rU1Ign4dYR08BtVrinokygDaiZ1QIntBlbcXw0oI4o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR11MB5817
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



On 10/5/2023 7:57 PM, Rafael J. Wysocki wrote:
> On Monday, September 25, 2023 4:48:35 PM CEST Michal Wilczynski wrote:
>> Some devices implement ACPI driver as a way to manage devices
>> enumerated by the ACPI. This might be confusing as a preferred way to
>> implement a driver for devices not connected to any bus is a platform
>> driver, as stated in the documentation. Clarify relationships between
>> ACPI device, platform device and ACPI entries.
>>
>> Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
>> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
>> ---
>>  Documentation/firmware-guide/acpi/enumeration.rst | 13 +++++++++++++
>>  1 file changed, 13 insertions(+)
>>
>> diff --git a/Documentation/firmware-guide/acpi/enumeration.rst b/Documentation/firmware-guide/acpi/enumeration.rst
>> index 56d9913a3370..f56cc79a9e83 100644
>> --- a/Documentation/firmware-guide/acpi/enumeration.rst
>> +++ b/Documentation/firmware-guide/acpi/enumeration.rst
>> @@ -64,6 +64,19 @@ If the driver needs to perform more complex initialization like getting and
>>  configuring GPIOs it can get its ACPI handle and extract this information
>>  from ACPI tables.
>>  
>> +ACPI bus
>> +====================
>> +
>> +Historically some devices not connected to any bus were represented as ACPI
>> +devices, and had to implement ACPI driver. This is not a preferred way for new
>> +drivers. As explained above devices not connected to any bus should implement
>> +platform driver. ACPI device would be created during enumeration nonetheless,
>> +and would be accessible through ACPI_COMPANION() macro, and the ACPI handle would
>> +be accessible through ACPI_HANDLE() macro. ACPI device is meant to describe
>> +information related to ACPI entry e.g. handle of the ACPI entry. Think -
>> +ACPI device interfaces with the FW, and the platform device with the rest of
>> +the system.
>> +
>>  DMA support
>>  ===========
> I rewrote the above entirely, so here's a new patch to replace this one:
>
> ---
> From: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> Subject: [PATCH v2 2/9] ACPI: docs: enumeration: Clarify ACPI bus concepts
>
> In some cases, ACPI drivers are implemented as a way to manage devices
> enumerated with the help of the platform firmware through ACPI.
>
> This might be confusing, since the preferred way to implement a driver
> for a device that cannot be enumerated natively, is a platform
> driver, as stated in the documentation.
>
> Clarify relationships between ACPI device objects, platform devices and
> ACPI Namespace entries.
>
> Suggested-by: Elena Reshetova <elena.reshetova@intel.com>
> Co-developed-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Signed-off-by: Michal Wilczynski <michal.wilczynski@intel.com>
> Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
> ---
>  Documentation/firmware-guide/acpi/enumeration.rst |   43 ++++++++++++++++++++++
>  1 file changed, 43 insertions(+)
>
> Index: linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
> ===================================================================
> --- linux-pm.orig/Documentation/firmware-guide/acpi/enumeration.rst
> +++ linux-pm/Documentation/firmware-guide/acpi/enumeration.rst
> @@ -64,6 +64,49 @@ If the driver needs to perform more comp
>  configuring GPIOs it can get its ACPI handle and extract this information
>  from ACPI tables.
>  
> +ACPI device objects
> +===================
> +
> +Generally speaking, there are two categories of devices in a system in which
> +ACPI is used as an interface between the platform firmware and the OS: Devices
> +that can be discovered and enumerated natively, through a protocol defined for
> +the specific bus that they are on (for example, configuration space in PCI),
> +without the platform firmware assistance, and devices that need to be described
> +by the platform firmware so that they can be discovered.  Still, for any device
> +known to the platform firmware, regardless of which category it falls into,
> +there can be a corresponding ACPI device object in the ACPI Namespace in which
> +case the Linux kernel will create a struct acpi_device object based on it for
> +that device.
> +
> +Those struct acpi_device objects are never used for binding drivers to natively
> +discoverable devices, because they are represented by other types of device
> +objects (for example, struct pci_dev for PCI devices) that are bound to by
> +device drivers (the corresponding struct acpi_device object is then used as
> +an additional source of information on the configuration of the given device).
> +Moreover, the core ACPI device enumeration code creates struct platform_device
> +objects for the majority of devices that are discovered and enumerated with the
> +help of the platform firmware and those platform device objects can be bound to
> +by platform drivers in direct analogy with the natively enumerable devices
> +case.  Therefore it is logically inconsistent and so generally invalid to bind
> +drivers to struct acpi_device objects, including drivers for devices that are
> +discovered with the help of the platform firmware.
> +
> +Historically, ACPI drivers that bound directly to struct acpi_device objects
> +were implemented for some devices enumerated with the help of the platform
> +firmware, but this is not recommended for any new drivers.  As explained above,
> +platform device objects are created for those devices as a rule (with a few
> +exceptions that are not relevant here) and so platform drivers should be used
> +for handling them, even though the corresponding ACPI device objects are the
> +only source of device configuration information in that case.
> +
> +For every device having a corresponding struct acpi_device object, the pointer
> +to it is returned by the ACPI_COMPANION() macro, so it is always possible to
> +get to the device configuration information stored in the ACPI device object
> +this way.  Accordingly, struct acpi_device can be regarded as a part of the
> +interface between the kernel and the ACPI Namespace, whereas device objects of
> +other types (for example, struct pci_dev or struct platform_device) are used
> +for interacting with the rest of the system.
> +
>  DMA support
>  ===========

Thanks a lot !
Looks very good, will include this in next revision.

Michał

>  
>
>
>

