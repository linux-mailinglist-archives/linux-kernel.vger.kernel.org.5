Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8E756E23
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 22:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230195AbjGQUX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 16:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbjGQUXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 16:23:23 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B652D10EF;
        Mon, 17 Jul 2023 13:23:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689625394; x=1721161394;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=QYkDPIU1JsLYeMm6yVtPohnAMjqYLgou8goD6J6/3VI=;
  b=nnIoDae11VbkpJgsCn3t6nzeMyYMddrO54M4omJJMI42PTU3AukoU2vS
   zBKmCSOck0o4FiuX7DhHMzs8jyOuu9LtSRtiQgFIjOzXtVPqrUzs8R5A0
   ODLv2RBQ3WqaqxpuIPWZlc5Nje6VUl2kAQSXCSl7ocMJjsI28ETqJmXc/
   KwEM4k/SWhxjXdRgEbJFRvpGzUmqKJ3pDJdmAwFdWYmnWSFYOSwOstQaE
   8Y7LU3SOILghSxTEHijLCQP6lLXGBWs0movbRVkFIbHin2E8e82Z2ertG
   5CDP9pLIshhQKowWaDm0bYWQwmi5rMnaYjQMnkEg5LgxlbbV7+0HmMlKU
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="452405543"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="452405543"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2023 13:23:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10774"; a="837011353"
X-IronPort-AV: E=Sophos;i="6.01,211,1684825200"; 
   d="scan'208";a="837011353"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga002.fm.intel.com with ESMTP; 17 Jul 2023 13:23:09 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 13:23:07 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 17 Jul 2023 13:23:06 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Mon, 17 Jul 2023 13:23:06 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Mon, 17 Jul 2023 13:23:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gQU/p3TzsjtTNwy0xR8WR9UfUUjdIF2XZHx6nDuStS6cU+tZBN45ejY6Qiyx2d11UFux1N1tkumrLVIvUoZ1Iyw89EIyfG7KFMI8ra+vQSB16wgpr0cF5pazMhn4aNei95IGQ24EpNwyoGfLFMnAQr9pTXddebXx84s8+d9jldoSKIc0CGkDMR38gFb4e4qX0JI2MsbM9RTZnidXAeuOnQAxl1li9lcPjx+kNcr8kqX+BkpJlAPlauUXAWva2CAAce0yjjiupdPEp1l1ZTkrHVAHdp+YtoWCGBFjaZNC3QpbosSXz94zP/eBd5y0JLhlEn/jBuTe7dHhducl6Xtimw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=a119qC8Na56o7y0U/WbQkZN7Y3QJXN0M2jCTI43oww0=;
 b=Bl/UxIeV2vhF1GG8Q4JNTSRwYYcxZJR8ursCpY7w0uzAIFQ8skaNrUZQskqrpXs77Zc4gVcgxR+TiiJBf+VAoYd02vjqDCNrk2T65Ts9QM8tRaLihggUdbBnXfehz7O9PA8FICMNM2ufRbVPiQGhS8m1s1T9QKdGfJ7xoGK8tfxb+GYPP12PL/liOtUpmDMf/hLDALfAcgH74eiclDxQZxJeekdbVtHpU2y6InFr0DBQ37NS+2aY+rwQ4GkIZQB4ICVrm+rcgepm5+FYGjTG5BL839GuCgl5uUsM3v+In9PeK6jZQml8TdnyP9K+2diDCmoiBbUu2FRCTjP1kti/ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CO1PR11MB5089.namprd11.prod.outlook.com (2603:10b6:303:9b::16)
 by CH0PR11MB5442.namprd11.prod.outlook.com (2603:10b6:610:d1::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.33; Mon, 17 Jul
 2023 20:23:04 +0000
Received: from CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae]) by CO1PR11MB5089.namprd11.prod.outlook.com
 ([fe80::cb4c:eb85:42f6:e3ae%7]) with mapi id 15.20.6588.031; Mon, 17 Jul 2023
 20:23:04 +0000
