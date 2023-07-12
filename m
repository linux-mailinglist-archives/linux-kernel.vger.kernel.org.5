Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FBB75106D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 20:23:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232600AbjGLSXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 14:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjGLSXM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 14:23:12 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F9641FE3;
        Wed, 12 Jul 2023 11:23:10 -0700 (PDT)
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36CIME0I010085;
        Wed, 12 Jul 2023 18:23:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : content-type :
 mime-version; s=pp1; bh=9+QqSw0V3MUjiFDX/WmZ2/QGK90yI5eSUSppc6j+J04=;
 b=h/f/Kyw4/CjCRFIegsUaOhpUKvOUcDxojmhmnT6LFJe8oXH0IR3R9LRCBLLwTE3oheNb
 Nx//tS8gE0N3EBheTdzsUrnehaZ9ORQRYXHF/7Cl9cm1OeWr1yVmGXSMKmxO+t8uazF+
 cREzUeDtgFS6w2yTZ6WkDV9SSTEwJ3zp2zA5ML9NydnqOeAebQx6cuERouds8vEnW+Rg
 o2LxEmdrbclpB1i9l/l/7sn0NxGHOeCIs6LoCwbZNOj+3bjY5dI2Smw+Gj8kz88KJzoq
 Y0A+jdDLlew2fYIZPjlz2ftD37WTdqN3rqe/Oqm4M7jkrfaNhmIQAOMy5wbkQ9lGVww8 Xg== 
Received: from ppma02fra.de.ibm.com (47.49.7a9f.ip4.static.sl-reverse.com [159.122.73.71])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3rt1csr0kj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 18:23:00 +0000
Received: from pps.filterd (ppma02fra.de.ibm.com [127.0.0.1])
        by ppma02fra.de.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36CA8HLZ004520;
        Wed, 12 Jul 2023 18:22:58 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
        by ppma02fra.de.ibm.com (PPS) with ESMTPS id 3rpye5j2rj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 12 Jul 2023 18:22:58 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
        by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36CIMuPc24642202
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 12 Jul 2023 18:22:56 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 093F120043;
        Wed, 12 Jul 2023 18:22:56 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id CDD6920040;
        Wed, 12 Jul 2023 18:22:55 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed, 12 Jul 2023 18:22:55 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Linux Trace Kernel <linux-trace-kernel@vger.kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH] tracing: Stop FORTIFY_SOURCE complaining about stack
 trace caller
References: <20230712105235.5fc441aa@gandalf.local.home>
Date:   Wed, 12 Jul 2023 20:22:55 +0200
In-Reply-To: <20230712105235.5fc441aa@gandalf.local.home> (Steven Rostedt's
        message of "Wed, 12 Jul 2023 10:52:35 -0400")
