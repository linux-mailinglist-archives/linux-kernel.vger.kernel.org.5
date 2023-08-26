Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 248F77898CE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 21:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbjHZTbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Aug 2023 15:31:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbjHZTay (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Aug 2023 15:30:54 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2104.outbound.protection.outlook.com [40.107.244.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6EFE79;
        Sat, 26 Aug 2023 12:30:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EwgXxcJkmeg6kan4cVgrVyDRD38jZ3vieUujzc8YJHqGYul80tBMKrEznMSCnnWWlf3Iwk3P+cQdm1ub7PeKOe0cHpLpXr4ulNsz1BBAiSDwTUu29Xh05+okm3m6eMNLw5iTFy53MXOG2TGt+J1STKLVSf0gbcl77X5rFliV1JW9F+K7b5XM9sP7EQv4ganM71wEwfMDRhbo038mVFtWLPfi7aBZfSRMMkXQEuZ1/cQwUI3bt0BCFIP6r8wUKOxPcA58YlPP2fc+bqhuEMbWD/I1mHuQLSx4C9wRsMTl1j3RVnRq+oopZunnc+EVLVFPcbM2UnPvfEivifH0ICoS/Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bPUo+JoMsF29CSugZ1nF3OB5G6Pf23tePv/tMyTHsyU=;
 b=PX/KDxBjYiC0w7xYBrA22Am3oQVSrUV1jZpva//zbEEXiW8X8fmtkb8CYx84VV/L8CJy6EygzJ4Y+9hjDt95c5G26/Vgvmxoo1dNcwv37m6/l2UgbNNT4GRYvPqN2xD9TTcnPjwbR1bR4opOGhNZ9yYzyHQ38iYlh7clhjSBau8OezN+UAGk9MAx7kpIa2VlO290djSrF21xqq+wi2t7Zpnhw+zuY6RWcCjeLCxUYvPoWjYyQBbIo6jygOECwPRBZJPUFnpJxDB7nK+eNSxI64ZxEv87GFOOE/UXpJONufWz9ZL9C6IWHwDRoDQhww42lI35nDAkcXnBnZX+Mu8VzA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bPUo+JoMsF29CSugZ1nF3OB5G6Pf23tePv/tMyTHsyU=;
 b=QOZeA3jwSBpV3R+N1FbROYrKJfSzq0A2tw3AQXrllPqO5LHoX59/ESk46pCGgG/aU1XiVKQi+h0ZRyx8GdQv9cg6+1a8cAN9GG5lDHH12/G4qDpVHROg/SFn+l5zkGkOk3jIzetTg8bEXOxwb3wLTBgbWseHvOSXs71vfmXirkY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM5PR0102MB3590.prod.exchangelabs.com (2603:10b6:4:a4::25) by
 DM8PR01MB7109.prod.exchangelabs.com (2603:10b6:8:a::6) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6699.34; Sat, 26 Aug 2023 19:30:46 +0000
Received: from DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015]) by DM5PR0102MB3590.prod.exchangelabs.com
 ([fe80::bfa4:8250:f526:5015%5]) with mapi id 15.20.6699.028; Sat, 26 Aug 2023
 19:30:45 +0000
Date:   Sat, 26 Aug 2023 12:30:34 -0700 (PDT)
From:   Ilkka Koskinen <ilkka@os.amperecomputing.com>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>
cc:     John Garry <john.g.garry@oracle.com>,
        Ian Rogers <irogers@google.com>,
        Ilkka Koskinen <ilkka@os.amperecomputing.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf jevents: Raise exception for no definition of a
 arch std event
In-Reply-To: <ZONgPy7pK7Qc7Cc6@kernel.org>
Message-ID: <3d98ae94-eba8-2267-dce-9762fd12570@os.amperecomputing.com>
References: <20230807111631.3033102-1-john.g.garry@oracle.com> <373e8253-656c-84dc-c05-b578e3725d@os.amperecomputing.com> <CAP-5=fVsePTVU2qeeUzVFkWA7Oxj6bgSq+yWzO=t3y283vOgOw@mail.gmail.com> <dd4bc3fe-5b8e-6e64-bcec-29263df43086@oracle.com>
 <ZONgPy7pK7Qc7Cc6@kernel.org>
