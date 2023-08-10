Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5504776DEE
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 04:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjHJCPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 22:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjHJCPJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 22:15:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE10310FE
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 19:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691633707; x=1723169707;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=8jQhJx5obzteppUooDdNd3L46YJASHxYnbeWffYNAag=;
  b=mimwsC11aj/Pi36188w1uTmRrPvduc/eMYWQExEz75D0E9ewhcjQcMck
   MOkjTuGVlh+Oa78wJqTqPBFX6zaRBOeFyRw0mzdb8hcg+U3/50IBpHcGY
   7kE+rjJHh2TVtDQjONtfiJmOjK4RPKA5YHwMCcMm2yTqzMf9yxt2RQU58
   e3I3R1Jd7w7exaXZ5EBVBAWQDTcyn4tA4gD+LERVBlsB1xzZrcJa2HJlq
   xqc5mwulTUMyHFtMboz3uq/g6dCsMIgDGcXBn5NQNUcP61MKb/DLrUPqs
   9VZ+jfykh7MyXVqF3+/al6PA12OWSTrti8Sdb5ExfnzeF1jZf+uf11PJ3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10797"; a="437635069"
X-IronPort-AV: E=Sophos;i="6.01,160,1684825200"; 
   d="scan'208";a="437635069"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2023 19:15:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="875502206"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga001.fm.intel.com with ESMTP; 09 Aug 2023 19:15:10 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 19:15:06 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 9 Aug 2023 19:15:05 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 9 Aug 2023 19:15:05 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 9 Aug 2023 19:15:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=YSZE5yZRDFTDrphTADHRHyyq4i3lph/t3VrVtbCVZSmZK/oq4zei3nTIrL7ri91/tE+OHAlmSN5JuRUHXJC6nqUJW6ApRjM0Y4bGqHkuaUHo2CMshg5aR54w5Gj6+1lbIz7R4PaOmordGBpdKd0+c2zWdkUEurueMtQ+QX/qJLn0mh7zONoNcCD/FDozc81N+9SUM0RtOYiLplXOnvnCaO6CxTqwEtCM3rD2FffU90CaSJienwiZpv8vtLWQFhaV1VO9FeTh4zbJLC7Q7jx/zTmkBO+KqiuSN7NZYvpGFnHL0I7X3bqbChqkQGNiDX3Oeooa+KS2LulN+PxesSXqWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6silUzTIABn2Esw8KYNhG7Rp5XXkKC5RaAn+nn6oteg=;
 b=JNr2QsLsNVb3e/UQUcmInpVZHnUYcyhIix/i94FmVBuHm8haHkayDaPHKHEEdzuCb8kPQyaYugvCMuQntSypaqCSJeqA2aenDZsa4Rl5pVTaoxfdR2Xe/I4iNrdc5oh0cv8nVhz5oIPwtSpEj+hVzbxY2VOJIIS/qe2FZerhDeMHK1GmL+Ah2rW7hAatRSK8Mv9+J4iGpIx/sfZdMEqZa62Y+edsu6Mi4XgTpbcZRVIoB9SZrdDFWM/lMYnuej6a456X2n7sos/Ow2PSrSNZKahKS6UpXocPk0TVasqeONgrdURZFV9bvrli37w+tv9268/1+F2rwgfwDsGn6fVwjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MW5PR11MB5881.namprd11.prod.outlook.com (2603:10b6:303:19d::14)
 by CH3PR11MB8494.namprd11.prod.outlook.com (2603:10b6:610:1ae::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.30; Thu, 10 Aug
 2023 02:15:03 +0000
Received: from MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c]) by MW5PR11MB5881.namprd11.prod.outlook.com
 ([fe80::6c46:eead:bf23:5d5c%4]) with mapi id 15.20.6652.029; Thu, 10 Aug 2023
 02:15:03 +0000
Message-ID: <7125bb0a-24c0-2d0a-d410-454e86f649b9@intel.com>
Date:   Thu, 10 Aug 2023 10:14:50 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] iommu: Support mm PASID 1:n with sva domains
Content-Language: en-US
To:     Jason Gunthorpe <jgg@ziepe.ca>
CC:     Kevin Tian <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Michael Shavit <mshavit@google.com>, <iommu@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
References: <20230808074944.7825-1-tina.zhang@intel.com>
 <20230808074944.7825-5-tina.zhang@intel.com> <ZNJbaiTDG+YTgpDP@ziepe.ca>
 <ZNJc8r1eeQZ8GqxY@ziepe.ca>
From:   Tina Zhang <tina.zhang@intel.com>
In-Reply-To: <ZNJc8r1eeQZ8GqxY@ziepe.ca>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: CYXPR02CA0026.namprd02.prod.outlook.com
 (2603:10b6:930:cc::9) To MW5PR11MB5881.namprd11.prod.outlook.com
 (2603:10b6:303:19d::14)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW5PR11MB5881:EE_|CH3PR11MB8494:EE_
