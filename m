Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313077B2591
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 20:52:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjI1SwS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 14:52:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232246AbjI1SwQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 14:52:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1523E1A5;
        Thu, 28 Sep 2023 11:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695927135; x=1727463135;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=5ZPQovn2sByNfGeDOaCQf/e9pdgs+Na3l/+yFEJ/lxU=;
  b=M4OlJVZZtwX0HuDlmCW7lxzdP/wgT6xRZf2srZBQokpJImU8k6v3Ul9C
   54H4wVTDm4DMjQpkvS4aebIyin66r502eYU0OdRugepoT8uA2b7Gn9AUo
   G5yE98WxhfGYLV9Vh1Ewbb5cAW7VjkOnnJRqRk9RSp34yWGvo/wIrCHCP
   cCJ/UJgufjhYfGXEq1f2/LETqSv9VWbdJ4Etvd11gfeTYGbxtmZqaowpS
   7H8t4+JYp3MyF9sKbrbMd0gOSp4ziAspa0GNKPeDWWIgo/QsYGT7GalmG
   AXhKhn3ah2Eifu4P9F9n2/qP2lVuWdY2vRgSYz1m8j+G+9243Tj8NtbwR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="362393994"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="362393994"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 11:44:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="1080665091"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="1080665091"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga005.fm.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 28 Sep 2023 11:44:54 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 11:44:54 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 28 Sep 2023 11:44:54 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Thu, 28 Sep 2023 11:44:54 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.107)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Thu, 28 Sep 2023 11:44:53 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oPBWOZQK7XdctTaQKMeOrR/2UvevpbM7VFBqF3sNo1ShQHkBEQD/AkLZwuA0Sk8uzEy68b8AjQvEMEqk+eBlZx+JSUtgCVexY9MeWPuNktr+TBLz63BG8CvmzSwEEJn3pdxJlDZ5zL1AZIaBzBvN8xu8Fmd/AW4XhZMZHevZ4Z7FGV2O97gbaL+gBYjf8eWu1aeOb31fB1mszB7wG/nBkp214lgpw0gp1/6t94f5v5lVhPkM4ztVH1Ro9cDrEbCDpw3dGz2iWLltkti4cSowDtcz8Y6mKaPv4r1m1ZAXS135+TS8gs5G8wScLyP8pk6e0h3xZIYtrYqutTy+gOlYKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/F2vO3bH4K7dT7s7fUW+xDK+2tdA0B8cr2aBhXADrDY=;
 b=XvgNLvdSniZ1J53eYTZHfW6ZWzitpZgcUMp+EIPlUB2sf687GJIyNwo19yosH06A44UCBQwPiH+fO840F2dgHvi0T1qA1PLgOxzyEdCip2LfF3IqnRl3mwNsYItfW2ewA+F7kuaMNcJZMNgRvhvgHSUVN57xaGQGPYOfp7gkOTojsv1Zpcqm18Lb79xL9QkG2JulzSLNSJFYjbegdC7j3WQckLLSwvKgDiwiJoRVBGOYcyl2tT2NcxmyQqjayB5Cnqlt0MXzjSV7UGfmUY4S/4AdiaWawZ60CrURpaNnj7ajMcnBGx+51QXxGvi8Rny5y19zULr9oS1nfP07XMZ5Vw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by SJ0PR11MB6816.namprd11.prod.outlook.com (2603:10b6:a03:485::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Thu, 28 Sep
 2023 18:44:47 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6813.017; Thu, 28 Sep 2023
 18:44:47 +0000
Message-ID: <66d91674-fc2d-638e-ff92-7d3515e3aa08@intel.com>
Date:   Thu, 28 Sep 2023 11:44:45 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v5 6/8] x86/resctrl: Sub NUMA Cluster detection and enable
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, <x86@kernel.org>,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <patches@lists.linux.dev>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-7-tony.luck@intel.com>
 <20c243fd-5068-b8a0-31d3-369b739ff1ca@intel.com>
 <ZRXCHVhpxhD6Joo8@agluck-desk3>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <ZRXCHVhpxhD6Joo8@agluck-desk3>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW2PR2101CA0030.namprd21.prod.outlook.com
 (2603:10b6:302:1::43) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|SJ0PR11MB6816:EE_
