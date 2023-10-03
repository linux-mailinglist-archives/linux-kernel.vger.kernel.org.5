Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD177B731A
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 23:12:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241142AbjJCVLv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 17:11:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232343AbjJCVLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 17:11:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C95FBD
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 14:11:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696367507; x=1727903507;
  h=message-id:date:subject:to:cc:references:from:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=OtE8Sq6x2/UQJ+4lg2vTBhiwB3lut4qANGiHdW1jIO4=;
  b=WQYwxvMC6P0K78GwLZXw+lbj9maE8w5LJ0y5P37SXNv66rVvGDXYRxJ+
   8rLJmH2lDWo+8RqQ1NbgYazpMtHrmQPsnUhNJxkVRsj83bqXwNwlnav8+
   j1f6OZVqvwZMRhaQX2bEVado0j7wpAOcPJFYi8zplpJtCJxnCJbMcQvSx
   TiyVIBwZqH0IM4mK/dLDMdI7Vns2nzfexb6tr0TqFSYl0ICZBg+dvbZHo
   7MJd6hTlb1ZVt945fTn5cC2PEqfrxoG1NtllkxSEryD/sP50Nnz8d2SPo
   smzoIhZlIFiTzJiUW9vIF1ZOjJEqEawCyfGshOo9DW2eW8XFPR6qhXIT+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="385797750"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="385797750"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 14:11:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="786237324"
X-IronPort-AV: E=Sophos;i="6.03,198,1694761200"; 
   d="scan'208";a="786237324"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by orsmga001.jf.intel.com with ESMTP/TLS/AES256-GCM-SHA384; 03 Oct 2023 14:11:47 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:11:45 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Tue, 3 Oct 2023 14:11:45 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32 via Frontend Transport; Tue, 3 Oct 2023 14:11:45 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (104.47.58.104)
 by edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.32; Tue, 3 Oct 2023 14:11:45 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iNEtuzEQPbDNWptTJ0+ba3daNrtHQKFV16ivkovXgdmrgRV26vuaNhxoVkza6j/zRSx3UbRlvxmkgqg2Em95wUZr77G+arHvqB+7Xeo8/Xy1+g46hByT4NxJx/3imHkE6CbdL4Eu2qU9o34Y77Z8yvGVjGv8yPYZZ9so2Nf2CvlfBuh1QVqF9XYOckrsTjVgS+6Z59bZRmjIXTuRiGlZ6lpUAI1S7vRp0hdAVu5bpbGkLE2wjNFCigtspSNr/uDUg2l+T+bNDNeEmeyEWXZhkM6PHVcD+Bbsd3x11GLTvWTII7agCU+VanrxBAwaPyCt01o/71O5PO8bwDM/sDOCAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nsgaXXvZRrkHatQjqEeKNPWKEzCrDomfCWx2j+CKzCs=;
 b=aRXygkZiMiw6dD9Q5QZBIfZbLPahONpBo/q8GsfW6Sd0p4IrKFmaY+fLPdYdAs7dAXxFsABLRbiwOrFl1zpbwjQtl2snK0wOoIgQvRuqn24cB8eGplxY+M41LxIBhrUe7SiKuhQl0N/GskhfDIN3FDmxrPxRd8h2oLZSMkqwv5VmZZpJdnO/PfFuDZlqfq/c5zvsTIs1G09a4tniGlguLSVRy/utQeWuSEeLxEJXrGWQuOWcwp1LRlEcYtPVycGXENy/2tFgIiTL8Gqi5yoGt1a0tyTmCnAb5SpygeyB4GRXUhVTOwYUa5ErGNVtfZIQh2ox3lGKm78j/eSmjXIliA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com (2603:10b6:a03:4d2::10)
 by DS0PR11MB7577.namprd11.prod.outlook.com (2603:10b6:8:142::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6838.27; Tue, 3 Oct
 2023 21:11:43 +0000
Received: from SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e]) by SJ2PR11MB7573.namprd11.prod.outlook.com
 ([fe80::bd70:f215:4a97:c84e%6]) with mapi id 15.20.6838.033; Tue, 3 Oct 2023
 21:11:43 +0000