Message-ID: <5f8da155-736e-cdd8-35bf-0f68385c6117@intel.com>
Date:   Mon, 17 Jul 2023 13:23:02 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 net-next 00/10] Introduce ndo_hwtstamp_get() and
 ndo_hwtstamp_set()
Content-Language: en-US
To:     Vladimir Oltean <vladimir.oltean@nxp.com>,
        Max Georgiev <glipus@gmail.com>
CC:     <netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Horatiu Vultur <horatiu.vultur@microchip.com>,
        =?UTF-8?Q?K=c3=b6ry_Maincent?= <kory.maincent@bootlin.com>,
        Maxime Chevallier <maxime.chevallier@bootlin.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Vadim Fedorenko <vadim.fedorenko@linux.dev>,
        Gerhard Engleder <gerhard@engleder-embedded.com>,
        Hangbin Liu <liuhangbin@gmail.com>,
        "Russell King" <linux@armlinux.org.uk>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        "Jay Vosburgh" <j.vosburgh@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "Wei Fang" <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        <UNGLinuxDriver@microchip.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        Simon Horman <simon.horman@corigine.com>,
        Casper Andersson <casper.casan@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230713121907.3249291-1-vladimir.oltean@nxp.com>
 <CAP5jrPFbt7vc77wVi5buYM88gDQ-OCHzm3Hg=EzRxJiha7Ur5A@mail.gmail.com>
 <20230717112534.nhy7ldeer42r4rz3@skbuf>
