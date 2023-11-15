Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39597ED602
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:25:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344906AbjKOVZH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:25:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344943AbjKOVZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:25:01 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136F7181;
        Wed, 15 Nov 2023 13:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700083496; x=1731619496;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=pGEMTefOhvlwxa17kmaNM3mOmUgvRxFkII1eNdVf1Fg=;
  b=SQAF3o4aRFyEQBr4Be83gFb6tCMK3n6SQ16p+VBA5IzS2VO72hjCduTA
   TCSteiyRw1T72OaUeFcl6xrftvMPunVVIbUHR9824YfobNbcGUTWBOqTG
   94oKBiGnRORNgPTbWudoNFsrUAlxo0rnp0yaXnStWQZCi7F8dY0iTG38X
   aD1IAQ+mBzO25xE1NgKYhQj5Fqr69OW7I8cM7GhIgoNO9xn8HpT7CNNGL
   5k806R6lq4YpdggKxtsmR3SQGlC4O6g3bJz59xL4OiGy06WvbzbH/7Sjr
   Of13jV1izNPyvJ3dXj6KmdvUhFYNStQl/6tMEdXi7Fo1CFIGtJHJmnFXI
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="393811415"
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="393811415"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Nov 2023 13:24:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,306,1694761200"; 
   d="scan'208";a="12896572"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 15 Nov 2023 13:24:54 -0800
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 13:24:36 -0800
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 15 Nov 2023 13:24:35 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 15 Nov 2023 13:24:35 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.101)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 15 Nov 2023 13:24:32 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jwCMxwuuvD/AzPhm9ST/AlOVutkCWtmCxqe4WSeuYKzVZCrm+I6KfBjZI9Al069T3AXXMosJowN2YpWeXB/85ZFm5ztOU8lellzYVOvnfSRDsRk+BS+rNUHP4HdmybzjLwqg4F8juMrB7hHAqFH6JVJ26KwnQD4p1zIThrGrtvLyKwrS+d2xOpS1fqE+6XgYE1dK6pNgb/DSaZPT6IwXj7cYiBbMUXa4nVNhUG36EkBkgw+CMELsm+Yng+2+O2aSOL3VD9zKAqhSMV4CkefePLfI3rJQvV1HzIn6KOmI8fuq4rrsXfkHM1KjGi1bYuuDHlq4swnLsWs6k3J006eKXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=IokvQqTisvSrpVG47A7pjLkT2M60EvcSz0TQSnyQlWs=;
 b=llS7IlRUpNzcYJC434JHB+c9skWezWakBn3dcaYXwCfjJ+8D+hTQrXagGC9h7uV76T7mq2NY+/zulBbYpvLAA+yUfq1Ks83OejthVYXW4gSsFLX4IoyzRTDxKfVCzaZLSWBk3e4W5y398pEcd2EX0azBkb/iDMTSTQ0oXttqJYgbx3IiVKPzGoJ+71I2jhE7H/aApnmlaDQxeAwMtXbUPmPbPdcm+b8XtSo61kPl6OjM0Z5GkTZGsxy9f86uutum9s03O4/9B9O5+HMUASK2xwoqHgS0ZrOK30HQmzFKGZ+Cehr4lcvCp7Ujcy2zPyo0/URxaHoNSO4M49UMlSwqkg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by BN9PR11MB5529.namprd11.prod.outlook.com (2603:10b6:408:102::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7002.19; Wed, 15 Nov
 2023 21:24:27 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::28a6:ecda:4bb7:2f9e%7]) with mapi id 15.20.6977.029; Wed, 15 Nov 2023
 21:24:27 +0000
Message-ID: <34b90a9a-1cb4-4e8d-bb0c-fbf0e94f2b79@intel.com>
Date:   Wed, 15 Nov 2023 14:24:22 -0700
User-Agent: Betterbird (Linux)
Subject: Re: [RFC PATCH 2/6] cxl/memscrub: Add CXL device patrol scrub control
 feature
To:     <shiju.jose@huawei.com>, <linux-cxl@vger.kernel.org>
CC:     <jonathan.cameron@huawei.com>, <Vilas.Sridharan@amd.com>,
        <leo.duran@amd.com>, <Yazen.Ghannam@amd.com>,
        <rientjes@google.com>, <jiaqiyan@google.com>,
        <tony.luck@intel.com>, <Jon.Grimm@amd.com>,
        <dave.hansen@linux.intel.com>, <linux-acpi@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <rafael@kernel.org>, <lenb@kernel.org>, <naoya.horiguchi@nec.com>,
        <james.morse@arm.com>, <david@redhat.com>, <jthoughton@google.com>,
        <somasundaram.a@hpe.com>, <erdemaktas@google.com>,
        <duenwen@google.com>, <mike.malvestuto@intel.com>,
        <gthelen@google.com>, <tanxiaofei@huawei.com>,
        <prime.zeng@hisilicon.com>, <kangkang.shen@futurewei.com>,
        <wanghuiqiang@huawei.com>, <linuxarm@huawei.com>
