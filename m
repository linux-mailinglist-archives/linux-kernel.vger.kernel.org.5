Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F1267D83B4
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 15:37:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345095AbjJZNhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 09:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbjJZNhl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 09:37:41 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2080.outbound.protection.outlook.com [40.107.94.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E20CA18F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 06:37:38 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=h5fZd0uHE9twEC7x8NK29q193EbKzt87LJ2LZtKm+6uGaxG6wTtlw44wBeOMcFmJxewDoaJXvpS8UEkpc30corhnbJ3lXINvQqG9ukQIKPhQImPn1MLyEaF/k5+cywGe3g4yMYLaYmm08jfw7o1KrAXv2y7lSvimpYV2bYIFKBivqjdpKSmSVVwB6flKZvi9+5tSIcNqXD3hX/Exsz9fDXgckXBs0V9I6uuj12eH74hxJWGsJUXSD6klPWqIUFz9WNE8dU8B7eKuhgvXrCET+fQkdiynESbs1ske9WyLaryBgjoMSyKJ0GWSw/vX3BJYBsX3Unp09A2+zCTcPkwDdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=tGX9z4KtHJ9GMhmukxbcJCDb5JXfR7sBqzbl3MDF3l8=;
 b=hxx8jV7y0tIXJzeysClgBwTP9wzyX4La26dI2baxBWRReS3Kmox0MG94fjUAzI5SVh87nd3KtODGCjimRVjs8Siyu7H4Y8J9pDhGGC3NtVF7faFwGHGBNfqvhyXc7D1nf0F+ctf1Rpj4ZGygFmGrZ4iPaun3TFYLFaQcI6UMFup2A863MAKIimC5ndxTvRq4rmLED1ZLp42JQLG7q1IjXMLct8/2exqILOtiGXawSX7umawOUTHL2LMGv08nEPfkkzZYh9cgkOVx2qgM5bc1FNL73bclkpuyAOelIqip/Xp4Os0Ar4nQ5ic7DPsrrO2uBkhlBnoVqLQXAVaDd8p8GQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tGX9z4KtHJ9GMhmukxbcJCDb5JXfR7sBqzbl3MDF3l8=;
 b=qUMFb4jogqMP05waeN+i3M21k21QF2+gaEtLO61mKEBNi94nRlni914r2cKD/oWT92THqHkO1fLdoz5XzDUCwgykho6WQiY7aG921MCR6sv9bajDV6OGcrkShvgriMcm1thZK7o22ExLaroz7/Hxpw/Kh9b2cHDgRtBZT0Uswho=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BL1PR12MB5732.namprd12.prod.outlook.com (2603:10b6:208:387::17)
 by IA0PR12MB7554.namprd12.prod.outlook.com (2603:10b6:208:43e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.31; Thu, 26 Oct
 2023 13:37:35 +0000
Received: from BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021]) by BL1PR12MB5732.namprd12.prod.outlook.com
 ([fe80::e16e:d7f1:94ad:3021%7]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 13:37:35 +0000
Message-ID: <06f701e6-f74e-1dbd-d021-07a78523900c@amd.com>
Date:   Thu, 26 Oct 2023 08:37:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] x86/mm/cpa: Warn if set_memory_XXcrypted() fails
Content-Language: en-US
To:     "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Lutomirski, Andy" <luto@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "Reshetova, Elena" <elena.reshetova@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "Cui, Dexuan" <decui@microsoft.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "mikelley@microsoft.com" <mikelley@microsoft.com>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "bp@alien8.de" <bp@alien8.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>
References: <20231024234829.1443125-1-rick.p.edgecombe@intel.com>
 <e30560cf-cb88-45de-963f-f99f9b06db75@linux.intel.com>
 <2a5e4fdb3f2d9f32262c0ba23f5535cf09559fc1.camel@intel.com>
