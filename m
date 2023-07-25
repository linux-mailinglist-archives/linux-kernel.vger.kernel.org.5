Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5C2A760D48
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 10:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230089AbjGYIlM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 04:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232410AbjGYIk4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 04:40:56 -0400
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 136EC2738;
        Tue, 25 Jul 2023 01:40:14 -0700 (PDT)
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36P89UE1001171;
        Tue, 25 Jul 2023 08:40:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : references : date : in-reply-to : message-id : mime-version :
 content-type; s=pp1; bh=YpMfjlyQgTmUu011PhrrXIzGn0RzY6sAMyIcfyZXEN8=;
 b=fphE6e7+IDGH3LDgdMr7Ymd99l4IS6ju1RoOxUTde+ByZYB5CGK1E+dz86TuvRepFf05
 b37SRGx/Ipi7bWpeFMGU7Okxlnvs5t1LbBjD8J8aVduwRwarW1EkfasNvgdSo2kAcJ51
 oQCroLk6L96Fw7TXFfkgzmOhiXrcpbTAY7k7PNXwYRo2tD+306uVKcNL3408nOY0h7Fp
 MrRJLrJEpsFjf8+qzfXSl+qcNOIB7wsbwb4joBLQGZAk9TkuaezYV5k2cgu1gTarrc+f
 J/3f0GkjSfjiAOE7VK2yA6DWt6oGX5vntnE+Uu/6YBtZb0cnZYvCd3Ghn3+yBFu5Ho+j kw== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s261derky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 08:39:59 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 36P8Xiu5024365;
        Tue, 25 Jul 2023 08:38:37 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
        by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3s261depue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 08:38:37 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
        by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 36P6UT9H003634;
        Tue, 25 Jul 2023 08:36:56 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
        by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3s0txjtas4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 25 Jul 2023 08:36:56 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
        by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 36P8asLs22217026
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 25 Jul 2023 08:36:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 81D2220040;
        Tue, 25 Jul 2023 08:36:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 2851220043;
        Tue, 25 Jul 2023 08:36:54 +0000 (GMT)
Received: from tuxmaker.linux.ibm.com (unknown [9.152.85.9])
        by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
        Tue, 25 Jul 2023 08:36:54 +0000 (GMT)
From:   Sven Schnelle <svens@linux.ibm.com>
To:     syzbot <syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com>
Cc:     akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, syzkaller-bugs@googlegroups.com,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        David Howells <dhowells@redhat.com>,
        linux-crypto@vger.kernel.org
Subject: Re: [syzbot] [mm?] WARNING in try_grab_page
References: <000000000000273d0105ff97bf56@google.com>
Date:   Tue, 25 Jul 2023 10:36:53 +0200
In-Reply-To: <000000000000273d0105ff97bf56@google.com> (syzbot's message of
        "Mon, 03 Jul 2023 09:34:55 -0700")
Message-ID: <yt9d8rb44cbe.fsf@linux.ibm.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 4ZLu9JTO1OClaft3megPbrIW3nkFVM0c
X-Proofpoint-ORIG-GUID: oSnf5RvCyGQtaBDlq0FTZRZNRhtf8TSO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-25_04,2023-07-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=1 mlxscore=1 impostorscore=0
 phishscore=0 malwarescore=0 clxscore=1011 spamscore=1 adultscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=209 suspectscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2306200000 definitions=main-2307250075
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

syzbot <syzbot+9b82859567f2e50c123e@syzkaller.appspotmail.com> writes:

> [..]
> ------------[ cut here ]------------
> WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
> WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
> WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
> WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
> WARNING: CPU: 1 PID: 20384 at mm/gup.c:229 try_grab_page+0x108/0x160 mm/gup.c:252
> Modules linked in:
> CPU: 1 PID: 20384 Comm: syz-executor.1 Not tainted 6.4.0-syzkaller-04247-g3a8a670eeeaa #0
> Hardware name: linux,dummy-virt (DT)
> pstate: a0400009 (NzCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> pc : try_grab_page+0x108/0x160 mm/gup.c:229
> lr : follow_page_pte+0x174/0x3e4 mm/gup.c:651
> [..]
> Call trace:
>  __lse_atomic_add arch/arm64/include/asm/atomic_lse.h:27 [inline]
>  arch_atomic_add arch/arm64/include/asm/atomic.h:28 [inline]
>  raw_atomic_add include/linux/atomic/atomic-arch-fallback.h:537 [inline]
>  atomic_add include/linux/atomic/atomic-instrumented.h:105 [inline]
>  try_grab_page+0x108/0x160 mm/gup.c:252
>  follow_pmd_mask mm/gup.c:734 [inline]
>  follow_pud_mask mm/gup.c:765 [inline]
>  follow_p4d_mask mm/gup.c:782 [inline]
>  follow_page_mask+0x12c/0x2e4 mm/gup.c:839
>  __get_user_pages+0x174/0x30c mm/gup.c:1217
>  __get_user_pages_locked mm/gup.c:1448 [inline]
>  __gup_longterm_locked+0x94/0x8f4 mm/gup.c:2142
>  internal_get_user_pages_fast+0x970/0xb60 mm/gup.c:3140
>  pin_user_pages_fast+0x4c/0x60 mm/gup.c:3246
>  iov_iter_extract_user_pages lib/iov_iter.c:1768 [inline]
>  iov_iter_extract_pages+0xc8/0x54c lib/iov_iter.c:1831
>  extract_user_to_sg lib/scatterlist.c:1123 [inline]
>  extract_iter_to_sg lib/scatterlist.c:1349 [inline]
>  extract_iter_to_sg+0x26c/0x6fc lib/scatterlist.c:1339
>  hash_sendmsg+0xc0/0x43c crypto/algif_hash.c:117
>  sock_sendmsg_nosec net/socket.c:725 [inline]
>  sock_sendmsg+0x54/0x60 net/socket.c:748
>  ____sys_sendmsg+0x270/0x2ac net/socket.c:2494
>  ___sys_sendmsg+0x80/0xdc net/socket.c:2548
>  __sys_sendmsg+0x68/0xc4 net/socket.c:2577
>  __do_sys_sendmsg net/socket.c:2586 [inline]
>  __se_sys_sendmsg net/socket.c:2584 [inline]
>  __arm64_sys_sendmsg+0x24/0x30 net/socket.c:2584
>  __invoke_syscall arch/arm64/kernel/syscall.c:38 [inline]
>  invoke_syscall+0x48/0x114 arch/arm64/kernel/syscall.c:52
>  el0_svc_common.constprop.0+0x44/0xe4 arch/arm64/kernel/syscall.c:142
>  do_el0_svc+0x38/0xa4 arch/arm64/kernel/syscall.c:191
>  el0_svc+0x2c/0xb0 arch/arm64/kernel/entry-common.c:647
>  el0t_64_sync_handler+0xc0/0xc4 arch/arm64/kernel/entry-common.c:665
>  el0t_64_sync+0x19c/0x1a0 arch/arm64/kernel/entry.S:591
> ---[ end trace 0000000000000000 ]---

I looked into this issue. What syzkaller is doing is opening an AF_ALG
socket, and sending a large message which will eventually end in -EFAULT.
Looking at the code in crypto/algif_hash.c i see that hash_sendmsg is
calling extract_iter_to_sg() -> extract_user_to_sg(). In the -EFAULT
case, this function is calling put_page(), which looks like a leftover
from the old pinning interface. I think this should be a
unpin_user_page() call now.

However, hash_sendmsg() also unpins via af_alg_free_sg() in the error
path. From an API perspective, i would prefer if extract_user_to_sg()
does the unpinning on error. Any thoughts?
