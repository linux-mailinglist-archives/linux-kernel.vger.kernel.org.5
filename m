Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC7BF7FEB41
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:58:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231752AbjK3I63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:58:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjK3I61 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:58:27 -0500
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 655A9B9;
        Thu, 30 Nov 2023 00:58:33 -0800 (PST)
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
        by mx0a-0064b401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3AU5fJTW006780;
        Thu, 30 Nov 2023 08:58:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=windriver.com;
         h=from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PPS06212021; bh=T035uxmSAtmG1UcOI47F4iJMK+KApAb8YPCQhqjvDrU=; b=
        SiaA1yC3lLCChByFqUQc3JlJKh8p2ssjY04GEphjq+rUphy13fc/XNu28u55quwT
        i+HBHv7XLMllWBgcpfrq6zFoMDKw8wiXEs2MjEd5wRbaIfgpFoO5qfrTXsK5vC72
        iLFBbLEUth22PpW90KIw1Q9AFRszQ9bPJbpjPYahq9nUs1J12fVLpz/polGuWf3S
        HjnyYEYoRIWwHtJtM7KYoVht0f/G02vek+zN2QRRPJMs3+wWuv3kctT+NA4Fbeuq
        lROGVkqBvtBmggK30wd3oAJJi0Hkc/+SmJX+rstLsCPs/6f459eXM1H+JkcsYgAw
        1QSoC6mpfMwkWmnIrMYDOQ==
Received: from ala-exchng01.corp.ad.wrs.com (ala-exchng01.wrs.com [147.11.82.252])
        by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 3uph108aht-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Thu, 30 Nov 2023 08:58:16 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Thu, 30 Nov 2023 00:58:22 -0800
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.34 via Frontend Transport; Thu, 30 Nov 2023 00:58:19 -0800
From:   Lizhi Xu <lizhi.xu@windriver.com>
To:     <edumazet@google.com>
CC:     <almasrymina@google.com>, <davem@davemloft.net>, <hawk@kernel.org>,
        <ilias.apalodimas@linaro.org>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <lizhi.xu@windriver.com>,
        <netdev@vger.kernel.org>, <pabeni@redhat.com>,
        <syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com>,
        <syzkaller-bugs@googlegroups.com>
Subject: Re: [PATCH net-next] net: page_pool: fix null-ptr-deref in page_pool_unlist
Date:   Thu, 30 Nov 2023 16:58:10 +0800
Message-ID: <20231130085810.4014847-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CANn89iJxtgkKLQwmi2ZZYQP0VnrWgarJZrSL2KgkSdkO615vcw@mail.gmail.com>
References: <CANn89iJxtgkKLQwmi2ZZYQP0VnrWgarJZrSL2KgkSdkO615vcw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: mLwwRjEbhOMzzRM3ZGFcnH1vuXT2sNzZ
X-Proofpoint-GUID: mLwwRjEbhOMzzRM3ZGFcnH1vuXT2sNzZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.987,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-11-16_25,2023-11-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 mlxlogscore=664 malwarescore=0 priorityscore=1501 clxscore=1015
 suspectscore=0 spamscore=0 bulkscore=0 lowpriorityscore=0 phishscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2311060001 definitions=main-2311300066
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Nov 2023 09:29:04 +0100, Eric Dumazet <edumazet@google.com> wrote:
> > [Syz report]
> > Illegal XDP return value 4294946546 on prog  (id 2) dev N/A, expect packet loss!
> > general protection fault, probably for non-canonical address 0xdffffc0000000000: 0000 [#1] PREEMPT SMP KASAN
> > KASAN: null-ptr-deref in range [0x0000000000000000-0x0000000000000007]
> > CPU: 0 PID: 5064 Comm: syz-executor391 Not tainted 6.7.0-rc2-syzkaller-00533-ga379972973a8 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/10/2023
> > RIP: 0010:__hlist_del include/linux/list.h:988 [inline]
> > RIP: 0010:hlist_del include/linux/list.h:1002 [inline]
> > RIP: 0010:page_pool_unlist+0xd1/0x170 net/core/page_pool_user.c:342
> > Code: df 48 89 fa 48 c1 ea 03 80 3c 02 00 0f 85 90 00 00 00 4c 8b a3 f0 06 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 75 68 48 85 ed 49 89 2c 24 74 24 e8 1b ca 07 f9 48 8d
> > RSP: 0018:ffffc900039ff768 EFLAGS: 00010246
> > RAX: dffffc0000000000 RBX: ffff88814ae02000 RCX: 0000000000000000
> > RDX: 0000000000000000 RSI: 0000000000000004 RDI: ffff88814ae026f0
> > RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff1d57fdc
> > R10: ffffffff8eabfee3 R11: ffffffff8aa0008b R12: 0000000000000000
> > R13: ffff88814ae02000 R14: dffffc0000000000 R15: 0000000000000001
> > FS:  000055555717a380(0000) GS:ffff8880b9800000(0000) knlGS:0000000000000000
> > CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > CR2: 0000000002555398 CR3: 0000000025044000 CR4: 00000000003506f0
> > DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > Call Trace:
> >  <TASK>
> >  __page_pool_destroy net/core/page_pool.c:851 [inline]
> >  page_pool_release+0x507/0x6b0 net/core/page_pool.c:891
> >  page_pool_destroy+0x1ac/0x4c0 net/core/page_pool.c:956
> >  xdp_test_run_teardown net/bpf/test_run.c:216 [inline]
> >  bpf_test_run_xdp_live+0x1578/0x1af0 net/bpf/test_run.c:388
> >  bpf_prog_test_run_xdp+0x827/0x1530 net/bpf/test_run.c:1254
> >  bpf_prog_test_run kernel/bpf/syscall.c:4041 [inline]
> >  __sys_bpf+0x11bf/0x4920 kernel/bpf/syscall.c:5402
> >  __do_sys_bpf kernel/bpf/syscall.c:5488 [inline]
> >  __se_sys_bpf kernel/bpf/syscall.c:5486 [inline]
> >  __x64_sys_bpf+0x78/0xc0 kernel/bpf/syscall.c:5486
> >  do_syscall_x64 arch/x86/entry/common.c:51 [inline]
> >  do_syscall_64+0x40/0x110 arch/x86/entry/common.c:82
> >  entry_SYSCALL_64_after_hwframe+0x63/0x6b
> >
> > [Analysis]
> > If "user.list" is initialized, the corresponding slow.netdev device must exist,
> > so before recycling "user.list", it is necessary to confirm that the "slow.netdev"
> > device is valid.
> >
> > [Fix]
> > Add slow.netdev != NULL check before delete "user.list".
> >
> > Fixes: 083772c9f972 ("net: page_pool: record pools per netdev")
> > Reported-by: syzbot+f9f8efb58a4db2ca98d0@syzkaller.appspotmail.com
> > Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
> 
> 
> 
> I sent a fix already ?
> 
> https://lore.kernel.org/netdev/CANn89i+6BuZA6AjocG_0zTkD1u=pNgZc_DpZMO=yUN=S1cHS3w@mail.gmail.com/
> 
> Please do not attribute to yourself work done by others, let me submit
> the fix formally, thanks.
What exists may not necessarily be right, and how do you prove that I saw your 
fix before fixing it?

You have only tested on syzbot, that's all. 
This does not mean that others should refer to you for repairs, nor does it 
prove that you have made repairs, and others cannot fix them.

Thanks