From:   Tom Lendacky <thomas.lendacky@amd.com>
In-Reply-To: <2a5e4fdb3f2d9f32262c0ba23f5535cf09559fc1.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: SN6PR04CA0076.namprd04.prod.outlook.com
 (2603:10b6:805:f2::17) To BL1PR12MB5732.namprd12.prod.outlook.com
 (2603:10b6:208:387::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL1PR12MB5732:EE_|IA0PR12MB7554:EE_
X-MS-Office365-Filtering-Correlation-Id: e2331988-395d-46e0-8f77-08dbd628b625
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: hDSvigiT0k2+f41uzlzLN03Vr6acJ88ktsgCLptott/jNnLH4lYZcJf6Neh3tXwrxZbieD68v8VeTmqazqyCsUkANJMo2rZaTfH01JMJd4zaX7bAi0cr7s9UkUFcq3CWwox5GJUjOQzr3H0rX1WnDI/O0gahtjm9TW/ffQ1xl5JLO7pPTkBRd0RPYD64LOwtY/l/JkKA0PJL4YHtIkiVtPN4Lnlvl4Ba/OsWOB3vbIsbbrFcMsXevvRpF17wVCzGtYrecN6y1cwEDuIjp7hazQrtPsGeivDRKabbKmAtJ1k/PK+MU9jLbezthLpDMj8DPeU+H7t8UBa+qC4ewE3j2++ACorSL57MjTDqOQbHUyJrGsROR1ONC7nWVpspqgySUifEsTS+yO9ilsVM3No3onAE8rCBqQwX3BGtoszaWZ6bEHvN4NsSwL78wEsZXVFoZTbc1o0LJ0TAe9+YnOhnPadznkqKw/tn79/wc/I3DPTzJ8+38YR6r0+sxt2iT17B5lqveM0GaS2y8AHJLuz0OT7x0Y5KpiLalUhD+r9k/szc1LeWSx+FdTiOuY2gJEIqu9ehoQKP8uBCGaMjtKGauExtq3xcjaTuiPeipi/M5YgwrdM2qORFkdzjUUri97eNdQ/6vTAVQaBzRGvkBC7ki3dSLrBSolEX6qekDVqi48U=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL1PR12MB5732.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(346002)(366004)(396003)(376002)(39860400002)(230922051799003)(64100799003)(1800799009)(451199024)(186009)(4744005)(2906002)(38100700002)(66946007)(66476007)(2616005)(66556008)(316002)(6666004)(110136005)(478600001)(6486002)(6512007)(53546011)(6506007)(36756003)(86362001)(5660300002)(7416002)(31696002)(8676002)(41300700001)(8936002)(921008)(26005)(31686004)(4001150100001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?ZG13bzRVamdDSkdJTHlqWkZrQlNnbXRUdHZjN2tmSWxKYWcxS2RsYnFZY252?=
 =?utf-8?B?NSsxYjM0eGNTaWExVDlTYVVYVUNMSGhDdjIrZXlEN0hRTlpETXpxelVHUjBU?=
 =?utf-8?B?ZXZXbmx3bEZ1Q0JFTzVXL3JzVEJndGU1Nzh2cm40MXM1R0hPSXN2K291QzJm?=
 =?utf-8?B?TndDZFNybmZVeU5RWUpLR3Q3WVluVVBVck92Qkl5Vm5WcjdGSnVyNngxZXJX?=
 =?utf-8?B?VG5CeXdTSlRKQWFPRitmODdOa1o3OTA1YkpVWFlhWU1NRlYrMDJVTThmWUV5?=
 =?utf-8?B?d05qTW5Ua3RGMUwreFZxZ3UzSFZxUDI0Z2dIcmRzZDlHODJNQUJ0R1VHcU95?=
 =?utf-8?B?cE00SDZ1K3k5clZXNzdzSmdZUFRqS09ieWduRjVZYXI5ZllxQy9pWHJ3L3dH?=
 =?utf-8?B?Y1pyeEhqQzJ0cEFPS1MzOXJwTWhNZ0MwVElqREZVYWZqVjBjQThNZDhhR1VM?=
 =?utf-8?B?b01UR1h3aGZaR3NFazdlMStWUWtSMUVHS0xwNnh5VGVOWlAzeHEyUXZZZVZB?=
 =?utf-8?B?MXdNSEZYWGxSUmYwdmtMd3VEaCs5WGVDTlNhTTZla2FROTZCYnl1QlZxcVZu?=
 =?utf-8?B?Rko3T1c0Tmt1c2dZdStYMm44VjRLdUFxb1VSck9BVU1WTE92QjZOWnRyYVZQ?=
 =?utf-8?B?ME5Fb2ZXOXdRUGNJZGJDUStxWVVzTkFUd200dHJZbDVqV0pOVzZVR2lBbHQ4?=
 =?utf-8?B?bDUyOThKUm1LTk1rMjIrNldFQ1dDQXQ4NzBIb0VYT3hnbDVvSWJSdmw5TWlO?=
 =?utf-8?B?T2k1cHNzUS8wdGI0N05EWUVOYnNleVVzMjA0S0M0WTFTRk45UUcrTVFadmZo?=
 =?utf-8?B?b2xkb01VY2pHeXAyZ1JzeG1xc3FvaGlQSGpjam5kaG1jZkVGUTE5djdGVDV0?=
 =?utf-8?B?bStmQXg3cTl0N21tUHFSZEU1WkFobjcwZ2o4NTNaVnJZeG5PNHNpWElnS2Qx?=
 =?utf-8?B?ZmlmWUM1NjZZdFArZHlxMjJHRHErQjhzTlJkUXNlSU1PNVFoQTZDRVkxTUFE?=
 =?utf-8?B?VGFjMERHeWs5MC9qa2h6aE9IaWZqcUJVU3FkU3RuN044Y0NvRjYwb2wrUjlI?=
 =?utf-8?B?SXp6dEVGN0Vnd0JKMTZmT3g5SGFtMXBrMjNRYVJkcGJ2eEhGZ0VOVlVtVzFD?=
 =?utf-8?B?UEo4UzRlQ2oxNVprMy80bzRyQ1c0YkNtMUd1YVI4Z3I2Sm5JMnNMWW5VY1FJ?=
 =?utf-8?B?eVVQOWp4SXRaRjVwRGhEdkswT29ST2d0U1kwdER6YzF3aGZaM05iMkk4ZHNq?=
 =?utf-8?B?bDNmQVBUd28xN2w3UTVMNzIvc21KbU5tZFViWHJVdVo1ZWpJK3FGdEhvNjBG?=
 =?utf-8?B?UHh6clhhY2JudndIWEIzTGxDL0RXL25Ba1lMdHMvd2VDbFNjbzRPYnVkeVpC?=
 =?utf-8?B?NzZlcWxUNmluWlArZTd6SzJIZU9MeXlBSFlIdURWbkk4MTlRVTZLV3ZkZTUw?=
 =?utf-8?B?OFVBQStSN1B3anhYOG45VGxzYWdUSEg0di9rV05CdjYrc1UwNzFCL2ZiaVRV?=
 =?utf-8?B?bHJMcW11S2hwU01LL1BQcmRXSFRKbkhSV2NHcHgzTDAyVzlCdXd1Mm5TUG13?=
 =?utf-8?B?VGdtYy9PYWFqb1hFbWs4OVNmdG0yNXI0R2xSTk1Bb2I3TnRHdk9GNXFmNC9P?=
 =?utf-8?B?eWdsYUZCaitEb0pLb2V0cVFxV1lIVkIxVitmaUJIRmpoVzA5WUtucTFiQlJC?=
 =?utf-8?B?c1VMTERIMTdhVFpkWUdRMVZPVjZ3TGNwUkhDUjN3ZXJnOEVpcnBTdERWMWFK?=
 =?utf-8?B?R3VQNmMyd29qMlpBd0owcTdhNDBBd3BVdUlMdnVwSk5KTzVYc2VqWS92eWU3?=
 =?utf-8?B?UVpPYTBzOHJQL01aYlQ0cWluT0hlZWxjMmdTYmM3VjgzbEgrNUdGRU1ySnBM?=
 =?utf-8?B?NTEzQWRRMVZOM0Roa29obk9mdjFDY2VRbzF3RERXbTU5YjJpTmQ4Njk0TnRq?=
 =?utf-8?B?aHVaRjY2dndkalRFTm9CWENOZjZWQTVzK0tEQVBQSnErZ04xNjMxOU1rYy9C?=
 =?utf-8?B?ODl6Ri9mUEw2b096N0VselFxd2tUa0pVVElSWlVWQ0FhQzdGTXpEMitPU1BQ?=
 =?utf-8?B?bkVNem9udEQ5KzVWZ1Fmd05iL3dFdE8xS2JCdFdrcENVbW5OMjhUbDI3dG5J?=
 =?utf-8?Q?iwN57FTYanqtGNvR1gWIqxbZ0?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2331988-395d-46e0-8f77-08dbd628b625
X-MS-Exchange-CrossTenant-AuthSource: BL1PR12MB5732.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2023 13:37:35.1693
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pMA/OsXIm9rbR8czwEARuRhoE/0UXL9ECtDSyGlMKodp7JrINplM1h1sqW+XpZ4Vef3qwoFquemrYrvIONks0w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA0PR12MB7554
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/25/23 21:04, Edgecombe, Rick P wrote:
> On Wed, 2023-10-25 at 11:10 -0700, Kuppuswamy Sathyanarayanan wrote:
>> Looks good to me.
>>
>> Reviewed-by: Kuppuswamy Sathyanarayanan
>> <sathyanarayanan.kuppuswamy@linux.intel.com>
>>
> 
> Thanks!
> 
>>
>> IMO, you can avoid "out" label with (!ret && !x86_platform....)
>> check. But it is upto
>> you.
> 
> Hmm, yes it could. I think it's a little easier to read as is, but just
> my opinion as well.

It might be even easier to read to just have:

	if (ret)
		return ret;

	if (!x86_platform...)
		goto vmm_fail

	return 0;

since jumping to the out: label just does a return anyway.

Thanks,
Tom
