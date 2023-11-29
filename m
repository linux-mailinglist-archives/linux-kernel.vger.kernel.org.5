Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 167C47FE44F
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 00:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231474AbjK2Xsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 18:48:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjK2Xsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 18:48:38 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE2F984;
        Wed, 29 Nov 2023 15:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701301725; x=1732837725;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=05R7zsqi5TVrKsOIHC51wgUGqcwA987haiF8IJX3zrw=;
  b=ZZfP9glXyiKUY0Mlpjlm5XidgAqaMc2Wn38cc+lkyZXOPFSL5idNBKhV
   W76BQyP5xYRyabqOe9IdAz4zs9GT8iBitaLCDWQGZXf7z+7Ra0It03OCP
   OaN79rvPpY95Dkn5YGz0/zt3ns87p8AdPuhIovQIz5OTt64ZULoHMMjAZ
   XhXH5MpnV/gfR3dqbnPc0DBO7hoESXQyAaNKPLvHzpAmthOtd84eJlJP5
   WOZdVObCJgNX27buyw5TO6+xcGlsz/HNF3byE671BerBQ0ZsiFFgdyW0P
   13QA0vPkpxPdhg5EbfbXICbtL3NTXZdJXqK4w8Z5pc/SJmoact8UDFukC
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="14799173"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="14799173"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 15:48:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="942509622"
X-IronPort-AV: E=Sophos;i="6.04,237,1695711600"; 
   d="scan'208";a="942509622"
Received: from fmsmsx603.amr.corp.intel.com ([10.18.126.83])
  by orsmga005.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 29 Nov 2023 15:48:43 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx603.amr.corp.intel.com (10.18.126.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 15:48:43 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 29 Nov 2023 15:48:42 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34 via Frontend Transport; Wed, 29 Nov 2023 15:48:42 -0800
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.101)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.34; Wed, 29 Nov 2023 15:48:42 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=B0l0rGnmSeWuyFbQiIe9X+Izq15F10FosgruNVwhvfXGjEzjTRTUG5Nj9xxjSsTYHLke59Iwp2Zyu4ef3+fj5h8BzyFNu+KxTOeaKxmwxR1nCPDt7zxdIbootcoyUQjGrgxB1ApfjobRfsOw8kxhZI1Ii9y0bpvUlqXHbZWK+DCwB+fYqrkuuTn+lvBX9hTYhctMPISG4uqDWmAsLswgzqDVRID3PT5Su7Jq7Svzs7D59d476L00eCIIb2GUgeVE0Y8LNZWGFwY1Wdz2jscvM+b4ZXd9BkyHiG1fnYkJUSkMRjNxD+DVAZXYreDXpn8k3Edv0QC//G0hOAs0dLj3ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=PAPSmR4RCDbK3BXHfFxRVOQlaaSTlY/Rvt2Y2t9xtww=;
 b=UhzNo+d6cGj1gfO0vWWTrGfGGVFSnJKIivCHtmVnkJI30LEylQp4qdOF9iSir3RIpfKTGEceknuRWBOlRRNkocm8hgWiradLoW5sk53Bml0cRC6kEz22X6q4jdEdj1mMXWCIF0ppehbzb/YoZ4tFQT0Xl7WcV6g0hUYNADktSYBcThfYQYYCGZup5J4fD9feEwjidvw57yuaRo+A6jIVyhXAdIppi6xa5Kn8vefpiZdXCyP4gbG9lQtrtzIgYRrb83sasr80NRwSXRVYpxFVFeRvWUS3H6pRzs9BXNbJ2zMkwhhHMfBCClJ0I77v+iusdIcNpUY4P9eRde4wIOvjhw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7334.namprd11.prod.outlook.com (2603:10b6:8:11d::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7025.28; Wed, 29 Nov
 2023 23:48:40 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::6710:537d:b74:f1e5%5]) with mapi id 15.20.7025.022; Wed, 29 Nov 2023
 23:48:40 +0000