References: <20231114125648.1146-1-shiju.jose@huawei.com>
 <20231114125648.1146-3-shiju.jose@huawei.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20231114125648.1146-3-shiju.jose@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0233.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::28) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|BN9PR11MB5529:EE_
X-MS-Office365-Filtering-Correlation-Id: a4627fac-9839-4229-bc4b-08dbe6213f6f
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pcT6E+dbxio/x0n3HFXWX0QxqIqsoCBnzoaC4Jn59QcZWLYIIOJmV8dX9xzhhmwl8hi1ABZej9ATgCDfVlbnkWVI/wcGKrHqwb7fRrW6bzfElPz1Hc0Aex7riRO0ocBRoD+n/AvbAyrgk55bYB9DYXUEIRtTgxgkA1HfgKyBnDajkiHIvvOEBQ3s0NFiX8/a6B3CsWPHqcmsaQipUbZ99LVQI03a+G7BasMkEV482jdaQqPplnMSvj5WDcVt+3uBUy3B/igSOUqyH6Z7yrhWpGZ69dzjVhhnNkvuAE/I2DxiNpCcJlYJTiN2SmPoDsvNoEr3cYq9DtqYlo26YgQUTCRK15OazOhdKuTfOvDdg56VWyt4CbMVB3doMWYb+LzwINbZ9cnbXHuSO/nwCdfOOivPdxt1Fwf+0fNHBId/pP4koCKyX2gA9vEr6bmTe2Jv7cSHOj428IalxOt/t6I2dBgCW0mvJzIKERUqpPAKkMeqA/L9TMyrtJ0LvriyLtb419BxV6j98I7StPswdI/tza/ceWosXH8/Lrmp+uzpkmu0TvX6WhUrD74kkXsZEUmngRaVX76Zc82Dd9niKFnwfGlpmNkAhzQVAZdc3R5Qi/Fuq90xBGcr27mv5IymuEtu
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(136003)(396003)(39860400002)(366004)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(2906002)(86362001)(6666004)(2616005)(26005)(6512007)(53546011)(31696002)(6506007)(8936002)(316002)(30864003)(6486002)(66476007)(66556008)(66946007)(4326008)(478600001)(38100700002)(41300700001)(5660300002)(31686004)(36756003)(82960400001)(8676002)(83380400001)(7416002)(44832011)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?NlVYR0lzeldQUXo2dW41c2tTaThGRmQvZWd6ZU8zaURZUUdOeC9IRVF2ZVFa?=
 =?utf-8?B?alR0Q3djWVJCVnFKZ2laajlXSDh1QlRhT3c4QWs1R3dmNVR1Y01sSTU2YVpS?=
 =?utf-8?B?a0gzY0JHdVJBV1dXbmpUSVY3UDNRc3BYdmFFbmlPTnJRQy9DNlFrdGJYWk4w?=
 =?utf-8?B?K2RydGc1c3IzbHh4bUlXNmZDajMvWXBQQng1RVU5QzF1R3FEdGJoS0FDUlFX?=
 =?utf-8?B?NFo0bndiSlNGWXRmcUJlZ2pHOGxRTzhUSG9xQ2Q0Um56OWtlZm1PUU14RW10?=
 =?utf-8?B?M0REU0o5RTR5M0hlQWpCZFlSTCtFejNRVG1CSXd0MDVuVXN4NVVzMjB3b3JY?=
 =?utf-8?B?b1JRK0kzOWkxd1hKdW42eUx5NEttdXFOcFU2c2NML0VMRnUweHpFbXRkUGtR?=
 =?utf-8?B?ejNGMzQySWF1TE9CMDdiRDBlcVhaZVhyTk9WVXpqdys5aDRmbjhIbkZCNzVD?=
 =?utf-8?B?Yi95WUFUdVlDbmxxdUpSNGQraUI5VXQrdW5WZ3V6bEthcG1jV1V3aDFDOU9D?=
 =?utf-8?B?WnNOK0pBYW44Y1JDK0pKcjB6RitrT1BiaGROSzIzckVUTDJyRkF5cExsTWdL?=
 =?utf-8?B?ZzFkOTF4TDZHZmFkaU1IamEwWVJJNnNWK1VwMGwvcGhnU3Zjckd1YTAzUWNR?=
 =?utf-8?B?NS9XWDRNZjVGWUtmeWg3UXhFY0V2SHpBNllDdWZpVzF0S1ZHbkFVTnZEcUtV?=
 =?utf-8?B?bWkySHBXWWxuaWsyM1ErRGJBVkxoWU1KWXJVWWdxYnpQY0ZXcXFVQ01KdGQz?=
 =?utf-8?B?aFk5L2liSEpGTFByZkhEVllvQkthTTlYaXBlTWVramZCTG43c0Z5bkU0V3JG?=
 =?utf-8?B?NHJweHpKQ09VQ21TUTZhRVNBR1NhRVVYZmZORi9Nd2w4OC9ya3IxcWFKY1VR?=
 =?utf-8?B?MWtENmFUV3diclQxL1hkbEUzejgyTmJZbDdNLzZJT1IwSVRydEI1ekFxekdX?=
 =?utf-8?B?OTdPemY1cjNMdlY5eWFqOEFBS0dWOWxidTVBUHYyM3QwYnB0YStYOTVjakRS?=
 =?utf-8?B?aTNBTWtWV2lBVGsyZTVwdXQ0S2VCNlJyclZIL2lRbkZVSVFHMm54ZmR0SW5L?=
 =?utf-8?B?Rm5iUzhOVVZWNEh4REFWNkx1YWwxK1N4Y3RiUTUwS3liL2k5SEp1ZzU4YzdX?=
 =?utf-8?B?QWxxUUZNWkF4N05MR0lSK3B4VkZTL3NnNVpYdklWanVzSmUyQU5vcXB3TnJ3?=
 =?utf-8?B?WURLWGVzVEFYdU1maWJQdU9sSGhiQksxQjJVN1pHRC9DdzRuN01KSGVCSHMr?=
 =?utf-8?B?Ty9DbWVudTZNcEVCOUdVaC9wcUxqNmZYMmd1b3VpN1NtSE5FM01zcEhTMEg4?=
 =?utf-8?B?ZU11bmpWUEkwa3JBVytCcWRrMGJYOHIyc212ODdxckdDZjJJWklzQzRHc3Fp?=
 =?utf-8?B?M2VjdHNPZHFqT0RlMEZZZWNDYlNwbkxqTVhaaEo5S1Nia3lCaDB3T2N2VFdO?=
 =?utf-8?B?SDdWZjVzSVpnQUV4S0YrQ2xMN3ZlT0Zqd2hMcG1pdzF2NHd4UXc3QjVCRDVy?=
 =?utf-8?B?VUlhdEZNTFhMTCtSenBLbi9hRHh0YjFlMmEzT2UyNWhFT0NhY2RVVjdOR3Bx?=
 =?utf-8?B?dTMyRmFwb0dZaEVtYS9DZDJ6Qjc4UU1qUVV2UHF0NVJTWlZvaG1qenU5SXgx?=
 =?utf-8?B?RTBhNHNvOTM3cFlwTmVxSXUxZW1udG1YVG5SK2UyMWUyZmYzaTRkdEYzbCtF?=
 =?utf-8?B?cTVhU1BuZitFT3Z0amFjcmkyUWtDZUlabEdLeFBHNGx3Y3pNWVEya1JIWWNF?=
 =?utf-8?B?WXBiWFFXekdQNGJXbVlwOVhrNTB1NkJmRlk2ZnpuYTZSQUs4M1JESm5tWnVM?=
 =?utf-8?B?TzB4U1lWcmNrRmxvemJBb3d4WEZXakdCekFINUpIMEtBb3E3ak1Ubk81U1NL?=
 =?utf-8?B?Ym1pUjBpZFN1RVI2VXliUkUyWGZhanlTRWxJdTkvZHI2ZStLeW5tcUNCTm1s?=
 =?utf-8?B?eWV2S2xuUThjcjVJRWJFOTFEOXdmOWY4YWtzYkRLcG1sU0c5TVppRTdmMnlS?=
 =?utf-8?B?dVVvU01wa085aFZwL0dJTDNkVlUxMGpLSjRBTHFCdGNQTVN5U3dwMWxCVjUv?=
 =?utf-8?B?eWg1M1FJNlZEZDdOdE8reGNyeVBrOFU3anFmejh6YjBlUzFhYzY2MWV2alFJ?=
 =?utf-8?Q?8z+qWmh4VCLDOdv96C7eHPg9Y?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a4627fac-9839-4229-bc4b-08dbe6213f6f
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Nov 2023 21:24:27.7276
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j0bPv2rfToXaKBLuNsWjYJ2AUmGoH+bq9OrdFg+1XnV1v3rA2IeA2cEX/erjh/a8vNUb8TmAx2ElXUDLdLy5ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN9PR11MB5529
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/14/23 05:56, shiju.jose@huawei.com wrote:
> From: Shiju Jose <shiju.jose@huawei.com>
> 
> CXL spec 3.1 section 8.2.9.9.11.1 describes the device patrol scrub control
> feature. The device patrol scrub proactively locates and makes corrections
> to errors in regular cycle. The patrol scrub control allows the request to
> configure patrol scrub input configurations.
> 
> The patrol scrub control allows the requester to specify the number of
> hours for which the patrol scrub cycles must be completed, provided that
> the requested number is not less than the minimum number of hours for the
> patrol scrub cycle that the device is capable of. In addition, the patrol
> scrub controls allow the host to disable and enable the feature in case
> disabling of the feature is needed for other purposes such as
> performance-aware operations which require the background operations to be
> turned off.
> 
> Signed-off-by: Shiju Jose <shiju.jose@huawei.com>
> ---
>  drivers/cxl/Kconfig         |  23 ++
>  drivers/cxl/core/Makefile   |   1 +
>  drivers/cxl/core/memscrub.c | 455 ++++++++++++++++++++++++++++++++++++
>  drivers/cxl/cxlmem.h        |   7 +
>  drivers/cxl/pci.c           |   6 +
>  5 files changed, 492 insertions(+)