Message-ID: <yt9dsf9tdm68.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gCbSGRYk3qv3_EdfSS2zjZpRg-G-LqTA
X-Proofpoint-GUID: gCbSGRYk3qv3_EdfSS2zjZpRg-G-LqTA
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-12_13,2023-07-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=999 clxscore=1011 priorityscore=1501
 adultscore=0 bulkscore=0 malwarescore=0 phishscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2305260000 definitions=main-2307120163
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> From: "Steven Rostedt (Google)" <rostedt@goodmis.org>
>
> The stack_trace event is an event created by the tracing subsystem to
> store stack traces. It originally just contained a hard coded array of 8
> words to hold the stack, and a "size" to know how many entries are there.
> This is exported to user space as:
>
> name: kernel_stack
> ID: 4
> format:
> 	field:unsigned short common_type;	offset:0;	size:2;	signed:0;
> 	field:unsigned char common_flags;	offset:2;	size:1;	signed:0;
> 	field:unsigned char common_preempt_count;	offset:3;	size:1;	signed:0;
> 	field:int common_pid;	offset:4;	size:4;	signed:1;
>
> 	field:int size;	offset:8;	size:4;	signed:1;
> 	field:unsigned long caller[8];	offset:16;	size:64;	signed:0;
>
> print fmt: "\t=> %ps\n\t=> %ps\n\t=> %ps\n" "\t=> %ps\n\t=> %ps\n\t=> %ps\n" "\t=> %ps\n\t=> %ps\n",i
>  (void *)REC->caller[0], (void *)REC->caller[1], (void *)REC->caller[2],
>  (void *)REC->caller[3], (void *)REC->caller[4], (void *)REC->caller[5],
>  (void *)REC->caller[6], (void *)REC->caller[7]
>
> Where the user space tracers could parse the stack. The library was
> updated for this specific event to only look at the size, and not the
> array. But some older users still look at the array (note, the older code
> still checks to make sure the array fits inside the event that it read.
> That is, if only 4 words were saved, the parser would not read the fifth
> word because it will see that it was outside of the event size).
>
> This event was changed a while ago to be more dynamic, and would save a
> full stack even if it was greater than 8 words. It does this by simply
> allocating more ring buffer to hold the extra words. Then it copies in the
> stack via:
>
> 	memcpy(&entry->caller, fstack->calls, size);
>
> As the entry is struct stack_entry, that is created by a macro to both
> create the structure and export this to user space, it still had the caller
> field of entry defined as: unsigned long caller[8].
>
> When the stack is greater than 8, the FORTIFY_SOURCE code notices that the
> amount being copied is greater than the source array and complains about
> it. It has no idea that the source is pointing to the ring buffer with the
> required allocation.
>
> To hide this from the FORTIFY_SOURCE logic, pointer arithmetic is used:
>
> 	ptr = ring_buffer_event_data(event);
> 	entry = ptr;
> 	ptr += offsetof(typeof(*entry), caller);
> 	memcpy(ptr, fstack->calls, size);
>
> Link: https://lore.kernel.org/all/20230612160748.4082850-1-svens@linux.ibm.com/
>
> Reported-by: Sven Schnelle <svens@linux.ibm.com>
> Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
> ---
>  kernel/trace/trace.c | 21 +++++++++++++++++++--
>  1 file changed, 19 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
> index 4529e264cb86..20122eeccf97 100644
> --- a/kernel/trace/trace.c
> +++ b/kernel/trace/trace.c
> @@ -3118,6 +3118,7 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  	struct ftrace_stack *fstack;
>  	struct stack_entry *entry;
>  	int stackidx;
> +	void *ptr;
>  
>  	/*
>  	 * Add one, for this function and the call to save_stack_trace()
> @@ -3161,9 +3162,25 @@ static void __ftrace_trace_stack(struct trace_buffer *buffer,
>  				    trace_ctx);
>  	if (!event)
>  		goto out;
> -	entry = ring_buffer_event_data(event);
> +	ptr = ring_buffer_event_data(event);
> +	entry = ptr;
> +
> +	/*
> +	 * For backward compatibility reasons, the entry->caller is an
> +	 * array of 8 slots to store the stack. This is also exported
> +	 * to user space. The amount allocated on the ring buffer actually
> +	 * holds enough for the stack specified by nr_entries. This will
> +	 * go into the location of entry->caller. Due to string fortifiers
> +	 * checking the size of the destination of memcpy() it triggers
> +	 * when it detects that size is greater than 8. To hide this from
> +	 * the fortifiers, we use "ptr" and pointer arithmetic to assign caller.
> +	 *
> +	 * The below is really just:
> +	 *   memcpy(&entry->caller, fstack->calls, size);
> +	 */
> +	ptr += offsetof(typeof(*entry), caller);
> +	memcpy(ptr, fstack->calls, size);
>  
> -	memcpy(&entry->caller, fstack->calls, size);
>  	entry->size = nr_entries;
>  
>  	if (!call_filter_check_discard(call, entry, buffer, event))

Works, so:

Tested-by: Sven Schnelle <svens@linux.ibm.com>