Message-ID: <95a21b05-1838-4098-854f-f60f82f26f5f@intel.com>
Date:   Wed, 29 Nov 2023 15:48:37 -0800
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] x86/resctrl: Add mount option to pick total MBM event
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
References: <20231026200214.16017-1-tony.luck@intel.com>
 <20231128231439.81691-1-tony.luck@intel.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20231128231439.81691-1-tony.luck@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0310.namprd03.prod.outlook.com
 (2603:10b6:303:dd::15) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7334:EE_
X-MS-Office365-Filtering-Correlation-Id: b5752ccb-499a-49d3-7e47-08dbf135b66f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RUB99JPz9uUKuGVkGEsw+6Pu80OOVQFcr04vURE2Wi9NU8CWcvGjTzEn4WVtxVg+uZMi+8tFRQ5DGPcfi8s56G+MBxP40odyS+HZwTu3ulIw60wZUNWmDyfvQzXvktg3lWrk+ddPuPCOYUGbuR/82PPhQqTxh2hAi1+LlHLInuXg4Pvk4/vO59IkFoFaT/YrVvL/5110RFEepfsfQ8anKMl2Y4l9sQJv52TpbsNxkPbSJzTk0324ed/F4TgREYx9EJNzdD0hr2m1F9SBawD2jRMsMyZK2+NrBDgp3RwcxNIbgM1rglgvZYTRi99qDnr85oFZcAteLEcObCf2DPrMdcg9+SmSmDpoYApJPmnzzSHKJHaQrr3Sk4boV77+/BMySOfFfek0Ig8/0Loww/XwHQzmFxDR/Q2osCvgLNWYehr3q7t490nvf/9KU2KN6DsNg+n8wORMmO9+chVrstEBwEhZnvHAV+Mw6Jv5q9WK/9AzWPcNXjlAD1FBQrGeiMzIa+j/rbG1PZR1Kro3go96P62ixz68+/dK7Cbyf6pea0f3RSg+cT+21sdsgVpPbO8eqBOvxup4KewU12xNc4DkOIF3Kp3xAaf/CdZce/ySrTa4HU4o9Y0s6JUdReyKVkBOKDWZCwBV0njCZErgAgmBCCpoREQY4rNoNyKLyjD8/phumcYp5O5/P3poRja+Yf+d
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(39860400002)(396003)(376002)(346002)(136003)(366004)(230922051799003)(451199024)(64100799003)(1800799012)(186009)(5660300002)(7416002)(31696002)(6666004)(2906002)(86362001)(8676002)(38100700002)(66556008)(316002)(66946007)(66476007)(54906003)(4326008)(26005)(2616005)(6512007)(6486002)(110136005)(966005)(8936002)(6506007)(478600001)(82960400001)(36756003)(83380400001)(53546011)(44832011)(31686004)(202311291699003)(41300700001)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WDVPSkYrMC9URDlTS3VzNi94L29rbEIwemdhYzRCR3BYRklUd0FwMmo5dmRw?=
 =?utf-8?B?VnVaSFdiY2F5UGQ2NCtBUk5VTDJHd056dEFhTnpmVlowTUV0WitSY0VBaEQ0?=
 =?utf-8?B?QkljTVY5V2hLS2tOZk94a2crRlc4bmUzWFBYL0RjRG1TNlFVRkNnNUpUTkJJ?=
 =?utf-8?B?RGVYODAzK0FQSXNDRWZNL0pQWmFnWXNDZFY3bVdtOXNNUkYydEl6cEdXcUlS?=
 =?utf-8?B?aDA4eVFVMzBFL01MekxBd2d1NTlyVm9ucUs3dkZjYmNVN29zZStVeXp2QUVl?=
 =?utf-8?B?cGJHK2wweHQ2RGlrZWhmNmJ2LzZxSit1VFdJdGpFa0lKbjV3djVGK1JlOUMr?=
 =?utf-8?B?ZXU4d1BRSTF2WXB6VzdjRU1RU0NCSFpLSHh0bmJ3M1FxR0VyQzVUeFZxZHBJ?=
 =?utf-8?B?SHhCWXBHbHRINXY5N2VyWEZybW9LOFowczd5QmkxZ3VkbGxITlNVdW9sN2FB?=
 =?utf-8?B?S054TStLd0QzcVBJL240M3lPcGhZc3IxZzZDelUxZXN3dnNNcEZNME1GRU5z?=
 =?utf-8?B?THpiSWpnN0ZwV05PR0R4S3pkaVNuSGhZbU1NY0VsOGdDamNVd2RUN3AwaVl1?=
 =?utf-8?B?eW1vcUtxVlVXRGsrM3NqMGVxNXRhMEJrWmczY1NuQzUwVDJxU01IRmxwTzRy?=
 =?utf-8?B?MXR5TVYwQ0VkTUlGdmdUSUx6cTMwSkZSNmdxejR6RkpVTktmWnp5SlIwV1BZ?=
 =?utf-8?B?b0hJRGNxaXBUUE5yV245aTVwUmtHZ2xyNTc1czVrQ29VSmdZUWV6TVl4aHhx?=
 =?utf-8?B?dmp3RDBOT1RZYkxZZmFISm1BSjJDT3phT29JazBIOXZ0TXYvZThDMGwrd0Fh?=
 =?utf-8?B?ZkRpQWQ0VU8yN0xnSEtBUEtCdzFzVXdNQXJ3SDRod283UmdwcU5iWFI4WFlW?=
 =?utf-8?B?QUgwNCtiTUdLdXg0M0RUSzlIU3E5NzFtMlNkdHo5ajh4T25jNmNLZXc3NkUy?=
 =?utf-8?B?T29WV1Y5T1VhN2k0bHoyZkI2TlAvRlFQbkNXK1gzSkJ3elhCRDVoL25RcXpq?=
 =?utf-8?B?anBudEIxSUJzR1FxRUg5Zlh2U2NtUXEzTEk5TkNLSjlvdlhET0RzNTRDTW5T?=
 =?utf-8?B?YXY1QUFmTytxZ2lzUmdUWnl3RFF6WXMxbng0TmpsRGxvZHFTV0N4VldFL09I?=
 =?utf-8?B?YWJiUEJnOTNoZGxwdjYzWTBXQ1V0RzArTHY4d2duZ0YrT2VPZXFMc0l6UDBN?=
 =?utf-8?B?ZU5KejdrV2JzWXFoeFdydE9lakN5cFVpU2EvdFl1M294clFwOCtMQXhJajlu?=
 =?utf-8?B?alBPT0tYWCtiTTh1WmxmSWdqL09ycmVUd3pwNWMzVHVQYUptUCtBczRJZ1g5?=
 =?utf-8?B?VGszOVNScE04V0lDdzM1cDVKOFRucUdQMllVRlh5ck1PWDdqZFJnSE5qMnlr?=
 =?utf-8?B?M21yZC95L1Bsc3VVZ2kySTEvNkw3d1lDTmd1WkdXWFRFUXJDWGdsZmdjYmRw?=
 =?utf-8?B?U3NwTk1JOFFLRkhwVTJPeGQ2KzNJclp3c2oxNmhuU2RCQVU3WVNFa1JPQlI3?=
 =?utf-8?B?NnlIcDcrY08zeDBDYmk0SlZ3OUsrTUpsc3ZLVjNQNUwrTmFtZTFxTkd3S29U?=
 =?utf-8?B?VW40M1VkcnJ1aTB5aFNUeWl3d2N4aUo4cUluVE1MeWxUK0NqMW16L3B1dDVI?=
 =?utf-8?B?aUV0dndJenVneGlBd0Zydkt6U2RaN29lbEt1cmNVZEdrL0dkUU9wcDdHOGo5?=
 =?utf-8?B?VXUwKzhFc3dCeUxWOHpLL2pLdHlhTm00eHE1b3F0Qy9zNnpzaXNHbE5HWnhJ?=
 =?utf-8?B?a001dFVlcFZsVlZBWmQ2WVIvbHR3VkYwZTBLNmREek0wb1QzeExrbWZTSUkv?=
 =?utf-8?B?dndBeFVsdmNtaFVFcXV0TjRxWUxINDJBMG0rK3N6UDlyWUZnVkpEbEQwVmFs?=
 =?utf-8?B?clVBTElSR2hqdVJwS2FnNk4zelBoTEJnUDVtdzlFWDdtMnloR0pvMFAvMGht?=
 =?utf-8?B?MUhGY3FQMWpMaFpSbTVwMEhmQnFpMjc2aE5RMmI2WVJkWkZqMnZyaTBHQ3dE?=
 =?utf-8?B?TkowU0FXU3RjYndJNmNqQksrdlBrYzhadWhBd3hWd3N3NWR0UkxUMWVNQ1dW?=
 =?utf-8?B?UVJoRmkzdHEyZHhubExmSFpSNVduZ042MC8vZlBzVko5bWhGMFBQWDN3VFE0?=
 =?utf-8?B?R2kwY2ZYMjI2YlBZWC9PbHJzdVFIMWdsTGk1VTlHRjlyanVQWjVtcDdLb2xT?=
 =?utf-8?B?anc9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: b5752ccb-499a-49d3-7e47-08dbf135b66f
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2023 23:48:40.0939
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: D7jBfkveaYLDgiiMuFH6GsqUX4R5suGBBhe1pqWT4inFrHsijPpRtFIF/sumCxJd9ducv2hn4LAjOG+0dx+I/587v/GLwWQa2dmaasOJl7Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7334
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 11/28/2023 3:14 PM, Tony Luck wrote:
> Add a "total" mount option to be used in conjunction with "mba_MBps"
> to request use of the total memory bandwidth event as the feedback
> input to the control loop.

