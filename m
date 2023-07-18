Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE84B758627
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 22:37:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230388AbjGRUhf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 16:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbjGRUhb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 16:37:31 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6C3C0;
        Tue, 18 Jul 2023 13:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689712651; x=1721248651;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=9Du41TCB++BKdJI/Mo34cgLxhbC0A7uAT4jg7T3/qhQ=;
  b=DGmGR4hfcjnUGY3qCuOziMw1UifgQDyie/XSrZFXAxDm+DSYXV5SjLt/
   /GduIX7sh80LmI1jXF8FP/i1ASmyjDyJA5ciEbZaS4qojIs2cT4TKqjXV
   w0Dhb0F/Col/7ZDD9rrBHNsZ7l10vejiAp6TKLxe87KbKNN2pOKZE9E/I
   rLmLgVcHSktGzDWe3DPk8rqtfI/P4A5VHjzDh71tyrAotlY19NEH67fgc
   ziyEmcEAyf3tFWpaadXOsrvrDXg/zITVh4As63Wy3vRScbO8EQeU8QlzX
   udOP93sEgiQPliBSJ901lpspiwMUzOwWGgWAsRYgHEuWaWC7D/pFRULFG
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="363767958"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="363767958"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Jul 2023 13:37:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10775"; a="1054444221"
X-IronPort-AV: E=Sophos;i="6.01,214,1684825200"; 
   d="scan'208";a="1054444221"
Received: from fmsmsx602.amr.corp.intel.com ([10.18.126.82])
  by fmsmga005.fm.intel.com with ESMTP; 18 Jul 2023 13:37:30 -0700
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx602.amr.corp.intel.com (10.18.126.82) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 13:37:29 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Tue, 18 Jul 2023 13:37:29 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27 via Frontend Transport; Tue, 18 Jul 2023 13:37:29 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (104.47.58.169)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.27; Tue, 18 Jul 2023 13:37:28 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n8cpiDQ/n1U92IBhI1DfkVx0Ot5MOlyghFWAfR/Jf5V3nPqY4tF/NQG9511KDGvErR890H8N1Yp3zGma3OBZi+RfLJxB0Fn5kytEZoue3fdNiiX4WhzYV7pzRKaP9fU1/C9on94StFD/+NM9q57Ou7TDnD+y/MDq7n94XPsJ6FN0z1gDo1kZp8FNE1zPCJkLCs0a0rXKaXyHesnwgfp5WyZYFN3RpcQtFW8Rmuc7Us1K2tBaGorxiRpDI1YBA5J7wmdRg0v4ZG1rxfyzwpyqXRi3zoRAUbXfrE5hEx1+qefCV+GJi3t0pr7A7w9x5rYPpre4BtLF1UXIADTHE3bNug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mt19RKmVm9ec95XhLIZ0wZQqhDeqTz3yk08Gkx5mW4U=;
 b=J0l3bTxW4kGTAWmUxU0OsjfSVGCyPPKAkeI4tDyoIHV8qsl9ENCtTPlduccjSfZQ9AB9CDp4VQkMXNK7dbEQD6oyGFSNLRKGRN961Cm/bNPfI3bRCOZv+s1ObCfUd4LM6hjqGG+dbuelqSBh7c+mnx5M9s2HZK02Jk3mTIO5KJu1uVYbKWZ1nRbpGluIWcqiZyXIZqIxM6dp3drI5lfX+knnGqxd5/26fWkYPniOvrSY4K6HepXxkO0XVgWeQ4I+7NjPY441pVlNl8kNzpBszkZTUslcwVtcb8fVsc1gYgqPMxMCV7efUb+7anyFmQAeQ42jpYuMhazIeILAecmrUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ2PR11MB7576.namprd11.prod.outlook.com (2603:10b6:a03:4c9::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6588.31; Tue, 18 Jul
 2023 20:37:27 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::116c:1030:6e1a:be28%5]) with mapi id 15.20.6588.031; Tue, 18 Jul 2023
 20:37:27 +0000
