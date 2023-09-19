Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946B47A69D5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 19:45:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232930AbjISRpu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 13:45:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbjISRph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 13:45:37 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2081.outbound.protection.outlook.com [40.107.92.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9797C6;
        Tue, 19 Sep 2023 10:45:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PQuAnk+A5SjHv26zA3sbP9DqZpfNNitT6KaVuI4JwRDzd6Fb7DiEseb06NPKDjZciGWBgu+EmFEJyaPz5aprVazKh4VlkpLXGWUBNTY771Z3AiHYmOc6B2P2OWGlzrsIBvt29fg4AkGYqmrs4hFaKbwtfoX5WX9KXV4zxqSxpaxOcv1y6NvwPQfAHknbMujUWVZvdpBD+OIb1gkWd7DDxOrTZfrwXlIjk8E3WuKgufcbRrV6WBDuhEGKxe56ATJNO9lvNVZZogV1/SEv+BkXEQtIq/K1xB3PYqAvLoh3h5TSq4dFcx4yK6/HlDMGu+gqVpx3e1oYTxvuUnvnOnkiqw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e0v37NUo3S7z060/x8d+eAXfbKvb8OPvcTylCoGs7iY=;
 b=B9MmniqQ2mcqbX6SYGgPfYqm/uxxdUs01h4/udbJ+/embKoliXIo+gPB5JF8cn8n1h+973RTOVcHuemaxsImvrfiULUjYEF5u4EsUqflZSVBwW+Tl8G0iQoyv7YyEG1HdI8XxWwyRh7ZnBSD4s2dF8pKRgdHqnBPFQEV4Q4kQ4hnIG1hAL6xKDVwpv0rKPnQizA0hYQFL6oda7eCTQXwlJaAAXIuLzlCxoRKWkJ6dAG9dO8fOoEXtDPFcrwJRwp3ewfx3cocrT8vdyzVUP8h9+DSnSuU8i4FnQmaUPPLk5WqnBRdZ691gYp3Ef1mRAcBogJAgGmJbKnWAurYbSwd+g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e0v37NUo3S7z060/x8d+eAXfbKvb8OPvcTylCoGs7iY=;
 b=kWnJoz0j0x8DZ6Kw5g8jrP+jAPptYjyotQHLAivdk9gA8uE16ChgpZG491Fm93pC4+EJ5DJVg92iuv912BqW7WzRHtmChucZsCuGeeaHNeDr/5CAP+fgvQH80UbZn1Dbr6iYRUAW6MVw9wGrzS1BzISsYIRJytnTc3PqPejsAjk=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BN8PR12MB3108.namprd12.prod.outlook.com (2603:10b6:408:40::20)
 by SA1PR12MB7040.namprd12.prod.outlook.com (2603:10b6:806:24f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6792.26; Tue, 19 Sep
 2023 17:44:58 +0000
Received: from BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231]) by BN8PR12MB3108.namprd12.prod.outlook.com
 ([fe80::3043:e5d2:42f4:a231%6]) with mapi id 15.20.6792.026; Tue, 19 Sep 2023
 17:44:58 +0000
Message-ID: <c76723df-f2f1-4888-9e05-61917145503c@amd.com>
Date:   Tue, 19 Sep 2023 13:44:55 -0400
User-Agent: Mozilla Thunderbird
Cc:     yazen.ghannam@amd.com, Smita.KoralahalliChannabasappa@amd.com,
        dave.hansen@linux.intel.com, x86@kernel.org,
        linux-edac@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v7 2/3] x86/mce: Add per-bank CMCI storm mitigation
To:     Tony Luck <tony.luck@intel.com>, Borislav Petkov <bp@alien8.de>
References: <20230616182744.17632-1-tony.luck@intel.com>
 <20230718210813.291190-1-tony.luck@intel.com>
 <20230718210813.291190-3-tony.luck@intel.com>