X-MS-Office365-Filtering-Correlation-Id: ef037727-49db-417e-87a3-08dbc052fd46
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: oDE/mEnDS88sEVi1OxKhbMZNAmnQO8v2BX4LfSQFMJe+o3lAJYBKX+sx9ERUs13ix75/UQ2hgogM4Grf/oMxUAX+t428uA7DeZOzItlcbzoTmtW6jO6JDXqXr54NXFTt6N6HXT0LAlkHeTSFTixDxAp1VHWZ/13dl3aDBR/6KEZCMxKU2nisqc1/2nRFw+wMvHz7DsgKWLYd42xB77hR9vnmFLHmei7JjsWJ5aPy4se9WUUwkS7Y8yKHaVzX+calfguo5wWWtFbiUG7FWk84N94ogwKDhJBY/UJHH+8PlOnBJBJTER/BOdyGxURXFS3tcfr4Zqi18Q+2vWHGbeZ38Dd0in1q0i9pB93/6n2KCCWWGbWuPXgkojVI+QpoKQtnMIVeNlfaQ5T8f6BUV1kzsIljfFBo8YNO8M2Bf8c7Obh6qAXuhp9pFiox5LOYk1fPz9fEFPCgREXovGBB6KuVkquY72vl7Vv0z3QTVdrvRPr4e6qWy4NjdTxSBU1p7vlfcJnYW0+qmEqSqL57c2OArYqpAzQzhc4Q5iU/vsCRu+hwZA37cChwOZCMKkn5PIieIZQpDHRHhcybmXuo2WAnTZF8A28vhJZJdWuRYv2Z1pjovLpd1m/ww39QNm8OHyrSup4feSejTcHcXgYcoEmLLA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(136003)(39860400002)(396003)(230922051799003)(64100799003)(451199024)(1800799009)(186009)(37006003)(41300700001)(6636002)(54906003)(316002)(66556008)(66476007)(66946007)(8676002)(6862004)(8936002)(4326008)(31686004)(5660300002)(44832011)(7416002)(53546011)(478600001)(6506007)(6486002)(26005)(6512007)(2616005)(83380400001)(82960400001)(38100700002)(31696002)(86362001)(36756003)(2906002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZjlWNzhmTjhSUGQ3Y1lTU09heWxUdFE5bVlkREJMMFlRVzhnNkJrQllZRWlE?=
 =?utf-8?B?cUx4UGNHZFZmR0c0MEFhVE5ES29BV3dlbS9DTnVEbU40MXM5bTNRVS90eTk0?=
 =?utf-8?B?ekVpTmRPSU92aVVhT0gxY2oraEJRbVg1OE8wZVUzbjBreURDS0FvSHlidUpJ?=
 =?utf-8?B?U2lXK1ZocGdrZ2Jyb0YxQ1VvOHVxcFZHUDNQZUlvSzJqYUFyMkxpUUhhbWJC?=
 =?utf-8?B?cThyYlhBaFdLZjFtdExHbTl1bTVmdFFhb1Jya25ubXRtcGordHBNbEY2cVFM?=
 =?utf-8?B?ZE9lSklIZThyMDYwS3ZTcWhMcGdUNWVmWWM3ZE5WWm5ZdWg4K3E4Rk81YU1v?=
 =?utf-8?B?NTVacmxjQ1k0TlZBUW1Bb3krUDJkZzlvUk1xQlpzUGFmVWdGRkR4a1Flanlk?=
 =?utf-8?B?a3JtZHE3UUdYSmsxNmtDNVRBa0JtdS9CVzlWYU81NEFZRWQ3NUtpbXdTbm84?=
 =?utf-8?B?TVVFMmlwRW1GVjIzYW1welZBL0hYaDRZcEVNOVI5ckFHdWo3ZXhGaUg2cldS?=
 =?utf-8?B?c1ZSdXpaNXNLcStJSTkvakFhSGFvOVkwSW9nSEl5dHFZK0taaU5hTjEvQ292?=
 =?utf-8?B?L3JVWkNyd2RmcWc5RzI0aW9XZHRHRjlXTjVmK2piTUg3SHFaa3NaTzJQaURL?=
 =?utf-8?B?QWswOUZwR0lMVTN4RUpheGl1NWZmU0JXUXpMSG5wcW02N2c0S3doaGlkT05a?=
 =?utf-8?B?TnZkR1FESmpCcnQyZVp4M29OYmxhOHpmdWpnbHBTQ2IzWW04TnE4c2dyeFNU?=
 =?utf-8?B?d0dzUUVyUm8wQnRvNmxGWEUwV2dwZjEybE1wcndoSWxabHc0dkRWN1Y0bTJi?=
 =?utf-8?B?eW8xdjZhV2V5T0ROU1ZvUjNoTE5Tam1BbVNrVzlaWEFLWTduRDdrNmhpU0VP?=
 =?utf-8?B?RXJrQlJDRGJuN3E5OGM0ZEluU3pFRzJZUmxWb05EcHBxcWVqN3l6blM0MGZT?=
 =?utf-8?B?VXVqOHJab3puUUpJV0xzVVd1N3ZqV1FaaitUUC90d3piUG5uSldZaHVnQWJ5?=
 =?utf-8?B?TERrdHMxS1ZkUnZCMG9FZ3hhYXFjTXh4dTJVcC9Ba2pJRExuY0xPVUlKVTk2?=
 =?utf-8?B?S2cxNENrV2oraHpqUDlMREpTcERpR3RzZzNjbFZmWXB1RTRnSisxUkk4UHVW?=
 =?utf-8?B?UzFiRjlvczduaVIyNVE2VUZTUFI4VFhyUVBNZVpwVDF4cU5YZWlLTy9CY2Vt?=
 =?utf-8?B?NnhSUktCcWlLN2lqNERNL2xyWitQMkhKc21HNWxvZHRjUDJuSHB1ZThYNTdP?=
 =?utf-8?B?aVdleUhFeGI4VlhKME5IeXhBQm9kY0Fidk0zaWtkUzlJK2xvWG9MU3pka2t2?=
 =?utf-8?B?VnFOMHV3OTB0Q251eWFIN2dSMmxxdm9wTGc1SVo3TEYwcld5OUlUMy9wVTNs?=
 =?utf-8?B?aEF2bEpqUEh0NHRiUklPY1JRQUpZR0M4MnB0UG1nenNJMkF4Mmx5Z0tqN1Ay?=
 =?utf-8?B?MG5pR2g0dDlDbURzVEVYdlJ3enJyN2IyaGxMNE9QTGhROFFIayttcGQvL0pj?=
 =?utf-8?B?a3RSb2cwcGhNOTJBaHFCYStuanhNbW1qQUhWWjRac0pvTlJha0hxR3RBZ2Rt?=
 =?utf-8?B?NmcrQ1BhR2NzZitxZHdkbFNDaGRocmRRdWlkRjMxaklkVjdGQXltNEphR2hI?=
 =?utf-8?B?WXI3OUNPajQ3Q2hiOVcvdTlaMThPSVAwby9LdXpOZUVnWVFybEIvc1hHOWdM?=
 =?utf-8?B?d3BBVFcrYTlJalQwbUNPemJSZWFBY2xLckRCTWtBcTlnUzlhK1lHYWlJb0Ry?=
 =?utf-8?B?SFQ2SUNXTGpjREZLcnF2bWdrWjdOWTQ2K2ROajdmWnZldVZJdmxxcTdqTEhO?=
 =?utf-8?B?dWpGYmRCTGZGY05CaXpNRzBuMW81cHZORVRtbHhVQWFVU2MySG9NOUh0Mm5l?=
 =?utf-8?B?cVA1UWs3TnI5bmc4aENhUHJ3QUt6MldpN1hQMS9xZ3BEUHU3RTNHVEFkdTli?=
 =?utf-8?B?TnRBVUtnRUZNZWg4dGIxSkVLcUg3RkFaK1JKeHR0NS9GUXhsM2hDbWFxYjhn?=
 =?utf-8?B?dnpOYVJINjVjTFYwOUt5YXRObFR5Qy9JTXFFM2RqNkF5L1FHVGl0MEloUFJC?=
 =?utf-8?B?UVlCeVNOUHkxYVRSOE12b1kxNW9nUnV3bFdqL2Q3SmZMTE9Md1NoRXRIWWdU?=
 =?utf-8?B?VEVRb0RmbTg1S1VqbytTN3Ryczd1L1Fvc3d5cDVCVFE3OTBlZ0xWaHRJWjFW?=
 =?utf-8?B?VkE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ef037727-49db-417e-87a3-08dbc052fd46
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Sep 2023 18:44:47.3513
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: GEb7PAYTfaQodOonBv9iAYoi1mDFhIhvK5g+mmK4bOEpUYsj4aTqQGVeC+rmiLtEiVY/JdJSId6sjoXtnabW/LmxPybeQ/c1SSYqFxI1t6s=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR11MB6816
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 9/28/2023 11:12 AM, Tony Luck wrote:
> On Mon, Sep 25, 2023 at 04:29:44PM -0700, Reinette Chatre wrote:
>> On 8/29/2023 4:44 PM, Tony Luck wrote:

>>> +	if (cpumask_first(topology_core_cpumask(cpu)) != cpu)
>>> +		return;
>>> +
>>
>> This is an area I am not familiar with. The above code seems
>> to assume that CPUs are onlined in a particular numerical
>> order. For example, if I understand correctly, if CPUs
>> are onlined from higher number to lower number then
>> the above code may end up running on every CPU online.
> 
> This sent me on a voyage of exploration into early Linux
> bringup. There's a CONFIG_HOTPLUG_PARALLEL option to bring
> CPUs up in parallel. I have it set on my kernel, but I still
> see the "announce_cpu()" console messages show up in monotonic
> increasing order:
> 
> [    3.148423] smpboot: x86: Booting SMP configuration:
> [    3.148940] .... node  #0, CPUs:          #1   #2   #3   #4   #5   #6 #7 and so on
> 
> But, without solving this mystery, I realized this doesn't matter.
> Whatever order the CPUs come online was all completed long before
> resctrl is initialized:
> 
> 	late_initcall(resctrl_late_init);
> 
> So the order that resctrl sees CPUs is dependent on the callbacks
> from the registration with cpuhp_setup_state(). That happens with:
> 
>         /*
>          * Try to call the startup callback for each present cpu
>          * depending on the hotplug state of the cpu.
>          */
>         for_each_present_cpu(cpu) {
> 
> which is going to call in increasing numerical order as the bitmap
> of present CPUs is traversed.
> 
> If someone changed this, the only ill effect on the code I'm
> adding would be to set the MSR multiple times (which is
> inefficient, but won't break anything).
> 
> 

Thank you very much for investigating this.


Reinette
