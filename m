Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC9D769F53
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233224AbjGaRVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbjGaRUt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:20:49 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B415B0;
        Mon, 31 Jul 2023 10:20:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690824040; x=1722360040;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=AaN7ojWBiQ/jkf9hqfWhlqDy2x0utUDscL47ZMjm3Wk=;
  b=CuZCTSiAAsjtk/RX+aMxdYyYhZJu/bEN6xko1w8pHv01paYZQI8Wmi0v
   NlCoYgBSnkA7Z/o0lipgGWcdPpAOo2RMWn2RUisP5BUk3wiI+sGHSC52I
   JaAy+33wHCT7qSkTLd9ITVKyX8qQY5pvRUQoTg/NareFQi90lX8j/8lW4
   tmrTkUXbXnIqN3etuUlljYFyFYLtHAEEhRZ2Rm59njJ9P8eNPD9XLujVI
   goTR1h5i2l36skasnMSlbDtW5UoRfBaQ4RSpwgg2h7U9xkfpRnaUi4WMf
   YdRlWjMCnFdHfPPpP2Yl4nKXmZZqAS3jthBelDp2/fK/cje9P+Wm8vQ7B
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="366558110"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="366558110"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 10:20:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="974955091"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="974955091"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga006.fm.intel.com with ESMTP; 31 Jul 2023 10:20:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 10:20:34 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 10:20:34 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 10:20:33 -0700
Received: from NAM04-DM6-obe.outbound.protection.outlook.com (104.47.73.45) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 10:20:33 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bZlo3BS9/b0IWbUa31EMHHx2bSNtk++NtAgrVFsvkLB/95yhFwZ/cqVE8n3TJsJHfWAZRkfnkdch3dx+tMp8Myc+0FyPsw7QNo57Zf5DtEfacB4//4AMgxIsXrYShaXNH7GgMWXGybzwbNlOiTnYk2dVq3sqSWSqGE8qE4cF6LXAadtP5n6d7N1BTiWhwASXnhl+zzgqoa5Pj8gFXDYWnQrkmpOvYqtKWEk5JtlCrIIiaVqwZoKRGhNtbvu1920arEqG1uP4iXP1jJbXRYi6GBEv8d2y0zkDl9NUMr9OH1TFWLJ6l1FXKTLZKi9aUt3mZaQgm92AvqI5O2nJ5MoPgg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=s27O1oSqAS7Nu51sAj+AighthEj7OlohToS7yPm6vzQ=;
 b=jct0IiWIl4SP540FdCGb7CU1Dij3rACTbFBjYgIZzeB/2wMftWO9hPsDj+B9B494Nq3E6J33xogn77RQ5ySzjTmtrn3L7+QRQWe/OQ3IPD3VkkAtRSyrRqCpNq4Q+HufHziitwam0tK1b6cZmbAPC6SefVE2ip2YeNu/cha+JQZlrApIYjTWURYRjwofTxxaGWlocghK3pCgY5QB9ExLpac7nRbIXkG6Xm2orgtNrUMihQbgGWvsHWsmOxrcBe06FQROMCQQPFAa8vP7VIR+KhLbsj6YlXJP8Pn6X5FJcRoQ4NKsdorOte1KjNAqIl8IiMwAqNBXJhbx/Z3ELb8P3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by LV8PR11MB8461.namprd11.prod.outlook.com (2603:10b6:408:1e6::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.41; Mon, 31 Jul
 2023 17:20:31 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 17:20:31 +0000
Message-ID: <d30ccfb9-5632-de27-fd2e-07b93adaad42@intel.com>
Date:   Mon, 31 Jul 2023 10:20:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next PATCH V2 1/2] octeontx2-af: Code restructure to handle
 TC outer VLAN offload
