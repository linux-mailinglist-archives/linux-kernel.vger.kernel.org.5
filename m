Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE879803E07
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjLDTE5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjLDTEz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:04:55 -0500
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2081.outbound.protection.outlook.com [40.107.94.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94F14D5;
        Mon,  4 Dec 2023 11:05:01 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iOyZqEcDmZxz9oKFNCBdGC6taGD9PXUNoGVd7FcIko1TXmeRlzmaH31sBqqoV64Mfp/fu3+5IAX+BHYmNCRyRhulL3hvFCJhvF7rmk+HDcuZmgI1zSiJfryZ0yBk4Iaz127AGs1H5zoFA9pmpzfNE9wcDBc6lTwWuxrGU3reG0GGrSLyd5dHyR1vIEAA63y1MmomDUzjlyrNXoaqp4Qc9zWXhL1Kd4DnsHY3fyQxAW7aNqh+p/fmFEPD9TKbZ7sBRUfYQYQ3P8ydRRr04Nd89ewOkQXRPTaENCuHDTd3G/fmTP2pxMP6jzYQwTVVqvMP2Jz9mt2Ag8AgrxsKpS1EDQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dv/3rIs8OvZyahVuikpuOsd3Lj0wHjFqTGM/Cf2H+ww=;
 b=Z51POP8wffqgoq+OP3MSfcLbCLRmShdA2syx/fkR6/X+dfNB3pExuG2Z2MhMWAvMRdIXPn3gQN9lPghKTTwnxpc9VlcaMQ5mk1rTbFGAQ58gp7O5FuWwRMWNtDRU84G9uuzczJvzRlX3nG2cPMzOUIsERaUHdZvjpBDqT4vOE+W3rnZxstrCR9b2kLqGKgh+TZ0+ZpM1Ckaydzb3xhaXXSxPk8Utl2zO/gxoDsoWhqu1f7sr1NzL4glgoYcphrPsMkkmXdH5HmvBM6dBJZ4MSda8no6amfhVKt2HP7/PYrPnkEhN3clIxDDW93pIpQKjz4wfisp4A0t5342y8GxVkA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dv/3rIs8OvZyahVuikpuOsd3Lj0wHjFqTGM/Cf2H+ww=;
 b=st4T101AgndIO8zva0dMTbQVNSWn3P4KifmQw0WY0FfXO3G6+TgQclp0zw0XQ7WdWEUacWDK2eHuDNN66F9HyPxsL6MITODKi2SjNb7PYLJ3AX8aVnJiSdk6StlG1ti7Sxhy0mNx5lT+8zghxhkw+PKYkIiiEJ9P/qTEx+yl1cs=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from MW3PR12MB4553.namprd12.prod.outlook.com (2603:10b6:303:2c::19)
 by DM4PR12MB5865.namprd12.prod.outlook.com (2603:10b6:8:64::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7046.33; Mon, 4 Dec
 2023 19:04:58 +0000
Received: from MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b]) by MW3PR12MB4553.namprd12.prod.outlook.com
 ([fe80::1549:8c93:8585:ca1b%5]) with mapi id 15.20.7046.033; Mon, 4 Dec 2023
 19:04:58 +0000
Message-ID: <660935b2-93bf-4ca0-836a-7aba46009c5c@amd.com>
Date:   Mon, 4 Dec 2023 13:04:55 -0600
User-Agent: Mozilla Thunderbird
Reply-To: babu.moger@amd.com
Subject: Re: [PATCH v5] x86/resctrl: Add event choices for mba_MBps
Content-Language: en-US
To:     Tony Luck <tony.luck@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
References: <20231128231439.81691-1-tony.luck@intel.com>
 <20231201214737.104444-1-tony.luck@intel.com>
 <fd8a44a1-9001-4e3e-a1a9-63e7f737e6e1@amd.com>
 <ZW4XjqxfYBFZId6H@agluck-desk3>