Message-ID: <a362e485-f063-e53e-87e7-ac87bca9baac@intel.com>
Date:   Tue, 3 Oct 2023 14:11:39 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.15.1
Subject: Re: [PATCH v6 05/24] x86/resctrl: Track the closid with the rmid
Content-Language: en-US
To:     James Morse <james.morse@arm.com>, <x86@kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        H Peter Anvin <hpa@zytor.com>,
        Babu Moger <Babu.Moger@amd.com>,
        <shameerali.kolothum.thodi@huawei.com>,
        D Scott Phillips OS <scott@os.amperecomputing.com>,
        <carl@os.amperecomputing.com>, <lcherian@marvell.com>,
        <bobo.shaobowang@huawei.com>, <tan.shaopeng@fujitsu.com>,
        <xingxin.hx@openanolis.org>, <baolin.wang@linux.alibaba.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Xin Hao <xhao@linux.alibaba.com>, <peternewman@google.com>,
        <dfustini@baylibre.com>, <amitsinght@marvell.com>
References: <20230914172138.11977-1-james.morse@arm.com>
 <20230914172138.11977-6-james.morse@arm.com>
From:   Reinette Chatre <reinette.chatre@intel.com>
In-Reply-To: <20230914172138.11977-6-james.morse@arm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0351.namprd03.prod.outlook.com
 (2603:10b6:303:dc::26) To SJ2PR11MB7573.namprd11.prod.outlook.com
 (2603:10b6:a03:4d2::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ2PR11MB7573:EE_|DS0PR11MB7577:EE_
X-MS-Office365-Filtering-Correlation-Id: 92405f64-8b8c-4498-e9b8-08dbc4555834
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: RReRAaPEizZ8fUXjw/vNKyF+ol2INbh4l6cWDZQcPGOfI/c2bCMVLaeQk3UcNiLrFfsgQp7e6TQqfqFgQNb2CP6KhgrrjiDXrwXA065Bi079LJaGL2SGnAYIn/4/BlXD1XtzIldGFHtOX/UtWSFWbTAB1yRW7pcPmXCfxSr3gKV8awpP5vAfoCuwpgWQeyYKffofXoktHzByY/cyRh+sRByEu4v+VuXkLJMjvqGlAfQN3vNWjMLE1fk4ujK4H4wiFdmo/4Tp+8GZxeZIl/NlVn1plIyX+GPFJnqequ62J2qyKxOUoFOSoVThKWbBelBkUdiNoCF2rrARCHj4ZzQgnppdEyEWQtL0Gbw99YdcysuI6saHiG0tOocPEDKjoHzcNRcs20DsBnxUH73lb7M/FTBvOYTcFInIZKWr6NHlaQSrFjl/cWx0iKR/jUZwGvLyapO4ImCDZcKwmNFBH+w4vfX/yw8MzGoq7U+OPt8ptl/w6oWosDwSpnyLwrccVf8u3z10IF5aF+Qrwbmvy5pBM+Qk91qYhY5Rmp+ohc+84ZMBmkFVu/Ti39yilr29ZXT5xH+sM4fXx7QqwCK2hrQPh3JOvKshf4FUcYQdZJwQKKiI7Vgef60EvhKHrfTPS6xLekrBIMICygvkZc7+D5usaw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ2PR11MB7573.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(39860400002)(346002)(366004)(396003)(376002)(230922051799003)(1800799009)(64100799003)(451199024)(186009)(66476007)(66556008)(6486002)(66946007)(54906003)(2616005)(8676002)(41300700001)(8936002)(4326008)(26005)(36756003)(478600001)(6666004)(86362001)(83380400001)(38100700002)(31696002)(6506007)(82960400001)(6512007)(316002)(53546011)(2906002)(7416002)(31686004)(5660300002)(44832011)(43740500002)(45980500001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SjJ5M0dtWkZZQ0J0UUdTbTdkc2RsOURoT01OenhTQkw0My8vZXVaNnhERVcv?=
 =?utf-8?B?cVNUZW5zT3BObXdZMlJ2SlVxaUovRUpTWThGc0RtNDUvWk5XMHV2YkZsUWFC?=
 =?utf-8?B?azF1cjlldDFrdHNrWmVPTkl2aFo4RjNZcVBHc2xYSWRlR3hMODdpMjFOWnlY?=
 =?utf-8?B?KzZ3NVFTL3NLRGpvb0FKMHRwU2h5MXJob2lrMC9KMlNhODQzZkJBMWJxNnlK?=
 =?utf-8?B?VnROWndoUGlScjZ3QkpSUjVxUmhONGF2cEFLM2JFVUlrMFRESUVqRFZLQmFL?=
 =?utf-8?B?V2RHNjBPTEpBNTlHUUVIOExjZkNJSXBoZ1poUXhLSnJidWE5MUZTYkhZSUxC?=
 =?utf-8?B?NlV0cGIvZGpLalYxREhlcE04VCswdkMrOC9RSlhBSGxzbExuajRpR0kzNVFS?=
 =?utf-8?B?UWpsNThMVnlRNnRRTldXalM5WjNKMjNYTVZ2TWptQ3V2M1BFT0VYQ0Vvck1K?=
 =?utf-8?B?Z0wrWHpmQ1BHRWtIbDhkL255RXVqcTlWd3NmOHZCMW5BRmt3L3FDQWp5aXVy?=
 =?utf-8?B?NDVXSjgzYXhpUDZsRHdOcUh4OHh2TTViVVk3NUZKekVXTmhVWjMvb2NEd29i?=
 =?utf-8?B?ZzViSU1kUXJpRG9BLzR1empmWXBRNlpOUlpSL1EyUk1vYkg2UnZ4MG1iTGFr?=
 =?utf-8?B?QWFqN3RHdVlnL0l4bHg3Vjhhd0dzWEVjZmxEZ3FCUDh4UmxpZS9RY2EwcHE1?=
 =?utf-8?B?VUxjc3hmY29jKzFpSmtnOVJ0OFVYY081dUlIRCtHUXNpMmVQVWJneVRqZzQ4?=
 =?utf-8?B?cHdCMENhZURzaXF6dTNaWldoc3EvRjMrQ2h4SldONkt3QmRLT0FiaWRvdW42?=
 =?utf-8?B?TTV3cE5rZTRMTUFWRXQrbVBJT0pzZHZ0OGFhd3ZiOE1xQWY2ZE02dTZJdGJG?=
 =?utf-8?B?MXFwZ2tSK1FRRWxaYTNEckJtblQzU1ZLYUlxSGhIUTU0UCtNREI3QzJNeFl3?=
 =?utf-8?B?Zm9BTEkvT2JwamlLdjE1MnlmYUt6SERmRDNaYktXL3hJUjk2Q0RMVTJObHpj?=
 =?utf-8?B?dEhxYXB6TXdkRUtaOEJ4SmI0OWVPZlp2Um5pWnR4SllUWjQ2L0RlUE5SNzVE?=
 =?utf-8?B?eWNaOEZKZVo1ZEFKempLbWRVMlRuTFhONGxzYzBoVG1zczQ1NFJ2cXBlb0l4?=
 =?utf-8?B?S04rRlI1eXN2YTQxZFh5WEZ2Smkzb1BFMGZ6aGdnZ1Z5Mml6Um5qb2ZaWWQv?=
 =?utf-8?B?VitJTDBCcVl1ZDJKK2JJdGJteTJKY2RPYS9LRzB3MjBEeVlZVW5Ec1d1elNX?=
 =?utf-8?B?bERnazU5V0xOWDRmWUkwaDg4b3NQeG9xaWhzcysyeHBPemVVY0Z5dzIrb3ZT?=
 =?utf-8?B?OWt0TWRBaDRsU0dKUlByeTRZYlVwU0tDSkU5QUFvV2Q2bklxeGJUdDZaY3Vq?=
 =?utf-8?B?VmVRZGp1NW9NWm5sc20yeE9zNk45by9XYUkxaEpvZUlYYTkxTGJjZnZBdGdU?=
 =?utf-8?B?RG5nZEhxYk9VekFESHY3OGNKVXRCbHNmS2E2dFIzZENhZGZvUWUydCtkMnFQ?=
 =?utf-8?B?M2t1aHJYeTBhQ0tIWi9hOE5RYmowc1liWEROeG1SVWorbDNJY2tseTI2UFhQ?=
 =?utf-8?B?WlVQd0txTWNhZXhrYmRtMDZwNVBLWHFvSHE4NjNDckIxMlIwcEhsZW51WUhL?=
 =?utf-8?B?aFNNVWVkc0NVRlBnSytBUEkwbnRQbUwzY1Ixc0xPdFV5WFAwMVdyS3VhL3hR?=
 =?utf-8?B?clYzTHpkbk9kWlNxTmIwemwwMmk2Ym1XMzVjTno5YmJOYUdST01nN2JhRkVz?=
 =?utf-8?B?aGh2YnhjbW5EcmNpcVhPcDNvWFlEaXV4T3dSenhDcnJtNUFKanJEMDlYRm9a?=
 =?utf-8?B?ZmtYQjBhNWNYK1R2OGUyeXhLdThpaXd3cmtDZUVGS2VpdldPa0wybzRmUWRa?=
 =?utf-8?B?VG5zSE1JbTVqVDNlRzhReDJKemFvcE1TLzlmM3p3N2Z5TWE0dEc5NERBTFlY?=
 =?utf-8?B?TW1oT3hXWCtCY3lReWE2THZ2cWNrRUY2MkttUGkySmNqd3p0NUJoU0sya1RJ?=
 =?utf-8?B?NXZENXljSm1RcHliT1A3SmtIOXFSaVBxM0pxaEZuVEJtNDJ0Uy9kVFNJaGc4?=
 =?utf-8?B?TjRvQ0N0M3FJc3dVc082ZnpYSVJ3MDhlb3Y2RmdrY0svSkNRWG9HV09MWnp5?=
 =?utf-8?B?ajZwT0RPbG51TEdtUEVXanV5R0pOaVd2dlhSSzJxbnZhbE5nazFCdVRUQkNE?=
 =?utf-8?B?ckE9PQ==?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 92405f64-8b8c-4498-e9b8-08dbc4555834
X-MS-Exchange-CrossTenant-AuthSource: SJ2PR11MB7573.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Oct 2023 21:11:43.5515
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: io8Q8SAHrZAMqntfshSZ/V+6gJ3m3QAsA2bMA6+K7fDWR4DaUuEH9EbXpB1rkIV4leMSCr5vK/1HaXRP5FfwdpjT57/HVWF0EbZ9l/yuLbw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR11MB7577
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James,

On 9/14/2023 10:21 AM, James Morse wrote:

> diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> index cfb3f632a4b2..42b9a694fe2f 100644
> --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> @@ -24,7 +24,21 @@
>  
>  #include "internal.h"
>  
> +/**
> + * struct rmid_entry - dirty tracking for all RMID.
> + * @closid:	The CLOSID for this entry.
> + * @rmid:	The RMID for this entry.
> + * @busy:	The number of domains with cached data using this RMID.
> + * @list:	Member of the rmid_free_lru list when busy == 0.
> + *
> + * Some architectures's resctrl_arch_rmid_read() needs the CLOSID value
> + * in order to access the correct monitor. @closid provides the value to
> + * list walkers like __check_limbo(). On x86 this is ignored.

I do not think this is correct. At this point in the series
__check_limbo() uses @rmid as index, at end of series it uses the
(@closid, @rmid) index. Never does the list walker use @closid.

Perhaps something like below that matches your later similar comments:

	Depending on the architecture the correct monitor is accessed
	using both @closid and @rmid, or @rmid only.


...

  
> @@ -685,11 +706,11 @@ void mbm_handle_overflow(struct work_struct *work)
>  	d = container_of(work, struct rdt_domain, mbm_over.work);
>  
>  	list_for_each_entry(prgrp, &rdt_all_groups, rdtgroup_list) {
> -		mbm_update(r, d, prgrp->mon.rmid);
> +		mbm_update(r, d, prgrp->closid, prgrp->mon.rmid);
>  
>  		head = &prgrp->mon.crdtgrp_list;
>  		list_for_each_entry(crgrp, head, mon.crdtgrp_list)
> -			mbm_update(r, d, crgrp->mon.rmid);
> +			mbm_update(r, d, crgrp->closid, crgrp->mon.rmid);
>  
>  		if (is_mba_sc(NULL))
>  			update_mba_bw(prgrp, d);
> @@ -732,10 +753,11 @@ static int dom_data_init(struct rdt_resource *r)
>  	}
>  
>  	/*
> -	 * RMID 0 is special and is always allocated. It's used for all
> -	 * tasks that are not monitored.
> +	 * RESCTRL_RESERVED_CLOSID and RESCTRL_RESERVED_RMID are special and
> +	 * are always allocated. These are used for rdtgroup_default control
> +	 * group, which will be setup later. See rdtgroup_setup_root().
>  	 */

This comment will not be accurate after Babu's changes are merged (the function will
be rdtgroup_setup_default()). To avoid that conflict you could perhaps change
last two sentences to something like below that will be accurate no matter the
order of merging between your and Babu's work:

	These are used for rdtgroup_default control group, which will be
	setup later in rdtgroup_init().

> -	entry = __rmid_entry(0);
> +	entry = __rmid_entry(RESCTRL_RESERVED_CLOSID, RESCTRL_RESERVED_RMID);
>  	list_del(&entry->list);
>  
>  	return 0;


My feedback only relates to the comments. The rest of the patch looks good to
me. I could give a review tag with expectation that comments be addressed in next
version but since some review feedback fell through the cracks in this version I
feel that I need to confirm first before providing review tag.

Reinette
