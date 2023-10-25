Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218B07D6CDA
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 15:15:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbjJYNOt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 09:14:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234967AbjJYNOr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 09:14:47 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A44F12F;
        Wed, 25 Oct 2023 06:14:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698239686; x=1729775686;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=MmHp/FqCRi2labE9naDPRt9cTmWCDIW+XHuza7qUgb8=;
  b=QHmF5RNbcCMPSr7rPX2txe+mStsCEUAJ0CuS52Mialub2ZTY3rDP8T1T
   aw0emdFIQOv85oF36c8YARQ2qg/MoSf+njrAfH/+6drps3O/QiH4vt2w+
   Tn4EKoBWu9pTksgboRKZvGmp8rvVcaTkAncbhrpIhLuW7FoRtyqCNZ/EA
   bLyThDaAZoKj6sMW75S4AwAPTRf6JLU4dY13/8l4Q/x6O4LS2npjrf/VR
   LsqonjqDTelWVrQlpp5uhjRrvOy22/7ywOvqP0kbUJoS1M3tAqSi0jmt3
   bn46Z9YhKm5wVKW1cohs+HGB+J0+lcASZ5hwCVxUrBQHMl8MrBLr2PdtI
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="384514240"
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="384514240"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2023 06:14:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,250,1694761200"; 
   d="scan'208";a="89020"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by orviesa002.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 25 Oct 2023 06:14:11 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 25 Oct 2023 06:14:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 25 Oct 2023 06:14:44 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 25 Oct 2023 06:14:44 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (104.47.57.168)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 25 Oct 2023 06:14:44 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ibcpin87W0avR7T9LmYkMwgkpkm0ZhohxKTB9CksZ6fe1l2U8++0oXbszYR8uoZNs1BI88a+NvN8MwgEo39iAQKeexqATPAP2iMoo1akJmQYfdxuHkDJYKARfDWcRg2jibQ4QhMTGtz1yhbpObOUePC5Oo/+Pl8HH5RnxW1LUJFpsuwIstcWSbVxZ42xUTMCi9HqUHuPfvsCxu233C17t5a45U8C1OnO/B3ugxXLZ/VbO5RWeK63oXMvZWDnV8tB+fve72WTqAmAAq3QBkfm9w2hJl1e7hJ/3/l4b0CTgwx/THaPLmh4ij8relVLa+RSUseHAKI7MH5kGsNQHEM2Nw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o+MFktwB3vX4fL1jEGjzwRD/DT8JiQbPwrTQXO53Cj4=;
 b=cMm2LG2UsItwmz86z1MUqg6JXc52ev3xgAeEWNuhhwBqXckOmF6gICLXkoUtmPLSxO83bjbTKS5ci+Lyj1DyhoaWSktNiy/gWklAZjaGn93PYavjhuOylDFNSO68JTauQQFuBEHHidGL3Bqom1oFTIlvjymmqT2GFul+zBpQw2yTk8zOiz/1L81k8pgBxA+CeDvwtSIvTLhGi2ELyH7Y3H2fnl+QAdgl8sqwzWyHYyB2vOtCB9M7lnycqfofJP72BBLp31r1eJmZMdqYHhdqUOtL23jQPXNo3sG7Mp8l/TXWWDJNNmETZTffxa/VJM0ou9yiiwlQq32fPXb+1vPFHA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3672.namprd11.prod.outlook.com (2603:10b6:a03:fa::30)
 by SJ0PR11MB5772.namprd11.prod.outlook.com (2603:10b6:a03:422::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.21; Wed, 25 Oct
 2023 13:14:43 +0000
Received: from BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48]) by BYAPR11MB3672.namprd11.prod.outlook.com
 ([fe80::7666:c666:e6b6:6e48%4]) with mapi id 15.20.6907.021; Wed, 25 Oct 2023
 13:14:43 +0000
Message-ID: <f7e712a2-a0d0-f1e1-b6dc-7c41c1ef3d86@intel.com>
Date:   Wed, 25 Oct 2023 15:14:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH net-next] bareudp: use ports to lookup route
To:     Beniamino Galvani <b.galvani@gmail.com>, <netdev@vger.kernel.org>
CC:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        <linux-kernel@vger.kernel.org>
References: <20231025094441.417464-1-b.galvani@gmail.com>
Content-Language: en-US
From:   Przemek Kitszel <przemyslaw.kitszel@intel.com>
In-Reply-To: <20231025094441.417464-1-b.galvani@gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: FR4P281CA0416.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:d0::19) To BYAPR11MB3672.namprd11.prod.outlook.com
 (2603:10b6:a03:fa::30)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BYAPR11MB3672:EE_|SJ0PR11MB5772:EE_
