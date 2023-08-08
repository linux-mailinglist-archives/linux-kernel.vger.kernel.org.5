Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4638A7747E2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 21:21:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234740AbjHHTVV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 15:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbjHHTU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 15:20:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E342077
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:44:15 -0700 (PDT)
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378EdFmj011937;
        Tue, 8 Aug 2023 14:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=uXoTIO+5lwwtLlN/NRmd7fRlIP3awliY1hCQo+5CJpg=;
 b=RmOHVCDgux0tuhpNl182ovuUmY0CEHj+JeRmPHCLXJuXHmUKmrsrleHJLaIOAk221Ywc
 8ni/AWwerAQvnkHADEYVja5+INMlCFVIG4OCvCWTBNjb4Bof1wWpF6M6iTsMUbPxMG4A
 I+U0UY8qq9TidAoLvnvVDFBfcqWRKZ+SiAL/uwjqmNJWeo1tG7bhbHONzoi76PqMC/7/
 yKxyco4Zr22KaUHB7/QIlg3dxVDQQ9PX04L4jlhZMACN+veJvqfotb8/dsfF7ib5g3Cx
 A5jRG4zh67rLK5dAIMOA1XldbeMrSGBJ0ojUxWtaxhXJxmkPNY2LBUOw0XlKXciClcP9 iA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbqhd0gp3-9
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 14:48:18 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 378DTkni030379;
        Tue, 8 Aug 2023 14:28:52 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rn7a1s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 14:28:52 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 378ESosT57737656
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Aug 2023 14:28:50 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2B9FA2004B;
        Tue,  8 Aug 2023 14:28:50 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 0DD5820040;
        Tue,  8 Aug 2023 14:28:50 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Aug 2023 14:28:49 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org, Tom Zanussi <zanussi@kernel.org>
Subject: Re: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
References: <yt9dsf8zfhw8.fsf@linux.ibm.com>
        <20230807215310.068fce2f@gandalf.local.home>
        <yt9da5v1rhqd.fsf@linux.ibm.com>
        <20230808061423.0a12980f@gandalf.local.home>
Date:   Tue, 08 Aug 2023 16:28:49 +0200
In-Reply-To: <20230808061423.0a12980f@gandalf.local.home> (Steven Rostedt's
        message of "Tue, 8 Aug 2023 06:14:23 -0400")
Message-ID: <yt9dzg31ppzy.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: MQ2oNIwm26m3lXZtDPQWMaYVT-WiGGxZ
X-Proofpoint-GUID: MQ2oNIwm26m3lXZtDPQWMaYVT-WiGGxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_12,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 malwarescore=0 clxscore=1011 priorityscore=1501 adultscore=0
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080130
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

>> I think the problem is that the code assigns data_offset with:
>> 
>> *(u32 *)&entry->fields[*n_u64] = data_offset;
>> 
>> but reads it with:
>> 
>> offset = (u32)entry->fields[n_u64];
>> 
>> which works on LE, but not BE.
>
> Ah, that makes sense. I didn't realize (or forgot) that s390 was BE. My
> PowerPC box that was BE died years ago, and I have stopped testing BE ever
> since :-(

Ok. If you want something for testing BE i could provide you with an
s390 linux image + the commandline to run that within qemu. Linux on
s390 is not much different than other platforms, but you would need an
s390 cross-compiler.

>> 
>> I'm currently preparing the patch below, which also makes the code a bit
>> easier to read. I'm still seeing no stack traces, but at least the
>> random memory reads are gone and no KASAN warning anymore. I'll
>> continue fixing and sent a full patch as soon as everything is fixed.
>> 
>> >From 82fc673f0d3b6031b760b4217bebdb1047119041 Mon Sep 17 00:00:00 2001  
>> From: Sven Schnelle <svens@linux.ibm.com>
>> Date: Tue, 8 Aug 2023 11:35:12 +0200
>> Subject: [PATCH] tracing/synthetic: use union instead of casts
>> 
>> The current code uses a lot of casts to access the fields
>> member in struct synth_trace_events with different sizes.
>> This makes the code hard to read, and had already introduced
>> an endianess bug. Use a union and struct instead.
>> 
>> Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
>> ---
>>  kernel/trace/trace_events_synth.c | 100 +++++++++++++++---------------
>>  1 file changed, 50 insertions(+), 50 deletions(-)
>> 
>> diff --git a/kernel/trace/trace_events_synth.c b/kernel/trace/trace_events_synth.c
>> index d6a70aff2410..1f8fe7f2b5b2 100644
>> --- a/kernel/trace/trace_events_synth.c
>> +++ b/kernel/trace/trace_events_synth.c
>> @@ -125,9 +125,22 @@ static bool synth_event_match(const char *system, const char *event,
>>  		(!system || strcmp(system, SYNTH_SYSTEM) == 0);
>>  }
>>  
>> +struct synth_trace_data {
>> +	u16 len;
>> +	u16 offset;
>> +};
>
> This is actually common throughout the tracing code (as all dynamic fields
> have this). We should probably make this more generic than just for
> synthetic events. Although, that would probably break BE user space. Hmm,
> we could have it be:

I'm not familiar with the ftrace code, so I think i would need some more
time to find all the other locations. Therefore i updated the patch to move
the structure declaration to trace.h and sent that as a first step.

Thanks,
Sven
