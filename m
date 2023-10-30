Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296057DB2F6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 06:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjJ3Fuw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 01:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229829AbjJ3Fut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 01:50:49 -0400
Received: from EUR05-DB8-obe.outbound.protection.outlook.com (mail-db8eur05olkn2093.outbound.protection.outlook.com [40.92.89.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F5D0BD;
        Sun, 29 Oct 2023 22:50:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UOEmX6LvXdfCsU6fkRTwY63qiDAvQjWxepYojkoN7Pz1SHqgAOkLvDRnxguHQ0b3D2tgG3sloqiNG/F4urzPOwQQBciXAwkMswe2R6xqCIowpHZ1dVk+Mhu6WaSscE1SqNy+rIkwbpaGrOZ0uyf5dtxcRiOMXd6Yp3m58xeoVAXQ7kUprQfmhWs77Swu5rm1Uav3RzPS/D70jLvMf0A5tzoPW8V6OdfkNSn6JncXt1Q0AI3WmdLil0d3go88npz/JkrlOg8Xe42NDSv43bwPjz20B5qRzo+x3rDayKyfA/T5IYy85/EQKVrWFns7K2/W6jN17lIx/DlBaPIGF/rdew==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SYqA4IctbEkQT2KQ80rUDUKN8ziquz6/k+wW9c3GqA8=;
 b=kSKQy93T4lnhy7xLL9lUKxkP/8MnEL4f0kPTheHzEQaHxqsdEIVmJvGDI7jDbGzRYZxqey6exOImZbfv8ArpmBGrZpfCepWJaSE+A0K0oySpN10D+bI+Z3BkTgnID5M+ltHzwQA5xeYGuf4xLfVkbG3u/DoT6ENPd776ds6hc5xIE3Ohw7VrpEKdHHCdSG6Vub70dO/443a9z947CHCu3aFaeceFwZSppIFKbM3CPVImJYWbe/AltDq2/rpXdVTJEu207szgLRi7zcth5HLXq9gHedBGQFifpxzF39gGr7k/nI6oJNYLt4jhojR7JKXLoD+r+9y+fN7IUf/6nJjyug==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM (2603:10a6:20b:333::21)
 by DB9P193MB1580.EURP193.PROD.OUTLOOK.COM (2603:10a6:10:2a5::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6933.26; Mon, 30 Oct
 2023 05:50:43 +0000
Received: from AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d]) by AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 ([fe80::b89e:5e18:1a08:409d%6]) with mapi id 15.20.6933.027; Mon, 30 Oct 2023
 05:50:43 +0000
Message-ID: <AS8P193MB12857C4E9B8C7EEEA2506AF7E4A1A@AS8P193MB1285.EURP193.PROD.OUTLOOK.COM>
Date:   Mon, 30 Oct 2023 06:50:54 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix error handling in begin_new_exec
Content-Language: en-US
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Alexander Viro <viro@zeniv.linux.org.uk>,
        Kees Cook <keescook@chromium.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Christian Brauner <brauner@kernel.org>, linux-mm@kvack.org
References: <AM8PR10MB47081071E64EAAB343196D5AE4399@AM8PR10MB4708.EURPRD10.PROD.OUTLOOK.COM>
 <87mts2kcrm.fsf@disp2133>
From:   Bernd Edlinger <bernd.edlinger@hotmail.de>
In-Reply-To: <87mts2kcrm.fsf@disp2133>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TMN:  [xmh7MVs1REkPjFB03ZFK1+1FxwbX7Jb9/ycdXtifm1V9gLtwxgGYXm0+4jr4W3u5]
X-ClientProxiedBy: FR0P281CA0244.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:af::13) To AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
 (2603:10a6:20b:333::21)