Maybe this patch can be split up? Awfully large. Maybe a patch with support functions and then another with usages?

>  create mode 100644 drivers/cxl/core/memscrub.c
> 
> diff --git a/drivers/cxl/Kconfig b/drivers/cxl/Kconfig
> index 8ea1d340e438..45ee6d57d899 100644
> --- a/drivers/cxl/Kconfig
> +++ b/drivers/cxl/Kconfig
> @@ -154,4 +154,27 @@ config CXL_PMU
>  	  monitoring units and provide standard perf based interfaces.
>  
>  	  If unsure say 'm'.
> +
> +config CXL_SCRUB
> +	tristate "CXL: Memory scrub feature"
> +	depends on CXL_PCI
> +	depends on CXL_MEM
> +	depends on SCRUB
> +	help
> +	  The CXL memory scrub control is an optional feature allows host to
> +	  control the scrub configurations of CXL Type 3 devices, which
> +	  support patrol scrub and/or DDR5 ECS(Error Check Scrub).
> +
> +	  Register with the scrub configure driver to provide sysfs interfaces
> +	  for configuring the CXL device memory patrol and DDR5 ECS scrubs.
> +	  Provides the interface functions support configuring the CXL memory
> +	  device patrol and ECS scrubs.
> +
> +	  Say 'y/m' to enable the CXL memory scrub driver that will attach to
> +	  CXL.mem devices for memory scrub control feature. See sections
> +	  8.2.9.9.11.1 and 8.2.9.9.11.2 in the CXL 3.1 specification for a
> +	  detailed description of CXL memory scrub control features.
> +
> +	  If unsure say 'm'.
> +
>  endif
> diff --git a/drivers/cxl/core/Makefile b/drivers/cxl/core/Makefile
> index 1f66b5d4d935..99e3202f868f 100644
> --- a/drivers/cxl/core/Makefile
> +++ b/drivers/cxl/core/Makefile
> @@ -15,3 +15,4 @@ cxl_core-y += hdm.o
>  cxl_core-y += pmu.o
>  cxl_core-$(CONFIG_TRACING) += trace.o
>  cxl_core-$(CONFIG_CXL_REGION) += region.o
> +cxl_core-$(CONFIG_CXL_SCRUB) += memscrub.o
> diff --git a/drivers/cxl/core/memscrub.c b/drivers/cxl/core/memscrub.c
> new file mode 100644
> index 000000000000..ec67ffc81363
> --- /dev/null
> +++ b/drivers/cxl/core/memscrub.c
> @@ -0,0 +1,455 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * cxl_memscrub.c - CXL memory scrub driver
> + *
> + * Copyright (c) 2023 HiSilicon Limited.
> + *
> + *  - Provides functions to configure patrol scrub
> + *    feature of the CXL memory devices.
> + *  - Registers with the scrub driver for the
> + *    memory patrol scrub feature.
> + */
> +
> +#define pr_fmt(fmt)	"CXL_MEM_SCRUB: " fmt
> +
> +#include <cxlmem.h>
> +#include <memory/memory-scrub.h>
> +
> +/* CXL memory scrub feature common definitions */
> +#define CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH	128
> +#define CXL_MEMDEV_MAX_NAME_LENGTH	128
> +
> +static int cxl_mem_get_supported_feature_entry(struct cxl_memdev *cxlmd, const uuid_t *feat_uuid,
> +					       struct cxl_mbox_supp_feat_entry *feat_entry_out)
> +{
> +	int nentries; /* number of supported feature entries in output payload */
> +	int feat_index, count;
> +	bool is_support_feature = false;
> +	struct cxl_mbox_get_supp_feats_in pi;
> +	struct cxl_mbox_supp_feat_entry *feat_entry;
> +	struct cxl_mbox_get_supp_feats_out *feats_out;
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +
> +	feat_index = 0;
> +	do {
> +		pi.count = sizeof(struct cxl_mbox_get_supp_feats_out) +
> +				  sizeof(struct cxl_mbox_supp_feat_entry);
> +		pi.start_index = feat_index;
> +		nentries = 0;

Is this needed since you init it to feats_out->entries a few lines below

> +		feats_out = cxl_get_supported_features(mds, &pi);
> +		if (PTR_ERR_OR_ZERO(feats_out))
> +			return  PTR_ERR_OR_ZERO(feats_out);
> +		nentries = feats_out->entries;
> +		if (!nentries) {
> +			kvfree(feats_out);
> +			break;
> +		}
> +		/* Check CXL memdev supports the feature */
> +		feat_entry = (void *)feats_out->feat_entries;
> +		for (count = 0; count < nentries; count++, feat_entry++) {
> +			if (uuid_equal(&feat_entry->uuid, feat_uuid)) {
> +				is_support_feature = true;
> +				memcpy(feat_entry_out, feat_entry, sizeof(*feat_entry_out));
> +				break;
> +			}
> +		}
> +		kvfree(feats_out);
> +		if (is_support_feature)
> +			break;
> +		feat_index += nentries;
> +	} while (nentries);
> +
> +	if (!is_support_feature)
> +		return -ENOTSUPP;
> +
> +	return 0;
> +}
> +
> +/* CXL memory patrol scrub control definitions */
> +#define CXL_MEMDEV_PS_GET_FEAT_VERSION	0x01
> +#define CXL_MEMDEV_PS_SET_FEAT_VERSION	0x01
> +
> +#define CXL_PATROL_SCRUB	"cxl_patrol_scrub"
> +
> +/* The default number of regions for CXL memory device patrol scrubber
> + * Patrol scrub is a feature where the device controller scrubs the
> + * memory at a regular interval accroding to the CXL specification.
> + * Hence the number of memory regions to scrub assosiated to the patrol
> + * scrub is 1.
> + */
> +#define CXL_MEMDEV_PATROL_SCRUB_NUM_REGIONS	1
> +
> +static const uuid_t cxl_patrol_scrub_uuid =
> +	UUID_INIT(0x96dad7d6, 0xfde8, 0x482b, 0xa7, 0x33, 0x75, 0x77, 0x4e,     \
> +		  0x06, 0xdb, 0x8a);
> +
> +/* CXL memory patrol scrub control functions */
> +struct cxl_patrol_scrub_context {
> +	struct device *dev;
> +	u16 get_feat_size;
> +	u16 set_feat_size;
> +	bool scrub_cycle_changable;
> +};
> +
> +/**
> + * struct cxl_memdev_ps_params - CXL memory patrol scrub parameter data structure.
> + * @enable:     [IN] enable(1)/disable(0) patrol scrub.
> + * @scrub_cycle_changable: [OUT] scrub cycle attribute of patrol scrub is changeable.
> + * @speed:      [IN] Requested patrol scrub cycle in hours.
> + *              [OUT] Current patrol scrub cycle in hours.
> + * @min_speed:[OUT] minimum patrol scrub cycle, in hours, supported.
> + * @speed_avail:[OUT] Supported patrol scrub cycle in hours.
> + */
> +struct cxl_memdev_ps_params {
> +	bool enable;
> +	bool scrub_cycle_changable;
> +	u16 speed;
> +	u16 min_speed;
> +	char speed_avail[CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH];
> +};
> +
> +enum {
> +	CXL_MEMDEV_PS_PARAM_ENABLE = 0,
> +	CXL_MEMDEV_PS_PARAM_SPEED,
> +};
> +
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK	BIT(0)
> +#define	CXL_MEMDEV_PS_SCRUB_CYCLE_REALTIME_REPORT_CAP_MASK	BIT(1)
> +#define	CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK	GENMASK(7, 0)
> +#define	CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK	GENMASK(15, 8)
> +#define	CXL_MEMDEV_PS_FLAG_ENABLED_MASK	BIT(0)
> +
> +struct cxl_memdev_ps_feat_read_attrbs {
> +	u8 scrub_cycle_cap;
> +	__le16 scrub_cycle;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +struct cxl_memdev_ps_set_feat_pi {
> +	struct cxl_mbox_set_feat_in pi;
> +	u8 scrub_cycle_hr;
> +	u8 scrub_flags;
> +}  __packed;
> +
> +static int cxl_mem_ps_get_attrbs(struct device *dev,
> +				 struct cxl_memdev_ps_params *params)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +	struct cxl_mbox_get_feat_in pi = {
> +		.uuid = cxl_patrol_scrub_uuid,
> +		.offset = 0,
> +		.count = sizeof(struct cxl_memdev_ps_feat_read_attrbs),
> +		.selection = CXL_GET_FEAT_CURRENT_VALUE,
> +	};
> +	struct cxl_memdev_ps_feat_read_attrbs *rd_attrbs;
> +
> +	if (!mds)
> +		return -EFAULT;
> +
> +	rd_attrbs = cxl_get_feature(mds, &pi);
> +	if (PTR_ERR_OR_ZERO(rd_attrbs)) {
> +		params->enable = 0;
> +		params->speed = 0;
> +		snprintf(params->speed_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +			"Unavailable");
> +		return PTR_ERR_OR_ZERO(rd_attrbs);
> +	}
> +	params->scrub_cycle_changable = FIELD_GET(CXL_MEMDEV_PS_SCRUB_CYCLE_CHANGE_CAP_MASK,
> +						  rd_attrbs->scrub_cycle_cap);
> +	params->enable = FIELD_GET(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +				   rd_attrbs->scrub_flags);
> +	params->speed = FIELD_GET(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +				  rd_attrbs->scrub_cycle);
> +	params->min_speed  = FIELD_GET(CXL_MEMDEV_PS_MIN_SCRUB_CYCLE_MASK,
> +				       rd_attrbs->scrub_cycle);
> +	snprintf(params->speed_avail, CXL_SCRUB_MAX_ATTRB_RANGE_LENGTH,
> +		 "Minimum scrub cycle = %d hour", params->min_speed);
> +	kvfree(rd_attrbs);
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ps_set_attrbs(struct device *dev,
> +				 struct cxl_memdev_ps_params *params, u8 param_type)
> +{
> +	int ret;
> +	struct cxl_memdev_ps_params rd_params;
> +	struct cxl_memdev_ps_set_feat_pi set_pi = {
> +		.pi.uuid = cxl_patrol_scrub_uuid,
> +		.pi.flags = CXL_SET_FEAT_FLAG_MOD_VALUE_SAVED_ACROSS_RESET |
> +			    CXL_SET_FEAT_FLAG_ACTION_FULL_DATA_TRANSFER,
> +		.pi.offset = 0,
> +		.pi.version = CXL_MEMDEV_PS_SET_FEAT_VERSION,
> +	};
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_dev_state *cxlds = cxlmd->cxlds;
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlds);
> +
> +	if (!mds)
> +		return -EFAULT;
> +
> +	ret = 0;

Why set to 0 and then overwrite it in the next line?

> +	ret = cxl_mem_ps_get_attrbs(dev, &rd_params);
> +	if (ret) {
> +		dev_err(dev, "Get cxlmemdev patrol scrub params fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	if (param_type == CXL_MEMDEV_PS_PARAM_ENABLE) {
> +		set_pi.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						   params->enable);
> +		set_pi.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      rd_params.speed);
> +	} else if (param_type == CXL_MEMDEV_PS_PARAM_SPEED) {
> +		if (params->speed < rd_params.min_speed) {
> +			dev_err(dev, "Invalid CXL patrol scrub cycle(%d) to set\n",
> +				params->speed);
> +			dev_err(dev, "Minimum supported CXL patrol scrub cycle in hour %d\n",
> +			       params->min_speed);
> +			return -EINVAL;
> +		}
> +		set_pi.scrub_cycle_hr = FIELD_PREP(CXL_MEMDEV_PS_CUR_SCRUB_CYCLE_MASK,
> +						      params->speed);
> +		set_pi.scrub_flags = FIELD_PREP(CXL_MEMDEV_PS_FLAG_ENABLED_MASK,
> +						   rd_params.enable);
> +	} else {
> +		dev_err(dev, "Invalid CXL patrol scrub parameter to set\n");
> +		return -EINVAL;
> +	}
> +
> +	ret = 0;

