Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CF17754477
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 23:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229691AbjGNVxz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 17:53:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjGNVxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 17:53:53 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB37B1720;
        Fri, 14 Jul 2023 14:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689371632; x=1720907632;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=yumfd8oLxM4TnDfcfw2nx16MW9FOYlFSr+mrAxuHAYY=;
  b=Yaxpmw8qh+OSvpRke3n3eR1mi3LOWyseX2ncb/3FYE7fa8/KunqWQ+V1
   djWTpN4UisdoqWr5nX7mCsXlXH+79SYerr7fvPLz3bG8BWcgMceS78JTP
   rVRc8+zXHrtrOoh34ST+alTFyOCIZWoARats6G0m3LBCY6xE3rqS/WgTf
   Bra+C7SdZ31QnIdJaHkQXwb25+wWsMt+5+YNxtAmtCzsjmTygxcGlSa2/
   XOnw9SFobyzU+jgiCt5gho7V63POIpXceAZfJu99SxdOmEksNSFBJ9Wlu
   ba/Ext/e6K0/7Sb31DTumE672HjxEmqokShJQxNNdzoX7+oYkJiKV3EWy
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="369135311"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="369135311"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 14:53:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10771"; a="722549968"
X-IronPort-AV: E=Sophos;i="6.01,206,1684825200"; 
   d="scan'208";a="722549968"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga002.jf.intel.com with ESMTP; 14 Jul 2023 14:53:51 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 14:53:50 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 14 Jul 2023 14:53:50 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Fri, 14 Jul 2023 14:53:50 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.173)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Fri, 14 Jul 2023 14:53:49 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bN2qwsaiUJfdVjgi+GyLqTpLE5GKbuLYXaVdtjMdM2jHwPC9itIEJvLQ8RBthCAwovfVhgxKx1QaGEc3bfvyv8zJllBpgKOtsPSTrT4qBbXfCYhug8Qx31klO6XOdVhReImmlmCLkYALUe1/He/ji0yVelT9zXupKBGUa0AbERywVHwuRAwhCO1GwmUsQf0s3uVVF87KuRHHPX+F01+Q/SEzBjh/mssptGzCFlEQo3fKMVsNoksoPjgPOTC5wZ4LO8h3I4WKb9sU56jomL95YndIo6OKUTVrauPfulVPdybTl4HMVktItJW6ILAnEyj4PrEe6mvlCNA23qSgM5wTIg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bxh9KuKo4rWiXddxmztRPM4BC67hexg4QBDBxS7N4Ks=;
 b=V1Gl4XYo05F+HtTTMssnQmrbeFXGXP1snoC/AOMcYq2e31LV0zeTt5XPh7MvIqo6u1s1Td295GXqjDD6rW5th3FN9RHNxJEpT95LF0zzwZbDaAKGgaL0118uBBXC1FXPTiRfyRy94dtq3j7f4oN029QH56XX/CgcTZO+kxeiqAFiyKCgNalet8qhBR6ZwvBHYr83Vlu0WfgKWLRC0nFfFTtXcJmz8mGk5Jjpe+pQPkVV9zJv1b4m18n6Nzwc7jcMVENghXKDGNCQOSFvJ1qUa5TFBbFLQ/0ndZfZ6ZbIvr/yZ/Cj5m0JBxlvHkTlcvD1FBXOBne1WF9ZkTuu8sbh0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB8404.namprd11.prod.outlook.com (2603:10b6:a03:53f::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6544.24; Fri, 14 Jul
 2023 21:53:42 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::3b1a:8ccf:e7e4:e9fa%4]) with mapi id 15.20.6588.027; Fri, 14 Jul 2023
 21:53:42 +0000
Message-ID: <e051f7f9-3d51-e45c-f8d4-e3700d68aa92@intel.com>
Date:   Fri, 14 Jul 2023 14:53:38 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v5 6/8] x86/resctrl: Display CLOSID and RMID for the
 resctrl groups
Content-Language: en-US
To:     <babu.moger@amd.com>, <corbet@lwn.net>, <tglx@linutronix.de>,
        <mingo@redhat.com>, <bp@alien8.de>
CC:     <fenghua.yu@intel.com>, <dave.hansen@linux.intel.com>,
        <x86@kernel.org>, <hpa@zytor.com>, <paulmck@kernel.org>,
        <akpm@linux-foundation.org>, <quic_neeraju@quicinc.com>,
        <rdunlap@infradead.org>, <damien.lemoal@opensource.wdc.com>,
        <songmuchun@bytedance.com>, <peterz@infradead.org>,
        <jpoimboe@kernel.org>, <pbonzini@redhat.com>,
        <chang.seok.bae@intel.com>, <pawan.kumar.gupta@linux.intel.com>,
        <jmattson@google.com>, <daniel.sneddon@linux.intel.com>,
        <sandipan.das@amd.com>, <tony.luck@intel.com>,
        <james.morse@arm.com>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <bagasdotme@gmail.com>,
        <eranian@google.com>, <christophe.leroy@csgroup.eu>,
        <jarkko@kernel.org>, <adrian.hunter@intel.com>,
        <quic_jiles@quicinc.com>, <peternewman@google.com>