Content-Type: multipart/mixed; boundary="1372433909-1731103519-1693078245=:15634"
X-ClientProxiedBy: CH0P220CA0020.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:610:ef::33) To DM5PR0102MB3590.prod.exchangelabs.com
 (2603:10b6:4:a4::25)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3590:EE_|DM8PR01MB7109:EE_
X-MS-Office365-Filtering-Correlation-Id: d0435936-fc41-44ba-c893-08dba66af1e3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: FkdzUkGY8MmBlzNrvSrL2snuno2PDqPJtdQQD6xKe5oTJEUQr7jqbI/bMMEo+EtPXWP63ebzlXrXB9mrSajKa0SqmYRopSW44LCyuX9H+WXzJBY7/23pvpboK+IvRQb0jXQ2MbvpT7ChSzNTkMVMo/i+JhR9SGnSjVqudrUhtQWzJ/CyFeAYUxDIW4Ej/75dOdF1JdwrHUJgd+cWYF24Vp/fqLe19AvCqpZ9otiNzOEOfbhcPZDcAEOJv0OebaEe4T786HUZC1t+xF0Ywi1MhyTB9nVccSOvCj2TFN9dmQ3xeTJnlg5H5TE4jeHKwOZV+s4TXeQ/jY49Q0xo/ZS587nodtWbFTembo0Skjacj3A2ETrwHrw5DuJIdWJo/oYZQtMV3SGGDcxwRPRZ/VUxOcEs2Ibdw+iAJ4erh4Hxj2Ib9FQr2dVffFjv3H/W6eZ1jsflC6UVThO6EVX9fzyQv5fgENaZe9iT4T3eBBoG6Z8v6xZWM2Frx4CrcgMgT4MeYcaUeWjkjRM9SQiU56rh9YTBqvDrgNJc6J3uKltLAFZn4saKzg9dF2ZzYK/6VwELaS7CTIsMlEdbzt4VsPiTi1qm1T8ThDy+TZPphULTHEY=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR0102MB3590.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230031)(346002)(396003)(136003)(376002)(39840400004)(366004)(1800799009)(186009)(451199024)(6506007)(6486002)(6666004)(86362001)(6512007)(38350700002)(38100700002)(2616005)(83380400001)(2906002)(26005)(478600001)(53546011)(33964004)(52116002)(966005)(66476007)(66556008)(66946007)(8676002)(5660300002)(4326008)(8936002)(41300700001)(316002)(6916009)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?V2xFWVRMb3J4VzJjTG9peXlCdHcwL0lIb3MvdXhBY3Zhdm9qbmU2Mk1abkR0?=
 =?utf-8?B?aWNOUjJoaEEycks0NXlWTXJnTXFxYzdGTjRFdjJRaUR4TEI5RDNhNEh4WUUw?=
 =?utf-8?B?Y2JSVU41eUt5cVR1N0UzTTBONWZmRWRQTmRJUTlNc0wzU3RZVmM1OWhmZjl2?=
 =?utf-8?B?TWpwYjRrZXJGM0RQSklQS0tJWTJvVHYydVZacHVjcTd3UnNsQTJZZHMwRnU2?=
 =?utf-8?B?czlxbzl2d29uZjRSazZDZ2hZa1BIQ1JJU2pGT2MwaENGTGptUmlMaE9zMUxG?=
 =?utf-8?B?eGo2Zk5rbjc4S2JweDkzVzJLR2RSc2FPVmxRMjJ2YkNXb0dBTzRoa3c4aWtX?=
 =?utf-8?B?amttb3RRbElPcGlqZ3MyRVlYWG92Q1pLRGpFMVpzRzhDYkxKbVE3RXNRYWsw?=
 =?utf-8?B?SHdMRFcxQTl2a0tqRHU3UG1UTWV0WUVqTVBjWERsc1hTTXZUN0NGWFBoc1Ru?=
 =?utf-8?B?d28xU0xHZ2pCWEVJNjJvR2ZWMnFPRUphcXVSVUNXZE9TOFNTaWRMZW9vNmVF?=
 =?utf-8?B?MHI3eXFHdmVtL0tqbGRZa1hIODN3Z1lIcDR3OFZrQU55TERrRWw5MUIyYTdv?=
 =?utf-8?B?NTd0Z3pEdE5xQnVhSVlGaWZKcE1xeVVEMDQwS0oraExPT3krSndRSmJFM3B1?=
 =?utf-8?B?NlAvbmhGZTN4RWZ1clNuam9JS0IzWjdsT1RIKyt6MUhrUldGUElQd1JDQStX?=
 =?utf-8?B?aWJQS1p2ZmI3UElZbGYwblRPeEVNS21sTHdaSjJqWkZ3L2ZhSHNabVN1ZWtn?=
 =?utf-8?B?NklDOTQ0aGRPUFhvWU0xSVNWZFUwTHJXRnRuTFhVK09ocGFJcWFSMVFYWUIx?=
 =?utf-8?B?YndCUDQwcFVKN3pOUEY3Nm1ic3pxa280cmdMQUxqMHBlTlBmZVNBK2xXK0VN?=
 =?utf-8?B?V2p3dldGeVc1SWprZTZ4YXRGSGdsS0JJWE5hNm10YTExcVI1eDRuNzVYQ3NJ?=
 =?utf-8?B?VXpCbFJwNlE5KzkrNnhETWkyaTFjL1BFZytqUmR1T3RpU2VtekcxaWtVcEM4?=
 =?utf-8?B?WHFPWXlta24rS1FhT25mOGF3Slg2VXBxeXRuaDhlNE5uaFRTSmV3TWMySmlt?=
 =?utf-8?B?dk9zUWlOY2xuOTZnM2lGcG8yd3JGUVZiSGcxVTMxS1VvWnFEVVJ5N2xCQksw?=
 =?utf-8?B?TE1OSldFWmtaQU0ybHdHRFdxaHkyZUdFVi9oS2RLY1ZCZmdLVDg2MmFFemJ5?=
 =?utf-8?B?aU5iY1ZHOGhxZTdOSldwOUF0VlVkMlZRanNkeUJnTW00bW5IMXlrV2JTb3Vy?=
 =?utf-8?B?VlA0alRzbTZPUVI0NE9xc2hSR2MwNGsrZ1NVR2M5TjZtUEFHd2I5Q3ppS1hs?=
 =?utf-8?B?Rk8rais3dG5vQmJmNTRlRmRGR2h0MW54clNEY0wyTEhySngzblR3cmkrU0lE?=
 =?utf-8?B?dXVGTkt1Tkd2cTZaenJad2xmTzBuSW52SGl4b3lSaTJac1FTdFcwSXA5K252?=
 =?utf-8?B?b1NLakR0RGNwc1JZQ1JNanpsMFBKU0tTbFRadGlka3M1Tndyb2NhZHlrSWpG?=
 =?utf-8?B?SkxvbHd3d09rVVFDNHhtVFF0a2wvOFVLbi91VFZnbXZTQVBSMU5ieG9lVWNS?=
 =?utf-8?B?SjRDK2JHcGdUK0hpSm1lblBpWXJYa1cxSzVySzNWQzVEMG5iZm5xS0VUWXVG?=
 =?utf-8?B?bTRkRGErRWtJYmE5L083Zzd1dTBmTklNU1l0OERGMmJxNThVNHk5cWJ1S0Rh?=
 =?utf-8?B?QXVKenFVeC82MVJJYXZOMTR3N3FqZG5mV2M2Y1M1RDFlSXpRVzVVZXlpNjMz?=
 =?utf-8?B?Vm9TT3lhMlJhbHVFckpMVFhRVncyUklBRERBRFoyK3ZJVHhjbmRJaXFMTCsx?=
 =?utf-8?B?M2RaZDF6WWJ5SXJzOTNqNHVIOHJiZkZ3OXJyYkQ2dFBsVGt2UmoxOEZKaUZh?=
 =?utf-8?B?blNYVGNDMXp1bThQQ1dpcStVZFIxRENsOXU4Y1IzZ1hZOGllNlRhSGFhOGpI?=
 =?utf-8?B?VWZhMlU3S3J2UFR4aytST3kwRWY4T0tCWjNlZCtSRDVJcEZFVmJPcTdxYWxu?=
 =?utf-8?B?N2VsSFNiYmRaRlp2a2w3REZlQ05hKzFTZ0J6SkRlOHJhNG9HT2FuNUxVdTlJ?=
 =?utf-8?B?VnlTc3BiWENCUTU1TXFnZjJUQWVGYXR3VHR0YlF5enZQOXlmOHhyazY3UDZG?=
 =?utf-8?B?RTdJekM4TUdYQ25oYkhNSzlFK0krQ1VlOVN4U3h0VXlzV1JFZGZLVXNMU056?=
 =?utf-8?Q?EEmIvUrNSCsGA7qkdVwnRU4=3D?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0435936-fc41-44ba-c893-08dba66af1e3
