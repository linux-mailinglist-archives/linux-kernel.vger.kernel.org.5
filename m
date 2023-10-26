Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01BEC7D8C2C
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:22:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbjJZXWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjJZXWa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:22:30 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A8A187;
        Thu, 26 Oct 2023 16:22:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698362548; x=1729898548;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=BjbRxuggZUXbRIr4e5B/Sp01fvXGCL+PzRTKzFVGl/s=;
  b=bgJ6vFYPCY1+Bo2sdOVUZIuhU+3JEIWQQCcMIoUYwZvM2hd6H8lM+ONl
   BQmJ12pLc7u9KAvGQilEjQxFQWM262wPsho9bO/S1CgQi95mnuPxfEnRK
   jXMHzy88ADhyYE2oFtoTw1X5Jeo1IlHo4maSTJGg8TyiNdHn7/sXs81Yc
   ssMh2U3joaD0CxTJ44nwwkDLoSHtTOhSbTX8Ldmsivt60c361BJmnTkWx
   DvaoQ+rURXQYAF1rUQXWXJD/6yf0JLrtUtGGn8X6xJ3z4/djgIOKxV8H/
   hUv+NfysfpCCzV5XyUJB/aDjKjT0YYygJqmU/EqNv3rZZ0t+B3OTk+qor
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="467095"
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="467095"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 16:22:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,254,1694761200"; 
   d="scan'208";a="655004"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmviesa002.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 26 Oct 2023 16:22:15 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:22:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 26 Oct 2023 16:22:26 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Thu, 26 Oct 2023 16:22:26 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (104.47.55.168)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 26 Oct 2023 16:22:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ooru6a/SCD8bNfs//VUMcBtFjIcf08QvaZlh5EYuYscPMka/eMuLNOImltA7PZKdPmSApU7xJoZnBLWHzJq8xNs2GbxB89rUk6QCGcQXXiofp/kDElFRwSFXBr4gg5q9H3mAdUQnWGIwRpt0RHJYR263TB9zNanODxmwP68A4NhHLzZX6yWb6MnJFs1a7OGY3OpC6hC9O6TD4dg7gRbVxGDxBQen/l3+oVCIWRuxK15VcY3X6iEs7AltIoeYNm7UIBE7Lmhj5YD/CEp4l9DDZC6pYUHzyemsQ2s08o76wPAZnEXFBvMtA26R6DxRFRNhkcjLvCx2ltu5j6kJ4NgqGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rhyMoh2uOsd+weC7WboUcraiS0xAzxtnin6/wuRzDxE=;
 b=LuaJXu0WUSUUf2sIo5xRS99fvNVwSsullx7HVBr1TXwvrOTa7HcH5VLXtuQn3jB5X9wWRA1xiKkJqIVZf+nmnmy0fbx2ANpGW+6EG2oKfgpmD9QIAfE7k795HLKaHJhuRAc/y4OkZjWR+n0TFhoLCPmWyJf06VmsKp49cdqGHQLCOSeAB8RsOXCHh+dwtIBsGD/otADUssr78RrjO8RJ+E5QKUghSvWk/8lbH6ylzyKVW3g2iS/i/wLS+F01N1JgCVap2W9GElflKxc48BsZglPwaojVqww+T0sSRPzaHUkrwOZ8pEfXZi7MR4oNviC3zBGC3bnL1BxHXTWskOf/Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB7385.namprd11.prod.outlook.com (2603:10b6:208:423::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.22; Thu, 26 Oct
 2023 23:22:18 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::f216:6b2b:3af0:35c1%4]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 23:22:18 +0000
Message-ID: <ba0b674f-32c5-4ded-a8aa-7d1f3d396b73@intel.com>
Date:   Thu, 26 Oct 2023 16:22:17 -0700
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 4/5] net: phy: broadcom: Add support for
 WAKE_FILTER
Content-Language: en-US
To:     Florian Fainelli <florian.fainelli@broadcom.com>,
        <netdev@vger.kernel.org>
CC:     Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Vladimir Oltean <vladimir.oltean@nxp.com>,
        "Tariq Toukan" <tariqt@nvidia.com>, Gal Pressman <gal@nvidia.com>,
        Willem de Bruijn <willemb@google.com>,
        Daniil Tatianin <d-tatianin@yandex-team.ru>,
        "Simon Horman" <horms@kernel.org>,
        Justin Chen <justin.chen@broadcom.com>,
        "Ratheesh Kannoth" <rkannoth@marvell.com>,
        Joe Damato <jdamato@fastly.com>,
        "Vincent Mailhol" <mailhol.vincent@wanadoo.fr>,
        Jiri Pirko <jiri@resnulli.us>,
        "open list" <linux-kernel@vger.kernel.org>
