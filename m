Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2003F812A3C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 09:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbjLNIYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 03:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjLNIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 03:24:37 -0500
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DCCACF
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 00:24:43 -0800 (PST)
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE7cHrP023154;
        Thu, 14 Dec 2023 08:24:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : in-reply-to : references : date : message-id : mime-version :
 content-type; s=pp1; bh=EAS5XJXk6U+QgcDEY10r7th110a8HILa0q+4HGlwfCo=;
 b=qjgJo2qGMYfZnD5sJIzlGkyGBj4KvaicGOU0/O8SvHlKCqbyxNQ+dvhhVfp0MNHSnuj7
 PdUIAnYoj4xa67QE4FhwcDCldKyy9Bxm76e6rJDmBb45yxwL3svhJOEsaIysQ3+v4Nvv
 H/PNRJb7Gz6O7PYlc2HwfouFCJmYCpWjo0t0QRjTEq9X68sVNe69d+n4jFhpxPuU6oAV
 YLESGMCQepgnldFb6DAFDbQK+ZBwPIETYmoMPygMxltTMhcwBQWVWpEPPUGCFhHVb1E4
 Txh7chD1Jbs9mRQCQOx0KCHgyPtDb2W0PaeOHwjEi11qj21U/pZemNYvVvQvRDeRBjpB Xw== 
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3uywg217n1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 08:24:20 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 3BE6Vvgd028201;
        Thu, 14 Dec 2023 08:24:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
        by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3uw2xyy96p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 14 Dec 2023 08:24:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
        by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 3BE8OHE916188106
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 14 Dec 2023 08:24:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6D4F020043;
        Thu, 14 Dec 2023 08:24:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4F9A120040;
        Thu, 14 Dec 2023 08:24:17 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Thu, 14 Dec 2023 08:24:17 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Andy Lutomirski <luto@kernel.org>,
        linux-kernel@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>
Subject: Re: [PATCH 0/3] entry: inline syscall enter/exit functions
In-Reply-To: <20231206110202.GD30174@noisy.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Wed, 6 Dec 2023 12:02:02 +0100")
References: <20231205133015.752543-1-svens@linux.ibm.com>
        <20231206110202.GD30174@noisy.programming.kicks-ass.net>
Date:   Thu, 14 Dec 2023 09:24:17 +0100
Message-ID: <yt9do7etw5se.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: jonJla6tE9aTRM7ALYpsyF2zWpz1vyyz
X-Proofpoint-GUID: jonJla6tE9aTRM7ALYpsyF2zWpz1vyyz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-14_04,2023-12-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 mlxscore=0 priorityscore=1501 mlxlogscore=468 clxscore=1015
 suspectscore=0 malwarescore=0 impostorscore=0 bulkscore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2312140053
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Dec 05, 2023 at 02:30:12PM +0100, Sven Schnelle wrote:
>> Hi List,
>> 
>> looking into the performance of syscall entry/exit after s390 switched
>> to generic entry showed that there's quite some overhead calling some
>> of the entry/exit work functions even when there's nothing to do.
>> This patchset moves the entry and exit function to entry-common.h, so
>> non inlined code gets only called when there is some work pending.
>
> So per that logic you wouldn't need to inline exit_to_user_mode_loop()
> for example, that's only called when there is a EXIT_TO_USER_MODE_WORK
> bit set.
>
> That is, I'm just being pedantic here and pointing out that your
> justification doesn't cover the extent of the changes.
>
>> I wrote a small program that just issues invalid syscalls in a loop.
>> On an s390 machine, this results in the following numbers:
>> 
>> without this series:
>> 
>> # ./syscall 1000000000
>> runtime: 94.886581s / per-syscall 9.488658e-08s
>> 
>> with this series:
>> 
>> ./syscall 1000000000
>> runtime: 84.732391s / per-syscall 8.473239e-08s
>> 
>> so the time required for one syscall dropped from 94.8ns to
>> 84.7ns, which is a drop of about 11%.
>
> That is obviously very nice, and I don't immediately see anything wrong
> with moving the lot to header based inlines.
>
> Thomas?

Thomas, any opinion on this change?
