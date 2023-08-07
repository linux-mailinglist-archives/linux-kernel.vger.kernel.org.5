Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A310771A05
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 08:09:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231137AbjHGGJY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 02:09:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbjHGGJW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 02:09:22 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6D9310F9
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 23:09:21 -0700 (PDT)
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 37760gNX022469;
        Mon, 7 Aug 2023 06:08:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=8lC68q+3Etjcpz76NeQMAydEwaS4UejuJGfrWFBuZ18=;
 b=OLklORmIOKQpJsMe1pLFOtL6A+RvHGb2jpFgF5KxYnZLhqnd7hkaoju9/A2VqNM6BKuf
 ITc3lN1j6RQTwBTUv6Nup1LZaNcUM+3QBJENqxeV0VPiwVJ+GN3CFDB5wzbYijrrCX6A
 zyTsu6WxRu+ZiRgehsAegNfbuhnkXRxWeoubU6iMMXOyKuquzy+18w43GyMHM/Kmr4td
 6o9uvOvdW2CtLZK5swLcFvxugERzg0e9rA0uH04HNCfQpXDRCxiZEpHh2yHGCTHCczBA
 0BaXUT/gp3cv7hP2sAiXU8bl8klc5wX+li/OjC8tEDG6DfI1AoOwoIK7tEcHvFDA+4n5 UA== 
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3satyhg96c-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:08:52 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
        by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3774tDBl001597;
        Mon, 7 Aug 2023 06:08:52 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
        by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3sa2yjj4er-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 07 Aug 2023 06:08:51 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
        by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 37768opB1639122
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 7 Aug 2023 06:08:50 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 3A41B2004D;
        Mon,  7 Aug 2023 06:08:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 167BC20049;
        Mon,  7 Aug 2023 06:08:50 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Mon,  7 Aug 2023 06:08:50 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: BUG: KASAN: slab-out-of-bounds in print_synth_event+0xa68/0xa78
References: <yt9dsf8zfhw8.fsf@linux.ibm.com>
        <20230804115033.34c2b5af@gandalf.local.home>
        <yt9da5v66a4v.fsf@linux.ibm.com>
        <20230804133601.40cb5fe9@gandalf.local.home>
Date:   Mon, 07 Aug 2023 08:08:49 +0200
In-Reply-To: <20230804133601.40cb5fe9@gandalf.local.home> (Steven Rostedt's
        message of "Fri, 4 Aug 2023 13:36:01 -0400")
Message-ID: <yt9d7cq7s7ta.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HWi_FLwC-oz-O_BaiBR_fCVOMLXPK7YA
X-Proofpoint-GUID: HWi_FLwC-oz-O_BaiBR_fCVOMLXPK7YA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-07_04,2023-08-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 mlxscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 mlxlogscore=906 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308070055
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> On Fri, 04 Aug 2023 18:32:48 +0200
> Sven Schnelle <svens@linux.ibm.com> wrote:
>
>> > Can you show where exactly the above line is?  
>> 
>> It is:
>> 
>> (gdb) list *(print_synth_event+0xa68)
>> 0x5e4f60 is in print_synth_event (/home/svens/ibmgit/linux/kernel/trace/trace_events_synth.c:410).
>> 405                             p = (void *)entry + data_offset;
>> 406                             end = (void *)p + len - (sizeof(long) - 1);
>> 407
>> 408                             trace_seq_printf(s, "%s=STACK:\n", se->fields[i]->name);
>> 409
>> 410                             for (; *p && p < end; p++)
>
> I think that conditional needs to be swapped. Can you test the following
> change and see if the problem disappears?

Unfortunately that doesn't change anything, still exactly the same splat.