"total" is very generic. It is also not clear to me why users
would need to use two mount options. What if the new mount option
is "mba_MBps_total" instead, without user needing to also provide
"mba_MBps"? 

> 
> Also fall back to using the total event if the local event is not
> supported by the CPU.
> 
> Update the once-per-second polling code to use the event (local
> or total memory bandwidth).

Please take care to describe why this change is needed, not just
what it does. This is required by x86. For confirmation:
https://lore.kernel.org/lkml/20231009172517.GRZSQ3fT05LGgpcW35@fat_crate.local/

> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
> 
> Changes since v3:
> 
> Reinette suggested that users might like the option to use the total
> memory bandwidth event. I tried out some code to make the event runtime
> selectable via a r/w file in the resctrl/info directories. But that
> got complicated because of the amount of state that needs to be updated
> when switching events. Since there isn't a firm use case for user
> selectable event, this latest version falls back to the far simpler
> case of using a mount option.

(I did not realize that that discussion was over.)

> 
>  Documentation/arch/x86/resctrl.rst     |  3 +++
>  arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
>  arch/x86/kernel/cpu/resctrl/monitor.c  | 20 +++++++++-----------
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 ++++++++++++++-
>  4 files changed, 29 insertions(+), 12 deletions(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index a6279df64a9d..29c3e7137eb8 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -46,6 +46,9 @@ mount options are:
>  "mba_MBps":
>  	Enable the MBA Software Controller(mba_sc) to specify MBA
>  	bandwidth in MBps
> +"total":
> +	Use total instead of local memory bandwidth to drive the
> +	MBA Software Controller
>  "debug":
>  	Make debug files accessible. Available debug files are annotated with
>  	"Available only with debug option".
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a4f1aa15f0a2..f98fc9adc2da 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -59,6 +59,7 @@ struct rdt_fs_context {
>  	bool				enable_cdpl2;
>  	bool				enable_cdpl3;
>  	bool				enable_mba_mbps;
> +	bool				use_mbm_total;
>  	bool				enable_debug;
>  };

Why did you choose new member to not follow existing custom of having
an enable_ prefix?

>  
> @@ -428,6 +429,8 @@ extern struct rdt_hw_resource rdt_resources_all[];
>  extern struct rdtgroup rdtgroup_default;
>  DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
>  
> +extern enum resctrl_event_id mba_mbps_evt_id;
> +

This global seems unnecessary. struct resctrl_membw.mba_sc indicates if
the software controller is enabled. Creating this global fragments
related information.

One option could be to change the type of struct resctrl_membw.mba_sc to
enum resctrl_event_id. I assume that 0 would never be a valid event ID and
can thus be used to know if the software controller is disabled. If this
is done then enum resctrl_event_id's documentation should be updated
with this assumption/usage.

Reinette