X-Microsoft-Original-Message-ID: <d3b7f4c0-bb4d-45b4-8f43-70b9014ed5de@hotmail.de>
MIME-Version: 1.0
X-MS-Exchange-MessageSentRepresentingType: 1
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS8P193MB1285:EE_|DB9P193MB1580:EE_
X-MS-Office365-Filtering-Correlation-Id: 7c5e6e80-2dea-405a-6754-08dbd90c275c
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: DmUd6cpr80h4kbg1MB4UUGzVPhP3NdIUaakqDVbiDs4tV1Xe4SjnoneUHJY8AGIPwoXYoaON2oSokXUUPtEQwiN7ExJzMA+jRgL1UtUAZ1i5CGf3Mb5iFnfhFos6q5wnQZD1MngY+JSy9BuxZdJXZXfhnRWcTqQzzxy0J/QIdZ+mNdQEOhV+mLzfN8I6SpNd0s6/eOT5Pa7HqjchJQH0Cp8CzHyMRyvdxzha5NLwD7p7a3x9FC2xnMNfegUXtly2yGEnkg2Xzo8IYHL2WxlqCHzntZCS113I61I1dTT9DlA36VeoSRrKwUTCBd8UInBee+ehbssWpIQ2JoWQ/7TT1pqy+GxJHEBkvjgrUe6pL7OUS7dwuGOYdvQYPQIELhLya8CRUCV6zKrPka4279XR4JEk5biXsojM26GX6qXFDSx2aUnOLD8N48fEsQpNrpusPSWD1nF4PSiwPwwR9scco6iU6NHKw9ew4uPpNjs8fVrVGO3hKHc2d7QIEg3pnFhbW5kUcZSXxD2g0RqTgDu46Z4w42cYHiwkKUOD2MYGCAgNyU94Sm4hv9F5e4MVXgmR
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?dWM4K0QzWWFqbURMS0l3bGl6VzNGTUUvdG96Y2hVaDZQazJvcVI0dHIrdERN?=
 =?utf-8?B?UTlMOTNOTWVkOW9wVXlkakgydTVsV25heFY0TmIzT0htWGVCaU8xYWlpMzI3?=
 =?utf-8?B?YjMrUjFXSnh6UVQ2U0VHZ1VUVVMrQ1B5QndhYW1HWithMVRJVkZqUDlqR2FP?=
 =?utf-8?B?emVTNGx1ajBXeFZ5RUhpV2Q3YnQrbU1PWnF4OEF0VlhvMHlOeXIyYnJ1aDRL?=
 =?utf-8?B?cXlyckpQWlhaelFvSUowSE9yczNlMnlPWkV3OTRrdGJqbUpSbGVCL0Joa2g4?=
 =?utf-8?B?UEdJR3VzZXlmZHVXdm92NE1pbSsvRlhTcHJoUGVhTTE3d21BdTRzakpvQWs3?=
 =?utf-8?B?SkdIRFdkeE0rK1pSM2xYVnphQ3FkNXBMa2w3L3FzaURGVVA2blZpNGFIOUd6?=
 =?utf-8?B?am9wbjNzVEJ2amhBeEVjbTVnS2M3c0ZVVkxYa29IVmd3bHRtbjAwR0kzT1J6?=
 =?utf-8?B?TjJVTkp6UnZRdTA4dDVmaUdyMVVBUnIvOTRreXVjMGVwcmtKSlJjZ3RmVnd1?=
 =?utf-8?B?MmhRakI3UWp1UFNGQTZka081ZDFGR0xCTHBQSGFsTlcrUWFTbDJ6N0JkMThM?=
 =?utf-8?B?WFlUNzdGQXFvUkVRWGVtc0tyUCs2N3RScGtrTkxKSHlOV3ltdnR1ZTlLRHI3?=
 =?utf-8?B?WFdMSnBWYkdhQUJ5dDBQWG5yTmUzZTNtaDU1Rno4SzZuMVBGbkFlMjVsS1NG?=
 =?utf-8?B?ZHYzbXpBM3RGczVCaktqY2JVekt4UEF2TlRYU0JCN1dDdU5rU0pGaTBhWnUw?=
 =?utf-8?B?dkhlRzlUUjRhWjNLVUlySzZwYXJKMGNKUTF0WERzcmNIMk9YQWNEOGpyVVNO?=
 =?utf-8?B?bnBpM1NndlEyUVBuaDUvMWk1UFhNZDRMYUZCRDBGUHlCbmNuSEpBcCtqa3dU?=
 =?utf-8?B?MlE2VXVaTVFTdVBLM01HQkUwVkNWNEpHQUplS0h1UmtGSUd5TVFqQUExdkc0?=
 =?utf-8?B?Sjd0VENvS3poSEh5V0FReGFaVG9rcEhFVDhlODNrR0I3cFhDUS80a0FFb1gr?=
 =?utf-8?B?MmlMdzEwRm5MaER4OXlGamkxdlVhSHhQWlZCV251WkFJMHRjQ2djbHdIcjc2?=
 =?utf-8?B?WUxMZDErdEFDSWtvaVMwN3dXSVppMVJFRWFmMlAyRjFob0dXdXhJanVJMmRi?=
 =?utf-8?B?NGhmWGZPTDFuNFNRVHA4YnJYR1ZVdWwwQkhyZTNHeHVWVUkxcDMyd1JRanV2?=
 =?utf-8?B?Q3lBdE9VbmlJalk4cGpKSzN4eEN2VkpScktUTTVYcFBsbWQ2a2lJWUJHNTd6?=
 =?utf-8?B?cjMxV0EzaXpZK1drcVV2R1J1WTJCVGtRS0RkRmhMY0d4ZTdKTm9WUDIrUUV3?=
 =?utf-8?B?YTZIZnNYUlZoZ2VGVnU4c0ZrSUlWL2JCQ2lDWGpuZmM1MzI3cml5cU9yVHdT?=
 =?utf-8?B?bnpManBVcFhMWG8yZTYzdkl4UGpTa3NzMmpyWExGMk9BN3hhVCtoeEQzOG8w?=
 =?utf-8?B?VkhlTFBwRTl5N1BtVW9kbFJacnBMWnkzY2wxb3pwTFhaVGx2K0xMWXA5bUZW?=
 =?utf-8?B?TjVwdnJrRXZQa2JscG5lUjBudVprL1N1MXBKMHF1STFFS29tVmxycmhjVlJP?=
 =?utf-8?B?cFVXWjk2eFgwa2VZcEJJb1h6aEl3aE1XenVNZ1hHVC9JemhBMUZQWi92aVNv?=
 =?utf-8?B?SVByckU0akVMd3FaV3ZFMmV6NW51b1MrcHdSQmExU2JQWmJ4eExOY3l5L1Vw?=
 =?utf-8?B?QXRuZi8rMytzVXF5YmlQSDN5WjdEc29RYmp2YnhLcjFlWHZRcVljcnU5eHJU?=
 =?utf-8?Q?iBnaKAxl8Zekgihwjg=3D?=