X-MS-Office365-Filtering-Correlation-Id: 08aaee1b-0454-4a8d-8511-08db99479b9b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: D2F69CrXrX9E9APGb2omYxTC3ZTIOxCHbI06SM3yvIY5rMlo3fFMbj2RYX83ccUtzVigOVmydj+ocLzwN/goP6JdFx6YuIsh4DDSBAHOgy7W1N9tk+PSSwjXxrnnhGzJeXxd2LrYA82IygE7eg4LwmQGlET53nXJ+jHzNiNIENpqAk4ECCmPJrHah0L3J4E5QaO36HZKMv4VmAvep2PrtC8Nq1Hs1eLSVDtlBnCPpV17YlTg3cKRk2KEkVjnVgt+vNFZ+j1Pe7Bfa7NuSVgkGBLpVouSNYdjlH96vf1FXbGHyxc/9IzNM7tIRvsPBsJwrt1brmOEb/BKClprOMMCCcMgrR1Nobhgd3ry5DXe8Cuo2TfpDpHzGt5zDGLc2n9oAVzkg8yGE3ALplL9oVd5NbhigdrAer3NKDXLOq8gKpUIpP6O8gU8o0PBRC+S+hUpjCbImkO2ftnyu6W/SA/KYB+Si9Z6YmpGf+S2zcOdzrUMrIAqV3KpmZmtM/bxeuTbSywf5sehHjafYDzIHVwh05z642dBo5CJGNo+gODjPelby2urZtyDF9bKP2gt79qHpiMqE2KAP/izw/p7lEFmXNrZLb7/nfOOn1Kl7WQrPQv4o6FlgxxUgeuDQcdGu3NEIq7yBAKWvEbh7jicRoQ1aA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW5PR11MB5881.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(346002)(376002)(39860400002)(366004)(451199021)(186006)(1800799006)(4744005)(83380400001)(54906003)(2906002)(53546011)(6506007)(6512007)(26005)(6666004)(36756003)(31696002)(6486002)(86362001)(478600001)(2616005)(66946007)(6916009)(4326008)(316002)(66556008)(8676002)(66476007)(8936002)(5660300002)(82960400001)(41300700001)(31686004)(44832011)(38100700002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MTZPd2hsYWJQenB1N1JDZE1VYXc5MmQ2Y3JiVUlXQm1WbnBJZGF1clNqY05l?=
 =?utf-8?B?bE10ZmEwSzE3QXBOc2VlT1ZOMWYwMGtSWHRVTjBFZVZOOTYra0M5Y1hyR2Y1?=
 =?utf-8?B?VjU1aWRNMExNeXNmRU43a1J1WUZ6MkE3alZTaUgvK0JqWVJrY1gyUjAvWlQr?=
 =?utf-8?B?SHQyLzRLdkVWY0ozYkhrUFYzcmJ5VnR1TFpSdlRFSnd2bU1VS2hWclpQZkdl?=
 =?utf-8?B?Zk5RUEwyTW1VcXVqVytVWUZIdW1hNHJaK1JWMkdpYlBKZEIrSklQenh2czM4?=
 =?utf-8?B?a2lZTlFKWHIvTElUaUdxL0UxSGdncTRycDFEZDA3VE1rYlZSRGw0MzZBUDZC?=
 =?utf-8?B?UkVNRGlsUlBJRWgzS3N5M1Q3M0xVdlczeUN5ZVhxdHdXcEhWYjN5dkt0NHlr?=
 =?utf-8?B?VzBVWkJpSEQ4TjdENXIzbTI2VmtHWVg4QUhlSUk4dHRCTlFhSHduMHRKWWgx?=
 =?utf-8?B?aXlZcE1jNmZ1ZmdqMElTaWw4bm14UnlhOWd3OUdib2NhbnVoalh1OTFXZDB3?=
 =?utf-8?B?ZDdvMytCOE9UbEVtOFQwOG0rUTNjUFVMQ3k3Q0JSL2dJb05XZVJJakdkWG14?=
 =?utf-8?B?MTJvU2toRVlJWERTVE5tWGRnbTdmUzdvWWlDM0g1UFlhN0hUSXZoVGtuczZs?=
 =?utf-8?B?Y0F4bVdwa3BINkNRL1hRMDJMajRPYzI3NDl3NEtNbjhVQVVuUUpDU2REc3Ji?=
 =?utf-8?B?L3NkbGRNMC9oZGdIczIvNmJiOC9URHFBSEk3eFhPSGF6LzREU3VOcmpSaVFW?=
 =?utf-8?B?TG9PWUgrTDkzbmQ1c2dva0NjejJ4L056QnE5VGh3enl2WHQvdW9RTlRsc0x1?=
 =?utf-8?B?c0xhaTl5dzduNDVmZjd1MGlCQS82aWduMXFJMkd2YzRTSm9zeUY2ZzdvV04r?=
 =?utf-8?B?Vll3elFRWW1IY3VjZmdEYVdCa2NlR05uZHZCSUc3VlUya2dEQkh0akh2Snpm?=
 =?utf-8?B?VENtcXRUcTZhZ01WWG1PY1VFWkNWU2ZPNENBdEhtcWcwZTlESU5TU2ZjeFZa?=
 =?utf-8?B?SFh5YVNsc0dYUkt4QmR4NU1VaEhML2RFODdEeWduaGkrekNhTmRsQXhPRjRu?=
 =?utf-8?B?YXhSeFZRSDI4TUxJaFJyZ0NxZkFwOHpPeG1zcWRldExmMWFMZmFNQXRETHhQ?=
 =?utf-8?B?VlJ1MlcrSDduTGhnMzFSOExhSFRqeGp6R20vU0RURGpUZ0xxUkVHV1hobTFk?=
 =?utf-8?B?RVFxQisvdUx3MWU5bWloWUdRbVRXUzNxalFKbVd0M01tT0hiMEJMeXNPbUZp?=
 =?utf-8?B?eDRwZlY2S3FsUkdoUjh3VEw1REtra3NQSG5EYjF0RkNjOCtxckh4T2ZFM1pP?=
 =?utf-8?B?TDkxVUxXTU1aSi9vd3V6UWx2TC9MRmZzWTRuU25tc242eHJreGtaOG0rVmc5?=
 =?utf-8?B?aEtRUGg0dy9LZ3RQbTcwcVA3Y3NSOHVpSUxjQUxOK05TWGxHaHJOcUhDdm95?=
 =?utf-8?B?NTBDeHVYbFI0Q2FsbVpXRGl4M2g2KzIxbHhzeU9kcVdvU2tpUnNjbXZMTGRQ?=
 =?utf-8?B?Y1g2MjU5b3pmZXdKNkZzcFRxK0pQb2YwbGlKSzJJWkdEMFdKMGYrQ1ZkNUNK?=
 =?utf-8?B?N09RYk1wUngyaFpmM0RVaHRWOHgralJjbk52UWgrWkI5MittK0tTVVMxREMv?=
 =?utf-8?B?TitLdmtQc2Fhd0d1NFhvTGRvK2NSQ3pRMnlFanI0a3F0YnRYcXBpOGpkdW1C?=
 =?utf-8?B?dXlpbUxOUUFTUmszK1YySktjb3ppNzZxY2ZXV2ZhLzFReHhHMDRpNlJzdzVF?=
 =?utf-8?B?NnpaTWlmRGs5OWFZQms2U3E2T21QSzI4NWExTHFDUjBmeHFIU3FQd3ZtRGQ2?=
 =?utf-8?B?d1ZhZFVjV1pkY1AxR1NCTnlZWUx5UG1TazNTNWpMOWlWSDVuTU9vRHhCVW5U?=
 =?utf-8?B?cFpkRkgyakVubmU0aUdSUTE5dHN3cWdWaUEzek9oMUtWMlluMlVDM1U2VGZh?=
 =?utf-8?B?YkNtUm16ZmE5SUoxYzR3cjRDYzlPbXVhTVB4ckhaempLRmZLbUtwRWFxUFZo?=
 =?utf-8?B?bldYWExyTmRBeE5PbWdNZC81MUFaR0hkN1FoSnZqdThPZUp3aTI3Qko5ejFR?=
 =?utf-8?B?V0hiQ2pwOHF0SFZhL0NsZkR0eldVN3dtMElQTzRKTGV5UDRFaEtjMVc5R2px?=
 =?utf-8?Q?qfXyCk2KOQmGXPkP/rQXUThVe?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 08aaee1b-0454-4a8d-8511-08db99479b9b
X-MS-Exchange-CrossTenant-AuthSource: MW5PR11MB5881.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2023 02:15:03.6780
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: F3MMJEgPLKONG6vu2zVAlwwUAD9+WcQnbItE//flk+DKtQkfQr0P+EqCbwX/wL5FLQpRHilp2quO5sA6rPcl2A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR11MB8494
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/8/23 23:19, Jason Gunthorpe wrote:
> On Tue, Aug 08, 2023 at 12:12:42PM -0300, Jason Gunthorpe wrote:
> 
>> Lets please rework this function into two parts
>>
>> The first should be 'iommu_sva_alloc_domain()'
>>
>> It should do the list searching and user management. The usual
>> 'iommu_domain_free()' should be modified to clean it up.
>   
> I suppose we can't quite do this fully since the domain allocation
> needs to use set_dev_pasid to detect compatability :( This is a
> similar problem we had with iommufd too.
> 
> Still, the 'alloc and set_dev_pasid' should be in one function and it
> should be undone with iommu_detach_device_pasid() and
> iommu_domain_free().
> 
> The helper bind/unbind functions should wrapper that sequence.
Make sense. I'll refine the error handling paths in bind/unbind 
functions in the next version.

Thanks,
-Tina
> 
> Jason
