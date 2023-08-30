Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 012BA78E280
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 00:46:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbjH3Wqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 18:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344112AbjH3Wqg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 18:46:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F93ACD8;
        Wed, 30 Aug 2023 15:46:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693435578; x=1724971578;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yrirVc3btB7pWepC427XSvq12dFBJ3/+xSk3OBbi5cM=;
  b=laGCYO5a5Ki9heMiMcHbRp9G/e67MatuhUoNPuah/VigCqmOHcRFhwCc
   44UKPzik3Eq6204CW5pyC5dk+1F9onOunUx7kBG9hTAb1WBHCHImLjt/6
   v8wp7v4eBfl6elm44cJh80Ss44SZhBTaQHwwXwwkRg7fa0teTU9hBo8wr
   kM+SAhe+tpUbd3R19anxOZZQQpXjJj4zcKOESsbZQOBVLqaW5PHBnjZbx
   JzbMM2EJXwnZwnURZQJXDTTNOAc/1k5nF00+3bFsApjdQei+q7okmPOqS
   hIMonsKZpjBSC3lxloQI+at3C2qOAxH+NNM2j65NpE7XNEdlE3dHjpBfm
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="365967766"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="365967766"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 15:46:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="804715866"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="804715866"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga008.fm.intel.com with ESMTP; 30 Aug 2023 15:46:13 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 15:46:13 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Wed, 30 Aug 2023 15:46:12 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Wed, 30 Aug 2023 15:46:12 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.47) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Wed, 30 Aug 2023 15:46:12 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WquT9jB86YTk0ZYNfdN94Q5SwmXXrbMJ0+Y2d1gzNSvDZIRUi2v/TsbInUYGvuTv4ordo2rXAmSr4am2FZclNuidxhr4Fcrp5jIf4DBziNHfNf9JTcOxPi6YWRc8PJYV2Be8xCBkfyOzwviyfjgN+d0BJ45hKGppNl6OVhmuJr6ruyZnalRgkJamMNu40muajnNdW0F3wIomjiuXeOH+Xy+YAB+xxq3GY8HVsQgydI0ycOK0l17fkj4UhMxgnARBxd2MCOOd3RO1PpUV6ih9DEPjKAz7ocF1Toc5/UlYa3iNCRvKeaC4SXzKfN3Nlw+8EnTozUUnllmQjAhtOLJ0uQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tAIF8xYHf01Gig1VbpihXUb3Jwf+QneOPVYiuT7VBP4=;
 b=cXkU/SH9tR+V2Rtkup8yRz4fCx0e9iSslNBoWPpoRkXyv357j/W/11bV5ToGD5+qrgNuzjbwmAVvkGJNpiKcEY5bMuqteyGl8o4Uf3rrkIs61sFxGEPx+s4rl4EwQ09d6hLf0AQLOgFEzhYquKz+Fa3kfyQ+k5Zj9T/EHCCtwImDLLTunnqgp1sABLBedULe03SHXZrRVWCjv/Joj+uf92sKfxtL3Ntx8FaMqQaYiD8miSAQNwhC+vDq20HzhQ7hyeizRI8J2bYVyQyyVRn0KlbWEm9iIkSOiyBnET1GXO9VDK85OohsvYJWihCxFcLwGJErKLuA4y11VCN9rU9PTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by LV8PR11MB8488.namprd11.prod.outlook.com (2603:10b6:408:1e7::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6699.34; Wed, 30 Aug
 2023 22:46:05 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::9563:9642:bbde:293f%7]) with mapi id 15.20.6699.034; Wed, 30 Aug 2023
 22:46:05 +0000
Message-ID: <7e7dfcbd-22a0-c1c3-de1b-7a99edb7f22a@intel.com>
Date:   Wed, 30 Aug 2023 15:46:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH RFC v2 07/18] cxl/mem: Expose device dynamic capacity
 configuration