X-MS-Exchange-CrossTenant-AuthSource: DM5PR0102MB3590.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Aug 2023 19:30:45.9039
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cWzBTxKJxdoCoVmrciYYBrIbFgWgnkG31zx8NBwf9WJeoNfR5RX7Yk2cDD1o4GL0WlCDNkpHKI9+Wuf8g7Jx6it/1LDC0ztCt/VmvQac9UwAA063CFmxxmKR8RX7PZ3H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR01MB7109
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--1372433909-1731103519-1693078245=:15634
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8BIT


Hi Arnaldo,

On Mon, 21 Aug 2023, Arnaldo Carvalho de Melo wrote:
> Em Mon, Aug 21, 2023 at 11:46:20AM +0100, John Garry escreveu:
>> On 10/08/2023 20:27, Ian Rogers wrote:
>>> On Wed, Aug 9, 2023 at 10:11 PM Ilkka Koskinen
>>> <ilkka@os.amperecomputing.com> wrote:
>>>>
>>>>
>>>> Hi John,
>>>>
>>>> On Mon, 7 Aug 2023, John Garry wrote:
>>>>> Recently Ilkka reported that the JSONs for the AmpereOne arm64-based
>>>>> platform included a dud event which referenced a non-existent arch std
>>>>> event [0].
>>>>
>>>> I wish I had found the bug in my patch a long time ago but, in fact, it
>>>> was Dave Kleikamp who initially pointed it out to me and figured out the
>>>> difference between jevents.c and jevents.py when porting the patch to 5.15
>>>> kernel.
>>>>
>>>> https://urldefense.com/v3/__http://lists.infradead.org/pipermail/linux-arm-kernel/2023-June/844874.html__;!!ACWV5N9M2RV99hQ!It9EhKK4s2uBUJyQvLg-ruUfENAA6Sw7TWVo_hF8XmFoQ6q565iYafTnN-yoBNh3EQ1IFa2tHknUjNHs5dI$
>>>>
>>>>>
>>>>> Previously in the times of jevents.c, we would raise an exception for this.
>>>>>
>>>>> This is still invalid, even though the current code just ignores such an
>>>>> event.
>>>>>
>>>>> Re-introduce code to raise an exception for when no definition exists to
>>>>> help catch as many invalid JSONs as possible.
>>>>>
>>>>> [0] https://urldefense.com/v3/__https://lore.kernel.org/linux-perf-users/9e851e2a-26c7-ba78-cb20-be4337b2916a@oracle.com/__;!!ACWV5N9M2RV99hQ!It9EhKK4s2uBUJyQvLg-ruUfENAA6Sw7TWVo_hF8XmFoQ6q565iYafTnN-yoBNh3EQ1IFa2tHknU_t28TiE$
>>>>>
>>>>> Signed-off-by: John Garry <john.g.garry@oracle.com>
>>>>
>>>> Thanks for the patch! I quickly tested it and it worked as expected. Just
>>>> in case this is needed:
>>>>
>>>> Tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>
>>>
>>> Reviewed-by: Ian Rogers <irogers@google.com>
>>
>> Hi Arnaldo,
>>
>> Can you consider applying this patch along with https://lore.kernel.org/linux-perf-users/CAP-5=fX2uE=B_Vb90nn5EV0mw+AJBpjDecP9w29OUn=j7HKPPg@mail.gmail.com/
>>
>> I think that we should expect another version of that series with changes
>> elsewhere.
>
> Done, thanks for the ping.
>