X-MS-Office365-Filtering-Correlation-Id: 193502f2-a0be-4af6-f5e2-08dbd55c5a28
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: gSpVlcqKCJZTvsXb5G1hhSchgcVfvYPgyucP4EE1NQNnFXK9gEGgEb/GtjUdQ6eC46Eprc/CSyi9U2ba4/wKBs9tsNyKycV/vb8j+qCQ5BYe6VYLSURwW3W/iteHfhoQRUuKAW7Cszip2oDvOKPNi5drcxUN7kVFD8w8CmcAqW97GqvYwFv5BpwBDlS2Bou06IyILb5R4PTF3+ivkAVBFKF8EUEW/zF6YSnufGE2pBzBCC98nEX4Kub8Ltt+zGdb/sAppQamMsJ1Oe0WKHn3DYOIhbebIt9mWaaye9kvWqYowogrTrDbT79VsrzB19jj7SbANHdh0o13s8fpE4a9eXkMFPbqFyHuzFNkJ3tbbmo83Jimqm54YsG2/FLNJ3BXZdsiMBgVx6/ACZxt0f+DbBCL1Yhv4jBKYOqWQ+VNYichJnz3tzZ6dRxSi0DVSS2Ei8DCxczBNEmJUJNaHKdqJaf69Xd9hDKVDmOu3VuUtqmp/2dWgTJQ5GJMxNpLa48xwEgKACYLIl2+meFEAJpekgQ7AKJDV4qQaLCTnX+JYKSTNTsb1qEnRBvAr8RUsMK+x3AThaNTPnjHYy1hboTZ1GNnCsV2NcI+8xtxVMxsqwdio0XWyLqpOmF6YOYMdfkmbmcVwAhXV8GsLmVdhS+R0Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3672.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(39860400002)(346002)(136003)(366004)(396003)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(6506007)(36756003)(316002)(38100700002)(53546011)(6666004)(31696002)(41300700001)(4744005)(2616005)(2906002)(4326008)(31686004)(66556008)(54906003)(66476007)(66946007)(5660300002)(8676002)(6512007)(26005)(478600001)(86362001)(8936002)(6486002)(82960400001)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?K29wODZmNGZIYTR2ajQ3aWRmZWxyUWNQeW1RaHJaNGV2N0trWVlJQVpCcWo4?=
 =?utf-8?B?L2toZW01S3lmZ05ldFlSaGRlV3U3L0pVMXFZbTUyc0NEQUQ0b0syRkVaeWpN?=
 =?utf-8?B?S2RodHo5eVRGWks2UGpQc0k4Tjl1d25LYjAwemVESkJpdWFQN0tBbkxvNzdr?=
 =?utf-8?B?WWFjKzJxeU1yeXh3L1ZDekxvWUNDeWt2VmJEd1NwanYvLzduWWdzL0N1VkRN?=
 =?utf-8?B?SEdqNlpEc3Z3NGR4ZkF5OWtXcGdNWEQ2V292dW9relpPd1lrZ3BTcVF3RHQ5?=
 =?utf-8?B?UEd1R1psT2ZRL3NmT2dvaDFNeEcySFBCMzZ1NTlGMlJEbGFPTGIzeERlYVRo?=
 =?utf-8?B?eWdjNEMzMUxIYWExcVJzRDhDeUR1ektkRjlCc0hhYitkLy8vY0ZPc3gvRmR4?=
 =?utf-8?B?WGg1U0F6R292Z1IzY0lnVGo0VVlQa3VnTXFoQTdxZGZmMnBnMlRLb25nYk5Y?=
 =?utf-8?B?eWhtcG1JL1psUngvYnN3ZFltVnRGZGFMYWFOOHNQbVdwRzA4TkQwcWlXaFhO?=
 =?utf-8?B?cy9SdlRtYXI1Mlh6RERRTDRCWEwrbHNwWEYxNjIzVjVMTDVkMG80b1J1a056?=
 =?utf-8?B?Y0krcTVmbXJNL3lBdEFRbFNGMmJ0V2hoaXZuNDdrRmNzY21tOTc1SmhML0JU?=
 =?utf-8?B?bUJkQ2RTRGJjMmkvOEVJR25iMmtPRXNleWdKN0RKdlN1VFphOGo5V1V2TTl2?=
 =?utf-8?B?MGtUTnRXQmhUYkxxOTROZ25jZ05GMnFidEZyTW5UbFI2Zm5XTUx0TEJYRS8z?=
 =?utf-8?B?WGRaa0h0Y1ZEeFp2YmZic21TaGxHcHIzcEtYaUh1RjVGbER6aG9FRytoa256?=
 =?utf-8?B?b0dLUHhORE5mNXBvcDUvZHR6REo3V1BlWW9vUlJ0aGdibm9WT2s4ejFDOGxk?=
 =?utf-8?B?d20yc1d1dVlucnRtMHNjVWIwTTdtd3R0K0h4RWVHSXNQYURyZTUva3lTMnp3?=
 =?utf-8?B?NzJkNUhFeUUvZ1NkU25hdHRFMVlqRFNZMmJFOFJqaGZYQitGOUtNMkkyNUZq?=
 =?utf-8?B?OVVYU3VUbVZ2TG93Ym1zWHhtV3hwM2xrOWhuaGpFMjlreDdzM0lEUjJSZGoy?=
 =?utf-8?B?dW1lNlZGcE9PeGEvMWlBSXNTL2c5ZEpFb3BZOG9uL2k2dTh5YUl0WVZvSk4x?=
 =?utf-8?B?bGxUcEZPSmxVdUhpMG5zQVBKV2gyN210QzVkL3kxNXBiZkJDVGoxN2tkN1JM?=
 =?utf-8?B?R3kxLzlLVThCTE54WS9TcVZ5MSs1aDVXa3JETFJvd21jdldvU1U4dFozV0pK?=
 =?utf-8?B?Yzg1ek5VemZzNnorMVFsZXNpQXdMdFEybUtvaVFKZ2FzYXRiNm9QZXc1aHZ3?=
 =?utf-8?B?Q0NaSFdBamZPMnJNN215V2c0bDlLZ2dhSVhmOENIcTI0MDlaME1kRFFsMlN2?=
 =?utf-8?B?T0c0WDZvWGt2WkNJYWt3ZWFGWXBQckQ4eWQ5MC9ncy9LSEYrdWgzVHMvK1NZ?=
 =?utf-8?B?SzhsZFVSQXZ6U0QrS1VyN21PSXlVRFVka1FNWGN1TDVpdXl2d1VVWnJtWDFi?=
 =?utf-8?B?RVpsdmZaaG9rSlNMWjY1czBLcUZKOWxMTElQVXgvQUZmNDVxUi9KNTNPbi9a?=
 =?utf-8?B?L0o3S0lVaHhsZ1B4TGt4YnBZS1VVbk92dDFFSWR5WXp3VXdDUDRVQ1VSQ2lU?=
 =?utf-8?B?ZUdyMzY2T3I1bEdXTHJQelRkNVFnaDdjTzV0Yy9lWjhrd2VyMmh1QjZsOHRa?=
 =?utf-8?B?RnBCbnZxSjh5SVllejhKVXNRM0kxQ3BUSTRGcVd1Z0hOZjZDS1BrWWM2cWRX?=
 =?utf-8?B?RDhZOCs0dkk5VWsrZ1dGTWQ2UFZKOFRGUHREaXRpb3JoYnYxN3lWVFJCZW9G?=
 =?utf-8?B?MHc4V2k5UHFEU1JualFDd25ldE9VZmd3V3BwSGJ3bGNHRFFlZ002aC9IS21y?=
 =?utf-8?B?eXNrdW5pNUFJZ3pTNTlUZFQ0RThmWEJaMlZTSE45N1JtdE8zQzYweTdGaGFi?=
 =?utf-8?B?YU5PMWJwOVVhZ05hNy9LNzNLRGp2MmRjTTFNR2F0Lys1Um1wZU9MVGh1dFQ1?=
 =?utf-8?B?QTNFb0pvc2FESHIvVTVrOSs4bkxaU0ltc2QvRWo3RlllTGtMZVBVdnZMYm15?=
 =?utf-8?B?alVTYW02WlZWNkdxKzhYbXFZaXhkWXQzK0lvc3pnK3NSR1VBaG5SM1R3d3dQ?=
 =?utf-8?B?VjlQZnBqcFdXdnVZTE01K040MnhzYWEzbC8vNDJDdnRVU3hTbjZUNUZTYTRt?=
 =?utf-8?B?ekE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 193502f2-a0be-4af6-f5e2-08dbd55c5a28
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3672.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Oct 2023 13:14:43.2810
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vxZ7l0oKG3IyRa6RbPSrFH0UwKWPqcIgXSkHWCUMX91b1tmfbis61RzF4pL4oIc4+a28U5ImYXVWkeoNm7TGUsThXvWIPMad07iS6qKX4vE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5772
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/23 11:44, Beniamino Galvani wrote:
> The source and destination ports should be taken into account when
> determining the route destination; they can affect the result, for
> example in case there are routing rules defined.
> 
> Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
> ---
>   drivers/net/bareudp.c | 29 ++++++++++++++++-------------
>   1 file changed, 16 insertions(+), 13 deletions(-)
> 

Good, steady work!

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>

