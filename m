Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92313770616
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 18:33:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229708AbjHDQdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 12:33:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbjHDQcy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 12:32:54 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD8AB2
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 09:32:53 -0700 (PDT)
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 374GSPqk020072;
        Fri, 4 Aug 2023 16:32:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=eLJgIjzWU6yUe7EmRTvaGZRzT7j0lVhx+s07WpG9SVA=;
 b=kskoUtbHhKKfty881fNU4fztvewUPIZI4926CC1VZjkf+RKcJN02umzVB9IHlJYXbSuU
 p5qRtT4dL6eFRFJdectxEZoVu3/u8CsXIbiRzJGV6vVau4n6M9aC3rjZfiQaYvZoeDw3
 CJiXT8DjWlz6b5KEi8tKnTn8y2OrrZmveUP06eNU2BFDmNepGdYWCPjCnixEiRFzjs8y
 3Jmx1TWWuh/nbd7NHNwNYL24RDfbed/SyzMuN1BByIWp+7WZCDXSMPHIs3TFZUpAuTYT
 d6Jlbhiy1lV+3fjlkP7SXCMVjhNFF2EfPiz6oc1BPSiZ1rbtK70PRUzl7GGp4lZaJeyV qw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s94vf0359-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 16:32:51 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 374Fslmm023561;
        Fri, 4 Aug 2023 16:32:50 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s8km9q9ya-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 04 Aug 2023 16:32:50 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 374GWm5a40174196
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 4 Aug 2023 16:32:48 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8FF3520043;
        Fri,  4 Aug 2023 16:32:48 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 76AE420040;
        Fri,  4 Aug 2023 16:32:48 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Fri,  4 Aug 2023 16:32:48 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
References: <yt9dsf8zfhw8.fsf@linux.ibm.com>
        <20230804115033.34c2b5af@gandalf.local.home>
Date:   Fri, 04 Aug 2023 18:32:48 +0200
In-Reply-To: <20230804115033.34c2b5af@gandalf.local.home> (Steven Rostedt's
        message of "Fri, 4 Aug 2023 11:50:33 -0400")
Message-ID: <yt9da5v66a4v.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Iv9hP582BsRVIaydL-Z8ITkO9u9A4VJC
X-Proofpoint-GUID: Iv9hP582BsRVIaydL-Z8ITkO9u9A4VJC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-04_15,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 clxscore=1015
 phishscore=0 lowpriorityscore=0 priorityscore=1501 mlxscore=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308040144
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 04 Aug 2023 08:20:23 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> Hi Steven,
>> 
>> i noticed the following KASAN splat in CI (on s390):
>> 
>> [  218.586476] /home/svens/linux/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
>> [  221.610410] ==================================================================
>> [  221.610424] BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
>> [  221.610440] Read of size 8 at addr 0000000087753ebc by task grep/1321
>> [  221.610445]
>> [  221.610451] CPU: 9 PID: 1321 Comm: grep Not tainted 6.4.0-rc3-00008-g4b512860bdbd #716
>> [  221.610457] Hardware name: IBM 3906 M04 704 (z/VM 7.1.0)
>> [  221.610462] Call Trace:
>> [  221.610466]  [<00000000026026e6>] dump_stack_lvl+0x106/0x1c8
>> [  221.610479]  [<00000000009cdbbc>] print_address_description.constprop.0+0x34/0x378
>> [  221.610488]  [<00000000009cdfac>] print_report+0xac/0x240
>> [  221.610494]  [<00000000009ce32a>] kasan_report+0xf2/0x130
>> [  221.610501]  [<00000000005e4f60>] print_synth_event+0xa68/0xa78
>
> Can you show where exactly the above line is?

It is:

(gdb) list *(print_synth_event+0xa68)
0x5e4f60 is in print_synth_event (/home/svens/ibmgit/linux/kernel/trace/trace_events_synth.c:410).
405                             p = (void *)entry + data_offset;
406                             end = (void *)p + len - (sizeof(long) - 1);
407
408                             trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
409
410                             for (; *p && p < end; p++)
411                                     trace_seq_printf(s, "=> %pS\n", (void *)*p);
412                             n_u64++;
413
414                     } else {

>> For reproducing, the following script is good enough to trigger it
>> reliably on my system:
>> 
>> cd /home/svens/linux/tools/testing/selftests/ftrace
>> for i in $(seq 1 10); do
>> 	./ftracetest -v /home/svens/linux/tools/testing/selftests/ftrace/test.d/trigger/inter-event/trigger-synthetic-event-stack.tc
>
> It's probably because that code has:
>
>   #!/bin/sh
>   # SPDX-License-Identifier: GPL-2.0
>   # description: event trigger - test inter-event histogram trigger trace action with dynamic string param
>   # requires: set_event synthetic_events events/sched/sched_process_exec/hist "can be any field, or the special string 'common_stacktrace'":README
>
> Where it looks for "common_stacktrace" in the README file, and will not run
> if it does not exist. That "common_stacktrace" was added to the README file
> by that commit.

Thanks, i'll try to bisect again with the changed test.