Sorry, I completely missed these two emails for some reason.

I finally have the fixes for the metrics patch [1] as it took a while to 
verify some wrong equations that were found too. I was planning to submit 
v2 of the whole patchset but I can see you picked all of them already.

How should we do this? The original metrics patch had issues that John and 
Ian pointed out. Would it be best if you dropped it from perf-tools-next 
branch since it's not required by other patches and once John and Ian acks 
the fixed version, you could pick up the new one? Btw, I just submitted v2 
of the metric patch [2]


[1] https://lore.kernel.org/r/20230803211331.140553-4-ilkka@os.amperecomputing.com
705ed549148f perf vendor events arm64: Add AmpereOne metrics

[2] [PATCH v2] perf vendor events arm64: Add AmpereOne metrics
https://lore.kernel.org/linux-perf-users/20230826192352.3043220-1-ilkka@os.amperecomputing.com/T/#u

Cheers, Ilkka



> - Arnaldo
>
>> Thanks,
>> John
>>
>>>
>>> Thanks,
>>> Ian
>>>
>>>> Cheers, Ilkka
>>>>
>>>>> ---
>>>>> Please do not apply before [0], above.
>>>>>
>>>>> diff --git a/tools/perf/pmu-events/jevents.py b/tools/perf/pmu-events/jevents.py
>>>>> index 8cd561aa606a..98cccc3fcbbd 100755
>>>>> --- a/tools/perf/pmu-events/jevents.py
>>>>> +++ b/tools/perf/pmu-events/jevents.py
>>>>> @@ -347,12 +347,15 @@ class JsonEvent:
>>>>>        if self.desc and not self.desc.endswith('. '):
>>>>>          self.desc += '. '
>>>>>        self.desc = (self.desc if self.desc else '') + ('Unit: ' + self.pmu + ' ')
>>>>> -    if arch_std and arch_std.lower() in _arch_std_events:
>>>>> -      event = _arch_std_events[arch_std.lower()].event
>>>>> -      # Copy from the architecture standard event to self for undefined fields.
>>>>> -      for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
>>>>> -        if hasattr(self, attr) and not getattr(self, attr):
>>>>> -          setattr(self, attr, value)
>>>>> +    if arch_std:
>>>>> +      if arch_std.lower() in _arch_std_events:
>>>>> +        event = _arch_std_events[arch_std.lower()].event
>>>>> +        # Copy from the architecture standard event to self for undefined fields.
>>>>> +        for attr, value in _arch_std_events[arch_std.lower()].__dict__.items():
>>>>> +          if hasattr(self, attr) and not getattr(self, attr):
>>>>> +            setattr(self, attr, value)
>>>>> +      else:
>>>>> +        raise argparse.ArgumentTypeError('Cannot find arch std event:', arch_std)
>>>>>
>>>>>      self.event = real_event(self.name, event)
>>>>>
>>>>> --
>>>>> 2.35.3
>>>>>
>>>>>
>>
>
> -- 
>
> - Arnaldo
>
--1372433909-1731103519-1693078245=:15634--