unnecessary init?

> +	ret = cxl_set_feature(mds, &set_pi, sizeof(set_pi));
> +	if (ret) {
> +		dev_err(dev, "CXL patrol scrub set feature fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	/* Verify attribute set successfully */
> +	if (param_type == CXL_MEMDEV_PS_PARAM_SPEED) {
> +		ret = cxl_mem_ps_get_attrbs(dev, &rd_params);
> +		if (ret) {
> +			dev_err(dev, "Get cxlmemdev patrol scrub params fail ret=%d\n", ret);
> +			return ret;
> +		}
> +		if (rd_params.speed != params->speed)
> +			return -EFAULT;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ps_enable_write(struct device *dev, long val)
> +{
> +	int ret;
> +	struct cxl_memdev_ps_params params;
> +
> +	params.enable = val;
> +	ret = cxl_mem_ps_set_attrbs(dev, &params, CXL_MEMDEV_PS_PARAM_ENABLE);
> +	if (ret) {
> +		dev_err(dev, "CXL patrol scrub enable fail, enable=%d ret=%d\n",
> +		       params.enable, ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ps_speed_read(struct device *dev, u64 *val)
> +{
> +	int ret;
> +	struct cxl_memdev_ps_params params;
> +
> +	ret = cxl_mem_ps_get_attrbs(dev, &params);
> +	if (ret) {
> +		dev_err(dev, "Get CXL patrol scrub params fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +	*val = params.speed;
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ps_speed_write(struct device *dev, long val)
> +{
> +	int ret;
> +	struct cxl_memdev_ps_params params;
> +
> +	params.speed = val;
> +	ret = cxl_mem_ps_set_attrbs(dev, &params, CXL_MEMDEV_PS_PARAM_SPEED);
> +	if (ret) {
> +		dev_err(dev, "Set CXL patrol scrub params for speed fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	return 0;
> +}
> +
> +static int cxl_mem_ps_speed_available_read(struct device *dev, char *buf)
> +{
> +	int ret;
> +	struct cxl_memdev_ps_params params;
> +
> +	ret = cxl_mem_ps_get_attrbs(dev, &params);
> +	if (ret) {
> +		dev_err(dev, "Get CXL patrol scrub params fail ret=%d\n",
> +			ret);
> +		return ret;
> +	}
> +
> +	sprintf(buf, "%s\n", params.speed_avail);
> +
> +	return 0;
> +}
> +
> +/**
> + * cxl_mem_patrol_scrub_is_visible() - Callback to return attribute visibility
> + * @drv_data: Pointer to driver-private data structure passed
> + *	      as argument to devm_scrub_device_register().
> + * @attr: Scrub attribute
> + * @region_id: ID of the memory region
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +umode_t cxl_mem_patrol_scrub_is_visible(const void *drv_data, u32 attr, int region_id)
> +{
> +	const struct cxl_patrol_scrub_context *cxl_ps_ctx = drv_data;
> +
> +	if (attr == scrub_speed_available ||
> +	    attr == scrub_speed) {
> +		if (!cxl_ps_ctx->scrub_cycle_changable)
> +			return 0;
> +	}
> +
> +	switch (attr) {
> +	case scrub_speed_available:
> +		return 0444;
> +	case scrub_enable:
> +		return 0200;
> +	case scrub_speed:
> +		return 0644;
> +	default:
> +		return 0;
> +	}
> +}
> +
> +/**
> + * cxl_mem_patrol_scrub_read() - Read callback for data attributes
> + * @dev: Pointer to scrub device
> + * @attr: Scrub attribute
> + * @region_id: ID of the memory region
> + * @val: Pointer to the returned data
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int cxl_mem_patrol_scrub_read(struct device *dev, u32 attr, int region_id, u64 *val)
> +{
> +
> +	switch (attr) {
> +	case scrub_speed:
> +		return cxl_mem_ps_speed_read(dev->parent, val);
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +/**
> + * cxl_mem_patrol_scrub_write() - Write callback for data attributes
> + * @dev: Pointer to scrub device
> + * @attr: Scrub attribute
> + * @region_id: ID of the memory region
> + * @val: Value to write
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int cxl_mem_patrol_scrub_write(struct device *dev, u32 attr, int region_id, u64 val)
> +{
> +	switch (attr) {
> +	case scrub_enable:
> +		return cxl_mem_ps_enable_write(dev->parent, val);
> +	case scrub_speed:
> +		return cxl_mem_ps_speed_write(dev->parent, val);
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +/**
> + * cxl_mem_patrol_scrub_read_strings() - Read callback for string attributes
> + * @dev: Pointer to scrub device
> + * @attr: Scrub attribute
> + * @region_id: ID of the memory region
> + * @buf: Pointer to the buffer for copying returned string
> + *
> + * Returns: 0 on success, an error otherwise
> + */
> +int cxl_mem_patrol_scrub_read_strings(struct device *dev, u32 attr, int region_id,
> +				      char *buf)
> +{
> +	switch (attr) {
> +	case scrub_speed_available:
> +		return cxl_mem_ps_speed_available_read(dev->parent, buf);
> +	default:
> +		return -ENOTSUPP;
> +	}
> +}
> +
> +static const struct scrub_ops cxl_ps_scrub_ops = {
> +	.is_visible = cxl_mem_patrol_scrub_is_visible,
> +	.read = cxl_mem_patrol_scrub_read,
> +	.write = cxl_mem_patrol_scrub_write,
> +	.read_string = cxl_mem_patrol_scrub_read_strings,
> +};
> +
> +int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd)
> +{
> +	int ret = 0;
> +	struct device *cxl_scrub_dev;
> +	struct cxl_memdev_ps_params params;
> +	struct cxl_mbox_supp_feat_entry feat_entry;
> +	char scrub_name[CXL_MEMDEV_MAX_NAME_LENGTH];
> +	struct cxl_patrol_scrub_context *cxl_ps_ctx;
> +
> +	ret = cxl_mem_get_supported_feature_entry(cxlmd, &cxl_patrol_scrub_uuid,
> +						  &feat_entry);
> +	if (ret < 0)
> +		goto cxl_ps_init_exit;
> +
> +	if (!(feat_entry.attrb_flags & CXL_FEAT_ENTRY_FLAG_CHANGABLE))
> +		goto cxl_ps_init_exit;
> +
> +	cxl_ps_ctx = devm_kzalloc(&cxlmd->dev, sizeof(*cxl_ps_ctx), GFP_KERNEL);
> +	if (!cxl_ps_ctx)
> +		goto cxl_ps_init_exit;
> +
> +	cxl_ps_ctx->get_feat_size = feat_entry.get_feat_size;
> +	cxl_ps_ctx->set_feat_size = feat_entry.set_feat_size;
> +	ret = cxl_mem_ps_get_attrbs(&cxlmd->dev, &params);
> +	if (ret) {
> +		dev_err(&cxlmd->dev, "Get CXL patrol scrub params fail ret=%d\n",
> +			ret);
> +		goto cxl_ps_init_exit;
> +	}
> +	cxl_ps_ctx->scrub_cycle_changable =  params.scrub_cycle_changable;
> +
> +	snprintf(scrub_name, sizeof(scrub_name), "%s_%s",
> +		 CXL_PATROL_SCRUB, dev_name(&cxlmd->dev));
> +	cxl_scrub_dev = devm_scrub_device_register(&cxlmd->dev, scrub_name,
> +						   cxl_ps_ctx, &cxl_ps_scrub_ops,
> +						   CXL_MEMDEV_PATROL_SCRUB_NUM_REGIONS);
> +	if (PTR_ERR_OR_ZERO(cxl_scrub_dev)) {
> +		ret = PTR_ERR_OR_ZERO(cxl_scrub_dev);
> +		goto cxl_ps_reg_fail;
> +	}
> +
> +cxl_ps_reg_fail:
> +cxl_ps_init_exit:
> +	return ret;
> +}
> +EXPORT_SYMBOL_NS_GPL(cxl_mem_patrol_scrub_init, CXL);
> diff --git a/drivers/cxl/cxlmem.h b/drivers/cxl/cxlmem.h
> index fdac686560d4..1d0fad0dc5ae 100644
> --- a/drivers/cxl/cxlmem.h
> +++ b/drivers/cxl/cxlmem.h
> @@ -969,6 +969,13 @@ int cxl_trigger_poison_list(struct cxl_memdev *cxlmd);
>  int cxl_inject_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  int cxl_clear_poison(struct cxl_memdev *cxlmd, u64 dpa);
>  
> +/* cxl memory scrub functions */
> +#ifdef CONFIG_CXL_SCRUB
> +int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd);
> +#else
> +int cxl_mem_patrol_scrub_init(struct cxl_memdev *cxlmd) { return -ENOTSUP; }
> +#endif
> +
>  #ifdef CONFIG_CXL_SUSPEND
>  void cxl_mem_active_inc(void);
>  void cxl_mem_active_dec(void);
> diff --git a/drivers/cxl/pci.c b/drivers/cxl/pci.c
> index 0155fb66b580..86bba8794bb4 100644
> --- a/drivers/cxl/pci.c
> +++ b/drivers/cxl/pci.c
> @@ -881,6 +881,12 @@ static int cxl_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
>  	if (rc)
>  		return rc;
>  
> +	/*
> +	 * Initialize optional CXL scrub features
> +	 */
> +	if (cxl_mem_patrol_scrub_init(cxlmd))
> +		dev_dbg(&pdev->dev, "cxl_mem_patrol_scrub_init failed\n");
> +
>  	rc = devm_cxl_sanitize_setup_notifier(&pdev->dev, cxlmd);
>  	if (rc)
>  		return rc;
