Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34A7677448F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 20:22:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235739AbjHHSWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 14:22:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233894AbjHHSWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 14:22:31 -0400
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 181DB7ED4
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 10:33:13 -0700 (PDT)
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 378HSE4S012620;
        Tue, 8 Aug 2023 17:33:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=ce6KrtxW1N1M1KpdmyHfcpXsMxruBSPZBYwCMFJvTy0=;
 b=myf/rhRl+04/jXK3GAYIxFnSxfWU0sUyxnygeTCfUrXoJzV70jaM8eZfFnUeMMP+cWwW
 mPYLAhCFmRryJEemxbomsGLEo3Up6+eM9cFPlNY81KHE05zdsRX0OMoYbNLg/lVMyvAZ
 QMP+Jp4CKqzycOnhwn8zc7o0Ym1VxiAf6vuJPlxETiLwg9IZX7DNuGHoJxZzhumQrNO6
 IvGYdtHNySiy2v7XjWG3bCcnZtD9GF75ldat4paQmyhjYkgejGqx18e62lSK22ABLXY1
 FbhXmrccponDGJWtaZpH8eG6qdPECBtHXWeqIgNx9VJRvFEMmgwXIdZP6+bzFlcT70R+ vA== 
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3sbt4t03j9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 17:33:10 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 378HEefF030353;
        Tue, 8 Aug 2023 17:33:09 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
        by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3sa1rn8qfs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Aug 2023 17:33:09 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
        by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 378HX72n21430984
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Aug 2023 17:33:07 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 6AE9120043;
        Tue,  8 Aug 2023 17:33:07 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 4375F20040;
        Tue,  8 Aug 2023 17:33:07 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue,  8 Aug 2023 17:33:07 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] tracing/synthetic: use union instead of casts
References: <20230808142148.2652883-1-svens@linux.ibm.com>
        <20230808132726.08cabfbc@gandalf.local.home>
Date:   Tue, 08 Aug 2023 19:33:06 +0200
In-Reply-To: <20230808132726.08cabfbc@gandalf.local.home> (Steven Rostedt's
        message of "Tue, 8 Aug 2023 13:27:26 -0400")
Message-ID: <yt9dv8dpphgt.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ZZOva1gYbPQFMS-khdBW-CrOGnVEOmZ_
X-Proofpoint-GUID: ZZOva1gYbPQFMS-khdBW-CrOGnVEOmZ_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-08-08_15,2023-08-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 spamscore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 mlxlogscore=899 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2308080156
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Rostedt <rostedt@goodmis.org> writes:

> The "dynamic" I was using wasn't about the fields were dynamic (union), but
> because the field the offset/len combo represents is of dynamic size. It's
> used all over the trace_events code.
>
> I would have in include/linux/trace_events.h (right above struct trace_entry):
>
> /* Used to find the offset and length of dynamic fields in trace events */
> struct trace_dynamic_info {
> #ifdef CONFIG_CPU_BIG_ENDIAN
> 	u16 offset;
> 	u16 len;
> #else
> 	u16 len;
> 	u16 offset;
> #endif
> };
>
> And then it kernel/trace/trace.h:
>
> union trace_synthetic_field {
> 	u8				as_u8;
> 	u16				as_u16;
> 	u32				as_u32;
> 	u64				as_u64;
> 	struct trace_dynamic_info	as_dynamic;
> };

Ok.

> I could work on the part of the trace_dynamic_info if you want.

Whatever you prefer. Should i update my patch and send it again, or do
you want to adjust it?

Thanks
Sven
