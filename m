Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A4C7A9006
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 02:05:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbjIUAFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Sep 2023 20:05:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbjIUAFE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Sep 2023 20:05:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209AACC;
        Wed, 20 Sep 2023 17:04:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695254699; x=1726790699;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2/wJQJDt6neXI2OY6aprpAN2KQZAIONNR38eHRtBNsk=;
  b=RwIfnZyFj2dBM3XfTwpXobp7xPvgEl3WP7Ae07ixPS5R+FHTIl+Q4f9f
   lB3BvxnDZT4Gu3EdI/y7h6iBZ1CmF3e0K/G31PkUs25940i8ngEXWqpme
   cH9TwGS8DsviJihcFK6UaD62wNnJJwbrkoAewgQKYGZSzGKwwV96v4Wmc
   cSHCN/mvYXk4CLU40T9sgMpGszrwP41rtc3Vza7nPE1htGbK1awz+tBZ2
   R84vDxknd7shFQwi38lcXdz1N5ebS4Q1sxAJDOT1vRME1DhwXG3EOEpP6
   FLGrUwrsK0pF8P9AVX2T6Jht5ekWbJWVFdTVBd1RZHRtmfOdrIo1s1j4v
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="384213463"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="384213463"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Sep 2023 17:04:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10839"; a="750150784"
X-IronPort-AV: E=Sophos;i="6.03,162,1694761200"; 
   d="scan'208";a="750150784"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 20 Sep 2023 17:04:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 17:04:35 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Wed, 20 Sep 2023 17:04:35 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Wed, 20 Sep 2023 17:04:35 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.106)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Wed, 20 Sep 2023 17:04:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KdMmGbvRyW8ZGCn1YTlb7dTWlrWmRsHpYA9iARI2YjlAmN/6qMwMYrbBQT9ZWYMx+NoYfQXCXURVlQmW6QiX7CoHkzlquEEJRMvuD6vC+xbWkbgZqyrPScZLq6K1ZELoJEl7tuTSTQE6gLrgiMVjzET9ACGuwYZmW0roet9LEOEyBEqhxdi8lgelayLSL0Ic/dL40pkEF5lTAWLXnj2TOZ7TV5bNKYlKgAY+G+eqL/I0y0Udz4AkLJAf6soeuUHSS066jflwF5l2ZhXaPV35yNUWP8fqSinkHXwdbjA3axyLbsVwV7GPKt6ciPAQrqCG+S65GJOn0cgw01ewa6vsCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=OEkPgK3N12B7huTLbQSKNTseOQJ5LE1vB2uZhSB07EM=;
 b=O+YSypHI7Pi8V3ihK5v+8F724VITt/henR7MDI8f73LAv3fjZGY+uQ3sA7buoyWqBYYkHGB+aCLTrWOJ8HQF2m2D5Zk5oeKOVkUx0C4k660wVJ8nlvPI9uc3UemGW2nttoXFPf3guSeS6fSc0nsQ+1bk+n3ezYiBdiozZwJBfWjsZlfdMjRl8BwxIQW0tTzgwT0Pes5sLDNW5Yx1fgTmezOD1owF0LYC8jvK1nre1b9eL1ic6dqMryR6dejF/v/vstniJnwv56Gpn5qJG09VYU6eFZjGvfq22pMcUu5Wn1djTHJ5bdV7urHSgd7FcJLSzR/3/GBsEPr/nsYNxndJxw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by IA1PR11MB6417.namprd11.prod.outlook.com (2603:10b6:208:3ab::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.27; Thu, 21 Sep
 2023 00:04:33 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::9654:610d:227a:104f%4]) with mapi id 15.20.6813.018; Thu, 21 Sep 2023
 00:04:33 +0000