From:   "Moger, Babu" <babu.moger@amd.com>
In-Reply-To: <ZW4XjqxfYBFZId6H@agluck-desk3>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: DM6PR06CA0046.namprd06.prod.outlook.com
 (2603:10b6:5:54::23) To MW3PR12MB4553.namprd12.prod.outlook.com
 (2603:10b6:303:2c::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MW3PR12MB4553:EE_|DM4PR12MB5865:EE_
X-MS-Office365-Filtering-Correlation-Id: f55f4c9f-22a8-412f-bb12-08dbf4fbe8ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KKK/DeSspwTYFX+3pWuGOFoGLr21yOt+4pgT8vAJ00fyyWzNCP3qYv4SlNebXW1GBzNkNOuUffd8J6gLHVivqfk2x171V1mPWnyC30QEO7fQAS9LE5tArRexLY1eDDCh49ZVtBIiDbLBPHho4IQS4RFrle9GbKR80b++hfBjwPIFYSEmoN/9JU3Kqr1Du4RScRBAbq+f6ohf599kKf7D96tSDp30Ai3ZFPhj4IHlciHJ7YXGK9CAmzFlzmJ+L0OFjtw7yiu0tAnIiouMzTwaaGBZqAIa6RkOQVBFcjl5950Qdo7ELeUAkWCnNJUrDtXOzO04Z8bjB3U6FMQHL+Tu7Nw6rFeK3+FfDZZC55LQpaQ03sHahOKaFbQQPVW/dmtTgaQsXJweG3fnDkqiUcYWZWexkssV02tuogedQS8otocSVL1EejIo8/LdKSl5cHovq9oAA4ajdj6oFQRRR7bm05yU0tv3RGRePZv7UHU/SXmYkAyDQ91+Qs71+oGq0G5NNhTEiYLVV48kUy3prbrz9JDqbCrGe/Oi9nCWD94oyS2f/boVKqjg2f/d5I7Z3ydIAFCOcTxXKOHL4SCnbFwzJqDhCYllJCOmUDmd6uR9P/xx9DOSbaWZqGtOVYEi3xKizdIENVSlY7ekOo53es83kA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MW3PR12MB4553.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(376002)(346002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(451199024)(186009)(26005)(966005)(478600001)(83380400001)(6486002)(6666004)(6512007)(6506007)(53546011)(2616005)(36756003)(316002)(66946007)(6916009)(66476007)(54906003)(66556008)(31686004)(38100700002)(5660300002)(4326008)(86362001)(7416002)(8936002)(8676002)(3450700001)(2906002)(31696002)(41300700001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?L241QktIdkl2Vm5KTVE4d09RU2xRaWVITGM3TlRoeWllTGtCaHlGSmRISW55?=
 =?utf-8?B?ZjdtYmk5RTdTRWdlbFVmcUNkRjY4ZHc5Ym4xK2RFeUtoeGplb3JKMEhRWThn?=
 =?utf-8?B?cWVEMXNWYlZTMGtFejU5YzMwTnBMWFJEMnRmbUxZdkRxM29OQXlaUFNvL1cz?=
 =?utf-8?B?NDh0ZUhQYlAwN3FDUUQyNC9xNVlEZUhKakZSQzRKY1VPeVpET0s4N3lieEtK?=
 =?utf-8?B?UWtUTkVnTk5JaEVCYXIxNWNleFlSdXpRVTNHOEUrQ3lGa3ZDZVBRbEx6YlpL?=
 =?utf-8?B?NnluSnNTWmhrZFZqcy9GbmVEZUhsOGthZTZHK1NGNnM0ZEhJN2xkSHNraXdq?=
 =?utf-8?B?SU5zZ3hjU0I1YTRCalRrUGorYXpzV3VodmllenljcEZMNks4SUtBOXp5dnVp?=
 =?utf-8?B?UHJQalkrS3VPRU1kYTBkOWxCTGNQaEFEelNDV1UySHczRkpwVVkwZ0NzcjY1?=
 =?utf-8?B?ZUlka1VoU1JDbm1oSm9rQUU1SlRzTmQyS2FNenExQ2FuVUlVcmVPZ3BJRzc5?=
 =?utf-8?B?K2JxV01OSEJ6MGhVR1F6dkJON3pMRHRnbk4yd1VSdGpvZTNzOFNZYVN1OVM2?=
 =?utf-8?B?TlpPZ0huT210cldNUVdMakZaNUV0QktVS2lvMnFQek55eVNVQi9ROTBnamhX?=
 =?utf-8?B?RURta1ZBOFlwWGpIU2FJZ2lhNWpLS3lPRzRVcTN0b3ZNSGovM1JMSEdFYnhL?=
 =?utf-8?B?R3NVWXZhYmwzRjgwRXVBN05Uc2RIS3NFalIrYkJpTXdWc0JHVGJlRXhXNXBT?=
 =?utf-8?B?a0xuaVZrbzV0QnNyYzJ5cEIzQnJvSW5uWlVlZ1pjKzV0UVdMV25nQVNxc2xD?=
 =?utf-8?B?RlBMOXdJWFozajlNd1VhUVMwSlU1bWswVVVkc3NrVG1MRXhvd0dZdmFBRXZr?=
 =?utf-8?B?MTcwNkFGVElaWFZJOXQxSjdvSlF1WHRBTW1ORXgzTThiVlAyYVJ5NnpaUEQr?=
 =?utf-8?B?aWpwNFI1cUlsMHZhZS9keDFET21GVXUvY2t0MWQyTWJMUVdvNkFReUZDcnBp?=
 =?utf-8?B?Zi91Qm1ucXU2MU9OelV4R2ptRktMQVhZcEp1WjVEcU8vKzNQMmwvaDlzWjZY?=
 =?utf-8?B?WkxXZmJ2SGlReVVUdFRnb1pYV3JGWjRvUk9rei9mZ3lkQWdzTklERFAzM2Y1?=
 =?utf-8?B?LzdrUGxzVnYwelM2UXZpenhCL3Bwa3BhS2N0S2RsWWhaWTdKc2ExemQ1Wks4?=
 =?utf-8?B?Q0FsdEtod3dNY1hLR2FjVUhmTHNVMURrNmhoRVZjLzZ3MlFpUjFwdkNwcmpC?=
 =?utf-8?B?RG1iUjdONGNvM3BwWUJGSUtKeFRaRWtyQ0NsT0pJRG0yT1llT2xKcnVtcW10?=
 =?utf-8?B?ck9Wa21lWHhSN0Q5UWN3blhmeHpUK2IvcVJBeUtkZXpYaVpzamp3L1J6czVl?=
 =?utf-8?B?dU84Mm91aG1pMzNtbW5JVG5ucXRYSFJlRlUxYUxQOC9SOVNPdzBETy83eFJz?=
 =?utf-8?B?N2FiWFRzU2JDRGdKUDZYbDV4RU5OZHNjMnBPb29HZEZqVk1KRDcwUFVEQ2Zw?=
 =?utf-8?B?REdTV2tNRi92T0pnSXc2cmczOWZPaXNuR0ZrRVFUTFVWTlBpdStQQSs5ck1h?=
 =?utf-8?B?OHYxeGZ5ZGZxRVpmeXF5L0NkQ2ZWb1NkUkN0NEpuTm9WM3NwSFMrN1IrM0RZ?=
 =?utf-8?B?Rmc1SkdLMHZRZzJXZER4Zm5VdUdNNWhHQVRYMEVyQnd4MjdWUDNFYkh2Ukgy?=
 =?utf-8?B?c3g4QzcrREc2QU15Y1BqS3BUZTBlcHJRTW1mRjlvcm1la3pHRTQvVG9GV0VZ?=
 =?utf-8?B?NXRSa0xPSjcwTUN5S083aW1SbStKTDNIcDI5MDdaSzZJRTIzUnp0TmpzeCtM?=
 =?utf-8?B?ZXhESjJRSVNlRlBMOEY1dEZKdDVvVW1UY2JXaFRGV3B1Nm1kbWVwOUpYa2R6?=
 =?utf-8?B?QWJwbW5paDN0K285WEd5dGFReStiZkl3eXRjWlh3Sk5uWmRQeVg0THRQMTFm?=
 =?utf-8?B?QXZ5VXpsQ3YzZXRLakdxenBpVTU5NWorSjg3U2oydlZmSTBMcFVCdGhLR01y?=
 =?utf-8?B?eXhwZFFGOWVBMUhJNFJodEo5RkR2Q25Wc2djVEh3MkhlMU92ck5tbG9PV2pR?=
 =?utf-8?B?RjdYUWFCSG9hK0pCNytYSlFaWVRib1hmejU3cVB0Vlo2SWQyeFFOdGFaM1Jt?=
 =?utf-8?Q?wR/A=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f55f4c9f-22a8-412f-bb12-08dbf4fbe8ae
X-MS-Exchange-CrossTenant-AuthSource: MW3PR12MB4553.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Dec 2023 19:04:58.2402
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pJlA2oE4zjkNj7hKH21s/z59lFkLOyWTqwiKuVxl9gHB1L1saCEXx56KdUdIMqj7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5865
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tony,

On 12/4/23 12:16, Tony Luck wrote:
> On Mon, Dec 04, 2023 at 10:24:58AM -0600, Moger, Babu wrote:
>> Hi Tony,
>>
>> You are intending to achieve two things at once here.
>> 1. Adding new mount option
>> 2. Changing behaviour for the current option.
>> I think you need to split this patch into two. Few comments below.
> 
> Hi Babu,
> 
> Thanks for looking at this patch.
> 
> You are right. I will split the patch into two as you suggest.
> 
>> On 12/1/23 15:47, Tony Luck wrote:
>>> The MBA Software Controller(mba_sc) is a feedback loop that uses
>>> measurements of local memory bandwidth to adjust MBA throttling levels to
>>> keep workloads in a resctrl group within a target bandwidth set in the
>>> schemata file.
>>>
>>> But on Intel systems the memory bandwidth monitoring events are
>>> independently enumerated. It is possible for a system to support
>>> total memory bandwidth monitoring, but not support local bandwidth
>>> monitoring. On such a system a user could not enable mba_sc mode.
>>> Users will see this highly unhelpful error message from mount:
>>>
>>>  # mount -t resctrl -o mba_MBps resctrl /sys/fs/resctrl
>>>  mount: /sys/fs/resctrl: wrong fs type, bad option, bad superblock on
>>>  resctrl, missing codepage or helper program, or other error.
>>>  dmesg(1) may have more information after failed mount system call.
>>>
>>> dmesg(1) does not provide any additional information.
>>>
>>> Add a new mount option "mba_MBps_event=[local|total]" that allows
>>> a user to specify which monitoring event to use. Also modify the
>>> existing "mba_MBps" option to switch to total bandwidth monitoring
>>> if local monitoring is not available.
>>
>> I am not sure why you need both these options. I feel you just need one of
>> these options.
> 
> I should have included "changes since v4" in with this message, and
> pasted in some parts of this earlier messge from the discussion about
> v4:
> 
> https://lore.kernel.org/all/ZWpF5m4mIeZdK8kv@agluck-desk3/
> 
> Having the option take "local" would give a way for a user to
> avoid the failover to using "total" if they really didn't want
> that to happen.

Yes. I saw the thread. Even then I feel having two similar options can
cause confusion. I feel it is enough just to solve the original problem.
Giving more options to a corner cases is a overkill in my opinion.

Thanks
Babu


> 
> Not in that message, because I didn't think of it until later, it
> opens the door for different events in the future.
> 
> But I'm also open to other suggestions on naming and function of
> mount options here.
> 
> Thanks
> 
> -Tony

-- 
Thanks
Babu Moger
