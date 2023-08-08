Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A591C773D32
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 18:15:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231795AbjHHQO3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 12:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232131AbjHHQNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 12:13:09 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7F57EE5
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 08:47:15 -0700 (PDT)
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3786Qimg002426;
        Tue, 8 Aug 2023 06:28:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=WAcImLZ1LuHtg80bGsO/Z0uoEIASog0uUu2R+QNCRZc=;
 b=BeFwA01TB3ZeA/zFkW3MmqIeIa2YY8p2uiWsbzkfY4gW67Uo9mpS3V7fUUh4KULT4ZIb
 BiRcDNxiketoFuM/Nax1r83Q/CVLu4I/MzSsy5O78ikCTNkf1oWO5VSBrH7s183YX9jc
 35OWOlJ/So/6BGASWt9RHFMRcPhR7AwmN/ro8RXSJkeMYlqwBd9P25ibg9sZqxD1wkui
 fs8yAbALXsoCeRtbVLJ6S46oVY5z9xd3I+mrOHSfwy7YUxHTfYkDn/mppIf9c3I8TkzH
 WujHAZGr29sLm3oxathrZ2mRLz1Rcdh2rLY3TL7vzQrvWzcvRzKJijQPWjDsVerQuMfl Dw== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbgeqr0qx-7
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 06:28:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3784V2gG030374;
        Tue, 8 Aug 2023 05:59:02 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rn3vn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 05:59:01 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3785x0Ff14484056
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Aug 2023 05:59:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 042872004B;
        Tue,  8 Aug 2023 05:59:00 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D041320040;
        Tue,  8 Aug 2023 05:58:59 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Aug 2023 05:58:59 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
References: <yt9dsf8zfhw8.fsf@linux.ibm.com>
        <20230807215310.068fce2f@gandalf.local.home>
Date:   Tue, 08 Aug 2023 07:58:59 +0200
In-Reply-To: <20230807215310.068fce2f@gandalf.local.home> (Steven Rostedt's
        message of "Mon, 7 Aug 2023 21:53:10 -0400")
Message-ID: <yt9dmsz2qdlo.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: nM7HZ3fPNLrUkZOkGjshMCHCjkW9yXcp
X-Proofpoint-GUID: nM7HZ3fPNLrUkZOkGjshMCHCjkW9yXcp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 phishscore=0 clxscore=1015 malwarescore=0 suspectscore=0
 priorityscore=1501 bulkscore=0 mlxscore=0 adultscore=0 impostorscore=0
 spamscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2306200000 definitions=main-2308080054
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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
>
> Could this actually be a bug in KASAN?
>
> The reason I ask, is because of the report.

I don't think so. I looked into the trace file when the problem occurred
yesterday, and it looked like this:

kworker/0:2-83      [000] d..4.    59.260107: wake_lat: pid=2654624 delta=55 stack=STACK:
=> 0x6b6b6b6b6b6b6b6b
=> 0x6b6b6b6b6b6b6b6b
=> 0x6b6b6b6b6b6b6b6b
=> 0x6b6b6b6b6b6b6b6b
=> 0x6b6b6b6b6b6b6b6b
[..]

Somtimes the number is 0xcc, which is POISON_FREE_INITMEM instead of POISON_FREE.

In other entries delta and pid are also wrong:

swapper/0-1       [002] .....     5.864575: wake_lat: pid=5437496 delta=7880749591624456 stack=STACK:

Of course PID could have gone away, but that delta looks interesting. So
it looks like the whole entry is just random data not owned by tracing,
and not the data that was allocated in the ringbuffer code.
