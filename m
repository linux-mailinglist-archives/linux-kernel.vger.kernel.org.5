Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B5CC769F6E
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 19:24:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjGaRYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 13:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230189AbjGaRYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 13:24:47 -0400
Received: from mgamail.intel.com (unknown [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0254B2;
        Mon, 31 Jul 2023 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690824286; x=1722360286;
  h=message-id:date:subject:to:references:from:in-reply-to:
   content-transfer-encoding:mime-version;
  bh=/+LIvgG+mnYdL0gM8G2jDS+ZFaK6XeTAfbN3XaIq75I=;
  b=Kiv0tN1XLEwT1EpRxfx0Xjyj6RzrDcoDArtfyW+wtbV4S7fs/xHOhwAZ
   z/V4uqs78RwuLNOE7AHdqMysc5W2Zuz7G+u5BdHuD3JqxbkjvGRYnaHn6
   tgqI+W8//20D7zlJtnNQEsioLgzAZwFt0Y1noFn7s38LJ91f0r/2uh6jx
   /LT8bXKVHV6KN2jXTiSFJCZo63+OJQufFQCD5Z9nvWxqr0NJorD/kcTtV
   3vxkFKDeojz9M+1hPktHWdEsR8s2s74WSF/UtVt0CWpixssL2bSVpYKAv
   XBkLsqmr15zzlMLnzvtWG9wKZYNa6yN4qSw8bcpaCjqJ5o6E8IMLQSsVA
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="432905423"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="432905423"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 10:24:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="852120488"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="852120488"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga004.jf.intel.com with ESMTP; 31 Jul 2023 10:24:37 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 10:24:37 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 10:24:37 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 10:24:37 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.108)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 10:24:36 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Z+0q6wb2Huwvf1nWNB/NlfmM6agzEfxNMBMoAvboiAK4OF0rtiqwd0tlluStquBbQ0mmmAOuzqE9ic7vY5FQ8+sGkzx+JUFgjDfGy8Y5k0MMDbFkPFozOuP9cUCwekv9c2deHbM9pdS4XelcEVyLq+ChfmJgRWcsaO6JziXJzbUuCEg4uPRKxwsYNpC+uZcrE8lkHIZySDNGJBnjJ9BkU8tOVIuidrEtOaZhT9nfpYFyz0z7C4lFxjlr18gEbqPWVZbPwhySPPBBS84RGd9vigTmCPFsk2NH70/OBY+6e8B1exevAy6DaboL9lFzcg66PKNhtLttaM6MTehfnMY/5g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zYUu2Ipertw/xiH+KLYLxahLAjYATxkgjmmqvXtDytc=;
 b=iG11gwSXqSxa3wNkycZWV8cuLIfuzpurHMdaUZEvGRK1KIj7OvvqNZLqLPDeC+hqztx+5QO0HyWExFtv4Jw3OqD9LCE+36Ac+V5LQhXsyJINglfezjLnkj54b2FF6SytUAoCfOavJQ/JQ0G6XyqupdyEmIax3egD3z3DgDoggM42o9l3icn8YWDRGVy/x/pAa5rB6YWZav6urbxa7gz2W68xv9j/kjCZq2EDYYUaPbe/1zgoFomYZ+2xmFRLVjsMqYAseZo7KPmQ9ET7Skidt3u/YefXMxkgjaU7KaF1ExjEf/gf3TaxuGNFnq20rGC1biKWERuwLW6C4o/Fd+rMNQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
 by SJ0PR11MB5615.namprd11.prod.outlook.com (2603:10b6:a03:305::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 17:24:35 +0000
Received: from CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda]) by CO1PR11MB4914.namprd11.prod.outlook.com
 ([fe80::9c1c:5c49:de36:1cda%3]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 17:24:35 +0000
Message-ID: <1ff19823-beae-3e39-b3b8-2d8e7c94775f@intel.com>
Date:   Mon, 31 Jul 2023 10:24:32 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [net-next PATCH V2 2/2] octeontx2-af: TC flower offload support
 for inner VLAN
Content-Language: en-US
To:     Suman Ghosh <sumang@marvell.com>, <sgoutham@marvell.com>,
        <gakula@marvell.com>, <sbhatta@marvell.com>, <hkelam@marvell.com>,
        <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <lcherian@marvell.com>,
        <jerinj@marvell.com>, <simon.horman@corigine.com>
References: <20230730143107.2845172-1-sumang@marvell.com>
 <20230730143107.2845172-3-sumang@marvell.com>
From:   Jesse Brandeburg <jesse.brandeburg@intel.com>
In-Reply-To: <20230730143107.2845172-3-sumang@marvell.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0028.namprd16.prod.outlook.com (2603:10b6:907::41)
 To CO1PR11MB4914.namprd11.prod.outlook.com (2603:10b6:303:90::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB4914:EE_|SJ0PR11MB5615:EE_
X-MS-Office365-Filtering-Correlation-Id: 791aed22-abef-4a80-8d0e-08db91eb0288
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0BUQRECNPcVMztCgIJp/L3sHgRQConiYYbtBqzS5pPtqArbSw55gbZDlI1rqaWXa8vVvndr7OsDB8EVhUAUd4R43gy72JV//r0huNkfPMgAq/yXSNKq3WI6Q5SthmL3l4ulGRVPeogGu6lylkoo8AmhH2WybdjQbt6TCaJ4j2EjUcm6bHNu06ME6UihMCscQuI9gmVlzKV3aPysxRepl7S5KhtHvKhm9rhV8uqwTC+hXyPpoKSB2X8kUMiNrTMpe1OcM7YNZ4KLhSDVjTIRZwr5V8NCEJA23CKIbZaJLRbccDMxr64j9yOv3SW4qhEM3mjX//n6jsn+6SGvKZ3JpPvxJWClaz9q6hfoxGctSyFf9qpSJRHVcqyiIqJ7dvBMfLRlQ+fDheq5zmb1oLL5MOYxEaswU1tRPaAIiwgdFih7yWm+WhlpWsz4nDPinQ0F8Jbw6TeziX5kmcd0QyILFuu4nDO800JwGQ6xrGyS9mJs8oesnyd4GXmyJsavuwgxqabIHNEa0hmqDrBOdMDDTxahW10NGCCDjHi5+D7AFvwAE24+0Cj931D/9lA1+8NFD+mHlkpsGi22LmQizOHOfsXDaiMGOvLh1s29sKom0CDZ6fCGIqmMWht+FXRCs0ZlxdDHw4SN1G8qryeCWueJpSgHerzvewJycKq4visN8lJQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4914.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(136003)(39860400002)(376002)(366004)(346002)(451199021)(5660300002)(44832011)(7416002)(66946007)(2906002)(66556008)(66476007)(82960400001)(921005)(4744005)(316002)(8936002)(8676002)(41300700001)(31686004)(478600001)(31696002)(86362001)(6666004)(6486002)(6512007)(38100700002)(6506007)(26005)(53546011)(186003)(36756003)(2616005)(83380400001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TVpUM3pPRXpSamZBRUlFQk1zQ3JpZVdhazI0TUVJaVA0WXFIbEFJMHp5bGlu?=
 =?utf-8?B?a1M4dkdqMDlFNGNXNEpiSnlMTGNINFRPQlFUOE5TNjN6US94bjRKWFhVU2lj?=
 =?utf-8?B?aVZPdExacmhoYUxYeTZCUWZwQ0s2UmZ1UkxPMEtWMlFiS01iaUZYbkhHbjVD?=
 =?utf-8?B?THlkS3lUQS8vZlNOSlRVRTZoeDNHOHFHejVGcW5IRWhXb1BHM29vOG9iRFNh?=
 =?utf-8?B?QUs3VlNoMkdkbVhNRDZGbGsrU2ZqckRyVGhWc0lXYktOdWpOMmJiTmI4dVNB?=
 =?utf-8?B?Q2VNT3hBZy9Gd3YrQ0JhWkRjd2FUU05tS21FWm4zL05qeWtXbzZieDhQTysw?=
 =?utf-8?B?ZUp6T2lrREtVVmJ2TEFMU3pvRzFuaytWRUNOZEthUTlic0RYcE9kQUtxWXdy?=
 =?utf-8?B?K0FDM25RcmN4bnVURXJhb0NBYVpidFhIUkMrcktOZWJ5alhjdzJGOWNMUm5t?=
 =?utf-8?B?VnJVb1hLQlp3SHBTYitpT2FxUmJvbGtQRldBaG5SNE15MlA2VWV4NzNpbmtn?=
 =?utf-8?B?bWJ2ZU9FVE1uWG1Nakd1OStFUFowMjJyQktCR3pPTEFhenUyT0NzNEllN2w1?=
 =?utf-8?B?MFFEU2VUYi9LbGlnbzVPWmhpaGJ5bGxYak1YOHpoZkhQSDJwV0JZRi85R3do?=
 =?utf-8?B?RjR1ZXlleWMvdnc2UHVrb3drQk1TNkFpV0dwSUdEQ2pCVjd1Rk9RNVFqL0ZT?=
 =?utf-8?B?NUlMdFovTXZGQ2NGbGJRYlU5ekphVXZrakRXb0d1T0V2U3duM3ZTNk5GQ2ow?=
 =?utf-8?B?Z20vNEhVbm1oZnF2NTVlNGdjUWpYZmZHaDZUM0lnZ0VQYndDeVB4cjRlTlBl?=
 =?utf-8?B?Um5veFFCWDNJM3ZUVEx2Q2JFTkVqYW1aRFdtUlM2S2MrK2JHYi9LSVozaFk5?=
 =?utf-8?B?OEpDUEtuR3p0dTlXbE90ZVVoN1A2ZzZmanlYbjlTOW5HakdPOEw2dUJpV3U4?=
 =?utf-8?B?TForSk1nS3ZnNnI5a29DQmFxTUsyMUFiYlIvOUZuVWttYnVxd3MwendiSHcz?=
 =?utf-8?B?YW9iNGhZb0w1NXV3eG1PbjVRQVl1UTV3QW1IMWxLbEFvQWZBQjFFNDJRekFG?=
 =?utf-8?B?dmJya3hVcG9hc21FYkIraENqb1RtYUN2eUtmMVJwSldNQVFhMWYxZzNYRUkz?=
 =?utf-8?B?R0hrWUpIZHBRK28xRmpHVzRHSHRuRmZzaHBPMGN2Y3dXTGJyNVg0UXlsS2Ew?=
 =?utf-8?B?b3JyVVBGcXJ3TU13b0pvL2xtQmJoRFlLVTVRcEVQdGtIOHZHcndkS2FBL3Bh?=
 =?utf-8?B?OGVFTldxMU8vY1c3eEd2NjRSUFZnQWhsRnBFWE40WU1yRTV1QzlQY1RoMUZF?=
 =?utf-8?B?T0dUSnRzcmxMdXFnMnVqTHJkWmdMMmRZKzNoeWRGK1VMS29lYko2bFBWNmpZ?=
 =?utf-8?B?WlhQYnZyL2x3Zy8vLzIrTmQvWGFjdzMwMVBBY1ZGTXhrblFEWkhMNHJCOGxR?=
 =?utf-8?B?YlRxbENIVHVzRVd0eWl0ZjBhNm5jb0NQcFVvODlZZDVyTWxiaktnT2diS3Fz?=
 =?utf-8?B?akNmWldkQ0JaL09RcTNaWi9tWHpOSVdjd0tUNkFwQTVYWm01MXFPYVJsUkNC?=
 =?utf-8?B?WHNvVis0bE5GMTY2ZlpOYzQ1dnliYkpGbWVtcEtzTU01QStrRS9vN0pnVXRj?=
 =?utf-8?B?QTR2Ty9GWkVlV2FRdGdabnJzd2orYmFHWXlDMWZFTUJGQ2txS2V3OFlaWG9x?=
 =?utf-8?B?bEF5aE1hUmVkTnF6YVdWM3JyNUc1VE8zMWxETWRZWmk1dE0ydlZQR05FdCtK?=
 =?utf-8?B?VnhFS1VaYy82ZUlpdGhJNUNIbXJ0VVdMNC9LRzZiTXRONzlaOVhuandodGwx?=
 =?utf-8?B?bE56Z1B2QjRlSDZIZG1aYVAyaWNLeW9SU0V5M0UzZjB5cXhSNmpGMm9ZUWt3?=
 =?utf-8?B?YW9FMHlTU0JxTlVnS09SZ3hrejN6WDdnUnkvN0cvS1JJd0JpYjVFSFZUc0hH?=
 =?utf-8?B?Z2gwczFzZlpUd0RHTVdxd2JNNmVwczB4Q3FQMVA4VVRSNmtIUFZEN0dwU2dD?=
 =?utf-8?B?dUVJNDJXd0pwbmxxMFlBQTkrQWgzOHBOTEx4WkpnZFZSRjY3bnFqNWZvSWJU?=
 =?utf-8?B?N2xiaWh1c0VoK2FaZTltSmh6TS85b3ViU004b1pOb2JIWTFKWkVxK0ZlLzZi?=
 =?utf-8?B?RVNnVHZhRmdmUzBXZnpBZXNhakVqUzN1bWlhdmlHNGl3VEMvNnZNeUIwdldN?=
 =?utf-8?B?Wmc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 791aed22-abef-4a80-8d0e-08db91eb0288
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4914.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 17:24:35.0197
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2/59/D78RyysjX9pI51W7JOZ/xRTTA2qS5i7GjMp95UPl0VQ3lvOnNhhL1oxadtNqC1TXvPoCw+7QHHwty48pWhlh18IfN+6v29b9HwsztA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB5615
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
> This patch extends current TC flower offload support to allow filters
> involving inner VLAN matching, to be offloaded to HW.
> 
> Signed-off-by: Suman Ghosh <sumang@marvell.com>

Use imperative mood please.

if you happened to change the patch for some other reason I might update
the above text to:

Extend the current TC flower offload support to enable filters matching
inner VLAN, and support offload of those filters to hardware.

Otherwise the code looks fine.

Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>