References: <168564586603.527584.10518315376465080920.stgit@bmoger-ubuntu>
 <168564611100.527584.7981937236207103115.stgit@bmoger-ubuntu>
 <94694f76-62e0-3751-3791-936db8b7e3ce@intel.com>
 <f443880e-fad7-b61e-e832-3cd180ad3a33@amd.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <f443880e-fad7-b61e-e832-3cd180ad3a33@amd.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR16CA0064.namprd16.prod.outlook.com
 (2603:10b6:907:1::41) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB8404:EE_
X-MS-Office365-Filtering-Correlation-Id: 083913ff-b57e-4f46-c539-08db84b4c999
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jxfWgzrogbTadTo1bS/cUhG0CO0UYtfFvFHF45mBjRAt5DpaZMj55vKan2loQixM55FfPKUNx6aRy+EIx9EAlKW4ZFzFjcWA440LLIizJc/tKGqLeAXZIKxWbAyOr794XrA8dTNLqid29WcM7Kgu6nuO2QpPbu285QEs35EzYh7vaQWhz1Gqgh3xxppHiH53IBjQvmX+CIRZmXU401rLyiv4KNENaMZqxdK4gO5BscGsuB1X71kO3gD083usmhECXImYfr2jt32VU8565HY0Vo74kmIq4cWwyqMAUou4wgSI4cO+EUbkVWCffTpA9zCs4KU4DownM5qjWJJtebp/a+KaPS1mtYD6AlNELA/KQtbyMQ+BUODT+g07TtuoySF32KtVYf9IBOmk3IXuaL7BNgTH1kG8s1cPBzq7D/ow8gIjjZbTNO4scC0Kj+sPz4oDkSAc8C/tPbcdN1VOYU9LHNfISfpSNV3yLRBQpUBomEeHnz0NDPv/E/80A+DQucJqRmJpOxmOlljRv592YXtSDdABoENMoKeGUOgmp6c8AoCbq0xqyiEP/finhdfjRLW/fNUorpJ/cCQUEqBJaC3XBfORi4CiAcOShsSACqK3ZSnPBhPv1JBa/oUwUmNj2KNsE9+JRbfgK/xCKXVS9HXO2w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199021)(2906002)(4744005)(31696002)(86362001)(36756003)(82960400001)(38100700002)(2616005)(5660300002)(26005)(6506007)(41300700001)(186003)(6512007)(6486002)(6666004)(53546011)(66476007)(66946007)(4326008)(316002)(66556008)(478600001)(8936002)(7406005)(7416002)(8676002)(44832011)(31686004)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dkk0WUovKzhUY1BpLzZEVC9zZG9JRDVRYlBoQkpMUExkamdOUVdsc2RDTzZN?=
 =?utf-8?B?YUtsUTNMZGRlc04vUmgyaVZLcEZMSk1LdCtyY2E1NFFkQS9WUFl0Z3lhYUFx?=
 =?utf-8?B?dll3OG1MSEVtTVBqRkdZeUk4LzZBY1RiSFlDZ2tWQmRKZ1JOSUNKcE1pZDJl?=
 =?utf-8?B?bVpQYjVSSlpSZ1FjbVpGSXRxQUNTbHBERkJCdWZmVGZZcnYvVWh2ekVHUXF5?=
 =?utf-8?B?MDkrMUlsM3pWMmVVN01jZkR5RnQ1RVYzSFYzc2NzWmlxa1dWQVVCY1IrVVor?=
 =?utf-8?B?cWhORDhhaWNVOExZL3dHR3RzTVNJUHlzbUhEQ3hmQkkrNWpRVEJvR3U1V3Bq?=
 =?utf-8?B?RkVGYzJFMy8yekx5dEwweHR1OWNoL2FNSEJzOXMvSGZSSGJWWUprMnRBMUNT?=
 =?utf-8?B?bThxT0FCSHNVaU5aUVJBK2JPY2cwaHE2aDZ3cjFwRGd2ZDFDM2MzQzloQlVF?=
 =?utf-8?B?MCsrckFuVDJ4UjdkQWRGQkhnSjVJOEtZOGdUOEFGZ2twelo5RGMvRjRETkda?=
 =?utf-8?B?RS9DWnZYb29YdTF6WjlscE1ISXpXZzlEdklFUzdMMlg1bjBHNWp1SjYxZUlo?=
 =?utf-8?B?WEtIeUFKeU9xZmxGOXpjZWlUYTg2dUxCT0k3SDY5dmpka3BhOUR2dWIzSlQ2?=
 =?utf-8?B?dnlQUWR3M09vWUlUN3AyZ0dkcnRDTVZVNXF1WDA4MExlNG85YlFGQ2ZwRmJF?=
 =?utf-8?B?OXhsTzV3ejF4b2NLN25EcDhhRVRFUHZsMmM3SklGTUY2N09WdmZqQ2p3N3Yr?=
 =?utf-8?B?UmRDWUZtUVoxT2M2K3NkQU1odWdsUllSOVB1T0pVb1pZZzBJbHZrQWRrTjU5?=
 =?utf-8?B?VjRZUERZN3J3dnIxUGxYMWtjVldWaExUVUhZcUluYUV3eklXYVNxWnhETThx?=
 =?utf-8?B?SHFEbWJMdDcwcStXWjRvYVZkWE8yNWZlb1ZFZmZOVFJDMDlGZFVzMVdWUWdV?=
 =?utf-8?B?QlJUaGZlNE93SnM0TEN4TTU5M1p1NEtCRHI5eHVwMTFncXdJOGtLYnd5c1Jv?=
 =?utf-8?B?Y0I0NW1YSjR4dXNzK2Y0aDBReitXcU13ZzBhRldHSXo3ano1VHByYnBMbDdx?=
 =?utf-8?B?aHB4THBWZnJhY2pEcTM5VzgvZ2hlaVZjcVFyQ0dTNHo2ak5maGE0RUFIV2x6?=
 =?utf-8?B?TVBDRzViSW9jQVIrak1ITzRqQmxJcWtjK3pOWVZrQm9vWlV6bW50U1I2QnA0?=
 =?utf-8?B?L0dFYW1LZ09lcGowVVBSWVZKalBKbHQ4cXJCY0E4d1ZhMTVLVityNmwwWVE5?=
 =?utf-8?B?Y1FQTHNDWTNpaHkyK3d2Z1hNRzFQSzJNd3BWOUxUZ3A5M1haQ1dvRHMzL21G?=
 =?utf-8?B?Mk1QeEZFZVAvUUJ4OUxMOEZNQWcxSDNVM0poOVJTMTNFZGtMbmpCNHAyM0g4?=
 =?utf-8?B?di9lQ0dzSGVPS1psQ2swL2pFVUpvSzMrVWpwbVVFSktQOW13MGdBeERiemRD?=
 =?utf-8?B?MHlQL0hvUXkxNzJtYTg1RDBydUtkc29OV3lSbTdIR0tNYURGVVcyNXlVNUs1?=
 =?utf-8?B?NkZNMGQzdG9QUk4ySDZ3VlBMQXBaUEI2ODZGcHFtcE5ET2d1OTJZdHQ5SnJY?=
 =?utf-8?B?bGx1YkVkVkhJOElndm5JSitHWUJVcHRRK3UxZWp3YmFJZHBieUY2RzB4QnQ5?=
 =?utf-8?B?SFZPcElMdHgzOEVvaU1ZWERZVVZZTzlGR3RSUFkrbzc1TUJBYUlZYzZUbiti?=
 =?utf-8?B?WGExazh5R1F5OEVIK3RTMG5qdjZRUzVsWjJKYUlCdkxrbStRSks5Nm1oRGtI?=
 =?utf-8?B?eW9nRkpHNTMxRUlhM2MrZlJFQmpVMktzNktaK2JlSnBLSVlseGdrb1ljUTdO?=
 =?utf-8?B?b1VneitXWkRROGJnZVU3UlBhVFovMjkwNnNwVGtWMnV4L3phODY2UHk4RVFx?=
 =?utf-8?B?d2p2SDFzSDRpbDdtWjFWU21rSjFZQ2RlaUtqWk53UVQvODZYb2tGdWtjeEVa?=
 =?utf-8?B?MkxDYmpMaEVFZzRlcXZJQWFYQ0N5MjI1cHJ4cnEwQS82bHA0ZzErWjhiRW9p?=
 =?utf-8?B?ZVRZYjVLVFhHYjJXdVh1amgxV2Q1OXZVdnRIY0p5emUxanVMQklzenQyV2FU?=
 =?utf-8?B?K211ZG1kRGxaU0FwWngyVUpCM2NQQklTdmZ4aWtDUlRJOTR1OFRSdUtBVlVK?=
 =?utf-8?B?TldUZGxsYWk1WnU3NDhQWUxzSjdSVFVvd0N1cHlwTTg0Q3QxbzU4SVFMQ1B0?=
 =?utf-8?B?U1E9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 083913ff-b57e-4f46-c539-08db84b4c999
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Jul 2023 21:53:41.6977
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gcoTuV+A3S5wxoV/AOmIGOj1JCCV9b+HzQ8ooZTFzNi5U4lVKJicPVNznSDoriX58VFOQ13JTUS66Yz+GkAY16yoMxPKVZT0hUvPMPiZ670=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB8404
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Babu,

On 7/12/2023 12:36 PM, Moger, Babu wrote:
> On 7/7/23 16:45, Reinette Chatre wrote:
>> On 6/1/2023 12:01 PM, Babu Moger wrote:

>>
>> Could you please add a snippet to explain the file naming choice? Just a
>> mention that this is done in support of other architectures that do not use
>> "CLOSID" and "RMID". 
> Adding this.
> 
> Other architectures do not use "CLOSID" and "RMID". Kept the names
> ctrl_hw_id and mon_hw_id to refer "CLOSID" and "RMID" respectively in an
> effort to keep the naming generic.
> 

Looks good. I would just replace "Kept" with "Use" since this
change introduces these terms.

Reinette
