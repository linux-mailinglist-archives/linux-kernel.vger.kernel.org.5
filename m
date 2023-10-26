Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9247D7F5B
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 11:10:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjJZJKl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 05:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjJZJKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 05:10:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F560187;
        Thu, 26 Oct 2023 02:10:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698311432; x=1729847432;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=o8An9iMfN1rouwSViFZj8BqSdDOyvrY0GUyFsyH9FbY=;
  b=nSDhG0iM12mLgEPRDtDbPBH5Ld5wBFaeR5/ftmmT2d1Q3mEYNnuHUwwn
   4Oqr4sIZWz62rj3zBBsP0aDbD3PGk2LEZ3tXgAP18Yvs2Dzvu+kpf4PyH
   Vuu08fk0K8sUHrOir2DE3/Hk2oBJmkiyGIQxCNXsH445s37cf0gJKRlGx
   zE86tN3kS0Gut8hqpEgW2gYXpoiT6rI1cgqwZv0hnWJ8jnT8bH6SG60Vh
   w5voCqHlBxHkOeUMz1kCaPHVmOg02DdyKb1SLzJmVwAXuyEvHAW5Qj+9L
   LaQjEgk5EmOJ0C6rZmBDgMrfmuhYuVwAaCNiYjSsspzIuuWEdC00hHxjS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="367706952"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="367706952"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 02:10:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="6863310"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by orviesa001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 02:09:10 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:10:30 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 02:10:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 02:10:29 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.100)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 02:10:29 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dUlDmM9MLuAX4K7p2caaaV0xaR2qF0N22MAjg53KmJcuMhNF3TPyPWc15leeLlB6AlCXXVDvtG32afqoIW2+p1lnM3+bgWknWt/WwWsqByIt06JRXpV6FpFEicnkjkiCUteV+D2J82FRq95PvUe853x5kpsgwobp8zNltS9bzQyL1zF1+yTz4/X1spG2SePcZwm6C2xSR4UCCZlA+4mziXq2yPzfcdIbNSnGo3SCAPKFWtPZWfoafoAXFad+KrN2j/l/FXTOVuaZKjKWCOqV3iCPFUBww9lKxeE5iyPD0IDLSnnTSCjU6fHS1MAi7LxYWD+qRaVIK298uX6Xh+Ma+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b9An17FlA20mdwIKHlnLVBsx2hbqjy9f8L50Q8Y5Gzo=;
 b=YgHdek7AoWnDnO2Wvl3P4sgrsgmQTZpPi37cNpQwyMcRSYfghJnBg/vfjTjTpRcvOHMX+w8rDDi/+D5GRCbIDuZI9Ve71FdhiSyosTYWCNhCr3lN6gPTuEAnWQCGx5B8imGBLFgW8V4d+JpOS/ko2KeFRpiK1gf9hkdD83t7IQ60YEL0bvpd5LFyuOW6ysZNhRkIoWeVm9wUQCEG5C7kjpjZ0+ifWQCreQmaO8i42aQOvku3rKUqx1Y7xY/wBcNf/o1F1JuHGcUp8oAPR36n2avsADK3wjA2HU2VnNpa0iLVQyOl69f8VllWSy3a3QCWYOg2OrUhtZTDVhM4pNOsjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by MW4PR11MB5892.namprd11.prod.outlook.com (2603:10b6:303:16a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 09:10:21 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Thu, 26 Oct 2023
 09:10:21 +0000
Message-ID: <7596497f-394d-20f2-d517-064674d38b5e@intel.com>
Date:   Thu, 26 Oct 2023 11:10:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH iwl-next] iavf: Remove queue tracking fields from
 iavf_adminq_ring
Content-Language: en-US
To:     Ivan Vecera <ivecera@redhat.com>, <netdev@vger.kernel.org>
CC:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        <intel-wired-lan@lists.osuosl.org>, <linux-kernel@vger.kernel.org>,
        Jacob Keller <jacob.e.keller@intel.com>,
        Wojciech Drewek <wojciech.drewek@intel.com>