Content-Language: en-US
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <simon.horman@corigine.com>
References: <20230730143107.2845172-1-sumang@marvell.com>
 <20230730143107.2845172-2-sumang@marvell.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230730143107.2845172-2-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0098.namprd03.prod.outlook.com
 (2603:10b6:303:b7::13) To CO1PR11MB4914.namprd11.prod.outlook.com
 (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|LV8PR11MB8461:EE_
X-MS-Office365-Filtering-Correlation-Id: 67a97620-c318-43e7-32ec-08db91ea7114
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: qWsd8yyTysmXrQuD1HLnhmr3LF6sYRT0F2+Pr1yAFpNlzIZ0xUKpYEXAId0MCCf5LOTM/le/XvsHjugIOs15isrhtSr/gQMY8dgdUWp55EAsC1l5BM47JGi9B4VBqLQe0i1J4fJCcvPaldokM1UrFrzkhdn/+28ek+fRCLlq6BKSFraH1uGSs0zAk0azghFuTRBIVHHY7VLJTwcIAmlsDhHaAe+IMx/0bOlOCi2rCDEukg5XjOkilF/CT3sL9EnS0+xXNEVl3c+ofQkQ7HSLDlfnephhb8bbWjo7YxNnb59Mw7iDW8su3jqfDe83htRgbEtnXHAx2F2UDu6L5aHc/QqMgoPjjQQyYoWJGhjbv/am0LB5itZkmgRvLRg2ErGkRU0tViGhg0Ns2n8LgxKH69HtHefxnWhNeJqtA2CDLAVeQBLa4YlZuQu+Nb5sg+gi6JybriWciM/P+XzHzQiaY1xJk6EVed9nwhF/hFv7zPcadaS23D0m4sJWVreKa1P3N7lZRPYzAJgBR2o916dzrxoi18y7oy5wErizhwGuD9599Y7kD0XBROgXc4nnY820Fk9Itt6E4Bj1pVbka7UtdlUl3HqxAK20yvg+P9Jq9v+8z8ODAdBqSQXJErJQkhbviqr6tN1gjBlqaV2tfLR0Ggt5zhYQ64yuOEBIePvxbvc=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(376002)(39860400002)(366004)(346002)(451199021)(38100700002)(66476007)(86362001)(31696002)(8676002)(31686004)(8936002)(316002)(5660300002)(7416002)(921005)(41300700001)(66556008)(66946007)(82960400001)(478600001)(4744005)(2906002)(36756003)(44832011)(6512007)(6486002)(6506007)(26005)(186003)(53546011)(2616005)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?S0pGL0Z1ajYvWmVLRzlHZFkvTDU5YlplcVVLTHp2NmFPamUxVjhuYXVVUnJM?=
 =?utf-8?B?QlA0S3hKOHhBSXQ3RUlhaGVQcENpTndJeWR2dDIzS3hlK3FkZFpFWWpqYmNz?=
 =?utf-8?B?dmVGMytySDVVVzBUOUhrOE5LZFlKckhTT3E0Zm9IWDdocXVTZSs4bTJTK2pF?=
 =?utf-8?B?MDlGeG1RTC80alVWSG9samdPZHo1OHZzQWxld2pwWStqOXQ3QlNZVkVJQ1ZQ?=
 =?utf-8?B?bkVnN1orRGtBTWxGcE84OE1pbWlqSkpmRW1pUVBFRVhrNGczd0ZZMWp4bEJG?=
 =?utf-8?B?ZXdJVERJM25XVXVNdHlYdjNhVGZYYmVXWmRQZjIxS0xGcFUwc3V3bW5UQnd3?=
 =?utf-8?B?Nnd2dk1oYkVIZk0wZlNhRHcwblQ2blV4Uk1pVUN3bDB1VlJmbG5Vdi9pd0dw?=
 =?utf-8?B?QXFLZ01hek55VDBJRUpIMlVGNTU2dkQ5TFNQak0yc0RJdDJDTU9hZ2pjZFNr?=
 =?utf-8?B?TmRHRjlSUlJka09xRUhtZ2Mvb3FHY3V0Yk5QSFJROTUrN1IzdDY0c2p4NEZW?=
 =?utf-8?B?RGtLRUFEQ0R0aG5wM2J3MW9iZkYzc1RNZHdvWXJiRUh1Q0loeDd6UVd4eWJM?=
 =?utf-8?B?amw3T0huL2FoNm53OWFmNjgzQmNnNkhjZkhXcEhuQkQwcHErYUV0WlJtTzdI?=
 =?utf-8?B?Y1dMRkYyQjBmWG90aXpJR25SNjdmS1VjSEUxbGtYejJ3UllKTVBteVpuRTNV?=
 =?utf-8?B?ZHhKTHJXUC9vTUtFOXlFQXFZWTdrQS94VDlVV2hOY0U5S1hjYWUxeG52YlFF?=
 =?utf-8?B?WENTOCtCR2E1aU0zRGV6dFRLYjByVUFwY2o1S0V2YWhNTlpJNjgrWnBzeDUy?=
 =?utf-8?B?K3VkbURzejZRRkFuMFY4WXQrTWE0RWRGbVFrcHg4Z2M5WXRBaGQvSGhKVnRs?=
 =?utf-8?B?ajQxVGtsY1N1ZTUyOEl6Tmg0NlgyUW9aSStMcG42clk5ckdPdWxTelp1NG42?=
 =?utf-8?B?b3R4cDVKYXAwRk5mUjQrUUZzWTlibXBIRHVVbm01eFFYUDRqVmN1OG9WMFFK?=
 =?utf-8?B?WHF0K3pTZDBwNTNnSzl4WndBSXNXNE1BODE5aFFvZEdLQUZJUW9Qa0d1SVRR?=
 =?utf-8?B?LzVidk5CVUZpOWxDUXpLdVkxVHNJTEZsY0hyTE96aXBaakVWdlJZODVyNjBC?=
 =?utf-8?B?OUNuNEtxbE1ZVUZ1dDcxMU9ZdlJGNjJaaXBBMzRsWFNvQ09oeU9iNkdFVUxa?=
 =?utf-8?B?aGdpbzN4VitPd2FiOVZvS056YUVibW14aDJDOGQ3UWIrUllGbkoyamt2RHRm?=
 =?utf-8?B?K1c5V2VPcTlUdW83NWh0T3VwZmh6M3pPRGJCMnlGV2lOU3dRVzFreSt0eWE0?=
 =?utf-8?B?WnIwUFM1QVl6UzB3L1c0N1prWVRUSFN5VVM4enNmTEJMcWhlZkVDUzdHelcz?=
 =?utf-8?B?c1NMSDgxR0tGZ0E3MWdLdVl5YldwcjlSOHArWjdDNUlRK0ljOU1KK0dDQmZM?=
 =?utf-8?B?aGdRRHhPanhiTExyTmV6cEZIVFZHN1FCVUhQNW1Henl5VkFWWmt4enFucDZQ?=
 =?utf-8?B?WVFvenBqc291S3hUcnlsLzlIY3dvWDI1cFZiTEFWRDk0VU5aU2hha0hEVlMr?=
 =?utf-8?B?TkFBT2hHdTBCd3VZQ2I5aTRrSUhKT2JiN25EOHpEdGRtaWhJN2hNL0YydFdz?=
 =?utf-8?B?dXoyaE5saVBQc1EzMEdUZ1RReXo0Z3dKOFdLeE5jV1pmZ1g4eWlHV1VkODJ1?=
 =?utf-8?B?TFUvbHNITmVTbU51UndPTFpQd0NNbUZWM0FKUEVYSEFxdEh5dWo4QnV6WVRT?=
 =?utf-8?B?UzVYWVFYNzl4dnEvWWxnWjB6SzhLVzdZTEx1RnI2ald4YTBvVDIrOW9nZ0tw?=
 =?utf-8?B?L2ZvT3QzVWdSSlJHUi9KNXJIZjNaV1Y2eFFrRVVSanhCMVZwT3c5ZkpOMEhh?=
 =?utf-8?B?eVlKT3hPeU4xYnJDdS9Cb29wNTV3MkdwN3V6ZlpPN3dzcU8wbVQ2M1IxbXZY?=
 =?utf-8?B?V3lTSXNheUFaelQwNTA4RWZ3dktmQzdiT3RtOERBVmxvWVJwdGFwNXhPMkxE?=
 =?utf-8?B?SW5CamdlZlFsN0VyQnpsT3dnRld1RUQyMnhmTldwZnhzNnp2N1kxdTI1RGJy?=
 =?utf-8?B?VXpjZzREK0p2bXYxQlhVMWo3VmxjS1BJVk5iVDBhck5oLy9zM0dsSVkweDBS?=
 =?utf-8?B?cmZjRzNwRXdMZnB2S2tXSUt5K3ZKSzZBa1ZYMmJIa2tIc3J2TWl6Q2xRaXU1?=
 =?utf-8?B?Ymc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 67a97620-c318-43e7-32ec-08db91ea7114
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:20:31.0113
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: e5mXtBt753HrmNxyz7woiniNn5yajrYSVawO3UjbNgfoFUb9WrFcrgQ9X4Fiyl5VSsHEFlpA/K62vDvw5DNEZoTh3iKAg7lYx9TrBefa4y8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV8PR11MB8461
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/2023 7:31 AM, Suman Ghosh wrote:
> Moved the TC outer VLAN offload support to a separate function.
> This change is done to handle all VLAN related changes cleanly from
> a dedicated function.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