Content-Language: en-US
From:   Yazen Ghannam <yazen.ghannam@amd.com>
In-Reply-To: <20230718210813.291190-3-tony.luck@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BN9PR03CA0235.namprd03.prod.outlook.com
 (2603:10b6:408:f8::30) To BN8PR12MB3108.namprd12.prod.outlook.com
 (2603:10b6:408:40::20)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN8PR12MB3108:EE_|SA1PR12MB7040:EE_
X-MS-Office365-Filtering-Correlation-Id: 90157ecd-8324-4eab-c767-08dbb938244a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: sOw6d5u9j2QNJr03wqeXIAgQC/dHVMbUobCpFzV0LxGnl9HzTf1/dep//MF/tMNI1PcnjJ81A9uWGc0rC83lJ8foB/pPHChilKqtQIuqi5UxtHr4a6EbE9BQG731glYGyHVsnVS15ffRn/tZSYIXkiCgyr3Qijpd2hYcYH7EpBJCw3TPfwJjucP1O3ml8gazwoLXGVHFul4BjC8kJloFYRlzoL1/CnqrEX4OCJ4ha/flQpe8+Tx9jGaKWwwNkwvfgUx2hOsVAM3aNyPoMVjwipvHgt0YjfCTq9/dPCOQ83YyNiLljlXGvYFwQFn1Knvar2pLoNLk05+20sF7K06IvIkLEpU0OHnmyczhaES7KML9AnFnEgFi5O+7eXNLublWZnEL3Lbcd6KHV1G0WLwZ70khJ3608i3u645+p3T8NVqRjZjSegL19vO2BAdtq9r0DfAxyASt7qHsD893cI43g7nsOJfI5I+FHl9/7vW0qvHYxbAWtyB7tbQV0B82sl9CzJAse1N8NcR9tc3YV/gAbSziXlcWPdpG+Yaz/tG0fr6d/2Tl28VWdjM+r0jodeNqu66yNbYq6Bh6/6XZBTlPHhts04HmFGwQKpyI79xgR6nYQMIFyoi7zZmUxgIKm11aIBCxMGtGW+/ZLH7vFDj9Qw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR12MB3108.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(376002)(366004)(346002)(396003)(136003)(39860400002)(186009)(1800799009)(451199024)(5660300002)(26005)(8676002)(4326008)(8936002)(2616005)(15650500001)(2906002)(31696002)(36756003)(86362001)(38100700002)(83380400001)(44832011)(66476007)(66946007)(6506007)(6486002)(66556008)(53546011)(110136005)(31686004)(6666004)(478600001)(6512007)(41300700001)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?bXpmWVNVMysxUy9sb3F0ZmNac0s5WXE1SkpCUjlYTkNjRSsxSzlqdkxIK2xO?=
 =?utf-8?B?SCtMNkVubFgwQ3E4SGR2OXJlL3J2S2tzdXV1eUo0SllRNjQ1NUZIejNBV3RO?=
 =?utf-8?B?QUJwUnV3OXNYR0FPbzBTNkFReXlodjI2U3JsTHNnYUZ6Z3B5TlBrTURPYUgw?=
 =?utf-8?B?M1BKUVp4ek00TXlLTkFJR3lOVnJPL2NweERjdG0rNXFyYlR0QzhJNTBURHYy?=
 =?utf-8?B?d3JKQnQrQzNyNDlxWklPSCs2OWVTa1pBU1gxNGhmbkl5bWozTFpGT2xRRGQz?=
 =?utf-8?B?YmUrRFdzaS9CUWxEVTdscDNBbm91NllJQis0d0lhSlpncENPQzhSd1VnQ2FY?=
 =?utf-8?B?TDVDcE5oOEZNNVhtdE55cGdnRDlOY0NQckNvQWt0ZG9aWW9GVmpuTUlrV2d0?=
 =?utf-8?B?QndzdFFvN0g4N09lcXU3Ris4c0Z5YnFJWjNTNitkdEhHbDJLUHJ1M25Ca0tK?=
 =?utf-8?B?VlJhS3d5RHA0RFpYc1dpTXp4QXBlZGZZVE5xNGROOVV2WnorY3YzcE1EYzZO?=
 =?utf-8?B?b2syT0NwaWVSRS9MYkE5eXBMRkdmZGg0ejBNUVFsUWZic3NRbkxFVWRlR1pS?=
 =?utf-8?B?cEp0bm56ZzdSemtaVzNnMEZ2QnhhN0ttY0VyYTREUHZNMkU0am8vcDAvVWVr?=
 =?utf-8?B?bDMzcUFSUEJYSno3c1BFdnJ3Z21TSmdERnBHS0tZdFFUQysxT3l6ajN3VzI4?=
 =?utf-8?B?azB2TzBsLytmNHUzcHg2TVdSYlRmNktQWVNYNlN0U1FBWGNKb3RRd2ZieHNm?=
 =?utf-8?B?ZzNFOWVMb0NTT0k1U2NJeWg0N2lTalBEcndhQzAxVGNHeG1LYU5zOFJ2Y3hH?=
 =?utf-8?B?MElneTJhdzlKbVZYMTZVYUxCKzNpRkhIOTVqdmtaeHJYcmJOMnFTTHkwMElF?=
 =?utf-8?B?eml1MVRiM0hvbzFKRFp3UXY0VWtDU1huNGgwdlp6cE9ydytkdXFuekxreTFW?=
 =?utf-8?B?MEtuVzNWRVpNRm93eWp0V21HN1VNZDZUeWVISXViUU40dVo5dStIVXEybUs3?=
 =?utf-8?B?QzUxUThsRCtXUnFyaDFGVUJNTkI3SGk3SDIrUW1aNjRob29TUlBpMXY1MXlN?=
 =?utf-8?B?VWJnZ3pLVDMxQzZMd3hzUGVOOXYwQkdxTFhQN1hITlBSU2huL1NkZUJLV1Na?=
 =?utf-8?B?WmNYRmQ3Q1FxSk1mWVR0a0NyVHBmTDhmVnd3SlYzMEw2U2xyaW1wc1FoSElx?=
 =?utf-8?B?MjE5VnduRVBoNW91Yy9DZExlcUFOWmZlMXVHalZZdlNlenVEeG1sZU9OaGpW?=
 =?utf-8?B?S0tjcktNNEZ2QlhuWVY3VVBpeitHb2RmWERreVdoT2lNZEpSOVhpYjBhOUZF?=
 =?utf-8?B?eTJGODg1bC9wMlNyVnBTY1RQOWxEdE5KVWtTbmpnMjFYQUN2ZEk2dUFXVDha?=
 =?utf-8?B?L0tCWGt5NWsrOGRiUTg2L1dmYWc5OHI1U2JTYVcrMk1abDJpSHEybnJxWEJ2?=
 =?utf-8?B?T25kYWRvSGFwZFlxNG4wRlZIb0FWcTVJdFk1TlIvaVlJQkhHcW9zT0xvWC9y?=
 =?utf-8?B?U3NzOWdwSTdNSFpLbks2MXpzZXJtdGF4Y3dEUGdWa01zSnEralZscmZWd0sr?=
 =?utf-8?B?bDhGK0RsVG9teklyUU81K1VnZnlneDY5azNjOXJUbUVXREFNSVA3aDM3K2lI?=
 =?utf-8?B?WW1zUEpCVWU2RDJkclBza0tzTitHZDE1WlNzOFBMSHJnT2pkY2VQOWtVaG9r?=
 =?utf-8?B?RXIrNmw3Q00xV1Y0bjFFM2JKd2Q2Q1pnRVR5UGM2cTJCbEJKMDNxL05ZOVN5?=
 =?utf-8?B?Njd4dFJiQ2VwbkxoNURRbGxPUnFHaVRKczNTTUtHcnFRak5zZEVUd3hsUXI4?=
 =?utf-8?B?QkxUZFEzMVdLcUNncVhEK0x6dlpXUzE1SVB6MkQzb2VrNitpb2dTakR2bXkz?=
 =?utf-8?B?RzNsajhiUmgxUEFjeEZKNldZSEpLVVRzYzFIYkhFQUtDMUI2M2RiWEFzTk5j?=
 =?utf-8?B?TDY4eVlPdnNVS2xueStQTVZ5TkpHd05WRWYvN0pTU3RvMGI3akxDTmZyVnBo?=
 =?utf-8?B?YTVmMkJJY2d0cE5veERnMStvVWw5bjhjaHhiQ3hlanlGZ3JvRERHNHVsK1Fo?=
 =?utf-8?B?V1doTms0YURFVk1QYmZSeE1IMFk2TW0zYSs1a3RwUklMYWcvckxhZmlmOTlW?=
 =?utf-8?Q?0C4v83UMVdUfI1ZaSmGqcxAzv?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 90157ecd-8324-4eab-c767-08dbb938244a