Message-ID: <0df556eb-71b2-9612-a81d-cd83c27a2cd7@intel.com>
Date:   Wed, 20 Sep 2023 17:04:29 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [Intel-wired-lan] [PATCH net-next 3/3] idpf: fix undefined
 reference to tcp_gro_complete() when !CONFIG_INET
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        "Paolo Abeni" <pabeni@redhat.com>
CC:     Michal Michalik <michal.michalik@intel.com>,
        <netdev@vger.kernel.org>,
        Richard Cochran <richardcochran@gmail.com>,
        <linux-kernel@vger.kernel.org>,
        Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>,
        <intel-wired-lan@lists.osuosl.org>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Milena Olech <milena.olech@intel.com>
References: <20230920180745.1607563-1-aleksander.lobakin@intel.com>
 <20230920180745.1607563-4-aleksander.lobakin@intel.com>
 <2038f544-859f-4ffb-9840-37c1ba289259@infradead.org>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <2038f544-859f-4ffb-9840-37c1ba289259@infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0175.namprd03.prod.outlook.com
 (2603:10b6:303:8d::30) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|IA1PR11MB6417:EE_
X-MS-Office365-Filtering-Correlation-Id: 73c73055-4834-4af9-54fe-08dbba3655ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8bgtY+dbyaO9jnmUM+oCIZRvvcD2mRQHUhy3oua3Y88DDIcvQpIFPu3zTxJ7OG4XmWZJ3bRO24oVUyoVH3V+aGIzNcT5I55NCy57ZG9Bx8+oDcLu+qc9Pjryfx59/L8TQzhfd6VGBxxYSJ1EpWpX4uC02W/lz2+Yicd/dPEOKlekvds1Kz3E73Zvw4hyka0g5IOJLhMmm05WXBuN6lc+0PzNTS0+L2TdNR6jeK1UNNqCbIL+cSlYulXKFEKfVlUD5mSr4Xlg5T+P13qb4oNkEAv4MktJy/Wh1JjwZAQo05El7NDxbHeU/rQYPeB43TEwckYChNvRk/A19bPgcLtpsoTFljpU72LF7+ZY02Gk7N5bvVpC8Ucqfv3elH5UE6NzwBiZbTa1fr51jAw98KCsU0GUkNGxXZiF9THfdjEgwJhTTdmAD9/n9+Rc11F78n7Hx8JnwBcSZpoOfGOOkdAxYkPhU5zxiE5ET4JTINrE5+sS53qJq/5rfLCBJTcZoAkVdGQAPfzpzYHii++uFXzu2/JefWDYqkSdMHsILzwQxWtn26zzT/RBmOGMW/qO9AyvVqE3dGhm9gFf6O+le26pN6BHIS9xnCl0jHK5VG1e/D229UJVWJTu9JyoR9QC2DoTZlYKOwPaXKm5PZkYY05ymw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(346002)(39860400002)(396003)(136003)(366004)(186009)(1800799009)(451199024)(2616005)(26005)(107886003)(6486002)(6512007)(6506007)(53546011)(36756003)(82960400001)(31696002)(38100700002)(86362001)(83380400001)(8936002)(5660300002)(478600001)(66476007)(966005)(41300700001)(31686004)(66946007)(110136005)(66556008)(4326008)(8676002)(6666004)(2906002)(316002)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WXp5bHpkSTJKTzBEQTZOVS9ZY1lhSHYxTURHVkpqYXJBcWMwQzRRT1ZNLytr?=
 =?utf-8?B?eDVoMi9vZWZpMStlWURrdHI5VzBDUmJrNDg1ZXViT25JTUZ3SjJKaGZ3c2JZ?=
 =?utf-8?B?QU12ZWo0a0UwYU5VNVBwTTZvRDF0c1QyV1VhZDRlU0VvT1R1bi9VUHBYOW1H?=
 =?utf-8?B?WjBCcWdZcjBzWkNKU2I0QTQ0L3dJazZSTGhLUFVGdjh5TEcrcWNVbys4TVF0?=
 =?utf-8?B?ZElJS2k5L0pJVzlBRzhuYUh5aDR3YURmZGRuTGEwd2poOTVvM2hESTVvdXI1?=
 =?utf-8?B?UWxHd0swZkNoUGhwb05HNEZTYXA2VnRrQVZIMXY0RGtFaDYzMmhxYUxWVGZ5?=
 =?utf-8?B?bno3M3NVVGlXaE1zbHBVUTlMS25XdktXRlpIeU9JTUdnSzNKckpwQ2o5SlFy?=
 =?utf-8?B?YUJLdkNOYmloQzA5dkhRVlpYZ3hqYWpDdjlKTWdFb1YrNEhXd2xuTEZ5dHNY?=
 =?utf-8?B?azNPQk9uL1oySWlidmRHVlNVTE9CWU5kZEZSMm4rWHV3R0N2RUVkdFZLUXdW?=
 =?utf-8?B?UkM0Z05FakhCY2dVd2JDRkNDVEh0VFhMR1NSNkxjclh4TE1XN29WaG1YT2hs?=
 =?utf-8?B?bk10RkIwc2VQdnFkS0R1YWdNa2ljbU5NTzNKSC9abmIxNEFZZ1dtTmk2bitv?=
 =?utf-8?B?T0FOeDh5aDhwNkRLYVU3R3IxT2JWMmhXamtZVnRCQjZxVGYraDBMVlZnZFpY?=
 =?utf-8?B?L2xkMEhSOVU1V3NsZFJFR2tMWW4wSzdKMk8rK3pLeE9EcTIxNkRSM3JQbWpz?=
 =?utf-8?B?SFFJOFRLL2l5Z1g2dmpvMjM0TnBTNEhIOTUzNGlIQy90ZEYrUElNSVdnVmF3?=
 =?utf-8?B?bE1qMXFTTzdsM0R0elIwNkhFTTl0UmFRdFN5ZHZpc21HVmtaSmV3QlpVSmY0?=
 =?utf-8?B?ZjdyOVBIWmwwNlVpVzVETmxhcEZwRHZublBTQnNmKy9MWWFEaEJuamJUWTd5?=
 =?utf-8?B?d2orR3RBbHd5YWtJQ0xJOG0xdWs5OXk1dlNVaEF4anFWQ1NpOEViQlpQbFh5?=
 =?utf-8?B?NVVuUGEwM3hjV2dyZWVMb1ZWeEpsQzUzaGVDR3EyMUNSaWJZWVZWQ2NiRlQx?=
 =?utf-8?B?dFVSMWRjRmdIeTVGdS9uQWRISjJhS1ZvUjNSMUlnT0lmSTZLSG1WR2U3UGtW?=
 =?utf-8?B?UVBqQlBENnBudGFRcTBwRTkyWmNCRFEzVTdsVWFaMXpPSU1qUmkvNjJzOTRW?=
 =?utf-8?B?YmtKd2dSZE1tZStPMmhDeTFjVlNPbUxWUGthRTZiZC9zQlllQTlTV3Jlb3Mw?=
 =?utf-8?B?VXlERGd4cWxucENmTk8rdGpSVDdYZDlZVU9jNTBjWFRHRVd0NHp4ZXhoaEJh?=
 =?utf-8?B?VFl4NW9temMrb2t6RDV5TG93RVhzbE56Y1F2TERWWEpLSDZaOFdFNzdHdG5j?=
 =?utf-8?B?NEdHVEJNbEMxWWVGUjdLTGZVUWYzcDdINnZQOG1jRTF3QUs2N1JaQzZ3eXBQ?=
 =?utf-8?B?cXIvY1RQcVhNajFyOHk5azRUeS9nOGtWSklIcERYVEJIZkRGMDk2b1NlY09h?=
 =?utf-8?B?RmIwQmpoZWVHSHR6RXRmNW5ESEV2bWJNOTZFL3dob3E5dnp1M0Rtc2dvY2xW?=
 =?utf-8?B?SzI2U3g1MXlDdmpoNGJXTGxuR3g4TFZKSGFNNXlUZTRnZlcrL3QzS1FYWjRV?=
 =?utf-8?B?Tk9LL2NUbU9scUxYNVFRNmFpT3RoSGVnZzAyL2MzV1ptV0djeDQxOWRBNWVj?=
 =?utf-8?B?Um1SVTZIRFE1eHoxbUQ2REtSYU5CTzkybTZWeS9oZk5JZGNzc3Z3eFpJNWxo?=
 =?utf-8?B?L1ltdWM3SCs1eDJPQ0lobVppcUthUUF6UlovdmRtNGtLVnMyaFl2bzIrdkc4?=
 =?utf-8?B?Z1g3MTFaUW1LU21neWJiMnpva1dUZnJNdUZtUVEvVFhwbjJ2emJJcDJueHA1?=
 =?utf-8?B?Rk5yanp2N0VRSW1CZCt5VjF0cGVDVFVBY25jRWJyS2l1TnBVNzZTN0NCQ2d6?=
 =?utf-8?B?TFpUMzIxbEl1NkxncHc5aTdnbUFYRWVOa1ZhV1hWZDk2RmllQnppNklYeU1S?=
 =?utf-8?B?aUxwU0R2NDR1RS9tZ1NFVUJtbk9ZZUt2d1A3L2dJZ0lvLzExcklYSkl1Skxm?=
 =?utf-8?B?T3ArYS9nNmlQZ1dtaGZ0WGZxbjVyUE9nTDV3ZktmVWtJV053MHhvclZiZVpB?=
 =?utf-8?B?eEZTTW0vQVhpbUd3a0hMMTRhUEt6NjZPN3RTTGU3MUd5RjN3d053Nkw0Szda?=
 =?utf-8?B?ZGc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73c73055-4834-4af9-54fe-08dbba3655ae
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Sep 2023 00:04:33.3008
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 5FO8cYoPspdLJvoGyD2Tx1mzjm647DmxPc7RnfcACz+PcV22EF1fiZDAfjp8xQ3Y2g82v1x+4hwioDgBcrOAuVq6oag6u1B7oToSkKK9hEk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR11MB6417
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/20/2023 2:30 PM, Randy Dunlap wrote:
> 
> 
> On 9/20/23 11:07, Alexander Lobakin wrote:
>> When CONFIG_INET is not set, tcp_gro_complete is not compiled, although
>> the drivers using it may still be compiled (spotted by Randy):
>>
>> aarch64-linux-ld: drivers/net/ethernet/intel/idpf/idpf_txrx.o:
>> in function `idpf_rx_rsc.isra.0':
>> drivers/net/ethernet/intel/idpf/idpf_txrx.c:2909:(.text+0x40cc):
>> undefined reference to `tcp_gro_complete'
>>
>> The drivers need to guard the calls to it manually.
>> Return early from the RSC completion function if !CONFIG_INET, it won't
>> work properly either way. This effectively makes it be compiled-out
>> almost entirely on such builds.
>>
>> Fixes: 3a8845af66ed ("idpf: add RX splitq napi poll support")
>> Reported-by: Randy Dunlap <rdunlap@infradead.org>
>> Closes: https://lore.kernel.org/linux-next/4c84eb7b-3dec-467b-934b-8a0240f7fb12@infradead.org
>> Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
> 
> That builds for me.  Thanks.
> 
> Tested-by: Randy Dunlap <rdunlap@infradead.org>
> 
> I hope that these patches can be merged into the v6.6 instead of
> v6.7 kernel at some point (i.e., [PATCH net] instead of net-next).
> 

Did any of the offending code make it into 6.6? I thought all of this
was from recent merges after 6.6 closed.

Thanks,
Jake

> 
>> ---
>>  drivers/net/ethernet/intel/idpf/idpf_txrx.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> index 6fa79898c42c..aa45afeb6496 100644
>> --- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> +++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
>> @@ -2876,6 +2876,9 @@ static int idpf_rx_rsc(struct idpf_queue *rxq, struct sk_buff *skb,
>>  	if (unlikely(!(ipv4 ^ ipv6)))
>>  		return -EINVAL;
>>  
>> +	if (!IS_ENABLED(CONFIG_INET))
>> +		return 0;
>> +
>>  	rsc_segments = DIV_ROUND_UP(skb->data_len, rsc_seg_len);
>>  	if (unlikely(rsc_segments == 1))
>>  		return 0;
> 