From:   Jacob Keller <jacob.e.keller@intel.com>
In-Reply-To: <20230717112534.nhy7ldeer42r4rz3@skbuf>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4P222CA0013.NAMP222.PROD.OUTLOOK.COM
 (2603:10b6:303:114::18) To CO1PR11MB5089.namprd11.prod.outlook.com
 (2603:10b6:303:9b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CO1PR11MB5089:EE_|CH0PR11MB5442:EE_
X-MS-Office365-Filtering-Correlation-Id: 7f756cbe-0aba-4487-2c7a-08db8703a033
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jQfC2A3OR6bX/sxAfomea42YAA3O8Qd7ZGWltaWuXQHtejqBVFq3dHmFOjPL7M0AfqxvdKPj5xQLp+u+5rs9KYpvBh3HUCPEnJ6I+R7ZPzG4LOuFLfqMI77BaEhKJgHXUuTMgfSxfqnniEvTaCp4zNbSsOsNPUtugSq0++YOX8mx6gW1wCvjYpdKtBHHFvWF5xHek12/3VDS510Zi1SBEtuMDWDq7V3eIfOuaTnAazRDvh2XNliL7P78edQ846FpLsw/KrXdYboF0GYlyTnsBTSQ57ycnAdXogYlq1TusqpaimYo1NPH6yU9my+rIRN+6n8xJnJn/RrDoxOi2FPT9z5CHJY4j0e8tFt472AH3Q50fxq2U4vod+LHEA6U2SRmheGfLmZycxjTxEk6Oim8m0XpH9SfuQJ+QJRMunOgRRASPg9jqVltbrORbqwdwWlaZ1P7qRkBQ27kIdpNtVhScdPtB7WGo+XHZiEuxkNLj22cjqx579uzsNDh6tW/k3OBsj8sQZGXlG9Spk/2eyBiQ5GFoRSinrWLRhbw4bK8k3bamENLdwx8AvnL9O4H/zLEtnSDYq60Bob4D77jnMSCL0ICba5cs8luFCjl9FAVNk3BvmELBpySSc4RUQgzZ0Zi0ptOMlpC0cHSKxV9leXfvg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5089.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(39860400002)(346002)(376002)(366004)(136003)(451199021)(31686004)(6486002)(54906003)(110136005)(478600001)(2616005)(83380400001)(31696002)(86362001)(36756003)(2906002)(6506007)(186003)(53546011)(26005)(6512007)(966005)(38100700002)(82960400001)(4326008)(66946007)(7406005)(66556008)(41300700001)(316002)(8676002)(5660300002)(8936002)(66476007)(7416002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?N0lzL0k1NHc4Zk5jZVB2UVBicG9XRmNNd1RCWHB1VktiNmRwZkNjNnNFVXhM?=
 =?utf-8?B?VFZBRkdzTVMvTnJDWXBZcEJRbXp6RWtrY3JzRmlHem5OdDVZSzJVQXV5aWFO?=
 =?utf-8?B?ZWRxeXJFUjlROW5WVWVQaHVydlphdHlSYVQ4N1gvWlBTa3gzRHoyWm1NOFpx?=
 =?utf-8?B?NXA3TlFTc294TG1HV29TVlQxOVBCaVl1QVh2U0hSd2xXbWhnWW1ySEdZWVRJ?=
 =?utf-8?B?c0dRb2pQc0RFS0tOWXQ3OWdHcHR2YWlFVkZzWG1HbDFRR2lFdUx0MUhNNFB4?=
 =?utf-8?B?a2NSYk1rNXZRYlN1YkdoYVVDNDc0b3hZK2I1enVxZ1RmYkZZWEcrTUFnTnN3?=
 =?utf-8?B?bEE4aE8yQm8wWVhYZFhZbDVHbW5TTXljTkhXUS9wdzA0N21yakJSa3o2M1Fp?=
 =?utf-8?B?ekNLbTluczhKcDVjcUM0NVR3bHlEendaeTA2M092dDdoSktRcGJLNFMycXVM?=
 =?utf-8?B?RlFHdFFEdWpOZjN5QlVOY00rNFU1ZmkvZDc3azlCUHJOQmhEMGdObGlTMGtW?=
 =?utf-8?B?NGJUNnRxV0tZUGVYTzdXSDFFZmtjNVZpY3laVlowS2lpTjdLb2wrWWxjeUIz?=
 =?utf-8?B?SDVvM05iUUZHanUxN0FBL1V3RlROQm5LTmN1K0RScDF1TWFUa1RJWDJtTHNa?=
 =?utf-8?B?UXowNlczd1E3SmVCVHgxbWU0Y0IwbkwwVzBWTE0wVTlmcnpGQUZZVWdScERH?=
 =?utf-8?B?SUdNUFhhUEg0WmtJVXhWWjJQcGZOakg4eGt2QlF5S2xFSGFDc1RldnREN3Zs?=
 =?utf-8?B?ZUFOdWlWTlFSaTBLeUgyV1NCV0Vxa3ZpeXNycE1penl1NmxxNkoyQURVSjFX?=
 =?utf-8?B?bTJDS1FkUFdzYUVvQ0ErY1pNOWRocmRKTkhaSzVLdWoyOHJCcS9ZS1VtbjJl?=
 =?utf-8?B?V3o0aVNNTXc1cmxQZHVPdENDOENhWGRuSGlFNXk5dHY5TFkyS1Y5OGcwZDVB?=
 =?utf-8?B?NE1uOVljSVZDNUVSblNSMzBvWlhyMUlQdFM1TDBndldRSy9pMDFWMC9BR0tN?=
 =?utf-8?B?eXhSRWZnUWhhMXZyQitvc3hNVnJ1Vm5YTWlpaStWaVhVcWdNdUQ5RE1zR0Qz?=
 =?utf-8?B?TlVYZlBrTks5VzBabVpZMWV2NW0wTlRGV0p1cjMxVGdUQnRkMVAwbTZrYlow?=
 =?utf-8?B?a2VkUzRkWEVHWnprOGttendITjE4N2NoekpqTHM3UVNjN2EzaXRlV0JlU1V4?=
 =?utf-8?B?Q3k4SHdJZmE5Q09LWTlka2l6RmFTUU4wUGRhaFlGVXMxc3lCTHJicGFKUjZo?=
 =?utf-8?B?ck80UkhjL290YXRySldwdDhmc1l1QnRtNDlheSt1Ri84cmUwT0J3UFQzNWhh?=
 =?utf-8?B?aGozTk9zZkpHVnl5VVNVN0NXSmFrbnFSdlNQUTB6dFlwMy9IeTJsYy95SHdX?=
 =?utf-8?B?bTF2WU1FemlVK0lXUVRneFdTVEhVWmJ4M2hjY09SblhSek5weDBFbzNzd1pS?=
 =?utf-8?B?VUdNTnZORHVVWU9LRFBjVmZQTm1pZXRLaXcwcHpnUjRrUmE0T3FZTU12NXpn?=
 =?utf-8?B?b2kvQ1p5NjVpaWlVUERqb1I0R1NHOXJjUmxwNXMxYmlvbUtUMnlXSTdTUUZi?=
 =?utf-8?B?U21xV2VwLzRuZ2tDZE52NnV6QmdXVnd0L3lhVGhmMFZvWEJmbXdYMWdWdVZ3?=
 =?utf-8?B?SUppUzJ0R0VyZlI0M2toRHJCNEVaZHFubTZPRDNaaVhSa1ZMNXF4cXNSalhj?=
 =?utf-8?B?ZVdaSG03RVN3M3h0RjBFMXZiOUxwZ0g1RHdnQ0lrS2lhMllTU0FtVkJraXRs?=
 =?utf-8?B?OVozbGFPam1PVEljcDNwZmIwbVhlbnBVdFc5R0wzQXh0UTRXRXZHYS9jUHBq?=
 =?utf-8?B?T1J6RmZ6L3NQTGtmR2JwUVFXOUlsUzlVd1RPRy82WmhrdVcwaEw1Nm1CY2U4?=
 =?utf-8?B?eHI1RndKeGFUYlF0Z1Fyem9hWXNtcTYyR3Z1SXdUT2V0aTA4eUp4TzBQQUhQ?=
 =?utf-8?B?N3RtaXk3Rno4ek04U2o2T253TE9YWjZOYXRwYVA0dHg2NEpQV0FxdUFNWmdL?=
 =?utf-8?B?bzQ0M29jbkpzN2xMb0xia3pIc3FabFVnbGlFZzZIQU0xSWorQjJSWVZIVlI3?=
 =?utf-8?B?NTJrWGt4dVF4OUxPT3BXay9TallCVXFvcE9BT0x3Rlo1dUQ1UHVMR1M5MVY0?=
 =?utf-8?B?T0E1VHNINElTSENueERKeW5sV1hxZUw3d3Q2RVBvOTFpVXhMYlEydWFneEhl?=
 =?utf-8?B?SHc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 7f756cbe-0aba-4487-2c7a-08db8703a033
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5089.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Jul 2023 20:23:04.6509
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: lUqpo+GpoeJ7ZP2xaUXK2NLb0whkpDAeLtnmEj6GqZI2s6k0WNqmxxvSI3COhrvIEH7QBfUckYrAE+dUPKq0RGXhWDw1us7EuwsBJXV2Fms=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5442
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/17/2023 4:25 AM, Vladimir Oltean wrote:
> Hi Maxim,
> 
> On Sun, Jul 16, 2023 at 07:22:23PM -0600, Max Georgiev wrote:
>> Vladimir, thank you for taking over and improving this patch stack!
>>
>> I see you dropped the netdevsim patch:
>> https://www.spinics.net/lists/netdev/msg901378.html
>> Do you believe it's not useful any more since the rest of the
>> patches in the stack were tested through other means?
> 
> I just didn't consider that adding mock hardware timestamping support to
> netdevsim was necessary or useful, considering the number of other driver
> conversions that will have to be submitted. Just an extra, avoidable effort
> for me.

FWIW I think its unnecessary as well.

I read through the implementation and noticed that it also used the
.get_ts_info callback by directly reporting whatever type and filter was
set via SIOCSHWTSTAMP, rather than reporting some device capability.

Obviously as a mock device there is no real capability, and that was
likely done for testing purposes. However, it would still leave the
kernel with an implementation that does not follow the expected rules
for these ioctls.

For a mock device thats not really an issue. However, I'd prefer to
avoid such in the kernel so that its not available for copying when
someone without such knowledge comes along to write a new driver.