X-MS-Exchange-CrossTenant-AuthSource: BN8PR12MB3108.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Sep 2023 17:44:58.3205
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: xsnIEo+viqe/GZ+VD0/74hPykG/QGvgiyh3UjcwG7nWHB3l/nqMy2lKSB26wdN/CHEhN+jpvewIOWWaI/ydafw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7040
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/18/23 5:08 PM, Tony Luck wrote:
> This is the core functionality to track CMCI storms at the
> machine check bank granularity. Subsequent patches will add
> the vendor specific hooks to supply input to the storm
> detection and take actions on the start/end of a storm.
> 
> Maintain a bitmap history for each bank showing whether the bank
> logged an corrected error or not each time it is polled.
> 
> In normal operation the interval between polls of this banks
> determines how far to shift the history. The 64 bit width corresponds
> to about one second.
> 
> When a storm is observed a CPU vendor specific action is taken to reduce
> or stop CMCI from the bank that is the source of the storm.  The bank
> is added to the bitmap of banks for this CPU to poll. The polling rate
> is increased to once per second.  During a storm each bit in the history
> indicates the status of the bank each time it is polled. Thus the history
> covers just over a minute.
> 
> Declare a storm for that bank if the number of corrected interrupts
> seen in that history is above some threshold (defined as 5 in this
> series, could be tuned later if there is data to suggest a better
> value).
> 
> A storm on a bank ends if enough consecutive polls of the bank show
> no corrected errors (defined as 30, may also change). That calls the
> CPU vendor specific function to revert to normal operational mode,
> and changes the polling rate back to the default.
> 
> Signed-off-by: Tony Luck <tony.luck@intel.com>
> ---
>  arch/x86/kernel/cpu/mce/internal.h |  41 ++++++++++-
>  arch/x86/kernel/cpu/mce/core.c     | 108 ++++++++++++++++++++++++++---
>  2 files changed, 140 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/mce/internal.h b/arch/x86/kernel/cpu/mce/internal.h
> index 9dcad55835fa..da790d13d010 100644
> --- a/arch/x86/kernel/cpu/mce/internal.h
> +++ b/arch/x86/kernel/cpu/mce/internal.h
> @@ -54,7 +54,46 @@ static inline void intel_clear_lmce(void) { }
>  static inline bool intel_filter_mce(struct mce *m) { return false; }
>  #endif
>  
> -void mce_timer_kick(unsigned long interval);
> +void mce_timer_kick(bool storm);
> +void mce_handle_storm(int bank, bool on);
> +void cmci_storm_begin(int bank);
> +void cmci_storm_end(int bank);