Message-ID: <7f56cc04-021e-ff75-255a-dbfd80a3f6d7@intel.com>
Date:   Tue, 18 Jul 2023 13:37:24 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/8] x86/resctrl: Remove hard code of RDT_RESOURCE_L3
 in monitor.c
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>, Fenghua Yu <fenghua.yu@intel.com>,
        "Peter Newman" <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Shuah Khan" <skhan@linuxfoundation.org>, <x86@kernel.org>
CC:     Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230713163207.219710-1-tony.luck@intel.com>
 <20230713163207.219710-3-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230713163207.219710-3-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0059.namprd04.prod.outlook.com
 (2603:10b6:303:6a::34) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ2PR11MB7576:EE_
X-MS-Office365-Filtering-Correlation-Id: 73ac9017-c7ac-4676-8964-08db87cecca6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vgDMfjTpGo3JPyTtx4NQjty+rqqjrtLFwlMHXxUlJBDcMOW+5N0m4KepJRDNz9dsFtscCE+mWFnGSbLzPi41Z8kFRgVzR8ZjPkRwNXcl3iFlE84cs5reexH4Y/92MERw4o+/6KdeL06jOVcab5EbVeCZNYWb1270tMpnFoCWUFHrE7ZMQCSm5iDRXwNEeR42m15KS+7QhcyShLoOiEglv2DObu92RSb/HMtrmnsV4dsSQ+jrYOzVsJauJEQ8A7meXorEEAYVtZGR4G70UpBFrK9v5KoRYaoUIc2EWj+FosI0o4DWNUmgWH5UsecxtAy/IXuOiHHuhvKX+6qPfWTtzmETOhMP4sX4+JtvIXgw0zQFyW6lZiu7Y7GQINvSIyMb2nmKENd8B2qkuI6ynqef5w4N5sNMPeiEHTFJSV82Rjcy/lKLOBJCRX1/pR0GEIT511rNwtmb5G5dsWIMsy6hMMGD4B1dZNIL3QQtEydK6cEUwaPAZGYN9euUM+s5h9HA5SsdvhZD3mesutLhx2GRQYf208A+TbAyhrtneggT72gxVPq62Y3vh0993XSiU1Dw35iTu5nPs5A6xQJAOZlQcOhi6Vwru95/V5xD7RJoR+sGhdHiEEzbj2QMFjT45ARZyUb7ucdR4WMbhV5chqCRNA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230028)(396003)(376002)(136003)(366004)(39860400002)(346002)(451199021)(54906003)(6486002)(38100700002)(82960400001)(110136005)(6666004)(41300700001)(8676002)(8936002)(316002)(66556008)(478600001)(66946007)(66476007)(5660300002)(4326008)(6512007)(186003)(2616005)(6506007)(26005)(53546011)(86362001)(31696002)(44832011)(2906002)(36756003)(7416002)(31686004)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UUFxYjFWM1pwdkM3RGQvS2xPRUdvMGtWN3pDWlZHSTZBRHJIRjIySm93TUN3?=
 =?utf-8?B?MXlnMWZkMmNDWGRMWTVsTklBYkRSdlBTTnY5ZmFSeStTaW5SSndWdUo5KzdF?=
 =?utf-8?B?VkFDMFJoVU5WZFBFM3RCdWc4NW1tUGFaN1NOU0tBU0J6cDdpT08xWHhWaHdO?=
 =?utf-8?B?a2VLYmkwTDBYL0hCSUQrdEc2c2xSdXBxcjExR2w3YWt1akJiOFFrZEJpQmsw?=
 =?utf-8?B?TDA4b0xVVW9LR1JlMDU5K0FSRlR6Tld4QlM3NlVWN2lML2lWL2hERWRyTHhh?=
 =?utf-8?B?emladVFBcHh3Q1ZiL1NTNnZ2dnh4VkxObzU4R1NZZi9BajhCcEYzUyszcG1W?=
 =?utf-8?B?aUIvRi9CWlFiUzlwZHhhRGdSSEI3M0ZEbkNiVzFnUGZOZ2tvaGs2bEpQRGlv?=
 =?utf-8?B?U21qM1hmenA1U3FhRmprM0VyTEhMcGVJeHBlSlBuRy9OR3JQdWQwRXRkQ1A5?=
 =?utf-8?B?SzFwSWVOL2JyVEllSmRTWjFRcUppSTFhck9yck45Vi93cWJoaWlLcEtvNHM1?=
 =?utf-8?B?YTJWa25Bd3pVMEFhVUM2aTFnNThEbTM0VGZVMUhpVnhyNVZ4RWFyUGh3NS9D?=
 =?utf-8?B?a2NGWlh1UEMxaGc1YTZaRk5KaElkRTBKNys0V0tvTEdiN2ZvZGxKS0o2U1FD?=
 =?utf-8?B?TXRUQW8xMnhEVUVSb0FrOWVvcENXcmpYTDRuT3VpdUMzMmFjczNBdlZ2NDlR?=
 =?utf-8?B?djFKT2tKS3VJbmlIOEp0QnlPcUN6UCtUODIrUU4vUCtFUGlZNmhRZFJneTlD?=
 =?utf-8?B?YVFGdnRYUzVueGs0bUNMV1kramE4M3gyMkhoWjBPQkVnYXRIUGR5aEtIRWhq?=
 =?utf-8?B?b0E1Y3FodFYydjh1alpCRE1YUWdsWHozZGtRZFBxTExieFR0Y2U4V0MwWHJP?=
 =?utf-8?B?Y0MwN3RRbzR1UDZSbG5VM0I2Zk9NM3gvZTRqUURyRWVzbktiaE14VEJzMHIy?=
 =?utf-8?B?QUQzbml0Zmk4TkpWbCtiZjlGUm9MR3J0N2Zaa2wvZzlhbUxHK28wNGpwQURY?=
 =?utf-8?B?OHA4MkJ4TnJMUlI5S2gzWm8ySUQwUkhSOFEzVWNVMTFDdnVEUjNSbVBnZzE4?=
 =?utf-8?B?NXFpWDhsVzhrMS9FM0hFZGM0NGtHblk1ZS9EUmhmeExERE0xeTlwUzhVOFVL?=
 =?utf-8?B?aXA0VThNenhpSHdXUVMrd2l4bHNjdHpXTk5EeXlTcGZzbCt5d3hLdGU3V0xO?=
 =?utf-8?B?R0hlMHEzQUkrZjJoRWhTOWlsUUcrZ0pScC9JanR4TUhPamlocFRnUmJWWlJB?=
 =?utf-8?B?QVp2MlVxTC9oQWJZZ2xtSk8veTN2dEVLZzVIS09Obk9Mbmk2aWFmazJSVS9u?=
 =?utf-8?B?c2VaME4zRHRVMXhqYTZ6YTRXSlNrclZqL1VhajlxNFYvc3ZlUDBDS2VTNVFz?=
 =?utf-8?B?OFYvOUxza2QvdWNpUFJ5bjlQUWRNWlVNUlNPNDVLdFd2VDNxQW91RjdER3Zv?=
 =?utf-8?B?dFA3aXhPMGRlS3VNZ0szUWxNY1dVTVpJNkpLV0ZmN2t5OEpMeC8ydithbkl5?=
 =?utf-8?B?Vi8wSDRPcXU3RVIza0RtV2ZvTDlpcWdpUXk5UkNjNFlXZ3NWMHlzMnRrT1dL?=
 =?utf-8?B?Ti82cURSVTVTcUoyeEhCMlZMNncyY1lHRUxRVVUvNkNibWl4TzQ3Y3l4cFhL?=
 =?utf-8?B?K1ZjOGlTdmJ3NS9CdXVkTk5kZUZkdG1zekFCYzV1LzJYTlBCZXQwRkFjUklp?=
 =?utf-8?B?eDZZYUJmNHIzY0ROT1V4S2hremMvbHVxS1NxMXYvTlFCOVVFaFovUkNhK3VB?=
 =?utf-8?B?MHBmNUFPbmNoN3kyc1hFMC9aYkYwMG0vZ1VNN3lpYUpXSU01dXhJQ1o0YUlD?=
 =?utf-8?B?WldBTHBIUmp2ZVZFRy90N2Y4NGRJUSsrOUVsZzhVcUR3bEhKcGtvVnlMMmI1?=
 =?utf-8?B?TjZCNHhLcURETU83WDFyeXpJRkdHUThqa3ZtUU0rRlc3M0JpOFNVM25BeGZ2?=
 =?utf-8?B?bVU2UHMvclhVc3ExMkRyNytwRXRFS0ZEMnBjaWQ3M09SWjViRjE4bXJJMHE5?=
 =?utf-8?B?NFFicVZpTytXTmFnTDFpclVuNGFjWHp6SmVVU2NjN2gyVG10U21Sb0k0enUz?=
 =?utf-8?B?aDJONEdWVUc3eU9GQ1JPb2Z0K3ZzL3NDTDVibVlPdFh3Zkk5SllDNzV6U3hX?=
 =?utf-8?B?M0xvSUl3V3FLMWFkbllKVTVBbzdHSFFYZnRabkZqWjJGSmIyY3RIaHNmZUE1?=
 =?utf-8?B?M3c9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 73ac9017-c7ac-4676-8964-08db87cecca6
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jul 2023 20:37:27.0838
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: q8pVogmtUI+QdEL3fu+qSnh+k+qHTGo4QjkGwVoCLlvZvh/xy8HNUcfTOKwKDNvzupiMVkSJn838rM61BBCGqGbfQD9mnSoeMWC1f9lvMFE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR11MB7576
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

