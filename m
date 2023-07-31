Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECE976A368
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 23:53:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231551AbjGaVxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 17:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230266AbjGaVxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 17:53:37 -0400
Received: from mgamail.intel.com (unknown [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12573E7;
        Mon, 31 Jul 2023 14:53:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690840413; x=1722376413;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=namA0BXXxiTUR+GmLAiDiaXyuLmoKdMowqZGLEv/y3A=;
  b=nMoX8PBX8HbvQHzPfZDf43q7QYZfC0+fnWK58KiI+WIAIPwdVK4jbVTw
   6afah/5N80uThaNvHiCZfw5WXhc53L7BpARSVFiERQyIYcwERuBkEuR+t
   nPqhYptXd7Cl1Jh13poAR7AiHafxf4qzDQLS+FeYwxx2eEBEkZO8o7EAt
   75fiE6Qw18R7Rnd28U+T1/qhhXszxPebwLqm4az/vmyjBqUagKSo45Dst
   2zEC9jtfQhQloGjFDyM0xdx7xc+giRjsQ06KoaLiWJqemm5PNVv+dRANx
   1rwP/CZSRTG18Qd9vNnpD+bk8t+th3JmkKryIlbGwINuIUwFVstDntPJM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="359172078"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="359172078"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2023 14:53:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10788"; a="798408272"
X-IronPort-AV: E=Sophos;i="6.01,245,1684825200"; 
   d="scan'208";a="798408272"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by fmsmga004.fm.intel.com with ESMTP; 31 Jul 2023 14:53:32 -0700
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 14:53:32 -0700
Received: from fmsmsx603.amr.corp.intel.com (10.18.126.83) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 31 Jul 2023 14:53:31 -0700
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 31 Jul 2023 14:53:31 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (104.47.56.177)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 31 Jul 2023 14:53:31 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=T0NWO502Ly4+3KS8ExRkRuwAV7sEAS7+uPr67rd5dwljRGQ928G9YZLCMQI9KgAhoqvNap0j9Se1Dcx1ZBmIdywXfC6FaTSn7psI0mi/xpaWJn0mtVYyAc9BuGL81s8R72jB+Ec2qhwEslYlTSsRoIhrzbeM+A+2QpADBHkkk7LS9myvNeS5NPbMO/RlN5U92t27PSyZzgkqYABJ6k7cwTlhfm2iYfTTzEom4CtttxVDfL3UoeuJuDT7dFoxY3zcVVDcbTCS2eMRm6DQQHo8HPUe4CSXkQJIUMlv2DGf0bHREk3GvY4G9hx4ugbS3BtZoABjOHuI3jpROXRr6zEOJQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=TAeQkuffeujAjnDEnZRzWlsnwro9YvmnF74ZVUEt4Yk=;
 b=WMakQECyE2Ked2wafDaq8OvzAqoCUDPTypdwFFFEPvJX0qkQgXPlLcSmsMr7iU7lw7s5mIR3OvufTIse2KoVUqIcLNjEDRWrvzq1IJVWu/9tuweqbaY/dzAr1hDCyA/gs7ITo5jW19jRvuEtrMFnKfq6/WZtclsaXbW0VfB867R8wT+yCRaAWc1WecDU8X9Bk9oKtIVTNYuKcu69bGeRGEzUxstbZYRx1UCjVlEmsNh46YURhxFDJTke+yeLgwx+iMauA98cMxES6Nzv5YuGcSDYWwPkwWDx2h82NyhKMfCv63OChwO+VQ/BtVQ621+aVET2tJavQSKH0cILXWWrjw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from PH7PR11MB5984.namprd11.prod.outlook.com (2603:10b6:510:1e3::15)
 by SA3PR11MB8004.namprd11.prod.outlook.com (2603:10b6:806:2f8::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6631.44; Mon, 31 Jul
 2023 21:53:30 +0000
Received: from PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80]) by PH7PR11MB5984.namprd11.prod.outlook.com
 ([fe80::be6a:199e:4fc1:aa80%6]) with mapi id 15.20.6631.042; Mon, 31 Jul 2023
 21:53:30 +0000
Message-ID: <a988d3a6-2818-1ab7-d286-8ec968ce5d23@intel.com>
Date:   Mon, 31 Jul 2023 14:53:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Betterbird/102.13.0
Subject: Re: [PATCH] cxl/mbox: Fix debug message print
To:     Ira Weiny <ira.weiny@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jonathan Cameron <jonathan.cameron@huawei.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        "Dan Williams" <dan.j.williams@intel.com>
CC:     <linux-cxl@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com>
Content-Language: en-US
From:   Dave Jiang <dave.jiang@intel.com>
In-Reply-To: <20230731-cxl-fix-clear-event-debug-print-v1-1-42c068f500d1@intel.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SJ0PR03CA0223.namprd03.prod.outlook.com
 (2603:10b6:a03:39f::18) To PH7PR11MB5984.namprd11.prod.outlook.com
 (2603:10b6:510:1e3::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PH7PR11MB5984:EE_|SA3PR11MB8004:EE_
X-MS-Office365-Filtering-Correlation-Id: 491f7691-7a53-4269-b3b4-08db9210939e
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: ykSbXqLwGn6GQpTmg/xvj8dxP2krRQxZcNJrP6Y5DHLPbEwKxjQWHKyOzBkLjTIsRfP3JIu4/ZT1DQJJgiZb564tgEaTF+cuQc9ymZPQeTrhj0fNqT6w9UpYc8Iua1y/j7uDiyf2aZjeVzgk2MQxzriX3Q5hxW74ZGHbJeWjgx2b4Q/ZS1CjfjZrtnVyphRZhIyKGX2zd1YOhNZrf/XYurZk4gllAi+RZx30LZ5M5iN+8XbvLBzLQBpo9mK8Vhk9UJ2ST+xGhjm5ZE/wjWXHd+aFjO8wXYMJfRL4J2sUqtQop5fXFTaBEPMzMl5dpm3ieh+I/bbov0JD576b/9zbTMFqlj96n7/tkJFAhR3/82KaafdjSmSWSW4fbA+osviOX8NUlq+9HKJEt/SIrqASkqAmZJJU/OZqar4A0n1ooG64kYrcUDVvC+KNJAURNL8dhMz8Lg3/ZgWOSaYKtYSwAvkLSzaphvWcAiBtaoume6CFxD3svY62seL3vwmPgkJTENEh5OfVko4Y8cuEHaIwyI180aUHWfGLHUlWLU1o/zHgoXcTFw89LFbJIoH0K/Jt+eRXugFoYfw9iuVtSY1hWXHiX26mWlMLNkivbai/XlFf0h63cTCY7dmSfm3PzwEhWRRzQJ0uESwf/ZFIUcBRqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH7PR11MB5984.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(346002)(39860400002)(376002)(366004)(396003)(136003)(451199021)(31686004)(6506007)(53546011)(2906002)(186003)(26005)(38100700002)(36756003)(82960400001)(83380400001)(5660300002)(66946007)(316002)(6636002)(4326008)(8676002)(66476007)(66556008)(6512007)(44832011)(2616005)(478600001)(110136005)(86362001)(41300700001)(31696002)(6486002)(6666004)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZVBJLytnUU1xTVFuTnliVzZsNTN6dEs0R2FZbWtOR05iVEpGVTRxSG1hWkhz?=
 =?utf-8?B?QlpoSUc1QnNTNk1GaGFWdjRrK2ZNNFFQZHlZQU53V1BvbURsT3loS2IxT1hS?=
 =?utf-8?B?VUJLV0NqNmE1ODd5ZHB4aVZWdDZIK09XbmlkeUE3dDdmNDM1US9TQXdnMUs2?=
 =?utf-8?B?aG9BV2RWTUJtdTFLMlNtTlRMcFFpUzBSWE12TkdyTWk5Q2IvZzJRcjV2M3dR?=
 =?utf-8?B?V1doR3dSQ0RkR2NqbjU1dEZrK3dmdVpaS0lhZ2syOHhSUHVXRFNQK3QzNFZh?=
 =?utf-8?B?UDRDR0pqYmRqYmtJdUFqMldvM3dMVUJSaWtvRVY5QzB5bjgwTXVsUlNZOVZC?=
 =?utf-8?B?TzVKakNpaVNMZmYwTXEzc1Q4alNSZFF6RXpqaFBsMUIxeU1EeTF3YUJPOVIz?=
 =?utf-8?B?T092T1lvNWFJOXJUVDdiSkNGalVIaWgycVZFb3ZaUmx2MkI0UnRQOTk2V3Rt?=
 =?utf-8?B?VHJrRkZWSHgvQXRFdzh6Mll5bVQyeDFqMzUwNXkyU3VvNHZIcTVTc1RNeTFh?=
 =?utf-8?B?NWN5T1pkTVhjVHlsazNJQzRJUTNwdklzM0pIUnF4WTEyd1RyVVJSWmtoTk56?=
 =?utf-8?B?ckdYb2lldjc2K2UyY1pkS05ZenoxbDRnMjhPbzBKeFNCdWZzSXlVbE91djhC?=
 =?utf-8?B?RDU3Y3FNVGVTeTcvSUQzbC83OXBEMVl1R2RjaGpFaFovV1B0WVBRY2JSZHNk?=
 =?utf-8?B?cmRhQVliUFZVOURHMW1lRjJUVUNhdEhpNTlXV1hPemY0ZWYxMW9xZlE1eWlU?=
 =?utf-8?B?UjRHb0d2VnFSTDFlM3Ava08wNUZvbXdKaDFuenI5RWUvWGthaXQzMmtOeGY3?=
 =?utf-8?B?TDNEcWQwY2xWdHlQV2dGblVzNnNKNmVPcHllMGFOdUIvSjZYaU9iWXE0c2px?=
 =?utf-8?B?VVNlQlRmcUtTWWJ5aFpMMUJCelE5VUswallqVjZBYmQrSllTeDZNT0dWbWJp?=
 =?utf-8?B?cTk2eitCNTVCZ0FZWEp4NlhwK3VWakFBUWVPRFl4YXovejJ4WSt1VU5wZGt4?=
 =?utf-8?B?NGE2ZWhicEdta29Xb1l2cFVtRkhhSGU0MzVXMTlTSjJwdldDRHpGYjRXbmh0?=
 =?utf-8?B?cDBGK1hzUFJlbHlxbWZXclRRQS85ZWphRTVYWFRWN1BieUdRdlphNVk2bTdp?=
 =?utf-8?B?bU9DdVhnODAvcE5tV3E0MDB5YVFnN0FHVmVCU2pLTkVTMVV1Y3RHM3pueTFy?=
 =?utf-8?B?R0VGQXFOSEJJNVd3SjFzcWs4WHgwanA2eVZkR3NxRmtQaWN0SEx4RlBnbWht?=
 =?utf-8?B?MjRRVU5rWlZWb3FXV3dWNEdTTmFrMGdzQ0pHQmhiT0tXemtUeUJLdVYwWFBZ?=
 =?utf-8?B?cUhhV3ZvL2diNXZ0WW1va3grbFJ3emNDSThMSU02MHh0KzgzTGlDb2lRSHhP?=
 =?utf-8?B?eVFlc1NMRzZlNnpjSkc5YnlySUdCTG9VVDFObVA0WGp6bmxNNFBhV200UmVT?=
 =?utf-8?B?QXlzdXc3dk1XNEx4bis1OGdhYUplRk1uQTJGQVRPOXdrZzBYMXdJU1l2Q1Jh?=
 =?utf-8?B?cSt0Z1dVdlB1UEIwV3NITkc3bXAyc0s4VVpnQ1Byai80cTlZSis0LzNaWUkv?=
 =?utf-8?B?NWtLTDJDRWppenBpMlRPYmdDbWdTY1J1UDNVV2NWYVNFYnhBVXMzZzhGZW9x?=
 =?utf-8?B?WEF6b1kvajNDaDRIWGkwMnNGcFBySVYzR3lZdEZ2RWxLSGNiVUhwQUoxdi9N?=
 =?utf-8?B?b0RVbkg4dThGMXIyVEl3NWNhZmVyV0ZaR0t3cDlGSStGR2ZpSzE3K3JiNUt3?=
 =?utf-8?B?aFZnN1ViU1lrczdBN1VXYzlkZzgyNjl3ZU9FbTlKaDMvZTBRelhZSVplTG9v?=
 =?utf-8?B?b1F0WFE1OTZtWjgyTGpQUmJ3d0lqSml0d1pmUFIxRWRnMFBHSXZNam5UbnVM?=
 =?utf-8?B?cVNnTHRXYkV4SEhxV3BqUHNsYmwzMThYRzkyQmUzcmhpejY0MmZrb0VnekhF?=
 =?utf-8?B?aDcraWNRQ294N1JLRHJGaFJFa2grSUVtb05YY3VVYkgwR2hkb3dFYjBBWjFv?=
 =?utf-8?B?dHo0eWs4UVYzVFQvTkRKTitkWnUvbjB0Z1VkZC83eTFhOUY5cllReStzQTFH?=
 =?utf-8?B?Z1JubDVZSGl3cDVQanJuK1VLMit2b2toeTB5cmZ3dXhudUlKczJISFFaQXdt?=
 =?utf-8?Q?v4RNgYXxpdfJCawqhpfR1ZT9+?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 491f7691-7a53-4269-b3b4-08db9210939e
X-MS-Exchange-CrossTenant-AuthSource: PH7PR11MB5984.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jul 2023 21:53:29.9075
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Gd7VrHv/9z2jbnqg8r2ncC2SV+FWJnRpRChnQKe/5Qa1gfmONWFfDTTwK1pLVjWA+rBqTl8tJZRa0enQg1Yn6w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR11MB8004
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/31/23 13:52, Ira Weiny wrote:
> The handle value used to report an event being cleared by dev_dbg() is
> incorrect due to a post increment of the payload handle index.
> 
> Delay the increment of the index until after the print.  Also add the
> debugging for event processing which was useful in finding this bug.
> 
> To: Davidlohr Bueso <dave@stgolabs.net>
> To: Jonathan Cameron <jonathan.cameron@huawei.com>
> To: Dave Jiang <dave.jiang@intel.com>
> To: Alison Schofield <alison.schofield@intel.com>
> To: Vishal Verma <vishal.l.verma@intel.com>
> To: Dan Williams <dan.j.williams@intel.com>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: linux-cxl@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Ira Weiny <ira.weiny@intel.com>

Reviewed-by: Dave Jiang <dave.jiang@intel.com>
> ---
> NOTE: This does fix a bug in the patch referenced below.  However, I
> don't think that warrants back porting because this is only a debug
> print.
> 
> Fixes: 6ebe28f9ec72 ("cxl/mem: Read, trace, and clear events on driver load")
> ---
>   drivers/cxl/core/mbox.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/cxl/core/mbox.c b/drivers/cxl/core/mbox.c
> index d6d067fbee97..f052d5f174ee 100644
> --- a/drivers/cxl/core/mbox.c
> +++ b/drivers/cxl/core/mbox.c
> @@ -882,9 +882,10 @@ static int cxl_clear_event_record(struct cxl_memdev_state *mds,
>   	 */
>   	i = 0;
>   	for (cnt = 0; cnt < total; cnt++) {
> -		payload->handles[i++] = get_pl->records[cnt].hdr.handle;
> +		payload->handles[i] = get_pl->records[cnt].hdr.handle;
>   		dev_dbg(mds->cxlds.dev, "Event log '%d': Clearing %u\n", log,
>   			le16_to_cpu(payload->handles[i]));
> +		i++;
>   
>   		if (i == max_handles) {
>   			payload->nr_recs = i;
> @@ -946,9 +947,13 @@ static void cxl_mem_get_records_log(struct cxl_memdev_state *mds,
>   		if (!nr_rec)
>   			break;
>   
> -		for (i = 0; i < nr_rec; i++)
> +		for (i = 0; i < nr_rec; i++) {
> +			dev_dbg(dev, "Event log %d: processing handle %u\n",
> +				type,
> +				le16_to_cpu(payload->records[i].hdr.handle));
>   			cxl_event_trace_record(cxlmd, type,
>   					       &payload->records[i]);
> +		}
>   
>   		if (payload->flags & CXL_GET_EVENT_FLAG_OVERFLOW)
>   			trace_cxl_overflow(cxlmd, type, payload);
> 
> ---
> base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4
> change-id: 20230731-cxl-fix-clear-event-debug-print-3b57da0e956c
> 
> Best regards,
