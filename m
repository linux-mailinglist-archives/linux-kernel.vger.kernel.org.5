Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C37BC774C83
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 23:10:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236057AbjHHVKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 17:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235971AbjHHVKW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 17:10:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C678573F2;
        Tue,  8 Aug 2023 13:56:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691528212; x=1723064212;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=jDZOsdbuocTPvkIch27NHSH738NdS/PMdNrp2eskZhs=;
  b=EJlSBp0+O2ttq0RyyaSzWg38tFHJedswdQd5DoVuMnS+gPVcPMBH79Tm
   NX2Ag6oisCcNKBsE8pxHf/eF+HD8vyOCjiGSLS0NsnSgod0ReHFhYkk9+
   uulutB7cH+uGguqwWOMTfMqN7fiaiDswIbS8mAPfLoXiZb6hUsKP3F8J7
   noL7dNHTSZog1R0xnDv3ofE3okQrB5IRAnMbQvXxArrZ+GNam3dtTzz5p
   XSw9r2Wf7BNy2HiKr93oQhmdTdrAqo6K4lfLJfy2Rdbl28NyGdfQmcvN0
   D72TpGeaCvFkpbmS0PMw9+M39MQj8QnSApA+TNGa1cKsqtTskSLPJQRLN
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="351260821"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="351260821"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 13:56:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="801472685"
X-IronPort-AV: E=Sophos;i="6.01,157,1684825200"; 
   d="scan'208";a="801472685"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2023 13:56:32 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 13:56:31 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 8 Aug 2023 13:56:31 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 8 Aug 2023 13:56:31 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 8 Aug 2023 13:56:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ZNlf58GgV5I7/P8PCqXcYU6ncQBe12RW4OfI1y+d2NJz2XqWyzOw2H0iVKHUtl2wgiQOQBzqCGXiz3NOeYkuODnjIhHBeUHjtEvIta1e8xDuNEYwiuIT/tjIykEOQ7IRdqlUmGhCjVgR2ffpQFfxCO/lvZ/4QHxQRC4PNLlsVeqe1D+wegLa0uEAqpjYmpYmFqYf6XheVtzo+ZnFcbOgC8BIZoXLVTZq9w87HGS0vSGJvidcvYgSMRSheadv5JSI3NEsn0C075KY1LtS2jHaxYKiZUK1vRimlldOeJdoZ37EbUrs9yCqIXy98MqMcC/E+IbfsmtO+96BYyNuFHEGLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d8gL1xRhNm++te8tiL3HxkhZo6NQh7H8rNQEzUtQjrw=;
 b=ljQL/z6xEKPlcQhKPBqoWaTpIsyZTV4/yLL8xmeAVLkWp2WgoYcd+Kw6JXT2OQ321SJVjNx6nUYyo2kETgeEYxUuWGa5C3h8ke/x/ICHDYYhNhG+tjig062DpC8TgubO12yk9iahg/K9VOHC+QGxLHcxKt/I9zY7HTeklBa7yNBnTUaky8mmYDroHJ/RYmV4xxkX3+OkHJpD7Vf7EPh9BH0qpQmcmdvjizQO41aprAPctJLcA1N1ttvHDOBNIoaQ4+/aLF+t8ZDc1JOeRIJ/YnpGDA5WxB2woM5Jy+Fv0Q/oWEt+E5mIJjnpDKDt8S0Rz80uMeZwEu344HRuQlqaaA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by CH0PR11MB5507.namprd11.prod.outlook.com (2603:10b6:610:d6::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6652.27; Tue, 8 Aug
 2023 20:56:27 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::cc0d:5933:ecba:1df3]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::cc0d:5933:ecba:1df3%6]) with mapi id 15.20.6652.026; Tue, 8 Aug 2023
 20:56:27 +0000
Message-ID: <fb0c1111-83af-4dc4-047f-dfab7a125e2c@intel.com>
Date:   Tue, 8 Aug 2023 22:56:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [Intel-wired-lan] [PATCH net 0/2] Fix VF to VM attach detach
Content-Language: en-US
To:     Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC:     <slawomirx.laba@intel.com>, <przemyslawx.patynowski@intel.com>,
        <kamil.maziarz@intel.com>, <jesse.brandeburg@intel.com>,
        <norbertx.zulinski@intel.com>, <dawidx.wesierski@intel.com>,
        <edumazet@google.com>, <anthony.l.nguyen@intel.com>,
        <intel-wired-lan@lists.osuosl.org>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <davem@davemloft.net>,
        <linux-kernel@vger.kernel.org>
References: <20230807094831.696626-1-poros@redhat.com>
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20230807094831.696626-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FRYP281CA0004.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::14)
 To BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|CH0PR11MB5507:EE_