We usually use "unsigned int" for bank numbers. Can we also do so for
these functions?

> +
> +/*
> + * history:	bitmask tracking whether errors were seen or not seen in
> + *		the most recent polls of a bank.
> + * timestamp:	last time (in jiffies) that the bank was polled
> + * storm:	Is this bank in storm mode?
> + */
> +struct storm_bank {
> +	u64 history;
> +	u64 timestamp;
> +	bool storm;
> +};
> +
> +/*
> + * banks:		per-cpu, per-bank details
> + * stormy_bank_count:	count of MC banks in storm state
> + * poll_mode:		CPU is in poll mode
> + */
> +struct mca_storm_desc {
> +	struct storm_bank	banks[MAX_NR_BANKS];
> +	int			stormy_bank_count;

Can we use unsigned values for stormy_bank_count? I'm not clear on the
restrictions for the inc/dec functions.

The maximum possible MCA bank count is 255, i.e. MCG_CAP[Count] = 0xFF.
So stormy_bank_count can be a u8, I think.

> +	bool			poll_mode;
> +};
> +DECLARE_PER_CPU(struct mca_storm_desc, storm_desc);
> +
> +/*
> + * How many errors within the history buffer mark the start of a storm
> + */

This should use single-line style comments.

> +#define STORM_BEGIN_THRESHOLD	5
> +
> +/*
> + * How many polls of machine check bank without an error before declaring
> + * the storm is over. Since it is tracked by the bitmaks in the history
> + * field of struct storm_bank the mask is 30 bits [0 ... 29]

Should have a (.) at the end of this sentence, and also the one above.

> + */
> +#define STORM_END_POLL_THRESHOLD	29
>  
>  #ifdef CONFIG_ACPI_APEI
>  int apei_write_mce(struct mce *m);
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index b45c5008df34..6a44e15d74fe 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -607,6 +607,83 @@ static struct notifier_block mce_default_nb = {
>  	.priority	= MCE_PRIO_LOWEST,
>  };
>  
> +DEFINE_PER_CPU(struct mca_storm_desc, storm_desc);
> +
> +void cmci_storm_begin(int bank)
> +{
> +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> +
> +	__set_bit(bank, this_cpu_ptr(mce_poll_banks));

This assumes that mce_poll_banks does not include banks with correctable
interrupts. This is true for Intel, but not for AMD. 

I'll include a change for AMD to match the Intel behavior. I don't think
there's a good reason for the difference. Also, it may be good to save a
few cycles by disabling polling when interrupts are enabled.

There will be an action for me to make sure AMD users are aware of this.

> +	storm->banks[bank].storm = true;
> +
> +	/*
> +	 * If this is the first bank on this CPU to enter storm mode
> +	 * start polling

Need (.) here.

> +	 */
> +	if (++storm->stormy_bank_count == 1)
> +		mce_timer_kick(true);
> +}
> +
> +void cmci_storm_end(int bank)
> +{
> +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> +
> +	__clear_bit(bank, this_cpu_ptr(mce_poll_banks));
> +	storm->banks[bank].history = 0ull;

Why is the "ull" needed?

> +	storm->banks[bank].storm = false;
> +
> +	/* If no banks left in storm mode, stop polling */

Need (.) here.

> +	if (!this_cpu_dec_return(storm_desc.stormy_bank_count))
> +		mce_timer_kick(false);
> +}
> +
> +static void track_storm(int bank, u64 status)
> +{
> +	struct mca_storm_desc *storm = this_cpu_ptr(&storm_desc);
> +	unsigned long now = jiffies, delta;
> +	unsigned int shift = 1;
> +	u64 history;
> +
> +	/*
> +	 * When a bank is in storm mode it is polled once per second and
> +	 * the history mask will record about the last minute of poll results.
> +	 * If it is not in storm mode, then the bank is only checked when
> +	 * there is a CMCI interrupt. Check how long it has been since
> +	 * this bank was last checked, and adjust the amount of "shift"
> +	 * to apply to history.
> +	 */
> +	if (!storm->banks[bank].storm) {
> +		delta = now - storm->banks[bank].timestamp;
> +		shift = (delta + HZ) / HZ;
> +	}
> +
> +	/* If has been a long time since the last poll, clear history */

"If it has..." and need (.) here.

> +	if (shift >= 64)
> +		history = 0;

Can this be initialized to '0' up top, then set "if (shift < 64)"?

> +	else
> +		history = storm->banks[bank].history << shift;

Newline here, please.

> +	storm->banks[bank].timestamp = now;
> +
> +	/* History keeps track of corrected errors. VAL=1 && UC=0 */
> +	if ((status & (MCI_STATUS_VAL | MCI_STATUS_UC)) == MCI_STATUS_VAL)

This should be a call to mce_is_correctable(). The VALID bit check isn't
included, but this can be handled by moving the track_storm() call.
Please see below.

...Actually, I wrote this and the comment in the polling function, but
then realized that may not work as intended.

We want the per-bank history to 'tick' every time we enter the polling
function, not just for "valid" errors, correct? You mention this in the
commit message, but it didn't click for me until later... :P

> +		history |= 1;

Newline here, please.

> +	storm->banks[bank].history = history;
> +
> +	if (storm->banks[bank].storm) {
> +		if (history & GENMASK_ULL(STORM_END_POLL_THRESHOLD, 0))
> +			return;
> +		pr_notice("CPU%d BANK%d CMCI storm subsided\n", smp_processor_id(), bank);
> +		mce_handle_storm(bank, false);
> +		cmci_storm_end(bank);
> +	} else {
> +		if (hweight64(history) < STORM_BEGIN_THRESHOLD)
> +			return;
> +		pr_notice("CPU%d BANK%d CMCI storm detected\n", smp_processor_id(), bank);
> +		mce_handle_storm(bank, true);
> +		cmci_storm_begin(bank);
> +	}
> +}
> +
>  /*
>   * Read ADDR and MISC registers.
>   */
> @@ -680,6 +757,8 @@ bool machine_check_poll(enum mcp_flags flags, mce_banks_t *b)
>  		barrier();
>  		m.status = mce_rdmsrl(mca_msr_reg(i, MCA_STATUS));
>  
> +		track_storm(i, m.status);

