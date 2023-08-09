Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EA1E7753F2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 09:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231446AbjHIHRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 03:17:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231603AbjHIHQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 03:16:58 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E51A91B6
        for <linux-kernel@vger.kernel.org>; Wed,  9 Aug 2023 00:16:57 -0700 (PDT)
Received: from pps.filterd (m0353724.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3797DUuq029336;
        Wed, 9 Aug 2023 07:16:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=LdcwoFOxvfuJqhelbBw4ePT0nyFZpEVQvUONfP4H9S4=;
 b=NvVrLSYKQA7o5+0pinPcp8TvTrrKdyWCXLfm2v4EgqjpDW4QRRSb7YAYDmemanKlGSTk
 na2sGUf6GI/ChV7t6575Hq9xcH+0nbJX2XJEENHImOWXuWQEkDONs1MHxVju2uTxB+4f
 5QFP/MT1noa9hSGnnQ4A9UEtMFVVX8e8CPgGKAHX8Baqdwnh9uVHwQhAK6Zr3YFpNqjR
 iDiJI1cN3cqfzf6XJgEk//HJjCE+oOhF76vFQSQ4jjPK2ylV0TKixqLyXq9zbIiZfj75
 7SY4XPWKZ2QMLXQ0NWlbDid4/s6J+UWgpCpr8iXCagBkcp24CkJ+gUtNA8RmBFupy39c YQ== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sc6098cnq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 07:16:55 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
        by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3796B5Sf001785;
        Wed, 9 Aug 2023 07:16:55 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa3f1wff6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 09 Aug 2023 07:16:55 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3797GmlG39780732
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 9 Aug 2023 07:16:48 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 676D320043;
        Wed,  9 Aug 2023 07:16:48 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 473C620040;
        Wed,  9 Aug 2023 07:16:48 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Wed,  9 Aug 2023 07:16:48 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/synthetic: use union instead of casts
References: <20230808142148.2652883-1-svens@linux.ibm.com>
        <20230808132726.08cabfbc@gandalf.local.home>
        <yt9dv8dpphgt.fsf@linux.ibm.com>
        <20230808160547.59e6efd9@gandalf.local.home>
Date:   Wed, 09 Aug 2023 09:16:47 +0200
In-Reply-To: <20230808160547.59e6efd9@gandalf.local.home> (Steven Rostedt's
        message of "Tue, 8 Aug 2023 16:05:47 -0400")
Message-ID: <yt9dr0ocptwg.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: fDwge7XjySzcTlyUdve35Dz6q1Mqlmu8
X-Proofpoint-ORIG-GUID: fDwge7XjySzcTlyUdve35Dz6q1Mqlmu8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-09_05,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=959
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 malwarescore=0
 impostorscore=0 adultscore=0 clxscore=1015 mlxscore=0 spamscore=0
 phishscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308090062
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Tue, 08 Aug 2023 19:33:06 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> Steven Rostedt <rostedt@goodmis.org> writes:
>> 
>> > The "dynamic" I was using wasn't about the fields were dynamic (union), but
>> > because the field the offset/len combo represents is of dynamic size. It's
>> > used all over the trace_events code.
>> >
>> > I would have in include/linux/trace_events.h (right above struct trace_entry):
>> >
>> > /* Used to find the offset and length of dynamic fields in trace events */
>> > struct trace_dynamic_info {
>> > #ifdef CONFIG_CPU_BIG_ENDIAN
>> > 	u16 offset;
>> > 	u16 len;
>> > #else
>> > 	u16 len;
>> > 	u16 offset;
>> > #endif
>> > };
>> >
>> > And then it kernel/trace/trace.h:
>> >
>> > union trace_synthetic_field {
>> > 	u8				as_u8;
>> > 	u16				as_u16;
>> > 	u32				as_u32;
>> > 	u64				as_u64;
>> > 	struct trace_dynamic_info	as_dynamic;
>> > };  
>> 
>> Ok.
>> 
>> > I could work on the part of the trace_dynamic_info if you want.  
>> 
>> Whatever you prefer. Should i update my patch and send it again, or do
>> you want to adjust it?
>>
>
> How quickly do you need it. I can hopefully start working on it this week.

I would like to have the bugfix in as soon as possible, as this is
triggering a lot of KASAN warnings in our CI (besides breaking the
synthetic events on our platform). I sent a v2 of my patch, so we
apply that. The rest of the changes are not urgent.

Thanks
Sven
