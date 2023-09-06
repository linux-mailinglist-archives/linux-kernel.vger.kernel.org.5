Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFFF794071
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 17:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241736AbjIFPdm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 11:33:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230085AbjIFPdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 11:33:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33A4AE6B;
        Wed,  6 Sep 2023 08:33:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694014417; x=1725550417;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=r7BsURK9Lw1MEHX2Al0HSPl3/weZq2fh93pP8mq3Clo=;
  b=Um4+gRxzw4TxSVysyP6EOvKpFO6/JNnC30zChp7tnsAA4WtLPIpxPWeO
   dNbmwoQ5wih47WC4H6faCMfURR3plzhvUtdBdjJ5s5/gPLM4y+MwzCloL
   AXRr5K5T7WP528LJYmDNvHFlbPapP8b6xBDZNUtGM01kKh0pRFhUf4zkP
   kW/GUmvQTZcBHu9DDYA6vEquO5eNCXgPPbZPShGr7KgxBOxISAii08sZB
   5a39aCmF1JMJmjPuUGxHYcy08cNS4KWWa20G1vyyWGp7lKFYvjNlCYDNp
   ZvAQdgELhj5489FxI6d+mIVe3lx0CvwMsDhFRwVzjpr5BryhVs9PgeDzE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="463475129"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="463475129"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Sep 2023 08:33:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10825"; a="856489694"
X-IronPort-AV: E=Sophos;i="6.02,232,1688454000"; 
   d="scan'208";a="856489694"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 06 Sep 2023 08:33:22 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 6 Sep 2023 08:33:21 -0700
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 6 Sep 2023 08:33:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 6 Sep 2023 08:33:21 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 6 Sep 2023 08:33:19 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=c4/va7zqUXsmkaEv1IzrxhjacQ1G2JjiDja1vCypPyusD/RTZqEC+zej4PLBK6KZ/zjkzymdrpUp34TZm6pKf8Md8Y1SE5qrcBsgSIsHAx4WSbFm4WfDN2M0L3uBO+L0/COVzwEZz7tlsMpkX6imEOLPuhF0kMP/Jze1iw37u3+mswiavoOLyKKvNy/VLy3RMfSvCf0w4Dce61eID789JV95u4MPr+uFgi19dQnpD+YfeA4hipoZFe3MQOCd4zOV9GKp/3jkKzvJ0e3hdFLycs7+nSkM2Rye92uzdHF4kvkVfNh751e8XD/fFj2WfF830lS9Eu8ZbsP+PG5Npka+hQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pE3bU/sBjOMqzbXI0EaXBQ62tOagjzJc6ocE6lE1/j0=;
 b=kAT8dz2jbkrd8cXBj1hlfR88lAxhCN9D78egzc3Z4v2sJ3nHkTCjXRGCVlgkNRfRljjlSlZ4RfoGiAgadl4CX8Jh1tTkOvOREGsTLITrDoI5FVlekblBx7fEFHdFee61RAYrxGvNvdivJIgZElPPCub5BUvU4NWO81A8nRp09i8oTJzlNKXx07cQ0elFOjvjXRsY1Za23a6HBHwhxxOrMbH/iaWIBoyM9a44UZnboBB3T0ZrNpujHBhhh6ifZOdyxH5dI1L/4Xqgc6FVXtwtWlSBduJjeStcIODr8sMdGikFwxfXrXrjPhaC1ElZ8FjT/y5jZJCeJA6GoPMyRARlUQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SN7PR11MB7420.namprd11.prod.outlook.com (2603:10b6:806:328::20)
 by DM4PR11MB5374.namprd11.prod.outlook.com (2603:10b6:5:395::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.34; Wed, 6 Sep
 2023 15:33:09 +0000
Received: from SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0]) by SN7PR11MB7420.namprd11.prod.outlook.com
 ([fe80::3e89:54d7:2c3b:d1b0%6]) with mapi id 15.20.6745.030; Wed, 6 Sep 2023
 15:33:09 +0000
Message-ID: <bbb51ddd-ceb1-63a8-a06a-f365da5ac4b7@intel.com>
Date:   Wed, 6 Sep 2023 09:32:59 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [Intel-wired-lan] [PATCH net 1/2] iavf: add
 iavf_schedule_aq_request() helper
Content-Language: en-US
To:     Petr Oros <poros@redhat.com>, <netdev@vger.kernel.org>
CC:     <ivecera@redhat.com>, <intel-wired-lan@lists.osuosl.org>,
        <jesse.brandeburg@intel.com>, <linux-kernel@vger.kernel.org>,
        <edumazet@google.com>, <anthony.l.nguyen@intel.com>,
        <kuba@kernel.org>, <pabeni@redhat.com>, <davem@davemloft.net>