X-OriginatorOrg: sct-15-20-4755-11-msonline-outlook-80ceb.templateTenant
X-MS-Exchange-CrossTenant-Network-Message-Id: 7c5e6e80-2dea-405a-6754-08dbd90c275c
X-MS-Exchange-CrossTenant-AuthSource: AS8P193MB1285.EURP193.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Oct 2023 05:50:42.9661
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9P193MB1580
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,FORGED_MUA_MOZILLA,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ping...

On 6/6/21 21:34, Eric W. Biederman wrote:
> Bernd Edlinger <bernd.edlinger@hotmail.de> writes:
> 
>> If get_unused_fd_flags() fails, the error handling is incomplete
>> because bprm->cred is already set to NULL, and therefore
>> free_bprm will not unlock the cred_guard_mutex.
>> Note there are two error conditions which end up here,
>> one before and one after bprm->cred is cleared.
> 
> Acked-by: "Eric W. Biederman" <ebiederm@xmission.com>
> 
> Yuck.  I wonder if there is a less error prone idiom we could be using
> here than testing bprm->cred in free_bprm.  Especially as this lock is
> expected to stay held through setup_new_exec.
> 
> Something feels too clever here.
> 
>> Fixes: b8a61c9e7b4 ("exec: Generic execfd support")

Note, ./scripts/checkpatch.pl complains about the too
short commit hash here, I overlooked that previously: 
WARNING: Please use correct Fixes: style 'Fixes: <12 chars of sha1> ("<title line>")'
 - ie: 'Fixes: b8a61c9e7b4a ("exec: Generic execfd support")'

Could you please fix that before merging,
the correct Fixes reference would be:
Fixes: b8a61c9e7b4a ("exec: Generic execfd support")


Thanks
Bernd.

>>
>> Signed-off-by: Bernd Edlinger <bernd.edlinger@hotmail.de>
>> ---
>>  fs/exec.c | 3 +++
>>  1 file changed, 3 insertions(+)
>>
>> diff --git a/fs/exec.c b/fs/exec.c
>> index 18594f1..d8af85f 100644
>> --- a/fs/exec.c
>> +++ b/fs/exec.c
>> @@ -1396,6 +1396,9 @@ int begin_new_exec(struct linux_binprm * bprm)
>>  
>>  out_unlock:
>>  	up_write(&me->signal->exec_update_lock);
>> +	if (!bprm->cred)
>> +		mutex_unlock(&me->signal->cred_guard_mutex);
>> +
>>  out:
>>  	return retval;
>>  }