X-MS-Office365-Filtering-Correlation-Id: a206469f-4d43-4f20-aebb-08db9851eec7
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ySQLSl0hd0rriHjKzj9i6tAq8jj4K/kmQ10nscWwfojUxTIunpm9pd10IJi0mfkkccfzstK8mFaQO1IeWBuohzG3ZqtvyeOv5OPV89uZ4Cq3i6HsCUu0czSxhELUsAul+U08id1F4hsLBmkTnAzMyzv30wsg6Zjd+tf1oYo0WTjYqvPfJ/RlAjByfKgSjZMXfbbmltE433j/OmDVjq58XlTJ1emBfkAC1MfRC44wjQ1NkHN0HV2qvYwfHCYkWAqm8Fs1mNEC5tzbXyaTq9UwDfT8XoxO8okfBOV1J+7OD1kR815Gx70zmEl5Tu26Ckg5t/mZNVZ06e4njl2nHJ5Bng/VcsfYbZpSKFY7fYKTAI4NKTb9ywXtdhWc2KeJc1beuAoDwrimZlTJULJBPU4n18QICghNRNKSziioYI7GX0NzaGNnJ/+J5s4rx/FwWul7yw60cMFctlg0gIUST70IL9OfXfW9D+TIwBGsQWnkVKZRKGg4lzjkrjOHeh8B7FWs4hOTbUbiMvfDYKSMojsL6HS/Al/AMzeG2HmwzHeHByhANiUff7pUKl3SmXegezTA+z5eh1YCnWRWKBnIRXwT8jPukkKEIfoOfqUjKL77MjeN5z2lhCwNEQqTOvR3ymbII/Z+lxiKBKJdU5+XRMGFtw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(39860400002)(396003)(136003)(376002)(1800799003)(186006)(451199021)(2616005)(53546011)(36756003)(6506007)(26005)(6486002)(6512007)(6666004)(478600001)(31686004)(82960400001)(38100700002)(66946007)(66476007)(66556008)(4326008)(316002)(41300700001)(8676002)(5660300002)(8936002)(4744005)(2906002)(83380400001)(86362001)(31696002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Rk9PRHpFZ3JmRmFKQXFWME9ER0R4Q29Qa0VUTG83QktoK0hKOUxHOGdRaU9T?=
 =?utf-8?B?aGdEM2FaNWE3YVREYXU5RG1NLzNKRmFxUy9sY1VsdVNTdEJxbnAxYm16dE5t?=
 =?utf-8?B?dzk3a3dRakMybm5NWkZsbk9EWHZnbjQvWEtQVU9DaEhvbElxL1c5eENqaklB?=
 =?utf-8?B?K3l3a2pPY2krS2w5dDlqNGhYQ1IvVDltUlZBa2RpNHlrS25nRWM1VDlYL3J4?=
 =?utf-8?B?azM4YmJkSGU0WkVRdzZsMVZEaUx6bXh5aEVTQUhGaGxZUlRlR0xwTDJKZnVP?=
 =?utf-8?B?TTkrMGZsTEQvZ2dxUEE2dUNOamJ2S1R6YUJBM2hsd1lNM01LQTRKbDNOWnBL?=
 =?utf-8?B?YXg4TTlHTldEVjc1OFphZkx1djM5ZGNoS0NTMDdHeDFRc0pDWEZNSTBjb24v?=
 =?utf-8?B?UU95VVU4WEREa2dJcU5TdXR5RTdOK2NZbnZtMUFEaE5KWk9YNVVRRkFWaHZm?=
 =?utf-8?B?TmRmVnZlM3FKamJYeFVqWGxpU2Z0OGJJUzhVdlNoKzJqZm9DbFVBT0g5eVlq?=
 =?utf-8?B?ckNaT3lCSmNxZTBJZkZaMkxDeDNnb2Y2YW94UHpLUmRjT245c2JCR0FxK3A2?=
 =?utf-8?B?VTVlbWJXTlNpSTJnMkNzOHU0WmhYWXpxUzRUOHkxaGNWdmcwQ0ZMVzhkSXlP?=
 =?utf-8?B?M012RWNmUWpRcEJReEtqS0JuNFdZRGIycjJLcjRra3NUbEcrTnM3MDZFOEZl?=
 =?utf-8?B?Mno0bktlUGp5THpBdDViTmF3MnU4cDYybjhFOFM0V3FKengwb1dHOHVCNGR5?=
 =?utf-8?B?S01ob0ROQ1FGSHZSUmk2RHVsWnMrSUVEdEFYK1ZSeU9kSEc5SDdGRFFjZmpV?=
 =?utf-8?B?Rzlmbi8xYWhOOWZnYkUwb053VjlxWGxWSHNtUGZmbW5ZTURyUDR4RU5nT20r?=
 =?utf-8?B?OERLbjdUR0I0YUkyL3RiQzlLOXgrb3dMY2NTbllLRHpnK2ZEdmdRZGRHejhi?=
 =?utf-8?B?THRBdnkyY0FmL2dLSXNWSTBROXlyVDlGV0FMY3p4NlRhM1M0VitSUjZ6Rllm?=
 =?utf-8?B?YStnMjh3a0xYaFdlSmdnN24zYnFkazQ4NVZaYWhrZWZReEZRbm5ndVl5MVdT?=
 =?utf-8?B?NVZTUXdsZkdnYnVBWm9jT3pqVjNaZERERXNPVVNLbDlKeGgvWFYxclFQSXNl?=
 =?utf-8?B?SVpJNUNnbTVTTDYzYllNTU5yYWp0bGR1NHRvN25pQkdIU2RqR0hGZnhjWjNE?=
 =?utf-8?B?YjJZY1ViOUtZRk9wZ0RiaURxRWJQemhRWFRGTGxUcForUDI2elYrUjJrSEhX?=
 =?utf-8?B?QklEblBMbFVyaHlDU3ZmK0c4ZXNsL1NaZXBsUXhBK3YwZHNHSEVVRytVQ05H?=
 =?utf-8?B?VEJVT2VGaUJtUHdvQ1k5cm9oNGlpTHVFMU5MN0t6d3E2Y1VvUnhUZWhoTWli?=
 =?utf-8?B?dnQ3ZUtDUFZvbEppbjBTZ2hQcXlFdzNPeHZ0TE84dkpJS0FCd1pGV3VzNjBW?=
 =?utf-8?B?MVdmVWZyVDFBdEJxdWluMlROTVF1QXlMbzVobmFIOHZmUUpFNXFIVEZXVXhv?=
 =?utf-8?B?YkRVSm1EV0lMNTU0blVtUWY3OUREbUcveHJYTFRMc1QwSkZ6dEJoQldMSVV5?=
 =?utf-8?B?VmhSRlpsUDA3d25pVTFOaEtLVnB6M3BJeGNQakUvdE1iRUhOVURvc3dOa01k?=
 =?utf-8?B?NVIyY3pRMWVBZTVYcWd4TEtHYjBlTy9BNU1FM1F6MDdLdWE2NDU4dXVKVktn?=
 =?utf-8?B?bzQxRDZHc2pRODI0MnM4bXo5UzZXa1BEU3lJc3NHUWw1T2FjUXlCYk1Jb0pS?=
 =?utf-8?B?SHU5bkwwYXk0ODJFbTE0c24zV2FCWG9LVlRPb3RFNTQyNXJyR0tEbFZaMThP?=
 =?utf-8?B?MnI3UjFkeWJZQ2I4ZzB5aVVNVVVBNVFLdVZMbjZsekxuSGlKUU0xdS8yWXBF?=
 =?utf-8?B?dW13aC95Q1hjdlh4SUpoeXJMcS9NVTBUTmJ0OW9RbHQxREd0ZzI2SjhZaVU3?=
 =?utf-8?B?SkdPeFMwNUNrMWR0cDJRWC9KUzBkcjlEOWdsR3UvWHZYWm1FVVFHVkNWNnpX?=
 =?utf-8?B?cTRjTnMxV1g2czg1RlNBQ3VmR0VpWE9KNDNaa21xdG94bnRDODBCWSthcVJK?=
 =?utf-8?B?b0FrTVVnYy9QbFJJdURNTy9CaVVHZWpvNmFTcUNyOTIxV2tTejFtVmJZMXFW?=
 =?utf-8?B?Z0R1c2h0aVFpMm9CNFVYZHNTNnlDNmtSZXhCcmxHSmtMRzlHY1lyMFMwV0Nh?=
 =?utf-8?B?Nmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: a206469f-4d43-4f20-aebb-08db9851eec7
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Aug 2023 20:56:27.1725
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: j5L+ywHBSb7r4gPCxqrOPRu08xurJYzcRLVDHLXRH0YOya8ZmBaLVx6z/w6ZP22+LW/QpAvEHFuY0asDVpJVtTOwdzF8OrLnan07F1m+1i4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5507
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/7/23 11:48, Petr Oros wrote:
> Petr Oros (2):
>    Revert "ice: Fix ice VF reset during iavf initialization"
>    ice: Fix NULL pointer deref during VF reset
> 
>   drivers/net/ethernet/intel/ice/ice_sriov.c    |  8 ++---
>   drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 34 +++++--------------
>   drivers/net/ethernet/intel/ice/ice_vf_lib.h   |  1 -
>   drivers/net/ethernet/intel/ice/ice_virtchnl.c |  1 -
>   4 files changed, 12 insertions(+), 32 deletions(-)
> 

There were 3 typos reported, but this series is good anyway

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