To:     <ira.weiny@intel.com>, Dan Williams <dan.j.williams@intel.com>
CC:     Navneet Singh <navneet.singh@intel.com>,
        Fan Ni <fan.ni@samsung.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Alison Schofield <alison.schofield@intel.com>,
        "Vishal Verma" <vishal.l.verma@intel.com>,
        <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230604-dcd-type2-upstream-v2-0-f740c47e7916@intel.com>
 <20230604-dcd-type2-upstream-v2-7-f740c47e7916@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230604-dcd-type2-upstream-v2-7-f740c47e7916@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BYAPR11CA0071.namprd11.prod.outlook.com
 (2603:10b6:a03:80::48) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|LV8PR11MB8488:EE_
X-MS-Office365-Filtering-Correlation-Id: f83fe501-e74f-47e9-8ad3-08dba9aae45b
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Wud+XaxNcKkcvatTXwzYYdtmc3rTaTA1WV/enyQFR7BofWugry6GO0yaAOYLkhXFII/NcZBxUutMr0QcdXgn5EHQmTYFqRZfHLqlWRQ7a35XIM44+3TNAquvmWwatqgknixPXPeTkGw2ZSe4VEnuh2ipKXqWmtinkS2ZTYL7vD/DMNrZawEABHMpsxXYPsNT4UAgvrU84czllYd2GdbKrQD92sm7DnNlfvnV027uJKqpDy9xROnSQvyCPCgS2K7Rv/AK/mnlsa1KvroxCySxl/gUj58LeHIWuD4VCXZCl+XnBTd8biwb21EgbnhX1v5XvP0CeX/nEiw38KA7judvgtp1LfhUyFjuiCf5HuAOwx9mrROu5TYMCv4TzCzGiRth5L2CxnbsxdqUqX9j8+IhiKZ+rWlrTnP/XmFxnl1dd8MuDcyD5/LvitL/VmxzcuC0xp6KJaI9csjEJDY52TirWe249jl1QL31qd76MAMUPaYKN3fPJSdMB9v653RC69aqerDePt4Tg7jpSmXvWz5VJAxUIgNzjXGv92ZxwyWiM8IboSf3apXC2xFBh9k+y4rVd+kbfkf6KALnrFVefN69CR2nx4h72QWV/R9GVhhazBjUREbma1+5TZSzhJLbkOfQwvXsI/FX56Dpua+vZynMjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(396003)(39860400002)(136003)(376002)(346002)(186009)(1800799009)(451199024)(6506007)(6486002)(6512007)(6666004)(53546011)(83380400001)(26005)(478600001)(6636002)(316002)(8676002)(37006003)(41300700001)(66556008)(66476007)(66946007)(8936002)(4326008)(5660300002)(54906003)(6862004)(2906002)(44832011)(36756003)(86362001)(2616005)(38100700002)(82960400001)(31696002)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TGdVMFN3Q3k5UFFHTnlnMDJWL2Y2S2c3R284NDN6clk0eEJCRE1na1JJK2JM?=
 =?utf-8?B?TGJvTllONEhQU29iaHdjZng3NFF1UXhzYnE4R2JWS3UxWkZCWkFuQW9tdmVY?=
 =?utf-8?B?ZXhkd2pGdTFBVHA2NnhZNEhobGxQWWlLNzRYMzROeTlVaU9zU3Exbm5ld1k0?=
 =?utf-8?B?Umd0QkY2eG9QTVpRa21oWjdFZ2w0Q3BVdGY1dmMzdmxMam1jODNnOEVFdjlG?=
 =?utf-8?B?VlZoVVJrQVFWcEpWR3FmUFNhcUczbkp0c0k1SkoxcFVRbjkrZ0FaVmxZK0Jm?=
 =?utf-8?B?ZWFEaXkvR1YxRi81cjRvL2I1Tkg0dCt2N1hVbmMxdXhOQXMydTV6SjhqMmZL?=
 =?utf-8?B?UzhuSmlhMlBXUCthdy9wUFgzcDVoQzBXa2Z1c3g4SVhCTjV6dzEvcnBOclNz?=
 =?utf-8?B?cXJmaHNGQ3lyRWMzeEtPMmV3N2xNa04zOWFOSmZWWXozM2xKcEk2RTBNWEZw?=
 =?utf-8?B?bDlhTXY3NmRBbCtiR0RaaERQSm5BeXBRYXZMeG4zVTJkQTVneW42MlFBTkFm?=
 =?utf-8?B?WmZnZGN3WUlXWXFEaTJaNm1mYUlBU2drZUk4Q3pmVGFsUlROVkIwbUxIT3Rl?=
 =?utf-8?B?Vyt3WHd6QWFTakVlczVoVTU5Q1o4VTlmaElDa3RUVDRNVnFPNzU5RFVTSWJY?=
 =?utf-8?B?N2wxZ1MrbS9KT2laT2x2bXZxSjBwTGJEWHhvQ1MwY1FON0JvZnBpcEluNURj?=
 =?utf-8?B?N2lWdHczK0lhNjZyd0xFdCsycmZ0RnhIYlFLZGErVlVqbE9mRjBJbWZML25W?=
 =?utf-8?B?ZGRxUlJvZzBuUEIzT2tWNXd2TGNCV2cxZ0lac3pxNjFyMGFXdjR4WVJoMEIx?=
 =?utf-8?B?Z01MdXM2ejhzbzUxNW5aV2FtRjh5YWYySHl6aWxaWlVjZ0J2RExadENSK1NZ?=
 =?utf-8?B?aGpoSVAzSG5Kek1wY1FHdjNNYTVPK2UxOVhseWRmSk5hSCtZZXA0QlE0THRn?=
 =?utf-8?B?OFdLV2JMYkJjTlF1ZTQ2dlVVc2UwWVdwcmRlNE1ZQTlOKzdiUCtYaDNsR0lM?=
 =?utf-8?B?czB3Y21Bb2UwV09FekdjMlg0eUdpeUpnUWtxNGlZVDFmdFB5bHNLeERWUjEr?=
 =?utf-8?B?aEMrMzMxQ3dMMHlIM1R3RGdFeW5JY3dIUWxyV3Y3bHNCMWVYTWtDTk5Od0lC?=
 =?utf-8?B?dm9zMnI2YXZ3WUxoeE9qV1pLajIzdmlwditDMGVQVExCNk1nY29tTUpJRnpX?=
 =?utf-8?B?RHhpUkZKTDUycE0za2Y3R01aNkRXZnNjN0NUaVNWOVVMRkF5R0F0c3JNcjZx?=
 =?utf-8?B?L3c4Mit0dm1NL0Z6eEVWQjRsRVpDWk1DOHQ4RDhtd0RzZnZxZEUzaVp0bll6?=
 =?utf-8?B?WS9JTTJ4emp6WCtyUVU1WDZJcjg0R0lwZkpUVnlsL0Jsdk9Xc2hmWmx6QnNI?=
 =?utf-8?B?d3d0czR0M2lJQVZjQzRtcnNHK2h3TlJoTEhmcW56TCtpRnZTYzJ1dGxINlRh?=
 =?utf-8?B?TkY4dlNrNmF2NzVwa1I5SXgyc0lGU2x3eWVNVmFVSlNUZ3FzVHZQR2NUV0VG?=
 =?utf-8?B?eG1kZlNXS2F6d1JxeUQ2WXNIbmNPWFNPU2VteW1WbStBLzB0amZvMDdVald3?=
 =?utf-8?B?eE8wSnZHVnhXNmZCSE1vOVA4STNUQzVDZTBvNEJsTERGd2RNNU5QWTFNV042?=
 =?utf-8?B?MFVUdC9uOHg1eDVVNlc0VHRzL0t4cUkxWGF6TGNscnJOeXhxYlQ5TUVNTTdT?=
 =?utf-8?B?alVkbkNhejhWM1JpK2tNdEFzZWlITW1ldXZPVXhCWXJPTFNKOFpCYVFsYmoz?=
 =?utf-8?B?NTVDclRxSERsMFBEU201Nm5zNXBxM3NlMVFhYktBNG5YckZQcFo2NVlYUDk2?=
 =?utf-8?B?VjkyMWdLR1FFcnhGV2F1RWJMNzFLVDdvOWl6ajZWbGFHLzZSZjNHSExVU2lI?=
 =?utf-8?B?dkJzOFZFVWZzb1czNy9vMGxHRW92NitTNjBvVXg2NHRmR2dneXRxcHMwbDdm?=
 =?utf-8?B?SmYxbkxyU3RGRUNJQ2k2WmJYUlV4MllmSkMvYXBBditRZ2NlVVNabnovMXZ0?=
 =?utf-8?B?TUI3VGhJOHl5VU5EdllMczBLY3ZvRGFid2FsVmMxMkdUTjZzZnFuQVVHNEV1?=
 =?utf-8?B?c0c4bFVBN1RwQ0M5NTYxY05LbXhWNE9TMlF6ZUtNdEZXZVVYL0ZLcHp6NTBB?=
 =?utf-8?Q?Nw5NSye9t1SrRXH3fnzs43Gjf?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f83fe501-e74f-47e9-8ad3-08dba9aae45b
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Aug 2023 22:46:05.0341
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zSnPR5wTaQhsTdWo8e9ycqPyItT02WOjoAqOGkrA2bT/naM7F1+3M3gAv9jb2q/TAE1rPbjvxJxsfgBwom8rvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8488
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/28/23 22:20, ira.weiny@intel.com wrote:
> From: Navneet Singh <navneet.singh@intel.com>
> 
> To properly configure CXL regions on Dynamic Capacity Devices (DCD),
> user space will need to know the details of the DC Regions available on
> a device.
> 
> Expose driver dynamic capacity configuration through sysfs
> attributes.
> 
> Co-developed-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Navneet Singh <navneet.singh@intel.com>
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>
> 
> ---
> Changes for v2:
> [iweiny: Rebased on latest master/type2 work]
> [iweiny: add documentation for sysfs entries]
> [iweiny: s/dc_regions_count/region_count/]
> [iweiny: s/dcY_size/regionY_size/]
> [alison: change size format to %#llx]
> [iweiny: change count format to %d]
> [iweiny: Formatting updates]
> [iweiny: Fix crash when device is not a mem device: found with cxl-test]
> ---
>   Documentation/ABI/testing/sysfs-bus-cxl | 17 ++++++++
>   drivers/cxl/core/memdev.c               | 77 +++++++++++++++++++++++++++++++++
>   2 files changed, 94 insertions(+)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-cxl b/Documentation/ABI/testing/sysfs-bus-cxl
> index 2268ffcdb604..aa65dc5b4e13 100644
> --- a/Documentation/ABI/testing/sysfs-bus-cxl
> +++ b/Documentation/ABI/testing/sysfs-bus-cxl
> @@ -37,6 +37,23 @@ Description:
>   		identically named field in the Identify Memory Device Output
>   		Payload in the CXL-2.0 specification.
>   
> +What:		/sys/bus/cxl/devices/memX/dc/region_count
> +Date:		July, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Number of Dynamic Capacity (DC) regions supported on the
> +		device.  May be 0 if the device does not support Dynamic
> +		Capacity.
> +
> +What:		/sys/bus/cxl/devices/memX/dc/regionY_size
> +Date:		July, 2023
> +KernelVersion:	v6.6
> +Contact:	linux-cxl@vger.kernel.org
> +Description:
> +		(RO) Size of the Dynamic Capacity (DC) region Y.  Only
> +		available on devices which support DC and only for those
> +		region indexes supported by the device.
>   
>   What:		/sys/bus/cxl/devices/memX/serial
>   Date:		January, 2022
> diff --git a/drivers/cxl/core/memdev.c b/drivers/cxl/core/memdev.c
> index 492486707fd0..397262e0ebd2 100644
> --- a/drivers/cxl/core/memdev.c
> +++ b/drivers/cxl/core/memdev.c
> @@ -101,6 +101,20 @@ static ssize_t pmem_size_show(struct device *dev, struct device_attribute *attr,
>   static struct device_attribute dev_attr_pmem_size =
>   	__ATTR(size, 0444, pmem_size_show, NULL);
>   
> +static ssize_t region_count_show(struct device *dev, struct device_attribute *attr,
> +				 char *buf)
> +{
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +	int len = 0;
> +
> +	len = sysfs_emit(buf, "%d\n", mds->nr_dc_region);
> +	return len;
> +}
> +
> +struct device_attribute dev_attr_region_count =
> +	__ATTR(region_count, 0444, region_count_show, NULL);
> +
>   static ssize_t serial_show(struct device *dev, struct device_attribute *attr,
>   			   char *buf)
>   {
> @@ -454,6 +468,62 @@ static struct attribute *cxl_memdev_security_attributes[] = {
>   	NULL,
>   };
>   
> +static ssize_t show_size_regionN(struct cxl_memdev *cxlmd, char *buf, int pos)
> +{
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	return sysfs_emit(buf, "%#llx\n", mds->dc_region[pos].decode_len);
> +}
> +
> +#define REGION_SIZE_ATTR_RO(n)						\
> +static ssize_t region##n##_size_show(struct device *dev,		\
> +				     struct device_attribute *attr,	\
> +				     char *buf)				\
> +{									\
> +	return show_size_regionN(to_cxl_memdev(dev), buf, (n));		\
> +}									\
> +static DEVICE_ATTR_RO(region##n##_size)
> +REGION_SIZE_ATTR_RO(0);
> +REGION_SIZE_ATTR_RO(1);
> +REGION_SIZE_ATTR_RO(2);
> +REGION_SIZE_ATTR_RO(3);
> +REGION_SIZE_ATTR_RO(4);
> +REGION_SIZE_ATTR_RO(5);
> +REGION_SIZE_ATTR_RO(6);
> +REGION_SIZE_ATTR_RO(7);
> +
> +static struct attribute *cxl_memdev_dc_attributes[] = {
> +	&dev_attr_region0_size.attr,
> +	&dev_attr_region1_size.attr,
> +	&dev_attr_region2_size.attr,
> +	&dev_attr_region3_size.attr,
> +	&dev_attr_region4_size.attr,
> +	&dev_attr_region5_size.attr,
> +	&dev_attr_region6_size.attr,
> +	&dev_attr_region7_size.attr,
> +	&dev_attr_region_count.attr,
> +	NULL,
> +};
> +
> +static umode_t cxl_dc_visible(struct kobject *kobj, struct attribute *a, int n)
> +{
> +	struct device *dev = kobj_to_dev(kobj);
> +	struct cxl_memdev *cxlmd = to_cxl_memdev(dev);
> +	struct cxl_memdev_state *mds = to_cxl_memdev_state(cxlmd->cxlds);
> +
> +	/* Not a memory device */
> +	if (!mds)
> +		return 0;
> +
> +	if (a == &dev_attr_region_count.attr)
> +		return a->mode;
> +
> +	if (n < mds->nr_dc_region)
> +		return a->mode;

I would add a comment on who you are checking against nr_dc_region to 
make it obvious.

DJ

> +
> +	return 0;
> +}
> +
>   static umode_t cxl_memdev_visible(struct kobject *kobj, struct attribute *a,
>   				  int n)
>   {
> @@ -482,11 +552,18 @@ static struct attribute_group cxl_memdev_security_attribute_group = {
>   	.attrs = cxl_memdev_security_attributes,
>   };
>   
> +static struct attribute_group cxl_memdev_dc_attribute_group = {
> +	.name = "dc",
> +	.attrs = cxl_memdev_dc_attributes,
> +	.is_visible = cxl_dc_visible,
> +};
> +
>   static const struct attribute_group *cxl_memdev_attribute_groups[] = {
>   	&cxl_memdev_attribute_group,
>   	&cxl_memdev_ram_attribute_group,
>   	&cxl_memdev_pmem_attribute_group,
>   	&cxl_memdev_security_attribute_group,
> +	&cxl_memdev_dc_attribute_group,
>   	NULL,
>   };
>   
> 