Regarding subject and change: Why is the focus on just monitor.c?
Hardcoding of RDT_RESOURCE_L3 as monitoring resource is done
elsewhere also (rdtgroup.c:rdt_get_tree()) - why not treat all
hardcoding?

On 7/13/2023 9:32 AM, Tony Luck wrote:

...

> @@ -759,9 +761,9 @@ static struct mon_evt mbm_local_event = {
>  /*
>   * Initialize the event list for the resource.
>   *
> - * Note that MBM events are also part of RDT_RESOURCE_L3 resource
> - * because as per the SDM the total and local memory bandwidth
> - * are enumerated as part of L3 monitoring.
> + * Monitor events can either be part of RDT_RESOURCE_L3 resource,
> + * or they may be per NUMA node on systems with sub-NUMA cluster
> + * enabled and are then in the RDT_RESOURCE_NODE resource.
>   */
>  static void l3_mon_evt_init(struct rdt_resource *r)
>  {
> @@ -773,6 +775,8 @@ static void l3_mon_evt_init(struct rdt_resource *r)
>  		list_add_tail(&mbm_total_event.list, &r->evt_list);
>  	if (is_mbm_local_enabled())
>  		list_add_tail(&mbm_local_event.list, &r->evt_list);
> +
> +	mon_resource = r;
>  }
>  

This does not seem like the right place for this initialization.
mon_evt_init() has a single job that the function comment clearly
states: "Initialize the event list for the resource". What does
the global mon_resource have to do with the event list?

Would get_rdt_mon_resources() not be more appropriate?

Although, looking ahead it is not clear to me why this is needed.
I'll try to focus my responses to the individual patches in this
regard.

>  int __init rdt_get_mon_l3_config(struct rdt_resource *r)

Reinette
