Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9002B7C5521
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 15:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232257AbjJKNTN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 09:19:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbjJKNTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 09:19:10 -0400
Received: from EUR01-HE1-obe.outbound.protection.outlook.com (mail-he1eur01on2059.outbound.protection.outlook.com [40.107.13.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F4A593
        for <linux-kernel@vger.kernel.org>; Wed, 11 Oct 2023 06:19:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BPb6CSznNFmTGyLZ/VMcBGdM8IZIstMcoFSIFB1YVGuCJfz5GL42WuuS424FqmkM1oqr2MDiFdq/QQR3+36t9MCfx1/z2sidsNtuNAU5uVQXWK5ghRL2jkwNbQXnls8zfHF/PhJDhUnmDFOWbrKJZIrIl4oZXj4kIoDaiMUcsKyF3vo6y18yhRhpa6vybIw9wnvts/0dZWD3Ii11wepQC7LeSeItXnK/DJzftEJjABU0lPzAbET+4jkAEN2YjKipYjaz3O6eyW7RNPwSP8heMdp0HzHmlqprIuHdNMySBNoA93U4W66XKd6uEroRQ9KcNOf+jBYUypPEfU9s2+ymAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0nLtVZBK2uK1oS5PxAZ18Ukh96EKOU5KZtz6GTGg+8k=;
 b=KBoO6vySL4wcWI4cRds6a3oq75Bx23NeaJ3TV1z0Dyn0J/8jN+UFLPkAsPAvWh9bGzenOurp6tpBdPPvnYcl0v7FCIlUGs1wnrhRCH3XP61Q6jbvglffDxytA2CdU94NqxQno/ZYc72TWHckg8GdRdBSjcq28b+w4KAZJP3fQnMGDOHhYHwS3kxg8ObOyRPE/E7a1nGFJ6WNPOKbOcKvnt6PLfi3ptniBGSMP0kqM58E2lEvkYt4PZHFQi4F/KCYSUCLCX52PVq/gkelzRIgPcRuzfAa4MSnAD7ZoubQZ6SDIjb2d6IDfJiPDlxow6Qb5AjQXTnknpyhh04bDwGD6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0nLtVZBK2uK1oS5PxAZ18Ukh96EKOU5KZtz6GTGg+8k=;
 b=OIyjPU8RTmVZLbBYqWWP7zH2CQu9XEVcUxb+y//akNmGSHErIBBwX9sHVZGoPF2Zd2TCsblnwYJ+3Yy277oTmTgvQet6rq/ZeOTHg6fRxwW11vBAzarSzLdhs48xEpZqS2dtcSYUhWlUh2jb3Ss9sO4h0U5CODVhq9G09/mKHmo=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13) by PA4PR02MB6894.eurprd02.prod.outlook.com
 (2603:10a6:102:f6::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6863.38; Wed, 11 Oct
 2023 13:19:04 +0000
Received: from AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::31ee:1e73:e80b:d9ce]) by AS1PR02MB10348.eurprd02.prod.outlook.com
 ([fe80::31ee:1e73:e80b:d9ce%4]) with mapi id 15.20.6838.040; Wed, 11 Oct 2023
 13:19:04 +0000
Message-ID: <d6ab6509-9969-4f36-96fe-b6ce6bc74b73@axis.com>
Date:   Wed, 11 Oct 2023 15:19:02 +0200
User-Agent: Mozilla Thunderbird
Subject: Re: [cocci] [PATCH 2/2] scripts: coccicheck: Separate spatch stdout
 and stderr
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Nicolas Palix <nicolas.palix@imag.fr>, cocci@inria.fr,
        linux-kernel@vger.kernel.org, kernel@axis.com
References: <20231003-coccicheck-v1-0-07d2d900a52a@axis.com>
 <20231003-coccicheck-v1-2-07d2d900a52a@axis.com>
 <alpine.DEB.2.22.394.2310072140340.36842@hadrien>
 <5c76da14-e34e-afbd-4265-493c66e0bc60@axis.com>
 <b37c26-154a-2db9-4944-26a8aa8af7af@inria.fr>
Content-Language: en-GB
From:   Anton Eliasson <anton.eliasson@axis.com>
In-Reply-To: <b37c26-154a-2db9-4944-26a8aa8af7af@inria.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MM0P280CA0004.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:190:a::18) To AS1PR02MB10348.eurprd02.prod.outlook.com
 (2603:10a6:20b:473::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS1PR02MB10348:EE_|PA4PR02MB6894:EE_
X-MS-Office365-Filtering-Correlation-Id: 031c0a5d-e905-4071-fb31-08dbca5ca43e
X-LD-Processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: cvfJ/M+NKcv+LMrpbaoFppRJ2MBlc/LcsFIXEDybWAu1wHw746WHLYtV+sCOpNLILLhvhb5Nv8pV0lJJqQNeC6SG9LY27I2v8CJ48fI19GMS9hkPzEMjgvjakUPSNq50eKJm7Q3dwvED3pY5sulpcXsRnynUhG9nVCL0O8jO6QX9SuVbBLuL1jA7rmNfRCndx+pa5ORSHOW6leijK8tkkfM1/gup8Vua0sttO+0nc7fKQHYWidR5l9y9UCFpiprnF4T3VCAKmad/UiZHAX0ebHCbDulFt6cimneFjq/PKYRSm9RRaDUTFmWdSgwHecThC8UDR6+86QFa1ZCYgy2qRx7S+V0FGxpp4sNyPPN9RieCgA2zK9a8Hoopd52SBpEex27HwnF6yuERvQh7fIlJ6hle2eRttTinZixjJi7MZOt/cLDUgEa9qSnhh9hposAM+HpbmtAMJYVXLP8nFCttGJIjinVzlcx41d9axdv+8zE6q6X5CGLRfYjbN/E9zSoIREk8lv9JPoalAnUzftuRhr/ahnLEDGE93xKPFYIJgaOXiBsozPAoEcCm5G37ORv9oEORoDV4Af/JwKrZTyKct7Rf+YqIlQb/00e1f2N0UOmNX4okHLo0mk7oSoGDTitVaupM3o7gJvsdNzYbQNrqIg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS1PR02MB10348.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799009)(64100799003)(26005)(107886003)(66899024)(2616005)(478600001)(36756003)(6512007)(6486002)(6506007)(86362001)(31696002)(38100700002)(8676002)(66946007)(6916009)(316002)(44832011)(4326008)(41300700001)(8936002)(2906002)(5660300002)(66556008)(66476007)(31686004)(83380400001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?eG5aRDZJV3NBK0hLREx1VS8rNEZvazhZU3U2NTdSS25aTmRNT0pxNXI2czJV?=
 =?utf-8?B?UFhTNUdFMTcza3BGcFVuZlF5clErNVpnQ1NjSVR0THlpMWdqUGd3NFdtb3NI?=
 =?utf-8?B?NEwyOWVwU2VvbXJsdUVNWWdkRnZEUkt1elhXYWNkNzdmc2lMOXVoVWU1MU1m?=
 =?utf-8?B?WG52aGxiNHE1MVdTWGhRNVd3S2pUYU54K2kwV1dYNXVLN2sxeGM1eFdjSGpK?=
 =?utf-8?B?V2NES1AyUk5NUUd6TnNtUjREZUd1aWV0WVVlZVVDRHpHeVpXakxPbi9qc0du?=
 =?utf-8?B?MGRjQ2pHc05tcitsL3piSklmam5LdmJBcU1abW9FZ2VmN2c0YUJCZTFUc2NH?=
 =?utf-8?B?Mk51L1ZMRGs1WGZFQUtNWnNLbSsyaU41Nzk0c25nMnpYRytvN3ExYjA2cFZP?=
 =?utf-8?B?ODd1R0JCNzJYN2J5a0VZaXE2WVJEZVlTc3UzSjRxM0RDaFNOL3BuMEJnVi9X?=
 =?utf-8?B?Uzlub0M0alhiQ3c4NDFOYmJ4Rm1PMW1NeHl4TVVsWGg0NFFqK3Z2L1JLcWo0?=
 =?utf-8?B?MFl2WjR5Q3hHeGJBcjVNZ3llU2hBcGxDWUhkNlg3NXZqbGJFdkFaVHc0cGdn?=
 =?utf-8?B?Mi9VTmZGS2YxbVU5NTZPSHlCWWVyYnJLUXNEeFdPb0lTZkVjTWJSNTVreWNB?=
 =?utf-8?B?MzFCeTFsUnkybUU5TmdZYVFhaFZYdkZPeExCRnVoZzNBU3pCWXBTVGQ0ZEVw?=
 =?utf-8?B?VzFQeTMyMlEwY3IzSWdtdFArZ0lLNDJGanlyL1RsQSt2aUxDZmRRZkprN1VT?=
 =?utf-8?B?dUI3K29HNTNCcEpxdGgwc2Q1enFjWGJyS25FT0xvZWhCS3BEYVhGQksvOWs1?=
 =?utf-8?B?aTh1LzdSODRvZS8xTGlZdjdvM0pnMXF3ZFVFWGNOYjRCTU12U0FXMTJSTWVK?=
 =?utf-8?B?dkVFbmxFQmtXdDRqelZ3V2c2dGQrWDJZOHVZM2pxMmhKNFB3RklFSVY3MWdV?=
 =?utf-8?B?TnFXbHNKajFjU1FsVEIrcGtkTGUwUDFhQkxxMVZiSnFyQkpYSW96WElpeVRH?=
 =?utf-8?B?UHpXZVFTdFFQY0Vyck9IM1cwUnB3L3gzTHJBcnFYblByaUJsb1dqM2ZtVEQ0?=
 =?utf-8?B?bUlVa3dkc0h6TUQyTkRFWSs5MG1MNUN6d3c2NE0rTXNvY2RFTjlwOGVCMlFh?=
 =?utf-8?B?MzdNdUtWUDJDWm9ZbUszS0plNkVlajFsbkZsaXRpVlB1d3p5cjF3TEorcExp?=
 =?utf-8?B?U3FjV3o0S0NZMHhlS3J0U3V0d0xhQWZhelBWTHJZdEJDbEExQjlLQzFPdWR3?=
 =?utf-8?B?WVZTZm9VWDNFUG9NT1J5NWxIQWkwa3VrR0hySVJlVTROcE01MFFQMHhlUG8x?=
 =?utf-8?B?d0FZeTdLbnkyemFkYmd6U0ljU1BWNythYU9nMmZ1SzBvWTdiSjBQWUI4Vk1z?=
 =?utf-8?B?cXVHOEpDRlhiYkdES0xCNjhZSzYwUFBlaHd6R1k2Y3VTQnVTS0pNL0hnM3Zp?=
 =?utf-8?B?VDhiY2dqR3dGc09YQUdDbVNnL0swMWc1cENmQWFOb2VCTTVFeXM2NHRNRFp0?=
 =?utf-8?B?eS80blZYaVh0NHRYOFc2bmJQbm9SQnRWM0ZZNmRRWi9WcWhaTmFsL2cxN01i?=
 =?utf-8?B?clRyUEFoU00vSkl0Tkx5VW9LVWR4UU50KzdJZTN1V0ZpWHhuV0kvb3B1ZmFD?=
 =?utf-8?B?ZzNWZk5yQmNCL2ExcmJLYlUzY2tlaFlTWjdQTGZpOVJ6YXVScUdmQ2xBdWpJ?=
 =?utf-8?B?d1Y5MkU0dFZHRXZ4M0JBQlRldlVzZ2oxTlpxaWRqcHRCOEdSck5Iai9pV3pQ?=
 =?utf-8?B?YysrZldaMHM4OW96ZmZiTmZLeWpydzNjOXlZWEJXb2orNU81bjdIWnVVZzd3?=
 =?utf-8?B?ZlRDUTZ0UmJtQXNWQ3V5QzZ3bEFNK2JPSTVRQVpxM3VRZmQvM1ZUUW1iYmll?=
 =?utf-8?B?SXUvYnREdTVKZVlWai93Ri9PWm5oUVFaTVFyMnhoZTZpVjlTWnBXRUZvTytY?=
 =?utf-8?B?VFRBMU11V29sMEVLbHgyd0NVQjVjQ2t1dk9udk5CUlRrUDBnSGJrUm5kS09p?=
 =?utf-8?B?ODhYcTJqK0VRQjlobElxZU1ISVpPbm9FelFBVU1ydk0vUjVPN1FBYzQyYTNC?=
 =?utf-8?B?TXM0M3c4M0laVWJ4NnBVL1EvUnNDdDk4bHVBQVkwMmNzQ3FGL0RTV0hGT2FZ?=
 =?utf-8?Q?P7+4=3D?=
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 031c0a5d-e905-4071-fb31-08dbca5ca43e
X-MS-Exchange-CrossTenant-AuthSource: AS1PR02MB10348.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Oct 2023 13:19:04.6904
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1o4JGQuVN/6i7ZfeSRXQGIaNk39ydQJnTxVu2MuX1dQl/T5NntZqpQJIXmmn7hWD
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA4PR02MB6894
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/2023 18.11, Julia Lawall wrote:
>
> On Tue, 10 Oct 2023, Anton Eliasson wrote:
>
>> On 07/10/2023 21.41, Julia Lawall wrote:
>>> On Tue, 3 Oct 2023, Anton Eliasson wrote:
>>>
>>>> This helps automating coccicheck runs by discarding stderr and only
>>>> looking at the output of stdout. In report mode the only remaining
>>>> output on stdout is the initial "Please check for false positives"
>>>> message followed by each spatch warning found.
>>> What is getting dropped is the spatch command lines indicating the
>>> semantic patch.  Is this desirable?
>>>
>>> julia
>> It's not ideal but it's the best compromise that I have found. The problem I'm
>> trying to solve is to be able to diff the output of two coccicheck runs and
>> notify the developer if any new warnings were introduced. That requires the
>> output to be stable. spatch is always invoked for each cocci file in the same
>> order. However, the output from each spatch invocation is not stable as it
>> examines each source file in an arbitrary order.
>>
>> My workaround is to sort the output before diffing. The line-by-line sorted
>> output only makes sense if the input is one line per warning found and that is
>> why I try to discard all output except the single line per spatch warning.
>> While the terse output doesn't tell which semantic patch file generated the
>> warning, it does usually contain the offending file, line number and a summary
>> of the issue.
> Why does the command line pose a problem for sorting?
>
> julia

You're right. I was overthinking it. Since the sorted command lines will 
be common for the two runs they will disappear after diffing.

So at this point I don't have any need for this patch. I'll reach out to 
you again if it turns out to be an issue after we have gotten the 
continuous integration check in place. Thanks for the feedback and I'm 
sorry about the noise.


Anton

>
>>
>> Anton
>>>> Signed-off-by: Anton Eliasson <anton.eliasson@axis.com>
>>>> ---
>>>>    scripts/coccicheck | 4 ++--
>>>>    1 file changed, 2 insertions(+), 2 deletions(-)
>>>>
>>>> diff --git a/scripts/coccicheck b/scripts/coccicheck
>>>> index 95a312730e98..7e7c44125f47 100755
>>>> --- a/scripts/coccicheck
>>>> +++ b/scripts/coccicheck
>>>> @@ -146,8 +146,8 @@ run_cmd_parmap() {
>>>>                    echo $@>>$DEBUG_FILE
>>>>                    $@ 2>>$DEBUG_FILE
>>>>            else
>>>> -                echo $@
>>>> -                $@ 2>&1
>>>> +                echo $@ >&2
>>>> +                $@
>>>>    	fi
>>>>
>>>>    	err=$?
>>>>
>>>> --
>>>> 2.30.2
>>>>
>>>>
>>