References: <20231026224509.112353-1-florian.fainelli@broadcom.com>
 <20231026224509.112353-5-florian.fainelli@broadcom.com>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20231026224509.112353-5-florian.fainelli@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0017.namprd21.prod.outlook.com
 (2603:10b6:302:1::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB7385:EE_
X-MS-Office365-Filtering-Correlation-Id: e3716e48-8f69-4f23-91ec-08dbd67a65af
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: h7oxyq1XRxwX4m/QB9LFJHU/AQJH/7NHEpeOAIe0HMkzWCLpEAfe2mp2OiQ27qLrycHV+b4x6WiC8FXTGow8RW36wjNpMMY36QgZSUtVCjUG5ArJhzO8pvpcZaPhNeGwVPSnPfiYuzAasShoCy2TzwCLXNumpUZqZHUpAhmj4rtNyKCI2kl2h2OHBsvJIk0Z7Ia08BMdLPSx4um6uIY0Y5wWm0v2if5Dg06b5VtSna0itAbVONGAJAItarnbuPrXRxA9/C2stuCOWzeHPiJ8UzdaGBAksIlcCu/chp5OMQ+QCYcLOVOg04VtSMu/IT5iLCvy+Z8/55WohmqwIdedMGfVe8hK6ywmX4j2k3w6VbyyMc23E+aBkMziPyHVsDPPh5ab9dnwcbeO8Hr/AW0rkgkWMkaYpmnGPaXEpNHn0lqVYGOST8PMnF8752NcYNSGi3AZPu7czlNqf2P7dEywQ+ygjKaQ889GBA+16LOamfiVmerbd/B+cG/t/hIp/licGFobqBUsXh+bC5K0gzoPjC6poOV7EQ50G910zVK3r3aO3leV7kPEVMnN7uafqdejtX/wHQ5YtxyEqfP+FT4iLuTZ2BtYjllebCD6eY/rHHJNevzkAqrC42jIq7u9EIdlXQxz9uFpsYqSyQtuGNgJOQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(396003)(366004)(376002)(346002)(39860400002)(136003)(230922051799003)(186009)(1800799009)(451199024)(64100799003)(66476007)(66556008)(66946007)(316002)(82960400001)(54906003)(31686004)(6512007)(6506007)(53546011)(478600001)(6486002)(26005)(2616005)(4326008)(8676002)(8936002)(36756003)(31696002)(86362001)(41300700001)(5660300002)(83380400001)(38100700002)(2906002)(4744005)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?VEkweHBxVm5teGVNb3ZqV2lsb3hiZitCSEZrczJRNkNnTHRZeWJkNzEwcHc1?=
 =?utf-8?B?T3hYV2pGSHE4K0RQUGlwajZLdFUvVzVVcW1Jb05FQlR6SG9rN1k1QU1OdlI2?=
 =?utf-8?B?S1NMRXF0Y2g3NXAyVmplQ1FwVHFmZlMwb2hmU25TbkhnWCtZcFI2d29SY0Ju?=
 =?utf-8?B?MkdSQlhpVUI5TEZySHhqWjhUdHUwMHRiK3liWktubUdDb09LN0ZVUUsrTTZ4?=
 =?utf-8?B?TGpFM3ptT20vNUd6YlJHZ0szUk9vcmNlNGhFUUZ2UitzRUtUM25hYjdZeUtS?=
 =?utf-8?B?K24xek9QSFRBVUtwaVltUERnbDJLZWZucVRtL2dkYXJUYzNIanZYODFsSklR?=
 =?utf-8?B?Z1hVbXZLdEFCdjJ0M1pldCtobmoreEtHRWVqcHIxc0tBeW1LOTljbUNCVXl1?=
 =?utf-8?B?VjJjdGhRa0ZRMytFbURBYi9KNnhpS0ZnOXNuUERHdjF3Q09zZzhkdUNRZFNB?=
 =?utf-8?B?c3RLbGRtTEpoS29zYkhQVlZ1am5FdXdUcVhkT09aQm02QUZhRm0wK2F2QkEv?=
 =?utf-8?B?VHZvQnNTc29xRzV2TXJ2WkpPK1QvT0RXMUdQYXBNQ0NxaXNnQlNMYjBhb0cv?=
 =?utf-8?B?OVpuNU5pbXEyV2o1NjJLMStVanhwZHNYcWVEZ1ZoZ2xqNzJ5MEZGQXZFMXh5?=
 =?utf-8?B?aVFEYmpEc3NqdFNsUFpZODV6L2dmNExHY2d2aHp0eHg2ZGRZRTAvNEJQZEt3?=
 =?utf-8?B?dFV5cElkU1hPbXpEREZ6L3ZQaGdrWUdOU0x5ODl6UktXLzJ1VjNHRStwRjZi?=
 =?utf-8?B?TDRNQis3R3IwY3hodjV6VXZVVzV1THdOTkZlczdvVWhXOTg4Z3hnaG01R2cw?=
 =?utf-8?B?azhWb2xjdXQyZWx5SlIwQmMvbjVEZUxJdFFhdTkrTVp2ckZLSzlBZU14U1or?=
 =?utf-8?B?R3NTaFhiR3JaVWRvdVJMcmtaR3lhK2lLSjNnNGVaU1FCVjZqeEp6K0ZaczBY?=
 =?utf-8?B?T3RRWHpjbVpyZERvMXo3N2F1M04xa2l5Z21heUxtTjVXakVqYUVBWWFFV0pz?=
 =?utf-8?B?OFVjdDhDZ3hwRnFudjNKNHArNGtuZXA3YzY0cTczKzV4MGhORDh5ZElnTUgz?=
 =?utf-8?B?ZnE3UXVxVENxSVlKMzJyd2taZDNyZ1hNeDBlaTJqUXR1OU5kSG1CalBNRXN5?=
 =?utf-8?B?d3hPUlJSU2RENlU0cThmY0FOOU50L1hzeTRXOU5iVzg5VVZ5Wkh6WG1tc2xN?=
 =?utf-8?B?ZGlTazlWQnZwOUsyTmU0Sk1wYm1PaWtxd2NRUnpCR2R0dTBZVU5VOTRHNE5E?=
 =?utf-8?B?eG43TzEyODFoY3FmVW1BNFFoWDYzS01oNmJLcnhVbWg0VFh4bHR2ak41V0pT?=
 =?utf-8?B?bzQ2WnU3SlloQlpRL1VYRThuUGR6STRSQmQydzNndkJUMHowbWgvdkY5SXNn?=
 =?utf-8?B?emF4SWd5Vzl4aWVNWXIvMWY2eko4bXRKTVZLeXJSVFppRlRRTmhUNWdndU1i?=
 =?utf-8?B?TWFkQ253ejUrWEFSNHVNc1BUa0JIcTJOd25KMkhscGo4S0RrKzlybnl5QjFZ?=
 =?utf-8?B?dEd6THdyWko1M1hwQVhlUno1cWQ1REJKV1k4SUtHVHBiUkNmbUhGMjY3Y2Yx?=
 =?utf-8?B?WFlxakVXL3dLRDVMWHJKdWV4UDlTZVVYUzIyZzR6N2R2ejBSOTBOMDl1RGds?=
 =?utf-8?B?dnZWcGlxTHhvSDM4Nkl1TTdxZXFtcHZvVjdRN25BbkdNczNJVDF3eGZKY3hW?=
 =?utf-8?B?RnFVczRtUnlRUWozOC8wcWxQWEtPUGNCbFJTaXp0Y1B0K1V1aGVvcTdPcngv?=
 =?utf-8?B?MHphaXdJMUFNa1RrVDFlUzM1QVBFellxVjRLS25Bd0pVNDFPQ2lLelVaNHg5?=
 =?utf-8?B?MGZHaWFtM2VlMU1aenlqK1ZaRXVUWEdWU1M4MnJqaTV4WUZMKythMVBpOThS?=
 =?utf-8?B?aFV4cHk3aGdyUm1RK05iT1EwQXk5Y20wY05kcXVrSGx1UE9PeCtQL0h2NTZs?=
 =?utf-8?B?VlZoZ1kyZFdrUkRtRjE5NVp6Z1B4a1ZNdWlCbjZvbEdXTmlsMVBKc2haTTRj?=
 =?utf-8?B?VXVrb0cyWWg2YW5kSjROWlBzRWJldkc2cFZXVWhzQjh0dERKNXRrTjBMQ2Jy?=
 =?utf-8?B?cVBSMC9qRmthaGRPNDBwak5aMTE4Nk96dFVGdk1GMHQyY1d2emZ5QmVJa0VK?=
 =?utf-8?B?WndQNGFEWjlJVkpmUnplZmxDWm1TWGFta1ErOG16cmN2Ym9DVDE0alFCV0t0?=
 =?utf-8?B?aHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e3716e48-8f69-4f23-91ec-08dbd67a65af
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 23:22:18.4284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zeBNmwF+DFC6RX1ly2xpH9dj9rcK0E9qF9QcaN7lY8xAzBUBCSCUHCUAGetBx87w8HuO4xXedvMfvL3K+N2dMHQw3nspd7q8C5MvodZckzo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB7385
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/26/2023 3:45 PM, Florian Fainelli wrote:
> Since the PHY is capable of matching any arbitrary Ethernet MAC
> destination as a programmable wake-up pattern, add support for doing
> that using the WAKE_FILTER and ethtool::rxnfc API. For instance, in
> order to wake-up from the Ethernet MAC address corresponding to the IPv4
> multicast IP address of 224.0.0.251 (e.g.: multicast DNS), one could do:
> 
>   ethtool -N eth0 flow-type ether dst 01:00:5e:00:00:fb loc 0 action -2
>   ethtool -n eth0
>   Total 1 rules
> 
>   Filter: 0
>           Flow Type: Raw Ethernet
>           Src MAC addr: 00:00:00:00:00:00 mask: FF:FF:FF:FF:FF:FF
>           Dest MAC addr: 01:00:5E:00:00:FB mask: 00:00:00:00:00:00
>           Ethertype: 0x0 mask: 0xFFFF
>           Action: Wake-on-LAN
>   ethtool -s eth0 wol f
> 
> Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
> ---

Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