This can go after the VALID bit check below.

Also, the "status" parameter can be dropped if the correctable check is
done here...

> +
>  		/* If this entry is not valid, ignore it */
>  		if (!(m.status & MCI_STATUS_VAL))
>  			continue;

...like this.

		if (mce_is_correctable(&m))
			track_storm(i);


...please disregard this comment, if my realization above was correct
about the "history tick". If so, then I think it'd be better to pass
struct mce to track_storm(), because it'll have both the bank number and
status register. And it can then be passed to mce_is_correctable().

> @@ -1622,22 +1701,29 @@ static void mce_timer_fn(struct timer_list *t)
>  	else
>  		iv = min(iv * 2, round_jiffies_relative(check_interval * HZ));
>  
> -	__this_cpu_write(mce_next_interval, iv);
> -	__start_timer(t, iv);
> +	if (__this_cpu_read(storm_desc.poll_mode)) {
> +		__start_timer(t, HZ);
> +	} else {
> +		__this_cpu_write(mce_next_interval, iv);
> +		__start_timer(t, iv);
> +	}
>  }
>  
>  /*
> - * Ensure that the timer is firing in @interval from now.
> + * When a storm starts on any bank on this CPU, switch to polling
> + * once per second. When the storm ends, revert to the default
> + * polling interval.
>   */
> -void mce_timer_kick(unsigned long interval)
> +void mce_timer_kick(bool storm)
>  {
>  	struct timer_list *t = this_cpu_ptr(&mce_timer);
> -	unsigned long iv = __this_cpu_read(mce_next_interval);
>  
> -	__start_timer(t, interval);
> +	__this_cpu_write(storm_desc.poll_mode, storm);
>  
> -	if (interval < iv)
> -		__this_cpu_write(mce_next_interval, interval);
> +	if (storm)
> +		__start_timer(t, HZ);
> +	else
> +		__this_cpu_write(mce_next_interval, check_interval * HZ);
>  }
>  
>  /* Must not be called in IRQ context where del_timer_sync() can deadlock */
> @@ -1965,6 +2051,12 @@ static void mce_zhaoxin_feature_clear(struct cpuinfo_x86 *c)
>  	intel_clear_lmce();
>  }
>  
> +void mce_handle_storm(int bank, bool on)
> +{
> +	switch (boot_cpu_data.x86_vendor) {
> +	}
> +}
> +
>  static void __mcheck_cpu_init_vendor(struct cpuinfo_x86 *c)
>  {
>  	switch (c->x86_vendor) {

Thanks,
Yazen