References: <20230906141411.121142-1-poros@redhat.com>
From:   Ahmed Zaki <ahmed.zaki@intel.com>
In-Reply-To: <20230906141411.121142-1-poros@redhat.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR3P281CA0188.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:a4::20) To SN7PR11MB7420.namprd11.prod.outlook.com
 (2603:10b6:806:328::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SN7PR11MB7420:EE_|DM4PR11MB5374:EE_
X-MS-Office365-Filtering-Correlation-Id: 7a86d055-7d96-4252-b41e-08dbaeee9298
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 9M1gAsK1pgblU71zZE8M8ER7JBxO4b1IWI5xyOFPpRRcdABEmD9YySYoD6tmwrS8z4udnFOkqdUOoLYxrOz/vPmUW5zo1a4JPiNWWlzWGillfrdpE/9/OkrdiSfl6rH1YjCY5uqVevIX40qJCUK1kZqckof2TswzcSkqMHuCpNM6m0OIyBghFDsCBSYVEPxWZg4ePqB/JAHbGb7wYg2k/tQEDqgobfEjpNBVPqLPcFPUeUJ2a2Q06qE6SfvuB513rUtrMyaCKcvOKgZnfjBoFESYXezGICFVhzLujcwP0vSR3PwEDHLetZoCdHFQZN6mFJlVdXdZtVN26S7piexI4QH1m6MFZfQ/r44DpO0HsGcpX+dNvjr2kOrlAjIjh9Ax+XmrnpBroLTwb5KiSNas+nHEdRnjuG7uclRkJweR7ZQV7qAlTGbpOIFxh48rPkp6g+SDU2gZYBFVPHYulsT5kQdMhTWZgRx9yV++n4dtq8iY2AZraHM++l4jMv3fOvyn9N3WLHNzzQR8RdWAkRvtjwYCYKO4WR5Z2D3tZtR/5UrVa9PS+8W6r67syqUxRngMW/Dq5SGtDieYbPkiKx0eEEMJ2cyuxaRpRuqeBWkDgG6sTcczpq2L3Uv5aTQxUFNDH0drmqfZXqL1H7HLdd4SNw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN7PR11MB7420.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(396003)(366004)(136003)(39860400002)(346002)(451199024)(1800799009)(186009)(8936002)(8676002)(478600001)(4326008)(66476007)(66556008)(66946007)(44832011)(5660300002)(83380400001)(31686004)(2906002)(41300700001)(31696002)(316002)(86362001)(6666004)(6506007)(53546011)(6486002)(6512007)(82960400001)(2616005)(26005)(38100700002)(36756003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?Z0FUSWFtY1QyU2E4RzN5Y0NsWnNMTWM2a0tlanlDUFVDMzkzVmdRMGo0Uk55?=
 =?utf-8?B?WVIybjM4ZmxTQmFWTXJPTGxDNTNoaTljcnphc0ZKcDd1Wlk4QlhLU0JTTFFC?=
 =?utf-8?B?YmJ2cy80S2t0NFlvdGZ3eDU0eHNtUEhwNjB1UE5PczlkZmp1ZG93dzZVYlp1?=
 =?utf-8?B?cTN0eDZiK0p1Vkx2WjNNM1F3T0dOTTVQU3BGc2s5OFYxUUdHV3NSN2MxaElF?=
 =?utf-8?B?Q1RpUThGVjBDYUhrTjZjckVXRHZiQTlkTmF4VUszbDE0VXFoNk8yNU5TeHFm?=
 =?utf-8?B?KzRibWhPSlhMRnZmWWNRUTk1M3pMa0pqYzVwZ3BGanEvaHRwV0xjT0UrQ3Jl?=
 =?utf-8?B?UTE0RnY4S1NjRmxMWlRhSkJ3bnFwZ0xJRGh1czNSclI4RUlGbTRxalV4cVlV?=
 =?utf-8?B?aVhZNlJXcllURENXei9tNzdXZExhTk1mbFgyZ2djN083MHRBN1ZhVG5uOWZJ?=
 =?utf-8?B?dUVONEp2RXJHOWd6YWRnakdRRGVQZUlxNXNSblc4MUx4bXlQTEdDZUYrWUZw?=
 =?utf-8?B?TWNRUzVGWkJyZGFYZ3dIYlhJQ29VY3dFM3A5aDRLaUtXdzhBaEVsb3RCWDBh?=
 =?utf-8?B?Y3BqVzhVK0QxYWN6eE8wMmJ2cU1MRGFMSUJwUXJ2WEoydEZYWDJibDdMaWpJ?=
 =?utf-8?B?RVhWaFJjenFvcXI3UE1wQXpMb292cEVHQ2JVL2xEVlRhVUJkQWJ4YWtUSGNO?=
 =?utf-8?B?eEI3YWlObThlZDd6aGNSZnpuYmlQY3kwL2FGWWtSelI4KzRNRllxZkNsREhL?=
 =?utf-8?B?SEQrWXNiUnNsQlllVkVHcTc3RU9oeHV6eFBDdmFhZGtIR1FsRzFBSE8zQlBv?=
 =?utf-8?B?bXE2L1lkNzlTcGVZYWsvck5Ha2RnaWV2VWR3NW9sZnhtdDlQNkRPRmZjaGR6?=
 =?utf-8?B?SWNnRVEwZlpXbDVzVGMzL0Mvd04yZWZrRkh5d09YTWdXbWV6U2NxeWxPK2lV?=
 =?utf-8?B?ZmtYTk9sSFZ1MmMvUHg2MjZOTTNOZUdseFhJZXdBS3F1bnN2M004elBHZm5Y?=
 =?utf-8?B?NGtlTDhpWEFDVEtoUkppWU1ON3Zqbm5yOFBjelQzOEp6aG80Tk1DZlNDOXVL?=
 =?utf-8?B?WWI0L1FySlhhR3QzSGN5aTk0b0hwaGQrZk1ibzNSNTJFOHpEVGFObWhhODZz?=
 =?utf-8?B?UHJ5UlZMZHdmVHJJcm9MMnRaUVNBUzNnWThKbkpHcjU4SC9YOGs0N00rWlZo?=
 =?utf-8?B?TEFIeGp5eEt1YUJuSFdDM2FTeGZybkZ1WFhaSDJPRk1mL1hGakxabXF6aXUy?=
 =?utf-8?B?MkV5YmJIZnNCNkJ1SUVIL2RVV0tOLzhkZVdyYUYxc0dVMXVqY0tKcjZSbXhZ?=
 =?utf-8?B?OWl4Rm9OOTVqR0xMeHR6OWM0UTVhUC9YdGFlYlVISEhXWDFFSWl4RElyd1Bo?=
 =?utf-8?B?eXNvWk9jZ1Qwem5CUlJHSVBYVE16MlZxeWJtQTNDUXpiYWtFNFd6NkxjRjZU?=
 =?utf-8?B?K0FqMStpcE9BTWllc3J5UCtPVG5xQWlObkRhZDZkV013bGl4ZWd5UDc5L3hD?=
 =?utf-8?B?Nm1sSXBlSlNabzNnT0VzcjBqMUR6UUVzeXRXSGZWRE9vb0c4NE5CWm55ZVpO?=
 =?utf-8?B?c1Rta1ViTVhsblNjVzJ2R3I5UnVYUEl1b0NkdGhZMzBSeEVKaWEreWRKN20v?=
 =?utf-8?B?bW1hTUU0VzdFendDQ1Z1bFRPRVkvQ0ZWUk05OWZIUUY2RnZMWjhBWllabFBv?=
 =?utf-8?B?NE1yRlRVNlF2RUNETFZ3SFByS1ZZNHNLTUVMK1lhSVFKTzFtSnlIRjNSSFMx?=
 =?utf-8?B?MklobnZGaVBHSGZaM1orTllRMU55bjJ1dW51cXE5WEJqVXkxWjZQQWNtZUpy?=
 =?utf-8?B?ajk5QXJJbW5YemdkSnQ0QnhXbklBM2NDR2dZV2tKMFQ2Tnd6VjdDb2ZmbUgw?=
 =?utf-8?B?YTZKbDhUR3ZrQlFSZUpqaUk5MHdOcWRNZEg2UnpzVFk2YTRkM3JKWEhwU2xC?=
 =?utf-8?B?aEJWRUNZNnRvajVHSktxY0FaMGI1eUg5K05mL3hHZjdPaE5scTVtR1VKRFdm?=
 =?utf-8?B?dFA3Mk5Sb2ZQaXlqVll0QTZxREJwVGRxSmM3SVpqalpNM3VlR1I2WmNqRWRY?=
 =?utf-8?B?M1E2bUZCazV2V1pxZWdxQllFcnU0cGFWTWw0eTBwb0ZpR2JYWFIxZ0lKNUpS?=
 =?utf-8?B?RVdOTlVjNnlqRVdpY0xwcG9ZQm9TOHZNdGRoU0x5QnpZRnFmR3FseGxSMVg0?=
 =?utf-8?B?T0E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a86d055-7d96-4252-b41e-08dbaeee9298
X-MS-Exchange-CrossTenant-AuthSource: SN7PR11MB7420.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Sep 2023 15:33:09.0402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: SmWDODkLfmHIWXPafshg1h77pXwId60XyzJ/6pus5gMt97P/+N35AKE/h+J00S+NNB485cOwMjvyGjQojO05ng==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB5374
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2023-09-06 08:14, Petr Oros wrote:
> Add helper for set iavf aq request AVF_FLAG_AQ_* and imediately
> schedule watchdog_task. Helper will be used in cases where it is
> necessary to run aq requests asap
>
> Signed-off-by: Petr Oros <poros@redhat.com>
> Co-developed-by: Michal Schmidt <mschmidt@redhat.com>
> Signed-off-by: Michal Schmidt <mschmidt@redhat.com>
> Co-developed-by: Ivan Vecera <ivecera@redhat.com>
> Signed-off-by: Ivan Vecera <ivecera@redhat.com>
> ---
>   drivers/net/ethernet/intel/iavf/iavf.h         |  2 +-
>   drivers/net/ethernet/intel/iavf/iavf_ethtool.c |  2 +-
>   drivers/net/ethernet/intel/iavf/iavf_main.c    | 10 ++++------
>   3 files changed, 6 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/net/ethernet/intel/iavf/iavf.h b/drivers/net/ethernet/intel/iavf/iavf.h
> index 85fba85fbb232b..e110ba3461857b 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf.h
> +++ b/drivers/net/ethernet/intel/iavf/iavf.h
> @@ -521,7 +521,7 @@ void iavf_down(struct iavf_adapter *adapter);
>   int iavf_process_config(struct iavf_adapter *adapter);
>   int iavf_parse_vf_resource_msg(struct iavf_adapter *adapter);
>   void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags);
> -void iavf_schedule_request_stats(struct iavf_adapter *adapter);
> +void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64 flags);
>   void iavf_schedule_finish_config(struct iavf_adapter *adapter);
>   void iavf_reset(struct iavf_adapter *adapter);
>   void iavf_set_ethtool_ops(struct net_device *netdev);
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> index a34303ad057d00..90397293525f71 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_ethtool.c
> @@ -362,7 +362,7 @@ static void iavf_get_ethtool_stats(struct net_device *netdev,
>   	unsigned int i;
>   
>   	/* Explicitly request stats refresh */
> -	iavf_schedule_request_stats(adapter);
> +	iavf_schedule_aq_request(adapter, IAVF_FLAG_AQ_REQUEST_STATS);
>   
>   	iavf_add_ethtool_stats(&data, adapter, iavf_gstrings_stats);
>   
> diff --git a/drivers/net/ethernet/intel/iavf/iavf_main.c b/drivers/net/ethernet/intel/iavf/iavf_main.c
> index 7b300c86ceda73..86d472dfdbc10c 100644
> --- a/drivers/net/ethernet/intel/iavf/iavf_main.c
> +++ b/drivers/net/ethernet/intel/iavf/iavf_main.c
> @@ -314,15 +314,13 @@ void iavf_schedule_reset(struct iavf_adapter *adapter, u64 flags)
>   }
>   
>   /**
> - * iavf_schedule_request_stats - Set the flags and schedule statistics request
> + * iavf_schedule_aq_request - Set the flags and schedule aq request
>    * @adapter: board private structure
> - *
> - * Sets IAVF_FLAG_AQ_REQUEST_STATS flag so iavf_watchdog_task() will explicitly
> - * request and refresh ethtool stats
> + * @flags: requested aq flags
>    **/
> -void iavf_schedule_request_stats(struct iavf_adapter *adapter)
> +void iavf_schedule_aq_request(struct iavf_adapter *adapter, u64 flags)
>   {
> -	adapter->aq_required |= IAVF_FLAG_AQ_REQUEST_STATS;
> +	adapter->aq_required |= flags;
>   	mod_delayed_work(adapter->wq, &adapter->watchdog_task, 0);
>   }
>   

There are other places where the helper can be used without functional 
changes, e.g. iavf_add_fdir_ethtool() , iavf_replace_primary_mac() and 
couple of other places. In all of them, mod_delayed_work() is called 
after setting the AQ flag. For the sake of consistency, can you use the 
helper there too?


Thanks,

Ahmed