References: <20231026083932.2623631-1-ivecera@redhat.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231026083932.2623631-1-ivecera@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:cc::13) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|MW4PR11MB5892:EE_
X-MS-Office365-Filtering-Correlation-Id: b5c05f04-e194-4acd-db70-08dbd603614a
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: kTyWQkPxcLK8BeUyVw7cusHkz7dbJi9udiGK4vTVz+t9uyCnQJ5ykA1ere6b6oTp6T4bREsjGkflBedxaM2DheAwhKYVYHhrtOas0/GbUF4aVN+11XVYOwBiKuVes79uQ1tnChs6z2QJtXI7NFeDTQPa6p5rvzlyCL55iG4xWgcThuJgtoHUerlFQh4tWWoVUPw5SpEDGDeiYfiP0hFWXh3JcLovq7WDbJayS/P/aojoVbAUZsFtDD8qbl2MGt/gzOGIjd8r26S8Zmt5jm/sLk6JPHBSoVwXgYY2/lhTRqdnLaARTOrpfJ9HOWrOetVMjPHfpwLnrxLeVl+hIDz5GttAyHyw89CLl0OyV6Qa9FXD6cW9p0a+jfDGog3jLOIByqbTii+h4vLHU97hv/J2eoIf6Q9Grk4CmBhK1NSXHHuDdVJ3SOUjotzOSYMHIw3PR6gEpRoo6yiHPAMuT/OPiDyeou3Zdig7pw+BPvTzkM8CZpSH4gDorBa2+kFoIhWaCKRLrjvm9lawdZ7JD+NQdMeDiAhiS9xhYV3TnpVy+UUSPOesxz8VEjBXMm/GvLyF9uDWAwq9OVXMhqVTy/YlxvC4e40gow9n0JK/iTeF9tgzNKQA5AjQXloT5Ga1+U1nMZzGfeClZQQCXStFMZVJXw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(376002)(39860400002)(366004)(136003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(54906003)(8936002)(6666004)(5660300002)(66476007)(66946007)(41300700001)(86362001)(66556008)(478600001)(31696002)(6506007)(6512007)(316002)(6486002)(8676002)(36756003)(4326008)(53546011)(30864003)(2906002)(2616005)(26005)(107886003)(38100700002)(82960400001)(83380400001)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?enJrM1VaZDA0Q0NocEFsdktIbUs1bFpXUDJLM296aFRkZUpqVENwUTh0MVdJ?=
 =?utf-8?B?K1lnSFNVS0Y4SE9LM1ZGRFJZNEdKTksyK3loNXAzOFIrU2FzTUZkVjdza1Jp?=
 =?utf-8?B?cjNvMkRMa2Vrby9hTU1tdFQzQStyWXVMQ0RSa3N1UkdGdHF5Q2Q4Yi9HM0p6?=
 =?utf-8?B?aFEzK0U0eFptNlgycUtCOE4yQWlUUWJRK2gxMGFkRGVZY0p2czYyVVVTWGZo?=
 =?utf-8?B?TGlRQ0ZVN3pqaGUyUWp6SFlSNmtiZjRnZ2hvOHY2WDZ3YUtnUEwwWGlUYVp1?=
 =?utf-8?B?djlpR1VWQmRyUVFaZkt4U2RIbWVwZ1hCcWxPR3FZV0VkbTZRUnhySGlnZllE?=
 =?utf-8?B?c3Z6TStDcWNRckR0Z2l0Z2Y5ZHRsY0VmZUV0U1JGM1Nkc2dDTGNSOGoxa0Z2?=
 =?utf-8?B?THp6RFg4MldoMFBZYzFkMzBLS200U2t3RmJqZEpOVUdYK1FVRloxbmNOK0Rl?=
 =?utf-8?B?aVJJbDVEbjUrbWVUcFB2RjNVN0x4Tm1QTVNPRS9iY21Pa21kbk1oK2R3ajZ4?=
 =?utf-8?B?dXNxNzFlZTBFV0EvVWJpZVhGMCtRdG4vck1TQmI2ekFYWHR1TjRnOUNsc25s?=
 =?utf-8?B?dUVhekNiSDRDTC9ucmtoZnArY0ZQd2J0V3dHcHR0aFVUeUN2QzRxQ0kyTEIx?=
 =?utf-8?B?azQ2VEdLVHNRWXZPOW94K0RybG0wcVMwZUN3L3pVOWpWSUtxMXNXanRIOWpF?=
 =?utf-8?B?VXRoekJuRTZkOS9lSXdBOWZsK0ZRYzJOeEl4NUp4UXk4dXY3QjNjbjU4cWZI?=
 =?utf-8?B?NGRhd09xRlNqR1dwWmlsZGpKeldIczlZT1k0UzhUbUt2c1dJOWJoL0N1NnBm?=
 =?utf-8?B?ak91d0dmcW83TUFoZmFZZjJIM2NkS0VGbWdpMmxEMkwzSGlHOHo0S0JoWWhR?=
 =?utf-8?B?d0FTWlRhYU5BZk5FNTZMbmhLQmJpZGI0TVhmZjV3aWtTdHZub2tienJQMGtC?=
 =?utf-8?B?OVREUWVTcW9YUk5abVhqZmZtUTJLQUdlSEtyaGZvdVhLa1lPWEJyUW9tTTUz?=
 =?utf-8?B?YUxHcE9YZ1h4b1NjNW05eWFoN0FUa1ludStIMFd5Ymd6a3ZOUFJBalVPV2Q0?=
 =?utf-8?B?c3JwQnNsdnlxNXdxYkxTbDBsZG03QloyY0E2bkllTDZpNkhFcWRtbTdlYUVk?=
 =?utf-8?B?YTVPRE5LbndDdGs1WDFCUElFSTJwdXFsZTZUdTArdkFOZjFZV0x4dVIvZUJW?=
 =?utf-8?B?a1YvUnFlOVh4WkhGcDVCbXAwZmVSQUt2cUw5SFM0TklFRC8reHVUL2ZoRXo5?=
 =?utf-8?B?ZUVZaElRcG5RV0pSME53bG90eFloRjVFM3o0dGp4ODNZdHVKUlkzOUtsaWg1?=
 =?utf-8?B?bEdFdTkyV0NURWl4WEt3ZXkvQTU0NWxVcFhEYThDQnB6QTdVTTU0eFk4b0hO?=
 =?utf-8?B?enlwMW1LelhmTDNzS285anF0dDNHaDU5MjF5ektxZUVJZmsxMy9KWDVuYnE4?=
 =?utf-8?B?eGIrekgxVDMvVlNXSUF4U08veFhFckZFRnk3aUJGYXpzSXpQaEV0NFdjWkRK?=
 =?utf-8?B?THlPYkhlZFMyU1QrRy96S01EZ2NBYjhVQVFPUTdhWUlxdnJIMjEzZ3ZKWkdP?=
 =?utf-8?B?NzNFZjU4SWNIVUMraDlEaVdVN1lIaXF5aDREZ1RuS3FLNEZUaUZBL3ZuOVdF?=
 =?utf-8?B?ZDlOYnhVMG85aTltcDR2eFFuSWo4V3JoOFB6YmFSdFFzZUpNbDJCSGJodk9i?=
 =?utf-8?B?aW9BU204Y1BiUi9OcGo4UWdnQWs3YVdqbHRaNms2ZDI1ZmVNUkdMeSt3WGR1?=
 =?utf-8?B?czJqVkFha0VrdEVjZC81U2xZNXNrd1pDRDZPMml2REQ1aEd0QkE3V0cxVThI?=
 =?utf-8?B?NnhzWTZORjVHVklnNHp2cVhkMXNhR01Hb2ZmTEdEZHQ5REJKOWI0ajJWcVVC?=
 =?utf-8?B?dXRRamw0SC9FWDNNak5iQ2F2Uzd3eGp2cC8wUlFrTDlXNU9MM2lqNlBidlVv?=
 =?utf-8?B?Y3BEQWVoN3diWGNWQ3YyVkR6aTI0OWFIQ1cxQVl3ODVqOTFXWFZ3Y1FWVEFD?=
 =?utf-8?B?Z0ozaFZHTFE4RDVYNm12ZHVyZnZWeCtjZ3pPdzhyZUVDMUpKeWVOREt4STV0?=
 =?utf-8?B?L2dBSGwrYm5EKzVvbVZmbVlma1RWN05ualcxdjBYeWRVeTNJNUhiallwNERY?=
 =?utf-8?B?WTA1SVM2blFZZXB2SkUyMmNPY0F0dnk2bEd0T1RMK0wzV1dKRHFGaUsyZXN3?=
 =?utf-8?B?Znc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5c05f04-e194-4acd-db70-08dbd603614a
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 09:10:21.0192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w/ekJhsVIcqvSUsWG3ATsliw2LNgYDLGCPTkVc8JqPbACCSrMHXxu8RyPeSjCnwP+xP7VBhUGSYGCvg1G5VNBNZaCc+67CVNo9B2gaVtws4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5892
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/26/23 10:39, Ivan Vecera wrote:
> Fields 'head', 'tail', 'len', 'bah' and 'bal' in iavf_adminq_ring
> are used to store register offsets. These offsets are initialized
> and remains constant so there is no need to store them in the
> iavf_adminq_ring structure.
> 
> Remove these fields from iavf_adminq_ring and use register offset
> constants instead. Remove iavf_adminq_init_regs() that originally
> stores these constants into these fields.
> 
> Finally improve iavf_check_asq_alive() that assumes that
> non-zero value of hw->aq.asq.len indicates fully initialized
> AdminQ send queue. Replace it by check for non-zero value
> of field hw->aq.asq.count that is non-zero when the sending
> queue is initialized and is zeroed during shutdown of
> the queue.

That part could be a separate commit, perhaps even for -net

> 
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf_adminq.c | 86 +++++++------------
>   drivers/net/ethernet/intel/iavf/iavf_adminq.h |  7 --
>   drivers/net/ethernet/intel/iavf/iavf_common.c |  8 +-
>   drivers/net/ethernet/intel/iavf/iavf_main.c   |  8 +-
>   4 files changed, 39 insertions(+), 70 deletions(-)

anyway, this is fine, so
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

> 
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.c b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> index 9ffbd24d83cb..82fcd18ad660 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.c
> @@ -7,27 +7,6 @@
>   #include "iavf_adminq.h"
>   #include "iavf_prototype.h"
>   
> -/**
> - *  iavf_adminq_init_regs - Initialize AdminQ registers
> - *  @hw: pointer to the hardware structure
> - *
> - *  This assumes the alloc_asq and alloc_arq functions have already been called
> - **/
> -static void iavf_adminq_init_regs(struct iavf_hw *hw)
> -{
> -	/* set head and tail registers in our local struct */
> -	hw->aq.asq.tail = IAVF_VF_ATQT1;
> -	hw->aq.asq.head = IAVF_VF_ATQH1;
> -	hw->aq.asq.len  = IAVF_VF_ATQLEN1;
> -	hw->aq.asq.bal  = IAVF_VF_ATQBAL1;
> -	hw->aq.asq.bah  = IAVF_VF_ATQBAH1;
> -	hw->aq.arq.tail = IAVF_VF_ARQT1;
> -	hw->aq.arq.head = IAVF_VF_ARQH1;
> -	hw->aq.arq.len  = IAVF_VF_ARQLEN1;
> -	hw->aq.arq.bal  = IAVF_VF_ARQBAL1;
> -	hw->aq.arq.bah  = IAVF_VF_ARQBAH1;
> -}
> -
>   /**
>    *  iavf_alloc_adminq_asq_ring - Allocate Admin Queue send rings
>    *  @hw: pointer to the hardware structure
> @@ -259,17 +238,17 @@ static enum iavf_status iavf_config_asq_regs(struct iavf_hw *hw)
>   	u32 reg = 0;
>   
>   	/* Clear Head and Tail */
> -	wr32(hw, hw->aq.asq.head, 0);
> -	wr32(hw, hw->aq.asq.tail, 0);
> +	wr32(hw, IAVF_VF_ATQH1, 0);
> +	wr32(hw, IAVF_VF_ATQT1, 0);
>   
>   	/* set starting point */
> -	wr32(hw, hw->aq.asq.len, (hw->aq.num_asq_entries |
> +	wr32(hw, IAVF_VF_ATQLEN1, (hw->aq.num_asq_entries |
>   				  IAVF_VF_ATQLEN1_ATQENABLE_MASK));
> -	wr32(hw, hw->aq.asq.bal, lower_32_bits(hw->aq.asq.desc_buf.pa));
> -	wr32(hw, hw->aq.asq.bah, upper_32_bits(hw->aq.asq.desc_buf.pa));
> +	wr32(hw, IAVF_VF_ATQBAL1, lower_32_bits(hw->aq.asq.desc_buf.pa));
> +	wr32(hw, IAVF_VF_ATQBAH1, upper_32_bits(hw->aq.asq.desc_buf.pa));
>   
>   	/* Check one register to verify that config was applied */
> -	reg = rd32(hw, hw->aq.asq.bal);
> +	reg = rd32(hw, IAVF_VF_ATQBAL1);
>   	if (reg != lower_32_bits(hw->aq.asq.desc_buf.pa))
>   		ret_code = IAVF_ERR_ADMIN_QUEUE_ERROR;
>   
> @@ -288,20 +267,20 @@ static enum iavf_status iavf_config_arq_regs(struct iavf_hw *hw)
>   	u32 reg = 0;
>   
>   	/* Clear Head and Tail */
> -	wr32(hw, hw->aq.arq.head, 0);
> -	wr32(hw, hw->aq.arq.tail, 0);
> +	wr32(hw, IAVF_VF_ARQH1, 0);
> +	wr32(hw, IAVF_VF_ARQT1, 0);
>   
>   	/* set starting point */
> -	wr32(hw, hw->aq.arq.len, (hw->aq.num_arq_entries |
> +	wr32(hw, IAVF_VF_ARQLEN1, (hw->aq.num_arq_entries |
>   				  IAVF_VF_ARQLEN1_ARQENABLE_MASK));
> -	wr32(hw, hw->aq.arq.bal, lower_32_bits(hw->aq.arq.desc_buf.pa));
> -	wr32(hw, hw->aq.arq.bah, upper_32_bits(hw->aq.arq.desc_buf.pa));
> +	wr32(hw, IAVF_VF_ARQBAL1, lower_32_bits(hw->aq.arq.desc_buf.pa));
> +	wr32(hw, IAVF_VF_ARQBAH1, upper_32_bits(hw->aq.arq.desc_buf.pa));
>   
>   	/* Update tail in the HW to post pre-allocated buffers */
> -	wr32(hw, hw->aq.arq.tail, hw->aq.num_arq_entries - 1);
> +	wr32(hw, IAVF_VF_ARQT1, hw->aq.num_arq_entries - 1);
>   
>   	/* Check one register to verify that config was applied */
> -	reg = rd32(hw, hw->aq.arq.bal);
> +	reg = rd32(hw, IAVF_VF_ARQBAL1);
>   	if (reg != lower_32_bits(hw->aq.arq.desc_buf.pa))
>   		ret_code = IAVF_ERR_ADMIN_QUEUE_ERROR;
>   
> @@ -455,11 +434,11 @@ static enum iavf_status iavf_shutdown_asq(struct iavf_hw *hw)
>   	}
>   
>   	/* Stop firmware AdminQ processing */
> -	wr32(hw, hw->aq.asq.head, 0);
> -	wr32(hw, hw->aq.asq.tail, 0);
> -	wr32(hw, hw->aq.asq.len, 0);
> -	wr32(hw, hw->aq.asq.bal, 0);
> -	wr32(hw, hw->aq.asq.bah, 0);
> +	wr32(hw, IAVF_VF_ATQH1, 0);
> +	wr32(hw, IAVF_VF_ATQT1, 0);
> +	wr32(hw, IAVF_VF_ATQLEN1, 0);
> +	wr32(hw, IAVF_VF_ATQBAL1, 0);
> +	wr32(hw, IAVF_VF_ATQBAH1, 0);
>   
>   	hw->aq.asq.count = 0; /* to indicate uninitialized queue */
>   
> @@ -489,11 +468,11 @@ static enum iavf_status iavf_shutdown_arq(struct iavf_hw *hw)
>   	}
>   
>   	/* Stop firmware AdminQ processing */
> -	wr32(hw, hw->aq.arq.head, 0);
> -	wr32(hw, hw->aq.arq.tail, 0);
> -	wr32(hw, hw->aq.arq.len, 0);
> -	wr32(hw, hw->aq.arq.bal, 0);
> -	wr32(hw, hw->aq.arq.bah, 0);
> +	wr32(hw, IAVF_VF_ARQH1, 0);
> +	wr32(hw, IAVF_VF_ARQT1, 0);
> +	wr32(hw, IAVF_VF_ARQLEN1, 0);
> +	wr32(hw, IAVF_VF_ARQBAL1, 0);
> +	wr32(hw, IAVF_VF_ARQBAH1, 0);
>   
>   	hw->aq.arq.count = 0; /* to indicate uninitialized queue */
>   
> @@ -529,9 +508,6 @@ enum iavf_status iavf_init_adminq(struct iavf_hw *hw)
>   		goto init_adminq_exit;
>   	}
>   
> -	/* Set up register offsets */
> -	iavf_adminq_init_regs(hw);
> -
>   	/* setup ASQ command write back timeout */
>   	hw->aq.asq_cmd_timeout = IAVF_ASQ_CMD_TIMEOUT;
>   
> @@ -587,9 +563,9 @@ static u16 iavf_clean_asq(struct iavf_hw *hw)
>   
>   	desc = IAVF_ADMINQ_DESC(*asq, ntc);
>   	details = IAVF_ADMINQ_DETAILS(*asq, ntc);
> -	while (rd32(hw, hw->aq.asq.head) != ntc) {
> +	while (rd32(hw, IAVF_VF_ATQH1) != ntc) {
>   		iavf_debug(hw, IAVF_DEBUG_AQ_MESSAGE,
> -			   "ntc %d head %d.\n", ntc, rd32(hw, hw->aq.asq.head));
> +			   "ntc %d head %d.\n", ntc, rd32(hw, IAVF_VF_ATQH1));
>   
>   		if (details->callback) {
>   			IAVF_ADMINQ_CALLBACK cb_func =
> @@ -624,7 +600,7 @@ bool iavf_asq_done(struct iavf_hw *hw)
>   	/* AQ designers suggest use of head for better
>   	 * timing reliability than DD bit
>   	 */
> -	return rd32(hw, hw->aq.asq.head) == hw->aq.asq.next_to_use;
> +	return rd32(hw, IAVF_VF_ATQH1) == hw->aq.asq.next_to_use;
>   }
>   
>   /**
> @@ -663,7 +639,7 @@ enum iavf_status iavf_asq_send_command(struct iavf_hw *hw,
>   
>   	hw->aq.asq_last_status = IAVF_AQ_RC_OK;
>   
> -	val = rd32(hw, hw->aq.asq.head);
> +	val = rd32(hw, IAVF_VF_ATQH1);
>   	if (val >= hw->aq.num_asq_entries) {
>   		iavf_debug(hw, IAVF_DEBUG_AQ_MESSAGE,
>   			   "AQTX: head overrun at %d\n", val);
> @@ -755,7 +731,7 @@ enum iavf_status iavf_asq_send_command(struct iavf_hw *hw,
>   	if (hw->aq.asq.next_to_use == hw->aq.asq.count)
>   		hw->aq.asq.next_to_use = 0;
>   	if (!details->postpone)
> -		wr32(hw, hw->aq.asq.tail, hw->aq.asq.next_to_use);
> +		wr32(hw, IAVF_VF_ATQT1, hw->aq.asq.next_to_use);
>   
>   	/* if cmd_details are not defined or async flag is not set,
>   	 * we need to wait for desc write back
> @@ -810,7 +786,7 @@ enum iavf_status iavf_asq_send_command(struct iavf_hw *hw,
>   	/* update the error if time out occurred */
>   	if ((!cmd_completed) &&
>   	    (!details->async && !details->postpone)) {
> -		if (rd32(hw, hw->aq.asq.len) & IAVF_VF_ATQLEN1_ATQCRIT_MASK) {
> +		if (rd32(hw, IAVF_VF_ATQLEN1) & IAVF_VF_ATQLEN1_ATQCRIT_MASK) {
>   			iavf_debug(hw, IAVF_DEBUG_AQ_MESSAGE,
>   				   "AQTX: AQ Critical error.\n");
>   			status = IAVF_ERR_ADMIN_QUEUE_CRITICAL_ERROR;
> @@ -878,7 +854,7 @@ enum iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
>   	}
>   
>   	/* set next_to_use to head */
> -	ntu = rd32(hw, hw->aq.arq.head) & IAVF_VF_ARQH1_ARQH_MASK;
> +	ntu = rd32(hw, IAVF_VF_ARQH1) & IAVF_VF_ARQH1_ARQH_MASK;
>   	if (ntu == ntc) {
>   		/* nothing to do - shouldn't need to update ring's values */
>   		ret_code = IAVF_ERR_ADMIN_QUEUE_NO_WORK;
> @@ -926,7 +902,7 @@ enum iavf_status iavf_clean_arq_element(struct iavf_hw *hw,
>   	desc->params.external.addr_low = cpu_to_le32(lower_32_bits(bi->pa));
>   
>   	/* set tail = the last cleaned desc index. */
> -	wr32(hw, hw->aq.arq.tail, ntc);
> +	wr32(hw, IAVF_VF_ARQT1, ntc);
>   	/* ntc is updated to tail + 1 */
>   	ntc++;
>   	if (ntc == hw->aq.num_arq_entries)
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_adminq.h b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> index 1f60518eb0e5..406506f64bdd 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf_adminq.h
> @@ -29,13 +29,6 @@ struct iavf_adminq_ring {
>   	/* used for interrupt processing */
>   	u16 next_to_use;
>   	u16 next_to_clean;
> -
> -	/* used for queue tracking */
> -	u32 head;
> -	u32 tail;
> -	u32 len;
> -	u32 bah;
> -	u32 bal;
>   };
>   
>   /* ASQ transaction details */
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_common.c b/drivers/net/ethernet/intel/iavf/iavf_common.c
> index 8091e6feca01..89d2bce529ae 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_common.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_common.c
> @@ -279,11 +279,11 @@ void iavf_debug_aq(struct iavf_hw *hw, enum iavf_debug_mask mask, void *desc,
>    **/
>   bool iavf_check_asq_alive(struct iavf_hw *hw)
>   {
> -	if (hw->aq.asq.len)
> -		return !!(rd32(hw, hw->aq.asq.len) &
> -			  IAVF_VF_ATQLEN1_ATQENABLE_MASK);
> -	else
> +	/* Check if the queue is initialized */
> +	if (!hw->aq.asq.count)
>   		return false;
> +
> +	return !!(rd32(hw, IAVF_VF_ATQLEN1) & IAVF_VF_ATQLEN1_ATQENABLE_MASK);
>   }
>   
>   /**
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 6e27b7938b8a..146755498feb 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -3253,7 +3253,7 @@ static void iavf_adminq_task(struct work_struct *work)
>   		goto freedom;
>   
>   	/* check for error indications */
> -	val = rd32(hw, hw->aq.arq.len);
> +	val = rd32(hw, IAVF_VF_ARQLEN1);
>   	if (val == 0xdeadbeef || val == 0xffffffff) /* device in reset */
>   		goto freedom;
>   	oldval = val;
> @@ -3270,9 +3270,9 @@ static void iavf_adminq_task(struct work_struct *work)
>   		val &= ~IAVF_VF_ARQLEN1_ARQCRIT_MASK;
>   	}
>   	if (oldval != val)
> -		wr32(hw, hw->aq.arq.len, val);
> +		wr32(hw, IAVF_VF_ARQLEN1, val);
>   
> -	val = rd32(hw, hw->aq.asq.len);
> +	val = rd32(hw, IAVF_VF_ATQLEN1);
>   	oldval = val;
>   	if (val & IAVF_VF_ATQLEN1_ATQVFE_MASK) {
>   		dev_info(&adapter->pdev->dev, "ASQ VF Error detected\n");
> @@ -3287,7 +3287,7 @@ static void iavf_adminq_task(struct work_struct *work)
>   		val &= ~IAVF_VF_ATQLEN1_ATQCRIT_MASK;
>   	}
>   	if (oldval != val)
> -		wr32(hw, hw->aq.asq.len, val);
> +		wr32(hw, IAVF_VF_ATQLEN1, val);
>   
>   freedom:
>   	kfree(event.msg_buf);

